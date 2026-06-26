Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCA3FB06E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490359; cv=none; b=Yl6haYp95C5gnF8/V8fldq01pzHnvG3750NWEI36WU4EdvKYQgI2HSPaFf1XipZF4XhCFdnrsGEFOzH8kAkn26bj9tX+E1iifnlDRmb+tE0kpWOTZyesLFJZnqVpc5oDcOM5m21pIYPEuyrsveDME3bMBY3zFe0+siUqIRx+Vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490359; c=relaxed/simple;
	bh=RRDqPVhOh/jqdvKNH4WvIljG/GX3n6eN0UVkX31YW8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz5wU/9f+9mzLxJ2OAkCWdtu/JjrV7z4CwEivP87lvsVkOI8ieBruHYI4rvqpmGSUjfma9r11MmVxaSpHhkugn6jIsladYno4eU8uM7id99iabPgyawL2pxnOHij40oUIOQIrEHBYoYk9zgS0VceIJkM9LpOZuqkFgcApw+ql4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=WcGDqgzm; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="WcGDqgzm"
Received: by dvalin.narfation.org (Postfix) id 55B2920541;
	Fri, 26 Jun 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdAMBgvWWkEd/4PXruvyYiBJzDXPSujvV+UvFAMTW0E=;
	b=WcGDqgzmRhVzbrglEupDukE1u46LkvIpricm4apZFQkXZpl+FxXBD830C7A6hLdiDbMPRM
	sQlvQUyBl1qmrstlo9vf7af+g0Dk6w3CzSQbRvIi0emxZGl3gFgf8ZRTo4xjDbsgccnoKJ
	4LV5ewZDIYOzlrkSWfLP6fcMs2T9NoM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 16/26] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:12:15 +0200
Message-ID: <20260626161225.124839-17-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161225.124839-1-sven@narfation.org>
References: <20260626161225.124839-1-sven@narfation.org>
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
index e4e1f9e04aaac..c50a1440bb0d3 100644
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

