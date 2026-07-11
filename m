Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C6374E59
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754022; cv=none; b=hGlPxwTFOH05iiRSh1BMWVyIcG7DtfNZp6jzmjIfcYks9V5RbOK39elW0YA80z3OjggAddGDvx/VD8W0yay2Lm37W04XwD8+GNvsa4yA0Ivv7YL11K/KqESkP2FvtFUcCFyEFiDOjBW0EKuDVu6p6IdTJJ9LIiApfsxPJ4FxNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754022; c=relaxed/simple;
	bh=nJ93PuRgfvyXeSbj+HoOEf3Bf82IWNnh7L9snO3pg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQKvRyso72UeKnPGgCrWwkL1olI1lPIK6sh1xafOpVX95mOTUVcL85pgTCpo0+w/gj0H5TSrDgo7yd+1vNGdFhFaTtXtbvQ1K41VwGsNHZN8lf1D2EUY6lGa2//ALL+HYmEBqLn2VtR/K15JwJGQYc9MUjqnvzYzNV4m+3QNoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=jR9qGL0c; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="jR9qGL0c"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1394555f8f.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783754019; x=1784358819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNHJSSzRo5FI9vf+enTbdejiXKeJlyuLQfvo17oWJAQ=;
        b=jR9qGL0cLL9OH8fZxX0l0ahGUrNlXFSzyPUN7DEBq2Tq42sRjZ+Ssf+tRy4SoxE09I
         1lipBfJEfCizwGIOQCdXBfCGWtg2x2NX4iGCgFsxYj1eqnDl3/kPqHqSG26Vlzi2AjFc
         PVKQJ7JUULXgOWxcBlix09KC/BQ3zTX1ww5x9fmdWQEXmfC1XvghCyOJlADQbJx3x2P0
         4FIILW8gLT6Bl5vFpwEukXZlCZzGzQ8LGT1R8A7R5LUXRF+eouCL7ykzNHUN8lfLyesm
         2VGPTDsk/v7YTyK0vlEi1XQ6UKVG13o9d88YEpxsEZUXuMfHqxIbmAv0ItaN8u2+6RGF
         K4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783754019; x=1784358819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNHJSSzRo5FI9vf+enTbdejiXKeJlyuLQfvo17oWJAQ=;
        b=SGkkCX3WdLThAczU7cPOdvxFCPaXLOpKIai55L6mAuHJW4kkV4YVAs3FJWKgVda3F4
         QiMz/AqVSyKA4hOYH0TMDBq7PbwNs0/L8S/+oIzjyVpCKBq7/HvyVh1V8goTxLwMhTpL
         HswMY0T5MExDqdjkoVtWgf/01/GkBKVkrRJZzVlFnT9iDahwss8sB3d7G2f8Z3Qa92RE
         dD5PWkzS5pGzNWx2hwJAqdkz4JpIuNdCidersNqR6ObOijJIm0N8lpJGgNbVzxCCABi4
         HyiuAM8Jr2MufO0yO5sWN5+btXaRI0MNx5jjpRjbso8xdA7ElAB/zM9HhU71byitmLY2
         dWQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjYiIHKRo56yoAs+BjlTXQst73y8ZjsbLaBi2LErbEhYDZtFbA/PhezO26qVg7gG8cHcoTfUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPC69CzDHJxMVq8ijs6/VK8BQgbS59LdV/2PaDMLpaZMcCQ7J
	SjmBtBDqfl8J5ml+TljL9X1ur14unTzivL0yHGDdb/3EmyDrk5oDKpDcj298//YAzE/X
X-Gm-Gg: AfdE7cm2DT8csN0iqtcrH4RCyfwjRwY7FHf+iwIdrkU2bOgM43uia0B0w94j1ihlazy
	+WXxA6EEP41mRQVF10zNzw3+xEmjP4GvmtY4YRG1fkJy2I4dQ9u5MLzUPpt4UmFFBUCUYCFu352
	UECux+WQxjGA22gQx4VipBm/obB9VAXSn1VZcySqizz1P3lSjWHXUZAjEivxteRjRRqdHwyxiWq
	knh3kkJoqhK52EUXboVVgNs83WjBDYpqFOr/Bk0u8Do1TENZfNdNk0FUlISpgrYZzpwLB2/yyqs
	sQv7JLs7KEl2/ZOSNh+/CJel1QJaxuNkDLN6qeEG2P9z8D1WyANC0LL07XHfRZLSWIDCzD7Q/Ep
	kj4od0w7/8Pn6ktWMzvKs/srd03L+k66fKmEPvu0cO4qgwh/L+HPmqPlzCchAUYCH7iBaLzBWan
	BoxmminZfioFOK29MCA8VylVWljWOM3qzN+kEwgCGiz8URIQdnRz2+vjavGZZpnc5S5PEtPA6sW
	DYb1ohmSuJTcfzSLz/oZX6zkRyIvcZjF2w=
