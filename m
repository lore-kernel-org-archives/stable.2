Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE55437E8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871698; cv=none; b=p1EeNBdcYD0qzW1+zJwFzsQdF8P1gQTNmJ58suTToouYtL+y5XqCiCf064qCw3JnjpenYOfcuUhpyjnJdmS9/SC0XokTcypI67pt7Ow7Q8VX5CNSX/OCPL6a9DHGrMZjuScg10xtcCzDoKhfW7tolq+mW+Bzjr23BuPeV8Mx/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871698; c=relaxed/simple;
	bh=hID5FmCBvCjlSM1yQ/oNVBuMVBcJNMd9vDuJBO3VSEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5CLgqS/Beg0l8iQwv2qxd7fZQQp5GDlynw6ajBEgE+Ye63YyeOW46wuA/slJ2TkHJZJPOWE/KsXUAWLq67MBQSXePc7OKYVLxqAH7q77NmcLfY4eDd/grA4MsZKV2PQU/01iuZinV96Iy/m4hamlMnS5CONuQt2gOI/ZnQ7RlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D5F1F00A3A;
	Tue,  8 Sep 2026 12:48:15 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/5] bpf: Factor stackid_fastpath function from __bpf_get_stackid
Date: Tue,  8 Sep 2026 08:48:10 -0400
Message-ID: <20260908124813.2161006-2-sashal@kernel.org>
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

[ Upstream commit 0ca56befcffec3a6c9d1842eae06c74e1cf41f11 ]

The new stackid_fastpath does the fast stack hash and trace check, that
does not need new bucket allocation. It covers both just-ip and buildid
code paths.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260803210149.296496-3-jolsa@kernel.org
Stable-dep-of: 15f1bd857466 ("bpf: Disable preemption in bpf_get_stackid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 66f58a7606907..cfccf8b12fe14 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -511,6 +511,7 @@ struct stackid {
 	u32  len;
 	u32  hash;
 	u32  id;
+	bool hash_matches;
 };
 
 static int stackid_init(struct stackid *stackid, struct bpf_map *map,
@@ -531,28 +532,46 @@ static int stackid_init(struct stackid *stackid, struct bpf_map *map,
 	stackid->hash = jhash2((u32 *)stackid->ips, stackid->len / sizeof(u32), 0);
 	stackid->id = stackid->hash & (smap->n_buckets - 1);
 	stackid->bucket = READ_ONCE(smap->buckets[stackid->id]);
+	stackid->hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
 	return 0;
 }
 
+static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
+			    struct perf_callchain_entry *trace, u64 flags)
+{
+	int err;
+
+	err = stackid_init(stackid, map, trace, flags);
+	if (err)
+		return err;
+
+	/* fast cmp */
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
 static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			      struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
-	bool hash_matches;
 	u32 trace_len, i;
 	int err;
 
-	err = stackid_init(stackid, map, trace, flags);
-	if (err)
+	err = stackid_fastpath(stackid, map, trace, flags);
+	if (err != -ENOENT)
 		return err;
 
-	hash_matches = stackid->bucket && stackid->bucket->hash == stackid->hash;
-	/* fast cmp */
-	if (hash_matches && flags & BPF_F_FAST_STACK_CMP)
-		return stackid->id;
-
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
 
@@ -567,7 +586,7 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			id_offs[i].ip = stackid->ips[i];
 		stack_map_get_build_id_offset(id_offs, stackid->nr, user, false /* !may_fault */);
 		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
-		if (hash_matches && stackid->bucket->nr == stackid->nr &&
+		if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
 		    memcmp(stackid->bucket->data, new_bucket->data, trace_len) == 0) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return stackid->id;
@@ -577,12 +596,6 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			return -EEXIST;
 		}
 	} else {
-		if (hash_matches && stackid->bucket->nr == stackid->nr &&
-		    memcmp(stackid->bucket->data, stackid->ips, stackid->len) == 0)
-			return stackid->id;
-		if (stackid->bucket && !(flags & BPF_F_REUSE_STACKID))
-			return -EEXIST;
-
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
-- 
2.53.0

