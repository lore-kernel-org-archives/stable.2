Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3734A92DF
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398873; cv=none; b=G9B8MjkR3nOhQsWSGN99EDMhqisPYb/C3GVqQQ6aVCF0SrdxQ2DBdbnIdS79cYRh+6bHX6msfa3pwmbG8NFNKNgjb9XfwABVcmdwoTNB5yYM/SNUhyCbIbqg1406XEhFz1DpFw691ZRts1iNzIOk03xdOMO3zTEljfKRm8QFOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398873; c=relaxed/simple;
	bh=n+++pehzSMdqbL5BtCndPHmia10d0QX7iMtIrAmvWjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itjkayHWX8C7Nib0ZM/ysVrbekDrKn5+sIsntjv4+0STSNDuNV6em9SgsZYiszj0ZuVxD72aOaxZMQb8gOG6f6J+8UogkZ7RerM5JJDvQ8W5UEc9v4cuGPm8wrwZ5eZpNVh6xn2gMU3+ogTzi9+M8SaU3a6rWX2/nz8oRK+6m+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3b/87eU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3b/87eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giDxXwL1o+CMg1THzWf5zoSR2NVsWyaJX7jNumHMRio=;
	b=B3b/87eUQYHVxesmZg/HyWMfL37EGsDavK3fg3plpVRHfwxFd5m0NjCWOqY7JLWkswTuAV
	7uV38oFHP0l4OK0TdP5FPql647/XT3TQ3pYpEIqJyh5ZArC0iCwq9rw2COwQ8+6XA65GcO
	NLCI1OfqqXPqOF7ViYZG6uLq4z2ygZk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-aCqHsJ7nP-CHMM1mNlMo4w-1; Mon,
 14 Sep 2026 11:14:26 -0400
X-MC-Unique: aCqHsJ7nP-CHMM1mNlMo4w-1
X-Mimecast-MFC-AGG-ID: aCqHsJ7nP-CHMM1mNlMo4w_1789398865
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C820D182A102;
	Mon, 14 Sep 2026 15:14:24 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0DEE1956053;
	Mon, 14 Sep 2026 15:14:21 +0000 (UTC)
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
Subject: [PATCH net v10 07/14] rxrpc: Fix packet encryption error handling
Date: Mon, 14 Sep 2026 16:13:31 +0100
Message-ID: <20260914151340.3227501-8-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In rxrpc_send_data(), if ->secure_packet() returns an error, the code
currently just jumps to out: and returns the error to the app on the
assumption that any error returned by this is automatically fatal for the
call, and may even have corrupted the transmission queue - but leaving it
to userspace to deal with.  Nothing stops the application from retrying the
sendmsg(), which will try to encrypt the buffer again, and might succeed
with a corrupt buffer.

Fix rxrpc_send_data() in the following ways:

 (1) If -ENOMEM is returned, assume we never got as far as the encryption
     and that the operation is retryable.  In which case, jump to
     maybe_error_rewind and, if we've copied all remaining data into the
     last packet, remove some of the bytes from it that we just added so
     that we don't tell the caller that we've completed the transmission
     phase.  The iterator is also correspondingly rewound.

 (2) If any other error occurs, set the TX_ERROR flag on the call and
     return that error directly; on all subsequent attempts to add data to
     the call, return -EIO.  The app must then abort the call to get rid of
     it (this allows the app to choose the abort code to use).

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
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
 Documentation/networking/rxrpc.rst |  6 ++-
 include/trace/events/rxrpc.h       |  1 +
 net/rxrpc/ar-internal.h            |  1 +
 net/rxrpc/sendmsg.c                | 63 +++++++++++++++++++++++++-----
 4 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 01ad12fdf305..9b7eeae84148 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -878,8 +878,10 @@ The kernel interface functions are as follows:
      exclusively to in-kernel virtual addresses.  msg.msg_flags may be given
      MSG_MORE if there will be subsequent data sends for this call.
 
-     The msg must not specify a destination address, control data or any flags
-     other than MSG_MORE.
+     msg must not specify a destination address, control data or any flags
+     other than MSG_MORE.  The last-packet flag will only be set on the
+     outgoing packet if MSG_MORE is not set and all the data in the iterator is
+     buffered.
 
      notify_end_rx can be NULL or it can be used to specify a function to be
      called when the call changes state to end the Tx phase.  This function is
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 56dc9b614071..a5c92592d8f9 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -148,6 +148,7 @@
 	EM(rxrpc_eproto_wrong_security,		"wrong-sec")		\
 	EM(rxrpc_recvmsg_excess_data,		"recvmsg-excess")	\
 	EM(rxrpc_recvmsg_short_data,		"recvmsg-short")	\
