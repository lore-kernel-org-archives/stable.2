Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F33E024B;
	Tue, 13 Oct 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888266; cv=none; b=dd1FCQh6CLcngX2QVLpv0t1vHQTzqQhLvqKIS6oVBl/Jl9a2xleULuybTyGEuwB70M806xsnHStMSm9pAW5CbZnaF4RttID4vuf82hroptePVso1Rozu/IHiSfCzvXXl4wM5uRxvHaKxlHMjKuR2Z6c+Jd9PqKbbtniV7XNeRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888266; c=relaxed/simple;
	bh=tnIyxnOv4M/d0hGZvP0pwYiKXxhQ57h6fi84wV2O4+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX6WZ2jZXF2kK8938sGgEpfrqw7xOEnPNxha8fNP/3DUR42R10q+fxrqXDL4l+GDDlFibndpT6fPxiE7Wh4N3UX1Z++V7H5PcsXIwIdNdHagN7E09N/BPL6AeEiC7vCYweBNA+vNxILGfWg2U1Se71yuP8n2kF+fzPRcVN+8ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL6c3bej; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL6c3bej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791888264; x=1823424264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tnIyxnOv4M/d0hGZvP0pwYiKXxhQ57h6fi84wV2O4+w=;
  b=RL6c3bejYWWHc0FZXh1WHvBCJ5ZCF39vI1YumCt80sLPdU0d4hpPmy+V
   JR+MuPCHC0NYl4rkje4hoyzW/mi0moKfd0b8bxDMnM3ZD+j+dr4IYvgkb
   Ks+HFqvLt69BqguQ2daWaHv+fPLJduZVQfInq08jFxUVtNoLqbk5G/OHW
   AmoJhkK/AHAxvN55qqXB/CoQDNWG8b1sywZNcBtokqjeYSOE7u4BfD726
   hw0D05LnqHFE/14bCs2ifQyVyMs0k6b7l4sAT69/V6UM8MAFqahPql/Jd
   bC/xBJOo02LHz6+dm7Fq9VVXLz2slm5HJd1PBjpUoAb12WervUAs3G2ls
   g==;
X-CSE-ConnectionGUID: r9cfb5qiT1W5Q00QQe1zpA==
X-CSE-MsgGUID: FX6cOA0QQoCz2LVzElXrvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="494148"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="494148"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:44:23 -0700
X-CSE-ConnectionGUID: wffqdhZ+RGWmTUXFGRCLCw==
X-CSE-MsgGUID: 3cBpKyivR+Cytt8USC43uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1062098"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa009.jf.intel.com with ESMTP; 13 Oct 2026 03:44:21 -0700
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
Date: Tue, 13 Oct 2026 13:44:14 +0300
Message-ID: <20261013104416.26143-1-ajay.k.v@intel.com>
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
[    3.360857] Bluetooth: DBGC allocation 1: fragments=16 fragment_size=262144 total=4194304
[    3.361298] Bluetooth: DBGC allocation 2: fragments=16 fragment_size=262144 total=4194304
[    3.361712] Bluetooth: DBGC allocation 3: fragments=16 fragment_size=262144 total=4194304
[    3.361715] Bluetooth: MDBGC fragments: DBGC1=16/262144 DBGC2=16/262144 DBGC3=16/262144
[    3.397439] Bluetooth: hci0: Device revision is 0
[    3.397442] Bluetooth: hci0: Secure boot is enabled
[    3.397443] Bluetooth: hci0: OTP lock is disabled
[    3.397444] Bluetooth: hci0: API lock is enabled
[    3.397444] Bluetooth: hci0: Debug lock is disabled

Signed-off-by: Ajaykv <ajay.k.v@intel.com>
---
 drivers/bluetooth/Makefile             |   2 +-
 drivers/bluetooth/btintel_pcie.c       | 105 ++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h       |   4 +
 drivers/bluetooth/btintel_pcie_debug.c | 117 +++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie_debug.h |  60 +++++++++++++
 5 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/btintel_pcie_debug.c
 create mode 100644 drivers/bluetooth/btintel_pcie_debug.h

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
index 3a555aa50c87..a4aaca3daf20 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -203,6 +203,90 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
 	return data->dbg_path_cache != BTINTEL_PCIE_DRAM;
 }
 
