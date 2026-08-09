Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F12941A
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236490; cv=none; b=a0oyGSE5sHklQ8nGgakXcRzU2kkQziQk8vVCFu/3m8Or7mq2lTMlCcfmaHoVRUZANG1xGMJUprIOTUbEtDjoxgbeEHjko/MQKHSEONS7LWUTYNNy632ETjKmz2KuuNh4PWtGEOiYrXqb9I+ko2h1k5Bta6OReGKNFGxnOlfNag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236490; c=relaxed/simple;
	bh=XS+CnS/Jy6T6qyj642RHF4SMoggz1xhcD1NOpnwn33c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVoeczIBKKgy6cY2RzQGmfDXoXre4iZzIMkhjs/C5YPnb8c5skL/azSgxdJ5LwRAZVeTaTmgAYyhbjpfQK062ocXQKlxvDD/2TJsGxCib6VTcqpjkhuGqF3WhXMwo+ljSeiCsYKmTWpAf3MdCqhzrHHrcDaNw8/RbtevICKAMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxYBnAOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxYBnAOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5216A1F00A3E;
	Sun,  9 Aug 2026 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236488;
	bh=779TMifL+tcB66mvXfDsrO40cp1gHpBMQVn5SFnGNLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxYBnAObkKcvZy65ZePH5b27dJrFnsx4KXX+blMTDgjuBrKOUYGIZiuUE53sIC7zt
	 8LQ6Wy4L+yjolTdpXCZ3v7neaEahp4+7Gs1oQ76x7yVztn75BJOtKFPRg9rzGZJn0c
	 1jgF2O8AB8brQ30AWPtZbeFSWpKj5v+wn+DgfT0lDI0d7Yk2ufZh4BPz2hoBAC8wQu
	 ICRG/XmSnH9ylfk91gasVqpTY1nCJ/YEbWMKpR3AwmJFHiMfGoe7iKkPBzMGuYPxiC
	 46IDT6d+4zEKBKCxCXP6AipGRfb4aSOcIa5BglxqFPOcyQaZW3wX9yBwm4KShhEheI
	 on5cxqJz9EW9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Danielle Costantino <dcostantino@meta.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/slab: prevent unbounded recursion in free path with new kmalloc type
Date: Sat,  8 Aug 2026 20:48:04 -0400
Message-ID: <20260809004804.874153-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809004804.874153-1-sashal@kernel.org>
References: <2026072908-drowsily-racing-b265@gregkh>
 <20260809004804.874153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Harry Yoo (Oracle)" <harry@kernel.org>

[ Upstream commit d9e6a7623938968e3752b67e37eaff097e559a54 ]

Commit 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from
its own slab") avoided recursive allocation of obj_exts from kmalloc
caches of the same size, by bumping the obj_exts array's allocation
size whenever the array size equals the size of the object being
allocated.

However, as reported by Danielle Costantino and Shakeel Butt,
even slabs from kmalloc caches of different sizes can form a cycle
by allocating obj_exts arrays from each other [1]:

  What happened: a KMALLOC_NORMAL slab's obj_exts array (used by
  allocation profiling / memcg accounting) is itself kmalloc()'d from a
  KMALLOC_NORMAL cache, so the "slab holds another slab's obj_exts array"
  relation can form cycles. With sizeof(struct slabobj_ext) == 16 and
  the host's geometry:

  - kmalloc-512 has 64 objects/slab -> array is 64*16 == 1024 bytes,
    served from kmalloc-1k;
  - kmalloc-1k  has 32 objects/slab -> array is 32*16 ==  512 bytes,
    served from kmalloc-512.

  A kmalloc-512 slab and a kmalloc-1k slab therefore hold each other's
  obj_exts array.  Discarding one frees the other's array, which empties
  and discards that slab, which frees the first's array, and so on:
  __free_slab() -> free_slab_obj_exts() -> kfree() -> discard_slab() ->
  __free_slab() recurses along the cycle until the stack is exhausted.

With memory allocation profiling, this allows unbounded recursion
in the free path and led to a stack overflow on a production host in
the Meta fleet [1]:

  BUG: TASK stack guard page was hit
  Oops: stack guard page
  RIP: 0010:kfree+0x8/0x5d0
  Call Trace:
   __free_slab+0x66/0xc0
   kfree+0x3f0/0x5d0
   ... ( ~125x __free_slab <-> kfree ) ...
   <kernel driver freeing a resource>
   do_syscall_64

