Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1575437E3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871699; cv=none; b=ZjVE97LkBavZRl9dI4x77V+eXJQZbKGPab7tws8YI3A8mBY8x+v4FGNkXHpnIIQ7epMukzF73r8B8mk/JcGFxSnp2A1ft0BjjPx0lftqx95GDjaMKg7MAcs2QcMEISveZq2/YDgm8UKGBA/8Bc59L1r6bzCLA0KkKsnYD4IOpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871699; c=relaxed/simple;
	bh=z7FjxurKGhH9ncPjTCcabS/sUSr0vkgw10HCmTg8uCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdnhCy0JQT1t3FAOqd0/jnu7k/EhDm9clsiGT+u+HVXcJLVWclR3NVR2zQdRuT/ilE5vvzWWKgfr0EMAAlFVzexlWQGYDTXqLxETa5V3syL0o63HZ3JiYelR4UPbrasVnaBVjjn5gSHDN1tOeTNAsgvpK8RTAUfSVLQueDpA29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEEE1F00A3E;
	Tue,  8 Sep 2026 12:48:17 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/5] bpf: Use stack id functions instead of __bpf_get_stackid
Date: Tue,  8 Sep 2026 08:48:12 -0400
Message-ID: <20260908124813.2161006-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908124813.2161006-1-sashal@kernel.org>
References: <2026090344-joystick-majestic-6d7c@gregkh>
 <20260908124813.2161006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 09b3fd6caa0b57f8a39254ee5db3af30bdd53c18 ]

Replacing __bpf_get_stackid calls with sequence of following functions:

  stackid_fastpath
  stackid_new_bucket
  stackid_install

This makes code more structured and allows us to easily disable
preemption only in bpf_get_stackid in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260803210149.296496-5-jolsa@kernel.org
Stable-dep-of: 15f1bd857466 ("bpf: Disable preemption in bpf_get_stackid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d2c278c754d4c..b85597c880d47 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -584,22 +584,13 @@ stackid_new_bucket(struct stackid *stackid, struct bpf_map *map)
 	return bucket;
 }
 
-static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+static long stackid_install(struct stackid *stackid, struct bpf_map *map,
+			    struct stack_map_bucket *new_bucket, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
-	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *old_bucket;
 	u32 trace_len;
-	int err;
-
-	err = stackid_fastpath(stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
-
-	new_bucket = stackid_new_bucket(stackid, map);
-	if (!new_bucket)
-		return -ENOMEM;
 
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
@@ -629,10 +620,12 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 {
 	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel = !user;
 	u32 max_depth;
+	int err;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -646,7 +639,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(&stackid, map, trace, flags);
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
@@ -674,6 +675,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_map *, map, u64, flags)
 {
 	struct perf_event *event = ctx->event;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel, user;
@@ -701,7 +703,6 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 
 	if (kernel) {
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -710,12 +711,22 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	}
 
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
 	/* restore nr */
 	trace->nr = nr;
-
 	return ret;
 }
 
-- 
2.53.0

