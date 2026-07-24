Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AD422533
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889261; cv=pass; b=TU673FZC/QdG8bktSh3/9wHUoBKhmQRGTRy/hy4U+Cavotxo/AnbDOEiJfiMSpoYFQEHxFr8hO6EHRwIJJCWHJTlZHo5p3EiJaG3RaKNlJNsSdj+SyQKIbWik5YQFZpLK/B9dIkEb0iF2COpomIQwybqwykSYLLjikwEQRPYEnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889261; c=relaxed/simple;
	bh=826ZazTKwZj2w0rkxYeBgMbTtdADMXRarAhXI3HWZ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvVb4EXuNuIF+eKkycQ/z9ZrMwSgDk5o94G2uBuijROnrI5Lgk6PO/vtKq7w05pM9e4wSIS7CwJ6HrXEdd4cqdtPZLZAsZBS6Dzy8aJBN2HpDJgy+BmlBrZH+ADSR+V+veLpeiKEuPQeugCAzck+wlsWCa9dKWTRJ5DDjBYpCe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=T/58VZiM; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=phmJ4qgC; arc=pass smtp.client-ip=85.215.255.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="T/58VZiM";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="phmJ4qgC"
ARC-Seal: i=1; a=rsa-sha256; t=1784889256; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gUpgfnhQbDkjDNMZga4G9TeXDKie/mWUppr9uQ9TZL/xRZPb1XkoNxJ4PH2bl2Vom6
    0Qr/mCTODfY2CtVOod85mp0XlwZhyg1KtDueRhSoWSAzHW6LBmLZgOjZJgmHXYAfOewT
    nCEGv2HYVuNL1bZaldP3XJU+OZTmatOwcNP5ihPu6q7g6U/zl/qvrOG0vto93rlaZLgJ
    P7eYOoICSC2rYq53YYheOzPhpxZk2/oim5/AQTUyCzvqdOwZpQDqT5bdO0ItH5EvAfVE
    aHJH8vE3HAFhOMGGiTQ2Ey6HeQuYMq31bAnDtOTfOCKBRBfk1MF2FhpzICckIAjvUx5/
    lhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784889256;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CeVqEwSt6Jj4wR85eeycJatAHKMVCZQQkYAKiPA8T5I=;
    b=eRJ3mEOdGC8MBaIYp+GM4W96Gxaphs0JTuYNck1gP4gvfLsZH75vXO2rI1tqdw41j1
    TaS9/5QelTPKjnDRTOphM6WLYvStRnBIi5BYWczmUgqEv8QnxLfx6Fvpb2ajAmh1Gn04
    OMXGqJdXBpX8Okx8lqWd0/uTz1wtKGLMdHvDikJ7kXoADcGq+kwrwYLmeyqPhRJjZemp
    sOn74R7lRHzd6r5VSNnn6SUZKCtB+dpQNiRLw52/wFWFMmNqj5XsaMXDNxJ+2DnvrBPN
    wnJyUdILs//dtGpscQPugm0FK6mEwcfTF0dJGMh2XggtE5wRf/d9z+/vFF0kSaYpGCpU
    H33A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784889256;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CeVqEwSt6Jj4wR85eeycJatAHKMVCZQQkYAKiPA8T5I=;
    b=T/58VZiM2S/u4mrg6W2o25S4K33GUSfyQ2NwmEAGHUKpAGc1sWMlWvqVNoC56UEEA4
    VgNc+GYZ//LRkip+kdfPZrXr5lnmujUe5sIH7U+Rq0jjnI4+taI0DqPjNsuuyjIxH3D5
    HBNMFxKuv342AcqX9/0snZRKLzfspDTPkUkJorhVBEDc+b/D3azFnq/u8skKYgSw1z7v
    WteIPoi5GZ3Kw/I95zipvo/bwzi7RxPfkrPH0Q8yq67D+8UPuEj6eN9R13Jxf2GYx9wa
    h0YaObbFbG9I81y4K0kSix7a/Ry1kckk4AQZTSswcVu2BaZFwaCgpVSxxTTyWl5iCSk6
    LxlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784889256;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CeVqEwSt6Jj4wR85eeycJatAHKMVCZQQkYAKiPA8T5I=;
    b=phmJ4qgC3t2Z9VJyHubTOSVfuhxNDgELIQzZkRf3/FlXMmzspNDozfYV+EyMlIRFvA
    oJCYa0kfEjTVRs94l1AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAYFtML
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:34:15 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y 2/2] can: isotp: serialize TX state transitions under so->rx_lock
Date: Fri, 24 Jul 2026 12:34:09 +0200
Message-ID: <20260724103409.17867-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724103409.17867-1-socketcan@hartkopp.net>
References: <2026072053-spoils-overlying-285a@gregkh>
 <20260724103409.17867-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit cf070fe33bfbd1a4c21236078fadb35dd223a157 upstream.

