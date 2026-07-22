Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884414334A8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741411; cv=none; b=Nyf1ENNoMd4hr2Tr+008ngM271WbSWQjK9S5cWlYKPogAAtrCXYyh9a3vtsGOHsnUv2tH1weij7UArzqY0TdWHGeaxUf/3aN6SmyEL05OvjhkrzbAwzOLLzDD2hxDHTrC53kQIwRo1ejythXDLsUmxH+K1HwZMLqxdxgCTfYezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741411; c=relaxed/simple;
	bh=RjcKyV7WhbBOoYLD8r5gQeIQi0PIir2LsXU+EY2QKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKWwT1FusFkBUXN3z9hSlwfa7PSFucXXm0rbUxw7upDxtQieX9/SEymc81090DXli2j6uQBWNrRodCxEiYSq1fZCo/DsvfBwVPbJxaimjakcDoFvupnVFcjSVAAh6T9gUQ6Jo+QNsbNGzs4FD5LC4aOj3tlyBSzctPG8JDVtDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzRlZQtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzRlZQtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D981F00A3A;
	Wed, 22 Jul 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741409;
	bh=rX/5fcnsxuxj5hx0nTWKnuX5t1/Bc4Pe2Cl8eKSVZxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzRlZQtEFGlYSkQVtwniT5yWYnmNQnLZPzVyGU9vQQVlnB/6O7meVyKm5eBbxrEjY
	 lSKwsDdaoJRWtPa/A8D8UMTLjEOEl9PtBlUiIPyN2ECMEZ+Ne8ySx2mYuv8FiovCJS
	 Y4FBIimd6yAU8WJhaNjiUB/538YXF0cfwAuye/ss11kcqvyr7QZQkeKLA20KjYv2Y3
	 ESZ4wpGUl3Dk9ZCJYlMTFz9313D09JbMOTNo0lSuwRBoOg3V5+n7eiW/haoc7DI+KN
	 06tEy8mjGJ9c+MTiw1Bx147dJMWTLgYRyPMPhD6XZzSLw5GungaXRCgqEQnMkF5RJY
	 gGHUbgfdAFvjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] rxrpc: Use irq-disabling spinlocks between app and I/O thread
Date: Wed, 22 Jul 2026 13:30:04 -0400
Message-ID: <20260722173006.2069029-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722173006.2069029-1-sashal@kernel.org>
References: <2026072024-devalue-womanly-8b22@gregkh>
 <20260722173006.2069029-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit a2ea9a9072607c2fd6442bd1ffb4dbdbf882aed7 ]

Where a spinlock is used by both the application thread and the I/O thread,
use irq-disabling locking so that an interrupt taken on the app thread
doesn't also slow down the I/O thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e66f8f32f501 ("rxrpc: Fix socket notification race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/af_rxrpc.c    |  4 ++--
 net/rxrpc/call_accept.c | 20 ++++++++++----------
 net/rxrpc/call_object.c | 14 +++++++-------
 net/rxrpc/conn_client.c | 12 ++++++------
 net/rxrpc/conn_event.c  | 14 +++++++-------
 net/rxrpc/conn_object.c |  8 ++++----
 net/rxrpc/input.c       |  5 +----
 net/rxrpc/peer_event.c  |  8 ++++----
 net/rxrpc/peer_object.c |  1 +
 net/rxrpc/recvmsg.c     | 22 +++++++++++-----------
 net/rxrpc/security.c    |  4 ++--
 11 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0547c809876ed1..861d82d7883da0 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -362,9 +362,9 @@ void rxrpc_kernel_shutdown_call(struct socket *sock, struct rxrpc_call *call)
 
 		/* Make sure we're not going to call back into a kernel service */
 		if (call->notify_rx) {
-			spin_lock(&call->notify_lock);
+			spin_lock_irq(&call->notify_lock);
 			call->notify_rx = rxrpc_dummy_notify_rx;
-			spin_unlock(&call->notify_lock);
+			spin_unlock_irq(&call->notify_lock);
 		}
 	}
 	mutex_unlock(&call->user_mutex);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 37ac8a66567866..82d3b96a7de26e 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -189,8 +189,8 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	/* Make sure that there aren't any incoming calls in progress before we
 	 * clear the preallocation buffers.
 	 */
