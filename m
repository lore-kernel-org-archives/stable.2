Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882D2931C0
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674672; cv=none; b=b8U953JecT6OMdTeWzPuJMkIy0+5CPwiLVpjCsyiSQdLFH8YKMejesy38/uFtl+LeDsM0FoRqf+82GUOzXY7fgGqTBwQB2YKTco9wD2pLS9TXZ3eMaCdm0RUUBGN79phKXOrM3C3GFpuQZ3kXcr3bYTa1kfs7CfvG3KuD9WLFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674672; c=relaxed/simple;
	bh=KTp17qIt41gJlDmPq9Al+TQldVqlBDxxKy25x9nCcos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmWHE8C13Fbzf/23hkK96+hks6snAsLIirK0wTUUzizEQyzdcTgWxvilA4J9rN5nIQp6BiUD319xxGpbVTzRRm7ep6DfuR0wYJaICjDjRY5sEhhkkasa7LMhH9Q0a1npIUXs4PfLH1vaZHCBVsDSQp+W6GHXtPuc165C809VRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=YaAsR4Y0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="YaAsR4Y0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so5241815e9.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785674669; x=1786279469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GmTaPhi4gg01Ffe5NHKx8HyCVLhQUuUjauGNikkJAk=;
        b=YaAsR4Y0rBPIvp3arHF1wRUKnEt/jsRm1N1vrm6r1nV/FE88Ib3mjv5rI900mGxvE5
         gF970e+sIb1Fl/DwEOjnzLf6fRyfCjPDzoY8KUvXqmrEJziQHdvProF5cwM22V5PuNFX
         hLK7dZBPOgjL6kUOTBthmqATKAWKieKJQAsXdCPZiv6GdB9zqmZa1aj7ga1zAwZJeToR
         hdTIJa31gODOJghG99nSxwXivEIZGGnFrTbL310NMOpYp8nmc5Q8CwBg1IJN1HqiudUk
         Mlik9psu2WX/Pf9mya8BQZx/KL65GqCcG78wx1wgwW6xTRHtgZY6v1LECZA+oDMHiWPf
         dCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785674669; x=1786279469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0GmTaPhi4gg01Ffe5NHKx8HyCVLhQUuUjauGNikkJAk=;
        b=Gqv+7XeEz7JhTuS436/w/SywkzEwgrHoj9qbQ1Rd/fv6HGvPGNBJo9iIDcIHozOhsl
         TveYVSZB7WBi7qIS3rx8eARVyB6QaH0EJU2p4bQIJAkE0LtLYMPqb9Vn4iZjlzSxndZC
         VGwqz1xJQCH7kFY4Hi4rroIdghg0BXJIF9zLi8+dz5PW6O0oDuISGaQwBSjr3yciOFp1
         bIXuQyUYz0BcWJrylLsfjchChF4fwvysuySvIqWA6EKZ3Rl778gCOALMW2gGXcemAfYt
         Nm8wuvNeSpCXXH8+lbgIYGS7GDZRGhcZ/5lMnc2ie1JVnYXxIWHVzF+WizuT9a+LkijR
         VvlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPg2B+ez0wJ4BNFgoVMhG6d+QPY/IReFKEtaHGPj6aOvkuWqSOn8u9267F/7yw7SB2nkYiOlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdhp/rRhGg/uLCeOuhpxO/CbT9fiVkooESMvnBdkN52cICCawM
	XH85tNGNVWzX3Y0yJmAzE8bCRKTuNF7Qi7By9npz6kNz0afbhMz/6w259BT2N2svb3rI3T6bDuE
	3VG1+Gg==
X-Gm-Gg: AR+sD135uGcKeR2YUxBQsObHZ952vmAcyoehcI+w1IKlIvM4xKoOBxNUqo3jSTkkmrP
	hAmKh/GY9Y4txYsOzTC5Q4ZURYJj6GRafxcY+Ssa6ZyfikTNWnmHGIr08KC1vzMzR3dahuTe0Bl
	YiAc2o8YlxOlbLbH0wBdbz1Ct7NBbmnSLU1AwHiX3gYMgnxeItbGKndZV+roh1EHFjWzd7cUgnI
	BnYOyl7NVIJduuXdBaDULgyyHtpe/V3M96hSj5q/bVwFn56iU1ryTUMANDp8NQFJzCXkawusBF3
	ab555aaUxf9O88yu1aQHuO7EN9P2utPjbsR2OkCzzxs6Exq/ZaD6TwlI8reM1HGamMzoeMjcKCt
	70FV6KUOls8p8QLxfV+0HOrobHqNLoqt7l2lXSlnRlm3anzRYuTFSpqe5yB18zq/CDTGC9nLCnb
	qNU1YFo/yJYYh4SgThUyor5rFySmPq1Sw5J+al7V7zrCmRZIeqf0KmoQevRwsOit47YGeJC5Gpg
	V4JYkMjbe67AcW41eaLoMkB8xm5AMjguhWHQ6bDYy7y64te6LMIcOyoeaiHSBGCYBwOXfcwoh5i
	06EPhv50sB05sKl3Yg==
