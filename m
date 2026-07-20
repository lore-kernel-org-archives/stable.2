Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5035B639
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554358; cv=none; b=M0+6aFHFF/KG2qgDmGR9Noxx9PMoyAWyaLpruKZ+zplPZ+Q7gJWvKl4xFAlf91RIdkqWYwhpPMHny24C9xJ4Ivf1HVqhOT3+Qr73ApicJ8kn1dLmDmPKZR9PWrOjtCZFAw6oKAWVuBtv9+mSfKfwyKDMRtFEQcW84zV0jkCw7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554358; c=relaxed/simple;
	bh=z0qTz79XYGIlpHOxmThdq1g3KBiGuhjqVtXC0POl6wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dii221WJEFaVMDdoCyocutNv3yz4a56C73sI0ZCAtS9GeL/dYLoL8h8H1r/w4/mEyjegDMdoZSo0QA0sn9l87hOi7eHPQdSaaMDG/2pbEgOx88qnSiqbAfy/Zzqomh+YcA93Mso1t9P1SQHvKOe0ljbdT698aiXfqQCeFc2zrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XbO5Ei9r; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XbO5Ei9r"
Received: by dvalin.narfation.org (Postfix) id 634C020131;
	Mon, 20 Jul 2026 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784554355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQytIWJvjV018+mwX9wN604no5OmSp2X61jGg+/xN3c=;
	b=XbO5Ei9rVrtAdH8PTlmPVuCqhE6Om0eVrbdm3x8RIXcTpCB8q99r1AzOHC66hQOsYdNRBb
	wzxvOT03X/FPC2fqH1m0w5FyKAJPV/dK203Varu5YhQPMRbsvShU1La/YrbvXKGfox/uPz
	dhcONYKLbOlCBpRVQUF6bVMSzJ1Jhu4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.10.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 15:32:05 +0200
Message-ID: <20260720133205.385345-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072042-gumminess-snowman-dea3@gregkh>
References: <2026072042-gumminess-snowman-dea3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 49df66b7993c80b80c7eb9a84ba5b3410c8296a0 upstream.

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
[ move from mesh- to soft-interface.c ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c8c62b0cd54c7..0107fc814218b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -210,6 +210,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 
-- 
2.47.3

