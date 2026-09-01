Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33B263F4A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301298; cv=none; b=HUTVLPJNcdl7EriyY0k/tpGufsFgZwcFxc+ERrTSif1ROnNFE+Vc+bt/H2KdhE55nAltF/kH67ZwNT2zUpXW8DVUdud3hFJuVjzj+ZgaLdCXzUDICsTGv6D2EaXQj2gfuD4ddy2RQnPZ6HmiiBicTcK3mjens3iuOENNrUAiUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301298; c=relaxed/simple;
	bh=XxGu8ZP59xh74VfON8Z2GJEk+T/yIyDCdfcZ1KPy8AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3o/7oLMg+euAmAhXmeMEMM/WDLvmtvoN28L1uD/gvCbVH/xg5YtqaKA+OAA1g5Xh4SNgn7WUBKayMA6TDt7+g4bXWsCpsYQZdeDGnwxId2Jd4c2B5RA9rFfHXDY0LF2TcN/k1vlrI53Biq+gA/2KC2oyCjUku56GFjBCZ19QKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am7WsXZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am7WsXZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD771F000E9;
	Tue,  1 Sep 2026 22:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788301297;
	bh=H6Z+EZlS1YSKOuG3Hh9gzMVMM+85QdPcbMxZGkgvL7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=am7WsXZOivYpoUa5kqxe+25lIZNMRoFbZsMMHeQoVhc7EXgx17/GW3/oZ4uFRxw5F
	 uEDMzmNDf2p+/OiOvWeYlyNGxNvFfEao+Run4oWOd9nAWo0R6T/AiYSf7d9jmPOWhd
	 NsSbA6lpG2Dae7nPVRlgBBjrB2EY7NoS12MgJoUO1crZaVMCBKuoR0GCfpCapviuNy
	 msOuh2SvOiytSFZ+yhrAys+g1qio6ZR2QasM+qYj74tWqY/o6yg+m8ueeiYTCLO49A
	 Ptz+1v7SWLYbd3rhXyD44LKpskP0czCZoaSy7fyg+xRGHNjljG2hP9mmTI3H+dKZkX
	 U+Z1vfbkZ9s+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Tue,  1 Sep 2026 18:21:31 -0400
Message-ID: <20260901222134.1700802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083106-sterile-daunting-b716@gregkh>
References: <2026083106-sterile-daunting-b716@gregkh>
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
index 9a23986f1071a..9adea166d2d97 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -201,6 +201,12 @@ static inline u32 dst_mtu(const struct dst_entry *dst)
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
index 5efd0b71dc673..299d964850fd3 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -263,6 +263,12 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+/* Variant of dst_mtu() for IPv6 users */
+static inline u32 dst6_mtu(const struct dst_entry *dst)
+{
+	return INDIRECT_CALL_1(dst->ops->mtu, ip6_mtu, dst);
+}
+
 static inline unsigned int ip6_skb_dst_mtu(struct sk_buff *skb)
 {
 	unsigned int mtu;
-- 
2.53.0

