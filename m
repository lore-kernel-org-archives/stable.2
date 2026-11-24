Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536846;
	b=YmiiqkuOOTMeDc17eKk2L4DIxf3qSlykmGoRm4YVTRYOQf5BIP7Dj0Rz4NF4hLVKs1gb
	 U2neGSHns+E0NcONW2u9bf0sX8U4ac/EeychMyZQj8avvW9exKyDWs8MwNc2dKFmP3va4
	 YKUAyj8fYVpCyBNCPjxFX232R79Y4g5HZBluII3UbaZd6kJ+xEcIUWJ+D939/p0g5kCi0
	 dR5bt6ea2Q3zgsUX+0SijGHgs9KWhh6VAOb6lU0FEqMBba9G+bwYhGzm2cy8vhzcxxMC/
	 19WiM1bvcvbqbuxYTha4y8kLyBQr2xwVz2PgYGUbLIYR6VatvP5F3UbqhK66b3StXBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536846;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=XAU8hIyCdHjxNoq80dW172OlDTbuwZf51aoQ3MrXrlw=;
	b=OZMXX5CWZN90vpRGrmtdiQZFILysOgReHSJMceRSexqf8z+Bqbj5tFNkpmdjvhW+YrDU
	 BY8sJRQThW2/YJA1l43NHkKrv9G0UA4rhdd0eQZManWlhUPTxX9LLdc0X+26rNy9OWMP8
	 lmjEfZR8XJdx7OsEYUKuG+C42cNBz4f9LyuIMART4lTSLFKnlOU3Nsvygm28n3TP+ibjZ
	 XwyWQF9E+qpjBTrYe/X6y2MHkVwPyAiEADTAbVhPZzeJYR+VpdaBnigHMaj7Lkc9cnD4f
	 YUKXTGu0iVChgE3CS3t5TeU8ev/JCuGwJPYApUfv/BQz56LcIxMN9RFe4wvxtM6fVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPAYiLGQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208E606A334
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3208E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QPAYiLGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAU8hIyCdHjxNoq80dW172OlDTbuwZf51aoQ3MrXrlw=;
	b=QPAYiLGQZu36JMwKPdr1nYmpYSvN4G9M9HrhA7V5DFcZlracAeTlLhfDiUQMphjswR0WCd
	YXgRLEtX5pk8hIdHtiCH/2SpvctqqjsGsd3uT1Yb8LyCehgaxhVEgpl5eNyEaVbEH7SfVg
	FYq5j1QVc/eBmwa8j+ySvcmSR35Uz6Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-A0VBYSHrPWGuUUqaqtBxmg-1; Tue,
 24 Nov 2026 16:14:00 +0000
X-MC-Unique: A0VBYSHrPWGuUUqaqtBxmg-1
X-Mimecast-MFC-AGG-ID: A0VBYSHrPWGuUUqaqtBxmg_1795536834
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FE371802560;
	Tue, 24 Nov 2026 16:13:54 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5607436;
	Tue, 24 Nov 2026 16:13:51 +0000 (UTC)
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
Subject: [PATCH net v3 10/10] rxrpc: Fix RACK-TLP implementation
Date: Tue, 24 Nov 2026 16:12:58 +0000
Message-ID: <20261124161302.4044422-11-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fix the RACK-TLP implementation in the following ways:

 (1) Move the "in Fast or RTO recovery" flag to the rxrpc_call struct
     rather than rxrpc_ack_summary so that it persists beyond ACK parsing
     to the next time rxrpc_congestion_management() happens (when the next
     ACK is parsed).  This allows that value to be accessed by RACK-TLP
     when invoked by the Reorder timer expiring.

 (2) In rxrpc_input_call_event(), rearm the RTO timer before the function
     returns if no other timer is running and if DATA packets have been
     sent but not yet ACK'd.  This prevents us not having a timer set to
     drive retransmission.

     Further, update the RTO timer after new data has been ACK'd if the RTO
     timer was running before the ACK was processed (but not if it has just
     been started by the TLP probe dispatch as that set the timer for
     itself).

 (3) In rxrpc_congestion_management(), initialise the TLP state when
     entering the FAST_RETRANSMIT congestion control state, not every time
     we process that state.

 (4) Don't reset segment_xmit_ts in rxrpc_rack_mark_lost() as that's called
     from three places, one of which shouldn't do that.  Instead, do it in
     the calling function as appropriate.

 (5) In rxrpc_tlp_calc_pto(), check flight_size is at most one jumbo
     packet's worth of subpackets in size, not just any non-zero value
     (RFC8985 7.2 has a comparison against 1, so this is approximated
     because we'll be sending jumbo packets if possible).

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
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
 net/rxrpc/ar-internal.h |  4 ++-
 net/rxrpc/call_event.c  | 22 ++++++++++++++++-
 net/rxrpc/input.c       | 10 +++++---
 net/rxrpc/input_rack.c  | 54 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c0cb1c7e6680..37e649f96efd 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -653,6 +653,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_RX_IS_IDLE,		/* recvmsg() is idle - send an ACK */
 	RXRPC_CALL_RECVMSG_READ_ALL,	/* recvmsg() read all of the received data */
 	RXRPC_CALL_CONN_CHALLENGING,	/* The connection is being challenged */
+	RXRPC_CALL_NEW_DATA_ACKED,	/* New data has been ACK'd */
 };
 
 /*
@@ -810,6 +811,7 @@ struct rxrpc_call {
 #define RXRPC_TX_SMSS		RXRPC_JUMBO_DATALEN
 #define RXRPC_MIN_CWND		4
 	enum rxrpc_ca_state	cong_ca_state;	/* Congestion control state */
