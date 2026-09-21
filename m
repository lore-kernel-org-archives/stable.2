Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F64A99D6
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002475; cv=none; b=rRmkxVcMNm+fCdV4tWbtyzj6c+z9yJgtZsRVZwTe9WDzVkQ5GY9wcu/YTJrISLvXQ9BYn/H3f7yLHfKqEFjBcFeTfW3DvWi6VxxRexUg/0eakx2RipWWFPlogRzfDzUd4Z1xozIjvA2KjWrqdRL0DnhXNA5HD7pHwagXEKq28WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002475; c=relaxed/simple;
	bh=kiEKWx34GSLChiV33AtGscUKajKjswXMbyM45TD9rF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDujNiiu/5GSdDjiT0fi3Szxg9799KskFwIg2Bs+Xlqhu5kDkLMaDPYKzjs92pI/PWgB16jd6nLM7wTCNRLE+0cffx7ZLKoBuOKVqNJYsaXNN2EP9MyDTjieoWw9Gm9V88J+oHVTfClrlYeVNQM7EdU00TN8HIIsCdLan0pLIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaPDv5mm; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaPDv5mm"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so2095836a12.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002473; x=1790607273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=55jBginyPAWykGAECg1kcDGv2/bNXqJ6rxbJ7xeJwNc=;
        b=AaPDv5mmw3ksdc6KIW4sWaqOYrNgYqsFbvTL4m8XMdRt72y18ar+Yih9CmuIdoqtZv
         Kz0M1KR/AZQr8ZfE4+DKxSnVFduD4N/0ic01dvQ/+AWNd2aNtO1F8s3/FiXkjFmFJ6r2
         ptOMVLpGvUkm1eUG2VFZzRwg7BdR7P/5jrKE8uAOXBcQ0AWCKFLynYrOM3chOkJD4SKV
         YIM6J9/agPGN7CbrQJust1yXHZuaF3EDKYSzge9eSxUTEy9uFWGMFOuqqUKapQ6QaPis
         2e0hlJIw8RUkMpW1dSZfbqMV74VRT9NGdEp8YZWT45h4RX+4wEzquNTUWH6klfpg7C3h
         byjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002473; x=1790607273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55jBginyPAWykGAECg1kcDGv2/bNXqJ6rxbJ7xeJwNc=;
        b=rsF13LG74rkjOZtqeeA8Ul04dDXavug6xSDU66l11mN1T3ZnBjmy50AeGCvAOHKeuW
         vanxZXarQP+PNGIoJUiACX20mw8VUBNY7/UAvZeZAFVOztFesgQtcEa/4PCoRyVODjty
         jf86VMTBpWthZv5QPfl52VdLfhpnSGSrJfrFySwtVAcKdgCoA0/5Ep2Xkws0xTrsbidb
         lOEHMqDV79raV9X4ohjvFp9GQftut0eic7N1qIJyR4Mzwf0o918g82qD6b6GB2NRhPme
         ewFDEs0sHgc/CrnxmQTAAciVIDqbCPJmWzlf6ZdhXNCrx6cga1NwMvcrfT21N1TGtNHc
         MA+g==
X-Forwarded-Encrypted: i=1; AKwUvBysKjow8pLUmh7U9bQDANnyjVUKcAhvycHUXYO7VZmx5eD960lThmciz50/A2IiGdCzgp0+P3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++npEGf/80WxPLP9NdU4czem4vxL4dK+zAzDwuUhdqA2mcnLk85U
	qjq0JIk6Oq4xZzcsxpL6+aHmBH9P0qusauiL30YKQ18RFXrROn8T8Ql4
X-Gm-Gg: AYBFou3N/+efO39eSnU+07sghOc7+lIuxWwQRXJ7qjF4g0FSNRk3WqIU4WkxX46mnel
	um6BLL+5Fchrh/YiYK0mi2+vMB8J31+CNYeg68/ObqV4I2ayXf8fsvKYI/ZhcH+ciwzVBX/VHt2
	RSlyN3oq9GziiwLYxTmtKOY2yjmxJqTB0LHcK4go9O95nmP8LV2r4wFRjlwVvgV5f9J8ar9VZhe
	xYwhYz6kdQkAFGgwqollbU/E5YUiWQbrYb9UasrXFHBUze+gmfTOk7VD2xNTWeJ3C76MfQVt9Aj
	J+OtLXqe45d2moIzVMrO+r0FtjUOqQmBfIPLSLyAWJNAoXdszGc2Zj72TcAoO6SZTb/249Q29em
	LsaoSBBup73+yNtGr2oolHgoVRBEJCyQYbOYxVTJ9fVNILj26TJCY1DMHPyvStTFIGvJPRTdQOG
	dXnfFpvqC53rzAmfhaD+JSpRC7WzWj6it6sacKUetgi6FMaBznMSj3n7gCS89WmPUoaw==
