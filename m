Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C475013AB;
	Wed, 30 Sep 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779606; cv=none; b=Kv2UAMMFNEKGkSOi03uuSd9cc8n+4DOSUaKR9hTVqWSLZUZ/LL5OGVUqXfWSHCDM33yfPLwWybkiqtaevmKKybh7FDKUBTV6kg7Yam3L3lsgOq/9VY4PnoIwmKplvfTtYevS6dpcPdv5dyn9voUeI8Bfh3iF/VyMt+Uofum6z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779606; c=relaxed/simple;
	bh=XnUiW5VFoedZY+eP3TUUjBeCi3VffUB6KdXAqhe/1k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOwMmCX7UT34Lxfbpy0j0lEFhffPxtvK1OOVTEQTmTbBCRN6xN/JW1mDEva5grLuowShKIpfj4LMgDpDl1j7WvMaoP4zZQyicDFNwlKd49U8151/8MQjLHUGoM0kldKPCQuLMZKFHeWHKklnZpFxwzPRzp2o3Cv3tg67ULNJ2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=AYJxYcfM; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="AYJxYcfM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=T5XblxZKsNW6EFSZ9hSjNIHRfko62QFiItjh35VdEHs=; b=AYJxYcfM/IhnUv+k1Ejax4FVLf
	KGU+lK68f2379iOU2ErFRrvDabydvUwb8O0zHUqhpLPMewXg72mZppM9kCaMl1NjA3K1Vv4KndAO8
	+8nRNqhmEGgGNOjMg9Bl4/ct8XJoVrBcC+/VntmR2kDQnaPtVTUsoK5+P+sbFBfMZ4YlsQrEAIYEK
	+rJ/RpTuqXB7dKX3eOhbij/hRcq2Fcit8bx6wnOMOwZ27O7kcWxCWQCAvXwOGwDUvf682pxbhmgvc
	wHFiakoknuR2yRa0OOQCTURuOrWEm4qQYOaP9orBt+xBHDOX8A6ecB9VDDFUx+jQwtCPWiBm/84v6
	bzwaMiuQ==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZq-00000005QLT-0zhG;
	Wed, 30 Sep 2026 16:46:31 +0200
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
Subject: [PATCH ipsec 1/7] xfrm: esp6: use the current sequence number for the IV
Date: Wed, 30 Sep 2026 14:45:18 +0000
Message-ID: <20260930144523.435271-3-Jeremy.Jean@oss.cyber.gouv.fr>
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

When a GSO packet is split in software for IPv6 ESP,
validate_xmit_xfrm() calls esp6_xmit() for each segment. These
segments have XFRM_GSO_SEGMENT set, but after the split, skb_is_gso()
returns false for each skb, so each call increments xo->seq.low by one
after writing the ESP sequence number.

When encryption is done in software, the AES-GCM IV is generated from
the incremented value: if the last segment has sequence number 100, it
uses 101 to generate its IV. A bug arises when the next ordinary
packet is processed: it also goes through esp6_xmit() with sequence
number 101, but since it does not have XFRM_GSO_SEGMENT, no increment
happens and the same IV is reused.

Save the full sequence number before incrementing xo->seq, and use
that value to generate the IV.

Fixes: 3dca3f38cfb8 ("xfrm: Separate ESP handling from segmentation for GRO packets.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv6/esp6_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d..05d13cce22e4 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -346,6 +346,7 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 	}
 
 	seq = xo->seq.low;
+	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
 
 	esp.esph = ip_esp_hdr(skb);
 	esp.esph->spi = x->id.spi;
@@ -364,8 +365,6 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 	if (xo->seq.low < seq)
 		xo->seq.hi++;
 
-	esp.seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
-
 	len = skb->len - sizeof(struct ipv6hdr);
 	if (len > IPV6_MAXPLEN)
 		len = 0;
-- 
2.47.3

