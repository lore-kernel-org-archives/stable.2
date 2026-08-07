Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A346983E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091281; cv=none; b=tTsWBA37lntEdvpKOs41zY0ugLeqCqfjkQKi7pAslXIGD7orcp25RjOh3oI9CCsSl4c4DArDYcw+tRRdcVqqvnpyYCIL7Kc66EiBlG6GCXXRuw+nRvYOxyeylHYquix4qk1HmgYt8VcidDJwcv5BIzjQLIeT2Ml4Aus7++d8QZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091281; c=relaxed/simple;
	bh=KqGUHd3qFik/3HYQ+hBPtHvoV8YV+aNNOJstuZvGbAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvwXMjZyanfAt1E7gnMT683s7L45k3RhIjO5Zuk5Xx9nbnuBUEoTECuL6jSa7q+y0Z71vuXZUDLrdyIxFLhxnFw9xvf4m6zWe9U4dVFZtBkFkzw6BSIR3WEoB7m+3SdLU5RC9txn+aNfWxdUWGJ9J4eXTg/VpeXAT0ayg7xenM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4AsWTVf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wh0XZsL4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4AsWTVf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wh0XZsL4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777xHwo3564257
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yncoaJbBZ1/xcSu1pOWqjeOKdyOuKp868TeAmEloDjA=; b=Z4AsWTVfb3o1sp37
	whOy3CFxOcJZRMxmsPuK24cTT00xXCt0KeABvVgl5++XcJvC4Ju8GL51nUZD74db
	tjUMpGcGEdOppfMxFXDDidETkVc01ea/xodJaQEbN1J9Rr7LNplvyP9aJzjPeY96
	KLDHlDUUWaWwORca4J83fYJg9XNHDk/79aAAbH+nrrRH0Jt3nfJyx7WQn5ks/NTa
	CjpTh9k/2DuVhe433zKPHsSdVDvD/sMJm6DMVlNBl0dXevAU6SpMm6LlR8VlYMw4
	2v4WJPfV+l+r2OvtnRnD1qLFndZExbNwJobs5r1u56z86zsqoHgcBfN0ONOmpOn7
	apydAA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jtwq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:27:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c856470fe9fso2469441a12.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091278; x=1786696078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yncoaJbBZ1/xcSu1pOWqjeOKdyOuKp868TeAmEloDjA=;
        b=Wh0XZsL4HeyVaXoGA3VkDf3lHSnEdoV5wWhDvade4qHjJNuRQ0BgUgYVnfuTyR9Cxq
         sEHyVafwMfr0EbazHRV8dKGgPHuaMOmjO4+zKZMKa777ptAaRdnjkwLMdgznEDD1F/bD
         XN9od7zdXNHAI64Jy/v1uFs51umGhEt/N0HnSQBL1ZufjszYMQHdXr5RkOdU35Tt1x57
         Z2Cadp0YvkoCmbKK+IbqWmMlK9MVtHzGgmdXQRyndoobWPEMUCUhproBdHkD/P3SeDBl
         S7zYN7gZcFDZIPesib95k3qpWcKoSX1hHJ8Sjj8OtfjElZAhaHSIkNjlPg6jC6ps75m4
         5pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091278; x=1786696078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yncoaJbBZ1/xcSu1pOWqjeOKdyOuKp868TeAmEloDjA=;
        b=YZOiqgwv1iAYfMm/M27Qiqy4rS3AJh0gJ3niZOPpcrUymNA2t9/hlVfYa5WEfoQo4m
         zxJx46ByJtUE+0+6HT3VsiaIu3lXncJ1AlFhX7OjiUaNFoh7gfQ2sMQ1Y3Ww7wiGR2CA
         0qQko5NEEX3Zhc9wcF5yl/jRw+eZkP7C0I/L7uEatjmKje1g+FbDsPJ3MNICUaeE1J1t
         HviKJ4azdbhPUMPrBfUT6kG1h/9ehQp5emXBTCycfKeVjpp6rahBRB8SJOuk73y5E8hB
         xTxLmYV7wrZKlrPYvkBbaU1f5Ut9ITInIoXug1YnWHnjqbWfCUHM6lA+rPlUbRmqY+lO
         MqDA==
X-Forwarded-Encrypted: i=1; AHgh+RrWKljGSqx0UV7fLGjpkaFofNGh6Q99ukR2ZzZz58PN9rTlSGimJvLaMqww2DODtsU3veDNIPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsgyDhDR/whnx6COeTZcsBVLhz+B21DpW3YNfilDe9FdU8SEJ
	UZBU2iQNa5r/F+MLjvUZeIlBdlHsgHHXUrMdoS3leYbI0/r7rm8ZTC8ULirkaw5wygLAgeHSwf1
	X4fAHhbtyGWzNVgE03w//77zJBNM0eYfCUXOV5aWnbfaoKFtuu2+49BuPkqQ=
