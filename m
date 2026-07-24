Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3636A008
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882536; cv=pass; b=jR65IZZRVhcziT35T/TPEV7aYwpSidbVzTWsftLoAEP9lO+GcPDzNXaqYGl0d5i8kiuV//1HmEYpq8u+n1E/EUwwdu8MdonhDW6UTRLfAxfQIFDenl0QwIQdTPzV3qOF5yoj8KJOn8DCjI1qzhY+cEXBHmDLukzYdpWIGPy+Azo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882536; c=relaxed/simple;
	bh=4mrAodG5qajPWfpKVhglxQihtKY0+dcn1wVdmVN44Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tENtnUR2aVZwXumCbvFfAUY6IHdFgplEOctm5a1PtoRAM2L1oqDa6KekpBheNCgYxACC7wZE2GhU62b2LEQIUB59P/ADzpHTEtvQVTGSJwl4UYgr/G6Mb5cwZrbea0khi0p0U9AfiEkARH/C0Vk35+QAFOJ2nSpaAOaiWGijsk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Df/Ip1eb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mpOJCoF9; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Df/Ip1eb";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mpOJCoF9"
ARC-Seal: i=1; a=rsa-sha256; t=1784882531; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=agS+gceLczmdpzjr1xgBJvS6p9drYvIzlF4/hFwM9HgTy801zjuteJieBNwEz+IJ8/
    AHvWZSBLTM+xnL7PDWvJI9BJB+xL1QjBlApdF8yKNOmI5aCeZebMKwkT/qclM02q9iwm
    x5vVf50JkRg64smPRg05x7VQZW6QSR7phyW5aEjsyOhU1dSnV0VZxvNcI8mB4YASsWq+
    2K0D6S0mMWRRGcT5pMXtHhU4NR8O2ltpf80wJgUrpwf9GpESlb6DvAihbbF+ps2xrRyh
    Y2UATudsu7k49X6g135EobtSksfHl+alhz+Dj1EHJLtWJ2ZCgQtV1qbq03ig6teWREAY
    A5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=njsezuVG7LWJMB6/Obv6q5HWDQPcruu0RzJ+UVis2Ac=;
    b=mEwQNWN8fJb/LkkLbyz9Q65Hy2e/eHX1qEn0tqPLTgB18RaR84oQnqj66xlEI1hbEJ
    3MIXQCEdLLCkvNfRV17ax6TSBqQ4frNn3z8wreR0t9Nk2pB4N8SYwF4k44ahqoBXnM0t
    CUErg203IqS6SJWDpsQJGdt85ZRnnBaYLC05O6YFWrug1JMC4CAR7wM3nq4fqCP/pgUV
    vSpa5w4bnoYRGpIBhRL/efEoYi7PISNMbN89/KSxA2oWZPv4+UetioLK8QqCAnMlaQB5
    zBTPEs5/6MWlb7crGav+2KD0iestkBadcmlJWHIA+kkucIUcaUiUWnVsPzAie8qHWvlm
    Ubvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=njsezuVG7LWJMB6/Obv6q5HWDQPcruu0RzJ+UVis2Ac=;
    b=Df/Ip1ebXoQFgc+G6HNA7OhnMu/DSawo9FzvsTVY79EpJ//BxN/wopm9sWkO6+WcK8
    W9OFwF7q8YVCRF9co/PtsF79ak6HQfEFwR2AsWnTaygBehhx/zUyHb/VBNmc2wZBLDBS
    nzpr6qgHzZfuHXC4/02sfhvtYOEuGkFqcBinIuk8pqc1tyR/BFfofyXTO8dHjlKCc8no
    DhID7Dm1VYvrvfkuP3sqtJBkIIUA7/eIF+A6m3mb2ZAF7TlDa7HuNWurQSJmswgMOgFU
    ZgP3vZf80MnHYlpBRqglb4fr0GjujB5ID9y9IA3Fok1uxYirUS/iN8h5UZpIKQ8R8PEf
    yBgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882531;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=njsezuVG7LWJMB6/Obv6q5HWDQPcruu0RzJ+UVis2Ac=;
    b=mpOJCoF9eYgoqhbFBiRjTs5GbGL9019h3bKst7XdI2WUQR6VGvexFGkSJWkVdTUdo3
    rrI7SGs88m/huJa3n5AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8gBrXL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:42:11 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/8] can: bcm: fix CAN frame rx/tx statistics
Date: Fri, 24 Jul 2026 10:41:58 +0200
Message-ID: <20260724084204.13169-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072045-reapprove-footpad-1bee@gregkh>
References: <2026072045-reapprove-footpad-1bee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit e6c24ba95fc3f1b5e1dcd28b1c6e59ef61a9daa5 upstream.

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in separate bcm_update_[rx|tx]_stats()
functions. The rx variant runs under bcm_rx_update_lock to prevent
races when resetting the two rx counters; the tx variant runs under
bcm_tx_lock and only needs to guard its own counter's overflow.

