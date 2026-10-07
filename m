Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE173B9618
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389847; cv=none; b=gMwnfEY+Uk7TOQIoNdaSpcy8/DlUKinKSJEfUvFP+4UFaFOUnT3kjuc7EYlykmwYsS1Hn6iKKRHZ0QFtGPTP2Shxf+6QtkNGTt6w1XvZNiTiwwVQvHCUXhg6n5mUJZnkd4Em4jNiZzEAWOp0XHkGm4OgqKSWOfV9ci7Ucxq/gCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389847; c=relaxed/simple;
	bh=WHKroD7dUGdwvfgsrlVmP73MnJQsIo9u1DqdalxEU/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+X6mSzRGNlsac4wYG+8ooQoOLPMxJjjbPiaN1UefC2H3k7t6DBYb85jJ/sF8KfCGJRWv2EMHIz6+szBDguEmJ4PYEA9y1USTn2mFafd6CFUUCAh8GKDhtDF7X1n6OUXXj5vIhiSKrQduGpbMbv30VBLC+tIdXKsSfQg5n3Ek10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOeftahg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOeftahg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso14543365e9.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791389844; x=1791994644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umgdDYKjH1ujmMwYt0DrEX+xooXwWq3eYjix5EPxwqM=;
        b=UOeftahgln2bI2Fjw0DeofSYI4y+8iNEmy63JIVKEF6nENoH++bxEdZw6i0+vay9Wf
         BFUHG8by3Ym3y/49pc5rARouEG1n85zeqxNOY2MERnV3P7w8SJSOcbg+S9yYs2WDGg3L
         4HTrFGj8y4e0Py3S7fdBOnaQIT5bF2BIsSqamIMQwPU0sSJ5ZBI8M5cXYDs9iD9Wx4Fh
         Y7lNKbj0j2LlgrC7QtdCpnyiUjg5C+ySj9w2VqTMTaOoCZUr8q/otC2Fw2DMA02tnhmy
         n8AeFjv0EtYK9PrW9JZUPpGlpHmgzaNnRI3BZ+/CNGeZ3+eJo/SgxThdrq5TSfvEz1y0
         cTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791389844; x=1791994644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=umgdDYKjH1ujmMwYt0DrEX+xooXwWq3eYjix5EPxwqM=;
        b=IMWtO64qr6uliK1MXaGOtb3ULoCD0cvTHzGm8dp+GK+5XYIpaGkfECZT5BMdNB2FNc
         +b5DJPBNXyoadFpUmDRGWIW9+6HqVU2PcGEGHQuR0MkQgctgho22OfgnRkrq1jwVWLb2
         81su+JtxHeiCrEX/jiwJimvnxaUW8+9TNB4zZKmvbQxcayiZ1GH/cH/MRsIc+JU9Th5b
         qzraUobRgl+sWHQWlWBDthEF5P/rLxAlauP8gFVrnvp0LB0ck6cnwX8s8f8vaLQn+O4d
         P99+ynKD7YFyhKrg0WbHWyOAD6XVB14Y1I56vJWu+Aa5GngtvQ31bGiyH8OcMMkSmN+C
         YGjg==
X-Forwarded-Encrypted: i=1; AKwUvBxwpGM2tIS6p1cbfP5QBInFmmUeeupyxNrxAOGVpatJvsY0vtK3s+w7RTWVjcLo0X4I1G6yGBM=@vger.kernel.org
X-Gm-Message-State: AFuF++nDLQC6/lbUzmDECrn7DLJu31OXWRAh1hSmh6WobQkhxL7UAFv4
	PQhAA7TRlcExDZUbmDtrArwBaHGVmUD29ZoEmSMTuZRXkP6xvTqiALA=
X-Gm-Gg: AYBFou1/YLIeRBgjxspz8J8YhKf8Q2IFeE+br7qlilT3Y3aENe9Rb96pifMyJQVCpeM
	TDz83jNXXLMqefUOxvlFTXKNdSL8X1oxk+i538qp9lqrnTu2MisWu0fTRxV/acOHsLuQdlCKqqs
	KmzIN0hA84+OWEN6lC6rllu1OAx5+rWCOZl5ghvAGfRDlAEzkBA98iyQNnI6PGXTzjLYjV1gCV2
	L4nIu5JwXzEQT6uv0DO/TEUH6jClloPUPRE2H33l2O0J/arcom7/M1Fv94ULTek3WLMhcY6J0ca
	L5V4wyBuXA1G4TMBUiK6+RTz97l67vQfUcCEXzfcTMTmFpYaUyb3gMc3FNKHuuV5ia7M/kU1rmW
	zi2zhf76LBXQo+INtFV8t3Z12IXM1H5E92j41f9h/uoMLNfWTtJlmczUQEsLNzKdWGIXcAVjGv1
	1Ak1lbIUCX4IsQIvbbDA+s1k6jfC6dwL11SzOJo0+6
X-Received: by 2002:a05:600c:154a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a18043b5fcmr44495025e9.16.1791389843979;
        Wed, 07 Oct 2026 09:17:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843aac98sm2685295e9.9.2026.10.07.09.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:17:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Po-Hao Huang <phhuang@realtek.com>,
	Chin-Yen Lee <timlee@realtek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless v2 1/2] wifi: rtw89: fix IE length passed to cfg80211_find_ie() in 6 GHz probe
Date: Wed,  7 Oct 2026 16:17:20 +0000
Message-ID: <20261007161721.261452-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007161721.261452-1-tristmd@gmail.com>
References: <20261007161721.261452-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

rtw89_core_cancel_6ghz_probe_tx() computes a pointer to the IE area
from a beacon/probe response frame:

    ies = mgmt->u.beacon.variable;

but then passes skb->len as the IE data length to cfg80211_find_ie().
Since skb->len covers the entire frame including the 36-byte management
header and fixed fields, cfg80211_find_ie() may read up to 36 bytes
past the end of the actual IE data.

Fix by computing the correct IE data length as skb->len minus the
header offset, and validating the minimum frame length before parsing.

Fixes: c6aa9a9c4725 ("wifi: rtw89: add RNR support for 6 GHz scan")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 397ebbfcac09a..6e000cdbb0219 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2571,6 +2571,7 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
 	struct rtw89_pktofld_info *info;
+	size_t hdr_len = offsetof(struct ieee80211_mgmt, u.beacon.variable);
 	const u8 *ies = mgmt->u.beacon.variable, *ssid_ie;
 	bool queue_work = false;
 
@@ -2582,7 +2583,10 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
+	if (skb->len < hdr_len)
+		return;
+
+	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len - hdr_len);
 
 	list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
 		if (ether_addr_equal(info->bssid, mgmt->bssid)) {
-- 
2.47.3

