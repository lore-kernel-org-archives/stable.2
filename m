Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339176;
	b=PCtyTJ96uYB+rAIxJbEAbLRT3FFJ/n5tzbZmcCXyhXa2UPOhbRB0dMCKHMFGBT1hAsWW
	 3xQgfkwjBI1gOvGUObPv14sNvtcKGige81I5iSztPV9Cqb0iYS5mlg+fbqE4HEpksCwbQ
	 2jz3zq+ReKsFgehfBKlPihZEh2uQlJS8KEUONywV6YIKqDxKO3pLlj5Ov7+38gM70Zbhu
	 blPpIm9TGXRz2nbxGSaKZ17NB2zOpcDZtgizsev79pR/fqfFRrUQgdMZae5jXY24pG5pX
	 QSlCoLc4Akjl4gYQx25lQMNS7uIUIAvRkAWl+Ovf+xA/2+LJVQYnxqe9GhVf1wqh4Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339176;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fHG3CQSTPg+TQDQxfsi36+vCaipB6W4jrUD6Bfih+eU=;
	b=IfZaGMdRXLSsnEqrNLprF4ph+X0VtBf/5AM3INAno55LCxVHxDiEL8cPnEfGS7NkTtrJ
	 02UjTLBWTHP3OT7mRPfjavXIBFxkEOpe0d2mPxGrRJQWFVRQyxu5NLDbX6hrWWpZyvtYr
	 2w7rX1QP/Gh30HWgo+bgqQRRC55poxifmzAe6dZND7QrBAiXlcFIzt+E8/AuRr80UmrpY
	 sZmPY9+9WPYuwEIxyYstYzlsk3hOjyttIr8aQGZYFZOMozpdejsfl99F8+krMim1Lh06t
	 TwVkjkVdQ4GSVIwd1My5ZaK6u1Ie8AvbVyd7o4i1II3JhytbkusBFJsVH1l4VHfZIAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b="G9m/aZOp";
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F2475606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2475606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=G9m/aZOp
Received: by dvalin.narfation.org (Postfix) id 54E1A20292;
	Tue, 10 Nov 2026 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHG3CQSTPg+TQDQxfsi36+vCaipB6W4jrUD6Bfih+eU=;
	b=G9m/aZOpHLQEBzIgHlpqkOb/7rnPTTfAE/5qOdsWZJPTlV34J5is2/wSSf6XV28WFuJHNY
	3Lr77QBj5Yehp7NrCeQ+whK1MXTssXwcWYtZuO5G9OA/Wv4Kt1ZdRwvTx/2FRD82t+KrIm
	qykwnGSOMEz/GAzyw2gFO9tM1OczXQo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1.y] batman-adv: tt: only update flags for TT events
Date: Tue, 10 Nov 2026 20:32:47 +0100
Message-ID: <20261110193247.253694-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201528-failed-6.1-ad1fd828aa39@kernel.org>
References: <20261109201528-failed-6.1-ad1fd828aa39@kernel.org>
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

commit ad1fd828aa3944efc393b84b0d7c02483f1b5638 upstream.

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
[ Context, drop now unused code for removed entries ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 41 ++++++++----------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8ff98e5dbdbb3..a73aede68bff9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -455,6 +455,9 @@ batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
  * @bat_priv: the bat priv with all the soft interface information
  * @tt_local_entry: the TT entry involved in the event
  * @event_flags: flags to store in the event structure
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one.
  */
 static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  struct batadv_tt_local_entry *tt_local_entry,
@@ -463,8 +466,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	u8 flags = common->flags | event_flags;
-	bool event_removed = false;
-	bool del_op_requested, del_op_entry;
+	bool del_op_requested;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
 	if (!tt_change_node)
@@ -496,44 +498,23 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		/* DEL+ADD in the same orig interval have no effect and can be
-		 * removed to avoid silly behaviour on the receiver side. The
-		 * other way around (ADD+DEL) can happen in case of roaming of
-		 * a client still in the NEW state. Roaming of NEW clients is
-		 * now possible due to automatically recognition of "temporary"
-		 * clients
+		/* the other nodes may know the client with different
+		 * flags. A DEL+ADD must therefore still announce the
+		 * current flags and an ADD+DEL must still remove the
+		 * client. ADD+ADD and DEL+DEL only update the flags
 		 */
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (!del_op_requested && del_op_entry)
-			goto del;
-		if (del_op_requested && !del_op_entry)
-			goto del;
-
-		/* this is a second add in the same originator interval. It
-		 * means that flags have been changed: update them!
-		 */
-		if (!del_op_requested && !del_op_entry)
-			entry->change.flags = flags;
-
-		continue;
-del:
-		list_del(&entry->list);
-		kmem_cache_free(batadv_tt_change_cache, entry);
+		entry->change.flags = flags;
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
-		event_removed = true;
+
 		goto unlock;
 	}
 
 	/* track the change in the OGMinterval list */
 	list_add_tail(&tt_change_node->list, &bat_priv->tt.changes_list);
+	atomic_inc(&bat_priv->tt.local_changes);
 
 unlock:
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
-
-	if (event_removed)
-		atomic_dec(&bat_priv->tt.local_changes);
-	else
-		atomic_inc(&bat_priv->tt.local_changes);
 }
 
 /**
-- 
2.47.3

