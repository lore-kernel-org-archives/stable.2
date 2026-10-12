Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138124C227A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840861; cv=none; b=KhukXdtupqAdu40r3uDPqZxewR4F4yIk8SjDRkvlCLNd1axUbic+12ivZ8W+xblEGSWHmaYoysr/8TQIhqVK9ofNYbzrYGkStdfSboA3qUn/8RYM2G2zb10p6oBJQO/dC3iEXZeI3u9bz+v2iotjeuWOkiSmGegrywblvqxaftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840861; c=relaxed/simple;
	bh=UctqwLPESLFBObmNLViyigWOUjCGagAQbUUpgdtCH74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5AOFFoMQQFVDohMKzY8K61RTPSAIgI9bwVgv+GoFJWbHLeIDmzso/IKXi3pi886E2jeDhqgru8NC+SZ58pXUN0s1yUkHjW/zGmBzU+YmnQpJv4jIwal97BmlFQ1uP5AEA+2aiHCiwKamKHq1AyPk7DmrkwdG9zVUq55bv3jbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzSjhAiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzSjhAiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0D91F0089B;
	Mon, 12 Oct 2026 21:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840859;
	bh=eksqOxiem3EDFn+gBeUAoblVZv0QRx7rFvahWMGuVqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzSjhAiScsh8f8J2Z+XMNzH7cpcPUIs5wQ+NHM0+YstKtEbxxZ7IrcbNsCJXA+p54
	 4SX7TOm68YcfypeMRJnaOgqnEknu6UPbSU4HuUO3cz5Hs1VY7Y/+ShMdRS8Hspp5jW
	 JnUjr07BHgli72chvWnsW3tJLyilImvQrASssJBzc/bEi00PqZ3Dpus3+390CGW4hT
	 tTGY1gLPYWavaH8ryW3MpYms1+oPzwQ7BLl8FjD2ld0ZQx+Y19vAaLk5goKyfVhbMk
	 SwWvEp4L+uRhXUJ++7lf+gDHIR4GqDkFYupR8xNhU1Bm1uGp+MFX3tYHTM+K9jJxuz
	 k6I5BW9TnJ9aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ip6_gre: remove obsolete ERSPAN PMTU update
Date: Mon, 12 Oct 2026 17:34:17 -0400
Message-ID: <20261012213357.1591422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101244-railing-trance-37fc@gregkh>
References: <2026101244-railing-trance-37fc@gregkh>
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
[ sashal: Adapted the removal to the PMTU check using dst->dev->mtu directly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 950d5e74b094e..73ec4641f2201 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -962,7 +962,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	bool truncate = false;
 	int encap_limit = -1;
 	__u8 dsfield = false;
@@ -1094,10 +1093,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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

