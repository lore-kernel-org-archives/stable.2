Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AE3563F6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588852; cv=none; b=K6Vy/rSeZHZNmibl1v0XRyK7eLctDGleNnBeC9VDqLymZlh4OO02Wl8+HIYBTDKhWjkq7ifbdf9PSNjtislZB4cVm4SVsZnmFGnl4b0ey5J351E7DSZN7va44xfXifL2oF4w9WA7GUKiNuW0fx4EQBNLdtmwQldoLpZaZwzj3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588852; c=relaxed/simple;
	bh=soUSA0hHZ+RSqP+1NOLGduxa8KBIXkafeGKvVaMtbQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn52NwgNW2WPqM8usMVAhQZ5/4w0RaSNIaKwMar3ZrWAWaRtfR+xxn9Sb7c5nqTsmtZsfSuMErD/3VP16FBzU9yOj0MAIuOzAeO1XQXlmtbPKvuUUp+4uVFMQa5tNmqJ0DEcf01yt8k3qxiv5rkVNq4840l5lApdBqzFl+aoEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdGXEcJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdGXEcJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0531F0089B;
	Wed, 16 Sep 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588841;
	bh=y7B3wodt/k7ZPdTsGQxuUtx//QPZMeWzw0SV0v/H6O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bdGXEcJJsnx03kQLRt6OitWD7Jb6qepMZWLl0ljNUIxOuOUAtcoNTDmX4vZivjV1U
	 FeVARj/hUn8sgT9IxM+0T+UpqxX56J2SAm7gld8Wr2cKEPgs9zMGyMGZiEHErolGgy
	 nDWBGGKMPaPDWPamKMpPEO5fSwrOSHdSHTf0ampeRhT7fz7vmrXsxNR3eBA55WgmF3
	 pdFt9Ibm4XWpnWhsTCwVkmwRJtAQmd+CuTx3WHGunL+alcNe7J4bMqTyxjHnW1T4dq
	 HwArzTKRaVGqBTnftfPGuM8zQ606AlFfoY3ybtJPkMGBVcPlvMJSzUdIqNDEkQ6NDb
	 6zD9BrcHGndPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] accel/ivpu: Refactor functions in ivpu_fw_log.c
Date: Wed, 16 Sep 2026 16:00:37 -0400
Message-ID: <20260916200038.2459399-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916200038.2459399-1-sashal@kernel.org>
References: <2026091615-moisten-showy-63d8@gregkh>
 <20260916200038.2459399-1-sashal@kernel.org>
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

[Stable dependency adaptation for 95bf070f3225]

Keep the existing critical/verbose loops and VPU labels instead of adding
fw_log_print_all_in_bo(); this adaptation adds no functions. Retain the
stable buffer-object accessors and module parameter interface.

Prepare the exact log-printing code used by the target with the relevant
changes from 4bc988b470195 (wrap handling and newline placement),
dd1311bcf0e62 (index bounds), and 0724afc55c77c (validated metadata
snapshots). The size-smaller-than-header check already exists in this
stable tree. Add only read_wrap_count from the newer tracing header,
using one reserved host-side word, and update the existing mark-read and
cold-boot reset paths. These changes let the unmodified target apply
cleanly without importing broader firmware API or buffer-object changes.

The original upstream helper extraction described above is intentionally
omitted from this stable dependency.

Also include ivpu_fw_log.h in ivpu_pm.c: the preceding cold-boot-reset
dependency calls ivpu_fw_log_reset() without its declaration on this tree.
The missing include is required for the x86 allmodconfig build.

Stable-dep-of: 95bf070f3225 ("accel/ivpu: Limit firmware log name prints to field size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_debugfs.c |   2 +-
 drivers/accel/ivpu/ivpu_fw_log.c  | 128 +++++++++++++++++++-----------
 drivers/accel/ivpu/ivpu_fw_log.h  |   2 +-
 drivers/accel/ivpu/ivpu_pm.c      |   1 +
 drivers/accel/ivpu/vpu_boot_api.h |   4 +-
 5 files changed, 87 insertions(+), 50 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 5e5996fd4f9f1..6c64ecdf15ff1 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -137,7 +137,7 @@ fw_log_fops_write(struct file *file, const char __user *user_buf, size_t size, l
 	if (!size)
 		return -EINVAL;
 
-	ivpu_fw_log_clear(vdev);
+	ivpu_fw_log_mark_read(vdev);
 	return size;
 }
 
diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 0ed29e5ac8e52..b1919c0749640 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -26,10 +26,17 @@ MODULE_PARM_DESC(ivpu_log_level,
 		 " error=" __stringify(IVPU_FW_LOG_ERROR)
 		 " fatal=" __stringify(IVPU_FW_LOG_FATAL));
 
-static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
-		      struct vpu_tracing_buffer_header **log_header)
+struct ivpu_fw_log_desc {
+	struct vpu_tracing_buffer_header *log;
+	u32 header_size;
+	u32 size;
+};
+
+static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
+			  struct ivpu_fw_log_desc *desc)
 {
 	struct vpu_tracing_buffer_header *log;
+	u32 header_size, size;
 
 	if ((*offset + sizeof(*log)) > bo->base.size)
 		return -EINVAL;
@@ -39,31 +46,37 @@ static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
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
+	if ((char *)log + size > (char *)bo->kvaddr + bo->base.size) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", size);
 		return -EINVAL;
 	}
