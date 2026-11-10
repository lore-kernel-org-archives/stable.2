Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273637;
	b=LsyWbgCUBm9RAhdQFF7yaP7ZW8wTTVkG0YMR3PhtpEhW0Jf6NJrpPDhvprGZQdWWRb7z
	 CuPTLXJlZaKk9vt9WjGrlXQXHlU+m52WfzdhiPwL/iLDQhwzhDzdG/d8URiIiMadPwVsk
	 5y8xlSlhJtJRafREUSdeaj1hm0x5WcHhtdDw8lshHgYuc+IqBIFDDYdDDA6D3lb8sfrSm
	 FtfdtVkU1QKc0pH/Vfrck+UZfk/xUq/DVUtjoKcVtopJTnYtlEPMvnXyCGiAiKd0UdvfW
	 EfyJUPrweD8r10wTsL27+izH5xFmtmCy8op2RywQomcWZgQ3NqxY4EWeNr5d45XSWQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6/9J8HWmdekKvpUNP1Iag5qSTq8cvYMr2m6zACsJclI=;
	b=sVtgo1rpK42JXgVaj+WVkH2bo35fgFmr6ACvufA/kGu7LgpxvHDCkNYC+87wQ6InlwyP
	 v0YUq4vrR7P7bJbqB51wLm6jyiQFP6rMdqX5M4+mw+5OEKjlYwR9I0hPCczIuKPNnTPyw
	 fYKGAbuAm4O+bYCvWY5Hz9Q4mNm3nfou5xLYFAMmixbjJ2+KoIevw4Kc8wHpWzicbaaBM
	 A7RKCBU79xQ9jKDjVwjNEuCaFnGX0w8mQUBRzy5AxPhIjV/g28ki8aXv4Qe4ipykCUNi7
	 JOzM3b4pZsoPRZPG5AgEDEfEu/psOed156wvyLWiaCS965qMG3V6RNfjPtQ4TKCezUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrJhGONl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4260A260C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrJhGONl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10ED1F0089F;
	Tue, 10 Nov 2026 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273637;
	bh=6/9J8HWmdekKvpUNP1Iag5qSTq8cvYMr2m6zACsJclI=;
	h=From:To:Cc:Subject:Date;
	b=IrJhGONl+ChQ/NNRGzatn7lLvUEqgPflk3pAusvz2PttSOjw1FNDbyCQu76O9gJSb
	 OGQr3XlsijswHIpoEkbbJ9ADurxxUC/K8Db5icfBpY7iR5iAtXqwXEKhDuCsUDJu6N
	 w/iua7Lqjjk24fmn1s4W8bGdH8CjCTrA2uquaDa+EvA54Iqyzrc4tPyKKhdT2oaTmd
	 nAOqJX1XqsEhc5X398/Ob9WTDsUomZ2WCVTgmsSAt3r9KbbKT7BRYNS3EwU3YGPqiZ
	 5vh/rGojyYdABRWyoqNK5VKr1h3wmk3YMUhamwZLFMeLvGyIyA11gMSszOjmZwtjLs
	 3aqs+T6PMuiaw==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: don't drop local events queued during TVLV update" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:35 -0500
Message-ID: <20261109202035-failed-5.15-ed7a0dfdd370@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ed7a0dfdd370acb48be7a281df732c1bebcc7f1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202035-failed-5.15-ed7a0dfdd370@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ed7a0dfdd370acb48be7a281df732c1bebcc7f1d Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 8 Oct 2026 17:41:24 +0200
Subject: [PATCH] batman-adv: tt: don't drop local events queued during TVLV
 update

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
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 61 +++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index fa5ead248f192..f0100ccf93deb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1323,22 +1323,24 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
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
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tt_change_node *safe;
 	int tt_diff_entries_count = 0;
-	int tt_diff_entries_num = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
 	int tt_change_len = 0;
 	int tt_diff_len;
 	u16 tvlv_len;
 
-	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1356,19 +1358,39 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
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
@@ -1378,7 +1400,6 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 	}
-	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
 	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
 				     tt_diff_entries_count);
@@ -4429,11 +4450,25 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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
 
@@ -4450,7 +4485,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt.ogm_append_cnt, BATADV_TT_OGM_APPEND_MAX);
-	batadv_tt_tvlv_container_update(bat_priv);
+	batadv_tt_tvlv_container_update(bat_priv, &changes_list, changes_num);
 }
 
 /**
-- 
2.53.0




