Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536837;
	b=M466/WmPoG9ESFNtaeIZRbPhlRBiUmeknFn6XR9PjhqIEq5BoV6tkfEHI9cNA1NeTcHJ
	 pV/N4ax2VAd1cc5AC4Iaf2giyVt90jvdekrMMIbfrDIpOBn2hLoT5qwG49M0tKv1j/aDe
	 VUWUHNsr7zaqcA3vYiN6FiDMPK62qdBzZpzwrKT4IuTbVpQwqHAAJwvocydvuNQYlSRhN
	 Gx15a08Fv7DHV9fmBBXwcJz200czRre5CXc834Y5rrzE1xz9wfQPqIM3QtEoNubvLeO2z
	 +yAwnLebwzAEL5UuaaR5gJxXxksv7hyiGFx0thvz1gcBG9MjERLxWV6/et4+YUaQX4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536837;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=6h5fzNfvD85tDkj6v+K1YGNMtaaJfEGYj2fkFDGYDMw=;
	b=npLRdYRZDws8PXbKcLDSpUXcviDm1dZQpnvX7PDojLWZhaCTGIt1XC54eYdhMhxd/zdK
	 xBOyU38IkcPFE2DmjZ6gH9i7OpkNaJWyStPy3MuxA09Yv0MYhe6pGr75bI8W/yuaGRK5U
	 ODvKyIWmWZI5gtcqPFUYb0/0GWQqWLLx1V8cbcvv4S/eq8gxx42rInOE6MOwneWlER4fs
	 KtCS7TD150E/ficHwLO5PQesmGco3TwUDC5JAUZWdVTYI/1AhsVdOITriMHDpLHG498I9
	 LKynMYII7VfO5xsZjOFlw25Q1dRwh2jWtnJ3YQHLOZXaXtQZokrrEo50C959z5snyTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=afYXOYWe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDC606A33A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54DDC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=afYXOYWe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h5fzNfvD85tDkj6v+K1YGNMtaaJfEGYj2fkFDGYDMw=;
	b=afYXOYWeZVHd5tiAc2V51AgMT+zdeez4fZDZQykFg3Xw2HApCvpDCst0EEse5Jtq2RJK9+
	/AizFuemA0R2QXIbpU0VvT5enitgkgQb2yZlssBbnIk5DXbub8ALJXTllAb5MdfClBJAFm
	++2nyq+B7G1HQmwo2yOrJZGM5OqfIxk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-eH2ykTRCMoelxTW0vHB4iA-1; Tue,
 24 Nov 2026 16:13:48 +0000
X-MC-Unique: eH2ykTRCMoelxTW0vHB4iA-1
X-Mimecast-MFC-AGG-ID: eH2ykTRCMoelxTW0vHB4iA_1795536826
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCAE2195608C;
	Tue, 24 Nov 2026 16:13:46 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61C051800543;
	Tue, 24 Nov 2026 16:13:44 +0000 (UTC)
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
Subject: [PATCH net v3 08/10] rxrpc: Fix detection of TLP probe response
Date: Tue, 24 Nov 2026 16:12:56 +0000
Message-ID: <20261124161302.4044422-9-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix detection of the TLP probe response to include a check that
->tlp_serial is valid, otherwise it's possible to see an ACK of a packet
that matches an old value of ->tlp_seq as a probe response.

Also make sure that we check to see if an ACK is a TLP probe response -
even if we would otherwise discard it as being out of order.

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
 net/rxrpc/input.c      | 21 +++++++++++++++------
 net/rxrpc/input_rack.c |  5 +++--
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 63a0feae2081..d01a8d95dc6d 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -275,7 +275,8 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			/* Packet directly hard ACK'd. */
 			tq->nr_reported_acks++;
 			rxrpc_input_rack_one(call, summary, tq, ix);
-			if (seq == call->tlp_seq)
+			if (call->tlp_serial &&
+			    seq == call->tlp_seq)
 				summary->tlp_probe_acked = true;
 			summary->nr_new_hacks++;
 			__set_bit(ix, &tq->segment_acked);
@@ -288,7 +289,8 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 			/* Soft NAK -> hard ACK. */
 			call->acks_nr_snacks--;
 			rxrpc_input_rack_one(call, summary, tq, ix);
-			if (seq == call->tlp_seq)
+			if (call->tlp_serial &&
+			    seq == call->tlp_seq)
 				summary->tlp_probe_acked = true;
 			summary->nr_new_hacks++;
 			__set_bit(ix, &tq->segment_acked);
@@ -1139,7 +1141,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	/* Discard any out-of-order or duplicate ACKs (outside lock). */
 	if (!rxrpc_is_ack_valid(call, hard_ack, prev_pkt)) {
 		trace_rxrpc_rx_discard_ack(call, summary.ack_serial, hard_ack, prev_pkt);
-		goto send_response; /* Still respond if requested. */
+		goto check_for_tlp_probe; /* Still respond if requested. */
 	}
 
 	trailer.maxMTU = 0;
@@ -1217,9 +1219,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	 */
 	rxrpc_congestion_management(call, &summary);
 	rxrpc_rack_detect_loss_and_arm_timer(call, &summary);
-	rxrpc_tlp_process_ack(call, &summary);
-	if (call->tlp_serial && after_eq(summary.acked_serial, call->tlp_serial))
-		call->tlp_serial = 0;
+
+check_for_tlp_probe:
+	if (call->tlp_serial) {
+		/* Need to check to see if the ACK is a TLP probe response,
+		 * even if the ACKs may have come out of order.
+		 */
+		rxrpc_tlp_process_ack(call, &summary);
+		if (after_eq(summary.acked_serial, call->tlp_serial))
+			call->tlp_serial = 0;
+	}
 
 send_response:
 	if (summary.ack_reason == RXRPC_ACK_PING)
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index c652451cc9b5..07972c85f256 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -368,11 +368,12 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 }
 
 /*
- * Detect losses using the ACK of a TLP loss probe [RFC8958 7.4].
+ * Detect losses using the ACK of a TLP loss probe [RFC8958 7.4].  The caller
+ * must check ->tlp_serial != 0 before calling.
  */
 void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary)
 {
-	if (!call->tlp_serial || after(call->tlp_seq, call->acks_hard_ack))
+	if (after(call->tlp_seq, call->acks_hard_ack))
 		return;
 
 	if (!call->tlp_is_retrans) {

