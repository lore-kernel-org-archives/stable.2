Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536811;
	b=KZX3Hqu/9vdxG8HMtJFQqfwrl3EFVm2xCGoW5ORWthQEJZehMRObg79nVf0bBuMKn5zv
	 y06IULV5S+xRmzAQd5r8CzWGQb1Kb45r8GWdMOuarm5rlYiAydXQryzn3dmZrbbr1kqf/
	 MKXg1l5t18oTQOMpEIWB9ELpEVpI6dJYoLyeyB9B5oFCUAxUoLpM7E9ojjVjc4495l9/C
	 yOlgiRWkbvmVXpJXE78g0iXlXDrZBPLiZqubTpRm3tO15d9PlTXbrxfXZYecwtFOA6iMI
	 259SVv8DIbRm1wB5lnYIalTeVrI3S7ccwN18ofNpXVQCf9zww6Bi+MEDOHfXNilz7tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536811;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ygmh6x4s8y4UYUbIDkaJBgv4POTnvtCO/UnLp5JA/pk=;
	b=5j1IeWUI2gUfgD8h3uWFdMvczwrhufR8TnYgfOwS/tqc3PrizaznEVpKtuHvkDRLcYrG
	 jO3PCwDZbsUo3RrLaFF75O1RxhLWZKBTEPYzmjWmU1wpOKey77ZsOFpbnf/e6bPwN0Khc
	 LbohOpSJsffzqug+TfNkw3cZleQfZ6JtAA+YFRnnmLLmHSVEPvdInfMwRFirynAIDgM56
	 nQMaxaadO566LHfCSz8arhOIZoRrF2hvTfA3c1s8lDcFIjH093p8anxoLxQN6eJHRP8Iq
	 onnJ7i1grgzQc4wOmGTV7zRxaHmdgdIBcZUWYXuJajwjPbHaqGniz4Jb5cIIMTe9KPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=as6KQaC4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D51606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D51606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=as6KQaC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygmh6x4s8y4UYUbIDkaJBgv4POTnvtCO/UnLp5JA/pk=;
	b=as6KQaC4oR01+rb1sts2r8vHuCoP+7uOvRVOdGHmnQIBmM83/nou/MjbTlSOJg1wu0TExX
	ZEmZYlHvZqRfEpNWaZpRYG6aEPhQxvOhThMODZP3F9MmAQxeHuUj4GeRo9+/49UBZxWlpb
	FwsOGZEsLdr9iNBxv6ctDZ3uJezP820=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-xNhmy4lbObiLCKS_W3atDg-1; Tue,
 24 Nov 2026 16:13:24 +0000
X-MC-Unique: xNhmy4lbObiLCKS_W3atDg-1
X-Mimecast-MFC-AGG-ID: xNhmy4lbObiLCKS_W3atDg_1795536802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94B9B1955F38;
	Tue, 24 Nov 2026 16:13:22 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC6411801A60;
	Tue, 24 Nov 2026 16:13:19 +0000 (UTC)
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
Subject: [PATCH net v3 02/10] rxrpc: Fix time unit conversion truncation
Date: Tue, 24 Nov 2026 16:12:50 +0000
Message-ID: <20261124161302.4044422-3-dhowells@redhat.com>
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

Fix three integer truncations on 32-bit arches in which a time unit
conversion is performed that multiplies a 32-bit microsecond value by a
largish number without first casting it to a 64-bit number.

One of these bugs was found by Sashiko and the other two by Claude-opus-5-5
run locally.

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
 net/rxrpc/call_event.c | 2 +-
 net/rxrpc/input.c      | 2 +-
 net/rxrpc/input_rack.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 21be9c86d7a7..b102a055c2e0 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -45,7 +45,7 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	trace_rxrpc_propose_ack(call, why, RXRPC_ACK_DELAY, serial);
 
 	if (call->srtt_us)
-		delay = (call->srtt_us >> 3) * NSEC_PER_USEC;
+		delay = ns_to_ktime((u64)call->srtt_us * (NSEC_PER_USEC / 8));
 	else
 		delay = ms_to_ktime(READ_ONCE(rxrpc_soft_ack_delay));
 	ktime_add_ms(delay, call->tx_backoff);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 73cafe6bfa9f..bda6e7d77013 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -185,7 +185,7 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
 	    __rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
 		return;
 
-	rtt = ns_to_ktime(call->srtt_us * (NSEC_PER_USEC / 8));
+	rtt = ns_to_ktime((u64)call->srtt_us * (NSEC_PER_USEC / 8));
 	now = ktime_get_real();
 	time_since = ktime_sub(now, call->tx_last_sent);
 	if (ktime_before(time_since, rtt))
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index edd0dee8ac32..24903eb722b9 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -296,7 +296,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 
 	if (call->rtt_count > 0) {
 		/* Use 2*SRTT as the timeout. */
-		pto = ns_to_ktime(call->srtt_us * NSEC_PER_USEC / 4);
+		pto = ns_to_ktime((u64)call->srtt_us * (NSEC_PER_USEC / 4));
 		if (flight_size)
 			pto = ktime_add(pto, call->tlp_max_ack_delay);
 	} else {

