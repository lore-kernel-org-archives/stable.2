Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD34A385E;
	Thu, 15 Oct 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065280; cv=none; b=HSGeYEgZxq4/GFIuUUU2yDPNGhW9TiwqUNQ/ssxHB9qCsxxsF0a6UjQMkQfQR2ymKnJe+oCMd8nT+yj9n8yiB4aq4HIeipgZ5q6xSdztEOSNpUyJEBVCQlqz2tZVMg9/LzPtA8LjCqeZh0RXfExp0MMAkadDdhNaYMfzo1UplJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065280; c=relaxed/simple;
	bh=ITvtbFnfD1HGhLOTmI7RNN1uqniYqUorCXEmPuSE4y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZ86Lf4dHU4V4GNwOAvI4MjMdECmbFIknfnJIRkdxSoQsmyiBOWt+TjvqYUM0HvLalBEnuVTXDwWGLJPDDnZKN0wAqgYT7/kO9O1TP5FL7r0Zqxv1JlCu1dMyz8+kQr1jP9yLAgdnkjH4PpYUUoR6yVzL+JLXVgLNvEFm+wngRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DO0Hf353; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DO0Hf353"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792065278; x=1823601278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ITvtbFnfD1HGhLOTmI7RNN1uqniYqUorCXEmPuSE4y8=;
  b=DO0Hf353dw8HG3CUCbqC7e/VtJrspkDNNZ3w1iuWgPDYw+GP5eUKXXi3
   zIOqfbmsVmWz0Ckv74c+7KEzv+/dRtW7l3tzeCBGjyztKoK8LIg4kw40c
   KvDSiZFdDU3uCfjCn7CmktN0PVs+xtLm9ZQmn7vz5c5dRoVrIapg0llLI
   yefnLZXhXoN/7ZbshwhK9MXXJa2rl61A3IsSPo+ltYzChUhEN4dfwXODs
   ggUaSo6XOHOInPi5sGVnDMUGs9RxcVbVkIS9Rm2gLZqr86eMz6dc61yjc
   7dyHIpM0oKvdfz99LkJjNgDy26s3/T810SiXJHQcRYIFoEgpdH6m1rEiD
   A==;
X-CSE-ConnectionGUID: 2vCc4VIsTVq3Jp3yRWgOrw==
X-CSE-MsgGUID: NR/iFcQqQcqbYUqjOwP/ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="732146"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="732146"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 04:54:37 -0700
X-CSE-ConnectionGUID: 4TtD9GddRw+WqC7UUNEDTg==
X-CSE-MsgGUID: UxcyNtlUT++S1EyUHSu6+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1584347"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2026 04:54:34 -0700
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
Subject: [PATCH v4 1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
Date: Thu, 15 Oct 2026 14:54:29 +0300
Message-ID: <20261015115431.27456-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ajaykv <ajay.k.v@intel.com>

Add an optional YoYo firmware configuration path to the Intel PCIe
Bluetooth driver. Read DBG_PATH and ENABLE_INI from
ibt_bt_dbg_cfg.ini, and load intel/ibt_debug_yoyo.bin only when YoYo
is enabled and host DRAM routing is selected.

Introduce a runtime context and bounded TLV-stream validation helper.
Initialize and clean up the context with PCI probe and removal, while
falling back to legacy debug behavior if optional YoYo data is missing
or invalid.

Runtime validation of the complete P1-P3 series produced:
[    3.286504] Bluetooth: Core ver 2.22
[    3.297359] Bluetooth: HCI device and connection manager initialized
[    3.297373] Bluetooth: HCI socket layer initialized
[    3.297376] Bluetooth: L2CAP socket layer initialized
[    3.297384] Bluetooth: SCO socket layer initialized
[    3.332848] Bluetooth: YoYo: configuration loaded and validated
[3.360857-3.361712] Bluetooth: DBGC1-3: each 16 x 256 KiB (4 MiB)
[3.361715] Bluetooth: MDBGC DBGC1-3: each 16 x 256 KiB
[    3.397439] Bluetooth: hci0: Device revision is 0
[    3.397442] Bluetooth: hci0: Secure boot is enabled
[    3.397443] Bluetooth: hci0: OTP lock is disabled
[    3.397444] Bluetooth: hci0: API lock is enabled
[    3.397444] Bluetooth: hci0: Debug lock is disabled

Signed-off-by: Ajaykv <ajay.k.v@intel.com>

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index d5eb2568af2e..7d933755b291 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
 obj-$(CONFIG_BT_INTEL)		+= btintel.o
-obj-$(CONFIG_BT_INTEL_PCIE)	+= btintel_pcie.o btintel.o
+obj-$(CONFIG_BT_INTEL_PCIE)	+= btintel_pcie.o btintel.o btintel_pcie_debug.o
 obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
 obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3a555aa50c87..313789cb290e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -203,6 +203,108 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
 	return data->dbg_path_cache != BTINTEL_PCIE_DRAM;
 }
 
