Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB693FADFD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490309; cv=none; b=uF+AWnhRyoOay4qJ9lTpryUxCdT8hw75gPjAhDd6TxGmHVfWgI4B/7VO+Vb/Py6aYRjPQqqrw9uRBevojS1zz6AV4LxUiSFIm+JHgfbCDgWM68KOYkIG6tpLx2qjC3FI8/CtzGlZ69tAdamOg1luuyq2KnQWkoKoux/RRpKzAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490309; c=relaxed/simple;
	bh=2rRWR7tAcssBTDZnBnJdnfCNFYy5zvRCvuy1e3oj0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u26PceX7S3TVm5itqIqHA88oMpSoH3LCvFOgGJBd1njm7Jj6opsPi24Ix/ZOVGWoiGYcMQnVgH7YOsdHHfrK9f1/sCe5qfCu9a5a8r8HITUen3ygtYFjaQ3Tb3d/jgk47akj7ZFQ1NKTpIE65audgGAmjF454MDmQQD+rMmrLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=tMoj84ZL; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="tMoj84ZL"
Received: by dvalin.narfation.org (Postfix) id 80A17203D3;
	Fri, 26 Jun 2026 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbiA+M91X6bce8QWxIo9gl87QVsOyX6Frnbwww7jHpk=;
	b=tMoj84ZLOlHSx2K5JwR2dgkdpUD1aFH51jSi4roja9r504a1FxIoRbqK1WkpTs8dtE6tkl
	CEohIp+HCM2n5mzVyF4Hstrb8B0Y8Npal4jpKHu0LpnCvSge5BIJ3ry5HG1SEhK2Xw3XXO
	0nDLNd7bsR3WCi49xiO4j4UHrE0zMrs=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 15/25] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:11:29 +0200
Message-ID: <20260626161139.124425-16-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
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

