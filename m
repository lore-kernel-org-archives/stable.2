Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982287;
	b=AxTLRCLgQInj0yLSDY7H7UMCYADuPNG/H69ewEiWRmS9bFm62F3FsKMgcFK2WST5u3i9
	 AspUjUAXv9hVy5B4jmIzluFbDzlQP78tGhEVAMzw5uGicPbblsp0dMgZD1IpSKksj2lvT
	 kUTDNKGgd9f5FSAm6uUSAWMZntOMVAja9G4H0f43dgmtiZB3De0PFwO1xpIzrGN+7HsIo
	 z82NkcwOkgLcCemN/ySTl10rPgDil12z8nUeMqyHfxC3Z3C1Es8w4z6vH/IpDDkFK2VWK
	 lRzTmqxp7JVCww09+sIfCptl5wyYYK9JLCLQHDuAyK9EbhdtcSEEUy08IzE13gkjIJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2z4VVs1Qo8OYp3DZuSp2R/7gbv0QlVZXOPABkWi5IYI=;
	b=QtG+LiygNYL/d6BrDs6j4n+tQbuVRbDCDRVt2pQ8GhPdlybPSYfm9AOuNPz69BcRnLHs
	 pG7TcZpgJK1tyWUxRlk8MkZGtfmK/hdseuwM9lm8t/bljE42KwjcLhDlXVUdbcYTv+PZo
	 iyypm9soQN9mi4muaLmYcWvsV+tp61+C0qKyENPFNsIKr+v9a7r0OAE2KMFkaaDzRCvkz
	 CdmPYy0O0Wxwf1is95IoAU2cjytLGTXhxpdwKl6BVpLoo8IurMGl3YDELWmxU2pGipIy0
	 o9QoSiigrTpEi+hMlGfMAwDDVuNOrmXAKx6N3JsY1LtveJs2H6QF/55hi5e5Erb6T/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UzS/gPMP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C3606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzS/gPMP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B11F0089F;
	Fri,  6 Nov 2026 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982287;
	bh=2z4VVs1Qo8OYp3DZuSp2R/7gbv0QlVZXOPABkWi5IYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzS/gPMPIrdK3W2v16GP2Am9fGP/wd3HKETOo2BR/MvJfurl+Scxev1/C3X1g40G0
	 qa5FRnnhsKxcaHnQyIHaCWFEAfOcnzvCC5EapJE3H1y0UKNopA8HAJcmcT0qnOiVU6
	 NOyr5iWgoPQQegD6HTaolJg6ppB3S977Ad6NsmMO+P77Jbf8CYON16JUmC383EJ3ud
	 0G7pBjxDkSaU01O0f7iQVObWn5Q0S68G3zLU42WzPyImGJDyioWowJUHxiZumRDzZB
	 aGx9vi8oEjqunUTAuL3m6/vxbr6UCBJ9XipaENMwrB6eANw/xWH/pF36OoEDBSWQ89
	 a32PY3GgNuyYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] rxrpc: Fix update of call->tx_pending without holding lock
Date: Fri,  6 Nov 2026 11:24:44 -0500
Message-ID: <20261106162423.437376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110441-rocklike-unbeaten-72b2@gregkh>
References: <2026110441-rocklike-unbeaten-72b2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7801c42c3bb737cfb06194a383873fcad8daacf5 ]

Currently, rxrpc_send_data() updates call->tx_pending just before it
returns - but it won't be holding the call->user_mutex when it does this if
a wait was interrupted by a signal.  This would allow a parallel sendmsg()
to race.

Further, both the callers of rxrpc_send_data() call it with the lock held,
and then it returns an indication through the parameter list to say whether
it has dropped the lock or not - after which the callers both just drop the
lock if it's still held.

Fix this by:

 (1) Moving the release of call->user_mutex down into rxrpc_send_data() and
     get rid of the indicator parameter.  This makes it easier to see where
     the lock is held.

 (2) After waiting, if the attempt to reacquire the mutex is interrupted,
     just return directly there rather than going to out_unlock

 (3) Restricting the txb variable to inside the buffering loop and leaving
     ->tx_pending set until we've queued the buffer.

Note that there's a slight change in behaviour in that wait_for_space
failure now doesn't check for completion because it doesn't hold the call
user_mutex.  The caller, however, should re-issue the send and pick up any
error at a second attempt.

