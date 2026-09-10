Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DF2D12EE
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999492; cv=none; b=aYSaPLUH/F/+8eUFxiO9MeyzmNhSoyD2FIQaUNlTMr8uBSJPFrnMPeTKpQwlVEgBqED7LYf6fqul1duvM2jFnCDHtJAXN9nJ9bzK9BU1kksvD22vPm4NYUtgAZPWUOmGu6xv6IDP7xshE5RX8r3/+BTbVnOXjdvT1qDIQt8Wgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999492; c=relaxed/simple;
	bh=xQ3SOOQILXvBOBnX1DDLw8EWIoJqqW4UZkUbfuuwl8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjgEapPVXOq53ipGzbFLPOzWMekijzM/61Z+l38hKM9zIdB3XWUcjm643aR/fSoAU+XukSsJAN/jg+e+XLqe2NBZrnHde89+pHw1Hjo1nfipA/lBbSE/3vpHK+ofAPE6DO9H470HkbEnSkQtVRRVbP2ev9BEA4uq2u43+4bj6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfq1+/Do; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfq1+/Do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE29D1F00893;
	Thu, 10 Sep 2026 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999491;
	bh=tLGHCrxpX22oAarGfFEenxAp3+eUvQS1XzhdKMgaezU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dfq1+/DojXNqF8wo7DtYf2+n0Q2ZkZ+LLz5OyvbgK/fGJf9YA+IRiGm3dFKMx7UqS
	 /5LWt+7n8YfCngIYO4C2GzMe/tmfOY+FBcRFDZwtFHRE2O0hnzeMtxwgwoO4qSJ6lk
	 dgSI0Br+H726GjzcDN7JdS8RCMn7RlH9w1yG4kjFvJiotYSTpDNX6W5v4xzH4y+F24
	 3bwEG9stdrY3jHzijXjUbriJluwjVIULT1zq5AkPAJ9+XMqeyKQKDxh+akbpAhIxpA
	 gJqbkQefrpYcksANAzsYXFkbE/wxV1dLiBCcXi94Fbx3tuNxFBm4mVufQ9OdXp+eFB
	 JPFptvQkwaFTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
Date: Wed,  9 Sep 2026 20:18:07 -0400
Message-ID: <20260910001807.3749308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090420-fleshy-punctured-8063@gregkh>
References: <2026090420-fleshy-punctured-8063@gregkh>
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
index 7cf2693619c92..ff161685ad75f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5171,14 +5171,19 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
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
@@ -5186,9 +5191,6 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 	}
 
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
-
-	if (pending > RTL8XXXU_RX_URB_PENDING_WATER)
-		schedule_work(&priv->rx_urb_wq);
 }
 
 static void rtl8xxxu_rx_urb_work(struct work_struct *work)
@@ -6464,6 +6466,13 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
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

