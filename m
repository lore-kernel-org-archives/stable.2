Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F43425CF7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554510; cv=none; b=gwfwogYdnsaYPalFM5EGk8IEUFXo2jGZc7iowM9I0YDOyapaVdnwopy521/LauKZMyNaq3OyVyynYBd/B42ufDR9JwQG72vsINiZJ4eUS8/ZFFIpg2xbomLjzeyleIXXEGT0ylcNZ4sPZs373qt+EvFD4+/WcT/ws0yYlZ1Nnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554510; c=relaxed/simple;
	bh=tPXCwrDkyL1Y5Q8VloXmBt15Gu+wNHoI2tTB4MrjKi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftD9CIueEK6mJDE7+I1Afk2T9RMOKlwjNmPO2/Y6+Cla3bVIdawbv+eAhObyxfeDhIOKUCd8WdTL2OnyZQS2Tzzg2D+/XCv/l29WNzodXsNeCpunZF12mL8wa8hpiOxcxT75CUZhmN+Qnr+zmE5v7BI9vOI0cW6ZS+wqPmbKTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=mVRnj5U2; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="mVRnj5U2"
Received: by dvalin.narfation.org (Postfix) id 48899200A3;
	Mon, 20 Jul 2026 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784554492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oxUNmpnoZjbqTEx3/2OPQBsJF1m/JLkgAZtNwRm378=;
	b=mVRnj5U2/dxYmCvMa0YRQVPRTnCReUOlIPpQD6iyl2IjXVN0Nz6QqWOwswgydMQ8ZGRkd1
	zOuhKs8wY5iz54Gr9fGMMUtmhgdPEDwXiaNIjMcyN+jjoNTkZTrUAsoalAuzZ2OptJV2KJ
	x4CD2crvMYNZRTgt1cQxkmziqDxtLBg=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.15.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 15:34:30 +0200
Message-ID: <20260720133430.437468-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072042-pretext-impound-67fc@gregkh>
References: <2026072042-pretext-impound-67fc@gregkh>
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
index b46480ec7bd1d..3d868b728696a 100644
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

