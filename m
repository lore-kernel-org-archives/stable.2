Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD14E50A8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584964; cv=none; b=CJ2eDvb+jEv1oM7ihw8a5IOMyaRnjYrw+VfVIlzb4eJV1Bsxbp3T36utfEtBWaNGBOzeLDvY+33Vr+I8RoiKbS4A8ngkc7GUBuQ5SHcVZG9ruGaMaoH1Ow5vSqFdeRle3f6Y5JtAdNc3GyBGI/VpL8Q7xKETuEH9rZVGViveAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584964; c=relaxed/simple;
	bh=M8JxbOul724N1r48NnhrXV+cPpnnHplXfs6gF60ReLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXZXFRdsxJpNnqIsxUmIq/e7uDAKQQSQbRDsBSUThXbItsOBXuovwbqvFKiCizOwFrlbW4aXsWoBWEhER+i+zWDRN4YWvoSd6/RELtsZthkGKZTnDRfkmKSiPzWsvbLPDBEy2FUCJA0bQVX/t8cBPgJMQUmM8ovvtKWuh19ci54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrJe+1m6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrJe+1m6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AEB1F0089A;
	Wed, 16 Sep 2026 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584946;
	bh=g4kxCQPtUsniyDAp1Q2rh1ah14Tcf6fOc1T258SXO+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TrJe+1m6/1rg1DMdVtEKMFw/7N7OFYTzpQzKcF3v6V+Of5/RUD/sDHiqdD9h6xA+p
	 RE1Jb3aq8O358SnH6/7l7mVty+WKaBZdFQ7uLLf9AkRUOD4gei3iIHkiVIPj3d7p3K
	 aYvCB3OkJDh6NugNnIiJPQC1nfQgo9AbRuYbWlTNfhvDV87XvatufjohPqhqhJ1Tzp
	 8c+w2fQIcnYN4QsXtlpUvbXEFgwy3Bio8Xosq1Km44sD+HDtnLPOa289woTJNvHptN
	 V+QmPhboJkVzwvsOrCokXog9OL4TP3aFVi3ipuJ4d+i5grWU8JgcSj+p9cnPpkh7EH
	 xiuR2jMppYZdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] accel/ivpu: Refactor functions in ivpu_fw_log.c
Date: Wed, 16 Sep 2026 14:55:40 -0400
Message-ID: <20260916185541.1885084-4-sashal@kernel.org>
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

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

[ Upstream commit 1fc1251149a76d3b75d7f4c94d9c4e081b7df6b4 ]

Make function names more consistent and (arguably) readable in
fw log code. Add fw_log_print_all_in_bo() that remove duplicated code in
ivpu_fw_log_print().

Reviewed-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-5-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Backport to 6.6: keep the VPU log labels and the existing module parameter.
Convert the existing ivpu_fw_log_print() into fw_log_print_all_in_bo()
and move its two BO calls into the existing debugfs and dump callers.
This preserves the number of functions; no helper or accessor functions
are added. Rename the existing parser, line printer and mark-read entry
point consistently with upstream.

Carry the log-printing prerequisites from 4bc988b470195 and the index
bounds checks from dd1311bcf0e62 so 0724afc55c77 can be cherry-picked
without conflicts. The tracing header already has read_wrap_count from
an earlier dependency, and the log-size/header-size check is already
present. Keep both checks and reset/update the reader wrap count.

Map the upstream BO accessor names to this branch's existing fields
with local macros, avoiding the unrelated GEM conversion and additional
functions. The target can then snapshot validated metadata and pass it
to every log consumer without re-reading the shared size fields.

Include ivpu_fw_log.h in ivpu_pm.c: the preceding cold-boot dependency
added an ivpu_fw_log_reset() call without its declaration in this tree.

Stable-dep-of: 0724afc55c77 ("accel/ivpu: Validate firmware log buffer metadata")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_debugfs.c |   5 +-
 drivers/accel/ivpu/ivpu_fw_log.c  | 110 ++++++++++++++++++------------
 drivers/accel/ivpu/ivpu_fw_log.h  |   9 ++-
 drivers/accel/ivpu/ivpu_pm.c      |   1 +
 4 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 5e5996fd4f9f1..502a0a6468b5e 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -119,7 +119,8 @@ static int fw_log_show(struct seq_file *s, void *v)
 	struct ivpu_device *vdev = s->private;
 	struct drm_printer p = drm_seq_file_printer(s);
 
