Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E73F99E6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490378; cv=none; b=YPvzne1d5RM9McHebrA007wvbSzxRysun5pfqPZTZkzrLrXGeGrRaGI9HpaJ5LYZo/UxOJgsbx22QbiyFJYAb6YQsHWTqwuL86UUHgLaLLZdxcP2kjhw5iQYKhsHw5m0UfxsB8Nkf4Sw+w4OFoOEuicmtdxQvmufBnU1Yav87kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490378; c=relaxed/simple;
	bh=3TAtaMIfIC+XwJ8IQEmCaSkOxAIU2reng4KwXfjXypg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st5DTQ3dXyGwreQsW19QPbOev10Zus0nhOrXCGkA5NHmWjPutn8bikOezCUR1feeqNiegmESRSj5B/qo6f2WNHRUL7ODJcBi5Fjm1P9pnwxtOWXQJLTM1KMvw9DDhZz+DwYzy347UtnA0ZH12bnvPW4b0wt948QUx9MdCBP6y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=oSt3IUYN; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="oSt3IUYN"
Received: by dvalin.narfation.org (Postfix) id D348A1FDCC;
	Fri, 26 Jun 2026 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdMyqjAtBp3GLVsFmwJjNc5UoTOf+33gDOpORDVClKI=;
	b=oSt3IUYNR9bJpcbgD7TuU3Srtk7JiRq57wbWZlH9CZo0EWfd2fU1GOngzBzYSfEOW3gimF
	WUgY52SusqJnxhLUX7PSMLqnHACylqDEdnwp7f8knPGCTuGr6AyTqX2PMcyEcC9Wwl5tYj
	UKIYNJ1k1XuN/Ybe4Wc9EAalEbP+4LU=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 16/26] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:12:31 +0200
Message-ID: <20260626161241.124988-17-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 493d9d2528e1a09b090e4b37f0f553def7bd5ce9 upstream.

Packets with a TTL are using it to limit the amount of time this packet can
be forwarded. But for batadv_frag_packet, the TTL was always only reduced
but it was never evaluated. It could even underflow without any effect.

Check the TTL in batadv_frag_skb_fwd() before attempting to prepare it for
forwarding. This keeps it in sync with the not fragmented unicast packet.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 5c2a7629e4e09..9a5927ecc4746 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -415,6 +415,13 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (packet->ttl < 2) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
 		if (skb_cow(skb, ETH_HLEN) < 0) {
 			kfree_skb(skb);
 			*rx_result = NET_RX_DROP;
-- 
2.47.3

