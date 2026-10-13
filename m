Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348353162A;
	Tue, 13 Oct 2026 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916005; cv=none; b=XGKRp87sNCYLgF/wReHmVRjpcUiNc6QgblHfLsM1vzzOZM2K9I3LVrUR3g+rWmUzR2tXkcLaNJVtKk9LXEgnMVcxVl7+oqGJTBgd8KPUbgtRL+HF9qnMOYx6ShtELAbkkKswJjmtjjANYQ6PUJkBqFk4VLUSNvFDQ/HeUYUlwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916005; c=relaxed/simple;
	bh=J1Wh/IVZ2ptogmL0qbIghFtNohKsza/xcOdZpIs5ilg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTX0PpPxlwN9ziOpw6g8W9Iy1hCTPiPTu2/ganxh8wna5tYHvuCZYvIKR7tinADlQIgEkr4P7yEOQ/YJdSHGz3Uw9ItoUJ4BkpP0qwgyVxOU+00DGYobwZZPfUxEwHfmWgrWp+Tm4f2V51HvD9bT1SCA9vSvzqJzNmZALwUEZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcqbQRXb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcqbQRXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791916001; x=1823452001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1Wh/IVZ2ptogmL0qbIghFtNohKsza/xcOdZpIs5ilg=;
  b=EcqbQRXbwjSSSvfp12OuH2iAOugqYtHuldedUffs9a3NrjQqjnOVbAbr
   m3/A65h8xmInK7L/T6dCw1BLmpHwJQdmKd2oyx/kcGNrPtlyl4XVa5bmm
   DnqKj2XVp70UYdi9/RHnkk3hOrFPSreKaV64mmHmYccil6mOz8WYcvZA3
   w6egpKNltDumknzlZskV7WDwckWN4lFR6szuRGOUD7dLjeHu2WDE+CAFO
   nT/8Ozqcc1FWHZimCPdZJSNcNxEFRiKGXiGjCWq415VG2kDvva3riKlgW
   DHQO3x48UpK79Puj+WzJoksy8u9Uw0PXCAorQGX9wyWqbDP62RbcngtCk
   A==;
X-CSE-ConnectionGUID: rpKWj7AKQduk8Rulvg7oYQ==
X-CSE-MsgGUID: fCEkVtlbT7qCy1DIGkce1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="754605"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="754605"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:26:40 -0700
X-CSE-ConnectionGUID: zSm1BIrHSDmxclPqZYSl2Q==
X-CSE-MsgGUID: e+nGF6b2Qqieurx2vJ7EgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1157532"
Received: from unknown (HELO WEBAPTLH032.iind.intel.com) ([10.66.250.231])
  by orviesa005.jf.intel.com with ESMTP; 13 Oct 2026 11:26:37 -0700
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
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Configure YoYo DBGC buffer allocations
Date: Tue, 13 Oct 2026 21:26:26 +0300
Message-ID: <20261013182627.81957-3-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013182627.81957-1-ajay.k.v@intel.com>
References: <20261013182627.81957-1-ajay.k.v@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ajaykv <ajay.k.v@intel.com>

Parse DBGC buffer allocation TLVs for DBGC1 through DBGC3. Validate the
allocation ID, DRAM location, fragment count, requested size, and
minimum fragment size before storing each allocation.

Use configured fragment counts and sizes for DMA buffers, firmware
context descriptors, and coredump collection. On MDBGC devices, omit
unconfigured buffer IDs when YoYo is enabled; retain legacy allocations
when YoYo configuration is absent or invalid. Single-DBGC devices use
DBGC1.

Signed-off-by: Ajaykv <ajay.k.v@intel.com>

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e28f527d6d29..e235a873a3fe 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -315,7 +315,8 @@ static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
 				       void **v_addr,
 				       struct btintel_pcie_dbgc_ctxt_buf *frag,
 				       u32 buf_index,
