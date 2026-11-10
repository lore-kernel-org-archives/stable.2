Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337384;
	b=z1qOUHzGGgn7TygreVc/ONTNqgH15yoXgQF2gkifmSaA2SVGds/tVTaSRarcgb7vR1BO
	 rjCcqy9VJWkOHuLy5oipfRp6f8pTUZ6DYJleNX3l8tuHfjn0fvZDXc1PCwv5JSK2ZEkqZ
	 ceCaT6oKikJGyceM6BM2eWLw0TjbFGJJi+3EQypz1aceVksgQOISr1LSlaGNpAi8oNvDm
	 9rxE69hma0oAmC3f1r0TG9kn5dAlREMSU4xi93hzf/XcXYR1VHnZoYnZinmhz/wu/PKEy
	 EZSfAsaFynWZgf+F7VMQUggKofWN6y7XxhWv6T7GHW+BYvEALTebgb7RU941AY9qQiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337384;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1g6N+UiSFWtJXbhcz2hQ0sX5BzMJnPPhFYk09G5Egyo=;
	b=eGK79XHArMTL7bSD10xBLhwHDVlGmDAVVCxmN75mKpCTSs++h9++9CJtm4Ly8Hz9qcFL
	 onhYCzXtkDY1sgispoczavyzh6V4pfpPl1wXf+fN+oWBKXPUjHRbpMivXeM5kZNhmBoht
	 Rcw58aZj1h89EyB5YxZhCIgkA1mofCqnCsStU8TdCu8Q2el/tBNW+oaT2Vh/EorrTisZ8
	 U2Jl4e28aPccpyJoeNX3Z+W04fAo5t50eQr9Lunag3RA4rwtQhAprYlbIEfwuHpv9W5Yg
	 wtIfNBhi+/W0W2Memhag2L8dJ145GMatI1iZaxq49lmkAeEmns+sYCTGDG99iqfmBDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=I46fDFJJ;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DE41A606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE41A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=I46fDFJJ
Received: by dvalin.narfation.org (Postfix) id 452151FD16;
	Tue, 10 Nov 2026 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794337382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1g6N+UiSFWtJXbhcz2hQ0sX5BzMJnPPhFYk09G5Egyo=;
	b=I46fDFJJoYistMokHcaIYaYR8A/ih7uHt3rdPLKUezz4/z48Bf36xfEj9Ro3jC81Oid8qM
	vydtbcZuAXP05QvHaiueBW2u0izNBUjyLqZC+zNQhjDN6oxewne3ImMFOILvv8SWmb69uN
	vk06QiPiQsdu5/xrXdW1v4otERmIroM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Tue, 10 Nov 2026 20:02:59 +0100
Message-ID: <20261110190259.111201-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200621-failed-6.12-cc2186d78547@kernel.org>
References: <20261109200621-failed-6.12-cc2186d78547@kernel.org>
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
index b4c98ac6d338d..c148127799c1b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -658,6 +658,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	int hash_added, table_size, packet_size_max;
 	bool ret = false;
 	bool roamed_back = false;
+	bool added = false;
 	u8 remote_flags;
 	u32 match_mark;
 
@@ -684,7 +685,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			goto add_event;
+			added = true;
 		}
 
 		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
@@ -765,10 +766,12 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
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

