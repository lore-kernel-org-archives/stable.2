Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4173793AC;
	Fri, 24 Jul 2026 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870942; cv=none; b=CzD1d0RMSlx2SpeVRFcsZzYet/LhUPZoLGqfeBGr0L1muqjYpBuSfgExD+FA7tSx5aAAix6iQIGOfjyogzzdWza+Me7R+uoQR69+6lbGAL/Z+lEdOfBDmW62fRyeVujSP279vSHju7HZJiJzoOeryvXMFwIus5B9MnDJn1u/dL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870942; c=relaxed/simple;
	bh=5F56TsAfK9IjGi9mmeCF0ZROJhca+Ukll/P8IGDtXgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU0e0PLd4ncl7ZQtg9G6Opd09aWwMlIMTAAaF1+Uj/rgkwjXsOKB3fo8KBibst89fUleGa+Zxqffvd/KXYj36QHt8eY0aZWSv8gI7Z0EPp3yXMMk1H6O53n+ycnEAe9gkVPsgDXsvERd0lzI8ZD2c3XNYTgSKbmNdDitkuxn24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=CMEI6Eqf; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="CMEI6Eqf"
Received: from LAPTOP-99KJFSET (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a1b8;
	Fri, 24 Jul 2026 13:28:53 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	arnd@arndb.de
Cc: linusw@kernel.org,
	brgl@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y 3/4] misc: ti-st: drain published users before transport removal
Date: Fri, 24 Jul 2026 13:28:41 +0800
Message-ID: <20260724052842.1052-4-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260724052842.1052-1-getshell@seu.edu.cn>
References: <20260724052842.1052-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f9299147803a1kunm7e8f9dea24470
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTBpPVk9ISBlMTx5OTBpMGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=CMEI6EqfRkbPAyZ4/NWzA69ns+NcAMh2q4jCVxIwO2UowSu6NoxGGwMfZLF+oyKUzulzc8cYneHyxszwuAosHRG3uulDDplJ9z26CVi1sO3XenKKrLxq0bcrihawCOqB+nlZOMFhftlhwfeNGTMqlMFNIM1nJDXIPEC9tqlwuao=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=L+6y4ptf2rF2GMgt6YAjXEKmOTtNZ8dQMZKG+Yhgwa4=;
	h=date:mime-version:subject:message-id:from;

kim_remove() leaves the transport published while it tears down GPIO,
sysfs state and the core.  A protocol registration or write can therefore
retain the core pointer across kfree().

Under the publication mutex, mark the core as removing and clear its
global slot.  Unregister the line discipline and wait for all previously
accounted users before releasing the core and its parent data.  Keep the
GPIO and platform data valid until those users have drained.

Fixes: 53618cc1e51e ("Staging: sources for ST core")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/misc/ti-st/st_core.c | 25 ++++++++++++++-----------
 drivers/misc/ti-st/st_kim.c  | 22 ++++++++++++----------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 43d2587..3aed6c3 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -906,20 +906,23 @@ err_unreg_ldisc:
 void st_core_exit(struct st_data_s *st_gdata)
 {
 	long err;
+
+	if (!st_gdata)
+		return;
+
+	tty_unregister_ldisc(&st_ldisc_ops);
+	wait_event(st_gdata->users_wait,
+		   !atomic_read(&st_gdata->active_users));
+
 	/* internal module cleanup */
 	err = st_ll_deinit(st_gdata);
 	if (err)
 		pr_err("error during deinit of ST LL %ld", err);
 
-	if (st_gdata != NULL) {
-		/* Free ST Tx Qs and skbs */
-		skb_queue_purge(&st_gdata->txq);
-		skb_queue_purge(&st_gdata->tx_waitq);
-		kfree_skb(st_gdata->rx_skb);
-		kfree_skb(st_gdata->tx_skb);
-		/* TTY ldisc cleanup */
-		tty_unregister_ldisc(&st_ldisc_ops);
-		/* free the global data pointer */
-		kfree(st_gdata);
-	}
+	/* Free ST Tx Qs and skbs */
+	skb_queue_purge(&st_gdata->txq);
+	skb_queue_purge(&st_gdata->tx_waitq);
+	kfree_skb(st_gdata->rx_skb);
+	kfree_skb(st_gdata->tx_skb);
+	kfree(st_gdata);
 }
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 11eadc1..ab84fe6 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -788,28 +788,30 @@ err_core_init:
 
 static int kim_remove(struct platform_device *pdev)
 {
-	/* free the GPIOs requested */
 	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
 	struct kim_data_s	*kim_gdata;
+	int id = 0;
 
 	kim_gdata = platform_get_drvdata(pdev);
-
-	/*
-	 * Free the Bluetooth/FM/GPIO
-	 * nShutdown gpio from the system
-	 */
-	gpio_free(pdata->nshutdown_gpio);
-	pr_info("nshutdown GPIO Freed");
+	if (pdev->id >= 0 && pdev->id < MAX_ST_DEVICES)
+		id = pdev->id;
+	mutex_lock(&st_kim_mutex);
+	kim_gdata->core_data->removing = true;
+	st_kim_devices[id] = NULL;
+	mutex_unlock(&st_kim_mutex);
 
 	debugfs_remove_recursive(kim_debugfs_dir);
 	sysfs_remove_group(&pdev->dev.kobj, &uim_attr_grp);
 	pr_info("sysfs entries removed");
 
-	kim_gdata->kim_pdev = NULL;
 	st_core_exit(kim_gdata->core_data);
+	kim_gdata->core_data = NULL;
+	kim_gdata->kim_pdev = NULL;
+	gpio_free(pdata->nshutdown_gpio);
+	pr_info("nshutdown GPIO Freed");
 
+	platform_set_drvdata(pdev, NULL);
 	kfree(kim_gdata);
-	kim_gdata = NULL;
 	return 0;
 }
 
-- 
2.50.1.windows.1

