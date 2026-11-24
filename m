Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536849;
	b=B9h8F4v+pwUGOL16Nlun3evatMONFDXLXMQnKT3DC7vxKlHkewtefoN+nc/1HyYKzPfd
	 w6AUVD6zjsrW2kLl2RVm5b0dwgfJIR2FJLZGsm/Dl72mfrqQpJdfo7r3CB5OCYsH04LRT
	 d+3d/9sYE6HPaNi2iFVeZCWuFovNMQ8v3hWdugjnUc2dInDJZPoBaTusnoR11bE/t3hf/
	 4D6EJTzAMRWk7Et2Kc3O7v0DybkVBXC4b8qkycjZKDiiqKsTIRwdJxWzHLhZpkH8QS/Hz
	 WEsfBIaIio/rv/6uWhlZO1ZnaSVoBSs0QA8DxJKG8f63G9tCdX/vvht0iyeE0jxOjsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536849;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=RCreZvrypwRnIZDCuQwz6MJScYzu2vEPvy8Vu7nfZq4=;
	b=z/zh8IuwDoZhvsCIgQKlDTurREf/TOsJkxhPi7yDZjq9vyRhHiKq8I73lDh2B8EHvcZ8
	 EokP7wnSEMkeMP7FmRhK/pLHuPHCVUykkdLhlkkx+d+vnQT5stmksR47pB/tJa6zAx6VU
	 SZuSzFiD5+bv4JtsuhsXSKh6R1e3cgXeaP3KStfkLaktRmu14YH9b5mMhXdfDC0z+Hg7R
	 ZQz4CXaQwsc+PO8QzAXuz2Tg2Ro4JwxrIyM7qApdM1p1ZmAgN0TNsYe1cNu7gQvb7kMoy
	 4uAisZIN7GsSmfsCaqn4aECk1Scl8vBi5FxRrQuHB/HMUgDBXSk6H1zBSlTjDDQKllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MKHn798I;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B77606A681
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B77606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MKHn798I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCreZvrypwRnIZDCuQwz6MJScYzu2vEPvy8Vu7nfZq4=;
	b=MKHn798IDgmdPhRu6WKMbT6ZyQBdQTfLFCA6F8uvcOy4UiMojaM/lnbdD0VMxHwFJq475p
	RlWJclf8yGh8q6G3SKMl1LX5V7jhuPoDS2NI6Ogth7CViYClCWRWYemNciBlqvqIHV8QS9
	uIJE6rAWWPzDa/K4HZepSseaQ3/mMxQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-XPczvPTrPWunq1AwO_sgSw-1; Tue,
 24 Nov 2026 16:13:59 +0000
X-MC-Unique: XPczvPTrPWunq1AwO_sgSw-1
X-Mimecast-MFC-AGG-ID: XPczvPTrPWunq1AwO_sgSw_1795536807
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC44B1956062;
	Tue, 24 Nov 2026 16:13:26 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEC411801978;
	Tue, 24 Nov 2026 16:13:23 +0000 (UTC)
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
Subject: [PATCH net v3 03/10] rxrpc: Fix carrying of in-flight calc over retransmission
Date: Tue, 24 Nov 2026 16:12:51 +0000
Message-ID: <20261124161302.4044422-4-dhowells@redhat.com>
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

rxrpc_tlp_send_probe() calculates the in_flight value at the top of the
function and then doesn't use it till the bottom of the function - after it
may have done (re-)transmission, which would change the value (though it is
recalculated in one place).

Fix this by calculating that value at the point it is needed.

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
 net/rxrpc/input_rack.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 24903eb722b9..87084cea88b1 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -313,8 +313,6 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
  */
 void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 {
-	unsigned int in_flight = rxrpc_tx_in_flight(call);
-
 	if (after_eq(call->acks_hard_ack, call->tx_transmitted))
 		return; /* Everything we transmitted has been acked. */
 
@@ -333,7 +331,6 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 			call->tlp_serial = call->tx_last_serial;
 			call->tlp_seq = call->tx_transmitted;
 			trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_transmit_new);
-			in_flight = rxrpc_tx_in_flight(call);
 		} else {
 			/* Retransmit the highest-sequence DATA sent */
 			call->tx_last_serial = 0;
@@ -345,7 +342,7 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 		trace_rxrpc_tlp_probe(call, rxrpc_tlp_probe_trace_busy);
 	}
 
-	if (in_flight != 0) {
+	if (rxrpc_tx_in_flight(call) != 0) {
 		ktime_t rto = rxrpc_get_rto_backoff(call, false);
 
 		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;

