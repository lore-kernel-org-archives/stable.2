Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C02359A89
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272290; cv=none; b=cH2knYy8MPVLVslORwrBB6roYT98hGOGsi1AukcsAU/YGi7kLniRsG/sqQDRRRGcTnF39L/4qXoVMkmd6SesSrp7uPgiPBcppY8Y3vsG/sdOMGnJi78ipMUxdwgsf7NqtFV/KqyW4YlQB4qjJANkqNVnBeLa+cALau2bviHagUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272290; c=relaxed/simple;
	bh=i6Jy8hjACAAnGpE+rxLvc4frN91cughvXMs/1bcDst8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVb0G5Laz63XCvLqOu09/EUj/RZp+nkE57NhmJRkcQp7kit40biYLM03ESK61b3X0n63CGhDvaOpVgVP95/xnuEnqiV+amwUvfkXHFtFrQbEMbyCu9hmKexqKejWalWxFz3BnAT8NidW1xiE9KFB9hgYGIFqEncenma0oFr7QrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqgP82hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqgP82hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9071F00A3D;
	Tue,  1 Sep 2026 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272289;
	bh=rlI5k4rJDF9wj610iAsq9inXC95AZholO5+826xXu4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZqgP82hn6e1ErWiPCokaFwNSEYWli9UUhi6nY7K/idVC7WkXcKNENNNsd3ZZP0v5K
	 enKI/m84b93vOQ8+mP7feZZqnGKmocDBY7ZYkYAOuFaGIIIja1V2Fhb0JaSgY4D3Dd
	 Aznl7W8LGr4qo1K84OQWO3gwCbhAhGaw5R17fa+k3WZ1jDtBIcPDjSPI7Xu1sgK88b
	 JtxsUl7XNNHHDEPfMWekaMN1x9p1EnBlYpPx7Yq2bW55VX0OL4QZ5QLRDWk5imHfu2
	 4zwnJKgbXjK8ugGm8mYOZHlXICURwjViCLN3Ypw0CCazvCRfb0/+93jxRJwNQI2MwX
	 4XKjuBkQo32iA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] ipv4: use dst4_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 10:18:03 -0400
Message-ID: <20260901141804.1031618-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901141804.1031618-1-sashal@kernel.org>
References: <2026083105-buddhist-verdict-4f97@gregkh>
 <20260901141804.1031618-1-sashal@kernel.org>
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

[ Resolved conflicts in net/ipv4/ip_output.c and net/ipv4/ipmr.c,
  caused by unrelated local/upstream divergence unrelated to this
  commit's own diff:
   - ip_output.c: upstream's pre-image already has
     'pmtudisc = READ_ONCE(inet->pmtudisc);' hoisted out of the if
     condition in __ip_make_skb() (from a commit not present in this
     tree); kept this tree's un-hoisted 'inet->pmtudisc' form and
     applied only the dst_mtu() -> dst4_mtu() substitution.
   - ipmr.c: this tree already has an extra 'dev = rt->dst.dev;'
     line before the MTU check in ipmr_prepare_xmit() that upstream's
     pre-image doesn't carry; kept that line and applied only the
     dst_mtu() -> dst4_mtu() substitution. ]

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
index 7c4c7b7fe3846..69cac8b20a217 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -785,7 +785,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 
-	room = dst_mtu(&rt->dst);
+	room = dst4_mtu(&rt->dst);
 	if (room > 576)
 		room = 576;
 	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 150cdea8aacbe..9698290ef7293 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1304,7 +1304,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		return -EFAULT;
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
@@ -1438,7 +1438,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	 * locally. */
 	if (inet->pmtudisc == IP_PMTUDISC_DO ||
 	    inet->pmtudisc == IP_PMTUDISC_PROBE ||
-	    (skb->len <= dst_mtu(&rt->dst) &&
+	    (skb->len <= dst4_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 1a6952921e07b..a5affb6e280ef 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1642,7 +1642,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		val = 0;
 		dst = sk_dst_get(sk);
 		if (dst) {
-			val = dst_mtu(dst);
+			val = dst4_mtu(dst);
 			dst_release(dst);
 		}
 		if (!val) {
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index af9412a507cf3..074662e2daed6 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1895,7 +1895,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
 	dev = rt->dst.dev;
 
-	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 1632cedcd348c..76320f1ba4996 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -296,7 +296,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		goto free_nskb;
 
 	/* "Never happens" */
-	if (nskb->len > dst_mtu(skb_dst(nskb)))
+	if (nskb->len > dst4_mtu(skb_dst(nskb)))
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3f9e1cfde0083..97e3ce3e60f98 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -363,7 +363,7 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -375,15 +375,14 @@ void tcp_v4_mtu_reduced(struct sock *sk)
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
@@ -1624,7 +1623,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst4_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index ac38d4aa09ddc..b36fc57acf061 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -968,7 +968,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	iph6 = ipv6_hdr(skb);
 
 	if (df) {
-		mtu = dst_mtu(&rt->dst) - t_hlen;
+		mtu = dst4_mtu(&rt->dst) - t_hlen;
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-- 
2.53.0