It is proposed [1] to resolve this issue by always serving the obj_exts
array allocation from kmalloc caches (or large kmalloc) of sizes larger
than the object size. However, as pointed out by Vlastimil Babka [2],
this can waste an excessive amount of memory as slabs from large
kmalloc sizes (e.g. kmalloc-8k) generally need obj_exts arrays much
smaller than the object size.

Therefore, rather than bumping the size, let us take a different
approach; disallow formation of cycles between kmalloc types when
allocating obj_exts arrays. Currently, all obj_exts arrays are served
from normal kmalloc caches. Cycles cannot be created if obj_exts arrays
of normal kmalloc caches are served from a special kmalloc type that can
never have obj_exts arrays.

To achieve this, create a new kmalloc type called KMALLOC_NO_OBJ_EXT.
KMALLOC_NO_OBJ_EXT caches are created with SLAB_NO_OBJ_EXT flag when
either 1) memory allocation profiling is not permanently disabled,
or 2) kmalloc types with a priority higher than KMALLOC_CGROUP are
aliased with KMALLOC_NORMAL.

Sheaf bootstrapping for KMALLOC_NO_OBJ_EXT caches now must be deferred
because allocation of a barn can trigger obj_exts array allocation of
normal kmalloc caches when the KMALLOC_NO_OBJ_EXT cache for that size
is not ready yet. For simplicity, perform bootstrapping of sheaves for
all kmalloc caches later.

Introduce a new slab alloc flag, SLAB_ALLOC_NO_OBJ_EXT, to prevent
allocation of obj_exts arrays, and let kmalloc_slab() override the type
to KMALLOC_NO_OBJ_EXT when specified. Note that kmalloc_type() remains
unchanged because kmalloc_flags() bypasses the kmalloc fastpath.

Do not pass SLAB_ALLOC_NO_RECURSE to kmalloc_flags() in
alloc_slab_obj_exts() and instead use SLAB_ALLOC_NO_OBJ_EXT only when
the objects are allocated from normal kmalloc caches. While this
prevents unbounded recursive allocation of obj_exts, it allows
KMALLOC_NO_OBJ_EXT caches to have sheaves.

Since sheaf allocations specify SLAB_ALLOC_NO_RECURSE that prevents
allocation of both sheaves and obj_exts arrays, the recursion depth
is bounded.

obj_exts arrays for non-kmalloc-normal caches can now have a valid tag.
Do not call mark_obj_codetag_empty() when freeing an obj_exts array to
avoid false warnings. KMALLOC_NO_OBJ_EXT don't need this as they never
allocate those arrays.

Reported-by: Danielle Costantino <dcostantino@meta.com>
Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
Closes: https://lore.kernel.org/linux-mm/20260625230029.703750-1-shakeel.butt@linux.dev [1]
Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/c5c4208d-a6f0-413e-bad9-49be12f12d55@kernel.org [2]
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Link: https://patch.msgid.link/20260713-kmalloc-no-objext-v3-4-47c7bd138de7@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/slab.h |  6 ++++++
 mm/slab.h            | 28 ++++++++++++++++++++++++++--
 mm/slab_common.c     | 13 +++++++++++++
 mm/slub.c            | 34 +++++++++++++++++++++++-----------
 4 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 773843a71960d..62715b7435e19 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -578,6 +578,9 @@ enum kmalloc_cache_type {
 #endif
 #ifndef CONFIG_MEMCG
 	KMALLOC_CGROUP = KMALLOC_NORMAL,
+#endif
+#ifndef CONFIG_SLAB_OBJ_EXT
+	KMALLOC_NO_OBJ_EXT = KMALLOC_NORMAL,
 #endif
 	KMALLOC_RANDOM_START = KMALLOC_NORMAL,
 	KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + RANDOM_KMALLOC_CACHES_NR,
@@ -591,6 +594,9 @@ enum kmalloc_cache_type {
 #endif
 #ifdef CONFIG_MEMCG
 	KMALLOC_CGROUP,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	KMALLOC_NO_OBJ_EXT,
 #endif
 	NR_KMALLOC_TYPES
 };
diff --git a/mm/slab.h b/mm/slab.h
index b65d2462b3fdb..8e9fc3efc3fa4 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -413,9 +413,13 @@ static inline struct kmem_cache *
 kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
 {
 	unsigned int index;
+	enum kmalloc_cache_type type = kmalloc_type(flags, caller);
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		type = KMALLOC_NO_OBJ_EXT;
 
 	if (!b)
-		b = &kmalloc_caches[kmalloc_type(flags, caller)];
+		b = &kmalloc_caches[type];
 	if (size <= 192)
 		index = kmalloc_size_index[size_index_elem(size)];
 	else
@@ -454,7 +458,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 {
 	if (!is_kmalloc_cache(s))
 		return false;
-	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
+
+	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT|SLAB_NO_OBJ_EXT));
 }
 
 /* Legal flag mask for kmem_cache_create(), for various configurations */
