Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.165.235.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666629;
	b=gxRp06tBRp41jXtBnL86a1fFtD+tCJumMoXbli8JlCD4yIWpfByuDPlMZ0Lq9ZgOG767
	 PrZsnFLV3U8RoIbSAuSDmVfOjRFdKkMWrg9h0NY+YYvQBlD4mkYh2OPEiSrJDSFNlQ0yy
	 Ez0U3Ufa7G4E7KNZ0nneI1+fvB/Ii6e7w/e+Kd16YGu9vQCOKg3tEwgNJSkDd3uXhOK9L
	 rSTwo8wy8WEAZ9EANalwiCc6xPkcOiS+tUCG/ledP2+ev95IJR5OlYnzthOETbeSb3xec
	 3VyoGCKBuHaFdhetkIoE7uDT13rGK0NeqKXU7Jkd4WD1TP4aRdXgurkR9SMTiRY7voA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666629;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iMNt/RUGjBwSgCLaiXUfJ1ikj3Mi+NCwd7oG4jHQ++0=;
	b=sngIT/ThuiiSa1pmBsHpOBxacgPaeD1YgX/aHTbovFrqptYTssobRW1pQQBizr4fk5oB
	 6DNy/uIS+XykzsMuNdk8O+2lGCO92pHYuB0p8IwGWvYpPG+K9JkcCnUHfyaTk9LQrpT6j
	 2kDjjWz4iY4TUS1F2tDAgg/GKL4XA8pg6MNT7rQj19Ql8pVYrFLRI9zoQ/QeyafdGOSZG
	 p0whV1UrdWz3IdN9MuFugq/gQ+BbNFkGSGIEIOHhB63oYoHP4V3J1tKPSGJWhmxKubJfT
	 VkpghPRnQKGeAOFtbCiRr6KPxIDjn9fdTxp0AkxiaMWOTXHABcdoPXfsytCQCMzXmYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mutemail.de;
	spf=pass smtp.mailfrom=mutemail.de;
	dkim=pass header.d=mutemail.de header.i=@mutemail.de header.a=rsa-sha256 header.s=2024 header.b="z/caezjQ";
	arc=none smtp.remote-ip=188.165.235.121
Received: from mail.mutemail.de (mail.mutemail.de [188.165.235.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010EF606A320;
	Thu, 22 Oct 2026 10:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 010EF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mutemail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mutemail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mutemail.de header.i=@mutemail.de header.a=rsa-sha256 header.s=2024 header.b=z/caezjQ
From: "Felix K." <fk@mutemail.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mutemail.de; s=2024;
	t=1792666626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iMNt/RUGjBwSgCLaiXUfJ1ikj3Mi+NCwd7oG4jHQ++0=;
	b=z/caezjQKNRWgTrYZUJv8kK+miLlaq5bZY1iK5OppMy4TADvhj3JM2Bn6w5I0IFrCOd3Ud
	ALk8ARkp9fHMCCvrvRiwbvlLU60fPGRiRldrjnetSRxw44oQ/5Zb8TlVky3PXKMOH8PZcX
	rjadhPFRDxvzPIRMqH1w4pxBEFjQqEQHPEeMUwl3/q7U80Phk3HFEBd/9ClNvsXZ8t440D
	7oUn51v7ukUu48Qucxt0kROzVZgxQwrx+DZp0C7gBUVzuKmq3AUSRQhOrGTFF2dZ+8ll/D
	ggn1hOf5eC7KnWH0ZWklz8npQZov9+a+DBOA7q+an/TuoSbqLQUnAfHu7bwNeg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=fk@mutemail.de smtp.mailfrom=fk@mutemail.de
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	"Felix K." <fk@mutemail.de>,
	stable@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath9k_htc: fix beacon slot selection once TSF exceeds 2^42 us
Date: Thu, 22 Oct 2026 12:56:56 +0200
Message-ID: <20261022105656.4175421-1-fk@mutemail.de>
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

ath9k_htc_choose_bslot() derives the beacon slot from the TSF reported
in the SWBA event as

	tsftu = TSF_TO_TU(tsf >> 32, tsf);
	slot = ((tsftu % intval) * ATH9K_HTC_MAX_BCN_VIF) / intval;

TSF_TO_TU() truncates its result to 32 bits, so tsftu is
(tsf / 1024) mod 2^32 and wraps every 2^42 us (~50.9 days). 2^32 is not
a multiple of the beacon interval (2^32 mod 100 = 96 for the default
of 100 TU), so every wrap shifts the computed position within the
beacon interval by 4 TU. Depending on where in the interval the SWBA
event arrives, the wrong slot is chosen after one or more wraps. The
state only recovers when the TSF is reset.

Compute the offset within the beacon interval from the 64-bit TSF
instead. For TSF values below 2^42 us and an even beacon interval the
result is identical to the old calculation. TSF_TO_TU() in htc.h has no
other user and is removed.

This is the same issue as in ath9k_beacon_choose_slot(), which is fixed
separately. Compile tested only, I do not have ath9k_htc hardware.

Fixes: 832f6a18fc2a ("ath9k_htc: Add beacon slots")
Cc: stable@vger.kernel.org
Signed-off-by: Felix K. <fk@mutemail.de>
---
 drivers/net/wireless/ath/ath9k/htc.h            |  2 --
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 4d2b75d02..59e0b3cf7 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -39,8 +39,6 @@
 #define ATH_RESTART_CALINTERVAL   1200000 /* 20 minutes */
 
 #define ATH_DEFAULT_BMISS_LIMIT 10
-#define TSF_TO_TU(_h, _l) \
-	((((u32)(_h)) << 22) | (((u32)(_l)) >> 10))
 
 extern struct ieee80211_ops ath9k_htc_ops;
 extern int htc_modparam_nohwcrypt;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index 81fa7cbad..b478af150 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -266,20 +266,20 @@ static int ath9k_htc_choose_bslot(struct ath9k_htc_priv *priv,
 {
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	u64 tsf;
-	u32 tsftu;
+	u32 offset;
 	u16 intval;
 	int slot;
 
 	intval = priv->cur_beacon_conf.beacon_interval;
 
 	tsf = be64_to_cpu(swba->tsf);
-	tsftu = TSF_TO_TU(tsf >> 32, tsf);
-	slot = ((tsftu % intval) * ATH9K_HTC_MAX_BCN_VIF) / intval;
+	div_u64_rem(tsf, TU_TO_USEC(intval), &offset);
+	slot = (offset * ATH9K_HTC_MAX_BCN_VIF) / TU_TO_USEC(intval);
 	slot = ATH9K_HTC_MAX_BCN_VIF - slot - 1;
 
 	ath_dbg(common, BEACON,
-		"Choose slot: %d, tsf: %llu, tsftu: %u, intval: %u\n",
-		slot, tsf, tsftu, intval);
+		"Choose slot: %d, tsf: %llu, offset: %u, intval: %u\n",
+		slot, tsf, offset, intval);
 
 	return slot;
 }
-- 
2.53.0