X-Gm-Gg: AR+sD112Rq6+F4YhZkJ71bs71aVbJ+TJZlnMLevsSl7VnjFMXEpwciuFE8h+Ta5gS0Y
	Uz9NqmMle0ulFd4U3HlG6OFP4uqErcSfyeWuPptaHDMPXw+5sASeM8bmnKm70TpmuH+o8BFONvS
	nrOU8/ULRfJH3JwTVNhQsfrDUgsGxhht+4baDRLhdbr4etKxEBCgtQ5FWJxXLi4OtH13d+bRfus
	LxVyjsIAb7LSgrpKSeAF29dsVLS3XGUTpvybLibIF3wjRROP+KS67EpRP2lhMjAj7F/JdDYRlA2
	lMwzhgKtFsWTzR1pHi/0g6/jtLWUlhpAs3ucxBn5pRlWpeGNBGgAL4eO8QiodNkmUQfJmRDfSf4
	uUFnSeNiD01dh/i1EMqoQgwZSTtHMpKcYJcM=
X-Received: by 2002:a05:6372:a70f:b0:3cb:9594:91b8 with SMTP id adf61e73a8af0-3cb9594bf77mr18102314637.35.1786091278095;
        Fri, 07 Aug 2026 01:27:58 -0700 (PDT)
X-Received: by 2002:a05:6372:a70f:b0:3cb:9594:91b8 with SMTP id adf61e73a8af0-3cb9594bf77mr18102282637.35.1786091277699;
        Fri, 07 Aug 2026 01:27:57 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:27:57 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:56 +0530
Subject: [PATCH 12/22] arm64: dts: qcom: agatti: Reserve low IOVA range for
 Venus
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-12-3996f67e33f9@oss.qualcomm.com>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
In-Reply-To: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=1926;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=KqGUHd3qFik/3HYQ+hBPtHvoV8YV+aNNOJstuZvGbAo=;
 b=d9t38wsrwD1u2MRMTYxZgoEWFvw3lBqcDUx6RtJ/7BILMhKRyt+TFWAaAYdBnWnDZuNEs3Kx9
 alsZV1UVRyGDesW2laOnhPUL1eEi6W+OFMH84VGmzdnd1uOs27rWcvL
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=Rt/16imK c=1 sm=1 tr=0 ts=6a75970e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GHpYZHFKExNjpo6qA40A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX7G+EJr8FqyPT
 ofbEiiAmZPv3jOiB4l0UlK2PB8e+w5KaGBTg0WH38MXgtXwrJc9QXaQ5d+RRj2+LWt1v3NDjskX
 VoSE4k3vpwfm772MJVbZg2+34zn1lkPjZY0WXQpO7PDautO09p91H44H9fRqa3bUHLsILHj9RJ2
 ZX0d6PHkrC4Z6aMNRr+/M9GbVlVMF7Tq1q68eQv4D3q3S2RCnT/gDW55QiB7TGHuvFaqwjMbkWD
 yOXcuyrMH6AOcpoyszulBtH3m6m7ZAtPGh6sbDAfKISoOpLafKlUdJQS1BoJaILOzef65FjwTbF
 klGu2zjb7mEZ02MT3EBlEp7k33i+dqHapJjnXYTGEV9wN16oo/r+oopVMasU8/Aa8pSvtWRUAWm
 ct4X8XJmwL9Tn5fgRKu0PDpPiYfk5nAnQ8dDZ4PACo+YD+Sfvl+wShzpkfO//0V99CXhdfpmF69
 WUM82IwZbCcAPlg+PKg==
X-Proofpoint-GUID: EYIgSKpyZc7vr3NDAbl66m1I1M_-vI0E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfXzFC4qgBi9zvx
 ghGOe9AaQfDzYLFSdCk+u7CKPrTZE9RAGBlHCJc4RtzuRM/giNeHSIp2hPHG2E2RkZA3zeRmzqH
 4/p+l8uFDEQFQLe8syhTOUCUFbvvK0Q=
X-Proofpoint-ORIG-GUID: EYIgSKpyZc7vr3NDAbl66m1I1M_-vI0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070062

Venus VPU reserves IOVA addresses below 0x25800000 (600MB), primarily for
secure non-pixel buffers. DMA into that range, from any other stream id
would triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with one or more browser tabs
driving multiple concurrent video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the venus node so the IOMMU layer keeps DMA
allocations above that boundary.

Fixes: 7a37bf31e3a7 ("arm64: dts: qcom: qcm2290: Add Venus video node")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index 590bd2432d85ba80891ed42df8afa317c869daa2..6ae66ef882363a2b5b529a23429dc1f2820b2086 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -381,6 +381,17 @@ rmtfs_mem: memory@89b01000 {
 			qcom,client-id = <1>;
 			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA QCOM_SCM_VMID_NAV>;
 		};
+
+		/*
+		 * The Venus VPU reserves IOVA below 0x25800000 (600MB),
+		 * primarily for non-pixel buffers using different Stream IDs.
+		 * DMA into that range triggers unhandled SMMU faults and
+		 * spontaneous reboots, so reserve it to keep IOMMU
+		 * allocations above this boundary.
+		 */
+		venus_iova: venus-iova {
+			iommu-addresses = <&venus 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smp2p-adsp {
@@ -2486,7 +2497,7 @@ venus: video-codec@5a00000 {
 				      "vcodec0_core",
 				      "vcodec0_bus";
 
-			memory-region = <&pil_video_mem>;
+			memory-region = <&pil_video_mem>, <&venus_iova>;
 			iommus = <&apps_smmu 0x860 0x0>,
 				 <&apps_smmu 0x880 0x0>;
 

-- 
2.34.1

