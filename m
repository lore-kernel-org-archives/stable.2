Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83578223DE7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554221; cv=none; b=EpJpfD88nSMsBFw3ogObuROlg8VOOqCBPDCFApxp/IH0rkMGi4o0vrAOb+enCce6ac/+x6tWy+Wek/MntEtS9cFK2+RGDNZWlSQhq45K1WOMMQ3lVsaO0tNXEzwPvjvp0TFsYh1lzvWO9Kms1q/RZfQl+R+YnS0bPRyA95/poEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554221; c=relaxed/simple;
	bh=OcLsxRIQNSqAt8rM3ensX8aG+Kes3lsxh3izH5AsZ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXEyNAqqwIrfPDNz1C1TYpCKnQL7aMHAoEAmS8chwzUx51VCHvwro582QFzK517g13tAmjg6v2SrGhn1XvDiRkOwpvvNDzRPqJmmNdUAknMY+a+kEEHthSMBCa3/gKmj+6f4kyTnzzKRzTtbyoR80w8jjOuQT4beUNHcPpEFWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=wiidfx+y; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="wiidfx+y"
Received: by dvalin.narfation.org (Postfix) id 786A320131;
	Mon, 20 Jul 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784554218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yPW+qb+d71lcSMUQAIZvIuGN/JxWEu4oCxpESbPHxQ=;
	b=wiidfx+yPIkRjuh6n2V3vQfOD2KddZuqx63SrzoOpphbl8i19G6i9Jg6m2HDZBzvGz3g8U
	mmT1uzX2ksXo2xgNDBGWT+JEwZBVN0PANHzCW3oEjV0zWgiUC/EPmASlD5XH4+/oLXK/0P
	7B6tWt5BIgcxtWpJTjRaeveIQOl1KPc=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.12.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 15:29:51 +0200
Message-ID: <20260720132951.334751-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072041-bruising-resort-e0fb@gregkh>
References: <2026072041-bruising-resort-e0fb@gregkh>
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
index f46064333f334..f64c3058ad191 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -206,6 +206,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 
-- 
2.47.3

