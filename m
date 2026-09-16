Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE430521225
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572453; cv=none; b=YMRSrvSgiMDx+iMekiloE4t2waH9+bp781ak0KEgLirEmAiSqpFzNruCX4GRNsd/EGaepxmP2fZYDSgQvdDL0Dhxah+fWqpKKUlhHVyjXVP+nQd8RaBRdq1vzBcmpLdD4EPIBOo12zZw9zrENNC185lSFIia5lgPyOTomLGjrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572453; c=relaxed/simple;
	bh=XBo2H/6E1I6WOvpXeFR8FrkZPFozoF0nncXLuhmvVfs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KLZWTb6IEdw14TmWo+UgmJn+DajstMU6gSWXhpxI77rpvEixRqGHf+pl/OlbH+MG6Il1ja2MjQDoHG2WO4ArAmheGVZNoXmWE9MLR7b12ykIobwCarN0OWYj0JK7uyqR2es1gdEwx9FEXi3f2evq79dnY7XDDj5m7jPrs5nSbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jNEMcQG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jNEMcQG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BF81F00898;
	Wed, 16 Sep 2026 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572447;
	bh=VgISR9mAahbItXfIS7fUFY12nzyZo1PkDAVvHjr6XYk=;
	h=Subject:To:Cc:From:Date;
	b=jNEMcQG9qp28VQ5SCIdEmM19oYiCW2uEoDZkhCF9m1F2bQwyV6/46hDCLykDpo/KH
	 /2nH1+AQnEDi7D8HUOFfgzSfGZA7hN0DNDKjVBP7Sjfv/axeLqdJXJgkISAq0WNFL+
	 Nsvvoxzr0WT53chJtkGp05K4pL5VL+8GUlHVxNs4=
Subject: FAILED: patch "[PATCH] accel/ivpu: Validate firmware log buffer metadata" failed to apply to 6.6-stable tree
To: magdalena.schulfer@intel.com,dawid.osuchowski@linux.intel.com,karol.wachowski@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:13:01 +0100
Message-ID: <2026091601-reply-pointy-7e61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0724afc55c77c36c7feb9a7264b02aa7593c5c2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091601-reply-pointy-7e61@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0724afc55c77c36c7feb9a7264b02aa7593c5c2d Mon Sep 17 00:00:00 2001
From: Magdalena Schulfer <magdalena.schulfer@intel.com>
Date: Tue, 1 Sep 2026 14:57:48 +0200
Subject: [PATCH] accel/ivpu: Validate firmware log buffer metadata

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

