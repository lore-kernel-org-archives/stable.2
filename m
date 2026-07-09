Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2040963A
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591686; cv=none; b=M8wIsYdV+LPbjLP2YkpAS27okY3Y2LaPwLo2cykuFc4PxwyB76TrpJ1T5gnV8gacjA6ng37LoZbokU3xlfPnJT2zDH/WeGJ9JvNn9p4VfNkzFvlZNBxRlcsZ5ELySDMseK0lceifDVhSDCHD41dJb8VlxN6WBbk5Pp4P1ot21qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591686; c=relaxed/simple;
	bh=UxU+JME5ebASSmQr4qIUB2ld2xMnnpTyCKBpBPioAwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqflDsM+vZJJ8qStJwNJjQJGzE4IzOazkK20KgtPMEfbjw2fOKVxXUR3rj5OSJ7o1N4f67E0Vbhc7Re126kIGE9lljK2cTVTL86g7+ZOTr03Pn0kdy4nWIl36HOpYt0bQllyOxxnrAZwcmmc4UZTqb4TpTa7d+YhXsdhP0LI2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=nfyhnOVG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="nfyhnOVG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so863729f8f.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783591683; x=1784196483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JbLxmjVDkQJsUyY2A+uFCQIi3MH0ZYtgFX/E0Ge6oo=;
        b=nfyhnOVGMPkEP9wTcYLV3irZJCg/XZrGJ3i94G3fnHK4843PUlLi09afkOQHd6wH9V
         ZQYFD2+jQWP+g38JHuNgfHzUUvwTWZgYJ9aMLmo61bIq2zHNNMGfbQN5L2zEf2wZV6FG
         BbzoAMMzm17nUAjCwvl85l4Ghd0JppU9bXHgJ/1ZhHRGcU0l7jIAaXGs00WEOWkqeiW8
         nvAdxQFA8BM+35p5nZo8bYLC7cgl38bUo7O2WVegF2uR9GbfxFzcQnMbs8Ew6VEHHAEM
         Qo6DJ+JcZTRYkkoo72GyaZ8giIZXIiuAvTpb7RrOY10cGyKHd7ejfP1HdpVISMqUhTZh
         mX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591683; x=1784196483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JbLxmjVDkQJsUyY2A+uFCQIi3MH0ZYtgFX/E0Ge6oo=;
        b=ayKLqSsir6LCZMe9q1DMATu1ODGqCEfhTOtzZfilCUnZzYnSR3zsnZLFCTXuVIId6/
         spjBAUy8xJD1lWXghJ+JRX8DGBCyB2gsfgNK0jQhUMmSxjK/gODboOqHusZ8Z26EAHUp
         L+OgvqelQgvKYMl8TTYR1G2Xtx6j/sPOeLqDAGVWTcXBSbSQ71Pwx08QEQ+6GFFae34t
         2caD0l4nIvrJDJa9HSInoUSmfPqIZToWteNTAHxRsgieYdjpneVsmslYL6NdEzWRWHHv
         rJoPY1lypbI9F7DSPZLqJMd2djIhEEeoRuM7AqAqe55PMPsE7kvG1CCUwTpAxB+xkIsQ
         C3OA==
X-Forwarded-Encrypted: i=1; AHgh+RoF/9t1NPK3KZq5QAsYGlGvU8ZnnNDDEAW+6E5/3egFI/5hbhvBwnOU1s1gOrp7NUwUa7Z3eC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OKTQE0uwfO5mAYxCOxuhuUEIyLXGHHA5oFYimEclXLUmgvlo
	bc/L8Z1fEaaO9KytgU63eEW6g0WmtZJ2kjNczK9zRbEI/zzyPmBbGXeGsvo74bEjmN7Kn26y5k+
	ri1aqHaf6
X-Gm-Gg: AfdE7cmnC1ox+KTn7MvdfjOVJXT8SW2y27L1tycaSszja0R42NxObTGc5hnWDSUoVal
	7C3fduEH18C2POZuAPAbGT+hEHEnZAirjSTHVwQVKtAFvS5D3ikCTe5J5BMcnsWqNdcWh220s6C
	PvPvBZN+Id4D69w2xz8SJU0cweno/xwtABmhLFbEVyV6IovXUMFX9DkxGEH88HbARsoPHZ12xeN
	8d1nmZemfwUGuL4PMXix7UIPeqqy4ICqLsqaiMOR7UEqLulWiHLqLbvVbybcEYus+2bHS9/cx+z
	RJN98TJEax2///ZkR68O+YpCdBkf4XkTncThxXAZdbi0/HgAstRpjGjZujYPr/1wiHiR+IBcinS
	ihCd7wi0GzOZOfwH+piZUwfctO/ukuNhWDE1N8cRktYUA/Dm3T0db3z0Lw60c0Bf+4Vkf36ea5S
	M4/49I1hHU6OaaXMJ3vwBYT2ttowmiDfxq33q5MVetZSwi5xGF2lH3CdjINr/3cnTmnxERN8ocR
	H9G3MmxZvi88xLBVaha09GYyVKrT0jAGFK2AV73GhFkUA==
