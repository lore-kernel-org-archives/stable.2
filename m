Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336641;
	b=FiCD5F/8wQUBjqp6ksHziqnE6N8q8qkAUor3/sg+y3jBubcwbDjq5lVyZ3m1m4vg+y12
	 1blErjV2c33djpOnkst7zeJJU2QQFyWyyzdLRrpxTkKaofViYvzxGCWif0z2cB5ncAy1t
	 SwdPPx4Qx5rIP5iuPs8gh9ewN4JywfCCs7pEEB8dFmf2R7ZbS9zz0clptGidcU8YVfzHK
	 veGGlsM670qdG2ZyJha+Fh4i+5hiflLkSEVR6yiiht7f1prbEHZ39izi4LvY8yXsz5krC
	 NSxJ48sm6d11lk+LqOrnnmJsEjpUJ91SlALHBdbyiHTILyiHnhYzOHqSlw8Bjb3OGxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336641;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yRT61txqiCi4jIko/NOW8tNjJsck0AZ7tXaR8k81L40=;
	b=aRo0+VdtC3tKlQZrEx97ZletGOi3bqSAfBcsXprypkddqYhHqgk1UsrJtDVxP37C+0eY
	 bNvy+wfXDkPThbEveBy4RKNjX7DcG/a3fkTTfSjZh/6CK44ymxyt3pJlzgWPJUB5dD785
	 ukRiWaDVjLmRD53i/5kHapmsYzU8J9ON7fjsuoU0i6EnQK0dEzyfp5KyHWfoGHXi1tPXM
	 disvqEODX2YkLTQC9QDBtbIY30G5ElKwUXmj38rZ6t64iwn238wwzP8im8Y75VLDi5WzJ
	 xUXeN8LHJxNNggH2NUoFkSGhatzVMhvb5HekFMO3YXbMSdMQo3F6NnkBtyHo/xG3BZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=N3oTZl1z;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F3931606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3931606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=N3oTZl1z
Received: by dvalin.narfation.org (Postfix) id 3873F216C6;
	Tue, 10 Nov 2026 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRT61txqiCi4jIko/NOW8tNjJsck0AZ7tXaR8k81L40=;
	b=N3oTZl1zr7/vbIlaPt4mmG9q7Qr1+BM5wHxUsIwp68fwN1KD/HE6yki7iM40pUwj2XbnPB
	/3/W9Ag2jH7D6f77gS2KjMoHa2XDp420JO2sdApKzIk51p7It+gPsCdRZ4c1Lxu+p/j/Wr
	Euj1413HiKLLm9JkCdmgQFkEIIWjev4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Tue, 10 Nov 2026 19:50:36 +0100
Message-ID: <20261110185036.73635-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200225-failed-6.18-cc2186d78547@kernel.org>
References: <20261109200225-failed-6.18-cc2186d78547@kernel.org>
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

commit cc2186d7854785b30d423f5d43757b086b300e55 upstream.

When a ROAMING_ADV is received for an announced local client,
batadv_tt_local_mark_removed() sets BATADV_TT_CLIENT_ROAM, queues a
DEL|ROAM change and marks the entry as BATADV_TT_CLIENT_PENDING. If the
client sends a frame again before the next TTVN commit,
batadv_tt_local_add_existing() only clears the PENDING flag and returns
early. The ADD cancels the queued DEL, but the entry keeps the ROAM flag:

* batadv_is_my_client() reports the client as not served by this node
* batadv_tt_local_client_is_roaming() reroutes unicast frames for it to
  the node which sent the ROAMING_ADV

The ROAM flag is only removed with the next frame of the client.

Since BATADV_TT_CLIENT_ROAM is set together with BATADV_TT_CLIENT_PENDING,
it has to be cleared also at the same time with BATADV_TT_CLIENT_PENDING
when the client roamed back.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
[ adjust code still in batadv_tt_local_add ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c7ea317acc516..d1cc702e1f14d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -612,6 +612,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	int hash_added, table_size, packet_size_max;
 	bool ret = false;
 	bool roamed_back = false;
+	bool added = false;
 	u8 remote_flags;
 	u32 match_mark;
 
@@ -638,7 +639,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			goto add_event;
+			added = true;
 		}
 
 		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
@@ -719,10 +720,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		goto out;
 	}
 
-add_event:
-	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+	added = true;
 
 check_roaming:
+	if (added)
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+
 	/* Check whether it is a roaming, but don't do anything if the roaming
 	 * process has already been handled
 	 */
-- 
2.47.3