+	bool			cong_in_recovery; /* If we're in Fast retransmit recovery */
 	u8			cong_extra;	/* Extra to send for congestion management */
 	u16			cong_cwnd;	/* Congestion window size */
 	u16			cong_ssthresh;	/* Slow-start threshold */
@@ -896,7 +898,6 @@ struct rxrpc_ack_summary {
 	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
 	bool		need_retransmit:1;	/* T if we need transmission */
 	bool		rtt_sample_avail:1;	/* T if RTT sample available */
-	bool		in_fast_or_rto_recovery:1;
 	bool		exiting_fast_or_rto_recovery:1;
 	bool		tlp_probe_acked:1;	/* T if the TLP probe seq was acked */
 	u8 /*enum rxrpc_congest_change*/ change;
@@ -1266,6 +1267,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now);
 void rxrpc_tlp_send_probe(struct rxrpc_call *call);
 void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary);
 void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by);
+void rxrpc_update_rack_rto_timer(struct rxrpc_call *call);
 
 static inline void rxrpc_tlp_end_probe(struct rxrpc_call *call)
 {
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 62e15b03c9c2..2b3bd5355a02 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -312,7 +312,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 {
 	struct sk_buff *skb;
 	ktime_t now, t;
-	bool did_receive = false, saw_ack = false;
+	bool did_receive = false, saw_ack = false, in_rto = false;
 	s32 abort_code;
 
 	rxrpc_see_call(call, rxrpc_call_see_input);
@@ -330,6 +330,8 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 		goto out;
 	}
 
+	clear_bit(RXRPC_CALL_NEW_DATA_ACKED, &call->flags);
+	in_rto = call->rack_timer_mode == RXRPC_CALL_RACKTIMER_RTO;
 	do {
 		skb = __skb_dequeue(&call->rx_queue);
 		if (skb) {
@@ -448,6 +450,24 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 				       rxrpc_propose_ack_input_data);
 	}
 
+	/* Need to rearm the RTO timer if we don't start the TLP-PTO
+	 * timer [RFC8985 7.3].
+	 */
+	if (call->rack_timer_mode == RXRPC_CALL_RACKTIMER_OFF &&
+	    call->tx_in_flight > 0) {
+		ktime_t rto = rxrpc_get_rto_backoff(call, false);
+
+		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
+		call->rack_timo_at = ktime_add(ktime_get_real(), rto);
+		trace_rxrpc_rack_timer(call, rto, false);
+		trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);
+	} else if (call->rack_timer_mode == RXRPC_CALL_RACKTIMER_RTO &&
+		   test_bit(RXRPC_CALL_NEW_DATA_ACKED, &call->flags) &&
+		   in_rto) {
+		/* Update the RTO timer if we saw an ACK. */
+		rxrpc_update_rack_rto_timer(call);
+	}
+
 	/* Make sure the timer is restarted */
 	if (!__rxrpc_call_is_complete(call)) {
 		ktime_t next = READ_ONCE(call->expect_term_by), delay;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 66be37f21410..aa3af5a10c01 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -34,6 +34,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 {
 	summary->change = rxrpc_cong_no_change;
 	summary->in_flight = call->tx_in_flight;
+	call->cong_in_recovery = false;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags))
 		summary->retrans_timeo = true;
@@ -97,12 +98,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		call->cong_extra = 0;
 		call->cong_dup_acks = 0;
 		summary->need_retransmit = true;
