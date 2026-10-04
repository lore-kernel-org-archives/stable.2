Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D443F4B8
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147889; cv=none; b=Sk+M/e/sYu4BGyDP5680CiuqEG5i3NX7krDNiDxt4rg3CJkBD98bxDUjReV3Jc5CcGz6IXhcOmItTjrNtMWv6pqvl6m1ljv/5GfcvRizDu9tWkANuEOo9Lw2sTPx1IfgeaAgSk6CvW/bS2Ozd12jroUC5YyHFFVRc05i6IUoNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147889; c=relaxed/simple;
	bh=VZqB+0XvEiVduxeGBeit6IRjxo4ihWt/yhVVmDiU3mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WutkWYHhJK/+/VaT/JWNvGfUSVFa0OmB5W2ZVHlhRV1LI3cE/YwVxOymHmzt9W/ACjUaJ6X8BDVr4idLka4ElNNHKTeJtb4aauCIM+rXaR8/qmD4O9II4dU7kE66NqQlj9bZTYgHX2Rpe63Lw9FjIZheox7rIPvkw3gXua3ExeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYV/Gu3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYV/Gu3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991131F000FF;
	Sun,  4 Oct 2026 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147887;
	bh=TDG14GEglpV1DeagzHyppXzfYykYnl72TNObMnVhs7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYV/Gu3ne9eD2fbcm//2ksibWu4b6gh2ZjxANjqNfvy/cHuRQVDmqBWKxbEpSAvVk
	 se9erF0I4j9g8no9yY4OPYnNwXlrlg8VEV3LyWTtoLCk76OWirlzera6MLvZA5Kpbg
	 6tip4udzvdlcMvDZpkXd2KEsR8sIFaf3sP7Jzxrkef+s/33sxTlcwk71+KZ2ziYefi
	 w1D9Nd652e9C6CeSj0Ssic8RlXCeYj8fpLs0HePhHbPM91Nx5o3i8dbuPBAo1ltZ/v
	 dvSFc30Vv7bd8XMiVLH6o/UsvC8Qk9O30CayxtpCYoxHgE3T0HTQ/aErMVbJjHz93z
	 1w3L/QMQPo+tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: wlcore: Convert to platform remove callback returning void
Date: Sun,  4 Oct 2026 17:04:43 -0400
Message-ID: <20261004210417.1052493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100446-celtic-uplifting-ac0e@gregkh>
References: <2026100446-celtic-uplifting-ac0e@gregkh>
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
index 2c3f7fbd04330..b5ae25e7ed897 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6734,7 +6734,7 @@ int wlcore_probe(struct wl1271 *wl, struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(wlcore_probe);
 
-int wlcore_remove(struct platform_device *pdev)
+void wlcore_remove(struct platform_device *pdev)
 {
 	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
 	struct wl1271 *wl = platform_get_drvdata(pdev);
@@ -6749,7 +6749,7 @@ int wlcore_remove(struct platform_device *pdev)
 	if (pdev_data->family && pdev_data->family->nvs_name)
 		wait_for_completion(&wl->nvs_loading_complete);
 	if (!wl->initialized)
-		return 0;
+		return;
 
 	if (wl->wakeirq >= 0) {
 		dev_pm_clear_wake_irq(wl->dev);
@@ -6769,8 +6769,6 @@ int wlcore_remove(struct platform_device *pdev)
 
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