-				       u32 buf_count)
+				       u32 buf_count,
+				       u32 per_buf_size)
 {
 	struct data_buf *b;
 	int i;
@@ -328,8 +329,7 @@ static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
 	}
 
 	*v_addr = dmam_alloc_coherent(&data->pdev->dev,
-				      buf_count *
-					BTINTEL_PCIE_DBGC_BUFFER_SIZE,
+				      buf_count * per_buf_size,
 					p_addr,
 					GFP_KERNEL | __GFP_NOWARN);
 	if (!*v_addr) {
@@ -339,16 +339,40 @@ static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
 
 	for (i = 0; i < buf_count; i++) {
 		b = &(*buf)[i];
-		b->data_p_addr = *p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-		b->data = *v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		b->data_p_addr = *p_addr + i * per_buf_size;
+		b->data = *v_addr + i * per_buf_size;
 		frag[i].buf_addr_lsb = lower_32_bits(b->data_p_addr);
 		frag[i].buf_addr_msb = upper_32_bits(b->data_p_addr);
-		frag[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		frag[i].buf_size = per_buf_size;
 	}
 
+	BT_INFO("dbgc buf %u allocated: frag_num=%u per_buf_size=%u total_size=%u",
+		buf_index + 1, buf_count, per_buf_size, buf_count * per_buf_size);
+
 	return 0;
 }
 
+/* Returns false if YoYo is enabled and @alloc_id is not configured */
+static bool btintel_pcie_get_mdbgc_cfg(struct btintel_pcie_data *data,
+				       u32 alloc_id, u32 *count, u32 *size)
+{
+	const struct btintel_pcie_buf_alloc *ba;
+
+	ba = btintel_pcie_yoyo_get_buf_alloc(&data->yoyo, alloc_id);
+	if (ba) {
+		*count = ba->max_num_frags;
+		*size = ba->req_buf_size / ba->max_num_frags;
+		return true;
+	}
+
+	if (data->yoyo.enabled)
+		return false;
+
+	*count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
+	*size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	return true;
+}
+
 /* This function initializes the memory for MDBGC buffers and formats the
  * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
  * size as the payload
@@ -358,10 +382,9 @@ static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 	struct btintel_pcie_mdbgc_ctxt db_frag;
 	u32 frag_size = sizeof(db_frag);
 	void *frag_v_addr;
+	u32 buf_count, buf_size;
 	int err;
 
-	data->mdbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
-
 	/* Allocate fragment context structure */
 	frag_v_addr = dmam_alloc_coherent(&data->pdev->dev, frag_size,
 					  &data->mdbgc.frag_p_addr,
@@ -380,46 +403,71 @@ static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 	db_frag.ver = BTINTEL_PCIE_MDBGC_FRAG_VERSION;
 
 	/* Allocate DBGC buffer 1 */
-	db_frag.buf1_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_1;
-	db_frag.buf1_count = data->mdbgc.count;
-	err = btintel_pcie_alloc_dbgc_buf(data,
-					  &data->mdbgc.buf1,
-					  &data->mdbgc.buf1_p_addr,
-					  &data->mdbgc.buf1_v_addr,
-					  db_frag.buf1,
-					  0,
-					  data->mdbgc.count);
-	if (err)
-		return err;
+	if (btintel_pcie_get_mdbgc_cfg(data, BTINTEL_PCIE_ALLOC_ID_DBGC1,
+				       &buf_count, &buf_size)) {
+		db_frag.buf1_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_1;
+		data->mdbgc.buf1_count = buf_count;
+		data->mdbgc.buf1_size = buf_size;
+		db_frag.buf1_count = buf_count;
+
+		err = btintel_pcie_alloc_dbgc_buf(data,
+						  &data->mdbgc.buf1,
+						  &data->mdbgc.buf1_p_addr,
+						  &data->mdbgc.buf1_v_addr,
+						  db_frag.buf1,
+						  0,
+						  buf_count,
+						  buf_size);
+		if (err)
+			return err;
+	}
 
 	/* Allocate DBGC buffer 2 */
-	db_frag.buf2_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_2;
-	db_frag.buf2_count = data->mdbgc.count;
-	err = btintel_pcie_alloc_dbgc_buf(data,
-					  &data->mdbgc.buf2,
-					  &data->mdbgc.buf2_p_addr,
-					  &data->mdbgc.buf2_v_addr,
-					  db_frag.buf2,
-					  1,
-					  data->mdbgc.count);
-	if (err)
-		return err;
+	if (btintel_pcie_get_mdbgc_cfg(data, BTINTEL_PCIE_ALLOC_ID_DBGC2,
+				       &buf_count, &buf_size)) {
+		db_frag.buf2_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_2;
+		data->mdbgc.buf2_count = buf_count;
+		data->mdbgc.buf2_size = buf_size;
+		db_frag.buf2_count = buf_count;
+
+		err = btintel_pcie_alloc_dbgc_buf(data,
+						  &data->mdbgc.buf2,
+						  &data->mdbgc.buf2_p_addr,
+						  &data->mdbgc.buf2_v_addr,
+						  db_frag.buf2,
+						  1,
+						  buf_count,
+						  buf_size);
+		if (err)
+			return err;
+	}
 
 	/* Allocate DBGC buffer 3 */
-	db_frag.buf3_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_3;
-	db_frag.buf3_count = data->mdbgc.count;
-	err = btintel_pcie_alloc_dbgc_buf(data,
-					  &data->mdbgc.buf3,
-					  &data->mdbgc.buf3_p_addr,
-					  &data->mdbgc.buf3_v_addr,
-					  db_frag.buf3,
-					  2,
-					  data->mdbgc.count);
-	if (err)
-		return err;
+	if (btintel_pcie_get_mdbgc_cfg(data, BTINTEL_PCIE_ALLOC_ID_DBGC3,
+				       &buf_count, &buf_size)) {
+		db_frag.buf3_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_3;
+		data->mdbgc.buf3_count = buf_count;
+		data->mdbgc.buf3_size = buf_size;
+		db_frag.buf3_count = buf_count;
+
+		err = btintel_pcie_alloc_dbgc_buf(data,
+						  &data->mdbgc.buf3,
+						  &data->mdbgc.buf3_p_addr,
+						  &data->mdbgc.buf3_v_addr,
+						  db_frag.buf3,
+						  2,
+						  buf_count,
+						  buf_size);
+		if (err)
+			return err;
+	}
 
 	/* Copy fragment to DMA coherent memory */
 	memcpy(data->mdbgc.frag_v_addr, &db_frag, sizeof(db_frag));
+	BT_INFO("MDBGC: buf1 frag=%u size=%u; buf2 frag=%u size=%u; buf3 frag=%u size=%u",
+		db_frag.buf1_count, db_frag.buf1_count * db_frag.buf1[0].buf_size,
+		db_frag.buf2_count, db_frag.buf2_count * db_frag.buf2[0].buf_size,
+		db_frag.buf3_count, db_frag.buf3_count * db_frag.buf3[0].buf_size);
 	return 0;
 }
 
@@ -431,9 +479,21 @@ static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
 {
 	struct btintel_pcie_dbgc_ctxt db_frag;
 	u32 frag_size = sizeof(db_frag);
+	const struct btintel_pcie_buf_alloc *ba;
+	u32 buf_count, buf_size;
 	int err;
 
-	data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
+	ba = btintel_pcie_yoyo_get_buf_alloc(&data->yoyo,
+					     BTINTEL_PCIE_ALLOC_ID_DBGC1);
+	buf_count = ba ? ba->max_num_frags : BTINTEL_PCIE_DBGC_BUFFER_COUNT;
+	buf_size = ba ? ba->req_buf_size / ba->max_num_frags :
+		BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+
+	BT_INFO("dbgc setup: frag_num=%u per_buf_size=%u total_size=%u",
+		buf_count, buf_size, buf_count * buf_size);
+
+	data->dbgc.count = buf_count;
+	data->dbgc.buf_size = buf_size;
 
 	/* Allocate fragment context structure */
 	data->dbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
@@ -451,8 +511,9 @@ static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
 	memset(&db_frag, 0, sizeof(db_frag));
 	db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
 	db_frag.ver = BTINTEL_PCIE_DBGC_FRAG_VERSION;
-	db_frag.total_size = BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
-	db_frag.num_buf = BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
+	db_frag.total_size = sizeof(db_frag.num_buf) +
+			     buf_count * sizeof(db_frag.bufs[0]);
+	db_frag.num_buf = buf_count;
 
 	/* Allocate DBGC buffers */
 	err = btintel_pcie_alloc_dbgc_buf(data,
@@ -461,7 +522,8 @@ static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
 					  &data->dbgc.buf_v_addr,
 					  db_frag.bufs,
 					  0,
-					  data->dbgc.count);
+					  buf_count,
+					  buf_size);
 	if (err)
 		return err;
 
@@ -954,7 +1016,8 @@ static u32 btintel_pcie_dump_list_total_size(struct list_head *list)
 }
 
 static int btintel_pcie_dump_dram(struct list_head *list,
-				  u8 count, struct data_buf *bufs,
+				  u8 count, u32 buf_size,
+				  struct data_buf *bufs,
 				  u32 write_ptr, u32 wrap_ctr, u32 cur_frag,
 				  u32 region_id, const char *name)
 {
@@ -966,7 +1029,7 @@ static int btintel_pcie_dump_dram(struct list_head *list,
 	int i;
 
 	mon_hdr_size = sizeof(*mon_dump);
-	ranges_size = count * (sizeof(*range) + BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+	ranges_size = count * (sizeof(*range) + buf_size);
 	payload_size = mon_hdr_size + ranges_size;
 	total_size = sizeof(*dump_data) + payload_size;
 
@@ -995,12 +1058,10 @@ static int btintel_pcie_dump_dram(struct list_head *list,
 
 	range = (void *)mon_dump->data;
 	for (i = 0; i < count; i++) {
-		range->range_data_size =
-			cpu_to_le32(BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+		range->range_data_size = cpu_to_le32(buf_size);
 		range->dram_base_addr = cpu_to_le64(bufs[i].data_p_addr);
-		memcpy(range->data, bufs[i].data,
-		       BTINTEL_PCIE_DBGC_BUFFER_SIZE);
-		range = (void *)range->data + BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		memcpy(range->data, bufs[i].data, buf_size);
+		range = (void *)range->data + buf_size;
 	}
 
 	list_add_tail(&entry->list, list);
@@ -1009,7 +1070,8 @@ static int btintel_pcie_dump_dram(struct list_head *list,
 
 static int
 btintel_pcie_dump_dram_monitor(struct btintel_pcie_data *data,
-			       struct list_head *list, u8 count,
+				       struct list_head *list, u8 count,
+				       u32 buf_size,
 			       struct data_buf *bufs, u32 status_reg,
 			       u32 wrap_reg, u8 allocation_id, u32 region_id,
 			       const char *name)
@@ -1017,6 +1079,9 @@ btintel_pcie_dump_dram_monitor(struct btintel_pcie_data *data,
 	u32 allocation_offset, write_ptr, wrap_ctr, wr_ptr_status;
 	u8 cur_frag;
 
+	if (!count)
+		return -ENOENT;
+
 	allocation_offset = allocation_id *
 			    BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET;
 	wr_ptr_status = btintel_pcie_rd_dev_mem(data, status_reg +
@@ -1038,8 +1103,8 @@ btintel_pcie_dump_dram_monitor(struct btintel_pcie_data *data,
 		   "allocation=%u wr_ptr_status=0x%08x write_ptr=0x%06x cur_frag=%u wrap_ctr=0x%08x",
 		   allocation_id, wr_ptr_status, write_ptr, cur_frag, wrap_ctr);
 
-	return btintel_pcie_dump_dram(list, count, bufs, write_ptr, wrap_ctr,
-				      cur_frag, region_id, name);
+	return btintel_pcie_dump_dram(list, count, buf_size, bufs, write_ptr,
+				      wrap_ctr, cur_frag, region_id, name);
 }
 
 static int btintel_pcie_dump_target_region(struct btintel_pcie_data *data,
@@ -1320,6 +1385,7 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 	u8 hw_variant;
 	u32 file_len;
 	u8 count;
+	u32 buf_size;
 	int ret;
 	LIST_HEAD(dump_list);
 
@@ -1328,10 +1394,12 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 
 	if (btintel_pcie_is_mdbgc_supported(data)) {
 		mdbgc = &data->mdbgc;
-		count = mdbgc->count;
+		count = mdbgc->buf1_count;
+		buf_size = mdbgc->buf1_size;
 	} else {
 		dbgc = &data->dbgc;
 		count = dbgc->count;
+		buf_size = dbgc->buf_size;
 	}
 
 	hw_variant = INTEL_HW_VARIANT(data->cnvi);
@@ -1351,7 +1419,9 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 	}
 
 	if (btintel_pcie_is_mdbgc_supported(data)) {
-		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list,
+						     mdbgc->buf1_count,
+						     mdbgc->buf1_size,
 						     mdbgc->buf1, status_reg,
 						     wrap_reg,
 						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_1,
@@ -1360,10 +1430,12 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 		if (!ret)
 			regions_mask |=
 				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR1);
-		else
+		else if (ret != -ENOENT)
 			bt_dev_warn(hdev, "Failed to dump DRAM buf1: %d", ret);
 
-		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list,
+						     mdbgc->buf2_count,
+						     mdbgc->buf2_size,
 						     mdbgc->buf2, status_reg,
 						     wrap_reg,
 						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_2,
@@ -1372,10 +1444,12 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 		if (!ret)
 			regions_mask |=
 				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR2);
-		else
+		else if (ret != -ENOENT)
 			bt_dev_warn(hdev, "Failed to dump DRAM buf2: %d", ret);
 
-		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list,
+						     mdbgc->buf3_count,
+						     mdbgc->buf3_size,
 						     mdbgc->buf3, status_reg,
 						     wrap_reg,
 						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_3,
@@ -1384,11 +1458,12 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 		if (!ret)
 			regions_mask |=
 				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR3);
-		else
+		else if (ret != -ENOENT)
 			bt_dev_warn(hdev, "Failed to dump DRAM buf3: %d", ret);
 	} else {
 		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
-						     dbgc->bufs, status_reg,
+						     buf_size, dbgc->bufs,
+						     status_reg,
 						     wrap_reg,
 						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_1,
 						     BTINTEL_PCIE_INI_ID_DRAM_MONITOR1,
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 0a4e508d0beb..d68f83a62922 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -468,6 +468,7 @@ struct rxq {
  */
 struct btintel_pcie_dbgc {
 	u16		count;
+	u32		buf_size;
 
 	void		*frag_v_addr;
 	dma_addr_t	frag_p_addr;
@@ -479,7 +480,12 @@ struct btintel_pcie_dbgc {
 };
 
 struct btintel_pcie_mdbgc {
-	u32		count;
+	u32		buf1_count;
+	u32		buf1_size;
+	u32		buf2_count;
+	u32		buf2_size;
+	u32		buf3_count;
+	u32		buf3_size;
 
 	void		*frag_v_addr;
 	dma_addr_t	frag_p_addr;
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index 615996232cdf..5af00784bf96 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -64,6 +64,76 @@ static int btintel_pcie_yoyo_parse_dbg_info(struct btintel_pcie_yoyo_ctx *ctx,
 	return 0;
 }
 
+static int btintel_pcie_yoyo_parse_buf_alloc(struct btintel_pcie_yoyo_ctx *ctx,
+					     const struct btintel_pcie_tlv_buf_alloc *tlv,
+					     u32 len)
+{
+	u32 alloc_id, buf_location, domain, idx, max_num_frags, min_buf_size;
+	u32 req_buf_size, version;
+
+	if (len != sizeof(*tlv) - sizeof(struct btintel_pcie_tlv_hdr)) {
+		BT_WARN("YoYo: unexpected buf alloc TLV length %u", len);
+		return -EBADMSG;
+	}
+
+	domain = get_unaligned_le32(&tlv->dbg_hdr.domain);
+	version = get_unaligned_le32(&tlv->dbg_hdr.tlv_data_version);
+	if (domain != BTINTEL_PCIE_DOMAIN_BT ||
+	    version != BTINTEL_PCIE_BUF_ALLOC_TLV_VERSION) {
+		BT_WARN("YoYo: unsupported buf allocation domain/version (%u/%u)",
+			domain, version);
+		return -EINVAL;
+	}
+
+	alloc_id = get_unaligned_le32(&tlv->alloc_id);
+	if (alloc_id < BTINTEL_PCIE_ALLOC_ID_DBGC1 ||
+	    alloc_id > BTINTEL_PCIE_ALLOC_ID_DBGC3) {
+		BT_WARN("YoYo: invalid buf allocation id %u", alloc_id);
+		return -EINVAL;
+	}
+
+	idx = alloc_id - BTINTEL_PCIE_ALLOC_ID_DBGC1;
+	buf_location = get_unaligned_le32(&tlv->buf_location);
+	max_num_frags = get_unaligned_le32(&tlv->max_num_frags);
+	min_buf_size = get_unaligned_le32(&tlv->min_buf_size);
+	req_buf_size = get_unaligned_le32(&tlv->req_buf_size);
+
+	if (buf_location != BTINTEL_PCIE_BUF_LOC_DRAM) {
+		BT_WARN("YoYo: buf allocation id=%u unsupported buffer location %u",
+			alloc_id, buf_location);
+		return -EINVAL;
+	}
+
+	if (!max_num_frags || max_num_frags > BTINTEL_PCIE_MAX_BUF_FRAGS ||
+	    min_buf_size < BTINTEL_PCIE_MIN_BUF_SIZE ||
+	    min_buf_size > BTINTEL_PCIE_MAX_BUF_SIZE ||
+	    req_buf_size > BTINTEL_PCIE_MAX_BUF_SIZE ||
+	    req_buf_size % max_num_frags ||
+	    req_buf_size / max_num_frags < min_buf_size) {
+		BT_WARN("YoYo: buf allocation id=%u req size=%u max frags=%u min size=%u",
+			alloc_id, req_buf_size, max_num_frags, min_buf_size);
+		return -EINVAL;
+	}
+
+	ctx->buf_alloc[idx].alloc_id = alloc_id;
+	ctx->buf_alloc[idx].buf_location = buf_location;
+	ctx->buf_alloc[idx].req_buf_size = req_buf_size;
+	ctx->buf_alloc[idx].max_num_frags = max_num_frags;
+	ctx->buf_alloc[idx].min_buf_size = min_buf_size;
+	ctx->buf_alloc[idx].present = true;
+
+	if (idx + 1 > ctx->num_buf_allocs)
+		ctx->num_buf_allocs = idx + 1;
+
+	BT_DBG("YoYo: buf allocation id=%u loc=%u req size=%u max frags=%u min size=%u",
+	       alloc_id, ctx->buf_alloc[idx].buf_location,
+	       ctx->buf_alloc[idx].req_buf_size,
+	       ctx->buf_alloc[idx].max_num_frags,
+	       ctx->buf_alloc[idx].min_buf_size);
+
+	return 0;
+}
+
 /*
  * Parse the optional YoYo firmware TLV stream and validate each record.
  * This is the entry point for the runtime debug configuration payload.
@@ -98,14 +168,16 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 							       (const void *)tlv, len);
 			if (ret) {
 				ctx->dbg_info_present = false;
-				return ret;
 			}
 			break;
+		case BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC:
+			ret = btintel_pcie_yoyo_parse_buf_alloc(ctx,
+								(const void *)tlv, len);
+			break;
 		case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET:
-		case BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC:
 		case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
 			BT_DBG("YoYo: valid tlv type 0x%x len=%u", type, len);
 			break;
@@ -116,6 +188,12 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 
 		ptr += tlv_size;
 		remaining -= tlv_size;
+
+		if (ret) {
+			BT_ERR("YoYo: error parsing tlv type 0x%x (ret=%d)", type, ret);
+			return ret;
+		}
+
 		count++;
 	}
 
@@ -124,6 +202,10 @@ static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_ctx *ctx,
 		BT_ERR("YoYo: trailing %zu bytes after tlv stream", remaining);
 		return -EBADMSG;
 	}
+	if (!ctx->num_buf_allocs) {
+		BT_ERR("YoYo: mandatory buffer allocation TLV missing");
+		return -EBADMSG;
+	}
 
 	BT_DBG("YoYo: parsed %u tlv's", count);
 	return 0;
@@ -162,6 +244,8 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
 
 	ctx->enabled = false;
 	ctx->dbg_info_present = false;
+	ctx->num_buf_allocs = 0;
+	memset(ctx->buf_alloc, 0, sizeof(ctx->buf_alloc));
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
 
@@ -218,5 +302,30 @@ int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_load_and_parse);
 
+/**
+ * btintel_pcie_yoyo_get_buf_alloc - Query buffer allocation config for a DBGC
+ * @ctx: YoYo context
+ * @alloc_id: Allocation ID (1=DBGC1, 2=DBGC2, 3=DBGC3)
+ *
+ * Return the parsed configuration, or NULL if no matching TLV was present.
+ */
+const struct btintel_pcie_buf_alloc *
+btintel_pcie_yoyo_get_buf_alloc(struct btintel_pcie_yoyo_ctx *ctx, u32 alloc_id)
+{
+	u32 idx;
+
+	if (!ctx || !ctx->enabled ||
+	    alloc_id < BTINTEL_PCIE_ALLOC_ID_DBGC1 ||
+	    alloc_id > BTINTEL_PCIE_ALLOC_ID_DBGC3)
+		return NULL;
+
+	idx = alloc_id - BTINTEL_PCIE_ALLOC_ID_DBGC1;
+	if (!ctx->buf_alloc[idx].present)
+		return NULL;
+
+	return &ctx->buf_alloc[idx];
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_get_buf_alloc);
+
 MODULE_DESCRIPTION("Intel Bluetooth yoyo debug framework");
 MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index 717e8838c4d5..5ed368fb13d1 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -28,10 +28,16 @@
 
 /* Supported TLV type versions */
 #define BTINTEL_PCIE_DBG_INFO_TLV_VERSION	2
+#define BTINTEL_PCIE_BUF_ALLOC_TLV_VERSION	1
 /* Debug Info TLV */
 #define BTINTEL_PCIE_CONFIG_NAME_LEN		64
 #define BTINTEL_PCIE_DOMAIN_BT			0
 #define BTINTEL_PCIE_CORE_TYPE_BT		1
+/* Buffer allocation TLV */
+#define BTINTEL_PCIE_MAX_BUF_ALLOC		3
+#define BTINTEL_PCIE_MAX_BUF_FRAGS		16
+#define BTINTEL_PCIE_MIN_BUF_SIZE		(32 * 1024)
+#define BTINTEL_PCIE_MAX_BUF_SIZE		(4 * 1024 * 1024)
 
 enum btintel_pcie_image_tlv_type {
 	BTINTEL_PCIE_IMAGE_TLV_TYPE_EXTERNAL	= 0x1,
@@ -39,6 +45,24 @@ enum btintel_pcie_image_tlv_type {
 	BTINTEL_PCIE_IMAGE_TLV_TYPE_UNKNOWN	= 0xff,
 };
 
+/* Allocation IDs */
+enum btintel_dbg_alloc_id {
+	BTINTEL_PCIE_ALLOC_ID_INVALID	= 0,
+	BTINTEL_PCIE_ALLOC_ID_DBGC1		= 1,
+	BTINTEL_PCIE_ALLOC_ID_DBGC2		= 2,
+	BTINTEL_PCIE_ALLOC_ID_DBGC3		= 3,
+	BTINTEL_PCIE_ALLOC_ID_MAX,
+};
+
+/* Buffer locations */
+enum btintel_dbg_buf_location {
+	BTINTEL_PCIE_BUF_LOC_INVALID		= 0,
+	BTINTEL_PCIE_BUF_LOC_SRAM		= 1,
+	BTINTEL_PCIE_BUF_LOC_DRAM		= 2,
+	BTINTEL_PCIE_BUF_LOC_NPK		= 3,
+	BTINTEL_PCIE_BUF_LOC_MAX,
+};
+
 /* TLV header */
 struct btintel_pcie_tlv_hdr {
 	__le32 type;
@@ -76,6 +100,38 @@ struct btintel_pcie_tlv_dbg_info {
 	u8 config_name[BTINTEL_PCIE_CONFIG_NAME_LEN];
 } __packed;
 
+/*
+ * struct btintel_pcie_tlv_buf_alloc - YoYo buffer allocation TLV
+ * @hdr: Common TLV header
+ * @dbg_hdr: Debug TLV version and domain
+ * @alloc_id: DBGC allocation identifier (DBGC1..DBGC3)
+ * @buf_location: Requested buffer location (SRAM / DRAM / NPK)
+ * @req_buf_size: Total requested allocation size in bytes
+ * @max_num_frags: Maximum number of buffer fragments (1..16)
+ * @min_buf_size: Minimum buffer size in bytes
+ *
+ * Describes the buffer sizing override for one DBGC allocation.
+ */
+struct btintel_pcie_tlv_buf_alloc {
+	struct btintel_pcie_tlv_hdr hdr;
+	struct btintel_pcie_dbg_hdr dbg_hdr;
+	__le32 alloc_id;
+	__le32 buf_location;
+	__le32 req_buf_size;
+	__le32 max_num_frags;
+	__le32 min_buf_size;
+} __packed;
+
+/* Parsed buffer allocation entry in the YoYo context */
+struct btintel_pcie_buf_alloc {
+	u32	alloc_id;
+	u32	buf_location;
+	u32	req_buf_size;
+	u32	max_num_frags;
+	u32	min_buf_size;
+	bool	present;
+};
+
 /*
  * struct btintel_pcie_yoyo_ctx- Runtime state for YoYo debug configuration
  * @enabled: Whether the loaded YoYo configuration passed validation
@@ -83,6 +139,8 @@ struct btintel_pcie_tlv_dbg_info {
  * @trigger_list: Parsed debug-trigger entries
  * @hcmd_list: Parsed HCI command entries
  * @config_set_list: Parsed configuration-set entries
+ * @buf_alloc: Parsed buffer allocation entries
+ * @num_buf_allocs: Number of parsed buffer allocation entries
  * @hdev: Associated HCI device; NULL until successful HCI registration
  *
  * Stores the validation state and parsed TLV data for the optional YoYo
@@ -95,6 +153,8 @@ struct btintel_pcie_yoyo_ctx {
 	struct list_head	 trigger_list;
 	struct list_head	 hcmd_list;
 	struct list_head	 config_set_list;
+	struct btintel_pcie_buf_alloc buf_alloc[BTINTEL_PCIE_MAX_BUF_ALLOC];
+	int			 num_buf_allocs;
 	struct hci_dev		 *hdev;
 };
 
@@ -105,4 +165,7 @@ void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx);
 int  btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
 				      struct device *dev);
 
+const struct btintel_pcie_buf_alloc *
+btintel_pcie_yoyo_get_buf_alloc(struct btintel_pcie_yoyo_ctx *ctx, u32 alloc_id);
+
 #endif /* __BTINTEL_PCIE_DEBUG_H__ */
-- 
2.53.0

