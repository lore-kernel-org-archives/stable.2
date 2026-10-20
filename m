Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527213;
	b=oEhLUW3DwjlLbqgg5kXJwv0A74bYFDfcdeaq2mFVKdANIFOhZ8iciEAlt8wq1lm9nh1C
	 Qn5QEY7h/xnmWOLuoXWaGF4pE96HtJV+cP0NY7DOOLCezO+HxzqcAFndtGrX0ILl3I0Wk
	 PA62UgWq262rZgU6RbI1bZa4aeG3fNBy+Gg9w1HJPi+inmXYHxTe6MRth/6owTeCuIU8L
	 QzJ1dAL0FqKhHT/3aF/k0OH/kHjxtIJaKoRMjB6rcHEHldnJboN6OCj7cydXX602U+E8Z
	 ovGnqf2oiAs4+PPYBTzOYF1QjU0Afs4fRkDs28AOdjO7fNQcnbAseMx9AdqC7CsCeKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527213;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=iF/2g8ezmRgNpkHpQC85116K3p+NIblnBxlCe9zwHwA=;
	b=rESvCBhR/ZvOOkzet8zgjgYzZ8vxczTJ56/fyg4S8w4AFGBBHpZe1SNfZ9rFxHEWc2xM
	 pRrbYx6zPBTc+nZYYpRyLYbr4LFrp/wJhA2Oa0EMrTXahHSZVTVCIJtOJiHJUarSUj3Hw
	 eN4lgZ0kh5EKTwWx6yYeT2Vgsg/S84YVvydkcKYHdsukYvmXPo0LX7PMd6QUU7ZPxPKyX
	 FMXtbhvcPF28mbZwsb0g72IOgqJOnDJNb26OSZHwbd/V9RVT3usV/NOqZPLKgPoW8vAqi
	 s/SPsTZ9yWYxD3fxlMBBSK4sYx5nwRhYhnymuMK6M0Gq1uUmeEQ7uuvUBgx+nr4Akjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BP17Wisa;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62498606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62498606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BP17Wisa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iF/2g8ezmRgNpkHpQC85116K3p+NIblnBxlCe9zwHwA=;
	b=BP17WisafRVxQoeCGYB7OHT1HHkgVbg9HlQSOD+FqLnxKElmVepI1bFWECOGwolrq2YikW
	zUG08KMf9DSmWnaBPmYuFiH5A0B1J2ru0grxczjtuoIyxRtl7k0R7BUVstATneYBPDmh8C
	z7Weaz+M+U/7Gldf0mnwwyuEFNsqKdc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-AG6VDaP-MuaY6qqQwcB3AA-1; Tue,
 20 Oct 2026 20:13:21 +0000
X-MC-Unique: AG6VDaP-MuaY6qqQwcB3AA-1
X-Mimecast-MFC-AGG-ID: AG6VDaP-MuaY6qqQwcB3AA_1792527199
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB91C1955F6E;
	Tue, 20 Oct 2026 20:13:18 +0000 (UTC)
