Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FF3C4B6F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986564; cv=none; b=cMsnesGc5Jui5qVPEFVutDOvkNeZH3i9Hk6J9Qrk+rSUl4ihXV4MBSfRl8N/1VeXIxNtfPk1lBQD/KwbUwYx9D1R22EaN8MWPwfNIXFyDIrcNyxkeWoBYEwqkzBk5ojcxWInv6ChGAtrB7er6KL0y65dkV8fJ11KbcYoUYFs5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986564; c=relaxed/simple;
	bh=6q4LDETmrFAUstP4gSYilVoMsVbbsw90oeID9TBh9PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LO8hZR+H+jZq1rttqcDfOlNxFSahi2fFWou2wK3OjMVc+bLOlnRa/HidLz8uk1pu4YJyQXyD465YkxvI1H4kgU+A/c414ITqEnc/0MSyLlxKAugNvivsh6+1z1i9qdmFJoMcN04gRLKTztws9IFtoYjdFg7afgCKimbjIwtncQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY0YfOxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY0YfOxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669EC1F000FF;
	Wed,  9 Sep 2026 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986540;
	bh=3iM3hEXHUEVoOq5LM5qtrNOP/NqB+UBGr/xVPjg9xl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mY0YfOxr5vVPk78FT1CPhGO2HB0E3s7YO+/prUlm/aJJjvlLIN4EnqT0OZjvCiJiu
	 xnb60ZoLnDHIHmQy/rCWWmamAvzsvW+btO1khOqEPVJHEMjd4HVVyL2A47Mo+Y6gu8
	 EMUrX7k3O/+bwLxcOFjuIGSatTA6j0hbTBLPBBJmeZYMFIb/TgwVhCalpiBmSpvEtd
	 6L6DPQxaBSC/PxdOdxPbI0GcR1e5nWwgkUyz005GB1vE7u3qOxwtFCINAyGbzCUHtT
	 Fr2ZX+ZcAiyxsKMNFeORRVQDepd3BImhJ+EsrWYXy6WcU+Newgv5KiV0uvD5SFqYtx
	 qmlXKHNuSJa1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
Date: Wed,  9 Sep 2026 16:42:18 -0400
Message-ID: <20260909204218.3659750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090417-tweak-sinner-8280@gregkh>
References: <2026090417-tweak-sinner-8280@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 6c080026ecc17eecb103f8927c64ea73a74bb818 ]

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
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260630033117.3377-1-fanwu01@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5a57ffb53acee..bbaebdd821c8d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5829,14 +5829,19 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
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
@@ -5844,9 +5849,6 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 	}
 
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
-
-	if (pending > RTL8XXXU_RX_URB_PENDING_WATER)
-		schedule_work(&priv->rx_urb_wq);
 }
 
 static void rtl8xxxu_rx_urb_work(struct work_struct *work)
@@ -7281,6 +7283,13 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
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
2.53.0

