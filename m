Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC53D45C1;
	Thu, 20 Aug 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220187; cv=none; b=IL5s2TjCoGqs0kZtJyZnuq09r+PwujG2cshdcPxDjJ9sghiRzKV/UZ/5sSE1ctOtPa3coev9i8SZnyEl8QBPVOEVDZRY5W04S/WxiUmWthcShILF96l29Mk6hqXJJKZ75nsApOvgJTrh0odyGH4kAOgylchaG2SCsieH1tPUeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220187; c=relaxed/simple;
	bh=yjRzldArbYODxSvNEvZ7dRry3VO1egD2am5/cK5Vqt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bd4HTGzSo9UPSko7QBv1g9Dmk6wbC7b+IkbqfsFHbNE2vum1aJFzafF+9REy1fKr+K4yGuLIacmLgL8IUqLPvFi5jYyS7tz8zGay4n8Acy83jl73qqGGgX7d7BCyzw55osIOROKZqIENk0wRSeCe3kQbMgX9s+lfglf7NubCryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mL0uwQLc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mL0uwQLc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BF9C61A1768;
	Thu, 20 Aug 2026 10:02:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9114D602B8;
	Thu, 20 Aug 2026 10:02:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D61711C760F1;
	Thu, 20 Aug 2026 12:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787220169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=J9IkcMn3tZqQRLkfuwau8kV3b82A8qd50t+xwVLTmcs=;
	b=mL0uwQLcWjES7km3xswrfFIgO3kPR+28koBeAY093sSHY69/2uCC36acHPlX0QHae4QzdI
	Nqy8HXu2SuKY6A8kgETxqJRRwkFAmti7afRrYrE+SDzWUmy2RyIxWXf6n9cJucsDJ84z0f
	a0QHXnAsMauSFXkh9PG5dSC+bdo4oAjK/5ko8l7E24c3yGm0b7atzi9gBuOPoDtNWBJz11
	PAjNBiP/lNRHC+i6ssOdJ7Myz3egTse1iH07x7d/RrLCaq8n2S5EzLq8cRwR6jFHOcqNBi
	SPGSkgtUbgu43uZHD+lGbqK8xaoAqNpvkmrzXSy00rgSGIJFWv2f2gxhKcgKoQ==
From: Miguel Gazquez <miguel.gazquez@bootlin.com>
Date: Thu, 20 Aug 2026 12:02:10 +0200
Subject: [PATCH 6.12.y] ipv4: start using dst_dev_rcu()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-cve-2025-40074-v1-1-f045d5f74950@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3bJdilIfBXjgdZV1wOaFomE8
 O5WPX6TzL8iazLNOFQrks6W7TEWuF2FeBvGq5KdiyEsHffCFGelgpY8895TkNBHbhsvg0M5PZN
 e7P0LHtHVTuoFp/+eX+GucfrWsG0flmFy3noAAAA=
X-Change-ID: 20260820-cve-2025-40074-b2b8c05342a1
To: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
 Wei Wang <weiwan@google.com>
Cc: thomas.petazzoni@bootlin.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miguel Gazquez <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787220165; l=3915;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=tyMQo+nHOrlj15/tqkrNb1JIaPH5z08HC5uc4TA6Tk8=;
 b=dedXycg5ejqcSSYocRIam//aOLzLxuxfN576X/Cn/Jm2461iKnd6u9G4/1IhaYk+xtkkpH62g
 eu2PCB8S7sxBN0d3+687/gB+GPwYJAoC7tsfwYngO2FlDCkaFuvXfzF
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

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
[ minor modifications to fix conflict ]
Signed-off-by: Miguel Gazquez <miguel.gazquez@bootlin.com>
---
 net/ipv4/icmp.c        | 6 +++---
 net/ipv4/ip_fragment.c | 6 ++++--
 net/ipv4/ipmr.c        | 4 ++--
 net/ipv4/route.c       | 4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

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
index d3abc84a6c02..790df2c5f747 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -483,13 +483,15 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
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
+	dev = skb->dev ? : skb_dst_dev_rcu(skb);
+	vif = l3mdev_master_ifindex_rcu(dev);
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
 		int ret;
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
Miguel Gazquez <miguel.gazquez@bootlin.com>

