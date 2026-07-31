Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4346F483
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522233; cv=none; b=NCbXTdMWgeiFqVJ5esO507fYch50o1nJr9I70+p91A6wiGn0ftKGeoVn/COSWnnQZ/y45K67Oi5SV7XgUa0/fX8ychs3p/Q7e8dxYU77KB+lxKKfq+IhZG7sg4qZmZZdd0MfyqXBSYB/gQz8Gjx622YZhw2YxZd3jUYYOdTiap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522233; c=relaxed/simple;
	bh=Ylggv5ukM9cL+Qy7BuVA8yvNM4fwEAff5bDtks1Oxh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+5egxfnw0K35ZnJhzanzel1eAstoA+hppNkIpQd41jKw9Ei5RNM8s8GsxZOaV30VXKEZ7Me1ityQwr68JUljTMTlzLWvtDXGau1/qxFCxL2HW8szBvxOCTdsAHbjeSp7EGXWdy4LvFFTHHUzsDKZDIiSqX6B/jOqzV8BxxyRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KACdZtun; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q9QTO2sb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KACdZtun";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9QTO2sb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFO0Ha106205
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzhVX5WD0XnAhIfnqoRt17YMyLSYbQFbZtW3hEYJn9o=; b=KACdZtunScbY3WjR
	ly0OgQTN/c8pVWn0akOLzuHG1kXPhhpvYlxWXu4vT2q7cYuxNsypdFteYk1XS/Rj
	KjHxPq9jIXHtEe+mFtBe4mr+wkPjXCbYEe8haKFZcB/z0V7ToOBBKCJjShGRw0US
	YuL/VwXQP0zawVayFL9+hN+uDnSbQnSJgheJxzHYN5dFXqVcOb3J1Ev4QApiWtnu
	bLBMC/GkONPlibOFmzg5JFUosVtzTQcX/Z4qwdARnBFr7C2N6D2ZHowrP6uvdzJZ
	Q1fBOwPKu+IlFzPXMl/9LJnv9An/845Ic4WCK4yZRdTbCAN3lJ4w/+ouaBoQ9e3F
	qJzqkg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u1ue4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1472649a12.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522230; x=1786127030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzhVX5WD0XnAhIfnqoRt17YMyLSYbQFbZtW3hEYJn9o=;
        b=Q9QTO2sbMRmtqZSdbQyfG1ssoncIVsRpl88xjgocOLL4FjrgIxrd5ax//hRAqi8qh3
         UbR9PnZBKPFJsvKT23jQh4YYhwarpvJ3KQQ8NaF9VmHhBPba8/qw0QnTgdwmJTJRPEa2
         bYjTXVGrB32+V6xRWdFhvpaXoQ/wUCR82R0LAku0BgzuvcwKlZ2EVqtfQhBTdm/u7o9T
         EUug2XDeIa04RWoN+CxNKHIngjlqZV/oRo5EC+kOiNLzy3nmFnwZYH9Kf0GjhY72qzUg
         Da0pGRoHSmKW1olyk+QJKdmNQlvWGEaFtrGnZKwe+9z5xaoFyP4cHibPMSGmkkk0V1u6
         DSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522230; x=1786127030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzhVX5WD0XnAhIfnqoRt17YMyLSYbQFbZtW3hEYJn9o=;
        b=OL+qxDSPDhNBgZrDBPIoG+1UluQMxr1i6rV+2x5giGlkmQnYNUAiwU44IR6witAIF0
         vF8D6wF5pP7n4qVJ9iaMgyIGukCi5S3B9MHiw+5yoq+NOodP2TVOtQWtrDHypTc4XaYl
         g9dV2awdKom+LIXmAgq9CBk3ho3basjY9hzEGxR2JTk+o9eCK8LzKJOP3iGZo/OdiZi8
         4vmToa7HCOaJepXJZztHbUYcTuiZ8QuLKPsxdXk1nyEaHLIcuBhnHBZpZx8BbC+SRib9
         IJaxnT9TAo/7LhNZuTKwIOxR2zsh32psn+Vp2qdVlsnZEJ9QKByWp8Qd1aJkIARarN6g
         ImbA==
X-Forwarded-Encrypted: i=1; AHgh+Rpj6FaZLW9PzWKC0LOffRi2WpSYu7valMLOyPwk85EDH1Z2+bU9gEJNXh3AO8MztC9ZSLx0UBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//Jz4rygS+IuDbxolvSsq0yq62fTcfcU4UUyl0BQnTWxZWB04
	gbgTMfK12DS3AuwoXFMj2/Edx/r9vIBhCw1WC6t672fCH/AQETjGXM93tIxpvjEDWQkZCGIlJKG
	17Pr0gCbMT83MSqAQsUs43R9mxgANMbf4jIS2QSNa6Lpd7MF/NzhjBeYQJVA=
X-Gm-Gg: AR+sD12wgwGwPg4ylBW4a159exrLf5yCot2ZQrBZjF65hbZAcjUPZfIAEX9ig1AgQot
	K/BGCVRC1yHUYunygj2hzGfImPhu6x3JaglDE41ae55sqAHSiBaYE3+iEZpD0Y5vU1Elm5JuVxY
	zhF0EYK0dzKa/qQogrpcx9iObBRRxSd+tZUMyW1UcBAs8cAu6TzWOoZxTR2k2yqvEy62IncmRMi
	FQDVc0RYf8jr5M6BkopQzs2NUaIhU8K4MEKch/QFJT0k/AC1bPtFSGuEh2ebzd7lQsxL5PDBs/v
	9zq1V9CbRsaqDqDHwO2h/B37iIrIJUrWbeEQQ9w3k3RT7oHwaPSXnuYjbE57+do1xkA2njNntHH
	ASlHIfpI0ba0dnMPTsPzEFM03AsV3k9/BZc4=
