Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27676446859
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531800; cv=none; b=KYMzt581iVXlUPLodt1My2On4CaZKq24W9Vth/Ds6CC5UFwCF0K9w7C/NZonFt7HKZz1fPCcSv6aFQH1ldMYOwKmZYIcRnOvszpDrwVbubZf/RrlMi7bMXujxLJnmP1NJNgGFUs/1OlswSC1WG0n+7TgtDHc2hCItj/9Dy5E8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531800; c=relaxed/simple;
	bh=eO3lwemXvrMRbuBfi+Bc3EPcTylp1ir9432SDGq5c4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SexYO4T8xeDKysPCZXToag5LmnpQHorppRHByh56ff7mCRcAdSoz4FDHf+Hu5K1tq9sWvgqOVBEwKxUQm4Jx/2riFkrj4dANn5B4k5o7r1na/Diif8OFg/38l/Jje9aGz/3U+m1mCE6ihEDRUkVqQto7CH/B1LbeSt5Q96122XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm4UwYfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm4UwYfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDF41F00A3D;
	Fri,  4 Sep 2026 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531798;
	bh=wnzRK3HlDNXlDdnxZSpXFT3X8xHgFldfP50o1kH8QIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gm4UwYfnl+1gAEgZzTdl+v/kUZdk22RVXKcrY4EE2mNQQHB8jGB9CeILUcId4MjQj
	 oVtZJvxEfwJFGAkmCSFivhtBFL7/kQntoStI4yar4FubniPUPAJhJkqpgCyomIMs8H
	 8zZrgRc2tJFfOUzNFj6eXnqmXyQdT6A5xfeQ5Yz0TBNsDNNQDnZfClgE1OdgLayGHf
	 KX/brvwbqhqYCrIvy40JcXlC+71nRxUzYMJw5ZKjE045ii2Vqgw8XvprRru0DfUH0o
	 O/kmzlvdv0nJRAIOF5Lw3rqhyK1SM3qwXXX92hp7gD+OEex7cgNgey4hY4wj/zW8yS
	 L7wY+hDJ6mZNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] serial: imx: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 10:23:15 -0400
Message-ID: <20260904142316.780585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-applause-active-107a@gregkh>
References: <2026090333-applause-active-107a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c066f87314b7fbbf4d72d38957436a98e7b7e503 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231110152927.70601-18-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8b0b29fdcb47 ("serial: imx: serialize imx_uart_ports[] lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c         |  4 +++-
 drivers/tty/serial/imx.c        |  6 +++---
 include/linux/platform_device.h | 11 +++++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 647066229fec3..94a4c8184cc91 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -783,7 +783,9 @@ static int platform_drv_remove(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret = 0;
 
-	if (drv->remove)
+	if (drv->remove_new)
+		drv->remove_new(dev);
+	else if (drv->remove)
 		ret = drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6e49928bb8646..b558cee2966f3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2467,11 +2467,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_uart_remove(struct platform_device *pdev)
+static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
@@ -2638,7 +2638,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 
 static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
-	.remove = imx_uart_remove,
+	.remove_new = imx_uart_remove,
 
 	.id_table = imx_uart_devtype,
 	.driver = {
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index e7a83b0218077..331d785505e98 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -203,7 +203,18 @@ extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
+
+	/*
+	 * Traditionally the remove callback returned an int which however is
+	 * ignored by the driver core. This led to wrong expectations by driver
+	 * authors who thought returning an error code was a valid error
+	 * handling strategy. To convert to a callback returning void, new
+	 * drivers should implement .remove_new() until the conversion is done
+	 * that eventually makes .remove() return void.
+	 */
 	int (*remove)(struct platform_device *);
+	void (*remove_new)(struct platform_device *);
+
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
 	int (*resume)(struct platform_device *);
-- 
2.53.0

