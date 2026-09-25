Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C84E325E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363757; cv=none; b=e1bVZk4NKy/3A7+indLoU6Z12LKIC2btOCgzq+UV8pXPENTJkmOqaX+nOAYdRvJzJObKus0PuxX3gouWfWtWRBILr8Q3/tkNsXn5ik+TgmpmVBOxYLFTo2tROKFFo1oLJG9lHWp66COkGgA/9B8G6zk23MMc3wh3l+xbIlgXluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363757; c=relaxed/simple;
	bh=1iQYlNeb3MrVFHVuyqAHdMXtCaOZscTNUbEqzCORxQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kayrydpgurF7Z4bjVINhhwM7XCnTGUfp0MFnmPGOJyGj4p/9/Fci005X8iCTvSsouexycclig6hHPWXmpyHRFpV6cqgcegW4PfvD5lJubnQYigfLHPb03OQ0mdwT2Yby90jt0VLzEVWCvIdRTt/HyeUWRioSr8oizdVMJ/3wz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsspPzuB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsspPzuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790363752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2QYCor8/EHodqVrXWLpxAEHB8hZMJ7N24MS/yoFyvY=;
	b=XsspPzuBxQA3WtOxwaPEpNmcEkxnXFKzDgO5mHAnCmE9beu2lyE9uK5Sp2WrwlJgORMHEf
	rSk/DJ0QBAih3qaIzX/WWlghm6TN3sQgd2Do9e7pgUIQ/YCGURTc/TWbcOjFpyjVYu10rC
	jE5wLFvTHXIfCppNFNXYdJx61HhKzMU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-ZzFAzJ6IMKinhC4234EWzQ-1; Fri,
 25 Sep 2026 15:15:49 -0400
X-MC-Unique: ZzFAzJ6IMKinhC4234EWzQ-1
X-Mimecast-MFC-AGG-ID: ZzFAzJ6IMKinhC4234EWzQ_1790363747
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EF64195419F;
	Fri, 25 Sep 2026 19:15:47 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 420B11800473;
	Fri, 25 Sep 2026 19:15:43 +0000 (UTC)
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
Subject: [PATCH net 2/2] rxrpc: Fix RACK-TLP implementation
Date: Fri, 25 Sep 2026 20:15:19 +0100
Message-ID: <20260925191520.2206700-3-dhowells@redhat.com>
In-Reply-To: <20260925191520.2206700-1-dhowells@redhat.com>
References: <20260925191520.2206700-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 net/rxrpc/ar-internal.h |  4 ++--
 net/rxrpc/call_event.c  | 13 +++++++++++++
 net/rxrpc/input.c       | 10 ++++++----
 net/rxrpc/input_rack.c  |  8 ++++----
 net/rxrpc/output.c      |  4 ++--
 5 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index f0c8cbcc5dd5..9c7b2e0817e7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -818,6 +818,8 @@ struct rxrpc_call {
 	u16			cong_dup_acks;	/* Count of ACKs showing missing packets */
 	u16			cong_cumul_acks; /* Cumulative ACK count */
 	ktime_t			cong_tstamp;	/* Last time cwnd was changed */
+	bool			cong_in_recovery:1;		/* If we're in Fast/RTO recovery */
+	bool			cong_exiting_recovery:1;	/* If we're leaving Fast/RTO recovery */
 
 	/* RACK-TLP [RFC8985] state. */
 	ktime_t			rack_xmit_ts;	/* Latest transmission timestamp */
@@ -896,8 +898,6 @@ struct rxrpc_ack_summary {
 	bool		retrans_timeo:1;	/* T if reTx due to timeout happened */
 	bool		need_retransmit:1;	/* T if we need transmission */
 	bool		rtt_sample_avail:1;	/* T if RTT sample available */
-	bool		in_fast_or_rto_recovery:1;
-	bool		exiting_fast_or_rto_recovery:1;
 	bool		tlp_probe_acked:1;	/* T if the TLP probe seq was acked */
 	u8 /*enum rxrpc_congest_change*/ change;
 };
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 21be9c86d7a7..07e9aac42163 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -440,6 +440,19 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 				       rxrpc_propose_ack_input_data);
 	}
 
