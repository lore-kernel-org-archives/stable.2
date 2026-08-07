Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE33D647C
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091169; cv=none; b=TDgvL4z68Kgbo1NoOz7Sa68ywW26y/1IrerrPZUg9+p4X7COQUkY6L6FcWn9CXpT7bdWzLwBlmHharje5585ZGxdI3f7YpLzaPEyeO7EVtuJxBb44rzDjUmysk3MRYr8E+yRtSl4EH/3vIfqNH3+xTPA98s0Y9lvRK2UiqRXuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091169; c=relaxed/simple;
	bh=k2QqCCh9X9jHuhXVXYKmeUNyCph6NCLcDyyxb6DSt9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EglQbwgDYyqVzOk467oOQb7vveAMmLuE4U56cMxR1FGatBWTwckeAUcBuQ41wtaOkHoCw0LPUH7Bett6gdtozCmzah4Ffv8AhY3IRLJKPXtSJAUYssEKnbNFu3zrtSjhhsYcxf6VwC2BL4IVrqShqny2dtA7US0ezHxQzR3EqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rd/pIsCz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KFf4h+3o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rd/pIsCz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFf4h+3o"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777ieYG493924
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uWa9gET6WAVvUhHxtXVevYTe4vaEKY3KFNZ8ChrERG0=; b=Rd/pIsCzkCJ7sJkq
	hX3kY4lm0uNJK/x3yfsA2x27SYy/XvmjHFfZuKx4/q2cw9jsPiDa3t3as67dUtJW
	LVxvenSQMPGgMh3BLrM39e5F7TC9qInycSsGhL1TKsqjfLHc5K9/S9xlO/o6hLZi
	LncHGdDusJS6gfHXoQZIqf044EyO/zNATFg8p3k8FVS/Ctr/mObuFAC4N+33tke6
	xU7rt+YF8jqZSbjUcVISVWx0a4Blg1XFh9Dedw8HFMeUkV0J5+Vj10HeM2euES/E
	dMqL0daiX6pYFyiW5ipbdTdWrf7fhS8dd3wG8w1QEInSFcVi/lZQxcMvLURNk8iM
	8J/0zg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6raxh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:26:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so28256045ad.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091165; x=1786695965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWa9gET6WAVvUhHxtXVevYTe4vaEKY3KFNZ8ChrERG0=;
        b=KFf4h+3oDVBWyUslgxxPZPN3GP1dbIvBqMG+txSfMYQ38+vhDcO1h8ihtJASYYMqWr
         MlQcUK29iubeciy3qWr3Im28MumcExddW7lPae+wNdKCP0dqs8p8vbIGmmomsiWBZrkE
         /LHKMo/qOjLRHKdSuYdUxhWsaor0wA9rUeBL6SnoERuvoWebcVD1fHpQsiZcixU0bALr
         2AsrrijGk/LGTSkRcR2yOijKmUrCDpdKj7F666yeGWTe1hngRzPC5OjxILh7IF5Dyahi
         /EvKCHjAzNhZ0uIM2/WORei+VTz4kErsPB7UGiNPVDb22KHnZb2y4zpGCAkxvgGkX7nr
         5Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091165; x=1786695965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWa9gET6WAVvUhHxtXVevYTe4vaEKY3KFNZ8ChrERG0=;
        b=NdmI5oj6jL6qsQewnWcNE+8ooZ60u5qAlUicpmZIg6cPNH7vTndJxAWdzjb9215r35
         YVtpkEjGpDOtb2eTJnkyxXUa7yxJGty2peVvCTtirTjxsbN9SjdzIaqrdnWfHGoBxjsz
         gtxKddD3S6fwk6mlZU0Tykd/xxweXeXFfndvSOLR+6/X54A7U+MJKusCefXC20ukArav
         cuCt8xB6NvGcQARDG321YUiJ2weLGCCecfIf/zkHgH6JBRsYVgKfXvda/UofDqIxU5/X
         9liIhdFhgb7GhzcPqEafeGiYNf1Tw2TvsI0CX+lBx7Dme2TaQB1P1oxb/R3mdeVjPMYo
         mBRw==
X-Forwarded-Encrypted: i=1; AHgh+RppjBnAgzPr7HrmBMkJggO3+EYoMbyiC1kXc8lpezkHlL+IJtDHk1hZxhoxgkxexCjBnHNX9sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZb1Nn7ny/PMzA1b9P2taauXWuJZK96n1fodnc6nxM8bfyZ3JS
	EG9rl1PpurTAocibmSsZljHwGhYBYkxhc9a+6hiuk8bZ3Zu0nJEJ2dY4i02BhJIxlbjY3wtDhju
	ObUDeFfkD1zjiYMHeFOfUD1KYb9b6PQbjVtujcelQr7g0H6w3010d7IeFdXU=
