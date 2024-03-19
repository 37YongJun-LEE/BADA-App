package com.bada.badaback.myplace.service;

import com.bada.badaback.family.domain.Family;
import com.bada.badaback.family.service.FamilyFindService;
import com.bada.badaback.member.domain.Member;
import com.bada.badaback.member.service.MemberFindService;
import com.bada.badaback.myplace.domain.MyPlace;
import com.bada.badaback.myplace.domain.MyPlaceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MyPlaceService {
    private final MemberFindService memberFindService;
    private final FamilyFindService familyFindService;
    private final MyPlaceFindService myPlaceFindService;
    private final MyPlaceRepository myPlaceRepository;

    @Transactional
    public Long create(Long memberId, String placeName, String placeLatitude, String placeLongitude, String placeCategoryCode,
                       String placePhoneNumber, String icon, String addressName, String addressRoadName) {
        Member findMember = memberFindService.findById(memberId);

        MyPlace myPlace = MyPlace.createMyPlace(placeName, placeLatitude, placeLongitude, placeCategoryCode,
                placePhoneNumber, icon, findMember.getFamilyCode(), addressName, addressRoadName);
        Long myPlaceId = myPlaceRepository.save(myPlace).getId();

        Family findFamily = familyFindService.findByFamilyCode(findMember.getFamilyCode());
        List<String> myplaceList = new ArrayList<>();
        myplaceList.add(myPlaceId.toString());
        findFamily.updatePlaceList(myplaceList);

        return myPlaceId;
    }

    @Transactional
    public void update(Long memberId, Long myPlaceId, String placeName, String icon) {
        Member findMember = memberFindService.findById(memberId);
        MyPlace findMyPlace = myPlaceFindService.findById(myPlaceId);
        findMyPlace.updateMyPlace(placeName, icon);
    }

    @Transactional
    public void delete(Long memberId, Long myPlaceId) {
        Member findMember = memberFindService.findById(memberId);
        MyPlace findMyPlace = myPlaceFindService.findById(myPlaceId);
        myPlaceRepository.delete(findMyPlace);

        Family findFamily = familyFindService.findByFamilyCode(findMember.getFamilyCode());
        List<String> placeList = findFamily.getPlaceList();
        if(placeList != null) {
            for(String placeId : placeList) {
                if(!placeId.equals(myPlaceId.toString())) {
                    placeList.add(placeId);
                }
            }
        }
        findFamily.updatePlaceList(placeList);
    }
}