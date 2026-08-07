Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F446D2C1
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091207; cv=none; b=ulZqEr+DhytS3UqNZrh/9FNMCQfvjr0f6b/SJWG9qX6tLFR0fYhT5xBxR5w1jrxp0sB2E+Z4VW/03Q/iOO8oaBPsAid4g7JLb4sH2rCND0xGUi/VpGeaTnRhNZ5n8y88W1FwU4yIz0Prd0PuVbvVlFkfdAbuo1lL5DFFI8anSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091207; c=relaxed/simple;
	bh=PVsdyB/yAC9/7RXIeAbXTwRvlXT2Yu2XewV4qN+JEVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTvy+eDL/pIBagAnELtnki0ilwsWTpmmTgrs0CdwfzJncjlMk+uh49rQoH4LKMWganjtCzOfVPj++Mhp5hool2SQfLVhoWEhZb0NuhJ95TCuAB/AQtJ+Dn9IBKlZCyakvg3HlxTz60DNlzKYbwkY+aFT/fKGH0vBM7guuZgg4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d6qCFE+4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eG9bDo22; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d6qCFE+4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eG9bDo22"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777reHD3564350
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YMBH6F7abMRHkji3NCYrqotmxaH3oooV000NuMuHt3k=; b=d6qCFE+4XcNp1DrJ
	dlUuyNORjuxjz89WQ4DZt6GMjOUaCpSJOQip+yBV1iOcz8FhsPtTeU330GxgEo/4
	/TQv3xq+0JofX/L2N+qao70evSkT+6Rzzq1IDSGbju8afUxJsYnCMnFBpXD9VPu8
	7kXpAgjeirFCe4ijQrpxt73lONyTphVVif5wHaWn6ueunU0pHDcj3HR5+umYKHPL
	oVOef7pB1NPtxoWiKjrdaCpmjwHst/Ia8+1aBx2CU19Sb1XsDlPjREAa8y6NxXOl
	G0w+/MZS3WYp9Bet/sE6UkLlNZvfdHWGZm+dILFXryQuLOJ8XzJK/ayBBbya0yv8
	lXX/Tw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jtwh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:26:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1393447a12.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091203; x=1786696003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMBH6F7abMRHkji3NCYrqotmxaH3oooV000NuMuHt3k=;
        b=eG9bDo22eetEwVqSzoZIUS20FtX0S9Pw9hQd1BDOJzWrVcXR/INeqrbWSLoNh/QUDF
         PggduRW6nSgKD47glU/gMmviS6qPf2ME4d2WA+Mo/e0pBRQuJQSmdRM9nH/CgxRIaUMS
         tEhL7yrWC4tmjKHBnldT1XUXRY4V1eexqNq8DZTWCUcj+u/bcC9hVGahQ5X+G8iMLvps
         da/63sZxd368lyZved2BvcoVLEQ1vquDlco0HxAan/D5KW9pdI+TOonipZ1P39SwD//X
         ToMdV9TWS1IutX/JLGn6gwCtDTxs7xjzwKVAOJHDyWzD9yBQLdOwWwskhbsA3Wxuy4l+
         bzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091203; x=1786696003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMBH6F7abMRHkji3NCYrqotmxaH3oooV000NuMuHt3k=;
        b=Yaf61zoTB6yzW8yPabbUWWxJODzORELmMPdwwKR6uAk4bdnrl5LxAAlA/yPGSpa4+F
         s1f0eC51HxUNhPQgfryiKC7WU475EPlbGeLcxna2wPKCkeHrxzrSDYo/a8Ygg4iPYRGB
         q7ekR48bh8pLnnx0FXNjED93NWWvSefqbTJa2z9iRUDTGd27NBWYwDqyvEKQ9auEYc0W
         M5YbX/azfuMyXXvlrAux2+kzVq1UQobIR8CjFPDTXcVcMGqgu86XU5CJyBO8I4WVhoRX
         bom3w+vXEKgDjKFs8ASU3j2/0j3Zvh4Bo3Dy4BlLYu/+cRpl/V8WMNpX53TgVnEzcLLN
         /vnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpT31detUjK+shNpxIhd174PDRAzDf8szket/qbUIM4CD+bQW235QyevHFk034b4lrB2RZv1zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2ZxbTi6zl8pkOt35LUZ6Zx7Ok8C8v7ZeOwEL1hYfaBUR6Dbz
	9vMeJ98QlHxChsTSGxQ25Jf2oDbIgQsnG/I5M2BsKlBgsv2Wc8MlP3GnzzS+RVfW4bSGykoY+ze
	UnWcSFT1U4L8OFqJrulPxPFQxpxa6WQBwvVp+agEI3zuPzj/TLjjb4sNEVGo=
