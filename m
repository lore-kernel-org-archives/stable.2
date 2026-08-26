Received: from mail-qk2-f0.google.com (mail-qk2-f0.google.com [74.125.230.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68973C0A1B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736489; cv=none; b=BH0VW/NswXrNnWI4DD3oQ52lUnA/88Sb3oH+qJIeN69gy/v6XeMkml4lZ9FykZneKellNzkPQ0QVrk/qrAlE1ZapfK6orvp5I/aE+b9O2QeTcAr51NsdUGLG22Fybdi+9G8jc+o0jVYhd9lTK5FBDF3qsxM+32PuecyjTQIK9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736489; c=relaxed/simple;
	bh=Hv7+Y9dHESTSaxHnfqqTK4NCvljMduEQjgsI3qTkahQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CC7aDzVQ+G6KyDNoKAVxJb/PiCLgvdYWOXoXV8vniZq40CTCAdt4trMT+Ejq9+t6Tiaqkk7I+gUEQCaMAaqNn8bloPc47y/2Kny96WvGvb+RJrpDVerLsqsaLAkQriEOxu4Qwtg1SXiPpngZ0fBdmNenSBJDxIY/whLY5pi4lOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ6buCXR; arc=none smtp.client-ip=74.125.230.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ6buCXR"
Received: by mail-qk2-f0.google.com with SMTP id af79cd13be357-9371529ed6cso16710885a.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787736485; x=1788341285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLln/nzEL/lmZp8E8NEYYdhaUC5D7iZndLYefw4Q5CU=;
        b=QQ6buCXRA5+hpQnX7RTql7lkgNGgM/evAvzcML/xujJ0HQCdOwpP39axbkBy9dvnGP
         +jG4cz8hcOlWsv3cJWA/QFvygkWstK03yLaCh6Ews0lKTGJGv3rcCLocQVNBV2SziZsX
         gNV7HgkBXuTLN7KJHAXMDi7oOrSiZEMmerwN7M0JGGHWWEBkDgczUNVh/ZarSF1QJsa/
         300gd+vMCmcMcl5Kipx96bAKZOf4oDwvzdcaS7Yllom6TGhUdmU9CTq5bJUgiNFRsre4
         aT8D4JtW47uiUo9TskyY5RZynZIhODjk+3qTMP6wvHExsj7KbXmLVKI14WLMWf8nj5Os
         ss1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787736485; x=1788341285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLln/nzEL/lmZp8E8NEYYdhaUC5D7iZndLYefw4Q5CU=;
        b=RUuJP9etHavGsC+UQktIJNeKUhlEo/wkdEUKgp0cVJWjisiBF2erPW6mDY64ynerDl
         iHrjXSED3CaOoULkshV+mc8eXCwhBqc2DHjF3wUAVETnRkDXrC//n1MYjrNUl1TQCBIR
         ClDwyby/uqpmMzdEa1/Fjwbe3HMTIZWesq20TvVZbfCLdMVgy5r0euG2676tYoMZF7EW
         F6i4uknIl8bhQv7vuq3MIzYtjcVOvZ7sQeE5rUknCeA6yNaUj9egBVZO0DafsdbnrcxI
         opAOuq561lt2AJRC+iKgywrug1aMkSdgj42p7leXw+ViFPHC69eJGSJOvtbeRWJn8EWH
         ZLGg==
X-Forwarded-Encrypted: i=1; AHgh+RrS9hGcTtTlCAwGBna02SgvpEqT5c4r5XbSMs2pEGB0pT6sAYQORMelzw+hxIdHlJPmcJIboII=@vger.kernel.org
X-Gm-Message-State: AFuF++nieC6qAM/EGM1jVySgVGi+Sh849wFhM/etF/3794n5Fr2XRcFC
	Sj+GZsqx22xAEhh2QIgBLYRZyVGjWaHr1pqj4SX/kja960bgDnsUH32W
X-Gm-Gg: AR+sD12HoVtX3s0xktXhmWqmStIRbW4pUnkFDWsPNKf4SqdPybc/CUUbD2fwqO8mvHM
	jw2NsOHaCoEAZtsgWAoooIkTqh9OxtKENcY+Q5lZ9ijKJnKGDpqNlAfMYogVj2+ACZ1Db/zsV6Y
	ztxz8F0Fu3xHE6uHYtddWMI9jL68eS1W3FhoQWvfOC2ZWRO7SA5d7VTro/kZC/bJ6mB6A6EAWq/
	xXcB6rC5T2Y4v4gfQ8RxKAd5Xek1NQ/oBTGUmicTigY7bmcax0Ne7KY71KBFaWCB46cxziwmb5/
	O9fxSJkyJ3nLCBLpEkV+JhJ2c+lBeXbNoStdx9VUAyCYHeOc2ULVzrRO9fRxb/xfWqzhAq+0Ke8
	OnWGxTkcUT16HaedC7KRQjuXQch6y2ss3jj8liW55PD8H3GpssBiNrJeBHkFv27FVEd8XsAH04z
	XHr7hze1C/huncun7nxKp2mnOhwb4pepn7WET+am157S0lT/qQxTAAEvKNQ7VNh1GDRVHP0e5+v
	N51OGlDQE+pKg==
X-Received: by 2002:a05:620a:99c:b0:937:2aca:4d58 with SMTP id af79cd13be357-937803e5454mr340157585a.24.1787736485479;
        Wed, 26 Aug 2026 02:28:05 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:39f:4500:5acb:2301:2b5a:c076])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e34b9cfsm170522085a.13.2026.08.26.02.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:28:05 -0700 (PDT)
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
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH wireless v2] wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff
Date: Wed, 26 Aug 2026 05:27:55 -0400
Message-ID: <20260826092755.480190-1-markanthonyagarro@gmail.com>
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
Closes: https://github.com/morrownr/mt76/issues/88
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Mark Anthony Agarro <markanthonyagarro@gmail.com>
---
v2: Drop the Reported-by tag. It named an invented
    users.noreply.github.com address for the reporter that isn't a
    real, deliverable mailbox (v1's Cc bounced with NXDOMAIN on that
    domain). Closes: already credits and links the original report;
    no functional change.

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

