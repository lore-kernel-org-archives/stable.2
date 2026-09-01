Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8B4A260A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290922; cv=none; b=qRHfWRKUWzdUBOV+GHcUmLBqCGoXLnhG/VlBqmnZsaa5bCz9cjqvQzXDWn7fF9NHxpSNTev/6l1hwoAQ2LyvQl+TuqHJbe2GGoxJOjKpL1NqTdDEzRoaTjeCN5da1vKWj2MQChIlvnjrAlTSU/PJ4foEsHdrgTOtafcivdyDypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290922; c=relaxed/simple;
	bh=S1/IqtZdAC63iD99o+TskfCOvd1uVsurNn4uZwX87BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrHM1A7eNUByfv1AM8Mm2+jlJye/ea7yAJzMNoO/7bQnqNekg4SVB9GvuHnW56C+fz+wogJbPCf1HSqX24v9Gft6rcq1IqCUKAnvVEY8QQCShb2n8oHKIUBrd/A1c2ApN3O22JtoFKyVp1ESMyyTLNnAhyzBTfZCrPVOhJ/gPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7aNN9yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7aNN9yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5461F00A3F;
	Tue,  1 Sep 2026 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290920;
	bh=54mSKp3EjnJheBart7C04LvX5+QSDFp1dM2ND8N8VAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I7aNN9yoSb/MzXHBK4P/WYNA5NKuK4EkrVN/O4iXHZ2rxU6UvrPZS0rEuvcQSNoDR
	 +SvXNGShcbstLbyG3um84gcyaSUdv7U2ysYWc25clqay8cJQE8ufBf4oH/K9nRX9Q6
	 T5LzJlOlcMYR6J9hnrxRv//9/hnaVc4UszpTkY+9jAP5+OcJKOudeKb6vI2bji+uKW
	 kziqhVcy79DvijmbqcLIXBgCq6lTmiP6V/feJ7oHvGJYQodxfl07MwK8pmoDTloxlj
	 EDjFKsRMfMuP4J4RDEuZdPzgvT6pyLECAO2TSLlHsKk8zdDri+Ie08MvdLIOYqGBcj
	 OtecknmLHWgDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/8] ipv4: use dst4_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 15:28:31 -0400
Message-ID: <20260901192833.1439569-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901192833.1439569-1-sashal@kernel.org>
References: <2026083106-glider-shiftless-2e30@gregkh>
 <20260901192833.1439569-1-sashal@kernel.org>
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
index e8c59c2051c2d..6a1ad22dc574c 100644
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
index 6fd7995ff8dd1..4989155bb9069 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1282,7 +1282,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		return -EFAULT;
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
@@ -1546,7 +1546,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	 * locally. */
 	if (inet->pmtudisc == IP_PMTUDISC_DO ||
 	    inet->pmtudisc == IP_PMTUDISC_PROBE ||
-	    (skb->len <= dst_mtu(&rt->dst) &&
+	    (skb->len <= dst4_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a00ba2d51e1b2..9b3e92045dd49 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1657,7 +1657,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		val = 0;
 		dst = sk_dst_get(sk);
 		if (dst) {
-			val = dst_mtu(dst);
+			val = dst4_mtu(dst);
 			dst_release(dst);
 		}
 		if (!val) {
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f64651c0dea6c..6cec599dc5856 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1881,7 +1881,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
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
index 753a881ce3cdf..7be24beed347f 100644
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
@@ -1567,7 +1566,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
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

