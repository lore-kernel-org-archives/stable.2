Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE9429022
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826583; cv=none; b=iYoYBXRfXjjFTBHIrDxUBvW5ryvLgg2tFSn/qMlwXbnOAi0o0KjSMc07SeQcNqo4TTT+Hz+WXmhKkzCcxJfmmrwRZ5mleLxcJB5SFmUX47fnHJkmdCSuze8yfeqPbmuXc6zLEHADoy6mtAbBXS+DZEMoYA6EMp8WRXkanLU3obE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826583; c=relaxed/simple;
	bh=WTeSaKkx6c5J8iEmuDSbplgMP3mpr/maEgb4TBLsY48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH8nVjv4WgQO2oVtfDahAKn/IL/HCN8S/dH3fi9hwBrSAu5C9gDIMTQ4cAPQUqAEHHMy0daJusSyEfTBuz/53H7YnHEVBfzsmATc/Bsqt6GKARJD6mfv1IAXfMZjt4n+Wj2joD8Uvl9xKGf5F1piqyKPeTHGsdwMeshYQl2FQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7gjTPPZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7gjTPPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787826579; x=1819362579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTeSaKkx6c5J8iEmuDSbplgMP3mpr/maEgb4TBLsY48=;
  b=S7gjTPPZzdIM8Ii6tn7WrZ8RkpO9tJBbyNRVC/PRvD8z8y0NiYJtVBuX
   9M537MFETufxW43y7L91pM2bZ/MPXmvmiHHEfYXTieYJnqCBSir+2Xrfl
   C7UCB9smNYFEH3ARbOtB2l1EqtEjCpeWyOQwRkHaI/yhPEQ+EWlI92NVS
   sh8mBmOvw1XYyIql2q9vJ8qdJXMolzM7+z2+6e+CrdtlzkB05SylTmqlh
   ByTupqKoNtLtClfe+sVr5TA/FiIv9TUstdOO1LhxeE/SqfcEzH0AczYrB
   7r8oBegYYhH/TbUqd1VwhD0GKubmZlBUSkW61dL5ZAj5Ej3+l6FXnYeLd
   g==;
X-CSE-ConnectionGUID: pjXQzHG/TlGhuR0JTNR5fQ==
X-CSE-MsgGUID: ALYn79UhRLqpRXowd4dYsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98920699"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="98920699"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:29:39 -0700
X-CSE-ConnectionGUID: nWyXoqc7S7yqE6fv+y7N8Q==
X-CSE-MsgGUID: F7NcmyI/Sx6u2hjlhPFTzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="261711649"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:29:37 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	karol.wachowski@linux.intel.com,
	lizhi.hou@amd.com,
	andrzej.kacprowski@linux.intel.com,
	Magdalena Schulfer <magdalena.schulfer@intel.com>,
	stable@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 2/2] accel/ivpu: Validate firmware log buffer metadata
Date: Thu, 27 Aug 2026 12:23:39 +0200
Message-ID: <20260827102339.281799-3-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
References: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
Content-Transfer-Encoding: 8bit

From: Magdalena Schulfer <magdalena.schulfer@intel.com>

The tracing log headers parsed by fw_log_print_buffer() reside in
DMA-shared BOs that the NPU firmware can write to.

fw_log_from_bo() validated log->header_size and log->size, but
fw_log_print_buffer() re-read those same fields from shared memory
afterwards, allowing a TOCTOU where firmware changes them between the
check and the use, and making the host dereference out-of-bounds
addresses while printing logs.

Snapshot the validated values once with READ_ONCE() and pass them down
explicitly in a new struct ivpu_fw_log_desc instead of re-reading them
from the shared struct.

Cc: stable@vger.kernel.org
Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
Signed-off-by: Magdalena Schulfer <magdalena.schulfer@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 76 +++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 716467aa3156..4f9055aa9d33 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -26,10 +26,17 @@ MODULE_PARM_DESC(fw_log_level,
 		 " error=" __stringify(IVPU_FW_LOG_ERROR)
 		 " fatal=" __stringify(IVPU_FW_LOG_FATAL));
 
+struct ivpu_fw_log_desc {
+	struct vpu_tracing_buffer_header *log;
+	u32 header_size;
+	u32 size;
+};
+
 static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
