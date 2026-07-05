Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7A20E023;
	Sun,  5 Jul 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287358; cv=none; b=bhD95ZuwlmE9t8p/sgmDXWJGPqmssLMO0/Z7myGt6lGqdJWU6DdW5zpIUzQJLDWHbe6wI74gEXfcDuGlrqqIFV4R9IZZ5Cey5RB4v88xnfC/Sei8R9ffvYVPfoCPNEr+VOuqxRkVT3EQmKn0zA1aZRXz5cSTxIc7iDgoRUaJPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287358; c=relaxed/simple;
	bh=gdRkLQABCso7Pq+hx4ptN7VAvIimLCYikztKh8bbSfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8A5afyxB+wg86SV0aPCBgNmxL6HXB/OFjFlVvBuSAZ7MS99bFPi+2yONEkF0vBZnUE86SUVx25kYMXbDyKDs9WUpTzg2/CmfN8UQRrocuOL4PbtMO8CMzE3Omx7YxBOo91/1PO3s1Tjuwlv+24DjBSNLlVPxQaQ4R773HqO8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KSUfAx9L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KSUfAx9L"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29DB2B8B;
	Sun,  5 Jul 2026 23:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783287299;
	bh=gdRkLQABCso7Pq+hx4ptN7VAvIimLCYikztKh8bbSfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSUfAx9LwSMa2l5hnQUZLe8H4Td880SoqHfCZ427jjdLCtz5/oKodZ34b8oNIAvF+
	 pp8NrqvP+VELSxxQNu1bM2p+tgsRQKIm2tWBn+QIuuYqkyroFos2HoEf3Vh7Mp2uWN
	 pBPWDi6oDCE25/arzodjJ2PvlFMKgALJk6SSeR4w=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter resource leak
Date: Mon,  6 Jul 2026 00:35:40 +0300
Message-ID: <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
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

Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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
-- 
Regards,

Laurent Pinchart

