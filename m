Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C33FB074
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888526; cv=pass; b=f+ToXVd98Z2iXREuUQDKZHYW/OGzj+kW1G11C0s8LYiUUrT7UhBUvMG24dfC5r/O9IUuAiYOKo4myQ+/mMp0gNTEFKpkiI73xD6G9paSG6tRZgTp2XymnTNGGMSS7Ay5VPa8zkSd7+sq/Pb59pjZ2Hk4CR77dAKrkr0lCetW6F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888526; c=relaxed/simple;
	bh=kATVCadHHMiVbiFQZK+BV2KFpITOqNVNwKYMcnbpomE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPg7CsHGksAOqxMX5/Igc+Rx+omyrtRZlYNa+1Rh+I3IhYKlyrwixTisB2cj4B7/1Kqnpfst85xKWE2FlQabo2PaPW97mUf4UZwjOQ5IEPubkFgEJn/M7icmb+BY3DzqhFExFWnnTE9tnwlcmmT1bP+EdBQDwftB2XakYVpDY5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nJpUwEZw; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=vdOEH5xv; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nJpUwEZw";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="vdOEH5xv"
ARC-Seal: i=1; a=rsa-sha256; t=1784888520; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZQwNPvhEkzdtWfEtucZsOVht+FY5dDtb1mUUp1oJyzajnfc2YYEGkct0DBop3RrJKL
    EmxvT3YVa6vyx8YMQmFXpOszpWOHYP9PAauHZAk8fFfZB+2lgO7LmoHCW3qzlddMTBT5
    ITv3lEK1yfsMctHR3g1oh4B/QQLMytz3ToNtqNJbwLNlCqkJEQ68MMW9R12iVGCKZOIR
    FQwGQrJc6WASX9dSYkLFFa4a8yuhvMgdNHtt/erzQi82YVmDQb2RWbLztTFmAH9QGLRq
    jBlbBRCoLS6WEBNQpMczqGuqgAi1wvOoUefVAS28S6A9hmqLUWPo57aQKGFS7hpzCw6x
    fHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+4RZxV19+mbhGdAZVw0kY8njOHjBxxHsREuZNkzH0A8=;
    b=S3cr0EkjvVyhd3WH51gM8yQ9Ho0O+ipgpCm+Rzkq1Eopv6Ldk2XtAe/eU+TGckiBsc
    WkzcmbZK94ItBEAG7iYpYNs8WFStkwVLKR2GNx0Hzu4Ou3YtZhkfYBtM111sSf0+Av58
    HvSeoEttMURrU97Di9+WEKQW56FLK7VDZlBj7fodkl6Wp+dAd62YvbP+Zih81wbcgaHt
    TlltoN5SYH2UxYx+3YnZ1N37B1XL8mx8YMbjVOE0K5B+IECkXjmul54T8PLtj4yCQx8J
    1/ol1y4i2sbn+5VmytB4H1YGQnKsC4r21zzrh4mdtrWnwtUjM8fzoqDCfRGfi/rmjtqs
    xzQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+4RZxV19+mbhGdAZVw0kY8njOHjBxxHsREuZNkzH0A8=;
    b=nJpUwEZw528dcLo7SqtFuHnTSo5strZj9j3cmV51ZnZamR6pZ/ea9oCx+f4Ma3F1vt
    V4nA18+2DxvSpw2a/aSNv5HQdvXbQFDJUJnh6flF7+YWn20yQwP5hKtorxoOvbtVTD1V
    ZXrKMYh4IWwSvTAoxl34gMdSCGWvgDwoL9jsr7JAEcRTJO6TBD9neZv7wSgY+4R6XgSc
    jSTks4FpjgadjFrMGeB6xq+jBvDGInttJmLUcUdLomxpZvFMkW5p8BUPfAK5uG2XJtsu
    UJllAjaYXl0YJ95ekQ/XC2NqqSFjzB2xavuVVV/Orlte+Vto8iI+wlJKiyZ1A3EhNAdm
    Xvlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+4RZxV19+mbhGdAZVw0kY8njOHjBxxHsREuZNkzH0A8=;
    b=vdOEH5xvNAS7gp11CENFnsOWqN88OZO6AvAw/gHDZT1/5vxvYoj32bJN9OI6yzsThf
    dVmRs7Vz1FuWEyNWGgDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OALxtHd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:21:59 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 3/9] can: bcm: fix CAN frame rx/tx statistics
Date: Fri, 24 Jul 2026 12:21:43 +0200
Message-ID: <20260724102149.16440-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102149.16440-1-socketcan@hartkopp.net>
References: <2026072036-giving-knee-3a33@gregkh>
 <20260724102149.16440-1-socketcan@hartkopp.net>
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
index b03065a..1fe0cd1 100644
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
@@ -713,25 +732,29 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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