Received: from warthog.com (unknown [10.44.48.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 008D7195608B;
	Tue, 20 Oct 2026 20:13:14 +0000 (UTC)
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
Subject: [PATCH net v2 2/3] rxrpc: Fix counting of in-flight transmitted packets
Date: Tue, 20 Oct 2026 21:12:53 +0100
Message-ID: <20261020201258.290827-3-dhowells@redhat.com>
In-Reply-To: <20261020201258.290827-1-dhowells@redhat.com>
References: <20261020201258.290827-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

The value in tx_in_flight is then used instead of the approximation.

The tx_nr_sent and tx_nr_resent counters are then removed and the
rxrpc_rack tracepoint updated.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com
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
 include/trace/events/rxrpc.h | 11 ++++-------
 net/rxrpc/ar-internal.h      | 18 ++----------------
 net/rxrpc/input.c            |  8 ++++----
 net/rxrpc/input_rack.c       | 19 +++++++++++--------
 net/rxrpc/output.c           |  5 +++--
 5 files changed, 24 insertions(+), 37 deletions(-)

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
index f0c8cbcc5dd5..d0e18eb6301e 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -782,9 +782,8 @@ struct rxrpc_call {
 	rxrpc_seq_t		tx_top;		/* Highest Tx slot allocated. */
 	rxrpc_serial_t		tx_last_serial;	/* Serial of last DATA transmitted */
 	u16			tx_backoff;	/* Delay to insert due to Tx failure (ms) */
-	u16			tx_nr_sent;	/* Number of packets sent, but unacked */
+	u16			tx_in_flight;	/* Number of packets considered "in flight" */
 	u16			tx_nr_lost;	/* Number of packets marked lost */
-	u16			tx_nr_resent;	/* Number of packets resent, but unacked */
 	u16			tx_winsize;	/* Maximum size of Tx window */
 #define RXRPC_TX_MAX_WINDOW	128
 	u8			tx_jumbo_max;	/* Maximum subpkts peer will accept */
@@ -980,6 +979,7 @@ struct rxrpc_txqueue {
 	unsigned long		segment_acked;	/* Bit-per-buf: Set if ACK'd */
 	unsigned long		segment_lost;	/* Bit-per-buf: Set if declared lost */
 	unsigned long		segment_retransmitted; /* Bit-per-buf: Set if retransmitted */
+	unsigned long		in_flight;	/* Bit-per-buf: Set if "in flight" */
 	unsigned long		rtt_samples;	/* Bit-per-buf: Set if available for RTT */
 	unsigned long		ever_retransmitted; /* Bit-per-buf: Set if ever retransmitted */
 
@@ -1601,20 +1601,6 @@ static inline unsigned int rxrpc_tx_window_space(const struct rxrpc_call *call)
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
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 73cafe6bfa9f..f497eba59cf6 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -33,7 +33,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 					struct rxrpc_ack_summary *summary)
 {
 	summary->change = rxrpc_cong_no_change;
-	summary->in_flight = rxrpc_tx_in_flight(call);
+	summary->in_flight = call->tx_in_flight;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
@@ -288,11 +288,11 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
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
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 072e1d9ecb2e..e43ce032a261 100644
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
 
@@ -136,6 +137,8 @@ void rxrpc_input_rack(struct rxrpc_call *call,
 		unsigned int ix = __ffs(new_acks);
 
 		__clear_bit(ix, &new_acks);
+		if (__test_and_clear_bit(ix, &tq->in_flight))
+			call->tx_in_flight--;
 		rxrpc_input_rack_one(call, summary, tq, ix);
 	}
 
@@ -289,7 +292,7 @@ static void rxrpc_rack_mark_losses_on_rto(struct rxrpc_call *call)
  */
 ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 {
-	unsigned int flight_size = rxrpc_tx_in_flight(call);
+	unsigned int flight_size = call->tx_in_flight;
 	ktime_t rto_at = ktime_add(call->tx_last_sent,
 				   rxrpc_get_rto_backoff(call, false));
 	ktime_t pto;
@@ -313,7 +316,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
  */
 void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 {
-	unsigned int in_flight = rxrpc_tx_in_flight(call);
+	unsigned int in_flight = call->tx_in_flight;
 
 	if (after_eq(call->acks_hard_ack, call->tx_transmitted))
 		return; /* Everything we transmitted has been acked. */
@@ -333,7 +336,7 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 			call->tlp_serial = call->tx_last_serial;
 			call->tlp_seq = call->tx_transmitted;
 			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_transmit_new);
-			in_flight = rxrpc_tx_in_flight(call);
+			in_flight = call->tx_in_flight;
 		} else {
 			/* Retransmit the highest-sequence DATA sent */
 			call->tx_last_serial = 0;
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 88cad087f13b..3ccd9a27643a 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -571,15 +571,16 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
 
 		_debug("prep[%u] tq=%x q=%x", i, tq->qbase, seq);
 
+		if (!__test_and_set_bit(ix, &tq->in_flight))
+			call->tx_in_flight++;
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

