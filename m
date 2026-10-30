Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368285;
	b=jJf/PewtcsR8wkovS7FWQYrLZdYR7zchUpUigbUOKIqLBKTCkWUfL3yvtV1tNqT37Bb2
	 od09yrzVsyeRq2MVXfSytRRnuqZZXrcxw0N3xMn+E+fxYJ6CncgHVoB8IW5T71VZz4ex2
	 LHbkHUgJg8LCEN3eIY51TPjtx9wiGbbMd0qkl8gFbHtU3U3cZtgC6pzBWWHQIFscH8yGe
	 bRpmsM0TKfGiXi2K5jKXnFm7nNaKgLQ/50OJIl9hEJ6tfVxWs97DliiCyDvrYxRvkhDJ7
	 wgLgqJKB/KAJ1PrBIwHm+fTgvdCZHY+og6igNDufbWniGEFDsk0kV7Dd3MlA7Y8MkMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368285;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Sdas4EDEWHsgNZKpqDTz51HIwTHhqSyCgWVHRMM+/8=;
	b=UA/ovLDhL8Zv5vHYREssWpXo3Ud7JuQqyjCIkobUkd4QDMSD/UCblzWuYw6Fohxu2bYA
	 N5qFEaOkl5Hydayrwy/c7qlWPsViqSKvbzAx7UhpYSEigeIuYzZ4E6BV74ElBCyiBh3vh
	 pYFT4/cwVNGORL/gN5lu8iV7eG5hKUijRabCk9qZnWwsLMGsjuvwoLyDWmb3PR4FRwbod
	 Z7yzhLYjMf0bk0iohFn5sU2wvHeXCDiiLesDNUDKezNNqHR3+1OoxTCe2TLWUCWkDrb7a
	 1sjGbdwCW2KR9HQhppdEstku9JZrDjxtUbTjfxKRRzbInchmrPbpDGIJr6ttNrwv/8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b="Wk11/76Z";
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 81C8F606A32C;
	Fri, 30 Oct 2026 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C8F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=Wk11/76Z
Received: from kero.packetmixer.de (p200300c597124FD839580C360D3ed6f6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 3842FFA273;
	Fri, 30 Oct 2026 14:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Sdas4EDEWHsgNZKpqDTz51HIwTHhqSyCgWVHRMM+/8=;
	b=Wk11/76ZRA7BdAZGziY5W0a3IxsEs6b1Xi6FULgiN5ssnc5WryR3K2zLeQImYeJamPYrbY
	BIrd2LZZNE41jtr+3yfOz17UNpuB5e+OZBshy1uvWpNNqIEEXD2T7B7eb1z6AjfjCE2abY
	bIplPYB9oyxIlZwh+chJMcHKEcbCrO0j4pQjv51LjmLGiK0jAZGJBQDupI50hJuequHsXL
	KFPSSbltgNOezryeUEpHKLTCRrkILa+8XU7h0S5d9WqB/niEAok5f8/aKQ5yX8WCMPjAti
	PF7pgWK6gqGNKdDVG11BLJwe0eEunGB+4MntETvB/RiROjyQNAe4/LuloxvCfg==
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
Subject: [PATCH net 09/14] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Fri, 30 Oct 2026 14:51:00 +0100
Message-ID: <20261030135105.2555887-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
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
2.47.3

