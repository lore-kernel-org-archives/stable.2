Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857336E48B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971633; cv=none; b=E/mNZ8jAAeJwDt7Nw1OTEKB/ubUHqgEP+bnHJzdU2NcI5YA2dUBYp9A3hvVl0JhcH13/mR97+4Buh4UwcjdcbECStc7hpF86H2Mg4KJBp5MypLRFef6/QxUE0A2684FSuzVVnr3eWYLhSuv+WqHqJ7QbDOUAnyP9I084RKrEryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971633; c=relaxed/simple;
	bh=xwyDh/gqIKThBIDqDIaDn1f6CWzTkjln6k/sldLENWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufxke19bEBhHHFXMn3dc2HMBfn6V2LqJsFHg5MFsi/yYTAtsblLnI1IOulFDDRH1aUHU5EL4Tm+hLWGjmTxStp86et8UxG6u6+u88w7C1vtvySra1Z5ivRi1F6VtygrgMtkk8FJ64VWZ8Nk7x6mOEnC7qSd91WBsckxG7NGSbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFSdfblI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpJQd/nr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFSdfblI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpJQd/nr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3Ysji142166
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MM6fxEdC63BYt4I9p9mHc3crUkRM0DfxDxmdNan0WwU=; b=kFSdfblIN84CxHNo
	/E1xDSz9N0L1oPeatOKzBH4/3eF5j6Z6ekWOb++EYnCGGHpX21Jg7N+CC2wsU5KI
	sdhDzIrMPL6eolEw2DUSTzjca3WwplAlDpzMfR4+IcBOLE/ye6ALxZCHrh+VoXe6
	pVNJCCZ8dxnzg4XOQ4OxtEmLIH6cHgPI8R5zF7B3g80yfxxeleZtp/AvEpTcEozO
	WHLGDEs32Cs0o6gE4hiDIlvCRI65VMhFDPB5fGE2Ai/eUBFWA+XbHJpACUMFWZmA
	sknvuZXoe76rPwaiCD3odFh+uUKUh1ADMGZw/hQmguQY7mj6Qlct0K6+raF1ycGy
	++CGeQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1egt80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:20:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so33426225ad.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971630; x=1790576430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MM6fxEdC63BYt4I9p9mHc3crUkRM0DfxDxmdNan0WwU=;
        b=HpJQd/nr2yHmoBjmC3IY0/zdjTQFmhap15sTThwadxtx+ajuGu3P5yRcatsk2Cln2x
         NldGNl8TZTTMSSpna0Ti6sog0K8593sS0O6X+0+fDKBPxFOs3TdTUTun+E5oi7DuD/UB
         UYExv+17v+9qYPRuQ6Lhq7kIhUd1+ocx5UefueCebLfTJiBev4AHDF35kMWQPXhfHdV0
         AagCOx1qeHGjIrgNwk1J3kHYBRGYDfNSe7w9eE6LauT9RRjUJs05+emnb8Q32pIFesik
         eRkJY4bA2wQW8Lq1JEjaxhkqDcC2m7cJ++daVBei6xn3CKTbXQOdW+tLq+nuQ5F56rps
         JRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971630; x=1790576430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MM6fxEdC63BYt4I9p9mHc3crUkRM0DfxDxmdNan0WwU=;
        b=riCn2QWezG7maAJQgpCEcIyvGr0yw8N+c5lyUn+4A1oXFoGN3OJhSTz9eJ5wylkEZb
         3/x1sD9/feMGB7/uQHs+/yEwbFHFab9xHVJs183lE63JjtGJGRAcpuI0/9YtRl4ek4mO
         3JZI97Nxtcq9hjqX/wTG8BqgxVYfDIZCOKmFwiq2U5k5tTvuRbiwgign88WZUdWR8OAG
         FIVNrFoAHX3pitFCtYzFMxBixPXVnnqSShs+diMRsJubBscbtviKwc0G1sK7OH0g2Y1C
         mkhafpdCpmKIYgGAnLTn7ZkKrlT2SRUeSGF+Z5K9KUdEM2CvlV+ea0l1glPwVTwURLVb
         49Pg==
