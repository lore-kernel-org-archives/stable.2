Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EF3F9F22
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490274; cv=none; b=iv7+2HjU1KkK2Qwo2J7IDTMD9s4Bp6YjqpUY8cgIZ8JxkoQtJnNRZbxLI6qGrt0m63KK9NeUCJ4B3shhutmjeqyxmorozdnbfRX1Hn7gIYZgdi3YSRGqHcBfkA3o6r8mvzsGRFGeEtZ8eBkxa/Mlbz52yFQMdrDKqfFXpwX3YKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490274; c=relaxed/simple;
	bh=2rRWR7tAcssBTDZnBnJdnfCNFYy5zvRCvuy1e3oj0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYo7E8xXWyIaCW0qaWX+fCgctUvCv9EH/a9hq0qVJKgYMPr9Ol9PVsNVfGfkeJbXHKS8mPCUrqwsXFpxx5VSvn51kMfywaC8LmoAM8yeRy+yhCpZ1eqLY3ESfc5ij/kandjWh+tC2gM/ycvRzpNFQTWFUHlE6KFutyzlKP3D4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=agw9prWL; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="agw9prWL"
Received: by dvalin.narfation.org (Postfix) id 4B6FE202D1;
	Fri, 26 Jun 2026 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbiA+M91X6bce8QWxIo9gl87QVsOyX6Frnbwww7jHpk=;
	b=agw9prWLnhoc+CcTrmz7lS8PZwrblxL3H1pT6b5fk1zZxH17FbU+i2Aj4QuuRNmwW8weCS
	PYn9Nyx9E1aAMDXAOhvyo0wt6SxURyMUU6pdwWYWIs51/tfCk0ShsjZkpKLKC0mIeB894Q
	Mr30hUQN2MLaeTmAjWTHfODzJaClWSY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 15/25] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:10:54 +0200
Message-ID: <20260626161105.124113-16-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
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