X-Received: by 2002:a05:6a20:2591:b0:3bf:9c93:ac44 with SMTP id adf61e73a8af0-3c92a5d3558mr817746637.19.1785522229741;
        Fri, 31 Jul 2026 11:23:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:2591:b0:3bf:9c93:ac44 with SMTP id adf61e73a8af0-3c92a5d3558mr817708637.19.1785522229301;
        Fri, 31 Jul 2026 11:23:49 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:23:48 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:27 +0530
Subject: [PATCH v2 12/12] arm64: dts: qcom: sm8650: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-12-da52b5228dbd@oss.qualcomm.com>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=3736;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=Ylggv5ukM9cL+Qy7BuVA8yvNM4fwEAff5bDtks1Oxh4=;
 b=J/81NlQ0HTG3zYB4u+otyNn1pTWp4eMXgVHr2h5/hboHaAJFIDc4FrrsBS5BFTm9bCTQv1E5A
 47MQ/1wRgikAMTj55617cAmwAxwm6EwsDa6ncplR1Rqu+jh6gFc0F+Z
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: FKVYe3EUEVI-Lap2dbvr6YlOrxVge3xG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfXzgIaVXOcMDnU
 KUSvnidzOdoA+BNN2ASlw+qfLRehoMdYgWtagoymHu/0kCv4ylr/zz4aVO/mPtazzfoozmAOopY
 VfcELvHtqJ4qbHf0FEVDSzYb5P4J2AMKJQI9psaP/tEPQwXPeOCdgxaRongpuRtIYHlTgU3dcyQ
 DKqsCSNAE2vug3jty8N1w8nqjsPdn8Qxj+hOsnF2OIbWNSzV/pk+uLQT3/FcJgJRqgCzyQ75kfu
 tMoCjXJw3jFMn6YMRBIxirUaNioHnIeo+Dt9GpHz3KVJu5877fhPbk2MILEh+UtCXXUs9Tkangt
 DRYhDtK20NXH7aebz293eeso977VSyqAMh1wX7+Zs1TbDZxg38iBVSR3JJu1rEZju1ZY4RYFbpE
 BHbE5hz9iQFA1Wbph0OdYU4bcsTX2Dr822ZS2+88agAJBc+eiTnIh4nxa+PCSeBJkqqkxs+k3gL
 nokrItbCOhU4IDCETXA==
X-Proofpoint-GUID: FKVYe3EUEVI-Lap2dbvr6YlOrxVge3xG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX2cY+bQ1OerJm
 SLslu2tugPF8NBma7RfsYp8PRKXrBzpjBa/qXcwKoOHoz7HLhJ952DsOzhmPJC6RTej958Wzf37
 ng7tskyIx0bsJXABMR+IP9NBDKtHCE8=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6ce836 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8
 a=v0Z7u7uCyoCEKL_A5NIA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310141

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
is restricted to use 0-600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing keeps a
non-pixel buffer above 600 MB. Once an allocation lands below that
boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Describe the two streams as "non-pixel" and "pixel" subnodes so each gets
its own IOMMU domain, with stream 0x1940 becoming non-pixel and 0x1947
becoming pixel. Point the non-pixel subnode at a reserved-memory node
whose "iommu-addresses" covers [0, 0x25800000), which excludes the low
600 MB from that domain's IOVA allocator and keeps its allocations above
the boundary the stream can address. The reservation node carries no
"reg", so it is a pure IOVA carve-out rather than a memory mapping. The
pixel stream is left free to use the whole range.

The video-codec node also gains '#address-cells' and '#size-cells' of 2,
which set the cell widths used to parse the "iommu-addresses" entry that
refers to the non-pixel subnode, and an empty "dma-ranges" declaring the
1:1 DMA translation into the parent. Both are described in the common
schema change.

Fixes: 56cf5ad39a55 ("arm64: dts: qcom: sm8650: add iris DT node")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 9ecbc0010694faf8005eabdeb033efe630f95037..6fccd8a886ec0aaa42e20b7a20333a7b77c31b48 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -1905,6 +1905,10 @@ llcc_lpi_mem: llcc-lpi@ff800000 {
 			reg = <0 0xff800000 0 0x600000>;
 			no-map;
 		};
+
+		iris_resv: reservation-iris {
+			iommu-addresses = <&iris_non_pixel 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smp2p-adsp {
@@ -5275,11 +5279,12 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 				      "xo",
 				      "core";
 
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
-
 			dma-coherent;
 
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges;
+
 			/*
 			 * IRIS firmware is signed by vendors, only
 			 * enable on boards where the proper signed firmware
@@ -5287,6 +5292,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			 */
 			status = "disabled";
 
+			iris_non_pixel: non-pixel {
+				iommus = <&apps_smmu 0x1940 0x0>;
+				memory-region = <&iris_resv>;
+			};
+
+			iris_pixel: pixel {
+				iommus = <&apps_smmu 0x1947 0x0>;
+			};
+
 			iris_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.34.1

