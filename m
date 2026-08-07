Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47B46C4C2
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091181; cv=none; b=lhBiMdHnE1F8WfMO8jld0rTXv5oTQxk1CiDXJ16DF6r1k9TU9D+6FSnj7ARKvqxypuYcEJZeQUjToCiZbTynxPII65WKMdbl8O7PZ2t9M3eY5cJkSYqgfV74S2Mi6IuRkMRppJOmMA3hKKwg3B6pY9/dV2dohW6LFS55Aq4vHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091181; c=relaxed/simple;
	bh=7GZVCck40mAmasXY6IIt1kL9lo7NhO7orzOoUuPBEOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eb5bF8S08oLe2Ppws0O4nHnzbVENVgkY0daqOSkjCRZoEByLr3mXXZb/dIeoi6gnoqyy5yN9DO+cFZV9/RdNZs3lnkAnkAYp1JjTuxg6TLTnVwtbtl2jnGslcS+XzUx+5vXY8uZirOSOnQEgIj0tFAdSXJsUNO9BX2UrLWtKsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oxKR1Aq4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzzrXh2o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxKR1Aq4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzzrXh2o"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777cs7B3829298
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TakO/Tgd+FhPD+OAmfvwRyhlNZw59xqM17dbGLWCc5I=; b=oxKR1Aq4dfs1vbaS
	fIuNCBgf5uNap54a7pWfPGCvcDTQ2jPvER7F5FF3aKjyl0+l1E/FpiFzIuhR/JrI
	qM0I7FtP6MHnYNqjLB42uJ280hSUiUxpcpUr4ow0P2KiouU7VINTfPAltuslsorQ
	HdzN1e7aOT99tZHGuh8wPh6HS/cNr0P7q/o4LoXGo9TL8GLq6KeVET/+WgiCrMLo
	ZmcuFLQLJgEnow3W9Zu7mHdoV/e5foCclrXiBukcJili48gpUsUp6pFPno9pDHaI
	tp7hoGXkjmpFX/Z8fUARcFKHxvbdUigY536BgZ0qCh+WqTh7uDMuoAtheEcCusmm
	jGAn2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gu3v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:26:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso3556036a12.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091178; x=1786695978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TakO/Tgd+FhPD+OAmfvwRyhlNZw59xqM17dbGLWCc5I=;
        b=CzzrXh2oofzr1BXGqvxTQgAotdgm/wYWWjL6AP7QxiR1ItLO5Kbr1AevPr4xRF+aPR
         rXLXh6hngBY9cm2nvEVf7Wzq+ws26KchbbCNk82APPIIvaMfOQy/u+zGa3tqBQ5zoJ3e
         wh1LaoGAmqF8ExDiIQq2tpAP+jTSzwq2ygIwSq/aVUkjwqhMGU1QkqFlFV89frFeQm3r
         uFlbOBpKLIoje1GAN5JYsz94vahj6OylUt9UuMC5zaXynpuZRYQkYocRO0NRqOhlvd/1
         g+j/wL+Cr0vUI8sjSKiEOEEMdwqGcM1ktap+0jQkjiXQo1M7b/BH+kI48zxxzP3XMdCC
         qr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091178; x=1786695978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TakO/Tgd+FhPD+OAmfvwRyhlNZw59xqM17dbGLWCc5I=;
        b=ZcvyEN9veLVHEUszlO+ktPkPOuf8SFFT7hl/jpUtP0QvCc07cXwa1TDcIgLZ9/FbW6
         yo8FoYBt1/VS5Es2MhMmf/c1Eq/vS9/sVZdIg2vpnqQzI9vIBxGdc3FW9at7CMwR01Ky
         03W0M2fyhs7FW1g3gE6x4dYqwgZHxcm2RjF0tDlkpf5tk+/zOjlHqJOqwhT9j6eN167t
         xYL3Niexo8Nq4MvBlHXu10nwdei1lrA3L7rjSRy0xj8oOEXvYXKEJ4VuulJMrgtm875h
         XwJahwI90tHUeYJ7g7y+2Y7pp8XljnsYPtt7tl+PFMsTAaqKyCIZOsRP2e2TLsiB7lVK
         9L3g==
X-Forwarded-Encrypted: i=1; AHgh+RpOsQf5mP+z0RbeeSddlk99ADte+35pQoCaYyxtANbBjLp/cbplRrUwuRV7LYuXcQd4lLYbp2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHi9n+1YdlOkv5lEq0sx7LlMnykPgWM6w+pN5jM0hKzK8poQWB
	JWyk79UBthhTKYvui6A54pr5jNrjBUPbIEVYEimyaJei/y6SkngdLJxYxc3CO4qgwbE/zRaHBEP
	DYTXT3ZRUNVbXmpbdp4UmJatWmLgEkUermYcRFuUVw7lt0UDJ0puwnnMFKwo=
