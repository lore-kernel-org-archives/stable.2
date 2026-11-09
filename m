Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245532;
	b=SEXGhbNeOHCqZMXvUHMOIgx+IhTq+f2gjl8qwmQAWtw66gFU0VE+2Fca/4lY03IyhcpD
	 5WEUR7bOmpvcdGqkjg+oh7pkNxK8O5OdQgTOFoyNtOlOrSIB+n21fztD88xx7jLb+6S5C
	 +I51kVkvo1A20ud0mgy9Bni5sXXtNh2c+DmnIcDLS2BRP+MVJ2EOqev0D8WyvboXInBtz
	 PkQT2Qg6RJuOxylagybJyo5UDe7tvpSWHYopYS85zD5X/L4DJY0PkJFfefah2INUvGMEl
	 bI+SXxb6YXHzX+vQ2gpcQduJJXH9PhJvoe42YvCS05QT+7agsfKFNS/roescPdKYNcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245532;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gd/YSoytHwr/p2TGkIdWJzz3Ge9YKZKl4CuwsTUzviA=;
	b=AkwZF5znOGoKzmkk3UY2c4FEynY+jiJ32qfB2Z+VQVNh+SbXcCUw5i2oLr+CzEtI5VhF
	 S4jbBrr44RGaVDMJA0mS0qLqIcQ/SyVinGyfFn8qgEbEo66DncX0wCL0HUGmxjozecpue
	 0pkEeT3S8rPu9bTHaFFhfdnkyz7iQqPBkZmG1L5Et+MvxNjjxadUHUKTUWFxLd1Hz1vQC
	 LFnB4dirOEOgFHQZOleXUVVxPfrNhm3G2TjF6knS3dfhQwpw3+mxjFRfCCTxefUKp9G5b
	 FUwwOgRBWEmmNUA4qU7C0KaPGf8la48i+Y8i2mfdNRzc+HvnB8r6BSqn6oBeKjlaY1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ifBLq4Fn;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60F606A325;
	Mon,  9 Nov 2026 17:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A60F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ifBLq4Fn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794245531; x=1825781531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o67kH6v78MRcVDoM3Kk06ld5Nv/YX8dzCofhjrICOMk=;
  b=ifBLq4FnmSlmg3hT/zzem33SKdqa/z13bd6WLC90z1T0ClNADGLKaOVT
   q17o7zOAe1houi5q8+WhqLaNUJhBnWXpvsg/Y6400Ct+nHtr5ezFdX5SL
   m7OdBFwq5f0K/SIuKPj0xY7n55R5qi9e2KLSsKBe5JwHriodUjGRGMVrZ
   Qp55lFYLn5jbqY3YW9XOA2bfjKtqMkPGqIcGTK9lXfvq1mI9fIfEDAnoF
   llXnoNjBMVywGnE7oK+pd7ew/jmaA+H0bOzatlgA4W1Of+FYNDLZD2est
   FeQFyUWTc49kzv4moceQH0k8xdJiC7TTU2nQHsSbkhTCcejzyTSFeXQwN
   Q==;
X-CSE-ConnectionGUID: n9J2Pb1rQYesaL5hj8tQlw==
X-CSE-MsgGUID: 7TdMIxxoTnqzdO8ucL1pvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2876046"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2876046"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:32:11 -0800
X-CSE-ConnectionGUID: uG3b3GRxT/ab0TGXm6rhoA==
X-CSE-MsgGUID: +Jyk+CCRRkCZZKx8LYDH6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7970255"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2026 09:32:08 -0800
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
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add yoyo configuration for Hci cmd Tlvs
Date: Mon,  9 Nov 2026 19:31:54 +0200
Message-ID: <20261109173154.8576-3-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109173154.8576-1-ajay.k.v@intel.com>
References: <20261109173154.8576-1-ajay.k.v@intel.com>
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

Add parsing of the YoYo HCI command TLV so that HCI commands can
be sent to the controller through the external TLV file. Each
TLV is validated for domain, version, timepoint and command
length. Only the ALIVE timepoint is supported, and periodic
commands are skipped with a warning. Valid commands are stored
in the HCI command list of the YoYo context and are freed when
the YoYo context is cleaned up.

When the ALIVE timepoint is reached after setup, the stored
commands are sent in order. A command is skipped if its
parameter length does not match the TLV payload. Sending stops
if the device is halted, in recovery, in D3 or unregistering,
or if a command fails because of a timeout or a lost device.
Other command failures are logged and do not stop normal
Bluetooth bring-up.

