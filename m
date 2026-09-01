Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302F479876
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261068; cv=none; b=E9erjm30JXddZD0BKp0afCQqKXIIjj+EL+b4r4SDwfUWWHiRV+6Fl3KI0Ys4hdzmSUeioYSNWrkh+58oSltm02jbRXFRCfl8N68Ax5Mox+vEhni0wnOPQO/Vnj1AlyBxb/f5jVO2B1fvHZCJ71kWQv7wOwtsCBCBN+zelyigWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261068; c=relaxed/simple;
	bh=GMPXC6c4uq4gxYkkCQ5Yh984edYgYqTtBPb7NZiZZfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX3JyWxuLA/6d8rnERzapHiUMnxUEybGpTDyuCLwqYx4RFa6n6ANhxsbQYw/J0xLJKGUESMcMiEP6JirwHX2JhM4EF2PkZopEl0ANimJmPanOR+kwQ40zP6dqtWZnOIp2te13g+sLMlJ2ztJch1B49tpCLIPpZp7a29WuKGXJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0YLfXej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0YLfXej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8F1F00ADB;
	Tue,  1 Sep 2026 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261064;
	bh=2c5Km27EOVXapnfaczKWhbRDLyCNlsxcNdIDQtTT+gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q0YLfXejqcXyjBznYk5SOzsexkB+9ZKfxTdQJ/zrayuaSbbzjyrFplkeC1+37cFMB
	 My5Sw2lby0FqHGs6v7pySSmNNJcRLr5FHOF3GDxojDuP/gl/ll2Pqp0di9YBpqu469
	 732assM8bY51+0SMvRGwM9hXr3XZ0XvlLOvWPa0j5AwDNE111LGEzDyMJ3KsrH9f/9
	 UxzujFoizUC8Al8kriCE/Q/FNACAjQ7TJNdxz0fkoJHK1f0+Mawzuv0gPkjY8703bR
	 HLDF/qv5QzYWhoRqqC8/Da9g/T4i1hAa44XXJKf+JY7gu7st+9AJ0iJe0Q872y16//
	 qJYAuOiv0gKAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] ipv4: use dst4_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 07:10:40 -0400
Message-ID: <20260901111041.4174429-5-sashal@kernel.org>
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
index 1fc967a60bb9c..7e391c2bc5bc0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -789,7 +789,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 
-	room = dst_mtu(&rt->dst);
+	room = dst4_mtu(&rt->dst);
 	if (room > 576)
 		room = 576;
 	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e04965d6b54e0..1f81d5152471d 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1305,7 +1305,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		return -EFAULT;
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
@@ -1440,7 +1440,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	pmtudisc = READ_ONCE(inet->pmtudisc);
 	if (pmtudisc == IP_PMTUDISC_DO ||
 	    pmtudisc == IP_PMTUDISC_PROBE ||
-	    (skb->len <= dst_mtu(&rt->dst) &&
+	    (skb->len <= dst4_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d8..4a7c3241462ee 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1634,7 +1634,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		val = 0;
 		dst = sk_dst_get(sk);
 		if (dst) {
-			val = dst_mtu(dst);
+			val = dst4_mtu(dst);
 			dst_release(dst);
 		}
 		if (!val)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f0294b1148246..82c0778c82d4a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1896,7 +1896,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
 	dev = dst_dev_rcu(&rt->dst);
 
-	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 1c739587bacde..57ccff9ab076a 100644
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
index 40b73e97d5fbf..4d2debf02cce7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -367,7 +367,7 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -379,15 +379,14 @@ void tcp_v4_mtu_reduced(struct sock *sk)
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
@@ -1800,7 +1799,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst4_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 78e685011382a..0330168eab85f 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -971,7 +971,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	iph6 = ipv6_hdr(skb);
 
 	if (df) {
-		mtu = dst_mtu(&rt->dst) - t_hlen;
+		mtu = dst4_mtu(&rt->dst) - t_hlen;
 
 		if (mtu < IPV4_MIN_MTU) {
 			DEV_STATS_INC(dev, collisions);
-- 
2.53.0

