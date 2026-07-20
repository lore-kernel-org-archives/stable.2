Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87113C9C4
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553876; cv=none; b=ejpLHHq696QeQnH1AdKjNF/38Gv7A0vyv5LNV6N3uBvuTbbYZeON1I2Hh8t2jg7UBHIKpdZkvTmsAPGiK7VZiptyWX0Mdx5ifvhjPNHUpPqodqJ6VFy5JGapY2cXYigBdPrXYpowcGOuQEqrc1AKhChzCwXKfn12Pc8UAxveDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553876; c=relaxed/simple;
	bh=CZuYABGsuQ8VBoeAiYvoARTJhStvAhLQKp1RRVSl9/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+YgTApZwCDT1p1xFQpNX1UhOQLFCdyBNW72XGXeQ6kpxWVyxkl1CcGVRqvf9TDGk/E8niTaSi0qzHOHnAWgQdCn1AGEdIlbwN7cPxdye2UAJ6CDPIG40b1rraSk2i32vvZQDkjSw4QiCX6x0GcwcSUvBGLXdKzeB4QpHBEBjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BSG8/cbo; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BSG8/cbo"
Received: by dvalin.narfation.org (Postfix) id 5588F20131;
	Mon, 20 Jul 2026 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784553313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2N8TXLzu/ihME80BnKBVIF2qulIvDezW+rIWoL1FeQ=;
	b=BSG8/cboPyIoOgn2Pglidi3fzToH0+OcaknfrJSgIM7ehe8SEqv8jF14glt+iCjQPhlh+L
	n3p33KVACWRrH74xBr/zgF5dW406tZ5trLEGoO8a7yArQ1+OGYb11HDMHKJZlRYdn+SxUN
	yYiylp+K9mU44x3GaFWvLGUeAs3ytLY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.12.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 15:14:59 +0200
Message-ID: <20260720131459.69396-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072056-gothic-untreated-85a2@gregkh>
References: <2026072056-gothic-untreated-85a2@gregkh>
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
index f46064333f334..42ad04d356904 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -445,6 +445,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
-- 
2.47.3

