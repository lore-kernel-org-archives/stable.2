Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2759221D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891652; cv=none; b=cHgKEx03sgcfWuB5lS+Do5PgbuRCsQcirCvIfiKn8xjQy8C/XYpO0T4pHXj6ztEjkh3e4l4AomBrFZRIiiCkafZxKYFGTx1mYFmx2ILx64LWrK9s+d3Eo4qEZIm3eZRh2nTCdFwXx6MxW6FV3tluAy9dPFAcxta02uFmHqg50P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891652; c=relaxed/simple;
	bh=1A2NyHsueFwLUK6WVxWj38/89/j+ZmY26dXoXWV4xc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFSX6cRWHKDNvDSiUe1+QdSrkQFa5Mt+P41hM7JKB3lKP439ROOHCMziwDlc0NvoeSLGCjVicDzsXfUSk7EzMKjR316WLCgxiJbZ63YtQ8joL4Fz12AG/7mn1Tt6Nr8XH5l0FD9XH/QtME0/Vzw630qbI6yeMG7iXy5BxL0332Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJgF87je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJgF87je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D33E1F00ACF;
	Tue,  8 Sep 2026 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891649;
	bh=47BxRPKW6kAlytRQl5kJMKUCVFx89ai6uzizqvDmPYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJgF87jeKhtz57FGxuiP+1lvs7z93RUWBW7SMDn9y1CULFPQaT9Jvax1tiKLfArT1
	 uy3StZtCUSRIDAqoPzoTZMa9IZlvQ+FsjmmoSn72oj5Og28HHsgJpG7xyO/zIWN4jh
	 JnrotPK7ROHLRO6Z94gbAIZ2IkQkajnz3wvpQ3ZzHi3eDK0fMKSKgmYVAzq0jNnnRV
	 ywfhbrVv5qAdT8FNHVCHbsptgyfkiHvYRIlHBfueFhyhCf54VCyB/ZKGHWdYjdk0zF
	 bRhkZaNvmrMpov4I+vIiyaCjo4J5tcTCI8u/T9R+74URNlKvTI31Y6yR0P5QmqdscZ
	 J3NHBwsi1dWtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] bpf: Factor stackid_init function from __bpf_get_stackid
Date: Tue,  8 Sep 2026 14:20:46 -0400
Message-ID: <20260908182047.200457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-evolution-kitty-6754@gregkh>
References: <2026090354-evolution-kitty-6754@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 15b837759a97237d647962f9943afe0d55af615a ]

The new stackid_init function stores all the necessary bits for stackid
trace and it will be used by other functions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260803210149.296496-2-jolsa@kernel.org

[ Stable 6.1 note: Fold in the three intervening stack-ID refactors
needed by the follow-up preemption fix. Adapt the older build-ID path to
copy perf-owned IPs before that fix ends its preemption guard, and reshape
the legacy get_perf_callchain() interface to the follow-up call form while
leaving the unavailable deferred-unwind argument unused. ]

Stable-dep-of: 15f1bd857466 ("bpf: Disable preemption in bpf_get_stackid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/perf_event.h |   4 +-
 kernel/bpf/stackmap.c      | 267 +++++++++++++++++++++++++------------
 kernel/events/callchain.c  |   8 +-
 kernel/events/core.c       |   4 +-
 4 files changed, 193 insertions(+), 90 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 41ff70f315a92..b4af64e20842b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1361,8 +1361,8 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
 extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f0fd936cef319..7d316386a7480 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
 		sizeof(struct bpf_stack_build_id) : sizeof(u64);
 }
 
+/**
+ * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
+ * @size:  Size of the buffer/map value in bytes
+ * @elem_size:  Size of each stack trace element
+ * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
+ *
+ * Return: Maximum number of stack trace entries that can be safely stored
+ */
+static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
+{
+	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 max_depth;
+	u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
+
+	max_depth = size / elem_size;
+	max_depth += skip;
+	if (max_depth > curr_sysctl_max_stack)
+		return curr_sysctl_max_stack;
+
+	return max_depth;
+}
+
 static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
 {
 	u64 elem_size = sizeof(struct stack_map_bucket) +
@@ -127,8 +149,18 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
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
@@ -145,29 +177,29 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
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
 			memcpy(id_offs[i].build_id, prev_build_id,
 			       BUILD_ID_SIZE_MAX);
 			goto build_id_valid;
 		}
