Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F5276049;
	Thu,  9 Jul 2026 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571635; cv=none; b=SD2HIDR5J9uJq8Fsf5h1Zd3HFjtfq54cRiCmhLx1siN7MwxdQcbQpyfMqqJ+KhQ22iP/ZyYyrprZypQaFbrrLtEWv4JjiXNKQEvz7K26GLPzokLeo5vrSngD5SfFKkEhEMvb7re9SCIzlhiXZBTNHHDMvTPtAaOqRM/FkMbH6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571635; c=relaxed/simple;
	bh=N+5eQZrGgrV3/k5mSj96tUCKV0nwjxbj1AbAVEQw1Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hESz7sNhAcOdqtGfjuzodIe4s8X/mC3dm92mxM7V8bKQ/ucMm+EoxyAnqhPf7rNN+dJ7CSZCy/gMf5g5PzD9/HL+BbhdBEaO2NBKrW7t1fdlYdSDFl64u4rmwC7rlR59Zw7Kvg1BEviAk7veYZCHjrX4T+9vCXMTDkD94JRKLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTH+KvgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTH+KvgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE651F00A3A;
	Thu,  9 Jul 2026 04:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783571633;
	bh=il2P9a+N8T2OIsl1QaY5Hs87atCN0ByFMp3QBIFbL3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTH+KvgCW/7lUK3LTN10IX9nVw1ySibC3SHxzgB1s5UT6s8+fu5qjHOWLI9CJ5fs/
	 peuI7uxP5VTHxMgUVjlTGE21FeNfkpams9NGewTWox/QofmaK1863g0ZTGogThLj7Y
	 wRQHS0IZYWqz/5HQ+1NWyaWyNijgfEiQkqHgihE3SBaHTIbo/rUVCw8GDXKHSUlvry
	 tMCtv+5HqfMrGTvKZnAjF9yeKUTqU3sufWsRSkurdCs02r6S+jLbNJPO39fUjYG6uJ
	 X+JHmxd7SzFPgxpxP0MxtQ2Y4WYz8kkbQixTdBbheDPuWyHBYZpoQERuDJat8cThJ/
	 vgmzyne0rMLrw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 1/4] slab: Introduce kmalloc_flex() and family
Date: Thu,  9 Jul 2026 00:32:58 -0400
Message-ID: <20260709043301.142931-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709043301.142931-1-ebiggers@kernel.org>
References: <20260709043301.142931-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

commit e4c8b46b924eb8de66c6f0accc9cdd0c2e8fa23b upstream.

As done for kmalloc_obj*(), introduce a type-aware allocator for flexible
arrays, which may also have "counted_by" annotations:

	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);

becomes:

	ptr = kmalloc_flex(*ptr, flex_member, count, gfp);

The internal use of __flex_counter() allows for automatically setting
the counter member of a struct's flexible array member when it has
been annotated with __counted_by(), avoiding any missed early size
initializations while __counted_by() annotations are added to the
kernel. Additionally, this also checks for "too large" allocations based
on the type size of the counter variable. For example:

	if (count > type_max(ptr->flex_counter))
		fail...;
	size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(size, gfp);
	if (!ptr)
		fail...;
	ptr->flex_counter = count;

becomes (n.b. unchanged from earlier example):

	ptr = kmalloc_flex(*ptr, flex_member, count, gfp);
	if (!ptr)
		fail...;
	ptr->flex_counter = count;

Note that manual initialization of the flexible array counter is still
required (at some point) after allocation as not all compiler versions
support the __counted_by annotation yet. But doing it internally makes
sure they cannot be missed when __counted_by _is_ available, meaning
that the bounds checker will not trip due to the lack of "early enough"
initializations that used to work before enabling the stricter bounds
checking. For example:

	ptr = kmalloc_flex(*ptr, flex_member, count, gfp);
	fill(ptr->flex, count);
	ptr->flex_count = count;

This works correctly before adding a __counted_by annotation (since
nothing is checking ptr->flex accesses against ptr->flex_count). After
adding the annotation, the bounds sanitizer would trip during fill()
because ptr->flex_count wasn't set yet. But with kmalloc_flex() setting
ptr->flex_count internally at allocation time, the existing code works
without needing to move the ptr->flex_count assignment before the call
to fill(). (This has been a stumbling block for __counted_by adoption.)

Link: https://patch.msgid.link/20251203233036.3212363-4-kees@kernel.org
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Kees Cook <kees@kernel.org>
[Backport-notes: Removed the actual flex counter handling.  That's a new
 feature, which isn't necessary for just adding the new allocation APIs
 to get backports to apply cleanly.  Also, the allocation-time overflow
 check in the upstream commit was reverted upstream.]
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/process/deprecated.rst |  7 +++++
 include/linux/slab.h                 | 42 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 91c628fa2d59..fed56864d036 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -387,6 +387,7 @@ allocations. For example, these open coded assignments::
 	ptr = kzalloc(sizeof(*ptr), gfp);
 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
 	ptr = kcalloc(count, sizeof(*ptr), gfp);