X-Gm-Gg: AR+sD12r8lztcnZxVphjd5197+/pM8DVmJXaOtDRkoN5iR2EQns7/2opq5ShHXzzU/x
	7WEDgfRsE+AJURODmQXuNGNJDPBFALXH+1XUYh1ning6HCAVEO56PfleiqmnA0RXTl/jLdrAf9I
	A7qF04cat5zr/hpeOlwlw8FhkvZhIwAjLwc9oO1M+9qSRuIMMFeuIUqG0cbrUmt8jtV6y0NdD3O
	ueJUQ6Ye0zVCWtrOnzeHkM07EU3PexAYhh2qjw7P+bjfyhtJyzhJQiV845vPzmUbJJukVvHe8br
	KoeEc/h5wh6162LutYNMl8tKTZa9frsIlw5sQysuQ+LENJao3J+hM/PIsWQ+lpK20ES9W4fOo4j
	0eUAaJliwLZl8IhnSyU3xXhHH+yXU89XUdus=
X-Received: by 2002:a05:6a20:7fa8:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3cb85ded9c0mr23418873637.5.1786091177978;
        Fri, 07 Aug 2026 01:26:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa8:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3cb85ded9c0mr23418821637.5.1786091177445;
        Fri, 07 Aug 2026 01:26:17 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:26:16 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:48 +0530
Subject: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
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
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=2107;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=y4neOBhumiVhQMGRZ3cGfK29w/izA9kcGQfXlvZQmjs=;
 b=1cBem7Z5JSG2G9f+WHj/HYweF2Bv9cAIfephHSlpV8VOM19nJc4+mPIV8mcnuyYm11yjt3ykF
 /katKAb7D/rD6s5erB+tN/0Z2fCti1VKEW7YAVkhhECVjVw4pQr4oo5
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a7596ab cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=t9ty7G3lAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=RKaA520q8mD8wv_CYVYA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: g9W6auMjS4jPT1JsNDHmxRjSAYkZA7js
X-Proofpoint-ORIG-GUID: g9W6auMjS4jPT1JsNDHmxRjSAYkZA7js
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX/hTZf6S4qne4
 ZF3NJSOWO3N/8j8XIEcuIP/UYliSPO2APCyNXzPrVGzFhffThZSR0G2IYFFvZthzVK/mAmnwQrM
 AXE2ENfEflrSP7H3dkMRxVXHWXGPpvk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfXwj5QGEJMGCHz
 be6wv8DMRL582zQXT717bq1gULRICVVjushdO1Jrmp6/Cj+a0kftZU7rzdV/3W2ZYZMYEKO8uwP
 u5fZxOZxk3IWt9jUcb69KfGJ4w19WkU0aZgSJUAUjKwZ3g2LDeli2H2KxyKXERYDElFQk766HX0
 AYQSCoKZ7n/8BGZxK2bfG/2hSVGSWPvYAVoHXXboL7y0v6x3Gce53QfOxJDAKSd61+e3l4B0gHl
 XTz4SLAENusUxtZGWXwqedulSH7dkQjf7sfH7X19a2umq9rJcA2EIJfLUePrQHgL+StNOaf0lPx
 MMD4xwzjTEhSzLZEaBhg0jLA1OGTMS9Pd0XCXNjOCrUQuWL600MJkVjrd58ax3U6h65MKYTqAVm
 KwDUj9ZSnmnSwXo2/t2QnMfxJTcGsZsFbtHEMbF3HZE9SyoHaca6wE5EWibfqRusS4QVKpMgYA0
 82MAakgq+jUNFV6izOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070061

From: Daniel J Blueman <daniel@quora.org>

On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
below 0x25800000 (600MB), primarily for secure non-pixel buffers. DMA
into that range, from any other stream id would triggers unhandled SMMU
page faults that cause spontaneous device reboots. This is readily
reproduced with one or more browser tabs driving multiple concurrent
video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 8a96ea1bdb9c4c409b2af997680d8c13fed0643e..87f424765d513c97b06303bceb75ca9f176d2ace 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -666,6 +666,17 @@ smem_mem: smem@ffe00000 {
 			hwlocks = <&tcsr_mutex 3>;
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
 
 	qup_opp_table_100mhz: opp-table-qup100mhz {
@@ -5439,7 +5450,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			interconnect-names = "cpu-cfg",
 					     "video-mem";
 
-			memory-region = <&video_mem>;
+			memory-region = <&video_mem>, <&iris_iova>;
 
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";

-- 
2.34.1

