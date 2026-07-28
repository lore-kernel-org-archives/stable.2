Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1F353A9D;
	Tue, 28 Jul 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245972; cv=none; b=MjKrmxfQ2WwWJeWoJPLtzZl8vG/FfiI8ziD4O/ETcMDVzh3QitTMVPsCc14ra/+tAYvFxlG4/3swAk5OOb9XqvvSUkKW8Ca2fo2cyuqYjmHbCADaZSzm8EAq9EYucLJ6qNQglPGgAzWsUez5zqHG0R9lff3F36hzu724/sCw940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245972; c=relaxed/simple;
	bh=LCNWp166FiGU/3Gkjyrrx1lyyr2vl7MIA0Y8Uqvu5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilw07tU8UkU3BFr3mXEBL7qyvWhDCwIlz8+eAY73IIDGtXW3ftGC+T+9XbWacCrT9ZZy4OlANVrRZUVMF0/jZzMs1WbvqaqYxqW0Q+jDDQM/hnaqT0037My1I8ZPbdU03+WkHLQ4OPAPKLppW0CDI+Fr70C8ulbmCuN0PWUp/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=qwKKXFUd; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="qwKKXFUd"
Received: from kero.packetmixer.de (p200300c59717Ead808F168C97E5563a8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B610EFA128;
	Tue, 28 Jul 2026 15:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlGWbLUy89WAmmXZ/1xLRELWDvmfS/fkFJGA8kissPU=;
	b=qwKKXFUdwLmUwFIM0ggYjJm/vSNwKVL/NiFGiGiKHAZxfC7qpmUUuu+7YoEwzzFWiFs6cQ
	V+T2iMaWy5kponH6T28uQnenxhQ8Yi6/TBMxqO5p8NI9HP5i0sb8WujBAXCXgDyXDy/SAI
	b1O5LzLv7blGqbygLFgPsLehbPDPi2l/o/lKAcfZP2qbA5OfTOSPLGQgWgWC/NIW+RI0l9
	VlQ2b2oqo+GUE1iDcGFznlM0xI4hRE+AYOnhCJJGAbr1tnjKsLGLKVWNL1BkFWn1ezvWNv
	8B45bnWOQZddj/v0AxER3i7eEtL0JUqAFweZprVX3jyw+G6z50p8vwhrtuM9KQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 06/15] batman-adv: mcast: ensure unshared skb for multicast packets
Date: Tue, 28 Jul 2026 15:39:09 +0200
Message-ID: <20260728133918.643267-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When a packet is transmitted via a batman-adv interface and has already
enough room for the header then the nothing will make sure that the skbuff
is unshared. But it is now allowed to modify a currently shared skbuff.

Always make sure that the pskb_expand_head() is not only called for a too
small header but also for shared skbuffs.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 1404a3b7adfb1..240ed7380cb0f 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1100,8 +1100,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < hdr_size &&
-	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.47.3

