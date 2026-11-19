Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092037;
	b=LuLQp8WS1PwHvmEPdIMsT9qy6hvq0uk2u5jSRzkN6j1rNNOr2ZMvFUy+16Xznn0AdBuE
	 XN3dqKfXilZQlXPc1AU/91TBQ1PVwag2fylQA6l4OkmcPn+tP2DIgOdcNKc4hKQjiVgTX
	 Ak3rAJdSwN/8uAhrb6VcAnkiOKisClZvzkNggamOZyWerws3aJeZTL+GIa8Wvb+iPjR5U
	 64Fmi1+8WiXrTQK7XlPPUUWV3M5HhkmBSZqTpVo1CyTpFUMUEadcIEQXNyHlUI5w2x9Rd
	 uImzLiXLqTpYSuXXLjYUoNIFBfZ/NNVqsQmmgu/nWvLKo2gAKxNyOjIr8kK0lIM4hIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tVDnY8OtxNX87CAwAGPLJZ7DAxyj7rWw4UJCN44byEo=;
	b=fL+H8Wr+qaetgGXK9Mp1sLxBsr/B3TFavscrOHPqK/DEWv0wA9NgYLcwchFtDgZ/yBb2
	 R0HoINB6//XBVVJVfC4a/E1K33sPnBe+imEaoQDCeepkeyN6YCuooUWPtmxucIIy/UgCU
	 sC4bLo4rOXPVs4UcqWqQuoAex+VR+H00vWq3PsThC8EdYTe429k04sK2PtZ/ZLr6U6Pem
	 s8eOVSb50R/8FtZCIN7/qdTmM101OlAmzGHPvbmp2pipiFBQtGEYV9aDc7oI8zrktC7H8
	 sW0IfYI9m0nLGwUWOzIZpPd2UyZvejK6AN1KmrGA6yHkpRZZlgMIuyMAiELC35MhHVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=O8pJNLyp;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB35606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB35606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=O8pJNLyp
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365f9a04c5so28825891cf.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795092035; x=1795696835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVDnY8OtxNX87CAwAGPLJZ7DAxyj7rWw4UJCN44byEo=;
        b=O8pJNLyp5l0iKi1X4+pPG7gM8tZIRyouS1KJ1bmgyKmu0Y/IMd+XIfxoVhjnO6jS6r
         CVZTS0GDKOWNYnf968sqh1hXrjpWHa5zfEzdsxWWt8swcz2Ue+ytbt+rxLuopiOkuAYf
         tuo+zJ9NApIiLSTz3C77VaADY98UxsujnzhI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092035; x=1795696835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVDnY8OtxNX87CAwAGPLJZ7DAxyj7rWw4UJCN44byEo=;
        b=hG/0nKk/l83D6/hzXOVgMCYRwyCW+ESrArpJv0rmD22INUsqvyzknv1IE5lkgkkHxt
         iVJa+m5fYY5wuaMRqpubOYYZNmFvyh1Zt523/YUPS+UwPKHnJ1RpLA12eiZ1/6tPvFbn
         nG7lnZBmND8TTvvRCtX0YBHGH57PB4u+9dLtFzJUVBZIkEM5t7iMGa76WN5SrUBjf/T+
         GO8iGKBjgb0oaIne6OfF5GbnfiPmPOvXPdcbhitBVtR+szXgT+LV+pnGmhPFPI3I9M1M
         dTRtaRYJZnhMRdENIw/9bqq+4b9yog4Zz02gYtd75LSNsdkwLuTemvTBYY6N2+ZRoI3y
         NoHA==
X-Forwarded-Encrypted: i=1; AL+hErFmXALF3mD2OUp60eGS7AEv8jOxTaZ0IzzKYnMsgPXhMfkOP+ikgjr3Lyx57vFJW29xXpU1AKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FQwR05Y4fUkiBSF5jZWB3n6IGS2AnjLmby97VeyP7F90IHATZ
	w4WvgQbq3AQDz3Cf/8lVo0HURCxp7Jk38KA78/y0UEHk3Czbom5NWVAgiZq6ssfHfw==
X-Gm-Gg: AYBFou0T9KE+1WLVv9gMEDhB0SSta4HrCi/0sAmt2yMEsnty/YvIvgL+hml20iNT5fN
	/ixBILRI4jMDX5d2ZyHo6vgdRt1e5+mI08kGCOAb75fvh02vj1mbF4xByf885yWZxdYVe/Jw0+l
	ppdPyi5dS8IaBXs8mm3uBn4lYTL+m43BfBKwlFOAgzjU6oR4qhFXladAh17+9md6rosVsBqDqGJ
	DIbcSqPuQonG8p4/pKxvlS6GPftsSKnOLx8mHTpP29hghGExYDyU1Isp9VSx/gcz9FRQtgGrRgT
	2vSSSo0AEjTIUy6yEaaSsaUVwTc/QLMVhjCP17+oRrrN/Vh8UPgChCBPUVheza5aXW1raxAUDv5
	795IcMPKwlOaUCvdwHR/H34lHqo4F57THmduFE/LSLG+gRSX9plIbSohejOvzej8NeyaZrWFu6b
	V/Yj/xzHi3/8AZrAeFcG8xIPooSgcvLQc11qMcFfxI8UYOwHhlJUMai5NfL54kzBEEYe/7PEsg0
	YCqC/nQBXPp+B+8+8X3eij8ZtX+qmxApg/cmM7R1xlYvhqPUIEDgO1WeagQMlgo+5u9JwvT5uAw
	dTQXk5WMLxin1xIyby/erJibUk0pnAV7HkzPMu2bgMn53ebRrIpmXxaoMqU2vq4XPKymfTevDM8
	=