As the rx path resets its values already at LONG_MAX / 100, there is
no conflict between the two locking domains (bcm_rx_update_lock vs.
bcm_tx_lock) even for ops that use both paths.

The rx statistics update and the frames_filtered update in
bcm_rx_changed() were previously performed in two separate
bcm_rx_update_lock sections. For an rx op subscribed on all interfaces
(ifindex == 0), bcm_rx_handler() can run concurrently on different
CPUs, so a counter reset by one CPU between these two sections could
leave frames_filtered larger than frames_abs on another CPU, producing
a bogus (even negative) reduction percentage in procfs. Update the
statistics in the same critical section as bcm_rx_changed() to close
this gap, which also removes the now unneeded extra lock/unlock pair
around the traffic_flags calculation.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-4-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 69 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d151bb..24aca35 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -111,7 +111,7 @@ struct bcm_op {
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
-	unsigned long frames_abs, frames_filtered;
+	atomic_long_t frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
@@ -228,10 +228,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
-		unsigned long reduction;
+		long reduction, frames_filtered, frames_abs;
+
+		frames_filtered = atomic_long_read(&op->frames_filtered);
+		frames_abs = atomic_long_read(&op->frames_abs);
 
 		/* print only active entries & prevent division by zero */
-		if (!op->frames_abs)
+		if (!frames_abs)
 			continue;
 
 		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
@@ -253,9 +256,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-			   op->frames_filtered, op->frames_abs);
+			   frames_filtered, frames_abs);
 
-		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
+		reduction = 100 - (frames_filtered * 100) / frames_abs;
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
@@ -279,7 +282,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 			seq_printf(m, "t2=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
-		seq_printf(m, "# sent %ld\n", op->frames_abs);
+		seq_printf(m, "# sent %ld\n",
+			   atomic_long_read(&op->frames_abs));
 	}
 	seq_putc(m, '\n');
 
@@ -289,6 +293,24 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_PROC_FS */
 
+static void bcm_update_rx_stats(struct bcm_op *op)
+{
+	/* prevent overflow of the reduction% calculation in bcm_proc_show() */
+	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
+		atomic_long_set(&op->frames_filtered, 0);
+		atomic_long_set(&op->frames_abs, 0);
+	}
+}
+
+static void bcm_update_tx_stats(struct bcm_op *op)
+{
+	/* tx_op has no reduction% calculation - use the full range and
+	 * just keep the displayed counter non-negative on overflow
+	 */
+	if (atomic_long_inc_return(&op->frames_abs) == LONG_MAX)
+		atomic_long_set(&op->frames_abs, 0);
+}
+
 /*
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
@@ -340,7 +362,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_tx_stats(op);
 
 	/* only advance the cyclic sequence if nothing reset currframe while
 	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
@@ -500,12 +522,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 {
 	struct bcm_msg_head head;
 
-	/* update statistics */
-	op->frames_filtered++;
-
-	/* prevent statistics overflow */
-	if (op->frames_filtered > ULONG_MAX/100)
-		op->frames_filtered = op->frames_abs = 0;
+	/* update statistics (frames_filtered <= frames_abs) */
+	if (atomic_long_read(&op->frames_abs))
+		atomic_long_inc(&op->frames_filtered);
 
 	/* this element is not throttled anymore */
 	data->flags &= ~RX_THR;
@@ -751,24 +770,30 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
 	op->rx_ifindex = skb->dev->ifindex;
-	/* update statistics */
-	op->frames_abs++;
 
-	/* snapshot the flag under lock: op->flags/op->frames may be updated
-	 * concurrently by bcm_rx_setup().
-	 */
+	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	rtr_frame = op->flags & RX_RTR_FRAME;
-	if (rtr_frame)
+	if (rtr_frame) {
+		bcm_update_rx_stats(op);
+		/* snapshot RTR content under lock */
 		memcpy(&rtrframe, op->frames, op->cfsiz);
-	spin_unlock_bh(&op->bcm_rx_update_lock);
+		spin_unlock_bh(&op->bcm_rx_update_lock);
 
-	if (rtr_frame) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
 		bcm_can_tx(op, &rtrframe);
 		return;
 	}
 
+	/* update statistics in the same critical section as bcm_rx_changed()
+	 * below: frames_filtered must never be checked/incremented against a
+	 * frames_abs snapshot from a concurrent bcm_rx_handler() call on
+	 * another CPU for the same (wildcard) op, or frames_filtered can end
+	 * up larger than frames_abs.
+	 */
+	bcm_update_rx_stats(op);
+
 	/* compute flags to distinguish between own/local/remote CAN traffic */
 	traffic_flags = 0;
 	if (skb->sk) {
@@ -777,8 +802,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
-	spin_lock_bh(&op->bcm_rx_update_lock);
-
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
-- 
2.43.0

