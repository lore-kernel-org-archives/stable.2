Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8D4A2068
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290920; cv=none; b=cyTC4fn5P4xWXEhSK/O1rVhnS4XC8xj3ixA98g/MqLWG0YLbq8KIIQfs6PY5Bnhr2WnDB3D309zJdVjGKCY86BDthwSwPCP8UUzJlCC2X+HCizipIfH3DR5gUirjwMGxYrDP2l6ZHDjUd5Y5F+whNr7RXuFGp01tGQbbZl7yvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290920; c=relaxed/simple;
	bh=ErbvwiZsgcYCSNm/HpnoPkrPHbxVlFNt6RlWS8AC5cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcBWkDVx2W3tbATXk0tgax8Drf+L8DvUmXQblMWdI6NI+EpbQLBooi0TG8O7eDP2299EmEzm8Zm0JWVqNwBCYXHtpndyuTcRa1KM8/3yvR81Pk4rgbEZ7v6FNCb3bf9RGzrGwE/plY3TeknxML5QxbhOOUb0eKHgl0GmMtqlEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6pcvRRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6pcvRRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673281F000E9;
	Tue,  1 Sep 2026 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290919;
	bh=zUAnTioyagyKZ/jk1wiItDxYiN9uCwt0U1u32n07ly8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6pcvRRmb3r2vB+z5DMirYoTD7lqYhEuRFin8NUlzqR30Vyepk8rOXfxQBfF/qiMX
	 1fcCBCSjuhlr+7zH3JJIbUgsikazYx3N8XcPOSm7IHNMSMojMkIHmJ1PWj9/SFAW7U
	 hz81uNdU1zJPgo1eq+kYB8+9ikao9CTm2oUYf91aI8nE2H7bmen4v5G8IgMxbVeMu5
	 pal8GQepDHx+4qtfvcfen09VW3SnzcYU7wEr7cmWfrTsoNjtZAMG5aTCQO9wzUcEld
	 AKtcgKvC+DLWW73LNimdhxhr23xEu2cqYqbHXIWkfGrQkPEXVs9rA3+HoEhzcBB9Ex
	 McmXNmEL+In2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/8] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Tue,  1 Sep 2026 15:28:29 -0400
Message-ID: <20260901192833.1439569-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901192833.1439569-1-sashal@kernel.org>
References: <2026083106-glider-shiftless-2e30@gregkh>
 <20260901192833.1439569-1-sashal@kernel.org>
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
index 67ef21cff3f48..2b726bd240498 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -205,6 +205,12 @@ static inline u32 dst_mtu(const struct dst_entry *dst)
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
index 7c0184c09392f..f87e9fcb5312c 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -270,6 +270,12 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
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

