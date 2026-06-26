Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA63FADE5
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490328; cv=none; b=NpSEA5wWuO7iNYTgvjhT7P5IXGc8PirfZqZf68ZOKSTdZsyxwxkMGDBU8L7wZpAcq93bg+Swn+v8UxUb5mTwWkQuUbSn5FbSayaWgiLXVx1TxbyXeq65UBFDQFBBMG9EXQ46uGQLvP/x5yE8raH7k42MPTmY2VzXIVlxxX/GNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490328; c=relaxed/simple;
	bh=m5X4c3KXZrss0dwELlNb2WZc+yOjHwRLxp6gkVEs5CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0NUMEh1huTecGklJq9IDXZMXOmTyduors+qKZEL+/t0ApMmg+C5V6f91WfYHf4oWmEW4eP2+SusLVUSH30YWHhsI5oZOYNTiCkgai27VJYEf7WSgT3j4AOkGmRtyRRGT0zwXuoRNdOssvb3ZXNI/94EBIRukuH/ignklyw0Qpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=WnY+LuQY; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="WnY+LuQY"
Received: by dvalin.narfation.org (Postfix) id C8D8820470;
	Fri, 26 Jun 2026 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu/sOezHMtRSwvo5XUH8opCmMYdUBzbM2NpFrFHLRy4=;
	b=WnY+LuQYpQVKsshKNO2GCTELgEcItYt4QLdGq6ZTZ323xFFT0pFmPpxT3RjZWX0yphZ2vW
	GwxL/ThEkummEzTHyQh3gCuCATCRL4jUpV42/XVzb/cNx2MissdeKdmqe0FaEKI3XfcUf9
	R3PROppJkytRkGP4UNecBFZg2cnh8Bk=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 22/25] batman-adv: tt: track roam count per VID
Date: Fri, 26 Jun 2026 18:11:51 +0200
Message-ID: <20260626161154.124562-23-sven@narfation.org>
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

commit 12407d5f61c2653a64f2ff4b22f3c267f8420ef1 upstream.

batadv_tt_check_roam_count() is supposed to track roaming of a TT entry.
But TT entries are for a MAC + VID. The VID was completely missed and thus
leads to incorrect detection of ROAM counts when a client MAC exists in
multiple VLANs.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 +++++++--
 net/batman-adv/types.h             | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 69a42bc3fa02e..2a7caab5c197e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3517,6 +3517,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  * batadv_tt_check_roam_count() - check if a client has roamed too frequently
  * @bat_priv: the bat priv with all the soft interface information
  * @client: mac address of the roaming client
+ * @vid: VLAN identifier
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
@@ -3524,7 +3525,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  *
  * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client, u16 vid)
 {
 	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
@@ -3537,6 +3538,9 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		if (!batadv_compare_eth(tt_roam_node->addr, client))
 			continue;
 
+		if (tt_roam_node->vid != vid)
+			continue;
+
 		if (batadv_has_timed_out(tt_roam_node->first_time,
 					 BATADV_ROAMING_MAX_TIME))
 			continue;
@@ -3558,6 +3562,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		atomic_set(&tt_roam_node->counter,
 			   BATADV_ROAMING_MAX_COUNT - 1);
 		ether_addr_copy(tt_roam_node->addr, client);
+		tt_roam_node->vid = vid;
 
 		list_add(&tt_roam_node->list, &bat_priv->tt.roam_list);
 		ret = true;
@@ -3594,7 +3599,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times
 	 */
-	if (!batadv_tt_check_roam_count(bat_priv, client))
+	if (!batadv_tt_check_roam_count(bat_priv, client, vid))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 01c8fef027b41..9bde0469e748c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2065,6 +2065,9 @@ struct batadv_tt_roam_node {
 	/** @addr: mac address of the client in the roaming phase */
 	u8 addr[ETH_ALEN];
 
+	/** @vid: VLAN identifier */
+	u16 vid;
+
 	/**
 	 * @counter: number of allowed roaming events per client within a single
 	 * OGM interval (changes are committed with each OGM)
-- 
2.47.3

