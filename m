Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001532863D
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319128; cv=none; b=HfufI0hl4ZsByyMYfemLqSOkQchlol6DRyKUeXuD4+HlfVRs0BlYfxraxYKSLx6cpwgrJPrcrtcFJQjQ4pqKYzD1O/pb08QA+nTaGr00/PPYISUWgx2IisJULdx/xjuwQoSLCSZTFREtAB8FAlgggrAb2O1NjGJ7xBRAREAeWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319128; c=relaxed/simple;
	bh=71YhhEWVOfBZicLxtxgRiYXUvkOYKW01IOQrScal9c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je2RNrymZbyBa5K3izy1aVRJtvzFzr6jcMUJrSmeHh4Pjb8ZrygjCVXrooucidbiZEdNIYE2amA34XgPh3lKr3wp57kHlQjWG6tNQd8M2CxKujxYk90LH+1LFwZ22z8WyqB5HQo1qBGFJVpYEiJ2aBGnCoiTdSJu0Tdgk5nVUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1Z/2vwZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1Z/2vwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AION8xlEfyArmZW7ZAp97FKVNaslFpVnOEzx/+Mk9bs=;
	b=D1Z/2vwZDNbHUSXHDt4oj3Jidn4jZM44/ivqbg3VkX3AY/He/ltQ8KUSfZWvPRDRFgPEqk
	ZE4cfMfpzEYL5P5iqN5gvmxvu+WoXo6F//haxgbYXxktT4REiTF3TEyzKNivOBJtCBtVJW
	Fn8W73Jt2xFE3sRHBVx+VaiF9UbT2YM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-4tWb9zxzODygAol-uB0Yfw-1; Wed,
 24 Jun 2026 12:38:37 -0400
X-MC-Unique: 4tWb9zxzODygAol-uB0Yfw-1
X-Mimecast-MFC-AGG-ID: 4tWb9zxzODygAol-uB0Yfw_1782319115
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06484195604A;
	Wed, 24 Jun 2026 16:38:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A44B41800361;
	Wed, 24 Jun 2026 16:38:27 +0000 (UTC)
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
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v3 01/11] rxrpc: Fix ACKALL packet handling
Date: Wed, 24 Jun 2026 17:38:08 +0100
Message-ID: <20260624163819.3017002-2-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
References: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Wyatt Feng <bronzed_45_vested@icloud.com>

rxrpc_input_ackall() accepts ACKALL packets without checking whether the
call is in a state that can legitimately have outstanding transmit buffers.
A forged ACKALL can therefore reach a new service call in
RXRPC_CALL_SERVER_RECV_REQUEST before any reply packets have been queued.

In that state call->tx_top is zero and call->tx_queue is NULL, so
rxrpc_rotate_tx_window() dereferences a NULL txqueue and triggers a
null-pointer dereference.

Fix the handling of ACKALL packets by the following means:

 (1) Add two new call states: RXRPC_CALL_CLIENT_PRE_SEND which indicates
     that the client call is connected, but nothing has been transmitted as
     yet; and RXRPC_CALL_CLIENT_AWAIT_ACK, which indicates that everything
     has been transmitted at least once, but we're now waiting for the
     stuff remaining in the Tx buffer to be ACK'd (retransmissions may
     still happen).

     The RXRPC_CALL_CLIENT_PRE_SEND state is set when the call is assigned
     a channel and transitions to RXRPC_CALL_CLIENT_SEND_REQUEST when the
     first packet is transmitted.

     RXRPC_CALL_CLIENT_AWAIT_REPLY is then narrowed in scope to indicate
     that all Tx packets have been ACK'd and we're now waiting for the
     reply to be received.

 (2) As per Wyatt Feng's original patch[1], the ACKALL handler then checks
     that the call state is one in which there might be stuff in the Tx
     buffer to ACK, but now this includes AWAIT_ACK rather than
     AWAIT_REPLY.  ACKALL packets are ignored if received in the wrong
     state.

     Note that unlike Wyatt Feng's patch, it's no longer necessary to check
     to see if the Tx buffer exists as this the state set now covers this.

 (3) Make the ACKALL handler use call->tx_transmitted rather than
     call->tx_top as the former is explicitly the highest packet seq number
     transmitted, whereas the latter has a looser definition.

