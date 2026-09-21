Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747736B923
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971618; cv=none; b=SlhoxoaeETgYa2ODOPFC3rLkZB4Rt5kUk+/S8YhaSrLnjgqeXcrI2D/slag4gpeOVuTE87J1X4asFy5HpYf2iYbcPBdC6t8g+KYehXIYGx4cLFZUaKLx6uk8fbgPG6oJtt2c2XjXlxyPHOwdEWvVU1VLPLkRtRevONLEuvgtUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971618; c=relaxed/simple;
	bh=yQBFMi0V1Q/34XT7l2xkr/OPRTO8ErCo82SZzAZN8PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uY/qQCk6+So2S9OM5UrwjQtMTHNxzQLypfRYCkdf6fbv2OvKxMMSvSBKMIDzr2GHXWbVYYFSOu1jgkHARoyxYEbUrOwhVcvPkJZJ0h5vxU5DUukvKAkucwTCIpju7C15U8IPmQVyC3k2hozawibGn/NxQYMj3DU5LRSL5FJ45lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFBULBpD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxbVDTzA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFBULBpD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxbVDTzA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3Z9CT993525
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3TMnVyIqj4oCOoXs32jIk9PhLPoRy53h9I9OmzdXVzE=; b=JFBULBpDRvWijOZu
	nK5Ju9lbxSXz/Oyo+REGLyqeKRSpKZYiCdg88TLy1wsg+wY6+FSeD/84976D7owH
	Yu8o54Vl2TtHtiAZ3h3DqrJCgEtZxb8951653I/TLSNFZirvz0IVXcO4yLVzDbEM
	iaphkMCFg4o9K4ROlFPaZH8XJzxGVf1y5/gdOVrZ9mf/N3E6D7quOf0IDfe19MCK
	6bvQbP3mzBCTq5jzhml/u67n5KOmZmm+9OdfjVrHA5z/Oa00UiVvFh/O4s8IOTeI
	Mo9W7dyyQeEesPcya5lSE18R3oPHBdPrCKnuZ+hh20UScrbVeBk/jIRsYVj6acmw
	vC6UQQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3v8wmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:20:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dc7337e2a7so33992485ad.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971615; x=1790576415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TMnVyIqj4oCOoXs32jIk9PhLPoRy53h9I9OmzdXVzE=;
        b=TxbVDTzAXUU3N0vprDEv6wpbyRHmH45ma6SWMMpVAPg7FCIe9oyjcrm8TV88YdutLS
         O9OOUnE3VgB2wp2rv69i3eBjtyq1tt4iT77vBf3095G2YeiCEQApCka1rPeGFBFMrPdw
         n5BB4QcyxcF+lkv1+WO2tiUBgsDYz3uUoZeTwLgaiEFaa264KjGXRNedGmWWsyPF2Z0G
         TbOvz4M5cdk0+ywTE34Q2Q+kQgDtJmNXRzn0gOIZw1L8qFBKT9WsHw5DTEjT5tKzV0wE
         gw8nuvOqIi8BjCOOkZs+6R4KHGeOJCVZpQ7POk5RsrgjIDB13MNtqdcsHaFrKuUeKPKv
         sMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971615; x=1790576415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TMnVyIqj4oCOoXs32jIk9PhLPoRy53h9I9OmzdXVzE=;
        b=P/UXBISNiSgM/PQybtwHZc3BxeIyM6UiYnr0AW44Z7FGa2Sla9PRgzILdMfcScnOh+
         jENju2NGcLybuR/FcXEK3vu4ee2Mhqw9yb5jCDLAHG3BYJmNxTY0optaN3akkyE65iGp
         osS3hxX+DpHiE9Ja8/R9Hm6tZZYSfqvIcQCdCJ/Aw8Nl7JcDi/hafgBVUun0076CLFxP
         J+s/MVYurKGhPyUXnVYriuHarzC6c4BweeJs8ojjkqgQK053qfLRbDSwkeMoKSYHm8F3
         TtAQ898Y3KgWIJDcYCYF3/mhRr1jQdYy9T26VhRrp+sq79pNCPyYA5qFmNWGWiSNrocf
         mHUQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6cG0XP+LhZzDHR3FYULtrr5lVZL35quIKtbV8D8TpwoExxuyQwp+CTYiUFdAxg7ccjBsAKB8=@vger.kernel.org
