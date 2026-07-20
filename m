Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B6240DFDE
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554007; cv=none; b=ajncRpjU+AgeYfXefMQojPryzzE5ER5p25vA+VYOKOWqAaA+2vA2bfxYkn6/jodj2tcsyKt8flQl9I5vlPh+kfmgnhIdx8UJL9LxmnSEbHh5yMVINZVU7uSNodkxvmqn/20SlngyssuqJ3y8mZw8ziSzBalB7d0KyXL6QI1Jv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554007; c=relaxed/simple;
	bh=2i83I+tv3I44N4CBccDXOP9MbDeco2bUu2MyW5cuhH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bThxR5S3wcUFCAfceKR/GO/PV/Z3n1lFEWOB9SwMkXbroh3kHusKa97SvnMLmcEgb3rDhSr8uosWO0VSgGAbq92/rsCv2tLhKYQZgGlWPV9XsH+G014osEZstSQp42mXIhAC9LQHnoCpnTgevgRNRKqGlhaRWwehcRvYci46e8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Vj3bHGAm; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Vj3bHGAm"
Received: by dvalin.narfation.org (Postfix) id 307B320131;
	Mon, 20 Jul 2026 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784554004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/IDIiOQTbCXvx9hSuPopv9P3EfpW+vlfucUkHWze78=;
	b=Vj3bHGAmzN8uufXIgEIanRjCjNRmPXlbyRafI1CjOpiC+q8PNOi1g2RCxEsRkTtnCGYLmN
	Sg1T3NSJo8cYb1iJr+VLx+M5B0UUWFJ7VtPmLPMhk0CBj7MdoRqFdEPVM6MJbYyJtvOzVf
	kDI+m0Du1bJcEA+RHxDjIrgTVaY98ZM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.15.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 15:26:40 +0200
Message-ID: <20260720132640.304181-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072057-food-spender-efd0@gregkh>
References: <2026072057-food-spender-efd0@gregkh>
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
index b46480ec7bd1d..21297af54e4ea 100644
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

