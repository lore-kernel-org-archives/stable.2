Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2684CC272
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786047; cv=none; b=mdF429kiPHsS66g1g9aRG9Mnk/WwQSXeB0gxKWIvEyEpUKWVy45SMT5DIBft6SSEvkPNNaJ0POjVPNRWnha+0nkaUemhNLvvbxwxiRyE2b6QkP9/cQc2j523cRZix/vUTwK+i5MzuRjFmWnPcYWp9egmLPFwK3nVZgcC3O9kj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786047; c=relaxed/simple;
	bh=gCPjQLee8IZ6ZI1o3PKvV9FFsQQqDDwLDIvAlHVSnmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6fSAaygYj8yeKgC3oR2ab4OOq8f0J7AEZ0A7cXZ2dLhm/aB9xnScRB3iJ5wehhy1rPhRXEWfAYNiRbXxBe1y1W1A7xMUN3VuRwZNejoNBsaf2Mh8U1Kq75IH8sNg+Og003KR0kQ7zwf0wWxGyPgh4p2MV8R9BPzAaFJZ+jIhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=larfk0Wl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dEuXZiim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="larfk0Wl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEuXZiim"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnAZ34064241
	for <stable@vger.kernel.org>; Mon, 7 Sep 2026 13:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=; b=larfk0WlpEup5H3m
	Ee/0P6ULDeJf8uBNe18+jf18aEKhu9xGfIFxIttialr25DSZEavIL/551vZ+uQaC
	OwZkD8yPg4ifSq+CuBuLFWbu4ShJZJL0YErS8nT3JsBzyo+uJppopbv16l8ZdCfx
	d1X2nHP3uiglbrC09FSelq8LJEHPGUEFbl6oMDgZ7PpJDOpie9rBIA+p6W3LoPo7
	ptfIvNap0Ql4lPEzqHzptAWl988S07yxFFTTLxvyiI8yX1sk0NIKQZucN2ttjHKn
	PAMYo9Lgmt/bu6poZlLRhwWd/MRH8IvLEW8yiea2kA+wp9C1ziZKcrxoyOiEhXFM
	JVWMsA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86s9ga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 13:00:37 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97cb2f3c6f7so289178241.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788786037; x=1789390837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
        b=dEuXZiimvydS46TF++eIje/CG4MaS/xRtTZkB6Zai11uz7Ia2ML1MDb6NimiWJvIH3
         DLN+H1gpgN9kgpMo35Hj1JwcYlRWNdrr+b4NjZel9mVvhopTKUSRAAJ3WqAkpRe1ggH7
         gXAhFr7yGP2L7XNdo8Uwz0CTM8auuHeJD1fLzHuqeywpeCFKHcf4ERSWzHcxdbAttOP+
         cjvwdVkDPfdbKkPPEqrU4N+8Qt6WMy7Qqcm8FkAsWJwyzhOPSjADbM9KgkfWCug3wq+3
         /oYKxAS3WN4kiTvk4DX+HGhLM8iEBbzjfuF/p5zi4WY0T6knb65Q+QV1UDxR4TTphCKf
         mhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786037; x=1789390837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
        b=aYV9I+uvQ4dAl5TeudPD/yPeoFVRcUrz//3miFuHI7Gu43FAItoPR9ELnVcNWO2OcM
         WaUmAGc01moe0tbmnEmV/7S69h1I25Wif6KMdf7SB9NFc93D9veeuf32WKFUc9fy5y4V
         Jf4j1QsOYzhoQj3GXuLh7+wT5+6trlVh3ImUpn8qR219jXI6YWwaRLqvrcrVHgromWLU
         TxRGj4t6cbiXRCryj6qdq6T8yJC51i7+TUm7piJwRhE4Y81gfNapMumAWj+VRxpeDXc6
         mFwglZzQAJ1C/+ZmFv590Y0BAAwP2HCmletwIzQiYSWJcgJGw4/H/BDczSQdIS3FliXl
         yg4A==
