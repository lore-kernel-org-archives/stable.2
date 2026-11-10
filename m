Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273630;
	b=S3UHlZP9f0HhGSqmXz4Npx+5AjBUVnnmO7CgmePyA3l9RL4m4AYY4ZLxFs5oxsVvNBoW
	 /IsRbbDYkD8PrKyJbpg290ikJYSJnbGWRkWcOIRupiSJQMVi0b+63Jn1PIZmRAxmcyZ7/
	 n26nS+uLxWNJDBTSOlB59d3JfgqRqRTpc2VtxyQxQazape/Mtuv93xPrXnKZ4FOjJAipB
	 o1CSWcut+9ruglZ4RGiAXzbyj9sfCdHyXd2gI02z55R9yrLB8tPTfKAYuAAI/wZ18dSo4
	 mZTR2ivDZE101MVDG0xTWcLyC+z3LPqjdpDh8x8Owy1JXeOgWnU4OxxR5Pt2E6gd87A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=apAKxY4tz35SGNIsDu165gKeZxHZ8UOKxpzScCFCib0=;
	b=Y7qTm0Zt9jgf4QYUIC86Aflsa/kRrz9MIluDbO2P/Tdn38sEmxaZ8CRq4LjBZ+9Efo1c
	 WvGjooy+JjnHgnmOGhpipyROhtF6Uca6PqtdoFd+WcNaUnXY0W16V0tzC5fr+lF1mxZQr
	 ucXfhu/GpUe2dbLs727fz473dKDdH2vMCkMl+lz+nggwjPNW+qDQtI93+aJepEPvN69vw
	 Ir5xlMHKcoZf5ziXFuT67hOIW70SiZzcH8oZPEzMiltssY7SI+BHo0tVphF3oI3lk7ugX
	 rji6Wd+Bhv2H0IoErD3CVaRkBlSWU6H7TQphgHuiJjwHY67YvunEXPTF/Zewq3zHWJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOat8+TF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C548606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOat8+TF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E52C1F0089F;
	Tue, 10 Nov 2026 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273629;
	bh=apAKxY4tz35SGNIsDu165gKeZxHZ8UOKxpzScCFCib0=;
	h=From:To:Cc:Subject:Date;
	b=mOat8+TFyp01PDeKhTPbCil9kIB+wnwqrWsg7tOyKi9RH3qNIT5jZ5bxRG4YVR0VH
	 QO/uqn7eOIlHZhs2GhWiw8kxNPGctx9p++i3rn+etaTdPUNcMqlmN/DPq4WOM4odmV
	 GxY7cSyyoS5Yr+p+zk3boRpG/JmCcrGLxDNQ3XdMd5pz9EusidiHM8IwoUwPo98k1g
	 hwZKFUcaA8l1eUFkDjgcKcHK179Ho/lQ+LGXTK3xZfAF1XnuLYUieGjwuHBBkflaag
	 R4zq785a/YTqpQG/as84No+G0BzkUv8V/+BmzIGQmNp81QKbSI3RvBkt6qk+e9Pbwn
	 EeV+LC2qWviTQ==
From: Sasha Levin <sashal@kernel.org>
To: sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: tt: clear ROAM flag when re-adding a pending local client" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:28 -0500
Message-ID: <20261109202028-failed-5.15-cc2186d78547@kernel.org>
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
git cherry-pick -x cc2186d7854785b30d423f5d43757b086b300e55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202028-failed-5.15-cc2186d78547@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