Signed-off-by: Ajaykv <ajay.k.v@intel.com>
---
 drivers/bluetooth/btintel_pcie.c       | 96 ++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie_debug.c | 75 +++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h | 46 ++++++++++--
 3 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index de740477e6d7..8334ebea76ef 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -657,6 +657,8 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	hci_recv_diag(hdev, skb);
 }
 
+static inline bool btintel_pcie_in_d3(struct btintel_pcie_data *data);
+
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb, u32 pkt_type, u16 opcode)
 {
@@ -927,6 +929,90 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	}
 }
 
+/* btintel_yoyo_send_hcmds - Send all HCMDs configured for a timepoint */
+static void btintel_pcie_yoyo_send_hcmds(struct btintel_pcie_data *data,
+					 enum btintel_pcie_dbg_timepoint tp)
+{
+	struct btintel_pcie_yoyo_hcmd *hcmd;
+	struct sk_buff *skb;
+	u8 plen;
+	u16 opcode;
+
+	if (!data)
+		return;
+
+	/* Held across __hci_cmd_sync() so cleanup cannot free entries in use */
+	mutex_lock(&data->yoyo.lock);
+	if (!data->yoyo.enabled || !data->hdev) {
+		mutex_unlock(&data->yoyo.lock);
+		return;
+	}
+
+	list_for_each_entry(hcmd, &data->yoyo.hcmd_list, list) {
+		long err;
+
+		if (hcmd->time_point != tp)
+			continue;
+
+		/* Stop if device state changed or driver is shutting down */
+		if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags) ||
+		    test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags) ||
+		    btintel_pcie_in_d3(data) ||
+		    hci_dev_test_flag(data->hdev, HCI_UNREGISTER))
+			break;
+
+		if (hcmd->cmd_len < 3) {
+			bt_dev_warn(data->hdev, "YoYo: hci command too short (%u bytes)",
+				    hcmd->cmd_len);
+			continue;
+		}
+
+		opcode = get_unaligned_le16(hcmd->cmd_data);
+		plen = hcmd->cmd_data[2];
+
+		if (plen != hcmd->cmd_len - 3) {
+			bt_dev_warn(data->hdev,
+				    "YoYo: hci command 0x%04x plen %u does not match tlv payload %u",
+				    opcode, plen, hcmd->cmd_len - 3);
+			continue;
+		}
+
+		bt_dev_dbg(data->hdev, "YoYo: sending hci command, opcode=0x%04x len=%u at tp=%u",
+			   opcode, plen, tp);
+
+		skb = __hci_cmd_sync(data->hdev, opcode, plen,
+				     hcmd->cmd_data + 3,
+				     HCI_CMD_TIMEOUT);
+		/* HCI Err 0x11 corresponds to errno -95 (UNSUPPORTED)
+		 * HCI Err 0x12 corresponds to errno -22 (INVAL)
+		 * HCI Err 0x16 corresponds to errno -16 (EBUSY/CMD DISALLOWED)
+		 */
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+
+			/* Command completed with Command Status (0x0F) */
+			if (err == -ENODATA)
+				continue;
+
+			bt_dev_dbg(data->hdev, "YoYo: hci command 0x%04x failed: %ld",
+				   opcode, err);
+			/* A timeout already made the HCI core run hdev->reset
+			 * and start device recovery; stop issuing debug
+			 * commands instead of adding more timeouts to it.
+			 */
+			if (err == -ETIMEDOUT || err == -ENODEV ||
+			    err == -EHOSTDOWN || err == -EINTR)
+				break;
+		} else {
+			bt_dev_dbg(data->hdev, "YoYo: hci command 0x%04x completed successfully",
+				   opcode);
+			kfree_skb(skb);
+		}
+	}
+
+	mutex_unlock(&data->yoyo.lock);
+}
+
 static void
 btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 				    u32 time_point)
@@ -1046,11 +1132,16 @@ static void btintel_pcie_yoyo_handle_timepoint(struct btintel_pcie_data *data,
 	if (!data || !data->yoyo.enabled)
 		return;
 
+	BT_DBG("YoYo: Handling timepoint %u", tp);
+
 	if (tp <= BTINTEL_PCIE_TP_INVALID || tp >= BTINTEL_PCIE_TP_MAX_NUM) {
 		BT_WARN("YoYo: invalid timepoint %u", tp);
 		return;
 	}
 
+	/* PRE-DUMP phase: send HCMDs and apply config sets */
+	btintel_pcie_yoyo_send_hcmds(data, tp);
+
 	btintel_pcie_apply_yoyo_config_sets(data, tp);
 }
 
