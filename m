Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998803A1E96
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618100; cv=none; b=ijxuFQUEB1TrpI+ghfblXocPr1EDNidWOjH1f0V1tPDo4LTglFu/NfF4/M7qBbW2IgGksqEM07mkc2ojiTlP43LCtBjV+o0PY/rluWgRLedhtO7ztsf+wcplGJRDiPa9CYDIon9SAiG3rxFKtQeClEA6FVewGIi+fXMBAMbXzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618100; c=relaxed/simple;
	bh=6jQcRwnaEJSKXnBaiuoju+Dc1f0VDkpiVBAL0Skx1QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/jz7iEPiyXjcTK68Rw039B+us2K5FzIhdEbXJ0GOABF3KRIDmc37RGAjZZlp8MbMEIgF1jBJ59ERCvZH0Nti+67UOdU0Sp0sbe37fzZc89UDn/BaS1Gvnunt5DuWncR3Sr++AcVafd5jR97EC8Y34hWHQGWpzMCe0TXedkujXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwuPwzcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwuPwzcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB31F0089B;
	Thu, 17 Sep 2026 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618099;
	bh=ji1phF/+w7VQcsMG3I+a6f11HYkI7s47xI1VD9G6e+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwuPwzcdcEUAmcsdkHG7niQ+V1PxSVvOMggPKLPnBIYWCviU3WtGnu7NGFJzy2Etc
	 D9Qh7f541AqNzCOZDwBWeAnqveOJaaxbKpy1tuU6sQSaZHHHGSmNyh9jLW4pLh7B+r
	 ngo0sTgEV1fmTp/pifk2kiOpbh/FIkUzpKmXA0oHkIgABBkQsX0O559qM/+Ip3Tn+7
	 gJPwPhY5tPF3bGDqXBDQRfFSw3KIQS/GjVpSx0RnOcLaIFiocy3iz9t0aDgJTFlQ41
	 pG2JpkBSCxDDxlfuVdBJMgG1z7ozuWa7ZTXXLCcpiZrMUQklpKmiT74LmJOD1AY7r8
	 Xo4dWg9IjRXYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] ipv6: make ipv6_pinfo.saddr_cache a boolean
Date: Thu, 17 Sep 2026 00:08:13 -0400
Message-ID: <20260917040815.4171498-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917040815.4171498-1-sashal@kernel.org>
References: <2026091657-voter-although-5ad8@gregkh>
 <20260917040815.4171498-1-sashal@kernel.org>
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
index b6fb76568b01a..c27c9efcfab83 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -208,10 +208,10 @@ struct inet6_cork {
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
index 5efd0b71dc673..fc77432f83108 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -227,7 +227,7 @@ static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
  */
 static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 				 const struct in6_addr *daddr,
-				 const struct in6_addr *saddr)
+				 bool saddr_set)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
@@ -235,7 +235,7 @@ static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr;
 #ifdef CONFIG_IPV6_SUBTREES
-	np->saddr_cache = saddr;
+	np->saddr_cache = saddr_set;
 #endif
 }
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 4d5f5f2585da9..c2534a2fb421a 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -865,7 +865,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
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
index ab745cda1179b..8c21e0012011a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1066,7 +1066,8 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
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
index 9172b371cd2cd..68fe4fda80f86 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2981,9 +2981,9 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
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
index 77069176137d0..501f81939257f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -300,7 +300,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL, NULL);
+	ip6_dst_store(sk, dst, NULL, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
@@ -1327,7 +1327,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	ip6_dst_store(newsk, dst, NULL, NULL);
+	ip6_dst_store(newsk, dst, NULL, false);
 
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
-- 
2.53.0

