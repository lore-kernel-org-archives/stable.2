Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F74B0C9C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823358; cv=none; b=YqQxBnPOEEShwQF0k46C3h1O8ZlImKoE+eECQwMR9+8m9SWTfOokAMWLlwiCELI63w/VCk+Lszl3NAERuvIdCyICWmdZS99mSrfLZMKb5fRutHniSMyPbi8b4QrALtm18q4o3swc3ihwhW4Kou8d1YW91Dp/WbveuFLjsEfmIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823358; c=relaxed/simple;
	bh=XsLSqxOPfmsb4TomwCp/F4ALscZoCynvRPXM6BPNFP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6EpLCdpLrg/XGVhX8UZdgs+2iw9Nd/A16/itdyIvkQYJtlqsIvUKT8sLjTbO8zIq3d6Zp1oCM1BkHH17frWZP7PvQEDHKhTlcTjSQIKWhDK78wrMZ2V6gChNqQeebXyZaS63yqTdLOO3BkUOLjfKKgUX3gRUDIHXbOH5jJMH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiROKreX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiROKreX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A1D1F0089B;
	Mon, 12 Oct 2026 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823356;
	bh=h9s+OCWD+w76MI8rNPLtfHnpqZBGa1WdVpz8+zSPfUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiROKreX+zU30oFf7Uv/ZdFWOnf7/3reJtmi2xaEhO1NNeRqCLpWN7/v7Zbanr8XI
	 IQ14xbs8YCI2r0b3q4RI5NMOeXNGz7BCEMLb9OqSyxeZeOJ6tyhRJInDib+BIGyKnn
	 42yz1TrG0HvZd8jKkahlTGsYvtorSs3c7kSGkWwXi7GE1sKuCa+EoUN3g08bBoqq2m
	 VJ/jdLWwgzDW8fsuAAwAkGj8J5fW9Nj0y2USQRyTeY5z18q7S4+c+Oht1R6f7R8sRr
	 vNk0HR55b+c0/zgIdrl54TK6geTd1OwyWtLFnwtxbV21BfoloGg1NL/MpGM3Z6E3UY
	 495fxu36/BiVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ip6_gre: remove obsolete ERSPAN PMTU update
Date: Mon, 12 Oct 2026 12:42:35 -0400
Message-ID: <20261012164217.1134378-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101243-squid-unpaved-65ac@gregkh>
References: <2026101243-squid-unpaved-65ac@gregkh>
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
[ sashal: adjusted the removal to match dst6_mtu() instead of dst_mtu() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ce1ba9d2af405..0cc0e1113845a 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -951,7 +951,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1087,12 +1086,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	gre_build_header(skb, 8, flags, proto, 0,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst) {
-		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst6_mtu(dst) > mtu)
-			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
-	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
-- 
2.53.0

