Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7534EEFD
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532245; cv=none; b=UruwcOIsDQVJ991tX+erDP56z/BhW0Oq3i0E5r6+UTRja2AyosYIRIcVsBGlvfIcN50rW320cObn/qNr4BKCmjinEnv6ho36XVcFerEnlOPAXIASZNVF97tyaUWz+7f+CmsL3GV44muwIL653b4o2NIZn1lhryLej1YCywRaUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532245; c=relaxed/simple;
	bh=5h2rWX+arJm/jwCezL0i7fw+OXTFbTIOjOhYu8V4TU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=htKRV20cao7tx4cUOCB2GB5USUl/vBO38h3oIdxASqYJ94uvyJAXkpj/AfObB5OzUsruGccZEHn4LqI3I5Aoao/rV+9uAdNyVA9CKQwK0ZjYI2/ovV3Lci2L0lUQGGYU+N5+F3LztILjhVjcQn0tXdc3t5kX/2FAILLHLgu2wOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGxG0SMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bdhkulGQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGxG0SMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bdhkulGQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fpcb3777822
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f+cIIHYANrwwOF3taM7v3s
	t3QlGjS9s9bbPQmxJDDv0=; b=DGxG0SMYpXUibNqkUAnrU/p8DhvhR0D6Dml6RK
	KWhHLwgR3d0eoEk9iSCELI5ORa7tVl3zo09zwq7y+9MEARdI9jUra+Hu53zcrphG
	rGu8gh4nGZwVryBIqnyCZhP53tflnEmkMys4nTY6epC+Gv2aGXDq1UU2LkX3kchu
	5sSz2DRerXKaWwP39EciH17goR6R7RFyNpUZJHlzMckGDxLSbW+3JNglIrLGhYSd
	C2KowxAlfAwe51z3ZsT6hUdnfEYcBnfojCBvopwiHhkkOkP0mmvtNUQhFV5cnVRc
	Q9NK2/k1fcQXa/ySyCLdppFTHyVMx/dhnnmgxXHU5c793jZA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgene-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:57:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so2124759b3a.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786532242; x=1787137042; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f+cIIHYANrwwOF3taM7v3st3QlGjS9s9bbPQmxJDDv0=;
        b=bdhkulGQIxk8mcBow2tEd2/jltgAZAy2+TJYv0+tkIpzchtjs9ApPuaVWzAbO/ykb3
         1KVfhQVtckr3poAt7bD0CLf6foJn8ObeWpKUNhGJReivcyJU2CQaHdAiRR3Ha+bmwGoy
         GOFLs0qJVg5kYVNJNY9FQUX/QD3plwImMynHGktTS+Nr4ukB392tuiFua461hUs2oICr
         MkZNCYOed2Sw0s6rikus4uPe5Wkg48nTSWl81Pnm5nWjnPFRUCxMLn/Tigpzgs/w8gQa
         LXaa4FnYoq7VqaTYUH52j2VPR5l0OS3ZB1ymoQU8V4wQEx0SENedNXUfmBTjieCQSMCe
         8nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532242; x=1787137042;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f+cIIHYANrwwOF3taM7v3st3QlGjS9s9bbPQmxJDDv0=;
        b=EF/1IglHgEocs6BWN9KLcz4TdFsGiKGrE9k/y6OB6pPz7fYyehJZ+4NpaCGDTYiP2h
         bRPGFSKjyF4qsUhVoB/BXx1Jh/y+kKP3br+NAk+PvR5D2P868+L4rwHYs1OE9CiBuqsU
         o15yZKeVN/QJqOdxELufvmVDkVKNinREE8o2RYc27oe828MmcH8AlN2hTNZezSP8uJUw
         UlpzJl6QFlQVtgxVMl027H1JYDTtmzkeZn/t/osXbrFAa//R+ZTOlTb61Kla6q3EWK1f
         q1OUNapK8R0III8gCaEFOPFpQxuOV/P+beSKAvoNpGclwU6j5TJvNSyLGG5osZYLXE5T
         Tq9A==
X-Forwarded-Encrypted: i=1; AHgh+Rpyahf6WS1/+6/vA71V3Yffv98EU1xx6vGIMeMNsVhTA4/2jUIF5HoecHByI5MbL9DBNarNfgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23cwYqur/EQS97/R70gL5p7+003uC1nIawRz4D/etPAIxE7ed
	dQ2pFci6qibRlmiuvRinjpEYuQQRSmFND3GzwTJxOmHHj5vIJt8j4h5FNqXRbgFBXJD3w4nlxGq
	K8NDfRG62b2CdXFjn1oRpTd0wbTr3OAckWBqlwvSW6YC0L8wVLVb3qHI4QyU=
X-Gm-Gg: AR+sD10Ux1YnecWR5JmMQTiT6uup7Mc6ByL7SN4U1CU27kKHWsKPvS8Z6AzBTMPR1QA
	dLi/b825eUiUae5w+stMe46m1RL67AoqTqQA+10B7O/y7toCPxz9d+ZvLqOWAxwazwbMRFiCKxA
	cWYTdy/lDS4N2Qt8loWUnVdIYwDXlMVEpYjczx5F1seJTM4pTTvWDj39Yq4qTinzYmZwcXeNPX8
	zaohkZa/TFGmXWwW4ypXGOP0hVJ4Ipxr3mZI7qij6vcYQu589XDDje3P8BayLLXltAytbibpz5t
	XZFLmM5Znl1oIOeAfu2kPv5hfVzN6d9Y9dDMAJ42NpUkcNbccoAOwA6tmoArtpw4t4dKRIYaKp3
	VIN71Y22gW7dEmJyIyAFyBUPiuO8K4VbKcA==
