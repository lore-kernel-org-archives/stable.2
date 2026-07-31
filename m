Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBC4457AF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522204; cv=none; b=flkme1oH5UpjBxIUQ+XKQQ+353l++gjrWD+Wft8JwPcFORnvxKsd0I4OxRK9ywT7RXu1Ts6Q+SmjmH1D/WWCHa2UuD8DwA18nsrSz+9IrPamOz8Tf4y4zDa2hVZ/YaLxPc6jDkBwlRstburNrTjzNNEPJ2GbWIiVcrd0I+nhsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522204; c=relaxed/simple;
	bh=qlApsNCsQ4GXqwqCMeJ2hDu4QJX63CTHsIcYlQRJ8no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cog9CinDpHGYOHU1/4681T9JSzv4mZlmBV+dygGKZrHYxwYAylmlUgwn5ktrA5F86puPVeZJD3pzKDF6e9HAY1XG8yjQ6NPHQO4+6zwGQTIw26Qhsz5hXZWJRY74TsvZSZVEggVDnnMj7D/TahTQ0hyaa9VtUENADJWTemwCb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mf8//Qww; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KMi0WjJf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mf8//Qww";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KMi0WjJf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOOo3701798
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	stsy/YjX/wtx1x9sv7xAkjZFnGaIQJvxRwp41nJ/XTA=; b=mf8//QwwsjCLe+PN
	KmIgYWco5ngU9aGtHWeuaSTmZUkFHSTz55HH5EQA2nssUB4t9FW151iWZWQApsRV
	pjhbIA5e0j1gMzMy1U42LSt+hTDg5AATcjhNAzFpW25OmJ4Mc6uL69GXCbDVzRoU
	2UaI1AgPd1m9o2/h7uJg4jEJ7Qi3SQ5BdMxnWGn14riF5wM1UHivuzkMi4OXcHq4
	GNevNl2zdA90AAIo6/f+YL1WmfeLqHcA4RtqwZaWrVPnuK5XciZLz8P8LFLLXeDj
	vfZQhd4nzM7Qh67VW7zzz77Kz0pkjAVYxIICWKwHOlmsa7ygjmy+J2jMH4iweBBL
	4avIeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u1u92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc88e22f92so24987015ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522202; x=1786127002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stsy/YjX/wtx1x9sv7xAkjZFnGaIQJvxRwp41nJ/XTA=;
        b=KMi0WjJfzbhlvDte5ryiwNQ3f9bmxxQg6l81GEefJqLg7Oov/Ee6bJ20C++MbHvDeg
         BswPq1W1E66/m01ze58TWMTssLg5Ub361LCundopHRYmkE9WUReyL8IeL1LeNhYyXy3J
         C3OqWmo07XWah6ciVV/SCxWR6Ie+MOut88+uWcEi3GVpy8sJGbV8xnewD2Pv3AYllawC
         Fp4ceshC1olVAb38ivtpTDJc19vTT+jvigEsk7zPnaldr96hB8Pi8CpWYyB9NE7ZNPqE
         I5T70VL82Z1xlETLMl46cIq2AX737aNAe5zaTCFPr+HwawpEeLR0sqIsXwk0LaKrRt5b
         tETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522202; x=1786127002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stsy/YjX/wtx1x9sv7xAkjZFnGaIQJvxRwp41nJ/XTA=;
        b=jIYobImfVqiimS0dIUfjIeZSr0WmZy1qu5ijAuJbHhVsI3lWiQkjJU3LCvwXn3oby0
         hMWpkVutXR+LJcgN0i/q1Uan1F9AhCSnZGNI/fDIpQ5NxQcS/0EALuC7PiDMk0eF3GbH
         ODnY49OVB+734BHB5rEiEwq6i2CVm4K3XmzsZqp1NoP3bbgtyzPyhwojWnIDbg9ag5iD
         f3hguxvTdlxumWDS7r9cJ0TGRWEeV8Saa9v5JTf5m8Fzt48KHfPfaO2jaCjzeeuF+zPF
         sfd8KvVG++VbPwfDh3+3Qg3xvnwxuQlocxX6MunYJ5Trygtq8qYaKbXXZw5isR5ADYd9
         xLMw==
X-Forwarded-Encrypted: i=1; AHgh+Roif4AD79V/RtkPtl4VLje3IJ+Jka4zZKs+uNEfnCeli4r639YdaPt71Bta64GSJpO/KwxPCiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUnxG09E0apI+u5JC7PBEVni8Q8g4YqKstFwlV2Pbm/p4hz5p
	gSsKgtslX8/SVjuTTX60dA7g/57tjjx+9nQhs/YgUpJfXBxJLI42bxBthYZ3aYAE1PooPlpJ2SN
	f1GZXjR96inyEwA+/fxgwRsS/gkLDfjE66+HOX5r0vXgO925Jv8VhgpsyyKs=
