Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087815;
	b=iQVU93PSfN3sKQ++4wW4NdtcJ55/mkQjbDKTHJZoIHhV+/Ciy23P/WEFOFBUe97pvt40
	 p0ymZm2P44Dvp9ivqEevou96mgHiTg4c/2S+HkXxJi/zYSqV7e0JU7ZGsiFKR3GJbHfbM
	 eIGC8vlFmsnyiJrt8uOc8qggvrLyPHuMHifTLS4E+HczgqtIQu8QVnukSm+m4drrTNqAT
	 RGLWnsY/z2WVj6Ksi5nA6iaoaxV+pv7EC3sG6IK1175wYrqHpxOYVZtOLJ0pwvY0/0/Hq
	 7r8vDdYBIg4QhJaHSlsU7W3Mg4VRrvzJq20QuMslL32kVCoioUGP7V6LmG8G/sWmdgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vi6rDNDccrxXPa1zbQgFmr5dJFtiIk0+PH3s9JJRU8I=;
	b=FKqURg15wTP9e4hhOAs+m9jyjAM2UHllLeEURLb2/ewWHTLbsLmdGXfvPOKBwb1JV0X9
	 eZeeeGBetysnOsI8LMGMx+1++I6AyTB8Dp9yNBz4StKfS7rmivKfrQos3zX096quv0COq
	 GD0ksXezxgsCypCKTGOHKjdYkQhn9N0GFzq8EnkByiDDMHIPm5Dv0gCta2lXJof3pLQHl
	 gJxriwwluWgTlEMlrvXKdS6a/C9ZBvlPWxGIOiVEpOV5vd5CUhEXuqBss1c/KTcudwsoc
	 koHAraedAMDO0A6e5JW2Gt7ds+eoRbKO00p2tyzyVQNiPB/V2RWv6S9CU6kLm42DHcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mU3i849Y;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF14606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF14606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mU3i849Y
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f3c616c84so318971085a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 00:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087814; x=1793692614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vi6rDNDccrxXPa1zbQgFmr5dJFtiIk0+PH3s9JJRU8I=;
        b=mU3i849Yg3Ns/g1fPqUQOYEc7THM3TQ7JnHEcQ4I8ZhNR9m6n5+7dvXtwbmAeXEN4w
         YAPcSyRh4VLlHnGXAt0OYPO4jorVmfHxk9nDtEmreAVbOWOmXFbObqISianzcjIdS1gH
         uqARHsoAGomgjCLV+sxZOpglMo/2KaL8OTgDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087814; x=1793692614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vi6rDNDccrxXPa1zbQgFmr5dJFtiIk0+PH3s9JJRU8I=;
        b=2g7PDk/O5Gj13GWTAbZEZyKyz0KTcUO0hKSxxr/R05XeKhm8Z+V53F+qPRrCxG+9QC
         5stvkWPFKxsEKc0pahhEfjCN6gSLn+CG6JS5J9HqImNsNWhTPnTKT6RwBIQ5AU6PHtpf
         KqaAAUStxwbHaPyH+t5wS2n4aMDe/32nolSS0g9Y4E9wXj/oRGSD0T9r8TUaQfdwlpHq
         FjmETHUWp7k2adLkP0NqOvpUc9IkgjE7YkXMqmhmYwV2v21vjIsoYElyVIb4TaalF6Op
         qXfPYm1J1IW7C/vzt8S82RWUoBTJjJMoe9zMBSNYoZ45mIGU582r0r8sLMqQXsa+AKK0
         Snmg==
X-Forwarded-Encrypted: i=1; AKwUvBzY4cqT0DvoZhue8BGkyyCLO1OIx7VkvrQ88w7PmqKdvQWtKK+IXIHT7/olMXPmuH22UFuIa9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxfqBOvMKuf4GknPl8VbIb4umswFSSJMi9cFJKHTP33AVb0haD
	5O8XFRI16ekkBSeHA28klrUIu6m7s3V5RxhISMGChc+89x7nlhU4xwNHcYIhnVozKg==