-		summary->in_fast_or_rto_recovery = true;
+		call->cong_in_recovery = true;
+		rxrpc_tlp_init(call);
 		goto out;
 
 	case RXRPC_CA_FAST_RETRANSMIT:
-		rxrpc_tlp_init(call);
-		summary->in_fast_or_rto_recovery = true;
+		call->cong_in_recovery = true;
 		if (!summary->new_low_snack) {
 			if (summary->nr_new_sacks == 0)
 				call->cong_cwnd += 1;
@@ -1217,6 +1218,9 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_input_soft_acks(call, &summary, skb);
 	}
 
+	if (summary.nr_new_hacks || summary.nr_new_sacks)
+		set_bit(RXRPC_CALL_NEW_DATA_ACKED, &call->flags);
+
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) &&
 	    call->acks_nr_sacks == call->tx_top - hard_ack &&
 	    rxrpc_is_client_call(call))
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 240362109a3b..473046562b0b 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -30,7 +30,6 @@ static void rxrpc_rack_mark_lost(struct rxrpc_call *call,
 
 	if (__test_and_clear_bit(ix, &tq->in_flight))
 		call->tx_in_flight--;
-	tq->segment_xmit_ts[ix] = UINT_MAX;
 }
 
 /*
@@ -146,6 +145,7 @@ void rxrpc_input_rack(struct rxrpc_call *call,
 
 		__clear_bit(ix, &reneged_acks);
 		rxrpc_rack_mark_lost(call, tq, ix);
+		tq->segment_xmit_ts[ix] = UINT_MAX;
 	}
 
 	while (new_acks) {
@@ -197,7 +197,7 @@ static ktime_t rxrpc_rack_update_reo_wnd(struct rxrpc_call *call,
 	}
 
 	if (!call->rack_reordering_seen) {
-		if (summary->in_fast_or_rto_recovery)
+		if (call->cong_in_recovery)
 			return 0;
 		if (call->acks_nr_sacks >= dup_thresh)
 			return 0;
@@ -243,6 +243,7 @@ static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
 				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
 				if (remaining <= 0) {
 					rxrpc_rack_mark_lost(call, tq, ix);
+					tq->segment_xmit_ts[ix] = UINT_MAX;
 					trace_rxrpc_rack_detect_loss(call, summary, seq);
 				} else {
 					timeout = max(remaining, timeout);
@@ -313,7 +314,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 	if (call->rtt_count > 0) {
 		/* Use 2*SRTT as the timeout. */
 		pto = ns_to_ktime((u64)call->srtt_us * (NSEC_PER_USEC / 4));
-		if (flight_size)
+		if (flight_size <= max(call->peer->pmtud_jumbo, 1))
 			pto = ktime_add(pto, call->tlp_max_ack_delay);
 	} else {
 		pto = NSEC_PER_SEC;
@@ -446,3 +447,50 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
 		pr_warn("Unexpected rack timer %u", mode);
 	}
 }
+
+/*
+ * Update the RACK RTO timer after new data is ACK'd.
+ */
+void rxrpc_update_rack_rto_timer(struct rxrpc_call *call)
+{
+	struct rxrpc_txqueue *tq;
+	ktime_t earliest = KTIME_MAX, rto;
+
+	if (!call->tx_in_flight)
+		return;
+
+	for (tq = call->tx_queue; tq; tq = tq->next) {
+		unsigned long nacks = ~tq->segment_acked;
+		int nr_sent;
+
+		if (after(tq->qbase, call->tx_transmitted))
+			break;
+
+		nr_sent = (call->tx_transmitted - tq->qbase) + 1;
+		if (nr_sent < RXRPC_NR_TXQUEUE)
+			nacks &= (1UL << nr_sent) - 1;
+
+		while (nacks) {
+			unsigned int ix = __ffs(nacks);
+			ktime_t xmit_ts;
+
+			__clear_bit(ix, &nacks);
+
+			if (tq->segment_xmit_ts[ix] != UINT_MAX) {
+				xmit_ts = rxrpc_get_xmit_ts(tq, ix);
+				if (ktime_before(xmit_ts, earliest))
+					earliest = xmit_ts;
+			}
+		}
+	}
+
+	if (earliest != KTIME_MAX) {
+		rto = ktime_add(earliest, rxrpc_get_rto_backoff(call, false));
+		if (ktime_after(rto, call->rack_timo_at)) {
+			call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;
+			call->rack_timo_at = rto;
+			trace_rxrpc_rack_timer(call, rto, false);
+			trace_rxrpc_timer_set(call, rto, rxrpc_timer_trace_rack_rto);
+		}
+	}
+}