-	if ((char *)log + log->size > (char *)bo->kvaddr + bo->base.size) {
-		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
+	if (size < header_size) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x < header size 0x%x\n",
+			 size, header_size);
 		return -EINVAL;
 	}
 
-	*log_header = log;
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
 
-static void buffer_print(char *buffer, u32 size, struct drm_printer *p)
+static void fw_log_print_lines(char *buffer, u32 size, struct drm_printer *p)
 {
 	char line[IVPU_FW_LOG_LINE_LENGTH];
 	u32 index = 0;
@@ -91,70 +104,91 @@ static void buffer_print(char *buffer, u32 size, struct drm_printer *p)
 	}
 	line[index] = 0;
 	if (index != 0)
-		drm_printf(p, "%s\n", line);
+		drm_printf(p, "%s", line);
 }
 
-static void fw_log_print_buffer(struct ivpu_device *vdev, struct vpu_tracing_buffer_header *log,
-				const char *prefix, bool only_new_msgs, struct drm_printer *p)
+static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefix,
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
+	struct vpu_tracing_buffer_header *log = desc->log;
+	char *log_data = (void *)log + desc->header_size;
+	u32 data_size = desc->size - desc->header_size;
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
 
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p)
 {
-	struct vpu_tracing_buffer_header *log_header;
+	struct ivpu_fw_log_desc desc;
 	u32 next = 0;
 
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		fw_log_print_buffer(vdev, log_header, "VPU critical", only_new_msgs, p);
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &desc) == 0)
+		fw_log_print_buffer(&desc, "VPU critical", only_new_msgs, p);
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		fw_log_print_buffer(vdev, log_header, "VPU verbose", only_new_msgs, p);
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &desc) == 0)
+		fw_log_print_buffer(&desc, "VPU verbose", only_new_msgs, p);
 }
 
-void ivpu_fw_log_clear(struct ivpu_device *vdev)
+void ivpu_fw_log_mark_read(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log_header;
-	u32 next = 0;
+	struct ivpu_fw_log_desc desc;
+	u32 next;
 
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		log_header->read_index = log_header->write_index;
+	next = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &desc) == 0) {
+		desc.log->read_index = READ_ONCE(desc.log->write_index);
+		desc.log->read_wrap_count = READ_ONCE(desc.log->wrap_count);
+	}
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		log_header->read_index = log_header->write_index;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &desc) == 0) {
+		desc.log->read_index = READ_ONCE(desc.log->write_index);
+		desc.log->read_wrap_count = READ_ONCE(desc.log->wrap_count);
+	}
 }
 
 void ivpu_fw_log_reset(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log_header;
+	struct ivpu_fw_log_desc desc;
 	u32 next;
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		log_header->read_index = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &desc) == 0) {
+		desc.log->read_index = 0;
+		desc.log->read_wrap_count = 0;
+	}
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		log_header->read_index = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &desc) == 0) {
+		desc.log->read_index = 0;
+		desc.log->read_wrap_count = 0;
+	}
 }
diff --git a/drivers/accel/ivpu/ivpu_fw_log.h b/drivers/accel/ivpu/ivpu_fw_log.h
index 692ee0f266a31..3bde9aa549035 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.h
+++ b/drivers/accel/ivpu/ivpu_fw_log.h
@@ -26,7 +26,7 @@ extern unsigned int ivpu_log_level;
 #define IVPU_FW_CRITICAL_BUFFER_SIZE		SZ_512K
 
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p);
-void ivpu_fw_log_clear(struct ivpu_device *vdev);
+void ivpu_fw_log_mark_read(struct ivpu_device *vdev);
 void ivpu_fw_log_reset(struct ivpu_device *vdev);
 
 static inline void ivpu_fw_log_dump(struct ivpu_device *vdev)
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
diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index 88345070a9965..7d302693f4562 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -301,7 +301,9 @@ struct vpu_tracing_buffer_header {
 	u32 host_canary_start;
 	/* offset from start of buffer for trace entries */
 	u32 read_index;
-	u32 pad_to_cache_line_size_0[14];
+	/* keeps track of wrapping on the reader side */
+	u32 read_wrap_count;
+	u32 pad_to_cache_line_size_0[13];
 	/* End of first cache line */
 
 	/**
-- 
2.53.0