X-Received: by 2002:a5d:5c84:0:b0:474:9991:60d0 with SMTP id ffacd0b85a97d-47f2dcb60d3mr1985178f8f.12.1783754018793;
        Sat, 11 Jul 2026 00:13:38 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm61990120f8f.35.2026.07.11.00.13.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:13:38 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI connect event
Date: Sat, 11 Jul 2026 09:13:36 +0200
Message-ID: <20260711071336.58324-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath6kl_wmi_connect_event_rx() only checks that the received event is at
least sizeof(struct wmi_connect_event); it never checks that the trailing
beacon_ie_len + assoc_req_len + assoc_resp_len fields fit within the
received buffer. Those attacker/AP-influenced lengths then drive two
out-of-bounds accesses:

  - The WMM information-element scan builds
    peie = assoc_info + beacon_ie_len + assoc_req_len + assoc_resp_len
    and walks up to it, reading past the end of the event buffer when the
    declared lengths exceed the buffer. The walk also dereferences
    pie[1..6] and pie[1] (for the advance) without checking they stay
    within peie.

  - ath6kl_cfg80211_connect_event() subtracts fixed offsets from
    assoc_req_len (-= 4) and assoc_resp_len (-= 6), both u8, with no lower
    bound. A short assoc request/response underflows the length to ~250,
    which cfg80211_connect_result() / cfg80211_roamed() then treat as the
    IE length and copy out of bounds from the small assoc_info buffer,
    disclosing adjacent slab memory to user space via nl80211.

Bound the declared IE lengths against the received buffer, bound the WMM
element reads against peie, and clamp the assoc request/response lengths
before the subtraction. The sibling wil6210 driver already performs the
equivalent length check for the same WMI connect event.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bounds are evident from source and cross-checked against the
sibling wil6210 driver. Compile-tested.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c |  5 +++++
 drivers/net/wireless/ath/ath6kl/wmi.c      | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index cc0f2c45fc3a..62f663c0daa2 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -754,6 +754,11 @@ void ath6kl_cfg80211_connect_event(struct ath6kl_vif *vif, u16 channel,
 	u8 *assoc_resp_ie = assoc_info + beacon_ie_len + assoc_req_len +
 	    assoc_resp_ie_offset;
 
+	if (assoc_req_len < assoc_req_ie_offset)
+		assoc_req_len = assoc_req_ie_offset;
+	if (assoc_resp_len < assoc_resp_ie_offset)
+		assoc_resp_len = assoc_resp_ie_offset;
+
 	assoc_req_len -= assoc_req_ie_offset;
 	assoc_resp_len -= assoc_resp_ie_offset;
 
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 72611a2ceb9d..fbfd74154d12 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -862,6 +862,10 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,
 
 	ev = (struct wmi_connect_event *) datap;
 
+	if (len < sizeof(*ev) + ev->beacon_ie_len + ev->assoc_req_len +
+	    ev->assoc_resp_len)
+		return -EINVAL;
+
 	if (vif->nw_type == AP_NETWORK) {
 		/* AP mode start/STA connected event */
 		struct net_device *dev = vif->ndev;
@@ -913,7 +917,8 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,
 	while (pie < peie) {
 		switch (*pie) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if (pie[1] > 3 && pie[2] == 0x00 && pie[3] == 0x50 &&
+			if (pie + 7 <= peie && pie[1] > 3 &&
+			    pie[2] == 0x00 && pie[3] == 0x50 &&
 			    pie[4] == 0xf2 && pie[5] == WMM_OUI_TYPE) {
 				/* WMM OUT (00:50:F2) */
 				if (pie[1] > 5 &&
@@ -926,6 +931,9 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,
 		if (wmi->is_wmm_enabled)
 			break;
 
+		if (pie + 1 >= peie)
+			break;
+
 		pie += pie[1] + 2;
 	}
 
-- 
2.43.0

