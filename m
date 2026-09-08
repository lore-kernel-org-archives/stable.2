Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C07344D95
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883294; cv=none; b=fN4LlnMNwl2OAQlOpdFoMoTgYwWmv36/L6otdJjj5ENJN7QP90+CDMqRK2W6818g5Kne9/BZIxzKphNIstaCGm9Q7Gi16x3WhiYk5Qtn2dnrt473KkzV5YmHjZGgVZ7sUHec35DkYEr8V/7u8zAq+r51MQsoRBn4k15OsFCktYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883294; c=relaxed/simple;
	bh=8mGUZTZ4ZIFRggEOTyiV+xd0yEOKufT6O++0hjXwS9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIr/J8Kb++ZnmBg+Y8ckzYCxxGT+hBSpEuXYPdXRZOQnC4bAGTjBFA3CVU/2oADxjU2Q4VVIyGs+QkQ6wJcVeuCZ2A4wPNJ4hu0RRdgOQvo8y08N57hiAfxjHaag4E0YlicQknwd5gHioSyrXK2TU0Tg0vuU+GJoU5gBEAm+S3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr7E5QB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr7E5QB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89AF1F00A3A;
	Tue,  8 Sep 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883292;
	bh=quoyCQcwiHjiXq9l36Bjx6VLgQ9muWe9VfQ9gRXeWno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lr7E5QB53YVfPrYy+5U/2mnngufc9DtIwWtyA0jx3orMiDmJtNzBPkBO/OUU9lU3/
	 1EOgqAcmQhRhmE+gBzY3PZJREbmk9ufJo6LmwPosdTOoj8zON6gNEVJWTOAmZpwAAy
	 YHw2AJseW6U79bPZ+SB6lOO+Dhiz4IsEY9WpdkXCpGI1gjo5lU05GSJVYfSMHGiHPq
	 L1CiZIUnNPfYN6nBnlumVMBU//aPR9W9jjXK5BBVGsj8FqOfFuSzzUQff4m9F793us
	 2ir35PpybSs26M8IGE42fktYo2ohnhN0RPG/SAUUP0Tpnk4IjsFvZuaDOLUwRck/oB
	 rLlftEO9XTbNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
Date: Tue,  8 Sep 2026 12:01:28 -0400
Message-ID: <20260908160130.2548511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-suffrage-hatchback-38cf@gregkh>
References: <2026090332-suffrage-hatchback-38cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 45b8fc3096542a53bfd245a9ad8ef870384b4897 ]

Make it clear that build_id_parse() assumes that it can take no page
fault by renaming it and current few users to build_id_parse_nofault().

Also add build_id_parse() stub which for now falls back to non-sleepable
implementation, but will be changed in subsequent patches to take
advantage of sleepable context. PROCMAP_QUERY ioctl() on
/proc/<pid>/maps file is using build_id_parse() and will automatically
take advantage of more reliable sleepable context implementation.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240829174232.3133883-6-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: b1a47b2708d4 ("bpf: Disable preemption in __bpf_get_stack")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/buildid.h |  2 ++
 kernel/bpf/stackmap.c   |  2 +-
 kernel/events/core.c    |  2 +-
 lib/buildid.c           | 25 ++++++++++++++++++++++---
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3b7a0ff4642fd..7b645d032875d 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -8,6 +8,8 @@
 
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
+int build_id_parse_nofault(struct vm_area_struct *vma,
+			   unsigned char *build_id, __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f0fd936cef319..484c6581ddca1 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -159,7 +159,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
+		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0bb33854c4a9..f40eb8fbcd4bb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8685,7 +8685,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
 	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
diff --git a/lib/buildid.c b/lib/buildid.c
index 391382bd05413..a83b9582338f9 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -144,10 +144,12 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
  *
- * Return: 0 on success, -EINVAL otherwise
+ * Assumes no page fault can be taken, so if relevant portions of ELF file are
+ * not already paged in, fetching of build ID fails.
+ *
+ * Return: 0 on success; negative error, otherwise
  */
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
-		   __u32 *size)
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
 	Elf32_Ehdr *ehdr;
 	struct page *page;
@@ -192,6 +194,23 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	return ret;
 }
 
+/*
+ * Parse build ID of ELF file mapped to VMA
+ * @vma:      vma object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes faultable context and can cause page faults to bring in file data
+ * into page cache.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+{
+	/* fallback to non-faultable version for now */
+	return build_id_parse_nofault(vma, build_id, size);
+}
+
 /**
  * build_id_parse_buf - Get build ID from a buffer
  * @buf:      Elf note section(s) to parse
-- 
2.53.0

