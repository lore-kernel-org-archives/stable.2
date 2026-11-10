Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339804;
	b=zQcs7cenbP/Uh90OddfSraWdbp8xL4DqBk5ps1wSRP5LUESQT2LOgy/i35kZRR+1frW5
	 FByiNixN+BK5ggdo40IQJb5XiNeQj5rQpxWKywtgjhB1vNYJ0+rB3LhMDwIUxrKQq778F
	 xcGYHQ9BdHLNZcD0hn/SlsByyRl4A3LT1tFOuAH+9sUI2aApxKIdSk9Aw9C94UZKMosPE
	 u5L/o7KC+FgS1nO7rXMsIfbT9ut4ASXMOQGlMEaMV2sbcsThttFlwycTRcOiBqmtlPHI5
	 vkhiAVGpENR/F4pyzDuV5PWm8vI4HgF/lzj1EKYouwNat/qpHMQTnkIRoDQ3FrFTjMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339804;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=14T4P81bk02MF3zNi39neaHy0dH1PzDOFSqiOavLIBk=;
	b=gdiqLzhGacQrTq2c27m7zxqjIIh8B9rTSjDWPhDK4AwMdFihLOyn4STBp2Suep6Nd4nY
	 +7+YpRPZ2KWK+PqO/wBi/lgAM08UkXv1emK7T8Gtl7n03ZfUIqP99RTCSGGfBh8JKXhmv
	 aE3PsIN8gsbj+32v/HoMVRIa9S6G+XmahTF6E85qD8ziKxJW4sDpo/WsYnhRGFy4i9upP
	 YsWNdaAmmVP8gJGRaJ5RC8Yl3aGAjqouDwpNKn50Tv4cq3QeWF7Cmzx7Vv9dVIgmPV+WG
	 6EYG3JWd2f5T3COWFr+KEDO1mbyYq4Z379iixh0jO5nmG7fOflGv1m1pKyDUKkg0WNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=tp41o3vp;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 48BF5606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48BF5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=tp41o3vp
Received: by dvalin.narfation.org (Postfix) id 6827320292;
	Tue, 10 Nov 2026 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14T4P81bk02MF3zNi39neaHy0dH1PzDOFSqiOavLIBk=;
	b=tp41o3vpIQcKRhMAAH2X5etbgxdRVdVAZYH2YWDHSkiLVJBO7tjBj4Eg8uxA94TrQKW/Zr
	bbJ/aFPueOY2STfm02ew5rlCrBevu0ecyJlMC/whUslQhFPxZP915PXBF6MjiPbUKTsakW
	7OJePThFAga31HbbaU3zoWWyBBL4v7Q=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Tue, 10 Nov 2026 20:43:19 +0100
Message-ID: <20261110194319.328801-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202028-failed-5.15-cc2186d78547@kernel.org>
References: <20261109202028-failed-5.15-cc2186d78547@kernel.org>
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
index a6c92a34b999b..300e3f9b60200 100644
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

