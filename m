Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886D263F4A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301300; cv=none; b=R96ivoBx4JFghC824MYCzsJbFRh4aFKucEq6jxvm8ZZRowsMf9+iywPJPBUwCIki7QtcEzG16tSsyWT0v/1NW4m3HTr24crHZqZ2m/3otT6vhqiu2QuOUjZcxRHfav4co/n2E4XOpDJ7FKUB7LE/ObbqWHgyG1+MjLGHt09M+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301300; c=relaxed/simple;
	bh=nEkkgg9rjvnXkRNu+uPQTbHQOUkRQWjrmO2Yg98Mn0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr5EFhfqdoxA99eD00F3XI0SO6mExnV8OcRVSp2VWbCAdWW17l08YLcqrsJf7YMBQMdsuuAgEFEJZeL2EUE5c6gWcHAbBX67mKLrhxENZ3HbktOyweu1Y/9VCWvSc+CqFtDOvNim7jHPXBwWpvXsxib/w20JsY40W7WtKgMgLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfUgfpZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfUgfpZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D731F00A3A;
	Tue,  1 Sep 2026 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788301299;
	bh=2UUzsxpp4k7ufuFDYlc8zhrCf8z738WWyvYdYu5oho0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfUgfpZOrYavC0aQmqATg9rw261P6G26bMzWLDXLH804D+/zH758xsoiOIE9j1SNl
	 Ak0pW3xlo0LD+NAKRlM79nNsdQRKItA36ye8R+QktcTiwhbnYv4aEAuOOW+SjXjIhj
	 KJ88qo8aVgsAh6xl5Gu+t/w1A/DLvcBoEAWVPPnI2FSCJDReGYmh+VXMbtXC4QIsZg
	 IdLrqu5LOaVReRLSoJeEGGI0SPNwNU9QjkfKJOoRW/rz+ucB+MlR0xasRhJUWIIHoR
	 KYUhxda8Jat3whcMfgcmtiaXk0VbTLJ3zHbQJG8AUBVZ4lHDWWlwGi9Su2A0zwtqAX
	 lyR34W0miIH9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] ipv4: use dst4_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 18:21:33 -0400
Message-ID: <20260901222134.1700802-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901222134.1700802-1-sashal@kernel.org>
References: <2026083106-sterile-daunting-b716@gregkh>
 <20260901222134.1700802-1-sashal@kernel.org>
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
Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/icmp.c                     |  2 +-
 net/ipv4/ip_output.c                |  4 ++--
 net/ipv4/ip_sockglue.c              |  2 +-
 net/ipv4/ipmr.c                     |  2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c |  2 +-
 net/ipv4/tcp_ipv4.c                 | 13 ++++++-------
 net/ipv6/sit.c                      |  2 +-
 7 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 49c94aebac32d..b1812362f0965 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -768,7 +768,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 
-	room = dst_mtu(&rt->dst);
+	room = dst4_mtu(&rt->dst);
 	if (room > 576)
 		room = 576;
 	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index fb64f5fcc422f..ffa8d6363a820 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1262,7 +1262,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		return -EFAULT;
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
@@ -1528,7 +1528,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	 * locally. */
 	if (inet->pmtudisc == IP_PMTUDISC_DO ||
 	    inet->pmtudisc == IP_PMTUDISC_PROBE ||
-	    (skb->len <= dst_mtu(&rt->dst) &&
+	    (skb->len <= dst4_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 3620dc739a5bf..f985d9a0dcdac 100644
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
index 5e582eab1ea19..1a9d499d914bf 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1860,7 +1860,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
 	dev = rt->dst.dev;
 
-	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index fbd264aa0a7ec..f64552b2cb832 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -298,7 +298,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	niph = ip_hdr(nskb);
 
 	/* "Never happens" */
-	if (nskb->len > dst_mtu(skb_dst(nskb)))
+	if (nskb->len > dst4_mtu(skb_dst(nskb)))
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f7693166c5161..6f97dfbc5343d 100644
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
 		WRITE_ONCE(sk->sk_err_soft, EMSGSIZE);
 
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
@@ -1614,7 +1613,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst4_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 4b16ddc3d6c7f..3f8e03cded539 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -974,7 +974,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	iph6 = ipv6_hdr(skb);
 
 	if (df) {
-		mtu = dst_mtu(&rt->dst) - t_hlen;
+		mtu = dst4_mtu(&rt->dst) - t_hlen;
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-- 
2.53.0

