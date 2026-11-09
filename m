Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245529;
	b=XvKjRgzNwzpQ6aTpkOKyRkzlpUZK6Bkde+FuEQ8tQ9+2U0xVduwTghwQukJL3Xlhu441
	 dtNnXVcmGyWXp4GAD/8dAGnLOnVLxtALhUmFiK5tRUzAV9LzSd7OXZni4kUfJpSz6lBZJ
	 pxvdrsCnOWinpZm9p8lnbUAn1R5sxUxH2aLURJB6vjqL5Ny4qAuPyNrkEEuPDHFpfdBiO
	 nTbHm8nLowNbcgn0ErzmAxiFcJOCJkPInb7loSChlwHpAFa86CrPIRR/K1R51ZDvEVUWP
	 cIBdwXjnrFFO2y+vxDoZEoOG5yZ/pLnYubVkBIC2oYtqgptqMBJrXKek5B7d1ADhtOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245529;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=laPTWEeOMkqqJhTVFNclKrXvQRYEuFctNHFtqsZtQ1E=;
	b=Lg7pJ/eTE6hZwf1x/73kZF2eQKBzUMvrhmDIh7DLRfGwd5c99futMyhvbYXpwmg516E1
	 B6FHJQ/qDklRDnaMNiYhoLLCxJ+zmTYtAX/GYhSkfVVFiXOKvwxNffu4OJ4Zym+pkHUsl
	 27PWlf+lpA+IXf83LJIpB3VSO84JpLNnwmwXNpTFQp7VhMqUfuPG6j4/AEVkuPPYMSi2o
	 j02rL37DSsU2wjTHvNwJuTigi5YPg2dVbfT9Hm/lzY5VRH2gSoA/LmIupgfLHJPBA6luw
	 wX1gjHqf71hT0AC577bh8XKLhV4dOKwFwkI4tmMBxu0UoGEhPzz37KdWDhDXy067sfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=USfmsDgn;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537F606EE82;
	Mon,  9 Nov 2026 17:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C537F606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=USfmsDgn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794245528; x=1825781528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qhldAf3Kz8tAv8CXuMf60nPqWBEcP1A+zW7wWEmvCo=;
  b=USfmsDgn5e+SMrQAbajk7S/BG5l2ZNsMaYZaJrDIzSze4HSsfdbjhIOK
   QB256gP+6FMFQPC6jeIKROSasRR1EKAJobRpBh0hfDIzSguhhvfYe67Hw
   NlWl3+h5v2M7Le412LiQS5dLVt93RYlB2SD3b2ztdlDdDUXuA1we3am7J
   GdHq3WhhxoDYWPeRaoZGilH8hL93h59OKWolcw35ieBX/AvF4bCt0Ycta
   P7vArIaheOFS4UrRNVOxnMpFl9XYdlNOibjRt5Woi3bA0DCdUcSijwVyj
   t2NViaAIQA6ahm03fCxB6jJv5R0JMKhLiiPGe4XCRrWY0q4X7xnsur+gG
   w==;
X-CSE-ConnectionGUID: OF+DHG4bTi6dqfXTb/etgA==
X-CSE-MsgGUID: XfpSmtU6TpKswc736w1/KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2876036"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2876036"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:32:08 -0800
X-CSE-ConnectionGUID: 32+QGz9EQvOWxu6dK+yJQg==
X-CSE-MsgGUID: nV7pX+njRwOrl1wXb9n4Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7970224"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2026 09:32:05 -0800
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
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add yoyo configuration for debug region
Date: Mon,  9 Nov 2026 19:31:53 +0200
Message-ID: <20261109173154.8576-2-ajay.k.v@intel.com>
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

Add parsing of the YoYo DEBUG_REGION TLV. A region TLV defines
a named, addressable debug region and registers it by region ID;
it does not trigger a dump by itself. A later trigger TLV
selects regions through a 64-bit region ID mask, and the dump
for each selected region is dispatched based on its stored
region type.

