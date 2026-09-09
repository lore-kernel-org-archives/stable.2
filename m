Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690983D5666
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952917; cv=none; b=ulRZfFTPk0EP/4MS6JIs2crJGG1H7s6nl6rN5isd3zCUzXG/0c9R5afRArXn2k7asJlRCo9P1osUTXvPFR9mxNKQ/4jVQE/lsSl0+VbvvWO0idIJa54VpGWlwMItjeqETRc/vf2c3JRakCb7EXoN7mtqg9qJQrltxF+wYBlIU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952917; c=relaxed/simple;
	bh=vvg+uhJ1QG61/nO3pNepF1KPt3FmLrU/BFzYqpFdkVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgS+DpAEbwSyxbV0RI9lXFCfFM5tI6tioEu+m0OKq5LwvcjdEHfA9rXw3Cz2y7iGv0PCZVPdW07uDDlBQEEKBtiF+Bq+voMaOoTf79bOowwZTThjpiFUNb0mPS9jWru8Tq7YX7WlK3lXNy2fwB9lG6XPYCFnjuytUN8nEMz1qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4kLHZJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4kLHZJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2711F00A3A;
	Wed,  9 Sep 2026 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952916;
	bh=Dol3uI5jFpQ1rqJ1/J0mguD8ss43Xbrf1v6s6m3Tznw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4kLHZJQn4MROQsVTIjMH+PQtMDZ+fzP4F2bRGB85RiKAa9XyqcUn6H3GJrv24Z6M
	 9Zh1h66W6z6kpgEN95wGDXOy3ZjPFcsP01jR2bDt70enwqMWYDEuYb2Vq+oq2lpTgS
	 etFyYZ78j787IGMWPrSecMVzLt0FiQGUHO12aLUOrxfO8BgArovmcuZidv5PBO0yWV
	 8wCMzGoMbOPe0SfZz7Clhh8b111AR1OSLS3I26Y3SDVlHOe4Zj2kNjcBZo2g6VWIxp
	 HORTaXb17wkakac40iyyCTO01BTK0l3WqbqV15UeZjq5s8x1IkPmk9ct7tP82hpanF
	 6iE8JmYI0ghHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/8] driver core: platform: change logic implementing platform_driver_probe
Date: Wed,  9 Sep 2026 07:21:47 -0400
Message-ID: <20260909112153.1816689-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112153.1816689-1-sashal@kernel.org>
References: <2026090353-unadorned-buffed-09ad@gregkh>
 <20260909112153.1816689-1-sashal@kernel.org>
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
Stable-dep-of: 831c29a12d56 ("power: supply: lp8788-charger: fix use-after-free on remove")
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

