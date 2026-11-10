Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287474;
	b=kFCP3a3wnheXwl0N5Aadoh7n2S86nS2wrSogouXYM1k6M/5IfUtRltR7MUlO3OtFZ4Gu
	 GBX18XHEHHN3XSgjWkFsMd+JUgY7Wi6VTLxaHf5z5/BPdlj4F/H/h+/BRRWFxPtLHAdut
	 7eUjt0E1HJ8CPu/HGr+tNGqvulWpgjlqjIsuscbdnpO39kr94z2VsaZWZW6j7s+h+XJeR
	 iR6wiJcouzvcJWqUqJ9xzLo604CcM7OMvw9AIqtf1Oz5tFMwPRWBBItsRaHHXGECFteJz
	 NkHwa1x8CEdPlOcsSMZsmq+lUvVkWiR6b8N7NkAaBWUyoZLWmLRG6i1eUvz9EzIQiHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287474;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0KHxHLGCSjMaZdJVzGtC3gwPZ+cPw6fyKakHN462aiI=;
	b=fm+GpKU346I/ExbNzFlV+F6ec0rxjGIJ+K1QddQjYWwsF5s7SrKQEvIsmfZlaUWohXEl
	 E3jtjduBoTtq4FUASAS2UiPml4pb8fniSEKUmZUQYg4NDzKQ5KssT4Mr6wUIgy8VafeZ5
	 ldDkqDgpJGiSAKUhiqblbzFd07Y1rw27tQDtvcjne3jAmuWR0Y4E3CwWniEOmpcZ7RQT8
	 H1igHJ8ih+9t3195AcR/RrCj4+7nURVyTUntM5PosOuGM45byPqefvSPsSaiMk3mOPffa
	 GVgjvhAUfZsNwCReQl4iqDHnV/KOFfxCJJVT1nhGaIUyg36pO+xgaCiluecL9MaYQgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HhjeEzj9;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E446606A325;
	Tue, 10 Nov 2026 05:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E446606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HhjeEzj9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794287472; x=1825823472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kOTu7fmskKj7WGGmuTN7cLs3MDL06lBisA0cmWvz3Yo=;
  b=HhjeEzj9p6JSd2w/feQT6YoRrcVrR/6VVVmc+jBmlBUHd3dQVUjchpxs
   uZSNuDXecdWVaMcTG/kU0fP7U4ZSKVl0to6JfZpRniOzxRzfyJ7j3ATxj
   CpcYablnvLj7ElsiaLlwSy8tUuUXZrD0HgRtqUqFRAicU2zAjCc6zpHqW
   YGNL0TWCx5S2bIKtWCMh6Sh9B1vOZkDlcB2q+nNw30buNb24N5yRqGkU5
   ZROz7uLJ3LiDCDoNauToHEKlDw7igEJY4JwFCJqdT7JtiBrMUsFjMQnSR
   0coqv+LUq9H1KXV3NmbSbZBMvA+DCMPojye6CweiOek05wdYs7MkrZCNs
   g==;
X-CSE-ConnectionGUID: SjPSh15UTJy3PkS/8xPI/w==
X-CSE-MsgGUID: 2Ty/FvcvRkCtp+EA01Jhig==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3053770"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3053770"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:11:03 -0800
X-CSE-ConnectionGUID: zmc92CSQT+OxqrLhnpZFjw==
X-CSE-MsgGUID: P/zQYLPxQtSXVJjZMWgBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7926947"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa007.jf.intel.com with ESMTP; 09 Nov 2026 21:10:56 -0800
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	kiran.k@intel.com,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	chethan.tumkur.narayan@intel.com,
	lakshmipathi.k@intel.com,
	Ajaykv <ajay.k.v@intel.com>
Subject: [PATCH v2 1/3] Bluetooth: btintel_pcie: Add yoyo support for config set TLV
Date: Tue, 10 Nov 2026 07:10:49 +0200
Message-ID: <20261110051051.7800-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.53.0
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

From: Ajaykv <ajay.k.v@intel.com>

Add parsing of the YoYo CONFIG_SET TLV so that debug register
configuration can be supplied through the external TLV file.
Each CONFIG_SET TLV is validated, and its address/value pairs
are stored in the config set list of the YoYo context.

At the configured timepoint, the stored pairs are written to
the target memory region, with or without target access
depending on the region type. Write failures are logged
and do not stop normal Bluetooth bring-up. The stored pairs
are freed when the device is removed.

