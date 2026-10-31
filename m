Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484664;
	b=sY3FlDMHU8UiO3dZSvvyAIKF2Kd1mZ/dzOQMUCMvJDmfA8uk71vvXM73clH50K5+0U13
	 c4pqRRBj7vuMm2KXLmMTgPLCesnGicg1u9OT84FWDmGmEpJK5J1ZBvohxnwef/E1RLF8H
	 LAiEfoMphBjOBZYJOOpZ7suaNDPRhIJS45k0OPkHpHdmiSzt1W53uxwQP/YFqUby5MCsF
	 sMdVHDVEFHqonQAIbbYvpXkPhFOi6yCmSkwNNwD84L7TOvkOHExf48yBNQche55ZxK+aI
	 jcUj2Hium7f9U0A4UTkKpFZRUI9u1o/aQcnN1dliHOXPXSXn9Cuu8h4RDMbYuPJ+bDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484664;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=QbKyi2Y+nX+sO/WAOcqG4XV1ZkwrVE+BhXDx179zkbk=;
	b=k0SO6GedFt8tHjQXgwUpd+SyYiM5QtvniI8n/TttXVMf93sihAszRQLIRVwVDyDPc4pO
	 5l/fLCYJ1x6SfnPPum/XLO7On0lNCNkZX3HGg/mlUpczZ8pGpY9j4XL9KXew8wyl+QANu
	 GxM6nqd2KJFVwKZSXZcd5rHN4iPxuDR3bXDv/hk7MyI1KG6XD8lcIn31i0MSHdZBeI+y2
	 hhVL095er7CjFQCVjtTZWNNhZ9O58Yj/Yq3mv99auLZF6nJSiiKBoc0oQIP1WfdcQ+pJi
	 TwgUhIhIk089IUep2RJxudFBKAv1XIMzUANc7NyntQm/8aZEk3CKnYebZDnxZsDmXRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=oHaRquRf;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E8606A321;
	Sat, 31 Oct 2026 22:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901E8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=oHaRquRf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QbKyi2Y+nX+sO/WAOcqG4XV1ZkwrVE+BhXDx179zkbk=; b=oHaRquRfqM1lzQBQ62z6vF5cDh
	V9gvu9yjB03p/U53uV2/ToSAls00gugg0xRORjYXwuS8R5l8+TBV9861lnZ2ttl9al+Mz8jBoUOPs
	R2x9sLIh3+DLfFlofiQaXoH1LajsJMLyTuGvZy7rj4zpEhSpOVXcktaj1+eN+l65CV6ya2SBEkbs5
	5HiWtNNLXOSbOPC5zGRLVU3GDNH2qsWesx4VoHs5m9y+oBrQUpZFjd2NwFMlJvY9dx1KIPi5XfyaX
	ilNI3gGiuv6zRrdNcDOV7OfBoH0pWTTkAYldodV84C+w33BRlNFWSXW7uOhWBL4X/Xo0Y90ja4d0S
	3+BuyZSw==;
Received: from [151.115.150.205] (port=46594 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNHI1-0000000EZr9-2D3q;
	Sat, 31 Oct 2026 23:11:01 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on byte-limit update
Date: Sat, 31 Oct 2026 22:10:52 +0000
Message-ID: <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

If userspace reduces the TX aggregation byte limit while a buffered skb
is pending, subtracting the skb length from the new limit underflows.
The later comparison with unsigned skb->len then lets the buffered skb
grow past the limit.

Check lengths before subtracting. Flush a buffered skb if it is already
at or above the new byte limit.

Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets aggregation")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index e6f48dc9fe64..205ac81f2c82 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -594,7 +594,7 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
 	struct timespec64 diff, last;
 	unsigned int len = skb->len;
 	struct sk_buff *agg_skb;
-	int size;
+	unsigned int size;
 
 	spin_lock_bh(&port->agg_lock);
 	memcpy(&last, &port->agg_last, sizeof(struct timespec64));
@@ -606,13 +606,14 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
 		 */
 new_packet:
 		diff = timespec64_sub(port->agg_last, last);
-		size = port->egress_agg_params.bytes - skb->len;
+		size = port->egress_agg_params.bytes;
 
-		if (size < 0) {
+		if (skb->len > size) {
 			/* dropped */
 			spin_unlock_bh(&port->agg_lock);
 			return 0;
 		}
+		size -= skb->len;
 
 		if (diff.tv_sec > 0 || diff.tv_nsec > RMNET_AGG_BYPASS_TIME_NSEC ||
 		    size == 0)
@@ -630,9 +631,8 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
 		goto schedule;
 	}
 	diff = timespec64_sub(port->agg_last, port->agg_time);
-	size = port->egress_agg_params.bytes - port->skbagg_head->len;
-
-	if (skb->len > size) {
+	if (port->skbagg_head->len >= port->egress_agg_params.bytes ||
+	    skb->len > port->egress_agg_params.bytes - port->skbagg_head->len) {
 		agg_skb = port->skbagg_head;
 		reset_aggr_params(port);
 		spin_unlock_bh(&port->agg_lock);
-- 
2.47.3

