Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419839B959
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851462; cv=none; b=JN/453aefc7evlhTIffL0eqQGDczWlRrsEbWD/0d00oLzpvMA5zst3ebIo4kHJWWrex0O8Lwt60MQev5ch/LM4ub1JSBmLb+FBbLfq3Qs4xfDv56YSVat7zSC4fpLZDI22rI7XGs/sV8PGdwmJzkdX6KM4fQF+4gdrcoKF43SNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851462; c=relaxed/simple;
	bh=ZG093MO2ef10q/LWPvFaNq71LX74/rGkq31nYz5GUvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHCKckL6xpAEeiWgxOtvOLhCTiw5KpGbJrUuoT8/wXJDtjg/S1lw/ncR9/QM2YeqiwBAyRKP14Br+9XQc2C7VHbwZ4QRfoJl4KDWufnwquTi5z8Y4r79S+bNX2KL7X3ttf7L4yuxYviD7go9HAztESY3L0FPMR9zjBNCo5TIvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d01t0aLc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H5VO5JOI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d01t0aLc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H5VO5JOI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Lm6s1645953
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 07:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=; b=d01t0aLckEBoXC7j
	nxjktvZpRydcpmhlamcAjJTIc3W4sje0zKN52B91cYt4i9cBIBwPOuyyPI0GeQe/
	x68hWIoJA8heF0tVkI4RC+D1Vv2KelJ9xixSL1YHMvj0OcW/MfyrpfmOnWEvyJkB
	WGJmu8isy1wRKn6guD51kZDb55xEI/xq6nYMnL+AEznwlZObGBh3mNa07xBWgYkl
	uPCZGtOPrVVvM3xai32j8q6jAgdw3b4q6usiOQjRoB+vQ89Sq8tb+3ZOKJ9nSe8d
	F6RmogpBPWzNNQ7EyH9pAHDi43IwOisAUoDjR++LLIz5NRFMDUXZ2LdCW/SgFoC1
	TcN4tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvug7p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 07:10:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so677322285a.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788851459; x=1789456259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
        b=H5VO5JOIEyQ/p8MW0ZxmB0N9CHD5JBHNzOcAf53DC8mWQ/FBRvVfDzBJBNNyczfnM2
         dmf6euZYi5QExEhxFhpmcysOxqV/vzi6fHIVF+nuTSiVwhduOf0L7xXmF4z5dazeNMlY
         V1qOAzlZRVCoeUEiPLQItq6BU5eCfSlV091xTZOpTpLGtOM0TPfOKEPBu25jkM5QkGu5
         Z+Q2Tc/G3PHHSgVxm6tfJlmvBRUhRwg7yw3E/PS8FEHqFg5RKlKSkftV5+qmx9//IW38
         pHQdv4oucX/iGFONAIhjR+10X0+3qgB+tydtt5EewAdjgR/uoNjFXQ4/vL/Jp3dbqmbj
         bftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851459; x=1789456259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
        b=FQWuLoqVxcIzHTWcZeOYRLcwG1IR8J0PkWHaTT8Gr9xqaSOL6bhNuZAxNMbAjskDVE
         18cvjjISs627Ku/2+JIfRVPienUQhDhnfwHSc/oPmNTNwETA2Qdek2VMMQpKfe7m9lrn
         HKv55ebbrbWBNbq6/jmrjRMgBuznKuLIT0m4Np74FQDsnLhvvjp3vDTyB5kw2Xoitpil
         KilD6zS+K04yHx5N+d5QSBvnn0CSQi85V6iLtff+DyRJcsox5sGgSItlPQuGbMCPW0pD
         X7/l14tUMbScoZQ2k7vw5dTj5SZPKD9bV4tVCWZnK3Vu7i01n9uP5iE/cbPG3n7xiEb4
         foqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw6LwqhJE7cdAC23+CCRaPxrdHVCDF0IITDD2YPUbahFP4sKNK+mfkVJsHcOnioK9c2IEZ/ns=@vger.kernel.org
X-Gm-Message-State: AFuF++kES9/Wn/W5o7L0leBmuRFuQkDcSjEBhVYn650kEH2WJLVpaO3k
	Ulb4dWo5xWjnuYS7ziSUlIoQQIg5osdRMZAwvdg4iJVYl1ANZYuF2TT9iPTUe/d+AHX7hAGLCkq
	fWYWt/AUV4Wo7tcZVRl0ZYicaSP6JGe6BqcPaLvvrilyPDmymXOGmAzHGpvc=
X-Gm-Gg: AYBFou0vfSjVXHMV4Quywp7UJ+9ZcjYy5wBf0eBTXSMpkiStPUac6heCak/wSkRKTAT
	DDuSBOJAOaphPGzLoyS5TtZQ0yjgOJfTopobnIHvsNBo7h60q2n2fQ8nyaRmZhnTDgJ+VUUqmmt
	O43RlfjNQfsefrFSnxgTPdBKbzWXivRgaFz+NrISvhz1snR09NZTDmgC7xhN4bmvb2C9fZAIewF
	EpDXEBBzliMmdS0ibAxtkcHmc70EH6BDgUfGsRnShRQTqxvaHqT5iL65DkbyT51hj+6hk6J8lnA
	fxmh3JoDcUoRQhLbc6U9vo2qiFCk+EmAmN1NSjt9hbCJwEFu+DH2sWc5XHf/UzObyThGoqbaE8m
	bocQdsIPgxFIwBunNenlSc4I=
