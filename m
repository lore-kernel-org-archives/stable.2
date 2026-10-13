Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C84734F4;
	Tue, 13 Oct 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888269; cv=none; b=oRVCpkWVhADTEJq9S/v6Fy6ez3GSPztE9wf378gtKx7lDYT1aQQN6sMHe2uX69Nrpdo58KEEEPqmnnVIPg3ktxFC2nkeXtQrF0+0pNsWQAgVwoWMGyscbpKIoa82RMZu5sy1M7J4YxBTdtjV9I+a/LjqgDo2a7rmPUpiXeTSxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888269; c=relaxed/simple;
	bh=l6up87aew36mVx0mwdLlEZNFJxjK0eQspGqceAD8nvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZfIZzYU2Xs4K+v88D2NBGp4rIGjyLjSs3czTFcHVSsTI1sVT7/ob0OhQL1k187lrf5N9gd3RbTzq30dCETm6n0DO/03VYl/E+hj57kfEVnr0KAGhF4jes9GzQmisIMV+rRA6LLM48qTWbayIVl2kyMAjW8RiWHeJ/GYtCX2ET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nr7b6C4D; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nr7b6C4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791888266; x=1823424266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6up87aew36mVx0mwdLlEZNFJxjK0eQspGqceAD8nvg=;
  b=nr7b6C4DTTXPEsivNmUBcrXIr2KlAXD5AaUP6mlH/OqirsWuMRV33RZd
   5VatazpiYr18h5vY9lHdD6H0jk3IMBXwZpnitJk3AjxQRd+T2PkNtyE10
   5iV3ecF8mgyVgdiS34vxxQ78QLkyB5cNZlyLH94+OXgrwNihqarl0jGLX
   PZcZzlzk1j8GDX1ubrWk7B51C6SJI0JYPD5Ufl5pm4nsHFc4IraiNJFHq
   vTvgiIIT68J7+oC24lRRicEwqFY7Pyf/zM9i8g0GIho91GMelnRn3I5k0
   lhhGl8gIpVJfEodnffMfCPt264aZu+XJyYt4R2UR+W2s8GpBcVWsanoLh
   A==;
X-CSE-ConnectionGUID: yHKf5/AsRgmJCl3GL7HwRg==
X-CSE-MsgGUID: 82vPUyISRqWQdsgw3RWvug==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="494159"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="494159"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:44:26 -0700
X-CSE-ConnectionGUID: 0tbata0CSGW9G9fEWjRtNw==
X-CSE-MsgGUID: ALYYLBlmTjWK4Te8vgsmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1062102"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa009.jf.intel.com with ESMTP; 13 Oct 2026 03:44:24 -0700
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
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: Validate the YoYo DEBUG_INFO TLV
Date: Tue, 13 Oct 2026 13:44:15 +0300
Message-ID: <20261013104416.26143-2-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013104416.26143-1-ajay.k.v@intel.com>
References: <20261013104416.26143-1-ajay.k.v@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ajaykv <ajay.k.v@intel.com>

Require a DEBUG_INFO TLV in the YoYo firmware configuration. Validate
its payload length, TLV version, Bluetooth domain, external image type,
and Bluetooth core type before accepting the configuration.

Reject missing or invalid metadata so the driver keeps legacy DBGC
defaults instead of enabling an incompatible configuration.

Signed-off-by: Ajaykv <ajay.k.v@intel.com>
---
 drivers/bluetooth/btintel_pcie_debug.c | 63 ++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie_debug.h | 10 ++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index e8a32d791541..240724c3d12f 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -4,18 +4,64 @@
 #include <linux/errno.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <net/bluetooth/bluetooth.h>
 
 #include "btintel_pcie_debug.h"
 
