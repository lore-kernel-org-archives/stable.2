Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4283B4432
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686750; cv=none; b=TGVBm8kovJRmhJRyZMj5CfZwPROcAfCfRcFanFE5Ad5J2yOdXxVSN8dy8PSGlcBxsIoIpnp8QZVH7OtLXvYIKyvO3c49UL2B3GuKfUPV2HZ4fZkPZX75cb6g/Iv39doIwHwwzM93AanASSoPS0EdcuLoRJVvak1Wg4dEYKC51h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686750; c=relaxed/simple;
	bh=QZIvylAwL2mwBu3J7lNF5eXEyn70Xu5VGQOPaqdnL2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSzE5yYFuR6mTnAAM5O6Gf72efjkP+0wohU7BCigL5CtJCo2q5kKh2poWmzhIAF/Zk1wznJF1iPOpUGNqh+a3Dd4dhJCyV1YamVmtC2/U1Aqr1fYPe7Iz3v891hner9LFwy4/L+RwxkFl0Q6NUG9ah804w48XBxh1F+qeMBglwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4tzXAoP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4tzXAoP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad8076b01so28914055ad.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785686747; x=1786291547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQmpfn45uaTNNsHtj+z4E83LXS4CJJjfzV+3sS08LV0=;
        b=J4tzXAoPBhfI2G00/VRbXmXdYJVpB9QLYI3cueW3s1CH8SY+5H89mHCjZ5zPULuWdl
         7Pjc7UpRExqqcpTwoY+ckLsdHyGz8fEextdOZkNh+RXRcdP9COWTRCf8COOUiYvbexFz
         M6NurCAge7E13AyoD+kgzA4CBJh5PcNJETcxLf+JXd6+oUVcOvCZq+BwDdWTcE5tV+7q
         n1Ygrv4h/Ntl7mCWtYEOygoWFCS2kjubbBkqfdFFG5ane3htH2s7c7dDxKYoh5NKaeYb
         OW2bu13h1R8cCprmWHQASXa8f5eYQx/EE+T+/bx/orD43AUVeHJ9oresEXMCW+ohj8yY
         hHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785686747; x=1786291547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQmpfn45uaTNNsHtj+z4E83LXS4CJJjfzV+3sS08LV0=;
        b=dO4qUz9VamN3xVMxOt7Sa4p/ELOHbHZjcnm9bYkIkCmQNeDaUmdfY1sb4jqMUArWP1
         8HB2M4teRqao9vdswVXKP67Zs2IzgP873rd2Ph3B5A3XtZ6UTxxdUTegox9GcZvshhOv
         aWyxgqs81RpUX8piqNE+QHtC8d8H/UJIgKaPSDuuMT/S+S/sZ9tWm30pFx9eidDtdV3B
         HBBfcuxctEPy0GOJNklBIETAU3vM4wpJWyBgmbi8X8acHv17PYBGpPWQAW2PqhmTnNsr
         W3udNh3POpNfGiHM/QRoZoui+Bhod6TyVp3V4ILa2z4c82O+/sgDhLg2JERovPhOliVO
         sLaw==
X-Forwarded-Encrypted: i=1; AHgh+Rqb7X7VvQw3FHJVnjmHGpyDBNoHPVI2fwVWjQEUSt9MdnTtq+eiU2QzMaF2evxwnIPjukC1Z7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDXHcaNoaftwj28UGCkJPWYF8KqSn//dCTM7y0VUWvlg9dkJx
	4I5ryiorY+rFILNom7Te2uK7/jH69nlTpDHqmriagzj8sasdTAhRBe78
X-Gm-Gg: AR+sD10eYuBicIMSWzX4+NtyaNEIXlaRmf1XZMubjkEu3/UeRQvbPX82GANS0sgR9ux
	Dkbt2ZQ0SNgHk9K6MvNIlUFGhAgXvI7ck+MEFm9dwIInrPUOV5l+GSVRclxuAME7hZJ708gLDwr
	SZCvnAXy/OhPaIK+W4akosEFOGdV0py53YAqTvllgc6cBcb0m53MlsKQKlKeTfli9psVy9JoewW
	+eMPE8/LxF8EqIiV/GEtTrkay5jpYn0ehk1jhciGOIXzJM3xjO7o5CGzzMJk3C5R+Cwe9MaIIHq
	lNLiSPM6BYRqIMhH1TfYIlnKdXlzLtIda5PU4BAA5fyP8oFLvHaw95nUXgDwqbatjP6FnX8BCrn
	m+D9E/RY4R1S58cuNl3rOmgCiZhgZ3MeSOHPfQe2SXK+/ZJBP5y5fjdX/afRMIARyWWdJTVCsCQ
	bK8OpbVlyFtpdZm7e9LfrpfjCKKZeK8nWNucAatqvy3rYWZfOht4ZhdYEj8Y6oeviPJFGL
