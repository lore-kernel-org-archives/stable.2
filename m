Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044053B614
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952696; cv=none; b=RHiJEE3Mpq19Mh6Mnq87u0fybL2L8flfi93os1+RIE+TyZYLNu0/WaZ8U8PrHFv5Kvl1Ts3q58JjPJtz1YbBo5cTsQZfiYG1BGt8tdsq6Qtv2dhx3vd6Nz6zok25/ebcN2nujhdBjQ0OhuY9E77N6AcdK4g2DEYwsuOwlK1SlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952696; c=relaxed/simple;
	bh=Bj74HruAsByYW3s4+cp7cFXyoC1XGQZ6tQ+mL92+6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpDZgW48BWYSJsiJgRymrcOU4YpEugvwvNksnuETad22kTyZkv0PtXPXxMmC0AVqQRhEQkAjXxGj6R/ooHSIwLgO6JdNUrwPLghDtpHrn+Shk2yzUYQmM6MxXGCR7wSPkzNg4pl6DDxmdZX1baHX4H3Lp/umUolh4mWKxmlyAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwwD80S9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwwD80S9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303891F00A3F;
	Wed,  9 Sep 2026 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952688;
	bh=V+rZ0lwtXiof/rB/VnD+yDanqpZl7rKGLPn2jE5nC0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwwD80S9cCG8ijt3qd6VnDJSICFAsm+41LnSdAmgsNkqxNrByWO9xtxUyNlRd2SRa
	 LMbrzJdDi+MRWTkYDy53QxIg6knF9erIra9DvBQxKYfz5chMCCFsEU2rIaVjp399FA
	 aWMuqaLuXIhUPJbqLFw6slG+3ZfJd0Bdh8lTL/vM31q+LVDNKXTDbN5OWH71MS7ZgH
	 LjcBUDf5do7lmwG1LkWKY9QahK9zw3MDzb11fka5etxLjbGTBcoDou6iJsYXq4vXE4
	 14L+lL8hUybxZBWJwgaINs2vTpGXxLBVunskoekgrt8xBhNMix1Vq2W4PNg8m5sXBt
	 F9gXYMRcmgj3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] driver core: platform: change logic implementing platform_driver_probe
Date: Wed,  9 Sep 2026 07:18:00 -0400
Message-ID: <20260909111805.1804682-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909111805.1804682-1-sashal@kernel.org>
References: <2026090322-humbling-ninth-d3ad@gregkh>
 <20260909111805.1804682-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 16085668eacdc56c46652d0f3bfef81ecace57de ]

Instead of overwriting the core driver's probe function handle probing
devices for drivers loaded by platform_driver_probe() in the platform
driver probe function.

The intended goal is to not have to change the probe function to
simplify converting the platform bus to use bus functions.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20201119124611.2573057-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fa023cf80dc48..16426eb934632 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -743,12 +743,25 @@ struct platform_device *platform_device_register_full(
 }
 EXPORT_SYMBOL_GPL(platform_device_register_full);
 
+static int platform_probe_fail(struct platform_device *pdev);
+
 static int platform_drv_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret;
 
+	/*
+	 * A driver registered using platform_driver_probe() cannot be bound
+	 * again later because the probe function usually lives in __init code
+	 * and so is gone. For these drivers .probe is set to
+	 * platform_probe_fail in __platform_driver_probe(). Don't even
+	 * prepare clocks and PM domains for these to match the traditional
+	 * behaviour.
+	 */
+	if (unlikely(drv->probe == platform_probe_fail))
+		return -ENXIO;
+
 	ret = of_clk_set_defaults(_dev->of_node, false);
 	if (ret < 0)
 		return ret;
@@ -822,7 +835,7 @@ void platform_driver_unregister(struct platform_driver *drv)
 }
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
-static int platform_drv_probe_fail(struct device *_dev)
+static int platform_probe_fail(struct platform_device *pdev)
 {
 	return -ENXIO;
 }
@@ -887,10 +900,9 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 	 * new devices fail.
 	 */
 	spin_lock(&drv->driver.bus->p->klist_drivers.k_lock);
-	drv->probe = NULL;
+	drv->probe = platform_probe_fail;
 	if (code == 0 && list_empty(&drv->driver.p->klist_devices.k_list))
 		retval = -ENODEV;
-	drv->driver.probe = platform_drv_probe_fail;
 	spin_unlock(&drv->driver.bus->p->klist_drivers.k_lock);
 
 	if (code != retval)
-- 
2.53.0

