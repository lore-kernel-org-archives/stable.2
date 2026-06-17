Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115328CF5D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728444; cv=none; b=AtwCsaNKSxUCbP2DqVgGBk21EdWSfISckegn2Dp+3MplfqkJgTPL3dg4h7M86zTP7bq7RikA4nwoqfmdyOf8bK+9uSWudZnw+LZoMBL/mUN1fo4gnPOAu8t8Sz0VlzbJELFjZDqIepMG5XCUgKFACJ5N7m0jxxQ6VMQ1Jc+HjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728444; c=relaxed/simple;
	bh=sMGr5ug+hsZO4kQSIrbuq06XSdG5xIeAW1C2O9ov4zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TV8LIlwAWjWiginFMAxsumPMjHa3+z9TwR5T3VKwIrHapo5fhCMwWPfzh8nQ1skrZoG5U0MpBCeJm9vOGkIddpboixgtd0A7+I7CaKX8CMmgiCHJCTFRhXFa07PftjegRJ+fa6W5/m/GLsD8nU6gdVcF8wIXQ7fdqOVFnsvDXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAiQYr4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAiQYr4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1D31F000E9;
	Wed, 17 Jun 2026 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728443;
	bh=xvrfebBA1DS3FCUHk7mIpra8jRQT6duXlISJByAfmTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAiQYr4BLwUCd1bABh3KfaRo0JIWxAe8FqGPVm8ldAP+8XyteLAp8UJIF+gNloPds
	 1v9orefztcC54SyNt7e1IvBSVeihawSofmSHj3mHe9TDOpJIbJ4mga2I17q+73kL/v
	 lHaWpzseUa8SNs/zU3GGLUPa/xyJnSTgxginJeH8ukqXhr1skwjmW12k9ksxmZnG4c
	 kMIxmoG64dLQHALgP88wTDHvC48pZ9i7Wz6LnItE+bvY0+mH7rVrXvGa7x8Aq1M0aD
	 47oCHeg6pe9oEPBlM9XoGwILK3B6iNwcSDn32xdI7ViJNbpyxlBdk5evvrE4PeZ//T
	 D66UFk1TxnluA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] slimbus: Convert to platform remove callback returning void
Date: Wed, 17 Jun 2026 16:33:57 -0400
Message-ID: <20260617203400.334600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061507-squishy-ankle-c2e7@gregkh>
References: <2026061507-squishy-ankle-c2e7@gregkh>
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
index c0c4f895d76e20..31f46000ca030f 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -628,7 +628,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_remove(struct platform_device *pdev)
+static void qcom_slim_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -637,7 +637,6 @@ static int qcom_slim_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ctrl->rclk);
 	clk_disable_unprepare(ctrl->hclk);
 	destroy_workqueue(ctrl->rxwq);
-	return 0;
 }
 
 /*
@@ -724,7 +723,7 @@ static const struct of_device_id qcom_slim_dt_match[] = {
 
 static struct platform_driver qcom_slim_driver = {
 	.probe = qcom_slim_probe,
-	.remove = qcom_slim_remove,
+	.remove_new = qcom_slim_remove,
 	.driver	= {
 		.name = "qcom_slim_ctrl",
 		.of_match_table = qcom_slim_dt_match,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3fa245a472b2ee..55739ed04fb84b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1607,14 +1607,12 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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
 
@@ -1629,7 +1627,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-	return 0;
 }
 
 static int __maybe_unused qcom_slim_ngd_runtime_idle(struct device *dev)
@@ -1672,7 +1669,7 @@ static const struct dev_pm_ops qcom_slim_ngd_dev_pm_ops = {
 
 static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 	.probe = qcom_slim_ngd_ctrl_probe,
-	.remove = qcom_slim_ngd_ctrl_remove,
+	.remove_new = qcom_slim_ngd_ctrl_remove,
 	.driver	= {
 		.name = "qcom,slim-ngd-ctrl",
 		.of_match_table = qcom_slim_ngd_dt_match,
@@ -1681,7 +1678,7 @@ static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 
 static struct platform_driver qcom_slim_ngd_driver = {
 	.probe = qcom_slim_ngd_probe,
-	.remove = qcom_slim_ngd_remove,
+	.remove_new = qcom_slim_ngd_remove,
 	.driver	= {
 		.name = QCOM_SLIM_NGD_DRV_NAME,
 		.pm = &qcom_slim_ngd_dev_pm_ops,
-- 
2.53.0

