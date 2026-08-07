Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8ED463B91
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091193; cv=none; b=UpOLofDiitpmuZiRu5PtLFa1KV57BvssPWavjQbtJahYfGbFqtsU/SN8SvW/2EkA0GOGFNIO8MDUwZhKhEtLjoejbR2alwm+QGzNfvo9bwoGE+zdVRx7hUT1oUODoWNcuYvcimRqXMWpGKYD+lR4m1bed8syZqpJEebex7st/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091193; c=relaxed/simple;
	bh=YMI3vkw8hmiKF6TeqHv14c9+YFV1N/QsGGgnxq8OIyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPGMqH+mdVAUsIzleNJnsvNnDHSBpDeVfgBgvehLVz1pvsn2djGZyk8MA14QmoYpDrvETZGos/NwgSCElLaHPl/MnxEA/p4YKSljSmER3CldUGBg9rWC769VrFhVbyV8dWMyfL0jsrc/RWvg1MmnEcX5zz2MtBaARDDkf+jZ6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDJd/eH7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ckpg4b5o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDJd/eH7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ckpg4b5o"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67782DtM4063176
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7j/zIsZ+9bVC1qTPvzBPq6Ov3hCUQZH6E82uuV16mCg=; b=PDJd/eH7F0gki3zf
	3qX4R2W/Z06K6LplI6Lj4dfsd/npfJX+0LgMhi67iLr9eLBmXIHaXdtNWJ6tGcHe
	keVNSAOocVSArcE4U2s0HjPgU4OLKkU8ZiFNPqdfu4fj8PwBAiQr2RNMKb1KIJAW
	+rkedsE9JsbTNFE0hTEHsSzAd4w2v3m9HOeqyWVgHwfLCk7YcS6KK46ucl29a5Jj
	vn3neUth4YYk748EzZcOVvISn+yQllKTT6n38ghxGJ5SX8/f+KLnvchZuC3wqkUp
	jy9Ax9/RBW8jhd/CEoNwM8m5gdthBw39kmWKsAQGeRiyBQd6ZLUy9uB6jxektR6s
	rpY47A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hawu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:26:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfe48ca1efso43399535ad.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091190; x=1786695990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j/zIsZ+9bVC1qTPvzBPq6Ov3hCUQZH6E82uuV16mCg=;
        b=Ckpg4b5oyd0bF5SilJ+/9Tpk6XXxekJXkw0i8wWKXrWa4hVURViEkRRtlXO7dLG87c
         nfkbf6GlYgeOxQT6Qi6dlujSkY66FkM0YxG9+cBt2852t4GMmblYSGCyCUv1WAbdTkBo
         ghHoP6BLHdjMF5bozwDUSUfDL4e0CgkJAKlzAxSvG7B2hxFWFj7TOtfh1Hyvyff+VSMX
         i96Qz9mqvUB2eXUruQfltmueh6GkZPtHQwGCHmQG6bQYD4LfzYit8uo/XSEI6vhKLDCc
         LAqmwGZkdNb8ezXRf+RHAMFt6Bko39gC4R7bYg2UzisTXvBLAoqVU0mG9mh8m73FoeQZ
         1hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091190; x=1786695990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7j/zIsZ+9bVC1qTPvzBPq6Ov3hCUQZH6E82uuV16mCg=;
        b=M8srYeqpYFe31ah5qgHd0dAL2ekRC6mhr2UkNTH00XbnMnqXQ135uy/Btk8fWQ0KUk
         jVbhK5knyoF9NEFhDDMFmIo4i8eJa5E0VRZK7J8pl3jtWdtj4Gr4BgcrjSPWB3XuAb5H
         q2WbQOGLlEmEubib6USRrNLmdQmPO7UKakGVrnkYSnLPSjq4siKxdHLxy+rOfF8tqzhB
         FTGL8jSHEB3zfJEwQI3YVtvlUcbSBQoiKDUFtH7YxaWfVHboRrRYpdNZyZYRs6Re2wEt
         uTqIDCKQwXpkZK33486e5WR9lvK+7lyjlzAp9lG4TJE59ij56BwsKAfq6D2MuKAUnGfE
         haZg==
X-Forwarded-Encrypted: i=1; AHgh+Rqd2yGnj9iZ7jKtopu7ycT2yfZQ38cdxqQTru0sKlr42YLPAsUBH3TckwzsdxJWlYeMxSIx9mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvBEa2YZiOI4zM5VLGDINO+tcUDBYgZY4WYTS/v1K7zas3G6j
	mf2sviomCqH/gMg3p8Aor4jmlcLIdfaXo6Ze87ReKcw3/l/uHIsOXeRlQSs00S9M/8JK/MyDZfG
	vzb4wGR+j1+xsgEahGgoE+ZXiNCdFmALR+Br2deGlwhreFashQupspaKk97w=