+#define BTINTEL_PCIE_DBG_INI_FILE "ibt_bt_dbg_cfg.ini"
+
+/*
+ * Loads optional "DBG_PATH=<value>" and "ENABLE_INI=<value>" overrides from
+ * BTINTEL_PCIE_DBG_INI_FILE and applies them to dbg_path_cache and enable_ini.
+ *
+ * DBG_PATH accepts WiFi DBGC (0x06) or legacy host DRAM (0x01); ENABLE_INI
+ * accepts 1 (enabled) or 0 (disabled). Missing or invalid entries leave the
+ * values set by the caller unchanged.
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
+		BT_ERR("%s not found (%d), using dbg_path=0x%02x", ini_file,
+		       err, data->dbg_path_cache);
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
+		char *eq, *val;
+		unsigned int parsed;
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
+		if (!strcasecmp(line, "DBG_PATH")) {
+			BT_DBG("Read DBG_PATH from %s: '%s'", ini_file, val);
+
+			if (!kstrtouint(val, 0, &parsed) &&
+			    (parsed == BTINTEL_PCIE_DRAM ||
+			     parsed == BTINTEL_PCIE_WIFI_DBGC)) {
+				data->dbg_path_cache = parsed;
+				dbg_path_applied = true;
+				BT_DBG("YoYo: DBG_PATH=0x%02x", data->dbg_path_cache);
+			} else {
+				BT_ERR("Invalid DBG_PATH='%s' in %s, using dbg_path=0x%02x",
+				       val, ini_file, data->dbg_path_cache);
+			}
+		} else if (!strcasecmp(line, "ENABLE_INI")) {
+			BT_DBG("Read ENABLE_INI from %s: '%s'", ini_file, val);
+
+			if (!kstrtouint(val, 0, &parsed) && parsed <= 1) {
+				data->enable_ini = !!parsed;
+				BT_DBG("YoYo: ENABLE_INI=%u", data->enable_ini);
+			} else {
+				BT_ERR("Invalid ENABLE_INI='%s' in %s, using enable_ini=%u",
+				       val, ini_file, data->enable_ini);
+			}
+		}
+	}
+
+	if (dbg_path_applied)
+		BT_DBG("Loaded dbg_path=0x%02x from %s", data->dbg_path_cache,
+		       ini_file);
+	else
+		BT_ERR("No valid DBG_PATH in %s, dbg_path=0x%02x", ini_file,
+		       data->dbg_path_cache);
+
+	BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
+	kfree(buf);
+}
+
 /* Helper function to allocate and setup a debug buffer group
  * @data: driver data structure
  * @buf: pointer to data_buf array pointer
@@ -4101,6 +4185,22 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	 * initialized
 	 */
 	data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+	data->enable_ini = false;
+	btintel_pcie_yoyo_init(&data->yoyo);
+	btintel_pcie_load_dbg_path_from_ini(data);
+
+	/* YoYo configuration is supported only with host DRAM debug routing. */
+	if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
+		data->enable_ini = false;
+
+	if (data->enable_ini) {
+		err = btintel_pcie_yoyo_load_and_parse(&data->yoyo, &pdev->dev);
+		if (err) {
+			BT_WARN("YoYo configuration is invalid (%d); keeping legacy defaults",
+				err);
+			btintel_pcie_yoyo_cleanup(&data->yoyo);
+		}
+	}
 	err = btintel_pcie_config_pcie(pdev, data);
 	if (err)
 		goto exit_error;
@@ -4128,11 +4228,14 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
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
 
@@ -4173,6 +4276,8 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	if (current_work() != &data->reset_work)
 		disable_work_sync(&data->reset_work);
 