X-Gm-Gg: AR+sD13jeLL/ZHPwYVAkkaumisZUM2xs0gAn2zASF/l3taPyRn/PSrItuJeGghpfKNH
	3YBZS8fsdeuHY8z4jEz2JQCOoYQiP1osKPeyBjtN6dNi0Gq2Yubgdez0yg2vzERipLGpyH1lPSZ
	BOGrMJ5q3e0GnRnIsx8Y3/WyIKK9C4+X4AFLaeKJCnjmBvtKtoOnpfMfANb5i3jSE7vMsvkgqF3
	pD2mDpGqjLzY4J1NXBk/9X4R03L6Kf72sj7vaoqd37X6L5v1p8jsuFdazL46eSnbyVq9ShBXQKs
	9NV14jfC/8+zvLetI/wzGDoOdP9c5AokKNNJwdcplWYUSy8Y9wCyoDDAOsYuKBHKJ5aGcRuTcE3
	kiwkjjUyfMl64+Qc9aYvuMa7scnPIG0Uto4k=
X-Received: by 2002:a05:6a20:2d08:b0:3c3:80bc:1540 with SMTP id adf61e73a8af0-3cb9c07129bmr15933710637.3.1786091203051;
        Fri, 07 Aug 2026 01:26:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d08:b0:3c3:80bc:1540 with SMTP id adf61e73a8af0-3cb9c07129bmr15933653637.3.1786091202624;
        Fri, 07 Aug 2026 01:26:42 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:26:42 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:50 +0530
Subject: [PATCH 06/22] arm64: dts: qcom: monaco: Reserve low IOVA range for
 Iris
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-6-3996f67e33f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=1915;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=PVsdyB/yAC9/7RXIeAbXTwRvlXT2Yu2XewV4qN+JEVc=;
 b=qTpHqEy6gqbrZGjCGnn1rBhSp5krueIuiVNonn7ByUCXsB7QHW7jReWYHyOYcp0FLpFb11RTs
 D5SdyHJqDWPABoyozZDXO1tuhINyutaQjcsix4T4qbrtNpigeuQmfzG
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=Rt/16imK c=1 sm=1 tr=0 ts=6a7596c3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oZq95A5y7fdjfYKW3kQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfXx08wL4rphlgz
 y5pE6uUiu/atZgpOwPo0ktDWUmzdhNUVUOj4CmNV2XFr+IW/VYp9mMyl1hGIulgDMXZUbIaDc7D
 9k+FuCun0psSidrGU+tKLdI3iqFhjN3jNdXHrkq9orlSkSL1jbxg2qgJPJYgekBzI/NckoY5HHn
 midbgokFcbKGoZ+KCN0gpl/M/LTPxjwN4oG+DO0SyHlrHJpTLHVTgUiCAu3WF1uLyS+lJWNxNeP
 sMxFzO/lS5yAWqQC1InUwd0qr5t1Ty7yZ1tY6qdaSOD27GhhrW7eXT92t/8g+Msf++1OrPKfssZ
 2wDDRDTBcdWY0jozSyp0hFJ3NCbLX8C6RMJGD491RmkDG2SSz/BUkpeOkpi+wrg8LShvEQhZ+2W
 u7RuqJCgt9t+Na0Ad/yalAU8NAvFWn9CVVFR5cliSZ3FhgUjUd1J0qPKMAo8jIsn85cCgRyBoNE
 vF4l6YTzV2cTp5y5H3w==
X-Proofpoint-GUID: 0xCMKh624YMyb-3IFmSRWimiaGBPFolw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX1CbaBjmNrr0p
 pCgtsVSaj3iCDkJ/04yQIqhJqy9RUBQFnDiH35/xbgXWO3c4GEAX9d1ZVnNmg5M+1j+qwkwKsx3
 WlBsq2Fmd768IfdMhS6mpLnhKCokM14=
X-Proofpoint-ORIG-GUID: 0xCMKh624YMyb-3IFmSRWimiaGBPFolw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070062

Iris VPU reserves IOVA addresses below 0x25800000 (600MB), primarily for
secure non-pixel buffers. DMA into that range, from any other stream id
would triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with one or more browser tabs
driving multiple concurrent video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

Fixes: bf6ec39c3f36 ("arm64: dts: qcom: qcs8300: add video node")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index cfe39f923224f6c9af0a1b15a84f2fefb90d53d5..048b4490fcafd292e4f8ad7f661121430f9ceb24 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -812,6 +812,17 @@ video_mem: video-region@9be82000 {
 			reg = <0x0 0x9be82000 0x0 0x700000>;
 			no-map;
 		};
+
+		/*
+		 * The Iris VPU reserves IOVA below 0x25800000 (600MB),
+		 * primarily for non-pixel buffers using different Stream IDs.
+		 * DMA into that range triggers unhandled SMMU faults and
+		 * spontaneous reboots, so reserve it to keep IOMMU
+		 * allocations above this boundary.
+		 */
+		iris_iova: iris-iova {
+			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smp2p-adsp {
@@ -5399,7 +5410,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			interconnect-names = "cpu-cfg",
 					     "video-mem";
 
-			memory-region = <&video_mem>;
+			memory-region = <&video_mem>, <&iris_iova>;
 
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";

-- 
2.34.1

