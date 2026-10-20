Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527212;
	b=ffd+C7v3r/5lbGAaEMwXZ9N4hXWPzPlUxPiQzy+T2lF623UC7xA9lRLqtpcqlITUqGcU
	 eF9M5kIZg5WoI2swPkwnyqj7NaUrDTplaQIHCsa4mbyJM2f2H9gqogy1y4c+Hj2X5L0tt
	 ivzlb4XZk2Jc1JbqFa3AQTrMjbVlHtLsCJ6vC6r+YWz7Gr+3S6JJc30z73dVfu5hk0iW6
	 2aZF3oCgg5M8QiPNfhlNaV33bhLZihT0ordtSx3CVxESvb7nVSkGu6IsCCWv83izP5sJa
	 ak78c2YlTsS5xIoaHaYEW5pFaANGsuvUADtQbgHTDH5Tu6ZjLFA6eFL+AvVx+bgI7vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527212;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=hBhYthZqRlscXrqkBjbjANMc/u24jQ5CQJxeQEmIvKU=;
	b=0rJq+ryY74lqJ9MC3YQ0Ra+aahUtpNQP4huxGiYLBfgzD8ubPHf/pcah/ARUoNWxO4Xt
	 QZZgm5jE0rhTkgbC5LV7jMoHgjERj1/SvzkmB1U0Q6Lxvh8z0DDTo7DY1lmfUvHCci0Fb
	 /zgNdD5adqi96bszL98DSivZMpoZFPOaaxKqbpyoTZdl9QBDQ/gatzd/L0Lkw7PNgjOaZ
	 4sMHSBk993vzMsSWakn935Aslb2rD55l+MTwF+ImXeSEzVdQNHiqGJRYuV4b3dy+FnOCa
	 D6cotqqfPE3JBE1eooXzmvJVFdeu4khX8HqCOAEuN1fONOQL745jWc6eNEpcvTQX8fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpar+xsA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD39606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpar+xsA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBhYthZqRlscXrqkBjbjANMc/u24jQ5CQJxeQEmIvKU=;
	b=fpar+xsAoajBJfMwPO4XaeDLAfL+Ko/oN9ZRTJaBRMEqPtsXojv7gnqIRgUtoW4jt729H2
	FSHakUrDgG72xIGG3y3e8Lxw2nn60vsYlUqYfaUUcwjSdNlkB5Gn6rkfKUGDl1NWXhW22s
	nsWNQZQ7ySoKGbiERB0tkpn4gmb2lQI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-QIzxf3X0NBeMLI_cLSXbmQ-1; Tue,
 20 Oct 2026 20:13:25 +0000
X-MC-Unique: QIzxf3X0NBeMLI_cLSXbmQ-1
X-Mimecast-MFC-AGG-ID: QIzxf3X0NBeMLI_cLSXbmQ_1792527204
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40DDB1954126;
	Tue, 20 Oct 2026 20:13:24 +0000 (UTC)
