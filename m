Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010451589F;
	Tue, 29 Sep 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688179; cv=none; b=szDgxdQFxcc/iq+/2XKahNtqGGZtDnZaxIWrlUh/fyd9gqc2HK+WhoWEYhuGE+Z+oZ/5VmwKgBOP8SF9XimwAv1U/HaMa8q5pqLcO8H8qCD5y5B/mGhK02gCEE3kiT6+ItTB05O6WKD/OGC7bkFKc4Mc/xzKuZ7uI4qrldp4X04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688179; c=relaxed/simple;
	bh=OOQ3txDD7lpypqd+9QCjt4HfYZMYRTlZsC3KqCtpDGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t48nUDG9U2JSLDM11PMfqIasZqPFfmCsnUnihh05ez/999iJXdKXjQnT04GHvKgqLnf1dX9x9dbRBLxaXISNI1YsC9d4PgEbR1e1xCvEZ56l9ZG05lVi8Q8k2fzQVWXg0rbTUyFotpnSCJg+u0J4UiRQqAyGLyFpu6kIsZP2zGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BINMJshN; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BINMJshN"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f82b2d62;
	Tue, 29 Sep 2026 21:22:51 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] mei: vsc-tp: initialize IRQ state before requesting interrupt
Date: Tue, 29 Sep 2026 21:22:45 +0800
Message-Id: <20260929132245.2152433-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ed55152c03a1kunm664b971e23fe27
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0sYVk8eT0tPHkxNQk1MTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BINMJshNnwi23i/B8cLCT4pKJVlavGBe08la17sljelWNohoNhYfvobXPpZ3KTxNb/fKP5R1ZoCtadmrfArP/UyvYb/T38rDR24g8pkWPEyZ49ysiaDrPJVy2frFlc8BFymACoCQ8e10Vwfh601tVly1Y+ztAzuNiDATjbdCGlk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=J9e45uD5BKyPsbkbL8G9Z1TokeQZHUZwd6InRM+P/xE=;
	h=date:mime-version:subject:message-id:from;

request_threaded_irq() enables the interrupt before returning, so the
threaded handler may schedule work while the probe is still initializing
its mutexes and work item. Initialize that state first and only free the
IRQ on paths where the request succeeded.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/misc/mei/vsc-tp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 432bc59f1..a5f56121e 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -496,30 +496,30 @@ static int vsc_tp_probe(struct spi_device *spi)
 	init_waitqueue_head(&tp->xfer_wait);
 	tp->spi = spi;
 
+	mutex_init(&tp->mutex);
+	mutex_init(&tp->event_notify_mutex);
+	INIT_WORK(&tp->event_work, vsc_tp_event_work);
+
 	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
 	ret = request_threaded_irq(spi->irq, NULL, vsc_tp_isr,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   dev_name(dev), tp);
 	if (ret)
-		return ret;
-
-	mutex_init(&tp->mutex);
-	mutex_init(&tp->event_notify_mutex);
-	INIT_WORK(&tp->event_work, vsc_tp_event_work);
+		goto err_destroy_lock;
 
 	/* only one child acpi device */
 	ret = acpi_dev_for_each_child(ACPI_COMPANION(dev),
 				      vsc_tp_match_any, &adev);
 	if (!ret) {
 		ret = -ENODEV;
-		goto err_destroy_lock;
+		goto err_free_irq;
 	}
 
 	pinfo.fwnode = acpi_fwnode_handle(adev);
 	pdev = platform_device_register_full(&pinfo);
 	if (IS_ERR(pdev)) {
 		ret = PTR_ERR(pdev);
-		goto err_destroy_lock;
+		goto err_free_irq;
 	}
 
 	tp->pdev = pdev;
@@ -527,9 +527,10 @@ static int vsc_tp_probe(struct spi_device *spi)
 
 	return 0;
 
-err_destroy_lock:
+err_free_irq:
 	free_irq(spi->irq, tp);
 
+err_destroy_lock:
 	cancel_work_sync(&tp->event_work);
 	mutex_destroy(&tp->event_notify_mutex);
 	mutex_destroy(&tp->mutex);
-- 
2.34.1
