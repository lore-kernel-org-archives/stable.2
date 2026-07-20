Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB94424679
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553518; cv=none; b=oWh23FM6rtWX8yW3ylqHnICVfLrNrvdu8dg4fZdBLP2ufDoKkep4XXrBW/0asQaSPKYd5hh/+5uhErlWA5/R8ITBg0zc8tI/C/8eJUcFZDZRfjLeaBWUlSVcPljkb5sHc5UsQSSH7uuzT9xAbXOM03Y9/Im1OR8Ksl51UAJXRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553518; c=relaxed/simple;
	bh=zi1vSpSelfqvzmhgUrnkjxYU7+DbnNI42mJHC6y64I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyWP4gIt+UKXPCrg+vdkuAVR1dSGCguDdF0/YbSzOdkMquXEgLDaBi59Ik+PZCJ3t1Eph/xhJ+J6C/5MFDIWQlzMWoMwhQD3PQqZThAOJoaDnCk26liYDJkxAnuoeRh4qWj97GkA2hveMkuWJ+/+oi3T17ZCACEpe/CkqKiQLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=cvirlZzT; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="cvirlZzT"
Received: by dvalin.narfation.org (Postfix) id 0B95A20267;
	Mon, 20 Jul 2026 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784553515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvI66/lC2GZhNFiloITox2aGPFiWZWYQeKYnZ/KKf9s=;
	b=cvirlZzTEnXMBe2k0dZyo0JdtidLudBNs3mgPcDbFqC3P11ejXUo4zyQO2LZKKyPJbNjHb
	qMCFfqgaN0udUMEYgzlee0LwlkVhpDFu/yPYgnIFtzmIgBTUg+6YQ80C8sOmbN2NJxwMsj
	qYMhph1CRy0ck5l8/fYubRs++NEYv2M=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.1.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 15:18:32 +0200
Message-ID: <20260720131832.142628-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072056-vitalize-nicotine-22d2@gregkh>
References: <2026072056-vitalize-nicotine-22d2@gregkh>
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
index c0549abcae7a6..40354da5c5b55 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -444,6 +444,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
-- 
2.47.3

