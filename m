Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49583FC0A;
	Sat, 19 Sep 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826350; cv=none; b=QNtja8bjyWgpr89i6Ia8miKd0hkBtmOj9HOS7TJcAHbbNkU5iIwTeure4Q2gWHeYSnxmhGyzPLBeUSB7X3mktu5ziCDo3FNRNBbBMIqXlAkJ4hcBSR92QvFbTeuSIgQGPofRxlZ0vn677IjEkORgdct3leQpCceHsnsH2EvRWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826350; c=relaxed/simple;
	bh=NI8TmhTxgfe0bz35XyZXN/VH6f5zbdKUAB9DqNj8dF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIkc3dnYNbtaPcq9et/2QGcoEzJdRpOVF0dQfddV8v916Jta/Eby9tC3OCwdKzKL576/nQk/NFMEHM7gGOEJpw+AuJLrKXlsnbqMDVw4GBFPEcUSoY9cUgl/kD2x/cDuVHWuDZuZ9iNWMOClOPRTQz10pJy9XJIRsPCiV6nEp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=s2X8WBov; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="s2X8WBov"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e6038de5;
	Sat, 19 Sep 2026 21:58:58 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Stanley Chang <stanley_chang@realtek.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] extcon: rtk-type-c: Stop IRQ before cancelling delayed work
Date: Sat, 19 Sep 2026 21:58:49 +0800
Message-Id: <20260919135849.1761877-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0b9f68dd403a1kunm8140e4303eb3e1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkkdVhlIGUgfSkNIHUpDGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=s2X8WBovyypLUrB49K9WQwzNdsK/eM4oF69zxatZ1HYFa108OyX5NRYV116TxjJfef4Cr0i9qd/CfczktAVbJx39kun6aExXcqcGfK2VqbERvvtUPmShwzh518PBcKsUKBOxtbvxS/gKwvaWy6g2WGqn8pmfbOFbUxzuETUajRc=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=f/YjbZOyMD0ItYjAjcMTYKBJgyj0pH5afSrIkNuBtqI=;
	h=date:mime-version:subject:message-id:from;

type_c_detect_irq() can cancel and reschedule delayed_work.  The remove
callback currently cancels the work before disabling and freeing the IRQ,
so an interrupt can reschedule it after the final drain.  The
device-managed type_c allocation may then be released while the work is
still pending.

In three ARM64 KASAN runs, dispatching the real IRQ after the final drain
made the delayed callback access the freed type_c object.  All three runs
with the IRQ stopped before the drain completed without a kernel
diagnostic.

Mask the hardware interrupt source first, release and synchronize the IRQ,
and only then cancel the delayed work.  Also use devm_free_irq() to match
the devm_request_irq() allocation and remove its devres entry.

Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/extcon/extcon-rtk-type-c.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 82b60b927e41a..9d77ce5c7ee50 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -1409,17 +1409,6 @@ static void extcon_rtk_type_c_remove(struct platform_device *pdev)
 	u32 default_ctrl;
 	unsigned long flags;
 
-	remove_debug_files(type_c);
-
-	if (type_c->port) {
-		typec_unregister_port(type_c->port);
-		type_c->port = NULL;
-	}
-
-	cancel_delayed_work_sync(&type_c->delayed_work);
-	flush_delayed_work(&type_c->delayed_work);
-	WARN_ON_ONCE(delayed_work_pending(&type_c->delayed_work));
-
 	spin_lock_irqsave(&type_c->lock, flags);
 	/* disable interrupt */
 	default_ctrl = readl(type_c->reg_base + USB_TYPEC_CTRL) &
@@ -1431,12 +1420,22 @@ static void extcon_rtk_type_c_remove(struct platform_device *pdev)
 	writel(0, type_c->reg_base + USB_TYPEC_CTRL_CC2_0);
 
 	spin_unlock_irqrestore(&type_c->lock, flags);
+	devm_free_irq(dev, type_c->irq, type_c);
+
+	cancel_delayed_work_sync(&type_c->delayed_work);
+	flush_delayed_work(&type_c->delayed_work);
+	WARN_ON_ONCE(delayed_work_pending(&type_c->delayed_work));
+
+	remove_debug_files(type_c);
+
+	if (type_c->port) {
+		typec_unregister_port(type_c->port);
+		type_c->port = NULL;
+	}
 
 	if (type_c->rd_ctrl_gpio_desc)
 		gpiod_put(type_c->rd_ctrl_gpio_desc);
 	type_c->rd_ctrl_gpio_desc = NULL;
-
-	free_irq(type_c->irq, type_c);
 }
 
 static const struct type_c_cfg rtd1295_type_c_cfg = {

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.39.5

