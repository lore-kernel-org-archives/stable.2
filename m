Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3583B14C3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617567; cv=none; b=D7tdL8qmQ7C1m0/v5kV3cVotQnfRP+ZbyUxsTKi1Xh+iLgdVKwh1u2Y27zpFsYML9aJOHENJseeTFARyEishWAXhN5SVC8JpNdtO6kkXFARJ3CIHx2epHLFIyWOOIiaSgfAYuTUoVhOVm1TLjCGDle5fUfI12DQ/sjodiXavBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617567; c=relaxed/simple;
	bh=SBH3pErwGu+M2h1yXoL9SDiF7XNt0zsSmnYBmHVJE3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgFTfb936TZsTATKwZ7zQpOwaQAhx6KPxKbzBMQ1q0vtxt++P9eIR7w/rfsUn0VvNX0bQdR40oyKXoiVI/TklRPIFhQ0LukN7d2DCRyxqvbSONe6fWlujOl4I2S8dX4EjmgRxZdSpzfOeE5S7Vtw4TgLB5tsFRQi/NANzFFf16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEycn8qQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEycn8qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CF71F00898;
	Thu, 17 Sep 2026 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617564;
	bh=D7TJ1lzs9/G2rhV/3Ve11MNCmJPRnhbvvKcWH6ZL6Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEycn8qQYM6DI2FYXD3WecLxz7EZG+vvdL784a3ai2wAWCUYi1dSaPBrG711n+L7m
	 xEjejCXTgdm8bLODv5xtlna3XuD0Xnnw8vGVkW/y4HIPEbTHZxmvfeE5ohlkhSkCBr
	 Mtpieer1X9X4nWkDBDPZ0b2iAKFXXR177/WYVMAkdSfUbQI5g/gkgKk0BZJgMsvs8Q
	 egKHlO5zjllHZ77b3mBOn60YG5YsFpXHSSy2s9zuEA/dv+Ma0i5XM10RrXSBlI0iRl
	 TL5NstF0z9BQ6sBxc3VBoUZ/Ry5XEeNEGecAmvzsNeNSeWj/Fx3OrGJWdYaGe5GX5a
	 c9EkpqwvJRDCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] ipv6: make ipv6_pinfo.saddr_cache a boolean
Date: Wed, 16 Sep 2026 23:59:18 -0400
Message-ID: <20260917035920.4132418-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917035920.4132418-1-sashal@kernel.org>
References: <2026091656-disparate-pang-cc22@gregkh>
 <20260917035920.4132418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3fbb2a6f3a70c27a6a2be80d131970608c0f84d0 ]

ipv6_pinfo.saddr_cache is either NULL or &np->saddr.

We do not need 8 bytes, a boolean is enough.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250916160951.541279-2-edumazet@google.com
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ipv6.h             | 4 ++--
 include/net/ip6_route.h          | 4 ++--
 net/ipv6/af_inet6.c              | 2 +-
 net/ipv6/inet6_connection_sock.c | 2 +-
 net/ipv6/ip6_output.c            | 3 ++-
 net/ipv6/route.c                 | 4 ++--
 net/ipv6/tcp_ipv6.c              | 4 ++--
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9a44de45cc1f2..e464d34621306 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -212,10 +212,10 @@ struct inet6_cork {
 struct ipv6_pinfo {
 	struct in6_addr 	saddr;
 	struct in6_pktinfo	sticky_pktinfo;
-	const struct in6_addr		*daddr_cache;
 #ifdef CONFIG_IPV6_SUBTREES
-	const struct in6_addr		*saddr_cache;
+	bool			saddr_cache;
 #endif
+	const struct in6_addr		*daddr_cache;
 
 	__be32			flow_label;
 	__u32			frag_size;
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c0184c09392f..55c6a1040a0fe 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -234,7 +234,7 @@ static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
  */
 static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 				 const struct in6_addr *daddr,
-				 const struct in6_addr *saddr)
+				 bool saddr_set)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
@@ -242,7 +242,7 @@ static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr;
 #ifdef CONFIG_IPV6_SUBTREES
-	np->saddr_cache = saddr;
+	np->saddr_cache = saddr_set;
 #endif
 }
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 49031e40551f7..7413624346a6d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -867,7 +867,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 			return PTR_ERR(dst);
 		}
 
-		ip6_dst_store(sk, dst, NULL, NULL);
+		ip6_dst_store(sk, dst, NULL, false);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 5a9f4d722f35d..aa5190e52e70f 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -106,7 +106,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 
 		if (!IS_ERR(dst))
-			ip6_dst_store(sk, dst, NULL, NULL);
+			ip6_dst_store(sk, dst, NULL, false);
 	}
 	return dst;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7ad60793c853c..924bed29ba7a5 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1096,7 +1096,8 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 	 */
 	if (ip6_rt_check(&rt->rt6i_dst, &fl6->daddr, np->daddr_cache) ||
 #ifdef CONFIG_IPV6_SUBTREES
-	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr, np->saddr_cache) ||
+	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
+			 np->saddr_cache ? &np->saddr : NULL) ||
 #endif
 	   (fl6->flowi6_oif && fl6->flowi6_oif != dst->dev->ifindex)) {
 		dst_release(dst);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b1de7c6f895a2..e679037a378cb 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3024,9 +3024,9 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
 		      &sk->sk_v6_daddr : NULL,
 #ifdef CONFIG_IPV6_SUBTREES
 		      ipv6_addr_equal(&fl6->saddr, &np->saddr) ?
-		      &np->saddr :
+		      true :
 #endif
-		      NULL);
+		      false);
 }
 
 static bool ip6_redirect_nh_match(const struct fib6_result *res,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d3952b058453f..f2df8845a403e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -304,7 +304,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL, NULL);
+	ip6_dst_store(sk, dst, NULL, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
@@ -1284,7 +1284,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	ip6_dst_store(newsk, dst, NULL, NULL);
+	ip6_dst_store(newsk, dst, NULL, false);
 
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
-- 
2.53.0

