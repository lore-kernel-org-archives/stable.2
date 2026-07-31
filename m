Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80226470117
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522226; cv=none; b=D7te8DjEiHQTmIGTZajPLG0ArARx0AQy8jGB0Hz0NzSdtO4nKqDFnj+S8EGWk9tsVYCPJRv6pmcVMu7w5xtUTKgH/Rv70t6x4sYq6xmFk2kcz4/FeeGVZ1lkDOSZj2+t8eSmqDtnIWU95vL/qNR2mNMcjiaZFWHqXrtZDtsNw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522226; c=relaxed/simple;
	bh=FJb/Id4PuWdTFV5z2pClpqcZ5YDKvcU6rsY+dr2+FJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYwUQrBlsBIvSBMR2mrIGfkRCSh/aXOXvC9zIa+YihSIno58W8Eh3fDWgknN8XhWTaaCU0HLnYua44NkKoEBGiJLSSaFkaZ+PEMjQNRrUmAcZnihXZbWJmbmBxOVyhdesAy0kkTudhC/vxLcqZtzOrGzl2VU1dOwTMNDQ3+wkBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ek6jPxnC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOwNvrww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ek6jPxnC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOwNvrww"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOpoV3880752
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AiZMji/Cmie6rbkuz/REtHx9yzWuZPib9vzcWO+cklk=; b=Ek6jPxnCa4VaOuL/
	6AbfKvWhVUunPA1rkUBLOh5Eb8zSzAj/UP86bphK4s331in4oWZO+HlKBcFQZ9dd
	uR9zrjUC6CPlzOmfr0ATcJaPo5hNNv5btPEYEXnvxDRTk9epfaxbhGxh3bw5gqHv
	gfusFoTMlafkiUVyu0LemVDBvcUKbx6pfPCMXVaXenHcNHVuxPn4SjCY/KRvvxA6
	25AucVzFCh60A1M6a8LHM01vAOTk87LyQ98eS0sHf1cBvbSwthaCXxje12ky9esw
	QkXybCL7DGbEsx9eab6M9RGUKVOU+UzwXgbCOEuAWYYmrblYZtsi/B8ptggL+zvh
	vJukVQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y1tvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d004f13426so15608885ad.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522223; x=1786127023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AiZMji/Cmie6rbkuz/REtHx9yzWuZPib9vzcWO+cklk=;
        b=TOwNvrwwDuMLojWkbu7F5hhmPVYHHWdkm1ZL9mybIpcatgmszFO0kOYRm/qKR/GyE4
         2IbR7k0VCKXYKmqvDdz1/OJ4efL3NKJRsHduHZfu9D16IRq3a+y/EcM7+GkLJUWMtI9a
         mST1xXTNyaTFty9GWlt3EKT3hxvyfMD6bRI+N91p2a+YqMdM3LbME3b8HpfrXiPQyLG5
         5c3rGJqzLz03J3Fnd0cLqYbL7ZTNTi2Xnsdaqs0Y+0eiE0tCrFbAnYc9KqnieZKy/yn7
         u2RJogC9eeV3aTNUBQxv+tmKPTM6hqmYWHaZ9OzurtGyNhDBVkBFeliDNbaOIVxpjpml
         V8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522223; x=1786127023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AiZMji/Cmie6rbkuz/REtHx9yzWuZPib9vzcWO+cklk=;
        b=GCUf41hfID8H2meQgR1qxMoXYLD4EShB7NTuQ1AF01MQeSjbXKZtPTdabpcoShcW+S
         2949ocJfmSiKdHeIvKdjh/2FYIZGeAFF4zdohDS2ejtqM7x7Cf/ncpgUrTWl8TjKjVPG
         bdZ18QaSrdwT2OC8QQMf2qbqBrGQ458005JBHSmSFCVo0H7DWz1Z18Fv1df5A/uqFzFn
         aQIVtXEPlQoe4fKt0qAGfCtvu7Fjw9VgEDUvO3ZSqtjo8fp4XMcIcCe6ZcLSGwZRtrn5
         wBSEnXDQcU3u+meEyR+KW2akiaCirxeKJtZY07rMNfww7TbHtpELSMQenTGbmpVj85rn
         6zbw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5rMhT8fP8CmZQUzv/iQWYtLKlmnWZNDNipE0ePq8YfdSuB4u0+5ikk/EzD9R53ZB9gfhGCAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DkW20lhHbOPR3xJ4AM8KyCr7tWU97Q4EFNklbnN+SjCWNA+K
	Tm0PPZrQaSfRWy+rvI3zNdjsxBAyk7yR1NyddK2L5bePyqY1RFMpkUNEvUD75srkWk7OWFP1/8J
	WVuZGwXksJMnbZuVkNvD2z8oXOjz8CVEe9kprkRdNCqryX31fsEna2CY5tsE=
