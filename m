Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9C17A2E8
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465035; cv=none; b=bUCysUMlW717SqGBTBjRLSBPrBFzB7TWoDo3MqvTPd3CZemkpZ+6ujpkVFjmpTFzjVUi7sPl2cbeawCP1rVwbjY7HmwQP7YzYzhI0Fu6PKCFJhikFyKiSQnzJxjTkwqL3B31/nNrFMvzwSeegMmj1XcgS76+aim+NmIRi47wHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465035; c=relaxed/simple;
	bh=g5TxrZZ4b27M9TTmINgA5cxz9/ojbKHAy5k4InmdUGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rt3CaVX4gsjIZlfM1CeRiHihgKTKlpvOgWLlzUW36vSumY1SvHvAfYzkusU+MxoAqs7WOcHBAing2Yugjy4z4T5jgHy5DRJI3q/lf7iKzTV/dQ+MUk7pp2QzT5MCNiVzFmNQKkMuqIVVArXMzLyCFnIYCAObfg4ZkJkzVaoRpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI5VIDPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI5VIDPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB35B1F00A3A;
	Sun, 19 Jul 2026 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784465034;
	bh=ALbLSRcHkAe8ee5Bbla/n6BJDf8pJ6FVAjFFHYaPGAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PI5VIDPGT/QouJy4HFXYQAVhvyLVf54EwHiixc1l5BseR/yHvzX9ipVtNXLP+Kjpl
	 StY8bZUWgoMBOsRlHwOZ0Wip2PSQ+XVM71rjB1DvpJPpSK+FVHp3PflgX/+UF3jLPq
	 deMpA7Q8UNlwKH70nZ/oaOOH/Kg92p8kqczyEAvXPDOcn4GnxWBHNZN4mVVonHiXmp
	 7ljbKWNJOxaVcGxbVKMJ8vDmRmRzDi8D9dzdBTzfkt93uhnP5ehR/0pz3n87OgW7Oi
	 0emmVQgpgGfVqZfEHhYo1K7RoHZMLDlEaahPMMkbLvmhpNd4baFbVOUYHejoo/8a4P
	 2oCtY5X6cZulA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] add default_gfp() helper macro and use it in the new *alloc_obj() helpers
Date: Sun, 19 Jul 2026 08:43:45 -0400
Message-ID: <20260719124348.3646001-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719124348.3646001-1-sashal@kernel.org>
References: <2026071427-sulfate-await-a368@gregkh>
 <20260719124348.3646001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit e19e1b480ac73c3e62ffebbca1174f0f511f43e7 ]

Most simple allocations use GFP_KERNEL, and with the new allocation
helpers being introduced, let's just take advantage of that to simplify
that default case.

It's a numbers game:

    git grep 'alloc_obj(' |
	sed 's/.*\(GFP_[_A-Z]*\).*/\1/' |
	sort | uniq -c | sort -n | tail

shows that about 90% of all those new allocator instances just use that
standard GFP_KERNEL.

Those helpers are already macros, and we can easily just make it be the
default case when the gfp argument is missing.

And yes, we could do that for all the legacy interfaces too, but let's
keep it to just the new ones at least for now, since those all got
converted recently anyway, so this is not any "extra" noise outside of
that limited conversion.

And, in fact, I want to do this before doing the -rc1 release, exactly
so that we don't get extra merge conflicts.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: e2674dfbed8a ("usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gfp.h  |  4 ++++
 include/linux/slab.h | 48 ++++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b155929af5b110..09559f7126ac7c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -13,6 +13,10 @@
 struct vm_area_struct;
 struct mempolicy;
 
+/* Helper macro to avoid gfp flags if they are the default one */
+#define __default_gfp(a,...) a
+#define default_gfp(...) __default_gfp(__VA_ARGS__ __VA_OPT__(,) GFP_KERNEL)
+
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
 #define GFP_MOVABLE_SHIFT 3
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7701b38cedeca9..6e5a3fbf6cd882 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1017,8 +1017,8 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
  */
