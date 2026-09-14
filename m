Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6394A262E
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398868; cv=none; b=dlmQDlhTjIfbcF3sCML3ESJrtGZc05XH6W+sXfYfVUeTgMK+gdM5pxN1K8OYjTy2QLY1ak/LpTFgBx08UJaLTvhKC1nYQFup16Y4EDvqln2kAMue+1SweLXPIGVXYP549XvxptHRGR4Oe0lHP396Z1dxqjvcfZj79HgA/XHNtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398868; c=relaxed/simple;
	bh=ah6DVqgjWSsjAl7nGPEMc1dYlpPs9nu3vx5QsgwP/1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6lbM9CRIgf1q2pQRnohdx+b4P/E/EeCipUljknufaTDd5oyW6URQrmCib09xx3bjAGFBu6f3Stu68cb5V9ZZ0weZwqhx2gHiZYLZEwNJnhmHaLqsOJXEI5SYxoslJqCO2L9532A+Jy3JBnkrLNj/VBZqmQK0KtPJkPULqcb2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/jqJkwu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/jqJkwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/Au7LwzqNLdJcIcoE6j8/auqWHac1zYcU/BxTnTJZ8=;
	b=L/jqJkwu7WstRrflRAVXEUv/yx5o2omlY84EHstHWpn8zvAUUMmOiE12nakNPuTwx7t1eB
	e3bOTkEpb6qEBoRL+P3JasZY7FTeYCTXwkbdZxM8Zf2gtvgQZ4ZWIeDWrf+UW7jnC7vPgY
	R7GmJSH7MGnwT4Vdra/7mKlxxlzVFh0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-OvpZnCxmOvKMrxne6JtqZA-1; Mon,
 14 Sep 2026 11:14:22 -0400
X-MC-Unique: OvpZnCxmOvKMrxne6JtqZA-1
X-Mimecast-MFC-AGG-ID: OvpZnCxmOvKMrxne6JtqZA_1789398860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 157DC18333E3;
	Mon, 14 Sep 2026 15:14:20 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A64841956086;
	Mon, 14 Sep 2026 15:14:16 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	stable@vger.kernel.org
Subject: [PATCH net v10 06/14] rxrpc: Fix error handling in rxrpc_send_data()
Date: Mon, 14 Sep 2026 16:13:30 +0100
Message-ID: <20260914151340.3227501-7-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix the error handling in rxrpc_send_data() so that it doesn't return an
error if it has successfully queued the last packet of a call, but the call
has seen to have completed after it did that.  Rather, leave it to
recvmsg() to report the completion (which it will do anyway).

The problem with trying to report the error twice is that the caller may
try to clean up the dead call twice.

Further, if we haven't queued the final packet yet, return -ESHUTDOWN if
the call is now marked complete (e.g. it got aborted by the peer) as
there's no point sendmsg() continuing to try to add data to a call if it is
defunct.  The application should abort the call and then call recvmsg() to
pick up the reason.

Fixes: 4ba68c519255 ("rxrpc: Return an error to sendmsg if call failed")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 fs/afs/rxrpc.c      | 11 +++---
 net/rxrpc/rxperf.c  | 38 +++++++++++++-------
 net/rxrpc/sendmsg.c | 86 +++++++++++++++++++++++++++++++++------------
 3 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 2b241716dae7..4694a6fca9b4 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -448,13 +448,14 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 		return;
 	}
 
-	if (ret == -ECONNABORTED) {
+	if (ret == -ESHUTDOWN) {
 		len = 0;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
-		rxrpc_kernel_recv_data(call->net->socket, rxcall,
-				       &msg.msg_iter, &len, false,
-				       &call->abort_code, &call->service_id);
-		call->responded = true;
+		ret = rxrpc_kernel_recv_data(call->net->socket, rxcall,
+					     &msg.msg_iter, &len, false,
+					     &call->abort_code, &call->service_id);
+		if (ret == -ECONNABORTED)
+			call->responded = true;
 	}
 	call->error = ret;
 	trace_afs_call_done(call);
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 7e9a53615309..83016830e696 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -74,7 +74,7 @@ static struct workqueue_struct *rxperf_workqueue;
 static void rxperf_deliver_to_call(struct work_struct *work);
 static int rxperf_deliver_param_block(struct rxperf_call *call);
 static int rxperf_deliver_request(struct rxperf_call *call);
-static int rxperf_process_call(struct rxperf_call *call);
+static void rxperf_process_call(struct rxperf_call *call);
 static void rxperf_charge_preallocation(struct work_struct *work);
 
 static DECLARE_WORK(rxperf_charge_preallocation_work,
@@ -293,18 +293,28 @@ static void rxperf_deliver_to_call(struct work_struct *work)
 	       state == RXPERF_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == RXPERF_CALL_SV_AWAIT_ACK) {
-			if (!rxrpc_kernel_check_life(rxperf_socket, call->rxcall))
+			size_t len = 0;
+			iov_iter_kvec(&call->iter, ITER_DEST, NULL, 0, 0);
+			ret = rxrpc_kernel_recv_data(rxperf_socket,
+						     call->rxcall, &call->iter,
+						     &len, false, &remote_abort,
+						     &call->service_id);
+
+			if (ret == -EINPROGRESS || ret == -EAGAIN)
+				return;
+			if (ret < 0 || ret == 1) {
+				if (ret == 1)
+					ret = 0;
 				goto call_complete;
+			}
 			return;
 		}
 
 		ret = call->deliver(call);
-		if (ret == 0)
-			ret = rxperf_process_call(call);
-
 		switch (ret) {
 		case 0:
-			continue;
+			rxperf_process_call(call);
+			return;
 		case -EINPROGRESS:
 		case -EAGAIN:
 			return;
@@ -508,7 +518,7 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 /*
  * Process a call for which we've received the request.
  */
-static int rxperf_process_call(struct rxperf_call *call)
+static void rxperf_process_call(struct rxperf_call *call)
 {
 	struct msghdr msg = {};
 	struct bio_vec bv;
@@ -527,7 +537,7 @@ static int rxperf_process_call(struct rxperf_call *call)
 		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 					   rxperf_notify_end_reply_tx);
 		if (n < 0)
-			return n;
+			goto send_error;
 		reply_len -= len;
 	}
 
@@ -539,10 +549,13 @@ static int rxperf_process_call(struct rxperf_call *call)
 	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 				   rxperf_notify_end_reply_tx);
 	if (n < 0)
