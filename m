Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274074582CC;
	Fri, 21 Aug 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306066; cv=none; b=J1Q7IbrPXgr5rwqbxbgx/1LnMPCsl/7hrMqtXiBvNusfX22B2Jxh5jS5fYDrafOLeix2qzH/34R4I2LF21JWUKx2XJ/KCzsPrrAMvjgsYy0XPOaFRRp/cfNBmr+5iu1CsOxomR2w4osKiN9P09Rkaa4jyqNgSLEgAETDsYXCmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306066; c=relaxed/simple;
	bh=BGmHDxiFYHY4kPR/JdBo+7Z66TmpdV4ofzoXGOopKrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d0iSKnssxD0tQ7vGOwjS3m4gWQcSPD+sK8S0O/nG6rJGJxOp8yqnzFaK9q43vjuIgPNuKaarMojbFeoZGmmqFDqdLZzkRsNzTv1YneQEu5lEpGTe8fJXHfWrRafe6WDAA0FsQLfNRmlqV9BafyT92TlyK8Qj6gQC0jQm3AlqPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u3e7SAI0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u3e7SAI0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 324054E4131B;
	Fri, 21 Aug 2026 09:54:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0418F604AA;
	Fri, 21 Aug 2026 09:54:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A81A11C76E5B;
	Fri, 21 Aug 2026 11:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787306051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=c9YITSXIgGE2B/kMS/461SXosMkhhSbjtgv8B7JJPqE=;
	b=u3e7SAI0PMJA18ChWZ7WfeDOfJwELWatnF6gf21AA4wvn4ERKidoiGwYB/yuPGVZNq6z7W
	Ino2mKeV61Q0uNjTRKb5mrKwlk6/4UzCOk/Qx2ktG1fIl3C4YXb0/KOZNr/Tu6cg2awshV
	7+KusLxx66nSE8X0FkS3WAO2ZgnR/7UwT7VZNSMc/RA3JQpQ42Je2RiuGznGZ2sqrBXbaK
	o9cT6BMJdlNLVYecDvD5bOMN+LKNKnYQ88GzwDGXspkAIBJLCNNL/q/89Btz0mmvFbj+VC
	Ylydj83x4oDc9duVlLI1IRxdLS7uBefT0+gOZC9O0IA3RyQa8EZKhJl/84mkYA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Fri, 21 Aug 2026 11:54:04 +0200
Subject: [PATCH 6.12.y v2] ipv4: start using dst_dev_rcu()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-cve-2025-40074-v2-1-7cb3fcb7c3ac@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBREr0L+2pLf2gK68h6GBS0fqdHWtNhIC
 He34Nrlm8zMWyBSsBThXCwQKNlovcsgDgWYsXM3YrbPDAJFhY1AZhKxDIpJxFoyLXRjUB2l6Dj
 k0SvQYD/74RWqkotyhvaXx7e+k5m2t6052jj5MO/mxPf+P0nijLMBperVUMuTwov2fnpYVxr/h
 HZd1y9daAxryAAAAA==
X-Change-ID: 20260820-cve-2025-40074-b2b8c05342a1
To: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
 Wei Wang <weiwan@google.com>
Cc: thomas.petazzoni@bootlin.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787306046; l=4578;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=Rs+OgxfWvKo17bICFv2f1PtvOvHT5/QaqY3slxWMxvM=;
 b=9hGYQAUCT3DMoZc5SvLlFdTCptF46EknyxPcZTPdbi1zPVuAzbIn8fHdLXucHwHdSRNSyPQJ/
 CuNyVzU4OujAhWDZa1tlGDTxdTbg8Rmp4+7/v7NrCeiIEcMdctTQp4H
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8 ]

Change icmpv4_xrlim_allow(), ip_defrag() to prevent possible UAF.

Change ipmr_prepare_xmit(), ipmr_queue_fwd_xmit(), ip_mr_output(),
ipv4_neigh_lookup() to use lockdep enabled dst_dev_rcu().

[ minor modifications to fix conflict , added rcu_read_lock and unlock
to ip_defrag function ]

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
Signed-off-by: Miguel Gazquez <miguel.gazquez@bootlin.com>
---
Changes in v2:
- Added rcu_read_lock and unlock to ip_defrag function
- Link to v1: https://patch.msgid.link/20260820-cve-2025-40074-v1-1-f045d5f74950@bootlin.com
---
 net/ipv4/icmp.c        | 6 +++---
 net/ipv4/ip_fragment.c | 9 +++++++--
 net/ipv4/ipmr.c        | 4 ++--
 net/ipv4/route.c       | 4 ++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index c7af8b914e13..1fc967a60bb9 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -320,17 +320,17 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 		return true;
 
 	/* No rate limit on loopback */
-	dev = dst_dev(dst);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
-	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
 			       l3mdev_master_ifindex_rcu(dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	rcu_read_unlock();
 out:
+	rcu_read_unlock();
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	else
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index d3abc84a6c02..f8919b2543e1 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -483,13 +483,16 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
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
@@ -499,9 +502,11 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
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
index de0d9cc7806a..ad0b922ebc73 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1906,7 +1906,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		goto out_free;
 	}
 
-	encap += LL_RESERVED_SPACE(dev) + rt->dst.header_len;
+	encap += LL_RESERVED_SPACE(dst_dev_rcu(&rt->dst)) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
@@ -1943,7 +1943,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	 * result in receiving multiple packets.
 	 */
 	NF_HOOK(NFPROTO_IPV4, NF_INET_FORWARD,
-		net, NULL, skb, skb->dev, dev,
+		net, NULL, skb, skb->dev, dst_dev_rcu(&rt->dst),
 		ipmr_forward_finish);
 	return;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4dce0de6ab89..0f31ae4da3d9 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -413,11 +413,11 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst_dev(dst);
+	struct net_device *dev;
 	struct neighbour *n;
 
 	rcu_read_lock();
-
+	dev = dst_dev_rcu(dst);
 	if (likely(rt->rt_gw_family == AF_INET)) {
 		n = ip_neigh_gw4(dev, rt->rt_gw4);
 	} else if (rt->rt_gw_family == AF_INET6) {

---
base-commit: 7155f3c7a69b8480e785f2a4252d31df95daa8d1
change-id: 20260820-cve-2025-40074-b2b8c05342a1

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