X-Received: by 2002:a05:620a:3707:b0:939:ab90:8f6a with SMTP id af79cd13be357-939ab908fd9mr1195392485a.18.1788851458759;
        Tue, 08 Sep 2026 00:10:58 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:939:ab90:8f6a with SMTP id af79cd13be357-939ab908fd9mr1195388985a.18.1788851458361;
        Tue, 08 Sep 2026 00:10:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:10:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:41 +0200
Subject: [PATCH v3 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-1-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZG093MO2ef10q/LWPvFaNq71LX74/rGkq31nYz5GUvY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T3vtS3HqWXUdSsiVISeU47Im6ROW1p5A6Fk
 05xiUy9rpSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+09wAKCRDBN2bmhouD
 114AEACRO7SvCxub/ywNPr/vKZhyFhbU2JGDgp/FmhNnXiUs5W0/MpyTWB4t9M0ZLv1B1KKWqxU
 6cIujtV0TMmQv0UOUoNqd48IREUrMtK8loR+ocxNUeetJ4OrYGG1APFlVT3Y5fyfZtAT13tHDDY
 GS7PLrdz9xI8IjU0ctGea9dQg4KXS0A3gJq+bNlan7j/O0NR5nIonwMLM6TIU4joM10NR7flK/t
 owfigDxvRpBr1EwTuDHi3tcLjJAxKWhnyVE0U+NOvKVEF5us5Z/v2EPv76A1suO1QDV4IZYvaks
 E/zgnXRFI4bNDnNXpDsglIQBNACSK1OtWVP30eGoSi9v2ZkGwc2LoU0GtYRG7xa+NDVs1iIZ0AH
 aWqjDV1EoJfgcYsxZNZrQ6cw5uHFbiz8LFNXRsm1CyI+HCGThYI9b+x5pqJiKCtYhtkTolcRqFg
 S6TplqNWUYXsKOlhRlBqzLKPzPcqtgO4a9U4XP/bVD7X/whtZCvW6U7RKoXJrANsmRTMPrsVocz
 7/msBWD7N82wzP3dlOYnKFvPOvS0vovO8yYNcjCSyZka1mkX4yP1mIRAFdU0CEtnc1jwbyt0LYs
 5KD1cOlPg+2B5fC7ZuWtUiMbLVXt9BOjMPV30OCg99Qi0BgFI2MYvWDNVrwWZXr+Tir/3RAxN+Y
 LkgdcouDjYxwaTQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6a9fb503 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: iAjwMagVy-n18Ff0BgFsJzgMAjqAQp2c
X-Proofpoint-ORIG-GUID: iAjwMagVy-n18Ff0BgFsJzgMAjqAQp2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX3NtXQdhfo3zo
 L8I8iFIDZEFwKBmPQmGP/7mEO1TTiIdwHGK5P6y1vs9YtICPh/hEkvLWqywhrnjgMvQCEabl0pD
 SLfsFJ7I014FUknu8Cd9ByELOgDW73T8JaIenU1M/eYCuXk6w6nX1z95ef4axnzXTnpmaTogeIn
 ySZvNG5+30VZXqSVGGBM7MkCNae1dgTHrbuU6L7NJyzzmUz7YLe98mwQwKV+chbYXjHdKNoDUN8
 8gFUWxebjfR0ooAOnIsjwZgSYP7VtwtcbHOqdZbERsoQlVayHbXccGYpwZRYktFV+zjNoTEyU/d
 EQZIMlOrNJN5Jwxif8unrIJGxWndapc5oj5ZlU1Jqj8+4eKWYWRVL5oEswnMu+X2CsRdBTCgjk6
 qa37/grYvuCeMUetezBqYic/qc6McfKaOEq3ioGvkiSifdTFvdTrXpqVTlrCMzIKHaYhwSWGDEc
 01+xiwd+rAKgUR4sl2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX/aiW+O7R8h84
 vx4l97vNDushKcK2LHVQn+O1kh84YCqVJPBNNdaRYP1JMf8YDHqnFS7IVm/jn9a3+WGLggarkka
 jGwynFk/McBb3u1Nx6PT7mMLnByJ8k8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..15e37596bdb1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
-		return ret;
+		goto err_pm_put;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
 		ret = clk_prepare_enable(phy->clks[i]);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
 				cfg->clk_names[i], ret);
+			goto err_clk_unprepare;
+		}
 	}
 
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(phy->clks[i - 1]);
+	regulator_bulk_disable(cfg->num_regs, phy->regs);
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 

-- 
2.53.0