+	/* Need to rearm the RTO timer if we don't start the TLP-PTO
+	 * timer [RFC8985 7.3].
+	 */
+	if (call->rack_timer_mode == RXRPC_CALL_RACKTIMER_OFF &&
+	    rxrpc_tx_in_flight(call) > 0) {
+		ktime_t rto = rxrpc_get_rto_backoff(call, true);
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
index 73cafe6bfa9f..0e9f6a1e9f00 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -34,6 +34,8 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 {
 	summary->change = rxrpc_cong_no_change;
 	summary->in_flight = rxrpc_tx_in_flight(call);
+	call->cong_in_recovery = false;
+	call->cong_exiting_recovery = false;
 
 	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
 		summary->retrans_timeo = true;
@@ -106,12 +108,12 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
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
@@ -125,7 +127,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 			summary->change = rxrpc_cong_progress;
 			call->cong_cwnd = call->cong_ssthresh;
 			if (call->acks_nr_snacks == 0) {
-				summary->exiting_fast_or_rto_recovery = true;
+				call->cong_exiting_recovery = true;
 				goto resume_normality;
 			}
 		}
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 072e1d9ecb2e..66ef2fc6d3d9 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -29,7 +29,6 @@ static void rxrpc_rack_mark_lost(struct rxrpc_call *call,
 	} else {
 		call->tx_nr_lost++;
 	}
-	tq->segment_xmit_ts[ix] = UINT_MAX;
 }
 
 /*
@@ -174,14 +173,14 @@ static ktime_t rxrpc_rack_update_reo_wnd(struct rxrpc_call *call,
 		call->rack_dsack_round = snd_nxt;
 		call->rack_reo_wnd_mult++;
 		call->rack_reo_wnd_persist = 16;
-	} else if (summary->exiting_fast_or_rto_recovery) {
+	} else if (call->cong_exiting_recovery) {
 		call->rack_reo_wnd_persist--;
 		if (call->rack_reo_wnd_persist <= 0)
 			call->rack_reo_wnd_mult = 1;
 	}
 
 	if (!call->rack_reordering_seen) {
-		if (summary->in_fast_or_rto_recovery)
+		if (call->cong_in_recovery)
 			return 0;
 		if (call->acks_nr_sacks >= dup_thresh)
 			return 0;
@@ -227,6 +226,7 @@ static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
 				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
 				if (remaining <= 0) {
 					rxrpc_rack_mark_lost(call, tq, ix);
+					tq->segment_xmit_ts[ix] = UINT_MAX;
 					trace_rxrpc_rack_detect_loss(call, summary, seq);
 				} else {
 					timeout = max(remaining, timeout);
@@ -297,7 +297,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 	if (call->rtt_count > 0) {
 		/* Use 2*SRTT as the timeout. */
 		pto = ns_to_ktime(call->srtt_us * NSEC_PER_USEC / 4);
-		if (flight_size)
+		if (flight_size <= call->peer->pmtud_jumbo)
 			pto = ktime_add(pto, call->tlp_max_ack_delay);
 	} else {
 		pto = NSEC_PER_SEC;
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 88cad087f13b..9e082f740331 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -576,8 +576,8 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call,
 			call->tx_nr_lost--;
 		if (req->retrans) {
 			__set_bit(ix, &tq->ever_retransmitted);
-			__set_bit(ix, &tq->segment_retransmitted);
-			call->tx_nr_resent++;
+			if (!__test_and_set_bit(ix, &tq->segment_retransmitted))
+				call->tx_nr_resent++;
 		} else {
 			call->tx_nr_sent++;
 			start_tlp = true;

