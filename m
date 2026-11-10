Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273635;
	b=jxIWdQ4Q+yvC46UIyPVklhsYbuSg6D1NmM+lnXR5+A3PhAMx9OVcg7y9RaeNeBOvbEgI
	 +Sm0C7HIiQoEwAy1ssVHbYF+mst5sRjjR1zMF3eVUDyaWHHE7IbLF8NSwaMywpQP87vqx
	 Qr9QaTItrKwlvPA1asxtGrkBliJl1Fr7wHTQ9SiZmIJqBkfp7JLh819F6Kz1xtMMADsWt
	 hwkT1NedDTt3Xey0f+5X22hvi7JpokquxMRH9xQJnlF4MAmE/7FwaC+iq4e1buLYBG6b3
	 tqlOmDrlms5+tf7xBd3/f/p9uvX0iL768p4Xc/QtaTh5Ra+2PYmI4Yf76fDkE1QwsEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=105j/EztII+k0mzUijCFL6HzNnH8eZLXj+IsEZd6GZE=;
	b=IZW9yUSCQHCwiCyj3/veZ0G8Q5na9PYrC+/pz8kgMxa0L7Avnnu1dVYfFE9dgjsWu0hn
	 cUGkwHmgs2WCQUu+ViX2duOUaOP3iyaiF62aBHBNoYH/FyTZk1YtmNVncOZSjRduxBf3f
	 L00UnG98E/31zGkhTGTC8Kp0LucSWeaNvG3Ktx+YUJOajZPPji47zsd8ZsxwMARULWj77
	 Sf8BOo5G7zgyL5yvBSK/CennE4pPhj+u7uUAZe7bU3e7+Dc2TEvjpaOHhiQer90bdUVIJ
	 htQkGBAnEf8nPY/KNZ3STTUMEzJNnVuhLMTszaaq4bkTo+7u5D+0KiNyTUJ/yddgM3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdVHMNkU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEF606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdVHMNkU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565221F0089F;
	Tue, 10 Nov 2026 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273634;
	bh=105j/EztII+k0mzUijCFL6HzNnH8eZLXj+IsEZd6GZE=;
	h=From:To:Cc:Subject:Date;
	b=NdVHMNkUiNLEcv3t0tSCuZG884lZKLw9smmn/lD5PfBQGH/CLceUwuNNLTsJe0MXk
	 Tq6s7VgcuCXDr6HPapV/HRUqkiu7s4LbIGS1H9YhBmLc3nbKd3NC3Y7lcMziPg4meb
	 ySlUIz8AHk7xIbY/al0/zVTq0kHfXvshWAH8H4co7nXQ85/MXbXhwTnzuxtoIkethX
	 7FebDkTye4V87c9GUZ/+u4WinhBQ3GmIkvWxBHdMBrETUIdq3C8kRinexqGZtiZJvI
	 78uqO5SNBlFoVC5fVZScefK6SldKtpGXtAoecsArrkLODR6675IRfuKVgqaAPRt9FG
	 xa7+S3/xxULDQ==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: only update flags for TT events" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:33 -0500
Message-ID: <20261109202033-failed-5.15-ad1fd828aa39@kernel.org>
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
git cherry-pick -x ad1fd828aa3944efc393b84b0d7c02483f1b5638
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202033-failed-5.15-ad1fd828aa39@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ad1fd828aa3944efc393b84b0d7c02483f1b5638 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 8 Oct 2026 16:30:10 +0200
Subject: [PATCH] batman-adv: tt: only update flags for TT events

In the first implementation of the translation table events, it was only
possible to announce:

* ADD: new locally detected client
* DEL: disappeared local client

If an ADD event was queued and then a DEL event was queued in the same
timeslot, it is valid to destroy both events because nothing actually
changed for remode nodes

But with commit 3c4f7ab60cc2 ("batman-adv: improve the TT component to
support runtime flag changes") and subsequent changes, it could also happen
that there are extra ADD events:

* ADD: _NEW_ locally detected client
* ADD: already existing client with new flags
* DEL: disappeared local client

The first and the last type of event could in theory still be removed
together from the (to be announced) events queue. But if the "update flags"
ADD is dropped together with the DEL, it would still leave global
translation table of a remote node in the incorrect state - believing that
the client didn't disappear.

If a detected client was previously announced, a DEL event must only
overwrite the "update flags" ADD but the DEL itself must still continue to
exist in the (to be anounced) events queue. For now, adjustment of the
announced flags is used for everything instead of dropping already queued
up events completely.

Similarly, a DEL followed by an ADD caused both entries to be deleted. But
the new ADD could announce flags changes which were not yet present for the
client before it was marked for DELetion. The new ADD must therefore only
overwrite the DEL - but still be kept.

Cc: stable@vger.kernel.org
Fixes: 3c4f7ab60cc2 ("batman-adv: improve the TT component to support runtime flag changes")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 247cce95c09f4..fa5ead248f192 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -622,6 +622,9 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one.
  */
 static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
@@ -631,7 +634,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
-	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -665,25 +667,12 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (del_op_requested != del_op_entry) {
-			/* DEL+ADD in the same orig interval have no effect and
-			 * can be removed to avoid silly behaviour on the
-			 * receiver side. The  other way around (ADD+DEL) can
-			 * happen in case of roaming of  a client still in the
-			 * NEW state. Roaming of NEW clients is now possible due
-			 * to automatically recognition of "temporary" clients
-			 */
-			list_del(&entry->list);
-			kmem_cache_free(batadv_tt_change_cache, entry);
-			changes--;
-		} else {
-			/* this is a second add or del in the same originator
-			 * interval. It could mean that flags have been changed
-			 * (e.g. double add): update them
-			 */
-			entry->change.flags = flags;
-		}
+		/* the other nodes may know the client with different
+		 * flags. A DEL+ADD must therefore still announce the
+		 * current flags and an ADD+DEL must still remove the
+		 * client. ADD+ADD and DEL+DEL only update the flags
+		 */
+		entry->change.flags = flags;
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
-- 
2.53.0




