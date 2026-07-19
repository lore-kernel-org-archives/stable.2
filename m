Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D715FDA7
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465035; cv=none; b=FamrAagx3Qtdd78+L+4bSPTY8vPN+FoXmjG7wgcd4TRj7Ljo+nEWIHu+nvHUKXNme42MXtvkGSQLMwH03P6peg0l9TIL8P2wK8/frRD60jF5Eivb684wHBMgb8P/QHRYT4XEcKXsSCaULZscu6GI3xKC76tKxHMktUGbEt6rsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465035; c=relaxed/simple;
	bh=S6DncE8gpVNrgTl674VvQ6o/UvTyW8UbwrfeIrFXVw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYUqiNJpVbD0MS7HYG55FzBwExlmq5wGNQgIov64tjRpnr6Oss72Dy9H+dGs8U0MBe1pQpx2Ibx3rhPeBYsC5ysLKJRz13V/Ihi8MpK085dcKMUEe2vvW1Pxuq3n7k8gOVLfi3fItacBbJwKD4U5Dqg2eYmw8lAiRE1/biucThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlY27+YC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlY27+YC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0DD1F000E9;
	Sun, 19 Jul 2026 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784465033;
	bh=2VZ/+zwn9rxmViM7WcczlTYOUyin1FfAtzJKTEZhSDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JlY27+YCrd0wstbC6nLuQFvNB2SXfFoTiaN16/U9AENoBUH86NTK0gd4gEMcdHcql
	 V3uVUYYPsDio1n983LPRUKBCyCb69lqu5wam3Qa7T9ltO+qbVQ7SSwqF0NN4zA3tfG
	 r1PP2BCF4uXmxuCTPQpGEqe269enou0AujzqEcNYctz1FUTunC+++km+TgV01K5IG2
	 YD6isXorTDThgXRkLGrptNWVn0ZqJ/kGfOm7EzCwMKe6ZuToITN2FuTm2ly6lL4dC4
	 ZhiJuU5lQ8CRrLqmngTi1sFC5VY6c3IGAlagR85LPN3KpgexwI5MfDgiv4RwAm0hbZ
	 yW3qql3lHn/IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] slab: Introduce kmalloc_flex() and family
Date: Sun, 19 Jul 2026 08:43:44 -0400
Message-ID: <20260719124348.3646001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071427-sulfate-await-a368@gregkh>
References: <2026071427-sulfate-await-a368@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit e4c8b46b924eb8de66c6f0accc9cdd0c2e8fa23b ]

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
Stable-dep-of: e2674dfbed8a ("usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/process/deprecated.rst |  7 ++++
 include/linux/slab.h                 | 48 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 91c628fa2d59c2..fed56864d0363b 100644
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
index cbb64a2698f5d0..7701b38cedeca9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -982,6 +982,33 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
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
+	TYPE *__obj_ptr;						\
+	if (WARN_ON_ONCE(overflows_flex_counter_type(TYPE, FAM,	__count))) \
+		__obj_ptr = NULL;					\
+	else								\
+		__obj_ptr = KMALLOC(__obj_size, GFP);			\
+	if (__obj_ptr)							\
+		__set_flex_counter(__obj_ptr->FAM, __count);		\
+	__obj_ptr;							\
+})
+
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
@@ -1005,23 +1032,44 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
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
2.53.0

