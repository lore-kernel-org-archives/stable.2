Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61383FE36A
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490325; cv=none; b=ncA4Lr+rhaYbcvsTZyvaxOPIiZYTIbak83CHzcng3X5aTmHoXshewMTHA2X1bfMvyE4THPEo2l89R8WftKUbIB4fq9EEs/+pVLxYu5LPRuZrFKt4ciJtaRoQpCEvs8XhcK97k8i3G71vVyqWllKqT29A1+WOtPgvoUWVjoECZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490325; c=relaxed/simple;
	bh=YbSVLK32kaP+lw7unDlfq8N3LautDeR2aq+wjkDWmSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1Gz9eBaXPp/WIbmRBdLM3vrCRJYf0EXTKUIbr8zWhijawXcOMCQJoGyvO2jCFlhSx1h7Gks/OExKqBT04XvCHweH1PgSTjGH5Ksaj/KbIgJNGeoB2ZxVFYchRm+8YMJ6GDsQn36iupxKT7h+lOIUTy1EOzbeQ9iFN52VBvJ6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=NJtHRSNi; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="NJtHRSNi"
Received: by dvalin.narfation.org (Postfix) id 0E2192045E;
	Fri, 26 Jun 2026 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2QYfLo7ilMWYAwykgkPMtqfaBCT7RLYlEYdYxQj1Gw=;
	b=NJtHRSNiL/+1He2Tm9zrpH2WPdbQcDdVOlAhQYXj21r37BHAxUN/JAg/IEE94OgDUimBFf
	yccgvh5fSUz9COzYGML4w2/DEIjeOitsnmFg7EgHYeBZT8FODZD7AM7xOoeXlxqYogQMkd
	A+6iNClQHvCgmBl+DWhaTzwnDSwUyzE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 15/25] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:11:44 +0200
Message-ID: <20260626161154.124562-16-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161154.124562-1-sven@narfation.org>
References: <20260626161154.124562-1-sven@narfation.org>
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
index f6714405b0f94..375c949912134 100644
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

