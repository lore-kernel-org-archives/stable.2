Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2763FCB1C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490314; cv=none; b=bddUS1MpcCTdMJMs8gWmHx56ji5FzLlO+p4a25+TvDXlucefIsOB202E79yrzFo0/wST66i3dl95webOy1bF05JDOzIwLzt1xaYfNkWi2+y1uNoJkU9SB0vIB/MMuV3JMC664AfQ61xZl76tTQ+TkTLiLrAFJicxZvtIzLCotec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490314; c=relaxed/simple;
	bh=EiqWd5bfW5ATf012mn6G1c4E+pq3KJE9EyJiNdo07SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFCkBJbVfpjyiWFl91KNyflLxXLhByc1u6FEu/BahMVmyHrY2a28rsyM9qmmtb3LjiAWwB1OMz52MjDPoF+HTSZz9WpFY+6Q7JeAXbMXHGow4oHvqTDJhODzlD2wKD/4YT+FwFmERuvnArySuzb5rghY5j5dABeFnaaYzfhO8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Lz5GKSpR; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Lz5GKSpR"
Received: by dvalin.narfation.org (Postfix) id 48445203F3;
	Fri, 26 Jun 2026 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shMdeFjb7zn9amOSjSBuKr+mpaRkm4NQasZ2ULs2OcU=;
	b=Lz5GKSpRe1Fo8KTEm+9L7f/HNNiab811k3ujKqPihNu7LC5tMW9nbvB8pDYWwbSrXpMuiu
	3EzAlUb1QgAWgX9jtvKxpotHABzTD/cxtsgxJ5u+I85szC+D3GBw0t0S2nxBe/Dc5cd5gR
	bySZaAgrjsJjF6tSNnzW0rOzuJURbkY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 25/25] batman-adv: tvlv: avoid race of cifsnotfound handler state
Date: Fri, 26 Jun 2026 18:11:39 +0200
Message-ID: <20260626161139.124425-26-sven@narfation.org>
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

commit edb557b2ba38fea2c5eb710cf366c797e187218c upstream.

TVLV handlers can have the flag BATADV_TVLV_HANDLER_OGM_CIFNOTFND set to
signal that the OGM handler should be called (with NULL for data) when the
specific TVLV container was not found in the OGM. This is used by:

* DAT
* GW
* Multicast (OGM + Tracker)

The state whether the handler was executed was stored in the struct
batadv_tvlv_handler. But the TVLV processing is started without any lock.
Multiple parallel contexts processing TVLVs would therefore overwrite each
others BATADV_TVLV_HANDLER_OGM_CALLED flag in the shared
batadv_tvlv_handler.

Drop the shared BATADV_TVLV_HANDLER_OGM_CALLED flag and instead determine,
per TVLV buffer, whether a matching container was present by scanning the
packet's buffer.

Cc: stable@kernel.org
Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tvlv.c  | 63 ++++++++++++++++++++++++++++++++++++++----
 net/batman-adv/types.h |  7 -----
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index e1cd27b99bd11..cc66e231ccb8a 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -398,7 +398,6 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 		tvlv_handler->ogm_handler(bat_priv, orig_node,
 					  BATADV_NO_FLAGS,
 					  tvlv_value, tvlv_value_len);
-		tvlv_handler->flags |= BATADV_TVLV_HANDLER_OGM_CALLED;
 		break;
 	case BATADV_UNICAST_TVLV:
 		if (!skb)
@@ -430,6 +429,48 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 	return NET_RX_SUCCESS;
 }
 
+/**
+ * batadv_tvlv_containers_contain() - check if a tvlv buffer holds a container
+ * @tvlv_value: tvlv content
+ * @tvlv_value_len: tvlv content length
+ * @type: tvlv container type to look for
+ * @version: tvlv container version to look for
+ *
+ * Return: true if a container of the given type and version is present in the
+ * tvlv buffer, false otherwise.
+ */
+static bool batadv_tvlv_containers_contain(void *tvlv_value,
+					   u16 tvlv_value_len, u8 type,
+					   u8 version)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	u16 tvlv_value_cont_len;
+
+	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
+		tvlv_hdr = tvlv_value;
+		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+		tvlv_value = tvlv_hdr + 1;
+		tvlv_value_len -= sizeof(*tvlv_hdr);
+
+		if (tvlv_value_cont_len > tvlv_value_len)
+			break;
+
+		/* the next tvlv header is accessed assuming (at least) 2-byte
+		 * alignment, so it must start at an even offset.
+		 */
+		if (tvlv_value_cont_len & 1)
+			break;
+
+		if (tvlv_hdr->type == type && tvlv_hdr->version == version)
+			return true;
+
+		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
+		tvlv_value_len -= tvlv_value_cont_len;
+	}
+
+	return false;
+}
+
 /**
  * batadv_tvlv_containers_process() - parse the given tvlv buffer to call the
  *  appropriate handlers
@@ -449,7 +490,9 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb, void *tvlv_value,
 				   u16 tvlv_value_len)
 {
+	u16 tvlv_value_start_len = tvlv_value_len;
 	struct batadv_tvlv_handler *tvlv_handler;
+	void *tvlv_value_start = tvlv_value;
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	u16 tvlv_value_cont_len;
 	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
@@ -493,12 +536,20 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (!tvlv_handler->ogm_handler)
 			continue;
 
-		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
-		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CALLED))
-			tvlv_handler->ogm_handler(bat_priv, orig_node,
-						  cifnotfound, NULL, 0);
+		if (!(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND))
+			continue;
 
-		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_OGM_CALLED;
+		/* if the corresponding container was present then the handler
+		 * was already called from the loop above
+		 */
+		if (batadv_tvlv_containers_contain(tvlv_value_start,
+						   tvlv_value_start_len,
+						   tvlv_handler->type,
+						   tvlv_handler->version))
+			continue;
+
+		tvlv_handler->ogm_handler(bat_priv, orig_node,
+					  cifnotfound, NULL, 0);
 	}
 	rcu_read_unlock();
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0368cb93865f3..4856cc98fc3c5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2413,13 +2413,6 @@ enum batadv_tvlv_handler_flags {
 	 *  will call this handler even if its type was not found (with no data)
 	 */
 	BATADV_TVLV_HANDLER_OGM_CIFNOTFND = BIT(1),
-
-	/**
-	 * @BATADV_TVLV_HANDLER_OGM_CALLED: interval tvlv handling flag - the
-	 *  API marks a handler as being called, so it won't be called if the
-	 *  BATADV_TVLV_HANDLER_OGM_CIFNOTFND flag was set
-	 */
-	BATADV_TVLV_HANDLER_OGM_CALLED = BIT(2),
 };
 
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
2.47.3

