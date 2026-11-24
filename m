Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536844;
	b=kbmCbGgjkz/EYi+tbThIYNL7+GaAAv2IibLQv4HpdonC4DHfghWRuzXpWT+y8aNPxvZR
	 w1pR2/ApQ53veH97QGEX5OuGil202L4s093nrWehHohWI5RJLlIbvEEixMXUiv7KacckA
	 d8bISoiEdNkYelbF8Qe2Y3WPNQba6Yayl/n0mRaf+X/CHC//3OSnH6VaVf5F/E1ZRBMTi
	 jvjtNrzOqIL7flkTvknLvXaLzuiiydV3LKjfdycaEkHW9+iSbk8DleLmrjs/C7ZT/AyuD
	 DnVMcqH20gtMf5sKAGMfhancJNJqDtuwj+0XTb/qLdpM8PJSU7MTZgAVXV6MtS9f5Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536844;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=bqaCQVc0CnAWlcTrMHqycFRIfLYQ02uy7g48ZeoAz6g=;
	b=DKRV1QCepM5ZYLBHuwypY27orfe3mSYXvzCuan+L/rPg2YTPcwX4nWSf1KFuXNZhvo+T
	 387uE2giKKC5ZLO3bWQpNk+QQTZvMv2l6mx04dDk8SmwOxazWnNWs8J5LoC5RKU1wUBKT
	 G4EGX6Kbj5qD9HLa4B5QZ+HvtvcbLehjZpBSkWHAUus5Vd+wtdrJGrTU3jaTDDK2UKjXN
	 W7PVMDEZZd6h+MKU6kXGzmYC28rSlXmwqB4m2b5SsvA7VuTREOuy3LTUFRw4Ql1ETP3O7
	 a+JWDZJLd7garpZDJ3YDBtHahIQJpz5puwS2zYXpSBanAAaFsVuMuoV/J1GpTw3zTLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9jAOHlc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA48606A689
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA48606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9jAOHlc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqaCQVc0CnAWlcTrMHqycFRIfLYQ02uy7g48ZeoAz6g=;
	b=a9jAOHlclfhyYEZs8i1WrU8kqg53fntGBrEaUzF0xyYr/RhiLKFitiAA6THtOhY8PqRh4H
	SG+bYMkTlcmIUEX+HbRR7elwTPAUJB5kvCr1YVPlRlwjBElEt/+kBvhZcxYXNoElbJhFe5
	qw7rHNCjcWVkvphvV0sSXGvoYXkG/QI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-bDiRZnSMMj-X2xJVZHtavw-1; Tue,
 24 Nov 2026 16:13:57 +0000
X-MC-Unique: bDiRZnSMMj-X2xJVZHtavw-1
X-Mimecast-MFC-AGG-ID: bDiRZnSMMj-X2xJVZHtavw_1795536830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A416180256C;
	Tue, 24 Nov 2026 16:13:50 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08A3118004FC;
	Tue, 24 Nov 2026 16:13:47 +0000 (UTC)
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
Subject: [PATCH net v3 09/10] rxrpc: Fix counting of in-flight transmitted packets
Date: Tue, 24 Nov 2026 16:12:57 +0000
Message-ID: <20261124161302.4044422-10-dhowells@redhat.com>
In-Reply-To: <20261124161302.4044422-1-dhowells@redhat.com>
References: <20261124161302.4044422-1-dhowells@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The RACK-TLP algorithm [RFC8985] makes use of the count of in-flight
packets in decisions (denoted as FlightSize).  This is currently based on
an approximation derived from the sum of other values:

	tx_nr_sent - (acks_nr_sacks + tx_nr_lost) + tx_nr_resent

This, however, turns out not to be very good here as the component counters
aren't updated together and this may lead to an incorrect estimate.