+/* Name of the optional INI file used to override the default dbg_path
+ * (data->dbg_path_cache) and yoyo ini settings.
+ */
+#define BTINTEL_PCIE_DBG_INI_FILE "ibt_bt_dbg_cfg.ini"
+
+/* Loads optional "DBG_PATH=<value>" and ENABLE_INI=<value>
+ * overrides from BTINTEL_PCIE_DBG_INI_FILE
+ * and applies them to data->dbg_path_cache and data->enable_ini.
+ *
+ * DBG_PATH accepts BTINTEL_PCIE_WIFI_DBGC (0x06, default) and
+ * BTINTEL_PCIE_DRAM (0x01, legacy); an invalid or missing entry leaves
+ * the cached value set by the caller unchanged.
+ *
+ * ENABLE_INI accepts 1 (enabled) or 0 (disabled); an invalid or missing
+ * entry leaves data->enable_ini unchanged.
+ */
+static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
+{
+	const struct firmware *fw;
+	const char *ini_file = BTINTEL_PCIE_DBG_INI_FILE;
+	char *buf, *cursor, *line;
+	bool dbg_path_applied = false;
+	int err;
+
+	err = request_firmware_direct(&fw, ini_file, &data->pdev->dev);
+	if (err < 0) {
+		BT_DBG("%s not found (%d), using dbg_path=0x%02x",
+		       ini_file, err, data->dbg_path_cache);
+		if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
+			data->enable_ini = false;
+		return;
+	}
+
+	buf = kmemdup_nul(fw->data, fw->size, GFP_KERNEL);
+	release_firmware(fw);
+	if (!buf)
+		return;
+
+	cursor = buf;
+	while ((line = strsep(&cursor, "\n"))) {
+		char *eq;
+		char *val;
+		uint parsed;
+
+		line = strim(line);
+		if (!line[0] || line[0] == '#' || line[0] == ';')
+			continue;
+
+		eq = strchr(line, '=');
+		if (!eq)
+			continue;
+
+		*eq = '\0';
+		line = strim(line);
+		val = strim(eq + 1);
+
+		/* Accept "DBG_PATH"/"dbg_path"
+		 * case-insensitively as the key.
+		 */
+		if (!strcasecmp(line, "DBG_PATH")) {
+			BT_INFO("Read DBG_PATH from %s: '%s'", ini_file, val);
+
+			/* base 0 lets kstrtouint accept "0x06", "6", etc. */
+			if (kstrtouint(val, 0, &parsed) == 0 &&
+			    (parsed == BTINTEL_PCIE_DRAM ||
+			     parsed == BTINTEL_PCIE_WIFI_DBGC)) {
+				data->dbg_path_cache = parsed;
+				dbg_path_applied = true;
+				BT_INFO("WRT dbg_path accepted: 0x%02x",
+					data->dbg_path_cache);
+			} else {
+				BT_WARN("Invalid DBG_PATH='%s' in %s, using dbg_path=0x%02x",
+					val, ini_file, data->dbg_path_cache);
+			}
+		} else if (!strcasecmp(line, "ENABLE_INI")) {
+			BT_INFO("Read ENABLE_INI from %s: '%s'", ini_file, val);
+
+			if (kstrtouint(val, 0, &parsed) == 0 &&
+			    (parsed == 0 || parsed == 1)) {
+				data->enable_ini = !!parsed;
+				BT_INFO("WRT enable_ini accepted: %u",
+					data->enable_ini);
+			} else {
+				BT_WARN("Invalid ENABLE_INI='%s' in %s, using enable_ini=%u",
+					val, ini_file, data->enable_ini);
+			}
+		}
+	}
+
+	if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
+		data->enable_ini = false;
+
+	if (dbg_path_applied)
+		BT_DBG("Loaded dbg_path=0x%02x from %s", data->dbg_path_cache, ini_file);
+	else
+		BT_WARN("No valid DBG_PATH in %s, dbg_path=0x%02x", ini_file, data->dbg_path_cache);
+
+	BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
+
+	kfree(buf);
+}
+
 /* Helper function to allocate and setup a debug buffer group
  * @data: driver data structure
  * @buf: pointer to data_buf array pointer
@@ -3192,6 +3294,8 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	/* Initialize the CI */
 	btintel_pcie_init_ci(data, data->ci);
 
