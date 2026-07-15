Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6B3128B6
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141748; cv=none; b=PWWIP+xvS0VgFBpqL1ZSQtINTNU1rEPvFlVtmJqQzvcS1WFWs0ZzhCezCESIbjApgNID5D9yKbYdOy9YF/c+TdIYXiq9Swp6EvlWIxNYD5sWIJS417tVIMw+XVPRPr4ho0fTtY38RgG7uHQhDs8KP/cuv0/BzZ5Yu8+UHvytnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141748; c=relaxed/simple;
	bh=7xBH/qlb9XYZQzIUvmR9CxJESOG3KhM08+kyoV4tfm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef5BkOIw7baY5zj9PVGnwhjK8aNmsxEr6Ik4upoYPaPZfi/VIkg7yc2vnkOe9k3fSzgLd2+ZclrVpB+kPFjmB1hkgzThpu09m/sSW9jJKFkCkC4pjHwPJUuJIoJZssKPch556N1SBGfr8ZbKf8hePW/67nXRr1iGufmWv6R05WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=RbTm8SxL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="RbTm8SxL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b779003fso25175965e9.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784141743; x=1784746543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBgT7C1VmTGs+SwffDnQ7vaSRKMxVj5a9hN2s5RO2E8=;
        b=RbTm8SxLrHDzDOaG8kAqe+wR/eKZNYM7FL8r9s6z6If0k0Dadj3qEfU7vGLjfrHkTw
         06y4fodzGaZhhz7oGZ9IT1o0d3R6Rs14EDwcm/k54Hegu5ENwqEwfqmPrVNGDGF0yyWI
         vHfcaFwHPGOsZtYsGbP7Iz0Nk+2BAFflJHJzTZpPyjlRxqlNTlc4/Xv56QuYhDZz6EK/
         iqw6VFjb71OaJMyUfuWZUBd4MJo8hzM1epxscmD3BUPTE7ENo2PRFy6J/DpI/fxZBZOb
         Ef2xyFMlWA0mG7ydsBwOKCX2Y7/R35vF/cCfAo/oYXbzIt6X1cl6TCZnVF62oGo5gw9l
         EHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141743; x=1784746543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBgT7C1VmTGs+SwffDnQ7vaSRKMxVj5a9hN2s5RO2E8=;
        b=sr/6So3tYWwXD8XAoGLrPxG6eSAnuxbZpOodfMH2l5mtdUjaNdrfyQzPqGITk1WAR8
         hBMdyNg4rYYN6wGj/JC2NURiWnaZrpnAJvDuTNHszAvrlJqbNQ1efVZB0QRf0WZvnXaG
         EUksmpSVmcp1m3OaG7zlw46UDs9S1/RYWXm4H1HnojkVG/UL60NhzI6uNzQvMN52E6uR
         JacuAFAPmLVmglVkweH0i00m8s8DtphxUgLhkB3vp66HuU7rYyhc/xFKKA7W08D8mwHW
         I5OSrOv7m3gYeUj3d4bQIJXtH1qHrrfVhYBaFhFJLe0d2jFq2WyHchEoZlwkuNYJU2vL
         8hJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqp+G+PS/xY4C7sMMzxDQ4RTtrFjYGivArZHAxh7qepAblLoKyv2pZ7RhN6oW426uHbOj2avbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaoTD5S4yQWRFiRHCsrQVwscSgnezTKNuL/P6gnQX+r9ClyX+
	zOAbj5EStZbFAh7IU9o/I05EWyVOK/fGcq9tdjz/Fc79TfkIE0Rs6razfch/jCSBvMnyXzxiMho
	7pOdGWYSl
X-Gm-Gg: AfdE7cmhkEN+DgaR/PvOqo6z901Sh8ff7hZXm5fZgF0MEEbagEmd0n8ImuqvMquoRdY
	8mqgHi2KGgzScCZTS7VoevkToIWlRI6etbo71RQKVOeBc/jYi6+gCSK74sokxNxitkRwFKxVpMx
	oDJXpGQjyI+4eeurE7QfMI9SzvzQ0HmqsEgkWHLZIRkkbTqweKaW2jQQ0KwViRKF10eZCBIrKhc
	ygqd3vYVn51HYUEEV5ZlJvjMagC/gKfuxn9ZMWHFpk/ko+R2NvIahrHz3237EDLD41R2h0n15pU
	SnzJvBbgYFHj4Xsm/vBp0knUn0VtvsCRl5gd6lkelKY/gyT2Tuw+KaVrjFEOVWJYuHmvSF8TJjT
	tYyFxIlE/L0J/ctYf6XmJj1vP9NfqHNa4vufWDO3gg0TSuSEoIo0JneD/TLnDGLpn4g+ZnXtojt
	ZYugZUWEWPYKMC47uXVvsN1ewvbI5TU330FSPdFDY9B53w7/TXVJZOIe0OlH1lx2o5xY1LeM691
	flIl1VeqHeUAfjQXEhtzUtwkm5QSi0CIY0=