-#define kmalloc_obj(VAR_OR_TYPE, GFP)			\
-	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), 1)
+#define kmalloc_obj(VAR_OR_TYPE, ...) \
+	__alloc_objs(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), 1)
 
 /**
  * kmalloc_objs - Allocate an array of the given type
@@ -1029,8 +1029,8 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
  */
-#define kmalloc_objs(VAR_OR_TYPE, COUNT, GFP)		\
-	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), COUNT)
+#define kmalloc_objs(VAR_OR_TYPE, COUNT, ...) \
+	__alloc_objs(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), COUNT)
 
 /**
  * kmalloc_flex - Allocate a single instance of the given flexible structure
@@ -1044,32 +1044,32 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * will immediately fail if @COUNT is larger than what the type of the
  * struct's counter variable can represent.
  */
-#define kmalloc_flex(VAR_OR_TYPE, FAM, COUNT, GFP)	\
-	__alloc_flex(kmalloc, GFP, typeof(VAR_OR_TYPE),	FAM, COUNT)
+#define kmalloc_flex(VAR_OR_TYPE, FAM, COUNT, ...) \
+	__alloc_flex(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), FAM, COUNT)
 
 /* All kzalloc aliases for kmalloc_(obj|objs|flex). */
-#define kzalloc_obj(P, GFP)				\
-	__alloc_objs(kzalloc, GFP, typeof(P), 1)
-#define kzalloc_objs(P, COUNT, GFP)			\
-	__alloc_objs(kzalloc, GFP, typeof(P), COUNT)
-#define kzalloc_flex(P, FAM, COUNT, GFP)		\
-	__alloc_flex(kzalloc, GFP, typeof(P), FAM, COUNT)
+#define kzalloc_obj(P, ...) \
+	__alloc_objs(kzalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define kzalloc_objs(P, COUNT, ...) \
+	__alloc_objs(kzalloc, default_gfp(__VA_ARGS__), typeof(P), COUNT)
+#define kzalloc_flex(P, FAM, COUNT, ...)		\
+	__alloc_flex(kzalloc, default_gfp(__VA_ARGS__), typeof(P), FAM, COUNT)
 
 /* All kvmalloc aliases for kmalloc_(obj|objs|flex). */
-#define kvmalloc_obj(P, GFP)				\
-	__alloc_objs(kvmalloc, GFP, typeof(P), 1)
-#define kvmalloc_objs(P, COUNT, GFP)			\
-	__alloc_objs(kvmalloc, GFP, typeof(P), COUNT)
-#define kvmalloc_flex(P, FAM, COUNT, GFP)		\
-	__alloc_flex(kvmalloc, GFP, typeof(P), FAM, COUNT)
+#define kvmalloc_obj(P, ...) \
+	__alloc_objs(kvmalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define kvmalloc_objs(P, COUNT, ...) \
+	__alloc_objs(kvmalloc, default_gfp(__VA_ARGS__), typeof(P), COUNT)
+#define kvmalloc_flex(P, FAM, COUNT, ...) \
+	__alloc_flex(kvmalloc, default_gfp(__VA_ARGS__), typeof(P), FAM, COUNT)
 
 /* All kvzalloc aliases for kmalloc_(obj|objs|flex). */
-#define kvzalloc_obj(P, GFP)				\
-	__alloc_objs(kvzalloc, GFP, typeof(P), 1)
-#define kvzalloc_objs(P, COUNT, GFP)			\
-	__alloc_objs(kvzalloc, GFP, typeof(P), COUNT)
-#define kvzalloc_flex(P, FAM, COUNT, GFP)		\
-	__alloc_flex(kvzalloc, GFP, typeof(P), FAM, COUNT)
+#define kvzalloc_obj(P, ...) \
+	__alloc_objs(kvzalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define kvzalloc_objs(P, COUNT, ...) \
+	__alloc_objs(kvzalloc, default_gfp(__VA_ARGS__), typeof(P), COUNT)
+#define kvzalloc_flex(P, FAM, COUNT, ...) \
+	__alloc_flex(kvzalloc, default_gfp(__VA_ARGS__), typeof(P), FAM, COUNT)
 
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
-- 
2.53.0

