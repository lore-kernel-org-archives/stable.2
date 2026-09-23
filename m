Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52595326CF
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170687; cv=none; b=DOdS626o8P5Q8lFiPBXOQo3/GKIe6khm+CvhrWAcZVYhOKOIzL2rkM5C41peRJ9jMkOfpN4lYJu6R4syEOiBEG1pYgSp0tmB5SDWf/BWpcOsGm9M27q9NrTFCvw5GX+XD6wnsgYd0TtQYQUlKQyv7BBhTUpWhOwHj/Xsyp0VA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170687; c=relaxed/simple;
	bh=4vh8v8aKpOcLX8nHKdWwTVN9Zlgb6js+pBcueFGnnjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtFPCihEK79cUewBjBnMU4qhxhqcOnCPRUt/wY5Y1TScDkCr6BaN1FwvCG1r7FK5TrFqUzVfFjbePqc0Pjv30Ru38OgvFHdP2MKeth7xUoW75me2Fh+hHgGrhLcszGj+WvCiMDcq+x6ce0QeGA9dIC//75qqUGp/1e0N8IGTUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFc2qKyX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFc2qKyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQyQZHEzqKL3gR4bqmpMdwtxd6mLpJ+ODofdMwin1jc=;
	b=QFc2qKyXQ2KSgZTFpNbG/ZK8ozBADnCltDh4DeaShjrQCli/BAu69/ZkEAEYRXt0soNfsM
	e7Ynqm2gOQbgqUov6rrEUIQu3pmOQS6lOuZqqe0QMZKPRavEh9EG13YSoKi0GEyzUotLmC
	xZQr1wGpn2QsmvKhtj7CL3E5DeVxUSU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-eeh9a8ixP8aQ6qossAtkmg-1; Wed,
 23 Sep 2026 09:38:01 -0400
X-MC-Unique: eeh9a8ixP8aQ6qossAtkmg-1
X-Mimecast-MFC-AGG-ID: eeh9a8ixP8aQ6qossAtkmg_1790170679
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D56EC180267A;
	Wed, 23 Sep 2026 13:37:58 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F063180057E;
	Wed, 23 Sep 2026 13:37:55 +0000 (UTC)
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
Subject: [PATCH net v11 08/17] rxrpc: Fix error handling in rxrpc_send_data()
Date: Wed, 23 Sep 2026 14:36:55 +0100
Message-ID: <20260923133706.1496540-9-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 fs/afs/rxrpc.c      |  11 +++--
 net/rxrpc/rxperf.c  |  29 +++++++----
 net/rxrpc/sendmsg.c | 114 ++++++++++++++++++++++++++++++--------------
 3 files changed, 103 insertions(+), 51 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c38458157ecc..0b9027549580 100644
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
index 823eedc5d16f..5042e8bfca55 100644
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
@@ -496,7 +506,7 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 /*
  * Process a call for which we've received the request.
  */
-static int rxperf_process_call(struct rxperf_call *call)
+static void rxperf_process_call(struct rxperf_call *call)
 {
 	struct msghdr msg = {};
 	struct bio_vec bv;
@@ -527,11 +537,11 @@ static int rxperf_process_call(struct rxperf_call *call)
 	ret = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 				     rxperf_notify_end_reply_tx);
 	if (ret == 0)
-		return 0;
+		return;
+
 send_error:
 	rxrpc_kernel_abort_call(rxperf_socket, call->rxcall, RXGEN_SS_MARSHAL,
 				ret, rxperf_abort_send_error);
