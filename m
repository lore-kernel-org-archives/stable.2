Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A0319F115;
	Tue,  8 Sep 2026 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841366; cv=none; b=WRCiOk/9f3rGqzrSGLIbcrHBvBJlLIckXlZ3tilxsEppbg2ptrNA8nuHLnIBqKsRhp5vERbOk8SxlfWAunszN9IskxtIL//CQ6P14bujoQE9lxJuZSk8RLND0Uxixz/4uGqwrrSVtPTrgLNWs3DazBQ5jI6JNq1RDEUeS+eJ8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841366; c=relaxed/simple;
	bh=qFAx9w5djwomjCqZF/+EPZjtBV3yE4+cb/UYRsC23+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrjss80r0cITUmwkUknz/X/rRsMZIJtRyuB3T9Me/dOSXRKkKopWG4aJJGhKH6kR7dyyaHfSFRHEo9kjDsrl8ONg3/qIl+FIv9TSoRXDicpDd0rp9vYpz3e77sThuP6wREo95ANNOsJTvk6dpYBBacQum5Hg9RrwkW1v3JBEWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3EX6DjZ9qJ0v9AA--.22841S3;
	Tue, 08 Sep 2026 12:22:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCnPKeDjZ9qvzlkBA--.62142S2;
	Tue, 08 Sep 2026 12:22:27 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	benh@kernel.crashing.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] usb: gadget: aspeed-vhub: cancel wake work on device removal
Date: Tue,  8 Sep 2026 04:17:39 +0000
Message-Id: <20260908041740.613713-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCnPKeDjZ9qvzlkBA--.62142S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?aQaxtQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBHBKz8wg5YwzVCsKXh9KORbDx6nCOS/gp/XLEQsM9WWEs6A
	SAYFFf03ZgYa92J2mMSp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxZFW5Jw17WF1kCF4fKF4rJFc_yoW7JFW8pa
	15JrWxAFWDtFnFgrWUJrs3XF45G393KFWUGrW7Xw4YvF93Aryvyry7tFWFqa1UAFWIyF9I
	9F4qqr4UXFs5XrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

wake_work is armed from the gadget .wakeup callback to resume suspended
downstream ports, and it is never cancelled in ast_vhub_remove(), so a
work item queued before or during removal can run after devm has freed
vhub and its ports, a use-after-free.

Cancelling the work alone is not sufficient: usb_gadget_wakeup() takes
no lock and the unbind path never clears wakeup_en, so a remote-wakeup
request in flight on another CPU can re-arm the work after the cancel
and before vhub is freed.

ast_vhub_del_dev() already clears d->registered under vhub->lock before
unregistering the gadget. Refuse the wakeup in ast_vhub_udc_wakeup()
once d->registered is clear: the check and the schedule_work() are then
atomic against the unbind, so a wakeup that passed before the flag was
cleared is drained by the cancel_work_sync() after the del_dev loop,
and one that arrives later returns without arming. Also move INIT_WORK()
to the top of ast_vhub_probe(), since the probe error path reuses
ast_vhub_remove() and would otherwise cancel a never-initialized work
item.

This issue was found by an in-house static analysis tool.

Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 4 ++++
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 5 +++--
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 4a8b9ff83..069673f0d 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -267,6 +267,9 @@ static void ast_vhub_remove(struct platform_device *pdev)
 	for (i = 0; i < vhub->max_ports; i++)
 		ast_vhub_del_dev(&vhub->ports[i].dev);
 
+	/* Final drain; the worker takes vhub->lock, so stay outside of it */
+	cancel_work_sync(&vhub->wake_work);
+
 	spin_lock_irqsave(&vhub->lock, flags);
 
 	/* Mask & ack all interrupts  */
@@ -328,6 +331,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&vhub->lock);
+	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
 	vhub->pdev = pdev;
 	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
 				      VHUB_IRQ_DEV1_BIT);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 8b9449d16..4b389de0d 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -280,7 +280,7 @@ static int ast_vhub_udc_wakeup(struct usb_gadget* gadget)
 	int rc = -EINVAL;
 
 	spin_lock_irqsave(&d->vhub->lock, flags);
-	if (!d->wakeup_en)
+	if (!d->wakeup_en || !d->registered)
 		goto err;
 
 	DDBG(d, "Device initiated wakeup\n");
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 02fe1a08d..d0345f310 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -558,7 +558,7 @@ void ast_vhub_device_connect(struct ast_vhub *vhub,
 		ast_vhub_send_host_wakeup(vhub);
 }
 
-static void ast_vhub_wake_work(struct work_struct *work)
+void ast_vhub_wake_work(struct work_struct *work)
 {
 	struct ast_vhub *vhub = container_of(work,
 					     struct ast_vhub,
@@ -588,6 +588,8 @@ static void ast_vhub_wake_work(struct work_struct *work)
 
 void ast_vhub_hub_wake_all(struct ast_vhub *vhub)
 {
+	lockdep_assert_held(&vhub->lock);
+
 	/*
 	 * A device is trying to wake the world, because this
 	 * can recurse into the device, we break the call chain
@@ -1076,7 +1078,6 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 int ast_vhub_init_hub(struct ast_vhub *vhub)
 {
 	vhub->speed = USB_SPEED_UNKNOWN;
-	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
 
 	return ast_vhub_init_desc(vhub);
 }
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index aca2050e2..96f1c3709 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -547,6 +547,7 @@ void ast_vhub_hub_suspend(struct ast_vhub *vhub);
 void ast_vhub_hub_resume(struct ast_vhub *vhub);
 void ast_vhub_hub_reset(struct ast_vhub *vhub);
 void ast_vhub_hub_wake_all(struct ast_vhub *vhub);
+void ast_vhub_wake_work(struct work_struct *work);
 
 /* dev.c */
 int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx);
-- 
2.34.1