Fix counting of in-flight transmitted packets by tracking them directly
rather than deriving the value:

 (1) On each rxrpc_txqueue struct, keep a bitmap of which packets (txbuf)
     from the set managed by that txqueue are considered in-flight.

 (2) A new counter, tx_in_flight, is then added to the rxrpc_call struct to
     keep track of the number of packets considered to be in flight.

 (3) Set a packet's bit when the packet is transmitted and if the bit
     wasn't already set, increment tx_in_flight.

 (4) Clear a packet's bit when an ACK is received for the packet or if the
     packet is declared lost - and if the bit wasn't already cleared,
     decrement tx_in_flight.

 (5) Add special accounting for the TLP probe when the TLP probe is a
     retransmission of a packet that has already been ACK'd.  The ACK
     parser doesn't update the in_flight status already-acked packets that
     get re-ACK'd, so this is tracked separately in rxrpc_call.  Also add
     TLP probe loss detection and then have that cancel the TLP probe and
     its special in-flight status too.

     Note that Rx protocol can in theory do a bit better than TCP here as
     the Rx ACK packet references exactly by serial number the DATA/ACK
     packet that triggered it.

The value in tx_in_flight is then used instead of the approximation.

If a packet that was soft-ACK'd gets subsequently NACK'd, we don't add it
back to the tx_in_flight counter as we know it's not in flight.  It does,
however, need retransmission and so gets marked lost.

To help make this work, a flag indicating that we're doing a TLP probe with
new data is passed down to rxrpc_prepare_data_packet() via
rxrpc_transmit_some_data() and the setting of call->tlp_serial, ->tlp_seq
and ->tlp_is_retrans is moved there.

The tx_nr_sent and tx_nr_resent counters are then removed and the
rxrpc_rack tracepoint updated.  The tx_last_serial is now only ever set and
so removed also.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com
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
 include/trace/events/rxrpc.h | 11 +++-----
 net/rxrpc/ar-internal.h      | 34 +++++++++++-------------
 net/rxrpc/call_event.c       | 17 ++++++------
 net/rxrpc/input.c            | 25 ++++++++++++------
 net/rxrpc/input_rack.c       | 51 ++++++++++++++++++++++++------------
 net/rxrpc/output.c           | 22 ++++++++++++----
 6 files changed, 96 insertions(+), 64 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 56dc9b614071..67a5612cdc55 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -2584,9 +2584,8 @@ TRACE_EVENT(rxrpc_rack,
 		    __field(rxrpc_serial_t,	ack_serial)
 		    __field(rxrpc_seq_t,	seq)
 		    __field(enum rxrpc_rack_timer_mode, mode)
-		    __field(unsigned short,	nr_sent)
+		    __field(unsigned short,	in_flight)
 		    __field(unsigned short,	nr_lost)
-		    __field(unsigned short,	nr_resent)
 		    __field(unsigned short,	nr_sacked)
 		    __field(ktime_t,		timo)
 			     ),
@@ -2596,18 +2595,16 @@ TRACE_EVENT(rxrpc_rack,
 		    __entry->ack_serial	= call->rx_serial;
 		    __entry->seq	= call->rack_end_seq;
 		    __entry->mode	= call->rack_timer_mode;
-		    __entry->nr_sent	= call->tx_nr_sent;
+		    __entry->in_flight	= call->tx_in_flight;
 		    __entry->nr_lost	= call->tx_nr_lost;
-		    __entry->nr_resent	= call->tx_nr_resent;
 		    __entry->nr_sacked	= call->acks_nr_sacks;
 		    __entry->timo	= timo;
 			   ),
 
