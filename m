Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273326;
	b=EsNCITY8KKdIB/J5t2fqcxLuaNe8oMVJ+i30x+j1CLpCUkY0yLq/+u6e8415euB0I3vG
	 l4rIC244lqKmgR3Pgc3iMGBOwATr5NGKYr0RXap+oOktqbs68v8jy8EQEYRLW2ynWNUtc
	 uEqjFvtg2rl5tqbh+Un/8nhQQqzg0VFYYPgxOv6UJld7mNo7XgH3d3riPTBzuim7F6Pjy
	 TAGVG5GlXYVeyQWm6W3+ww2+MIblHH9GHdxTTIJam80dvI75DdT2W3fR3Kr+GimNWR5tB
	 wD7iCT8h7SqTR4r0UrizkyDsfa4VQ+ampOAnzG3IyXqFE7qMRbzylm4d6rSLWrwtUEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273326;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/U8WHYVKei/ale2r/t++wGxrY793fOwjCoUTtgJ5XFA=;
	b=EQ30O8cVVyaSNrljy2C+YmqQFPOGykmCW4pSb3yDjFHbibtsdwRwWgsQtGBq5RswmrxD
	 QN1tjTRsAJ5LA3yYzMC5IyLYNO+TGzqHdlXPAfFvN+Vd9Nt3jFlo8aF19cvDLwoFiUXJ3
	 Vy3eWa9AuhB5bHKOL5PKm2GFwRBuRy7Pvp7GymZLZgiv8xvtRPsqXXzQnYAtFmAvQDco9
	 DfOYdt0sMewB6HvLY+I+nMNSgsMMPKdjeKd7VlKDlAzccVxE598sfjczUcgHmI9HDP2JY
	 wPiOsDO2MBIz3tGGryI9QUDHECS6f/r5fEAZkclgayY9erQ+JA9D3kS6MsB4yFmvHlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FPv/CeZP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPv/CeZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DEA1F0089F;
	Tue, 10 Nov 2026 01:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273325;
	bh=/U8WHYVKei/ale2r/t++wGxrY793fOwjCoUTtgJ5XFA=;
	h=From:To:Cc:Subject:Date;
	b=FPv/CeZP3CIKfvVPmY+6V9ys3+kYvly7ZxbpboRtLKFf1CY5X453vvFxCYbBzuDo/
	 1YbaAY1T+MHHbANHhegMjDkZjX728c34iXkLRdCncKbyfUQZVFoXGu6yE30Mu53oLx
	 v3OMMQnJZIboOsKmCluiXEKOiNjeKhCqLZkN44OoWLthDilFuQnCKZpexUtCjFIjDK
	 BiBJ77Rh0bYtsFtrciMK0Bg4n2TKN9jD5ZNV/NZr526laXmlxCrpucWGGxlP9qbYJ+
	 FaIs+pNifqxRLHnhkSdXSrvllELzHi4IUgvpyPi3zXVCsF5DUttbg+rWnMZu14Q8Zq
	 6MG/XezLA+exA==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending local client" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:24 -0500
Message-ID: <20261109201524-failed-6.1-cc2186d78547@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cc2186d7854785b30d423f5d43757b086b300e55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201524-failed-6.1-cc2186d78547@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cc2186d7854785b30d423f5d43757b086b300e55 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 7 Oct 2026 13:02:45 +0200
Subject: [PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending
 local client

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
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 39b61426f1680..e13c2828da475 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -894,6 +894,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 					 bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	bool readded = false;
 
 	tt_local->last_seen = jiffies;
 
@@ -908,8 +909,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 			 * flag can be reset like it was never enqueued
 			 */
 			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-
-			return true;
+			readded = true;
 		}
 
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
@@ -926,7 +926,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		}
 	}
 
-	return false;
+	return readded;
 }
 
 /**
-- 
2.53.0