X-Gm-Gg: AR+sD137hT+ADKQjuNPbZGUzFMJ4AbOvLD3cVd3yNwxmkwPKoR3GyErvA6tNxvYUi5L
	K9XdjZ9mvsPrtxcCR5BNUmcOknXBm2i85i8WU4j7m8+o253YCRHnInkzR7y9NZe+cNjD2/7nzoP
	Fhw5IdtcDv0MFrQxHE3OXDpsvR6IagliZI3PTfopeew1rPPdMHquTi4bNTtTfP0b1T0G+u83YE5
	U988F8z1U+eD5sTiAFIX3oCzxbsaCJhNjz0fS8Oo1TgkK7sofVgf4rOQ+Pgy8A8+PWtZDrTotkc
	rmGDnEjlwrXFAaOXQ7Eta+XbIHf+e/2nuUkhJoJPhiqPfw3Bvmrgth3PEclNUQv8+P+wlt8ojqC
	uGM4+DIT87K3x8GTpzwhjImlFJnRLWOmV+4A=
X-Received: by 2002:a17:902:e849:b0:2d0:3412:a3f0 with SMTP id d9443c01a7336-2d0522340damr8876405ad.19.1785522222709;
        Fri, 31 Jul 2026 11:23:42 -0700 (PDT)
X-Received: by 2002:a17:902:e849:b0:2d0:3412:a3f0 with SMTP id d9443c01a7336-2d0522340damr8876045ad.19.1785522222271;
        Fri, 31 Jul 2026 11:23:42 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:23:41 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:26 +0530
Subject: [PATCH v2 11/12] arm64: dts: qcom: monaco: Add Iris context bank
 subnodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-11-da52b5228dbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=3581;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=FJb/Id4PuWdTFV5z2pClpqcZ5YDKvcU6rsY+dr2+FJs=;
 b=GzwtIxyM9HQbdagnC94r3JzLi0sWbX8M/LxOnMtO/5sTqEXOmY0k32Utf5VZLjqUj941qBdj/
 gqhhLp83rqzD+L5xDK6CBhWU4DKHrbKryqPxjUW49JTtRr0wxJz2kI5
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfXxa2eTSQilOx1
 GvW0PzZNw/13yWs9xK2KSTgZntHDdM7OToF98R11sAlb2mXj9y818zrcTZXDMMsCVe8M1A0xBY8
 Wwq3b7MSgI8HWwcVEKXAOhlHk4NNaE0=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6ce82f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8
 a=v0Z7u7uCyoCEKL_A5NIA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX2ukJtvKnP7Pz
 tFpDdGauKrUSSkTQ/TX36kdB/yIy5xAOGxfBEfXmRYHjfBFtg3iSUvO6eYtEJcGcUE2o5SgUWc3
 6FstDEHY3tKYCCsvzBWzlL9EhchYgdf1lx38KuRr6Hy8bGbNSu8bKSCHjEIPKz0UU0fsFyMb7uN
 PzAVqP9WubtB5dV+UJhUVZeuChjnRuIbgx3DV0DWUdQEJsY9l8CVVXeevEKSVC/W/sh5WwuOH7R
 dEbugh/fbONasi8oPaHn542j6iaB1vANp4gEhEpMWlkeNuM/QM9NURDrL2Q8N54xyxMFFAoPaop
 DrEM7llogm/Pyzh7ChGc9O3j1nqoUCmGhWO4x1cApws+gt5JEAfHy5lbuHMWq4BREwIsYdXAx97
 /ky1hTzBhcXc7k6+AM5Jq2vKw3Cni7o1VqCXPpfjSyaSQIc/pupGO5VRzzyTh+KAl9UrvFloZfK
 wU+fx9KncZ0u0ssLr8Q==
X-Proofpoint-ORIG-GUID: TUg15rXdUIFRp9ZrihvZCdsSbnBdaeft
X-Proofpoint-GUID: TUg15rXdUIFRp9ZrihvZCdsSbnBdaeft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
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
its own IOMMU domain, with stream 0x0880 becoming non-pixel and 0x0887
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

Fixes: bf6ec39c3f36 ("arm64: dts: qcom: qcs8300: add video node")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 64fc0d592282cbe303efd81491cf93708cfb75e8..ec482258d03a3b2ecc1124a3b0971f16404f6096 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -811,6 +811,10 @@ video_mem: video-region@9be82000 {
 			reg = <0x0 0x9be82000 0x0 0x700000>;
 			no-map;
 		};
+
+		iris_resv: reservation-iris {
+			iommu-addresses = <&iris_non_pixel 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smp2p-adsp {
@@ -5403,12 +5407,23 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
 
-			iommus = <&apps_smmu 0x0880 0x0400>,
-				 <&apps_smmu 0x0887 0x0400>;
 			dma-coherent;
 
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges;
+
 			status = "disabled";
 
+			iris_non_pixel: non-pixel {
+				iommus = <&apps_smmu 0x0880 0x0400>;
+				memory-region = <&iris_resv>;
+			};
+
+			iris_pixel: pixel {
+				iommus = <&apps_smmu 0x0887 0x0400>;
+			};
+
 			iris_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.34.1

