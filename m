Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82395477E4B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099763; cv=none; b=fqbNfH7pnFLwtAp8t4CbC+C7xgN5AXhdadkYb1YoykUqKSAC4BVuotJ93un1RCdfkFRGlRGBAshftTKkAsdgyshzl0Ogj0u3tw0e8n6I296D4Rscahxrdx4ZX/uI7bxEW4JkZqMp9UHo6F2OYMy4wxt4noH8tk7Pj+vhivj/8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099763; c=relaxed/simple;
	bh=7e6W/MOzJQE4uJ87x0orxFRyihb7HOVelXpZdwh1s4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5ZFFia9YiZ+ZUUP7RwfBQJ47afOIQgQ3VXVI7FtBqcafpg6Ny4KKZj9RhM9Tb1MqU4lgjvPZecqDUm3OZ/fVI02V/cZX7Xs7Pw5SP9pnVAxC1kAuepqdl0ek6N+m5VL4pSEbb999wy1AlDRxAhuL+n8Rsomii58z03+gyR9GM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A66+5EvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A66+5EvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927441F00893;
	Tue, 22 Sep 2026 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099761;
	bh=q4a7pLzHTCM6XobA5JPpmKxd1a30/f9Hz0aC8CoREyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A66+5EvNuGZ57/rBwNWJ8gs0hnnXcFJV1lI89d0GmjZjuBE6DWFeDVgrMlQHhMm4y
	 TtrN3btWC9kA+pa7Sz+2d8Xt77i2GSvEVEGHm0XymNU4Eneo9VP6tYfAxNV4mgWWqZ
	 sIY21IBA3ZNE7Tw/X0DDpQlhO0YUxZJEQR0V0fNsA0mXiBhB0uKzn+MXOGsiBFVH71
	 Ovw0SuhuuS2E51+UWCTFxhqfSljj5hWWx3Bqx5QxjsigbxFCFMMviw3UuGC9nL94l7
	 azfTEEy99y5Ioh2y4uGAVfpJMH/2uhcZmyWEL2SSQil5MuMcQ3Op9CPHwKt+TBjBvO
	 6P3MtTacoefNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] slab: Introduce kmalloc_obj() and family
Date: Tue, 22 Sep 2026 13:55:58 -0400
Message-ID: <20260922175559.3320919-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092201-gift-election-aa36@gregkh>
References: <2026092201-gift-election-aa36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 2932ba8d9c99875b98c951d9d3fd6d651d35df3a ]

Introduce type-aware kmalloc-family helpers to replace the common
idioms for single object and arrays of objects allocation:

	ptr = kmalloc(sizeof(*ptr), gfp);
	ptr = kmalloc(sizeof(struct some_obj_name), gfp);
	ptr = kzalloc(sizeof(*ptr), gfp);
	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);

These become, respectively:

	ptr = kmalloc_obj(*ptr, gfp);
	ptr = kmalloc_obj(*ptr, gfp);
	ptr = kzalloc_obj(*ptr, gfp);
	ptr = kmalloc_objs(*ptr, count, gfp);
	ptr = kzalloc_objs(*ptr, count, gfp);

Beyond the other benefits outlined below, the primary ergonomic benefit
is the elimination of needing "sizeof" nor the type name, and the
enforcement of assignment types (they do not return "void *", but rather
a pointer to the type of the first argument). The type name _can_ be
used, though, in the case where an assignment is indirect (e.g. via
"return"). This additionally allows[1] variables to be declared via
__auto_type:

	__auto_type ptr = kmalloc_obj(struct foo, gfp);

Internal introspection of the allocated type now becomes possible,
allowing for future alignment-aware choices to be made by the allocator
and future hardening work that can be type sensitive. For example,
adding __alignof(*ptr) as an argument to the internal allocators so that
appropriate/efficient alignment choices can be made, or being able to
correctly choose per-allocation offset randomization within a bucket
that does not break alignment requirements.

Link: https://lore.kernel.org/all/CAHk-=wiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQHS_TkF5A@mail.gmail.com/ [1]
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://patch.msgid.link/20251203233036.3212363-1-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>

Backport to 6.6: place the type-aware macros between the existing kmalloc()
and kmalloc_node(), retaining the stable allocator implementations. Do not
import the unrelated allocation-profiling, nolock, or bucket APIs from the
upstream insertion context.

Also provide kzalloc_flex() using the existing overflow-safe struct_size_t()
and kzalloc(), so 8697c431e297 ("KEYS: encrypted: fix integer overflow of
datablob_len") can apply and compile without another allocator dependency.
The encrypted payload has no __counted_by annotation; this compatibility
macro leaves initialization of any count member to callers. No functions
are added. Correct the sizeof() syntax in the documentation example.

Stable-dep-of: 8697c431e297 ("KEYS: encrypted: fix integer overflow of datablob_len")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/process/deprecated.rst | 24 +++++++++
 include/linux/slab.h                 | 77 ++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 1f7f3e6c9cda9..82281f4fa355c 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -372,3 +372,27 @@ The helper must be used::
 			DECLARE_FLEX_ARRAY(struct type2, two);
 		};
 	};
