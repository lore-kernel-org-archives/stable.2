Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D203ACA5B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882407; cv=pass; b=Fd6YK4mXJw8KfEPkBtQfaiEyc9NO7D5B8kgGVuwmU0X56zsw6QpKEG0wKltFNb/UPDWB/NpcGOloQt7EZsxipqfT0v7BuQqXWurPX1XW63NLeBjG99RGYPUuQ47y4gqIeOMGZmJ6psJEY0um7JcoPPjH1ENN+bdeePLgyp5oX6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882407; c=relaxed/simple;
	bh=sDjwETz74fdFyU9X0pY9VCZo9DSIz+t1sCSkS/d2z3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTZIroVi6QK+7DkZcTZ1cQYn2U7K7IFbKY18ufQH008j/mphdfA6bU/9bb26T/j53TJK0QU7kK8Z2xM7PY5ImxKJVE1JYgW5dfSaRUxg5WKpoQWX7NGZb9J67MggFNj4amObLN/5nRrNp68T2pNNT9sutihgEQYtTgkfNXOYQKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oN4ojRXd; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jLJoTPsT; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oN4ojRXd";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jLJoTPsT"
ARC-Seal: i=1; a=rsa-sha256; t=1784882401; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m9kGuMGpg6F7g3t32sVz4oUfQh7PP25JpdbflEwwCZqPDCrHWQ37K5oC2bhY0/A5ac
    h1YE/XKXeoM9F8OuWBGToaDRrY5zfHMDa9hzKVsV3dvcGy812vjD1T86e4/tLwVkiBjA
    NPYZ12tmhhpdLT/qJ7SySZwonfsz3bhJGW8geHQ5muLIVKDL9S/5qk4Van4V2SjvVyC8
    +kOUOmN891MzaYpeZbybHz36qYTN46pNAaic1MC3t4uFiGyoa+nG+FmoWQabx/rMT36Y
    17oRGHcEEeUy+uX1Rwg+/yWspDFNBomM3qLncWO4JrdK9Nr8fTEEH/gkEOGfWmV3Gmoo
    Masg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882401;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BefFZ6COv8SXmoQgNVGT9EzxVHs5utAg10WZ0RTY2Yo=;
    b=LSrpHUADnZOG2rJMArUEs3lNXIskZG8QepS176K+B2WYH/Z8le5jT+4j7mFynRiGIg
    6/rDgDl+tJGLaxzSTVikCUmO89i1axQUAyikQT+Sk/zg0pgfOfc85Fgt04ckquluMCjF
    7oo/H9g9oYeGPlCxbY765/pmvr2UtYVpXwIn+ueRbCKY6Nf23dCl/F9Ott59AZu5glys
    MycipMaBjxMFhZpQODXAq7Q02SlsMdCjJd4DUZOCt2QhZwV2w4+/MX9HC/QwkxEISmsx
    blJiH7j6rY+5gaoYn5XB12EVMY65Jgt0qL+hrlJqFLwsvzRA++peLt3OVa+SvUztc4le
    m+Cg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784882401;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BefFZ6COv8SXmoQgNVGT9EzxVHs5utAg10WZ0RTY2Yo=;
    b=oN4ojRXdnW5qYIMGyc+38IZ+MicjJCDruxVFAvV+t3oZ6r2cBSFjKmlGV0eh49Niw2
    FMMF2B94OaU9Lu/HCZRIXfu9pJ0wQ6dPGan/c9YVulb6DMK9Epbc73ybTiHkhUwDTcTq
    O0KyKZN64l5RohSBzRmMjXpgbHCoMezOqk/2bP3+IdmARd1EouK5OXIHl7NFhrZxpXAY
    n5UcOevp5i3ogWZRoy75HNjVN3xamdqBaPGqTnDkFMaMtILzZyxOvZpZKHMSoqZxg4xT
    2xOhKM7/Z/FH+UCRQjDCo45Bm+GT0ZHMFTGewa3Tl2vo1HGWltrN/66LFiNobKUceSmK
    dOSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784882401;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BefFZ6COv8SXmoQgNVGT9EzxVHs5utAg10WZ0RTY2Yo=;
    b=jLJoTPsT8TNElb+g8LNkgDoRcdm0XBIb2nJrXHxyLSNiLNM6ujkzKcsglLkLoUJ0sq
    oU2hPWlcRpciKgi3vNCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8e1rV5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:40:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/8] can: bcm: fix CAN frame rx/tx statistics
Date: Fri, 24 Jul 2026 10:39:48 +0200
Message-ID: <20260724083954.12817-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072046-sizzling-passive-5a46@gregkh>
References: <2026072046-sizzling-passive-5a46@gregkh>
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

