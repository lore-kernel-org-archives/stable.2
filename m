Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D51362138
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321204; cv=none; b=S0D0DEBd9rTyUcRZ0HJQ+RMd6AeSIqarvpGx957eL6RG7pV2bcAKIw7nXZ5tKra2uVPrjcSMbco9d3E81pA4isldS6hNNhH9XF7HSr5/Lg43KPteLSqFZ10HMX4Z7YbovnvXeZ9lmeSM7ntp6Kif4b0tFM5Kgofs0xYbXxzo8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321204; c=relaxed/simple;
	bh=qD6xEwIzAG/TRZZOe7GB8r5kXaG9GFXowyH2zeu73E8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FTOl3eAu+QiFm6VFPa4wn4Fc+JpHp0NDtu+QRMnVCFR7LwzfXzxAW8W5xalmTevGXCOWolw1TGw5ndh0f6e+hJKxGGsgYd9LWYPOHP0y+XCv27cyJXZXwY4BrmihHQgqAwesMJAuywgB63uTFKRuZ6s4dORGQEyrBjnP43A0H4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nW8KT5WL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nW8KT5WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B01F000E9;
	Wed, 29 Jul 2026 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321203;
	bh=ytEeNJhCNJkJP5tIrBVI1P9G1+50xcMF7hOISyufkDw=;
	h=Subject:To:Cc:From:Date;
	b=nW8KT5WL/ObgNIWCvPzw1W6bdKSRFHabH4o/LXYMrviDA9aJZNxQ6jsFKG6hxTjeO
	 Vu/SyjpLe3UZQrapf4nxXqIffvNAaDMvIgj/+KrA8Q7A/vCblJbNb58KjlguC5yLaR
	 TxupZ9ugDFV1Aeff19eW0L4pZhiPfMrYB+2VgSAI=
Subject: FAILED: patch "[PATCH] drm/bridge: cdns-dsi: Replace deprecated" failed to apply to 6.1-stable tree
To: vitor.soares@toradex.com,luca.ceresoli@bootlin.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:33:09 +0200
Message-ID: <2026072909-childish-udder-2b58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2d8b08844c0ecc6f2002fa68711e779aa18c8585
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072909-childish-udder-2b58@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d8b08844c0ecc6f2002fa68711e779aa18c8585 Mon Sep 17 00:00:00 2001
From: Vitor Soares <vitor.soares@toradex.com>
Date: Tue, 5 May 2026 14:47:05 +0100
Subject: [PATCH] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()

The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
for both runtime PM and system sleep. This causes the DSI clocks to be
disabled twice: once during runtime suspend and again during system
suspend, resulting in a WARN message from the clock framework when
attempting to disable already-disabled clocks.

[   84.384540] clk:231:5 already disabled
[   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_core_disable+0xa4/0xac
...
[   84.579183] Call trace:
[   84.581624]  clk_core_disable+0xa4/0xac
[   84.585457]  clk_disable+0x30/0x4c
[   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
[   84.593651]  pm_generic_suspend+0x2c/0x44
[   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
[   84.601670]  dpm_run_callback+0x8c/0x14c
[   84.605588]  __device_suspend+0x1a0/0x56c
[   84.609594]  dpm_suspend+0x17c/0x21c
[   84.613165]  dpm_suspend_start+0xa0/0xa8
[   84.617083]  suspend_devices_and_enter+0x12c/0x634
[   84.621872]  pm_suspend+0x1fc/0x368

To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
RUNTIME_PM_OPS(). Bridge and panel drivers should only deal with runtime
PM, as the DRM framework manages system-wide power transitions through
the bridge enable() and disable() hooks.

Link: https://lore.kernel.org/all/fbde0659-78f3-46e4-98cf-d832f765a18b@ideasonboard.com/
Cc: stable@vger.kernel.org # 6.1.x
Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260505134705.188661-2-ivitro@gmail.com
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0dd85e26248c..e07a9892df4e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 	.transfer = cdns_dsi_transfer,
 };
 
-static int __maybe_unused cdns_dsi_resume(struct device *dev)
+static int cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cdns_dsi_suspend(struct device *dev)
+static int cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_resume,
-			    NULL);
+static const struct dev_pm_ops cdns_dsi_pm_ops = {
+	RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
+};
 
 static int cdns_dsi_drm_probe(struct platform_device *pdev)
 {
@@ -1399,7 +1400,7 @@ static struct platform_driver cdns_dsi_platform_driver = {
 	.driver = {
 		.name   = "cdns-dsi",
 		.of_match_table = cdns_dsi_of_match,
-		.pm = &cdns_dsi_pm_ops,
+		.pm = pm_ptr(&cdns_dsi_pm_ops),
 	},
 };
 module_platform_driver(cdns_dsi_platform_driver);

