Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191705;
	b=H0DHEIeaqU+xPZ/Kx7E2DzI+CQtBCgyQRKaENTh4FyUrO6uKFewXWZUYg8N/VdkFpUgQ
	 PYUnCgTjNDBz6InjSO3VF621LB+5gR5o0huxLLIvQdroBwLpNL0mijBkDV0U9JEiMbGdC
	 V7sOKoDQxsP+so8K7O6y7SmbHZCetd0hskbe44iD5UiVj1MuA6ZUwvspz9yhM+PXqV+lA
	 yeJSOnab0xHD4Eyu6f31SA7OjesrHAFvXIz0nsDJw6Kq8dw7Z0rGg6oKvWBo2+6DATuwX
	 nLULTK+uENn7yBK2rsM9q5QsMNGUGb6KbYvUIc5oTWuDvDiASTI9l62jnKOtNUQ1DVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191705;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pld/ypOEzvUZ1Xv2JYaevgXucwA7AzT9S4ayBCKuL5Y=;
	b=qadpgAc1hsN9ZagwG49Z2h3o6apPaHr+WRUrg3htZqvstzCwLJYlbxjseoOkLxypdxF3
	 XJnseukKmvGONsjiUXWtTRZPGyRKZoWRXX9t8dYg+4Xmho0FykPHb77TjnXSdM9S2zlfW
	 0nDGH0x7s/y/5NyZUMwUZ2QlNrtvL0txQAPOyKX/4t9MXg8F7VYkxkF3q34g3Ujid1190
	 vk5KRL7G7KUergETtQDB23U7sFyW1YoFt6WycW4m1qs0RvZHVR22Pj6upgiHIui7C4Sx7
	 50qU0tAuOLmXrJOxgc/kdpknqGvVNHXmddUhz7Mj58WP+w4E+JQNuifvGUz33HpDUPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=teqADy5g;
	arc=none smtp.remote-ip=91.218.175.99
Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E014606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E014606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=teqADy5g
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2lyP7MNsW9NOFL7Y9LVDi2zqIu+RzquUmDDPyYap5Rs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794191702; v=1; x=1794796502;
 b=teqADy5gls3z69Ns7Kr74fMniykMQIWn/YKKXLPLdpQR7WOk+tuqgGCzKMeOxP9+KT6ujd7i
 7AQ66/1S2b35G6K6ar77i+QecOEzbBEka2C6px+lHk4rFFPJ1QK0uH7ZQCH19TyU/lllD0gazNz
 FqREk8kOQZ9Arcq84w08PIcE=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5df9f00c67852b27;
	Mon, 09 Nov 2026 02:35:02 +0000
X-Mizu-Trace-ID: 5df9f00c67852b27
X-Migadu-Flow: FLOW_OUT
From: Yi Cong <cong.yi@linux.dev>
To: stable@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.18.y] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon,  9 Nov 2026 10:34:54 +0800
Message-Id: <20261109023454.52603-1-cong.yi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261107050921-failed-6.18-d0115096429c@kernel.org>
References: <20261107050921-failed-6.18-d0115096429c@kernel.org>
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
index 96c50a501c1a..d00807075c71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -704,7 +704,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
 
-static u8
+static int
 mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -766,13 +766,20 @@ mt792x_get_mac80211_ops(struct device *dev,
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

