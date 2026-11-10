Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272783;
	b=esBufTHOksVelK1f24OK58YP5w/LwRCr5oUUeHFQVeJmJ08gCz5YAuoG6on036d/Y32s
	 oPViwD2UUSHfAOe3PNfWaUza7NkJf+m0u+yPNMMV4pQo8HSQUuEcK27ozT6ZbCrBa6+rB
	 iIVIN+Hi+iuH0/DUd9w/0NCDauwcKv0Ud+oaAi1DSWTXwaqMWwF08pno+7MBvhy42RXl4
	 lkMD5CFpgn9AtnCF85ztxdPOEMY03LnQcK4cFsD2n2yUSZSZVDlUM2507CMV1QlS/zTjl
	 5BVXZuHMD/qqd056ZH722O27mRJu5Cpp5h0WpxixrOV7GJXk6+HqeMpGUHF8Vt8M6fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n+W1ywQ5rT6PiG5Vc08N8R/KUP+n4kUscyx2TlrTp6Y=;
	b=Ltl6fBlUzRp8XnI8R305zKXGkdPvRavnpYH/UBO28fJmghwRneSbgxrI3z5PCZh7bYCC
	 HaRUiKX8KCXFYGYpyhdnJ9n5Gs5TK2IJETe/JkK1E+QMH3/xQ9+z4nsQlAegfb1yUVLth
	 eECiXkwgoddPO1U+p7a9nKA5PxQI0kac7R/b2YAXLTyjgdXkRLwqp0B5W4+hJ/3U35yUl
	 MSkNxKVHrxYo/9kHzHuOtj7CSw9JlczJ43k7OtQvfl7/KX+0YgY+aIL5bB9vTMFidOn9D
	 3nTrcbvkQmNzflGaPOHvGN8e9hiM0loBx/PVFciZS9i/DHbXPbVdjkY40eohHS2giBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HnA9D/oD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE27606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnA9D/oD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76B1F0089F;
	Tue, 10 Nov 2026 01:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272783;
	bh=n+W1ywQ5rT6PiG5Vc08N8R/KUP+n4kUscyx2TlrTp6Y=;
	h=From:To:Cc:Subject:Date;
	b=HnA9D/oDw0NKM6euNqHskEOw/9LIkOqdRoiQ9IaRuyRbfqJMaXjoGZL6Hwbdk55wa
	 NY+jypyqdAopqtRXbp3kuIQbZptjbiLNIuvJvRcqWlJEQMcRpk+2YMcMkRdUaifW1N
	 rYVrI55SzOr6O0Y1SdgcdVfodMYwQddtvG3i8ujsKsY8GD72RhGoBqM0mJh1qd+I54
	 kfyDL0MSHI4V5gRa0DB2OGIO+gcDE05EudeuYHY1e3nlQu6YufeOK8WW1zABwIA4oj
	 PDlzUhWMsZHk4S8uzq+0dLtk2MVp8BO4OVqR6r1799RLMXKt9XqfaHROZV2+ad09KB
	 nv7s6t6JXl6iA==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending local client" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:21 -0500
Message-ID: <20261109200621-failed-6.12-cc2186d78547@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cc2186d7854785b30d423f5d43757b086b300e55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200621-failed-6.12-cc2186d78547@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




