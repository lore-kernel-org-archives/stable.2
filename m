Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6E35B636
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611545; cv=none; b=AIrcy1LpnTBkIe/J14Wi27jR7NyQ5363x/4TZD4yoJRylEgK29RixPcBfG1ydi8vvpRke9AXN5VSwCwj54NXMe1iV9yWaFaVlf5gM3xm7+a9ZrDHFSGkPqDPRKcepT5b3QmLfC9UgJD+jYzT7GrhHKXQoX2BTirVi+keXe4V/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611545; c=relaxed/simple;
	bh=OUndbcnyyIqd3qNqJV49DKDI+/SdNx2HssFdUNhiHZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mR9241/sxDZnqyDfUgnHzZf0LsR6kStO31kO8PrWdNjErFjEMN4lbCwENQNKc7fypxfcKZyzeSOwo3sW3hDX2ppLdH1LqwlUiCNxFALeayjY7e1yPP+VMKANSg3QF4r7FAeIV0Xqi+MiwJIAJVGgFcjC5vMVOySOhRbHYvjSna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGo6KgWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGo6KgWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3B1F000FF;
	Thu, 17 Sep 2026 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611544;
	bh=BE2r4BjM56kC5x1TRyO/GypDCrbfUYDfmbQbcAxgNIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGo6KgWFeH0JpjuFsfFq7JmiUvYD5xCGukW+wjhNxRxcqB2qp3a89HYgch2eq85KV
	 cJXN1QmTQqV67NVbiQDkjH9rhsTvwmZJ+1aIxJ8WJCsjrJxHSlNLo74c54KcWisTXP
	 YyMxEMD6cE5yn3MBGQCD6hj1CQ2T89h2gyTaAUM1/gEciqR0o8/q9gPPgA8Lw73ZAY
	 ybDX+LfnBqgiRzrurSYbRNaNHd7KgpuUuFw+dw6pCAVjGKrfxRpZ4HyS6o8ea8Mz87
	 pUWjczDHxRXJ/++v9SIQoxnxHwxQV+YrpiU/XIMkBs9FQ8VqbFyeqQG7VR6At+jgKu
	 eiozgI/seAwmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/7] ipv6: make ipv6_pinfo.saddr_cache a boolean
Date: Wed, 16 Sep 2026 22:18:56 -0400
Message-ID: <20260917021859.3810309-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021859.3810309-1-sashal@kernel.org>
References: <2026091655-dejected-hammock-755e@gregkh>
 <20260917021859.3810309-1-sashal@kernel.org>
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
index 5aeeed22f35bf..7eb42e15103b4 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -214,10 +214,10 @@ struct inet6_cork {
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
index 59f48ca3abdf5..223c02d426885 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -230,7 +230,7 @@ static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
  */
 static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 				 const struct in6_addr *daddr,
-				 const struct in6_addr *saddr)
+				 bool saddr_set)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
@@ -238,7 +238,7 @@ static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr;
 #ifdef CONFIG_IPV6_SUBTREES
-	np->saddr_cache = saddr;
+	np->saddr_cache = saddr_set;
 #endif
 }
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0786155715249..7b51c0cf2e453 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -856,7 +856,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 			return PTR_ERR(dst);
 		}
 
-		ip6_dst_store(sk, dst, NULL, NULL);
+		ip6_dst_store(sk, dst, NULL, false);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 80043e46117c5..1bc4510b4561c 100644
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
index fd25d5aadea27..10c1ffc732347 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1101,7 +1101,8 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 	 */
 	if (ip6_rt_check(&rt->rt6i_dst, &fl6->daddr, np->daddr_cache) ||
 #ifdef CONFIG_IPV6_SUBTREES
-	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr, np->saddr_cache) ||
+	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
+			 np->saddr_cache ? &np->saddr : NULL) ||
 #endif
 	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
 		dst_release(dst);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3e5bf8a5b32b2..4870692f9e1dd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3042,9 +3042,9 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
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
index 84efaf846f07f..61192ecc5c18b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -293,7 +293,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL, NULL);
+	ip6_dst_store(sk, dst, NULL, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
@@ -1434,7 +1434,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	ip6_dst_store(newsk, dst, NULL, NULL);
+	ip6_dst_store(newsk, dst, NULL, false);
 
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
-- 
2.53.0

