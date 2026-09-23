Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A205335A1
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170692; cv=none; b=JFXrM6mkFjcq8rakJFHRbmtKl+wZ0ueiVFt9nCkExzbcuW007UHNLJne32aym0dY+BAu4BxbU1J+qqFWycA4Fxw9LYXAeADCZ7MBVvCDS1AdNQJmMwd6WiMxPqGWCD3+YtW0unnpBG40bu4SnuzbjgcBzEsBG2huC2PEepZk40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170692; c=relaxed/simple;
	bh=AgQkNK9DZVe4D2Wdj7XGYwOLrTkZNGJ59AtVCb/jgYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr4ZqK/3K2I7guYOWjFEz9oFMWkKeutPXKLKc7/wzbZ9DqeooMtPo68FNkKN0lFW2Di10ZaUMhmo8ZI4LkEhEZVmCVA3oxuwJJrok3rhHzF41s3VCoKhX9LLSUY+Vw84NzWGRjt+XcEjrq5YKWAUKRSsk/ZMQRUBXXj2uBOge34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDzXNnvH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDzXNnvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzCMAv3yRDg2M+JwGL3OWL9L58RzLWg2LBCgM9DMQCA=;
	b=dDzXNnvHPIKkUsUmDXqXMzv9ZVhYqfiCITW8/JTRrERejV5GTrDOvQ997LVjYi8FKfCs1F
	7SYQAko9i/9NO7LjruJQuxQMzAFsL47wSZ+vM9QaM4/+KXlcuOs6aaR8FStauQXYcVdVJi
	LF8K2nYjPnhUNlAqZVugQayo8mRoAkw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-lC4_OpOwNVu4YORBb0Qu8g-1; Wed,
 23 Sep 2026 09:38:05 -0400
X-MC-Unique: lC4_OpOwNVu4YORBb0Qu8g-1
X-Mimecast-MFC-AGG-ID: lC4_OpOwNVu4YORBb0Qu8g_1790170683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB29D182A114;
	Wed, 23 Sep 2026 13:38:03 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70626180025F;
	Wed, 23 Sep 2026 13:38:00 +0000 (UTC)
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
Subject: [PATCH net v11 09/17] rxrpc: Fix packet encryption error handling
Date: Wed, 23 Sep 2026 14:36:56 +0100
Message-ID: <20260923133706.1496540-10-dhowells@redhat.com>
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
 net/rxrpc/sendmsg.c                | 68 +++++++++++++++++++++++++-----
 4 files changed, 63 insertions(+), 13 deletions(-)

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
index 80c6afc64787..e3b6347888bf 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -324,6 +324,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	__releases(&call->user_mutex)
 {
 	struct sock *sk = &rx->sk;
+	unsigned int rewind_by = 0;
 	long timeo;
 	bool more = msg->msg_flags & MSG_MORE;
 	int ret, copied = 0;
@@ -372,6 +373,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
 
 	ret = -EMSGSIZE;
 	if (call->tx_total_len != -1) {
@@ -425,6 +433,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 						 copy, &msg->msg_iter))
 				goto efault;
 			_debug("added");
+			rewind_by = copy;
 			txb->space -= copy;
 			txb->len += copy;
 			txb->offset += copy;
@@ -443,14 +452,29 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
 				goto out_unlock;
+			}
+
+			if (len == 0 && !more)
+				txb->flags |= RXRPC_LAST_PACKET;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			call->tx_pending = NULL;
+			rewind_by = 0;
 
 			/* At this point, if that was the last packet, it may
 			 * have been transmitted and the reply (client call) or
@@ -481,22 +505,44 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	 *
 	 * (4) If another sendmsg() has already queued the last packet: -EPROTO.
 	 *
-	 * (5) If we queue the last packet: the amount copied (which may be
+	 * (5) If an error occurs that may have corrupted the transmission
+	 *     buffer (e.g. crypto failure) or unusable crypto was encountered:
+	 *     the error given (and RXRPC_CALL_TX_ERROR is set to cause -EIO to
+	 *     be returned from further calls).
+	 *
+	 * (6) If we queue the last packet: the amount copied (which may be
 	 *     zero).  recvmsg() should be used to collect the result.
 	 *
-	 * (6) If some data has been copied by this call: the amount copied
+	 * (7) If some data has been copied by this call: the amount copied
 	 *     (which will be greater than zero).
 	 *
-	 * (7) Any other error.
+	 * (8) Any other error.
 	 *
-	 * For (1)-(4), there's no point in continuing with the sendmsg().  The
-	 * app should abort the call (just in case the error came from
-	 * somewhere else) and then use recvmsg() to collect the final result
-	 * of the call.
+	 * For (1)-(6), there's no point in continuing with the sendmsg() and
+	 * we no longer care how much has been queued as the call is no longer
+	 * viable.  The app should abort the call (just in case the error came
+	 * from somewhere else) and then use recvmsg() to collect the final
+	 * result of the call.
 	 */
 	_leave(" = %d", ret);
 	return ret;
 
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