-			  struct vpu_tracing_buffer_header **out_log)
+			  struct ivpu_fw_log_desc *desc)
 {
 	struct vpu_tracing_buffer_header *log;
+	u32 header_size, size;
 
 	if ((*offset + sizeof(*log)) > ivpu_bo_size(bo))
 		return -EINVAL;
@@ -39,26 +46,32 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
 	if (log->vpu_canary_start != VPU_TRACING_BUFFER_CANARY)
 		return -EINVAL;
 
-	if (log->header_size < sizeof(*log) || log->header_size > 1024) {
-		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log->header_size);
+	header_size = READ_ONCE(log->header_size);
+	size = READ_ONCE(log->size);
+
+	if (header_size < sizeof(*log) || header_size > 1024) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", header_size);
 		return -EINVAL;
 	}
-	if (log->size < log->header_size) {
-		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
+	if ((char *)log + size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(bo)) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", size);
 		return -EINVAL;
 	}
-	if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(bo)) {
-		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
+	if (size < header_size) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x < header size 0x%x\n",
+			 size, header_size);
 		return -EINVAL;
 	}
 
-	*out_log = log;
-	*offset += log->size;
+	desc->log = log;
+	desc->header_size = header_size;
+	desc->size = size;
+	*offset += size;
 
 	ivpu_dbg(vdev, FW_BOOT,
 		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
-		 log->name, log->write_index, log->size, log->wrap_count, log->header_version,
-		 log->header_size, log->format, log->alignment);
+		 log->name, log->write_index, size, log->wrap_count, log->header_version,
+		 header_size, log->format, log->alignment);
 
 	return 0;
 }
@@ -94,11 +107,12 @@ static void fw_log_print_lines(char *buffer, u32 size, struct drm_printer *p)
 		drm_printf(p, "%s", line);
 }
 
-static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const char *prefix,
+static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefix,
 				bool only_new_msgs, struct drm_printer *p)
 {
-	char *log_data = (void *)log + log->header_size;
-	u32 data_size = log->size - log->header_size;
+	struct vpu_tracing_buffer_header *log = desc->log;
+	char *log_data = (void *)log + desc->header_size;
+	u32 data_size = desc->size - desc->header_size;
 	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
 	u32 log_end = READ_ONCE(log->write_index);
 
@@ -134,11 +148,11 @@ static void
 fw_log_print_all_in_bo(struct ivpu_device *vdev, const char *name,
 		       struct ivpu_bo *bo, bool only_new_msgs, struct drm_printer *p)
 {
-	struct vpu_tracing_buffer_header *log;
+	struct ivpu_fw_log_desc desc;
 	u32 next = 0;
 
-	while (fw_log_from_bo(vdev, bo, &next, &log) == 0)
-		fw_log_print_buffer(log, name, only_new_msgs, p);
+	while (fw_log_from_bo(vdev, bo, &next, &desc) == 0)
+		fw_log_print_buffer(&desc, name, only_new_msgs, p);
 }
 
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p)
@@ -149,36 +163,36 @@ void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_
 
 void ivpu_fw_log_mark_read(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log;
+	struct ivpu_fw_log_desc desc;
 	u32 next;
 
 	next = 0;
-	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &log) == 0) {
-		log->read_index = READ_ONCE(log->write_index);
-		log->read_wrap_count = READ_ONCE(log->wrap_count);
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &desc) == 0) {
+		desc.log->read_index = READ_ONCE(desc.log->write_index);
+		desc.log->read_wrap_count = READ_ONCE(desc.log->wrap_count);
 	}
 
 	next = 0;
-	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &log) == 0) {
-		log->read_index = READ_ONCE(log->write_index);
-		log->read_wrap_count = READ_ONCE(log->wrap_count);
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &desc) == 0) {
+		desc.log->read_index = READ_ONCE(desc.log->write_index);
+		desc.log->read_wrap_count = READ_ONCE(desc.log->wrap_count);
 	}
 }
 
 void ivpu_fw_log_reset(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log;
+	struct ivpu_fw_log_desc desc;
 	u32 next;
 
 	next = 0;
-	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &log) == 0) {
-		log->read_index = 0;
-		log->read_wrap_count = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &desc) == 0) {
+		desc.log->read_index = 0;
+		desc.log->read_wrap_count = 0;
 	}
 
 	next = 0;
-	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &log) == 0) {
-		log->read_index = 0;
-		log->read_wrap_count = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &desc) == 0) {
+		desc.log->read_index = 0;
+		desc.log->read_wrap_count = 0;
 	}
 }
-- 
2.43.0

