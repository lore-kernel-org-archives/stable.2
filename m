Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE653CA93
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952697; cv=none; b=EhsZ/VXU1j+zkrnqFA2yhK1kIBTj+hkD2Urp5xKv6EkV5FU757sd0b+RF/k41IQXZTZkBAuEML459i675rh+AFB3ehOZFfRoaVM7Z7U370KAoWb7daVbGOpbk8piTwfc+OQyFeRMM6PFjXQ9xGES6eG70+b9vfqjxC859AmsQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952697; c=relaxed/simple;
	bh=QsiaW/WAGTw5yYlTu8B+tdxkn3muNQhP7whTZyFVw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaNJb/sAUVdbQ7fUwIDKGJqmDv0q/rT7w9Y1uhnlz5AwA65FYcg7Lg4iWx4qHcUPCW+9ylTwMNcdTrHnHGEHZps2m2SuO67aS+NhbiOFsFi2YoO+uCMLYYQK3WnN6MmxZnDfB1rUTJO54H/HYwe7xkoLSzoNP7a/wqBG2x9rA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kigIQkky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kigIQkky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1431F00AC4;
	Wed,  9 Sep 2026 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952689;
	bh=x5N9vle6uLS2YwXS56UTY6fT2OtehjYMsNP0ypApD9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kigIQkkyBfdpMfdmMcTDTsPzR7rsJ7RNJFDls9P8VscJj3vnJOGLI/YFZk8W9GlhU
	 li9Jmbm1OJDNDJf01imub1sHqvT8UYdW0w6Uy9nsl5kYoDLqWfmjDv9a89m01DCkVY
	 +ivsQhRHMHT/lJPPUGZcP8Zlg59oMYDU7vFzqUoDa8JcTv8hrVeqH8rcSqYrbe2HNA
	 Fj5yM0cytVZnA/lU9mQcNWWu7jpB35JQXPJ53Lx+ooamibloTPP/gx9CKfHALzv/ot
	 UzceMYCLWVSOrdrM/rtY0duISlREVSktSPrl5opOT0bBUGXewXD9ynuIXeXQjS52Tu
	 1w1Nke1TJ14Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] driver core: platform: use bus_type functions
Date: Wed,  9 Sep 2026 07:18:01 -0400
Message-ID: <20260909111805.1804682-3-sashal@kernel.org>
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

[ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]

This works towards the goal mentioned in 2006 in commit 594c8281f905
("[PATCH] Add bus_type probe, remove, shutdown methods.").

The functions are moved to where the other bus_type functions are
defined and renamed to match the already established naming scheme.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c | 132 ++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 67 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 16426eb934632..90166535a5c05 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -743,70 +743,6 @@ struct platform_device *platform_device_register_full(
 }
 EXPORT_SYMBOL_GPL(platform_device_register_full);
 
-static int platform_probe_fail(struct platform_device *pdev);
-
-static int platform_drv_probe(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-	int ret;
-
-	/*
-	 * A driver registered using platform_driver_probe() cannot be bound
-	 * again later because the probe function usually lives in __init code
-	 * and so is gone. For these drivers .probe is set to
-	 * platform_probe_fail in __platform_driver_probe(). Don't even
-	 * prepare clocks and PM domains for these to match the traditional
-	 * behaviour.
-	 */
-	if (unlikely(drv->probe == platform_probe_fail))
-		return -ENXIO;
-
-	ret = of_clk_set_defaults(_dev->of_node, false);
-	if (ret < 0)
-		return ret;
-
-	ret = dev_pm_domain_attach(_dev, true);
-	if (ret)
-		goto out;
-
-	if (drv->probe) {
-		ret = drv->probe(dev);
-		if (ret)
-			dev_pm_domain_detach(_dev, true);
-	}
-
-out:
-	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
-		dev_warn(_dev, "probe deferral not supported\n");
-		ret = -ENXIO;
-	}
-
-	return ret;
-}
-
-static int platform_drv_remove(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
-
-	if (drv->remove)
-		ret = drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
-
-	return ret;
-}
-
-static void platform_drv_shutdown(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-
-	if (drv->shutdown)
-		drv->shutdown(dev);
-}
-
 /**
  * __platform_driver_register - register a driver for platform-level devices
  * @drv: platform driver structure
@@ -817,9 +753,6 @@ int __platform_driver_register(struct platform_driver *drv,
 {
 	drv->driver.owner = owner;
 	drv->driver.bus = &platform_bus_type;
-	drv->driver.probe = platform_drv_probe;
-	drv->driver.remove = platform_drv_remove;
-	drv->driver.shutdown = platform_drv_shutdown;
 
 	return driver_register(&drv->driver);
 }
@@ -1329,6 +1262,68 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int platform_probe(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+	int ret;
+
+	/*
+	 * A driver registered using platform_driver_probe() cannot be bound
+	 * again later because the probe function usually lives in __init code
+	 * and so is gone. For these drivers .probe is set to
+	 * platform_probe_fail in __platform_driver_probe(). Don't even prepare
+	 * clocks and PM domains for these to match the traditional behaviour.
+	 */
+	if (unlikely(drv->probe == platform_probe_fail))
+		return -ENXIO;
+
+	ret = of_clk_set_defaults(_dev->of_node, false);
+	if (ret < 0)
+		return ret;
+
+	ret = dev_pm_domain_attach(_dev, true);
+	if (ret)
+		goto out;
+
+	if (drv->probe) {
+		ret = drv->probe(dev);
+		if (ret)
+			dev_pm_domain_detach(_dev, true);
+	}
+
+out:
+	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
+		dev_warn(_dev, "probe deferral not supported\n");
+		ret = -ENXIO;
+	}
+
+	return ret;
+}
+
+static int platform_remove(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+	int ret = 0;
+
+	if (drv->remove)
+		ret = drv->remove(dev);
+	dev_pm_domain_detach(_dev, true);
+
+	return ret;
+}
+
+static void platform_shutdown(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	if (drv->shutdown)
+		drv->shutdown(dev);
+}
+
+
 int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
@@ -1355,6 +1350,9 @@ struct bus_type platform_bus_type = {
 	.dev_groups	= platform_dev_groups,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
+	.probe		= platform_probe,
+	.remove		= platform_remove,
+	.shutdown	= platform_shutdown,
 	.dma_configure	= platform_dma_configure,
 	.pm		= &platform_dev_pm_ops,
 };
-- 
2.53.0

