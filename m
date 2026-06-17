Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A437B019
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733061; cv=none; b=KpvHl6sxktmfgtQTwk4WdDxvkrsuFbT4FgOAco0qPBUpAZV/dUQg6+OrF+l0hI8SCDoYFxolQzFPJiMs8NWPiPC2YFc3K9/RF4BXkLDaby70Da/apKdADykwmAWmVIlvQgitCavoPLNhQzymGa+QKVl9o64qUdgDShp3p46QEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733061; c=relaxed/simple;
	bh=kL45Mc7Sq4nBr5NUSqDvH9IUpwxeqKCAFVLc5pfHjZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFipUK8Qn7ykxmQDGPYdEtD8jU/yF7joESnPy/BFgWlCaA1pxqSlk7O2CNq4Bpx7PuKBVo8irldjD/mugo5D6hZE/3+orAA6v7sUccf4mUUPYKNSECk98oOovCxPobEHpEXFx3D8VnDNd4/bP2CgEbHxricBULBydKX46W/P+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqukwhfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqukwhfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB401F000E9;
	Wed, 17 Jun 2026 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733060;
	bh=0b2KrVXaqDKNrtDBc4d7BmFwzDubWQWObJigDaiSjcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqukwhfxPcltJV1TIZRnVt/CBAC3/2qydQL9y9fpWp9FJSy5sDWPykrRaDKgH4vdX
	 NTG9JMeG6Mwt1lk+7gnhYnCD5jSe0dNbnjdz74e6q4e/wrauiLtKN0PsuXo/BH9IZB
	 WRxPRqgKf9dGIXXhlxKnLn0gBZBhYBrpgC5qgPPf0E4xvRX18wLxJ2VBTtVTv+Aq97
	 kMN1n0gvBkevltpdv8Iu8B/lscyhRx0QqH0rff+nRCIU9rMMppUq9xitNGq7sogrLe
	 eqtATKQRYhrWqhUAjApXD7irK8szIVKEz62EnpMg4u26KVKAYCYqF6mm67tMQptnn6
	 3b1SK4yuYZUTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] slimbus: Convert to platform remove callback returning void
Date: Wed, 17 Jun 2026 17:50:55 -0400
Message-ID: <20260617215058.418058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061509-identical-efficient-87fe@gregkh>
References: <2026061509-identical-efficient-87fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 880b33b0580c8ac9d0202b6e592cb116c99d1b65 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert the slimbus drivers from always returning zero in the
remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240430091657.35428-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2a9d50e9ea40 ("slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ctrl.c     |  5 ++---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ec58091fc948a2..5866014f0e2327 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -630,7 +630,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_remove(struct platform_device *pdev)
+static void qcom_slim_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -639,7 +639,6 @@ static int qcom_slim_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ctrl->rclk);
 	clk_disable_unprepare(ctrl->hclk);
 	destroy_workqueue(ctrl->rxwq);
-	return 0;
 }
 
 /*
@@ -726,7 +725,7 @@ static const struct of_device_id qcom_slim_dt_match[] = {
 
 static struct platform_driver qcom_slim_driver = {
 	.probe = qcom_slim_probe,
-	.remove = qcom_slim_remove,
+	.remove_new = qcom_slim_remove,
 	.driver	= {
 		.name = "qcom_slim_ctrl",
 		.of_match_table = qcom_slim_dt_match,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ed1eb491430bac..4f939455f039cd 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1595,14 +1595,12 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
+static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
 	platform_driver_unregister(&qcom_slim_ngd_driver);
-
-	return 0;
 }
 
-static int qcom_slim_ngd_remove(struct platform_device *pdev)
+static void qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -1617,7 +1615,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-	return 0;
 }
 
 static int __maybe_unused qcom_slim_ngd_runtime_idle(struct device *dev)
@@ -1660,7 +1657,7 @@ static const struct dev_pm_ops qcom_slim_ngd_dev_pm_ops = {
 
 static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 	.probe = qcom_slim_ngd_ctrl_probe,
-	.remove = qcom_slim_ngd_ctrl_remove,
+	.remove_new = qcom_slim_ngd_ctrl_remove,
 	.driver	= {
 		.name = "qcom,slim-ngd-ctrl",
 		.of_match_table = qcom_slim_ngd_dt_match,
@@ -1669,7 +1666,7 @@ static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 
 static struct platform_driver qcom_slim_ngd_driver = {
 	.probe = qcom_slim_ngd_probe,
-	.remove = qcom_slim_ngd_remove,
+	.remove_new = qcom_slim_ngd_remove,
 	.driver	= {
 		.name = QCOM_SLIM_NGD_DRV_NAME,
 		.pm = &qcom_slim_ngd_dev_pm_ops,
-- 
2.53.0