X-Gm-Gg: AR+sD134KljqrK5aBnJ8KKgMXBu2DvIx4F1GpKsjhQ11ii+FYV4oELOyr765N0yxeno
	DI5wACyc3ly6+H7XDpd0ehUDdWCN8xGUIR1XzHfRYJhkoD2nn9QPd54Eptxv34Al7+ErswyQmZt
	dAlJ0/zvp1a09LhybUfYQpohCWUeTpDrwxcJr7JDVuZXH5yuGK54sHqR8EfnoApdeHeyGOqHbiA
	4Jo3TGogXOf9/K3Ubs1CSymz0rXGB/+v2u4b/pRMSPrW9eG/xVsW8Abva3jp6MpPXedt7koZAGp
	/XzpK31C1BvFRhw0eoU5miLeyiX18VH/qOtq81KGG2xexmmya5mrHR1M+TAWd/I7aYQrz8dguEc
	sHwInlToFqyuLAo+R8VhJmiJwRZvdkfrNm70=
X-Received: by 2002:a05:6a21:4c0c:b0:3cb:853e:850e with SMTP id adf61e73a8af0-3cb85dbd1f2mr26403347637.13.1786091190528;
        Fri, 07 Aug 2026 01:26:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c0c:b0:3cb:853e:850e with SMTP id adf61e73a8af0-3cb85dbd1f2mr26403288637.13.1786091190097;
        Fri, 07 Aug 2026 01:26:30 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:26:29 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:49 +0530
Subject: [PATCH 05/22] arm64: dts: qcom: lemans: Reserve low IOVA range for
 Iris
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-5-3996f67e33f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=1934;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=YMI3vkw8hmiKF6TeqHv14c9+YFV1N/QsGGgnxq8OIyY=;
 b=nlhEf9NlcAAHsMhV8gipliTwfBY+PUK9FEDOlMy9KhfsAoyYLeWc1J0uhItzpqcotydC/Mw0u
 jx1MioKYMpcCtUXFjWvbS+mcmeRgtYZEfZ9wAUajYAl17i5NYREvD9t
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=G60s1dk5 c=1 sm=1 tr=0 ts=6a7596b7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oZq95A5y7fdjfYKW3kQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: pt3RX2mS54BurZxw2SAf2CU-_jgsY22I
X-Proofpoint-ORIG-GUID: pt3RX2mS54BurZxw2SAf2CU-_jgsY22I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfXxzGMg97/aXBZ
 DuPJoQ7lWJrsskKkBYP+vzlC/wOqMYsdFUM7zjUuTBF4UZQwN7lfS2/6gGReyXu3QRS9PFQNBPb
 /geyPnmRp0IN9M3PfZONWf2u2QLNF6w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX++hvCrACplKx
 Z4C0O8xbef5cIk5Ca8fEtseMu+fLx9hnKQddz3NAvOwiDuGaoVHBcuATSux5IYnUb7PuKbmCG19
 gtB0BP4f3HpeSYLTmnx4G3OUWWqhcg270N4tNUOX8CqDpsqzXjM2RGdqibJyfel1SxdKiBi0pcG
 2xRCTdyQfHQ6d3H6w//C//QuY73ovv5SMyUrVMWbujLt5jhP87Uoz9QaR4vbXMIdoPrEu39POjo
 Qg0t/FJ7UlQZUKsqtECfBpForNDVPlvS5A/Zu1VwR9zwRgaIpdZBd0MSSq75VOh9IA+vRmzTDWw
 tJmWHrdCF+3YLX7Rjq3HAJex79e5DoJZcoXZr879kGEZ9pnF0fcYPVHPtpe7Val+nD1v9dCYEOp
 Gf/AlQRfPQhhrTYcK5RQd4nJxwBynAqG+/u18+kFbtKdxe0AAAvCHx6Kb9PlCoqeXHmKXa4yse0
 1IOpCqwBmY8FxG+DlpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070062

Iris VPU reserves IOVA addresses below 0x25800000 (600MB), primarily for
secure non-pixel buffers. DMA into that range, from any other stream id
would triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with one or more browser tabs
driving multiple concurrent video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

Fixes: 7bc95052c64f ("arm64: dts: qcom: sa8775p: add support for video node")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 695eae1b7256911e656ab1ecdd92aca135d92f39..da0326fe244850f92e080e648722b4aa0037da7b 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -862,6 +862,17 @@ cpucp_fw_mem: cpucp-fw@db200000 {
 			reg = <0x0 0xdb200000 0x0 0x100000>;
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
@@ -4957,7 +4968,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			interconnect-names = "cpu-cfg",
 					     "video-mem";
 
-			memory-region = <&pil_video_mem>;
+			memory-region = <&pil_video_mem>, <&iris_iova>;
 
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";

-- 
2.34.1

