Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819586;
	b=iZxYsMK4N8CG5wiVDoUn5ArN0RGuUO4vsviNNDEN6gIoi14n5ATw8tJRFRZyq/GLD8ds
	 XVj4KcTxX9tU5uTkOhFHsjDaPyf0yjSjL5TMBerpwTTKzG5Z42TcIem1Gd54w99mLGTk4
	 IEP8AFByybtRx7NxOFCKCIaT3PYxkUZs8Rs9N+7/PgvoVaPlYF5iML6Oqtc+5rs1qJVw/
	 UrwvQU/41dCQN3l9M1dRLtLAL1qlQwJJriIeIzYayateylxCr3jrJivXtqaJdvtTj5nqU
	 UvGdUZ5ZLylXQE+fymufXrfYLiytKkgBg/lUZNWGwnltYrG9fpxTZqnPo1MZusxP01A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819586;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Wa2HIGNepCRks4Y7cSVE0rCZKaeizntNuq/nBA8FAds=;
	b=JkcPee5d4NXY7O9UXd979xk6HcnoXD9EXprT3apA6MgVH6Z7IkgMXnDHZ2R7VuAYNABk
	 wX4QIYqSOqC9tIAEwjFWhfYlsVjFzJG7xdvXmbpVb7HTb+fd0DgoWNj6Uwwu29WsMUWMP
	 w2ymA7QT9HPmrVYs6hXOA8joFsH+H8k7YZPIVx0kbJkt2uFOiV8KnXVfoGZebbwayUNlB
	 hPWhMP1EN+Hv8m5XKf4qmOLyhuoCrxTBBggxO0lzxAnXrG/VE2vOZt9H25J6oPNEJ8cDA
	 i6fUWBLYLRAJ16h9EjUwWU3UlxXyyjmFQO6g2mO3NUIvOLlBF7x5XT+vs/bOsjAoJbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S4hSAUBq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FE606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S4hSAUBq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E361F000C1;
	Wed,  4 Nov 2026 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819585;
	bh=Wa2HIGNepCRks4Y7cSVE0rCZKaeizntNuq/nBA8FAds=;
	h=Subject:To:Cc:From:Date;
	b=S4hSAUBq0fv9/4BpnvwDKUV8zjBXt2JSy/rHXEgYff4rK1YZ4NxhPBCPpyT5qKcAR
	 k/ZBkl9uPTimNx4O+6mxZHMMJJL3wvv5wis09L41n3e8jhzigXDoBWpjGe+Ak0SvRF
	 EdmL83oHIiMa2vtK3DN7YpGo8aHTcVcSv6rW9b0g=
Subject: FAILED: patch "[PATCH] rxrpc: Fix lack of short-send handling in" failed to apply to 5.10-stable tree
To: dhowells@redhat.com,davem@davemloft.net,david.laight.linux@gmail.com,edumazet@google.com,horms@kernel.org,kuba@kernel.org,marc.dionne@auristor.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:12:58 -0500
Message-ID: <2026110458-debug-deranged-4db4@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x af208f36ae22440cf6011a43cb3064fd525d85b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-debug-deranged-4db4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af208f36ae22440cf6011a43cb3064fd525d85b4 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 6 Oct 2026 14:29:56 +0100
Subject: [PATCH] rxrpc: Fix lack of short-send handling in
 rxrpc_kernel_send_data()

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
Link: https://patch.msgid.link/20261006133011.531806-5-dhowells@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

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
-
-	if (n == -ENOMEM) {
-		_debug("oom");
-		rxrpc_kernel_abort_call(net->socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					afs_abort_oom);
-	}
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

