Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196144;
	b=GJPEZqaCI/zyVcCnkzzLUqQ3LM4+TvlXStKa23RojWZjqAtyvvnRd/tQbJb3YBFJLEmY
	 jLP7aGIIa2C1OfbBpSxo1vWkSvJftxYqLSptWlxDJcUjPMm9FYk4a0xh/jFZog1Zm+RDW
	 CXlASvBfPkjdbnu/OjLhc5UsLenkPOx3VYBQ/Jg8bNaAEV3mY83hAnGcJ6ai6Ttgoe+fz
	 hWw82advrtswadUcDaI8phjoZbSNW6oT1w1VbA9fCWOC8zrvi3K5UFGIKBYJdz7LaLnnw
	 3z97I9fDFD+ZB5vSyiqqDYBY62IaKJYi7rKe8JDUrpK4wQGwiyRfzpdGuao4LmWEZVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196144;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=KFuB17UBx3dmAUo4Do73D0BjXXKCh6ehL5UyXgHwGCE=;
	b=bZF+PvWFibGmbh28HgnvTeri5QK7Wr47RflnGrX+LuHex55VdG4xKmrAUjnQlDfOMODO
	 SLqYlJu0U/CYu+6RRM4QF5OoQZ2jwg0i4pa63bEpJMO+QBoHYyKJEwuHasNLV53H5ft7O
	 JCDl8az4MTJ47e7yulJy5xPjHB7Fuz/FL97cVA5I3UHTWY+5T6bTMzyFIwdXcZCd8wFT0
	 z9FLIGC52GSYOUA4fRz8WUNNc0kHt7FYZiPFhY5AJkS0AuHsg0qECnwSOhhx3PKk3Icvp
	 IlS9ZOD3ykj5fSqTGNug/nCtE+ma9G2aOeZ1SsftbAG5QOFPaV9oiGJyfH88c+Y13wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=U0h+PKV0;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242D60A2627;
	Fri, 20 Nov 2026 17:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0242D60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=U0h+PKV0
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5573c0ac1;
	Sat, 21 Nov 2026 01:35:34 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] thermal: qcom: tsens: Fix potential repeated removal of shared debugfs root
Date: Sat, 21 Nov 2026 01:35:32 +0800
Message-ID: <20261120173533.3924126-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1fa0723e303a1kunm13f08662238bb4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHU5KVhgaSEIaTUsZHkkfSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=U0h+PKV089Y9v2y82Tb/jss73lpZ1diiYfFdkaY9D+Zh6xJIVe9fTd7yF1HoBsOMp0kxonrelzb/FIfy8GJfYRm4kXyqYQXKZzgpO6x7y0uuzBbXVTjLrvjFSYjZY7FeJx0kLWV5M0JhsOTvvtoXhK17tL8KVAEevTRh4T3i+Rw=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=KFuB17UBx3dmAUo4Do73D0BjXXKCh6ehL5UyXgHwGCE=;
	h=date:mime-version:subject:message-id:from;

Each TSENS instance stores the same debugfs root and removes it during
teardown. Removing one instance therefore removes the files of its
peers, and subsequent removal operates on the same root again.

Own the root at driver initialization and exit. Each instance only
removes its own directory, leaving the shared root to the driver.

This issue was found by our static analysis tool under development.

Fixes: 7c938f4837ab ("drivers: thermal: tsens: Add debugfs support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/thermal/qcom/tsens.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4d7013fc79d6..e0fdeafdca30 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -22,6 +22,8 @@
 #include "../thermal_hwmon.h"
 #include "tsens.h"
 
+static struct dentry *tsens_debugfs_root;
+
 /**
  * struct tsens_irq_data - IRQ status and temperature violations
  * @up_viol:        upper threshold violated
@@ -902,12 +904,8 @@ static void tsens_debug_init(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
-	priv->debug_root = debugfs_lookup("tsens", NULL);
-	if (!priv->debug_root)
-		priv->debug_root = debugfs_create_dir("tsens", NULL);
-
 	/* A directory for each instance of the TSENS IP */
-	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), tsens_debugfs_root);
 	debugfs_create_file("version", 0444, priv->debug, pdev, &dbg_version_fops);
 	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
 }
@@ -1459,7 +1457,7 @@ static void tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
-	debugfs_remove_recursive(priv->debug_root);
+	debugfs_remove_recursive(priv->debug);
 	tsens_disable_irq(priv);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
@@ -1474,7 +1472,26 @@ static struct platform_driver tsens_driver = {
 		.of_match_table = tsens_table,
 	},
 };
-module_platform_driver(tsens_driver);
+
+static int __init tsens_init(void)
+{
+	int ret;
+
+	tsens_debugfs_root = debugfs_create_dir("tsens", NULL);
+	ret = platform_driver_register(&tsens_driver);
+	if (ret)
+		debugfs_remove_recursive(tsens_debugfs_root);
+
+	return ret;
+}
+module_init(tsens_init);
+
+static void __exit tsens_exit(void)
+{
+	platform_driver_unregister(&tsens_driver);
+	debugfs_remove_recursive(tsens_debugfs_root);
+}
+module_exit(tsens_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("QCOM Temperature Sensor driver");

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
