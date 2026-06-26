Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D03FB055
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490219; cv=none; b=Mcom4EIwRvYOzJmsn+V5nX4YhwSa/2hNtTiW3M3ZDlZiXNS8KremRywrdMgjyQJa0PQtnAe98jaMDj8ncLiAzVQklBhqrGANJzyVe3uisNHrfgztJc6VBd5A08ey2lH32ttVCD8XYYccmZ3mNMhTCAvsvsWPILgOAyvdCH2JG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490219; c=relaxed/simple;
	bh=llERaE+wwsHTADv3+e1XTcMN7TxgpvAb241U5xOs4Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYeZcvNhMRcTLEsOMdiM+2S+Y0tUhvW1NQkU+gQ4QSjTRbt0WggXmFWblY0q87sMw6s4St3WzPiGPRZZgaNFlBEqJcjUPlADhmeTymAa5YMPHkPVvBXsZFX9ukKyhFX1fJ/DK+vY0ZaW4R8PB7wrGfa/3r7HE4sAG3u/2++pTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=z+HzOAqz; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="z+HzOAqz"
Received: by dvalin.narfation.org (Postfix) id 0E8EE207F2;
	Fri, 26 Jun 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HITUKdEP6DKezIdCPbCj/I1RLm0k0qduLzGsI1bawM=;
	b=z+HzOAqzqL4d8V8WveAzSjzV5RW8aaVapjCSJaXpHcU8mphIZR6/elLR/0n7PDVQQNVDFn
	hdxfknfLuLhBvKe4VknPBclbZYI1SKe5R80f1E6JiZt7Iyod5FoBYuv58GLFcUcZELp8O2
	OXpcf/SBXkhEFLx76ursyRlRyswU+4Y=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 20/23] batman-adv: tt: track roam count per VID
Date: Fri, 26 Jun 2026 18:09:49 +0200
Message-ID: <20260626160952.123713-21-sven@narfation.org>
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
index c323660897d43..4b3f39d6ddaf5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3753,6 +3753,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  * batadv_tt_check_roam_count() - check if a client has roamed too frequently
  * @bat_priv: the bat priv with all the soft interface information
  * @client: mac address of the roaming client
+ * @vid: VLAN identifier
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
@@ -3760,7 +3761,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  *
  * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client, u16 vid)
 {
 	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
@@ -3773,6 +3774,9 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		if (!batadv_compare_eth(tt_roam_node->addr, client))
 			continue;
 
+		if (tt_roam_node->vid != vid)
+			continue;
+
 		if (batadv_has_timed_out(tt_roam_node->first_time,
 					 BATADV_ROAMING_MAX_TIME))
 			continue;
@@ -3794,6 +3798,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		atomic_set(&tt_roam_node->counter,
 			   BATADV_ROAMING_MAX_COUNT - 1);
 		ether_addr_copy(tt_roam_node->addr, client);
+		tt_roam_node->vid = vid;
 
 		list_add(&tt_roam_node->list, &bat_priv->tt.roam_list);
 		ret = true;
@@ -3830,7 +3835,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times
 	 */
-	if (!batadv_tt_check_roam_count(bat_priv, client))
+	if (!batadv_tt_check_roam_count(bat_priv, client, vid))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 437d651a1cffe..88831374e8174 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2059,6 +2059,9 @@ struct batadv_tt_roam_node {
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

