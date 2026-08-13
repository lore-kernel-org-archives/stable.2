Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E0279DB6
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602875; cv=none; b=GWpdz4h1/1xGpu+XkjGg6aAZfPUrDUnNnpivFVt8JcX/PZ/bC+b7iVOtsvW1jjLqMuJxAukVO7ZlpCEjYM6ZqNEXzfrrNKHVwvPK36qTcX1daogZ2XPIdnldP89VEpj/QmyluRmQESLaxI7vvLN4oVJMMvsWUW4J+D774xfMxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602875; c=relaxed/simple;
	bh=lQl87E1s6Upa7s8Q+G2KYRKPgEZq1WCMfhiN1Gntpj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1otmvWTo63QmmNcTZ75hZoVxVDGl8qhlAHEwEkhJRXd51WD8nZOdHcVv0004GqsDeYUppNngo8fReJ62rd5n4PWFU0nR9vPvK0p1MDG5ibn8v57I85HGXbc1hGez7vmpw7cX/ENX2hWZyxwuqdi6eb59vHj3IprPtr6hDQzzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0632ec6a96e111f1aa26b74ffac11d73-20260813
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fd3c8614-f519-4a77-b0d6-76025dacb9dc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:fd3c8614-f519-4a77-b0d6-76025dacb9dc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:e260268f0f2686f83a98a19cfcfe2e61,BulkI
	D:2608131434264LZW1PXM,BulkQuantity:0,Recheck:0,SF:16|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_USA
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0632ec6a96e111f1aa26b74ffac11d73-20260813
X-User: lihaojie@kylinos.cn
Received: from localhost.localdomain [(39.144.190.5)] by mailgw.kylinos.cn
	(envelope-from <lihaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 876626051; Thu, 13 Aug 2026 14:34:24 +0800
From: lihaojie <lihaojie@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	lihaojie <lihaojie@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/virt: fix integer overflow in size_kb shift
Date: Thu, 13 Aug 2026 14:34:18 +0800
Message-Id: <20260813063418.2064270-1-lihaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

size_kb is uint32_t. The expression "size_kb << 10" is computed in
32-bit arithmetic, which overflows when size_kb >= 0x400000 (4 GB in
KB). This leads to incorrect buffer sizes being passed to kzalloc(),
amdgpu_device_vram_access(), and amdgpu_ttm_init_vram_resv(),
potentially causing undersized allocations and subsequent heap
overflows.

Fix this by casting size_kb to u64 before the shift, matching the
existing correct pattern already used in the same file:

  u64 init_hdr_size = (u64)adev->virt.init_data_header.size_kb << 10;

The affected call sites are:
  - amdgpu_virt_read_exchange_data_from_mem(): dataexchange_size
  - amdgpu_virt_init_data_exchange(): kzalloc size argument
  - amdgpu_virt_init_critical_region(): amdgpu_ttm_init_vram_resv size
  - amdgpu_virt_get_dynamic_data_info(): data_size

Also update the corresponding dev_info/dev_dbg format strings from
0x%x to 0x%llx to match the new u64 type.

Fixes: 07009df6494d ("drm/amdgpu: Introduce SRIOV critical regions v2 during VF init")
Cc: stable@vger.kernel.org
Signed-off-by: lihaojie <lihaojie@kylinos.cn>
---

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9e8f7d2b898c..51287d2a6d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -752,12 +752,12 @@ static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, u
 {
 	uint32_t dataexchange_offset =
 		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
-	uint32_t dataexchange_size =
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
+	u64 dataexchange_size =
+		(u64)adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
 	uint64_t pos = 0;
 
 	dev_info(adev->dev,
-			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%llx bytes.\n",
 			dataexchange_offset, dataexchange_size);
 
 	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
@@ -804,7 +804,8 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
 		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
 			pfvf_data =
-				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
+				kzalloc((u64)adev->virt.crit_regn_tbl
+					[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
 					GFP_KERNEL);
 			if (!pfvf_data) {
 				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
@@ -1161,7 +1162,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	/* reserved memory starts from crit region base offset with the size of 5MB */
 	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
 				  adev->virt.crit_regn.offset,
-				  adev->virt.crit_regn.size_kb << 10, true);
+				  (u64)adev->virt.crit_regn.size_kb << 10, true);
 	dev_info(adev->dev,
 		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
 			init_data_hdr->version,
@@ -1181,14 +1182,14 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	int data_id, uint8_t *binary, u32 *size)
 {
 	uint32_t data_offset = 0;
-	uint32_t data_size = 0;
+	u64 data_size = 0;
 	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
 
 	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
 		return -EINVAL;
 
 	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
-	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
+	data_size = (u64)adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
 
 	/* Validate on input params */
 	if (!binary || !size || *size < (uint64_t)data_size)
@@ -1200,7 +1201,7 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	*size = (uint64_t)data_size;
 
 	dev_dbg(adev->dev,
-		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%llx bytes.\n",
 		amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
 
 	return 0;
