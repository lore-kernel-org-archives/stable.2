Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042431618B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122589; cv=none; b=l7cvb0xu6AhyBx35zpqyoSobi1xeKed26gI5foQ70DPo8dS2+JVy+Qvi69x0X3Sg6RM232d+Llvb0fp9TxvKICcZSduVNEJtZjzgsp6VKUrROc1IC6dvH7KpmDMCRkXL+/7OF/a4ACghk6eGkd2HIvUpdy2cqCDsdUP9O2A3EVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122589; c=relaxed/simple;
	bh=zVyV2ilpcMf+nszWhvyCe+gkOWrhd/P6l5OHLlMOlM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kjgy10IefqzQ7AkcvFSGsCB+yvGe1LiuIOwE0oseNxwNZPiWkvxPoMW2RV8JHBqQyDK8FppW/eZvq3/pcxG5uCJG/CPDtbZFg1xeoQ0CLULCYwaqu6i72HlPsQDDtZ+GLwtXpm0hkihU7vh73chzJK1nROHiw1/5152sh/RW1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6fuVPRI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f0h2EOAL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6fuVPRI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0h2EOAL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B9mWiR3292262
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wVBzkLR8DNYTE77N979Jlu
	GnvmPbIsiE+d4eF0Xe9is=; b=C6fuVPRIQwJ7RXy64Qbz3pJywNaiz7HZxKO0TE
	YFyXf2T5rX3Y1tAxGi9FbEqr4EEkoNx/W8487Tq0hU/mhwyr8OrS0+bU5B5p/tNV
	xEo1mW8qLIl8bSNJPBHpIkbopa2J8sG5FSAm401YZfjBIo2E/24fao4h/VktC3v6
	xYXFey834gFzrRaIe3YfkLkPQ7vqt9yY6uCCXfpV3wMMT+Jvy+2BFT1W8aoClerb
	pFBV/gOGv1/XwrPuFyIBUojlNI7UO3lu0cyuUD02fkpEzydKabl5t+T4uQ+QDby8
	IaoMdz1dv3hgahkMndMhPAiw13eRrHhVW3ENYzgD+5LFef/w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbg505-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93918756165so129857885a.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122586; x=1789727386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wVBzkLR8DNYTE77N979JluGnvmPbIsiE+d4eF0Xe9is=;
        b=f0h2EOALVnENFPPhL/DlqWmq55FgnfwCcdEmCNto2z6vSU3R4ET/mPKeEPFFbBsoGs
         xherjFaLy8oj7Q0UV1yuTaeO87rkI5E3Jcp8RKnpv/KWZ5Z2TEDhimXoPrTC8ElXKl5W
         QIX3ebVtEZfOfFwv1XS8E6Uaa8jkC7UB3c2gNbGTWoBi+TKJddLYLUC5fR4tswY+NfEZ
         faiCpb0StLIAc+beIIPo7lYqeDKTkVEYhjk1jFDG9BQ9SAgoGG8l9Ib/GxVWike8WqLM
         hz8n7u2EugMT5ZAXPrvOBenT+3MrzsNB50wZ4UdkT3CHBCg4Ua7Em92YAdQELLawmUBC
         AA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122586; x=1789727386;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wVBzkLR8DNYTE77N979JluGnvmPbIsiE+d4eF0Xe9is=;
        b=FE3xWwL/PZDy1aacQcdo/9XmvAowi4UbQTT7b3/UE6RxO4Ciy6yrgYg8MHGoShaB4M
         HjRoX30AUqzozagHf5SoKgkyqNIUbGXXUKEX4CPsb0LmoDD4IT/ZnxR9odtIrZ8zjzhp
         A62pDpCS5MQm4XdANxAWVnSby3MxpmToNXxct7XYZrH3l92OXy/FYoypM6DKHBeCsJwF
         MKSnOck/3o17SI9sbTFskES2AR5j4KucyC8q9Zb0KDfoV0b1JrAQRNEVdTe6H3mDOgcV
         x+2H31VZR5OWOW8zHXoCT1apts7YEiLw+hH5R17pWlx3dnviwbpKezgDEJeQ9NKQ8pXH
         vcYA==