The TX state machine (so->tx.state) is driven from three contexts:
sendmsg() claiming and progressing a transfer, the RX path consuming
Flow Control/echo frames, and two hrtimers timing out a stalled
transfer. Mixing a lock-free cmpxchg() claim in sendmsg() with
hrtimer_cancel() calls made under so->rx_lock elsewhere left windows
where a frame or timer callback could act on a state that had already
moved on, corrupting an unrelated transfer.

so->rx_lock now covers the full lifecycle of a TX claim: sendmsg()
takes it to check so->tx.state is ISOTP_IDLE, switch it to
ISOTP_SENDING, bump so->tx_gen and drain the previous transfer's
timers - all as one critical section. isotp_rcv_fc()/isotp_rcv_cf()
already run under this lock via isotp_rcv(), and isotp_rcv_echo() now
takes it itself, so none of them can ever observe a transfer mid-claim.
This also means a transfer can no longer be handed to sendmsg()'s
cleanup paths (signal or send error) while another thread is
concurrently claiming or finishing it, so those paths can cancel
timers and reset the state unconditionally.

isotp_release() claims the socket the same way, so a racing sendmsg()
sees a consistent ISOTP_SHUTDOWN and skips arming its timer or sending.

Only the hrtimer callbacks stay outside so->rx_lock, since they run
under so->rx_lock's cancellation elsewhere and taking it themselves
would deadlock. so->tx_gen lets them recognize whether the transfer
they timed out is still the one currently active, so they don't
report an error against a transfer that has since completed or been
superseded.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260712-isotp-fixes-v10-3-793a1b1ce17f@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 192 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 154 insertions(+), 38 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index b906fcd..efc5eea 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -155,7 +155,7 @@ struct isotp_sock {
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer, txfrtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer, echotimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
@@ -163,6 +163,7 @@ struct isotp_sock {
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
 	u32 cfecho; /* consecutive frame echo tag */
+	u32 tx_gen; /* generation, bumped per new tx transfer */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -369,6 +370,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
 	hrtimer_cancel(&so->txtimer);
 
+	/* isotp_tx_timeout() may have given up on this job while
+	 * hrtimer_cancel() above waited for it to finish; so->rx_lock
+	 * (held by our caller isotp_rcv()) rules out a concurrent claim,
+	 * so a plain recheck is enough here.
+	 */
+	if (so->tx.state != ISOTP_WAIT_FC &&
+	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+		return 1;
+
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	     check_pad(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
@@ -414,7 +424,7 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
 		/* send CF frame and enable echo timeout handling */
-		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
 		break;
@@ -567,6 +577,14 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 
 	hrtimer_cancel(&so->rxtimer);
 
+	/* isotp_rx_timer_handler() may have raced us for so->rx.state
+	 * while hrtimer_cancel() above waited for it to finish, already
+	 * reporting ETIMEDOUT and resetting the reception; don't process
+	 * this CF into a reassembly that has already been given up on.
+	 */
+	if (so->rx.state != ISOTP_WAIT_DATA)
+		return 1;
+
 	/* CFs are never longer than the FF */
 	if (cf->len > so->rx.ll_dl)
 		return 1;
@@ -856,20 +874,36 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
-	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+	if (skb->sk != sk)
 		return;
 
+	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
+	 * (no isotp_rcv() caller here), so take it ourselves
+	 */
+	spin_lock(&so->rx_lock);
+
+	/* so->cfecho may since belong to a new transfer; recheck under lock */
+	if (so->cfecho != *(u32 *)cf->data)
+		goto out_unlock;
+
 	/* cancel local echo timeout */
-	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	so->cfecho = 0;
 
+	/* claiming a transfer also takes so->rx_lock, so a plain recheck
+	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
+	 * a new claim while we're still in here
+	 */
+	if (so->tx.state != ISOTP_SENDING)
+		goto out_unlock;
+
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
-		return;
+		goto out_unlock;
 	}
 
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
@@ -877,53 +911,83 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 		so->tx.state = ISOTP_WAIT_FC;
 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
-		return;
+		goto out_unlock;
 	}
 
 	/* no gap between data frames needed => use burst mode */
 	if (!so->tx_gap) {
 		/* enable echo timeout handling */
-		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
-		return;
+		goto out_unlock;
 	}
 
 	/* start timer to send next consecutive frame with correct delay */
 	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+
+out_unlock:
+	spin_unlock(&so->rx_lock);
 }
 
-static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
+ * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
+ * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
+ * a new transfer with an error from the one that just timed out.
+ */
+static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 {
-	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
-					     txtimer);
 	struct sock *sk = &so->sk;
+	u32 gen = READ_ONCE(so->tx_gen);
+	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
-	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	/* only claim the timeout if the state is still unchanged */
+	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
 	/* we did not get any flow control or echo frame in time */
 
-	/* report 'communication error on send' */
-	sk->sk_err = ECOMM;
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	if (READ_ONCE(so->tx_gen) == gen) {
+		/* report 'communication error on send' */
+		sk->sk_err = ECOMM;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk_error_report(sk);
+	}
 
-	/* reset tx state */
-	so->tx.state = ISOTP_IDLE;
 	wake_up_interruptible(&so->wait);
 
 	return HRTIMER_NORESTART;
 }
 
