Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2036409629;
	Wed,  8 Jul 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502328; cv=none; b=mWwXzfCVVagfsmWjkXqAHDHTk2CbSRWQtg1m8BOjeiHU2FQ+0NSgIdwzBe9SkQ07A8y4KEN91PA6FAz+MG3CQdYyRnS8bQMIFqsrB0M9+FXh3RBqoVxcQskN9oEQgK9Qh8DhmrAm67QathByNH2jT2jDFrRAzudsYHbTktO9/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502328; c=relaxed/simple;
	bh=2/KTGQFLECcRsrA6RbYWbSgCdgNrI6yF8x9qSnLNCqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9gw5cXu2h2iYSIfMvQBxXowASf/906evc1EQU252gMBK1WcVRF6lgekPsBOpm2BWL5sxalAMck8C4XBRDeF79LXZdOxdX8fiSt+NBEO0d7zyjRNYJZ0WnklE2P9LPRQO/ptE+czmFu9blVyF+rOKEWNVzkWYRfI58fAUjt8kwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=AGBDHvgk; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="AGBDHvgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoHitXwXZodRmHC2FnwvG2SXUd+kAGWLzeuLItlrFgE=;
	b=AGBDHvgkTOUH5WKelMcNP+01Dx9OGyFk+Z/Rvq4jQVEd2zvAPfEhjD/dAi6jlDAq5dWpnR
	KFDsB3IxDzm4j1QdJVBuKEdn9v4up6mM0mg0cpjPeULywOSz48bX58h/R1g+DcQelB3Qi1
	w7dvLNuIHVc3S5OAX0iPSmKxCdFCXIZT2/L1Zh1hn/ig0RoqrDVcremTjX3Ged9GSu+M/A
	dNHLpyIPkveySCs5kbZaatBYm+K4x3TzxLUC9mbsuTifpyaVQW8ccB3YL2p3053uvZS8U9
	NUr8cpSNiGltfqziUDuj4aLn11feyblxUfSJv0KU6NGCOCo1+nRx6OtKxfKg6A==
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
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 7/9] batman-adv: frag: fix primary_if leak on failed linearization
Date: Wed,  8 Jul 2026 11:18:19 +0200
Message-ID: <20260708091821.314516-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

If the skb has a frag_list, it must be linearized before it can be split
using skb_split(). But when this step failed, it must not only free the skb
but also take care of the reference to the already found primary_if.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: a063f2fba3fa ("batman-adv: Don't skb_split skbuffs with frag_list")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 13d4689d332dc..2e20a2cb64cbf 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -547,7 +547,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	 */
 	if (skb_has_frag_list(skb) && __skb_linearize(skb)) {
 		ret = -ENOMEM;
-		goto free_skb;
+		goto put_primary_if;
 	}
 
 	/* Create one header to be copied to all fragments */
-- 
2.47.3

