Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0545505DC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873136; cv=none; b=JDKN4PEC2NiK835qtpAtVzyOrP1/+Zg2qWShOa+ZP6uerU6+lUmNnVrzvps0i3sozLJLW8b+f3mmX3GRMa04dHTW4ziln2yckCnkQfXSybAt2ILJ8ANHJyQ5umrQj1GskjyFVbj0rm/peP9gJsVn7sh949DecFopSg7uBqWqTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873136; c=relaxed/simple;
	bh=5ZGUGlNT4qJuGJv8hKffN9qTAQn3bhOG1O/HtrcfMJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJNqImxAj2yI+Dps8vnKI7vKCPFXOEvTM29FHiwV/gPSAzbwm8Wq/9g4BNUEMJS+cjzg0vFShwH5/Vc6EBYJmpqNXllhfGEflbU5X+ffhtYxwmciU5erebWCJ4FKp6g8xsHUyO4C1ILibohOJbgsxtyDpxUt1XHM+vKiVN25VHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO1CNgVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO1CNgVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C771F00AC4;
	Tue,  8 Sep 2026 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873132;
	bh=tBeR6uzSj6HDBPeBeDZ1ONWdYJpl8MWdtc3TsTntcLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO1CNgVXSjIJiD7amBcdiKcjc4XviEBRivBQsI6Oh/KQu6E3uNPLjsPAka2iDH8yN
	 SCxL02ZbhpZacRFcS0s125KYPDClnV51sTQY3HlTDY2yAEARCckGzBRubdvutim9Fv
	 FcSy353dIAQs5FeCBEm9QUhkS84zWsMQEeA4zCfnS21NaWAkjAuWAzoYN7lw+UUv2i
	 nZIrSoeM7YW4wc+3/bF0cDHgf/v6aI0oEs//34L8nquDlYSDJ/fc1JTAET/4Twaw0R
	 ThXrgjaz2WHAERcwc5PFMdSEJvH1luqx0at32znKTStbSVdiR2fAMGrYXICaS4ZIQF
	 TVTphM6ibK6Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] bpf: Factor stackid_fastpath function from __bpf_get_stackid
Date: Tue,  8 Sep 2026 09:12:06 -0400
Message-ID: <20260908131209.2236373-2-sashal@kernel.org>
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
index db64199dbd6fb..b3661d6f18676 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -253,6 +253,7 @@ struct stackid {
 	u32  len;
 	u32  hash;
 	u32  id;
+	bool hash_matches;
 };
 
 static int stackid_init(struct stackid *stackid, struct bpf_map *map,
@@ -273,28 +274,46 @@ static int stackid_init(struct stackid *stackid, struct bpf_map *map,
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
 
@@ -309,7 +328,7 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			id_offs[i].ip = stackid->ips[i];
 		stack_map_get_build_id_offset(id_offs, stackid->nr, user, false /* !may_fault */);
 		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
-		if (hash_matches && stackid->bucket->nr == stackid->nr &&
+		if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
 		    memcmp(stackid->bucket->data, new_bucket->data, trace_len) == 0) {
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return stackid->id;
@@ -319,12 +338,6 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
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