+static int btintel_pcie_yoyo_parse_dbg_info(struct btintel_pcie_yoyo_ctx *ctx,
+					    const struct btintel_pcie_tlv_dbg_info *info,
+					    u32 len)
+{
+	const u8 *data = (const u8 *)info;
+	u32 domain, image_type, core_type, version;
+
+	if (len != sizeof(*info) - sizeof(struct btintel_pcie_tlv_hdr))
+		return -EBADMSG;
+
+	image_type = get_unaligned_le32(data +
+				       offsetof(struct btintel_pcie_tlv_dbg_info,
+						image_type));
+	core_type = get_unaligned_le32(data +
+				      offsetof(struct btintel_pcie_tlv_dbg_info,
+					       core_type));
+	domain = get_unaligned_le32(data +
+				   offsetof(struct btintel_pcie_tlv_dbg_info,
+					    dbg_hdr.domain));
+	version = get_unaligned_le32(data +
+				     offsetof(struct btintel_pcie_tlv_dbg_info,
+					      dbg_hdr.tlv_data_version));
+
+	if (domain != BTINTEL_PCIE_DOMAIN_BT ||
+	    version != BTINTEL_PCIE_DBG_INFO_TLV_VERSION) {
+		BT_WARN("YoYo: unsupported domain/version (%u/%u), disabling",
+			domain, version);
+		return -EINVAL;
+	}
+	if (image_type != BTINTEL_PCIE_IMAGE_TLV_TYPE_EXTERNAL) {
+		BT_WARN("YoYo: unsupported image_type 0x%x, disabling", image_type);
+		return -EINVAL;
+	}
+	if (core_type != BTINTEL_PCIE_CORE_TYPE_BT) {
+		BT_WARN("YoYo: non-Bluetooth core_type %u, disabling", core_type);
+		return -EINVAL;
+	}
+
+	ctx->dbg_info_present = true;
+	BT_DBG("YoYo: config='%.64s' image=%u core=%u",
+	       info->config_name, image_type, core_type);
+	return 0;
+}
+
 static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 					      const u8 *buf, size_t buf_len)
 {
 	const u8 *ptr = buf;
 	size_t remaining = buf_len;
 	u32 count = 0;
+	int err;
 
 	if (!ctx || !buf)
 		return -EINVAL;
@@ -32,6 +78,14 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 
 		switch (type) {
 		case BTINTEL_PCIE_TLV_TYPE_DBG_INFO:
+			err = btintel_pcie_yoyo_parse_dbg_info(ctx,
+							       (const void *)ptr,
+								       len);
+			if (err) {
+				ctx->dbg_info_present = false;
+				return err;
+			}
+			break;
 		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
@@ -55,6 +109,10 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 		       remaining, count);
 		return -EBADMSG;
 	}
+	if (!ctx->dbg_info_present) {
+		BT_ERR("YoYo: mandatory DEBUG_INFO TLV missing");
+		return -EBADMSG;
+	}
 	return 0;
 }
 
@@ -78,6 +136,7 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 		return;
 
 	ctx->enabled = false;
+	ctx->dbg_info_present = false;
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
 
@@ -107,6 +166,10 @@ int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
 		BT_ERR("YoYo: TLV parsing failed (%d)", err);
 		return err;
 	}
+	if (!ctx->dbg_info_present) {
+		BT_ERR("YoYo: mandatory DEBUG_INFO TLV missing; using legacy defaults");
+		return -EBADMSG;
+	}
 	ctx->enabled = true;
 	BT_INFO("YoYo: configuration loaded and validated");
 	return 0;
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index d2b7597848e6..16951df2dcaa 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -18,6 +18,7 @@
 #define BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET	0x0100000a
 #define BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE 0x0100000b
 
+#define BTINTEL_PCIE_DBG_INFO_TLV_VERSION	2
 #define BTINTEL_PCIE_CONFIG_NAME_LEN		64
 #define BTINTEL_PCIE_DOMAIN_BT			0
 #define BTINTEL_PCIE_CORE_TYPE_BT		1
@@ -43,8 +44,17 @@ struct btintel_pcie_addr_value {
 	__le32 value;
 } __packed;
 
+struct btintel_pcie_tlv_dbg_info {
+	struct btintel_pcie_tlv_hdr hdr;
+	struct btintel_pcie_dbg_hdr dbg_hdr;
+	__le32 image_type;
+	__le32 core_type;
+	u8 config_name[BTINTEL_PCIE_CONFIG_NAME_LEN];
+} __packed;
+
 struct btintel_pcie_yoyo_ctx {
 	bool enabled;
+	bool dbg_info_present;
 	struct list_head region_list;
 	struct list_head trigger_list;
 	struct list_head hcmd_list;
-- 
2.53.0

