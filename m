Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575431;
	b=Y4+vcvLEJo2cvzdK4r7LrPRRWn8jLieaIVPBlaeD55cfxDqKWSrO+3CkJwD39etvI5jD
	 zghsAlCiEyhPahZPP/1x3c+oFs4f/Dw7Ea6xlbSCjhifsEpkRCvf+uQ53sBU7xTtE4BDM
	 6VJNVdjPD/7P8/SVQu5sFhaqqlrReo7gZkR/41d6pFPz/jwy4akNOPuNNDiYBEjk3hYxu
	 SFjMr+UgXD9D7zXelnAxHacX1aBqUc6U9rZTSXXoE7OvsJuO9eR3TpmX9/159hcCNKQCo
	 8BnlfEBhsMSZuc0ADZw43dgUQpQ13PKZcwJFCJwtkoKvnUgJyzaDksBlkF8RSxBat1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8uyEFf9a4sLVuPM18VQKJyocJI+Q3/dcNmBrhRNUf38=;
	b=BVcWgj18RY5hQiAQV0H+tW0jbS/VvaPbtsgHeklxSqeDyWoZRsqlyleeSni/x3PccM6l
	 WFbjOK4z7kNmRwKDNkgUnOtBfvxRjzjvO9LlJ9j0Aa0YZwlxBew/Xqr0wjvpOYj6mu71F
	 oN618n5a4BY0wKrWZm1UlJYTWMl6U93CoK+gsTsF3nwx6ZdS+s5toRr/63UlSgG3jTpOG
	 p6WKHqKl+/gYbS7a8AgVa23pUp0HIM35TjivbyDBLcTpywOX726gIbD+PQRgiJhMideH8
	 9QqJnaHMAz7z25G/e7Uz9mOJdLXXahpqL8nKDpZKAwM/dRsH8UiwynwTyFa2IsA5H9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOxM61GD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AB606A339
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOxM61GD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD301F000C8;
	Fri, 13 Nov 2026 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575430;
	bh=8uyEFf9a4sLVuPM18VQKJyocJI+Q3/dcNmBrhRNUf38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fOxM61GDqZKLwJ0jv6n3imZjicaydF8XEBLtUg/S/m6QbXgwkArNsy7ZHL0nyTase
	 odB1FEf8bDybdXsbkYoRvHE27Vq9GMjNeV9YECz9wHqE+3QTFQ2fWGyUqw3uv3fvoE
	 8TQOasb235IiZ44XFG05Ln+29+MWG2aKccXJV2yo5PyisMwCRrJCSOzMDoWhL1QbVj
	 JNx8uahNo2RF+mZslLmyBQT6VoHfeUrT1ie32GzmLUhasr6xIG9S5JhA55oKVYdatZ
	 G1OVsG/ydPKSIqysKr2kjBHCRaSu2YCI01OvaVk68cmcFaKoV6/vay8PlnjhpkcNXt
	 L5gqsS1n00HiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
Date: Fri, 13 Nov 2026 08:10:29 -0500
Message-ID: <20261113130529.1067258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060117-failed-5.15-dd6ecace5785@kernel.org>
References: <20261107060117-failed-5.15-dd6ecace5785@kernel.org>
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
[ sashal: adapted error handling to the legacy pre_enable sequence with bulk regulators and a power-clock array ]
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

