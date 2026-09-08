Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27755C1C3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874382; cv=none; b=JC213Vekk/Xn4QgkEUH+XldYrUV/T6jhNmo4tn0K2Hj/3lm4bWJQQ/evA4AgGAUD0TQzGrqty8s8IoyQv9c55xLAOKExCwiBeEdZnVvSeTJFxYdwLBe3d0GisyLuNj+wq7mOHgpDL+axGDuyMcz/w67s6QdOv/6vJ4jwNdBMr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874382; c=relaxed/simple;
	bh=MVZ70RQ24F31QhDE7yJpDyxkuMYnAD2HpDHVC8piyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehMCc7WEVUzjgOv4flO/xItroO3XFY8j8Pddt/ERU3sTVJN22C1nWGbuCZQdIlL6JGb8pCVyuwBEjopFVW+Cj0FA4Hf2/Tz0xmtIgUyu5Nxt3bS693Wrs/5BM2kjzpJChX5FJddKsqmBL0AFUD4Hs+QBGZN4TAafuC/282Ia7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F4E1F00A3E;
	Tue,  8 Sep 2026 13:32:53 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] lib/buildid: rename build_id_parse() into build_id_parse_nofault()
Date: Tue,  8 Sep 2026 09:32:49 -0400
Message-ID: <20260908133251.2324526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-saturate-wobbling-7457@gregkh>
References: <2026090326-saturate-wobbling-7457@gregkh>
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
index a330f38ae7335..0ed48217b2089 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -156,7 +156,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
+		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95743e6c5b0cb..7b16033510a18 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8903,7 +8903,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
 	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
diff --git a/lib/buildid.c b/lib/buildid.c
index 8d839ff5548ea..6ce6cb6e26fb3 100644
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
  * @buf:      ELF note section(s) to parse
-- 
2.53.0

