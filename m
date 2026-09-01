Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9690315785
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222069; cv=none; b=t6twgqvZXMcU9H10Sw2hKOAtMZsOzXuJFjEVq3xeK3QThEhC+D34SCMLuoeMEgXhEwj83yKzwKzEpa5nTpwJVpf4Kh9egAjSH6JsGcRCJFvYkCkHN+CTCwqVli7K9fH+oFga8m2Bcrm48bGa+a8pTrWfy4k8OPCnPbNd1Oan7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222069; c=relaxed/simple;
	bh=c8RjBWDa/CDxVRH806wZtmf2N/8EqD8DfF5HwWg+an8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f941e1Ny/LmcXvdrs60N+iBOSRUgdLQhsI+UfBjOHeBghAIg5oWW6Tt5cainWwRwjLJclwfG/OkFsxB0FqMbR4OnZd7buRW+iegb8Nt6VajRQpZZ3bIabGgIyeLDGIwFSa7m3AxxQi7qkhZcR0ZVBmPevX2zHw9slJ3ztZDt0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR9gsiSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR9gsiSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3175C1F00ACA;
	Tue,  1 Sep 2026 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222067;
	bh=gwWbpsc2OAK0u8T95Hum+yLnhE2eQtArdVgzKljZLJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZR9gsiSdQUG8BHDLnslF2AlVI8ZRCkVOCWvtjBRouX2ll6lW/sBO3r9RKMmY28sUH
	 98xLWoV9V8swUX7y1xTk9g/05OH9UZ1Us9IPzawoNIVMbMCrQuUIdYc0KD1kVVO4xT
	 7UVbcbYRYpVPigbLCdbhDNDnfOvAYItd9kMapW91/8zs/4kP/8PWkP/SL9GC51oy4P
	 SQznOB5PrkZE/fmrSkqO6TTOwV46lt5tOZUcl5az0c+tGjjCJ6VyG1AxQZXAvnxVJg
	 sN1bG6X8hTjhFSfXFUcI28a5INDevYlQ/X8T8KNGhas7HfAWAIumDPIF/bcHKUiy04
	 TnxI1ahxIsnrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] inet: add dst4_mtu() and dst6_mtu() helpers
Date: Mon, 31 Aug 2026 20:21:01 -0400
Message-ID: <20260901002103.2024757-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901002103.2024757-1-sashal@kernel.org>
References: <2026083112-scrunch-gazing-cb7a@gregkh>
 <20260901002103.2024757-1-sashal@kernel.org>
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
Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
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

