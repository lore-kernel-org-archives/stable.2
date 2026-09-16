Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39264C33D6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584976; cv=none; b=p+Yn1rc937sCkkA3mC6GkuOCnZAEzu0g/GTshXBjQQhq1qVTuzOpoKSwH4AupHebnTgX8qXEWk3aAdBbeOOPtEYy6nKWgfqkOB3iB0xfarG0FKFoTbTQi5IefadnhxxjrEetJlsJnPpekg1E4wCkcIWCbsGagUP7iByzLHHFkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584976; c=relaxed/simple;
	bh=2V4aJIHH1qzuL2ecIZcWBsrOkoDBoMTAbrS9VLBPMPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt+2KhRwwMS9b/skVLWCbGRHJ/A7AJ4RFslR1Caz5RlSQHyJM4u8x//EBmmKL192kDOj/HdeFXmJlYIGtrmSON5YycHQHhIt8fXXoc1JRCDIyLughpwjZOX0+zBR0veHj/HsiVbuFiWeNmUsBD/kadgs7MDSVcNvqM/RwDbnh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D73bNlVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D73bNlVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393B51F0089D;
	Wed, 16 Sep 2026 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584946;
	bh=gG8DnxpykCPGk+wj544Vmdx2ZHVUXMITri3q8xdP3bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D73bNlVuwt+2OcNFa3rAMH3BxoxkJNTa5NccIDOnatMqkLQQ7rDeGhz0gJlF3czns
	 tgx21GiGPrELbg4Jixt5g7aNqGjKI9E43qlZorMiif/py0qKTzBUYEqC9XTU8p1qmd
	 cMxA+9kc+Hmlmb866SmLDZCAz87flg/bDzeTNSOcWs7ox9i/gvA3ffTa7+k8TqiBey
	 OenOZElvKZAxusIBV20wREIS1IifwvXMzeWCy66DvKQVpXMsz4NEOMuzao92vCKCsT
	 228zQ017lCcaWC/JdCuSCafU1ioHVaaOtX0WvPJ1UnUpwrqXW6wNIi2fNQ5f+lFS/b
	 oC4bmhk3qSxFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Magdalena Schulfer <magdalena.schulfer@intel.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] accel/ivpu: Validate firmware log buffer metadata
Date: Wed, 16 Sep 2026 14:55:41 -0400
Message-ID: <20260916185541.1885084-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916185541.1885084-1-sashal@kernel.org>
References: <2026091601-reply-pointy-7e61@gregkh>
 <20260916185541.1885084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magdalena Schulfer <magdalena.schulfer@intel.com>

[ Upstream commit 0724afc55c77c36c7feb9a7264b02aa7593c5c2d ]

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
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260901125749.404338-3-dawid.osuchowski@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 76 +++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 365f2d782cdde..86001beb91cc9 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -30,10 +30,17 @@ MODULE_PARM_DESC(ivpu_log_level,
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
@@ -43,26 +50,32 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
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
@@ -98,11 +111,12 @@ static void fw_log_print_lines(char *buffer, u32 size, struct drm_printer *p)
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
 
@@ -138,45 +152,45 @@ void
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
2.53.0