+	EM(rxrpc_sendmsg_tx_error,		"tx-error")		\
 	E_(rxrpc_sendmsg_late_send,		"sendmsg-late")
 
 #define rxrpc_call_poke_traces \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..a6f830c1621f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -642,6 +642,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_TX_LAST,		/* Last packet in Tx buffer (at rxtx_top) */
 	RXRPC_CALL_TX_ALL_ACKED,	/* Last packet has been hard-acked */
 	RXRPC_CALL_TX_NO_MORE,		/* No more data to transmit (MSG_MORE deasserted) */
+	RXRPC_CALL_TX_ERROR,		/* Terminal error; call needs abort */
 	RXRPC_CALL_SEND_PING,		/* A ping will need to be sent */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
 	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 1012d2d337a5..ed7ff32da184 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -325,6 +325,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 {
 	struct sock *sk = &rx->sk;
 	enum rxrpc_call_state state;
+	unsigned int rewind_by = 0;
 	long timeo;
 	bool more = msg->msg_flags & MSG_MORE;
 	int ret, copied = 0;
@@ -352,6 +353,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		ret = -EPROTO;
 		goto out_unlock;
 	}
+	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EIO);
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
@@ -423,6 +431,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 						 copy, &msg->msg_iter))
 				goto efault;
 			_debug("added");
+			rewind_by = copy;
 			txb->space -= copy;
 			txb->len += copy;
 			txb->offset += copy;
@@ -440,14 +449,29 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		/* add the packet to the send queue if it's now full */
 		if (!txb->space ||
 		    (len == 0 && !more)) {
+			/* Do any required crypto.  If this fails, it could
+			 * have corrupted the txbuf content with a partial
+			 * encrypt.  Assume that ENOMEM is retryable, but
+			 * everything else is terminal.
+			 */
+			ret = call->security->secure_packet(call, txb);
+			if (ret < 0) {
+				/* Assume that ENOMEM here means that the
+				 * encryption hasn't happened yet.  The data is
+				 * aligned to avoid the need for slow buffering
+				 * in the crypto walk.
+				 */
+				if (ret == -ENOMEM)
+					goto maybe_error_rewind;
+				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
+				goto out;
+			}
+
 			if (len == 0 && !more)
 				txb->flags |= RXRPC_LAST_PACKET;
-
-			ret = call->security->secure_packet(call, txb);
-			if (ret < 0)
-				goto out_unlock;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			call->tx_pending = NULL;
+			rewind_by = 0;
 
 			/* At this point, if that was the last packet, it may
 			 * have been transmitted and the reply (client call) or
@@ -474,19 +498,22 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	 *
 	 * (2) If another sendmsg() has already queued the last packet: -EPROTO.
 	 *
-	 * (3) If the send side of the socket is shut down, -EPIPE.
+	 * (3) If an error caused it to be impossible to continue with the
+	 *     call: -EIO.
 	 *
-	 * (4) If the call is in the wrong state to transmit: -EPROTO.
+	 * (4) If the send side of the socket is shut down, -EPIPE.
 	 *
-	 * (5) If the call has terminated early, likely due to an external
+	 * (5) If the call is in the wrong state to transmit: -EPROTO.
+	 *
+	 * (6) If the call has terminated early, likely due to an external
 	 *     event such as being remotely aborted: -ESHUTDOWN.
 	 *
-	 * (6) If some data has been copied by this call: the amount copied
+	 * (7) If some data has been copied by this call: the amount copied
 	 *     (which will be greater than zero).
 	 *
-	 * (7) Any other error.
+	 * (8) Any other error.
 	 *
-	 * For (2)-(5), there's no point in continuing with the sendmsg().  The
+	 * For (2)-(6), there's no point in continuing with the sendmsg().  The
 	 * app should abort the call (just in case the error came from
 	 * somewhere else) and then use recvmsg() to collect the final result
 	 * of the call.
@@ -498,6 +525,22 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	ret = -ESHUTDOWN;
 	goto out_unlock;
 
+maybe_error_rewind:
+	/* If we got a retryable error after copying all the supplied data into
+	 * the last packet, we need to rewind as much as we can so the caller
+	 * knows they need to retry the sendmsg.
+	 */
+	if (rewind_by && !more && !len) {
+		struct rxrpc_txbuf *txb = call->tx_pending;
+
+		txb->space  += rewind_by;
+		txb->len    -= rewind_by;
+		txb->offset -= rewind_by;
+		copied      -= rewind_by;
+		if (call->tx_total_len != -1)
+			call->tx_total_len += rewind_by;
+		iov_iter_revert(&msg->msg_iter, rewind_by);
+	}
 maybe_error:
 	if (copied) {
 		if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {

