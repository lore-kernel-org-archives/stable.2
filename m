Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F537C908
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611547; cv=none; b=CAcatmdyxCVtaUDhg1MNfXtlNQXJ2q+mW7NVsBd8JQWFBweijmMEImW+XkNbJR6vWA2I5Uvarmapc+2B7vTPHMVeG3i+vUfGev9olKKYP1D8v+qF+/pEEmwlPav5D2t+9vAKmZqgl4q42b4PnrM6QbEU1Ga54GiPm1ZsCcUMW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611547; c=relaxed/simple;
	bh=phpmy3jcsm/ZD9QhwajG/jRRx5mlEGwAtQTaukvp9EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHa1BQnLfPKu5vPr7vbVXM18y5c04rJkuidDYqbUBKsPk1+arGsNCE2v+1ANaJ0xBOeWUKhvRNJ2Rk2L5tJlTOHWqmh18HQBFulBQh4p3FWLui5lt6SQLUAXvZjgVhKKwd5kpJ4T4BW3A1ZV2SZwWh+s/6dG50c6PYrT47e/gyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI3Kh+Nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI3Kh+Nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06041F00899;
	Thu, 17 Sep 2026 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611545;
	bh=wg62CkjVjlOblJSIlZhTkdIxi8Zf4hu0QQhRS7qF5/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZI3Kh+NrKlpENk1WbfIB+Ie8G5XvVlRkMmiIYWyA+Z6LV9zsGl7A054IblMX6Ad3H
	 +xDHHULDIoufqKTKe5JYassVFEYFXJKHFgSC7oaj0aelLrZbumY9cCnNbJdWKuPutB
	 9BFCxptwSAG6jArqS5v8amGmo0cSsVsFYb0Axr1i10CIusmWcX+K/eh/sl2F6ZyjAL
	 BI+h7WmZfe0s6IP6DzqhOdMB1Qg6R3wz/r+8Izufo83YBy9rlz5SCMaOVhowY3Jh/K
	 VWn3w2g7Mwv2Et1ad+oUN1IZ5c3wYn5suKA0gImFXls15PN21nA60d1PZpVnKnPnns
	 ZV+na8an/cz9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/7] ipv6: reorganise struct ipv6_pinfo
Date: Wed, 16 Sep 2026 22:18:57 -0400
Message-ID: <20260917021859.3810309-5-sashal@kernel.org>
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

[ Upstream commit b76543b21fbcfbb96332fd80cc0d85bbcd72d8f0 ]

Move fields used in tx fast path at the beginning of the structure,
and seldom used ones at the end.

Note that rxopt is also in the first cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250916160951.541279-5-edumazet@google.com
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ipv6.h | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7eb42e15103b4..0ac14eab99e74 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -212,18 +212,21 @@ struct inet6_cork {
 
 /* struct ipv6_pinfo - ipv6 private area */
 struct ipv6_pinfo {
+	/* Used in tx path (inet6_csk_route_socket(), ip6_xmit()) */
 	struct in6_addr 	saddr;
-	struct in6_pktinfo	sticky_pktinfo;
+	__be32			flow_label;
+	u32			dst_cookie;
+	struct ipv6_txoptions __rcu	*opt;
+	s16			hop_limit;
+	u8			pmtudisc;
+	u8			tclass;
 #ifdef CONFIG_IPV6_SUBTREES
 	bool			saddr_cache;
 #endif
 	const struct in6_addr		*daddr_cache;
 
-	__be32			flow_label;
-	__u32			frag_size;
-
-	s16			hop_limit;
 	u8			mcast_hops;
+	u32			frag_size;
 
 	int			ucast_oif;
 	int			mcast_oif;
@@ -231,7 +234,7 @@ struct ipv6_pinfo {
 	/* pktoption flags */
 	union {
 		struct {
-			__u16	srcrt:1,
+			u16	srcrt:1,
 				osrcrt:1,
 			        rxinfo:1,
 			        rxoinfo:1,
@@ -248,29 +251,25 @@ struct ipv6_pinfo {
 				recvfragsize:1;
 				/* 1 bits hole */
 		} bits;
-		__u16		all;
+		u16		all;
 	} rxopt;
 
 	/* sockopt flags */
-	__u8			srcprefs;	/* 001: prefer temporary address
+	u8			srcprefs;	/* 001: prefer temporary address
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
-	__u8			pmtudisc;
-	__u8			min_hopcount;
-	__u8			tclass;
+	u8			min_hopcount;
 	__be32			rcv_flowinfo;
+	struct in6_pktinfo	sticky_pktinfo;
 
-	__u32			dst_cookie;
+	struct sk_buff		*pktoptions;
+	struct sk_buff		*rxpmtu;
+	struct inet6_cork	cork;
 
 	struct ipv6_mc_socklist	__rcu *ipv6_mc_list;
 	struct ipv6_ac_socklist	*ipv6_ac_list;
 	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
-
-	struct ipv6_txoptions __rcu	*opt;
-	struct sk_buff		*pktoptions;
-	struct sk_buff		*rxpmtu;
-	struct inet6_cork	cork;
 };
 
 /* We currently use available bits from inet_sk(sk)->inet_flags,
-- 
2.53.0

