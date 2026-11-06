Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977852;
	b=ClhjMZly9bThRgJaBGUqy/gKrryyZic89wzERThUkgrz4NGCabEXAJtXgBnoVkzYGyFS
	 q7UsQ0wHd2E2H6hRcGfEmoivggsjQMWDyxktTQ8GPCpVCPCdX/84wYTJDZMbUZ7I1aVXb
	 i7YBZGNqaAcBgV8i6RxUyLC+aF4n6+HwLpIRCpSdtZTfD1S0CpTZpsZRfk/L/TNi2kvSi
	 4+ed3DwhT1PF/gkul7cQJ9HNmi+2i7pfe+tPV7GHtsLyQ/E9CelBC7hNr2do0+jn57rfg
	 3ODmLG7Wt7Ye9TVTBXQSJJkpfCaMMQrh++rJLGY5RVtGT9GhP1VVlR5UibY6Uhx2Hmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TopHnBkeMV7XM9K4vu6trxMuWEC+nQ/wulHs0l11oL8=;
	b=KMQJgjLJ01O/cP7fEnviy8A2Pl1qXAFOgc6JPBnt8Et7bgaw/8UYZ+CEfU0VKdkuUdX9
	 RdgCbCpbfwOmFlUybfCQA+GT1pPD35ONVBuaxMzrnJ+ngbfTadmJpsigy/TRSfxlRQeqy
	 JIxlt/bLWF6o+IgGs8Bdoy3P0O40owVHloLHELVv2DRnP2UUwZacjjzsWvQbsz/grlHgN
	 K1XtmLNxiPmYbV8JCxqs24OoR5tyys1tIdpNxVH74d2LfrSoFuGuN9qtrxn8e+nHHR8HO
	 mBr+33AVqlqxtxd6cbE68JCjbthKJB1ZKLI3pr1N998cQRS//jK4ik/PlskMZKQGBeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFqlFcfR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AF606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFqlFcfR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C07A1F0089F;
	Fri,  6 Nov 2026 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977852;
	bh=TopHnBkeMV7XM9K4vu6trxMuWEC+nQ/wulHs0l11oL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFqlFcfRljn3fzpyVeaSIeFytQYBJbSVE70ckHJZWCDRvHUd5qyQifVp5SiQVy7Rg
	 nepm5DGLSSi9KEcM+d3wE4aaTaUjN2DsBR1sgZpnpqrxihoJEOZloZ4sr5MqvNmBSF
	 2c3I0EZQMfJ6MG7gK0WT01wI8S7cahEFRlG9BBLuQwi9ktp4A0CjdVuO7puZ7BjSKP
	 JSbvIb71FBgQAQPhuKuSJXqH3L5PvcpHCAQUgJVhrZx4D9dAENGMZe11WASbG8qB3A
	 HVR/F37RgLoN88Iiav6qMmSYvYTRWbaZLaELE8B/L+Ys/J7500Bt/SlLxe7H72fvFo
	 x1phNweaaPvPA==
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
Subject: [PATCH 5.15.y] rxrpc: Fix update of call->tx_pending without holding lock
Date: Fri,  6 Nov 2026 10:10:49 -0500
Message-ID: <20261106151017.355384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-author-rockfish-7f6e@gregkh>
References: <2026110440-author-rockfish-7f6e@gregkh>
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
[ sashal: adapted rxrpc_txbuf handling to the existing sk_buff-based send path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 57 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index b03d93d8b69d0..28cd9fe93844e 100644
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
@@ -381,6 +378,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			       sp->remain);
 
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			call->tx_pending = skb;
+		} else {
+			rxrpc_see_skb(skb, rxrpc_skb_seen);
 		}
 
 		_debug("append");
@@ -432,13 +432,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 			ret = call->security->secure_packet(call, skb, skb->mark);
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
 
@@ -450,45 +450,46 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
@@ -650,7 +651,6 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	enum rxrpc_call_state state;
 	struct rxrpc_call *call;
 	unsigned long now, j;
-	bool dropped_lock = false;
 	int ret;
 
 	struct rxrpc_send_params p = {
@@ -760,12 +760,12 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
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
@@ -793,7 +793,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
 			   rxrpc_notify_end_tx_t notify_end_tx)
 {
-	bool dropped_lock = false;
 	int ret;
 
 	_enter("{%d,%s},", call->debug_id, rxrpc_call_states[call->state]);
@@ -811,8 +810,8 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
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
@@ -825,8 +824,8 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
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

