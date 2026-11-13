Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576898;
	b=TJO5RxwIlW6namn8jVCyCwbhgp7pK0MEvH0snm7LKtowjAiWGpHubDs7UhblEfxa8dHZ
	 j04WLC52zBl4BJtOp463YJMSpG2zenhfJWUFhtEYtNujJqwVg9NZsup+YjLTHPHBJk1nq
	 7Kv6ig249ScB9Zx+EMqjGoMFTiP5EZBdnV9cEfux05/1Y/dOmOM9HmiPjSLB5r10/S9LG
	 ikF4ctj65bluptL15cUf3SILWemqKAlDYMb74yoPwHVJqNgGPLAFgruvXwV/I0rJnibQg
	 QbebGWrxdwvDgXkUtojmPK2kSrBsxDcIES0BYiFfTV12Loh8RE2RT/USHHIqa4QYzFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576898;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+HP4/5uQ1XjEZrjvf8EO98oHmhRtFw1R+qXivNQu5lM=;
	b=U9rt3vMOY0cO3Gos43xRUd1cu4jnZ8iupJWJfvmKHLS5+RZZi4xqlti+jxZjNJLRERQW
	 U8DD6kx5hZD5l1d9rg9QUtPJV/SlLOeDJY2L8lbDMY+GMI8w2cOlhP1O3d4eDfLO/Ws3J
	 0ZjOmF+BnDWhYRQzddTkaXhwbBH75gS0xSNB0cTqMD8EwaoU4X96MJ+rFeTXy1HwlYxK2
	 KJfJ6cbEbvY8Tx99ak/YPNtll9Hoy68D5A6FtR2Z9yXrqvb+Fk/eUQ/wxFkgLP87wVQRa
	 omUUQ7IXTSq0Oi8upbZqjpavvRdO41IHVNMQ+RfjCyJsug9oHVcRBwwHPvadQP9rsuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GY3WwAPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75965606ABA4
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GY3WwAPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31E51F000C4;
	Fri, 13 Nov 2026 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576898;
	bh=+HP4/5uQ1XjEZrjvf8EO98oHmhRtFw1R+qXivNQu5lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GY3WwAPnK0GmbASoHigboFYmrwUF1dIHZm5ED4DS0Uky1/TvQmzwxQQ0LeBkIb5ZR
	 cR0NU7vHhff7FKTZTOhppenDxAnT7pR2DRAtilnyks2lVKI4uvZ5Gpyq+EsnJtQobD
	 iPqPmJgDXpVlyG2y9+f6joJSyg25SoUmqtgZOM+BeKxR2XlxIYMxAh1RItcJi6L/Lk
	 7d0XPqQ8zgrWCdAXtL9QNoU0I7xRcu3ZV+xPhNq4mUWP43Dr5nk5D0D983aZ/avJbA
	 NF8pvR6Xnr/D1mxSXZnN7exAYq3AdYAMKAbyuqkauoXCrUgTkr9uU6rd8t9kyW+j3x
	 6e72ual36ekwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
Date: Fri, 13 Nov 2026 08:34:56 -0500
Message-ID: <20261113132816.1312911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061759-failed-5.10-dd6ecace5785@kernel.org>
References: <20261107061759-failed-5.10-dd6ecace5785@kernel.org>
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
[ sashal: adapted error handling to the non-atomic pre_enable callback and regulator/power-clock arrays without state_mutex locking ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index dcfefc12385ab..d7dc6cbbea463 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -17,7 +17,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *bridge)
 	msm_hdmi_hpd_disable(hdmi_bridge);
 }
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
@@ -25,11 +25,15 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
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
@@ -45,8 +49,19 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
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
@@ -141,8 +156,13 @@ static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
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

