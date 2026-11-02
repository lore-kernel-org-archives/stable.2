Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614879;
	b=WDowsXlvKwvl/eQ1s/ab5Gdpq6xPx6Isf3herRC5tOlMUYfD0QQd0fJ1XoAt3WXw392A
	 7KDsEaVjYH7xhZm4zsuWp1u99Lqh2JKOmIdWYiGzytwUYtWJZjC74thAjTh7HBRfBKm4+
	 E12jA0V7ZTHVM/2tDgg4ScCx84Zho3On2D5jCL8NnZJtKe/vh4XloVNi2GQYGAuXp7UC4
	 Rhn8mSF+a6pBflAb4ObCXZpn+DOcJJl7OwhXbvcyWKGOBqkoufuzxTfzPrn/fkLXHS2Zq
	 1fW3ZpsGmGU0wgLhEhkp5LPPMoCz6KKMuk9W4zYWGKpR1GDU0FRgUF1UptBuur7Eu4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614879;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis;
	bh=6K1OLWSy14GgS+LD5ybY98SZc0eOkHCe5EW2RTGCc4s=;
	b=1Qj5haAfsYwb17dgwUwnWkf8ZWUqdzeGvp9bvYTAVWPIMoc4jJEF8gnZTGOn0/6ZOP/G
	 p0otaVIGnRxBpqkHGdMKwBE9/1dlwDGA8cGzTxJAcdY1Up9A6h4JehALLDh5RgtMlwEoI
	 J9YaM9bjs+1W90TWRxaM9Bn8gtGQBXI8vmk3+NbYG/Mqz1u/oEW9lliiPOD/0QX446A1S
	 OmcndP+ozGFvWGNSAxWv8bfbzM4TPxcDmCs0bmC4/45sZIEvJHNdChR4rUIe4XfT0bu7u
	 ONx7sm2o0dTPt/9/sOe1WafBUy+611dhjNfJSKR7uq2vSMbT3iXD2Fg8cioRte1f1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Cu8Ae1JS;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E5606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 051E5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Cu8Ae1JS
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A22lA9C2878320;
	Mon, 2 Nov 2026 10:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6K1OL
	WSy14GgS+LD5ybY98SZc0eOkHCe5EW2RTGCc4s=; b=Cu8Ae1JSfWSKPdsxuRQfO
	aELXwDWaHdi0t5FZxOr1S/WLbigk2hYn/IbaIH2mn7RZAPEVb2tIjFgWsBqKKzve
	0qBn+jrGbr8YoNwtkGI8J4BgrJ0bVFZFnaXQxBvntF7oUS4FY7rGZtp8dviHDAbQ
	r9SnkZa6QD+2AgMjxWxNKDj8XNDggftwLTU3MItE/6KiNslVzT/P2Fvb/1g9OaEM
	AD0pt+IBIaeB6HLF3T+mNZrd1VOPvj22LT0R4xCpRRtDSXf2OMUSAlSXJCkn90IM
	U+2Y6+4cLPjI5WrgED99OaH78+xmLrwCUCh2kNN+aDHGdwcP8wL40f+5akxS+RsD
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn8cfskf8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CxmV1424226;
	Mon, 2 Nov 2026 10:21:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-4;
	Mon, 02 Nov 2026 10:21:13 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 3/9] ipv4: start using dst_dev_rcu()
Date: Mon,  2 Nov 2026 02:20:58 -0800
Message-ID: <20261102102104.1558500-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-ORIG-GUID: 0xy3Y3_qVzxKxssnpdbp7k9yrq53RQM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXzYcWIpB2aMYx
 jb4+Kcn2L65+lu1EgdDwJsAA5m8DGlr8BWGB/1RYyzW92OhOLuKKU1EvYVqZ8FekPuB9PSyAgs1
 RF4RheD1gVUX0sL+3/r496QXs4jMDAMExmxNZQrxJ0rvtJ41r6usBu4rXB3nDLScx7B7VfuFezE
 DtcrmTsyeA2qGpP8Hzs46LdcNpDbgl6gfQQQXfBxywKQAASTCGKobr8LLlo5y+LHrS/5shOxuMa
 5Al6bQu6kiuZbkVK6SHj4OYJ8VZ7BW20l5eW+H52NeTXiUOx+vdf3DQAYh6UMjMTYRNS1AMNhZm
 z7Xzh6y2UVPsm3FNgLKS+/haA1nm65MHqnotD9pEDY3P6MOvtb7dsIsVyB/C5Jt2ow6EZqCbh1Q
 BaGAL/GIADKo1zlvd/mX9284lcAUjXRC944xmrg/MhoB3ILh0Yrin2I8M8BzgfKc9KpaKI/3gdy
 +4cdmZ0hquArHJkaWYlEW7vqDBHD3eSwn/PaqZlA=