-	spin_lock(&rx->incoming_lock);
-	spin_unlock(&rx->incoming_lock);
+	spin_lock_irq(&rx->incoming_lock);
+	spin_unlock_irq(&rx->incoming_lock);
 
 	head = b->peer_backlog_head;
 	tail = b->peer_backlog_tail;
@@ -348,7 +348,7 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	if (sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
 		return rxrpc_protocol_error(skb, rxrpc_eproto_no_service_call);
 
-	read_lock(&local->services_lock);
+	read_lock_irq(&local->services_lock);
 
 	/* Weed out packets to services we're not offering.  Packets that would
 	 * begin a call are explicitly rejected and the rest are just
@@ -404,12 +404,12 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	spin_unlock(&conn->state_lock);
 
 	spin_unlock(&rx->incoming_lock);
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 
 	if (hlist_unhashed(&call->error_link)) {
-		spin_lock(&call->peer->lock);
+		spin_lock_irq(&call->peer->lock);
 		hlist_add_head(&call->error_link, &call->peer->error_targets);
-		spin_unlock(&call->peer->lock);
+		spin_unlock_irq(&call->peer->lock);
 	}
 
 	_leave(" = %p{%d}", call, call->debug_id);
@@ -418,20 +418,20 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 	return true;
 
 unsupported_service:
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
 				  RX_INVALID_OPERATION, -EOPNOTSUPP);
 unsupported_security:
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	return rxrpc_direct_abort(skb, rxrpc_abort_service_not_offered,
 				  RX_INVALID_OPERATION, -EKEYREJECTED);
 no_call:
 	spin_unlock(&rx->incoming_lock);
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	_leave(" = f [%u]", skb->mark);
 	return false;
 discard:
-	read_unlock(&local->services_lock);
+	read_unlock_irq(&local->services_lock);
 	return true;
 }
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index ede2fbc6611352..0be153133cb085 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -48,7 +48,7 @@ void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
 	bool busy;
 
 	if (!test_bit(RXRPC_CALL_DISCONNECTED, &call->flags)) {
-		spin_lock_bh(&local->lock);
+		spin_lock_irq(&local->lock);
 		busy = !list_empty(&call->attend_link);
 		trace_rxrpc_poke_call(call, busy, what);
 		if (!busy && !rxrpc_try_get_call(call, rxrpc_call_get_poke))
@@ -56,7 +56,7 @@ void rxrpc_poke_call(struct rxrpc_call *call, enum rxrpc_call_poke_trace what)
 		if (!busy) {
 			list_add_tail(&call->attend_link, &local->call_attend_q);
 		}
-		spin_unlock_bh(&local->lock);
+		spin_unlock_irq(&local->lock);
 		if (!busy)
 			rxrpc_wake_up_io_thread(local);
 	}
@@ -311,9 +311,9 @@ static int rxrpc_connect_call(struct rxrpc_call *call, gfp_t gfp)
 
 	trace_rxrpc_client(NULL, -1, rxrpc_client_queue_new_call);
 	rxrpc_get_call(call, rxrpc_call_get_io_thread);
-	spin_lock(&local->client_call_lock);
+	spin_lock_irq(&local->client_call_lock);
 	list_add_tail(&call->wait_link, &local->new_client_calls);
-	spin_unlock(&local->client_call_lock);
+	spin_unlock_irq(&local->client_call_lock);
 	rxrpc_wake_up_io_thread(local);
 	return 0;
 
@@ -439,7 +439,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 
 /*
  * Set up an incoming call.  call->conn points to the connection.
- * This is called in BH context and isn't allowed to fail.
+ * This is called with interrupts disabled and isn't allowed to fail.
  */
 void rxrpc_incoming_call(struct rxrpc_sock *rx,
 			 struct rxrpc_call *call,
@@ -563,7 +563,7 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	rxrpc_put_call_slot(call);
 
 	/* Make sure we don't get any more notifications */
-	spin_lock(&rx->recvmsg_lock);
+	spin_lock_irq(&rx->recvmsg_lock);
 
 	if (!list_empty(&call->recvmsg_link)) {
 		_debug("unlinking once-pending call %p { e=%lx f=%lx }",
@@ -576,7 +576,7 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 	call->recvmsg_link.next = NULL;
 	call->recvmsg_link.prev = NULL;
 
-	spin_unlock(&rx->recvmsg_lock);
+	spin_unlock_irq(&rx->recvmsg_lock);
 	if (put)
 		rxrpc_put_call(call, rxrpc_call_put_unnotify);
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index a0231b64fb6ef0..05d851ed7f5aec 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -505,10 +505,10 @@ void rxrpc_connect_client_calls(struct rxrpc_local *local)
 	       ) {
 		struct rxrpc_bundle *bundle = call->bundle;
 
-		spin_lock(&local->client_call_lock);
+		spin_lock_irq(&local->client_call_lock);
 		list_move_tail(&call->wait_link, &bundle->waiting_calls);
 		rxrpc_see_call(call, rxrpc_call_see_waiting_call);
-		spin_unlock(&local->client_call_lock);
+		spin_unlock_irq(&local->client_call_lock);
 
 		if (rxrpc_bundle_has_space(bundle))
 			rxrpc_activate_channels(bundle);
@@ -536,9 +536,9 @@ void rxrpc_expose_client_call(struct rxrpc_call *call)
 			set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);
 		trace_rxrpc_client(conn, channel, rxrpc_client_exposed);
 
-		spin_lock(&call->peer->lock);
+		spin_lock_irq(&call->peer->lock);
 		hlist_add_head(&call->error_link, &call->peer->error_targets);
-		spin_unlock(&call->peer->lock);
+		spin_unlock_irq(&call->peer->lock);
 	}
 }
 
@@ -579,9 +579,9 @@ void rxrpc_disconnect_client_call(struct rxrpc_bundle *bundle, struct rxrpc_call
 		ASSERTCMP(call->call_id, ==, 0);
 		ASSERT(!test_bit(RXRPC_CALL_EXPOSED, &call->flags));
 		/* May still be on ->new_client_calls. */
-		spin_lock(&local->client_call_lock);
+		spin_lock_irq(&local->client_call_lock);
 		list_del_init(&call->wait_link);
-		spin_unlock(&local->client_call_lock);
+		spin_unlock_irq(&local->client_call_lock);
 		return;
 	}
 
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index ab66903e4d72fd..25fbef44ca9d6a 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -26,7 +26,7 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff
 	bool aborted = false;
 
 	if (conn->state != RXRPC_CONN_ABORTED) {
-		spin_lock(&conn->state_lock);
+		spin_lock_irq(&conn->state_lock);
 		if (conn->state != RXRPC_CONN_ABORTED) {
 			conn->abort_code = abort_code;
 			conn->error	 = err;
@@ -37,7 +37,7 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn, struct sk_buff
 			set_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events);
 			aborted = true;
 		}
-		spin_unlock(&conn->state_lock);
+		spin_unlock_irq(&conn->state_lock);
 	}
 
 	return aborted;