-		vma = find_vma(current->mm, ips[i]);
+		vma = find_vma(current->mm, ip);
 		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
 build_id_valid:
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 		prev_vma = vma;
@@ -213,101 +245,155 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 #endif
 }
 
-static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+struct stackid {
+	struct stack_map_bucket *bucket;
+	u64 *ips;
+	u32 nr;
+	u32 len;
+	u32 hash;
+	u32 id;
+	bool hash_matches;
+};
+
+static int stackid_init(struct stackid *stackid, struct bpf_map *map,
+			struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
-	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len;
-	bool user = flags & BPF_F_USER_STACK;
-	u64 *ips;
-	bool hash_matches;
+	u32 max_depth;
 
 	if (trace->nr <= skip)
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	trace_nr = trace->nr - skip;
-	trace_len = trace_nr * sizeof(u64);
-	ips = trace->ip + skip;
-	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
-	id = hash & (smap->n_buckets - 1);
-	bucket = READ_ONCE(smap->buckets[id]);
+	max_depth = stack_map_calculate_max_depth(map->value_size,
+						  stack_map_data_size(map), flags);
+	stackid->nr = min_t(u32, trace->nr - skip, max_depth - skip);
+	stackid->len = stackid->nr * sizeof(u64);
+	stackid->ips = trace->ip + skip;
+	stackid->hash = jhash2((u32 *)stackid->ips,
+				stackid->len / sizeof(u32), 0);
+	stackid->id = stackid->hash & (smap->n_buckets - 1);
+	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
+	stackid->hash_matches = stackid->bucket &&
+				stackid->bucket->hash == stackid->hash;
+	return 0;
+}
+
+static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
+			    struct perf_callchain_entry *trace, u64 flags)
+{
+	int err;
+
+	err = stackid_init(stackid, map, trace, flags);
+	if (err)
+		return err;
 
-	hash_matches = bucket && bucket->hash == hash;
 	/* fast cmp */
-	if (hash_matches && flags & BPF_F_FAST_STACK_CMP)
-		return id;
+	if (stackid->hash_matches && flags & BPF_F_FAST_STACK_CMP)
+		return stackid->id;
+
+	if (stack_map_use_build_id(map))
+		return -ENOENT;
+	if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
+	    memcmp(stackid->bucket->data, stackid->ips, stackid->len) == 0)
+		return stackid->id;
+	if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID))
+		return -EEXIST;
+	return -ENOENT;
+}
+
+static struct stack_map_bucket *
+stackid_new_bucket(struct stackid *stackid, struct bpf_map *map)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	struct bpf_stack_build_id *id_offs;
+	struct stack_map_bucket *bucket;
+	u32 i;
+
+	bucket = (struct stack_map_bucket *)pcpu_freelist_pop(&smap->freelist);
+	if (unlikely(!bucket))
+		return NULL;
 
 	if (stack_map_use_build_id(map)) {
-		/* for build_id+offset, pop a bucket before slow cmp */
-		new_bucket = (struct stack_map_bucket *)
-			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
-		new_bucket->nr = trace_nr;
-		stack_map_get_build_id_offset(
-			(struct bpf_stack_build_id *)new_bucket->data,
-			ips, trace_nr, user);
-		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
-		if (hash_matches && bucket->nr == trace_nr &&
-		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
+		id_offs = (struct bpf_stack_build_id *)bucket->data;
+		for (i = 0; i < stackid->nr; i++)
+			id_offs[i].ip = stackid->ips[i];
+	} else {
+		memcpy(bucket->data, stackid->ips, stackid->len);
+	}
+
+	bucket->hash = stackid->hash;
+	bucket->nr = stackid->nr;
+	return bucket;
+}
+
+static long stackid_install(struct stackid *stackid, struct bpf_map *map,
+			    struct stack_map_bucket *new_bucket, u64 flags)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *old_bucket;
+	u32 trace_len;
+
+	if (stack_map_use_build_id(map)) {
+		struct bpf_stack_build_id *id_offs;
+
+		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
+		stack_map_get_build_id_offset(id_offs, stackid->nr, user);
+		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
+		if (stackid->hash_matches &&
+		    stackid->bucket->nr == stackid->nr &&
+		    memcmp(stackid->bucket->data, new_bucket->data,
+			   trace_len) == 0) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
-			return id;
+			return stackid->id;
 		}