-	    TP_printk("c=%08x r=%08x q=%08x %s slrs=%u,%u,%u,%u t=%lld",
+	    TP_printk("c=%08x r=%08x q=%08x %s fls=%u,%u,%u t=%lld",
 		      __entry->call, __entry->ack_serial, __entry->seq,
 		      __print_symbolic(__entry->mode, rxrpc_rack_timer_modes),
-		      __entry->nr_sent, __entry->nr_lost,
-		      __entry->nr_resent, __entry->nr_sacked,
+		      __entry->in_flight, __entry->nr_lost, __entry->nr_sacked,
 		      ktime_to_us(__entry->timo))
 	    );
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 6e9fc996cd92..c0cb1c7e6680 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -780,11 +780,9 @@ struct rxrpc_call {
 	rxrpc_seq_t		tx_bottom;	/* First packet in buffer */
 	rxrpc_seq_t		tx_transmitted;	/* Highest packet transmitted */
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
-	rxrpc_serial_t		tx_last_serial;	/* Serial of last DATA transmitted */
 	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
-	u16			tx_nr_sent;	/* Number of packets sent, but unacked */
+	u16			tx_in_flight;	/* Number of packets considered "in flight" */
 	u16			tx_nr_lost;	/* Number of packets marked lost */
-	u16			tx_nr_resent;	/* Number of packets resent, but unacked */
 	u16			tx_winsize;	/* Maximum size of Tx window */
 #define RXRPC_TX_MAX_WINDOW	128
 	u8			tx_jumbo_max;	/* Maximum subpkts peer will accept */
@@ -832,11 +830,13 @@ struct rxrpc_call {
 	bool			rack_dsack_round_none; /* T if dsack_round is "None" */
 	bool			rack_reordering_seen; /* T if detected reordering event */
 	enum rxrpc_rack_timer_mode rack_timer_mode; /* Current mode of RACK timer */
+	bool			tlp_in_flight;	/* T if duplicate probe is in flight */
 	bool			tlp_is_retrans;	/* T if unacked TLP retransmission */
 	rxrpc_serial_t		tlp_serial;	/* Serial of TLP probe (or 0 if none in progress) */
 	rxrpc_seq_t		tlp_seq;	/* Sequence of TLP probe */
 	unsigned int		tlp_rtt_taken;	/* Last time RTT taken */
 	ktime_t			tlp_max_ack_delay; /* Sender budget for max delayed ACK interval */
+	ktime_t			tlp_xmit_ts;	/* Transmission timestamp for TLP probe */
 
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
@@ -980,6 +980,7 @@ struct rxrpc_txqueue {
 	unsigned long		segment_acked;	/* Bit-per-buf: Set if ACK'd */
 	unsigned long		segment_lost;	/* Bit-per-buf: Set if declared lost */
 	unsigned long		segment_retransmitted; /* Bit-per-buf: Set if retransmitted */
+	unsigned long		in_flight;	/* Bit-per-buf: Set if "in flight" */
 	unsigned long		rtt_samples;	/* Bit-per-buf: Set if available for RTT */
 	unsigned long		ever_retransmitted; /* Bit-per-buf: Set if ever retransmitted */
 
@@ -1065,7 +1066,7 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *, rxrpc_serial_t,
 			     enum rxrpc_propose_ack_trace);
 void rxrpc_resend_tlp(struct rxrpc_call *call);
 void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
-			      enum rxrpc_txdata_trace trace);
+			      bool tlp_probe, enum rxrpc_txdata_trace trace);
 bool rxrpc_input_call_event(struct rxrpc_call *call);
 
 /*
@@ -1266,10 +1267,19 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call);
 void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary);
 void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by);
 
+static inline void rxrpc_tlp_end_probe(struct rxrpc_call *call)
+{
+	call->tlp_serial = 0;
+	if (call->tlp_in_flight) {
+		call->tlp_in_flight = false;
+		call->tx_in_flight--;
+	}
+}
+
 /* Initialise TLP state [RFC8958 7.1]. */
 static inline void rxrpc_tlp_init(struct rxrpc_call *call)
 {
-	call->tlp_serial = 0;
+	rxrpc_tlp_end_probe(call);
 	call->tlp_seq = call->acks_hard_ack;
 	call->tlp_is_retrans = false;
 }
@@ -1603,20 +1613,6 @@ static inline unsigned int rxrpc_tx_window_space(const struct rxrpc_call *call)
 	return max(winsize - transmitted, 0);
 }
 
