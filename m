Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DB40B0F9
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134161; cv=none; b=h50ng7ozEOmrGlPsB/kDm9DUz3EGKVKA88xFAdIuAYSUo0wyo1DKm255OdEsRfPxHpOx+SZssMeJ2GTjhBuFFm4QuUnxPNO2bZpmyzolv/FFZeaPIJCuhtZYSsiZuepND/eY4doUb2bkqwVM1RXBgQlv/S8Xr7J75qR/HxXA8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134161; c=relaxed/simple;
	bh=65eiDUc8ECIcVZs4jAOfp1TiWyBBRf3rpD1YA79xeZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHXxuOVHIkUmQMJ9topYb9DRV7GyM7AlKKbr9pkS1UBiNe5thFurrQhJG/6lXa0ZyCHuJWXH4EO/jRSnSuO8rKd+YF5JzF9YA+YBtS20hgp9J8ZPAq0vpeDxztYdJ1sxbEM+0B7mSBJk9/0fkHK2pAoov0Zlmg0HwWS3jirMpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl1Gk/7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl1Gk/7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D491F00893;
	Sun,  4 Oct 2026 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791134158;
	bh=VJU3N0/XxUG29ibcBvcyF1ZcJkW4tPaXTG5fB2exWYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vl1Gk/7XYNNJ6MQo+I5ieu/wtuDNSmHx1DyoxrLjGSGQqlgrynAxeLYjm4S1BuvqA
	 6vRcBr/n57uGEZBmFTE7FofhrapuURxJRB4quuHWU5szi/HcET6zj/YZRTO2ML0D7I
	 KWgvq7n6FooAlARJ0UcZcD4jKTOcCFMgOCnlvc4IzLL7NOQ+PH9daJKmsZ3i19PTrB
	 steZmmd1/wWUYOwIgUM3A4UO3zEoJl2WH8cV+dt1AGZ4fW7OC9vwqY8aRH2mmQzaLh
	 w72qdQ8JxLBxTU40gUZdFF0pw8TgNGtmQmQXaYuUb4h7ZYs3iHImcgGC7gY1/ldWFp
	 JdmRgIJuP4Z9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] wifi: wlcore: Convert to platform remove callback returning void
Date: Sun,  4 Oct 2026 13:15:54 -0400
Message-ID: <20261004171541.901037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100446-quaintly-establish-1f37@gregkh>
References: <2026100446-quaintly-establish-1f37@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit f00928012886a07ca6817ea70eb4856ce280ce05 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code.  However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

wlcore_remove() returned zero unconditionally. With that converted to
return void instead, the wl12xx and wl18xx driver can be converted to
.remove_new trivially.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230912171249.755901-1-u.kleine-koenig@pengutronix.de
Stable-dep-of: a8b8881d0c1a ("wifi: wlcore: Fix runtime PM leak in wlcore_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wl12xx/main.c   | 6 +++---
 drivers/net/wireless/ti/wl18xx/main.c   | 2 +-
 drivers/net/wireless/ti/wlcore/main.c   | 6 ++----
 drivers/net/wireless/ti/wlcore/wlcore.h | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/ti/wl12xx/main.c
index d06a2c4194479..de045fe4ca1eb 100644
--- a/drivers/net/wireless/ti/wl12xx/main.c
+++ b/drivers/net/wireless/ti/wl12xx/main.c
@@ -1919,7 +1919,7 @@ static int wl12xx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wl12xx_remove(struct platform_device *pdev)
+static void wl12xx_remove(struct platform_device *pdev)
 {
 	struct wl1271 *wl = platform_get_drvdata(pdev);
 	struct wl12xx_priv *priv;
@@ -1928,7 +1928,7 @@ static int wl12xx_remove(struct platform_device *pdev)
 
 	kfree(priv->rx_mem_addr);
 
-	return wlcore_remove(pdev);
+	wlcore_remove(pdev);
 }
 
 static const struct platform_device_id wl12xx_id_table[] = {
@@ -1939,7 +1939,7 @@ MODULE_DEVICE_TABLE(platform, wl12xx_id_table);
 
 static struct platform_driver wl12xx_driver = {
 	.probe		= wl12xx_probe,
-	.remove		= wl12xx_remove,
+	.remove_new	= wl12xx_remove,
 	.id_table	= wl12xx_id_table,
 	.driver = {
 		.name	= "wl12xx_driver",
diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 0b3cf8477c6cd..d4a89401f2c47 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -2033,7 +2033,7 @@ MODULE_DEVICE_TABLE(platform, wl18xx_id_table);
 
 static struct platform_driver wl18xx_driver = {
 	.probe		= wl18xx_probe,
-	.remove		= wlcore_remove,
+	.remove_new	= wlcore_remove,
 	.id_table	= wl18xx_id_table,
 	.driver = {
 		.name	= "wl18xx_driver",
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index f472d4bd77fbc..535b47e54d6ab 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6735,7 +6735,7 @@ int wlcore_probe(struct wl1271 *wl, struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(wlcore_probe);
 
-int wlcore_remove(struct platform_device *pdev)
+void wlcore_remove(struct platform_device *pdev)
 {
 	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
 	struct wl1271 *wl = platform_get_drvdata(pdev);
@@ -6750,7 +6750,7 @@ int wlcore_remove(struct platform_device *pdev)
 	if (pdev_data->family && pdev_data->family->nvs_name)
 		wait_for_completion(&wl->nvs_loading_complete);
 	if (!wl->initialized)
-		return 0;
+		return;
 
 	if (wl->wakeirq >= 0) {
 		dev_pm_clear_wake_irq(wl->dev);
@@ -6770,8 +6770,6 @@ int wlcore_remove(struct platform_device *pdev)
 
 	free_irq(wl->irq, wl);
 	wlcore_free_hw(wl);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(wlcore_remove);
 
diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
index 81c94d390623b..1f8511bf9bb35 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore.h
@@ -497,7 +497,7 @@ struct wl1271 {
 };
 
 int wlcore_probe(struct wl1271 *wl, struct platform_device *pdev);
-int wlcore_remove(struct platform_device *pdev);
+void wlcore_remove(struct platform_device *pdev);
 struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 				     u32 mbox_size);
 int wlcore_free_hw(struct wl1271 *wl);
-- 
2.53.0

