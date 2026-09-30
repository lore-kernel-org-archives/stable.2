Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57A5013C9;
	Wed, 30 Sep 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779606; cv=none; b=Z/JLjQAPmjuyTRK+wT5MsTjgvmTsijxAdfRhujP3kpCulsfhIhPLq+xf58dKAM0X//3sxG+0Afg+YMOEhHGcWw67nRhaGu0XpqTCa6aKAxtPJ1dr8uzk7r10osk0ijcBvEvI//EvLMw845tuyihoVTnlFQiRnubzR6S1m2c1RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779606; c=relaxed/simple;
	bh=9lyw84XczQ3WW6w2jpwhKvTZttbsbJHhXCJ57V43VwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFvJhG9wQYduL3g7Ulnz1tUpS8HjZDebxayh9Ww2QhnxUkSemPuOy+BEU7rIBscnWeGkGOnZ++g6B4KmqjpErq6vKvZvC5DBHwN4RilCP4Yy0h3MX9faEztbaIyreWxELfFBOR6MdutXc8JUDVpcZYb+t9+KeGTDOBGRcEin0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=NUhcWWyJ; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="NUhcWWyJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IoXrO61KlpR633lXNE+xcQ6bFulflrt9FixsY4ZQxds=; b=NUhcWWyJMRLTHGi2ySvb4f6erK
	VfFmDGC2tunPnRhWyQun1Fu7XrZATkiJW5JMcv6jur7UQtM1L4ilupJnc++gXvRVXi0H/sfrmUxb2
	dEgPgGPuxOM3NQSxBAvLE5edej5lm8FqLL62brQqrQlULmvmwapjQTGip23u35LQjLNbtc3xxj3E1
	6uYne8+CmPi6cDNAKBUJrLopoew3kiMixUB/hFI409fKrFVZ+AFwnsCzpH8Os9WNDVgdiqIrSLl1i
	2Q43s7XYgpIaRpj4IQGIEx4/A9tv6iFC/ZK7fwqsnl6cfYkR7CfV/hfdMj2SipYG6gwURN6wMUf/j
	07S3iINg==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZt-00000005QLT-09rT;
	Wed, 30 Sep 2026 16:46:34 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for the IPsec IV
Date: Wed, 30 Sep 2026 14:45:22 +0000
Message-ID: <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb based
on the SA's current output counter. The metadata already contains the
high word for the first packet, so this can produce the wrong IV.

For a three-segment GSO skb starting at (H, 0), oseq is 2 and
oseq - gso_segs wraps to 0xffffffff. The helper then uses (H-1, 0)
for the IV instead of (H, 0). This can create a situation where GCM
reuses a nonce.

Remove the high-word adjustment and use xo->seq directly to generate
the IV.

Fixes: cb01008390bb ("net/mlx5: IPSec, Add support for ESN")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c         | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 6056106edcc6..4aa9f9c52f57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -153,21 +153,11 @@ static void mlx5e_ipsec_set_swp(struct sk_buff *skb,
 void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
 			    struct xfrm_offload *xo)
 {
-	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
-	__u32 oseq = replay_esn->oseq;
 	int iv_offset;
 	__be64 seqno;
-	u32 seq_hi;
-
-	if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
-		     MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - skb_shinfo(skb)->gso_segs))) {
-		seq_hi = xo->seq.hi - 1;
-	} else {
-		seq_hi = xo->seq.hi;
-	}
 
 	/* Place the SN in the IV field */
-	seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
+	seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
 	iv_offset = skb_transport_offset(skb) + sizeof(struct ip_esp_hdr);
 	skb_store_bits(skb, iv_offset, &seqno, 8);
 }
-- 
2.47.3

