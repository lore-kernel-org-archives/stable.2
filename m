Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004802;
	b=NrLV56lYQwa2bi4haq5clQlHrOXufwEhvYSYIdUCdqfJMc0/m82xg0u+Y+R/iXxqywnO
	 MjV5LlKjh67tm8eJo3hGDAaBk+BjbpeLsSrtOisXt+8DNHa8db/knyEChdMPYdJHikaVE
	 DpsTvpVj3qpVSCVaISpWy1Lm7wN7lFZNFPbYeqdSp/HQ0YFHyocSTm56k3jLdYMLncqQI
	 RRAdxFgBK1JQteTVmScaA1hpS1f3udHmWkWe+9z260Z9pdM329EeWz35kpP3i734LCnNq
	 V0YqsyluatS89O9e97dSm0xkZYjNu/Juk61IHVvpO+MPYV0zhnmhb4VzWA2JE3uYaaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004802;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
	b=3Aj/jza0rNsTwfxhWd8NTASkFRT7hADtz0tqRhyQ2isnNLBxqLSmqE3DEcYPEz1aWS9G
	 BjcjSYlMiQglvkB2klm1rvy6bD1tMVel8aNWjm63+F7fgiYx2llYg2cVT/ScL49qMJxI4
	 mT+wk+apu7/bZSW14IG0MGws5BPgsnvnyfm/LPsU+cOWabbLEia4LMuKyUoHJojAz5WMY
	 U3LXLXLtoVdCkwJx9vGAuGygQ6OBJkYD58MN00XoPBfrozMFQ4965lTY+fVuFORP+mhml
	 de/h6kbkJ1QZ3VQn9DW0GtW85lQwzz8D0CAeGZhMbsBTropW7D1BTZsI5LwAIXWGfig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ooC2oDbe;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BD0ED606A336;
	Mon, 26 Oct 2026 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD0ED606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ooC2oDbe
Received: from kero.packetmixer.de (p200300C5973CE5d80fc8dFE94a24022d.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id D8ACDFA1DC;
	Mon, 26 Oct 2026 09:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
	b=ooC2oDbezeShF9CVjJl65BGThd6LNfcLV7ZD4dz8waT6a8gcDALeO4vUfHt6oY/Cy22TDM
	H0ckEnyNv6UyjbIynkAPXPCqRJIOBRfRRYB5qYFqF7ZvkF5J/D9loU430hofRQFVl707gZ
	EE2uRPbFVsapo1twa9JWmA8N7FdHVOkYmEKrvke0pSKU1MYNym/4CnDXTbdfpEtsM/XYne
	mc8um22kPalvVevSkB5595gX6cyfbdgFv34s+QMXC79+5nKerFqcTqNpWiju9HXPjUsMGn
	Gz/cjaOI/s2AoY/yzIT9lRf1yllS9Q5V6BgzwPuBDe95rfoxQekB60WEBP+0cg==
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
Subject: [PATCH net 05/10] batman-adv: fix skb leak when hard_iface is being released
Date: Mon, 26 Oct 2026 09:53:04 +0100
Message-ID: <20261026085309.1074911-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_batman_skb_recv() owns the skb it is given. When the hard_iface
refcount already dropped to zero, the function jumped to err_out, which
only returned NET_RX_DROP and skipped the kfree_skb() under err_free.

To avoid a leak, free the skb before returning in this case.

Cc: stable@vger.kernel.org
Fixes: 4fe56e60ac1b ("batman-adv: Check hard_iface refcnt when receiving skb")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6c54a8d4be3ec..ced76942f33c5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -484,8 +484,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	 * shut down otherwise the packet may trigger de-reference errors
 	 * further down in the receive path.
 	 */
-	if (!kref_get_unless_zero(&hard_iface->refcount))
-		goto err_out;
+	if (!kref_get_unless_zero(&hard_iface->refcount)) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 
@@ -541,7 +543,6 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 err_put:
 	batadv_hardif_put(hard_iface);
-err_out:
 	return NET_RX_DROP;
 }
 
-- 
2.47.3