-	ivpu_fw_log_print(vdev, true, &p);
+	fw_log_print_all_in_bo(vdev, "VPU critical", vdev->fw->mem_log_crit, true, &p);
+	fw_log_print_all_in_bo(vdev, "VPU verbose", vdev->fw->mem_log_verb, true, &p);
 	return 0;
 }
 
@@ -137,7 +138,7 @@ fw_log_fops_write(struct file *file, const char __user *user_buf, size_t size, l
 	if (!size)
 		return -EINVAL;
 
-	ivpu_fw_log_clear(vdev);
+	ivpu_fw_log_mark_read(vdev);
 	return size;
 }
 
diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 0ed29e5ac8e52..365f2d782cdde 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -17,6 +17,10 @@
 
 #define IVPU_FW_LOG_LINE_LENGTH	  256
 
+/* Accessors for the BO layout used by this stable branch. */
+#define ivpu_bo_size(bo) ((bo)->base.size)
+#define ivpu_bo_vaddr(bo) ((bo)->kvaddr)
+
 unsigned int ivpu_log_level = IVPU_FW_LOG_ERROR;
 module_param(ivpu_log_level, uint, 0444);
 MODULE_PARM_DESC(ivpu_log_level,
@@ -26,15 +30,15 @@ MODULE_PARM_DESC(ivpu_log_level,
 		 " error=" __stringify(IVPU_FW_LOG_ERROR)
 		 " fatal=" __stringify(IVPU_FW_LOG_FATAL));
 
-static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
-		      struct vpu_tracing_buffer_header **log_header)
+static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
+			  struct vpu_tracing_buffer_header **out_log)
 {
 	struct vpu_tracing_buffer_header *log;
 
-	if ((*offset + sizeof(*log)) > bo->base.size)
+	if ((*offset + sizeof(*log)) > ivpu_bo_size(bo))
 		return -EINVAL;
 
-	log = bo->kvaddr + *offset;
+	log = ivpu_bo_vaddr(bo) + *offset;
 
 	if (log->vpu_canary_start != VPU_TRACING_BUFFER_CANARY)
 		return -EINVAL;
@@ -47,12 +51,12 @@ static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
 		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
 		return -EINVAL;
 	}
-	if ((char *)log + log->size > (char *)bo->kvaddr + bo->base.size) {
+	if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(bo)) {
 		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
 		return -EINVAL;
 	}
 
-	*log_header = log;
+	*out_log = log;
 	*offset += log->size;
 
 	ivpu_dbg(vdev, FW_BOOT,
@@ -63,7 +67,7 @@ static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
 	return 0;
 }
 
-static void buffer_print(char *buffer, u32 size, struct drm_printer *p)
+static void fw_log_print_lines(char *buffer, u32 size, struct drm_printer *p)
 {
 	char line[IVPU_FW_LOG_LINE_LENGTH];
 	u32 index = 0;
@@ -91,70 +95,88 @@ static void buffer_print(char *buffer, u32 size, struct drm_printer *p)
 	}
 	line[index] = 0;
 	if (index != 0)
-		drm_printf(p, "%s\n", line);
+		drm_printf(p, "%s", line);
 }
 
