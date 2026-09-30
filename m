Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D734CFAB;
	Wed, 30 Sep 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779606; cv=none; b=M5pjtfg6bLka1zv+w6DR9LjiIcyDDCJJgWk+uvRsM6cmC1UuOBAeyISBiJDf5s42aIwJRX5zKnBpuhcp5oSylLcncIJrBxcf/Bb5hdMJM26GdGOk/wTqtjIZBs1u2K9guZEdTxdlxJVG44FAoirJNHN0A5qfLEYknUvTvRXWPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779606; c=relaxed/simple;
	bh=wYdphDGn60Xj8Em2zlR4+Ymfr+SDeiu3P1dI/KzFscM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0CkBAXYRxlhHRpYcOpu/EUNGFytmZOeWOW6JXPyPnqEhl0k1uyBwhp1HslSy+a1q4m1M7uvX9QFGNjphHJDcT11rCelwRUJueTLzyRAWWMs9pSptqivJZite54kCnZugjY6T9+FOFw/JlGrtfdO+n7hROCMxGVle54s50Jb0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=BzIPioPg; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="BzIPioPg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sVyhSdsOOd7fZyJcX/x7aj2Fdoi5chXIw93AtAvuVsQ=; b=BzIPioPgtQsee/hk8d05s8MTM5
	q3CQjTiiikjRYPTXqvAtEH36KHl796rjcdZ4XKSwOn9a4VBNMYHamo9bLTpLU8exprL4R3X7BR894
	2hNFBdJwhTrdr08lvaxwmsH1PBcRloMSVtJWjpytRtRGhbYGQceRmjhbrzOkP0K91AFrEUXAcsret
	QDbf8RBYo0bs2ugdDikpcRAYYL9caH6qZKLhcdorlA49a56rARGSpceioD3ADgNTndb5q/1oeeHDF
	8VAVEXzB2u892RLlU3y6QpO3I+noHbgEUnUU2LFHovJBHZn99v0cHrDT1SDAoEbrWMtRdMsVY5zD6
	z9uffc7w==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZr-00000005QLT-3HqL;
	Wed, 30 Sep 2026 16:46:33 +0200
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
Subject: [PATCH ipsec 3/7] xfrm: esp: use the current sequence number for AAD and offload
Date: Wed, 30 Sep 2026 14:45:20 +0000
Message-ID: <20260930144523.435271-5-Jeremy.Jean@oss.cyber.gouv.fr>
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

When a GSO packet is split in software, esp_xmit() and esp6_xmit()
advance xo->seq before software encryption or the handoff to the NIC.
If the 64-bit sequence number of the segment is (H, 0xffffffff), the
counter becomes (H+1, 0). Both the software ESN helpers and drivers
such as Chelsio then use H+1 instead of H as part of the associated
data that is authenticated.

However, the ESN 32 high bits are not present in the ESP header: the
receiver reconstructs the 64-bit value from the received 32 low bits
and its own replay state, and uses it to check cryptographic
integrity. It uses H for this packet at the boundary, so the GCM tag
computed by the sender with H+1 fails verification, as it is different
from the one obtained by the receiver using H.

Use the high bits saved in esp->seqno for the software AAD. For
hardware encryption, restore the current sequence after skb_ext_add()
makes the secpath private, leaving the shared counter advanced for
the remaining segments. Restore both halves because drivers can also
use xo->seq to generate the IV.

Fixes: 3dca3f38cfb8 ("xfrm: Separate ESP handling from segmentation for GRO packets.")
Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv4/esp4.c         | 13 ++++---------
 net/ipv4/esp4_offload.c |  4 ++++
 net/ipv6/esp6.c         | 13 ++++---------
 net/ipv6/esp6_offload.c |  4 ++++
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db5817e78..04f27c41ea50 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -271,20 +271,15 @@ static void esp_output_restore_header(struct sk_buff *skb)
 static struct ip_esp_hdr *esp_output_set_extra(struct sk_buff *skb,
 					       struct xfrm_state *x,
 					       struct ip_esp_hdr *esph,
-					       struct esp_output_extra *extra)
+					       struct esp_output_extra *extra,
+					       __be64 seqno)
 {
 	/* For ESN we move the header forward by 4 bytes to
 	 * accommodate the high bits.  We will move it back after
 	 * encryption.
 	 */
 	if ((x->props.flags & XFRM_STATE_ESN)) {
-		__u32 seqhi;
-		struct xfrm_offload *xo = xfrm_offload(skb);
-
-		if (xo)
-			seqhi = xo->seq.hi;
-		else
-			seqhi = XFRM_SKB_CB(skb)->seq.output.hi;
+		__u32 seqhi = upper_32_bits(be64_to_cpu(seqno));
 
 		extra->esphoff = (unsigned char *)esph -
 				 skb_transport_header(skb);
@@ -543,7 +538,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	else
 		dsg = &sg[esp->nfrags];
 
-	esph = esp_output_set_extra(skb, x, esp->esph, extra);
+	esph = esp_output_set_extra(skb, x, esp->esph, extra, esp->seqno);
 	esp->esph = esph;
 
 	sg_init_table(sg, esp->nfrags);
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 3a0aafe991f4..6f6ce9ea5c49 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -358,6 +358,10 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 		if (!xo)
 			return -EINVAL;
 
+		/* Keep the current sequence number in the private copy. */
+		xo->seq.low = seq;
+		xo->seq.hi = upper_32_bits(be64_to_cpu(esp.seqno));
+
 		xo->flags |= XFRM_XMIT;
 		return 0;
 	}
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b1c9b36f76dc..7d3e9c5b3992 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -308,20 +308,15 @@ static void esp_output_restore_header(struct sk_buff *skb)
 static struct ip_esp_hdr *esp_output_set_esn(struct sk_buff *skb,
 					     struct xfrm_state *x,
 					     struct ip_esp_hdr *esph,
-					     struct esp_output_extra *extra)
+					     struct esp_output_extra *extra,
+					     __be64 seqno)
 {
 	/* For ESN we move the header forward by 4 bytes to
 	 * accommodate the high bits.  We will move it back after
 	 * encryption.
 	 */
 	if ((x->props.flags & XFRM_STATE_ESN)) {
-		__u32 seqhi;
-		struct xfrm_offload *xo = xfrm_offload(skb);
-
-		if (xo)
-			seqhi = xo->seq.hi;
-		else
-			seqhi = XFRM_SKB_CB(skb)->seq.output.hi;
+		__u32 seqhi = upper_32_bits(be64_to_cpu(seqno));
 
 		extra->esphoff = (unsigned char *)esph -
 				 skb_transport_header(skb);
@@ -575,7 +570,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	else
 		dsg = &sg[esp->nfrags];
 
-	esph = esp_output_set_esn(skb, x, esp->esph, extra);
+	esph = esp_output_set_esn(skb, x, esp->esph, extra, esp->seqno);
 	esp->esph = esph;
 
 	sg_init_table(sg, esp->nfrags);
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 05d13cce22e4..682063bfe685 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -379,6 +379,10 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 		if (!xo)
 			return -EINVAL;
 
+		/* Keep the current sequence number in the private copy. */
+		xo->seq.low = seq;
+		xo->seq.hi = upper_32_bits(be64_to_cpu(esp.seqno));
+
 		xo->flags |= XFRM_XMIT;
 		return 0;
 	}
-- 
2.47.3

