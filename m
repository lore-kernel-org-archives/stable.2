Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571049502E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781110; cv=none; b=goZ543X0Lh9XkBGhhkyLo0t2+dIRbCEs8o4dVMC4EsEVZl4mA50BiJfzs+QrhDYTbaVwNnj4ebA0w81OuB9Tc/sidh4ppSJS+tDqNdIsHAjoac1gSy7L+eaL+oH10O3qkmaUGZbXIPsvjc68xvvkpl/SaUJyFqTtSpR+1fXYVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781110; c=relaxed/simple;
	bh=n1YdNQJiXH8fGwbWfaPUQZefpOVpAig+D9U4az+hWiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnaHRgXoWreGgMuz57C+q3dRwjDwHlulymoB0eU/2rTU8cGfLb3ksjbqr+k5vumWChDr5ouDw7CRenYnAnCFhLf7LbEPkEOUx3zZ1tB0hO3YPX4UtjsTwYuFJP0P15G+goaaEm+FB9fnM4p7TEfYf3ALUovu6cFSwIhChL4WdOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjnlIx46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjnlIx46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfJ0b7lLuaZlI6ivE4yeY/awkgQjqwJ0GGi2sVpj0wY=;
	b=AjnlIx46K5QsJj0M7z/+s0JA76oU+xj4L86k8Vzwf2Q6g4ZgwqKpu/TjLPJWSzxL06+0bs
	KmzN1vEqvrv1i2qixlVGVmZAyQXralxuFF2YraaOqj7i7GpNIiBU6WWaeNR5ia1xCM1Z2i
	ekznD8qH1pSqO+WzMALgD2eLOM58iKs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-Qb0MNS3EO_qiXBIfw6EK0A-1; Mon,
 07 Sep 2026 07:38:24 -0400
X-MC-Unique: Qb0MNS3EO_qiXBIfw6EK0A-1
X-Mimecast-MFC-AGG-ID: Qb0MNS3EO_qiXBIfw6EK0A_1788781103
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F4B51955DE1;
	Mon,  7 Sep 2026 11:38:23 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF61730001A2;
	Mon,  7 Sep 2026 11:38:19 +0000 (UTC)
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
Subject: [PATCH net v9 06/14] rxrpc: Fix packet encryption error handling
Date: Mon,  7 Sep 2026 12:37:33 +0100
Message-ID: <20260907113743.1453210-7-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
     maybe_error_rewind and, if we've copied data into the last packet,
     remove some of the bytes from it that we just added so that we don't
     tell the caller that we've completed the transmission phase.  The
     iterator is also correspondingly rewound.

 (2) If any other error occurs, set the TX_ERROR flag on the call and
     return that error directly; on all subsequent attempts to add data to
     the call, return -EIO.  The app must then abort the call to get rid of
     it (this allows the app to choose the abort code to use).

 (3) The TX_NO_MORE test is moved so that both it and the TX_ERROR test are
     repeated after a wait-for-space is performed.

afs_make_call() and afs_send_simple_reply() are also modified to repeat
calls to rxrpc_kernel_send_data() if less than a full transfer was made.

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
 Documentation/networking/rxrpc.rst | 11 +++++-
 include/trace/events/rxrpc.h       |  1 +
 net/rxrpc/ar-internal.h            |  1 +
 net/rxrpc/sendmsg.c                | 60 ++++++++++++++++++++++++------
 4 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 8926dab8e2e6..7df6aff7644c 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -879,14 +879,21 @@ The kernel interface functions are as follows:
      exclusively to in-kernel virtual addresses.  msg.msg_flags may be given
      MSG_MORE if there will be subsequent data sends for this call.
 
-     The msg must not specify a destination address, control data or any flags
-     other than MSG_MORE.  len is the total amount of data to transmit.
+     msg must not specify a destination address, control data or any flags
+     other than MSG_MORE.  len is the amount of data to add to the
+     transmission.  The last-packet flag will only be set on the outgoing
+     packet if MSG_MORE is not set and len amount of bytes are buffered.
 
      notify_end_rx can be NULL or it can be used to specify a function to be
      called when the call changes state to end the Tx phase.  This function is
      called with a spinlock held to prevent the last DATA packet from being
      transmitted until the function returns.
 
+     The function returns the amount of data buffered or an error.  It will
+     return zero only if len is 0 or if msg->msg_iter is empty.  It may also
+     make a short write, buffering less than the amount of data provided or the
+     len specified, in which case it should be called again.
+
  (#) Receive data from a call::
 
 	int rxrpc_kernel_recv_data(struct socket *sock,
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
index 565799548102..4ce3ae0ba2e8 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -330,13 +330,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
@@ -353,6 +346,21 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 reload:
+	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EPROTO);
+		ret = -EPROTO;
+		goto maybe_error;
+	}
+	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EIO);
+		ret = -EIO;
+		goto maybe_error;
+	}
+
 	txb = call->tx_pending;
 	call->tx_pending = NULL;
 	if (txb)
@@ -441,12 +449,26 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		/* add the packet to the send queue if it's now full */
 		if (!txb->space ||
 		    (len == 0 && !more)) {
-			if (len == 0 && !more)
-				txb->flags |= RXRPC_LAST_PACKET;
-
+			/* Do any required crypto.  If this fails, it could
+			 * have corrupted the txbuf content with a partial
+			 * encrypt.  Assume that ENOMEM is retryable, but
+			 * everything else is terminal.
+			 */
 			ret = call->security->secure_packet(call, txb);
-			if (ret < 0)
+			if (ret < 0) {
+				/* Assume that ENOMEM here means that the
+				 * encryption hasn't happened yet.  The data is
+				 * aligned to avoid the need for slow buffering
+				 * in the crypto walk.
+				 */
+				if (ret == -ENOMEM)
+					goto maybe_error_rewind;
+				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
 				goto out;
+			}
+
+			if (len == 0 && !more)
+				txb->flags |= RXRPC_LAST_PACKET;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			txb = NULL;
 		}
@@ -464,6 +486,22 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	_leave(" = %d", call->error);
 	return call->error;
 
+maybe_error_rewind:
+	/* If we got a retryable error after copying all the supplied data into
+	 * the last packet, we need to rewind as much as we can so the caller
+	 * knows they need to retry the sendmsg.
+	 */
+	if (copied && !more && !len) {
+		unsigned int rewind_by = umin(copied, txb->len);
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
 		if (rxrpc_call_is_complete(call) &&

