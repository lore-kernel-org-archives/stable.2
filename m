Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936921;
	b=qlTTese3XnIOFj8jPRd4DR1RaS2e2DtKYoAw8rAmwVri1JwiOVUuifKpiN0ld9JIPZN+
	 sD2MXWqkbOqEnmu67p+LNMsqIIn7vO67IYrDBE0mNu9kKvBLgLpfE6HGduL+sNrURIsDe
	 OwqBdh8UEFS4PUqIv0bF+oFzL0DkOZdEcXx6Tgp/m6zQfJRdoreBiloriobxnJPSk0HX9
	 Eza+uS+T4h8r2IcrZ+PkIX7Fkj0oDdqB+ryr2onlxJPya2Cg9IdK+JluF/pKfnLamzDDL
	 krKvyUcE2igUcH16lUHSvPtQRrhcmamxHDU2aRixEj2sFGnGk5IbnH/V76f9BUJu8UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vrMXt1z7sqI2rPBLPoXnJ9DxZ7jNjEuTfkEKdCrv0eo=;
	b=tFef5VzZ4YxJmzz/A6S1MYou5l4BF84jh58DyhudU6DkCcK1iR3mt9hVhSDQyGU/DAUD
	 ryuyOHS3ncLCpffE2XTjr5h6VpaW3aMJrwnqbnCmfWgZ+ZKWRc1I1XdiyTc3EGFHg2L8M
	 n3oi0BngZ0QElUairgCBCGedZPxnH3Q29Pt7FDlUSvnd/aG02zsx2+T7t5yCmzDna/t0V
	 GeQzzRsMfTO4g+uf9VCaW5SbFv+Cff8U3CKxDtXbAGwcRKSwTmcf+p81HSZABK57K/feE
	 VTXMTB2HAFJANlyG/iybh2kgSa1zh3pWOIG7hQNRY1aMJFoewVh4DR/TISdinq1HEKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qTIefrEl;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27C606A328
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D27C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qTIefrEl
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so3561393eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936920; x=1793541720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vrMXt1z7sqI2rPBLPoXnJ9DxZ7jNjEuTfkEKdCrv0eo=;
        b=qTIefrElyFSBonKz3NWQEjyMYd2mF5liGilEmC2qnXcQs2bY8gzLi0n9lTS9i4yVw0
         IjWK+TrbICAO6Mjq4nUDMZM901xSQYWk8PCuUpR0X536VWB+2yoQcMa0lsT8Dq8FSL2j
         B2f20NHADJ2PA19gm48G1ZHuvHaoUNIBmaAZsR0TQdpzQWpNl+wY7zQe2CfC+7woBY/D
         EftUZEBtRWub5um0Ham7K+9R9HcEm247U9pswSPkDaads3zr/S1BS3NuBc5fDmh8dK0R
         T3jEXlgigFcirNCJh09dvo95zsHuICwitlsUTGlVTwzVHkt2aLo/sDUDu/QI0OZ+jxJ1
         lSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936920; x=1793541720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vrMXt1z7sqI2rPBLPoXnJ9DxZ7jNjEuTfkEKdCrv0eo=;
        b=jUxRz1fzmv9S6DcL52RIeZULeqsH+Do7qbdw+GCWT1tSopbzRxjkfaUFc/zfybhGv8
         FrNktPAX94N7f4kF8fxnyAoBw4M5SNZC3NGavIS0EZVzVMjIo/C+xdXzXbaaZNIR8b3k
         LXzTu3xfWkknvlREeBz9cDAPg6axgM9oleoYoaIuAMmV0Y0Z+k7Ll2eZi6J8DJbhXWrT
         zrdIy/wuDKLLz0+K9v6wiFcyJL+YqTBLWqkDUqU85hce2FWV9Wk6f96RKtjlFTv8jc+J
         PVaJvAlu8tobhha1o5PK2qc4OBlTnHMTKrIY5d+1u3E+4oHkRbXmg7vHTZOVtb7YinKl
         Lxew==
X-Forwarded-Encrypted: i=1; AKwUvBxOU/zvuTAtFHv/o63glkahksS0VRy7zHJUMpqTdNfPC+QpMynsdjZL3MRuYby+gJM+S2WxRB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLehw3ZGqbOVk83GgPiTdaEQSFCYhGv6YGcRAvnB8Gtaver40v5
	si2sgGM7q2f4Co5PcZL6uE7n4KgR1RKgGigxI7nDUDsaPzNB4QZDi5fY
X-Gm-Gg: AYBFou31HHXTyZaVV5hsm57pVUs3mt1PHjKiIbXDBC+3DYyF0Wl59UikmpNwfcH4eQ0
	yDuE+J9Tr8kZOm58LJ4W5JHflzSY4Ox36/sHwcnUaY7pf2s4JOA5LhkyqODDi0pN6NyIHR4tNVe
	ScXEqMQDxypS7Aa839Nqp/Y9thucTpRmdqlXXneV7V+w93PBbENrzFjd/cRaDS6205bQzCvISxt
	+sJzTZiW1zrzytNRoU2EnkScqi8nL1cS5RJHZQw8BfqLkDStb2cOnuNpBc5gYGxDJXdsI+zsCYi
	wT/FhmzTLlmrpAIBOTYwnKJtwajs1Xha/NmKFtnO0DcapKK1lRRpO1e61ca5uQnNrVeabev7oLz
	JmKiQBK4o6VKNK45lrEDxojjhQqVUIPDY9xf8dYQTMp173vde0VflmrrpS3pkgqqkXdN3zqs9th
	FQQ5Kh7UKWk7zwahyQRqAUCqKi6ODzQyXkjaeZ4UAyH4psA01OgCSVooy3rWrWNSzRV292dgAWy
	+OdN3jwSZP9w9Wk+IAt/htGq6RRgTJmaC/a9vdW6zDmkOUU7X5anx5wMKoj1P0vLSL46aKiAqSN
	HV2M6F0PraA1p7yYhIgvOIpPF3XlSezomdQ3my4=