X-Received: by 2002:a05:6000:610:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-47df073825emr6758798f8f.0.1783591682589;
        Thu, 09 Jul 2026 03:08:02 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm53768227f8f.1.2026.07.09.03.08.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 03:08:02 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Thu,  9 Jul 2026 12:08:00 +0200
Message-ID: <20260709100800.7026-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_update_bss_desc_with_ie() records raw pointers to the HT
Capabilities, HT Operation, VHT Capabilities, VHT Operation, 20/40 BSS
Coexistence and Operating Mode Notification elements taken straight out
of a beacon/probe-response buffer, without checking that each element is
long enough for the fixed-size structure that later consumers read. The
buffer is a tight kmemdup() of the on-air IEs (beacon_buf_size ==
ies->len), so a truncated element placed last leaves the stored pointer
one past the end of the allocation.

At association time these pointers are dereferenced at fixed offsets
regardless of the on-air length: mwifiex_cmd_append_11n_tlv() memcpy()s
sizeof(struct ieee80211_ht_cap) (26 bytes) from bcn_ht_cap and reads
bcn_ht_oper->ht_param, and mwifiex_cmd_append_11ac_tlv() memcpy()s
sizeof(struct ieee80211_vht_cap) (12 bytes) from bcn_vht_cap and reads
bcn_vht_oper->chan_width. A nearby AP (rogue / evil-twin; an open SSID
needs no credentials) advertising a BSS with a truncated HT/VHT cap
element therefore triggers a slab out-of-bounds read on the victim's
association attempt. This out-of-bounds read is the primary issue.

For the HT-Cap copy the over-read bytes are additionally placed into the
outgoing association request, so a limited amount of adjacent heap memory
can leak over the air. In station mode this is small (single-digit
bytes), because mwifiex_fill_cap_info() rewrites most of the copied
HT-Cap before transmission; the leak is a secondary effect.

mwifiex_set_sta_ht_cap() has the same missing-length pattern: in uAP mode
it reads two bytes of ieee80211_ht_cap.cap_info from a
cfg80211_find_ie(WLAN_EID_HT_CAPABILITY) result in a client association
request without checking the element length, a 1-2 byte out-of-bounds
read (used only to select an A-MSDU size, not leaked).

Reject (skip) any of these elements whose payload is shorter than the
structure the driver later reads, matching the length validation the
FH/DS/CF/IBSS parameter-set cases in the same beacon parser already
perform.

No dynamic reproducer: mwifiex is a fullmac driver for Marvell hardware
with no mac80211_hwsim equivalent, so this was confirmed by source and
structure-offset analysis only.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..997e7e19525b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1384,6 +1384,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 							bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_CAPABILITY:
+			if (element_len < sizeof(struct ieee80211_ht_cap))
+				break;
 			bss_entry->bcn_ht_cap = (struct ieee80211_ht_cap *)
 					(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1392,6 +1394,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_OPERATION:
+			if (element_len < sizeof(struct ieee80211_ht_operation))
+				break;
 			bss_entry->bcn_ht_oper =
 				(struct ieee80211_ht_operation *)(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1400,6 +1404,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
+			if (element_len < sizeof(struct ieee80211_vht_cap))
+				break;
 			bss_entry->disable_11ac = false;
 			bss_entry->bcn_vht_cap =
 				(void *)(current_ptr +
@@ -1409,6 +1415,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_OPERATION:
+			if (element_len < sizeof(struct ieee80211_vht_operation))
+				break;
 			bss_entry->bcn_vht_oper =
 				(void *)(current_ptr +
 					 sizeof(struct ieee_types_header));
@@ -1417,6 +1425,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_BSS_COEX_2040:
+			if (!element_len)
+				break;
 			bss_entry->bcn_bss_co_2040 = current_ptr;
 			bss_entry->bss_co_2040_offset =
 				(u16) (current_ptr - bss_entry->beacon_buf);
@@ -1427,6 +1437,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 				(u16) (current_ptr - bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
+			if (!element_len)
+				break;
 			bss_entry->oper_mode = (void *)current_ptr;
 			bss_entry->oper_mode_offset =
 					(u16)((u8 *)bss_entry->oper_mode -
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d21223..844223c04e2e 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -721,7 +721,7 @@ mwifiex_set_sta_ht_cap(struct mwifiex_private *priv, const u8 *ies,
 
 	ht_cap_ie = (void *)cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies,
 					     ies_len);
-	if (ht_cap_ie) {
+	if (ht_cap_ie && ht_cap_ie->len >= sizeof(struct ieee80211_ht_cap)) {
 		ht_cap = (void *)(ht_cap_ie + 1);
 		node->is_11n_enabled = 1;
 		node->max_amsdu = le16_to_cpu(ht_cap->cap_info) &
-- 
2.43.0