X-Gm-Gg: AR+sD12koDXzz9b0DfmXthvP4VlkeCjDBk7RusHBO3QBGMf6hDZHAe4oTs9wdFmAu/I
	aNLLWh45Oh/28+F7kmV6+SgSlcqo2nGCT4OQC2n1rsEoqgWK5Z+5TkkX0mKEhddVuHgNEQb1EH8
	7WRdFqtEkbH8dpGx45peW1sLg0wgqUaFn2boB6d5Ep+oDr/mXme2g97VLOkQG+/4xK6tKiAHpsa
	SnqFov249tkNqdPr3K1Ybp7neVFN0qWqhd47M8AakMGQ2D5KBiFgvCPNkWaWkFnNCcJdApQwGzM
	uiG0lt54jtX027wVOE9zFk7U2SIFge24wGnmCYgDEe7+GvCTt4kBSrnYHoVr5jCBccB0CgLR01N
	MsnRL5WUtDITtWnyiAshRQreCv3wwESGuU2U=
X-Received: by 2002:a17:902:d2c9:b0:2c9:cf5d:d9bc with SMTP id d9443c01a7336-2d0524b5269mr8750525ad.35.1785522201786;
        Fri, 31 Jul 2026 11:23:21 -0700 (PDT)
X-Received: by 2002:a17:902:d2c9:b0:2c9:cf5d:d9bc with SMTP id d9443c01a7336-2d0524b5269mr8749985ad.35.1785522201121;
        Fri, 31 Jul 2026 11:23:21 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:23:20 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:23 +0530
Subject: [PATCH v2 08/12] arm64: dts: qcom: hamoa: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-8-da52b5228dbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=3782;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=qlApsNCsQ4GXqwqCMeJ2hDu4QJX63CTHsIcYlQRJ8no=;
 b=AWxJv6+Dh7ngfH6rc1WhOagBZ4bsblrUWBnEAOSAch8nIwGgsDu+hMacxZdKvs2eh4wU0Bj3Y
 r9ALVF16SV7ADn98bi+oQVHDIUrX01nPxjjsdNs07pucUnnMucx7Msb
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6ce81a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8
 a=v0Z7u7uCyoCEKL_A5NIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfXywf/8espEUsg
 rBOUhfHgpszpbGteswViUfYntrMvZNS4F4oYlfV3nUQyKuNN2mJrs2CCL9dr4nnsVdX+paIG5vA
 4Bz3geJWSV4NVHYI1MFNBbG4/d1hIKeS4hpRxVonuKiQabYp4KfomXgMZn+mPu7ZbD7FKLyc9+/
 wWM6T0rkB0P20HYEZovJ73Ns0AljyeYnGBWeVKxpBXkmkIrtcWyWJFWYaIOMyOjCAgyXTUp+BgB
 dUdzKa6IwJ2YWyWAPxv9CpGZwVwn30g7UnxmBiIep8/V3EPXb+cw/c1921YXk6C8YjLKu8Tm5GC
 0FVLk0GTf/UPurVB3gtLtJ+ZZhWZOAR/7RA6YlUr/KAufIH5UGBoCH84cQiAlcCsX2a5JSlq6JN
 NunbPnJFG4FZlnyCt8tNlBC/WIe8gccT4UUuN0IcLerMQdBNw4KdOZLyXOpEMr3xfNaJ3hEOFLz
 7+DSfNoIds6MPZIPQKQ==
X-Proofpoint-GUID: tFPtUrdbYAG-lcOkNUzJb-uZjNezEJJB
X-Proofpoint-ORIG-GUID: tFPtUrdbYAG-lcOkNUzJb-uZjNezEJJB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX9SoahM1dQoMz
 t7sh4gRFsaI0aWnSoBtnuz7cNT5Dj7DeY2mFHs6Ee9NEgcfk4gzUV2jDEO4eAz61X8QI32hBJpc
 fVdHQSYvBL7MVdlqPWQJuaHjTxymB7U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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

Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 09527dcf957672b4b9658988359e79d8a432fd93..37f4449aa91e605a2112f399604df0cc6c64162b 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -658,6 +658,10 @@ smem_mem: smem@ffe00000 {
 			hwlocks = <&tcsr_mutex 3>;
 			no-map;
 		};
+
+		iris_resv: reservation-iris {
+			iommu-addresses = <&iris_non_pixel 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	qup_opp_table_100mhz: opp-table-qup100mhz {
@@ -5436,10 +5440,12 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x1940 0>,
-				 <&apps_smmu 0x1947 0>;
 			dma-coherent;
 
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges;
+
 			/*
 			 * IRIS firmware is signed by vendors, only
 			 * enable on boards where the proper signed firmware
@@ -5447,6 +5453,15 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
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