Signed-off-by: Ajaykv <ajay.k.v@intel.com>
---
 drivers/bluetooth/btintel_pcie.c       | 138 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h       |   1 +
 drivers/bluetooth/btintel_pcie_debug.c | 113 ++++++++++++++++++--
 drivers/bluetooth/btintel_pcie_debug.h |  76 +++++++++++++-
 4 files changed, 313 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index dadd79e4392f..166d1f13dff4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -927,6 +927,133 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	}
 }
 
+static void
+btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
+				    u32 time_point)
+{
+	struct btintel_pcie_yoyo_config_set *config_set;
+	resource_size_t bar0_len;
+	int ret;
+	u32 i;
+
+	if (!data)
+		return;
+
+	/* Get the length of PCI BAR0 */
+	bar0_len = pci_resource_len(data->pdev, 0);
+
+	if (!data->yoyo.enabled)
+		return;
+
+	list_for_each_entry(config_set, &data->yoyo.config_set_list, list) {
+		u32 pair_addr, addr, value;
+
+		if (config_set->time_point != time_point)
+			continue;
+
+		switch (config_set->config_set_type) {
+		case BTINTEL_PCIE_CFGSET_CSR:
+		case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
+		case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
+			break;
+		default:
+			BT_WARN("YoYo: unknown/unsupported config_set type %u, skipping",
+				config_set->config_set_type);
+			continue;
+		}
+
+		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
+		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
+			ret = btintel_pcie_get_mac_access(data);
+			if (ret) {
+				BT_WARN("YoYo: MAC access failed for config set (%d), skipping",
+					ret);
+				/* get_mac_access() asserts MAC_ACCESS_REQ before it
+				 * polls, and leaves it set on timeout; drop it so the
+				 * request bit is not leaked.
+				 */
+				btintel_pcie_release_mac_access(data);
+				continue;
+			}
+		}
+
+		for (i = 0; i < config_set->num_pairs; i++) {
+			pair_addr = get_unaligned_le32(&config_set->pairs[i].address);
+
+			/* Calculate the effective address by adding the address offset */
+			if (check_add_overflow(pair_addr, config_set->addr_offset, &addr)) {
+				BT_WARN("YoYo: config set address overflow (0x%08x + 0x%08x)",
+					pair_addr, config_set->addr_offset);
+				continue;
+			}
+
+			value = get_unaligned_le32(&config_set->pairs[i].value);
+
+			switch (config_set->config_set_type) {
+			/* Direct Address Access (CSR) */
+			case BTINTEL_PCIE_CFGSET_CSR:
+				/* Validate the effective address for CSR access (Direct Address)
+				 * addr not aligned to 4 bytes or exceeds the BAR0 length
+				 */
+				if ((addr & (sizeof(u32) - 1)) ||
+				    bar0_len < sizeof(u32) ||
+				    addr > bar0_len - sizeof(u32)) {
+					BT_WARN("YoYo: bad CSR address 0x%08x for BAR0 length %llu",
+						addr, (unsigned long long)bar0_len);
+					continue;
+				}
+
+				BT_DBG("YoYo: CSR write [0x%08x] = 0x%08x", addr, value);
+				btintel_pcie_wr_reg32(data, addr, value);
+				break;
+			/* Indirect Address Access (Peripheral MAC and Device Memory) */
+			case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
+			case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
+				/* Validate the effective address for peripheral MAC and device
+				 * memory access: addr not aligned to 4 bytes
+				 */
+				if (!addr || (addr & (sizeof(u32) - 1))) {
+					BT_WARN("YoYo: bad indirect address 0x%08x for type %u",
+						addr, config_set->config_set_type);
+					continue;
+				}
+
+				btintel_pcie_wr_reg32(data,
+						      BTINTEL_PCIE_PRPH_DEV_ADDR_REG,
+						      addr);
+				btintel_pcie_wr_reg32(data,
+						      BTINTEL_PCIE_PRPH_DEV_WR_REG,
+						      value);
+				BT_DBG("YoYo: indirect write type %u addr 0x%08x value 0x%08x",
+				       config_set->config_set_type, addr, value);
+				break;
+			default:
+				BT_WARN("YoYo: unknown config_set type %u",
+					config_set->config_set_type);
+				break;
+			}
+		}
+
+		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
+		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM)
+			btintel_pcie_release_mac_access(data);
+	}
+}
+
+static void btintel_pcie_yoyo_handle_timepoint(struct btintel_pcie_data *data,
+					       enum btintel_pcie_dbg_timepoint tp)
+{
+	if (!data || !data->yoyo.enabled)
+		return;
+
+	if (tp <= BTINTEL_PCIE_TP_INVALID || tp >= BTINTEL_PCIE_TP_MAX_NUM) {
+		BT_WARN("YoYo: invalid timepoint %u", tp);
+		return;
+	}
+
+	btintel_pcie_apply_yoyo_config_sets(data, tp);
+}
+
 static struct scatterlist *btintel_pcie_alloc_sgtable(ssize_t size)
 {
 	int nents;
@@ -1617,6 +1744,9 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 		BT_INFO("%s: Mac Init: Wait on Alive Interrupt",
 			btintel_pcie_dev_name(data));
 
+	/* EARLY Timepoint Handler */
+	btintel_pcie_yoyo_handle_timepoint(data, BTINTEL_PCIE_TP_EARLY);
+
 	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
 				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
 
@@ -4751,7 +4881,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (data->enable_ini) {
 		err = btintel_pcie_yoyo_load_and_parse(&data->yoyo, &pdev->dev);
 		if (err) {
-			BT_WARN("YoYo is not configured (%d)", err);
+			BT_WARN("YoYo (BDF - %s): yoyo is not configured (%d)",
+				pci_name(pdev), err);
 			btintel_pcie_yoyo_cleanup(&data->yoyo);
 		}
 	}
@@ -4834,8 +4965,6 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	btintel_pcie_synchronize_irqs(data);
 	disable_delayed_work_sync(&data->hw_rfkill_work);
 
-	btintel_pcie_yoyo_cleanup(&data->yoyo);
-
 	btintel_pcie_disable_interrupts(data);
 
 	btintel_pcie_synchronize_irqs(data);
@@ -4854,6 +4983,9 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	btintel_pcie_release_hdev(data);
 
+	/* Cleanup YoYo debug framework */
+	btintel_pcie_yoyo_cleanup(&data->yoyo);
+
 	destroy_workqueue(data->dump_workqueue);
 	destroy_workqueue(data->workqueue);
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 4125601b78d7..2224785b6e30 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -27,6 +27,7 @@
 #define BTINTEL_PCIE_CSR_MBOX_4_REG		(BTINTEL_PCIE_CSR_BASE + 0x17C)
 #define BTINTEL_PCIE_CSR_MBOX_STATUS_REG	(BTINTEL_PCIE_CSR_BASE + 0x180)
 #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG		(BTINTEL_PCIE_CSR_BASE + 0x440)
+#define BTINTEL_PCIE_PRPH_DEV_WR_REG		(BTINTEL_PCIE_CSR_BASE + 0x454)
 #define BTINTEL_PCIE_PRPH_DEV_RD_REG		(BTINTEL_PCIE_CSR_BASE + 0x458)
 #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR	(BTINTEL_PCIE_CSR_BASE + 0x460)
 
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index d675d3ff63dc..c52ef24dd0b0 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -314,8 +314,10 @@ static int btintel_pcie_yoyo_parse_dbg_info(struct btintel_pcie_yoyo_ctx *ctx,
 	const u8 *data = (const u8 *)info;
 	u32 domain, image_type, core_type, version;
 
-	if (len != sizeof(*info) - sizeof(struct btintel_pcie_tlv_hdr))
+	if (len != sizeof(*info) - sizeof(struct btintel_pcie_tlv_hdr)) {
+		BT_WARN("YoYo: dbg info tlv is too short or Invalid");
 		return -EBADMSG;
+	}
 
 	image_type = get_unaligned_le32(data +
 				       offsetof(struct btintel_pcie_tlv_dbg_info,
@@ -361,7 +363,7 @@ static int btintel_pcie_yoyo_parse_buf_alloc(struct btintel_pcie_yoyo_ctx *ctx,
 	u32 req_buf_size, version;
 
 	if (len != sizeof(*tlv) - sizeof(struct btintel_pcie_tlv_hdr)) {
-		BT_WARN("YoYo: unexpected buf alloc TLV length %u", len);
+		BT_WARN("YoYo: buf alloc tlv is too short or Invalid");
 		return -EBADMSG;
 	}
 
@@ -423,6 +425,84 @@ static int btintel_pcie_yoyo_parse_buf_alloc(struct btintel_pcie_yoyo_ctx *ctx,
 	return 0;
 }
 
+static int btintel_pcie_yoyo_parse_config_set(struct btintel_pcie_yoyo_ctx *ctx,
+					      const struct btintel_pcie_tlv_config_set *tlv,
+					      u32 len)
+{
+	struct btintel_pcie_yoyo_config_set *cs;
+	u32 fixed_size = sizeof(*tlv) - sizeof(struct btintel_pcie_tlv_hdr);
+	u32 pairs_bytes, num_pairs, domain, version, time_point, config_set_type;
+
+	if (len < fixed_size) {
+		BT_WARN("YoYo: config set tlv too short or Invalid");
+		return -EBADMSG;
+	}
+
+	domain = get_unaligned_le32(&tlv->dbg_hdr.domain);
+	version = get_unaligned_le32(&tlv->dbg_hdr.tlv_data_version);
+	if (domain != BTINTEL_PCIE_DOMAIN_BT ||
+	    version != BTINTEL_PCIE_CONFIG_SET_TLV_VERSION) {
+		BT_WARN("YoYo: unsupported domain/version (%u/%u)",
+			domain, version);
+		return 0;
+	}
+
+	time_point = get_unaligned_le32(&tlv->time_point);
+	if (time_point != BTINTEL_PCIE_TP_EARLY) {
+		BT_WARN("YoYo: config set unsupported time_point %u, skipping",
+			time_point);
+		return 0;
+	}
+
+	config_set_type = get_unaligned_le32(&tlv->config_set_type);
+	if (config_set_type != BTINTEL_PCIE_CFGSET_CSR &&
+	    config_set_type != BTINTEL_PCIE_CFGSET_PERIPH_MAC &&
+	    config_set_type != BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
+		BT_WARN("YoYo: config set unsupported config_set_type %u, skipping",
+			config_set_type);
+		return 0;
+	}
+
+	/* Malformed pair data: skip this TLV, keep parsing the rest. */
+	pairs_bytes = len - fixed_size;
+	if (pairs_bytes % sizeof(struct btintel_pcie_addr_value)) {
+		BT_WARN("YoYo: config set has an incomplete addr/value pair, skipping");
+		return 0;
+	}
+
+	num_pairs = pairs_bytes / sizeof(struct btintel_pcie_addr_value);
+
+	if (!num_pairs) {
+		BT_WARN("YoYo: config set with no addr/value pairs, skipping");
+		return 0;
+	}
+
+	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+	if (!cs) {
+		BT_WARN("YoYo: failed to allocate config set entry, skipping");
+		return -ENOMEM;
+	}
+
+	cs->time_point = time_point;
+	cs->config_set_type = config_set_type;
+	cs->addr_offset = get_unaligned_le32(&tlv->addr_offset);
+	cs->num_pairs = num_pairs;
+
+	cs->pairs = kmemdup(tlv->addr_pair, pairs_bytes, GFP_KERNEL);
+	if (!cs->pairs) {
+		kfree(cs);
+		BT_WARN("YoYo: failed to allocate config set pairs, skipping");
+		return -ENOMEM;
+	}
+
+	BT_DBG("YoYo: config set tp=%u type=%u pairs=%u offset=0x%x",
+	       cs->time_point, cs->config_set_type,
+	       cs->num_pairs, cs->addr_offset);
+
+	list_add_tail(&cs->list, &ctx->config_set_list);
+	return 0;
+}
+
 /*
  * Parse the optional YoYo firmware TLV stream and validate each record.
  * This is the entry point for the runtime debug configuration payload.
@@ -463,10 +543,12 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 			ret = btintel_pcie_yoyo_parse_buf_alloc(ctx,
 								(const void *)tlv, len);
 			break;
+		case BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET:
+			ret = btintel_pcie_yoyo_parse_config_set(ctx, (const void *)tlv, len);
+			break;
 		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
-		case BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
 			BT_DBG("YoYo: valid tlv type 0x%x len=%u", type, len);
 			break;
@@ -528,6 +610,8 @@ EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_init);
  */
 void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 {
+	struct btintel_pcie_yoyo_config_set *config_set, *config_tmp;
+
 	if (!ctx)
 		return;
 
@@ -535,6 +619,14 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 	ctx->dbg_info_present = false;
 	ctx->num_buf_allocs = 0;
 	memset(ctx->buf_alloc, 0, sizeof(ctx->buf_alloc));
+
+	ctx->hdev = NULL;
+
+	list_for_each_entry_safe(config_set, config_tmp, &ctx->config_set_list, list) {
+		list_del(&config_set->list);
+		kfree(config_set->pairs);
+		kfree(config_set);
+	}
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
 
@@ -552,7 +644,7 @@ int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
 	const struct firmware *fw;
 	int ret;
 
-	if (!ctx)
+	if (!ctx || !dev)
 		return -EINVAL;
 
 	ret = request_firmware_direct(&fw, BTINTEL_PCIE_YOYO_FW_NAME, dev);
@@ -576,17 +668,22 @@ int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
 
 	/* File Corruption / TLV validation failed */
 	if (ret) {
-		BT_ERR("YoYo: tlv parsing failed (%d)", ret);
+		BT_WARN("YoYo: tlv parsing failed (%d)", ret);
+		btintel_pcie_yoyo_cleanup(ctx);
 		return ret;
 	}
-	if (!ctx->dbg_info_present) {
-		BT_ERR("YoYo: Invalid BT debug Info tlv, using legacy DBGC defaults");
+
+	/* Mandatory debug Info Tlv is missing */
+	if (!ctx->dbg_info_present ||
+	    !ctx->num_buf_allocs) {
+		BT_WARN("YoYo: mandatory tlv is missing, using legacy DBGC defaults");
+		btintel_pcie_yoyo_cleanup(ctx);
 		return -EBADMSG;
 	}
 
 	ctx->enabled = true;
 
-	BT_INFO("YoYo: feature enabled and configured");
+	BT_INFO("YoYo (BDF - %s): feature enabled and configured", dev_name(dev));
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_load_and_parse);
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index b4d1d329886b..a9ecc7462d4e 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -48,9 +48,9 @@ bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data);
 #define BTINTEL_PCIE_YOYO_FW_NAME	"intel/ibt_debug_yoyo.bin"
 
 /* TLV type codes */
-#define BTINTEL_PCIE_TLV_TYPE_DBG_INFO		0x1000005
+#define BTINTEL_PCIE_TLV_TYPE_DBG_INFO			0x1000005
 #define BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC		0x1000006
-#define BTINTEL_PCIE_TLV_TYPE_DBG_HCMD		0x1000007
+#define BTINTEL_PCIE_TLV_TYPE_DBG_HCMD			0x1000007
 #define BTINTEL_PCIE_TLV_TYPE_DBG_REGION		0x1000008
 #define BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER		0x1000009
 #define BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET		0x100000A
@@ -59,6 +59,7 @@ bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data);
 /* Supported TLV type versions */
 #define BTINTEL_PCIE_DBG_INFO_TLV_VERSION	2
 #define BTINTEL_PCIE_BUF_ALLOC_TLV_VERSION	1
+#define BTINTEL_PCIE_CONFIG_SET_TLV_VERSION	1
 /* Debug Info TLV */
 #define BTINTEL_PCIE_CONFIG_NAME_LEN		64
 #define BTINTEL_PCIE_DOMAIN_BT			0
@@ -77,7 +78,7 @@ enum btintel_pcie_image_tlv_type {
 
 /* Allocation IDs */
 enum btintel_dbg_alloc_id {
-	BTINTEL_PCIE_ALLOC_ID_INVALID	= 0,
+	BTINTEL_PCIE_ALLOC_ID_INVALID		= 0,
 	BTINTEL_PCIE_ALLOC_ID_DBGC1		= 1,
 	BTINTEL_PCIE_ALLOC_ID_DBGC2		= 2,
 	BTINTEL_PCIE_ALLOC_ID_DBGC3		= 3,
@@ -93,6 +94,41 @@ enum btintel_dbg_buf_location {
 	BTINTEL_PCIE_BUF_LOC_MAX,
 };
 
+/* Config set types */
+enum btintel_pcie_dbg_config_set_type {
+	BTINTEL_PCIE_CFGSET_INVALID		= 0,
+	BTINTEL_PCIE_CFGSET_PERIPH_MAC		= 1,
+	BTINTEL_PCIE_CFGSET_PERIPH_PHY		= 2,
+	BTINTEL_PCIE_CFGSET_PERIPH_AUX		= 3,
+	BTINTEL_PCIE_CFGSET_DEVICE_MEM		= 4,
+	BTINTEL_PCIE_CFGSET_CSR			= 5,
+	BTINTEL_PCIE_CFGSET_DBGC_DRAM_ADDR	= 6,
+	BTINTEL_PCIE_CFGSET_PERIPH_SCRATCH	= 7,
+	BTINTEL_PCIE_CFGSET_MAX,
+};
+
+/* Types of Timepoints */
+enum btintel_pcie_dbg_timepoint {
+	BTINTEL_PCIE_TP_INVALID			= 0,
+	BTINTEL_PCIE_TP_EARLY			= 1,
+	BTINTEL_PCIE_TP_AFTER_ALIVE		= 2,
+	BTINTEL_PCIE_TP_POST_INIT		= 3,
+	BTINTEL_PCIE_TP_FW_ASSERT		= 4,
+	BTINTEL_PCIE_TP_FW_HW_ERROR		= 5,
+	BTINTEL_PCIE_TP_FW_TFD_Q_HANG		= 6,
+	BTINTEL_PCIE_TP_FW_DHC_NOTIF		= 7,
+	BTINTEL_PCIE_TP_FW_RSP_OR_NOTIF		= 8,
+	BTINTEL_PCIE_TP_USER_TRIGGER		= 9,
+	BTINTEL_PCIE_TP_PERIODIC		= 10,
+	BTINTEL_PCIE_TP_RESERVED		= 11,
+	BTINTEL_PCIE_TP_HOST_ASSERT		= 12,
+	BTINTEL_PCIE_TP_HOST_ALIVE_TIMEOUT	= 13,
+	BTINTEL_PCIE_TP_HOST_DEVICE_DISABLE	= 15,
+	BTINTEL_PCIE_TP_HOST_D3_START		= 16,
+	BTINTEL_PCIE_TP_HOST_D3_END		= 17,
+	BTINTEL_PCIE_TP_MAX_NUM,
+};
+
 /* TLV header */
 struct btintel_pcie_tlv_hdr {
 	__le32 type;
@@ -152,6 +188,27 @@ struct btintel_pcie_tlv_buf_alloc {
 	__le32 min_buf_size;
 } __packed;
 
+/*
+ * struct btintel_pcie_tlv_config_set - YoYo configuration-set TLV
+ * @hdr: Common TLV type and payload length
+ * @dbg_hdr: Debug TLV version and domain
+ * @time_point: Timepoint at which to apply this configuration
+ * @config_set_type: Target register or memory space
+ * @addr_offset: Offset added to each address/value pair address
+ * @addr_pair: Variable-length array of address/value pairs
+ *
+ * Describes configuration values to apply at a specified timepoint. Fields
+ * are stored in little-endian format in the packed firmware TLV.
+ */
+struct btintel_pcie_tlv_config_set {
+	struct btintel_pcie_tlv_hdr hdr;
+	struct btintel_pcie_dbg_hdr dbg_hdr;
+	__le32 time_point;
+	__le32 config_set_type;
+	__le32 addr_offset;
+	struct btintel_pcie_addr_value addr_pair[];
+} __packed;
+
 /* Parsed buffer allocation entry in the YoYo context */
 struct btintel_pcie_buf_alloc {
 	u32	alloc_id;
@@ -162,9 +219,20 @@ struct btintel_pcie_buf_alloc {
 	bool	present;
 };
 
+/* Parsed config set entry in yoyo ctx */
+struct btintel_pcie_yoyo_config_set {
+	struct list_head		list;
+	u32				time_point;
+	u32				config_set_type;
+	u32				addr_offset;
+	u32				num_pairs;
+	struct btintel_pcie_addr_value	*pairs;
+};
+
 /*
- * struct btintel_pcie_yoyo_ctx- Runtime state for YoYo debug configuration
+ * struct btintel_pcie_yoyo_ctx - Runtime state for YoYo debug configuration
  * @enabled: Whether the loaded YoYo configuration passed validation
+ * @dbg_info_present: Whether the mandatory DEBUG_INFO TLV was validated
  * @region_list: Parsed debug-region entries
  * @trigger_list: Parsed debug-trigger entries
  * @hcmd_list: Parsed HCI command entries
-- 
2.53.0

