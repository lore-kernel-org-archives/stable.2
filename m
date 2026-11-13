Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540320;
	b=cyTP+5efCvAWhdBCPGz+npsvXPXQ+pCKwrM+xCLGlE0LnWq6EAiTGkwQZExF4C/C/klb
	 hEb4cLSDO8qMnoLLJhloInT5vBFXpiGSZ1uVd4JgDVLoQUWgzhEyXgSnJBGY3cQUe8A4A
	 OSm4T3z46VfcjA/Jfgr5uKVYipGpOfLGfge70+q1FRZnHf9tk74EF7hAtEdlj+7SVh6NU
	 j01WgONPps57DzTOFPM7DnoSg3flXxH/jo0cMZON3BxGYBJXKtftZFwmmKXNAxfydlHl+
	 X9eePrcq0DveqB2zgdh7H3CpHX66hX+WwYdsMJhUzO6furyAYy9BH70zGk9szJlY+2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7ua/bssw+dBI0gHb5I7mgser30OX92pxQJI9CvEZWA4=;
	b=yYxE1/67GoNRCkTwZ3HViS9hLTh9MpnVe6Bp2W09xWlGBLCUYkwE2ExP6E0XDx3ZVNbX
	 W9gzQBTiMRDCCfFMXRxt89Wdm7nT1k0B4kerqO8iydhsQR00O5K4H3YC9w2TiTYmWljKU
	 r8GH7GMfSlSkJ6UDmEe63EK60+qCl4bI7YNwqFZa+CqhCDaZ7yetC2+uhRVAHNITDKu6J
	 2Cn8LLVbnk/ESx6Yba5gSLVH3z0qbye7OeK4faIbDgrIpsYbHRsr9p58C19M9fWQkX/mM
	 iyGR28iwdkWDgpk/FWqJqTIuN63ZFPA6/yA3cSHwk+uqsZxcW2VFU4Kl+Lt1sIjWkgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If6zW75x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F4606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If6zW75x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C859A1F000C4;
	Fri, 13 Nov 2026 03:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540320;
	bh=7ua/bssw+dBI0gHb5I7mgser30OX92pxQJI9CvEZWA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=If6zW75xp76yBr7K2fA1GUWc2ILxuzMvGKGLiBH4gSrWPHyJUsFzwCWTgscwo93m1
	 4z2FjOBWBYTL5Gzz4KiRowevj7RwSpUiocipv8JG4BwaUe8sWTuufgcED+cavsX/Qq
	 H0suvQAwJ04XNXMvetSnoqXkNMLZ/9o11rwNVzqKLj8FEnPIAjpmbK966v0w0bcaaG
	 rGiuELzJavkQ3DFNNAxBmWe3/maIQvEAmYklPi5i9prkBy+/r3rmhOdvfixmsdGbTi
	 zi3aykNxcV11HxBeMVD2iGf9L1+ks6tXCaZTN+p2LolfSOMXyx89gU9+8HKq56MLGs
	 Vcs4IermZCGjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
Date: Thu, 12 Nov 2026 22:25:18 -0500
Message-ID: <20261113032455.1016007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053057-failed-6.6-dd6ecace5785@kernel.org>
References: <20261107053057-failed-6.6-dd6ecace5785@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit dd6ecace57851878e62367a6f1a26dd5b9aa217f ]

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
[ sashal: adapted atomic_pre_enable() error handling to the legacy pre_enable() callback with directly managed regulator and clock arrays. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 919dcbd9b06cb..ad6e29d187a9b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -19,7 +19,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *bridge)
 	drm_bridge_remove(bridge);
 }
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
@@ -27,11 +27,15 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 	const struct hdmi_platform_config *config = hdmi->config;
 	int i, ret;
 
-	pm_runtime_get_sync(&hdmi->pdev->dev);
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		return ret;
 
 	ret = regulator_bulk_enable(config->pwr_reg_cnt, hdmi->pwr_regs);
-	if (ret)
+	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to enable pwr regulator: %d\n", ret);
+		goto err_pm_put;
+	}
 
 	if (config->pwr_clk_cnt > 0) {
 		DBG("pixclock: %lu", hdmi->pixclock);
@@ -47,8 +51,19 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable pwr clk: %s (%d)\n",
 					config->pwr_clk_names[i], ret);
+			goto err_clk_disable;
 		}
 	}
+
+	return 0;
+
+err_clk_disable:
+	while (i--)
+		clk_disable_unprepare(hdmi->pwr_clks[i]);
+	regulator_bulk_disable(config->pwr_reg_cnt, hdmi->pwr_regs);
+err_pm_put:
+	pm_runtime_put(&hdmi->pdev->dev);
+	return ret;
 }
 
 static void power_off(struct drm_bridge *bridge)
@@ -143,8 +158,13 @@ static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 	DBG("power up");
 
 	if (!hdmi->power_on) {
-		msm_hdmi_phy_resource_enable(phy);
-		msm_hdmi_power_on(bridge);
+		if (msm_hdmi_phy_resource_enable(phy))
+			return;
+
+		if (msm_hdmi_power_on(bridge)) {
+			msm_hdmi_phy_resource_disable(phy);
+			return;
+		}
 		hdmi->power_on = true;
 		if (hdmi->hdmi_mode) {
 			msm_hdmi_config_avi_infoframe(hdmi);
-- 
2.53.0