X-Forwarded-Encrypted: i=1; AKwUvBwfHj/XhXmyCCvi+gIlNWaFo7j6355QePTNv7/xYKkFTZKfOEjQYFU3AWQFhD6bVy3TA5GJN3c=@vger.kernel.org
X-Gm-Message-State: AFuF++lJmzsHlD0aprqcTO1NynwWVqAu43bKJmMxKhcLhtHBO3S2lBd9
	OyacaIJUQnrr+m3svHKzo4v0Q9D86b/3uzAn5SWBkIjPEt+YEaByEnotBxvct1jlGTe8YESVZDL
	BZu2cQG5UJJmyObdI4PfMHbdIhjSAc70ZidMSzAhHY2uVSMupH+G3973yUTM=
X-Gm-Gg: AYBFou03pGhsGgJhDlgDAq8mg/g2ovxSQKBZuoTTn0YqDc025hP4pnMVNqcRkOYge4r
	veWLHe8GVQthSUo0+WVDIozhSPOzbtRcm6D7PSKGq+XbCgSHlNYxY6oicGefwU1dY30+2V6C/Ol
	UoTQW+nAOhwruKzo3gNeCPtvShVkVrpOnMIFuUlWecjRYPhijPF+ZNARwOS9JXp9IhvOo2upiE3
	uATFvTeoHtdvQqEaIoIwqBa5F3zSvd2eiLNPbqN4EbaqaqSuLgFwZWkaxxglLNMp7lfoT1GwhJP
	gzxAy8xPqtV7Pphq2/BYHdKTSF9yNZe6sMwue79h9no1dfbVqduR5DNDGqh36Rs5ZxwhzsmcwcW
	AJo4qEwgjuWil7ubcCzJPo6E=
X-Received: by 2002:a05:6102:5091:b0:78a:8a0:7126 with SMTP id ada2fe7eead31-78a4aa97d5bmr6957342137.10.1788786036780;
        Mon, 07 Sep 2026 06:00:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:78a:8a0:7126 with SMTP id ada2fe7eead31-78a4aa97d5bmr6957293137.10.1788786036018;
        Mon, 07 Sep 2026 06:00:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:00:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:16 +0200
