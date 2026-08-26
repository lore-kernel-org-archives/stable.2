Received: from mail-qv2-f2.google.com (mail-qv2-f2.google.com [74.125.230.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAC3B6C05
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736226; cv=none; b=b+mLmxZZtFdJyqQztsIFpd9aBdYyEiUvJV95XTLvA7xgJMmD5fRXt5FMBBvzp6AkjyGsufQBoKHmTxkpFCf0uaG/QWkp08o/2PYFy42rGJJxkw+zW90Ol+oZ8v+IYNu2Qx3eJhPbnwKNC7hko4QqJ5qmWFxkvbM52o9/Rgd5Lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736226; c=relaxed/simple;
	bh=J5zNJQ3X4/N9a6M+pUzl/r33rH88D8R2hEMYOhygnB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLyKTHwOBlrlSlGZmO5qJhCgJlne0GAun6N2pJJFvD1AxJvXMZKkf+V3k7CljjlOITRHjQxnQKRY938dbUAJQ2Mk4c+oTxb0KwkNj6fSFpZN9b8mFRp3RNGcDmLlIrhsHXlDyrswJtpHKGYrDZkJqlHR6e979jfZ2HBWfuwf5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlXB1oXI; arc=none smtp.client-ip=74.125.230.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlXB1oXI"
Received: by mail-qv2-f2.google.com with SMTP id 6a1803df08f44-90c4d223e0bso3751226d6.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787736223; x=1788341023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLS2FTkBwTZO9cFIxC30lB3zfdCwRmbbW10fAQY6Wo8=;
        b=mlXB1oXIPYXbvUujLmUz61qITi1xf3hJUij42nHx8jN7O2dYnZa6ao2T2sdji6WaQb
         MuaNGIyXokHrORx9BUJJvuUp9/0oZ3M6oYJFrlsMhiZiGG1z2ZL4ChIi4kTkAgr3fHVJ
         DYCJ//miFlerQi7bIj83c7+wWy8OHJGc5wP3NwMixH0PIEqBYjisQb7jWNR+T3k1ZFTW
         IKnVGPGdVRhGuNGov/ojgoYSoAH/9266pzeYWwySYQbB2qJzroV8UJZlNCG/MDdhmPbt
         UZpQeQg5OZOeyT9iBlMNIJfkvyftGiWDz/murxiG2ucVs+gqRurHzseIYnn1APT5rKdX
         un+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787736223; x=1788341023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLS2FTkBwTZO9cFIxC30lB3zfdCwRmbbW10fAQY6Wo8=;
        b=GsWUsN1R3SboBGyTfFQvXzcIZoZvNYn/ZKZ1Qd3OkeKrQrKsidF3vZfuu0qvY4B/Ba
         JJhTNcRyT3/4vgf/JzncDMJB2eOmhWa8zzhOwT4aV+6nY93KFcZZwaHsXMS2JmyTQ3tV
         VOvjnNlhYv7EaDrBr+eiJM8oMwgf8n/nkyO2kRY47uZQdXQCaSyHZumuCUtHMWJTPTcV
         /9bvr4HBIgr06WXEYjayDyBxfuhgky+8bCiH0e8Owm+12zTCSKD9h1SF4snKxGfy2gKZ
         9HW7t1NkcGn0/k0XU9xjqqq+RqzOm7M+6Hsd8DpblgEnpzMMQual5TCD6eQX7g1tCKlz
         Rzdg==
X-Forwarded-Encrypted: i=1; AHgh+RpqIK0qubjpVL3RjmBTfjmUbN/kUbRfUD9tOzDnIDmBGZmBwh/l4bfZYDOGTS8HUW22AZ7XJB8=@vger.kernel.org
X-Gm-Message-State: AFuF++lZCHdWk/5CWHCBU5le+hFrZ6WMcWQNp/vlu82QmFj1Q6CIhP94
	6nTpZuwnyv/xYorCcEbv3/yk62c0zhXeIBtHLj/w06tJU3WFtXzdCcP3AZtprofiAEY=
X-Gm-Gg: AR+sD132aqraqrBkqkKeO9zqHIMr6BTyxbRV7A0fGlYE0LQIDACCmjL6Whg6Uo4HOlZ
	7tS9k2na05gJ5T9jA2GobLHtL2bpRUN23w182/eW9gJdO8uUnzBA46KEfwJixoO4neKnEpM5vLa
	ju8EstjaIOPIHE6FN13Ukv3Q9NN3Xy6nVaIQPjLpEqonENuVxW4uE46r4OLpev+1MeWQUAXay0D
	OtVY12DpnltEHtBO70iXieGlfTT5oB1aj/U93yICsjJV6Vegnbmqs4eegRd0FxJdviqMhFSGYRQ
	7jGGlLEPLlZ2qV6/DjM8vNPFxs8srC5ILZxhfS9HaBt6MZT47NOA8kP6dq2Up4YTv+99F2AUj2+
	ENlrFAU+WmHz0INfAo3EjA5wPM+X7fG41Qjr5kfQ5Y4C/aaJIWvTIvw8kWgAGWM4mipZzWyOsKk
	wT/V1bWlc59Qhws3wIo9Nu9/0zgvOgiPxmUOMhtBsUxoBeQAQZkBcE6Qt6iydoJAQqgwl/LgUvi
	li4D9QkHuteug==
X-Received: by 2002:a05:6214:4102:b0:90c:c39e:486 with SMTP id 6a1803df08f44-90cc7976c14mr43064136d6.31.1787736223075;
        Wed, 26 Aug 2026 02:23:43 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:39f:4500:5acb:2301:2b5a:c076])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc63e3108sm21248046d6.11.2026.08.26.02.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:23:42 -0700 (PDT)
