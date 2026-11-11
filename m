Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393473;
	b=3Bp5q2oa/PSNrUcXhXmyymTh9ztkCM3v9Qg2xO1IL8fAB/HjGCLtJcx4bD2vUflLG5eD
	 cfut7tCOYQCcgS7ukbrF1HVFf39u8nQ3mGTi8pHukPn876hhh3CdxZarvl2uB2zvX1rjD
	 0RkRKO47NO9ec5R9ERTryFmEuDrZKaylXsY144y7FoXTDQDqN3AwVkHFaGlx924HV1qOR
	 3bHX+YAh8XswUZpKbk7+inLSJt69m4DsVWkvssvxvwNQplm4c+CtSBSCmUMwv9hIi+GhP
	 7AJmNEUJUAPxkh8JjEg64URmROh2ADZ2HJDiojtVQH9FwGZ7Jo244CYitLUXRC22kfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393473;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=LTxP+YIomqSIzpLJsllAgnu6yXFb3cfcIae7hFBjMxU=;
	b=o9e4Ud/QN8twp6KxPvlSquPkA94KVq0lv0wGGhHPLYq5OdexF/LB5g0fWeBGaHN6z6Zi
	 eoDt4lbPX4ZFTBOqi6M9k1jGPb9FsBW2BeyHMjyUT/wbhYP1pB+gWV+vbRTglb9N8nDQN
	 F2UQ5bVIySReJF0Rh375DY7ocWepv0/kDasvUY7FsBRkp90CE/bNqY6xVTarqz1a0jrUr
	 FCa87t90WXxeuG//KKO+SFtqpb+0TAHynelhbhKDhQMhkPsXMR3XYVNz3Z9SVZm6iR0jV
	 xnNdKtmcVseOd3xOEFM7u1d04Z4CWfYXuGt4meteijOgGFDFZ3UKxmhABiC3aKKMMzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Nh18guJG;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5F606A886;
	Wed, 11 Nov 2026 10:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF5F606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Nh18guJG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=LTxP+YIomqSIzpLJsllAgnu6yXFb3cfcIae7hFBjMxU=;
	b=Nh18guJG8ApkMjdlkyqc/hCyytu3uslVQWSivIuQ/BJNbc2abEO7oZCLHs4PZT
	hWorljnw88qNgdlp4G2u4nCp6LgfwOQmTU8q1yymPF4sDwLwXRK+4tCbisWvhxMa
	K4tYovKTztyNqnAPljpE6rLJsTRbnhIajTavO5/PTWekc=
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Wed, 11 Nov 2026 18:31:22 +0800
Subject: [PATCH net v9 1/4] can: j1939: serialize cancel and rearm of the
 receive timer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-j1939-edpo-v9-v9-1-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
In-Reply-To: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-CM-TRANSID:_____wD3n3ZtRfRq73WgGQ--.5537S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWDKw47XrWUXF4kCw1kGrg_yoWxCryrpr
	W3Wry3Gr17WF47Zr4ktFyDWryFvwn3J348Wr1xJ3s2yay3Cr45tF1DG34xWa9rtrW8Z3y3
	ua4Sqwn8Gw4kt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7o7NUUUUU=
Sender: quchaosheng000406@163.com
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4w5EuWr0RW5fvwAA3F

From: Chaosheng Qu <quchaosheng000406@163.com>

Cancel and rearm the receive timer as one atomic step under
active_session_list_lock.  j1939_tp_set_rxtimeout() cancels the timer,
takes a reference and starts it again, but its callers do not agree on that
lock: the receive handlers call it without the lock, while
j1939_session_cancel() is reached from the transmit timer path and used to
call it with the lock held.

That makes the sequence non-atomic.  If one caller starts the timer after
another has cancelled it and before that one starts it again, the second
hrtimer_start() reprograms an already armed timer.  hrtimer_start() does
not report that the timer was armed and does not drop the reference the
first caller took, so that reference is never released: the session, and
the netdev_hold() reference it carries, leak.

