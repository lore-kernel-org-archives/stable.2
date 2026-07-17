Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DA360EFF;
	Fri, 17 Jul 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314121; cv=none; b=EfAgzdhDzlSQVm2rkmK3zg9Kv2vZvqzlopZBJQAaRYkgznby27IB3P6uW/ct8qwmSR1hStSmfG9VS51xuMxBJle2Xuz1Qo6xYTJlILY1yaNQvdDTUj5giBHVas3ITLRKDf3qCB2RGge+Qa3BVkY5LPfOVqBHnymawy9g3jF5D4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314121; c=relaxed/simple;
	bh=jJ7R+wwz8w6ZuFFtfjFEaGPZs98mzCpVLOeIWTgQUho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdY+liS8zUnvD1moLBs7kUU7HF6/EEXxXDPsQCTYYBA96X1iKPQP+pVjjSUM7kUty47hJubv7Qqq1RUhifjuXSQysNvQsK/BgLgUbyEDOErI/5iVujpqXxIyYRTtM4diH64HMtIcxrvAIOWEvAg7ZgwiFzFq9/5OJGDt/tLU1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fzJfn2kH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fzJfn2kH"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15CF8664;
	Fri, 17 Jul 2026 20:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784314061;
	bh=jJ7R+wwz8w6ZuFFtfjFEaGPZs98mzCpVLOeIWTgQUho=;
	h=From:To:Cc:Subject:Date:From;
	b=fzJfn2kHq5tRR+It5NYrawcu5D1V/KEeaBjEjXWCWjVbsZTP0v/DyBhiBEhD2xeEZ
	 7siUfgsNZIi4xTg6d28rO+ukLVurJfSUfN3DNBq5wQoQrmkrdl1U4tBCvNoJ+lzsm+
	 vjBhaFQvqqeHFVHKzYRvQAkttfV+a08XPDurx7eE=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/bridge: display-connector: Fix I2C adapter resource leak
Date: Fri, 17 Jul 2026 21:48:36 +0300
Message-ID: <20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the probe function returns an error after getting the I2C adapter for
DDC, the reference to the adapter is never released. Fix it by releasing
it in the bridge .destroy() handler.

There is no need to test the ddc pointer with !IS_ERR(), as
of_get_i2c_adapter_by_node() returns NULL on error.

Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index d1e74dd2e051..eb3412ec30a0 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -43,6 +43,13 @@ static int display_connector_attach(struct drm_bridge *bridge,
 	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
 }
 
+static void display_connector_destroy(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	i2c_put_adapter(conn->bridge.ddc);
+}
+
 static enum drm_connector_status display_connector_detect(struct drm_bridge *bridge)
 {
 	struct display_connector *conn = to_display_connector(bridge);
@@ -208,6 +215,7 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
+	.destroy = display_connector_destroy,
 	.detect = display_connector_bridge_detect,
 	.hpd_enable = display_connector_hpd_enable,
 	.hpd_disable = display_connector_hpd_disable,
@@ -439,9 +447,6 @@ static void display_connector_remove(struct platform_device *pdev)
 		regulator_disable(conn->supply);
 
 	drm_bridge_remove(&conn->bridge);
-
-	if (!IS_ERR(conn->bridge.ddc))
-		i2c_put_adapter(conn->bridge.ddc);
 }
 
 static const struct of_device_id display_connector_match[] = {

base-commit: 5b9af25f2d0b574b4058c9f8c84486a597168116
-- 
Regards,

Laurent Pinchart