Subject: [PATCH v2 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-2-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gCPjQLee8IZ6ZI1o3PKvV9FFsQQqDDwLDIvAlHVSnmc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVl5qXohDCURU+NBjhbzxqePcwXPR42atlwW
 MKZXfnzXIqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZQAKCRDBN2bmhouD
 13MLD/499ImyZNhv8KqXl37bfiQdgVu9Me30Y0fF1ckmJODd9Kkx2yUhO9VjmaeT7PgdxTDZzxu
 flb9jXTKAnkw0NGD1hd42UsH1Qkh1qJ6oD9EyqdPFwt2U/jhZFYCrA4O6GQiqAgjrgtHKOxx/HX
 f4QQ/+6h4ALMYtMDlSboskVDJy/L3QNA/hVVqhhp6qv+6Uoo932d8kCe88jVAbvrtxRfls/nO7z
 oR/mIRFUIJ9ly1p/4DTJgWgWADs/cIQAw5uBUszxsg+jvJkK9quTp7cJ7a5nXqoehBajDaj+SpI
 HMQKNWX7WfkQoMyUNGRmt71fAOvRb9xbfU9YUnhg7MpH1KANwJWU6XlKzhKnKFs92lz+Tky7MYz
 wjI9BTQ30YdhpON4qjuotYrA1JMnmobv4lpY4ODuTqxndsik8+AYPtMRB/q8R6xTHvhHbhM0cim
 UnnvfML8SJdnU1nkbl8KKH69Xj9FxIy5ztYtzng8ys7YQfXZ0hxtMKw747WPyGPdrI9JwYr1zDa
 hbhVIiTLQ6DitBSoGJRCXcU8up8kDjabFU/OpK4vAt8M6DkjH8/w9mYhT7dnGbX3a0gsqAqvxXm
 qJL3p/bK1iZivrvdLFe6O1r5cwRor9QBOxn2kF2DCx/hA2vjSDDYRKBOPDoyiLo3I7IsJSOYWEb
 QgNRexijnPWjaaA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: fec9V3GPWQzzaYs360ZZqwHdsQu0ba3f
X-Proofpoint-ORIG-GUID: fec9V3GPWQzzaYs360ZZqwHdsQu0ba3f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXw93o8EP0+3oA
 mpc+b7lHZ9PQ4UsnDL90oqo2GRcoMzgYigo1qxDRkJ2vtrbPB7bIohMoVFeq4YR/fUTyxhoehE4
 93BQVWtcJNrEkj2DTXuJjwYgAY90ohc=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9eb575 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IzbfGf_HrtPdoiX6LZ8A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX4vzmA0RjZjLf
 osvVCuypz3AB3P5cNY2eMF50y94sB5wO/05hAZkCvBYLFcKeKEhwwxnyJF/ue3IEGH3894saLs/
 eedKynu5bwZWhFGMmNV/Dyel2esWImRWZvxMxG+VjOZt5yPyH0N4P0JN5SuBH8CfpQhvgNs2oLL
 FfUgGvdG1MFT7GedPfzqLcmzYJA0hyxUsMhbOAYB5inlOLrHb7RDdLjoslov4+cdWaF6jKzK41O
 PXTwQpt7+c0sG8BhO1Hxx2lNlU952yi2EsMaY/JSheGGxqXfyIduMngpHYCBvL0iFJp3XIHSdOi
 NsWxUKB24iSrZ7fTqE95b4v9nird5UZfTZakyZiNDK4Z4LhysfbHXGyTPHpzw+QxQ1VFrUkYys6
 xJ9FMmGs0jbCLnwSjs5E7A6UlIUiQRM3f5QJGXfCBGrs06DIBTtQgd/PA/8ojNO5PDAZOfRGvIF
 xnKdFwfFXPXh8OaQtSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143

Properly handle power up failures during .atomic_pre_enable() by
aborting the .atomic_pre_enable() to avoid accessing registers why
blocks did not bring up.  Otherwise this could lead to imprecise aborts
when accessing MMIO while entire power domain is off.

Cc: <stable@vger.kernel.org>
Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 157f19bd90b4..db85400e574e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -13,14 +13,16 @@
 #include "msm_kms.h"
 #include "hdmi.h"
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	int ret;
 
-	pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		return ret;
 
 	if (hdmi->extp_clk) {
 		DBG("pixclock: %lu", hdmi->pixclock);
@@ -29,9 +31,14 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 			DRM_DEV_ERROR(dev->dev, "failed to set extp clk rate: %d\n", ret);
 
 		ret = clk_prepare_enable(hdmi->extp_clk);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable extp clk: %d\n", ret);
+			pm_runtime_put(&hdmi->pdev->dev);
+			return ret;
+		}
 	}
+
+	return 0;
 }
 
 static void power_off(struct drm_bridge *bridge)
@@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
 
-	mutex_lock(&hdmi->state_mutex);
-	if (!hdmi->power_on) {
-		msm_hdmi_phy_resource_enable(phy);
-		msm_hdmi_power_on(bridge);
-		hdmi->power_on = true;
+	scoped_guard(mutex, &hdmi->state_mutex) {
+		if (!hdmi->power_on) {
+			if (msm_hdmi_phy_resource_enable(phy))
+				return;
+
+			if (msm_hdmi_power_on(bridge)) {
+				msm_hdmi_phy_resource_disable(phy);
+				return;
+			}
+			hdmi->power_on = true;
+		}
 	}
-	mutex_unlock(&hdmi->state_mutex);
 
 	if (connector->display_info.is_hdmi)
 		msm_hdmi_audio_update(hdmi);

-- 
2.53.0