X-Received: by 2002:a05:600c:c8c:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4980c6564d5mr117979845e9.13.1785674669080;
        Sun, 02 Aug 2026 05:44:29 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a68sm97240315e9.4.2026.08.02.05.44.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 05:44:28 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Sun,  2 Aug 2026 14:44:26 +0200
Message-ID: <20260802124426.87779-1-doruk@0sec.ai>
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

Reject the frame with -EINVAL when any of these elements is shorter than
the structure the driver later reads, matching the length validation the
FH/DS/CF/IBSS parameter-set cases in the same beacon parser already
perform. mwifiex_set_sta_ht_cap() returns void, so there the too-short
element is skipped instead.

The length tested in mwifiex_set_sta_ht_cap() is ht_cap_ie->len, which
is attacker-controlled on-air data, so it is only used as a bound.
cfg80211_find_ie() walks the IE stream and returns NULL for an element
that claims to be longer than the data it was given, so any element it
does return has len bytes of payload inside ies_len. The new test is
therefore a minimum-size check before the fixed-size cap_info read, not
an assumption that len is trustworthy beyond the bounds cfg80211 has
already enforced.

No dynamic reproducer: mwifiex is a fullmac driver for Marvell hardware
with no mac80211_hwsim equivalent, so this was confirmed by source and
structure-offset analysis, and compile-tested only.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---

Changes in v3 (per Francesco Dolcini's review of v2):
 - Commit message only; the diff is unchanged from v2.
 - Spell out why ht_cap_ie->len is safe to test against in
   mwifiex_set_sta_ht_cap(): cfg80211_find_ie() already rejects an
   element that claims to be longer than the data it was given, so len
   is used purely as a minimum-size bound, not as a trusted value.
 - Restore the note (dropped in v2) that there is no dynamic
   reproducer and that this is source-analysis plus compile-tested
   only, answering the "did you test this" question on v1.

Changes in v2 (per Francesco Dolcini's review of v1):
 - Return -EINVAL on a too-short element instead of break, matching the
   FH/DS/CF/IBSS and VENDOR_SPECIFIC cases in the same function.
   mwifiex_set_sta_ht_cap() returns void, so there it stays a skip.
 - Switch the Assisted-by trailer to 0sec:multi-model.

v1: https://lore.kernel.org/all/20260709100800.7026-1-doruk@0sec.ai/
v2: https://lore.kernel.org/all/20260715185543.14478-1-doruk@0sec.ai/

 drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e7..22031faba057f 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1384,6 +1384,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 							bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_CAPABILITY:
+			if (element_len < sizeof(struct ieee80211_ht_cap))
+				return -EINVAL;
 			bss_entry->bcn_ht_cap = (struct ieee80211_ht_cap *)
 					(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1392,6 +1394,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_OPERATION:
+			if (element_len < sizeof(struct ieee80211_ht_operation))
+				return -EINVAL;
 			bss_entry->bcn_ht_oper =
 				(struct ieee80211_ht_operation *)(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1400,6 +1404,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
+			if (element_len < sizeof(struct ieee80211_vht_cap))
+				return -EINVAL;
 			bss_entry->disable_11ac = false;
 			bss_entry->bcn_vht_cap =
 				(void *)(current_ptr +
@@ -1409,6 +1415,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_OPERATION:
+			if (element_len < sizeof(struct ieee80211_vht_operation))
+				return -EINVAL;
 			bss_entry->bcn_vht_oper =
 				(void *)(current_ptr +
 					 sizeof(struct ieee_types_header));
@@ -1417,6 +1425,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_BSS_COEX_2040:
+			if (!element_len)
+				return -EINVAL;
 			bss_entry->bcn_bss_co_2040 = current_ptr;
 			bss_entry->bss_co_2040_offset =
 				(u16) (current_ptr - bss_entry->beacon_buf);
@@ -1427,6 +1437,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 				(u16) (current_ptr - bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
+			if (!element_len)
+				return -EINVAL;
 			bss_entry->oper_mode = (void *)current_ptr;
 			bss_entry->oper_mode_offset =
 					(u16)((u8 *)bss_entry->oper_mode -
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d212236..844223c04e2ef 100644
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

