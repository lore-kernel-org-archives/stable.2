Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971457;
	b=iBwIUNEkMOGoTV40yj8j7PmaaYVUqdb/2/G6qp/E7Ciq6m5iF35AN1zcZUJUcm6sLDAw
	 hDHcK9g2v+Bs5WWt+yzvfoy6MbYaHi1wpXQ+tq0ve8xUKiHJQ+Gqgb0I4dvGTxyLurIzw
	 7814DFrFugOigUIvIaZMkYIB1l3mTc2Pbrkrk0IQwlYitLI5IQ7L6Ajsd5GUSWXZiK/a5
	 l5OlAXaiMw/OjpfkSmC0YOKqb2d9R1rr0GTYaO7TqgM2paa8Od0ZAAknkV9TT4sS8J/vH
	 U9k1wQHFK00vOanDOO2IjrtxawQgmecOVmlB/I3IvnGyA0cIb/AiUIzqH2xyqMhn1KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GyOGPoX74Qb1IAG6MeJsBUrClAuyfH9T14N9wcFaAIc=;
	b=d9KStuVouM0i2bBO5IEwvHP1jHkNgaHUqS0pOIQu38DSqHTRPZfZLgzrpR8bLyQSt3tz
	 hEh8KAwGrZHmMkVk5+BYKb22nWaHWpHdnMUnnP5FAyGBnTXtvwe4FqeOzRUXt57t+6nYX
	 oFJwguD+8VhEwKqJbI0+jLllElvurTslbyG9xcaNjz0b/UhJFWFi/pXTMr9puj2nrUKES
	 5PsmUw+DHTKGSOXeAK77gIDQ7TM6uLJ373iWkkWypXs5j3Sp2+ff1cRDI5xrhF1uEUdfP
	 vCwei64r4ri2DX70HeaIqeV9qsfaAUALsNz1LKEczdcVRanolmwRZT5W/p4meazbllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HbD/QcDz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B87606A33F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbD/QcDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABFA1F0089F;
	Fri,  6 Nov 2026 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971457;
	bh=GyOGPoX74Qb1IAG6MeJsBUrClAuyfH9T14N9wcFaAIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbD/QcDzStgSBcww0YfdC4HcreLET1k8h3VPBBQIDX5FVPauTxFvbwRJa234OCzVC
	 Hmafbm1eX0lY5wf4JGeiM9r0tQc/4ser6eQflBJmz2jsJZO4SeVnSmTfuSmRlNXTTo
	 c3usMQKYlAxPbLNkqPqayukJp6azpfr2GnQVkFAfBGatCcbtvbGHm/yp9hsPyYvk6Y
	 fS/eEGzbPkbRGyoSIr5mlOk0hYAxnbdC9fx/gNnAXmNipUHUegud61oY3oZJqU2Yya
	 if/KXF6zGREeOP+ZJ5U4DXG9jCdmFnlij4xmpXxMOHJfWQz9xKye4Gs2xurPsimBiM
	 lrZzNfEwpxnFQ==
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
Subject: [PATCH 6.6.y] rxrpc: Fix update of call->tx_pending without holding lock
Date: Fri,  6 Nov 2026 08:24:14 -0500
Message-ID: <20261106132301.13922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-unified-reanalyze-a2ce@gregkh>
References: <2026110438-unified-reanalyze-a2ce@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: adapted caller cleanup to the existing if/else dispatch instead of upstream’s switch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 59 +++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 3dc54d6d4e316..dc86edb9bd3a8 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -279,10 +279,9 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 static int rxrpc_send_data(struct rxrpc_sock *rx,
 			   struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
-			   rxrpc_notify_end_tx_t notify_end_tx,
-			   bool *_dropped_lock)
+			   rxrpc_notify_end_tx_t notify_end_tx)
+	__releases(&call->user_mutex)
 {
-	struct rxrpc_txbuf *txb;
 	struct sock *sk = &rx->sk;
 	enum rxrpc_call_state state;
 	long timeo;
@@ -293,23 +292,18 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 	ret = rxrpc_wait_to_be_connected(call, &timeo);
 	if (ret < 0)
-		return ret;
+		goto out_unlock;
 
 	if (call->conn->state == RXRPC_CONN_CLIENT_UNSECURED) {
 		ret = rxrpc_init_client_conn_security(call->conn);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 	}
 
 	/* this should be in poll */
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 reload:
-	txb = call->tx_pending;
-	call->tx_pending = NULL;
-	if (txb)
-		rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
-
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		goto maybe_error;
@@ -337,6 +331,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	}
 
 	do {
+		struct rxrpc_txbuf *txb = call->tx_pending;
+
 		if (!txb) {
 			size_t remain, bufsize, chunk, offset;
 
@@ -367,6 +363,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			txb->offset = offset;
 			txb->space -= offset;
 			txb->space = min_t(size_t, chunk, txb->space);
+			call->tx_pending = txb;
+		} else {
+			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
 		}
 
 		_debug("append");
@@ -406,10 +405,10 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 			ret = call->security->secure_packet(call, txb);
 			if (ret < 0)
-				goto out;
+				goto out_unlock;
 
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
-			txb = NULL;
+			call->tx_pending = NULL;
 		}
 	} while (msg_data_left(msg) > 0);
 
@@ -418,45 +417,46 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	if (rxrpc_call_is_complete(call) &&
 	    call->error < 0)
 		ret = call->error;
-out:
-	call->tx_pending = txb;
+out_unlock:
+	mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 
 call_terminated:
-	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_send_aborted);
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
@@ -615,7 +615,6 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 {
 	struct rxrpc_call *call;
 	unsigned long now, j;
-	bool dropped_lock = false;
 	int ret;
 
 	struct rxrpc_send_params p = {
@@ -725,12 +724,12 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
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
 	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
 	_leave(" = %d", ret);
@@ -758,7 +757,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
 			   rxrpc_notify_end_tx_t notify_end_tx)
 {
-	bool dropped_lock = false;
 	int ret;
 
 	_enter("{%d},", call->debug_id);
@@ -769,12 +767,9 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	mutex_lock(&call->user_mutex);
 
 	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
-			      notify_end_tx, &dropped_lock);
+			      notify_end_tx);
 	if (ret == -ESHUTDOWN)
 		ret = call->error;
-
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 }
-- 
2.53.0