Each region TLV is validated for domain, version, region ID,
region type, address list and size. Invalid entries are skipped
with a warning. Valid regions are stored in the region list of
the YoYo context, replacing any existing entry with the same
region ID, and are freed when the YoYo context is cleaned up.

Signed-off-by: Ajaykv <ajay.k.v@intel.com>
---
 drivers/bluetooth/btintel_pcie_debug.c | 144 +++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie_debug.h | 133 +++++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index c52ef24dd0b0..d132214dcc8c 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -503,6 +503,140 @@ static int btintel_pcie_yoyo_parse_config_set(struct btintel_pcie_yoyo_ctx *ctx,
 	return 0;
 }
 
+static int btintel_pcie_yoyo_parse_region(struct btintel_pcie_yoyo_ctx *ctx,
+					  const struct btintel_pcie_tlv_region *tlv,
+					  u32 len)
+{
+	struct btintel_pcie_yoyo_region *old_region, *region, *tmp;
+	u32 addr_count = 0, addr_offset = 0, domain, version;
+	u32 addr_bytes, alloc_id, size;
+	u16 region_id;
+
+	if (len < sizeof(*tlv) - sizeof(struct btintel_pcie_tlv_hdr)) {
+		BT_WARN("YoYo: region tlv is too short or Invalid");
+		return -EBADMSG;
+	}
+
+	domain = get_unaligned_le32(&tlv->dbg_hdr.domain);
+	version = get_unaligned_le32(&tlv->dbg_hdr.tlv_data_version);
+	if (domain != BTINTEL_PCIE_DOMAIN_BT ||
+	    version != BTINTEL_PCIE_REGION_TLV_VERSION) {
+		BT_WARN("YoYo: unsupported region domain/version (%u/%u), skipping",
+			domain, version);
+		return 0;
+	}
+
+	region_id = get_unaligned_le16(&tlv->region_id);
+	if (region_id > BTINTEL_PCIE_REGION_ID_MAX) {
+		BT_WARN("YoYo: invalid region_id %u, skipping", region_id);
+		return 0;
+	}
+
+	if (tlv->region_type <= BTINTEL_PCIE_REGION_INVALID ||
+	    tlv->region_type >= BTINTEL_PCIE_REGION_TYPE_MAX) {
+		BT_WARN("YoYo: invalid region type %u, skipping", tlv->region_type);
+		return 0;
+	}
+
+	/* Any trailing bytes after the fixed region structure are an address
+	 * list, regardless of region type, mirroring the reference parser.
+	 */
+	addr_offset = sizeof(*tlv) - sizeof(struct btintel_pcie_tlv_hdr);
+	addr_bytes = len - addr_offset;
+	if (addr_bytes % sizeof(__le32)) {
+		BT_WARN("YoYo: invalid region addr_bytes length %u", addr_bytes);
+		return 0;
+	}
+
+	addr_count = addr_bytes / sizeof(__le32);
+
+	/* Types without a size field default to a valid dword size. */
+	size = sizeof(u32);
+	switch (tlv->region_type) {
+	case BTINTEL_PCIE_REGION_DEVICE_MEM:
+		size = get_unaligned_le32(&tlv->conf_params.dev_addr.size_bytes);
+		fallthrough;
+	case BTINTEL_PCIE_REGION_PERIPH_MAC:
+	case BTINTEL_PCIE_REGION_CSR:
+		if (!addr_count) {
+			BT_WARN("YoYo: region id=%u type=%u has no addresses, skipping",
+				region_id, tlv->region_type);
+			return 0;
+		}
+		break;
+	case BTINTEL_PCIE_REGION_DRAM_BUF:
+		alloc_id = get_unaligned_le32(&tlv->conf_params.dram_alloc_id);
+		if (alloc_id < BTINTEL_PCIE_ALLOC_ID_DBGC1 ||
+		    alloc_id > BTINTEL_PCIE_ALLOC_ID_DBGC3) {
+			BT_WARN("YoYo: region id=%u invalid dram alloc id %u, skipping",
+				region_id, alloc_id);
+			return 0;
+		}
+		break;
+	case BTINTEL_PCIE_REGION_INTERNAL_BUF:
+		size = get_unaligned_le32(&tlv->conf_params.internal_buf.size_bytes);
+		break;
+	case BTINTEL_PCIE_REGION_SPECIAL_DEV_MEM:
+		size = get_unaligned_le32(&tlv->conf_params.special_dev_addr.size_bytes);
+		break;
+	default:
+		break;
+	}
+
+	if (!size || size % sizeof(u32)) {
+		BT_WARN("YoYo: region id=%u type=%u invalid size %u, skipping",
+			region_id, tlv->region_type, size);
+		return 0;
+	}
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->region_id = region_id;
+	region->dump_policy = get_unaligned_le16(&tlv->region_dump_policy);
+	region->type = tlv->region_type;
+	region->sub_type = tlv->region_sub_type;
+	region->sub_type_ver = tlv->region_sub_type_ver;
+	memcpy(region->name, tlv->region_name, BTINTEL_PCIE_REGION_NAME_LEN);
+	memcpy(&region->conf, &tlv->conf_params, sizeof(region->conf));
+
+	if (addr_count) {
+		const u8 *addr_data = (const u8 *)tlv +
+				      sizeof(struct btintel_pcie_tlv_hdr) + addr_offset;
+		u32 i;
+
+		region->addrs = kmalloc_array(addr_count, sizeof(*region->addrs),
+					      GFP_KERNEL);
+		if (!region->addrs) {
+			kfree(region);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < addr_count; i++)
+			region->addrs[i] = get_unaligned_le32(addr_data +
+							     i * sizeof(__le32));
+	}
+	region->num_addrs = addr_count;
+
+	/* Swap into list if duplicate region_id exists, otherwise append */
+	list_for_each_entry_safe(old_region, tmp, &ctx->region_list, list) {
+		if (old_region->region_id == region_id) {
+			list_replace(&old_region->list, &region->list);
+			kfree(old_region->addrs);
+			kfree(old_region);
+			goto out;
+		}
+	}
+
+	list_add_tail(&region->list, &ctx->region_list);
+
+out:
+	BT_DBG("YoYo: region id=%u type=%u name='%.32s'",
+	       region->region_id, region->type, region->name);
+	return 0;
+}
+
 /*
  * Parse the optional YoYo firmware TLV stream and validate each record.
  * This is the entry point for the runtime debug configuration payload.
@@ -547,6 +681,8 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 			ret = btintel_pcie_yoyo_parse_config_set(ctx, (const void *)tlv, len);
 			break;
 		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
+			ret = btintel_pcie_yoyo_parse_region(ctx, (const void *)tlv, len);
+			break;
 		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
@@ -611,6 +747,7 @@ EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_init);
 void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 {
 	struct btintel_pcie_yoyo_config_set *config_set, *config_tmp;
+	struct btintel_pcie_yoyo_region *region, *region_tmp;
 
 	if (!ctx)
 		return;
@@ -627,6 +764,13 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 		kfree(config_set->pairs);
 		kfree(config_set);
 	}
+
+	list_for_each_entry_safe(region, region_tmp, &ctx->region_list, list) {
+		list_del(&region->list);
+		kfree(region->addrs);
+		kfree(region);
+	}
+
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
 
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index a9ecc7462d4e..f13107994fcf 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -60,6 +60,8 @@ bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data);
 #define BTINTEL_PCIE_DBG_INFO_TLV_VERSION	2
 #define BTINTEL_PCIE_BUF_ALLOC_TLV_VERSION	1
 #define BTINTEL_PCIE_CONFIG_SET_TLV_VERSION	1
+#define BTINTEL_PCIE_REGION_TLV_VERSION		3
+
 /* Debug Info TLV */
 #define BTINTEL_PCIE_CONFIG_NAME_LEN		64
 #define BTINTEL_PCIE_DOMAIN_BT			0