X-Received: by 2002:a05:6a21:e584:b0:3d7:b3c1:cc34 with SMTP id adf61e73a8af0-3dd8c41a56dmr13850919637.26.1790002472781;
        Mon, 21 Sep 2026 07:54:32 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6bec901sm3343453b3a.4.2026.09.21.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:54:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] net: mediatek: fix PPE resource leak on remove
Date: Mon, 21 Sep 2026 22:54:21 +0800
Message-ID: <20260921145421.443018-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PPE teardown is incomplete after both probe failure and normal
driver removal.

mtk_ppe_init() initializes a per-PPE l2_flows rhashtable and creates
debugfs entries, while mtk_eth_offload_init() initializes the shared
eth->flow_table. Flow offload entries allocated by
mtk_flow_offload_replace() can remain in these tables for the lifetime
of the device.

mtk_ppe_deinit() currently only destroys the l2_flows tables. It does
not release entries in eth->flow_table or destroy the flow table, and
the normal remove path does not call mtk_ppe_deinit() at all. PPE
debugfs entries are also left behind.

Drain eth->flow_table with rhashtable_free_and_destroy(), clearing each
PPE flow entry, dropping the WED flow reference when necessary, and
freeing the flow entry. Remove the PPE debugfs directories and destroy
the per-PPE l2_flows tables afterwards.

Track initialization of the shared flow table so partial probe cleanup
is safe and the table is initialized only once when multiple PPE
instances are present. Also continue past missing PPE instances during
cleanup so later instances are not skipped.

Call mtk_ppe_deinit() from the remove path to perform the complete
PPE/offload teardown.

Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Drain and destroy the shared offload flow table during PPE teardown.
  - Remove per-entry PPE and WED state before freeing flow entries.
  - Remove PPE debugfs entries during teardown.
  - Continue past missing PPE instances instead of returning early.
  - Track the shared flow table initialization state for safe cleanup.
  - Call the complete PPE teardown from the remove path.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |  2 +
 drivers/net/ethernet/mediatek/mtk_ppe.c       | 13 ++++++-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   | 37 ++++++++++++++++++-
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a..04d0a1eec4cf 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5394,6 +5394,7 @@ static void mtk_remove(struct platform_device *pdev)
 
 	netif_napi_del(&eth->tx_napi);
 	netif_napi_del(&eth->rx_napi);
+	mtk_ppe_deinit(eth);
 	mtk_cleanup(eth);
 	free_netdev(eth->dummy_dev);
 	mtk_mdio_cleanup(eth);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 0168e2fbc619..c1ca8af6f356 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1344,6 +1344,7 @@ struct mtk_eth {
 
 	struct mtk_ppe			*ppe[3];
 	struct rhashtable		flow_table;
+	bool				flow_table_initialized;
 
 	struct bpf_prog			__rcu *prog;
 
@@ -1508,6 +1509,7 @@ int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id);
 
 int mtk_eth_offload_init(struct mtk_eth *eth, u8 id);
+void mtk_eth_offload_deinit(struct mtk_eth *eth);
 int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		     void *type_data);
 int mtk_flow_offload_cmd(struct mtk_eth *eth, struct flow_cls_offload *cls,
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 8451dc3fd00a..f41df3cf0e2b 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
 
+#include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -946,7 +947,17 @@ void mtk_ppe_deinit(struct mtk_eth *eth)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++) {
 		if (!eth->ppe[i])
-			return;
+			continue;
+
+		debugfs_lookup_and_remove(eth->ppe[i]->dirname, NULL);
+	}
+
+	mtk_eth_offload_deinit(eth);
+
+	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++) {
+		if (!eth->ppe[i])
+			continue;
+
 		rhashtable_destroy(&eth->ppe[i]->l2_flows);
 	}
 }
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index 99b28aaa7cc4..5b14c7b3052f 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -678,9 +678,42 @@ int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
+static void mtk_flow_offload_free(void *ptr, void *arg)
+{
+	struct mtk_flow_entry *entry = ptr;
+	struct mtk_eth *eth = arg;
+
+	mtk_foe_entry_clear(eth->ppe[entry->ppe_index], entry);
+
+	if (entry->wed_index >= 0)
+		mtk_wed_flow_remove(entry->wed_index);
+
+	kfree(entry);
+}
+
 int mtk_eth_offload_init(struct mtk_eth *eth, u8 id)
 {
-	if (!eth->ppe[id] || !eth->ppe[id]->foe_table)
+	int err;
+
+	if (!eth->ppe[id] || !eth->ppe[id]->foe_table ||
+	    eth->flow_table_initialized)
 		return 0;
-	return rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
+	err = rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
+	if (!err)
+		eth->flow_table_initialized = true;
+
+	return err;
+}
+
+void mtk_eth_offload_deinit(struct mtk_eth *eth)
+{
+	if (!eth->flow_table_initialized)
+		return;
+
+	mutex_lock(&mtk_flow_offload_mutex);
+	rhashtable_free_and_destroy(&eth->flow_table, mtk_flow_offload_free,
+				    eth);
+	mutex_unlock(&mtk_flow_offload_mutex);
+
+	eth->flow_table_initialized = false;
 }
-- 
2.43.0

