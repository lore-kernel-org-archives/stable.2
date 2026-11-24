Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536818;
	b=IuWedhmeWGRY8Q+R2RHObbIBgEsAScQ7iH6ZKJMJ5YLbN0dVcMnpzgEOQFM9DV9SNM9h
	 VmH1KddvpHwxfTHw6kDDomij6yr2V/a7iAcO7+xUCokWWNXdDudzNE75tBCh2aLS5Yhss
	 ut/xA/J1A9UIf7rmQr4Dktqz21OY6USs9D4j63UoXcXA6dgrnT9abrKSUlbyS9JVyGg8i
	 iATV29Sfb3+MTFkpeR+ihh0Dt6Sj3q5ff5e/cm2zFN5D9tKkcnV1Ic5zXAPBoL1wNW0VZ
	 lsLh1uw4eSWC5NvLMgsaBwOHxlLOg0mp2NkYnX77IHXH1gMobOuOSTQWK2Q8RohMu4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536818;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=QBvbgfx4E8jvr7JMVNhMlTeMCa0V19tUFi11ZMoFNQo=;
	b=AWY6oNfjJ34kGKfekoxthsmu5PfgNxm8I3X8FXGQKN2bwVEW4owzS4moaKVSciIsHcDZ
	 +c1mAVr183B9pOcbwybKp2p6dSmcodkAH+2oFboMSKiK/Af7qc2gg1mNUYBY4Vp2VmMrK
	 t4S8MtYBHGvg2bk8VInLNu7LtwXYOkubKIb/Cv5aqLErEkWtomAey0+x42PW9jbg2ALV8
	 oqCFx8FLv2JscFGNqDPaTb59jqBqiRAE/1d9IuG4mtaMww1O1g6qxSDs+zuuu7RLtiBxK
	 yapgshbGU2TJxOUOP6MqjzGK9YqjCZIf3jyiGd/1gYEJWXL5P7Yc5v0ANoIISbbPJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UrNuwetI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851E606A33F
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4851E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UrNuwetI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBvbgfx4E8jvr7JMVNhMlTeMCa0V19tUFi11ZMoFNQo=;
	b=UrNuwetIQV5QgCbT1Pj0ILXJYYuM+0kv2YEUYXfKKCF5VHQaWtzPeD+WypaCM3mNJr0f4k
	1HehWWBp4S+6sek7GbYBOre1GbNVuMresyMrOOnuy4pBCcVjGiDIPpJ9SK4adeFmmZW1R2
	Go6ZTjr/zIabHfjmVzJBOmf+SoJliVY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-u2_ObtZPOtOBxkRb9pI3PA-1; Tue,
 24 Nov 2026 16:13:33 +0000
X-MC-Unique: u2_ObtZPOtOBxkRb9pI3PA-1
X-Mimecast-MFC-AGG-ID: u2_ObtZPOtOBxkRb9pI3PA_1795536811
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B5C1955E89;
	Tue, 24 Nov 2026 16:13:30 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1909F1956042;
	Tue, 24 Nov 2026 16:13:27 +0000 (UTC)
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
Subject: [PATCH net v3 04/10] rxrpc: Fix ack parsing to mark reneged ACKs as lost for RACK-TLP
Date: Tue, 24 Nov 2026 16:12:52 +0000
Message-ID: <20261124161302.4044422-5-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If an packet that was ACK'd becomes NAK'd (ie. the peer discarded it), the
now-missing packet is not picked up by the RACK-TLP implementation.

Fix this by marking reneged ACKs as lost immediately.

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
 net/rxrpc/ar-internal.h |  3 ++-
 net/rxrpc/input.c       |  6 +++---
 net/rxrpc/input_rack.c  | 11 ++++++++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..d88dd02b6ab5 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1256,7 +1256,8 @@ void rxrpc_input_rack_one(struct rxrpc_call *call,
 void rxrpc_input_rack(struct rxrpc_call *call,
 		      struct rxrpc_ack_summary *summary,
 		      struct rxrpc_txqueue *tq,
-		      unsigned long new_acks);
+		      unsigned long new_acks,
+		      unsigned long reneged_acks);
 void rxrpc_rack_detect_loss_and_arm_timer(struct rxrpc_call *call,
 					  struct rxrpc_ack_summary *summary);
 ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index bda6e7d77013..9b02e36264aa 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -888,7 +888,7 @@ static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
 				    rxrpc_seq_t *lowest_nak)
 {
 	unsigned long old_reported = 0, flipped, new_acks = 0;
-	unsigned long a_to_n, n_to_a = 0;
+	unsigned long a_to_n = 0, n_to_a = 0;
 	int new, a, n;
 
 	if (tq->nr_reported_acks > 0)
@@ -951,8 +951,8 @@ static void rxrpc_input_soft_ack_tq(struct rxrpc_call *call,
 		rxrpc_input_soft_rtt(call, summary, tq);
 
 	new_acks |= n_to_a;
-	if (new_acks)
-		rxrpc_input_rack(call, summary, tq, new_acks);
+	if (new_acks || a_to_n)
+		rxrpc_input_rack(call, summary, tq, new_acks, a_to_n);
 
 	if (call->tlp_serial &&
 	    rxrpc_seq_in_txq(tq, call->tlp_seq) &&
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 87084cea88b1..c4276534f539 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -130,8 +130,17 @@ void rxrpc_input_rack_one(struct rxrpc_call *call,
 void rxrpc_input_rack(struct rxrpc_call *call,
 		      struct rxrpc_ack_summary *summary,
 		      struct rxrpc_txqueue *tq,
-		      unsigned long new_acks)
+		      unsigned long new_acks,
+		      unsigned long reneged_acks)
 {
+	/* Packets that got un-ACK'd get marked lost. */
+	while (reneged_acks) {
+		unsigned int ix = __ffs(reneged_acks);
+
+		__clear_bit(ix, &reneged_acks);
+		rxrpc_rack_mark_lost(call, tq, ix);
+	}
+
 	while (new_acks) {
 		unsigned int ix = __ffs(new_acks);
 

