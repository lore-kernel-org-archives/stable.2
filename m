Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6764B1D19
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170665; cv=none; b=WiRBDVQzNG8fURj/kMn5qOAoPDypgF2+mH07GpbAYLNuIFMNtn/Hqh7C81M6m58twof6ItGPwVK84Qm/TaOFVbRQq5yuF1+h+6d774KCoLY0dHhvBtSOyKSEx0xQUBaLn9VJbmCftct2DLIGut+FxNifHOPpgr7QojQ+lS1mkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170665; c=relaxed/simple;
	bh=5VX9gYYEf/sTJG4nfVy4FwufwOgJyzH6XIvquctxgfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ58710PaVJuY6dMui6ziMr2U26kvABQ0/U+qPbCjMN9HQgMME1PsEqQw7cD33x3ux20ku7NBu6fwcbgKHdNgNRCPFuasywr6VsI91qmXV9ThDJ8VyXrYX+UGeV/hXLPCJN5m2Avjl86EoMW+e8Khiwwzx8iXz0B9IrwhFNfR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blySBfim; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blySBfim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLsrlWFNUE9H47XWQfC/ZAY1xGRSJRlALO3fmSh23ts=;
	b=blySBfimnS6cGMfPbB8aWUwBJGn8q99uLZDPTsFhvgyPSdO8oqIDlERHN6FY7DP7t9cfAy
	asKFP5ROjHZxfF3Bc1LbQXPh+Z4KJ+KpzAc87hF0/EvLKNUR1FomUJTIxM8XQ0psxtZMIY
	8vw/aTHSqRltclwAycIH0PR9kRUMe5M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-oFg0MO4ZMoOLqc6Lu5bIrQ-1; Wed,
 23 Sep 2026 09:37:35 -0400
X-MC-Unique: oFg0MO4ZMoOLqc6Lu5bIrQ-1
X-Mimecast-MFC-AGG-ID: oFg0MO4ZMoOLqc6Lu5bIrQ_1790170654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FD781944EB3;
	Wed, 23 Sep 2026 13:37:34 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73DD8180034C;
	Wed, 23 Sep 2026 13:37:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v11 03/17] rxrpc: Fix update of call->tx_pending without holding lock
Date: Wed, 23 Sep 2026 14:36:50 +0100
Message-ID: <20260923133706.1496540-4-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
---
 net/rxrpc/sendmsg.c | 63 +++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005a..fb8d48418882 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -320,10 +320,9 @@ static int rxrpc_alloc_txqueue(struct sock *sk, struct rxrpc_call *call)
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
@@ -334,30 +333,26 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EPROTO);
-		return -EPROTO;
+		ret = -EPROTO;
+		goto out_unlock;
 	}
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
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
@@ -386,6 +381,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	}
 
 	do {
+		struct rxrpc_txbuf *txb = call->tx_pending;
+
 		if (!txb) {
 			size_t remain;
 
@@ -411,6 +408,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 				ret = -ENOMEM;
 				goto maybe_error;
 			}
+			call->tx_pending = txb;
+		} else {
+			rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
 		}
 
 		_debug("append");
@@ -445,9 +445,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 			ret = call->security->secure_packet(call, txb);
 			if (ret < 0)
-				goto out;
+				goto out_unlock;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
-			txb = NULL;
+			call->tx_pending = NULL;
 		}
 	} while (msg_data_left(msg) > 0);
 
@@ -456,45 +456,46 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
@@ -660,7 +661,6 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 {
 	struct rxrpc_call *call;
-	bool dropped_lock = false;
 	int ret;
 
 	struct rxrpc_send_params p = {
@@ -769,16 +769,15 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		ret = 0;
 		break;
 	case RXRPC_CMD_SEND_DATA:
-		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
-		break;
+		ret = rxrpc_send_data(rx, call, msg, len, NULL);
+		goto error_put;
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
 out_put_unlock:
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
+	mutex_unlock(&call->user_mutex);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
 	_leave(" = %d", ret);
@@ -808,7 +807,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
 			   rxrpc_notify_end_tx_t notify_end_tx)
 {
-	bool dropped_lock = false;
 	int ret;
 
 	_enter("{%d},", call->debug_id);
@@ -819,12 +817,9 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
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

