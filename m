Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336114;
	b=rsxn7nxJmDvckGt6WpojxYo6K3TZoV4ZZj/fcARgiAOlNYuKXeWK43anZq0BS8/EUHxe
	 KqCCnhWdwCItxb9QDnb1pR6ZZB/mGNJW5e7pUqRAB/z6EgWaIsFT7jwUWB4FbRn7iY3as
	 7hm7AeU4rAzprZQxRmT7Tng0azVhZgOkeFLDEZQGiAkl+ePGhhy/DzTBfxJl/XOD2UUF/
	 OrfgvW3taL5KifyfdBxAyNX/SnFG7pFZPa2+qWGq14HMzzY5lD5hpL/lkGMoyCwtcGt3y
	 nOiFt8t3mmYkBsEhwBapRSIpW+2BtLi1FJ0gCxTBQcP0RKwocGtYYJAFiGyBQui1HPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336114;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KHGhKy9qQThvzKbSGMvLB6JXGIfC9R9vmwfyx4ZB7Ko=;
	b=iU9+DT7zY6izfBWHRPHOWtRCahK+NuYYPNB5YyFBw2+vK8KPbSw79kAj7f0QorT6x+9W
	 Ucfm7n8aGXDfoJqR6WgCJyazzmTZrHDsISoShTduGNKwOq7Q98R+v7XUMb6e2dAgbS71s
	 aP1GqNbZT7AiegieWOwUCWo8v8shwUXkBSYZTj9PhTK/M7lZhK1Sg3NSTPhg7OYF7cHAE
	 GZesx+XhM9WRAeuPsNdD4rWwe7CA4vGl0P0kJb82IumG2bgfEBGfKQ+Ie2VfZi8Tg5W03
	 wgTrdQ6BWZCjSXw3+Wbb8B4wpS/Kvk6fAgq/+5lMExUwof5TJMT/OAjWbA/lg0V9b4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=v5xtsPXE;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 82A2F606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A2F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=v5xtsPXE
Received: by dvalin.narfation.org (Postfix) id 6E6341FE32;
	Tue, 10 Nov 2026 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHGhKy9qQThvzKbSGMvLB6JXGIfC9R9vmwfyx4ZB7Ko=;
	b=v5xtsPXEowZ0PJ5cs0bSrw0Q1lkCfHu0RsJRM6QmdhelaOFJHVp49JPxE9Da0WFnKvE8tQ
	YFbISxhg08XHUMw7SNOe7xd57Ju1qOTDlPLmS4TqynSuHPcxS4PJZxYkn9v6ftWD7wRJkD
	J7rkJNFtcPHUD0o+OBAmfV1JE98m7CI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.3.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Tue, 10 Nov 2026 19:41:41 +0100
Message-ID: <20261110184141.42827-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200104-failed-7.3-cc2186d78547@kernel.org>
References: <20261109200104-failed-7.3-cc2186d78547@kernel.org>
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
index 15566ae255c9e..4523daec6de5c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -632,6 +632,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	bool iif_is_wifi = false;
 	struct hlist_head *head;
 	int packet_size_max;
+	bool added = false;
 	bool ret = false;
 	u8 remote_flags;
 	int hash_added;
@@ -664,7 +665,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			goto add_event;
+			added = true;
 		}
 
 		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
@@ -745,10 +746,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

