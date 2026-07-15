Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437140096F
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141751; cv=none; b=MPXJnjeXGz4oNcizbxZcbP1f1eA/mGK3qFomLCDsJjCpXN4yPx88CissIKcX2rxGQw+TdSifOsjEb7aTixbsYu6xHil4HjV+WY99ug2Y3Am5Xqq83lPvo7ZAEGopstoMyCHOB8PW6oV0PQ+JbgAXlnkqmKyw7IRNuH210443aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141751; c=relaxed/simple;
	bh=3DnU6CqzFmAW0ak1NYsuCwXcj4lzte6aeTZ5aEU9g30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5LWgJiYT9yDeT4VDses3CwLjc21xaF6f+tkzVULE1DzKOmtA7Q//7iTy07m+6TlY5M53h5Q/97YxIkM+tZg2EoPkc6q95SAPCJuL690H4eSes+lpYbFMPijesIo4lk77xHjFQZ2KANLd5V1P4eepSiH2+0wrEkHV4XrN9stpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=iIGPIU2v; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="iIGPIU2v"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b1710405so31882105e9.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784141746; x=1784746546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RwsH6RHa4hAdb9nmM6t5egIJ3f199jl2+ceKUA05gP4=;
        b=iIGPIU2v1lC41nmOsrERDicU/QFKa/Hniste3iSDCTWnufMyh1aIXnutlzmiLyNCOp
         KSxloz30QaeT4s5+sPQHkhTd9ffrF+L/CNS01r2TetJXXxT7oiYkPAEjSozV/rzew9XB
         OL7es3ONftnR7G+NJ3hCslSLLLXckwpftGcPnnZ6mA/7hef90t1AmW3pd05hoqymBqIf
         +Rak/OGuuja0PYKcwgJffEjjE0qdADOCLtU8dHDAKLDbaIahJ5FiITab8XlOHrmxEnKc
         G8x2ReZqKqTYO103i6X6jZs+9pSiBPHq320dAB+JaZ4x8/HFDQIDnG+MjjLv6md9GbpI
         FHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141746; x=1784746546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RwsH6RHa4hAdb9nmM6t5egIJ3f199jl2+ceKUA05gP4=;
        b=dj+AE3lIjuyeFAhTfSpyokJbp1py8d89nuaWAlUG9+rKAsHWbEAt3nUKMFpb7iBHI3
         PUD2pxLaSez/N83vc55IFwJsXfsgGpNIaJ6WR7zSScP81ywhK/R0eAqmi30T+NBnNwMS
         MKfAp5gGS81yRWN1S/l1E3pEQ6i9rtTijfAV15xjWvZZbMYR4o0lNhyVLnGb/+WrF7uY
         txB4UekrZXHTrcSQpTjLfdZqnHAK0E55s1k2IPmdR8oFcUeojNLo0flXo3ZwrgLF6jwL
         aTgXNeeFSqkGfZUH35/IQyCtslaODWdVrNgOmS5X3KtNpXxiqluggop5G/thMfjhMsu1
         Mt3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrhp0BgWObWwLyU2u97X0/l81AblUIXYU1m0WEQHa07LO+eTyyeGdOPz4ePUPAXRjqG2bROxf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdMqoTktkMed/K6WjhVAJTQ24hKJ2ccfw7jHl1B9zeou0qeTD
	qX2cINjOqavUfRzyIZdbiuTaWIYR0bhJmLQ+THnBGUJs/Y7qGehEDQcyGQKOjzFMRuLh
X-Gm-Gg: AfdE7clgKTgzxw6xsNkL37psZxzEdigdhBW2PhR9fup1gYv287evAKm507uPEQNiEdA
	SSksx7K1ykwuVrTmX7OLbpaxlqYn2VsoXrJdCeROmbBrb2eC1W7a7bUB9rnOrqD/rq5tqTx7Q9f
	rtk1OSaO6Xziwobz2tZbnUrBvKYjRdlfuz8Yih968ugNYIQ+RK9O7o/wGCPKnMXv+lIDg+OU5Az
	vTHXXDSajBaNl2JwHJd0ILSbrC33MYaZ+YwAiRKto11fYLoZIDPucQh9Eue/Rq0Dd7UmNM4d6GO
	IhF/nyz7ovYhXE0HqaMy+1F4OAdsxdOUKw5fveE3R9izyf1eVKSyahPb0wARVmR2NOn75UETBzc
	4pB9cAUn3YvZSQPwVmEgqVbTn0vG0eDlvc3rmkdm88pf1sKHyW/j7J2r4EVHfFv0EBM+kxg8v8W
	3TsPnPLytBMdY5jM+s9fFBhLIChxPxXQg+aqHsAMdXRblxKo63JNO8uYNsc+lPCbgKwsQLTQWLJ
	FrHsZWP2+7jVSQR/QVTw5/og0KvaOapoSo=
X-Received: by 2002:a05:600c:4e53:b0:494:282:106c with SMTP id 5b1f17b1804b1-495158db293mr103213185e9.16.1784141745653;
        Wed, 15 Jul 2026 11:55:45 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7f8aesm3025235e9.1.2026.07.15.11.55.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 11:55:44 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Wed, 15 Jul 2026 20:55:43 +0200
Message-ID: <20260715185543.14478-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709100800.7026-1-doruk@0sec.ai>
References: <20260709100800.7026-1-doruk@0sec.ai>
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

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---

Changes in v2 (per Francesco Dolcini review):
 - return -EINVAL on a too-short element instead of break, matching the
   FH/DS/CF/IBSS and VENDOR_SPECIFIC cases in the same function.
   mwifiex_set_sta_ht_cap() returns void, so there it stays a skip.
 - switch the Assisted-by trailer to 0sec:multi-model.
 drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..22031faba057 100644
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

