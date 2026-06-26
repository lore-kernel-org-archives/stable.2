Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD723F9F2D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490215; cv=none; b=FIPoDZ+wSZ0Pd/4QaQQlv0UJM65dl195J+IN1WZixOL69ONJSuikGvNptsAR8+OM2pl89GEd0PFBzAEpik1x/7t583qkJJ+I2RM8jdAVCoQSvTdz2VJKCj7YqY2Pz5J/T8LzsG93hj60NiXDSKNNjxx5J4MZFZmGLg23cnS3w18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490215; c=relaxed/simple;
	bh=T6VL1ig2dvVt+gvQNoHT/vhOZiUeaFAJA9M8ZfEtOT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfGrk9ss/sjivsfHICY5Yecr2yWaeCYpa12Izr00w4/2ssAB8FGK5qDCOsJntP594Lo9G1Rw99aJDN1IWoK5zZqNp2To2OM7Raj1gefQq1SwZmzs/lXj0gxvc4rT0Ul/lypelc9zsr9sViKN6RDbUe2/igxVKxOZCSiNYKG1UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=dtudkvoP; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="dtudkvoP"
Received: by dvalin.narfation.org (Postfix) id EBE032056F;
	Fri, 26 Jun 2026 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvR0SLZ4i0EewDE1pwyW64ott3RzYcU8yW4FQQZB9Bs=;
	b=dtudkvoPczIHtiskXEqh2dXyFfbNZlnjkmldLw2omoxzUp6cSFql59UOUKa1OsgiVE51aM
	0SW+Ag148RNEWo2F3FPwxLZ3nwP/yPxU3DJtZyJSXVuEOCocbsafDbmDNENwWR/q7iPhpI
	Zf7PDs5MlYpObSYGOj9QBarUcUyrRsI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 13/23] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:09:42 +0200
Message-ID: <20260626160952.123713-14-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
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
index 95c88bbdbcbee..43dfe86f07a9b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -421,6 +421,13 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
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

