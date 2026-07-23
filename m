Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F542F718
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806632; cv=none; b=hYAWLLShj1P4acuuEJkAYHJZ0hz0MiYdDQ2OZwW+R/jNhlRuHBWfKTegwurHTg3ljKd1lPyYw2Dua5tU7ZLBiDakG4CpTVWfcPEzzjelTkpf84jiMrZbjpL5qpjOex6kaZjXbTOhe01ouVoMc8YW6KR3MwcPAHNxfXtW2KCFAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806632; c=relaxed/simple;
	bh=RwBKOcqq7KlNhDqSXUwfKLZ4p/ZPhQuzqdxPSGVTUho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7xCK7zRuViP0+p1NtrQQHDJSTgWI7PGAejzKI9NZl7RNOKR1IAFT7+NkZaYp9UdisJk0Wxr9fM1k+73+MZUP3ebVX/TjARbH/A05hdFaC9qQrDBBTpB+cPmNi3fBPU5Fs5zVGJu2j+7lBqZ2DPPtp8VhfTuy/pT9yTl7CICLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjjUWLa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjjUWLa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D701F00A3E;
	Thu, 23 Jul 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806630;
	bh=xLndCf/f7hq8H692H9YsVPUB9jJWI2f5CGDeEhSIwRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjjUWLa8fnArpfV7rE+u3KudBuctnj5yP+qiMFFA+JYjXs+1bLt0gqtCKWi9ueKzR
	 acrQohHCqrirScgSH0d+yDPkqgomwfhTRt+BvhwhGz1BIL2hqEJ44I1NVIK6y0K1XF
	 kRPU8uaLochEAqnow+W7XPIiDWBPcx733DMriAEe7oaF43z+PIeW0j2FjwGnIbMly7
	 FiQgN/hl6NrdQ7K0cJ47mAOaMVbf0j9pdJhxK1Ni+3WvdIiEP9r7IdPVkLkCOIxkWH
	 mtfXvm5oK1k0YxBfWo3SEP3FstqhK3eodS2xkcOM/NKOH1SmHPO8sinBaS/biji9dh
	 G1PIi2G5sYFXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] net: dst: annotate data-races around dst->input
Date: Thu, 23 Jul 2026 07:36:58 -0400
Message-ID: <20260723113702.3035088-2-sashal@kernel.org>
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

[ Upstream commit f1c5fd34891a1c242885f48c2e4dc52df180f311 ]

dst_dev_put() can overwrite dst->input while other
cpus might read this field (for instance from dst_input())

Add READ_ONCE()/WRITE_ONCE() annotations to suppress
potential issues.

We will likely need full RCU protection later.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-5-edumazet@google.com
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
index 76a0afabb3c815..efbea74d03d915 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -459,7 +459,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_local_deliver(struct sk_buff *));
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->input,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->input),
 				  ip6_input, ip_local_deliver, skb);
 }
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 53bd2d02a4f0db..a4632a64daae32 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -142,8 +142,8 @@ static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 		dst->output = lwtunnel_output;
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_input = dst->input;
-		dst->input = lwtunnel_input;
+		dst->lwtstate->orig_input = READ_ONCE(dst->input);
+		WRITE_ONCE(dst->input, lwtunnel_input);
 	}
 }
 #else
diff --git a/net/core/dst.c b/net/core/dst.c
index 6d74b4663085fc..12ab51f87da452 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -149,7 +149,7 @@ void dst_dev_put(struct dst_entry *dst)
 	dst->obsolete = DST_OBSOLETE_DEAD;
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev, true);
-	dst->input = dst_discard;
+	WRITE_ONCE(dst->input, dst_discard);
 	dst->output = dst_discard_out;
 	dst->dev = blackhole_netdev;
 	dev_hold(dst->dev);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4a7789ac0c1015..e5a1006daeefcf 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1703,7 +1703,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 			new_rt->rt_gw6 = rt->rt_gw6;
 		INIT_LIST_HEAD(&new_rt->rt_uncached);
 
-		new_rt->dst.input = rt->dst.input;
+		new_rt->dst.input = READ_ONCE(rt->dst.input);
 		new_rt->dst.output = rt->dst.output;
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
-- 
2.53.0

