Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF93655CF;
	Tue, 30 Jun 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827414; cv=none; b=nS6kJyiaAyCVV0uHTWGm/kv7tnGat9R6oVm2rugp5v+aMK2Jkb4PWKvG5I4SxfYKrRhhD/wwkZDT7G8215L4EVTmVseAMgFyE975/IBNnjQNGT+LSkHrOHyMRjcihFpEtdVCAosCY8DywhTZG2UFHD9fUck/VMAENW0yT3e/LO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827414; c=relaxed/simple;
	bh=dEfcVMqAagf5Z/KbO/YMEcTRUts5sKjg9t3G2nt5OUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHIpmmf7vqhvcp8qXrrILUeqT7xHuB8gYuvQMOxfX8k94AJQjOObK3hvYy6Kqlz0nZDTfRMLvnKIEQGudzynOp0P9WQhmcqHbpPC2Y2ZqzoH4mJ5pBn2MzMRfQv6EHU30hPZ4Zcqp29VcSb2SRtBZvs6njPzdFtUPYuLLjG7S+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=InxosmK1; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="InxosmK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBuHPZ3Gw+mxEmOkIIjrkJNU1dKRnB7h3kisH349Hag=;
	b=InxosmK1H4dBLqnjRvXv8/9FIZjpGJzRKYs6i7DJrTtsB0sA9lDmbj6mQVVUb1ruxDE9SN
	I/ETKihQZlImJOidz2lWiDk/tBdPM076Jzg6dxEerRixHCo2BAUoVM5IzhT/ig8VCVL7br
	v+hRDptzhwlKxAQvOmJkt8ybClTmNbgVGx8hUiyj1jr0kLczS76lNsUxhE7bITB4zrN3Sq
	iudM3agVD3ZQ1AhCweabAxgLuJScwlPCFv+m96ypwxk+VEF5Kt8lr20/dDZjs2SsU22sAq
	rz47rE7gIxGqoIFQxOCd18hUgpHpOFp3X5Z3ci3tYPuPoSl3qs0Yhoa04IXpkA==
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
Subject: [PATCH net 3/6] batman-adv: gw: acquire ethernet header only after skb realloc
Date: Tue, 30 Jun 2026 15:44:27 +0200
Message-ID: <20260630134430.85786-4-sw@simonwunderlich.de>
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

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

Cc: stable@vger.kernel.org
Fixes: 6c413b1c22a2 ("batman-adv: send every DHCP packet as bat-unicast")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/gateway_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 305488a74a256..a5ac82eabd250 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -684,12 +684,13 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_gw_node *gw_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
 	struct batadv_neigh_ifinfo *curr_ifinfo, *old_ifinfo;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct ethhdr *ethhdr;
 	bool out_of_range = false;
 	u8 curr_tq_avg;
 	unsigned short vid;
 
 	vid = batadv_get_vid(skb, 0);
+	ethhdr = (struct ethhdr *)skb->data;
 
 	if (is_multicast_ether_addr(ethhdr->h_dest))
 		goto out;
-- 
2.47.3

