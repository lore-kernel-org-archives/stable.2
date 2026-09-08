Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CC5908DA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888794; cv=none; b=aDdg4EevKz5wkxhpr3m9idsMYl1uI4qNOolo4Txd5nhgiVJJX/tWyv5KKMHiAqXb5aIyXX/3KRNDv3g7+9LZQtppsC8x1qAHPJOmrec/5ixhf1gj6Bf3wsuDi+0hhFcczNr9W4UGHITEL5csdagmUPRysKRCots1jynVSsD2tg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888794; c=relaxed/simple;
	bh=PV1Ye90ahx3lZcidjdL3GBfRcD3FgcLezaALbpmxGQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCfSQx3yM8JovlE9q9A3++OTlcYvDZVU5m0vZxmFHBYUXVfGkPpkXyTKQhYVKxz5CnhXEqFj1ISxCPBhFcnxISBd7flj692z+fvZSzfDrGgpiGmQp2JYYIbxZHCMpyl05iYm6AIrWF6CryvOGVU79MgftkxVi4w9Dq9kqBxNHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hno2modj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hno2modj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0471F00A3D;
	Tue,  8 Sep 2026 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888792;
	bh=xejbvm2bPMDVbsebyRhi+itCsZSm49BxEi/MA+60dsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hno2modjH2LsVUsA6FTr1ntmro9pF9jXvdlt0tK6HLz2PMexHUXgDGszavUhB2bwK
	 zZ9uMIa34ga+rsWF2P6krdRrnIUEtq0ROK8iQBYK/OD9NO0z43sJszSLXHLHDs5Uhv
	 vTjgPvYrN/KWUsAF8ZYEMQ7HoMkz0KlUtk3F0sCwDNHyoWIwGuvFDaJitwwuCirXYS
	 ppDDQzs5f2xfMAPSIHaNHW+ptfCCXxW43ISZVfTYKGDtPIhpLIQtJKORW30dp8Fel1
	 vfvinReDk8L+UiVJxYBp1P1LZ58QAqGat8wh6ODCN9Jj/poTl/YhRTU64e3Ju71jSj
	 rzu4rieJlwLqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eyal Birger <eyal.birger@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paul Chaignon <paul@isovalent.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ip_tunnel: Respect tunnel key's "flow_flags" in IP tunnels
Date: Tue,  8 Sep 2026 13:33:08 -0400
Message-ID: <20260908173309.106466-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908173309.106466-1-sashal@kernel.org>
References: <2026090359-hurry-disagree-2db4@gregkh>
 <20260908173309.106466-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eyal Birger <eyal.birger@gmail.com>

[ Upstream commit 7ec9fce4b31604f8415136a4c07f7dc8ad431aec ]

Commit 451ef36bd229 ("ip_tunnels: Add new flow flags field to ip_tunnel_key")
added a "flow_flags" member to struct ip_tunnel_key which was later used by
the commit in the fixes tag to avoid dropping packets with sources that
aren't locally configured when set in bpf_set_tunnel_key().

VXLAN and GENEVE were made to respect this flag, ip tunnels like IPIP and GRE
were not.

This commit fixes this omission by making ip_tunnel_init_flow() receive
the flow flags from the tunnel key in the relevant collect_md paths.

Fixes: b8fff748521c ("bpf: Set flow flag to allow any source IP in bpf_tunnel_key")
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Paul Chaignon <paul@isovalent.com>
Link: https://lore.kernel.org/bpf/20220818074118.726639-1-eyal.birger@gmail.com
Stable-dep-of: 6776efe4a52f ("ipip: fix skb leak in collect_md mode when metadata_dst allocation fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 3 ++-
 include/net/ip_tunnels.h                            | 4 +++-
 net/ipv4/ip_gre.c                                   | 2 +-
 net/ipv4/ip_tunnel.c                                | 7 ++++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 96b098df144ea..39e2f5c3548e8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -424,7 +424,8 @@ mlxsw_sp_span_gretap4_route(const struct net_device *to_dev,
 
 	parms = mlxsw_sp_ipip_netdev_parms4(to_dev);
 	ip_tunnel_init_flow(&fl4, parms.iph.protocol, *daddrp, *saddrp,
-			    0, 0, dev_net(to_dev), parms.link, tun->fwmark, 0);
+			    0, 0, dev_net(to_dev), parms.link, tun->fwmark, 0,
+			    0);
 
 	rt = ip_route_output_key(tun->net, &fl4);
 	if (IS_ERR(rt))
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f858df8325d15..53f057b4f1f43 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -243,7 +243,8 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 				       __be32 daddr, __be32 saddr,
 				       __be32 key, __u8 tos,
 				       struct net *net, int oif,
-				       __u32 mark, __u32 tun_inner_hash)
+				       __u32 mark, __u32 tun_inner_hash,
+				       __u8 flow_flags)
 {
 	memset(fl4, 0, sizeof(*fl4));
 
@@ -260,6 +261,7 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	fl4->fl4_gre_key = key;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_multipath_hash = tun_inner_hash;
+	fl4->flowi4_flags = flow_flags;
 }
 
 int ip_tunnel_init(struct net_device *dev);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index a812d7e5adcc6..02cec5335b7d4 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -614,7 +614,7 @@ static int gre_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	ip_tunnel_init_flow(&fl4, IPPROTO_GRE, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
 			    key->tos & ~INET_ECN_MASK, dev_net(dev), 0,
-			    skb->mark, skb_get_hash(skb));
+			    skb->mark, skb_get_hash(skb), key->flow_flags);
 	rt = ip_route_output_key(dev_net(dev), &fl4);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 7ddadf779004e..b4e655903190a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -295,7 +295,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
 				    RT_TOS(iph->tos), dev_net(dev),
-				    tunnel->parms.link, tunnel->fwmark, 0);
+				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
 		if (!IS_ERR(rt)) {
@@ -583,7 +583,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id), RT_TOS(tos),
-			    dev_net(dev), 0, skb->mark, skb_get_hash(skb));
+			    dev_net(dev), 0, skb->mark, skb_get_hash(skb),
+			    key->flow_flags);
 	if (tunnel->encap.type != TUNNEL_ENCAP_NONE)
 		goto tx_error;
 
@@ -741,7 +742,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, RT_TOS(tos),
 			    dev_net(dev), tunnel->parms.link,
-			    tunnel->fwmark, skb_get_hash(skb));
+			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, tunnel, &protocol, &fl4) < 0)
 		goto tx_error;
-- 
2.53.0

