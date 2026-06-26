Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624B3FBB7D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490380; cv=none; b=SIMnwfeNgTWzr3wuXD+JgTsSTa1xrK/zkxty9jBKwDLDFdhf3+qnYhKJUHYDCCZs/UIdJP6YhczY5ElO1xuuBFWnno/0asIGDYLeive/18ddWfE16fiIh57Kh1DTXrPLF+F5wGRbEraBH9ZWL2//Tjs7KkAzIKskj+rF7Ll9EPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490380; c=relaxed/simple;
	bh=oMG4eDhzXWEd7B4cXmufAFHcRl+LoOCapbJUaLu+utw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBzc9727TD3A8o/tTIvZnPe5LBBfp4jmmfhBFQFZjhf9yogOmQkJ0350hPYXOyqZZqaG/9IEGAw6wMkaVS9YBXwEQdsNNn0UeJx3pRmX0aIbcGcW4lDp/kbRw/DYE/zPYR7cXTbAu3EfumGAr+nOkkHrVhSZ2UR0Isxr8dQfxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=v2COd9Dj; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="v2COd9Dj"
Received: by dvalin.narfation.org (Postfix) id 1001F2053A;
	Fri, 26 Jun 2026 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZk1/oLbQ+Rb6iXhbBqGGPsmRYAyP6GGBYD7MjVKDkE=;
	b=v2COd9DjmEs7ZvYtwAKTid0T2rHx12JFTkmgfWIvyeL+Teo2+BCfxa0m2AHz7KzShe/WUO
	vgC4taCI1zpWIUk4ETLBuQnHRqrw3LFYrR0E2DxRw7D1wx3ZuhOG/NBDt7HzZEykLh4DXO
	31SW7OXoQfC7sWs5hxjlw53w5y+RcU4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 25/26] batman-adv: tvlv: enforce 2-byte alignment
Date: Fri, 26 Jun 2026 18:12:40 +0200
Message-ID: <20260626161241.124988-26-sven@narfation.org>
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
index b8b1b997960a9..6e79f69c2fede 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -311,14 +311,23 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
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
index 6852bf5da8c55..1f9b2d2b4831c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -849,14 +849,23 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
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
index 4483f8d9c7583..41951c7a1c50b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1366,6 +1366,12 @@ int batadv_recv_mcast_packet(struct sk_buff *skb,
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
index cc6ac580c6208..baadf97f98e5f 100644
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

