Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032840913C;
	Wed,  8 Jul 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502739; cv=none; b=jT4ukVxG1yWc+rCepOVBXyYOjBPV4LZYGcnSv7qfr/qd1jPdxHDOuyaN8gQJdtKyjtCxYLFFv/7tN7kA4zLGSguxxj2/Zqd/tUJMXRkw2YS4qnIjxWz5hKLN0HHAyiTKjZ0OgX3fg2rLOCTuCD/cKQs7PjL7+c1x5FmtY8xo6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502739; c=relaxed/simple;
	bh=Vh4xyjTCbQ8k7s3KHdoOeDrfN9h+Dzh0l/Pu+qYgBV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvBGypBo92F45ELwqoIxfRJAiOZt4MaC5NXj84mB6sKGbL8iKPHs985oREl+spwxdTIs7mp30DVyfhN51wRLW3jqLjEK4/bMnKJyv5Ke8z2pP9uC/veZcqg0hYY7FiRnLNLiEcp1yxQXmueHOBs5lve/Tm+PYmzO0HAoEs71bRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=YxAPM70f; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="YxAPM70f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5J+tIbRjyAogUs4+BXpxDdI90HGCo95hYrshku0PZg=;
	b=YxAPM70fqXr0DJvTU/LwJcskGVz/oMIVqoaWY7+4fsEc5eW1IdEHNQs009Srdfo5Bddyma
	vKPRC0k097WMBy5omhxm3BpMQHahHSLCKNqDtPTTP5w7bb+HzXosN3fwK1QT6/nHnOykwx
	tsE5sV2bdIOvSyjoeeK04tY3P3evHRhGBM7Ssq2Pf/IwJjhVRNljEUNPcliweNAeLssvDn
	Y+k/mboC2wT4S8kmUC3vIeTkr2H0HPcewA6qCxUsKI8xkArfhr5oEqWmZGhpsqcmsw30Qj
	AzQfeeaPV6bQAs8XQviTGNh4/aX9iEvSgoY5xjDMhpqB6nkSo43y9G/MjE8JCQ==
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
Subject: [PATCH net 1/9] batman-adv: ensure minimal ethernet header on TX
Date: Wed,  8 Jul 2026 11:18:13 +0200
Message-ID: <20260708091821.314516-2-sw@simonwunderlich.de>
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

As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
at least eth header len bytes"), it is possible by for a local user with
eBPF TC hook access to attach a tc filter which truncates the packet and
redirects to an batadv interface. But the code assumes that at least
ETH_HLEN bytes are available and thus might read outside of the available
buffer.

The batadv_interface_tx() must therefore always check itself if enough data
is available for the ethernet header and don't rely on min_header_len.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 511f70e0706a7..0b75234521b63 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -195,6 +195,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 
-- 
2.47.3