-		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
-					RXGEN_SS_MARSHAL, n,
-					rxperf_abort_send_error);
-	return n;
+		goto send_error;
+	return;
+
+send_error:
+	rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
+				RXGEN_SS_MARSHAL, n,
+				rxperf_abort_send_error);
 }
 
 /*
@@ -695,4 +708,3 @@ static void __exit rxperf_exit(void)
 	rcu_barrier();
 }
 module_exit(rxperf_exit);
-
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index b370e440e2fd..1012d2d337a5 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -329,13 +329,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	bool more = msg->msg_flags & MSG_MORE;
 	int ret, copied = 0;
 
-	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
-		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
-				  call->cid, call->call_id, call->rx_consumed,
-				  0, -EPROTO);
-		return -EPROTO;
-	}
-
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	ret = rxrpc_wait_to_be_connected(call, &timeo);
@@ -352,13 +345,20 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 reload:
+	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EPROTO);
+		ret = -EPROTO;
+		goto out_unlock;
+	}
+
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
-		goto maybe_error;
+		goto out_unlock;
 	state = rxrpc_call_state(call);
-	ret = -ESHUTDOWN;
 	if (state >= RXRPC_CALL_COMPLETE)
-		goto maybe_error;
+		goto call_terminated;
 	ret = -EPROTO;
 	if (state != RXRPC_CALL_CLIENT_PRE_SEND &&
 	    state != RXRPC_CALL_CLIENT_SEND_REQUEST &&
@@ -368,7 +368,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EPROTO);
-		goto maybe_error;
+		goto out_unlock;
 	}
 
 	ret = -EMSGSIZE;
@@ -448,31 +448,73 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 				goto out_unlock;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			call->tx_pending = NULL;
+
+			/* At this point, if that was the last packet, it may
+			 * have been transmitted and the reply (client call) or
+			 * final ACK (service call) may have been received,
+			 * completing the call.
+			 */
 		}
 	} while (len > 0 && msg_data_left(msg) > 0);
 
-success:
+	/* Don't check for call completeness here, but leave that to recvmsg or
+	 * a further call to sendmsg().
+	 */
 	ret = copied;
-	if (rxrpc_call_is_complete(call) &&
-	    call->error < 0)
-		ret = call->error;
 out_unlock:
 	mutex_unlock(&call->user_mutex);
+out:
+
+	/* The return value is a bit complicated as we want to avoid returning
+	 * an error if we have queued the final packet.  In descending order of
+	 * preference:
+	 *
+	 * (1) If we queue the last packet: the amount copied (which may be
+	 *     zero).  recvmsg() should be used to collect the result.
+	 *
+	 * (2) If another sendmsg() has already queued the last packet: -EPROTO.
+	 *
+	 * (3) If the send side of the socket is shut down, -EPIPE.
+	 *
+	 * (4) If the call is in the wrong state to transmit: -EPROTO.
+	 *
+	 * (5) If the call has terminated early, likely due to an external
+	 *     event such as being remotely aborted: -ESHUTDOWN.
+	 *
+	 * (6) If some data has been copied by this call: the amount copied
+	 *     (which will be greater than zero).
+	 *
+	 * (7) Any other error.
+	 *
+	 * For (2)-(5), there's no point in continuing with the sendmsg().  The
+	 * app should abort the call (just in case the error came from
+	 * somewhere else) and then use recvmsg() to collect the final result
+	 * of the call.
+	 */
 	_leave(" = %d", ret);
 	return ret;
 
 call_terminated:
-	ret = call->error;
+	ret = -ESHUTDOWN;
 	goto out_unlock;
 
 maybe_error:
-	if (copied)
-		goto success;
+	if (copied) {
+		if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
+			/* If we've get here, we must have slept waiting for space and .
+			 */
+			ret = copied;
+			goto out_unlock;
+		}
+		if (rxrpc_call_is_complete(call))
+			goto call_terminated;
+		ret = copied;
+	}
 	goto out_unlock;
 
 efault:
 	ret = -EFAULT;
-	goto out_unlock;
+	goto maybe_error;
 
 wait_for_space:
 	ret = -EAGAIN;
@@ -495,7 +537,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	goto reload;
 out_nolock:
 	_leave(" = %d [intr]", ret);
-	return copied ?: ret;
+	if (copied)
+		ret = copied;
+	goto out;
 }
 
 /*
@@ -817,8 +861,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 
 		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
 				      msg_data_left(msg), notify_end_tx);
-		if (ret == -ESHUTDOWN)
-			ret = call->error;
 		if (ret < 0)
 			break;
 		if (msg_data_left(msg) == 0) {

