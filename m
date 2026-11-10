Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273936;
	b=lPJcNSJzvUoq88h5c855a10pO6MZ28dw2gT0urBHSsBzMi7H2N27LcmQbrX9J7O6kl10
	 Zxhy0cDNEtv9w98qEGsrXk8rlSRcwCVPrUW80TsZO678jAn1OQSQSX0SqQ07HnK1oAVK+
	 QW4OAauNagmxm0a8ox+qOIKA6kv7jxjLnVADWPIVpuOeu/tgsuOODexUiEEgxeK+gjbMN
	 7ZTON/p9gndcStruU6nxiIl9+yeoAS+0Itr4Dwb2NMEo4J8nhdeLKHUy+vgaOrxpCeCER
	 +SjCWVGOjdb+SdHKPwaTd3ldbO+dFc9FbbiIi0A1lNoUSOGv1daSAMGdPqaynr11zlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RfQZfDis5QqkzDYiei6Mz9ZyeLEUJYlzCG7dpvUlVFY=;
	b=JWkjDcIOsuyvpeXMfk25n/pGuJbrCCjS9gvjrzn7pgpq5w+aPRxoTOc5aXl/CaocUN0i
	 Gdgy01FWp7SY0sArOJwks4l/28imA+dGpDnblwfGWZK4dtEhbhxLjatTQLODXsYpt6N2P
	 4VzdRW7XLwBI374jzHH9GSIH0jllk1iC1VW/c0R22EZU7RzmAwU4LwoJP6r6c9pO2n4DT
	 /HuGsgrOLDYM32SXC6HbvNe7+GBTS3VHKkkP0TLZUKZbE7DnQ2bjJHigo69wIn1/MEUL7
	 QtD9E5SEWurl92UkdABTjxkSHydVr/QFaycSvjfBpuHUHfznTrz8bR32zpVWE1k5ShQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/YoBbJP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22D6071874
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/YoBbJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A83B1F0089F;
	Tue, 10 Nov 2026 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273936;
	bh=RfQZfDis5QqkzDYiei6Mz9ZyeLEUJYlzCG7dpvUlVFY=;
	h=From:To:Cc:Subject:Date;
	b=M/YoBbJPaVyS2duHgusFi1+cX/aTTFVmu4hdXVtBsE7CogsA4CdDmdiOwfacoQcA0
	 CyPFlK5fn1zuYVEyxaREXDcuPm6KDpARHlJFzf4wWVHTXoa1cnnLQFVjnivW7zDSYC
	 HHTgoX7GYanhwNwNc+s9MWrFWI8nycpBAozsTq53jQsI71Kb7l+NJiBpHydTkPI9nH
	 +lMQ8R1MtdkPZNgl25jBvVj8o0Gx/nnpjfpUvysrN18FCSr6tVDZJhAm1EjNlkqwPm
	 vVCQk0L2ZvP5J+8MhXc1R9DagmTaY0qdIohQKqtRrzXQ7BkWXhAi1J/pfF2wOrom4W
	 2KEuD0Gj1OxcA==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending local client" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:34 -0500
Message-ID: <20261109202534-failed-5.10-cc2186d78547@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cc2186d7854785b30d423f5d43757b086b300e55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202534-failed-5.10-cc2186d78547@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