X-Received: by 2002:a05:6a00:3d54:b0:84f:6f7e:493 with SMTP id d2e1a72fcca58-84fb6481adcmr3490691b3a.3.1786532241541;
        Wed, 12 Aug 2026 03:57:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d54:b0:84f:6f7e:493 with SMTP id d2e1a72fcca58-84fb6481adcmr3490653b3a.3.1786532241042;
        Wed, 12 Aug 2026 03:57:21 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d22247sm884301b3a.15.2026.08.12.03.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:57:20 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH 0/2] media: qcom: Fix iova allocation from restrict region
Date: Wed, 12 Aug 2026 16:25:57 +0530
Message-Id: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1RfGoC/yXMQQqDMBBG4avIrBvQiJL2KlKCib86XUSZaBDEu
 5u2y2/x3kkRwoj0Kk4SJI68hIzqUZCf+zBB8ZBNutRtaSqtBLlIsLyk3nKwg3CCKNM0rjbGO6e
 flONVMPLxG3fvv+PuPvDb90bXdQMNf5AIegAAAA==
X-Change-ID: 20260812-reserve_iova_in_driver-855b388cbb29
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786532236; l=2804;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=5h2rWX+arJm/jwCezL0i7fw+OXTFbTIOjOhYu8V4TU8=;
 b=wWVEQgf9Rg73L2I1yBf7Ukdp7YFjsbvzpri07X7LkyxJjZ+Nm6yOxA1T97O2m0/GVlfE+5lXm
 E1AG0JP4YvTBmrBoB6fLvhbeffplNR/TexPFaywEpEDE4PyJBzOhBGn
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: GiZkZjoJbQoHVx0eEjllySwg-Fte9wIV
X-Proofpoint-ORIG-GUID: GiZkZjoJbQoHVx0eEjllySwg-Fte9wIV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OCBTYWx0ZWRfXwX+B3lJ6sJgu
 7rSa5dwe4RVwWdt6IpBAt6wqOdI38OwkfrGAZy79mba9uUyI7gEh/UjEYRAKvKASSDzV2yTsI8I
 ScGRPWdr7YdMi5hoo+5eLKVFsq0dtJnzg5NM9nxFev5YzzirHBYIdysvK/k0qnYJBzKcfzoJDor
 MsJgsbgZyX1vp3k0iCvYnrDhvRoOTMl3ii4HgDEi9zaoZYqU5HCDdR4I2c1dI3abhu4wcAoXqqV
 0BpyL23DSL2sHP2M7O3sGFO313OB96wsLS5n8jW2tGTTSBzEwQpJc1dYJYuJmtiVudwTspSvIaN
 3VldEasHx+622MPJR1Jt/RSmrXcBCFoDPnK0nqOgZaUlsCTNsRmdgb2sE2iWGRGO3lDJdB91OMm
 mYqxhY+SL64bWvcWDZhJuq9izPjc2fMeU39GghCpjZ0LcUYs7stGKrdZcZWrJn07XrGlCKRGPZi
 hGmIXSVi/byk6jfgt6A==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c5192 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oC4F45RIJBzc_4nOIB4A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OCBTYWx0ZWRfX784EuGjYCEX+
 c4t+9Gz30wErQaqeS/btroI71BBD7VBTI6ZLSxXr6pHgUXPRnTXClJmPJpPRpwI+swv+Vi6/K1K
 DcJnNZhkztrvqrWYZPiaZ5RdulxVsPw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120088

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream
in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots.
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
already posted here:
https://lore.kernel.org/all/20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com

Those changes involve DT binding and DT node changes, and discussion is
still ongoing on how to handle those for stable and for the upcoming
sub-node design, with no conclusion reached yet. Thereby a critical reset
issue is still open.

This is an alternate solution to fix the unhandled SMMU page fault
by restricting the IOVA range in the video driver, which also makes it
easier and faster to land on mainline and stable kernels.

Currently sub-nodes are not yet present, and only a single device is
available, so the restriction is applied to both non-pixel and pixel
stream IDs. This makes the solution unoptimal while fixing the issue
considering all scenarios.
Once sub-nodes for non-pixel, pixel, and secure streams become available,
the restriction can be made stream specific.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Vishnu Reddy (2):
      media: iris: Fix iova allocation from restrict region
      media: venus: Fix iova allocation from restrict region

 drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
 drivers/media/platform/qcom/iris/iris_probe.c | 69 +++++++++++++++++++++++++-
 drivers/media/platform/qcom/venus/core.c      | 71 ++++++++++++++++++++++++++-
 drivers/media/platform/qcom/venus/core.h      |  5 ++
 4 files changed, 148 insertions(+), 3 deletions(-)
---
base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
change-id: 20260812-reserve_iova_in_driver-855b388cbb29

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