-	return ret;
 }
 
 /*
@@ -684,4 +694,3 @@ static void __exit rxperf_exit(void)
 	rcu_barrier();
 }
 module_exit(rxperf_exit);
-
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 312be27ca75b..80c6afc64787 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -324,19 +324,10 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	__releases(&call->user_mutex)
 {
 	struct sock *sk = &rx->sk;
-	enum rxrpc_call_state state;
 	long timeo;
 	bool more = msg->msg_flags & MSG_MORE;
 	int ret, copied = 0;
 
-	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
-		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
-				  call->cid, call->call_id, call->rx_consumed,
-				  0, -EPROTO);
-		ret = -EPROTO;
-		goto out_unlock;
-	}
-
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	ret = rxrpc_wait_to_be_connected(call, &timeo);
@@ -355,21 +346,31 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 reload:
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
-		goto maybe_error;
-	state = rxrpc_call_state(call);
-	ret = -ESHUTDOWN;
-	if (state >= RXRPC_CALL_COMPLETE)
-		goto maybe_error;
-	ret = -EPROTO;
-	if (state != RXRPC_CALL_CLIENT_PRE_SEND &&
-	    state != RXRPC_CALL_CLIENT_SEND_REQUEST &&
-	    state != RXRPC_CALL_SERVER_ACK_REQUEST &&
-	    state != RXRPC_CALL_SERVER_SEND_REPLY) {
-		/* Request phase complete for this client call */
+		goto out_unlock;
+
+	switch (rxrpc_call_state(call)) {
+	case RXRPC_CALL_CLIENT_PRE_SEND:
+	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_SERVER_ACK_REQUEST:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+		break;
+	case RXRPC_CALL_COMPLETE:
+		ret = -ESHUTDOWN;
+		goto out_unlock;
+	default:
+		ret = -EPROTO;
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EPROTO);
-		goto maybe_error;
+		goto out_unlock;
+	}
+
+	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EPROTO);
+		ret = -EPROTO;
+		goto out_unlock;
 	}
 
 	ret = -EMSGSIZE;
@@ -435,8 +436,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 		/* check for the far side aborting the call or a network error
 		 * occurring */
+		ret = -ESHUTDOWN;
 		if (rxrpc_call_is_complete(call))
-			goto call_terminated;
+			goto out_unlock;
 
 		/* add the packet to the send queue if it's now full */
 		if (!txb->space ||
@@ -449,31 +451,71 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
+	 * (1) If the send side of the socket is shut down, -EPIPE.
+	 *
+	 * (2) If the call has terminated early, likely due to an external
+	 *     event such as being remotely aborted: -ESHUTDOWN.
+	 *
+	 * (3) If the call is in the wrong state to transmit: -EPROTO.
+	 *
+	 * (4) If another sendmsg() has already queued the last packet: -EPROTO.
+	 *
+	 * (5) If we queue the last packet: the amount copied (which may be
+	 *     zero).  recvmsg() should be used to collect the result.
+	 *
+	 * (6) If some data has been copied by this call: the amount copied
+	 *     (which will be greater than zero).
+	 *
+	 * (7) Any other error.
+	 *
+	 * For (1)-(4), there's no point in continuing with the sendmsg().  The
+	 * app should abort the call (just in case the error came from
+	 * somewhere else) and then use recvmsg() to collect the final result
+	 * of the call.
+	 */
 	_leave(" = %d", ret);
 	return ret;
 
-call_terminated:
-	ret = call->error;
-	goto out_unlock;
-
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
+		if (rxrpc_call_is_complete(call)) {
+			ret = -ESHUTDOWN;
+			goto out_unlock;
+		}
+		ret = copied;
+	}
 	goto out_unlock;
 
 efault:
 	ret = -EFAULT;
-	goto out_unlock;
+	goto maybe_error;
 
 wait_for_space:
 	ret = -EAGAIN;
@@ -496,7 +538,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	goto reload;
 out_nolock:
 	_leave(" = %d [intr]", ret);
-	return copied ?: ret;
+	if (copied)
+		ret = copied;
+	goto out;
 }
 
 /*
@@ -818,8 +862,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 
 		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
 				      msg_data_left(msg), notify_end_tx);
-		if (ret == -ESHUTDOWN)
-			ret = call->error;
 		if (ret < 0)
 			break;
 		if (msg_data_left(msg) == 0) {

