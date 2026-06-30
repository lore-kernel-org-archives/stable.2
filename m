Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3090366052;
	Tue, 30 Jun 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827414; cv=none; b=AM7Lg9MftamFpsvOiDHrqImlrSBsTt8m4UW0ocWzR0BDmhUyC4BzTqvCjW3yc2LtK9DQOWAURbrkgfxZBs0xp9Y9WSigICLs8X5ftR0EjllYspYB4XIM97st/higI3nHDtiy+PiPKd6mHwldh8H98+9pcYMNl7P/39olm5ofgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827414; c=relaxed/simple;
	bh=0waat0bcc64myjOjt1ucKwriB7oQE5aosJTDY2Mu3n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV0xjiFR4JAW1q2o+zewMIpVzbGhR9HfCNroLhIxSmyiW81pQNOl7HCK/Y6lxXIoBDTx5CwBRZlEHmyU/FsrDvWEUOHCNIPLDpoyPJA91yT6ALxq3d+vaoQFZTJJfjFD5h6c8boCL+hzfpAf6XCpJ9rIieptZpTHSg4YivePQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=gSGup5cP; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="gSGup5cP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOjchQvhacxvYrMble3BHRhvtECYrwp0WDh1TmLB26c=;
	b=gSGup5cPIGZra0Xv5mvac2TW7IAkfBMTTDmKokVrMFVTdIcQX4RTZQB4da1DRBJk69tbNw
	OmXD0uvyEiF3ZcmlgHScJd8qtLwGlnTk+R4JgIrJ3GNybfVJKxBVedtauHfaMAA+aXFcGC
	iF+MzJyAZm4oq9VyYtAcv/PgWiUhnCUdZhlNN86N6c9ZLH/QBMUicyeRpqa+GxMlTPdIV4
	Bo9fc1Fp3QYFkUKi8WpRu522oW3xrXHb2TrHreFhdcwwzVqcmwEj4TrTpfyaU4xKX+9WqV
	XGj59EcKqkbDY/b3aZxRO2q19+2j7DTTD869zlUBGfj2NI9Kl49bcBvF3mNxhw==
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
Subject: [PATCH net 1/6] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Tue, 30 Jun 2026 15:44:25 +0200
Message-ID: <20260630134430.85786-2-sw@simonwunderlich.de>
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

pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the VLAN header but missed for the ethernet
header which is later used for the TT and AP isolation handling.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: c78296665c3d ("batman-adv: Check skb size before using encapsulated ETH+VLAN header")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 44026810b99ce..511f70e0706a7 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -434,6 +434,7 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
-- 
2.47.3

