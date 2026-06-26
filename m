Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E5373BE7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490341; cv=none; b=WGWu6e3AK94xBb5q/W9uaCCOS6jsaMbv/l9F2o7quqS+0AOp1rGKrSxpuPTgdWC4aU3nPIDHS3Rausrhs8nc9gTykEzs8RaGxa8My2Rk7hijvneA+Tbk1C0IceVJZZVvLAQq8piUMgXn5+AmcjPfVhIKGqrt+RnYgWfuA+hvENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490341; c=relaxed/simple;
	bh=cAJV/pv5WbGl9Ya6bBRmWXHItIVz5tOSgVN3JINPPwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB8+KdoNgD3rbHybRS7eJpp03pf6JB1S1KVzChSWkyApI7CXHlsTt33BRrTmnWcgA3l6v4XijGdgFndRhXo8BvtNJJneYzG99rZI5A6/Sm7BpdTlxYPa4FuyGqJdwgZWwSo9lElbhmzd6liy2PjrpZixP45aW+jP7lmbq1HjKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=LWvKp6sb; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="LWvKp6sb"
Received: by dvalin.narfation.org (Postfix) id C701020551;
	Fri, 26 Jun 2026 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3FEbOUsPEkIJKZQUX/pEp+qB00r6YhN5vjmsgo36JM=;
	b=LWvKp6sbS9KGjp7mwNfE2x4UifJL6CAs34C9HHz4REtQzhlQrxZoRTPr+AcWBQMH2wkR1O
	miHF5eTBaKsX/bLzaRkjCagoonw/r++5+tufyAR5DPCSu28fKNNF0t08lzIb0Lmzqlmh2u
	nawuGrDdxy4QvQz3CnAxQ4Jvy099qBA=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 13/26] batman-adv: ensure bcast is writable before modifying TTL
Date: Fri, 26 Jun 2026 18:11:57 +0200
Message-ID: <20260626161210.124712-14-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4cd6d3a4b96a8576f1fed8f9f9f17c2dc2978e0c upstream.

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or used skb_cow() to ensure that the data part is not
shared.

The old implementation used a shared queue and created copies before
attempting to write to it. But with the new implementation, the broadcast
packet is already modified when it gets received. Potentially writing to
shared buffers in this process.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to rebroadcast the
packet.

Cc: stable@kernel.org
Fixes: 3f69339068f9 ("batman-adv: bcast: queue per interface, if needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 12c16f81cc51d..0672dc30bed3b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1191,6 +1191,12 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_is_my_mac(bat_priv, bcast_packet->orig))
 		goto free_skb;
 
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	if (bcast_packet->ttl-- < 2)
 		goto free_skb;
 
-- 
2.47.3

