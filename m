Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8D3321A2
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791078148; cv=none; b=ViagFDcV4ohfNVGS5Hsj2cDOV1yO5iUPm+kDl+jz8j2rmBApoxjJc7t//uWKqEAiQXnm8qHLReEMslIWNS7PbnDbSP64KfR0WT53RJqqsocxc5wOvpZzUu3/v35Uzp71NkhZRWqqA/A5ECjhUxf+y2y6K00l4acowD451qJU0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791078148; c=relaxed/simple;
	bh=HtOcYyD1GyIM28MkUSZVbYVOvmOakW7KRcqJkvhScSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHxc+DmZJ8Wz9GfZBpgZz3GJU4LZlEWqqBzBOYdlAr2jieVFiKDAAxGh8b2DLSjJKN7ngiSLLMsTLf02yqyjxXnyfelhoGTcayGbaqH9Mw94jY4lPJUvF3f819st0cXsFWLPUJWEYBwWkRNOGq5ouxFB6mQ4z5LRwYsyoaNApbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyvVzOPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyvVzOPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820A71F0089B;
	Sun,  4 Oct 2026 01:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791078147;
	bh=UaGViweejqCCQdMJPpCcdyUNCpX6MWfChqsLjpkc1SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HyvVzOPVJxxJnyRpZcGYePLT4fRgkcn6/XbvSm2P7+KDdTB4Ci03kqM9+eoa280pO
	 RX3f3cGsNGYvgmAK2EZp9Ao1n/GfDtgYdvC8EaMX3a9E1ufic2z+16OpvjGGXhfHUB
	 f0veoYaDbYxzXqiabJ+dLTBnyKv1+EJACMldydhqh9V8rLMCwUR5IVzGU17/OdcJY5
	 SpHuXwMbvbASEDdBHjCrDzy9Ag+u5IciZBtMbNG95Q74bDWFoS+gjic9nOxXMfMutx
	 rw/01Ow7qswzW3cxuIrPS178jibQoJNupfXzuPijsexrIgkzuIkLdcv7Bxf3EqtWyP
	 N1iX6MOZnNmOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alice Mikityanska <alice@isovalent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net/ipv6: Remove jumbo_remove step from TX path
Date: Sat,  3 Oct 2026 21:42:10 -0400
Message-ID: <20261004013959.1318049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100323-outfit-headgear-cf23@gregkh>
References: <2026100323-outfit-headgear-cf23@gregkh>
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

[ Adaptation: retain the existing tunneled-GSO helper and remove only
  the BIG TCP exceptions from the GSO and checksum offload checks.
  The transmit and GRO paths still insert hop-by-hop jumbo headers, so
  keep ipv6_hopopt_jumbo_remove() in software segmentation to strip
  those synthetic headers before transmission. Packets affected by the
  stricter offload checks fall back to software segmentation. This
  prepares the checks for the extended IPv6 tunnel detection without
  requiring the wider BIG TCP representation change. ]

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
index ee9bb7e8e5316..c61a33d74380f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3597,8 +3597,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    skb_gso_has_extension_hdr(skb) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_gso_has_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3701,8 +3700,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
-- 
2.53.0

