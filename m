Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAE4E378F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449898; cv=none; b=WTmdPyvKDwA3WV7FFIRwWy+kU/47jPrG8GiMOLIiwvCFZ48gpp1dqJbN/gCm9wzBToafxHh/Wufbk0nST9N2ezFhA/jM3MjJdIDYLqBNX0wKGyPAz2/qWBUXSX3SeyhXpEzYqJaIRi2A0cI5U6YTrfKWDHKK1cvtGQtbu8cLRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449898; c=relaxed/simple;
	bh=c6c1sG6upv/VzXY77uGzjJPBxJfBTiQqVzDF7d7YhLc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=andaFR+zcaTte0UC9eSjxvX68COb6egwlIiDZu8/IPhRyMqS+nV21wT/zI44jEuavdfMxQjzhMSBYpsJLR2+z9BNZRJfJFCBTK85FY6wqQFX66yWai9B+SKfdzJ60lJRWCjiHhpx6DA3dYDT/oORMRvq2CVpwCYkw7wni6INkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u0+3DNSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u0+3DNSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F4C1F000E9;
	Thu,  3 Sep 2026 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449896;
	bh=cANZGYTl9TXDp7h2Q1WuhUc8o5nZei+VCxay7WOjF80=;
	h=Subject:To:Cc:From:Date;
	b=u0+3DNSCD4TyeJqz7M80Ewgc3319Wxn4r7wZ8f65VTu899MJYLomD7NrmU90zjAu2
	 ESrkWT5Zm5WuiCe2zagvu7rBXYUO81Lc/RQb3yJo4ZuG2ohSbvfyK9x/zei1NvMUwt
	 0PEzsjV1kF3aQHq02UIT38e79UZlUKiqLeqgvKaE=
Subject: FAILED: patch "[PATCH] net: ntb_netdev: Fix TX busy and drop handling" failed to apply to 6.1-stable tree
To: den@valinux.co.jp,dave.jiang@intel.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:08:39 +0200
Message-ID: <2026090339-existing-freedom-ef51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090339-existing-freedom-ef51@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

