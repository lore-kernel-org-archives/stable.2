Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540539;
	b=hrS4hAULbj7ptGt7eCLeT/L7tAXoLOF0DL8JG36kLGfbV6rwid7hkcEH5kwoFhtGHypa
	 FDkdoYvvtALwXX9jQgHcg1jAGBxsaDO8P3akNM6vIUeKfb61+DwiIdUz89kjUQHjcU+IZ
	 QrWjllR9ppcgw3yNyX0xJM5lXyWa5WlTZXXzP91nuXago/Z1vt8ngr6Kp+wvBCPlnYHbR
	 J/RoOyYm+/lGvE7dfu5okE3I1IhkXK4dFZUFGMWMWfz1iuFscMmzm+3pgVp3ZOvuLflvf
	 VTWAozTCz8KiVtzCW3h61PhH8fU9prFrJvsSwNeCvAMewhk8eX5MkS6Hedod1YLppjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AnMVaQW0wpmIBQ2Re5aDrucBSMMXzLX48x2T/fxCevg=;
	b=jBfRVw4Htg07qeqz6xSq9UFWUucy8bje7ucEZ2aAIkJkPYkmNPxYvB6KmavB0pZN4z+0
	 rF6ZVqgED6uJXwnpR3eFgkMe3GS984/0ltF6g0yQLuXexIjEpTMsvnGSOqbKRra0pCJm1
	 YGBMjJZGiVewn0GbzF6MPtYoRdAiUAXkxOIwF8VEZCLPiTNzzyR5xmljQEbUjev+ccFUk
	 eD/supSzAEiFe7pl/bbENgmA/MN4a/+Y92LuGHjTQXoZqCBu2a73qyDk5/19au6iCi/Hy
	 LsGEzNn7LTxtSVLtyqtHfJnmfmuvkoAaLqnHxvRTUCivHbe18h8WUXEtG/hwVXikBwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPCeSHdW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF517606A887
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPCeSHdW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE661F000C4;
	Fri, 13 Nov 2026 03:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540539;
	bh=AnMVaQW0wpmIBQ2Re5aDrucBSMMXzLX48x2T/fxCevg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DPCeSHdW2iqmhozFnTVi0aKVsvdVJ4luRICkmVNCAIJXMFGZ3j1OAptyPZcQBqJ0M
	 flabAy/VpLSkdqgPDzvWmmFPL/fdMdL4ejWfqEy/LaqUlAjXcNIkqGD+UgK4hKjPqD
	 vjsAXyiFpDQmr5/u6/7/eWHLawOF/Ii9tFoM+X75rulFAOcPdW+Qxo0gbaHWoiMFRA
	 vnXgXHV733eHgTh6J5waa2Nl4pUssmx/SErn9T5UPI6G4UjWGkGVyVkVQjHtnxB4uZ
	 sQJ9paoWw0ocmCrrK8GChxYKGP5//tEl1gvD4XwA7n6OXMbT4/he4aq4AA94UG4FMk
	 fOJ3azA4e1ngg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
Date: Thu, 12 Nov 2026 22:28:57 -0500
Message-ID: <20261113032834.1060523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054338-failed-6.1-dd6ecace5785@kernel.org>
References: <20261107054338-failed-6.1-dd6ecace5785@kernel.org>
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
[ sashal: adapted error handling to the non-atomic pre-enable flow using bulk regulators and power-clock arrays ]
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