+	data->pcie_alloc_init = true;
+
 	return 0;
 
 exit_error_txq:
@@ -3365,6 +3469,31 @@ static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data)
 		synchronize_irq(data->msix_entries[i].vector);
 }
 
+static void btintel_pcie_probe_cleanup(struct btintel_pcie_data *data)
+{
+	struct pci_dev *pdev = data->pdev;
+
+	btintel_pcie_disable_interrupts(data);
+	btintel_pcie_synchronize_irqs(data);
+
+	disable_work_sync(&data->coredump_work);
+	disable_work_sync(&data->hwexp_work);
+	disable_work_sync(&data->fwtrigger_work);
+	disable_work_sync(&data->mbox_work);
+
+	flush_work(&data->rx_work);
+
+	btintel_pcie_reset_bt(data);
+	for (int i = 0; i < data->alloc_vecs; i++) {
+		struct msix_entry *msix_entry;
+
+		msix_entry = &data->msix_entries[i];
+		devm_free_irq(&pdev->dev, msix_entry->vector, msix_entry);
+	}
+
+	pci_free_irq_vectors(pdev);
+}
+
 static int btintel_pcie_get_debug_info_addr(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
@@ -4054,6 +4183,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *ent)
 {
 	int err;
+	bool pcie_configured = false;
 	struct btintel_pcie_data *data;
 
 	if (!pdev)
@@ -4097,15 +4227,30 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
 	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
+	data->pcie_alloc_init = false;
+	data->enable_ini = false;
+	btintel_pcie_yoyo_init(&data->yoyo);
 	/* FLR can be invoked by echoing to debugfs path, so explicitly
 	 * initialized
 	 */
 	data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+
+	btintel_pcie_load_dbg_path_from_ini(data);
+
 	err = btintel_pcie_config_pcie(pdev, data);
 	if (err)
 		goto exit_error;
 
+	pcie_configured = true;
+
 	pci_set_drvdata(pdev, data);
+	if (data->enable_ini) {
+		err = btintel_pcie_yoyo_load_and_parse(&data->yoyo, &pdev->dev);
+		if (err) {
+			BT_WARN("YoYo is not configured (%d)", err);
+			btintel_pcie_yoyo_cleanup(&data->yoyo);
+		}
+	}
 
 	err = btintel_pcie_alloc(data);
 	if (err)
@@ -4128,15 +4273,22 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (err)
 		goto exit_error;
 
+	data->yoyo.hdev = data->hdev;
 	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
 		   data->cnvr);
 	return 0;
 
 exit_error:
-	/* reset device before exit */
-	btintel_pcie_reset_bt(data);
+	btintel_pcie_yoyo_cleanup(&data->yoyo);
+
+	if (pcie_configured)
+		btintel_pcie_probe_cleanup(data);
+
+	if (data->pcie_alloc_init)
+		btintel_pcie_free(data);
 
 	destroy_workqueue(data->dump_workqueue);
+	destroy_workqueue(data->workqueue);
 
 	pci_clear_master(pdev);
 
@@ -4173,6 +4325,8 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	if (current_work() != &data->reset_work)
 		disable_work_sync(&data->reset_work);
 
