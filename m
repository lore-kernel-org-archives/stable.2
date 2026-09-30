Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEF4D7D2C;
	Wed, 30 Sep 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779606; cv=none; b=C0QD12ak41Y1qhueSuNhp05VQtBqh9nNx/IAY1chLuPTqD2+wedNr90WMGIJT/FSd2N0U3XBQ07Zwx5cLxAJFcADWeUM8P2IF2rMWrPmd/BMdV4Q50ruo6Ox8h83H2xUGY3f2ZABbpcElPG0tePHiEzjhlvsOs8RaLUX/GfZWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779606; c=relaxed/simple;
	bh=zc/1DshwQZG3h0a1eESrUsDpJVJE60wypG9PdkT+ubI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MarS0wLokd21OMW6y3QyvO7DIsLby5qLZjZf6W9FhE+/OFILW8FSMVaz67HTd5TNHi2bciiAHMePKxT3RDf5Rnb4hO9DibcOs/rV+ulI7gNK35Swa0olRcA/JMKlYdsUKqLkzFv/5IAZDzq0ZW64Wxeslx1MtRmNmmVP3Pii2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=U+nVFRha; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="U+nVFRha"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=14K/qMFZnosuQ0uLGotnnjgPLLQm6f4qGAoVyZOWJtM=; b=U+nVFRhaXLo86oPTh2yOqFrhm8
	Xy0/dzG3ejZ3ViYJT5WciYrDNMySd6R6WSz0ml+v9BKNlBOlLUvg/4MF0BbDvllSxTwmmfsEYTwJ8
	OoBMfzyM4DHc0yjNakOf9vnAd7ZqdL6r2MIRV3g2aeBAA6lkpGujYNhDi2D2GPhDsj97dLZXx2TkK
	6APahDxDT5XRGiL10JequUHcwd5peV/5DZcRxZqiGfV7DPCCXlwUMdNnW/uMldhBa+XVXUUNzepHj
	YNlWJeZgoWvM+BtdLxQ/0voV2q42IScJgJUKezwaFF2CuY3ZLgKaY6R+G+TNz6TO1hmlORI4lP8wL
	vZNkAXvQ==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZt-00000005QLT-2f9N;
	Wed, 30 Sep 2026 16:46:35 +0200
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
Subject: [PATCH ipsec 6/7] xfrm: segment untrusted GSO packets before sequence allocation
Date: Wed, 30 Sep 2026 14:45:23 +0000
Message-ID: <20260930144523.435271-8-Jeremy.Jean@oss.cyber.gouv.fr>
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

Packets received through TUN or virtio-net can have gso_segs == 0,
with SKB_GSO_DODGY set until the segmentation metadata is checked.
When ESP defers segmentation, gso_segs is still zero, so the SA
sequence counter is not advanced. The segments receive sequence
numbers starting at oseq + 1, which subsequent packets can reuse,
causing AES-GCM nonce reuse.

This affects IPv4 and IPv6, with or without ESN, when the ESP offload
type is registered. Hardware encryption is not required.

Segment SKB_GSO_DODGY packets in xfrm_output() before allocating
sequence numbers, so each segment gets its own number. Set the ESP
encapsulation flag in xfrm_output_one(), after early segmentation, so
UFO fragment offsets and flags are filled in correctly.

Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for offloading")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f6644daa68ba..30b95aba10f0 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -505,6 +505,9 @@ static int xfrm_output_one(struct sk_buff *skb, int err)
 	if (err <= 0 || x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
 		goto resume;
 
+	if (xfrm_offload(skb))
+		skb->encapsulation = 1;
+
 	do {
 		err = xfrm_skb_check_space(skb);
 		if (err) {
@@ -812,10 +815,10 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		xfrm_state_hold(x);
 
 		xfrm_get_inner_ipproto(skb, x);
-		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
+			if ((skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
+			    (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL))
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
-- 
2.47.3

