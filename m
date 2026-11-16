Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825411;
	b=zV6J+b115aeGdvSsBVfBaSrkcCMnDfQtnwIGDncBeaezHa4gz3mapE+YE1U7qvR+v7qE
	 wt3q3Ft82oTR/myrz8oH4kAtoYDC95Ova8EKqtiSIZpqdA91Y5W8p06Kds85oSGtkQmFW
	 qH8YZCRek4d0Q5V5OEPzOKnO2aPJMvpYaJCS9RWD7hKrQmWQJ3ki8Hqk2ayeQnOZjx4BQ
	 9qIWqvq0/H1WGI0V6JONYvwNaVfhPdS+7h5kI/aVgyoq1Q79gPw2cR+8qNKjOf2H9wXoI
	 H/lF73MWRb7lZEKdEczlhe9vs04zrIsy04KNf0EDqldpAlIe2SO2tfgLr0jOfFuuMBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A9QCvBDNzjHNewK/5sGsCPHGV+HulpdvSNXD8RtJkPM=;
	b=GZvevgm3iAeR4xLfGYAOdRCR/xO5ttJm2HfZgHZzrMlmfTzEmwui39HenR41toWuUOeQ
	 uXilKk+lXFeCP6JlBLTEdcf+SNRSWpWUEaj/xytO+b4aFLz40DbSMOfP7vK6KCGVGHglY
	 G3RraWoE3MDm1Bm0ojIR0OZQkBHK6acZXo9Qu8anY2BWnorxDHt/ilMVmFUI43daWD3hf
	 hg6bRtld+inxECcaGhpnuDhyL4OICI8oYf2kZZqc674hn/aHrehKFneQVNAQfrOHSZWL5
	 gyuHVgyecaDMMBEJSvB69nqDBbnDSgpryokmRuO/LL76PwNE26tuDobSDvipO/XBHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KsupSwKc;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4C606A33B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE4C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KsupSwKc
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eb7d1478cso41918386d6.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794825410; x=1795430210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9QCvBDNzjHNewK/5sGsCPHGV+HulpdvSNXD8RtJkPM=;
        b=KsupSwKcrGa9Ub4U2tn+zrUWjxY4YpeOUXiPTMixI04s3Lr2LzT0JD3FSyD6Q1tVTw
         VR0ixc0mbd7CEKENRK+wnkSot1+oOS2lv7NPjM7Bxs42DyNtL8lsR5Fb7aIo5tBXEfxX
         QoOMRbRDdZQCC9aLtUd8YfYcUHQAGrnYd/3OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825410; x=1795430210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9QCvBDNzjHNewK/5sGsCPHGV+HulpdvSNXD8RtJkPM=;
        b=a8pqRB+jPrjCBqHPH6HVZFQ/WXeqKQKl5NtvPRN9M9g012Sk90czpiYU2Apq8uDkBK
         3vDgATwOC+GY9OPnUt9aOFBCj6CZxVniytspJGT1Zw1+ptLLaDuSM60U2m6CieI+F+b5
         MZXIKtvkaXaUMBnzSJHE4yCY8OwisJgDqw3SCX7XwC4H1kTKqxjrzbAlMn1MK4dliHcR
         /jY6WVJUq4vl5Il4h+zduGCorvug0XF9pM2HLtXu8xjtxS9s26JaI24cSI3rt9GY4he+
         gc9mGFTWB3o7fNRSBEW5hgq3T3H8d6TlvVQ7epAz+r9/MvFg3xdvW8cPaCY8fEwEk7YS
         6djQ==
X-Forwarded-Encrypted: i=1; AL+hErEYJIrRmzA/lYRHg3uigN7cX7IY4brq88rHj07XTo9PbMv4lBK1RgqBWgOxcT+I2QRczKfKaX8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vXW8Z47g/TQbE7ZaLdWGWbcuePoKSKJKw4u+B2iksDXdZdmo8
	3bzHwp7aOZv0v+mQrGEZ+MjppUykuDm4R84u6/qK+DU2i5VzcHvzmEmBwjmyasreqQ==
X-Gm-Gg: AYBFou0CGhKPtL6DhPrlWFLJH9tbw5fbziB2V363s8P6cT++XKJRN9qyNH7jC8+UfwS
	bcUti5kArT7MWJyXmeK+81cbEV61Iqju/VCeDekd2z//YiRcqnMPR+KA1Zry+dvyWcpZGungYO0
	ikd0TUUSKnhGKtACX40Oy7ICBtqP5ivnwf236c5OLDmB4wAWV85OGSf0hu2lTpRXTKQE70GrEC1
	mH04LQbuoFy79U9tDcQoZCoIpoBOtO8NxRYM+i9nRprpDmAuQ9VxIsrBKYYc66l9q4Mi0U2sON4
	Ke2Vc1gjO5rgOQJicz9TJfTu05kLiYDJiWaZlilFysvNBx8dLYRQF4evbJ3Jv+WJRcf4LRIOfrw
	wOeYqrIec1e2oKARzPccmLFxEtttLYobkYb4+mr/IMhdt7p/RQjmswZ+EsGuieZhiuYnxY3AS2R
	SEwPx79iWDK1S/UxevWHsBsmOYpsG2uUzhbajsmOBP7obcUuKHhp6TWAOEcFt+BHhVkO0pUO+FL
	I0uWBZ8pZ3B41a3+YO22Q1V1cZRJaRFsejjSFFMR8Umx2mlt5to+mFrQ68rJy1qTXmfjImb9s+Y
	8bLzeKQO+wwpGifIp53KusQhaDekwr4g88aH8BgwSCXY5gnS3K9gjwz7jMP6bWKpZyDr8NzBahE
	=
X-Received: by 2002:a05:622a:1a88:b0:535:f3e:745e with SMTP id d75a77b69052e-55ac667e1f8mr172060921cf.20.1794825409531;
        Mon, 16 Nov 2026 02:36:49 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad14f1ecasm77778651cf.24.2026.11.16.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:36:49 -0800 (PST)
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
Subject: [PATCH net v5 1/3] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Mon, 16 Nov 2026 05:36:41 -0500
Message-Id: <QDISC-6HS9.v5.r0.20261116052927-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
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
parks it on its arp_queue and writes it when the entry resolves.  Track
the added length per iteration; an AF_PACKET frame retries with its
header intact.

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
v4 -> v5:
- unshare the skb header before the neighbour is asked to send it, not
  only on the path where the neighbour writes the link header at once.
  A skb parked on the slave's arp_queue is drained through
  neigh_update_process_arp_queue(), which writes the header itself, so
  the unshare has to happen before neigh_event_send().
- the shared-headroom paragraph of "Conditions to recreate the bug" now
  describes that parked path.

 net/sched/sch_teql.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index dc21cd9704a2..626dc001ec23 100644
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
@@ -292,16 +292,26 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 		n = mn;
 	}
 
+	/* Unshare the head before the neighbour can write or queue it. */
+	if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The bytes prepended above skb->data, pulled back on retry. */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -309,11 +319,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
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
 
@@ -321,7 +333,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -335,6 +347,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	unsigned long flags;
 	int nores;
+	int hlen;
 	int busy;
 
 restart:
@@ -361,7 +374,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -408,8 +421,10 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
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
2.43.0

