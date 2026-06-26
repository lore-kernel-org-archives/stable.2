Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB963F9F30
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490293; cv=none; b=eV5suqlwJpFHFC7ZAMGvCIIfcHx2DLUPxX6/YRQfMLyiPvm3fICO5FaTd94ZF6pQvCQdQ6GliO24jl/0wZPHh5HTAfmle8lgsNdyGOFW6NFcxLtGrX28y5toliUbAIurjyfHAp1iRs2viWfcsyvyySRbTq8WCBgo73ACwLPqzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490293; c=relaxed/simple;
	bh=2rRWR7tAcssBTDZnBnJdnfCNFYy5zvRCvuy1e3oj0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imfeEiaphhHn9vvKCFHa3Gl/ILJKiNM7iOkEMtXmIxZ8ZqYMI6rP4ZfpLzprhiqYxHVKhLrzLBi0Y8yczHObPckxaMDauejx5cosDjrtbQzxA3ipO6g1NXTFrYKR7/uY34E10bDMVpp5QUfzmYtPvng/P1ZfCDEX37kolWc6E14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=hblxt7XR; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="hblxt7XR"
Received: by dvalin.narfation.org (Postfix) id 2F8A3202D1;
	Fri, 26 Jun 2026 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbiA+M91X6bce8QWxIo9gl87QVsOyX6Frnbwww7jHpk=;
	b=hblxt7XRMiUpPwq43XZialJXHsRm9PnV+trfq6UiJEs5HpYuupF07DHxiLeYbA9JZb3az4
	lZLH3iJlGjGUsGnkRWZEv+LDgoY+V812cwIgWG3dxm+UCt9roWqhg/qAAHIr4UTARaWQEk
	HPfOnV44VRbNpksV2UJrD8C/w8tmtYc=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 15/25] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:11:13 +0200
Message-ID: <20260626161123.124273-16-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
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
index fbf030c57ac04..0138b0953e10b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -420,6 +420,13 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
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

