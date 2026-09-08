Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF95505F6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873139; cv=none; b=XqqV5OeNK9VV+SYYGYtmhIPOrMlie/x9PBybZtjfXEHvxfsCz3UNKOCIX1FdKoSMrO/4rMB79a//BBhANBEAj4DjZFAA80+v47LQJVl7iGyZHSwkDzT68dWqZTbhw4kISa3cVsh8kVEfBPwYEcojUIYh9LApo/hqgEK+55b8A1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873139; c=relaxed/simple;
	bh=6sQiPgnwqYRfCPGfgkyhNqjlXnXl6StckUi9QNb2mbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTqddBQAAgPKVcfT6+xkbEwi9/3Rxki2oWS3YM/TuAuNrA1Lrt9+ZYya6/DaCP+HF8Sn7RXq7fWTuMNUI3vOpdDyYdaKBSmJk5KeSXUEpWndhQ40fNs7MBTgmfCjG2/2p45CWFAH+K5SUxccGedTGWpK+Xn/5nNP+N1Rs3atolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAAO9H9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAAO9H9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472B71F00ACF;
	Tue,  8 Sep 2026 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873132;
	bh=Y4JhlJeGqTiY+06VSZp5P8/MZHw/WybjDzFnYG70VhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AAAO9H9bgColpJHO5kqwYsSa0XR8zvxrBhIPosHwXQQzIg0FpYD2tvZN6Atl6SRiu
	 0nqHkoQ08LIhAe2JhNUyjZX2aRDNWobcmT4xVAQGZdaiplH0rG7y1q4/CJenZcI7dG
	 Oqsi5kMi8OJ//hVPaZzjK8mn9XRWaTaKjf8HfVg/Wzrm19D1rnbXkaQISaxARLtBIJ
	 MdK1MBg3DudTv5cJoZ7Wh9PbH1faW8x1WX36FWV/7m9ZTif45BL8QXkpv2JB8uuVv1
	 +DO3rczTsfy1kXWAzhDIJiPtBS59WGEf3CF3a5Ske/ehjFIgTSWdRhzop9tbeC47Rt
	 mLQof9/q5mT8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] bpf: Factor stackid_new_bucket from __bpf_get_stackid
Date: Tue,  8 Sep 2026 09:12:07 -0400
Message-ID: <20260908131209.2236373-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908131209.2236373-1-sashal@kernel.org>
References: <2026090347-bodacious-studio-93ee@gregkh>
 <20260908131209.2236373-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit bb4e6f4e1b68fe60c04ca04c564c6624e837dbf4 ]

The new stackid_new_bucket allocates the new bucket and initializes it
with the trace data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260803210149.296496-4-jolsa@kernel.org
Stable-dep-of: 15f1bd857466 ("bpf: Disable preemption in bpf_get_stackid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 48 +++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index b3661d6f18676..cd3b91a726336 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -301,31 +301,52 @@ static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
 	return -ENOENT;
 }
 
+static struct stack_map_bucket *
+stackid_new_bucket(struct stackid *stackid, struct bpf_map *map)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	struct bpf_stack_build_id *id_offs;
+	struct stack_map_bucket *bucket;
+	u32 i;
+
+	bucket = (struct stack_map_bucket *) pcpu_freelist_pop(&smap->freelist);
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
 static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			      struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
-	u32 trace_len, i;
+	u32 trace_len;
 	int err;
 
 	err = stackid_fastpath(stackid, map, trace, flags);
 	if (err != -ENOENT)
 		return err;
 
+	new_bucket = stackid_new_bucket(stackid, map);
+	if (!new_bucket)
+		return -ENOMEM;
+
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
 
-		/* for build_id+offset, pop a bucket before slow cmp */
-		new_bucket = (struct stack_map_bucket *)
-			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
-		new_bucket->nr = stackid->nr;
 		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
-		for (i = 0; i < stackid->nr; i++)
-			id_offs[i].ip = stackid->ips[i];
 		stack_map_get_build_id_offset(id_offs, stackid->nr, user, false /* !may_fault */);
 		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
 		if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
@@ -337,17 +358,8 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return -EEXIST;
 		}
-	} else {
-		new_bucket = (struct stack_map_bucket *)
-			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
-		memcpy(new_bucket->data, stackid->ips, stackid->len);
 	}
 
-	new_bucket->hash = stackid->hash;
-	new_bucket->nr = stackid->nr;
-
 	old_bucket = xchg(&smap->buckets[stackid->id], new_bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
-- 
2.53.0

