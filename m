Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E547D459
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261066; cv=none; b=fbTWGIz0x7Bx4CYtXWoQ7T4n3q79UrjBoPQGnuF+PMAQcDY95G6Zujv88JGGVeaBt8+ukq5GDPV1Nma5sH6pEtEdtWFIySyUH1J15bP4Erzc7xac79rYN6DZzY6/vZUmwMRa2TzsXghL2boHbmdKcjWLR1RPNVnxTzzrqUBFXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261066; c=relaxed/simple;
	bh=SrAl6BzfztWEQ7hrl6FY35IUhEzTIUTTM782powaewY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro/wA/uh9M3RmHMm6gPrarsRhqZ/iiHf+dkVKkey8aFJMOyoL3qm05gy1pYxr4IxS5DQH1cb3iLKN+4Apxv9l5ODyhjc4J+L/KIAv99bnzwPIgAbcLiP21NdXFg3kgmc70OCYQoPlLoa/XltO7uRm108L/D0NJETaRP4v/OWz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMiKO71N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMiKO71N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C8C1F00ACA;
	Tue,  1 Sep 2026 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261062;
	bh=nqjWYGhz8oVUYmQEvq9zLLlBc7LIVnUXdFlnb23sjNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VMiKO71NdjFxk/yMLIw/4LgOIJXZ+fk+An7ghX1+EJzOlHOa/G8SR7ujFRcbB58qe
	 evmfBtvp4hqlS+bzlsGCjn+6rlC4ksrAscpiF/9NxODg6i18rkUIi0Jv6FrsnlevWt
	 AxfAGDTt34jqfhIaMVlxmCWydUKrSd2gDu3TLeeoycjkEKYgoPsLT52zZkY4M1m9wq
	 MwbhfMmLCaW2vgeccEgAeh4BRvRpoesbjMAw4F76/EfDcM28KvEV+crvReLgkQSArZ
	 t6OS122jqPID8QKbVhj/Uoo8WSBgJlpt9xr4eFLHqhw07u5wKiKuVk6RY3bhtdJeBZ
	 fjOkS3QTMnS3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Tue,  1 Sep 2026 07:10:38 -0400
Message-ID: <20260901111041.4174429-3-sashal@kernel.org>
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

[ Upstream commit 8776c4ef3ab22b95f55713f00a7a576e6402507d ]

With CONFIG_MITIGATION_RETPOLINE=y dst_mtu() is a bit fat,
because it is generic.

Indeed, clang does not always inline it.

Add dst4_mtu() and dst6_mtu() helpers for callers that
expect either ipv4_mtu() or ip6_mtu() to be called.

These helpers are always inlined.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h       | 6 ++++++
 include/net/ip6_route.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index e7c1eb69570ec..b3ac23e14adab 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -219,6 +219,12 @@ static inline u32 dst_mtu(const struct dst_entry *dst)
 	return INDIRECT_CALL_INET(dst->ops->mtu, ip6_mtu, ipv4_mtu, dst);
 }
 
+/* Variant of dst_mtu() for IPv4 users. */
+static inline u32 dst4_mtu(const struct dst_entry *dst)
+{
+	return INDIRECT_CALL_1(dst->ops->mtu, ipv4_mtu, dst);
+}
+
 /* RTT metrics are stored in milliseconds for user ABI, but used as jiffies */
 static inline unsigned long dst_metric_rtt(const struct dst_entry *dst, int metric)
 {
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 59f48ca3abdf5..7ee73d362a0cc 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -266,6 +266,12 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+/* Variant of dst_mtu() for IPv6 users */
+static inline u32 dst6_mtu(const struct dst_entry *dst)
+{
+	return INDIRECT_CALL_1(dst->ops->mtu, ip6_mtu, dst);
+}
+
 static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 {
 	const struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
-- 
2.53.0

