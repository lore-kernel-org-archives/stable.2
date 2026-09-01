Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE93164B7
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222063; cv=none; b=RxV8y9fdA6UcelubcxWrDPVHZ777CK5KQ9pk5/uL/aLctJoNF1AOdqBg0vR1lBTJNdx9YTf/vqNayMcqZ9CGHAIdczdr6J6xvtGefrmGw1Eec1JZy7mE3Ly1SMgzrQQGgoSEObM2owcsCZBaDZcRhy52M7TmlDVhxuaVwiTzLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222063; c=relaxed/simple;
	bh=2EuJYc7/sL44ftfGP08dXvEjX9vnVogPcmokghh3aOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+IlxcADfA3vkl5HxDrg8HAG2wE5GoTovJHywfEfLI1nUrCK43IB6iRSyd2piSJa+8ClUcVvG7aQDj6dyKlWnJ8TvhQjY88Mun8ks3/W8OkBX3U4q2yyY0jZY5LbiNoe054PIyXhiuqmGwE9ugtaRK6FCMgXL9SxkeQtsqUMKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAUa16Fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAUa16Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C921F00A3D;
	Tue,  1 Sep 2026 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222061;
	bh=7sU4NzFLLHyrT9+OiUQQ7rDf/70XUiU8db8LkcFjNaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cAUa16Frc6F0etfGlLap7OJ2+IvEqqh76X1SzUsDXWHmecEj6zFPsliX3DCXa5fSJ
	 ypOHAxnAjHJZWQ76AYb1U3jyu+PIm2JNSTK9nZxJ9KuDYQGcYQxK5Xhx1tgLwKRmdj
	 PkQWAbWe3eV3Aj0NHd5l0gFgngE98JLuCKhGcqFeCn/1ax2gcmcGrSl9JLbIt7mL+/
	 AEKLPJxjsGpoHM4eykqE6tr7v3OAzH4fS7/lwoQ6xRMjIccA7Sn+LAXgJZS1ZbMWti
	 qCoVMpak+VLC1SX8CvAYBQqzKMYWz1Q4fSKv4gfowCGwXggoFVEWfAHgeeOv/yTFWN
	 hPsmEIEOKD26Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Mon, 31 Aug 2026 20:20:54 -0400
Message-ID: <20260901002057.2024614-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901002057.2024614-1-sashal@kernel.org>
References: <2026083104-huddle-balancing-d57b@gregkh>
 <20260901002057.2024614-1-sashal@kernel.org>
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
index f8aa1239b4db6..307073eae7f83 100644
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
index 7c5512baa4b2b..a55f9bf95fe39 100644
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

