Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F33002DC
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715235; cv=none; b=D4HM8ScG6SxLnuJzsJ8DTP8SLJ12qUhb8rAXCvAI52xlWGrYbx7kEt4w95xlpt3X1wEKFGkJncYfvBaHNDRnsL/DSeaQrxDj921e4IzySe8lyqRXFfeAR1JETxxgV1Bx47F9xQVpv0BLa0hjdpJgJ2xc1EtI74Hxzvnto0XUR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715235; c=relaxed/simple;
	bh=JBMowbALXN1jE7/AQew047fyFfMm2Zhn/Kx/LD/R+jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QN9whKS8U+8IeCsivvo16u50+I9+yyB4O1jAIypHVxM6f44CZ3IQ0DSaPXbWNfJ5sM8C5gaaNiPmYQa8bRD1Z0KHeZopW7RKHkWPrYY2EhzY7GjVV8r+xnowslF5jCO1rrVea7TgT5/phEPorg4GYH7wlSUQ+nmd2H4EAVUqlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0.security; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=LJQcp5da; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="LJQcp5da"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so7672335e9.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1786715231; x=1787320031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qmRPONQIeS1c8qTvxKNt6o0AVizi+U1D7QhZyeiIky0=;
        b=LJQcp5datWly0tWT1cCRRg7+DHbe9fLxtMTdtu3+CWxv9kqzJTr+9qA14DLHFRqmQO
         lBl6dErluf6XghHQv010u7tXeJDKTbhTPzlIegqu1gDTnxNCtDHZgvvk5gxoZxnfNx5N
         DkQX0SBjno0QcCCsuY+MfIt1zhYQ7y8RPG0oVCrglxZTrJaICWGM4FUJq+SjZxErtq1o
         UNE0H2zOqUD7vrKQ95rvziibQqcFYs3yq+rkeP0TO5p0UsafEWUc0dKI+O79a/LP0QdF
         KHZhSiR1eKCo0lvDduWusOWi3KPJcvOBjpcmWgO3cDRvLL14EOwnMzEWmVs2WLjlZ2+Z
         d3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786715231; x=1787320031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmRPONQIeS1c8qTvxKNt6o0AVizi+U1D7QhZyeiIky0=;
        b=atcmPCGs79SIJm7sMgSKT0DlsRWkQn/y1HIRCWhpUdLF2vY+bk8dUhK1B2e/XkxTri
         Bxe9kG7uBeU40Xkn0BGvg284drHUV6ZkQnC/tLqVv26mTEY4PYQH7tKTabUX6l1qbRz1
         AjgAqIyVJLnF7dImqA19UB5iSOSvMnOqR83p1DM6wjMi2ku6wrW5NAZr/Qpj+UL4GS7/
         GuMs/bPqpH0So2V+VdhrHwcWSmMfYiP3u1UaLlbGFLXkR99zLC0t2W7FnL0flfLEcVGC
         claHS8lOJk34bkE1pFkPjmmLHl2d6h71LQDmmlzGx/CM/jVzLYfEFlWHwPiKDPOCmijW
         tg4A==
X-Forwarded-Encrypted: i=1; AHgh+RoEfxFAR1MXieSZly9g7fcxAOPT1Le8k1kfw/Peadgw7KOL5r7StLVg+d1PcTVmKWhVQaF32Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7A6IJizNzfXF54x0qxa4QfAVhtYzCBlrce/Bw1UQ32kJMUeyK
	VRZ0yQeWtGSerTn8UaEsTKJ19ml0gg3XzPREPcUfo4jMSv03mJtMoxFR9NeXxG6va56y
X-Gm-Gg: AR+sD10fW/bNvQ+xPY8mHJYGU8FDMn0lTnAbe2JWBYxs6Yf9jsowq6CfX2Fjo+1wl3h
	kALJDy73BfWaP4CJcZjRNSJWHSqc/gucnDj29dA8wBecmqT0AHwQ378n3EsB2gmLdpQsA7RidDr
	VjYUMAX6tsoiVlwYcH/mwULqO7iTUwI6EtnIw4NloByvKIcbJgu3w61kT7PeWO7hM1LhM4cVTQl
	O3u3idhtoJgAxEfwuOfgkjVLqwcvX+59hIyJHWNMShrFmYxEmvx5YGaVs0OhFWJH26WuXMy4oi0
	1PYNzgXmDwdDYiPUA5vhJykB3fKXOrIR1AkETcVuwvQClH4lEFfqDH9Q4eD6xRAucQgFZaHhS/M
	6Oxwe7YjHTzaI0ZA8tWU7F3iWgJ2qArp0lY/0T0vdpd8rA8HhFcZS2r0G7St7DFNLz8L7Cc+m9z
	QeJtS93hdT7hcsbnB7gLdzG213q7Z6lh9TodxbKKQW+Qq5H1Gc3i6vmyIj4xX34MzbNna+9qB4R
	1P5dXa6Zk3DvK8qeMeC/uo7qPfjcxVtnG2yHMztwz4jIoL4Pz2zjN9EYBXK++Pq9avo5h8briET
	WHAnhA==
