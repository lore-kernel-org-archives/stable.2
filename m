Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416731;
	b=M09GVFHnN+Z5LtfSpN/IIX7y97pDNVnaFVo9GF5luI0uoJSlhaGre0zZC+BRUn0FFpOJ
	 43UQpM6gFZKui1Mrr25hDukAYSJoWgwb2A4ljps/RZ2I3FzCHvnnUIbTwUt1FL1Rie8l9
	 his+VpRh8lvfTKXrF2yaBTy8tJPlbbLfiz0KNyDJ4dxFCSA202anZfu1wLckd4Q7ROh95
	 fDNqxlUWlHM2yViV0ybeXrD5aj11sHszHJE93FGa36ZxVpvVq/KCynocqxxR5iUGaovqG
	 qa5HKta7h+EhVYOPZSc/Odxc81K/pcBrZD3pEE0qRcWXF3/c0fmbZ7WWk6LXZsxk/pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416731;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=smHPmzI4/01PKVCDKYM5LbTeZBN3UsZhH8KUWpulrBY=;
	b=yxkMaE9TFdoMt6gX4CYJNmxLAHzqswEb5p/6jIVUmNcTK5M1odiMMUZ1yOGf3NdiXvDm
	 ht/FGlhncqDHr9FY4ZUvK4FwhiHxg4mea3IFzZ66bAwC2VGaqLxnmrK44zpufgrsadv/Z
	 ooZy1UuzMKMqtouADA31MJ1GMj24O4Nqzy6gv8lxlkTYsZnyLcICYdOI+E/kOQSlD0vcw
	 SpFNAdqYeLfzAJu7VqOVwVpC9G9zN8CecdoQHRuySiPcTcUe3JTfuAwFc6JILNlm6euZK
	 BJ6k5SdTGGNpJxKLLeRtkhA42LLRy53mBOIUXKNG842eKyWEy12P+MUHJvAH0H/x+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzMVMleb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F488606A895
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzMVMleb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A961F00A06;
	Wed, 11 Nov 2026 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416731;
	bh=smHPmzI4/01PKVCDKYM5LbTeZBN3UsZhH8KUWpulrBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CzMVMlebBqgFGI5sP26WgGH6yiu1pMYeGoseTur2e2wRsKu/Qx/R1JTKtO1cvFnJL
	 z6J4lW/j6DDGTWP8DFGsF14AkbLbRyehmHb2Y2JjazRKxnmI6aOat9dv22wgUtxpOL
	 +9fvgein35+qYp+Y36MbdS3Ml+vzCgWPv8zmy2GeuB9fYQsc3QNMxNzqjWJ1rqHyZS
	 rlMoA9FuM8swKPVVwnilQARUm/XZqe6MuBkZ19dZhq2YGY8qyEokF9HMufQFVjG9IC
	 eVbR33Uh3iRzUUiZwK5OhuYUHpEWaWx/HmVVhaWaBBDLEvG1Suy6L2tiKNtCI5PZlW
	 qSj5flvF7bYPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Abhinav Kumar <abhinavk@codeaurora.org>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/msm/hdmi: use bulk regulator API
Date: Wed, 11 Nov 2026 12:05:28 -0500
Message-ID: <20261111170441.3401882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060115-failed-5.15-d27f831aaf20@kernel.org>
References: <20261107060115-failed-5.15-d27f831aaf20@kernel.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 31b3b1f5e35252b255f2a0d6a3883b09b5c4af97 ]

Switch to using bulk regulator API instead of hand coding loops.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Link: https://lore.kernel.org/r/20211015001100.4193241-1-dmitry.baryshkov@linaro.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: d27f831aaf20 ("drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        | 34 ++++++++------------------
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  6 ++---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 20 +++++----------
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 24 +++++++-----------
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c    | 33 +++++++++----------------
 5 files changed, 40 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 2c944419e1758..eb11fac881334 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -165,19 +165,13 @@ static struct hdmi *msm_hdmi_init(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto fail;
 	}
