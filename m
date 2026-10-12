Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6635295C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845461; cv=none; b=Ah70mMYJOb1/tGn6kLoiRmmWz6OaeS4C4Y4bLMW1+FzfUOWj9VT3NbcXnw1Cq8nWNwiGBiJf++1ws0DdkW3jhNqsxz1Mh5+yOb0ATe7rtrsZXfOiOt1ldScEip7sJkFzOin1THoPbLE327bNTnJQLEbSY/Bdl+GxZOCHmTHJ4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845461; c=relaxed/simple;
	bh=IL/gJWPEaO93zT9Q6yPJwgGjqc7LEOfepzU5UQIQg/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgFvSirSQx5w5G8q6LmbuNSPALCU8tJy/lNAEL8Z+tzZ2AT4S3wbQdXY/O7KONHS6IGS5WfP5ntRbjnPxXGrDmfg9oB6p/gvbH8JlZ0akRKpp1561OLVmUlnRKRlbTWC/AcWVQMigTCqJK6yZx8NOhm+SvsF1dxxACNuqkk3R14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6QVF5KI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6QVF5KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C411F0089B;
	Mon, 12 Oct 2026 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791845460;
	bh=ebQodE1sFA9xWanYSRjzn9jNhzNM+OzQB3VeWjomb7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6QVF5KIu0ROw0fxusAQMpOiovgXqeU2ejOe6L52DpAQUC4qgVt8rHpMBF5OkmOVQ
	 8/guAoZEdkS/AlkEDci8kbgfOfrxJS9QstcUW0HL8/+2avo+3ks4Hvb3q5w1IRLq2L
	 tw9XPCysKcoy7afy7tNW75dFD91BGqBleVfUyIo8/m3JSvLTxn7297ZAF52b2hdTuA
	 YctHux93/vm0mge/z9GjmUiiJBQL0ItuOq8/ZY2oLQF/7aVQuaND4NzJEfbyzbh4rT
	 Xoae6J1dirH4rUkWiiH632odBVDMaXrMB9pqS1bfSJ8WNlmMe/K1mk9OpEnj2bt/0l
	 0R+HJGkVy/r5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ip6_gre: remove obsolete ERSPAN PMTU update
Date: Mon, 12 Oct 2026 18:50:58 -0400
Message-ID: <20261012225044.1860654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101245-omen-grinch-fa7a@gregkh>
References: <2026101245-omen-grinch-fa7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 8bc60db48e8cba35488bbd6e1f94aa990afa275a ]

A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
and mirred can redirect it to a native ip6erspan device. The legacy PMTU
update in ip6erspan_tunnel_xmit() treats that metadata dst as a route.
Since it has no output device, dst_dev(dst)->mtu dereferences NULL.

On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0 used
self-created user and network namespaces to trigger:

  KASAN: null-ptr-deref
  RIP: ip6erspan_tunnel_xmit+0x10fc/0x2cc0
  Kernel panic - not syncing: Fatal exception in interrupt

The update is obsolete. Commit fe1a4ca0a2b7 ("ip6_gre: process toobig
in a better way") changed IPv6 GRE Too Big handling to update the
underlay route and removed the equivalent block from __gre6_xmit().
ip6_tnl_xmit() then propagates the underlay PMTU to the overlay route.

Remove the stale ERSPAN copy and its now-unused dst variable. This
eliminates the metadata-dst dereference and keeps ERSPAN aligned with
IPv6 GRE PMTU handling.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261002033058.358137-1-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted PMTU block context for direct dst->dev->mtu access instead of READ_ONCE(dst_dev(dst)->mtu). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index fb766066bcb0d..fc1b27cd75541 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -917,7 +917,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	struct net_device_stats *stats;
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1050,10 +1049,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	/* Push GRE header. */
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
-
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
-- 
2.53.0

