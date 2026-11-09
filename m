Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191579;
	b=w2v0j+8ISdXjW95C9iyHw0ab0opg9OSkXPc4BHFcdFCrO6r5dobCmnmHpRHGbxAxWxIF
	 2WfdU8KdZ7u24NZ+u1QDqIw7ENGnaZ3B/m7/M3tBcZY6mXgBcfYUnMIvt/yKY88Sk7ffY
	 6RlHrBniXaLZ2sl5vjiv86VERbN2ZEY+36o8K6wOC/khaOF5DhWclKa1KLWdZw65opnKx
	 iFREKOcohWzya+nR8BBRasWKX7Nqt2tIgGE0WvyxH21ZWkUBoaTEI5y+ZChNf45l9thEl
	 kfXglET9Cfa0DbAlnvcnIr97D8ydPssykKnl8YotI+1K5wLHz4DGRalqt35DGN3TeHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191579;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIU40uoVM7ZS1m9bivx5oi5SjikaIH2lZA+l0QqMwpU=;
	b=WHNTl5uDp9E19FVCZFkjl4y2eqpXhfKR3EYxwbXcLQqnhdMq76h8e6bKeEtygqCxbBVr
	 PCLcS16b0mMj3JNo0ukQpklazcJBwgXSho2f6cePQOIeoJI3nvJUnrBeDUJCFHw1/Yb4K
	 i9dwrZ0mfe0epQaOObklM6JFQPrTOlascUBVuY/z5cbm7VI9GufIfwr2Si8zqBgDNPJaq
	 8Pqp5TGC/+2n5pimi0zKNKkoKjUeDAFHQKzYekLVUlHQODFApMg1FcJiCUmmT+z8ggrkL
	 sECe8qkPq+y44Msx+LpGVmRVLeo8LLi2UwEpNsKHHH/1uzLsN2amvvRpZJznbiQcTEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KxQOJYLE;
	arc=none smtp.remote-ip=91.218.175.62
Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D6606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 802D6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KxQOJYLE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oBKdXSCyFnTZRor56F5yfiRU9teZqTqvsicnxR2Blz4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794191576; v=1; x=1794796376;
 b=KxQOJYLEAgg3JvVaq801Yh4QbBf3uC+5DA/cRS273hRWIx0810NC62vNFezUJZ5Lo/oFOJEU
 LNgZbYdX8ttoyu+kilnxPBcwvPE0ourSL7dASKI9DQlvGoc+PQ9fzay10SLPQzWr8HEZseeOu3Q
 uO7orcxPnuM9z/cQkLh5+XG4=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8995417d822701fa;
	Mon, 09 Nov 2026 02:32:56 +0000
X-Mizu-Trace-ID: 8995417d822701fa
X-Migadu-Flow: FLOW_OUT
From: Yi Cong <cong.yi@linux.dev>
To: stable@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.6.y] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon,  9 Nov 2026 10:32:45 +0800
Message-Id: <20261109023245.51991-1-cong.yi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261107053233-failed-6.6-d0115096429c@kernel.org>
References: <20261107053233-failed-6.6-d0115096429c@kernel.org>
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
index 66806ed4f942..d990e34cfcd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -591,7 +591,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
 
-static u8
+static int
 mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -653,13 +653,20 @@ mt792x_get_mac80211_ops(struct device *dev,
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

