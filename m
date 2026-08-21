Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F16305E28;
	Fri, 21 Aug 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306309; cv=none; b=qv69x2JQBEvltgSbarGLuqOD9e5v3APAhEe6KeI5xE/6KOwRqHhLDPr5fK7FsBdrZ5c4che5+uGyQS5eLSXmFrrgbzw38AfQz4A90WY1x6DlYi5QAWtKNA5WTBePsTrmMkW8lHHksc/G3OB9fL9nxGeLH+bJD6+G3cwkxDVCFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306309; c=relaxed/simple;
	bh=UQhvd2SvO+L9dVjlv+/TeOMBQVspK+SsPwuuSIQGccg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzejYy7sK7bu8yMZ8NIoqJMmWz1we4Ho4p+E+gbxFqghKJqc+w3LmWnTBDF4YkdsT/ctxEr3qc0w1Hf9q7M6MEtciZ3Zd01l12q63SXwupOzk7Lg63+Ft0DqegTA9HoXhlSQ1rX3rg2IoywfI0akvZNLs2/qI3vUb4vTpxbcj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=d0WnhjeH; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="d0WnhjeH"
Received: from kero.packetmixer.de (p200300c59714FcD8EC8C87C354003fed.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 70560FA039;
	Fri, 21 Aug 2026 11:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXRPXTDY0Mj1vFXOcaR5PTLxstn0I5G0reky+aH7w0g=;
	b=d0WnhjeH1NJ4oLO7BjUnP7l5NvO7wofNl28sBxOM6jQHveRLbWGuGHC/XHUHDiCkiGWg0X
	9hfCuLCKPB+Y+/Ndh8VTzHkNg9a1xnDEDtPVkNrdFuaq1qB6ST46aTVy6aqv/t2YO+oEY6
	Xqlj7E/Y+K0ez8SNEllhAtBtUvR+HGnmMpm3b8FE+Iv8j5rr/JUT+cOW2OwvDDlC5KtUsw
	bf5y0wka3DSQsiL8DbIMIR3Un621NO3/0flsvVTN6WOj9gVa5ZxN5MNpQTPAkVEK764Av2
	j/PdEaNMSOl5nb9v3eIizeevBwtAyDsAeKyJLr6ccvzVHHMJgEa00ThPTxiNXg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Zhiling Zou <zhilinz@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/9] batman-adv: fix stale receive device on merged fragments
Date: Fri, 21 Aug 2026 11:48:05 +0200
Message-ID: <20260821094813.201800-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Fragment reassembly reuses the skb from the highest-numbered buffered
fragment as the merged packet. When that fragment was received on a hard
interface which is deleted before the chain completes, the merged skb can
re-enter the receive path with a stale skb->dev and skb_iif.

batadv_batman_skb_recv() passes such merged packets through the normal
receive handlers again. DAT and bridge loop avoidance both derive the ARP
header length from skb->dev, so they can dereference the freed net_device
before the packet reaches the local mesh interface.

Refresh the receive device metadata from the current receive device before
running the packet handlers. This keeps internally reinjected merged
fragments consistent with the normal receive path after hard interface
teardown.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 77597171d6376..d89d44706269b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -492,6 +492,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto err_put;
 
+	/* Merged fragments re-enter here with reused skb metadata. */
+	skb->dev = dev;
+	skb->skb_iif = dev->ifindex;
+
 	/* packet should hold at least type and version */
 	if (unlikely(!pskb_may_pull(skb, 2)))
 		goto err_free;
-- 
2.47.3