Fixes: b0f571ecd794 ("rxrpc: Fix locking in rxrpc's sendmsg")
Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261006133011.531806-4-dhowells@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: adapted rxrpc_txbuf handling to the existing sk_buff-based send path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 57 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 0b24d09637252..b6ea5369309de 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -287,11 +287,10 @@ static int rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 static int rxrpc_send_data(struct rxrpc_sock *rx,
 			   struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
-			   rxrpc_notify_end_tx_t notify_end_tx,
-			   bool *_dropped_lock)
+			   rxrpc_notify_end_tx_t notify_end_tx)
+	__releases(&call->user_mutex)
 {
 	struct rxrpc_skb_priv *sp;
-	struct sk_buff *skb;
 	struct sock *sk = &rx->sk;
 	enum rxrpc_call_state state;
 	long timeo;
@@ -325,11 +324,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			goto maybe_error;
 	}
 
-	skb = call->tx_pending;
-	call->tx_pending = NULL;
-	rxrpc_see_skb(skb, rxrpc_skb_seen);
-
 	do {
+		struct sk_buff *skb = call->tx_pending;
+
 		/* Check to see if there's a ping ACK to reply to. */
 		if (call->ackr_reason == RXRPC_ACK_PING_RESPONSE)
 			rxrpc_send_ack_packet(call, false, NULL);
@@ -386,6 +383,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			       sp->remain);
 
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			call->tx_pending = skb;
+		} else {
+			rxrpc_see_skb(skb, rxrpc_skb_seen);
 		}
 
 		_debug("append");
@@ -449,13 +449,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			ret = call->security->secure_packet(
 				call, skb, skb->mark, skb->head);
 			if (ret < 0)
-				goto out;
+				goto out_unlock;
 
 			ret = rxrpc_queue_packet(rx, call, skb,
 						 !msg_data_left(msg) && !more,
 						 notify_end_tx);
 			/* Should check for failure here */
-			skb = NULL;
+			call->tx_pending = NULL;
 		}
 	} while (msg_data_left(msg) > 0);
 
@@ -467,45 +467,46 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			ret = call->error;
 		read_unlock_bh(&call->state_lock);
 	}
-out:
-	call->tx_pending = skb;
+out_unlock:
+	mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 
 call_terminated:
-	rxrpc_free_skb(skb, rxrpc_skb_freed);
-	_leave(" = %d", call->error);
-	return call->error;
+	ret = call->error;
+	goto out_unlock;
 
 maybe_error:
 	if (copied)
 		goto success;
-	goto out;
+	goto out_unlock;
 
 efault:
 	ret = -EFAULT;
-	goto out;
+	goto out_unlock;
 
 wait_for_space:
 	ret = -EAGAIN;
 	if (msg->msg_flags & MSG_DONTWAIT)
 		goto maybe_error;
 	mutex_unlock(&call->user_mutex);
-	*_dropped_lock = true;
+
 	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
 				       msg->msg_flags & MSG_WAITALL);
 	if (ret < 0)
-		goto maybe_error;
+		goto out_nolock;
 	if (call->interruptibility == RXRPC_INTERRUPTIBLE) {
 		if (mutex_lock_interruptible(&call->user_mutex) < 0) {
 			ret = sock_intr_errno(timeo);
-			goto maybe_error;
+			goto out_nolock;
 		}
 	} else {
 		mutex_lock(&call->user_mutex);
 	}
-	*_dropped_lock = false;
 	goto reload;
+out_nolock:
+	_leave(" = %d [intr]", ret);
+	return copied ?: ret;
 }
 
 /*
@@ -667,7 +668,6 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	enum rxrpc_call_state state;
 	struct rxrpc_call *call;
 	unsigned long now, j;
-	bool dropped_lock = false;
 	int ret;
 
 	struct rxrpc_send_params p = {
@@ -777,12 +777,12 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	} else if (p.command != RXRPC_CMD_SEND_DATA) {
 		ret = -EINVAL;
 	} else {
-		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
+		ret = rxrpc_send_data(rx, call, msg, len, NULL);
+		goto error_put;
 	}
 
 out_put_unlock:
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
+	mutex_unlock(&call->user_mutex);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put);
 	_leave(" = %d", ret);
@@ -810,7 +810,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
 			   rxrpc_notify_end_tx_t notify_end_tx)
 {
-	bool dropped_lock = false;
 	int ret;
 
 	_enter("{%d,%s},", call->debug_id, rxrpc_call_states[call->state]);
@@ -828,8 +827,8 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
 	case RXRPC_CALL_SERVER_SEND_REPLY:
 		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
-				      notify_end_tx, &dropped_lock);
-		break;
+				      notify_end_tx);
+		goto out;
 	case RXRPC_CALL_COMPLETE:
 		read_lock_bh(&call->state_lock);
 		ret = call->error;
@@ -842,8 +841,8 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 		break;
 	}
 
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
+	mutex_unlock(&call->user_mutex);
+out:
 	_leave(" = %d", ret);
 	return ret;
 }
-- 
2.53.0