-	for (i = 0; i < config->hpd_reg_cnt; i++) {
-		struct regulator *reg;
-
-		reg = devm_regulator_get(&pdev->dev,
-				config->hpd_reg_names[i]);
-		if (IS_ERR(reg)) {
-			ret = PTR_ERR(reg);
-			DRM_DEV_ERROR(&pdev->dev, "failed to get hpd regulator: %s (%d)\n",
-					config->hpd_reg_names[i], ret);
-			goto fail;
-		}
+	for (i = 0; i < config->hpd_reg_cnt; i++)
+		hdmi->hpd_regs[i].supply = config->hpd_reg_names[i];
 
-		hdmi->hpd_regs[i] = reg;
+	ret = devm_regulator_bulk_get(&pdev->dev, config->hpd_reg_cnt, hdmi->hpd_regs);
+	if (ret) {
+		DRM_DEV_ERROR(&pdev->dev, "failed to get hpd regulator: %d\n", ret);
+		goto fail;
 	}
 
 	hdmi->pwr_regs = devm_kcalloc(&pdev->dev,
@@ -188,19 +182,11 @@ static struct hdmi *msm_hdmi_init(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto fail;
 	}
-	for (i = 0; i < config->pwr_reg_cnt; i++) {
-		struct regulator *reg;
 
-		reg = devm_regulator_get(&pdev->dev,
-				config->pwr_reg_names[i]);
-		if (IS_ERR(reg)) {
-			ret = PTR_ERR(reg);
-			DRM_DEV_ERROR(&pdev->dev, "failed to get pwr regulator: %s (%d)\n",
-					config->pwr_reg_names[i], ret);
-			goto fail;
-		}
-
-		hdmi->pwr_regs[i] = reg;
+	ret = devm_regulator_bulk_get(&pdev->dev, config->pwr_reg_cnt, hdmi->pwr_regs);
+	if (ret) {
+		DRM_DEV_ERROR(&pdev->dev, "failed to get pwr regulator: %d\n", ret);
+		goto fail;
 	}
 
 	hdmi->hpd_clks = devm_kcalloc(&pdev->dev,
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 20f554312b17c..a6c88d157bc3a 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -48,8 +48,8 @@ struct hdmi {
 	void __iomem *qfprom_mmio;
 	phys_addr_t mmio_phy_addr;
 
-	struct regulator **hpd_regs;
-	struct regulator **pwr_regs;
+	struct regulator_bulk_data *hpd_regs;
+	struct regulator_bulk_data *pwr_regs;
 	struct clk **hpd_clks;
 	struct clk **pwr_clks;
 
@@ -161,7 +161,7 @@ struct hdmi_phy {
 	void __iomem *mmio;
 	struct hdmi_phy_cfg *cfg;
 	const struct hdmi_phy_funcs *funcs;
-	struct regulator **regs;
+	struct regulator_bulk_data *regs;
 	struct clk **clks;
 };
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 11b1919e37b1c..dcfefc12385ab 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -27,13 +27,9 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 
 	pm_runtime_get_sync(&hdmi->pdev->dev);
 
-	for (i = 0; i < config->pwr_reg_cnt; i++) {
-		ret = regulator_enable(hdmi->pwr_regs[i]);
-		if (ret) {
-			DRM_DEV_ERROR(dev->dev, "failed to enable pwr regulator: %s (%d)\n",
-					config->pwr_reg_names[i], ret);
-		}
-	}
+	ret = regulator_bulk_enable(config->pwr_reg_cnt, hdmi->pwr_regs);
+	if (ret)
+		DRM_DEV_ERROR(dev->dev, "failed to enable pwr regulator: %d\n", ret);
 
 	if (config->pwr_clk_cnt > 0) {
 		DBG("pixclock: %lu", hdmi->pixclock);
@@ -69,13 +65,9 @@ static void power_off(struct drm_bridge *bridge)
 	for (i = 0; i < config->pwr_clk_cnt; i++)
 		clk_disable_unprepare(hdmi->pwr_clks[i]);
 
-	for (i = 0; i < config->pwr_reg_cnt; i++) {
-		ret = regulator_disable(hdmi->pwr_regs[i]);
-		if (ret) {
-			DRM_DEV_ERROR(dev->dev, "failed to disable pwr regulator: %s (%d)\n",
-					config->pwr_reg_names[i], ret);
-		}
-	}
+	ret = regulator_bulk_disable(config->pwr_reg_cnt, hdmi->pwr_regs);
+	if (ret)
+		DRM_DEV_ERROR(dev->dev, "failed to disable pwr regulator: %d\n", ret);
 
 	pm_runtime_put_autosuspend(&hdmi->pdev->dev);
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 52ebe562ca9be..68f5254632c37 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -97,16 +97,13 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 	const struct hdmi_platform_config *config = hdmi->config;
 	struct device *dev = &hdmi->pdev->dev;
 	uint32_t hpd_ctrl;
-	int i, ret;
+	int ret;
 	unsigned long flags;
 
-	for (i = 0; i < config->hpd_reg_cnt; i++) {
-		ret = regulator_enable(hdmi->hpd_regs[i]);
-		if (ret) {
-			DRM_DEV_ERROR(dev, "failed to enable hpd regulator: %s (%d)\n",
-					config->hpd_reg_names[i], ret);
-			goto fail;
-		}
+	ret = regulator_bulk_enable(config->hpd_reg_cnt, hdmi->hpd_regs);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to enable hpd regulators: %d\n", ret);
+		goto fail;
 	}
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -155,7 +152,7 @@ void msm_hdmi_hpd_disable(struct hdmi_bridge *hdmi_bridge)
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	const struct hdmi_platform_config *config = hdmi->config;
 	struct device *dev = &hdmi->pdev->dev;
-	int i, ret = 0;
+	int ret;
 
 	/* Disable HPD interrupt */
 	hdmi_write(hdmi, REG_HDMI_HPD_INT_CTRL, 0);
@@ -169,12 +166,9 @@ void msm_hdmi_hpd_disable(struct hdmi_bridge *hdmi_bridge)
 	if (ret)
 		dev_warn(dev, "pinctrl state chg failed: %d\n", ret);
 
-	for (i = 0; i < config->hpd_reg_cnt; i++) {
-		ret = regulator_disable(hdmi->hpd_regs[i]);
-		if (ret)
-			dev_warn(dev, "failed to disable hpd regulator: %s (%d)\n",
-					config->hpd_reg_names[i], ret);
-	}
+	ret = regulator_bulk_disable(config->hpd_reg_cnt, hdmi->hpd_regs);
+	if (ret)
+		dev_warn(dev, "failed to disable hpd regulator: %d\n", ret);
 }
 
 void msm_hdmi_hpd_irq(struct drm_bridge *bridge)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index cfaf9c26a9054..326b43c803f09 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -23,22 +23,15 @@ static int msm_hdmi_phy_resource_init(struct hdmi_phy *phy)
 	if (!phy->clks)
 		return -ENOMEM;
 
-	for (i = 0; i < cfg->num_regs; i++) {
-		struct regulator *reg;
-
-		reg = devm_regulator_get(dev, cfg->reg_names[i]);
-		if (IS_ERR(reg)) {
-			ret = PTR_ERR(reg);
-			if (ret != -EPROBE_DEFER) {
-				DRM_DEV_ERROR(dev,
-					      "failed to get phy regulator: %s (%d)\n",
-					      cfg->reg_names[i], ret);
-			}
+	for (i = 0; i < cfg->num_regs; i++)
+		phy->regs[i].supply = cfg->reg_names[i];
 
-			return ret;
-		}
+	ret = devm_regulator_bulk_get(dev, cfg->num_regs, phy->regs);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev, "failed to get phy regulators: %d\n", ret);
 
-		phy->regs[i] = reg;
+		return ret;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
@@ -66,11 +59,10 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 
 	pm_runtime_get_sync(dev);
 
-	for (i = 0; i < cfg->num_regs; i++) {
-		ret = regulator_enable(phy->regs[i]);
-		if (ret)
-			DRM_DEV_ERROR(dev, "failed to enable regulator: %s (%d)\n",
-				cfg->reg_names[i], ret);
+	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
+		return ret;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
@@ -92,8 +84,7 @@ void msm_hdmi_phy_resource_disable(struct hdmi_phy *phy)
 	for (i = cfg->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(phy->clks[i]);
 
-	for (i = cfg->num_regs - 1; i >= 0; i--)
-		regulator_disable(phy->regs[i]);
+	regulator_bulk_disable(cfg->num_regs, phy->regs);
 
 	pm_runtime_put_sync(dev);
 }
-- 
2.53.0

