Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539557;
	b=ThnNoZm4JllvDk5qTNWSBw00Mfbr62W2WGf1z2jGSH7FvpSRBGfTWbFP85EJcilf5Vnq
	 IQGwAAeFLjhtgSBhjfHyafa6ABjXjMBn/G0GhhDiL5jgqMvX0ipX6lf9wnIlNrw2uyRYE
	 sy1ivBZJOyLMm1c+F2xdIxkY27G4tTJHeWdq/Zkv3U1tujtGHkK1dRtOvBXwrAIaoDbVl
	 wJ1C+w7WbyWY7N7cr2XL2R6SU0sf8Cmh7SXvY+ZDg6zWH3grx2PnphJ2UMnkVe7Kxpoez
	 crjljphTXDleaqdpKbp86TyWN43l/kRPen5W5MfVM+HRxBRIbF8howc1/x3ZbSF0C7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9tvixEKLvFMwJgIr/SUEMzdCExGp9ojYcq/aJ+ks3dE=;
	b=wiHShc45fNqqC1aGQjXNMW7CMSCoV5rea5Am9bh7VaDLUGSxmbrsRYDm6bL62sLrUYYd
	 AZ/+yRXdkjkQueAJpOMpTamOph7v2c9UitbECXd1bG2wkBI0fjDVeR8YFarVd0Nax/Nvh
	 +fyLr/ugkllXyjCQJQGCwqkOLKMX5MU3FV7QcdAS7NMhwVhr5kLSaLxdHW6gIt8vdSPb+
	 Lje6SmAVOuPTzqGMhZB+/D0ZI9RbZF9Qw8QcPJ4PaRO6gSQVv83KcHzLpSvlH1i1ST9S7
	 RaLJItmUPYAC/oOu82XMMSgJ/SGIpYQ82ZxkOyoaHVuugJ0tE8roBbhAuFsrENEo6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L56t7SJ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C93606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L56t7SJ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D05E1F000C4;
	Fri, 13 Nov 2026 03:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539557;
	bh=9tvixEKLvFMwJgIr/SUEMzdCExGp9ojYcq/aJ+ks3dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L56t7SJ2IrdDyl0K7feQ7WSzz2SRbn+nOur4HamvUCGFDm9SFct57yzy+ovlC0C0Y
	 brRVmDyOqKeOYwTkgMlE9OYkrtB1UgpKDVXInvyQzplTWOUY83Km3PNIlatnKypaPq
	 AHhRHDBAEDlysmd8gunZh6Wzat7O6KxAd5egD55uSwKPekBZJX6+CwvS9jHWh0rWTI
	 pPtc27ZT7j3Y4prPweRBKM+2ySpPIwxQj4BNJ+zJpVSdzx5eYu/02RJ0faD1H9kbF0
	 Rsa+9cJngRVbv1Rk6CarDpSlG+IX+AVHJjCYu0Rt5BtHO+yA5wqs7dZIq7wN3LOaCJ
	 jY5XqgeDSJC4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
Date: Thu, 12 Nov 2026 22:12:35 -0500
Message-ID: <20261113031212.983671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051826-failed-6.12-dd6ecace5785@kernel.org>
References: <20261107051826-failed-6.12-dd6ecace5785@kernel.org>
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
[ sashal: adapted atomic_pre_enable() error handling to pre_enable() with explicit regulator and multiple-clock cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index b4abac49f5d96..4b874b1c846ad 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -11,7 +11,7 @@
 #include "msm_kms.h"
 #include "hdmi.h"
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
@@ -19,11 +19,15 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
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
@@ -39,8 +43,19 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable pwr clk: %s (%d)\n",
 					config->pwr_clk_names[i], ret);
+			goto err_clk_unprepare;
 		}
 	}
+
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(hdmi->pwr_clks[i - 1]);
+	regulator_bulk_disable(config->pwr_reg_cnt, hdmi->pwr_regs);
+err_pm_put:
+	pm_runtime_put(&hdmi->pdev->dev);
+	return ret;
 }
 
 static void power_off(struct drm_bridge *bridge)
@@ -135,8 +150,13 @@ static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
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

