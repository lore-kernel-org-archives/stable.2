Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AE43F8D9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122596; cv=none; b=Y0KpeoqUGq7eBtEDN7aP9kdwkT9JNpk4UdUxsH1sFUYS/LRDz6i6mQhCkH2ljNpLeTDpqa/k7YndxWCRZ2n/6xgvGHfme3e9f3xCiLHNqUfqI3/BUORcaEy0fvOTUyDaqMcbzjqT/pxG9zAAXUpKn1QgvRSjcAKazggU8B03P/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122596; c=relaxed/simple;
	bh=gCPjQLee8IZ6ZI1o3PKvV9FFsQQqDDwLDIvAlHVSnmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+XIyM4LVQSjce3K6hxcT8jDhUbnQN7xwviJIsU/nffg90qYAWAKseeCNotAK3CRoEi5EfvUuhStRmsVQLCnlokUWVwK5lfQivK6qVThiqW6n0O6ITMKlti2H+xE35icVlFI0F217B56908lUQkjzlioznRxek65mcu8mLX8Lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJ7JxI8d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIRzgTLG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJ7JxI8d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIRzgTLG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7l17D144103
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=; b=DJ7JxI8d/CYTDOCk
	h3XPeU/Vt9kTF0Ban3/fyGI8v+8G3Ee99q4z4RXS0tKm3WnjI0dzL8fUL/ywhviu
	ceS8k8+WpGiC3/TrOHnI6w6HAztiA1kBTFarjVYYW1HjGsMG6eAvg30r8TLwZDjv
	8DC9KkWrsExoIaZsmM5bmhwmMO8nqr3JJwW6kjlvhV7P6cicnQvfAfONQlfTBaYG
	qV8FZAgSecDP/M2XUJy4CQg2Xu5cDHxxJ6yJKVQxBN5DOrrpDKmWb1I0iHrFS/jh
	Nv19OELvmyYg9z/hrtFHX3zyVu6MO5p0ouzwNOEe+b5Q2tXWuSh32KSxP9b5aDgs
	uQ+UlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd396tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939a00c45easo118705785a.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122592; x=1789727392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
        b=GIRzgTLG7AsA9tgUdicb6n0hiGtPu2uzBhyV4Tg7HJkJWO9KrtucEUmG4yS9M59Yhf
         9uXQzCXVTZ0bObmTiSXygVgj1PO231RH/7BZdNYVj8mNrONzptRnkgQ/Mbe/fK52Hj75
         qa/G+fsD+9zzirfPSAE2NtOfG2yyI3EOFxM3gVHuGyZKylfyM6/wfCXLIuu3TzZO0buS
         K4IgTM8UzOaPI1+P+fySaqqFIHBwuK/qcc5SiC1JvsgRS1w2OhTipvpH913HMiAGdS9r
         2wG9KkCBhoglOSKTc+ZSfwji8PP+gTG7UruItpmlRgwa6WHvr4+jNwp2DGr0X1D5KCrQ
         vMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122592; x=1789727392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
        b=ZY0+nZ1Nq2v5NPpWC+Vpfco+zjqNOBMGAeMYT6maTBIS4zwNCxFNL45ltwbE33SBa9
         YHCGVAribCiF69vEn0uZJm46Ouu/ZVwI/Qj/SlLiNx/uzWooVeCuP3XcgMjUbLG/fGqe
         ZjpEAxfDmmwp7NP6t+F32F5fGtD0wfPW/5TXvc7NTa3QhabM7fQp1qg5oy3ErOeSkD6b
         XIzKVgChLnPX4kkqczYi1b5CElZbv/X7cQayiK0rwWripBur6dKT71++hOYViDV5ukfj
         XG9EgY/dTkGlQfi6NNOkfpsq5+chcVHGcFOD1TYF2F9cpUwl84MHKxDN8jBZtNMieEcU
         2yQw==
X-Forwarded-Encrypted: i=1; AKwUvBwJZHUZvMakziXsO7KlHEfgwp4NVZh0yXwMrFq//hZ70eoHIWk4S7fJipeikrzgv3cHi6nyJP0=@vger.kernel.org
X-Gm-Message-State: AFuF++mCtoFIqe4lDff6u00UvcH6FdGOVe4U/cW+8Wlr7yKGkJcr4vDx
	8mKnOVNZftLlOzXEB0ytYR4ADJkljNKJlyvUS2iG1X28OcWfvHHfSJYESfww221Jupl594o6axl
	F0JCtDMwQq/ALsbwlVXmQtcBuInoav2YQrsa9cfkSc+AIj/ndx46ts0zEzfk=