+	btintel_pcie_yoyo_cleanup(&data->yoyo);
+
 	btintel_pcie_disable_interrupts(data);
 
 	btintel_pcie_synchronize_irqs(data);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3030b4e8b750..7bfb7615ed0d 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -6,6 +6,8 @@
  *  Copyright (C) 2024  Intel Corporation
  */
 
+#include "btintel_pcie_debug.h"
+
 /* Control and Status Register(BTINTEL_PCIE_CSR) */
 #define BTINTEL_PCIE_CSR_BASE			(0x000)
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
@@ -737,6 +739,8 @@ struct btintel_pcie_data {
 	u32	boot_stage_cache;
 	u32	img_resp_cache;
 	u32	dbg_path_cache;
+	bool	enable_ini;
+	struct btintel_pcie_yoyo_ctx yoyo;
 
 	u32	cnvi;
 	u32	cnvr;
@@ -783,6 +787,7 @@ struct btintel_pcie_data {
 	wait_queue_head_t	mbox_parse_wait_q;
 	/* Timestamp captured in GP1 handler when mbox interrupt is received */
 	ktime_t	mbox_intr_ts;
+	bool		pcie_alloc_init;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
new file mode 100644
index 000000000000..0e933f4ec376
--- /dev/null
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Bluetooth YoYo Debug Framework
+ *
+ * Copyright (C) 2026 Intel Corporation
+ *
+ * Runtime-configurable TLV-based debug collection framework for loading and
+ * parsing the optional YoYo firmware configuration used to enable debug
+ * regions, triggers, HCI commands, and configuration sets.
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <net/bluetooth/bluetooth.h>
+#include "btintel_pcie_debug.h"
+
+/*
+ * Parse the optional YoYo firmware TLV stream and validate each record.
+ * This is the entry point for the runtime debug configuration payload.
+ */
+static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
+					      const u8 *buf, size_t buf_len)
+{
+	const struct btintel_pcie_tlv_hdr *tlv;
+	const u8 *ptr = buf;
+	size_t remaining = buf_len;
+	u32 count = 0;
+
+	while (remaining >= sizeof(*tlv)) {
+		size_t tlv_size;
+		u32 type, len;
+
+		tlv = (const struct btintel_pcie_tlv_hdr *)ptr;
+		type = get_unaligned_le32(&tlv->type);
+		len = get_unaligned_le32(&tlv->length);
+
+		if (len > remaining - sizeof(*tlv)) {
+			BT_ERR("YoYo: tlv %u truncated (len=%u rem=%zu)", count,
+			       len, remaining);
+			return -EBADMSG;
+		}
+		tlv_size = sizeof(*tlv) + len;
+
+		switch (type) {
+		case BTINTEL_PCIE_TLV_TYPE_DBG_INFO:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
+			BT_DBG("YoYo: valid tlv type 0x%x len=%u", type, len);
+			break;
+		default: /* Log and continue, do not fail*/
+			BT_DBG("YoYo: unknown tlv type 0x%x len=%u", type, len);
+			break;
+		}
+
+		ptr += tlv_size;
+		remaining -= tlv_size;
+		count++;
+	}
+
+	/* If no TLVs were parsed, the YoYo binary is considered invalid */
+	if (remaining || count == 0) {
+		BT_ERR("YoYo: trailing %zu bytes after tlv stream", remaining);
+		return -EBADMSG;
+	}
+
+	BT_DBG("YoYo: parsed %u tlv's", count);
+	return 0;
+}
+
+/**
+ * btintel_yoyo_init - Initialize the YoYo context
+ * @ctx:   Pre-allocated context (typically embedded in driver data)
+ */
+int btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	memset(ctx, 0, sizeof(*ctx));
+	INIT_LIST_HEAD(&ctx->region_list);
+	INIT_LIST_HEAD(&ctx->trigger_list);
+	INIT_LIST_HEAD(&ctx->hcmd_list);
+	INIT_LIST_HEAD(&ctx->config_set_list);
+
+	/* set it to true after successful TLV parsing */
+	ctx->enabled = false;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_init);
+
+/**
+ * btintel_yoyo_cleanup - Clean up the YoYo context
+ * @ctx:  YoYo context to clean up
+ */
+void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	ctx->enabled = false;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
+
+/**
+ * btintel_yoyo_load_and_parse - Load ibt_debug_yoyo.bin and parse TLVs
+ * @ctx:  Initialized YoYo context
+ * @dev:  Device for firmware loading (typically &pdev->dev)
+ *
+ * Uses request_firmware_direct, since the YoYo binary
+ * is optional. On success, sets ctx->enabled.
+ */
+int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
+				     struct device *dev)
+{
+	const struct firmware *fw;
+	int ret;
+
+	if (!ctx)
+		return -EINVAL;
+
+	ret = request_firmware_direct(&fw, BTINTEL_PCIE_YOYO_FW_NAME, dev);
+	if (ret) {
+		BT_WARN("YoYo: failed to load %s (%d)",
+			BTINTEL_PCIE_YOYO_FW_NAME, ret);
+		return ret;
+	}
+
+	/* Sanity check firmware size */
+	if (fw->size < sizeof(struct btintel_pcie_tlv_hdr)) {
+		release_firmware(fw);
+		return -EBADMSG;
+	}
+
+	BT_DBG("YoYo: loaded %s (%zu bytes)", BTINTEL_PCIE_YOYO_FW_NAME,
+	       fw->size);
+
+	ret = btintel_pcie_yoyo_parse_tlv_buffer(ctx, fw->data, fw->size);
+	release_firmware(fw);
+
+	/* File Corruption / TLV validation failed */
+	if (ret) {
+		BT_ERR("YoYo: tlv parsing failed (%d)", ret);
+		return ret;
+	}
+
+	ctx->enabled = true;
+
+	BT_INFO("YoYo: feature enabled and configured");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_load_and_parse);
+
+MODULE_DESCRIPTION("Intel Bluetooth yoyo debug framework");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
new file mode 100644
index 000000000000..b0b94c2a169d
--- /dev/null
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Bluetooth YoYo Debug Framework
+ *
+ * Copyright (C) 2026 Intel Corporation
+ *
+ */
+
+#ifndef __BTINTEL_PCIE_DEBUG_H__
+#define __BTINTEL_PCIE_DEBUG_H__
+
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+
+/* External YoYo binary file */
+#define BTINTEL_PCIE_YOYO_FW_NAME	"intel/ibt_debug_yoyo.bin"
+
+/* TLV type codes */
+#define BTINTEL_PCIE_TLV_TYPE_DBG_INFO		0x1000005
+#define BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC		0x1000006
+#define BTINTEL_PCIE_TLV_TYPE_DBG_HCMD		0x1000007
+#define BTINTEL_PCIE_TLV_TYPE_DBG_REGION		0x1000008
+#define BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER		0x1000009
+#define BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET		0x100000A
+#define BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE	0x100000B
+
+/* TLV header */
+struct btintel_pcie_tlv_hdr {
+	__le32 type;
+	__le32 length;
+} __packed;
+
+/* Debug header common to all debug TLVs */
+struct btintel_pcie_dbg_hdr {
+	__le32 tlv_data_version;
+	__le32 domain;
+} __packed;
+
+/* Address/value pair */
+struct btintel_pcie_addr_value {
+	__le32 address;
+	__le32 value;
+} __packed;
+
+/*
+ * struct btintel_pcie_yoyo_ctx- Runtime state for YoYo debug configuration
+ * @enabled: Whether the loaded YoYo configuration passed validation
+ * @region_list: Parsed debug-region entries
+ * @trigger_list: Parsed debug-trigger entries
+ * @hcmd_list: Parsed HCI command entries
+ * @config_set_list: Parsed configuration-set entries
+ * @hdev: Associated HCI device; NULL until successful HCI registration
+ *
+ * Stores the validation state and parsed TLV data for the optional YoYo
+ * firmware configuration.
+ */
+struct btintel_pcie_yoyo_ctx {
+	bool			 enabled;
+
+	struct list_head	 region_list;
+	struct list_head	 trigger_list;
+	struct list_head	 hcmd_list;
+	struct list_head	 config_set_list;
+
+	struct hci_dev		 *hdev;
+};
+
+int  btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx);
+void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx);
+
+/* Load and parse the external .bin file */
+int  btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
+				      struct device *dev);
+
+#endif /* __BTINTEL_PCIE_DEBUG_H__ */
-- 
2.53.0

