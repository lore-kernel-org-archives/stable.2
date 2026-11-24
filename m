Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536826;
	b=UWe6SVDiZPO1BcVd3bgZAU42XOcmn/LDZIxKWCt60wCZ18eAT9iSEF4V7NviJm8XofDJ
	 mjivJMOP7erGCHWDc4eAMlD257g92V2aKCdmg8UWgqDWcOWzDiUYEa4MorW59aZ5oi0bg
	 JcA5Frq+kmsZqMy31WXZLZCMVOHQCjwKaozf40KYgndVyvjvzS6dPnnGBSudfHkWb4yLW
	 o4s9mO23CnreZHKUpXu+ObNPpGdnxnyHyfQXrWCPLp8EdBv5yGp7+uYqLlqKuaU53IhO6
	 mhcFAdg5pPvhsDo52Lq9UVVQzkXWYHuWFtKrf1x8b5Z7r2slO9FGsm5j2YsouMMBZMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536826;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=FAoXPtjsSbk6QimXxTrqaQ81lI7OL892cNz+SdiZLNA=;
	b=ir6Gah+EZUqzXZIMhl0R7EjJsDy8oQyk9qyqdWJHvA6lTtmDX8dR/qcXpeSAchwn7CZR
	 RxUuc+B7lDYri3PwdUpRgnfujQcIVVjLL0rBACWYGElZoijigCkPMF3NsScY3OoZC+rpp
	 YOj1FIKXK2wXwIGSXfAhEyjjXVgKEnN9qyr692CSzQ6yM7eoia52lpM+AYT33DhbgyHsJ
	 vDE3oaaV0sGNrKGsLQCrLGp75Em4Nu1h8m3BAv8JYXN0vU9z25l/1iQGmyRn/q/adEQrr
	 vAMHnsADEQ6LBeANNLNszNG/5M/y1hDkolUqBafUQOnq+vb4Y5Sgwfkp76+LeXaEU5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="c/oSV0gZ";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4881606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4881606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/oSV0gZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAoXPtjsSbk6QimXxTrqaQ81lI7OL892cNz+SdiZLNA=;
	b=c/oSV0gZZfUp6ytd5uvoztKx1Yb+d00eVKwSsaF11dtZrsXWRbvGsm4/S6ayoUr7cTTEaq
	3GT/xHdgdroToEiUph/5yV1cGPIFm6k1S9SSct3KDbXPHw3lsXrbRh4ziSdOrofvPS6N8a
	NyuhqzlnGW/4dejDTDDJk0fUhXeg3vg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-nU_5C4YEP-OUGK7FTY2g9Q-1; Tue,
 24 Nov 2026 16:13:39 +0000
X-MC-Unique: nU_5C4YEP-OUGK7FTY2g9Q-1
X-Mimecast-MFC-AGG-ID: nU_5C4YEP-OUGK7FTY2g9Q_1795536814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A9A71955E89;
	Tue, 24 Nov 2026 16:13:34 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F40A6180197B;
	Tue, 24 Nov 2026 16:13:31 +0000 (UTC)
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
Subject: [PATCH net v3 05/10] rxrpc: Fix RTT processing for a presumed lost packet getting ACK'd
Date: Tue, 24 Nov 2026 16:12:53 +0000
Message-ID: <20261124161302.4044422-6-dhowells@redhat.com>
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

With RACK-TLP, under some circumstances a packet that is presumed lost has
its xmit timestamp reset when it is marked lost.  However, if an ACK then
turns up anyway, rxrpc_rack_update() sees a bad RTT calculation because the
xmit_ts is calculated as being KTIME_MAX.

Fix this by skipping the RTT processing in such a case.

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
 net/rxrpc/input_rack.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index c4276534f539..e5288e5beb59 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -71,6 +71,12 @@ static void rxrpc_rack_update(struct rxrpc_call *call,
 	if (__test_and_clear_bit(ix, &tq->segment_lost))
 		call->tx_nr_lost--;
 
+	/* A packet may get marked lost and then ACK'd before we get to
+	 * retransmitting which can result in xmit_ts having been reset.
+	 */
+	if (tq->segment_xmit_ts[ix] == UINT_MAX)
+		return;
+
 	if (test_bit(ix, &tq->segment_retransmitted)) {
 		/* Use Rx.serial instead of TCP.ACK.ts_option.echo_reply. */
 		if (before(call->acks_highest_serial, tq->segment_serial[ix]))