@@ -557,6 +562,25 @@ bool slab_in_kunit_test(void);
 static inline bool slab_in_kunit_test(void) { return false; }
 #endif
 
+/*
+ * Return true if KMALLOC_NORMAL caches may need obj_exts arrays.
+ *
+ * Memory allocation profiling requires obj_exts for all caches.
+ * Memcg usually doesn't need them for normal kmalloc caches, but kmalloc types
+ * with a priority higher than KMALLOC_CGROUP can be aliased with KMALLOC_NORMAL.
+ */
+static __always_inline bool need_kmalloc_no_objext(void)
+{
+	if (!mem_alloc_profiling_permanently_disabled())
+		return true;
+
+	if (!mem_cgroup_kmem_disabled() &&
+			(KMALLOC_NORMAL == KMALLOC_RECLAIM))
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 /*
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 477fa471da185..4cc96c3ea18e0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -793,6 +793,12 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 #define KMALLOC_RANDOM_NAME(N, sz)
 #endif
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define KMALLOC_NO_OBJ_EXT_NAME(sz) .name[KMALLOC_NO_OBJ_EXT] = "kmalloc-no-objext-" #sz,
+#else
+#define KMALLOC_NO_OBJ_EXT_NAME(sz)
+#endif
+
 #define INIT_KMALLOC_INFO(__size, __short_size)			\
 {								\
 	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
@@ -800,6 +806,7 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 	KMALLOC_CGROUP_NAME(__short_size)			\
 	KMALLOC_DMA_NAME(__short_size)				\
 	KMALLOC_RANDOM_NAME(RANDOM_KMALLOC_CACHES_NR, __short_size)	\
+	KMALLOC_NO_OBJ_EXT_NAME(__short_size)			\
 	.size = __size,						\
 }
 
@@ -907,6 +914,12 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 			return;
 		}
 		flags |= SLAB_ACCOUNT;
+	} else if (IS_ENABLED(CONFIG_SLAB_OBJ_EXT) && type == KMALLOC_NO_OBJ_EXT) {
+		if (!need_kmalloc_no_objext()) {
+			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
+			return;
+		}
+		flags |= SLAB_NO_OBJ_EXT | SLAB_NO_MERGE;
 	} else if (IS_ENABLED(CONFIG_ZONE_DMA) && (type == KMALLOC_DMA)) {
 		flags |= SLAB_CACHE_DMA;
 	}
diff --git a/mm/slub.c b/mm/slub.c
index cf678f4617258..b61225c3503bf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1997,8 +1997,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	struct slabobj_ext *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
-	/* Prevent recursive extension vector allocation */
-	gfp |= __GFP_NO_OBJ_EXT;
+	/*
+	 * In most cases, obj_exts arrays are allocated from normal kmalloc.
+	 * However, normal kmalloc caches must allocate them from
+	 * KMALLOC_NO_OBJ_EXT caches to prevent recursion.
+	 */
+	if (is_kmalloc_normal(s))
+		gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec) {
@@ -2014,6 +2019,22 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		return -ENOMEM;
 	}
 
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		struct kmem_cache *exts_cache;
+		struct slab *exts_slab;
+
+		exts_slab = virt_to_slab(vec);
+		if (exts_slab) {
+			/*
+			 * The vector must be allocated from either normal or
+			 * KMALLOC_NO_OBJ_EXT kmalloc caches to avoid cycles.
+			 */
+			exts_cache = exts_slab->slab_cache;
+			WARN_ON_ONCE(!is_kmalloc_normal(exts_cache) &&
+					!(exts_cache->flags & SLAB_NO_OBJ_EXT));
+		}
+	}
+
 	new_exts = (unsigned long)vec;
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
@@ -2034,7 +2055,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * assign slabobj_exts in parallel. In this case the existing
 		 * objcg vector should be reused.
 		 */
-		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
 	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
@@ -2061,14 +2081,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 		return;
 	}
 
-	/*
-	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
-	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
-	 * warning if slab has extensions but the extension of an object is
-	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
-	 * the extension for obj_exts is expected to be NULL.
-	 */
-	mark_objexts_empty(obj_exts);
 	kfree(obj_exts);
 	slab->obj_exts = 0;
 }
-- 
2.53.0

