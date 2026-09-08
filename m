Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773958B6D4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907007; cv=none; b=DsOXwe26WPuZKy0126dUXzneaKPIPKnrK5mpaPHeJv4HHd63B2nPZUECuiCQDlRkd3R66H2S93Fz89o10oBqi7T9BNt+hzgpBoAirl9GK2kY7ByZBMqMn7WHkMmNmMnS8MdBMHdYV3Efi5G8r731n+E41LQmGQZtDArA5z0yHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907007; c=relaxed/simple;
	bh=leeNUoJOyRdJmn+D2g2cIpVneYJ9+yQHZD6wl+aoGUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCjd0Bdd1Q/Etb38ucoW6FXIcCE7t8+MpYEtpaxj+J0hjthUrhV1lIwWsKZkRgD/CN2aErt7eOpg2c7FNtQszba8vouaMiTaFFuUgrr+vv8GQk889HM1DbqAxIlLjRDcqW9VnR9dg4eKszX+mrO+B4powvm7APlM19+s8Dux6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cswKvJez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cswKvJez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169861F00A3A;
	Tue,  8 Sep 2026 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907003;
	bh=y9ejVnlC4uZuTNN0fBopsb6JHuoeo4hBFYJWjwuz1+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cswKvJez5kxn1B9pFY7bQqr09yRoO1xBuzS/bwZY168/K1tZiIXUQFKInOXyuKhSD
	 xCNXHta+WqG/s4ERTxq7iXw4IXUpDTToINY1/3qtFmtt6+JajqmasWscZUS3Kq0P7D
	 VnziSCdpPHuhMs8eTYuY+0YCEO1MPZKlhKxfPsXh0xAQp4bzmzgA2Vfi2Sk048YGkf
	 3s5fhLdR6gJxmPuziHMLRbDUx8qIYvWkg4lGNEPEn0GXG9wVLP6wRJlVUzkvi50Uof
	 HDxHUDRg8U/aFtApC5NX4mHAFv4FPOKHnx3TAZN7nNrmt6R0pB3T4zvDmvdEHvcTUu
	 jBfZWGXHiQ8pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] bpf: Factor stackid_fastpath function from __bpf_get_stackid
Date: Tue,  8 Sep 2026 18:36:40 -0400
Message-ID: <20260908223641.501474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-only-legend-2a89@gregkh>
References: <2026090356-only-legend-2a89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 0ca56befcffec3a6c9d1842eae06c74e1cf41f11 ]

The new stackid_fastpath does the fast stack hash and trace check, that
does not need new bucket allocation. It covers both just-ip and buildid
code paths.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260803210149.296496-3-jolsa@kernel.org

For the 5.15 backport, fold in the surrounding upstream stackid helper
split, depth calculation, and perf callchain API shape. Also decouple
build-ID conversion from the per-CPU callchain buffer. This lets the
follow-up preemption fix copy the trace into an owned bucket before
re-enabling preemption while retaining the older stable implementation.

Stable-dep-of: 15f1bd857466 ("bpf: Disable preemption in bpf_get_stackid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/perf_event.h |   4 +-
 kernel/bpf/stackmap.c      | 241 +++++++++++++++++++++++++------------
 kernel/events/callchain.c  |   6 +-
 kernel/events/core.c       |   4 +-
 4 files changed, 174 insertions(+), 81 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7cc581e0ee69d..b84da884c1459 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1290,8 +1290,8 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
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
index e04571c1833f6..c91e6ffa99dde 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -61,6 +61,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
 		sizeof(struct bpf_stack_build_id) : sizeof(u64);
 }
 
+/**
+ * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
+ * @size: Size of the buffer/map value in bytes
+ * @elem_size: Size of each stack trace element
+ * @flags: BPF stack trace flags
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
@@ -147,8 +169,12 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+/*
+ * Expects all id_offs[i].ip values to contain the initial IPs.  Each entry is
+ * then converted in place to either a build ID and offset or an IP fallback.
+ */
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u64 *ips, u32 trace_nr, bool user)
+					  u32 trace_nr, bool user)
 {
 	int i;
 	struct vm_area_struct *vma;
@@ -186,22 +212,22 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 		}
 		return;
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		vma = find_vma(current->mm, ips[i]);
+		u64 ip = READ_ONCE(id_offs[i].ip);
+
+		vma = find_vma(current->mm, ip);
 		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 	}
@@ -257,101 +283,151 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 #endif
 }
 
-static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+struct stackid {
+	struct stack_map_bucket *bucket;
+	u64 *ips;
+	u32  nr;
+	u32  len;
+	u32  hash;
+	u32  id;
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
+					  stack_map_data_size(map), flags);
+	stackid->nr = min_t(u32, trace->nr - skip, max_depth - skip);
+	stackid->len = stackid->nr * sizeof(u64);
+	stackid->ips = trace->ip + skip;
+	stackid->hash = jhash2((u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
+	stackid->id = stackid->hash & (smap->n_buckets - 1);
+	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
+	stackid->hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
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
+
+	if (stack_map_use_build_id(map)) {
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
+		struct bpf_stack_build_id *id_offs;
+
+		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
+		stack_map_get_build_id_offset(id_offs, stackid->nr, user);
+		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
+		if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
+		    memcmp(stackid->bucket->data, new_bucket->data, trace_len) == 0) {
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
@@ -379,9 +455,11 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_map *, map, u64, flags)
 {
 	struct perf_event *event = ctx->event;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel, user;
-	__u64 nr_kernel;
+	__u64 nr_kernel, nr;
 	int ret;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
@@ -401,15 +479,10 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	nr = trace->nr;
 
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
 
@@ -418,8 +491,22 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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
 
@@ -479,8 +566,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
-					   crosstask, false);
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   crosstask, false, 0);
 	if (unlikely(!trace))
 		goto err_fault;
 
@@ -492,10 +579,16 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
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
+		stack_map_get_build_id_offset(id_offs, trace_nr, user);
+	} else {
 		memcpy(buf, ips, copy_len);
+	}
 
 	if (size > copy_len)
 		memset(buf + copy_len, 0, size - copy_len);
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 58cbe357fb2bf..f83e464b28cc7 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -177,8 +177,8 @@ put_callchain_entry(int rctx)
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -190,7 +190,7 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 
 	ctx.entry     = entry;
 	ctx.max_stack = max_stack;
-	ctx.nr	      = entry->nr = init_nr;
+	ctx.nr	      = entry->nr = 0;
 	ctx.contexts       = 0;
 	ctx.contexts_maxed = false;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc59568a538f6..74340c54fc6b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7613,8 +7613,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
-				       max_stack, crosstask, true);
+	callchain = get_perf_callchain(regs, kernel, user,
+				       max_stack, crosstask, true, 0);
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.53.0