X-Gm-Message-State: AFuF++mS8tDdOmpeB3yZrfhTcU4wzzf77Ler1tOt6K+c4MZLdF8hMy/Z
	8tW2cmguCSm/dizjNTVYm2ZLSprHFWH60eN5LAXAmJUBCgQEwy9kzEm0W1S2ctViFGigmlZL4b+
	VpLfpENhVkckCoUAWNws6Z2R9VW03O/Eaf1ozhshUKP9QFLvPv82yXJA1H2U=
X-Gm-Gg: AYBFou1FMzKo/VJW+KbCT5nUEcbsCfy9hJrn0+l2vKprJvtsIDSjcmGay+Zgb39TUaj
	wdwgdYs+b+N+02WBiO8gr6Ty14G84kLtuaL17mKKugzKJKTDYwSEMTpdmH4DRWGqAbZg1hmnalY
	wUVu8+gRIFpvR3+EPJiKfxLje1usQp5lf+ip5ZLJ/FTEKgThPuNlPOb18ILmM1cj15kANo/j2yW
	0B36LHubLk+/ihKwNt47xcohQWQ1+pHX8W/Imq3edE9oBW0ctEAmFUVjvGh10joWQnZlosD6eXu
	VJKkE569R+uF55mj0JK0Xxdnca2sEBqOMAtQlu9eMVqReLHqakui+MvTfiJiRgZ+v7zxlriP/lj
	tVB369UyPqD+/AFJkY6t5T7psEEJHrNcnFEP/VI9Gu+lZq9DTNcQyZTBOnR7FDSncC0Rh2raVSv
	+dl5u1wecTpFHmU7xvQkD/5BuKxi5YxLxzeQ==
X-Received: by 2002:a17:903:19f0:b0:2dd:7593:8634 with SMTP id d9443c01a7336-2ddb1b0f7efmr138780405ad.13.1789971615494;
        Sun, 20 Sep 2026 23:20:15 -0700 (PDT)
X-Received: by 2002:a17:903:19f0:b0:2dd:7593:8634 with SMTP id d9443c01a7336-2ddb1b0f7efmr138780115ad.13.1789971615035;
        Sun, 20 Sep 2026 23:20:15 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:14 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:37 +0530
Subject: [PATCH 04/11] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE
 clock to GCC
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab0cca0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3OI4E87EZh46DsEagTIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: dgB_vlSc_Mh0WG32Wqpy4soOl6vo_YzY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX4ONvgSBwP6cn
 rsMrNZVXD+2m/h97g1ELHD92bFtYB02YCC89GpyeDUR8L1JWVlbOAaed6jYj7GB8/f6FktM6ytV
 WJB8UKdZ2rzcfdQWeWr0Qha0yzgLbFg=
X-Proofpoint-GUID: dgB_vlSc_Mh0WG32Wqpy4soOl6vo_YzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX7zEkxqDQk8bo
 RyJczGnj98leF/YRH1nqfpGhRF2EmbhbZk0JB+m0R2kfeWC0GyfH3PsaCrwC0m92YPc3V5QVHSy
 zslY56ztsnJ6ENG+TddThghvBg2oS4rsUrCRFur/jrDUFWm9VpaTJODxJCXFtSkIIe+5s4Ae0Lf
 nhlue9bJXkPhM8dcazJNAB4921giciq4dE8gafps9oBJ0wsdVJdD3zd8sIxVhbaf59DlGRwJS2k
 5OiQASuo98KC0HctcAXfU944DZ0I4QOWDkEKhUN/xyoEBnLBM66XiniO2GG9M1Jp8+vRHSUwQ9p
 0ljifTD90QZq8aCj6QTcNpxreWYJoYAlStL3iGssraxbzDZUC5doYPUGO5o05oV/rFioVgUfzn0
 4KfUYX2jwkxRVojlNRjxpDWSUfmmJLFEblfzSvx1GXb/ApadbEE+xFFoC/jCLxvJJhc5eZpggbP
 dSIqqfMtynOWq95EkUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock can
propagate to the USB controller.

Cc: stable@vger.kernel.org
Fixes: a98bfb31f676 ("arm64: dts: qcom: ipq9574: Add USB related nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 5a5bda5f21a1..dd1dcd955c95 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -428,7 +428,7 @@ gcc: clock-controller@1800000 {
 				 <&pcie1_phy>,
 				 <&pcie2_phy>,
 				 <&pcie3_phy>,
-				 <0>;
+				 <&usb_0_qmpphy>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;

-- 
2.34.1

