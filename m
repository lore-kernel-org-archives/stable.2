Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536827;
	b=5e1v7JKdnpjXKRsY0D8Bcx96pRqirVn7mGyttJ/Rbp+PZpi1seTeTZSfkEu3t4RKVTlr
	 PwL2xL0VdZxbEJBp3rGt7U+WaONhgp84wT5HPqz25tlCZnYi6fbv8gSeizr2NDc1Dx7t5
	 Kf+OpatrlcZjWXv6Ve0TUjnf11+owcG11cBSu4G4Gq2MGbcGS6XabnMziZlLVIuO6AzBv
	 GIuIlpBGuPsIC8wj9Fz6zQZqzlaUm7+36gwiKYFC89dkg0UyHDj+aGAleGneM/2ERQUWr
	 BLUWjDXOpVIIU0l95Sp8lf+Y3dI6S6qjO/ksw71ME7d7nw/wSINWlwmOYxkuCsq76Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536827;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Op9mG2o1C7sy88P4/c3HBUd3hjEC7DLxBGS54NsLWEA=;
	b=qPdGRMn90sLmZWGEpJGIAMP5cVOj2wsBAXPGWJE3zKVnFhvRi0VW6pl229nv66JkNnYE
	 JS/VsRZLHYtjA0E37GPMoEcFsmih32EkcwJ3tq3iPGsBeIWxVRfV0esGyCNi1MRxAojDI
	 Q/wSYmrcz6h7oyYSCvwjEjyWBqNCC1JccC8lMFT0nyvyPdNyFatA+6/jj8MfjsZgRqw8Y
	 du3f884vaJpSerDlKTzKLEsBxyz+iwY3PWGAJUP4H7YjbElQNv2Nkgy7k0Sedog106DtY
	 fV8LLD1afn7hZR2egMI6RsAFqwdjkn7Aq1dhpsLGnFUT6P+r+fw8lwyv6Ju2Sp9AGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=in13iLNC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76066606A338
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76066606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=in13iLNC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Op9mG2o1C7sy88P4/c3HBUd3hjEC7DLxBGS54NsLWEA=;
	b=in13iLNC/82lh5UdlABS9o6i7afBR8LZHW0uMgs3yrH8WINMtO+wj37ff0d2ww+l6ZjJro
	KhmXI12nM6ZfwEk2AksqUX8mBHh7da74kGrIHf0GrgSjClEySnceCuRsEUxsLCsA/jgBKT
	469FbiJeVMdJO9iYDTYnVUgONRUJCJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-YxTFUkE2M-Cs-vrkTBfviw-1; Tue,
 24 Nov 2026 16:13:42 +0000
X-MC-Unique: YxTFUkE2M-Cs-vrkTBfviw-1
X-Mimecast-MFC-AGG-ID: YxTFUkE2M-Cs-vrkTBfviw_1795536819
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 881511955F1F;
	Tue, 24 Nov 2026 16:13:39 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBA6218011D4;
	Tue, 24 Nov 2026 16:13:35 +0000 (UTC)
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
Subject: [PATCH net v3 06/10] rxrpc: Fix lost driving of congestion management retransmission timeout
Date: Tue, 24 Nov 2026 16:12:54 +0000
Message-ID: <20261124161302.4044422-7-dhowells@redhat.com>
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

The implementation of RACK-TLP in AF_RXRPC lost the part that sets
RXRPC_CALL_RETRANS_TIMEOUT when the retransmission timeout expired (and if
there were unacked packets).

Fix this by moving the currently-unused congestion timeout code to its own
function and then calling it from the RTO handling function.
RXRPC_CALL_RETRANS_TIMEOUT is then repurposed to convey that this happened
in the rxrpc_congest tracepoint.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
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
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/input.c       | 27 +++++++++++++++++----------
 net/rxrpc/input_rack.c  |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index d88dd02b6ab5..6e9fc996cd92 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1243,6 +1243,7 @@ void rxrpc_unpublish_service_conn(struct rxrpc_connection *);
  * input.c
  */
 void rxrpc_congestion_degrade(struct rxrpc_call *);
+void rxrpc_congestion_timeout(struct rxrpc_call *call);
 void rxrpc_input_call_packet(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_implicit_end_call(struct rxrpc_call *, struct sk_buff *);
 
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9b02e36264aa..63a0feae2081 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -35,17 +35,8 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	summary->change = rxrpc_cong_no_change;
 	summary->in_flight = rxrpc_tx_in_flight(call);
 
-	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
+	if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags))
 		summary->retrans_timeo = true;
-		call->cong_ssthresh = umax(summary->in_flight / 2, 2);
-		call->cong_cwnd = 1;
-		if (call->cong_cwnd >= call->cong_ssthresh &&
-		    call->cong_ca_state == RXRPC_CA_SLOW_START) {
-			call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
-			call->cong_tstamp = call->acks_latest_ts;
-			call->cong_cumul_acks = 0;
-		}
-	}
 
 	call->cong_cumul_acks += summary->nr_new_sacks;
 	call->cong_cumul_acks += summary->nr_new_hacks;
@@ -199,6 +190,22 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	call->cong_cwnd = umax(call->cong_cwnd / 2, RXRPC_MIN_CWND);
 }
 
+/*
+ * Handle congestion being detected by the retransmit timeout.
+ */
+void rxrpc_congestion_timeout(struct rxrpc_call *call)
+{
+	set_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags);
+	call->cong_ssthresh = umax(rxrpc_tx_in_flight(call) / 2, 2);
+	call->cong_cwnd = 1;
+	if (call->cong_cwnd >= call->cong_ssthresh &&
+	    call->cong_ca_state == RXRPC_CA_SLOW_START) {
+		call->cong_ca_state = RXRPC_CA_CONGEST_AVOIDANCE;
+		call->cong_tstamp = call->acks_latest_ts;
+		call->cong_cumul_acks = 0;
+	}
+}
+
 /*
  * Add an RTT sample derived from an ACK'd DATA packet.
  */
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index e5288e5beb59..c652451cc9b5 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -420,7 +420,7 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
 		rxrpc_tlp_send_probe(call);
 		break;
 	case RXRPC_CALL_RACKTIMER_RTO:
-		// Might need to poke the congestion algo in some way
+		rxrpc_congestion_timeout(call);
 		rxrpc_rack_mark_losses_on_rto(call);
 		break;
 	//case RXRPC_CALL_RACKTIMER_ZEROWIN:

