Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D23FCB33
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490344; cv=none; b=faU5V68m22Rf/3sP90VrULNKsP4sm+O6R+drCQYSr2wUWAIm28tjmkMPwxcP0fjMIBJP99qg3EKhZumH5ARtwf0FzEzxjH8m1/re6Do/yamOoFmR7dSeCc5drJVkpWOjysh24uZkz4KBy/G2iRjxVkCqMYfNrzKe0zJeFn7BYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490344; c=relaxed/simple;
	bh=J/zfiTW8sVR4SrjwOfRQHq2EMuVu0cnD+uHI5ZZrOAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRqDZdZtGd/LzvCvvaySVrrRl0nrdzH2ZYPvqDor0IVpNGkdbR8Lmi1gVs7yEo+twsnlpnDEjcwBRNq6wxgkEOrsR0lInYt0O89MvmAm3SF7hIQ5CG7/dt1kf2SOVZVQRO7kfuKjJJKC5BXe90XpWQNL7xad7gvJC1o8CLQZ9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Q83T5Agd; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Q83T5Agd"
Received: by dvalin.narfation.org (Postfix) id 23D70203F3;
	Fri, 26 Jun 2026 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGA0J1R1SZCvY6+4XWmkx72VWyQ3SDH293qNeEg8w0o=;
	b=Q83T5AgdYweurvell4/DSauna9PtLe7r6ACTuQKd208x27cTlNEkT7wiqnbzA6cX3blAYi
	fnDyKXKFC2oriWdjfCra8CZoGNrnkbyujDnM8iu46Ths1LmFKwJr4iyLRJxP0ckAbEGLEG
	aFM1R4xPXz2xsdM03kLX5d31c5Pldco=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 16/26] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:12:00 +0200
Message-ID: <20260626161210.124712-17-sven@narfation.org>
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
index ffa5d4b074095..4779741e7273e 100644
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

