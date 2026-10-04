Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F51922FD
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791075492; cv=none; b=hPYQxZD9YMs2UfCpFJbVraW819hStGKatWTEyI4x9N5oEl+Y7OE6Y4LUZRdyALScmv9wBK9Lyw04hHeal5Cxw5OT7ZO48BvLOE378u3H973vcfkbsZHH7u6vXD9Sw38f/GsGMwHume+V/pnffB+bnp5xZjPiSqbXtEBLSdOXZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791075492; c=relaxed/simple;
	bh=LYxoSp6A7nT3XNiH0FkmTpqL/IgXBBNtqPa607AvI8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARgjhd+vP4L5WP7JJOxlJ0nFYqBEkkbAjhtE4swmpm4yxWVmatANE7Sf7AZkeAllxB3BV4PGA/QqyZmA6FlSQkmX4QUb62s0lnp5NJEtazSuYc+PQzbwvzLy7i2jhKC5bLllju8uTFtuz2zimRCCGo3ih3PybKBQAN60FDuDhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcEg2lPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcEg2lPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660D91F0089B;
	Sun,  4 Oct 2026 00:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791075491;
	bh=KNe2NZ+pUD31L8Qj9kjkn5HSouGleau3zC3Tst0RRbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcEg2lPafGRr4dew1+KL8Q8yeM5K53aPcE0qjU/vfG/ZtOJW0NYYihU3NPKNmO7JG
	 3i4ibUimlOMaiBkWCCefduTVEfkQy2t9yu1tUE1zUobwgcGGIyJsCRVzcELIznRjq4
	 PUGXZgHmlA3f13tqbxd4nPI6osTRxMs4cfzUAqb6KpmGt//y/NqUMPCNZw5MgtPHeL
	 IXw7si4JdCLV1U2pSi2HaYBk7O0IOSjICNSaUrrJyukk1GzNdmNdWQfxO8zt4epwYu
	 cT8C8I5kptY1tkvtdiKGhPVTT0jXKNMapvhGfmxplYPHMMzJHL9JqlNgJad+wAFSA7
	 Y6V25g3ADrw0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alice Mikityanska <alice@isovalent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] net/ipv6: Remove jumbo_remove step from TX path
Date: Sat,  3 Oct 2026 20:57:54 -0400
Message-ID: <20261004005714.1288223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100322-crisply-undrafted-2051@gregkh>
References: <2026100322-crisply-undrafted-2051@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

[ Upstream commit 1676ebba391dee944988ce3de1c23e038a3121d3 ]

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260205133925.526371-5-alice.kernel@fastmail.im
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Backport adjustment: retain the existing tunnel-aware extension-header
helper and remove only the jumbo exemptions from the GSO feature and
checksum-offload checks. This prepares those checks for the follow-up
extension-header detection fix.

BIG TCP still inserts hop-by-hop headers on transmit and GRO completion,
so retain ipv6_hopopt_jumbo_remove() in ipv6_gso_segment(). Removing it
would leave the synthetic jumbo option in software-segmented packets.
Devices with restricted IPv6 checksum offload now use software GSO for
these packets, which strips the option before segmentation.

[ sashal: Reduced backport -- upstream 1676ebba391de touches 2 file(s), this
  backport carries 1. Not backported here:
  net/ipv6/ip6_offload.c
  This note is generated from the file lists only. ]

Stable-dep-of: 5f0764cb1c81 ("net: extend IPv6 exthdr detection of tunneled packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 97be4f9dfa771..ac506d1a41f01 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3641,8 +3641,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_gso_has_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3745,8 +3744,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
-- 
2.53.0