X-Received: by 2002:ac8:5d06:0:b0:536:d47:22e with SMTP id d75a77b69052e-55d5a5e9e6fmr94167611cf.40.1795092035312;
        Thu, 19 Nov 2026 04:40:35 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66b75823sm22370191cf.13.2026.11.19.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:40:34 -0800 (PST)
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
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v6 1/3] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Thu, 19 Nov 2026 07:40:23 -0500
Message-Id: <QDISC-6HS9.v6.r0.20261119070330-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com>
References: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com>
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

This is a followup of commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path") as reported by Sashiko.

The issue:
teql_master_xmit() writes the slave's link header into the skb in
teql_resolve() and on retry pulls it back with __skb_pull().  Two bugs:

1. When the skb's header is cloned (e.g. a tc-mirred action on a
   physical device's clsact egress redirects to the teql master), the
   write corrupts the other clone.  Call skb_cow_head() first.

2. The pull always removes skb_network_offset() bytes.  For an
   AF_PACKET/SOCK_RAW frame with no dst entry, teql_resolve() adds no
   header, so the retry strips the user-supplied one.  Pull back only
   the length this slave added.

The Fix:
Unshare the header before the neighbour is asked to send the skb, so the
skb is private whether the neighbour writes the link header at once or
parks it on its arp_queue and writes it when the entry resolves.  Start
every attempt from the network header, as neigh_resolve_output() does,
so an skb that arrives with link-layer bytes in front of its network
header is given one link header rather than a second one.  Track the
added length per iteration; an AF_PACKET frame retries with its header
intact.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y and CONFIG_VETH=y, run as root. A teql master with
two veth slaves, the first slave returning NETDEV_TX_BUSY without
consuming the skb so that teql retries the frame on the second one:

  ip link add vethBAD type veth peer name vethBADp
  ip link add vethGOOD type veth peer name vethGOODp
  ip link set vethBAD up;  ip link set vethBADp up
  ip link set vethGOOD up; ip link set vethGOODp up
  tc qdisc add dev vethBAD root teql0
  tc qdisc add dev vethGOOD root teql0
  ip link set teql0 up

Send a SOCK_RAW frame that carries its own link header on teql0 and
capture it on the second slave's peer. A veth transmit does not return
NETDEV_TX_BUSY on its own; to hold the skb pending this reproduction used
a test-only IFF_DEBUG accelerator in veth_xmit(), which is not part of
this patch and was applied to both the unfixed and the fixed build.

On the unfixed tree the captured frame arrives with its header stripped
(176 of the 208 bytes sent, starting at the payload) because the retry
pulls skb_network_offset() bytes while this slave added none. With the
patch the frame arrives intact.

The shared headroom case needs a second reference to the skb to survive
the transmit. A PF_PACKET tap on the master whose socket is never
drained keeps one alive; a kprobe on eth_header then reports cloned=1
without the patch and cloned=0 with it. The parked path needs the
unshare before the queue: a tc-mirred mirror on a physical device's
clsact egress parks the clone on the teql slave's unresolved neighbour,
so hold the original frame in a netem delay on that device and then
resolve the slave's neighbour through a changed lladdr. Without the
unshare the arp-queue drain writes the new link header over the original
frame's first bytes, and a listener on the peer sees a frame addressed
to the new lladdr instead of to itself; with the patch the queued frame
keeps its own destination address.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v4.r0.20261111094338-1%40mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v5 -> v6:
- every attempt now starts from the network header, as
  neigh_resolve_output() does, so an skb that arrives with link-layer
  bytes in front of its network header gets one link header rather than
  a second one.  The header length is recorded as the offset the
  neighbour built, and only that much is pulled back on retry.
  Considered comments from Sashiko (nipa).

 net/sched/sch_teql.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index dc21cd9704a2..44730a5e8917 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -262,7 +262,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -292,6 +292,18 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 		n = mn;
 	}
 
+	/* Unshare the head before the neighbour can write or queue it. */
+	if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Each attempt starts from the network header, as
+	 * neigh_resolve_output() does.
+	 */
+	if (skb_network_offset(skb) > 0)
+		__skb_pull(skb, skb_network_offset(skb));
+
 	if (neigh_event_send(n, skb_res) == 0) {
 		char haddr[MAX_ADDR_LEN];
 
@@ -299,9 +311,12 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The bytes prepended above skb->data, pulled back on retry. */
+		*hlen = skb_network_offset(skb);
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -309,11 +324,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
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
 
@@ -321,7 +338,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -335,6 +352,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	unsigned long flags;
 	int nores;
+	int hlen;
 	int busy;
 
 restart:
@@ -361,7 +379,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -408,8 +426,10 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Pull back only the header this slave added. */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.34.1

