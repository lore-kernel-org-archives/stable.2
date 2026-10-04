Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC120DD51
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791073686; cv=none; b=NqUN7bQt+AzL9frJB6RAiJa2QiE4+cct8T2QX0HcpHxmBMj8FrO3i4yH7qpFSeGcGA3W0k9UmuBK1fr2VpfGEUJBTjRJh8smsCzWElIcY0mUAZyAOOtbGbl8IIR8VvYFKjtrqIHzMoGufZV2vIRtNunvIFUJkpLRdWGMBCLQrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791073686; c=relaxed/simple;
	bh=vBdn+uGRrZSqTygIM8rct7JQHE6MG/y+T2fFfRTAaCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iimDeL7c76zJnvMnm5DcvgReiiRHuDWwreGEMnfxM1vw+SROXrBAnGUrc/gCToCusXMqC5kGflYvImvr8PbOwxFX9/a9UBiKOnebx1zOawNaGm9MJpu1HcpWgWF3TA2E+9f6Sf7aaT7lIsmlBTCCObNxmsj6BZtZ78Fr+OXpalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3hsj+fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3hsj+fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A051F0089B;
	Sun,  4 Oct 2026 00:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791073684;
	bh=Q7gh14PXQSZWryw9zNRvJq0h2l3NIrIWOF6KNUlQc4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G3hsj+fxtP2M6e5rOWoZ7avmtJ9lR0uVOi+b3GO9HQfjRd8DAHix9nDHCakwLgO2/
	 Z1EWp/lhco7x4a0J1ltpmge/0OvEB80DJc4asIlNeZkW/sNmiS34OI11k0j1lQbmo1
	 sndBknYrLs31TWFv4vr4Uy+Qi8im8HNl4wgy8D9ApION69dleg6xJe4EunX24bVhy1
	 kgZ3NZbfkhvkScZRKSoV45Onpjya0HWtKk9e502AVHUyFhi2Af3GI52/HOLH4vn6xA
	 ykWzGE8w4/C7xfbWYAvcDxg/n45K3QC8CgqerU17YqcKJu1G+Uw0rQqoX+eSCMfi3s
	 0TV4G5KgzIGgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alice Mikityanska <alice@isovalent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] net/ipv6: Remove jumbo_remove step from TX path
Date: Sat,  3 Oct 2026 20:27:48 -0400
Message-ID: <20261004002714.1231436-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100321-entering-brewing-b9b5@gregkh>
References: <2026100321-entering-brewing-b9b5@gregkh>
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

Remove the BIG TCP jumbo-header exemptions from the GSO feature and
checksum offload checks. Keep the existing skb_gso_has_extension_hdr()
helper when updating the GSO check so tunneled-packet handling is retained.

The transmit and GRO paths still insert hop-by-hop headers for BIG TCP,
so retain their removal during software segmentation. Dropping that
cleanup requires the earlier BIG TCP representation changes and is not
needed for the subsequent IPv6 extension-header detection fix.

BIG TCP packets with these headers now fall back to software segmentation
on devices limited to IPv6 checksum offload, where the retained cleanup
removes the synthetic header before producing segments.

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
index 6569605cc666a..e42ac7a306d07 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3824,8 +3824,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_gso_has_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3928,8 +3927,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
-- 
2.53.0

