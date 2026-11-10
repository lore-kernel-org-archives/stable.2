Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336844;
	b=H3JUiSHWO8vQQ+ZB8APS8jRiYCW+xo5dNdWNslWvJ0UUyzAJtO0TEmo8VXfg/gumWJes
	 9NY+SCNNMGQTIEv21RUMnUZuVmnOKC4iMK34db8VHFsXyR7kCG0rXcpV/I31ZuUjxTSLK
	 iWD8Gz0FY22zONCcRFmT+MOyslR/QfYbr9vHFdbtqe3C2NcE5YK6Mar+DSy5FGyLlMory
	 VtXa3f6Ar2XQnSGrkJczDa4SwikeG1FN28J5KWSioZMyNJSKnmhGZS4hEgEy82GiGZLOC
	 H3xHmD1y/LK6iQcmE1zQ/4R83+b/EI27qpRv1WY/ezr8FGZblP3zES1TTecfuc1lPQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336844;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1MzKz9QSxfF6XoW6plJVcSeplaY593DkXWqJV7OytsA=;
	b=q05un5z3WHYiFn8MJN1bOuPyOi+3PGlvGQxKpAeY9GiO3lAkDu/mtkSb7N/iSyYHcgS5
	 ueEv2DgAwGeRVQcBx9jIZx5BCmKbxJd0mFeqqdLoWpIdJLhczHTcqBEjoVY/4TYbBl9R4
	 uRLNaNOPDY29HBRNKfl0DR73ceeIVLP9dNFcCvewNqqp//FIXNHwgXGMoxUGPVXLLY2aJ
	 ouY8xnOti9iMCmIEB0h07/ScB3R4QwOclx69Tm8TPkqqK/aJiUfAhTnRgbqtkvneUHhnC
	 W1bZ/Cv4t9d2wIkHNrXz4+9m1171If+r97UjZ2eAq1co9FJ9JJhamhK1gYFAA4ir4KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=FIi6U770;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EB24C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB24C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=FIi6U770
Received: by dvalin.narfation.org (Postfix) id 89C8C20FF9;
	Tue, 10 Nov 2026 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MzKz9QSxfF6XoW6plJVcSeplaY593DkXWqJV7OytsA=;
	b=FIi6U770cvask3Q0G/CrwXirURG1RH/c6shQJzwNFZmHIUTXjpq1jqkkM9lPLPjCwsVC70
	wgFKds39oxWiArTdV6ExEo+91ny3W1Ri+iq0mJa1QEx/jdh1bZaRKpD1LASbCEMDCmqeq3
	F6PcdWpn/ZbB84ZFX7pp4hvnAIxm3Io=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.18.y] batman-adv: tt: don't drop local events queued during TVLV update
Date: Tue, 10 Nov 2026 19:53:57 +0100
Message-ID: <20261110185357.79794-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200231-failed-6.18-ed7a0dfdd370@kernel.org>
References: <20261109200231-failed-6.18-ed7a0dfdd370@kernel.org>
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

commit ed7a0dfdd370acb48be7a281df732c1bebcc7f1d upstream.

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
other nodes have to request the full table in this case either way. The
last changeset is only dropped in this case when the TTVN was incremented.
Without new changes, it still describes the current TTVN.

Previously, the unconsumed changes caused a retry of the TVLV container
update in the next commit round. Since the changes are now consumed, the
next round would only take the path without changes and wait for
BATADV_TT_OGM_APPEND_MAX rounds before updating the container again. Until
then, the outdated container with the previous TTVN would still be
announced. The ogm_append_cnt is therefore reset on failure to retry the
update in the next OGM interval.

This doesn't make the CRC consistent with the announced changeset. The
local table modifications are still not serialized with the commit and
batadv_tt_local_transition_new() can still make a client part of the CRC
for which the event is only part of the next TT round. Such an
inconsistency is detected by the CRC check of the other nodes and solved
via a full table request.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fc286ddd-5bed-4683-b842-ee7a307eeb19
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 61 +++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e7242706e3345..dfec5cce5fe50 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -978,20 +978,22 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
  * batadv_tt_tvlv_container_update() - update the translation table tvlv
  *  container after local tt changes have been committed
  * @bat_priv: the bat priv with all the mesh interface information
+ * @changes_list: list of committed changes which will be consumed
+ * @tt_diff_entries_num: number of entries in @changes_list
  */
-static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
+static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv,
+					    struct list_head *changes_list,
+					    int tt_diff_entries_num)
 {
 	struct batadv_tt_change_node *entry, *safe;
 	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tvlv_tt_change *tt_change;
 	int tt_diff_len, tt_change_len = 0;
-	int tt_diff_entries_num = 0;
 	int tt_diff_entries_count = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
 	u16 tvlv_len;
 
-	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1009,19 +1011,39 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
-	if (!tvlv_len)
+	if (!tvlv_len) {
+		/* the changes are lost and the other nodes have to request the
+		 * full table. Don't answer TT requests for the new TTVN with
+		 * the stale changeset of the previous TTVN. Without changes, the
+		 * TTVN was not incremented and the last changeset is still valid
+		 */
+		if (drop_changes || tt_diff_entries_num > 0) {
+			list_for_each_entry_safe(entry, safe, changes_list,
+						 list) {
+				list_del(&entry->list);
+				kmem_cache_free(batadv_tt_change_cache, entry);
+			}
+
+			spin_lock_bh(&bat_priv->tt.last_changeset_lock);
+			kfree(bat_priv->tt.last_changeset);
+			bat_priv->tt.last_changeset = NULL;
+			bat_priv->tt.last_changeset_len = 0;
+			spin_unlock_bh(&bat_priv->tt.last_changeset_lock);
+		}
+
+		/* announce the already committed TTVN in the next OGM interval
+		 * instead of waiting for BATADV_TT_OGM_APPEND_MAX idle rounds
+		 */
+		atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
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
+	list_for_each_entry_safe(entry, safe, changes_list, list) {
 		if (tt_diff_entries_count < tt_diff_entries_num) {
 			memcpy(tt_change + tt_diff_entries_count,
 			       &entry->change,
@@ -1031,7 +1053,6 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
-	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
 	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
 				     tt_diff_entries_count);
@@ -3695,11 +3716,25 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
+	LIST_HEAD(changes_list);
+	int changes_num;
+
 	lockdep_assert_held(&bat_priv->tt.commit_lock);
 
-	if (READ_ONCE(bat_priv->tt.local_changes) == 0) {
+	/* atomically get the list of changes. The TTVN decision and the
+	 * announced changeset must cover the same events. Events queued
+	 * afterwards stay in the tt.changes_list for the next TT round
+	 */
+	spin_lock_bh(&bat_priv->tt.changes_list_lock);
+	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
+	changes_num = READ_ONCE(bat_priv->tt.local_changes);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
+	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
+
+	if (changes_num == 0) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
-			batadv_tt_tvlv_container_update(bat_priv);
+			batadv_tt_tvlv_container_update(bat_priv, &changes_list,
+							changes_num);
 		return;
 	}
 
@@ -3716,7 +3751,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt.ogm_append_cnt, BATADV_TT_OGM_APPEND_MAX);
-	batadv_tt_tvlv_container_update(bat_priv);
+	batadv_tt_tvlv_container_update(bat_priv, &changes_list, changes_num);
 }
 
 /**
-- 
2.47.3

