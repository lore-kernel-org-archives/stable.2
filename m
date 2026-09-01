Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204259B56
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261082; cv=none; b=e+1B5DJHF/p1SMqHhgU4eRjDZZYPEZeMyurshRo8mawsltZ8D49cmCxryk+7dxw9FUDL00ruQJPvy+QCQ16FVxJrymbDaMID1/JmOinhgbdPYHmVY48JYuPqlEKHthBHuZ1+IPNgo8Emvxt7pW01DuWs8v/TpNXfEWaq1fF2iHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261082; c=relaxed/simple;
	bh=w71MILykEuIG0TQw0X6JC7Rh7MLia/ZSvcQ4o9ym4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV0RtQpLI33iJQ9CgBE40/S97Ji3azjadQqyFmIYS2IL6R/024bK08Ol+0E6mGwq0BjeZT3kYs+r+5uIoXrEH2lVjlF8gF7HjEHMDdz4pZYFrFfv7Z/f1P2IpDbmCS2/QqLSuDJzvIPrwIE/tz//ZFc+BdJjLr92sKmI4oU5ci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAHlWrT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAHlWrT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D761F00A3E;
	Tue,  1 Sep 2026 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261080;
	bh=Rhw8gyfK61/TEM194+4i0Kxq9WfAv8+sko0Oy3umWrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gAHlWrT7Xxqo4U2bZEISfb0PioSdSrQVWOb2kkAN746hQTlQTG27IsIc0DxZ4KyAO
	 YvdlI3jpWXFfkdvtO2c+ZonhUSuHP2854kUTTTahAymU5ZdLcRBA/5ri+3OVSdP4US
	 uBegeeVK7LOxAE3JGvhER88a9j6eT6Q/TbmIUOlSOC+MO2suAxP2qM3xVdEcdsKJ8g
	 CMCUmlDJYMEolqs0/nQ7bCuaiTjR5mIBIuK6yJXaBZRci5isEDWwm9H5T1g0tbJp0t
	 YpzztCPy8+iotfqD7qS+Uxkton3NTzip76RbkOrqp1TqPx7eFDzhOiIAAeU+NJDmTE
	 ASk4/yVO/hYpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] ipv6: use dst6_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 07:11:14 -0400
Message-ID: <20260901111115.4175900-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901111115.4175900-1-sashal@kernel.org>
References: <2026083114-maturing-resize-d958@gregkh>
 <20260901111115.4175900-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b40f0130a23b6bab8b359e158a40af81f11f14be ]

When we expect an IPv6 dst, use dst6_mtu() instead of dst_mtu()
to save some code space.

Due to current dst6_mtu() implementation, only convert
users in IPv6 stack.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c       | 2 +-
 net/ipv6/ip6_output.c    | 6 +++---
 net/ipv6/ip6_tunnel.c    | 4 ++--
 net/ipv6/ipv6_sockglue.c | 4 ++--
 net/ipv6/route.c         | 8 +++++---
 net/ipv6/tcp_ipv6.c      | 9 +++++----
 6 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dac2e589849df..cf7e5d1046672 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1086,7 +1086,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst) {
 		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst_mtu(dst) > mtu)
+		if (dst6_mtu(dst) > mtu)
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c1227bfeb8496..e483ea209fb76 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -353,7 +353,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->priority = priority;
 	skb->mark = mark;
 
-	mtu = dst_mtu(dst);
+	mtu = dst6_mtu(dst);
 	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
@@ -1400,10 +1400,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
-		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
+		      READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(&rt->dst);
 	else
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
-			READ_ONCE(rt->dst.dev->mtu) : dst_mtu(xfrm_dst_path(&rt->dst));
+			READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(xfrm_dst_path(&rt->dst));
 
 	frag_size = READ_ONCE(np->frag_size);
 	if (frag_size && frag_size < mtu)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 43ccc1a0a0d04..60b2583a8b2b4 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -643,7 +643,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* change mtu on this route */
 	if (rel_type == ICMP_DEST_UNREACH && rel_code == ICMP_FRAG_NEEDED) {
-		if (rel_info > dst_mtu(skb_dst(skb2)))
+		if (rel_info > dst6_mtu(skb_dst(skb2)))
 			goto out;
 
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
@@ -1195,7 +1195,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
-	mtu = dst_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
+	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
 		mtu -= 8;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1e225e6489ea1..c2ea92c0f9166 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1204,7 +1204,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			val = dst_mtu(dst);
+			val = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!val)
 			return -ENOTCONN;
@@ -1303,7 +1303,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			mtuinfo.ip6m_mtu = dst_mtu(dst);
+			mtuinfo.ip6m_mtu = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index eb2ba7c34f6f8..f7a138e317bad 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2051,6 +2051,8 @@ static void rt6_update_exception_stamp_rt(struct rt6_info *rt)
 static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 					 struct rt6_info *rt, int mtu)
 {
+	u32 dmtu = dst6_mtu(&rt->dst);
+
 	/* If the new MTU is lower than the route PMTU, this new MTU will be the
 	 * lowest MTU in the path: always allow updating the route PMTU to
 	 * reflect PMTU decreases.
@@ -2061,10 +2063,10 @@ static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 	 * handle this.
 	 */
 
-	if (dst_mtu(&rt->dst) >= mtu)
+	if (dmtu >= mtu)
 		return true;
 
-	if (dst_mtu(&rt->dst) == idev->cnf.mtu6)
+	if (dmtu == idev->cnf.mtu6)
 		return true;
 
 	return false;
@@ -2927,7 +2929,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 	if (mtu < IPV6_MIN_MTU)
 		return;
-	if (mtu >= dst_mtu(dst))
+	if (mtu >= dst6_mtu(dst))
 		return;
 
 	if (!rt6_cache_allowed_for_pmtu(rt6)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 085fc97c5a5b3..b6190f09551d5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -347,7 +347,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 static void tcp_v6_mtu_reduced(struct sock *sk)
 {
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -364,8 +364,9 @@ static void tcp_v6_mtu_reduced(struct sock *sk)
 	if (!dst)
 		return;
 
-	if (inet_csk(sk)->icsk_pmtu_cookie > dst_mtu(dst)) {
-		tcp_sync_mss(sk, dst_mtu(dst));
+	dmtu = dst6_mtu(dst);
+	if (inet_csk(sk)->icsk_pmtu_cookie > dmtu) {
+		tcp_sync_mss(sk, dmtu);
 		tcp_simple_retransmit(sk);
 	}
 }
@@ -1500,7 +1501,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst6_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
-- 
2.53.0

