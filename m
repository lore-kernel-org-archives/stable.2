Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F73E3C4F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554788; cv=none; b=YpGz3IuspcmCZep9WwmeGpNJ7q+FjLSbP0VmTO7UrgJAoh+5u455DyBsy5ItLtZ0027Rhd2/vjOqAcSao16pPK/5TjiR6OgfN+vuytGmFeNbzji04bpQGKcBJeuSQVdhSy4RhyLLOUU6G+USARdm4iG1F39CbSYyWrDNJ/gCvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554788; c=relaxed/simple;
	bh=HIUHuaJQ9s/zQcipPk7AlMc9LLkmByA5qLsAYitv9SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN6PP1Ywe7PM0zXSIWBQ5Omp7DYXYFx4SFOlnWBEzrJQux/lQXo/64RARRuEtjCSj2+up+/4Udf5ZQ6sD91AQE1l2O4VerJd1cGaaJcgz4eEZcVs77hQwAqjCrzJ+F9qBk8H3oFi6/jHR0EhsCF+XrzhNp3lVfKLZE9jY1k0nyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=0fcactUP; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="0fcactUP"
Received: by dvalin.narfation.org (Postfix) id 5FD8620267;
	Mon, 20 Jul 2026 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784554785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZNdoC8rATx+Q9CrR8Vuna4N/z9kAKTvtirt/0/4V0Q=;
	b=0fcactUPQKJQJtAgdfAtCWOK+5hhyFtito/imbp9gVLOz8sXCVv7YI/pvWwEC6olTjMHZC
	+tjBSTknFKfAlKi7ODJkU6cgglslTu8Ue07herWodY/rg/AKalYw9ri8b7ugRcR8MIpbcz
	TaDz2dWmGr8Vxd/J1r/UD7mBcx9f/GE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.6.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 15:39:41 +0200
Message-ID: <20260720133941.538930-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072041-sharper-bunt-8d04@gregkh>
References: <2026072041-sharper-bunt-8d04@gregkh>
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
index 680f729b3b022..f94bdfee62c35 100644
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

