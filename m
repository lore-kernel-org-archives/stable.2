Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273309;
	b=pnnIvxZCbDAUNsBqfQjrt79FR26BBhv+Na1L9EmKcf9Iz+phhzkPzCPXAEDaqLSV0lbO
	 V5Fe+A3xDdRplKLsYnG3C0zdYqXRe7RsQ/bcgTYa79sMzMFBuU92yHIxhH1flCxrUea7X
	 q9ogPQO6UuHpb++oJRXc8k1aC2wiZsgAOdi7WsexvutvcFpjIkT5/kr3MrAasfKFzZL8o
	 2cNmoSzV42xTWDej44q21IF1Zr5aB0vuZeMiHYuxuDJoPwzkw073ymjAMkdNtn5UJNSN9
	 w2TFe9xw8rWoc5z995pMotuzjik4/xV7NRcF+gh+y4g3nqaFGQYvWHb7FZSlDaheqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273309;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XXfpvfc0B7VIrzUB7E/ZibBdy/oc3t8ktG94jYr9cTQ=;
	b=md02NGsvBzDNfftrsQMeTqMSrpipMwDppN3SY4Nd0QjEpsSJCjn/uD/oRw4sNsnGAoFW
	 CZC3dQ4gQaWSKlTWYJIePtP9+pwMMkHhKlDjozO6U2TvHTmaFMoxKwNvTYo4UiGkUispU
	 OcqNCH58juNMx9951zwsZBzYLNUAYVddcqBAUK5Gu/az1lAxTYCa2whEr5WXcFus/fSDu
	 wtvCD8Zc8ykTO7a/USrsYKg8Mpm1rBrtlOaKeJfOwW3IvqTLl9se76Ux/lqfIeNy/+l2p
	 aS67a2utgDbOpdqRwvUaTDJD7v1M5CYUBjqVZJyG1e4lyeyvldDqtGh1BIIA4KaBZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuUUGI6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA9606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuUUGI6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F071F0089F;
	Tue, 10 Nov 2026 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273308;
	bh=XXfpvfc0B7VIrzUB7E/ZibBdy/oc3t8ktG94jYr9cTQ=;
	h=From:To:Cc:Subject:Date;
	b=MuUUGI6sfU3gMXH9HRjR9aVd5/d/rzJie4OGWCzkhGm3DKvKpWp50nHNIuy0bjx/+
	 6j9jnpAKJhk6XfCRBKgMAlv75VErIzsjxo5dv8R97QocqdZdkyR6uEr9vJpAeMdcEq
	 Ouru6EnJ2MGc9LoYIA8yaBx5pMccFgUuzWO6/88X39shLj123ohrvmXAHgXJNLS97H
	 F1iBDDwLTnzLs4Fh/2VQyyBFRvwEwdbo4aeLpLgmj2aIrcscNznNUHZSbSn5y+tQQd
	 L90e79srjJxI0OxMKzWP1WzdMiSU+xz8L/LZtShTlceD/bwx3Z/LEcmJrLmJEiMyFk
	 PVJ5LUghLMSxg==
From: Sasha Levin <sashal@kernel.org>
To: toke@toke.dk,
	eseverson@gmail.com,
	johannes.berg@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:06 -0500
Message-ID: <20261109201506-failed-6.1-25e73f1d6868@kernel.org>
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
git cherry-pick -x 25e73f1d6868c759c8eb56cad4e411692c5341b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201506-failed-6.1-25e73f1d6868@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 25e73f1d6868c759c8eb56cad4e411692c5341b4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Fri, 23 Oct 2026 13:00:51 +0200
Subject: [PATCH] wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in
 ieee80211_tx_prep_agg()
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
Tested-by: Evan Severson <eseverson@gmail.com>
Link: https://patch.msgid.link/20261023110052.650519-1-toke@toke.dk
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d51f810dd2c5b..32f94761cf322 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1118,6 +1118,7 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 	struct sk_buff *purge_skb = NULL;
 
 	if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
+		info->flags |= IEEE80211_TX_CTL_AMPDU;
 		reset_agg_timer = true;
 	} else if (test_bit(HT_AGG_STATE_WANT_START, &tid_tx->state)) {
 		/*
@@ -1149,6 +1150,7 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 		if (!tid_tx) {
 			/* do nothing, let packet pass through */
 		} else if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
+			info->flags |= IEEE80211_TX_CTL_AMPDU;
 			reset_agg_timer = true;
 		} else {
 			queued = true;
-- 
2.53.0




