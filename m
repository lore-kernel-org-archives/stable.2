Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AE35C6B5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272289; cv=none; b=PgDZnXiFnYe9rQD3c98LGL3GHXRdD+G/82P13qKeViT8e5q4FCzwZXVzR784iqySH1qb2hN2xYrgOjmb7toh4BX/pKm0Kb+vvKmDt5ZR5RgAjiF1PRR2YrTKJLw+17vRSvBpYMlTpulUrRKGX0wzFtYy/pW9GFq2diAn0pN3JDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272289; c=relaxed/simple;
	bh=uxYbCATsTjfkCQxSYLSxodKacYorSCaG5sgyc/QJPNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W//Uv1G5GDn5iJYKUMBDHhAegs7Iuzl4/3J+tF0Yuu421pt3d5lju0It8F7y9ttotHOYzJRADAFGtjE/53wTtht5ML9PrANmUDROVy8pjmI8vg2hGvYnuy4rJ7I5KXMSuxg8D3i/3jP753GziG2GxhYXSBFVPGy2LwRD4Jcd1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaSbKrm5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaSbKrm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220A91F00A3F;
	Tue,  1 Sep 2026 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272287;
	bh=XHs4teeY3repSQ9dqJ66u8I0SLMiBt4rwMMr2XKDam8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaSbKrm54NZ8NbxuTPV559CjyiRYbaldAcoKMnuKYfNp/48/3YQK6BY6CXy30UpHD
	 VnJ+l7tmvJmAysUFpj241LQcTWKzbFpVF504gHhp5+LqOsW3Ss9+cD4erzYGExx+QZ
	 6pC2LVtXTRwOl9ZQDflH0J5WnIS/RTGYnv35807mfMRpAs2x3QJsxGgmST51qnxbnR
	 jiHeu/VXKHZLlrfwsh4PIHhY5SNvs/cDP7lTATGseDfbecX/0f+AF4lSQ+R19tYAgF
	 Jf3Rf9DFc41mEaf8H/Dzc5AmULHoKAoimm4BharLRBmlPNvuAbvtdHvQ3fxb4CiJUi
	 LpdEJjL4ebnHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Tue,  1 Sep 2026 10:18:01 -0400
Message-ID: <20260901141804.1031618-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901141804.1031618-1-sashal@kernel.org>
References: <2026083105-buddhist-verdict-4f97@gregkh>
 <20260901141804.1031618-1-sashal@kernel.org>
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
index 55d1be268d243..e1c4a806597da 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -216,6 +216,12 @@ static inline u32 dst_mtu(const struct dst_entry *dst)
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
index 392232fcd703c..55c9ccfa0bcb8 100644
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