-static inline unsigned int rxrpc_left_out(const struct rxrpc_call *call)
-{
-	return call->acks_nr_sacks + call->tx_nr_lost;
-}
-
-/*
- * Calculate the number of transmitted DATA packets assumed to be in flight
- * [approx RFC6675].
- */
-static inline unsigned int rxrpc_tx_in_flight(const struct rxrpc_call *call)
-{
-	return call->tx_nr_sent - rxrpc_left_out(call) + call->tx_nr_resent;
-}
-
 /*
  * debug tracing
  */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 4def732352e9..62e15b03c9c2 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -193,7 +193,7 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
  * (UINT_MAX for no limit).
  */
 static void rxrpc_transmit_fresh_data(struct rxrpc_call *call, unsigned int limit,
-				      enum rxrpc_txdata_trace trace)
+				      bool tlp_probe, enum rxrpc_txdata_trace trace)
 {
 	int space = rxrpc_tx_window_space(call);
 
@@ -205,10 +205,11 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call, unsigned int limi
 
 	while (space > 0) {
 		struct rxrpc_send_data_req req = {
-			.now	= ktime_get_real(),
-			.seq	= call->tx_transmitted + 1,
-			.n	= 0,
-			.trace	= trace,
+			.now		= ktime_get_real(),
+			.seq		= call->tx_transmitted + 1,
+			.n		= 0,
+			.tlp_probe	= tlp_probe,
+			.trace		= trace,
 		};
 		struct rxrpc_txqueue *tq;
 		struct rxrpc_txbuf *txb;
@@ -266,7 +267,7 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call, unsigned int limi
 }
 
 void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
-			      enum rxrpc_txdata_trace trace)
+			      bool tlp_probe, enum rxrpc_txdata_trace trace)
 {
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
@@ -284,7 +285,7 @@ void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
 			rxrpc_inc_stat(call->rxnet, stat_tx_data_underflow);
 			return;
 		}
-		rxrpc_transmit_fresh_data(call, limit, trace);
+		rxrpc_transmit_fresh_data(call, limit, tlp_probe, trace);
 		break;
 	default:
 		return;
@@ -408,7 +409,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 	if (test_and_clear_bit(RXRPC_CALL_EV_INITIAL_PING, &call->events))
 		rxrpc_send_initial_ping(call);
 
-	rxrpc_transmit_some_data(call, UINT_MAX, rxrpc_txdata_new_data);
+	rxrpc_transmit_some_data(call, UINT_MAX, false, rxrpc_txdata_new_data);
 
 	if (saw_ack)
 		rxrpc_congestion_degrade(call);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index d01a8d95dc6d..66be37f21410 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -33,7 +33,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 					struct rxrpc_ack_summary *summary)
 {
 	summary->change = rxrpc_cong_no_change;
-	summary->in_flight = rxrpc_tx_in_flight(call);
+	summary->in_flight = call->tx_in_flight;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags))
 		summary->retrans_timeo = true;
@@ -196,7 +196,7 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 void rxrpc_congestion_timeout(struct rxrpc_call *call)
 {
 	set_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags);
-	call->cong_ssthresh = umax(rxrpc_tx_in_flight(call) / 2, 2);
+	call->cong_ssthresh = umax(call->tx_in_flight / 2, 2);
 	call->cong_cwnd = 1;
 	if (call->cong_cwnd >= call->cong_ssthresh &&
 	    call->cong_ca_state == RXRPC_CA_SLOW_START) {
@@ -276,8 +276,10 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			tq->nr_reported_acks++;
 			rxrpc_input_rack_one(call, summary, tq, ix);
 			if (call->tlp_serial &&
-			    seq == call->tlp_seq)
+			    seq == call->tlp_seq) {
 				summary->tlp_probe_acked = true;
+				rxrpc_tlp_end_probe(call);
+			}
 			summary->nr_new_hacks++;
 			__set_bit(ix, &tq->segment_acked);
 			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_hack);
@@ -290,18 +292,20 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			call->acks_nr_snacks--;
 			rxrpc_input_rack_one(call, summary, tq, ix);
 			if (call->tlp_serial &&
-			    seq == call->tlp_seq)
+			    seq == call->tlp_seq) {
 				summary->tlp_probe_acked = true;
+				rxrpc_tlp_end_probe(call);
+			}
 			summary->nr_new_hacks++;
 			__set_bit(ix, &tq->segment_acked);
 			trace_rxrpc_rotate(call, tq, summary, seq, rxrpc_rotate_trace_snak);
 		}
 
-		call->tx_nr_sent--;
+		if (__test_and_clear_bit(ix, &tq->in_flight))
+			call->tx_in_flight--;
 		if (__test_and_clear_bit(ix, &tq->segment_lost))
 			call->tx_nr_lost--;