X-Received: by 2002:a05:7300:8aa0:b0:35c:ceb0:8bf9 with SMTP id 5a478bee46e88-369e84e00acmr6241494eec.38.1792936920256;
        Sun, 25 Oct 2026 07:02:00 -0700 (PDT)
Received: from Gris-Laptop (gia.grisge.info. [67.230.185.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm9280272eec.7.2026.10.25.07.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:01:59 -0700 (PDT)
From: Gris Ge <cnfourt@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Gris Ge <cnfourt@gmail.com>,
	stable@vger.kernel.org,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Devin Wittmayer <lucid_duck@justthetip.ca>,
	Stella Liu <yu-ching.liu@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7925: fix NULL dereference in CSA worker
Date: Sun, 25 Oct 2026 22:01:18 +0800
Message-ID: <20261025140123.12056-1-cnfourt@gmail.com>
X-Mailer: git-send-email 2.56.0
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

`mt7925_csa_work()` checks `dev->new_ctx` before taking `dev->mt76.mutex`,
but the pointer is re-read and dereferenced after
`mt792x_mutex_acquire()`. That check and the later use are not serialized
against a concurrent teardown, which can clear the pointer in between:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:mt7925_csa_work+0x83/0x160 [mt7925_common]
  RAX: 0000000000000000

`mt7925_remove_chanctx()` clears `dev->new_ctx` without synchronization
against the worker. During a channel switch mac80211 frees the reserved
channel context (calling `drv_remove_chanctx()`) before
`drv_abort_channel_switch()`/unassign can cancel the worker, so it can run
with a context that was just cleared.

`mt7925_channel_switch_rx_beacon()` is serialized with the writers by the
wiphy mutex; the worker is not.

Protect `dev->new_ctx` with `dev->mt76.mutex` in add_chanctx() and
remove_chanctx(), and validate it under the lock in `mt7925_csa_work()`.
Keep a local pointer for both firmware calls so the context can neither
become NULL nor be freed while it is being used.

Reproduced the panic by injecting CSA-less "abort" beacon, works well
after patched.

Fixes: 7900da40e315 ("wifi: mt76: mt7925: introduce CSA support in non-MLO mode")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Gris Ge <cnfourt@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 15d95ad32636..fb5f9aa3534d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2020,7 +2020,9 @@ mt7925_add_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
+	mutex_lock(&dev->mt76.mutex);
 	dev->new_ctx = ctx;
+	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
 }
@@ -2031,9 +2033,10 @@ mt7925_remove_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
+	mutex_lock(&dev->mt76.mutex);
 	if (dev->new_ctx == ctx)
 		dev->new_ctx = NULL;
-
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static void
@@ -2509,11 +2512,13 @@ static int mt7925_switch_vif_chanctx(struct ieee80211_hw *hw,
 
 void mt7925_csa_work(struct work_struct *work)
 {
+	struct ieee80211_chanctx_conf *ctx;
 	struct mt792x_vif *mvif;
 	struct mt792x_dev *dev;
 	struct ieee80211_vif *vif;
 	struct ieee80211_bss_conf *link_conf;
 	struct mt792x_bss_conf *mconf;
+	bool roc_started;
 	u8 link_id, roc_rtype;
 	int ret = 0;
 
@@ -2525,26 +2530,27 @@ void mt7925_csa_work(struct work_struct *work)
 	if (ieee80211_vif_is_mld(vif))
 		return;
 
-	if (!dev->new_ctx)
-		return;
-
 	link_id = 0;
 	mconf = &mvif->bss_conf;
 	link_conf = &vif->bss_conf;
 	roc_rtype = MT7925_ROC_REQ_JOIN;
 
 	mt792x_mutex_acquire(dev);
-	ret = mt7925_set_roc(mvif->phy, mconf, dev->new_ctx->def.chan,
-			     4000, roc_rtype);
-	mt792x_mutex_release(dev);
-	if (!ret) {
-		mt792x_mutex_acquire(dev);
-		ret = mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76, link_conf,
-					   dev->new_ctx);
+	ctx = dev->new_ctx;
+	if (!ctx) {
 		mt792x_mutex_release(dev);
+		return;
+	}
 
+	ret = mt7925_set_roc(mvif->phy, mconf, ctx->def.chan, 4000, roc_rtype);
+	roc_started = !ret;
+	if (!ret)
+		ret = mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76, link_conf,
+					   ctx);
+	mt792x_mutex_release(dev);
+
+	if (roc_started)
 		mt7925_abort_roc(mvif->phy, mconf);
-	}
 
 	ieee80211_chswitch_done(vif, !ret, link_id);
 }
-- 
2.56.0