X-Gm-Gg: AYBFou194J51CtwlLLlFHB976INg8qwfsotLrY4CLUr8dlWRaOXs11oNiLLDn/026/6
	rANUfzGaoAhuteq68e7Al8F/WFjbqgh3MEiQpM4Dy+RYrOXm8vg/WIIh1AvfX/E6qk7HVEulxL4
	ecdlF3Co21D/sbKUSgQN7az7RiHd2r/Gxy1+Ic1VsHgbla5X1e/xdR+PTnTGcPVLhgja4WsGxVW
	E0v7Zlp/NmjuJdp9BWoY/cr+U1ViVv9z96lMAdGpmZfodA2HDLKUG16tLgaNQVJl8t5PZpSCZrY
	pRn8Altx5BELe/BI061ZVCiLpsjaTVYodKFyGgFwFtZbsFlb6HaPDTQe6XtvvNWN34aE6J4gHeq
	USKV9DVik+RFFqTU4JgQ/OtiyfKwygi63G5ssdmk54/dqDYpUbqqPHEg8RV2GM7xhaXHX8fXvdc
	9noLsJAOTqsGnKQHnrSLi1uljXcqMkmSf3/O7hjkEndldwbgJDwQpKVW+uspwbEkj6cWC17Fu+x
	upD1t8BJ/owjsTn6s0zBUkALW1YEV5q9e+3xRfDRjIJj2AwOOtYrGLt4NCI7xK8EOSZvfKmw8BR
	n2RUJSiZks6za7P0QgFWb09T6UA=
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dc6 with SMTP id af79cd13be357-940ef9c39f3mr1380355085a.70.1793087813677;
        Tue, 27 Oct 2026 00:56:53 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066629dsm906675585a.7.2026.10.27.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:56:53 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2 repost3] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Tue, 27 Oct 2026 03:56:42 -0400
Message-Id: <QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
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

teql_master_xmit() writes the slave's link header into the skb in
teql_resolve() and on retry pulls it back with __skb_pull().  Two bugs:

1. When the skb's header is cloned (e.g. a tc-mirred action on a
   physical device's clsact egress redirects to the teql master), the
   write corrupts the other clone.  Call skb_cow_head() first.

2. The pull always removes skb_network_offset() bytes.  For an
   AF_PACKET/SOCK_RAW frame with no dst entry, teql_resolve() adds no
   header, so the retry strips the user-supplied one.  Pull back only
   the length this slave added.

Track the added length per iteration; a header-cloned skb is unshared
before the write and an AF_PACKET frame retries with its header intact.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..acd03f9afc6b 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -245,7 +245,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
+		/* The skb may be shared (e.g. a packet tap clone); make the
+		 * headroom private before dev_hard_header() writes into it.
+		 */
+		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The header, if any, is prepended above skb->data, so the
+		 * network offset grew by exactly the bytes to undo later.
+		 */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -281,11 +294,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 static inline int teql_resolve(struct sk_buff *skb,
 			       struct sk_buff *skb_res,
 			       struct net_device *dev,
-			       struct netdev_queue *txq)
+			       struct netdev_queue *txq,
+			       int *hlen)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	int res;
 
+	*hlen = 0;
 	if (rcu_access_pointer(txq->qdisc) == &noop_qdisc)
 		return -ENODEV;
 
@@ -293,7 +308,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -305,6 +320,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	int busy;
 	int nores;
+	int hlen;
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
@@ -332,7 +348,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Undo only the header teql_resolve() pushed for this slave.
+		 * Pulling skb_network_offset() instead would strip a
+		 * userspace-supplied header when the slave added none, e.g.
+		 * an AF_PACKET/SOCK_RAW frame with no dst entry.
+		 */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.43.0