X-Received: by 2002:a17:902:d489:b0:2cc:61e8:5fba with SMTP id d9443c01a7336-2d05244492amr68660835ad.32.1785686747186;
        Sun, 02 Aug 2026 09:05:47 -0700 (PDT)
Received: from Hybread.localdomain ([118.100.92.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120fe0sm26777115ad.67.2026.08.02.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:05:46 -0700 (PDT)
From: Koh Tom Han <kohtomhan@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Koh Tom Han <kohtomhan@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: validate sta_num in ALL_STA_INFO event
Date: Mon,  3 Aug 2026 00:05:40 +0800
Message-ID: <20260802160540.1072-1-kohtomhan@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7996_mcu_rx_all_sta_info_event() uses res->sta_num, a __le16 taken
straight from the firmware event, as the bound of a loop that indexes the
rate[], adm_stat[] and msdu_cnt[] flexible-array members of the event.
The count is never clamped and skb->len is never consulted, so an event
declaring more stations than it actually carries makes the driver read
past the end of the received skb.

The strides are 20, 36 and 12 bytes respectively, so the worst case
(tag UNI_ALL_STA_TXRX_ADM_STAT, sta_num 0xFFFF) walks roughly 2.25 MB
beyond the buffer, in softirq context. Out-of-bounds wlan_idx values are
range-checked by mt76_wcid_ptr(), but the break statements inside the
switch exit only the switch, so the loop keeps running; indices that do
fall in range accumulate out-of-bounds data into wcid->stats, which
mt7996_sta_statistics() exports to userspace when WED offload is active.

The return value of the preceding skb_pull() is also discarded.
skb_pull() returns NULL without modifying the skb when the requested
length exceeds skb->len, so for an event shorter than
sizeof(struct mt7996_mcu_rxd) the pull silently does nothing and res
ends up aliasing the RXD header, taking sta_num from arbitrary
descriptor bytes.

Check the pull, require the fixed part of the event to be present, pick
the element stride for the tag being processed, and reject any sta_num
that cannot fit in the received payload. The subtraction cannot
underflow because of the preceding skb->len check.

For comparison, mt7996_mcu_wed_rro_event() in the same file already
bounds its iteration with "while (skb->len >= sizeof(*e))".

Found by code review and confirmed under KASAN with a KUnit test that
feeds the handler a synthetic ALL_STA_INFO event carrying four adm_stat
entries but declaring 65535, using a kzalloc-ed struct mt7996_dev (the
handler only dereferences dev via mt76_wcid_ptr()). No MT7996 hardware
was involved:

  BUG: KASAN: slab-out-of-bounds in mt7996_mcu_rx_all_sta_info_event+0x19a/0x3a0
  Read of size 2 at addr ffff8880012422a0 by task kunit_try_catch/28
   mt7996_mcu_rx_all_sta_info_event+0x19a/0x3a0
   mt7996_all_sta_info_oob_test+0x24b/0x360
  The buggy address belongs to the object at ffff888001242000
   which belongs to the cache skbuff_small_head of size 640
  The buggy address is located 32 bytes to the right of
   allocated 640-byte region [ffff888001242000, ffff888001242280)

The same test passes cleanly with this patch applied.

Fixes: adde3eed4a75 ("wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic")
Cc: stable@vger.kernel.org
Signed-off-by: Koh Tom Han <kohtomhan@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2e83f4b79..65d9ae11e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -648,13 +648,37 @@ static void
 mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
 	struct mt7996_mcu_all_sta_info_event *res;
-	u16 i;
+	size_t elem_size;
+	u16 i, sta_num;
 
-	skb_pull(skb, sizeof(struct mt7996_mcu_rxd));
+	if (!skb_pull(skb, sizeof(struct mt7996_mcu_rxd)))
+		return;
+
+	if (skb->len < sizeof(*res))
+		return;
 
 	res = (struct mt7996_mcu_all_sta_info_event *)skb->data;
 
-	for (i = 0; i < le16_to_cpu(res->sta_num); i++) {
+	switch (le16_to_cpu(res->tag)) {
+	case UNI_ALL_STA_TXRX_RATE:
+		elem_size = sizeof(res->rate[0]);
+		break;
+	case UNI_ALL_STA_TXRX_ADM_STAT:
+		elem_size = sizeof(res->adm_stat[0]);
+		break;
+	case UNI_ALL_STA_TXRX_MSDU_COUNT:
+		elem_size = sizeof(res->msdu_cnt[0]);
+		break;
+	default:
+		return;
+	}
+
+	/* the firmware-provided station count must fit in the received event */
+	sta_num = le16_to_cpu(res->sta_num);
+	if (sta_num > (skb->len - sizeof(*res)) / elem_size)
+		return;
+
+	for (i = 0; i < sta_num; i++) {
 		u8 ac;
 		u16 wlan_idx;
 		struct mt76_wcid *wcid;
-- 
2.53.0