+/* so->txtimer: fires when a Flow Control frame does not arrive in time */
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+
+	return isotp_tx_timeout(so);
+}
+
+/* so->echotimer: fires when a sent CF/SF's local echo does not arrive */
+static enum hrtimer_restart isotp_echo_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     echotimer);
+
+	return isotp_tx_timeout(so);
+}
+
 static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txfrtimer);
 
 	/* start echo timeout handling and cover below protocol error */
-	hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+	hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* cfecho should be consumed by isotp_rcv_echo() here */
@@ -943,13 +1007,24 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
+	struct hrtimer *tx_hrt = &so->echotimer;
+	u32 new_state = ISOTP_SENDING;
 	int off;
 	int err;
 
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+	/* claim the socket under so->rx_lock: this serializes the claim
+	 * with the RX path and with sendmsg()'s own error paths below, so
+	 * none of them can ever see a transfer mid-claim
+	 */
+	for (;;) {
+		spin_lock_bh(&so->rx_lock);
+		if (READ_ONCE(so->tx.state) == ISOTP_IDLE)
+			break;
+		spin_unlock_bh(&so->rx_lock);
+
 		/* we do not support multiple buffers - for now */
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
@@ -958,11 +1033,23 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait,
+					       so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_event_drop;
+			return err;
 	}
 
+	/* new transfer: bump so->tx_gen and drain the old one's timers,
+	 * still under the so->rx_lock we just claimed the socket with
+	 */
+	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
+	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
+	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
+	hrtimer_cancel(&so->txfrtimer);
+	so->cfecho = 0;
+	spin_unlock_bh(&so->rx_lock);
+
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile, so re-validate it
 	 */
@@ -1073,18 +1160,33 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			so->cfecho = *(u32 *)cf->data;
 		} else {
 			/* standard flow control check */
-			so->tx.state = ISOTP_WAIT_FIRST_FC;
+			new_state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
 			hrtimer_sec = ISOTP_FC_TIMEOUT;
+			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
 			so->cfecho = 0;
 		}
 	}
 
-	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+	spin_lock_bh(&so->rx_lock);
+	if (so->tx.state == ISOTP_SHUTDOWN) {
+		/* isotp_release() has since taken over and already drained
+		 * our timers - don't send into a socket that's going away
+		 */
+		spin_unlock_bh(&so->rx_lock);
+		kfree_skb(skb);
+		dev_put(dev);
+		wake_up_interruptible(&so->wait);
+		return -EADDRNOTAVAIL;
+	}
+	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
+	so->tx.state = new_state;
+	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock_bh(&so->rx_lock);
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
@@ -1097,13 +1199,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
 
+		spin_lock_bh(&so->rx_lock);
 		/* no transmission -> no timeout monitoring */
-		hrtimer_cancel(&so->txtimer);
-
-		/* reset consecutive frame echo tag */
-		so->cfecho = 0;
-
-		goto err_out_drop;
+		hrtimer_cancel(tx_hrt);
+		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
@@ -1119,14 +1218,21 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	return size;
 
+err_out_drop:
+	/* claimed but nothing sent yet - no timer to cancel */
+	spin_lock_bh(&so->rx_lock);
+	goto err_out_drop_locked;
 err_event_drop:
-	/* got signal: force tx state machine to be idle */
-	so->tx.state = ISOTP_IDLE;
+	/* interrupted waiting on our own transfer - drain its timers */
+	spin_lock_bh(&so->rx_lock);
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
-err_out_drop:
-	/* drop this PDU and unlock a potential wait queue */
+	hrtimer_cancel(&so->echotimer);
+err_out_drop_locked:
+	/* release the claim; so->rx_lock still held from above */
+	so->cfecho = 0;
 	so->tx.state = ISOTP_IDLE;
+	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
 	return err;
@@ -1188,13 +1294,20 @@ static int isotp_release(struct socket *sock)
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
-	/* wait for complete transmission of current pdu */
-	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
-	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+	/* best-effort: wait for a running pdu to finish, but don't block on
+	 * it forever - give up after the first signal
+	 */
+	while (so->tx.state != ISOTP_IDLE &&
+	       wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0)
 		;
 
-	/* force state machines to be idle also when a signal occurred */
+	/* claim the socket under so->rx_lock like sendmsg() does, so its
+	 * claim can't race the forced ISOTP_SHUTDOWN below; force it
+	 * unconditionally, even when a signal cut the wait above short
+	 */
+	spin_lock_bh(&so->rx_lock);
 	so->tx.state = ISOTP_SHUTDOWN;
+	spin_unlock_bh(&so->rx_lock);
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
@@ -1240,6 +1353,7 @@ static int isotp_release(struct socket *sock)
 
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	sock_orphan(sk);
@@ -1682,6 +1796,8 @@ static int isotp_init(struct sock *sk)
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
+	hrtimer_init(&so->echotimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	so->echotimer.function = isotp_echo_timer_handler;
 	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txfrtimer.function = isotp_txfr_timer_handler;
 
-- 
2.43.0