X-Received: by 2002:a05:600c:548a:b0:495:3f0f:d515 with SMTP id 5b1f17b1804b1-4953f0fd576mr33398805e9.36.1784141743212;
        Wed, 15 Jul 2026 11:55:43 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm18280933f8f.34.2026.07.15.11.55.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 11:55:42 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
Date: Wed, 15 Jul 2026 20:55:41 +0200
Message-ID: <20260715185541.14350-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711071334.58307-1-doruk@0sec.ai>
References: <20260711071334.58307-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_search_oui_in_ie() reads the pairwise-cipher (PTK) count from a
beacon/probe-response RSN or WPA information element:

	count = iebody->ptk_cnt[0];

and then walks "count" 4-byte OUIs from the element, comparing each with
memcmp(). The count byte comes straight from the (attacker-supplied) IE
and is never checked against the element's own length. The callers admit
the element on element_id alone (has_ieee_hdr() / has_vendor_hdr(), no
length check), so a crafted RSN/WPA IE with a large pairwise count makes
the walk read up to 255 * 4 bytes past the element -- an out-of-bounds
read of the kmemdup()'d beacon buffer, reachable from any AP whose
beacon/probe response is processed during scan result parsing.

Pass the number of available IE bytes to the walk and reject a count
whose OUI list would not fit, keeping the loop within the element.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---

Changes in v2 (per Francesco Dolcini's review):
 - store offsetof(struct ie_body, ptk_body) in a named variable
   (ptk_body_offset) and reuse it in both bounds checks; no
   functional change.
 - switch the Assisted-by trailer to 0sec:multi-model.
 drivers/net/wireless/marvell/mwifiex/scan.c | 22 ++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..33ef8af0a5e1 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -104,12 +104,21 @@ has_vendor_hdr(struct ieee_types_vendor_specific *ie, u8 key)
  * a given oui in PTK.
  */
 static u8
-mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui)
+mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui, int ie_len)
 {
+	const size_t ptk_body_offset = offsetof(struct ie_body, ptk_body);
 	u8 count;
 
+	/* Need grp_key_oui[4] + ptk_cnt[2] before reading the OUI count. */
+	if (ie_len < (int)ptk_body_offset)
+		return MWIFIEX_OUI_NOT_PRESENT;
+
 	count = iebody->ptk_cnt[0];
 
+	/* Reject an OUI count whose list would run past the element. */
+	if (ptk_body_offset + count * sizeof(iebody->ptk_body) > (size_t)ie_len)
+		return MWIFIEX_OUI_NOT_PRESENT;
+
 	/* There could be multiple OUIs for PTK hence
 	   1) Take the length.
 	   2) Check all the OUIs for AES.
@@ -143,11 +152,14 @@ mwifiex_is_rsn_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_ieee_hdr(bss_desc->bcn_rsn_ie, WLAN_EID_RSN)) {
+		int ie_len = (int)bss_desc->bcn_rsn_ie->ieee_hdr.len -
+			     RSN_GTK_OUI_OFFSET;
+
 		iebody = (struct ie_body *)
 			 (((u8 *) bss_desc->bcn_rsn_ie->data) +
 			  RSN_GTK_OUI_OFFSET);
 		oui = &mwifiex_rsn_oui[cipher][0];
-		ret = mwifiex_search_oui_in_ie(iebody, oui);
+		ret = mwifiex_search_oui_in_ie(iebody, oui, ie_len);
 		if (ret)
 			return ret;
 	}
@@ -169,10 +181,14 @@ mwifiex_is_wpa_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_vendor_hdr(bss_desc->bcn_wpa_ie, WLAN_EID_VENDOR_SPECIFIC)) {
+		int ie_len = (int)bss_desc->bcn_wpa_ie->vend_hdr.len -
+			     (int)sizeof(bss_desc->bcn_wpa_ie->vend_hdr.oui) -
+			     WPA_GTK_OUI_OFFSET;
+
 		iebody = (struct ie_body *)((u8 *)bss_desc->bcn_wpa_ie->data +
 					    WPA_GTK_OUI_OFFSET);
 		oui = &mwifiex_wpa_oui[cipher][0];
-		ret = mwifiex_search_oui_in_ie(iebody, oui);
+		ret = mwifiex_search_oui_in_ie(iebody, oui, ie_len);
 		if (ret)
 			return ret;
 	}
-- 
2.43.0

