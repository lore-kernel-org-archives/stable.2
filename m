Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19364E3764
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449906; cv=none; b=emt9IgvUoIPhjCYiK6Im0s4TwQ5k64U4o3hhOyueS/FTb0BtYNzuZKYlsBCZ34DxvWGh1SeQ6sAg9U9CtFPXERMTisPCce2wvSDj8igVPfBnX8PmLiZ4JYqVFgdcbJRnURn8qi6qEOEQ2U+XACmGixj6oFptOoZI8o9fKkaatBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449906; c=relaxed/simple;
	bh=c+aPibRTBl93GSpledz09NGptPVKujJ3VHrcwYONC4Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E4GJLS95NOq+esisLYQh/xkISEV92Ngrt6qYmPR6u6yXX1H/fVouNh+mXHZR/S8yKmTYp8t9ZZN4XRkrMr3px4DnWCYMKAZR4QxYp6Z4VcmcBc8jvj9qecIc8rpc+PB9eFhSBYX2WQxhdfbYCEaKCm9dm+dmEP5FdmA4vR264bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7CQXQo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7CQXQo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C01F000E9;
	Thu,  3 Sep 2026 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449904;
	bh=nw8xOyHnEi7pJ5W3EZO8trGwUURf0vfkiFe4GPUhI5U=;
	h=Subject:To:Cc:From:Date;
	b=E7CQXQo23qdMmBd+aTgDOhrWNdR7jvpu4UzdKRp0tWNED7+UqLc420z2e00ecdeFl
	 1ZcHgzh54g44JsbZ1Wo9YHJuuIGqDs0oepVtAY8XfC0kOErUstW9TXOty0Aj/Ce0M4
	 E2Wu0r3j2YA+YWONiSGAnzG6tCDqTInbKuBzOG/w=
Subject: FAILED: patch "[PATCH] net: ntb_netdev: Fix TX busy and drop handling" failed to apply to 5.15-stable tree
To: den@valinux.co.jp,dave.jiang@intel.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:08:40 +0200
Message-ID: <2026090340-stereo-dexterous-e88b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090340-stereo-dexterous-e88b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Mon, 17 Aug 2026 14:35:17 +0900
Subject: [PATCH] net: ntb_netdev: Fix TX busy and drop handling

Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
also increments the drop and error counters while leaving the skb owned
by the qdisc, and may return BUSY with the subqueue still awake.
Retrying a permanent error cannot succeed either.

The unconditional BUSY return and premature accounting date back to the
initial driver. The error-path queue stop was later removed without
changing that return value. The current flow-control code includes a
resource check, but ntb_netdev does not honor its result before enqueue.

Honor the resource check before enqueue. For -EAGAIN and -EBUSY, stop
the subqueue, arm the existing reaper timer, and return BUSY without
touching the skb. For other errors, free the skb, increment tx_dropped,
and return NETDEV_TX_OK.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Fixes: d723485cb4ca ("ntb_netdev: remove tx timeout")
Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260817053519.4135287-3-den@valinux.co.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 029a4a532a10..02b35cf53a62 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -199,8 +199,10 @@ static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
 static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
 				    struct ntb_netdev_queue *q, int size)
 {
-	if (__netif_subqueue_stopped(ndev, q->qid) ||
-	    (ntb_transport_tx_free_entry(q->qp) >= size))
+	if (__netif_subqueue_stopped(ndev, q->qid))
+		return -EBUSY;
+
+	if (ntb_transport_tx_free_entry(q->qp) >= size)
 		return 0;
 
 	return __ntb_netdev_maybe_stop_tx(ndev, q, size);
@@ -256,21 +258,30 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 	q = &dev->queues[qid];
 
-	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
+	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
+		return NETDEV_TX_BUSY;
 
 	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
-	if (rc)
-		goto err;
+	if (rc) {
+		if (rc == -EAGAIN || rc == -EBUSY) {
+			netif_stop_subqueue(ndev, q->qid);
+			mod_timer(&q->tx_timer,
+				  jiffies + usecs_to_jiffies(tx_time));
+			return NETDEV_TX_BUSY;
+		}
+
+		goto drop;
+	}
 
 	/* check for next submit */
 	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
 
 	return NETDEV_TX_OK;
 
-err:
+drop:
+	dev_kfree_skb_any(skb);
 	ndev->stats.tx_dropped++;
-	ndev->stats.tx_errors++;
-	return NETDEV_TX_BUSY;
+	return NETDEV_TX_OK;
 }
 
 static void ntb_netdev_tx_timer(struct timer_list *t)

