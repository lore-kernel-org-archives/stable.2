Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389F42DA35
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888724; cv=pass; b=M5C6F2rZfk+bW6b7v0piuKa9oKsEtXnNvQ3/Y0yAmMi1VazOtPRK1hVrNj8zGhQRWpwAUCz4viIFpwFaHKlg6yHCcM7/WhyeW2EP7yOVwGSS9t4V+UlCcS0A0HLJQ9Mqzy7U/mEc6vdggFWUhJXlf2M5wk1fk6Z2W9+DYN57DIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888724; c=relaxed/simple;
	bh=CIKK/qnPkOM3mgP0VgbgPMB7pCa6lyDQ6i9CN48rGfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyZPRIsZUnAA3zCiGAsFnEuhC572NUVjNHxqTOUsOgP/0bcFWTLkaZqi7ytMSxpvwwVUrWwyC5AO+nbk5vQRnC9RTd2/NP1SfadCXkKoHwLvH/WKh/MmZZrzCD00tB0X6Sxm8gLvoLR13j/MvXhB95RvWrdYGIDN5z/8bf4vYp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E15r1jWD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eGzZTxcd; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E15r1jWD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eGzZTxcd"
ARC-Seal: i=1; a=rsa-sha256; t=1784888719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J+ME8ZfdkMEDq9BjVUKFbaMh11AdxG/2kfiWS9iJaN1ZLp1amE4iprpPMJFmjbfaUF
    1vsjQdkCRM2BV35BsraluXWPtU501zW/bMMLTvjujG/t+69P7z7rdblgMnB9Bx9kvO05
    9WWO+UCdxQqcdaWIs1t+ASVXIkVgYAOiax6tm8TeOjzwn2qM3PKXVXDKScsWmTusZNP9
    SeY95MVkM779ZVPUR0x8floJqfaERrpfZmGicDzX3uAmiu4XoIG4Nj8y+E6Nn7uS/C2V
    LxiM3Pw0xBwW8UKCzsfnpK4XQ5q/0TRi06UX4V24CoZpIqUOv43Tdeh1xtezz6IxlJEC
    J3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888719;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iF1xp6qq/QFn7WlxK0qkhgTfrxbsT2aLYUhtL+Gum28=;
    b=Wtjjmto55/qeaP+xHaxYqUP9tYQPruoUFki51dmDEQdg05B2QjfZ/Jy2B9fdjXUkLy
    cCppQIVGvBoaA/HqKgD0KDmX4c7oFgDOAKLgAxEAJG9hYKcn7IYuDvSS+g5NqKoucCkX
    yJWkXd3Ha4zQdICN6EMLyULKUU1cJl8cAQcZ7uhU6a4A9YbfH86IBgOYkgMn6MfTKHl2
    kk8yrx3luv4QGJpwIuWwd7HMYFqk3ohluvl+VMP5hqkrIz0Cdq4q3WNB5eyapGDdn7za
    y3NJ1WSVtO2Dk2lUzX8WPzfs/PCAxRTdOY/3E6DIeXBkf7wfdWOb4OcHA+3XUsxcEUUS
    E1IA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888719;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iF1xp6qq/QFn7WlxK0qkhgTfrxbsT2aLYUhtL+Gum28=;
    b=E15r1jWDF717ZyF3poE2O7v3IuK5yNPcvnooeoQA/rM4D+uCMtm1WwFqSPd8BC4Tn4
    XzY9feSg+yCOGTQvDwncY2Eh7KQIsMNA/0PULXv14IhRZCCO6iPIf9cVVU4Q1x32R7Vq
    EyqQiE1u64LTnskMaIJD7EjptbUncdTXUXrQBOXOGWBif73Iyo8aSqHSuJOrm5Rk7NYJ
    vSpFptIh0aBgILl6++pDkLJxAgqBJvDn6zBSyQo6MhCnsFUdW7FfKZFVqN4z0gurB9Qh
    gKZQ5wq4bS/4mWs3S5dFyLs3TTJVgkRjlyd7ck7BB8EiuB50aIQzHUaEv7kN6m/RHTiW
    eMgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888719;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iF1xp6qq/QFn7WlxK0qkhgTfrxbsT2aLYUhtL+Gum28=;
    b=eGzZTxcdi853pXc6Q/0aJsMqBtm21wBKGbsZ9rN9LHCL/NSZY4EFEYsjifyUs0VOQF
    /SOmQYA/kZeqnA2szjAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAPJtIu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:25:19 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 2/8] can: bcm: fix CAN frame rx/tx statistics
Date: Fri, 24 Jul 2026 12:25:07 +0200
Message-ID: <20260724102513.16898-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102513.16898-1-socketcan@hartkopp.net>
References: <2026072011-atypical-tapping-9d9e@gregkh>
 <20260724102513.16898-1-socketcan@hartkopp.net>
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
index 50fc81b..bba0b27 100644
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
@@ -499,12 +521,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
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
@@ -750,24 +769,30 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
@@ -776,8 +801,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			traffic_flags |= RX_OWN;
 	}
 
-	spin_lock_bh(&op->bcm_rx_update_lock);
-
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
-- 
2.43.0

