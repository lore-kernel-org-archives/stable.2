Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285E43D4E0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806632; cv=none; b=UC1FIaK8Xt3FuxwZXx8BIDSfJikVQJJY/ZF8rfqBuQSiDw5ICcYth5MbbTBk6/mQHfw7NDflLZg3tSSzeGZI1GKEP5HzO6ZVG6Waemx1YfKyF/f85c0UHeX4xCbbdbYwkv+dMLS2stmQdTSB0EF8qO/MGXzJfpC0aWrO1udDD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806632; c=relaxed/simple;
	bh=LMdZLhfoLWDeJVmz1ZBw8hvrY5NdIiKsEw23kscEnG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEezpajuxIeGOKeKACmAacChsLzG8sSC3ChZk1qFNMv1KnhPWgbgxGR8SkPaWhJU6uidZ/ntcDENRZX5bsQoNODHT4ww2JhgspfBcBhjCO++9YT8hUk6XkWF+1tE0qrfQD+K0kFDm57nawpDN0AhYy5YUnWPtk3kLbHX4oHv5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge5ic3i6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge5ic3i6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C9C1F00AC4;
	Thu, 23 Jul 2026 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806631;
	bh=3JLiJQLJ8gRm4IjibXT4Zf/2FmY9nuhkucZ8T9pHvtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ge5ic3i620XW7shW6WKgpkcjYr8EXY/koktpFG8MzFgtNdWK3lCGi66/eU+i6qQI2
	 KKqsbKv1Si7OiHH39cfVWnmJWkG0IRYWirJFcUalSrYhVyFgE2sIoNGLslqvoqtqqo
	 EZN5RFNAWvcVIGzZLBULgkji+OJnZYurAkyKxoG6wmzr/ts5mFMLsldbOqELSu2Rrp
	 TkC+EVWviFi87HIpHALzelxTr0ki3Gl8503KNpDrH3Ul/pHsF53l5ZN7XKDte/QfYb
	 o5W5qKtS54R8Hqcg96jllkaLL+9ZkiwRbn9Y92Eqm9iMQ3J4srOauTzLj2r4zkX0iU
	 prZkrWAMRR7dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] net: dst: annotate data-races around dst->output
Date: Thu, 23 Jul 2026 07:36:59 -0400
Message-ID: <20260723113702.3035088-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723113702.3035088-1-sashal@kernel.org>
References: <2026072042-collide-upturned-2e18@gregkh>
 <20260723113702.3035088-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2dce8c52a98995c4719def6f88629ab1581c0b82 ]

dst_dev_put() can overwrite dst->output while other
cpus might read this field (for instance from dst_output())

Add READ_ONCE()/WRITE_ONCE() annotations to suppress
potential issues.

We will likely need RCU protection in the future.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c9c9b37f8c55 ("netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h      | 2 +-
 include/net/lwtunnel.h | 4 ++--
 net/core/dst.c         | 2 +-
 net/ipv4/route.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index efbea74d03d915..27494911d6a100 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -449,7 +449,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
 /* Output packet to network from transport.  */
 static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->output,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->output),
 				  ip6_output, ip_output,
 				  net, sk, skb);
 }
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index a4632a64daae32..09791f5d9b6ec8 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -138,8 +138,8 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len,
 static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 {
 	if (lwtunnel_output_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_output = dst->output;
-		dst->output = lwtunnel_output;
+		dst->lwtstate->orig_output = READ_ONCE(dst->output);
+		WRITE_ONCE(dst->output, lwtunnel_output);
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
 		dst->lwtstate->orig_input = READ_ONCE(dst->input);
diff --git a/net/core/dst.c b/net/core/dst.c
index 12ab51f87da452..42d7c04d409bd3 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -150,7 +150,7 @@ void dst_dev_put(struct dst_entry *dst)
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev, true);
 	WRITE_ONCE(dst->input, dst_discard);
-	dst->output = dst_discard_out;
+	WRITE_ONCE(dst->output, dst_discard_out);
 	dst->dev = blackhole_netdev;
 	dev_hold(dst->dev);
 	dev_put(dev);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e5a1006daeefcf..186e05a5a9c447 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1704,7 +1704,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 		INIT_LIST_HEAD(&new_rt->rt_uncached);
 
 		new_rt->dst.input = READ_ONCE(rt->dst.input);
-		new_rt->dst.output = rt->dst.output;
+		new_rt->dst.output = READ_ONCE(rt->dst.output);
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
 		new_rt->dst.lwtstate = lwtstate_get(rt->dst.lwtstate);
-- 
2.53.0

