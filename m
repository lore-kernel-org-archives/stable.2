Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02846A5E8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293460; cv=none; b=tfbVlvS8qCMSz0hnrzESRQbUm5IML7TxhGm8cVHUd9+EpEFpwecW5PglLVHjvkqWYnS76stV1eOZxzQ6OrGp/rUjzAoFDQ8vIXHixOQDHKxPUyIbkNWgjkQZ4KOXYciRIFPbuoL6FjYGr7adzb+MOzjHpZ9r9QisMDnECvoyxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293460; c=relaxed/simple;
	bh=GBPPEVwuWwcCiXHsYTZXIpFvZjXamQICSTK0puDVf40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSyhrfvTTDxYbJKfb0SUYMj9iBM+42jaJdgSI8Ux2EJJf/PG0ybZsIP8jF6azX0yCHRw4wxTchNLlH+FFNDSzTSui6uY1LO3j/dPGyKlOAN/VMrBnK0ujYAAxaWE/MbpJwVhhUKmU5pFoIvf657IcyeX9s/TOX653zM9Y6FgYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNer/Fm6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNer/Fm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791293449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9UWCJMEzr10UoAN8TaqL/fHiSJW5wGgOyryi30x7a8=;
	b=fNer/Fm61lj5Nu1mLNwxCuFBEV11mf+ngysPnTEMeaVhfIssl0Ev/wpktc9SJlYFxs3dTV
	/NwYd8T+NOYitEMIMjYap4gZ3F1FcfiuXk7Ad1fzszUtfdGy1W0eBux3yVJeSEI5EO41vM
	xHH2Pu5on5VVZQq93bv4JXYtWhZ8l2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-w6-H5fJRMTmFsGu67p4TBQ-1; Tue,
 06 Oct 2026 09:30:45 -0400
X-MC-Unique: w6-H5fJRMTmFsGu67p4TBQ-1
X-Mimecast-MFC-AGG-ID: w6-H5fJRMTmFsGu67p4TBQ_1791293441
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D0F5180ACC5;
	Tue,  6 Oct 2026 13:30:41 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93E021956047;
	Tue,  6 Oct 2026 13:30:37 +0000 (UTC)
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
	David Laight <david.laight.linux@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v12 04/15] rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
Date: Tue,  6 Oct 2026 14:29:56 +0100
Message-ID: <20261006133011.531806-5-dhowells@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
References: <20261006133011.531806-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix rxrpc_kernel_send_data() to loop around if it detects a short send.
David Laight suggested doing it here rather than wrapping all the calls in
loops.  Further, remove the len argument and use the iterator count instead
and return 0 on success, not the amount copied.

Note this is also a prerequisite for changing the way rxrpc_send_data()
works to return a short send rather than an error if some data was
buffered.

Fixes: 651350d10f93 ("[AF_RXRPC]: Add an interface to the AF_RXRPC module for the AFS filesystem to use")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
Suggested-by: David Laight <david.laight.linux@gmail.com>
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
 Documentation/networking/rxrpc.rst |  8 +++++---
 fs/afs/rxrpc.c                     | 32 ++++++++++++------------------
 include/net/af_rxrpc.h             |  5 ++---
 net/rxrpc/rxperf.c                 | 25 ++++++++++-------------
 net/rxrpc/sendmsg.c                | 27 +++++++++++++++++--------
 5 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 8926dab8e2e6..9239f7bd8885 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -870,7 +870,6 @@ The kernel interface functions are as follows:
 	int rxrpc_kernel_send_data(struct socket *sock,
 				   struct rxrpc_call *call,
 				   struct msghdr *msg,
-				   size_t len,
 				   rxrpc_notify_end_tx_t notify_end_rx);
 
      This is used to supply either the request part of a client call or the
@@ -879,14 +878,17 @@ The kernel interface functions are as follows:
      exclusively to in-kernel virtual addresses.  msg.msg_flags may be given
      MSG_MORE if there will be subsequent data sends for this call.
 
-     The msg must not specify a destination address, control data or any flags
-     other than MSG_MORE.  len is the total amount of data to transmit.
+     msg must not specify a destination address, control data or any flags
+     other than MSG_MORE or MSG_WAITALL.
 
      notify_end_rx can be NULL or it can be used to specify a function to be
      called when the call changes state to end the Tx phase.  This function is
      called with a spinlock held to prevent the last DATA packet from being
      transmitted until the function returns.
 
