Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316347D443
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261063; cv=none; b=r2ssYCcS9RdEe5WTgQMk7OzGSu5WyosNC1Rm8bAkEUJbR3jgy+ucK5FLpFUP8QPRoNiLAaE3IdfLbf8o520WpDcNPqRVRELcI3FiadLCTj0d99egkBdfnA2lis2rKWP1LRNAbOExwdHLn1vE/ou8KN637zJ19ynb2zE6K4Opgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261063; c=relaxed/simple;
	bh=N6avd7MeK4NbLGu/XuilshXuWBAk2fLNlClMcnjt4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDeYH/KQIXP19n2KB/jvMQWMfqR/2DrV6meDCnICI2z+tTwigrWDg5onGvenf4a82jlpEHZRwgkmc05TdhcbQpkf9mkYVguRHyqYBZgclXZylRBg87uNLDA4HEGdvk1JvPYvVKyHgV4+9Qj3wLYiItyPQ/fEUJP04W7qsGIF7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU0uW2pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU0uW2pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2EF1F00A3F;
	Tue,  1 Sep 2026 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261061;
	bh=nOh1o003OeFkrMXQgdJfC8LwHKqe8TsSL7aEnjBPkPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lU0uW2prLCgIc3Vi9OBlMDN7edJ1v/zH0VCgg3XUrPy4PvuudhKVC2Y6BS96K1khP
	 34E6MR96vvjtr5UBh2Tv0a4ES5a6KckZw5gzmIYDW/vO/2rXKFTBDoBNDAiqE5b997
	 /5/wPZHe8Vq3bcVhsiEbBgLsfZCSat3rCAEMpJRYgdPc9Ha53rruTXdY0CqF3dPIcH
	 RyQ8Q6SFTRYhcY8NPp6pblPLTjABOmdjRlKQc0f/yoHZVG5BpsYiKX2HzhlziBSbz3
	 iYrZFn4iLByVRrzHhnkxzBR1MXZAfVbM6hEXm5NP9vKi1cHwA7RbzYiCLGxe5JwpZX
	 x237/v/a43h4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] ipv6: add some unlikely()/likely() clauses in ip6_output.c
Date: Tue,  1 Sep 2026 07:10:37 -0400
Message-ID: <20260901111041.4174429-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901111041.4174429-1-sashal@kernel.org>
References: <2026083105-defuse-publisher-6b6c@gregkh>
 <20260901111041.4174429-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2855e4925416c5900a9c6cece11f4a2e56bf6e63 ]

1) daddr is unlikely a multicast in ip6_finish_output2().

2) ip6_finish_output_gso_slowpath_drop() should not be called often.

3) ip6_fragment() should not be called often.

4) opt is unlikely to be set.

5) ip6_xmit() and ip6_forward() mostly sends not too big packets.

6) Most __ip6_make_skb() calls are for UDP packets,
   not ICMPV6 ones.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_output.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2f4858fc2d489..c1227bfeb8496 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -83,7 +83,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	hdr = ipv6_hdr(skb);
 	daddr = &hdr->daddr;
-	if (ipv6_addr_is_multicast(daddr)) {
+	if (unlikely(ipv6_addr_is_multicast(daddr))) {
 		if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
 		    ((mroute6_is_socket(net, skb) &&
 		     !(IP6CB(skb)->flags & IP6SKB_FORWARDED)) ||
@@ -187,8 +187,8 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (unlikely(!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
+	    !skb_gso_validate_network_len(skb, mtu)))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -210,8 +210,8 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 	if (skb_is_gso(skb))
 		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if (skb->len > mtu ||
-	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
+	if (unlikely(skb->len > mtu ||
+	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size)))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -301,7 +301,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		}
 	}
 
-	if (opt) {
+	if (unlikely(opt)) {
 		seg_len += opt->opt_nflen + opt->opt_flen;
 
 		if (opt->opt_flen)
@@ -354,7 +354,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->mark = mark;
 
 	mtu = dst_mtu(dst);
-	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
+	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 		/* if egress device is enslaved to an L3 master device pass the
@@ -653,7 +653,7 @@ int ip6_forward(struct sk_buff *skb)
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
 
-	if (ip6_pkt_too_big(skb, mtu)) {
+	if (unlikely(ip6_pkt_too_big(skb, mtu))) {
 		/* Again, force OUTPUT device used as source address */
 		skb->dev = dev;
 		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
@@ -1365,7 +1365,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	/*
 	 * setup for corking
 	 */
-	if (opt) {
+	if (unlikely(opt)) {
 		if (WARN_ON(v6_cork->opt))
 			return -EINVAL;
 
@@ -1872,7 +1872,7 @@ static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
 static void ip6_cork_release(struct inet_cork_full *cork,
 			     struct inet6_cork *v6_cork)
 {
-	if (v6_cork->opt) {
+	if (unlikely(v6_cork->opt)) {
 		struct ipv6_txoptions *opt = v6_cork->opt;
 
 		kfree(opt->dst0opt);
@@ -1928,7 +1928,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	__skb_pull(skb, skb_network_header_len(skb));
 
 	final_dst = &fl6->daddr;
-	if (opt) {
+	if (unlikely(opt)) {
 		if (opt->opt_flen)
 			proto = ipv6_push_frag_opts(skb, opt, proto);
 		if (opt->opt_nflen)
@@ -1956,7 +1956,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
-	if (proto == IPPROTO_ICMPV6) {
+	if (unlikely(proto == IPPROTO_ICMPV6)) {
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-- 
2.53.0