-		if (__test_and_clear_bit(ix, &tq->segment_retransmitted))
-			call->tx_nr_resent--;
+		__clear_bit(ix, &tq->segment_retransmitted);
 		__clear_bit(ix, &tq->ever_retransmitted);
 
 		rxrpc_put_txbuf(tq->bufs[ix], rxrpc_txbuf_put_rotated);
@@ -960,6 +964,11 @@ static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
 		rxrpc_input_soft_rtt(call, summary, tq);
 
 	new_acks |= n_to_a;
+	if (new_acks & tq->in_flight) {
+		call->tx_in_flight -= hweight_long(new_acks & tq->in_flight);
+		tq->in_flight &= ~new_acks;
+	}
+
 	if (new_acks || a_to_n)
 		rxrpc_input_rack(call, summary, tq, new_acks, a_to_n);
 
@@ -1227,7 +1236,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		 */
 		rxrpc_tlp_process_ack(call, &summary);
 		if (after_eq(summary.acked_serial, call->tlp_serial))
-			call->tlp_serial = 0;
+			rxrpc_tlp_end_probe(call);
 	}
 
 send_response:
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 07972c85f256..240362109a3b 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -23,12 +23,13 @@ static bool rxrpc_rack_sent_after(ktime_t t1, rxrpc_seq_t seq1,
 static void rxrpc_rack_mark_lost(struct rxrpc_call *call,
 				 struct rxrpc_txqueue *tq, unsigned int ix)
 {
-	if (__test_and_set_bit(ix, &tq->segment_lost)) {
-		if (__test_and_clear_bit(ix, &tq->segment_retransmitted))
-			call->tx_nr_resent--;
-	} else {
+	if (__test_and_set_bit(ix, &tq->segment_lost))
+		__clear_bit(ix, &tq->segment_retransmitted);
+	else
 		call->tx_nr_lost++;
-	}
+
+	if (__test_and_clear_bit(ix, &tq->in_flight))
+		call->tx_in_flight--;
 	tq->segment_xmit_ts[ix] = UINT_MAX;
 }
 
@@ -304,7 +305,7 @@ static void rxrpc_rack_mark_losses_on_rto(struct rxrpc_call *call)
  */
 ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 {
-	unsigned int flight_size = rxrpc_tx_in_flight(call);
+	unsigned int flight_size = call->tx_in_flight;
 	ktime_t rto_at = ktime_add(call->tx_last_sent,
 				   rxrpc_get_rto_backoff(call, false));
 	ktime_t pto;
@@ -341,23 +342,18 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 		if (after(call->send_top, call->tx_transmitted) &&
 		    rxrpc_tx_window_space(call) > 0) {
 			/* Transmit the lowest-sequence unsent DATA */
-			call->tx_last_serial = 0;
-			rxrpc_transmit_some_data(call, 1, rxrpc_txdata_tlp_new_data);
-			call->tlp_serial = call->tx_last_serial;
-			call->tlp_seq = call->tx_transmitted;
+			rxrpc_transmit_some_data(call, 1, true, rxrpc_txdata_tlp_new_data);
 			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_transmit_new);
 		} else {
 			/* Retransmit the highest-sequence DATA sent */
-			call->tx_last_serial = 0;
 			rxrpc_resend_tlp(call);
-			call->tlp_is_retrans = true;
 			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_retransmit);
 		}
 	} else {
 		trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_busy);
 	}
 
-	if (rxrpc_tx_in_flight(call) != 0) {
+	if (call->tx_in_flight != 0) {
 		ktime_t rto = rxrpc_get_rto_backoff(call, false);
 
 		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
@@ -379,16 +375,16 @@ void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *su
 	if (!call->tlp_is_retrans) {
 		/* TLP of new data delivered */
 		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_new_data);
-		call->tlp_serial = 0;
+		rxrpc_tlp_end_probe(call);
 	} else if (summary->ack_reason == RXRPC_ACK_DUPLICATE &&
 		   summary->acked_serial == call->tlp_serial) {
 		/* General Case: Detected packet losses using RACK [7.4.1] */
 		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_dup_acked);
-		call->tlp_serial = 0;
+		rxrpc_tlp_end_probe(call);
 	} else if (after(call->acks_hard_ack, call->tlp_seq)) {
 		/* Repaired the single loss */
 		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_hard_beyond);
