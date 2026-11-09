Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191689;
	b=hSEulGjblY6TXaR/c9mofiOjhc3F4BSf0whwDj+SBZwE2FztLkyZUwtc396VCpqUTP2N
	 qbJSKMnSUqHusXKM+seo5jJmysTS3cuCC1A/AhWLn2PoNtRYIunVvjaweChotD94WdR65
	 7j0+BU64WfMDchbLaSu+jdDEZrunTF7Lw5FyxzIOIaM8ICbWf54DUzzlA89LksCvUBXgp
	 jrAPPCT26/F7xxH2f7vD5CbE22fy4/JgZrVNcJq11i31FLrrsFS4PFQfpXyoBTFABAZvB
	 g9ZloldaIS53yrPcHiITxRicTShrQZhOwwvAY6c0ePDhIndTLjwnzDrSMGUGBca+lzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191689;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XyLPAL3r7rsIPkKle+e6mDaQ5rTigPO2zU8QoUI1Nxw=;
	b=q6oxAgSjwGI8wvdF0G8gLUUmWAfcZhditP012q65tca+/TEZwnPmPfFTdgEF0q+Dj3dV
	 ZEL6o4lmQODOPEpEv6jei/kzW6+8BTUUoWy1nfG2tW6uVnc45kTsVCEQNZlIhVV0vRBsz
	 LfjJ8spgZ2e7/82fko7FdQaR5xv5eY89BM1OxWdmy0gS970mAooE3XWmxTpGgAMQbD0FD
	 SxEQRZAhSzKBdJ0Cjy80bcFIBFqXz5y7QkV7OHcUBf/SjEy+UAfswV0ReVMpiUpdVeqn2
	 yrsKz5x/EmM/8fCB7Hpb36rHODpNIWjnZ+X9HQcnqO/M+PoFV4lSdWTTFODg4KJzh5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uUCauczF;
	arc=none smtp.remote-ip=91.218.175.96
Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F2606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A9F2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uUCauczF
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1tQ1P15ffn/4hxtBpcvN+Ii8H1SXsICt7jl9y6HMnfI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794191686; v=1; x=1794796486;
 b=uUCauczFEejkwx43Q5kFy2d1vK/hvdLFlTUS4hE/h/1N+tP7y7rV7WOlXHWuGZGg3xYTEZQg
 tdHXy/1j0EhTn7sAv/hZ74KJaSe4PAmbh363UE4NbowZ9jgtFqmbylyreqg0wBOXskI7m0tZZTK
 X41sCu5RG5KlCZD1zJY10cRo=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2ddbcf87043b2216;
	Mon, 09 Nov 2026 02:34:46 +0000
X-Mizu-Trace-ID: 2ddbcf87043b2216
X-Migadu-Flow: FLOW_OUT
From: Yi Cong <cong.yi@linux.dev>
To: stable@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12.y] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon,  9 Nov 2026 10:34:36 +0800
Message-Id: <20261109023436.52407-1-cong.yi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261107052007-failed-6.12-d0115096429c@kernel.org>
References: <20261107052007-failed-6.12-d0115096429c@kernel.org>
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

From: Yi Cong <yicong@kylinos.cn>

Returning a negative errno as u8 turned -ENOENT into 0xfe, wrongly
enabling CNM and NAN caps. Return int and default to no caps on error.

Fixes: e8a264ccd2de ("wifi: mt76: mt7921: move init shared code in mt792x-lib module")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
Link: https://patch.msgid.link/20260824021429.43761-1-cong.yi@linux.dev
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit d0115096429ca090a592770c7645f9553a839954)
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index c6afdf90fade..a3ca93c9af63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -658,7 +658,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
 
-static u8
+static int
 mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -720,13 +720,20 @@ mt792x_get_mac80211_ops(struct device *dev,
 			void *drv_data, u8 *fw_features)
 {
 	struct ieee80211_ops *ops;
+	int ret;
 
 	ops = devm_kmemdup(dev, mac80211_ops, sizeof(struct ieee80211_ops),
 			   GFP_KERNEL);
 	if (!ops)
 		return NULL;
 
-	*fw_features = mt792x_get_offload_capability(dev, drv_data);
+	ret = mt792x_get_offload_capability(dev, drv_data);
+	if (ret < 0) {
+		dev_warn(dev, "failed to read firmware offload caps: %d\n", ret);
+		*fw_features = 0;
+	} else {
+		*fw_features = ret;
+	}
 	if (!(*fw_features & MT792x_FW_CAP_CNM)) {
 		ops->remain_on_channel = NULL;
 		ops->cancel_remain_on_channel = NULL;
-- 
2.25.1

