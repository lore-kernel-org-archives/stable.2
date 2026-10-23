Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753305;
	b=Pkmetk+ptunrSGZw3vTtbLF3PJM+1KpxLoyt3Poh6ZzmxmNUZPPgWElSujs5/cPMAUYI
	 9c8NHCzH+0eFJCoJoh/39RHZ+bt8YPrT1fQnx66Tlt2V4qoT5zXNkgrcRVQm8/D2Bx8wh
	 bOm7d1wImE/V9HBGr07Vj12M6jiYh7UHvg8a+3+/kYkZm3cxyXP7LYs4UuWv64boAY8Xc
	 8B3ndRDjUuqYDrmstIQc6eBjTk8lERUbxcBIn6GvIx0bHmxQGQ8iqeyR+t9qCP8RvXYDJ
	 iAOHlzq24TfOvdnvJ+VR60Ur7yWkmEZ+xXrJg5nahekFAoiOI9FBM70/GzpwU2+0wow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753305;
	h=DMARC-Filter:From:To:Cc:Subject:Date:X-Clacks-Overhead:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9i1lMAauhdSb96bAn21amtKRcV/LL4J/0GNVxIc7VqM=;
	b=ih6d1wlqMUmIE3cYoZGp1LeMwC+s7mtGgaN/54H/zhWrGkgr1er2R4e+3yVuzLun0J9N
	 i7N47h3Tqc95YtG6X2ddpPbN/8hAvLyi1eN/Y8+bijWuWdhs+GX+BwErQ2vOCd6ZRYn2d
	 ZbWKUFv3CbrBHmI4MLl4rczmhBtwlG1mrWwT1RCZ8RmvSYTDbugeCx5CZTXNvo4RCo+pJ
	 +RWg4hNcW1D+dZbWRO6XruXSb2jnd+LoO9S3Z/pdDV5ifVPG8gjSP6jlz6CI1a03jek7C
	 pzTcuffKNjouiR3jZA7GnheWYdEHoVgwgpFur6jcI83S1eNKSzcZ0lsKadpEqQ/Bopw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDF606A323;
	Fri, 23 Oct 2026 11:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BDF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	stable@vger.kernel.org,
	Evan Severson <eseverson@gmail.com>
Subject: [PATCH] wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()
Date: Fri, 23 Oct 2026 13:00:51 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20261023110052.650519-1-toke@toke.dk>
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

The commit 592234e941f1 ("wifi: mac80211: Fix iTXQ AMPDU fragmentation
handling") changed the way handling of the IEEE80211_TX_CTL_AMPDU flag
is done in mac80211, so the only place it is set is in
ieee80211_tx_dequeue().

This means that any frames that are sent to the driver via drv_tx() will
no longer have the flag set. In particular, this affects packets going
through ieee80211_tx_pending(). Evan reported that this can result in
the ath9k driver failing to account such packets in its block ack
window, eventually overrunning the window and stalling TX.

Fix this by reinstating the flag in ieee80211_tx_prep_agg() when inside
a valid block ack window. This should be harmless for the TXQ path, and
will reinstate the previous behaviour for drivers that use the flag as a
signal to track the packet in the window.

Fixes: 592234e941f1 ("wifi: mac80211: Fix iTXQ AMPDU fragmentation handling")
Cc: stable@vger.kernel.org
Reported-by: Evan Severson <eseverson@gmail.com>
Link: https://lore.kernel.org/all/20261014025734.2288693-1-eseverson@gmail.com/
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e9b6a0415d6a..0f46b5ff0c4a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1164,6 +1164,7 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 	struct sk_buff *purge_skb = NULL;
 
 	if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
+		info->flags |= IEEE80211_TX_CTL_AMPDU;
 		reset_agg_timer = true;
 	} else if (test_bit(HT_AGG_STATE_WANT_START, &tid_tx->state)) {
 		/*
@@ -1195,6 +1196,7 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 		if (!tid_tx) {
 			/* do nothing, let packet pass through */
 		} else if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
+			info->flags |= IEEE80211_TX_CTL_AMPDU;
 			reset_agg_timer = true;
 		} else {
 			queued = true;
-- 
2.56.0