@@ -4265,9 +4356,14 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		if (btintel_pcie_fatal_err_testmode_active(data))
 			set_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags);
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
+
 		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
 		btintel_pcie_unmask_hw_rfkill(data);
 		btintel_delayed_hw_rfkill(data, true);
+
+		/* Notify YoYo: device is alive and operational */
+		btintel_pcie_yoyo_handle_timepoint(data,
+						   BTINTEL_PCIE_TP_AFTER_ALIVE);
 	}
 	return err;
 }
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index d132214dcc8c..a299867be1a7 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -637,6 +637,68 @@ static int btintel_pcie_yoyo_parse_region(struct btintel_pcie_yoyo_ctx *ctx,
 	return 0;
 }
 
+static int btintel_pcie_yoyo_parse_hcmd(struct btintel_pcie_yoyo_ctx *ctx,
+					const struct btintel_pcie_tlv_hcmd *tlv,
+					u32 len)
+{
+	u32 fixed_size = sizeof(*tlv) - sizeof(struct btintel_pcie_tlv_hdr);
+	u32 cmd_len, time_point, period_msec, domain, version;
+	struct btintel_pcie_yoyo_hcmd *hcmd;
+
+	if (len < fixed_size) {
+		BT_WARN("YoYo: hci cmd tlv is too short or Invalid");
+		return -EBADMSG;
+	}
+
+	domain = get_unaligned_le32(&tlv->dbg_hdr.domain);
+	version = get_unaligned_le32(&tlv->dbg_hdr.tlv_data_version);
+	if (domain != BTINTEL_PCIE_DOMAIN_BT ||
+	    version != BTINTEL_PCIE_HCMD_TLV_VERSION) {
+		BT_WARN("YoYo: unsupported hcmd domain/version (%u/%u), skipping",
+			domain, version);
+		return 0;
+	}
+
+	time_point = get_unaligned_le32(&tlv->time_point);
+	if (time_point != BTINTEL_PCIE_TP_AFTER_ALIVE) {
+		BT_WARN("YoYo: skipping hcmd for timepoint %u", time_point);
+		return 0;
+	}
+
+	cmd_len = len - fixed_size;
+	if (cmd_len < 3 || (cmd_len - 3) > 255) {
+		BT_WARN("YoYo: invalid HCMD payload length (%u)", cmd_len);
+		return 0;
+	}
+
+	period_msec = get_unaligned_le32(&tlv->period_msec);
+	if (period_msec) {
+		BT_WARN("YoYo: periodic hcmd not supported (period=%u ms), skipping",
+			period_msec);
+		return 0;
+	}
+
+	hcmd = kzalloc_obj(*hcmd, GFP_KERNEL);
+	if (!hcmd)
+		return -ENOMEM;
+
+	hcmd->time_point = time_point;
+	hcmd->period_msec = period_msec;
+	hcmd->cmd_len = cmd_len;
+
+	hcmd->cmd_data = kmemdup(tlv->cmd_data, cmd_len, GFP_KERNEL);
+	if (!hcmd->cmd_data) {
+		kfree(hcmd);
+		return -ENOMEM;
+	}
+
+	BT_DBG("YoYo: hcmd tp=%u period=%u cmd_len=%u",
+	       hcmd->time_point, hcmd->period_msec, hcmd->cmd_len);
+
+	list_add_tail(&hcmd->list, &ctx->hcmd_list);
+	return 0;
+}
+
 /*
  * Parse the optional YoYo firmware TLV stream and validate each record.
  * This is the entry point for the runtime debug configuration payload.
@@ -683,8 +745,10 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
 			ret = btintel_pcie_yoyo_parse_region(ctx, (const void *)tlv, len);
 			break;
-		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
+			ret = btintel_pcie_yoyo_parse_hcmd(ctx, (const void *)tlv, len);
+			break;
+		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
 			BT_DBG("YoYo: valid tlv type 0x%x len=%u", type, len);
 			break;
@@ -728,6 +792,7 @@ int btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx)
 		return -EINVAL;
 
 	memset(ctx, 0, sizeof(*ctx));
+	mutex_init(&ctx->lock);
 	INIT_LIST_HEAD(&ctx->region_list);
 	INIT_LIST_HEAD(&ctx->trigger_list);
 	INIT_LIST_HEAD(&ctx->hcmd_list);
@@ -748,10 +813,12 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 {
 	struct btintel_pcie_yoyo_config_set *config_set, *config_tmp;
 	struct btintel_pcie_yoyo_region *region, *region_tmp;
+	struct btintel_pcie_yoyo_hcmd *hcmd, *hcmd_tmp;
 
 	if (!ctx)
 		return;
 
+	mutex_lock(&ctx->lock);
 	ctx->enabled = false;
 	ctx->dbg_info_present = false;
 	ctx->num_buf_allocs = 0;
@@ -771,6 +838,12 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 		kfree(region);
 	}
 
+	list_for_each_entry_safe(hcmd, hcmd_tmp, &ctx->hcmd_list, list) {
+		list_del(&hcmd->list);
+		kfree(hcmd->cmd_data);
+		kfree(hcmd);
+	}
+	mutex_unlock(&ctx->lock);
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
 
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index f13107994fcf..cada3b8ecda5 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -10,6 +10,7 @@
 #define __BTINTEL_PCIE_DEBUG_H__
 
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
@@ -61,6 +62,7 @@ bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data);
 #define BTINTEL_PCIE_BUF_ALLOC_TLV_VERSION	1
 #define BTINTEL_PCIE_CONFIG_SET_TLV_VERSION	1
 #define BTINTEL_PCIE_REGION_TLV_VERSION		3
+#define BTINTEL_PCIE_HCMD_TLV_VERSION		1
 
 /* Debug Info TLV */
 #define BTINTEL_PCIE_CONFIG_NAME_LEN		64
