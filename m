Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AE492E4C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913504; cv=none; b=DRvcbKiYn134VeR8CIjWNroEE4lcT2PRZZZLR8Pa+xtNOoHjFOveLDzXskjrmRe34kqP9mu6SBx+xPgfKMvsZdJT4+MZSpU6a94IugRPLQKvP1onUffh4UrIp922Zqcwa+XSxK75flRXGuEiBaKODXLWY0RfEc6UQy+PrjCvUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913504; c=relaxed/simple;
	bh=v0yqYoFNcfQEhOJTFJttCex6V0Vqc66sbVe/hrVYfIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSrMMpP/bAH3iMw3N4VfapQrNJbAEoT5UDrPwed/D8NTs2/4ykgTVG1L2bh9LZMWIp0Eo6JMdk4CYRbIR5tLJq6DkUn5SWeiVsoUtk3Byq6sQIqZBF4BuQTmQtAeKQzuNqMS2WaESn7ojHIM5/IFtWj61boaYcS7OKycMnWT3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUNLGxoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUNLGxoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC51F1F00A3A;
	Wed,  9 Sep 2026 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913503;
	bh=lvI7Fk7FrVuTmKc6ZqzRD6WNVZlKg/M1vVS0hp0K/O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUNLGxoDHfUUgJG6X3sZs0JMjoB9kHJMcgAM4syfaZuw3uHmBJAgYQOrCSYkeTYYK
	 vInZw3cv/cnDx5SOJMpyKvEs7JDSIqfgomwwbguVF0HSD9U+u48KZjcX7RHJ2D4McN
	 SQUUAS0SC7um6cgwYAqvvWnvXxET2EMtKZ/BEOjDzcn0wXWdRfxSK3ktb1zY+EGEV/
	 Rs6ryHlgBYMAxNdYzIVddd3gv7fRZ/QZVESLS6VSH5PURzyRiqx0AGvtnwOVShVRI0
	 THeDECEHUs+ghOuB5pyxka7fHLwWYsDxgs5wJZ2paI6dNCGPaUBJ0aPamcVck7LCgo
	 5QhZLeL4BNIJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] bpf: Factor stackid_init function from __bpf_get_stackid
Date: Tue,  8 Sep 2026 20:25:00 -0400
Message-ID: <20260909002501.724832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-enhance-frostbite-43b5@gregkh>
References: <2026090359-enhance-frostbite-43b5@gregkh>
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
Stable-dep-of: 15f1bd857466 ("bpf: Disable preemption in bpf_get_stackid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 94 +++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3ec76cb5f240d..2373b7e3b222a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -397,32 +397,54 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
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
 
 	if (trace->nr <= skip)
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	trace_nr = trace->nr - skip;
-	trace_len = trace_nr * sizeof(u64);
-	ips = trace->ip + skip;
-	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
-	id = hash & (smap->n_buckets - 1);
-	bucket = READ_ONCE(smap->buckets[id]);
+	stackid->nr = trace->nr - skip;
+	stackid->len = stackid->nr * sizeof(u64);
+	stackid->ips = trace->ip + skip;
+	stackid->hash = jhash2((u32 *)stackid->ips,
+			       stackid->len / sizeof(u32), 0);
+	stackid->id = stackid->hash & (smap->n_buckets - 1);
+	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
+	return 0;
+}
+
+static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
+			      struct perf_callchain_entry *trace, u64 flags)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	struct stack_map_bucket *new_bucket, *old_bucket;
+	bool user = flags & BPF_F_USER_STACK;
+	bool hash_matches;
+	u32 trace_len;
+	int err;
+
+	err = stackid_init(stackid, map, trace, flags);
+	if (err)
+		return err;
 
-	hash_matches = bucket && bucket->hash == hash;
+	hash_matches = stackid->bucket &&
+		       stackid->bucket->hash == stackid->hash;
 	/* fast cmp */
 	if (hash_matches && flags & BPF_F_FAST_STACK_CMP)
-		return id;
+		return stackid->id;
 
 	if (stack_map_use_build_id(map)) {
 		/* for build_id+offset, pop a bucket before slow cmp */
@@ -430,41 +452,43 @@ static long __bpf_get_stackid(struct bpf_map *map,
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
-		new_bucket->nr = trace_nr;
+		new_bucket->nr = stackid->nr;
 		stack_map_get_build_id_offset(
 			(struct bpf_stack_build_id *)new_bucket->data,
-			ips, trace_nr, user);
-		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
-		if (hash_matches && bucket->nr == trace_nr &&
-		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
+			stackid->ips, stackid->nr, user);
+		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
+		if (hash_matches && stackid->bucket->nr == stackid->nr &&
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
 	} else {
-		if (hash_matches && bucket->nr == trace_nr &&
-		    memcmp(bucket->data, ips, trace_len) == 0)
-			return id;
-		if (bucket && !(flags & BPF_F_REUSE_STACKID))
+		if (hash_matches && stackid->bucket->nr == stackid->nr &&
+		    memcmp(stackid->bucket->data, stackid->ips,
+			   stackid->len) == 0)
+			return stackid->id;
+		if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID))
 			return -EEXIST;
 
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
-		memcpy(new_bucket->data, ips, trace_len);
+		memcpy(new_bucket->data, stackid->ips, stackid->len);
 	}
 
-	new_bucket->hash = hash;
-	new_bucket->nr = trace_nr;
+	new_bucket->hash = stackid->hash;
+	new_bucket->nr = stackid->nr;
 
-	old_bucket = xchg(&smap->buckets[id], new_bucket);
+	old_bucket = xchg(&smap->buckets[stackid->id], new_bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
-	return id;
+	return stackid->id;
 }
 
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
@@ -474,6 +498,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel = !user;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
@@ -491,7 +516,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	return __bpf_get_stackid(&stackid, map, trace, flags);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -520,6 +545,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 {
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	struct stackid stackid;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -546,7 +572,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(map, trace, flags);
+		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 
 		/* restore nr */
 		trace->nr = nr;
@@ -558,7 +584,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(map, trace, flags);
+		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	}
 	return ret;
 }
-- 
2.53.0

