Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17C476CF7
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346433; cv=none; b=oAOuSrkVsY/Lp6HNGOYDdR/SLz7+SGgC11RElk9oEv7UWhfVra1k9ZPx0QC4Eq4K1de4x8EwSMNAuwYotmB6sy1Y4BhDDKeCGQwn8fp1+/wtCgZ9M/0sdjGDQroPXGYFcLzFMdJU8myYA8BCg8NadNhJ9/FAeQWN5c/+duKLnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346433; c=relaxed/simple;
	bh=IVApvSPDXsgjBa1lb/jQohsQ28h/OVmXDNWPTP3r+pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUCW+F46IkIRimLM2YkeAyoqf9h1zjuZ7/JHK3QlGsyDGTi2Ld2Rkmn/ddcxQUppfIhNvZvocphKABIioy1Cc9I2shwBC3p6VsYEZhW4MNKmshhXFuvYPOmgtWuXDHjCf9PaUTJcORUjpI1dCZwgcqJo3ooJvJc8uf86EL02aFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crwhF/qN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crwhF/qN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFC81F0155B;
	Wed,  2 Sep 2026 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346417;
	bh=2CdBrJGfAV/zU7+DM31ayRMC+cDI1b81iGMrN5u4wis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crwhF/qN9eBCf6EDnOWvgfKtHSUChX2n8p3WniceSUrM5dBai45HsKf83pSnQB5uk
	 m6w/sciKyWmhd9Jwx8KwvJmPO6SjgFs1ye8oeJoAa+D/y0reuL4LkmIEq3tpWB9gaa
	 6JUqd8zGKAEuOm3VDDWvJ6V8XZmjRBYJ7VIATtjY5n+nCnrPJnsrVjHoamrYeZuYeE
	 0gMKUKnRJspNAMnR30ZkL88X7Up38ZlCwD0ce0OGHWnIf5J/omIj6WHLF2JMUL1NF1
	 zHiDOPGxehRZH7evdgMx8BdYS7UL9OB0loOHRtX4frd1ItQ3zYjAwUWQDTAfAbguEZ
	 u9F0mZ6PXhIqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] ipv4: use dst4_mtu() instead of dst_mtu()
Date: Wed,  2 Sep 2026 06:53:31 -0400
Message-ID: <20260902105332.2048804-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105332.2048804-1-sashal@kernel.org>
References: <2026083106-glisten-superhero-188c@gregkh>
 <20260902105332.2048804-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit fe8570186f100b6cc499b2f7705946baf1388cde ]

When we expect an IPv4 dst, use dst4_mtu() instead of dst_mtu()
to save some code space.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ backported as a dependency to unblock "tcp: clamp route advmss to
  TCP_MIN_MSS". Resolved conflicts in ip_output.c, ipmr.c and
  tcp_ipv4.c caused by context differences from refactors not present
  in this tree (READ_ONCE()'d pmtudisc, RT_TOS() vs inline mask,
  WRITE_ONCE() on sk_err_soft): kept this tree's existing structure
  and only swapped dst_mtu() for dst4_mtu().

  dst4_mtu() expands to INDIRECT_CALL_1(dst->ops->mtu, ipv4_mtu, dst),
  which under CONFIG_MITIGATION_RETPOLINE=y references the ipv4_mtu
  symbol directly. Two of this commit's call sites that already
  applied cleanly (net/ipv6/sit.c, net/ipv4/netfilter/nf_reject_ipv4.c)
  are built as modules, and ipv4_mtu() was not exported for module use
  (unlike ip6_mtu(), which already has a matching
  EXPORT_INDIRECT_CALLABLE() in net/ipv6/route.c), causing a modpost
  "undefined symbol" failure. Added the missing
  EXPORT_INDIRECT_CALLABLE(ipv4_mtu) in net/ipv4/route.c to fix the
  build. ]

Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/icmp.c                     |  2 +-
 net/ipv4/ip_output.c                |  4 ++--
 net/ipv4/ip_sockglue.c              |  2 +-
 net/ipv4/ipmr.c                     |  2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c |  2 +-
 net/ipv4/route.c                    |  1 +
 net/ipv4/tcp_ipv4.c                 | 13 ++++++-------
 net/ipv6/sit.c                      |  2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e919d2a5169e7..e4ff658cf617e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -762,7 +762,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 
-	room = dst_mtu(&rt->dst);
+	room = dst4_mtu(&rt->dst);
 	if (room > 576)
 		room = 576;
 	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 89120dcc9060c..0306fdfd21942 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1266,7 +1266,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		return -EFAULT;
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
@@ -1532,7 +1532,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	 * locally. */
 	if (inet->pmtudisc == IP_PMTUDISC_DO ||
 	    inet->pmtudisc == IP_PMTUDISC_PROBE ||
-	    (skb->len <= dst_mtu(&rt->dst) &&
+	    (skb->len <= dst4_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b300d0988d525..2f2dabc2df064 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1631,7 +1631,7 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		val = 0;
 		dst = sk_dst_get(sk);
 		if (dst) {
-			val = dst_mtu(dst);
+			val = dst4_mtu(dst);
 			dst_release(dst);
 		}
 		if (!val) {
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6e4f91e76e2d3..125ece1bc46be 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1872,7 +1872,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
 	dev = rt->dst.dev;
 
-	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index e89a4cbd9f5df..bd3391204e5e6 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -151,7 +151,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	niph = ip_hdr(nskb);
 
 	/* "Never happens" */
-	if (nskb->len > dst_mtu(skb_dst(nskb)))
+	if (nskb->len > dst4_mtu(skb_dst(nskb)))
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 65a6781743013..088b8d794cf1e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1406,6 +1406,7 @@ INDIRECT_CALLABLE_SCOPE unsigned int ipv4_mtu(const struct dst_entry *dst)
 
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
+EXPORT_INDIRECT_CALLABLE(ipv4_mtu);
 
 static void ip_del_fnhe(struct fib_nh_common *nhc, __be32 daddr)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 855cca214a021..502365adc4fab 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -352,7 +352,7 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -364,15 +364,14 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 	/* Something is about to be wrong... Remember soft error
 	 * for the case, if this connection will not able to recover.
 	 */
-	if (mtu < dst_mtu(dst) && ip_dont_fragment(sk, dst))
+	dmtu = dst4_mtu(dst);
+	if (mtu < dmtu && ip_dont_fragment(sk, dst))
 		sk->sk_err_soft = EMSGSIZE;
 
-	mtu = dst_mtu(dst);
-
 	if (inet->pmtudisc != IP_PMTUDISC_DONT &&
 	    ip_sk_accept_pmtu(sk) &&
-	    inet_csk(sk)->icsk_pmtu_cookie > mtu) {
-		tcp_sync_mss(sk, mtu);
+	    inet_csk(sk)->icsk_pmtu_cookie > dmtu) {
+		tcp_sync_mss(sk, dmtu);
 
 		/* Resend the TCP packet because it's
 		 * clear that the old packet has been
@@ -1593,7 +1592,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst4_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 1027bd104941b..d62ce60fcdf6f 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -967,7 +967,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	iph6 = ipv6_hdr(skb);
 
 	if (df) {
-		mtu = dst_mtu(&rt->dst) - t_hlen;
+		mtu = dst4_mtu(&rt->dst) - t_hlen;
 
 		if (mtu < 68) {
 			dev->stats.collisions++;
-- 
2.53.0