The lock cannot simply be taken around the existing helper, because
hrtimer_cancel() waits for a running callback and j1939_tp_rxtimer() takes
the same lock.  Add j1939_tp_arm_rxtimer_locked(), which uses
hrtimer_try_to_cancel() instead: it never waits, so it is safe under the
lock, and it returns 1 only when the timer was queued, which is the only
case in which the caller's reference has to be dropped.

j1939_tp_set_rxtimeout() now holds the lock around the helper,
j1939_session_cancel() calls the helper instead of hand-rolling
get + hrtimer_start(), and the rx timeout branch of j1939_tp_rxtimer()
does the same, removing a second copy of that sequence.

Every existing caller of j1939_tp_set_rxtimeout() is outside the lock, so
the added acquisition does not recurse.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 66 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5..fa23260e1 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -721,15 +721,42 @@ void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
-					  int msec)
+/*
+ * Rearm the receive timer as one step under active_session_list_lock.
+ *
+ * j1939_tp_set_rxtimeout() is called from receive handlers that do not hold
+ * the session list lock, while j1939_session_cancel() is called from the
+ * transmit timer path.  If the cancel and the rearm are not serialized, a
+ * concurrent caller can start the timer after this one cancelled it and
+ * before this one starts it again: hrtimer_start() on an already armed timer
+ * reprograms it without dropping the reference taken by that caller, and the
+ * session leaks together with its netdev reference.
+ *
+ * hrtimer_try_to_cancel() does not wait for a running callback, so it can be
+ * called with the lock held even though j1939_tp_rxtimer() takes the same
+ * lock; a callback that is already running drops its own reference.  For the
+ * same reason the return value is only 1 when the timer was queued: when this
+ * runs from j1939_tp_rxtimer() itself, the timer is no longer queued and 0 is
+ * the expected result.
+ */
+static void j1939_tp_arm_rxtimer_locked(struct j1939_session *session, int msec)
 {
-	j1939_session_rxtimer_cancel(session);
+	if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
+		j1939_session_put(session);
+
 	j1939_session_get(session);
 	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
+static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
+					  int msec)
+{
+	j1939_session_list_lock(session->priv);
+	j1939_tp_arm_rxtimer_locked(session, msec);
+	j1939_session_list_unlock(session->priv);
+}
+
 static int j1939_session_tx_rts(struct j1939_session *session)
 {
 	u8 dat[8];
@@ -1161,18 +1188,29 @@ static void __j1939_session_cancel(struct j1939_session *session,
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool waiting;
+
 	j1939_session_list_lock(session->priv);
 
+	waiting = session->state == J1939_SESSION_WAITING_ABORT;
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
+		j1939_tp_arm_rxtimer_locked(session, J1939_XTP_ABORT_TIMEOUT_MS);
 	}
 
 	j1939_session_list_unlock(session->priv);
 
 	if (!session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
+
+	/* The abort already went out on an earlier call, so this one armed no
+	 * timer.  Several callers cancel the timers before calling here, which
+	 * would otherwise leave the session on the list with nothing to finish
+	 * it off, so deactivate it now.
+	 */
+	if (waiting)
+		j1939_session_deactivate_activate_next(session);
 }
 
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -1279,10 +1317,8 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		    session->state < J1939_SESSION_ACTIVE_MAX) {
 			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
 				     __func__, session);
-			j1939_session_get(session);
-			hrtimer_start(&session->rxtimer,
-				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
-				      HRTIMER_MODE_REL_SOFT);
+			j1939_tp_arm_rxtimer_locked(session,
+						    J1939_XTP_ABORT_TIMEOUT_MS);
 			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
 		}
 		j1939_session_list_unlock(session->priv);
@@ -1729,16 +1765,10 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-		if (session->transmission) {
-			j1939_session_deactivate_activate_next(session);
-		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
-			/* Force deactivation for the receiver.
-			 * If we rely on the timer starting in j1939_session_cancel,
-			 * a second RTS call here will cancel that timer and fail
-			 * to restart it because the state is already WAITING_ABORT.
-			 */
-			j1939_session_deactivate_activate_next(session);
-		}
+		/* Both roles: the peer is restarting the transfer, so free the
+		 * slot now rather than wait out the abort timeout.
+		 */
+		j1939_session_deactivate_activate_next(session);
 
 		return -EBUSY;
 	}

-- 
2.43.0


