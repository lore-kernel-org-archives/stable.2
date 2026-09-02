Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5F4779B0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346433; cv=none; b=GIi0g5dU+hle+fyOU7vFtnXeYCesiLVH+Ks0lhojBhA8Utaxdls//zdrUzjF4c/Ar2H9ZX9LrU2+kSamX7DXNaOognISPo6vgH3pCQYQW15szqViOp0OR9/pDbg5UxmCHDVrktXVTN8zWFVIEiApctlMCL0DXYt/h1O9MqH2TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346433; c=relaxed/simple;
	bh=glO6eMrM0zLsyJs0ZjAcQ7uqg8VlUvhASnw5trKzKpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg81X1RK51c2nsiMQrTkA+u1EKSGC9Om73OxTSg0QuE9YMlSui69DMnlpsY0erJQlnIO0R5VluxRNP9Da+WWzqhmtWkdX74I0gSJsM6mKu7+AexfoNZhsnA3JaKybAxRE45mvtbeM+J1HQSl+7KIyeHXeCZ4+SleLNN+JB+KLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP0ZlgOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP0ZlgOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDAC1F00ADE;
	Wed,  2 Sep 2026 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346416;
	bh=WHTjQlojThD+9ainIIzyS7nOTlOdf9ensAWpDjcApHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VP0ZlgOlgCI85L7lDelNqRIvOzWfc4+diTr8Ee6Nv2H40lYIqdvEZN9q2R1aifqBg
	 l+VK/1hcnR6a5YdKn994kz6cc7a8lerSKxE4v4DlvxjcbEiSmwjXVI9mpKJ/itB8FG
	 em2e1iJ9ixY3qcGxjDuRX7GPe5paJNFJMD+ZqNJ5HxTq9Mg6a7p8pXCTyzFcBLdcVb
	 sDsRrUH+HpyzrQyqAsVtzinW5GiZndCpbxXEeGmfonrpUAb8X+G/RXScLoZXxCd5vd
	 Ylf19jDKBZbAMbgL3VeZDZ1C3MW0gUfJRGqqbOEh881lV9ygaLjOhYE/67LzHIav1o
	 JuihpL+wJT9Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Wed,  2 Sep 2026 06:53:29 -0400
Message-ID: <20260902105332.2048804-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105332.2048804-1-sashal@kernel.org>
References: <2026083106-glisten-superhero-188c@gregkh>
 <20260902105332.2048804-1-sashal@kernel.org>
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

[ backported as a dependency to unblock "tcp: clamp route advmss to
  TCP_MIN_MSS". This tree's ip6_skb_dst_mtu() predates upstream's
  refactor to use dst6_mtu() internally, so that hunk was dropped and
  the existing implementation kept unchanged; only the new dst6_mtu()
  helper was added.

  Unlike upstream, ipv4_mtu() and ip6_mtu() are not yet reachable via
  INDIRECT_CALL_1() in this tree: they are still declared/defined
  static in net/ipv4/route.c and net/ipv6/route.c, with no
  INDIRECT_CALLABLE_DECLARE() prototype in a header. Calling
  dst4_mtu()/dst6_mtu() as-is would hit an implicit-declaration build
  error under CONFIG_RETPOLINE. Switched both functions' storage class
  from static to INDIRECT_CALLABLE_SCOPE and added matching
  INDIRECT_CALLABLE_DECLARE() prototypes in dst.h/ip6_route.h so they
  can be referenced from the new helpers. ]

Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h       | 8 ++++++++
 include/net/ip6_route.h | 8 ++++++++
 net/ipv4/route.c        | 4 ++--
 net/ipv6/route.c        | 4 ++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9114272f81009..c5a3a88fc9855 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -199,6 +199,14 @@ static inline u32 dst_mtu(const struct dst_entry *dst)
 	return dst->ops->mtu(dst);
 }
 
+INDIRECT_CALLABLE_DECLARE(unsigned int ipv4_mtu(const struct dst_entry *dst));
+
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
index 44969d03debf8..851139f4b369a 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -262,6 +262,14 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+INDIRECT_CALLABLE_DECLARE(unsigned int ip6_mtu(const struct dst_entry *dst));
+
+/* Variant of dst_mtu() for IPv6 users */
+static inline u32 dst6_mtu(const struct dst_entry *dst)
+{
+	return INDIRECT_CALL_1(dst->ops->mtu, ip6_mtu, dst);
+}
+
 static inline unsigned int ip6_skb_dst_mtu(struct sk_buff *skb)
 {
 	unsigned int mtu;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b7db0255af6e1..65a6781743013 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -136,7 +136,7 @@ static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
 
 static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
-static unsigned int	 ipv4_mtu(const struct dst_entry *dst);
+INDIRECT_CALLABLE_SCOPE unsigned int ipv4_mtu(const struct dst_entry *dst);
 static void		ipv4_negative_advice(struct sock *sk,
 					     struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
@@ -1383,7 +1383,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
 
-static unsigned int ipv4_mtu(const struct dst_entry *dst)
+INDIRECT_CALLABLE_SCOPE unsigned int ipv4_mtu(const struct dst_entry *dst)
 {
 	const struct rtable *rt = (const struct rtable *)dst;
 	unsigned int mtu = rt->rt_pmtu;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bda1d39f0b2e5..138761f4cc747 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -84,7 +84,7 @@ enum rt6_nud_state {
 
 static struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ip6_default_advmss(const struct dst_entry *dst);
-static unsigned int	 ip6_mtu(const struct dst_entry *dst);
+INDIRECT_CALLABLE_SCOPE unsigned int ip6_mtu(const struct dst_entry *dst);
 static void		ip6_negative_advice(struct sock *sk,
 					    struct dst_entry *dst);
 static void		ip6_dst_destroy(struct dst_entry *);
@@ -3080,7 +3080,7 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 	return mtu;
 }
 
-static unsigned int ip6_mtu(const struct dst_entry *dst)
+INDIRECT_CALLABLE_SCOPE unsigned int ip6_mtu(const struct dst_entry *dst)
 {
 	struct inet6_dev *idev;
 	unsigned int mtu;
-- 
2.53.0

