Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004803;
	b=mFRwFRxbgjcg1CDEI2KLEUW9YvQLJhQELuIgcTP9d/wfqkOhVV/VP2Kr90aDu3Tv0WBy
	 HBGD+5s/ymiwjtYcQnXjmT2oAhCix+AJXgCX1MTU3cEmoiOyw3O9fBHEHUcJsI3KUCJlK
	 fDAyxnJLgN5782SgP8CtujouxkA3rvhcNGbzzfgLXPrTCgt1Z2NhnE9hGo2b/vM9vUcVy
	 JZdfRtUbuKOjhsrJAg/JfT4KuBsrgaqtgtMrgU0iElf621sKDJbUX1PypROMu6+N6ENln
	 khMIPVmPuD+idAcpuwG6n7iLgsJb1N/IoufTPEmAmTJK/LOr3+kZB9sOqwXC00+FysA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004803;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cxXmU1gHIk+rLUIhSl6n8CsoMjs3h5pCmJ6cV3NBPIE=;
	b=Vv9HfcI+Ht5RY5JqG7ZGSCJGhJKEfpGQtW0BQR4BTz7G5RpF+hZdOZJtkbfOpTUX8E/7
	 d8r/WcgorIT6yzoij+UpM0PIJvtQGEjXSKNmgH+ICAac1T3+A1Xh1pLHB6EMdhgNfgit2
	 8Kho6HX7QtmSq8oMxw1ejrtkQU+qNP8UIKKWP7lWrqlic9hXCqJ05D+zBnfBY26l+9uan
	 qmrCt0eH+iFVzH0g92nkIkPciAYchGM1d+SlQbzP2wMswd2XkvzJRz7bdcVOKCNYGN3/4
	 zdDz+cQaSl1GzdnGkZI7AJI9X4/Q7/nH7RpPPDXXd2SBt/owmBvgibB2NHG++D6W/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=gDcshYgo;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B118660A260A;
	Mon, 26 Oct 2026 08:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B118660A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=gDcshYgo
Received: from kero.packetmixer.de (p200300c5973Ce5d80Fc8dfE94A24022d.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5D8C3FA26E;
	Mon, 26 Oct 2026 09:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxXmU1gHIk+rLUIhSl6n8CsoMjs3h5pCmJ6cV3NBPIE=;
	b=gDcshYgo0BOetHNnLXbBRvW/2mt+xDVI081MbiY8ubbNFjx4ioNub1WzGPjYpxUQGdD1b/
	oaBwYN5H3Kx25kBrohyxstm4DPLhaHlk4m0ucCHXwanXjESsCclLJDsUj9zAsPbI4iSNuk
	owW40g7BIAjp52AuLNX8ro0ZT/96zDvL/CwNIEJ/o5VO+zgfwBmp4GL/bvwXdYNKqVuR0A
	0xefQbPDvi7gS7ySPZmw4hiiQHCzMwxNWDXI3tUzHvwj1vzd+adDxJn20RBsELOaWKLnKV
	v3kpa4q7WnD97lIOSGvtpmHnsvxmHrTh5uAc0LuRPATnllls1njZjydzspjjOw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 09/10] batman-adv: tt: don't drop local events queued during TVLV update
Date: Mon, 26 Oct 2026 09:53:08 +0100
Message-ID: <20261026085309.1074911-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_tvlv_container_update() read the number of local changes without
holding changes_list_lock. batadv_tt_local_event() is not serialized by
the commit_lock and can queue new events before the changes_list is
flushed:

  CPU0                          CPU1
  batadv_tt_tvlv_container_update()
    num = ...local_changes;
                                batadv_tt_local_event()
                                  list_add_tail(...);
                                  ...local_changes++;
    spin_lock_bh(&...changes_list_lock);
    /* only num events copied but all freed */

The additional events were freed without ever being sent. Other nodes will
only notice this via a CRC mismatch and must request the full table.

The number of changes and the changes_list must therefore be taken
atomically. Events queued afterwards then stay in the tt.changes_list for
the next TT round.

The changes can no longer be kept for the next round when the TVLV buffer
allocation fails. But they would be sent with a skipped TTVN anyway, so the
other nodes have to request the full table in this case either way.

This does not make the TTVN and CRC decisions in
batadv_tt_local_commit_changes_nolock() consistent with the announced
changeset. Events which are queued between these decisions and the
snapshot can still be announced under a TTVN or CRC which doesn't cover
them.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fc286ddd-5bed-4683-b842-ee7a307eeb19
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 24054077cf3db..6774484f1c573 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1327,11 +1327,18 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	int tt_diff_entries_num = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
+	LIST_HEAD(changes_list);
 	int tt_change_len = 0;
 	int tt_diff_len;
 	u16 tvlv_len;
 
+	/* atomically get the list of changes */
+	spin_lock_bh(&bat_priv->tt.changes_list_lock);
+	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
 	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
+	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
+
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1349,19 +1356,23 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
-	if (!tvlv_len)
+	if (!tvlv_len) {
+		/* the TTVN of the changes is lost and the other nodes will
+		 * have to request the full table anyway
+		 */
+		list_for_each_entry_safe(entry, safe, &changes_list, list) {
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+		}
 		return;
+	}
 
 	tt_data->flags = BATADV_TT_OGM_DIFF;
 
 	if (!drop_changes && tt_diff_len == 0)
 		goto container_register;
 
-	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-	WRITE_ONCE(bat_priv->tt.local_changes, 0);
-
-	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
-				 list) {
+	list_for_each_entry_safe(entry, safe, &changes_list, list) {
 		if (tt_diff_entries_count < tt_diff_entries_num) {
 			memcpy(tt_change + tt_diff_entries_count,
 			       &entry->change,
@@ -1371,7 +1382,6 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
-	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
 	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
 				     tt_diff_entries_count);
-- 
2.47.3

