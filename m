Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046C40960A;
	Wed,  8 Jul 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502740; cv=none; b=AIcbbu3frsInox+hHnTdHYbewWo1QbLr3ZvBrHM/FHvt0UYTTGYyQjKUUux9RKDllE9mGEa5uOxdXJz+XxAQdDyPO1BS+fzeyM35PEJicyout0+BJdcMZuUMqTNJCtZ6JXjim9IHWHaLleGMjcczXDYECRUwTiV0hd7SiDadmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502740; c=relaxed/simple;
	bh=z2y2eFK/vgKRHQoO8Ch0RMv5BVHK+J78ZvQ7iUZ5lU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBtAYVFGZRmUN0PFrwC3h9OMxooGz7njqyMF8HTtEycrON43IsB89YdVyLCdxGlDklIH6g+W6IU4FvHWFgTgUUk0wR1nvTfWghiJJcvyIGJ1IhM9PylhNXHKrU+AcFBoCnIZcdHnJV3hxpSW3wJY9abiFUr6miy0x240QTZWzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=mN+nJC0h; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="mN+nJC0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhon6sTuY4kUTXwjWv/Mi9kGv+9UzLfGRQ7dJRuPoZ4=;
	b=mN+nJC0hwMwr8tRccPs1GyDN2Pi/CAxBAEBxe1wnx42SIMgXXRUhZfXYc3m2lQtAb70G8B
	WQL3CHenvd+3zxuodQAj9RkV+njCVLgnF9g24+NXwXj58VUOvWjKbufU5jRjEkkPmj0p/r
	pgN6c1s+xqScl/WK7sVOl/8PErDZwMCDfGYKfvyaU1Fj/HSkJUoyHBo+t/+rMgb7nSuCIC
	mHh38te0f84yXeM7fHJB39Geu5J+oKOPXqOZXhTJEjS3tqdnH1Pc61u8v3izyNkz/RiUdk
	ZI7OZXEg4n8km/8MSMNIzf0emYMiGAKM1fAly6PgXddjr3sNMHb/c13tGvYTjQ==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 4/9] batman-adv: tt: avoid request storms during pending request
Date: Wed,  8 Jul 2026 11:18:16 +0200
Message-ID: <20260708091821.314516-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_send_tt_request() allocates a tt_req_node when none exists for the
destination originator node. This should prevent that a multiple TT
requests are send at the same time to an originator.

But if allocation of the send buffer failed, this request must be cleaned
up again. But indicator for such a failure is "ret == false". But the
actual implementation is checking for "ret == true".

The check must be inverted to not loose the information about the TT
request directly after it was attempted to be sent out. This should avoid
potential request storms.

Cc: stable@vger.kernel.org
Fixes: 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4bfad36a4b704..aae72015645a4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2971,7 +2971,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 out:
 	batadv_hardif_put(primary_if);
 
-	if (ret && tt_req_node) {
+	if (!ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
 		if (!hlist_unhashed(&tt_req_node->list)) {
 			hlist_del_init(&tt_req_node->list);
-- 
2.47.3