@@ -69,6 +71,9 @@ bool btintel_pcie_fatal_err_testmode_active(struct btintel_pcie_data *data);
 #define BTINTEL_PCIE_MAX_BUF_FRAGS		16
 #define BTINTEL_PCIE_MIN_BUF_SIZE		(32 * 1024)
 #define BTINTEL_PCIE_MAX_BUF_SIZE		(4 * 1024 * 1024)
+/* Region Tlv */
+#define BTINTEL_PCIE_REGION_ID_MAX		63
+#define BTINTEL_PCIE_REGION_NAME_LEN		32
 
 enum btintel_pcie_image_tlv_type {
 	BTINTEL_PCIE_IMAGE_TLV_TYPE_EXTERNAL	= 0x1,
@@ -129,6 +134,42 @@ enum btintel_pcie_dbg_timepoint {
 	BTINTEL_PCIE_TP_MAX_NUM,
 };
 
+/* Region types */
+enum btintel_pcie_dbg_region_type {
+	BTINTEL_PCIE_REGION_INVALID		= 0,
+	BTINTEL_PCIE_REGION_TLV		= 1,
+	BTINTEL_PCIE_REGION_INTERNAL_BUF	= 2,
+	BTINTEL_PCIE_REGION_DRAM_BUF		= 3,
+	BTINTEL_PCIE_REGION_DEVICE_TXFIFO	= 4,
+	BTINTEL_PCIE_REGION_DEVICE_RXFIFO	= 5,
+	BTINTEL_PCIE_REGION_LMAC_ERROR_TBL	= 6,
+	BTINTEL_PCIE_REGION_UMAC_ERROR_TBL	= 7,
+	BTINTEL_PCIE_REGION_FW_RSP_OR_NOTIF	= 8,
+	BTINTEL_PCIE_REGION_DEVICE_MEM		= 9,
+	BTINTEL_PCIE_REGION_PERIPH_MAC		= 10,
+	BTINTEL_PCIE_REGION_PERIPH_PHY		= 11,
+	BTINTEL_PCIE_REGION_PERIPH_AUX		= 12,
+	BTINTEL_PCIE_REGION_VM			= 13,
+	BTINTEL_PCIE_REGION_CSR			= 14,
+	BTINTEL_PCIE_REGION_DRAM_IMR		= 15,
+	BTINTEL_PCIE_REGION_PCI_IOSF_CFG	= 16,
+	BTINTEL_PCIE_REGION_SPECIAL_DEV_MEM	= 17,
+	BTINTEL_PCIE_REGION_DBGI_SRAM		= 18,
+	BTINTEL_PCIE_REGION_TYPE_MAX
+};
+
+/*
+ * Region dump policy flags for OS dump-size limits.
+ * @BTINTEL_PCIE_REGION_POLICY_NO_LIMIT: OS has no dump-size limit
+ * @BTINTEL_PCIE_REGION_POLICY_MAX_600KB: Wi-Fi LKD dump request
+ * @BTINTEL_PCIE_REGION_POLICY_MAX_5MB: Microsoft BSOD/LKD dump request
+ */
+enum btintel_pcie_dbg_region_policy {
+	BTINTEL_PCIE_REGION_POLICY_NO_LIMIT	= BIT(0),
+	BTINTEL_PCIE_REGION_POLICY_MAX_600KB	= BIT(1),
+	BTINTEL_PCIE_REGION_POLICY_MAX_5MB	= BIT(2),
+};
+
 /* TLV header */
 struct btintel_pcie_tlv_hdr {
 	__le32 type;
@@ -209,6 +250,84 @@ struct btintel_pcie_tlv_config_set {
 	struct btintel_pcie_addr_value addr_pair[];
 } __packed;
 
+/* Device address for region conf params */
+struct btintel_pcie_tlv_dev_addr {
+	__le32 size_bytes;
+	__le32 addr_offset;
+} __packed;
+
+/* Special device address */
+struct btintel_pcie_tlv_special_dev_addr {
+	__le16 special_addr_type;
+	__le16 struct_version;
+	__le32 base_addr;
+	__le32 size_bytes;
+	__le32 addr_offset;
+} __packed;
+
+/* FIFOs */
+struct btintel_pcie_tlv_fifos {
+	__le32 fifo_ids[2];
+	__le32 skip_data;
+	__le32 addr_offset;
+} __packed;
+
+/* Error table */
+struct btintel_pcie_tlv_error_table {
+	__le32 struct_version;
+	__le32 base_addr;
+	__le32 size_bytes;
+	__le32 addr_offset;
+} __packed;
+
+/* Internal buffer */
+struct btintel_pcie_tlv_internal_buf {
+	__le32 alloc_id;
+	__le32 base_addr;
+	__le32 size_bytes;
+} __packed;
+
+/* Region conf params union */
+union btintel_pcie_region_conf_params {
+	struct btintel_pcie_tlv_dev_addr	dev_addr;
+	struct btintel_pcie_tlv_special_dev_addr special_dev_addr;
+	struct btintel_pcie_tlv_fifos	fifos;
+	struct btintel_pcie_tlv_error_table	error_table;
+	struct btintel_pcie_tlv_internal_buf internal_buf;
+	__le32				dram_alloc_id;
+	__le32				tlv_output_bitmask;
+} __packed;
+
+/*
+ * struct btintel_pcie_tlv_region - YoYo debug region TLV
+ * @hdr: Common TLV type and payload length
+ * @dbg_hdr: Debug TLV version and domain
+ * @region_id: Identifier used to select this region for a trigger
+ * @region_dump_policy: Policy flags controlling dump size limits
+ * @region_type: Region storage or access type
+ * @region_sub_type: Region-specific subtype
+ * @region_sub_type_ver: Version of the region subtype data
+ * @reserved: Reserved for future use
+ * @region_name: Fixed-size region name
+ * @conf_params: Type-specific fixed configuration parameters
+ *
+ * Describes a debug region in the packed firmware TLV. Address-based region
+ * types may append a variable-length address array after @conf_params.
+ * Multi-byte fields are stored in little-endian format.
+ */
+struct btintel_pcie_tlv_region {
+	struct btintel_pcie_tlv_hdr hdr;
+	struct btintel_pcie_dbg_hdr dbg_hdr;
+	__le16 region_id;
+	__le16 region_dump_policy;
+	u8     region_type;
+	u8     region_sub_type;
+	u8     region_sub_type_ver;
+	u8     reserved;
+	u8     region_name[BTINTEL_PCIE_REGION_NAME_LEN];
+	union  btintel_pcie_region_conf_params conf_params;
+} __packed;
+
 /* Parsed buffer allocation entry in the YoYo context */
 struct btintel_pcie_buf_alloc {
 	u32	alloc_id;
@@ -229,6 +348,20 @@ struct btintel_pcie_yoyo_config_set {
 	struct btintel_pcie_addr_value	*pairs;
 };
 
+/* Parsed region entry */
+struct btintel_pcie_yoyo_region {
+	struct list_head	list;
+	u16			region_id;
+	u16			dump_policy;
+	u8			type;
+	u8			sub_type;
+	u8			sub_type_ver;
+	char		name[BTINTEL_PCIE_REGION_NAME_LEN];
+	u32			num_addrs;
+	u32			*addrs;
+	union btintel_pcie_region_conf_params conf;
+};
+
 /*
  * struct btintel_pcie_yoyo_ctx - Runtime state for YoYo debug configuration
  * @enabled: Whether the loaded YoYo configuration passed validation
-- 
2.53.0