+
+Open-coded kmalloc assignments for struct objects
+-------------------------------------------------
+Performing open-coded kmalloc()-family allocation assignments prevents
+the kernel (and compiler) from being able to examine the type of the
+variable being assigned, which limits any related introspection that
+may help with alignment, wrap-around, or additional hardening. The
+kmalloc_obj()-family of macros provide this introspection, which can be
+used for the common code patterns for single, array, and flexible object
+allocations. For example, these open coded assignments::
+
+	ptr = kmalloc(sizeof(*ptr), gfp);
+	ptr = kzalloc(sizeof(*ptr), gfp);
+	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
+	ptr = kcalloc(count, sizeof(*ptr), gfp);
+	ptr = kmalloc(sizeof(struct foo), gfp);
+
+become, respectively::
+
+	ptr = kmalloc_obj(*ptr, gfp);
+	ptr = kzalloc_obj(*ptr, gfp);
+	ptr = kmalloc_objs(*ptr, count, gfp);
+	ptr = kzalloc_objs(*ptr, count, gfp);
+	__auto_type ptr = kmalloc_obj(struct foo, gfp);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index a761cc3559f29..903175aebe125 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_SLAB_H
 #define	_LINUX_SLAB_H
 
+#include <linux/bug.h>
 #include <linux/cache.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
@@ -604,6 +605,82 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
+/**
+ * __alloc_objs - Allocate objects of a given type using
+ * @KMALLOC: which size-based kmalloc wrapper to allocate with.
+ * @GFP: GFP flags for the allocation.
+ * @TYPE: type to allocate space for.
+ * @COUNT: how many @TYPE objects to allocate.
+ *
+ * Returns: Newly allocated pointer to (first) @TYPE of @COUNT-many
+ * allocated @TYPE objects, or NULL on failure.
+ */
+#define __alloc_objs(KMALLOC, GFP, TYPE, COUNT)				\
+({									\
+	const size_t __obj_size = size_mul(sizeof(TYPE), COUNT);	\
+	(TYPE *)KMALLOC(__obj_size, GFP);				\
+})
+
+/**
+ * kmalloc_obj - Allocate a single instance of the given type
+ * @VAR_OR_TYPE: Variable or type to allocate.
+ * @GFP: GFP flags for the allocation.
+ *
+ * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
+ * on failure.
+ */
+#define kmalloc_obj(VAR_OR_TYPE, GFP)			\
+	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), 1)
+
+/**
+ * kmalloc_objs - Allocate an array of the given type
+ * @VAR_OR_TYPE: Variable or type to allocate an array of.
+ * @COUNT: How many elements in the array.
+ * @GFP: GFP flags for the allocation.
+ *
+ * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
+ * or NULL on failure.
+ */
+#define kmalloc_objs(VAR_OR_TYPE, COUNT, GFP)		\
+	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), COUNT)
+
+/* All kzalloc aliases for kmalloc_(obj|objs|flex). */
+#define kzalloc_obj(P, GFP)				\
+	__alloc_objs(kzalloc, GFP, typeof(P), 1)
+#define kzalloc_objs(P, COUNT, GFP)			\
+	__alloc_objs(kzalloc, GFP, typeof(P), COUNT)
+
+/**
+ * kzalloc_flex - Allocate a zeroed object with a trailing flexible array
+ * @P: Variable or type to allocate.
+ * @FAM: The name of the flexible array member.
+ * @COUNT: How many flexible array elements to allocate.
+ * @GFP: GFP flags for the allocation.
+ *
+ * The caller must initialize any associated __counted_by member.
+ *
+ * Returns: a pointer to the allocated object, or NULL on failure.
+ */
+#define kzalloc_flex(P, FAM, COUNT, GFP)				\
+({									\
+	const size_t __count = (COUNT);					\
+	const size_t __obj_size = struct_size_t(typeof(P), FAM, __count); \
+	typeof(P) *__obj_ptr = kzalloc(__obj_size, GFP);		\
+	__obj_ptr;							\
+})
+
+/* All kvmalloc aliases for kmalloc_(obj|objs|flex). */
+#define kvmalloc_obj(P, GFP)				\
+	__alloc_objs(kvmalloc, GFP, typeof(P), 1)
+#define kvmalloc_objs(P, COUNT, GFP)			\
+	__alloc_objs(kvmalloc, GFP, typeof(P), COUNT)
+
+/* All kvzalloc aliases for kmalloc_(obj|objs|flex). */
+#define kvzalloc_obj(P, GFP)				\
+	__alloc_objs(kvzalloc, GFP, typeof(P), 1)
+#define kvzalloc_objs(P, COUNT, GFP)			\
+	__alloc_objs(kvzalloc, GFP, typeof(P), COUNT)
+
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
-- 
2.53.0

