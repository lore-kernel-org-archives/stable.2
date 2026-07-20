Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64353425CC0
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554645; cv=none; b=WX8C5tCNXdO98iwAJat7K9/WwJY2bB1hLmNs94rZD45K8PiorBSFiDQNhMHFhlg2kauDvXRxIfPwyrTSEHigMSGGzYY9z/xJHh7i6YXLRLpcgeCRME2OSRvwlD4023lCeLGeCluq/mUMLwZY8c8WhIbGFLWMkaPqqW6L/EknZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554645; c=relaxed/simple;
	bh=db4nn34NFWJsHGMrMqK0g1LDGkYi1dGoDB3UUz7IBRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE0mD97UGjP9TnyidhWFsYzHP7TWYIVBlpjshp24a1GULByBMAIj0/QvM1o6xTI6PnqwbossLVmk8DMhglwi/+7YHSY9KRzz+tM+TUcjSk9yEG9K0RJz7lHQkGMpie7zD/wx7aLrc4x7xYICIfiAt3HQnCJMh3ZamtVtn0n/tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=qazRM5o9; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="qazRM5o9"
Received: by dvalin.narfation.org (Postfix) id 63FCD200A3;
	Mon, 20 Jul 2026 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784554642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VhscQ+K02mA6kiwyg6FGqQuYm0YChmjaAVap/58TS4=;
	b=qazRM5o91IXWzpL4U4n1AKL90P0o0z2L99kBCjZYH+7HNs+/phj+Eb/2IZ1DwJ785Nd5TG
	0LkyaFu+3Pay55rMqm3T/jP8ra/t7n9H7VLFqq7eD6nVPDOfw0i9m2t0zhuHf2KqVEmo/S
	pOwNsCTViPZhWB3AdVkYqZMPKAjhoRg=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.1.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 15:36:57 +0200
Message-ID: <20260720133657.505141-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072042-hydration-bonus-479e@gregkh>
References: <2026072042-hydration-bonus-479e@gregkh>
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
index c0549abcae7a6..c79487104c24a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -208,6 +208,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 
-- 
2.47.3