-static void fw_log_print_buffer(struct ivpu_device *vdev, struct vpu_tracing_buffer_header *log,
-				const char *prefix, bool only_new_msgs, struct drm_printer *p)
+static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const char *prefix,
+				bool only_new_msgs, struct drm_printer *p)
 {
-	char *log_buffer = (void *)log + log->header_size;
-	u32 log_size = log->size - log->header_size;
-	u32 log_start = log->read_index;
-	u32 log_end = log->write_index;
-
-	if (!(log->write_index || log->wrap_count) ||
-	    (log->write_index == log->read_index && only_new_msgs)) {
-		drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
-		return;
+	char *log_data = (void *)log + log->header_size;
+	u32 data_size = log->size - log->header_size;
+	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
+	u32 log_end = READ_ONCE(log->write_index);
+
+	if (log_start >= data_size)
+		log_start = 0;
+	if (log_end > data_size)
+		log_end = data_size;
+
+	if (log->wrap_count == log->read_wrap_count) {
+		if (log_end <= log_start) {
+			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
+			return;
+		}
+	} else if (log->wrap_count == log->read_wrap_count + 1) {
+		if (log_end > log_start)
+			log_start = log_end;
+	} else {
+		log_start = log_end;
 	}
 
 	drm_printf(p, "==== %s \"%s\" log start ====\n", prefix, log->name);
-	if (log->write_index > log->read_index) {
-		buffer_print(log_buffer + log_start, log_end - log_start, p);
+	if (log_end > log_start) {
+		fw_log_print_lines(log_data + log_start, log_end - log_start, p);
 	} else {
-		buffer_print(log_buffer + log_end, log_size - log_end, p);
-		buffer_print(log_buffer, log_end, p);
+		fw_log_print_lines(log_data + log_start, data_size - log_start, p);
+		fw_log_print_lines(log_data, log_end, p);
 	}
-	drm_printf(p, "\x1b[0m");
+	drm_printf(p, "\n\x1b[0m"); /* add new line and clear formatting */
 	drm_printf(p, "==== %s \"%s\" log end   ====\n", prefix, log->name);
 }
 
-void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p)
+void
+fw_log_print_all_in_bo(struct ivpu_device *vdev, const char *name,
+		       struct ivpu_bo *bo, bool only_new_msgs, struct drm_printer *p)
 {
-	struct vpu_tracing_buffer_header *log_header;
+	struct vpu_tracing_buffer_header *log;
 	u32 next = 0;
 
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		fw_log_print_buffer(vdev, log_header, "VPU critical", only_new_msgs, p);
-
-	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		fw_log_print_buffer(vdev, log_header, "VPU verbose", only_new_msgs, p);
+	while (fw_log_from_bo(vdev, bo, &next, &log) == 0)
+		fw_log_print_buffer(log, name, only_new_msgs, p);
 }
 
-void ivpu_fw_log_clear(struct ivpu_device *vdev)
+void ivpu_fw_log_mark_read(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log_header;
-	u32 next = 0;
+	struct vpu_tracing_buffer_header *log;
+	u32 next;
 
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		log_header->read_index = log_header->write_index;
+	next = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &log) == 0) {
+		log->read_index = READ_ONCE(log->write_index);
+		log->read_wrap_count = READ_ONCE(log->wrap_count);
+	}
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		log_header->read_index = log_header->write_index;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &log) == 0) {
+		log->read_index = READ_ONCE(log->write_index);
+		log->read_wrap_count = READ_ONCE(log->wrap_count);
+	}
 }
 
 void ivpu_fw_log_reset(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log_header;
+	struct vpu_tracing_buffer_header *log;
 	u32 next;
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		log_header->read_index = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &log) == 0) {
+		log->read_index = 0;
+		log->read_wrap_count = 0;
+	}
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		log_header->read_index = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &log) == 0) {
+		log->read_index = 0;
+		log->read_wrap_count = 0;
+	}
 }
diff --git a/drivers/accel/ivpu/ivpu_fw_log.h b/drivers/accel/ivpu/ivpu_fw_log.h
index 692ee0f266a31..da17fab5ad3d8 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.h
+++ b/drivers/accel/ivpu/ivpu_fw_log.h
@@ -11,6 +11,7 @@
 #include <drm/drm_print.h>
 
 #include "ivpu_drv.h"
+#include "ivpu_fw.h"
 
 #define IVPU_FW_LOG_DEFAULT 0
 #define IVPU_FW_LOG_DEBUG   1
@@ -25,15 +26,17 @@ extern unsigned int ivpu_log_level;
 #define IVPU_FW_VERBOSE_BUFFER_LARGE_SIZE	SZ_8M
 #define IVPU_FW_CRITICAL_BUFFER_SIZE		SZ_512K
 
-void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p);
-void ivpu_fw_log_clear(struct ivpu_device *vdev);
+void fw_log_print_all_in_bo(struct ivpu_device *vdev, const char *name,
+			    struct ivpu_bo *bo, bool only_new_msgs, struct drm_printer *p);
+void ivpu_fw_log_mark_read(struct ivpu_device *vdev);
 void ivpu_fw_log_reset(struct ivpu_device *vdev);
 
 static inline void ivpu_fw_log_dump(struct ivpu_device *vdev)
 {
 	struct drm_printer p = drm_info_printer(vdev->drm.dev);
 
-	ivpu_fw_log_print(vdev, false, &p);
+	fw_log_print_all_in_bo(vdev, "VPU critical", vdev->fw->mem_log_crit, false, &p);
+	fw_log_print_all_in_bo(vdev, "VPU verbose", vdev->fw->mem_log_verb, false, &p);
 }
 
 #endif /* __IVPU_FW_LOG_H__ */
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index e17e4e6b037ee..3a59242b6a423 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -13,6 +13,7 @@
 #include "ivpu_drv.h"
 #include "ivpu_hw.h"
 #include "ivpu_fw.h"
+#include "ivpu_fw_log.h"
 #include "ivpu_ipc.h"
 #include "ivpu_job.h"
 #include "ivpu_mmu.h"
-- 
2.53.0

