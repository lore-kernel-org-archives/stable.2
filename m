Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048220;
	b=GeqAXbDAe7mrpICLmfEy+PyaFkycW0BIO9MRV+oiPjlJnzXS5n3OY7rHkZp2elLjaAQb
	 J/74af/D+rDkHCGwbzymA0Pm23dP/O5dO2+M4L/pQj++C1K75GbODvGbWEBRLqRTDLRFN
	 u1RTFZ61CRaBU5sGls5zLsaFKg9CBLqYQ16KNUzkOUY0tqODzK14bFEBDBMIBr+aordyL
	 +sZZfN8dvxI5ITEYNJ2nj1iSm/srf72Kb5vH51tp0Ws6GY6qAsqdjS+QZXrSeg2UM+kJ8
	 lrlVd7sTIezBN8X8iehvfLhdCoUlS+/WkuBxT8jcSev0jZu+0gvM193K12uLyrz6EBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048220;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OOXpMGfwiDGgoxnJlRht/qUE0rALpRDzAmBncqyn0wU=;
	b=sWsCHARhHyyMc3WjHgoQ7NX4+7XrXfvIl5zK90Dwq/dYZK8zXZVKZ/JG0tushDdLHS0a
	 dajlL191s0doBzeCH340bOdCybOKFZOjmGoiLZE/LO1dSOf+w84mnpo3G7ZCjj9izNYHJ
	 62qeEEw1zd9kbwz531/tyG5/d7aDzsnMBKyjyDNpHRL8RM8pdm/+ZTFkkIuH9gT6P2C2R
	 kRSe4743D6uNEPjtWKBOEEQav94braEJxlibTprFKnGQAn4dcohvgvG0Vm21AGsKP9W/H
	 FAAc8mR5YDcXniLOKq3FdxTCkJRxPkaoKxjN2G8mqk4VoK35pCp38BKWu0dogs+Xj7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPi6Bf26;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA42606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPi6Bf26
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF30D1F0089F;
	Sat,  7 Nov 2026 10:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048220;
	bh=OOXpMGfwiDGgoxnJlRht/qUE0rALpRDzAmBncqyn0wU=;
	h=From:To:Cc:Subject:Date;
	b=lPi6Bf26Vz9oShQ/yoAR+9BEJxatJkCOu9TE/wbH79QGNFgKqXo+cSDXr8K4gxOBl
	 Jr7qce5mksdTu7oHteVYVH4CUtLBmRbqtpGGICtV09egyWSogWA3jbvp8u8kwlIZxc
	 cyYxRIAW0FRSWFwlLHfPLP1KRMhJf4OWkF+LNCZveuBNR4Pvc9OucsmnWAD9+r9BZ5
	 3+x2pW8nfyV6G6PK6joncLzzij8tcggJ+DuU0g2o0BBdOsTUgMJVsr7mjP/d9ORz1k
	 ObT4tgzzq2dcqMx84Y1mc94pCXoJ0KCQMEceSVU+9aPf0O2FWdBBTFmhW7uzs8v2El
	 bmw3D7BPlnoew==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.kozlowski@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:38 -0500
Message-ID: <20261107054338-failed-6.1-dd6ecace5785@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dd6ecace57851878e62367a6f1a26dd5b9aa217f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054338-failed-6.1-dd6ecace5785@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dd6ecace57851878e62367a6f1a26dd5b9aa217f Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:35 +0200
Subject: [PATCH] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during
 .atomic_pre_enable()

Properly handle power up failures during .atomic_pre_enable() by
aborting the .atomic_pre_enable() to avoid accessing registers why
blocks did not bring up.  Otherwise this could lead to imprecise aborts
when accessing MMIO while entire power domain is off.

Cc: <stable@vger.kernel.org>
Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/752652/
Link: https://lore.kernel.org/r/20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 ++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 157f19bd90b4e..db85400e574e4 100644
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




