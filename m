Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F94A5C47
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398845; cv=none; b=WxDQMyHHaJ0GeXnIXks0P4VlH/y/EMTYhO2JJImcOucozI3M1Ilx7w3UltuGISnHIl5cMulx+8wqoB2yM5kiMvbA4xUmdyxB4CuAOE/deFyDadBli9+k9JLHVmqjI8KC7E8K18OtGH6DBNGvRV5AfmLxOTVjlDH/YqBfQe+vvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398845; c=relaxed/simple;
	bh=dCLrLzGxwCqaGfZh56kYijfTb4kpt+8llNj1BU5gtig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhX0iFY6a0+OodxtszQc4fsPcl5lGwURxBaVpwk9KCQU+XkJCQN6NfjGTUOdBUdL7fhuY7SuP2SPnTXC+yP6okHoyJ2sTcgTA2eUXYj168+0ERKK8WJj3Zpn1ngvlwEET2uvIj+Q+hFnAP/vM9a5+RI5vOXFMCwxpwyg/iKs+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4gBDN9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4gBDN9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0rxafblLK8f4qTe6lPuie/QPs+2crTJHKrvKFcaEZA=;
	b=T4gBDN9n+ONrjiLOYMPATt8MIf+CeayAp8SNPSq0uq7uGSH66Q8frbORFBxl5qNczgsBEA
	wAHkodxYJbuB/3JnUjZkbvZiRogPxe9wRfIYsfY60KgLCvbrotEF8Jcj3r2ktWbsl7eVVg
	ALaiMwnK+lhbW5ldv0KHJIcOR+hxp8E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-HDhq3wvhMoKdcYoyBOD_VA-1; Mon,
 14 Sep 2026 11:13:56 -0400
X-MC-Unique: HDhq3wvhMoKdcYoyBOD_VA-1
X-Mimecast-MFC-AGG-ID: HDhq3wvhMoKdcYoyBOD_VA_1789398834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1D5E19540FE;
	Mon, 14 Sep 2026 15:13:54 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C2E5180057E;
	Mon, 14 Sep 2026 15:13:50 +0000 (UTC)
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
Subject: [PATCH net v10 01/14] rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
Date: Mon, 14 Sep 2026 16:13:25 +0100
Message-ID: <20260914151340.3227501-2-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 Documentation/networking/rxrpc.rst |  6 ++++--
 fs/afs/rxrpc.c                     | 28 ++++++++++----------------
 include/net/af_rxrpc.h             |  5 ++---
 net/rxrpc/rxperf.c                 | 11 +++-------
 net/rxrpc/sendmsg.c                | 32 ++++++++++++++++++++----------
 5 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 8926dab8e2e6..01ad12fdf305 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -870,7 +870,6 @@ The kernel interface functions are as follows:
 	int rxrpc_kernel_send_data(struct socket *sock,
 				   struct rxrpc_call *call,
 				   struct msghdr *msg,
-				   size_t len,
 				   rxrpc_notify_end_tx_t notify_end_rx);
 
      This is used to supply either the request part of a client call or the
@@ -880,13 +879,16 @@ The kernel interface functions are as follows:
      MSG_MORE if there will be subsequent data sends for this call.
 
      The msg must not specify a destination address, control data or any flags
-     other than MSG_MORE.  len is the total amount of data to transmit.
+     other than MSG_MORE.
 
      notify_end_rx can be NULL or it can be used to specify a function to be
      called when the call changes state to end the Tx phase.  This function is
      called with a spinlock held to prevent the last DATA packet from being
      transmitted until the function returns.
 
+     It returns 0 if all the data is queued and a negative error code on
+     failure.
+
  (#) Receive data from a call::
 
 	int rxrpc_kernel_recv_data(struct socket *sock,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..09d9da92a1be 100644
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
@@ -912,21 +910,17 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
+	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
 				   afs_notify_end_reply_tx);
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
+	if (n < 0) {
+		if (n == -ENOMEM) {
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
index b8df6d22314d..dad04062213f 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -525,12 +525,10 @@ static int rxperf_process_call(struct rxperf_call *call)
 		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
 		msg.msg_flags = MSG_MORE;
 		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
-					   len, rxperf_notify_end_reply_tx);
+					   rxperf_notify_end_reply_tx);
 		if (n < 0)
 			return n;
-		if (n == 0)
-			return -EIO;
-		reply_len -= n;
+		reply_len -= len;
 	}
 
 	len = sizeof(rxperf_magic_cookie);
@@ -538,11 +536,8 @@ static int rxperf_process_call(struct rxperf_call *call)
 	iov[0].iov_len	= len;
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
 	msg.msg_flags = 0;
-	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg, len,
+	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 				   rxperf_notify_end_reply_tx);
-	if (n >= 0)
-		return 0; /* Success */
-
 	if (n == -ENOMEM)
 		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
 					RXGEN_SS_MARSHAL, -ENOMEM,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005a..34aae8e789a4 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -794,7 +794,6 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * @sock: The socket the call is on
  * @call: The call to send data through
  * @msg: The data to send
- * @len: The amount of data to send
  * @notify_end_tx: Notification that the last packet is queued.
  *
  * Allow a kernel service to send data on a call.  The call must be in an state
@@ -805,8 +804,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * Return: %0 if successful and a negative error code otherwise.
  */
 int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
-			   struct msghdr *msg, size_t len,
-			   rxrpc_notify_end_tx_t notify_end_tx)
+			   struct msghdr *msg, rxrpc_notify_end_tx_t notify_end_tx)
 {
 	bool dropped_lock = false;
 	int ret;
@@ -816,15 +814,29 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	ASSERTCMP(msg->msg_name, ==, NULL);
 	ASSERTCMP(msg->msg_control, ==, NULL);
 
-	mutex_lock(&call->user_mutex);
+	for (;;) {
+		mutex_lock(&call->user_mutex);
 
-	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
-			      notify_end_tx, &dropped_lock);
-	if (ret == -ESHUTDOWN)
-		ret = call->error;
+		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
+				      msg_data_left(msg),
+				      notify_end_tx, &dropped_lock);
+		if (ret == -ESHUTDOWN)
+			ret = call->error;
+
+		if (!dropped_lock)
+			mutex_unlock(&call->user_mutex);
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
 
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 }

