Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED43859D4
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614837; cv=none; b=J6ncO0zFSltwLZKMFyZNDkSSmreGr6u1/M04pfqjdbnQKUiIgoXIXW5IF5kPbfrPmVSzobXRsuwcQC6H78MkKEKsWLLEPHjXaNDVtf4lQOuwl7JVP6nhTa6AvBWAIhDEXKhY6hrhypT3uNUNhbLx5EXWKFl8aiQPU9Xx2Pykqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614837; c=relaxed/simple;
	bh=++x96Jk90OUFKba3TRznxkxPOdAVaSHkU2zTc8f2Es8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7tTv2Lu1BuD0Z3lAMxmYxosWn40u7sNj6t38wlu348s+Z2aKtPbPn+XNsdkHorrq3LAudgSLS6FurVw1GYh1s+AhovvtwjITDbqAt4qylqxi8mNyOwOjoNQRibP8a01PD7I7RX1UYY2xG/Vyk6dp0OkfXfTO1k1b64rSCbx85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idseb+LF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idseb+LF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF171F0089A;
	Thu, 17 Sep 2026 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614836;
	bh=fSwqao3CDeDerWeVcvN/N2a09oySkLlfRCIc1ScLqc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Idseb+LFrhFORW0ecCuBCxrCJD0W7cNVFr+QTb/cnjdh37c5wiVtMHnDgV/u7SjJk
	 ZRqGjb74B0H6lytkJ/C3/gUAGaCAyURVhXz9GdWevnVUiHVo8/2ivqiR6XgyaBwFIN
	 SCSDWVy8stQ7ImkRltkHJH6+W3H9eS2N9269GkYVctNXJM29G8NEoSpxQl5eK+cbOX
	 JZ00ChYahr/dFbVa3pLMuyaZLC27b5KfSOuBsLmM4T+ZR8NXQb7giAHjO8SNi5nD3O
	 1ddNPbbFqkVHiaoDoGLWpQOsdPaawalKR4L8xsaxQ20Dpy90QDstzGEP8+iTwmnMop
	 LKCbUJhpF/Zqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] ipv6: make ipv6_pinfo.saddr_cache a boolean
Date: Wed, 16 Sep 2026 23:13:50 -0400
Message-ID: <20260917031352.3971853-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917031352.3971853-1-sashal@kernel.org>
References: <2026091655-synthesis-number-1f2b@gregkh>
 <20260917031352.3971853-1-sashal@kernel.org>
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
index af8a771a053c5..fc52145ab732e 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -205,10 +205,10 @@ struct inet6_cork {
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
index 392232fcd703c..62557214b0012 100644
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
index 102ce1748b599..f2ecee2fb7fca 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -853,7 +853,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 			return PTR_ERR(dst);
 		}
 
-		ip6_dst_store(sk, dst, NULL, NULL);
+		ip6_dst_store(sk, dst, NULL, false);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 0c50dcd35fe8c..4b42f13f2267c 100644
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
index 2d18b2dcbafb1..79d41da8d4b57 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1098,7 +1098,8 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
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
index 5cdb084b55fb7..19e28c8ce9c00 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3032,9 +3032,9 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
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
index f13fdd1214aaa..aef3c7bc3d80d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -300,7 +300,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL, NULL);
+	ip6_dst_store(sk, dst, NULL, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
@@ -1273,7 +1273,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	ip6_dst_store(newsk, dst, NULL, NULL);
+	ip6_dst_store(newsk, dst, NULL, false);
 
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
-- 
2.53.0

