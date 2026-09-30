Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44C4FD26F;
	Wed, 30 Sep 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779606; cv=none; b=eTKIvwBgabH6RkNTyMwVFqtEdq0szD/rkxLv1Cz+U7ALl3UoC6ZGSTVtssiPrlbgVFL82vPMFP3Vf3BSfITDvMbkPAHl13KmglwFZUV3EPgV4G3LlGdxBBpB/7FIIGsEKHP3eNyzmLSHGTxm/2eogO3om2wiewshhjLk6gbiDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779606; c=relaxed/simple;
	bh=Gk2KmIM5HVHotjadVdw6XjNAUVYMQ7BHMns73y9zOcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Va1jr+yXgLx2l6SH9QTrVacfty74V1xWKd61yCelKEG+NWCWkleNrrAhvQCQ7TkdfmgIuuy5V7NwQifdTRLhSAHjXFc4pRuFORR56ACbBYO4PHnHi62UTQfGwAG/IrXSpG1x2pMgwUAi5ZH2QB5aweLCSFvl1j/cm8bgkOoBVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=SxT29RnQ; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="SxT29RnQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5S00ri3B76HtSzx2LYGc3AjujUsHHk4tkIRT7/LJzYc=; b=SxT29RnQ12aMAPY5sG2wohNgFD
	i6PdamqxD990671MEr8GbvDJGyP8W0ygnmecjb/eoJemDwYqAGU8Zg/ro0CGOAB6MIjn1RvcIJwxs
	RVhmuvHKEmat/+QTU/EEuLQPcnNirT++prcPgjiG4EBja8V7N7sAjFUWq84gmsSoyd+qyyX+8UKLH
	yzeR+PwMOofSugs3i9MksrYWOnpcjBBV0WE5Dqstf7aE9vMUgCCBcMt/hbDfQb+U8shGxo73NO4hx
	hqegwGnTOLzkYS+9jy4vj4hBGX1m5y+xOlNeR4qe0KZmCqVqVQ7PCT5jn+OvdY7+TyV2avKoAGm1C
	H3X5nlBg==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZr-00000005QLT-0aLP;
	Wed, 30 Sep 2026 16:46:32 +0200
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
Subject: [PATCH ipsec 2/7] xfrm: esp4: use the current sequence number for the IV
Date: Wed, 30 Sep 2026 14:45:19 +0000
Message-ID: <20260930144523.435271-4-Jeremy.Jean@oss.cyber.gouv.fr>
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

When a GSO packet is split in software for IPv4 ESP,
validate_xmit_xfrm() calls esp_xmit() for each segment. These
segments have XFRM_GSO_SEGMENT set, but after the split, skb_is_gso()
returns false for each skb, so each call increments xo->seq.low by one
after writing the ESP sequence number.

The low bits are saved in seq before the increment, but esp.seqno is
set afterwards, using the saved low bits and the high bits from
xo->seq.hi.

When encryption is done in software with ESN enabled, the segment at
(H, 0xffffffff) uses (H+1, 0xffffffff) to generate the AES-GCM IV
because xo->seq.hi has already been incremented when the low bits
wrapped. One full 32-bit cycle later, if the packet at
(H+1, 0xffffffff) on the same SA is non-GSO, it generates the same IV.

Move the assignment to esp.seqno before xo->seq is advanced. This
saves H before the wrap increments xo->seq.hi to H+1, so the segment
at (H, 0xffffffff) generates its IV from (H, 0xffffffff).

Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv4/esp4_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..3a0aafe991f4 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -316,6 +316,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	}
 
 	seq = xo->seq.low;
+	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
 
 	esph = esp.esph;
 	esph->spi = x->id.spi;
@@ -334,8 +335,6 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	if (xo->seq.low < seq)
 		xo->seq.hi++;
 
-	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
-
 	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {
 		/* In the XFRM stack, the encapsulation protocol is set to iphdr->protocol by
 		 * setting *skb_mac_header(skb) (see esp_output_udp_encap()) where skb->mac_header
-- 
2.47.3

