Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30994330D2A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553673; cv=none; b=UlXgqka4G/DoHUgW2Ia3TqQD/si5V+V+XTUOdL6yI5UFa0eaaR9PHVYGYCkBB9ORAtncF812EySPperS0Zu2xvWtWl3kOKZDlzWPCYYCRSF9ZH2kfTuLPSYTikegW07yK8LltrAARogZp/da3nVOIHHSXNOA7T+3zYp9VmAP6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553673; c=relaxed/simple;
	bh=xm+wpfShNKuecMaYN7AjwqZ/XzgN7iH8zKy6cQ99cbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq7y/8uj1wbHf/VBjPoGIEZm6EKmNUBNfdS52XWvi/L6j4Ix22lZxLt5cW3Lciy/oA3nUFFqegnHZjA6AyAjQ3AMMC00bR04FhId/QjW8U+Of0pWUgqmaKV6rY4qyfK1WQpOogDVWA1YXbnNStfZ2+f/ioZsiZXrUQNgjeA680s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=eMQPV+cT; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="eMQPV+cT"
Received: by dvalin.narfation.org (Postfix) id 19AF61FEC5;
	Mon, 20 Jul 2026 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784553670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZW3xAvJ+UEliLHzLg+KcYd04D6HDP4QJ7o6BzfMyyk=;
	b=eMQPV+cTm5QQxLYoDphUpH+w3Guuc85Dsj8R0Miz9RcF84JLf1fqG04d44jeOnvKMIavwH
	OO1n802t8KicxGUVe3REUo8J/vGfu5JBvTTPFplt3yLNI14AN3fuxMYZsI/bdnppIoq5Dm
	H1DH+Q/fi8sichuRFPEBYvHtgxUdi30=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.6.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 15:20:56 +0200
Message-ID: <20260720132056.176231-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072056-squatting-boss-26a5@gregkh>
References: <2026072056-squatting-boss-26a5@gregkh>
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
index 680f729b3b022..e4d302c93478b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -442,6 +442,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
-- 
2.47.3

