Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799D42377D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888667; cv=pass; b=EfQ1FLmdiNoZLVrYO4jgnBKcn7gWBzeAQOQbzYTmjWzsr2iexlRR25rwhRH1Gxm/uTVSJxQ9tPJjZm8lqVOoiQmIbRHVGD06yVZ/9h8u43p4piSLbw8/Pws7FxTPzev4HTjf9Uz+B7FUK0FcBxxnSOA2xl/LAgT3bMkWphBXs18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888667; c=relaxed/simple;
	bh=sDjwETz74fdFyU9X0pY9VCZo9DSIz+t1sCSkS/d2z3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRDTujnHGfiTu50DxumjLSABwmJXD5oEcTtnlmejfyHhBwYg/GAzvgsmlgcyoxgdPokjEP5Mf1pyw7ww+4jqfRNRSyNwFJLejVpOZ10PIR6Q7kd0DIcLD9EzoZ4+2B1wb0/s7y4EXmFRBxuuXxt9ylmYSSFJSVSxh+MWPaTsLJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HIFU3tWR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pmj1ifAU; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HIFU3tWR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pmj1ifAU"
ARC-Seal: i=1; a=rsa-sha256; t=1784888660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lcrdep2a70clIPbNQ/ljEyTjw5rAOURu8E/vYoc2jJ8esjQGB02kOM9RZDVbsEaGUk
    2OB2b9yw+WI6U8n/xq10DWMIL8GWmDwmbIoxkIPhxGm1pFMFbmu8kM23hhEj7fElyAbO
    dKGgywVYg1oyJWfWUdfpyRqHIL73XTcFRNDOCbhxDbHRvOAKaQmNLBv0UWrHAGStZ1nn
    pNxATWzzGKaBJRKqds6QQxuPIBs+Y6t61FtM+XD7vB8I6/oF3lWYY5jzUro5NOJZmRbG
    VeK/Ta3zDmklFPSecy1I+GjJtrCGhA8akUuyPQQfMac1UtSSO58H3KOKc4jSwrqUuHX6
    2ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BefFZ6COv8SXmoQgNVGT9EzxVHs5utAg10WZ0RTY2Yo=;
    b=G0N0xwxrYdVDUyNutoFm1jZkWZ9tUSKwm2lXWdPNu1ItyJfCsaVjWjb5aklY0oJtVK
    hY0htypSDUOGZKQyQ8vKvPAUs++DMTDyhVx9xxwreSteHR6nf/awiZz01YF875dt+iya
    Osz6lrb0hUtElpf1QjXIsw0Ba5+UDAZ+xI0ifQHdUkpO7Rn61OmtI14sJTzqY6j3u2RM
    dfv8yigX0tlatgT3710GFBm0StAebHuAE0K+iAi5JAys3ymkjO6eixdAIbtwjrtp5ybz
    zdd0lAi4AOPfVNkPxZ3V0WqOAQtq2xbbVyhxfzcKDTUyk4FeA09/mCvvkHa+TlX9kOuO
    Ygpw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BefFZ6COv8SXmoQgNVGT9EzxVHs5utAg10WZ0RTY2Yo=;
    b=HIFU3tWRu9n67alzkggSbIFrScBgeAfUJrFzc7kVh4cJ25ne1SFAiyGYcdUq356WAT
    DGrdv1PmC0JEweVunU4X80h9IAwlnbCaM8QmHg2XPxv3vMqR4ukpRm2+Bdpcu2qK7d5d
    cQyiVeehJ7K3OLRvoMON0d1bCHWey0G542yXfT4Tta1q7+9Sw+SKct6fd+VincoSJOrJ
    iWsGWSnQAFKs3WXXos0lm9BNq8r/cxWCvbt7eLuCozoQ1ktAtlGtUPNdkau3HA5hBL1Q
    7DmNNwP8KhYb4D0t3OcIttRkmjunB2sP+4j4uQ3cNJ9h41HVgpkm7idb26g/Y3oZ8ByU
    9n9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888660;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BefFZ6COv8SXmoQgNVGT9EzxVHs5utAg10WZ0RTY2Yo=;
    b=Pmj1ifAUJWNkda+Pa2/1VTBdzF3zU4dEuS7gmoBYwQ28zE5ppQahjr+tsOCUYB4qf2
    TsCoUoMuZSUuWtKM/bAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAOKtIY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:24:20 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 2/8] can: bcm: fix CAN frame rx/tx statistics
Date: Fri, 24 Jul 2026 12:24:04 +0200
Message-ID: <20260724102410.16731-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102410.16731-1-socketcan@hartkopp.net>
References: <2026072011-untruth-wrongly-ed18@gregkh>
 <20260724102410.16731-1-socketcan@hartkopp.net>
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
 net/can/bcm.c | 67 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 210ce99..762db0b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -109,7 +109,7 @@ struct bcm_op {
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
-	unsigned long frames_abs, frames_filtered;
+	atomic_long_t frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
@@ -216,10 +216,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
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
@@ -241,9 +244,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-			   op->frames_filtered, op->frames_abs);
+			   frames_filtered, frames_abs);
 
-		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
+		reduction = 100 - (frames_filtered * 100) / frames_abs;
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
@@ -267,7 +270,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 			seq_printf(m, "t2=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
-		seq_printf(m, "# sent %ld\n", op->frames_abs);
+		seq_printf(m, "# sent %ld\n",
+			   atomic_long_read(&op->frames_abs));
 	}
 	seq_putc(m, '\n');
 
@@ -277,6 +281,24 @@ static int bcm_proc_show(struct seq_file *m, void *v)
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
@@ -328,7 +350,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_tx_stats(op);
 
 	/* only advance the cyclic sequence if nothing reset currframe while
 	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
@@ -473,12 +495,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
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
 	data->flags &= (BCM_CAN_FLAGS_MASK|RX_RECV);
@@ -718,25 +737,29 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
 
-	spin_lock_bh(&op->bcm_rx_update_lock);
+	/* update statistics in the same critical section as bcm_rx_changed()
+	 * below: frames_filtered must never be checked/incremented against a
+	 * frames_abs snapshot from a concurrent bcm_rx_handler() call on
+	 * another CPU for the same (wildcard) op, or frames_filtered can end
+	 * up larger than frames_abs.
+	 */
+	bcm_update_rx_stats(op);
 
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
-- 
2.43.0