@@ -328,7 +330,29 @@ struct btintel_pcie_tlv_region {
 	union  btintel_pcie_region_conf_params conf_params;
 } __packed;
 
-/* Parsed buffer allocation entry in the YoYo context */
+/*
+ * struct btintel_pcie_tlv_hcmd - YoYo HCI command TLV
+ * @hdr: Common TLV type and payload length
+ * @dbg_hdr: Debug TLV version and domain
+ * @time_point: Timepoint at which to send the command
+ * @period_msec: Periodic interval in milliseconds (0 for one-time execution)
+ * @reserved: Command header (cmd_id, group_id, le16 seq_num); written as zero
+ *	      by the tooling and not used by the driver
+ * @cmd_data: Variable-length raw HCI command packet
+ *
+ * Describes an HCI command to dispatch at a specified timepoint. Multi-byte
+ * fields are stored in little-endian format in the packed firmware TLV.
+ */
+struct btintel_pcie_tlv_hcmd {
+	struct btintel_pcie_tlv_hdr hdr;
+	struct btintel_pcie_dbg_hdr dbg_hdr;
+	__le32 time_point;
+	__le32 period_msec;
+	u8     reserved[4];
+	u8     cmd_data[];
+} __packed;
+
+/* Parsed buffer allocation entry */
 struct btintel_pcie_buf_alloc {
 	u32	alloc_id;
 	u32	buf_location;
@@ -338,7 +362,7 @@ struct btintel_pcie_buf_alloc {
 	bool	present;
 };
 
-/* Parsed config set entry in yoyo ctx */
+/* Parsed config set entry */
 struct btintel_pcie_yoyo_config_set {
 	struct list_head		list;
 	u32				time_point;
@@ -362,6 +386,15 @@ struct btintel_pcie_yoyo_region {
 	union btintel_pcie_region_conf_params conf;
 };
 
+/* Parsed HCMD entry */
+struct btintel_pcie_yoyo_hcmd {
+	struct list_head	list;
+	u32			time_point;
+	u32			period_msec;
+	u32			cmd_len;
+	u8			*cmd_data;
+};
+
 /*
  * struct btintel_pcie_yoyo_ctx - Runtime state for YoYo debug configuration
  * @enabled: Whether the loaded YoYo configuration passed validation
@@ -373,6 +406,7 @@ struct btintel_pcie_yoyo_region {
  * @buf_alloc: Parsed buffer allocation entries
  * @num_buf_allocs: Number of parsed buffer allocation entries
  * @hdev: Associated HCI device; NULL until successful HCI registration
+ * @lock: Mutex protecting the parsed TLV lists against teardown
  *
  * Stores the validation state and parsed TLV data for the optional YoYo
  * firmware configuration.
@@ -385,8 +419,12 @@ struct btintel_pcie_yoyo_ctx {
 	struct list_head	 hcmd_list;
 	struct list_head	 config_set_list;
 	struct btintel_pcie_buf_alloc buf_alloc[BTINTEL_PCIE_MAX_BUF_ALLOC];
-	int			 num_buf_allocs;
-	struct hci_dev		 *hdev;
+	int			num_buf_allocs;
+	struct hci_dev		*hdev;
+	/* Serializes list teardown against consumers that sleep while
+	 * holding a list-entry pointer, such as HCMD dispatch.
+	 */
+	struct mutex		lock;
 };
 
 int  btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx);
-- 
2.53.0