-		if (bucket && !(flags & BPF_F_REUSE_STACKID)) {
+		if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID)) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return -EEXIST;
 		}
-	} else {
-		if (hash_matches && bucket->nr == trace_nr &&
-		    memcmp(bucket->data, ips, trace_len) == 0)
-			return id;
-		if (bucket && !(flags & BPF_F_REUSE_STACKID))
-			return -EEXIST;
-
-		new_bucket = (struct stack_map_bucket *)
-			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
-		memcpy(new_bucket->data, ips, trace_len);
 	}
 
-	new_bucket->hash = hash;
-	new_bucket->nr = trace_nr;
-
-	old_bucket = xchg(&smap->buckets[id], new_bucket);
+	old_bucket = xchg(&smap->buckets[stackid->id], new_bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
-	return id;
+	return stackid->id;
 }
 
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags)
 {
-	u32 max_depth = map->value_size / stack_map_data_size(map);
-	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel = !user;
+	u32 max_depth;
+	int err;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
-	max_depth += skip;
-	if (max_depth > sysctl_perf_event_max_stack)
-		max_depth = sysctl_perf_event_max_stack;
-
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
-				   false, false);
+	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+	trace = get_perf_callchain(regs, kernel, user, max_depth,
+				   false, false, 0);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	err = stackid_fastpath(&stackid, map, trace, flags);
+	if (err != -ENOENT)
+		return err;
+
+	new_bucket = stackid_new_bucket(&stackid, map);
+	if (!new_bucket)
+		return -ENOMEM;
+
+	return stackid_install(&stackid, map, new_bucket, flags);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -335,7 +421,9 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_map *, map, u64, flags)
 {
 	struct perf_event *event = ctx->event;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -357,15 +445,10 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(map, trace, flags);
-
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -374,8 +457,22 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(map, trace, flags);
 	}
+
+	ret = stackid_fastpath(&stackid, map, trace, flags);
+	if (ret != -ENOENT)
+		goto out;
+
+	new_bucket = stackid_new_bucket(&stackid, map);
+	if (new_bucket) {
+		trace->nr = nr;
+		return stackid_install(&stackid, map, new_bucket, flags);
+	}
+	ret = -ENOMEM;
+
+out:
+	/* restore nr */
+	trace->nr = nr;
 	return ret;
 }
 
@@ -392,7 +489,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -425,18 +522,17 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (trace_in)
+	if (trace_in) {
 		trace = trace_in;
-	else if (kernel && task)
+		trace->nr = min_t(u32, trace->nr, max_depth);
+	} else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
-	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
-					   crosstask, false);
+	} else {
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   crosstask, false, 0);
+	}
 	if (unlikely(!trace))
 		goto err_fault;
 
@@ -444,14 +540,19 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
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
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index ce5534c97cd1d..a42240fb7ca0f 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -177,13 +177,15 @@ put_callchain_entry(int rctx)
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
 	int rctx;
 
+	(void)defer_cookie;
+
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
 		return NULL;
@@ -194,7 +196,7 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 
 	ctx.entry     = entry;
 	ctx.max_stack = max_stack;
-	ctx.nr	      = entry->nr = init_nr;
+	ctx.nr	      = entry->nr = 0;
 	ctx.contexts       = 0;
 	ctx.contexts_maxed = false;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0bb33854c4a9..24ac59a7eee88 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7519,8 +7519,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
-				       max_stack, crosstask, true);
+	callchain = get_perf_callchain(regs, kernel, user, max_stack,
+				       crosstask, true, 0);
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.53.0