Thanks to Jeffrey Altman for a description of the history of the ACKALL
packet[1].

Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ren Wei <n05ec@lzu.edu.cn>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260616155749.2125907-2-dhowells@redhat.com/ [1]
Link: https://lore.kernel.org/r/c0fd4fec-1576-4070-b31e-a37d5506f5ed@auristor.com/ [2]
---
 net/rxrpc/ar-internal.h |  2 ++
 net/rxrpc/call_event.c  |  5 ++++-
 net/rxrpc/call_object.c |  2 ++
 net/rxrpc/conn_client.c |  2 +-
 net/rxrpc/input.c       | 23 +++++++++++++++++++----
 net/rxrpc/sendmsg.c     |  3 ++-
 6 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 98f2165159d7..b6ccd8a8199b 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -650,7 +650,9 @@ enum rxrpc_call_event {
 enum rxrpc_call_state {
 	RXRPC_CALL_UNINITIALISED,
 	RXRPC_CALL_CLIENT_AWAIT_CONN,	/* - client waiting for connection to become available */
+	RXRPC_CALL_CLIENT_PRE_SEND,	/* - client is connected, but hasn't sent anything yet */
 	RXRPC_CALL_CLIENT_SEND_REQUEST,	/* - client sending request phase */
+	RXRPC_CALL_CLIENT_AWAIT_ACK,	/* - client awaiting ACKs of request */
 	RXRPC_CALL_CLIENT_AWAIT_REPLY,	/* - client awaiting reply */
 	RXRPC_CALL_CLIENT_RECV_REPLY,	/* - client receiving reply phase */
 	RXRPC_CALL_SERVER_PREALLOC,	/* - service preallocation */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fec59d9338b9..21be9c86d7a7 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -178,7 +178,7 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
 
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
-		rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_AWAIT_REPLY);
+		rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_AWAIT_ACK);
 		break;
 	case RXRPC_CALL_SERVER_SEND_REPLY:
 		rxrpc_set_call_state(call, RXRPC_CALL_SERVER_AWAIT_ACK);
@@ -244,6 +244,8 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call, unsigned int limi
 				break;
 		} while (req.n < limit && before(seq, send_top));
 
+		if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_PRE_SEND)
+			rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_SEND_REQUEST);
 		if (txb->flags & RXRPC_LAST_PACKET) {
 			rxrpc_close_tx_phase(call);
 			tq = NULL;
@@ -267,6 +269,7 @@ void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
 		fallthrough;
 
 	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_CLIENT_PRE_SEND:
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
 		if (!rxrpc_tx_window_space(call))
 			return;
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index fcb9d38bb521..817ed9acb91e 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -18,7 +18,9 @@
 const char *const rxrpc_call_states[NR__RXRPC_CALL_STATES] = {
 	[RXRPC_CALL_UNINITIALISED]		= "Uninit  ",
 	[RXRPC_CALL_CLIENT_AWAIT_CONN]		= "ClWtConn",
+	[RXRPC_CALL_CLIENT_PRE_SEND]		= "ClPreSnd",
 	[RXRPC_CALL_CLIENT_SEND_REQUEST]	= "ClSndReq",
+	[RXRPC_CALL_CLIENT_AWAIT_ACK]		= "ClAwtAck",
 	[RXRPC_CALL_CLIENT_AWAIT_REPLY]		= "ClAwtRpl",
 	[RXRPC_CALL_CLIENT_RECV_REPLY]		= "ClRcvRpl",
 	[RXRPC_CALL_SERVER_PREALLOC]		= "SvPrealc",
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 9b757798dedd..48519f0de185 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -449,7 +449,7 @@ static void rxrpc_activate_one_channel(struct rxrpc_connection *conn,
 	trace_rxrpc_connect_call(call);
 	call->tx_last_sent = ktime_get_real();
 	rxrpc_start_call_timer(call);
-	rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_SEND_REQUEST);
+	rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_PRE_SEND);
 	wake_up(&call->waitq);
 }
 
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index ce761466b02d..2eedab1b0919 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -181,7 +181,8 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	if (call->cong_ca_state != RXRPC_CA_SLOW_START &&
 	    call->cong_ca_state != RXRPC_CA_CONGEST_AVOIDANCE)
 		return;
-	if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
+	if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_ACK ||
+	    __rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
 		return;
 
 	rtt = ns_to_ktime(call->srtt_us * (NSEC_PER_USEC / 8));
@@ -356,6 +357,7 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_CLIENT_AWAIT_ACK:
 	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
 		if (reply_begun) {
 			rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_RECV_REPLY);
@@ -694,6 +696,7 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
 
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_CLIENT_AWAIT_ACK:
 	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
 		/* Received data implicitly ACKs all of the request
 		 * packets we sent when we're acting as a client.
@@ -1154,10 +1157,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (hard_ack + 1 == 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
 
-	/* Ignore ACKs unless we are or have just been transmitting. */
+	/* Ignore ACKs unless we are transmitting or are waiting for
+	 * acknowledgement of the packets we've just been transmitting.
+	 */
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
-	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
+	case RXRPC_CALL_CLIENT_AWAIT_ACK:
 	case RXRPC_CALL_SERVER_SEND_REPLY:
 	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		break;
@@ -1215,7 +1220,17 @@ static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
 
-	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
+	switch (__rxrpc_call_state(call)) {
+	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_CLIENT_AWAIT_ACK:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_SERVER_AWAIT_ACK:
+		break;
+	default:
+		return;
+	}
+
+	if (rxrpc_rotate_tx_window(call, call->tx_transmitted, &summary))
 		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
 }
 
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index c35de4fd75e3..ed2c9a51005a 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -366,7 +366,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	if (state >= RXRPC_CALL_COMPLETE)
 		goto maybe_error;
 	ret = -EPROTO;
-	if (state != RXRPC_CALL_CLIENT_SEND_REQUEST &&
+	if (state != RXRPC_CALL_CLIENT_PRE_SEND &&
+	    state != RXRPC_CALL_CLIENT_SEND_REQUEST &&
 	    state != RXRPC_CALL_SERVER_ACK_REQUEST &&
 	    state != RXRPC_CALL_SERVER_SEND_REPLY) {
 		/* Request phase complete for this client call */