X-Gm-Gg: AYBFou1TuZifXJ06uDCurIaJAjMjCTY5u+XFki3pTxYlfEhFmXcATzFiVIv524dBHD4
	zlzi5zB24BYUx9XJUrQfoBI5lD1D3gyG6xeFYiFvSeS4tC2oZxUFmD5N+jaS0KLmlPNTN89XI5G
	q0U+bdJD+ztrbj/x5MKNv6CAnw9DPKb3oEBQUsUzzBmcs3XnKyi6NZTNh0c+HDKVu8Zixbj3eiT
	jAK0l0p1hKKauRE6M6HsDJ6jrzgpfO/GQQL6hY+ZHPqz5pPfPlSsj+rmPkETc4MLboGyKoV2+dF
	h1B44f2eZvwJR7rcSqRTLFUa2T/vNVoLjS37CnC+d/TXr+s2+RUMYT7/mbTx39VH34oDKLtnl3P
	WqALmOFyG5NSPS9/i4QIVwMc=
X-Received: by 2002:a05:620a:17a8:b0:939:9a09:6009 with SMTP id af79cd13be357-939ea22929amr417775285a.33.1789122592233;
        Fri, 11 Sep 2026 03:29:52 -0700 (PDT)
X-Received: by 2002:a05:620a:17a8:b0:939:9a09:6009 with SMTP id af79cd13be357-939ea22929amr417771685a.33.1789122591779;
        Fri, 11 Sep 2026 03:29:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:29:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:35 +0200
Subject: [PATCH v4 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gRkXjI/OEtozReZDeGIxNSRVYnBNLuVDYf2
 /ZVngtGyFeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEQAKCRDBN2bmhouD
 16cRD/sG7tWVhlh4K+dM3uTjagd7MjwoUd5+LK3+h748V4YfkAkWQ1KjKU0zdiH149YAjT5unRr
 d276FHxWWUtKrbYBnYO6VgdTVxNpLtJgIQ7z6XxkC0L63AgIwRcbybPe9JmZCxAe0iKa010yYUO
 R2HqvL3s93pOmGYGJpTS0Mprn7vXJW6MOMaeEG3hMjo9QIV7+2q+ghbzHFt8C0Xrf6UqpqX57ev
 e/GTTTWuSw5yxLDp6T1/CKjGdIByxbbli8F3yGkr13Cd7uEJGavLV78Tn8pLIU9jXpFxNZNyg5X
 any0DeWtC6WMNi+pUaHvAV1HDPMW35bwN7tNWEhVVw//mZrSjyo4aFRZ2ppTmt9eZQCG2yqf39G
 fttE5Mhlg/bTuQSMMFkJsJR09QhXkFYm9AAU9HItikZxropRdK9CG30pisSAIpJWJGAi/ZAoUl/
 CyVEvpvjOIJUZySzFdGdptEpCQUYdeASISLYjgbG0iydLDAjMLc0x1uW5qhLVPg2TMQHE+0ccVX
 opoRAbJw2ykVwTOpf01GE8HJWA6WwAfyg1+mTfnZjWmYIOUgjxtzk/aLFnEozHTB2beRJIdEsAP
 L0W/XGgb9kYUpha1Lg6al1zfrJILjxyhvLOA4dG8LQVrS6EaSJgiXt4hLMlVu5HXVilf98cIWFS
 hDCRNBJPVxaMpZA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa3d821 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IzbfGf_HrtPdoiX6LZ8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 4jrMZHyHiIltO_OcVaqX1Ub3OeMuaTen
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX06a80PRAG30R
 VTlrx7WwYGGbd/YLy4Xo/WMTyUXs9Rkg6rlbilTeDtd8D/mjaP0t0NH0YAfA77LPVjDC4BCShQX
 oECBhizsqHNrUPh7LC6gKeG0jJV5V8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX/y1xyGGMNkWy
 FynVwjmwg5gbaiF0NpWbEESEstIbxx7Kh1NGCfB7CszbmR9LCb64VNwcJZx5NlnaFRYn9QiJ9aw
 FXXOc+V8QeQtp9X87B0l+7IYV9uTtSPbNBjZQnhV3bxPIm6+3TGsr1L+erQ0B20744hTHPb207/
 +qHiTJhXVz5/U2DANSk4yfJpQtHEnm7MIvxBrq/HGbdeqkkKFt+0sobx/01+VmGDHjHuHLEYP+a
 RBeZpaqlHvF5E3MQAFaLaf1MRsERITkikKdGSSpYgKzisxCe5UPrItw1gVjVfDhpp6rlawZYr0t
 Lif6l8wuP9WiOtBm6lVex7fAWA8A3/2x3z0c3hflvuKT2rLSjPVRuPUH2ks71MZytxmqLFCrFwR
 xKWeDtqyWZGJXHu7K4aQVQmb4bErLJSFa3HeCq6FCmXRWfEQK5Dq2UkSbD2xGjJl0mte2eDKdQq
 kzJoZ0JaAXy+oVVLqdQ==
X-Proofpoint-ORIG-GUID: 4jrMZHyHiIltO_OcVaqX1Ub3OeMuaTen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110146

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

