Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024943E1D16
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913013; cv=none; b=j+kOHyWt7L/0SbrIK9U1hwtWW2tF3pMNJj0aH2Lx2XOy3PSlZvblsyMeNTxjP35xnVBMjh2eKwRTagt6NLkq2jgZ4aKjjdnD1fvivCXs885ntGpK44ykDnG1mUM6JcII2E8u0+ySGu8ZZvMmFTty0Ice39A6TVu56wN+UP1bwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913013; c=relaxed/simple;
	bh=vkWA+pR3OZfnWlFZW+uq1EZpX3DsehdrYFIuwaPN4dI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mdIMIQ4U1QWNGtnOkUh892tZHI0+5cR0oWLDBHLVXB+lVtZEYMPzom4WOhjh2+CFY0cjo/3sGk9JA/uvKSvMJF8UlMFj4NrFlwSqtNvvoDrNPJJkJ1g9b45pBUjfINIqUpBhIlwmMychLd6LInM5ckD4Vx7GiR79sFGXpZdJ0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCXSEblF0VqQvNMAw--.20652S3;
	Wed, 01 Jul 2026 21:36:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgD3DXDkF0Vq9hS8Ag--.36084S2;
	Wed, 01 Jul 2026 21:36:36 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: 
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
Date: Wed,  1 Jul 2026 13:35:41 +0000
Message-Id: <20260701133541.7481-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgD3DXDkF0Vq9hS8Ag--.36084S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?lKQt2AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WPh//7mY0qv4xtIN3wdo0R49TDnJWHVEE4lEwAX94AoDNBF
	CQeAx4DHCGCeRrlOYazN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy7WFy5Gw47XF4fAw1rXwc_yoWrtrykpF
	Z0k3sIkr4DXr4rtrn8Jwn7AF1rGw1a9F13ZF4kW343AFnagF1fX3W8KryavrWkur97tayf
	Zr18J39rGwn0krgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwC2zVAIFx02awCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUaKZXUUUUU

rtl8xxxu arms rx_urb_wq from the RX completion path:
rtl8xxxu_rx_complete() hands the URB to rtl8xxxu_queue_rx_urb(), which
queues it on rx_urb_pending_list and, once the list grows past
RTL8XXXU_RX_URB_PENDING_WATER, schedules rx_urb_wq.  The worker
rtl8xxxu_rx_urb_work() drains rx_urb_pending_list, recovers priv through
container_of, and resubmits each URB through rtl8xxxu_submit_rx_urb(),
which anchors it on rx_anchor and dereferences priv->udev.

rtl8xxxu_stop() cancels the sibling work items (c2hcmd_work, ra_watchdog,
update_beacon_work) but never cancels rx_urb_wq, so a worker armed during
the last burst of RX traffic can run rtl8xxxu_rx_urb_work() after
rtl8xxxu_disconnect() has called ieee80211_free_hw(), which frees priv,
producing a use-after-free.  The window opens under active RX traffic
(pending count above the watermark) followed by a disconnect.

There are two teardown races to close:

  * rtl8xxxu_queue_rx_urb() decided whether to enqueue under rx_urb_lock
    but called schedule_work() after dropping the lock.  A completion
    that observed shutdown == false and released the lock could then call
    schedule_work() after rtl8xxxu_stop() had set shutdown and
    cancel_work_sync() had already returned, arming the worker to run
    after the teardown.  Move schedule_work() under the same !shutdown
    branch so the arming decision is atomic with the shutdown check.

  * rtl8xxxu_rx_urb_work() anchors every URB it drained back onto
    rx_anchor through rtl8xxxu_submit_rx_urb().  A worker still running
    when usb_kill_anchored_urbs(&priv->rx_anchor) returned would submit a
    URB that escaped the kill.  In rtl8xxxu_stop(), call
    cancel_work_sync(&priv->rx_urb_wq) before the kill so the worker is
    drained first.

After priv->shutdown is set under rx_urb_lock, completions can no longer
queue rx_urb_wq. cancel_work_sync() then drains the last queued or running
worker, and the following usb_kill_anchored_urbs() kills the URBs it may
have submitted.

rtl8xxxu_disconnect() is covered because ieee80211_unregister_hw()
guarantees .stop() runs for a live interface before ieee80211_free_hw()
frees priv.  The probe error path needs no cancel: rx_urb_wq is
INIT_WORK()'d there but cannot have been scheduled, since no URB is
submitted before ieee80211_register_hw() succeeds.

This bug was found by static analysis.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index c06ad064f37c..b447ce78ff05 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5792,14 +5792,19 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 {
 	struct sk_buff *skb;
 	unsigned long flags;
-	int pending = 0;
 
 	spin_lock_irqsave(&priv->rx_urb_lock, flags);
 
 	if (!priv->shutdown) {
 		list_add_tail(&rx_urb->list, &priv->rx_urb_pending_list);
 		priv->rx_urb_pending_count++;
-		pending = priv->rx_urb_pending_count;
+		/*
+		 * Arm the worker under rx_urb_lock so this is atomic with the
+		 * shutdown check: moving it out of the lock would let a
+		 * completion arm the work after rtl8xxxu_stop() canceled it.
+		 */
+		if (priv->rx_urb_pending_count > RTL8XXXU_RX_URB_PENDING_WATER)
+			schedule_work(&priv->rx_urb_wq);
 	} else {
 		skb = (struct sk_buff *)rx_urb->urb.context;
 		dev_kfree_skb_irq(skb);
@@ -5807,9 +5812,6 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 	}
 
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
-
-	if (pending > RTL8XXXU_RX_URB_PENDING_WATER)
-		schedule_work(&priv->rx_urb_wq);
 }
 
 static void rtl8xxxu_rx_urb_work(struct work_struct *work)
@@ -7461,6 +7463,13 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw, bool suspend)
 	priv->shutdown = true;
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
 
+	/*
+	 * Cancel before killing rx_anchor: the worker re-anchors every URB
+	 * it drained via rtl8xxxu_submit_rx_urb(), so a worker still running
+	 * after the kill could submit a URB that escapes it.
+	 */
+	cancel_work_sync(&priv->rx_urb_wq);
+
 	usb_kill_anchored_urbs(&priv->rx_anchor);
 	usb_kill_anchored_urbs(&priv->tx_anchor);
 	if (priv->usb_interrupts)
-- 
2.34.1

