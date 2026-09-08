Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CB558202
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874389; cv=none; b=AJN9zzQ8eBtFFldnlMlNWac7DSpiJ7nL0JSNfhmd/0PC2ckGCrfk0kb5arJOwu4xz/XCnkSLMidUBWBqR65ayPWrV5/JlvvDzA3Z1ZZw/RirGbeJY4MWVBSGnk9h03dCyTMhK8nwNDndxvwt8S5FJ26rq6vmhsQ+JTHfZsDargc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874389; c=relaxed/simple;
	bh=myKcD2FsElqBvhWFDj6XfIomnq5GPYgPry5AtjUvCuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1VissceQn+RKo8AFk9Pxg2TUKfaRS7islyACrawv3aE+dW9HKR3J8csbnP9DPyfB3svcmNHV4gr23hWLvPY2TDWHIRabsPLsTp583SBPQfynsn90c71zOwppX/JGTd0ZyUNCcibMOtqHrZL0J30uZAUCk0SXiXUhilTUbayK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F191F01558;
	Tue,  8 Sep 2026 13:32:54 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] bpf: decouple stack_map_get_build_id_offset() from perf_callchain_entry
Date: Tue,  8 Sep 2026 09:32:50 -0400
Message-ID: <20260908133251.2324526-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908133251.2324526-1-sashal@kernel.org>
References: <2026090326-saturate-wobbling-7457@gregkh>
 <20260908133251.2324526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 4f4c4fc0153fb11ac40b16c24a24543dc9689d8c ]

Change stack_map_get_build_id_offset() which is used to convert stack
trace IP addresses into build ID+offset pairs. Right now this function
accepts an array of u64s as an input, and uses array of
struct bpf_stack_build_id as an output.

This is problematic because u64 array is coming from
perf_callchain_entry, which is (non-sleepable) RCU protected, so once we
allows sleepable build ID fetching, this all breaks down.

But its actually pretty easy to make stack_map_get_build_id_offset()
works with array of struct bpf_stack_build_id as both input and output.
Which is what this patch is doing, eliminating the dependency on
perf_callchain_entry. We require caller to fill out
bpf_stack_build_id.ip fields (all other can be left uninitialized), and
update in place as we do build ID resolution.

We make sure to READ_ONCE() and cache locally current IP value as we
used it in a few places to find matching VMA and so on. Given this data
is directly accessible and modifiable by user's BPF code, we should make
sure to have a consistent view of it.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240829174232.3133883-9-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: b1a47b2708d4 ("bpf: Disable preemption in __bpf_get_stack")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 49 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0ed48217b2089..fac13cfb32eec 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -124,8 +124,18 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+/*
+ * Expects all id_offs[i].ip values to be set to correct initial IPs.
+ * They will be subsequently:
+ *   - either adjusted in place to a file offset, if build ID fetching
+ *     succeeds; in this case id_offs[i].build_id is set to correct build ID,
+ *     and id_offs[i].status is set to BPF_STACK_BUILD_ID_VALID;
+ *   - or IP will be kept intact, if build ID fetching failed; in this case
+ *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
+ *     BPF_STACK_BUILD_ID_IP.
+ */
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u64 *ips, u32 trace_nr, bool user)
+					  u32 trace_nr, bool user)
 {
 	int i;
 	struct mmap_unlock_irq_work *work = NULL;
@@ -142,30 +152,28 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 		}
 		return;
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		if (range_in_vma(prev_vma, ips[i], ips[i])) {
+		u64 ip = READ_ONCE(id_offs[i].ip);
+
+		if (range_in_vma(prev_vma, ip, ip)) {
 			vma = prev_vma;
-			memcpy(id_offs[i].build_id, prev_build_id,
-			       BUILD_ID_SIZE_MAX);
+			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
 			goto build_id_valid;
 		}
-		vma = find_vma(current->mm, ips[i]);
+		vma = find_vma(current->mm, ip);
 		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
 build_id_valid:
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
-			- vma->vm_start;
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 		prev_vma = vma;
 		prev_build_id = id_offs[i].build_id;
@@ -216,7 +224,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len;
+	u32 hash, id, trace_nr, trace_len, i;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -238,15 +246,18 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		return id;
 
 	if (stack_map_use_build_id(map)) {
+		struct bpf_stack_build_id *id_offs;
+
 		/* for build_id+offset, pop a bucket before slow cmp */
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
 		new_bucket->nr = trace_nr;
-		stack_map_get_build_id_offset(
-			(struct bpf_stack_build_id *)new_bucket->data,
-			ips, trace_nr, user);
+		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
+		for (i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+		stack_map_get_build_id_offset(id_offs, trace_nr, user);
 		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
 		if (hash_matches && bucket->nr == trace_nr &&
 		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
@@ -445,10 +456,16 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-	if (user && user_build_id)
-		stack_map_get_build_id_offset(buf, ips, trace_nr, user);
-	else
+	if (user && user_build_id) {
+		struct bpf_stack_build_id *id_offs = buf;
+		u32 i;
+
+		for (i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+		stack_map_get_build_id_offset(buf, trace_nr, user);
+	} else {
 		memcpy(buf, ips, copy_len);
+	}
 
 	if (size > copy_len)
 		memset(buf + copy_len, 0, size - copy_len);
-- 
2.53.0

