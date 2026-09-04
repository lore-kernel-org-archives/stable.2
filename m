Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDA3B28D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489354; cv=none; b=WU2phdZLSTYK4AV4pk5Tz1cC5c/N12PCsGZPfFU7ALlOrjn5c+spNn0iy3ICP9UgWhCfWJ9bE69glABlED8frQcbJIwtjJVimGOjYYsGYlwuj2NvrI5m1YMedn//xVO2sEZySBRkw4UHN2kbdcS9DVXsBYZ9dzF0clAh1j7pyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489354; c=relaxed/simple;
	bh=gPzIBFlGOwL0jgsxhWatD5iLAmxYHDRlmajl0mIZwn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjsXkTK46Wjq0J6R8J+9g3YkiojZ2SftHlwtgXRmP0+HkAZ9ZSOMapJdrh0RyfhWJgIQ6EFUMqfPIiBkxE/N3WWbTZSKncBjwJWo3Rc9mhpp8nnJy5NSr7tlwiDqk7KxkYtIjsRdr+Q6M3J1KKAsa7fHO8fxjb0IN+X8Vt8T4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcmCkQEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcmCkQEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B781F00A3E;
	Fri,  4 Sep 2026 02:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788489352;
	bh=/0+8uqR9yiAMJ9Rdm3fjx71jn4o1+1Vr5ilEc79tKuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dcmCkQELCiU1/zJcK0HLjb3jmnhLSu7EI7FMDtzUQaezoKnJnLt6VlDVZv71bcv2U
	 IB2F/0Q3J/lCzhW1M9JQG4omRCWdcomYAJgF3WEBm9N/boij3bXc4p3aKHCQ8XxE7d
	 GMpvsP7vrf7glTfhaIXsFrktS4bSJ/eUK7INCVI/ROFItidx/GbvTn9XV9C4DgILfV
	 li2c75qiigLyPiNWhuUZtPuJunLpcEG2LPuUBdGosKOoBt9+INXAgGQ0cJ05zVtqZv
	 nmHT9QcvVT61+0F8DcXMdBpX+GbrLBVNt9BVDazwg3prVNhNK7o3LePYL+MPI4U2dX
	 uUpwzQAYsTYrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mm/slab: move and refactor __kmem_cache_alias()
Date: Thu,  3 Sep 2026 22:35:47 -0400
Message-ID: <20260904023549.2231387-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904023549.2231387-1-sashal@kernel.org>
References: <2026090309-stool-flyaway-37a0@gregkh>
 <20260904023549.2231387-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 8598351edc42f38d2a1eaed9abca39c98e7b0bbf ]

Move __kmem_cache_alias() to slab_common.c since it's called by
__kmem_cache_create_args() and calls find_mergeable() that both
are in this file. We can remove two slab.h declarations and make
them static. Instead declare sysfs_slab_alias() from slub.c so
that __kmem_cache_alias() can keep calling it.

Add args parameter to __kmem_cache_alias() and find_mergeable() instead
of align and ctor. With that we can also move the checks for usersize
and sheaf_capacity there from __kmem_cache_create_args() and make the
result more symmetric with slab_unmergeable().

No functional changes intended.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: 7e98f8563956 ("mm/slub: fix missing debugfs entries for caches created before sysfs init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab.h        |  8 +++-----
 mm/slab_common.c | 41 +++++++++++++++++++++++++++++++++--------
 mm/slub.c        | 29 +----------------------------
 3 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 8e9fc3efc3fa4..595e234e903c6 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -318,9 +318,12 @@ struct kmem_cache {
 #define SLAB_SUPPORTS_SYSFS 1
 void sysfs_slab_unlink(struct kmem_cache *s);
 void sysfs_slab_release(struct kmem_cache *s);
+int sysfs_slab_alias(struct kmem_cache *s, const char *name);
 #else
 static inline void sysfs_slab_unlink(struct kmem_cache *s) { }
 static inline void sysfs_slab_release(struct kmem_cache *s) { }
+static inline int sysfs_slab_alias(struct kmem_cache *s, const char *name)
+							{ return 0; }
 #endif
 
 void *fixup_red_left(struct kmem_cache *s, void *p);
@@ -441,11 +444,6 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int useroffset, unsigned int usersize);
 
 int slab_unmergeable(struct kmem_cache *s);
-struct kmem_cache *find_mergeable(unsigned size, unsigned align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *));
-struct kmem_cache *
-__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *));
 
 slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4cc96c3ea18e0..2e32712b65fa5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -170,15 +170,19 @@ int slab_unmergeable(struct kmem_cache *s)
 	return 0;
 }
 
-struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *))
+static struct kmem_cache *find_mergeable(unsigned int size, slab_flags_t flags,
+		const char *name, struct kmem_cache_args *args)
 {
 	struct kmem_cache *s;
+	unsigned int align;
 
 	if (slab_nomerge)
 		return NULL;
 
-	if (ctor)
+	if (args->ctor)
+		return NULL;
+
+	if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
 		return NULL;
 
 	flags = kmem_cache_flags(flags, name);
@@ -187,7 +191,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 		return NULL;
 
 	size = ALIGN(size, sizeof(void *));
-	align = calculate_alignment(flags, align, size);
+	align = calculate_alignment(flags, args->align, size);
 	size = ALIGN(size, align);
 
 	list_for_each_entry_reverse(s, &slab_caches, list) {
@@ -251,6 +255,30 @@ static struct kmem_cache *create_cache(const char *name,
 	return ERR_PTR(err);
 }
 
+static struct kmem_cache *
+__kmem_cache_alias(const char *name, unsigned int size, slab_flags_t flags,
+		   struct kmem_cache_args *args)
+{
+	struct kmem_cache *s;
+
+	s = find_mergeable(size, flags, name, args);
+	if (s) {
+		if (sysfs_slab_alias(s, name))
+			return NULL;
+
+		s->refcount++;
+
+		/*
+		 * Adjust the object sizes so that we clear
+		 * the complete object on kzalloc.
+		 */
+		s->object_size = max(s->object_size, size);
+		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
+	}
+
+	return s;
+}
+
 /**
  * __kmem_cache_create_args - Create a kmem cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -317,9 +345,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (!args->usersize)
-		s = __kmem_cache_alias(name, object_size, args->align, flags,
-				       args->ctor);
+	s = __kmem_cache_alias(name, object_size, flags, args);
 	if (s)
 		goto out_unlock;
 
@@ -1350,4 +1376,3 @@ EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
-
diff --git a/mm/slub.c b/mm/slub.c
index 68407f1177482..01a768143efc7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -333,11 +333,8 @@ enum track_item { TRACK_ALLOC, TRACK_FREE };
 
 #ifdef SLAB_SUPPORTS_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
-static int sysfs_slab_alias(struct kmem_cache *, const char *);
 #else
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
-static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
-							{ return 0; }
 #endif
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
@@ -6040,30 +6037,6 @@ void __init kmem_cache_init_late(void)
 #endif
 }
 
-struct kmem_cache *
-__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *))
-{
-	struct kmem_cache *s;
-
-	s = find_mergeable(size, align, flags, name, ctor);
-	if (s) {
-		if (sysfs_slab_alias(s, name))
-			return NULL;
-
-		s->refcount++;
-
-		/*
-		 * Adjust the object sizes so that we clear
-		 * the complete object on kzalloc.
-		 */
-		s->object_size = max(s->object_size, size);
-		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
-	}
-
-	return s;
-}
-
 int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 			 unsigned int size, struct kmem_cache_args *args,
 			 slab_flags_t flags)
@@ -7229,7 +7202,7 @@ struct saved_alias {
 
 static struct saved_alias *alias_list;
 
-static int sysfs_slab_alias(struct kmem_cache *s, const char *name)
+int sysfs_slab_alias(struct kmem_cache *s, const char *name)
 {
 	struct saved_alias *al;
 
-- 
2.53.0