From: Mark Anthony Agarro <markanthonyagarro@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Mark Anthony Agarro <markanthonyagarro@gmail.com>,
	rajeshkc-lx <rajeshkc-lx@users.noreply.github.com>,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH wireless] wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff
Date: Wed, 26 Aug 2026 05:23:31 -0400
Message-ID: <20260826092331.476016-1-markanthonyagarro@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt76x02_mac_process_tx_rate() extracts the rate index straight from
the hardware's raw TX-status word with no bounds check for the
HT/HT_GF/VHT cases, and mt76x02_mac_fill_tx_status() ignores its
return value. A stale or corrupt hardware index reaches mac80211's
minstrel_ht rate control, whose per-group rate array is a fixed 10
entries (MCS_GROUP_RATES), causing an out-of-bounds write.

Validate the index in mt76x02_mac_process_tx_rate() (HT: 0-31,
VHT: MCS nibble 0-9) and have mt76x02_mac_fill_tx_status() bail out
cleanly on failure instead of passing an invalid index through.

Fixes: 7c1f88812690 ("mt76: unify send_tx_status and related helpers")
Cc: stable@vger.kernel.org
Reported-by: rajeshkc-lx <rajeshkc-lx@users.noreply.github.com>
Closes: https://github.com/morrownr/mt76/issues/88
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Mark Anthony Agarro <markanthonyagarro@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 14ee5b3b9..d77356a2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -302,10 +302,22 @@ mt76x02_mac_process_tx_rate(struct ieee80211_tx_rate *txrate, u16 rate,
 		txrate->flags |= IEEE80211_TX_RC_GREEN_FIELD;
 		fallthrough;
 	case MT_PHY_TYPE_HT:
+		/* Raw hardware TX-status index is unvalidated; a stale or
+		 * corrupt value here overflows mac80211/minstrel_ht's
+		 * per-group rate array (MCS_GROUP_RATES == 10) and crashes.
+		 * Valid 802.11n MCS indices are 0-31 (four streams x 8).
+		 */
+		if (idx > 31)
+			return -EINVAL;
 		txrate->flags |= IEEE80211_TX_RC_MCS;
 		txrate->idx = idx;
 		break;
 	case MT_PHY_TYPE_VHT:
+		/* Same overflow risk for VHT: mac80211 expects the MCS
+		 * nibble (bits 3:0) in range 0-9, nss packed above it.
+		 */
+		if ((idx & 0xf) > 9)
+			return -EINVAL;
 		txrate->flags |= IEEE80211_TX_RC_VHT_MCS;
 		txrate->idx = idx;
 		break;
@@ -493,18 +505,21 @@ mt76x02_mac_fill_tx_status(struct mt76x02_dev *dev, struct mt76x02_sta *msta,
 		first_rate = st->rate & ~MT_PKTID_RATE;
 		first_rate |= st->pktid & MT_PKTID_RATE;
 
-		mt76x02_mac_process_tx_rate(&rate[0], first_rate,
-					    dev->mphy.chandef.chan->band);
+		if (mt76x02_mac_process_tx_rate(&rate[0], first_rate,
+						dev->mphy.chandef.chan->band))
+			return;
 	} else if (rate[0].idx < 0) {
 		if (!msta)
 			return;
 
-		mt76x02_mac_process_tx_rate(&rate[0], msta->wcid.tx_info,
-					    dev->mphy.chandef.chan->band);
+		if (mt76x02_mac_process_tx_rate(&rate[0], msta->wcid.tx_info,
+						dev->mphy.chandef.chan->band))
+			return;
 	}
 
-	mt76x02_mac_process_tx_rate(&last_rate, st->rate,
-				    dev->mphy.chandef.chan->band);
+	if (mt76x02_mac_process_tx_rate(&last_rate, st->rate,
+					dev->mphy.chandef.chan->band))
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(info->status.rates); i++) {
 		retry--;
-- 
2.47.3