-		call->tlp_serial = 0;
+		rxrpc_tlp_end_probe(call);
 		// TODO: Invoke congestion control to react to the loss
 		// event the probe has repaired
 	} else if (summary->tlp_probe_acked) {
@@ -396,12 +392,32 @@ void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *su
 		/* Special Case: Detected a single loss repaired by the loss
 		 * probe [7.4.2]
 		 */
-		call->tlp_serial = 0;
+		rxrpc_tlp_end_probe(call);
 	} else {
 		trace_rxrpc_tlp_ack(call, summary, rxrpc_tlp_ack_trace_incomplete);
 	}
 }
 
+/*
+ * Handle TLP probe loss.
+ */
+static void rxrpc_tlp_probe_loss(struct rxrpc_call *call)
+{
+	ktime_t lost_at, now;
+
+	if (!call->tlp_serial)
+		return;
+
+	lost_at = ktime_add(call->tlp_xmit_ts, rxrpc_get_rto_backoff(call, false));
+	now = ktime_get_real();
+
+	if (ktime_before(now, lost_at))
+		return;
+
+	/* Presume the probe to be lost.  Cancel it so we can have a new one. */
+	rxrpc_tlp_end_probe(call);
+}
+
 /*
  * Handle RACK timer expiration; returns true to request a resend.
  */
@@ -423,6 +439,7 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
 	case RXRPC_CALL_RACKTIMER_RTO:
 		rxrpc_congestion_timeout(call);
 		rxrpc_rack_mark_losses_on_rto(call);
+		rxrpc_tlp_probe_loss(call);
 		break;
 	//case RXRPC_CALL_RACKTIMER_ZEROWIN:
 	default:
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 88cad087f13b..e053db0c22e6 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -560,7 +560,6 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
 	whdr->_rsvd		= 0;
 	whdr->serviceId		= htons(call->conn->service_id);
 
-	call->tx_last_serial = serial + req->n - 1;
 	call->tx_last_sent = req->now;
 	xmit_ts = rxrpc_prepare_txqueue(tq, req);
 	prefetch(tq->next);
@@ -571,15 +570,26 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
 
 		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
 
+		if (req->tlp_probe && test_bit(ix, &tq->segment_acked)) {
+			/* Account re-transmission of an already ACK'd packet
+			 * separately as the ACK parser ignores re-ACKs of
+			 * already ACK'd packets.
+			 */
+			if (!call->tlp_in_flight) {
+				call->tlp_in_flight = true;
+				call->tx_in_flight++;
+			}
+		} else if (!__test_and_set_bit(ix, &tq->in_flight)) {
+			call->tx_in_flight++;
+		}
+
 		/* Record (re-)transmission for RACK [RFC8985 6.1]. */
 		if (__test_and_clear_bit(ix, &tq->segment_lost))
 			call->tx_nr_lost--;
 		if (req->retrans) {
 			__set_bit(ix, &tq->ever_retransmitted);
 			__set_bit(ix, &tq->segment_retransmitted);
-			call->tx_nr_resent++;
 		} else {
-			call->tx_nr_sent++;
 			start_tlp = true;
 		}
 		tq->segment_xmit_ts[ix] = xmit_ts;
@@ -603,8 +613,10 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
 	/* Set timeouts */
 	if (req->tlp_probe) {
 		/* Sending TLP loss probe [RFC8985 7.3]. */
-		call->tlp_serial = serial - 1;
-		call->tlp_seq = seq - 1;
+		call->tlp_serial	= serial - 1;
+		call->tlp_seq		= seq - 1;
+		call->tlp_xmit_ts	= req->now;
+		call->tlp_is_retrans	= req->retrans;
 	} else if (start_tlp) {
 		/* Schedule TLP loss probe [RFC8985 7.2]. */
 		ktime_t pto;

