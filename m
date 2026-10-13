Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BE5328A1;
	Tue, 13 Oct 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915998; cv=none; b=R6E1NaJhvVVlVZ/k1YHaUZtIZaWolac1VjHAyzk4PCJmQEoSEN9vFz3ldAfD/HzQfsvXgr2i2Wswj9Mc+y7wxStw+/Tu8okkn1vVTvM4/Nco8Y5gCaHhn6GdkXeWKgCEuJrZcehcMlVCCu8je3mnIKBAxI4dzJm58ltw7yze6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915998; c=relaxed/simple;
	bh=Rw//lETCW434AchMGDTCH/kN5vndDeh2t0JchEcS0M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIeupqiN3bfiqD/8/xvOEiUKYYaAvuJC0npIOnB9Kq5Czii3qopT4LGNCqFO+CUKdNYI98GUjnftj4mhEEggJ4sl38WkOqNQOXQQjj1z1gdJGC2vr+4WV0qK9pz4btfGSNu+yOvBzNE+b3MIV+3bLQKd8Hn14ngMRCqJRMEbkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axZeSP1S; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axZeSP1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791915995; x=1823451995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rw//lETCW434AchMGDTCH/kN5vndDeh2t0JchEcS0M0=;
  b=axZeSP1SY/mtFlW95Mc7qjUP0ao6dFmBaK2woWPGz3I0WCoQjTIVqp45
   lfU6IlX0Fc4uko4fp9H5filLoRErgSrp0jxxq6Nluz1sfZ0UtZqoPr530
   n13RCWt9287H6OsY839iV4NtY7qloEtsylpXUTnvhYmsz5OHPGISr7De/
   1LVGU6uT+2Tu56ovoQ+f7k2zw0gxXHXrEFoxa+7H+y5GfMHfpWf1gbezE
   NaP7hOdCxpFNEFRjrTmnRzmOHiRHji5lD0CS/NfTEQAo0BZj9K4QdJqmH
   uT5LX4RYyTXZTK+I7SGJHDT+GEC874Ovujm/pBVFtsdJrwChb1RQrODW1
   g==;
X-CSE-ConnectionGUID: wy0nQDq4Sg2n2iqYs+5+Qg==
X-CSE-MsgGUID: NF4sak1QR+itMDU0jzBbuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="754590"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="754590"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:26:34 -0700
X-CSE-ConnectionGUID: 3tQDvxivSCa39imKn3pDcA==
X-CSE-MsgGUID: gyMWdFf/TOuv6Tmdpv866w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1157519"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa005.jf.intel.com with ESMTP; 13 Oct 2026 11:26:31 -0700
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
Subject: [PATCH v1 1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
Date: Tue, 13 Oct 2026 21:26:24 +0300
Message-ID: <20261013182627.81957-1-ajay.k.v@intel.com>
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
index 3a555aa50c87..e28f527d6d29 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -203,6 +203,103 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
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
+		BT_ERR("%s not found (%d), using dbg_path=0x%02x ",
+		       ini_file, err, data->dbg_path_cache);
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
+				BT_ERR("Invalid DBG_PATH='%s' in %s, using dbg_path=0x%02x",
+				       val, ini_file, data->dbg_path_cache);
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
+				BT_ERR("Invalid ENABLE_INI='%s' in %s, using enable_ini=%u",
+				       val, ini_file, data->enable_ini);
+			}
+		}
+	}
+
+	if (dbg_path_applied)
+		BT_DBG("Loaded dbg_path=0x%02x from %s", data->dbg_path_cache, ini_file);
+	else
+		BT_ERR("No valid DBG_PATH in %s, dbg_path=0x%02x", ini_file, data->dbg_path_cache);
+
+	BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
+
+	kfree(buf);
+}
+
 /* Helper function to allocate and setup a debug buffer group
  * @data: driver data structure
  * @buf: pointer to data_buf array pointer
@@ -4097,10 +4194,25 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
 	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
+	data->enable_ini = false;
+	btintel_pcie_yoyo_init(&data->yoyo);
 	/* FLR can be invoked by echoing to debugfs path, so explicitly
 	 * initialized
 	 */
 	data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+
+	btintel_pcie_load_dbg_path_from_ini(data);
+	if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
+		data->enable_ini = false;
+
+	if (data->enable_ini) {
+		err = btintel_pcie_yoyo_load_and_parse(&data->yoyo, &pdev->dev);
+		if (err) {
+			BT_WARN("YoYo is not configured (%d)", err);
+			btintel_pcie_yoyo_cleanup(&data->yoyo);
+		}
+	}
+
 	err = btintel_pcie_config_pcie(pdev, data);
 	if (err)
 		goto exit_error;
@@ -4128,11 +4240,14 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (err)
 		goto exit_error;
 
+	data->yoyo.hdev = data->hdev;
 	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
 		   data->cnvr);
 	return 0;
 
 exit_error:
+	btintel_pcie_yoyo_cleanup(&data->yoyo);
+
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
 
@@ -4173,6 +4288,8 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	if (current_work() != &data->reset_work)
 		disable_work_sync(&data->reset_work);
 
+	btintel_pcie_yoyo_cleanup(&data->yoyo);
+
 	btintel_pcie_disable_interrupts(data);
 
 	btintel_pcie_synchronize_irqs(data);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3030b4e8b750..0a4e508d0beb 100644
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

