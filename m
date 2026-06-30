Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDF334692;
	Tue, 30 Jun 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827415; cv=none; b=mNOssWK1YW2EUQikghsefwfzfGYZZ2mey2bHIaLXoiisf993QdOF2RxMaMZhhJ2PxAb0Ra9ZGlRiIHYL89KeRiI5XVI2OUvHyF5qlZuu2LO+Ty1YS1RLb12bIqM39LdtJRmMw6bNytRA5aL65oLynX+GlGMUq7tGIP8iJ+N8XL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827415; c=relaxed/simple;
	bh=H1yo+HRogQu4ENymrsf+ZWvKvtld0kPKC9EmM3xCAfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPN1fqFlylHI6u3V3K0mJoZgtE7PqqsFAxG3HTcHPx2AmhBjlr0rAIjjVZu2l0ndYFHS43wMAPzODlY9OmbbkNTxuZ/5wOxYPlSsiZ8tu7KP917ZTJmUuVypnizFUR8fv5duKJJBKO7AucMw5/+0z8XixXVEKSpdwdUvDHIsGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=N0Qy26RZ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="N0Qy26RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDZ3PHvn8kVTKOAlVFvdCUxJ/aGwbeZvfumNwXha63c=;
	b=N0Qy26RZxx693ZUJkuy7Wm71ywlmlhnK2NXjhMCVgrcNRYLLup5LDJkJIPUT24H4LusegP
	SE1ntiSDgZdlVU1bTbjfaWqhL4xgJ2cz7Uclon6jUBzUm4vprVKqTpEEwWtXdg3kW/HRum
	ZuWoFZ1AZCshTGoiipIfzyyb4tToDHQjgPZSvNmGeNMxxvHZmqryG4spnGbfpak67hbwBy
	CXA3tvncZmuaPrlpMawcmxg/c5Klu9iI+ODV1uDnU0mMT7dPeJ3lA0wFC34FjnB9wOgf/M
	YsY6rvYjqh2pZaWe2luT+qOaAHj3mngn3cIRAwMneF5LG0HkrTmtoQtSkLdwjw==
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
Subject: [PATCH net 2/6] batman-adv: access unicast_ttvn skb->data only after skb realloc
Date: Tue, 30 Jun 2026 15:44:26 +0200
Message-ID: <20260630134430.85786-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the ethernet header but missed for the
unicast_packet pointer.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c05fcc9241add..2cc2307a41702 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -855,8 +855,8 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, sizeof(*unicast_packet)) < 0)
 		return false;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	vid = batadv_get_vid(skb, hdr_len);
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	ethhdr = (struct ethhdr *)(skb->data + hdr_len);
 
 	/* do not reroute multicast frames in a unicast header */
-- 
2.47.3