X-Proofpoint-GUID: 0xy3Y3_qVzxKxssnpdbp7k9yrq53RQM6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9ddxDrpihBtY
 S4xBcA18656UXDZrMZpzH6tpFc2ftziWXknWfNaZKrSJtrTW9kYCmgSLO+w546/Os1wyU3rnXS7
 BQgluPpr1rnmdikOiT74XGz0OSs1bObgGOIDVmRcfCDaTJQ38i+G
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ae8641a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=4JYK61xmR1osLatadLYA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8 ]

Change icmpv4_xrlim_allow(), ip_defrag() to prevent possible UAF.

Change ipmr_prepare_xmit(), ipmr_queue_fwd_xmit(), ip_mr_output(),
ipv4_neigh_lookup() to use lockdep enabled dst_dev_rcu().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org

Conflicts:
	net/ipv4/icmp.c
	net/ipv4/ip_fragment.c
	net/ipv4/ipmr.c
	net/ipv4/route.c

 - Supply dst_dev_rcu() and skb_dst_dev_rcu() in include/net/dst.h; this
   baseline has neither helper. Use the checked READ_ONCE() definitions
   present in 5.15.y, without changing struct dst_entry or importing the
   broader dst->dev_rcu conversion. The patch is self-contained.
 - Preserve the four-argument inet_getpeer_v4() and inet_putpeer() calls.
   Return before taking RCU for ICMP types exempt from rate limiting;
   release RCU on both the loopback and rate-limited paths.
 - Keep ip_frag_queue(qp, skb) and ipq_put(qp). Add RCU protection before
   selecting the device and release it on both queue lookup outcomes.
 - Use dst_dev_rcu() in the older ipmr_queue_xmit() implementation. Add
   the IPv4 cache-replay RCU wrapper from b07a9b26e2b1 ("ipmr: Always call
   ip{,6}_mr_forward() from RCU read-side critical section"), which this
   baseline lacks. RTNL alone does not satisfy the checked accessor.
 - Nest ordinary RCU inside the existing RCU-BH section in neighbour
   lookup. dst_dev_rcu() checks ordinary RCU, while the older neighbour
   hash walkers still require BH protection via rcu_dereference_bh().

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/dst.h      | 12 ++++++++++++
 net/ipv4/icmp.c        | 10 +++++++---
 net/ipv4/ip_fragment.c |  9 +++++++--
 net/ipv4/ipmr.c        |  4 +++-
 net/ipv4/route.c       |  5 ++++-
 5 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9114272f8100..b3522d3de8c8 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -547,6 +547,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
+{
+	return dst_dev_rcu(skb_dst(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e919d2a5169e..dab78347f7ce 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -315,24 +315,28 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 			       struct flowi4 *fl4, int type, int code)
 {
 	struct dst_entry *dst = &rt->dst;
+	struct net_device *dev;
 	struct inet_peer *peer;
 	bool rc = true;
 	int vif;
 
 	if (icmpv4_mask_allow(net, type, code))
-		goto out;
+		return true;
 
 	/* No rate limit on loopback */
-	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
-	vif = l3mdev_master_ifindex(dst->dev);
+	vif = l3mdev_master_ifindex_rcu(dev);
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif, 1);
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
 	if (peer)
 		inet_putpeer(peer);
 out:
+	rcu_read_unlock();
 	return rc;
 }
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index ec2264adf2a6..5cdc65a5c010 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -475,13 +475,16 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
-	int vif = l3mdev_master_ifindex_rcu(dev);
+	struct net_device *dev;
 	struct ipq *qp;
+	int vif;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
 
 	/* Lookup (or create) queue header */
+	rcu_read_lock();
+	dev = skb->dev ? : skb_dst_dev_rcu(skb);
+	vif = l3mdev_master_ifindex_rcu(dev);
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
 		int ret;
@@ -491,9 +494,11 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 		ret = ip_frag_queue(qp, skb);
 
 		spin_unlock(&qp->q.lock);
+		rcu_read_unlock();
 		ipq_put(qp);
 		return ret;
 	}
+	rcu_read_unlock();
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 	kfree_skb(skb);
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f17b36a97848..ee5860cf7650 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1012,7 +1012,9 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 
 			rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
 		} else {
+			rcu_read_lock();
 			ip_mr_forward(net, mrt, skb->dev, skb, c, 0);
+			rcu_read_unlock();
 		}
 	}
 }
@@ -1870,7 +1872,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 			goto out_free;
 	}
 
-	dev = rt->dst.dev;
+	dev = dst_dev_rcu(&rt->dst);
 
 	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b7db0255af6e..088c207c10fa 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -446,10 +446,12 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev;
 	struct neighbour *n;
 
 	rcu_read_lock_bh();
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 
 	if (likely(rt->rt_gw_family == AF_INET)) {
 		n = ip_neigh_gw4(dev, rt->rt_gw4);
@@ -465,6 +467,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 	if (!IS_ERR(n) && !refcount_inc_not_zero(&n->refcnt))
 		n = NULL;
 
+	rcu_read_unlock();
 	rcu_read_unlock_bh();
 
 	return n;
-- 
2.55.0

