Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976B3FC5CC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490331; cv=none; b=HKRx5dq7dQgupyZ4mLH/hWmQ25/Jj9Zpo4e0o8ORyBfNeJBumA5vU4rNCpe4z+p+vBVuNrFpbCgGJT3jgN1o4p3Ykl1PlCv+9AtC/g98Zgrn61yAR8FIadMpFc7fcsisUhSYMoj7VhCgHWToTK5uVilhHp0R9CZfbSyutdLBW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490331; c=relaxed/simple;
	bh=Z9PpMAp7p4gZSEkYMRh9LpCmsW6TXreqRU4HRvlOnVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lE5DJ1He3EH9uL6BMR9sXtafeRN28Kg8qKq/nyjK2BwB6S4XBImtWK7Kiym1EzKwPY3GFsL8Ei3ks7bdEUboAtQnSDKPkCYchNBRRSimJP2l3J87/m+Jb1PaTlQ7Lkf7gkBCHO2gVw2HqtsT3ld+oeXhxT+qizW9tRVqg/IFQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=cTE788AF; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="cTE788AF"
Received: by dvalin.narfation.org (Postfix) id CCC4B1FDCC;
	Fri, 26 Jun 2026 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQh8uRFTd9a0UsTx1h2eZ92KKMnqtOGH+E8NSWLmnyk=;
	b=cTE788AFVmnc5YbRlJ0k+J4hbZr7eljWq24VMjTVL/Z3VGrBYI2CjC6NQb75wMSkG5fUwB
	xzxrSlbIKXwtBO5vsj/Xxn0TeXnVDhUcmDUB3VtJMJInB9GNW5CW9+DnJrfzvfm8ENCXQU
	nZzmUqV1/jeu1twEDKt9B3HlD5lpdsI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 24/25] batman-adv: tvlv: enforce 2-byte alignment
Date: Fri, 26 Jun 2026 18:11:53 +0200
Message-ID: <20260626161154.124562-25-sven@narfation.org>
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

commit 32a6799255525d6ea4da0f7e9e0e521ad9560a46 upstream.

The fields of an aggregated OGM(v2) are accessed assuming (at least) 2-byte
alignment, so a following OGM must start at an even offset. As the header
length is even, an odd tvlv_len would misalign it and trigger unaligned
accesses on strict-alignment architectures.

Such a misaligned TVLV/OGM/OGMv2 is not created by a normal participant in
the mesh. Therefore, reject such malformed packets.

Cc: stable@kernel.org
Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 11 ++++++++++-
 net/batman-adv/bat_v_ogm.c  | 11 ++++++++++-
 net/batman-adv/routing.c    |  6 ++++++
 net/batman-adv/tvlv.c       |  6 ++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b37c9fb178ae5..5dd3e1f281bab 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -310,14 +310,23 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 			  const struct batadv_ogm_packet *ogm_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm_packet->tvlv_len);
+
+	/* the fields of an aggregated OGM are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGM must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 48a67705eba85..c5c4d33cb1983 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -853,14 +853,23 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 			 const struct batadv_ogm2_packet *ogm2_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm2_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm2_packet->tvlv_len);
+
+	/* the fields of an aggregated OGMv2 are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGMv2 must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6fd18b69e5f6b..f828d8143f752 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1373,6 +1373,12 @@ int batadv_recv_mcast_packet(struct sk_buff *skb,
 	if (tvlv_buff_len > skb->len - hdr_size)
 		goto free_skb;
 
+	/* the fields of an multicast payload are accessed assuming (at least)
+	 * 2-byte alignment, so a following packet must start at an even offset.
+	 */
+	if (tvlv_buff_len & 1)
+		goto free_skb;
+
 	ret = batadv_tvlv_containers_process(bat_priv, BATADV_MCAST, NULL, skb,
 					     tvlv_buff, tvlv_buff_len);
 	if (ret >= 0) {
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8d6b017c433cc..e1cd27b99bd11 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -464,6 +464,12 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (tvlv_value_cont_len > tvlv_value_len)
 			break;
 
+		/* the next tvlv header is accessed assuming (at least) 2-byte
+		 * alignment, so it must start at an even offset.
+		 */
+		if (tvlv_value_cont_len & 1)
+			break;
+
 		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);
-- 
2.47.3