Received: from warthog.com (unknown [10.44.48.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72EB51800495;
	Tue, 20 Oct 2026 20:13:20 +0000 (UTC)
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
Subject: [PATCH net v2 3/3] rxrpc: Fix RACK-TLP implementation
Date: Tue, 20 Oct 2026 21:12:54 +0100
Message-ID: <20261020201258.290827-4-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the RACK-TLP implementation in the following ways:

 (1) Move the "in/exiting Fast or RTO recovery" flags to the rxrpc_call
     struct rather than rxrpc_ack_summary so that they persist beyond ACK
     parsing to the next time rxrpc_congestion_management() happens (when
     the next ACK is parsed).  This allows those values to be accessed by
     RACK-TLP when invoked by the Reorder timer expiring.

 (2) In rxrpc_input_call_event(), rearm the RTO timer before the function
     returns if no other timer is running and if DATA packets have been
     sent but not yet ACK'd.  This prevents us not having a timer set to
     drive retransmission.

 (3) In rxrpc_congestion_management(), initialise the TLP state when
     entering the FAST_RETRANSMIT congestion control state, not every time
     we process that state - otherwise TLP doesn't happen in that state.

 (4) Don't reset segment_xmit_ts in rxrpc_rack_mark_lost() as that's called
     from two places, one of which shouldn't do that.  Instead, do it in
     rxrpc_rack_detect_loss().

 (5) In rxrpc_tlp_calc_pto(), check flight_size is at most one jumbo
     packet's worth of subpackets in size, not just any non-zero value
     (RFC8985 7.2 has a comparison against 1, so this is approximated
     because we'll be sending jumbo packets if possible).

 (6) In rxrpc_prepare_data_packet(), only increment call->tx_nr_resent if
     the DATA packet being retransmitted was not previously transmitted
     otherwise tx_nr_resent will keep getting bigger and cause RACK-TLP to
     malfunction (the value is used in the in-flight calculation).
     tx_nr_resent is decremented when a packet that has been retransmitted
     is discarded - but only by 1 per packet.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  2 +-
 net/rxrpc/call_event.c  | 13 +++++++++++++
 net/rxrpc/input.c       |  7 ++++---
 net/rxrpc/input_rack.c  |  6 +++---
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index d0e18eb6301e..d3b1b095192d 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -811,6 +811,7 @@ struct rxrpc_call {
 #define RXRPC_TX_SMSS		RXRPC_JUMBO_DATALEN
 #define RXRPC_MIN_CWND		4
 	enum rxrpc_ca_state	cong_ca_state;	/* Congestion control state */
+	bool			cong_in_recovery:1; /* If we're in Fast/RTO recovery */
 	u8			cong_extra;	/* Extra to send for congestion management */
 	u16			cong_cwnd;	/* Congestion window size */
 	u16			cong_ssthresh;	/* Slow-start threshold */
@@ -895,7 +896,6 @@ struct rxrpc_ack_summary {
 	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
 	bool		need_retransmit:1;	/* T if we need transmission */
 	bool		rtt_sample_avail:1;	/* T if RTT sample available */
-	bool		in_fast_or_rto_recovery:1;
 	bool		exiting_fast_or_rto_recovery:1;
 	bool		tlp_probe_acked:1;	/* T if the TLP probe seq was acked */
 	u8 /*enum rxrpc_congest_change*/ change;
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 21be9c86d7a7..f83db83df89d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -440,6 +440,19 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
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
+	}
+
 	/* Make sure the timer is restarted */
 	if (!__rxrpc_call_is_complete(call)) {
 		ktime_t next = READ_ONCE(call->expect_term_by), delay;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index f497eba59cf6..815749c7abeb 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -34,6 +34,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 {
 	summary->change = rxrpc_cong_no_change;
 	summary->in_flight = call->tx_in_flight;
+	call->cong_in_recovery = false;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
@@ -106,12 +107,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
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
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index e43ce032a261..1f6b51fa9721 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -30,7 +30,6 @@ static void rxrpc_rack_mark_lost(struct rxrpc_call *call,
 
 	if (__test_and_clear_bit(ix, &tq->in_flight))
 		call->tx_in_flight--;
-	tq->segment_xmit_ts[ix] = UINT_MAX;
 }
 
 /*
@@ -184,7 +183,7 @@ static ktime_t rxrpc_rack_update_reo_wnd(struct rxrpc_call *call,
 	}
 
 	if (!call->rack_reordering_seen) {
-		if (summary->in_fast_or_rto_recovery)
+		if (call->cong_in_recovery)
 			return 0;
 		if (call->acks_nr_sacks >= dup_thresh)
 			return 0;
@@ -230,6 +229,7 @@ static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
 				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
 				if (remaining <= 0) {
 					rxrpc_rack_mark_lost(call, tq, ix);
+					tq->segment_xmit_ts[ix] = UINT_MAX;
 					trace_rxrpc_rack_detect_loss(call, summary, seq);
 				} else {
 					timeout = max(remaining, timeout);
@@ -300,7 +300,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 	if (call->rtt_count > 0) {
 		/* Use 2*SRTT as the timeout. */
 		pto = ns_to_ktime(call->srtt_us * NSEC_PER_USEC / 4);
-		if (flight_size)
+		if (flight_size <= max(call->peer->pmtud_jumbo, 1))
 			pto = ktime_add(pto, call->tlp_max_ack_delay);
 	} else {
 		pto = NSEC_PER_SEC;