+	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
 	ptr = kmalloc(sizeof(struct foo, gfp);
 
 become, respectively::
@@ -395,4 +396,10 @@ become, respectively::
 	ptr = kzalloc_obj(*ptr, gfp);
 	ptr = kmalloc_objs(*ptr, count, gfp);
 	ptr = kzalloc_objs(*ptr, count, gfp);
+	ptr = kmalloc_flex(*ptr, flex_member, count, gfp);
 	__auto_type ptr = kmalloc_obj(struct foo, gfp);
+
+If `ptr->flex_member` is annotated with __counted_by(), the allocation
+will automatically fail if `count` is larger than the maximum
+representable value that can be stored in the counter member associated
+with `flex_member`.
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cbb64a2698f5..67f5b9831c56 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -982,6 +982,27 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
 	(TYPE *)KMALLOC(__obj_size, GFP);				\
 })
 
+/**
+ * __alloc_flex - Allocate an object that has a trailing flexible array
+ * @KMALLOC: kmalloc wrapper function to use for allocation.
+ * @GFP: GFP flags for the allocation.
+ * @TYPE: type of structure to allocate space for.
+ * @FAM: The name of the flexible array member of @TYPE structure.
+ * @COUNT: how many @FAM elements to allocate space for.
+ *
+ * Returns: Newly allocated pointer to @TYPE with @COUNT-many trailing
+ * @FAM elements, or NULL on failure or if @COUNT cannot be represented
+ * by the member of @TYPE that counts the @FAM elements (annotated via
+ * __counted_by()).
+ */
+#define __alloc_flex(KMALLOC, GFP, TYPE, FAM, COUNT)			\
+({									\
+	const size_t __count = (COUNT);					\
+	const size_t __obj_size = struct_size_t(TYPE, FAM, __count);	\
+	TYPE *__obj_ptr = KMALLOC(__obj_size, GFP);			\
+	__obj_ptr;							\
+})
+
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
@@ -1005,23 +1026,44 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
 #define kmalloc_objs(VAR_OR_TYPE, COUNT, GFP)		\
 	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), COUNT)
 
+/**
+ * kmalloc_flex - Allocate a single instance of the given flexible structure
+ * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
+ * @FAM: The name of the flexible array member of the structure.
+ * @COUNT: How many flexible array member elements are desired.
+ * @GFP: GFP flags for the allocation.
+ *
+ * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
+ * failure. If @FAM has been annotated with __counted_by(), the allocation
+ * will immediately fail if @COUNT is larger than what the type of the
+ * struct's counter variable can represent.
+ */
+#define kmalloc_flex(VAR_OR_TYPE, FAM, COUNT, GFP)	\
+	__alloc_flex(kmalloc, GFP, typeof(VAR_OR_TYPE),	FAM, COUNT)
+
 /* All kzalloc aliases for kmalloc_(obj|objs|flex). */
 #define kzalloc_obj(P, GFP)				\
 	__alloc_objs(kzalloc, GFP, typeof(P), 1)
 #define kzalloc_objs(P, COUNT, GFP)			\
 	__alloc_objs(kzalloc, GFP, typeof(P), COUNT)
+#define kzalloc_flex(P, FAM, COUNT, GFP)		\
+	__alloc_flex(kzalloc, GFP, typeof(P), FAM, COUNT)
 
 /* All kvmalloc aliases for kmalloc_(obj|objs|flex). */
 #define kvmalloc_obj(P, GFP)				\
 	__alloc_objs(kvmalloc, GFP, typeof(P), 1)
 #define kvmalloc_objs(P, COUNT, GFP)			\
 	__alloc_objs(kvmalloc, GFP, typeof(P), COUNT)
+#define kvmalloc_flex(P, FAM, COUNT, GFP)		\
+	__alloc_flex(kvmalloc, GFP, typeof(P), FAM, COUNT)
 
 /* All kvzalloc aliases for kmalloc_(obj|objs|flex). */
 #define kvzalloc_obj(P, GFP)				\
 	__alloc_objs(kvzalloc, GFP, typeof(P), 1)
 #define kvzalloc_objs(P, COUNT, GFP)			\
 	__alloc_objs(kvzalloc, GFP, typeof(P), COUNT)
+#define kvzalloc_flex(P, FAM, COUNT, GFP)		\
+	__alloc_flex(kvzalloc, GFP, typeof(P), FAM, COUNT)
 
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
-- 
2.55.0

