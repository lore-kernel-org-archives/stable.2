Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336759;
	b=QsVYlLisuY4zNu+sPB3KCy7KqHRYxsIX4e9Y6YwX7i7vw0ZR/Rcv8a6bCfWj/Ty/nHyy
	 QhDkeZNFR9EP7pfxepaMDN3/xQdTGkBcJV/HLKpZFuaeq9WHZMGvNVrpgEtFcACcpIe0C
	 VR2SXlYRiu9k8VcuhdOyz+KKXnp2cwHokK3+KwAPILRzzus87nz7Q8bGYNbA7SdiccCum
	 bUmHUsUmMDE7I7QZGJfvBcv9IXZBB3K/96DE7RAk8LOIXRini2zZcGlpjMFGdmyRHfLo1
	 Pt9l2PBtJQ32ZUH65LLweut4djt0d1gOd/HK+At+Xv50yrdwFi+BGpyClFyM0pctsTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336759;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3G/x1ZUc7Vwg2Jxk4zyD1AaxfghqpUE/YQMVnHz2A+I=;
	b=JJm2UkCLzZQdj9ePkb8ZbSfUo+BmlDvtnNmUik/VCcL95oJcRIZhDHeEVe7hyTDnRxHq
	 96zdZnOrVmKrA+tZQJQoUIwhbCppJPiLhcqOs87veNlIyvJcRHjN6jnpGyz/HoX1gfA1H
	 HQDI9ylBeMDGkvEDgR9rtlLFrWlB4P0/A5Plnay/EZtzJL8XXQpqikRXKScyNo/+fewSM
	 Lh4WzQY3i/xo3SNNAZOOoDw/5zBDmZIvJomFt92sQPQEJjRPyiOxmK9aua7ZE/Cc/TTr2
	 K581/K2cr+Pslq4OIFwZYK3iPa2j606iwApolonIGV82C8ZKwaBed5VXZB5FL3wZaFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=W6qHJW6N;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 75C83606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C83606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=W6qHJW6N
Received: by dvalin.narfation.org (Postfix) id B5D9D216C6;
	Tue, 10 Nov 2026 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G/x1ZUc7Vwg2Jxk4zyD1AaxfghqpUE/YQMVnHz2A+I=;
	b=W6qHJW6N7ryRExYX4HjFzzw046BP5G7YZucUeNKPDN6NO+aiVY5lQrldYnlLQ/6EbfStAs
	fTVZVgfuQ483MDXa+mwQsDVocnn7RdzL8nmmqOoBUHyng5J7lpYLMg3ox69rxTIIUlfIpT
	tA0guiedK/LB3JrrB4PIzLl+GJXCoiI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18.y] batman-adv: tt: only update flags for TT events
Date: Tue, 10 Nov 2026 19:52:30 +0100
Message-ID: <20261110185230.78235-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200229-failed-6.18-ad1fd828aa39@kernel.org>
References: <20261109200229-failed-6.18-ad1fd828aa39@kernel.org>
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
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c73596ef6160c..e7242706e3345 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -415,6 +415,9 @@ batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: the TT entry involved in the event
  * @event_flags: flags to store in the event structure
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one.
  */
 static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  struct batadv_tt_local_entry *tt_local_entry,
@@ -423,7 +426,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	u8 flags = common->flags | event_flags;
-	bool del_op_requested, del_op_entry;
+	bool del_op_requested;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -457,25 +460,12 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
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
2.47.3