+     It returns 0 if all the provided data has been buffered and a negative
+     error code on failure.
+
  (#) Receive data from a call::
 
 	int rxrpc_kernel_recv_data(struct socket *sock,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..bcb8bb15d471 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -412,8 +412,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
 
-	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
-				     &msg, call->request_size,
+	ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
 				     afs_notify_end_request_tx);
 	if (ret < 0)
 		goto error_do_abort;
@@ -425,7 +424,6 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 
 		ret = rxrpc_kernel_send_data(call->net->socket,
 					     call->rxcall, &msg,
-					     iov_iter_count(&msg.msg_iter),
 					     afs_notify_end_request_tx);
 		*call->write_iter = msg.msg_iter;
 
@@ -871,7 +869,7 @@ void afs_send_empty_reply(struct afs_call *call)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, 0,
+	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
 				       afs_notify_end_reply_tx)) {
 	case 0:
 		_leave(" [replied]");
@@ -897,7 +895,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	struct afs_net *net = call->net;
 	struct msghdr msg;
 	struct kvec iov[1];
-	int n;
+	int ret;
 
 	_enter("");
 
@@ -912,21 +910,17 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
-				   afs_notify_end_reply_tx);
-	if (n >= 0) {
-		/* Success */
-		_leave(" [replied]");
-		return;
-	}
-
-	if (n == -ENOMEM) {
-		_debug("oom");
-		rxrpc_kernel_abort_call(net->socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					afs_abort_oom);
+	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
+				     afs_notify_end_reply_tx);
+	if (ret < 0) {
+		if (ret == -ENOMEM) {
+			_debug("oom");
+			rxrpc_kernel_abort_call(net->socket, call->rxcall,
+						RXGEN_SS_MARSHAL, -ENOMEM,
+						afs_abort_oom);
+		}
+		_leave(" [error]");
 	}
-	_leave(" [error]");
 }
 
 /*
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0fb4c41c9bbf..f3980348ed34 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -64,9 +64,8 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   bool upgrade,
 					   enum rxrpc_interruptibility interruptibility,
 					   unsigned int debug_id);
-int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
-			   struct msghdr *, size_t,
-			   rxrpc_notify_end_tx_t);
+int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
+			   struct msghdr *msg, rxrpc_notify_end_tx_t notify_end_tx);
 int rxrpc_kernel_recv_data(struct socket *, struct rxrpc_call *,
 			   struct iov_iter *, size_t *, bool, u32 *, u16 *);
 bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 26f97e1dd388..981c0596c774 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -501,8 +501,8 @@ static int rxperf_process_call(struct rxperf_call *call)
 	struct msghdr msg = {};
 	struct bio_vec bv;
 	struct kvec iov[1];
-	ssize_t n;
 	size_t reply_len = call->reply_len, len;
+	int ret;
 
 	rxrpc_kernel_set_tx_length(rxperf_socket, call->rxcall,
 				   reply_len + sizeof(rxperf_magic_cookie));
@@ -512,13 +512,11 @@ static int rxperf_process_call(struct rxperf_call *call)
 		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
 		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
 		msg.msg_flags = MSG_MORE;
-		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
-					   len, rxperf_notify_end_reply_tx);
-		if (n < 0)
-			return n;
-		if (n == 0)
-			return -EIO;
-		reply_len -= n;
+		ret = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
+					     rxperf_notify_end_reply_tx);
+		if (ret < 0)
+			return ret;
+		reply_len -= len;
 	}
 
 	len = sizeof(rxperf_magic_cookie);
@@ -526,16 +524,13 @@ static int rxperf_process_call(struct rxperf_call *call)
 	iov[0].iov_len	= len;
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
 	msg.msg_flags = 0;
-	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg, len,
-				   rxperf_notify_end_reply_tx);
-	if (n >= 0)
-		return 0; /* Success */
-
-	if (n == -ENOMEM)
+	ret = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
+				     rxperf_notify_end_reply_tx);
+	if (ret == -ENOMEM)
 		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
 					RXGEN_SS_MARSHAL, -ENOMEM,
 					rxperf_abort_oom);
-	return n;
+	return ret;
 }
 
 /*
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index fb8d48418882..393a2dcfda07 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -793,7 +793,6 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * @sock: The socket the call is on
  * @call: The call to send data through
  * @msg: The data to send
- * @len: The amount of data to send
  * @notify_end_tx: Notification that the last packet is queued.
  *
  * Allow a kernel service to send data on a call.  The call must be in an state
@@ -804,8 +803,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * Return: %0 if successful and a negative error code otherwise.
  */
 int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
-			   struct msghdr *msg, size_t len,
-			   rxrpc_notify_end_tx_t notify_end_tx)
+			   struct msghdr *msg, rxrpc_notify_end_tx_t notify_end_tx)
 {
 	int ret;
 
@@ -814,12 +812,25 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	ASSERTCMP(msg->msg_name, ==, NULL);
 	ASSERTCMP(msg->msg_control, ==, NULL);
 
-	mutex_lock(&call->user_mutex);
+	for (;;) {
+		mutex_lock(&call->user_mutex);
+
+		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
+				      msg_data_left(msg), notify_end_tx);
+		if (ret == -ESHUTDOWN)
+			ret = call->error;
+		if (ret < 0)
+			break;
+		if (msg_data_left(msg) == 0) {
+			ret = 0;
+			break;
+		}
+		if (ret == 0) {
+			ret = -EIO;
+			break;
+		}
+	}
 
-	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
-			      notify_end_tx);
-	if (ret == -ESHUTDOWN)
-		ret = call->error;
 	_leave(" = %d", ret);
 	return ret;
 }