X-Forwarded-Encrypted: i=1; AKwUvBz+5NDftuWb4Y7lKePUUy6H/jPIHqsHg7mwfhxGO9woUjN7/U9Xv/zTYrnFGGwksaShUdZdQ7c=@vger.kernel.org
X-Gm-Message-State: AFuF++khslo2VZYop/1m+fXyDgmv3afp7LDEwXvOReeHjhV3z0Sqsxhh
	bx3nsk1XGCpE3XksATH3zT31K6o05jr/VWRaOAI6SyY9rnUotzLSsIITCrGsa6l+ga2rhnWhqwQ
	oiTKBT1KfIQ4a8J3vn9n0faCh8/tyQIHEPZ3fKOxO7TO/COdW3+pf9Skz2K4=
X-Gm-Gg: AYBFou3DhXfNO7WG+Shoi0bY9BnQoHZlv9sUFou8/FIJqk8gVyVJbWKaZr8CL/vuELz
	8B7BsIKeDJvO0SsOFFkyF8xJXTJYfwYiEpyvqRCzI5joxSL5Zx+/ORgmf5CjOYgJ4dYbxb/njux
	mTosc0QUn5Y3uQako8H4tNSZTPgRwpmyTjC1zUCslgNtzJTRNrzcRNLkI66DQY28bpo7ye99IVm
	Afsq8Rol5GIzgycYsVsMo3lXgCBnRSut2X2vCH0dFfCt/dgyyHcefPQGCtNmxAaE1NpaN9VY92O
	Ry/DUWhQ9XfE0mmbrS8g5N5aUgQ4kwIDyRsr2Oaq5C8QB371df2jtwg6MfrflezWVVRBHCxSxzh
	Nu54PG1J0E3WTP9Vz9uWKiSXr0ywptyScQ2F1pVqPjSvp2Aslc5tzsOq0aW8sX5BUCWXQ6EDG1I
	0dzDnSJ3/39J90yK+xjshmlrZvDCRV+kQHSg==
X-Received: by 2002:a17:903:94b:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2ddb1ac1c03mr132240165ad.2.1789971629712;
        Sun, 20 Sep 2026 23:20:29 -0700 (PDT)
X-Received: by 2002:a17:903:94b:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2ddb1ac1c03mr132240005ad.2.1789971629268;
        Sun, 20 Sep 2026 23:20:29 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:28 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:39 +0530
Subject: [PATCH 06/11] arm64: dts: qcom: ipq5424: Wire up USB3 PHY PIPE
 clock to GCC
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-6-d242e3d49648@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX4Nl3yMO+opt7
 48uIsYQkoFqMgfdTdAHuY5rHHILr2aI6rC4SwtHIoOWqVUlqS0DCBrDG1YSsweyNcROLFAn5RdU
 TUXnFLDhUgLyoAQaJIFaVs0pkGdCwNY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX4fpfHwYTzpt8
 /N+n5CR9apguIaAU+yPQl4L5gRbbgNJbXXEx63n75KYbmGX3usWV/ldlYdEnJ7ZajalrvhwUAGD
 BAPFLEL4wB+kEi9otAd+Brlz+4WddSKfPkrevBcgoRQ6y3fGjfNEvS9M7vzFES6dLAYxGHMNGS2
 g6nZj7Sa/XmLhnfkTRJong11aGYctCZK0GG3PSenKVuF59HtFbKzQ1NHSQiux788pXyUg3pNfVJ
 pfsuqiQFhQLv2kTvXmoImDXXT+AMwLxSKdRZkWxZ7DkBzmyNvLjXXSXncdclaL4A/emi24khf2K
 4kB53m1qjU8c6Ei4FrXJs7u6WAdk8drk6hjfMpSRro7EhhMCZlW619ABjHo+2OwDIcmb2mRJ3lt
 +7/3fjSPr53QwHTRfwgwUyQko1rs57IODzR9Kz3hhI5EamhAPHeyD68bjj8OjluX8ynYgYZkB8q
 vCfVMP0GBkBlGaZR/uw==
X-Proofpoint-ORIG-GUID: WE8ME4iMrsR71k2h9_KuvFJ9NJfFHQt_
X-Proofpoint-GUID: WE8ME4iMrsR71k2h9_KuvFJ9NJfFHQt_
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0ccae cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0BHkJw7pG0aoMaekWq8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock
can propagate to the USB controller.

Cc: stable@vger.kernel.org
Fixes: 113d52bdc820 ("arm64: dts: qcom: ipq5424: Add USB controller and phy nodes")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 702061e16a58..95e2508ac145 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -486,7 +486,7 @@ gcc: clock-controller@1800000 {
 				 <&pcie1_phy>,
 				 <&pcie2_phy>,
 				 <&pcie3_phy>,
-				 <0>;
+				 <&ssphy_0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;

-- 
2.34.1

