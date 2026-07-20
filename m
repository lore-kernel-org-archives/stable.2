Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406063AF676
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553882; cv=none; b=TWJuy+4bWioYJVFsp865aesV0mWGZBC2M7C2uwPDEcIxPEkKhMNq8k2MwD+n8z0m0GCkds9Fw6nEUmzOYN34XPoMjLO9UgGJKvzDFr9WHZmGdPtg9DgNOopBSJ6OTfZqSoNI2YKv9J5HcJ/qo7Rw/W+LDeW0ip8pcgtGHsqr/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553882; c=relaxed/simple;
	bh=Tp+srsD9usiDf/32Nng1NW/nKx7r8USnzbmRA/UlJ/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp0euqo+KToZ8Z0/ASVC85B3HpBvUT/RWmNqas7AFt47b0uDL2j46y7X4lYSyw//4lU1KvwN4EaLpF2C9ct/wcWyBTtxwX/v/sBWl+6tlOamWZG/VfKOsmeKRfPpJNlsr2Lr463jaOq0dFUQ+yAT7C74v+nAzEwsWVroSWf7yVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Wf4nk0iT; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Wf4nk0iT"
Received: by dvalin.narfation.org (Postfix) id EAC3220131;
	Mon, 20 Jul 2026 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784553879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZPUEPWFZXTOmR5DixPlIrpKPMKlzwvhPHPr7B7sKQs=;
	b=Wf4nk0iToDlF1IE1AOGPE+qKgiAkgfimR2DW3YXSALEKlNSVT6ymNG3DQQWq0kcUx7Eahe
	QsDqWrIwtNE2ILTasf1YD/NRly21XIDsxbQdNBtp/r+oCWkchKBamOitu7dz5XsW6Dde16
	gr/TX5gmdIlLa17g8bDY6m81lEovfJQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.10.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 15:24:35 +0200
Message-ID: <20260720132435.252242-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072057-equate-alfalfa-df1b@gregkh>
References: <2026072057-equate-alfalfa-df1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 035e1fed892d3d06002a73ff73668f618a514644 upstream.

pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the VLAN header but missed for the ethernet
header which is later used for the TT and AP isolation handling.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: c78296665c3d ("batman-adv: Check skb size before using encapsulated ETH+VLAN header")
[ move from mesh- to soft-interface.c ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c8c62b0cd54c7..8b4a8e80c0a32 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -454,6 +454,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
-- 
2.47.3

