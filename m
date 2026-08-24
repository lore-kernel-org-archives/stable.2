Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605792853F3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537698; cv=none; b=C+ks88TZqopZ1QfEGsqgUbRn1nbw6AecFaZbPn9M+8Kyfm60TX/8CIZrRoL0VxnqfT2j2U36cX4CSg47797AaW0RG7CmD1PbM9OW4TSupOb5bUPfcAYJEIxID0coae4NSSYJFctmEg5KWlhVVU6X5hlXcQX2lqovFe0UIXWq4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537698; c=relaxed/simple;
	bh=NtQ2IOM/Mh5R17rSUOh8SsBc1MqYsMk2h3KzjPHs0PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OG4NBs8EiKnLxgTD04QAf5kyOEVqBQCE+AoyWG+2Eh3LLAtkYc5oipgAsYw4Rcwsbs/TNRHvswFu5Ov9Ws22Rsv0OVXHGBGQODEBC37Heplev6w82wh+GT3Nb5ni8RDM4qWgAQyPRvCwcBgw0bRTkgD8OYlQc9B5nY7any5y408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wQVvXueO; arc=none smtp.client-ip=91.218.175.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQVvXueO"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NtQ2IOM/Mh5R17rSUOh8SsBc1MqYsMk2h3KzjPHs0PE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787537693; v=1; x=1788142493;
 b=wQVvXueOFLtDN5Vz2tgoyaSRzYAX7FfBDKUOiijLrQlo2B4jI0dhYuab3bIgZezb0devHpaf
 8ONXFs7as3ZARCG/vhHg2mxL52GZlfBk9BR9XRzM04jrRUYlAxcprZSyp1kk9GYUnV9DyaHQKSR
 uxGLG0tcaX8dIPAVqwNrobIo=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by mta10.migadu.com with ESMTPS id 9bf3271d94a12da4;
	Mon, 24 Aug 2026 02:14:53 +0000
X-Mizu-Trace-ID: 9bf3271d94a12da4
X-Migadu-Flow: FLOW_OUT
From: Yi Cong <cong.yi@linux.dev>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Yi Cong <yicong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon, 24 Aug 2026 10:14:29 +0800
Message-Id: <20260824021429.43761-1-cong.yi@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Cong <yicong@kylinos.cn>

Returning a negative errno as u8 turned -ENOENT into 0xfe, wrongly
enabling CNM and NAN caps. Return int and default to no caps on error.

Fixes: e8a264ccd2de0 ("wifi: mt76: mt7921: move init shared code in mt792x-lib module")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 0ad33f74c2285..297c8a9f41ba3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -857,7 +857,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
 
-static u8
+static int
 mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -926,13 +926,20 @@ mt792x_get_mac80211_ops(struct device *dev,
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
 
 	if (mt792x_needs_cnm_runtime(drv_data))
 		*fw_features |= MT792x_FW_CAP_CNM;
-- 
2.25.1

