Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91143DD87A;
	Fri, 17 Jul 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278701; cv=none; b=utdNabyecCgRa+ApdzLa8n/M65KRJssCWNhAoFK3aCP0OvWXUz4gBUhtxN+fVebymsSDWCTEmeUKyDfa/anrbnFTMi5+eyGoAlymP8lxUXPLyuKwNOnrz/TNKveDhN2I93dVy9y/GZM+fqzVqnNcworWZtqVwdMgIa1c5gJyDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278701; c=relaxed/simple;
	bh=N2gNV9pAOG3sYnwCXk7d06rhZ7CxAMYou7WHUBmLXVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDmYd4w94t7CA0CQYJERiS6Rcc9VgorOPho3N8MCZLVMCUrI9YQV6jPIpa4seQd+ye0jcMUtyq3+l4YClQrVpdf7hE7+rFtMYJNUgavytAbS+FGe9qd7ge/eERNS2SNdXEy20Z2x1DSZJ4vueHcMcCyy4+u8S7DKu5pYVQgg+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENkUMMN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENkUMMN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7651F000E9;
	Fri, 17 Jul 2026 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784278699;
	bh=iv4uXxn+GKJb3u9fgDa2VmuoPL5Se5Dx66tyxt7nYps=;
	h=From:To:Cc:Subject:Date;
	b=ENkUMMN+Xz2YTZ748nkH3PnWLGGPbD9CFI+c3wqdLecWnhQEOmrD1woNldQuYGFsc
	 q++5ZJ6dsbp8wQKF1mLltocvVIWNqNY60iLVWxutW9xtQWmFG1qSID6DWciVRzyFnx
	 k5Gg8KnCF1TfTkC14ThkNiskgi+RMrZElqBQQE92hI6bvz31PsNNmJfxMZJ7Ks3xPM
	 nH/0bWu5DymvXMM2aZZi2Kx8uihj5lHom89IPJLZq3Z1sTHV2/Ayb5VEsbjyUJEOb9
	 9a0+tutH01GTphtAfNOsE97umLV6qDP0tDgp5vhMDeeJsBoDmbwCJKJPJ2P44ky1rT
	 nFIMSAEOnuthA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wkeOe-00000006nGP-2uPl;
	Fri, 17 Jul 2026 10:58:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm/bridge: display-connector: fix i2c adapter leak on probe failure
Date: Fri, 17 Jul 2026 10:57:16 +0200
Message-ID: <20260717085716.1619275-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the i2c adapter device and module references on failed
regulator and enable gpio lookup (and regulator enable) during probe
(e.g. on probe deferral).

Note that of_get_i2c_adapter_by_node() does not return error pointers,
but i2c_put_adapter() can handle a NULL argument so the error pointer
check at remove works even if it is misleading.

Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
Fixes: 6eb6b6f0a012 ("drm/bridge: display-connector: handle hdmi-pwr supply")
Cc: stable@vger.kernel.org	# 5.12
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..c38de5518211 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -208,6 +208,13 @@ static int display_connector_get_supply(struct platform_device *pdev,
 	return PTR_ERR_OR_ZERO(conn->supply);
 }
 
+static void display_connector_put_ddc(void *_ddc)
+{
+	struct i2c_adapter *ddc = _ddc;
+
+	i2c_put_adapter(ddc);
+}
+
 static int display_connector_probe(struct platform_device *pdev)
 {
 	struct display_connector *conn;
@@ -328,6 +335,12 @@ static int display_connector_probe(struct platform_device *pdev)
 			of_node_put(phandle);
 			if (!conn->bridge.ddc)
 				return -EPROBE_DEFER;
+
+			ret = devm_add_action_or_reset(&pdev->dev,
+						       display_connector_put_ddc,
+						       conn->bridge.ddc);
+			if (ret)
+				return ret;
 		} else {
 			dev_dbg(&pdev->dev,
 				"No I2C bus specified, disabling EDID readout\n");
@@ -403,9 +416,6 @@ static void display_connector_remove(struct platform_device *pdev)
 		regulator_disable(conn->supply);
 
 	drm_bridge_remove(&conn->bridge);
-
-	if (!IS_ERR(conn->bridge.ddc))
-		i2c_put_adapter(conn->bridge.ddc);
 }
 
 static const struct of_device_id display_connector_match[] = {
-- 
2.54.0

