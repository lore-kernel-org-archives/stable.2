Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513759;
	b=fJdDMaQ7WI1ZJfF7WCJsrws2Uk0qiwx627ybKAWLXxLilzYObamoKHUNeq9c6rjG9cpM
	 AZJXX6OS7rm4h2VOGiKspkpseax5H6KF+pPRDi/BIngzgZrpUrqh0cFtrW79VXvL4xZxL
	 dcsT3KfLnzj8gK/+30I6SWDezsirCGZg7p5HWJ5UR95dTwJYBc1xl5aYPuwpDizlWKw9s
	 DqSDqbfmQEPKV11/9C+EvDSjkGkbPTHiaLqsyYMQ6DHj/wQeHJQ0uOoF32gJs0dEmGwlK
	 tieV5vxfOBSHOKC2oXVI3oHrEMbdzg9sn0HQuzTNnZdB8p0JG843B/4PTRBHpq9/yJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=slkJzzrrK3r3R+tM7uOPwQJ/dVKmERj9wH5MODddrAY=;
	b=dODSt5W79zcmxpwN6KvcNshhcO02isa/xlosAge2mMfYduZHw9zWSfZKsO6WT5CqveTU
	 phkluX7z4cmNkjnWanrxuplpzDAEejayOGt2DABLeJuPLGGob4gatq/B4mWl0ry180MQW
	 G0/6ADjEnNhRm5eWPVi4sxgf9d8YtS/IzIOlyjbndcphEHK+X4rkX3krsNI1hSTYqVXmO
	 oR2N7KJVRSAo4XX1PvHh8r4g3p3UxDVsC3ndCbTxWiCUFGLbyBdu8RKWa4Ftw6yHoyfTE
	 RcW9hEQeBHBUnkq/prIwr0gktRKVUV0uASnOJi0T6julhR2+XcgzB4zo3Ds3+Ppe5rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Q5p1wtQa;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEF606A6AD
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4BEF606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Q5p1wtQa
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-921276742e3so40299496d6.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795513758; x=1796118558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=slkJzzrrK3r3R+tM7uOPwQJ/dVKmERj9wH5MODddrAY=;
        b=Q5p1wtQaGTLJdx6sfSr7iRMFSa3XfzZLzupibUB9JB3S3pOtnB80RyXskBPJPszIx7
         LK0EZWtO9UYgwtiMc+N5Uiz7r/jWhpmQmRcjHqqraNPnrp69mZvyq46IsQFgx6Tf9wPN
         6gniXBsYdxhCrMyHCoRTmd7R25IunOofg7erE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513758; x=1796118558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slkJzzrrK3r3R+tM7uOPwQJ/dVKmERj9wH5MODddrAY=;
        b=zzGcWW2t8duR25JX2/+pLt1+F5HYOg9bQuAZuUm/U7fUqQ9SiItIz4E+6z5hslWBlZ
         mvkeNN7AHC5VeQr2nVSTjKfMAY1iiE7O9+4m+XziLqWbc+5dt0dMHMyMGN/hiLAvCy24
         7aGOnuuzRd8lp6m0YsmX++NtfL4wi9QRnnGL7AR+q2q25QUuHyv037RXgpQ6wSD0ciDk
         9mWjrdSf3ZgenrVWbkfTutkzaFU2wl8jXw49bbSa26DyxmL9pPKPzWLL3J2cD7HPRjf7
         UgZCo014lfBs/SsriR/7SF1yJNdAGzw3KyfXDmd1VdFhKA4vXOubIpa1FkxDEvy0uFL5
         bYsg==
X-Forwarded-Encrypted: i=1; AL+hErHWnqKBRjk2iBvFfpEpUs/q/38Hp+0+K+mSyNBFJmSAxeVdv3y+9vL3PBXFqgAIOQo5GfD3dCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CYA1j7l+l8LQdnGIhblpBDD5OYl4SszKpoFL/fbSlVhzoMwhx
	ZVhkSgjp41Tpwp6fzY0OEHGOsoCVhdbiikzpZY+d6dBL4DfV8qex8F16/OOlNkxkxQ==
X-Gm-Gg: AZFdTZcTQkrJ6yluKoscawRRmmQYfOH9VPPZPy9jufAaHRocSrZceEpW3Uc55y8tjL6
	sablcKAp9UeehyC3EmaKGBFsz5/Kxjx7kjoAWjqcfbrI34nA/JWBNbT7Wcy3UtflmmP71yCtK82
	j9D1Xld0bYrnLwgZK/vYE/IEYT+PeD6JiSZ2vajfI7J3nO0OI+8sGkoSgjWMRUl8RgFfqrwYIq0
	4uY5hp05pz34OlpWBJJmWYx5XYkD6gKVdUkmPCMI55XxNV0njYZZtrKBS5t5LLWZKvPUCrO8eXm
	BwD3pCo6S3EKtDgZwgdfGvIgo8wOWJxoyA1NXBKdKNvPpiz4DFtlPOv6V68l+jd9UUsa+hSnr1O
	EpFaP/9Koo0k3gyiv9HkwbZwSFCTQ6WNMHrMBdqbLaKNWaXBAz8Cwr5ISwW7EKkZv46jlDAC2DR
	87IiqCWM6RNA50P7RZ4L4yiXOhbMSSS2Vmlmg50JcNnJL2mEQq/wJHQiEkMQwbft8LXXz77qoPi
	ZWUIo/oSwljk8gW4ophjg+yEc8SOuv+wr3nF6ysDdkYWz35Sv9GPmYOLslQSBwfgVAW3m3ahhOE
	fEQQXZAzi2UsJ+1n8NstHQEWDqDi0prJJhTjrWlhSgMPutmgHQXeMEigXGBkrjTLHFXp0wnzG/q
	3Ng9H
X-Received: by 2002:a05:6214:124e:b0:921:2a6:c6d9 with SMTP id 6a1803df08f44-92134ade7cbmr264015476d6.51.1795513757772;
        Tue, 24 Nov 2026 01:49:17 -0800 (PST)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349ec64csm130484506d6.28.2026.11.24.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:49:17 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v7] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Tue, 24 Nov 2026 04:49:04 -0500
Message-Id: <QDISC-6HS9.v7.r0.20261123194720-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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
Link: https://lore.kernel.org/netdev/DN09UU4NHKLV.29WR92GGDPBP5@gmail.com/
Link: https://lore.kernel.org/netdev/179543888086.3135.17583427226707859195@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v6 -> v7:
- the code is unchanged.  Patch 2/3 and patch 3/3 of the v6 series are
  held back for net-next: 3/3 depends on a neighbour guard that is still
  in review, and 2/3 has no effect without it.  This patch is therefore
  reposted on its own.

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
2.43.0

