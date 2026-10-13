Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768D51B192
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909574; cv=none; b=HODDTnhGkn41Cvsol6QgqRjYEJ7UI12l7AtOVhR3Tv/ySRWYC9XhJ0l1sCuN+yF68cr2XYiFEg23fobse2PM5dwOl6zrZ51HXFFLWTs5Wkn6lVusJnSlBIGedQCWrAOS6xuc7mXrMnzPoUS+PuBFuDRJGCa1UZBH57IcO4bCM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909574; c=relaxed/simple;
	bh=tOyVZ0QoiWNHsIVVTZt12cNJONUL1JfifI/PmB2w4WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zlom9VIovO4fOTd0ToW32tGUWG+TMthQ/n7vUcZkibnEFiftMLPJolTRZh76zqt9WKIXEVx40cLafSxnOOLWskcQ872A+Brko7L4VEblOIQNM6uEduz+PSJMcKm89jd0SfKgSbf4dsLRuJGbDQ1jjNd8aPCpuEapYy1zctQLaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnSvrgWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnSvrgWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4141F000FF;
	Tue, 13 Oct 2026 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909573;
	bh=mQ1qfCMV/migmWILFo6P8ToD9GD/pLm/k08eK8noTaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnSvrgWA94smVx5rMZyPjwXQUP4eUWMKmh2TpJ00a7YyFMmhYTFvkR3xViB6iE5YW
	 eH9utNo4FKWh+tGVzeIClSAPT+ZZShVLjNXj/KgEt+PEKBvVHFoCBnAJoFm9e9RfOU
	 nBi7RQpbKWYuh4TI3h/2KI2gI0Ua699KbCQ8wn6nUcmQAnbFgbarquqFgSgCTw27wW
	 ucVLrA4FwebQwLuax5U9LFIv5vzaAHk8LiafB2GeJaq46pj2ZVCQzCfg5GJ+6kswbh
	 /I/DXL2mL64t07vlV3pHpEorq1iY2Q7w5jwLRMZVjUXiwHz7urCsaE8o998+OEvI/t
	 Y9fnLWAMkQpiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/vc4: Call drm_atomic_helper_shutdown() at shutdown time
Date: Tue, 13 Oct 2026 12:39:29 -0400
Message-ID: <20261013163917.466761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101258-operator-prior-e880@gregkh>
References: <2026101258-operator-prior-e880@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 013d382d11a29ee13023c21dade684f98e47ec5a ]

Based on grepping through the source code these drivers appear to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230901163944.RFT.3.I10dbe099fb1059d304ba847d19fc45054f7ffe9f@changeid
Stable-dep-of: b816da5d5df1 ("drm/vc4: Fix firmware reference leak in vc4_drm_bind()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 1b3531374967e..c133e96b8aca2 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -324,21 +324,21 @@ static int vc4_drm_bind(struct device *dev)
 	if (!is_vc5) {
 		ret = drmm_mutex_init(drm, &vc4->bin_bo_lock);
 		if (ret)
-			return ret;
+			goto err;
 
 		ret = vc4_bo_cache_init(drm);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	ret = drmm_mode_config_init(drm);
 	if (ret)
-		return ret;
+		goto err;
 
 	if (!is_vc5) {
 		ret = vc4_gem_init(drm);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	node = of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
@@ -346,13 +346,15 @@ static int vc4_drm_bind(struct device *dev)
 		firmware = rpi_firmware_get(node);
 		of_node_put(node);
 
-		if (!firmware)
-			return -EPROBE_DEFER;
+		if (!firmware) {
+			ret = -EPROBE_DEFER;
+			goto err;
+		}
 	}
 
 	ret = drm_aperture_remove_framebuffers(driver);
 	if (ret)
-		return ret;
+		goto err;
 
 	if (firmware) {
 		ret = rpi_firmware_property(firmware,
@@ -366,32 +368,33 @@ static int vc4_drm_bind(struct device *dev)
 
 	ret = component_bind_all(dev, drm);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = devm_add_action_or_reset(dev, vc4_component_unbind_all, vc4);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = vc4_plane_create_additional_planes(drm);
 	if (ret)
-		goto unbind_all;
+		goto err;
 
 	ret = vc4_kms_load(drm);
 	if (ret < 0)
-		goto unbind_all;
+		goto err;
 
 	drm_for_each_crtc(crtc, drm)
 		vc4_crtc_disable_at_boot(crtc);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
-		goto unbind_all;
+		goto err;
 
 	drm_fbdev_dma_setup(drm, 16);
 
 	return 0;
 
-unbind_all:
+err:
+	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
 
@@ -401,6 +404,7 @@ static void vc4_drm_unbind(struct device *dev)
 
 	drm_dev_unplug(drm);
 	drm_atomic_helper_shutdown(drm);
+	dev_set_drvdata(dev, NULL);
 }
 
 static const struct component_master_ops vc4_drm_ops = {
@@ -444,6 +448,11 @@ static void vc4_platform_drm_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &vc4_drm_ops);
 }
 
+static void vc4_platform_drm_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id vc4_of_match[] = {
 	{ .compatible = "brcm,bcm2711-vc5", },
 	{ .compatible = "brcm,bcm2835-vc4", },
@@ -455,6 +464,7 @@ MODULE_DEVICE_TABLE(of, vc4_of_match);
 static struct platform_driver vc4_platform_driver = {
 	.probe		= vc4_platform_drm_probe,
 	.remove_new	= vc4_platform_drm_remove,
+	.shutdown	= vc4_platform_drm_shutdown,
 	.driver		= {
 		.name	= "vc4-drm",
 		.of_match_table = vc4_of_match,
-- 
2.53.0