X-Gm-Gg: AR+sD13aTto/bOWORefhm2X/Bqcnclcix5BV6eDKCfHXKKf+pmeYqGozfzvsilD3Q3/
	GsPdWPfnYXxc5J82xzdlqtvGewvCuE/Y0loQOXPicr8qVZR9UyXjwM9RqST2Rs4ZxKOebPYnvHL
	YRRJ5M0Gq+RLHPGNc0AzcW/7824SFz/5R8JSpI1FGJGNR6buvGOgOeP2RPEPyWTtjs9Zu0AbMFJ
	as+W5Uy51iWTh6HiGUsnSyoM9PSc42L79gDGEu5DFla47CtgdYHHw5b8vidOsE6PxCppMuEDVJd
	VZIkKX1QZi5lyvL203TnabcPrOkvGNsdpA/2K3IZVnP2eUliwcV33OolK7ctO1Df3KeGSQ/8PbE
	7P93BRhXur5c/ni2WR43MZkMchxFL+Y9qacI=
X-Received: by 2002:a17:903:32c6:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d106650dcbmr77510395ad.0.1786091165072;
        Fri, 07 Aug 2026 01:26:05 -0700 (PDT)
X-Received: by 2002:a17:903:32c6:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d106650dcbmr77509915ad.0.1786091164607;
        Fri, 07 Aug 2026 01:26:04 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:26:04 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:47 +0530
Subject: [PATCH 03/22] dt-bindings: media: qcom,sc7180-venus: Allow IOVA
 reservation memory-region
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-3-3996f67e33f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=1453;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=k2QqCCh9X9jHuhXVXYKmeUNyCph6NCLcDyyxb6DSt9M=;
 b=QxFev80+LYxm6vHDtmI7oG4xa4xX6nSDpEXDR5undg+BHuYkeyecUmgHxEtRXsJ9VSN76xt+y
 yZkUXvpA1aFBks2i3lB565t2MiQcQ2PtjzNC4S8jZ9sxUJrpTZMTqpc
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX9vsLWpc1gk5/
 daf8wcRUeBGwkByHLIURlJDG1UCFpp9JyAlP7Mj1YJgbEuzSgXlX+iTSppe8quFSVUtOqjW0/Yw
 IRW3tOsEWQlsvOy9X9SirEtN2GVovr19wA8haGF7DI0Hx09p/uBBuJPj0q0V3v/hs5ZTZgO/Whb
 YSnKd6gFIgZJ/N9OTjAP2cBAaOHCHOlhw7c+qmCu6Xh8aWIioMIPxNhBURgt8QjWXgSiTj6armJ
 VZ4VB7dmQX0CuDNXNAsy+EXGvaLc1Dqdgwm4LHiUKjFCqxKj8dpk+PSse5DgfYI6l6/z8SZmlSS
 jf8Z1ObhRFBoFwzItq3fpMmGl0mmasPVAaKC537SIrTje9g6N6MP+ENCdMKCZjdiqSYbBC7JTZT
 XYlFJuVAHdxmlPVL0JQuemsS55b1JQ/uYYAOU3zcjt3rjLMfb6FVD69ZzAuesj31On3apuzu8fI
 xfOEuS+f27h+SjchRlA==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a75969d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OD5a0iPE9_tbS_7HGJYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: xR-7D6xTMVHhmAYrxCZhZGJKzdUTle9q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX4NDoL88N4egL
 BPqtYdt2Z/nd/QdkoZC9GsMGyS0CnYlOoDf4zECgbiahMVdI9n0IQqWD3oQtTIcm4mtiRJuLv/s
 6tKy6T9sXj7bqEeFioE94fdqF0VAcwg=
X-Proofpoint-GUID: xR-7D6xTMVHhmAYrxCZhZGJKzdUTle9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070061

Non-pixel stream IDs should not allocate IOVA space from the 0 to 600MB
restricted region, as this region is reserved exclusively for secure
non-pixel.

In addition to the firmware-loaded codec carveout, platforms need to
declare an IOMMU IOVA reservation (a reserved-memory node with
iommu-addresses) to keep DMA away from restricted IOVA range.

Permit a second memory-region phandle for this purpose, and describe the
meaning of each entry so the ordering is unambiguous.

Fixes: 545d984cc90c ("media: dt-bindings: media: venus: Add sc7180 DT schema")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index b21bed314848480b82153e49602f0b19e08e7335..52de5a5465b0f0b245b55eac6cd1acf16a00f7cf 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -51,7 +51,10 @@ properties:
     maxItems: 1
 
   memory-region:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Firmware-loaded codec carveout
+      - description: IOMMU IOVA reservation region
 
   interconnects:
     maxItems: 2

-- 
2.34.1