X-Forwarded-Encrypted: i=1; AKwUvBz5Xao2YXvYE8pj6aY72GjxV8G1SGRAgNaA9hhs6FBIxLhEaDN5pe661df5xiR9TWXESar0u/w=@vger.kernel.org
X-Gm-Message-State: AFuF++nyedcOVjyxPJW7ibj/9lc0z6EZt7CMmSpTQa+O4m95B3wfZEUC
	H8gIS76W7dFsPwSQGyH4IfCQC+JL0MntvRyCpG0Yw/7ffBx1bYd6nnC7Enyjqskkj6uKJIPGXZ2
	NRqvGFBcYUCj2iOv4M5w8rJO9csEYFdYtybxBakla0pNL9EGPCx/KhxIqzjl4vsXc3eU=
X-Gm-Gg: AYBFou2OKQ7POvUE3Mi/a63DLgCZtIktCzqvDC7JqtobxWSdtKHeIfZyTxnvm4U3M93
	jiajRkqCeuyIGnnYaFPZIfeIv5U6vvYd0lwDDG6arul/+cCQVW0lhC81vOr4m94ec0O9vvPeXkR
	MzDGHNTMjaMMSrIaXolYadlzUO6gobRmkq2rnRdRPManI6cNFYN/WQoiO2h2k1EQAAecQMEJ8kq
	ojzHPMWMFCtflFWaAjEj966kt2M0QrsnCj0ssvjcaarWJHEhcKI4dghsW/E+eOZefkjTFjQFkYb
	SqheVilizcBCUR1Teta++3ZK6YVo2PAFQIKePGcnZQn+DUn6LWfA+08cIlS6rcdGXI1psmBww9l
	F3y3o5ApvZsLMGlDOAW0hLE8=
X-Received: by 2002:a05:620a:371e:b0:939:9eb4:888a with SMTP id af79cd13be357-939ea0e3a2dmr446671785a.1.1789122586349;
        Fri, 11 Sep 2026 03:29:46 -0700 (PDT)
X-Received: by 2002:a05:620a:371e:b0:939:9eb4:888a with SMTP id af79cd13be357-939ea0e3a2dmr446668785a.1.1789122585913;
        Fri, 11 Sep 2026 03:29:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:29:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 0/7] drm/msm/hdmi: Fixes/Cleanups before Eliza
Date: Fri, 11 Sep 2026 12:29:33 +0200
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OywrCMBAF0F+RrJ0S6yOpK/9DXKSTqY2YRjNt8
 UH/3bRuXAi6GbhwOXeegik6YrGdPUWk3rELTQqr+UxgbZojgbMpi1zmG1lIBTZ68Oyhtt5B5W7
 EUFIVIgGd3cMAFiWqhV5bvUKRlEukqZWQ/eGduStPhO3Ijo3acRvifXqhz8fe/2t9DhJKWSisF
 mRQqV1gzq6dOWPwPktHjKP98pPVv9llYi1WulhvtNJovrDDMLwAseCBfD4BAAA=
