Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DB42589D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888772; cv=pass; b=I0ZhN7kAUrnwpamp2mKGf03LsjzmFofltiu8cWo+HYzJL80vS3x2ImhZlJu1I6Xt4E/wdBWdfKvfE+1Ip29RMCopmGxaMORL53Ek+/G6sADpUOQp5Zhph0ho9HGNTSYWD0TajgxICxRjoRYjJaY29fQHt+XVMsBa2Mk1s8yVSr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888772; c=relaxed/simple;
	bh=4mrAodG5qajPWfpKVhglxQihtKY0+dcn1wVdmVN44Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnDKNMKNvk79UekewTmHHyl/TBxwT6Ed/w/tohyhtEq5fDk8Pk3pk0V/gsirU49IHVdubhIftLTYF0BfXfYcta3stjfYXQLXsMZh+IOqVFra3cy7ZhaSAXok9m/aCt64Scc31jpN5irm+sobB0QZk2hjqDX1yCFWkrWJvXkcFJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=J51EoBVI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aHY365z/; arc=pass smtp.client-ip=85.215.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="J51EoBVI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aHY365z/"
ARC-Seal: i=1; a=rsa-sha256; t=1784888766; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HfohJonEOtOWw1b2MdqbzwB8yLbu2rLmpj2btseFv8wAXZXlzXSPZTMkOqUwnrOv41
    /nB72xaPPnsrhMSXW5cwz0gJOjEGuLj06WGurYWT+0HsDZmaHxTVroQMogphWIhVcFwJ
    FrwmVeQy5CrnI0TzZAIDRj3amsfVO+pe+fMQF6itKgx13RHvAavYMAlUmRnK1HbHDsFQ
    eEoA8BH3XebLgE8PgyCul8Xhfxv/TxomhM7vDm6VTi/Y/yP4gOBqGFmX+tSOJ3E9GPwW
    4I3GFvxa/kOymy/ajtheXuFk/gE2KSuSSs2QlGFyJCjciRYwLfVT0vdp30FOxc6IJCGY
    l9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888766;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=njsezuVG7LWJMB6/Obv6q5HWDQPcruu0RzJ+UVis2Ac=;
    b=q/h6iWFxKmerYctrUH3ml6As+WvBFJFXMfEEfOXubI0zT4L1kkgX3iq/9SFHWDJ/Ow
    yjF8c/Bxzhy7ZI57GIeEk0XvGzwsY7NLr5xLRAHLCav7zsCgJYeJBAlnW5ctgCjYFNRO
    LJHRR0KMHaNlNSX72WN+tkxehXQJ34iUYKx0+YIjp3FoiqK83HEZTn1hcyMqwEha2L30
    Li4Gv90nqbQbEC6o1W7027VpX4lSvzG6GF+Y0A7lIPAcbNLZpxQ4AW+A8C+j4TDm5gNY
    0LvID2YmLE5zEoFS1LToBA97bsRV3twp4u9tBSGAI0fAUHd3ePsXGFAlQUI7DHkHW8mq
    J7nw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888766;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=njsezuVG7LWJMB6/Obv6q5HWDQPcruu0RzJ+UVis2Ac=;
    b=J51EoBVIUdZfFkj2RT82v2km5Mr+WxYU2QttEY6so3+G6cl9nCCtJ15raNRrKMXGeb
    cBY2LYww/Nom5QY9EACWjVTDXfWIZOJGN/CM7bagWaRT31EMLSV3KGsEIB4EsitdMup7
    iLLRXquJRyWFniTBkJ+t2FQclWGt3pUA39q7cxctuipoil3W7IhS/90YLJWW65CLmglE
    clNq0N14b+rj4Unte/cu6z+8EPUPHa36yj188xMEtLXFIfw8qVei1DiwEq4zW3PMSXNk
    jF3dtitvVq7lT4xKkn27AVky6Rw7z/gtmkfv5agwcgcg1XrX6/Xzb0PJU0KPTsp7v0/S
    DmGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888766;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=njsezuVG7LWJMB6/Obv6q5HWDQPcruu0RzJ+UVis2Ac=;
    b=aHY365z/IEEN8v3z9LHtOKnZsr6nLyxFDmobbsB5e7rUu7/QdX/y2z+B0/3XhWTrS4
    el4hCxO2800rQPshpFAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAQ6tJK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:26:06 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18.y 2/8] can: bcm: fix CAN frame rx/tx statistics
Date: Fri, 24 Jul 2026 12:25:52 +0200
Message-ID: <20260724102558.17056-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102558.17056-1-socketcan@hartkopp.net>
References: <2026072010-winner-hurried-07df@gregkh>
 <20260724102558.17056-1-socketcan@hartkopp.net>
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

