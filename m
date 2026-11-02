Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614374;
	b=wfbT+Mc+W6n9esJztSy8zk5D8CjX3BGhddKnFfSkDe7rf4U2AMjew9zO8Pbi7NrxuMOb
	 juXzNb9vaPE48/V6qvIGTGkNd8k0fDg8odV4uflQFwphOhPLPaTGCxvk0NlsNP8BeX/RQ
	 f4mCd14+4wFCzYl92b43kFxRWJQCuNvp0Gc/xpmr8RaGIVtCRuHRSDM9JGPUlyNnyPNMZ
	 W0XsUK788O8UjvWR8xQLCLvnA0cLQa+TTbO8Jp5ukzkxzxbLOCzhIqRYNb6LFo0K3UAPk
	 1LSIBUXAPmJfJgsgFUkF0PnFQRm8DOM5fXTzci1AaNEUSApUP+auYtCVhPwFayR0aYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info;
	bh=upEhAo2WWbadjw3sPmk97mom8trWHIDdz/TaO4NX2gA=;
	b=ijzQZJbWYmH4Oflhswdn+Rujt+jUZtEdovSKLHmODLWlFhhfzGGQuEat5qYvg3cknz/L
	 GVqU0nj8zGbCyXFn7HJr+G+/gLjwAy7ey7IzfHAVP14f1S+qEwFlsmXpP3YYI+Ve1HU9a
	 4RlMAT2k3dRkbyXgSHLmIBuwdy7cFeTeDAKyd29ALlRPFb6ay7PqhmkghXq76fFMGlb4K
	 Xw2PCGvIhQnpU+OuBD3EbsQIsC7Hvey7JPnsRHsrobKVQ9/iX4IkV1/371vEVg7mzUHHo
	 kanHR5CK9B53p61tbsfiTzEcX3xoRBPc87bD49WU9LXczMknln7G1MEMDDU6WelJxQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oAL2Yizq;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE80606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE80606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oAL2Yizq
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1Nv3MD1184761;
	Mon, 2 Nov 2026 10:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=upEhA
	o2WWbadjw3sPmk97mom8trWHIDdz/TaO4NX2gA=; b=oAL2YizqGaUtKTnpNODMd
	duo7LWGUyHc6lP1MsgkTsKHgYTWucZq8VVoIZ5759YG3uBygqiS6udmcXG93FMIV
	rbeg1VLs66ekSkgG8ErrIpVD9EYDHV+IUbXU3HENSHIUv9Eom1c99XoloHceL+fo
	ZFqcKijICklGEeQ6fOC32IqTI2ilnUGIlyfKF43k/rotqpLoHR47I1j0MDjm3OWu
	icbkl2W7YQzK4o2FtkjQV9Cuu7Zvp7JlwPJfsLV16LE9/qKypPXBCOq2rkBd/guw
	Dgd+T4R0xTWRhAh1brsuSckmJ/u8jAcd0eG3TRPbyInOKefd00C70agIilr799gl
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn876hk7e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:12:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CuPt2995853;
	Mon, 2 Nov 2026 10:12:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-2;
	Mon, 02 Nov 2026 10:12:48 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 01/11] ipv4: start using dst_dev_rcu()
Date: Mon,  2 Nov 2026 02:12:29 -0800
Message-ID: <20261102101239.1557688-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: bOJbSAzv6qNhwoEdf4DryDN4aLjRvhIh
X-Proofpoint-ORIG-GUID: bOJbSAzv6qNhwoEdf4DryDN4aLjRvhIh
X-Authority-Analysis: v=2.4 cv=JJauIMKb c=1 sm=1 tr=0 ts=6ae86222 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=dw9mY3PTucIE_kGSVtcA:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX0m2fV1CgugVy
 pm+Fzo+eQvNRKgCOZnoFzbb7RmL3QDblE+FrLxISYBKpCPla3g+ZWqDSKNyH0jfDw4AeLgSQ2Hh
 WBNLXi//iYNy9+CxdSNp0jNoHPRwnuC89QSAAuxnPzOAm4GkzKcII3D2wHNegBLcU8dQqwbuYTB
 zT4bixN7vxXr4Zf6aMJadiRnCRNYtdxAxZLizBFbyaxNuBsFTiKZLUJI+eyYrKFkZ+TeNzxTbMK
 qSsZPcuiKmPx8nbMQjC6sp7qwm0oC9Q2SHpBUtLGpMCuz2gBHn6Eq7SgH5GBJrDujEZ+Q6xjHct
 rnNohHt3kQ4jBuwDDNijO/B99Dqr4cBtGs2RBZcxr0DLTGQrwMJnqrq43PNMqAF5H82CooAoq8D
 N8Fp2+vheGG3Oiv6Wj4PqBQ2CTWVh5dE0waqlvh5v7OfTcmZnBlAxQYGb5e/bnR2U42iBQESoQy
 HEPtzwvKvgXANJg9dbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9AKxvfDXkXMp
 Mt+qHkS3cOtLZdvW4HinfqRUPsfmiKikXWOtKQZ/sFOS28HlfNuDfV4Hiw3z6gtsij3P/pLBrud
 /alvZOx0D0bZNTKU1KjPH14SlYGSmnGPjkfgQcJOkHt3poh08eg3

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
 net/ipv4/icmp.c        | 8 +++++---
 net/ipv4/ip_fragment.c | 9 +++++++--
 net/ipv4/ipmr.c        | 4 +++-
 net/ipv4/route.c       | 5 ++++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 49c94aebac32..5f44609671b6 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -323,20 +323,22 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	int vif;
 
 	if (icmpv4_mask_allow(net, type, code))
-		goto out;
+		return true;
 
 	/* No rate limit on loopback */
-	dev = dst_dev(dst);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
-	vif = l3mdev_master_ifindex(dev);
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
index 23312d028af2..5cdc65a5c010 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -475,13 +475,16 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst_dev(skb);
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
index d5ae2df481a4..855da7c3a906 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1000,7 +1000,9 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 
 			rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
 		} else {
+			rcu_read_lock();
 			ip_mr_forward(net, mrt, skb->dev, skb, c, 0);
+			rcu_read_unlock();
 		}
 	}
 }
@@ -1858,7 +1860,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 			goto out_free;
 	}
 
-	dev = rt->dst.dev;
+	dev = dst_dev_rcu(&rt->dst);
 
 	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d504d8cdd030..b444a57498c2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -424,10 +424,12 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst_dev(dst);
+	struct net_device *dev;
 	struct neighbour *n;
 
 	rcu_read_lock_bh();
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 
 	if (likely(rt->rt_gw_family == AF_INET)) {
 		n = ip_neigh_gw4(dev, rt->rt_gw4);
@@ -443,6 +445,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 	if (!IS_ERR(n) && !refcount_inc_not_zero(&n->refcnt))
 		n = NULL;
 
+	rcu_read_unlock();
 	rcu_read_unlock_bh();
 
 	return n;
-- 
2.55.0