X-Change-ID: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zVyV2ilpcMf+nszWhvyCe+gkOWrhd/P6l5OHLlMOlM0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gPcy51GU7bRFE5EToHVzUBxULqGv8kxlubX
 TuDC5JqRfaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYDwAKCRDBN2bmhouD
 15e2EACS16tYVCLZcrSDQ0/SfPgwZwxD38wJiC1ZlZC4/pgoL/e6/XKYqKR27hk8XVRUZF2y+Jk
 /LrvqNTbuha2EKR0kYQ+kE9MfCgCXzufYJkac5Swe+RYh8FCZSuU+8h6UZ9IW6KltlCMC/NIfjG
 kpCAJy4JrSNjdQq3LiBih5ajOeExlSd2M2Vjm2OzlRdN4RQ1X31kNzBTKlWpkAVSmIqPIa+jIEP
 RnSExpzvD4VSrNVzF5k9At7PUUwZ9SI88q+l2DH/fkfQU4qbcMIpzN72s+fY6IJ7y7obpFphSj5
 NrAPpvsuIl/kTCsAa+YmeWAXM64sdj0nWPTyH/RSd9aNeW1Kd2gvXU5X5Zv5INsRMIK4EFR6s8E
 J/2neSTM1fc9om5rCAXOEr6KlewMtRnv9PLN5JF9KHlzCaLnOcvSkgGQB4X5UX9/xzjjhNsuWVm
 jw50/smyM6on6ZXHwi4zVIzGMWaIBYTxvaJ/SFEgy92kqxfUNXLXYRHXotoLTcVaruUyKnYqk49
 1i+jgGcCxXyQO1kSDUn82GT1pw0KG9LH3kH50Iu5+3N3gWXvedpd0k66nj2QbcByP2fQRGEoi5c
 JrKE8+nvupnz6Dl2W+QISW9ausk6P6ZVulScS8UFBg7hzRG14TLckIRjeTzAZU7yPrhlKqxtbXq
 t4QABYmSb1AqLTg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: q6zHIdeqEdGLFreIxRQQrh6uBiwaKfyH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX5qG1LueE+kYX
 aMA1shK+beh92YSPXnijOuyLavIrY+ElGJSsE1jxG7qpCBsqXYtqn+ajbyB0ABrwHLArxILBYiR
 z+MzWoKvHKJfZcySimlBu2UFe3SrflkhuGYQYYoGT0Pagg8vCPC4s9dRNL9AbMnsLrgqQDnh+ta
 ta65UzVCEcpjQZPopM2k1TKgOXMG21o0Mob/ssKk4VPEfYKBQWho2vOhNOE2yZTFj1bzrINAQl+
 d/8cNmm8UlPNahlQDTiFJKR5MlJLHiXURMQ+b/tzexilh8TpQuE0McJt2SBoxb+7rtHZt7Bih0D
 f0Y/2Oh4iwpid0i6eGKzVYfl9+cNeOn0Ku90cNA5WCZo74XUi4AnG2m+rHOjC62xGFUWLb9RNVO
 1XoRV54XcUNR+d7fFi7XzSq1kCcGZ/zYHB33eUxeeQNPhOi2VMp/COERmhLR3AS+DSTtJAEa5WV
 Lmgk2WZplj0SxFvpzsg==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa3d81b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LgtYtgaKtWELOkpzEYEA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX9as2YoQq206L
 OZ+pdTVOk4TopuREbXxFhA78wu2d0G1BW/ldb9lRb5u1M8LFZn3oD77vtlVJSTHWhG6Mq/BVNaq
 trBFUNYCcZG/Xa1/0WvEb1O3M11z6Qk=
X-Proofpoint-ORIG-GUID: q6zHIdeqEdGLFreIxRQQrh6uBiwaKfyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110146

Changes in v4:
- Fix second name in "Properly handle msm_ioremap() without name"
- Tags
- Link to v3: https://patch.msgid.link/20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com

Changes in v3:
- Add missing regulator_bulk_disable() in msm_hdmi_phy_resource_enable()
- Set hdmi->power_off=false before calling msm_hdmi_audio_update()
- Link to v2: https://patch.msgid.link/20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com

Split from Eliza patchset, thus `b4 diff` won't exactly work.
v1:
https://lore.kernel.org/all/20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com/

Changes since v1:
1. New patches:
   drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
   drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
   drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

2. Patch #5: use simpler ?:

3. Add tags.

---
Krzysztof Kozlowski (7):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi_bridge: Drop redundant initialization in msm_hdmi_bridge_init()
      drm/msm: Properly handle msm_ioremap() without name
      drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

 .../devicetree/bindings/display/msm/hdmi.yaml      |  4 +--
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             | 34 +++++++++++++++-------
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                | 16 ++++++++--
 drivers/gpu/drm/msm/msm_io_utils.c                 |  6 ++--
 5 files changed, 44 insertions(+), 18 deletions(-)
---
base-commit: 6e95d4043b2c59f1887fd72d1620b7fd3d3138a5
change-id: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