@@ -268,12 +268,12 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		return conn->security->respond_to_challenge(conn, skb);
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
-		spin_lock(&conn->state_lock);
+		spin_lock_irq(&conn->state_lock);
 		if (conn->state != RXRPC_CONN_SERVICE_CHALLENGING) {
-			spin_unlock(&conn->state_lock);
+			spin_unlock_irq(&conn->state_lock);
 			return 0;
 		}
-		spin_unlock(&conn->state_lock);
+		spin_unlock_irq(&conn->state_lock);
 
 		ret = rxrpc_verify_response(conn, skb);
 		if (ret < 0)
@@ -284,12 +284,12 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		if (ret < 0)
 			return ret;
 
-		spin_lock(&conn->state_lock);
+		spin_lock_irq(&conn->state_lock);
 		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING) {
 			conn->state = RXRPC_CONN_SERVICE;
 			secured = true;
 		}
-		spin_unlock(&conn->state_lock);
+		spin_unlock_irq(&conn->state_lock);
 
 		if (secured) {
 			/* Offload call state flipping to the I/O thread.  As
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index f0c77f437b6167..90652f6e85159b 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -31,13 +31,13 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
 	if (WARN_ON_ONCE(!local))
 		return;
 
-	spin_lock_bh(&local->lock);
+	spin_lock_irq(&local->lock);
 	busy = !list_empty(&conn->attend_link);
 	if (!busy) {
 		rxrpc_get_connection(conn, why);
 		list_add_tail(&conn->attend_link, &local->conn_attend_q);
 	}
-	spin_unlock_bh(&local->lock);
+	spin_unlock_irq(&local->lock);
 	rxrpc_wake_up_io_thread(local);
 }
 
@@ -196,9 +196,9 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 	call->peer->cong_ssthresh = call->cong_ssthresh;
 
 	if (!hlist_unhashed(&call->error_link)) {
-		spin_lock(&call->peer->lock);
+		spin_lock_irq(&call->peer->lock);
 		hlist_del_init(&call->error_link);
-		spin_unlock(&call->peer->lock);
+		spin_unlock_irq(&call->peer->lock);
 	}
 
 	if (rxrpc_is_client_call(call)) {
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 1157bf75ef9c8c..0503698af46d6f 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -366,7 +366,7 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	bool last = sp->hdr.flags & RXRPC_LAST_PACKET;
 
-	__skb_queue_tail(&call->recvmsg_queue, skb);
+	skb_queue_tail(&call->recvmsg_queue, skb);
 	rxrpc_input_update_ack_window(call, window, wtop);
 	trace_rxrpc_receive(call, last ? why + 1 : why, sp->hdr.serial, sp->hdr.seq);
 	if (last)
@@ -443,7 +443,6 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 
 		rxrpc_get_skb(skb, rxrpc_skb_get_to_recvmsg);
 
-		spin_lock(&call->recvmsg_queue.lock);
 		rxrpc_input_queue_data(call, skb, window, wtop, rxrpc_receive_queue);
 		*_notify = true;
 
@@ -465,8 +464,6 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 					       rxrpc_receive_queue_oos);
 		}
 
-		spin_unlock(&call->recvmsg_queue.lock);
-
 		call->ackr_sack_base = sack;
 	} else {
 		unsigned int slot;
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 8c7fad55da74d7..fd66d18b94df4b 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -205,23 +205,23 @@ static void rxrpc_distribute_error(struct rxrpc_peer *peer, struct sk_buff *skb,
 	struct rxrpc_call *call;
 	HLIST_HEAD(error_targets);
 
-	spin_lock(&peer->lock);
+	spin_lock_irq(&peer->lock);
 	hlist_move_list(&peer->error_targets, &error_targets);
 
 	while (!hlist_empty(&error_targets)) {
 		call = hlist_entry(error_targets.first,
 				   struct rxrpc_call, error_link);
 		hlist_del_init(&call->error_link);
-		spin_unlock(&peer->lock);
+		spin_unlock_irq(&peer->lock);
 
 		rxrpc_see_call(call, rxrpc_call_see_distribute_error);
 		rxrpc_set_call_completion(call, compl, 0, -err);
 		rxrpc_input_call_event(call, skb);
 
-		spin_lock(&peer->lock);
+		spin_lock_irq(&peer->lock);
 	}
 
-	spin_unlock(&peer->lock);
+	spin_unlock_irq(&peer->lock);
 }
 
 /*
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 8d7a715a0bb1ca..3a4cf95ecddfce 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -302,6 +302,7 @@ static void rxrpc_free_peer(struct rxrpc_peer *peer)
  * Set up a new incoming peer.  There shouldn't be any other matching peers
  * since we've already done a search in the list from the non-reentrant context
  * (the data_ready handler) that is the only place we can add new peers.
+ * Called with interrupts disabled.
  */
 void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 {
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 99efe14eb0c914..dccfa6cae71502 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -36,16 +36,16 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 	sk = &rx->sk;
 	if (rx && sk->sk_state < RXRPC_CLOSE) {
 		if (call->notify_rx) {
-			spin_lock(&call->notify_lock);
+			spin_lock_irq(&call->notify_lock);
 			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock(&call->notify_lock);
+			spin_unlock_irq(&call->notify_lock);
 		} else {
-			spin_lock(&rx->recvmsg_lock);
+			spin_lock_irq(&rx->recvmsg_lock);
 			if (list_empty(&call->recvmsg_link)) {
 				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
 				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
 			}
-			spin_unlock(&rx->recvmsg_lock);
+			spin_unlock_irq(&rx->recvmsg_lock);
 
 			if (!sock_flag(sk, SOCK_DEAD)) {
 				_debug("call %ps", sk->sk_data_ready);
@@ -379,14 +379,14 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	 * We also want to weed out calls that got requeued whilst we were
 	 * shovelling data out.
 	 */
-	spin_lock(&rx->recvmsg_lock);
+	spin_lock_irq(&rx->recvmsg_lock);
 	l = rx->recvmsg_q.next;
 	call = list_entry(l, struct rxrpc_call, recvmsg_link);
 
 	if (!rxrpc_call_is_complete(call) &&
 	    skb_queue_empty(&call->recvmsg_queue)) {
 		list_del_init(&call->recvmsg_link);
-		spin_unlock(&rx->recvmsg_lock);
+		spin_unlock_irq(&rx->recvmsg_lock);
 		release_sock(&rx->sk);
 		trace_rxrpc_recvmsg(call->debug_id, rxrpc_recvmsg_unqueue, 0);
 		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
@@ -407,7 +407,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		list_del_init(&call->recvmsg_link);
 	else
 		rxrpc_get_call(call, rxrpc_call_get_recvmsg);
-	spin_unlock(&rx->recvmsg_lock);
+	spin_unlock_irq(&rx->recvmsg_lock);
 
 	call_debug_id = call->debug_id;
 	trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_dequeue, 0);
@@ -503,17 +503,17 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 error_requeue_call:
 	if (!(flags & MSG_PEEK)) {
-		spin_lock(&rx->recvmsg_lock);
+		spin_lock_irq(&rx->recvmsg_lock);
 		if (list_empty(&call->recvmsg_link)) {
 			list_add(&call->recvmsg_link, &rx->recvmsg_q);
 			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue);
-			spin_unlock(&rx->recvmsg_lock);
+			spin_unlock_irq(&rx->recvmsg_lock);
 		} else if (list_is_first(&call->recvmsg_link, &rx->recvmsg_q)) {
-			spin_unlock(&rx->recvmsg_lock);
+			spin_unlock_irq(&rx->recvmsg_lock);
 			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_first);
 		} else {
 			list_move(&call->recvmsg_link, &rx->recvmsg_q);
-			spin_unlock(&rx->recvmsg_lock);
+			spin_unlock_irq(&rx->recvmsg_lock);
 			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_move);
 		}
 		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index cb8dd1d3b1d49e..9784adc8f27593 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -114,10 +114,10 @@ int rxrpc_init_client_conn_security(struct rxrpc_connection *conn)
 	if (conn->state == RXRPC_CONN_CLIENT_UNSECURED) {
 		ret = conn->security->init_connection_security(conn, token);
 		if (ret == 0) {
-			spin_lock(&conn->state_lock);
+			spin_lock_irq(&conn->state_lock);
 			if (conn->state == RXRPC_CONN_CLIENT_UNSECURED)
 				conn->state = RXRPC_CONN_CLIENT;
-			spin_unlock(&conn->state_lock);
+			spin_unlock_irq(&conn->state_lock);
 		}
 	}
 	mutex_unlock(&conn->security_lock);
-- 
2.53.0

