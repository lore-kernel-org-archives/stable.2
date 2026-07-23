Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F941DDE5
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806631; cv=none; b=ssfIAxlaiH+BhR+vwnr3YMqNvnuqT3vgc8q9toC0h+fvIq5jLtzPuf0rPcZjYKEjyKwpYEcOzXK5HarNEp5mplwc46sUEvlbve/DSk/o7cPWZPAfmE60QY2NR32Mn23CVaMn6RbO6TJCs18CaTclFWixHu/Gb1hJs5h9oqYGHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806631; c=relaxed/simple;
	bh=9RGReAND6UEnDdE5f3DaaHq1qlnAxYFppqZkq5VF4k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUkgFN7kBTq1aXJGUjVmKz9lhJVCYFKNHZxE8zBx8G2Cdi63NRdoFlED4OMbww3sqXAEkaKcEC4uORRo1LC89ha4jJkX2/tlXTWpCMxHk0SkXwR/VZJVPFVx+XGlQkSOcwh7mOU0W1OEENyg5mLJLAlOw5xON4B1pI+FwQuKEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuO2VArC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuO2VArC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7B71F000E9;
	Thu, 23 Jul 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806629;
	bh=rynG4CvEG5AvkHH8E69jexEfUb2PeV7Rc++SxiJF4f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuO2VArC59f+vjUxSILzsqXYAvv4xRZF78rG9fPG9vEBSaQpF6D29hN+z1zKe+7Gr
	 9RnQ8vNNN3JFTvAMjaiAGKi7f7RSWr0u3nmd212CeUPOlcRXGlzUpw1pKMMqLm6ul4
	 YUWroe332JFTQq0Ri29MwKFShkBlf2Xy8d8AOsHTaECXVE2qJ062Om69Q/uuLjL/dw
	 41QvnVEjR8Wx6VsQ4r6rYijTUjL0TBTTJ7VHW4tEVZSfsuSnPFiHWXRNJMJrnvMkUE
	 zsCDycC+O1R/3fb3ZBWgEuwrJqL2ERX51l4VM6SfATEXhD2mgRg4jISMIcLPuFZOF3
	 gCCkO/uA5ey4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] tcp: convert to dev_net_rcu()
Date: Thu, 23 Jul 2026 07:36:57 -0400
Message-ID: <20260723113702.3035088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072042-collide-upturned-2e18@gregkh>
References: <2026072042-collide-upturned-2e18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e7b9ecce562ca6a1de32c56c597fa45e08c44ec0 ]

TCP uses of dev_net() are under RCU protection, change them
to dev_net_rcu() to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250301201424.2046477-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c9c9b37f8c55 ("netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 net/ipv4/tcp_ipv4.c            |  8 ++++----
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv6/tcp_ipv6.c            | 10 +++++-----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index f89320b6fee315..cd9f071d5658d9 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -106,7 +106,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 	if (sk)
 		return sk;
 
-	return __inet6_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
+	return __inet6_lookup(dev_net_rcu(skb_dst(skb)->dev), hashinfo, skb,
 			      doff, &ipv6_hdr(skb)->saddr, sport,
 			      &ipv6_hdr(skb)->daddr, ntohs(dport),
 			      iif, sdif, refcounted);
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5849f816402dc1..03cb18838dcfc6 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -356,7 +356,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 	if (sk)
 		return sk;
 
-	return __inet_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
+	return __inet_lookup(dev_net_rcu(skb_dst(skb)->dev), hashinfo, skb,
 			     doff, iph->saddr, sport,
 			     iph->daddr, dport, inet_iif(skb), sdif,
 			     refcounted);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7e4a9090abd705..d35003b110e2c5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -486,7 +486,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	struct request_sock *fastopen;
 	u32 seq, snd_una;
 	int err;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	sk = __inet_lookup_established(net, &tcp_hashinfo, iph->daddr,
 				       th->dest, iph->saddr, ntohs(th->source),
@@ -718,7 +718,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 #ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	hash_location = tcp_parse_md5sig_option(th);
@@ -1794,7 +1794,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 	if (th->doff < sizeof(struct tcphdr) / 4)
 		return 0;
 
-	sk = __inet_lookup_established(dev_net(skb->dev), &tcp_hashinfo,
+	sk = __inet_lookup_established(dev_net_rcu(skb->dev), &tcp_hashinfo,
 				       iph->saddr, th->source,
 				       iph->daddr, ntohs(th->dest),
 				       skb->skb_iif, inet_sdif(skb));
@@ -1989,7 +1989,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_rcv(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sk_buff *skb_to_free;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index f17635ac7d829c..882e58d51179b9 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	bool reclaim = false;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e972bbb754189a..dea59b123eb759 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -382,7 +382,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct tcphdr *th = (struct tcphdr *)(skb->data+offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct request_sock *fastopen;
 	struct ipv6_pinfo *np;
 	struct tcp_sock *tp;
@@ -897,7 +897,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	struct tcphdr *t1;
 	struct sk_buff *buff;
 	struct flowi6 fl6;
-	struct net *net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	struct sock *ctl_sk = net->ipv6.tcp_sk;
 	unsigned int tot_len = sizeof(struct tcphdr);
 	__be32 mrst = 0, *topt;
@@ -1047,7 +1047,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 #ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	hash_location = tcp_parse_md5sig_option(th);
@@ -1633,7 +1633,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	struct sock *sk;
 	int ret;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	if (skb->pkt_type != PACKET_HOST)
 		goto discard_it;
@@ -1871,7 +1871,7 @@ void tcp_v6_early_demux(struct sk_buff *skb)
 		return;
 
 	/* Note : We use inet6_iif() here, not tcp_v6_iif() */
-	sk = __inet6_lookup_established(dev_net(skb->dev), &tcp_hashinfo,
+	sk = __inet6_lookup_established(dev_net_rcu(skb->dev), &tcp_hashinfo,
 					&hdr->saddr, th->source,
 					&hdr->daddr, ntohs(th->dest),
 					inet6_iif(skb), inet6_sdif(skb));
-- 
2.53.0

