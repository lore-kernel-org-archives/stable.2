Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624B3B442B
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100319; cv=none; b=oHB9xOm5jX6OMF6TxolyEkK4SPW+wOyHpGhc8ggOKnWawXbgmt5TPOQvQjt7IcwBOFv86+BZQgt2JbOSHPZCope+DD1S2cvSoLuL6/PAz2f3w84nQnb201Lp4vxLsSoH3v5Rw0z8NawRSrI5jbrh3z3Hu6GAUbdLaxtrgfQ4Z78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100319; c=relaxed/simple;
	bh=ZhO7T/KODzJDH9cl+5s8l+N7oWrQNDZ9TakHn3UoRnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUcHkV4TCpQdOdAFv+W0uNF665U8Ttb7scJDgIFdmgPXQJdozY/mxuThA1AkRtfbVoMcGV2+Tgkk0+ZRnUqjCEugX9qq6LJHLpz059sDqgXlSJ6R05qO6aeNeVhoiWrMF5ZQQGDQ6tu+vdVMGbjAZZZyP3m6ZEhpHVSFE61MPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhx4dOxF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhx4dOxF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495590dde14so24245075e9.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788100316; x=1788705116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqL3m/kWUFx3apMB9seIB00v+GAfFyrKKdC2EF4QFnE=;
        b=Dhx4dOxFASuOzXQBZySlEPLrhh0TDBHK5M6tqyEuEFByyzZAmgWbCyWGxoiX2UP9ZM
         2dA7cgtOm4R7uw1OubAHkCv7I1SNssjqmXrdcCJw3OaiYMalJfyQ16Qkbhwm6ofayJMj
         ekqwNdoSV/TsYq/H9sOe/KPBKcWmA8/2hsPffnQNStXiDeu6Rm92a4VIG33LxJUzoGxn
         dJsu6jNTR4Q0f43+cre9g5U+5B8EDcdhDRP//PSteDQlxUr4cYNWhJDxtYse54RWBhcK
         +FwTf9itGKFKtRuy7eibHFxFTTylQ63JgCCkQsUTEKf+Yhn5XgfZI9EVbea1N5epIeDA
         gboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788100316; x=1788705116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqL3m/kWUFx3apMB9seIB00v+GAfFyrKKdC2EF4QFnE=;
        b=YTvB+dZiHJmiEWnXJk+oDM6kCZDZry15wErgaxreiniThGlWTdTl8zEsoEPA17p5xU
         SfRsW9M1CrFAsz7Hym67lm9BCdfSl86wBIcJFpW2sT/CDqUaA/ufwbt5OUdrbeyf7buI
         uXtCV/5h2Y8TMTy6iGWpjEeUWSPBakSldPEuLhx7lnOU71Rg4SzJgYLD0WV1goCVJ879
         v5FTkADx+AfkM1p8+/HTFNdFGtv4Pq8W9L3ZPcf8IGu4xgbTqXNzqh5rjDcgzmNGpiWZ
         JcZ8JoZ3QKQjcIUTXBV7y2WdV7c0bwBNHs2Q9r3K2rxanhJR3OQbqMYJN/xvISeCxgAC
         4TlA==
X-Forwarded-Encrypted: i=1; AHgh+Rpw4eDdcKfjZxHQ8Jy+ZDJcdHxlJX54BVsT3NrglWvQwa1AfylYyhWw9phJywpiGYDt95WRa00=@vger.kernel.org
X-Gm-Message-State: AFuF++nTTp75oMpIsBMd3NEMhwhjXMI8TeqSNzmU7H9Muv6aw6eJq+PC
	PqLR4d/2suZiPmoXfjn8hpIZGSY3U3caPwKj1eeVbnFuw3HaRULgYpk=
X-Gm-Gg: AR+sD12fRAspiog/YxuL49nfpx08UT4A6SENifVwX96s5pJbcM/GF0dmfnZuJL+LVc+
	gkOP3rHGFkrs2bT7VAdKmbS/qHFiMlrB/gzHOC3X4FU6ceXnCDNyVkX1yJneVB+TduigyayB3is
	pqkl2/yjBz3DEILGQApP4hjM7r9Ax27RkBG1QJm8VwDf7DGQyxibXYfC5P5zArlm7DcsioBf5wL
	aWgr5YFP7KMoTpbzQzJNJ52tTzuAtEPUZ2elUiJjgaibcP11ih1fgzzjs5aJSGBcnHhqLZDiWUo
	KNyNqGL7x3oqb/aWFJVj+GkdqT/gJU9WiXDRbLntwvgUvK8Nr6wP6r7BhVklSbNLoywoWLXUvDw
	rO8kc95XnNrmQzpFGGwXC61wa3FM3WGKMvuM5PAvFmW8ucgYJrq0aM9PpH/jYACzrCzoKpUsXW3
	SX1xES9ZLnVakJYUjsbOE0UzNQ9zW6PA==
X-Received: by 2002:a05:600c:4715:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49b91c26a01mr291541505e9.5.1788100315529;
        Sun, 30 Aug 2026 07:31:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccae954f9sm146319065e9.13.2026.08.30.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 07:31:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Po-Hao Huang <phhuang@realtek.com>,
	Chin-Yen Lee <timlee@realtek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 1/2] wifi: rtw89: fix OOB read in rtw89_core_cancel_6ghz_probe_tx()
Date: Sun, 30 Aug 2026 14:31:52 +0000
Message-ID: <20260830143154.1751910-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

rtw89_core_cancel_6ghz_probe_tx() computes a pointer to the IE area
with

    ies = mgmt->u.beacon.variable;

and then passes skb->len as the IE data length to cfg80211_find_ie():

    ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);

skb->len is the total frame length, not the length of the IE portion.
The IEs start at offset 36 (24-byte header + 12-byte fixed fields), so
the correct IE length is skb->len minus that offset.  Passing the full
frame length causes cfg80211_find_ie() to walk up to 36 bytes past the
end of the skb data buffer, triggering a slab-out-of-bounds read.

Additionally, the function does not verify that the frame is long enough
to contain the fixed beacon/probe-response fields before computing the
IE pointer.

Fix by returning early when skb->len is shorter than the variable-IE
offset, and pass the correct IE data length to cfg80211_find_ie().

Fixes: c6aa9a9c4725 ("wifi: rtw89: add RNR support for 6 GHz scan")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 68dad6090f87e..7b46715ea12db 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2532,9 +2532,11 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	size_t hdr_len = offsetof(struct ieee80211_mgmt, u.beacon.variable);
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
 	struct rtw89_pktofld_info *info;
 	const u8 *ies = mgmt->u.beacon.variable, *ssid_ie;
+	size_t ie_len;
 	bool queue_work = false;
 
 	if (rx_status->band != NL80211_BAND_6GHZ)
@@ -2545,7 +2547,12 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
+	if (skb->len < hdr_len)
+		return;
+
+	ie_len = skb->len - hdr_len;
+
+	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, ie_len);
 
 	list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
 		if (ether_addr_equal(info->bssid, mgmt->bssid)) {
-- 
2.47.3