X-Received: by 2002:a05:600c:600a:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-49987981e14mr60442135e9.11.1786715231112;
        Fri, 14 Aug 2026 06:47:11 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988ae8facsm48742685e9.6.2026.08.14.06.47.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 06:47:09 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v4] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Fri, 14 Aug 2026 15:47:07 +0200
Message-ID: <20260814134707.85925-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_update_bss_desc_with_ie() stores pointers to the HT and VHT
capability and operation elements, and to the operating-mode
notification, taken from a beacon/probe response without checking that
each element is long enough for the fixed-size structure the driver
later dereferences it as. The beacon buffer is a tight kmemdup() of the
on-air IEs, so a truncated element leaves the stored pointer short of
the structure and triggers a slab out-of-bounds read when the BSS
descriptor is consumed at association time -- e.g.
mwifiex_cmd_append_11n_tlv() memcpy()s sizeof(struct ieee80211_ht_cap)
from bcn_ht_cap. A nearby AP (rogue / evil-twin; an open SSID needs no
credentials) can trigger this on the victim's association attempt.

mwifiex_set_sta_ht_cap() has the same missing-length pattern in uAP
mode: it reads ieee80211_ht_cap.cap_info from a
cfg80211_find_ie(WLAN_EID_HT_CAPABILITY) result without checking the
element length.

Reject the frame with -EINVAL when any of these elements is shorter than
the structure the driver later reads, matching the length validation the
FH/DS/CF/IBSS parameter-set cases in the same parser already perform. The
operating-mode notification pointer includes the element header, so it is
checked against total_ie_len; the HT/VHT pointers skip the header and are
checked against element_len. mwifiex_set_sta_ht_cap() returns void, so
there the too-short element is skipped instead.

No dynamic reproducer: mwifiex is a fullmac driver for Marvell hardware
with no mac80211_hwsim equivalent, so this was confirmed by source and
structure-offset analysis, and compile-tested only.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---

Changes in v4 (per Brian Norris's review of v3):
 - Use sizeof(*ptr) for the length checks instead of naming the struct
   type, so a check cannot drift from the type the pointer is
   dereferenced as. bcn_ht_cap/bcn_ht_oper/bcn_vht_cap/bcn_vht_oper/
   oper_mode are all typed pointers.
 - Check WLAN_EID_OPMODE_NOTIF against total_ie_len using
   sizeof(*oper_mode): struct ieee_types_oper_mode_ntf includes the
   element header and oper_mode points at the header, so a non-zero
   length test was not sufficient.
 - Keep -EINVAL on a too-short element (not break), matching the
   FH/DS/CF/IBSS cases in the same function as introduced in v2.

Changes in v3 (per Francesco Dolcini's review of v2):
 - Commit message only: spell out why ht_cap_ie->len is safe to test
   against, and restore the no-dynamic-reproducer note.

Changes in v2 (per Francesco Dolcini's review of v1):
 - Return -EINVAL on a too-short element instead of break, matching the
   FH/DS/CF/IBSS and VENDOR_SPECIFIC cases. mwifiex_set_sta_ht_cap()
   returns void, so there it stays a skip.
 - Switch the Assisted-by trailer to 0sec:multi-model.

v1: https://lore.kernel.org/all/20260709100800.7026-1-doruk@0sec.ai/
v2: https://lore.kernel.org/all/20260715185543.14478-1-doruk@0sec.ai/

 drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e7..80572989bc81c 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1384,6 +1384,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 							bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_CAPABILITY:
+			if (element_len < sizeof(*bss_entry->bcn_ht_cap))
+				return -EINVAL;
 			bss_entry->bcn_ht_cap = (struct ieee80211_ht_cap *)
 					(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1392,6 +1394,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_OPERATION:
+			if (element_len < sizeof(*bss_entry->bcn_ht_oper))
+				return -EINVAL;
 			bss_entry->bcn_ht_oper =
 				(struct ieee80211_ht_operation *)(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1400,6 +1404,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
+			if (element_len < sizeof(*bss_entry->bcn_vht_cap))
+				return -EINVAL;
 			bss_entry->disable_11ac = false;
 			bss_entry->bcn_vht_cap =
 				(void *)(current_ptr +
@@ -1409,6 +1415,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_OPERATION:
+			if (element_len < sizeof(*bss_entry->bcn_vht_oper))
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
+			if (total_ie_len < sizeof(*bss_entry->oper_mode))
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