+	btintel_pcie_yoyo_cleanup(&data->yoyo);
+
 	btintel_pcie_disable_interrupts(data);
 
 	btintel_pcie_synchronize_irqs(data);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3030b4e8b750..e361ed483fd9 100644
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
@@ -737,6 +739,7 @@ struct btintel_pcie_data {
 	u32	boot_stage_cache;
 	u32	img_resp_cache;
 	u32	dbg_path_cache;
+	bool	enable_ini;
 
 	u32	cnvi;
 	u32	cnvr;
@@ -778,6 +781,7 @@ struct btintel_pcie_data {
 	u32	debug_table_size;
 	struct btintel_pcie_dump_mem_info	dump_info;
 	struct btintel_pcie_mbox	mbox;
+	struct btintel_pcie_yoyo_ctx yoyo;
 
 	/* Wait queue for mbox_worker to wait for GP0 alive interrupt */
 	wait_queue_head_t	mbox_parse_wait_q;
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
new file mode 100644
index 000000000000..e8a32d791541
--- /dev/null
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Intel Bluetooth PCIe YoYo debug configuration support. */
+
+#include <linux/errno.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <net/bluetooth/bluetooth.h>
+
+#include "btintel_pcie_debug.h"
+
+static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
+					      const u8 *buf, size_t buf_len)
+{
+	const u8 *ptr = buf;
+	size_t remaining = buf_len;
+	u32 count = 0;
+
+	if (!ctx || !buf)
+		return -EINVAL;
+
+	while (remaining >= sizeof(struct btintel_pcie_tlv_hdr)) {
+		u32 type = get_unaligned_le32(ptr);
+		u32 len = get_unaligned_le32(ptr + sizeof(__le32));
+
+		if (len > remaining - sizeof(struct btintel_pcie_tlv_hdr)) {
+			BT_ERR("YoYo: TLV %u truncated (len=%u remaining=%zu)",
+			       count, len, remaining);
+			return -EBADMSG;
+		}
+
+		switch (type) {
+		case BTINTEL_PCIE_TLV_TYPE_DBG_INFO:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC:
+		case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
+			BT_DBG("YoYo: recognized TLV type 0x%x len=%u", type, len);
+			break;
+		default:
+			BT_DBG("YoYo: unknown TLV type 0x%x len=%u", type, len);
+			break;
+		}
+
+		ptr += sizeof(struct btintel_pcie_tlv_hdr) + len;
+		remaining -= sizeof(struct btintel_pcie_tlv_hdr) + len;
+		count++;
+	}
+
+	if (remaining || !count) {
+		BT_ERR("YoYo: invalid TLV stream (%zu trailing bytes, %u TLVs)",
+		       remaining, count);
+		return -EBADMSG;
+	}
+	return 0;
+}
+
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
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_init);
+
+void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	ctx->enabled = false;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
+
+int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
+				     struct device *dev)
+{
+	const struct firmware *fw;
+	int err;
+
+	if (!ctx || !dev)
+		return -EINVAL;
+
+	err = request_firmware_direct(&fw, BTINTEL_PCIE_YOYO_FW_NAME, dev);
+	if (err) {
+		BT_ERR("YoYo: failed to load %s (%d)",
+		       BTINTEL_PCIE_YOYO_FW_NAME, err);
+		return err;
+	}
+
+	if (fw->size < sizeof(struct btintel_pcie_tlv_hdr))
+		err = -EBADMSG;
+	else
+		err = btintel_pcie_yoyo_parse_tlv_buffer(ctx, fw->data, fw->size);
+
+	release_firmware(fw);
+	if (err) {
+		BT_ERR("YoYo: TLV parsing failed (%d)", err);
+		return err;
+	}
+	ctx->enabled = true;
+	BT_INFO("YoYo: configuration loaded and validated");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_load_and_parse);
+
+MODULE_DESCRIPTION("Intel Bluetooth PCIe YoYo debug configuration support");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
new file mode 100644
index 000000000000..d2b7597848e6
--- /dev/null
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Intel Bluetooth PCIe YoYo debug configuration support. */
+
+#ifndef __BTINTEL_PCIE_DEBUG_H__
+#define __BTINTEL_PCIE_DEBUG_H__
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+#define BTINTEL_PCIE_YOYO_FW_NAME "intel/ibt_debug_yoyo.bin"
+
+#define BTINTEL_PCIE_TLV_TYPE_DBG_INFO		0x01000005
+#define BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC	0x01000006
+#define BTINTEL_PCIE_TLV_TYPE_DBG_HCMD		0x01000007
+#define BTINTEL_PCIE_TLV_TYPE_DBG_REGION		0x01000008
+#define BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER	0x01000009
+#define BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET	0x0100000a
+#define BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE 0x0100000b
+
+#define BTINTEL_PCIE_CONFIG_NAME_LEN		64
+#define BTINTEL_PCIE_DOMAIN_BT			0
+#define BTINTEL_PCIE_CORE_TYPE_BT		1
+
+enum btintel_pcie_image_tlv_type {
+	BTINTEL_PCIE_IMAGE_TLV_TYPE_EXTERNAL = 0x1,
+	BTINTEL_PCIE_IMAGE_TLV_TYPE_INTERNAL = 0x2,
+	BTINTEL_PCIE_IMAGE_TLV_TYPE_UNKNOWN = 0xff,
+};
+
+struct btintel_pcie_tlv_hdr {
+	__le32 type;
+	__le32 length;
+} __packed;
+
+struct btintel_pcie_dbg_hdr {
+	__le32 tlv_data_version;
+	__le32 domain;
+} __packed;
+
+struct btintel_pcie_addr_value {
+	__le32 address;
+	__le32 value;
+} __packed;
+
+struct btintel_pcie_yoyo_ctx {
+	bool enabled;
+	struct list_head region_list;
+	struct list_head trigger_list;
+	struct list_head hcmd_list;
+	struct list_head config_set_list;
+	struct hci_dev *hdev;
+};
+
+int btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx);
+void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx);
+int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
+				     struct device *dev);
+
+#endif /* __BTINTEL_PCIE_DEBUG_H__ */
-- 
2.53.0

