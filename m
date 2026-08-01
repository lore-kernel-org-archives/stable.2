Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9138D;
	Sat,  1 Aug 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785587143; cv=none; b=Ck4Ceom9z8DO7gk8BdO0KJr47kLa9m5XXWNG3lEEjaWEEe57INdUI9iWkwqbmOgnpezWT9e+uYpH4z5JmdUNad2HMZDzKQv7qBh6jOs1wiIOUsKfxEJNr2aQxWakPH9hieB1ILr+QeYEyqCTG1My4Klv+NYQb+deqOMcM7LSxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785587143; c=relaxed/simple;
	bh=4gG5xB2QZ5YE8hLuOHmyuKaQd3LO5mKZnrgRUZNxWJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGJabZwZxQEPTjUaLbYEybMknWpCgKC/kbyfzr87wIUs4znHZwyEk1jbrhyIGojzFjLEdkH7h2XI6as4zaQotGW3DpR8uDZOc10rFbGvWakpPCHa5W7NMloYdN/p0J9cPWy4qHy9JGPxKZlrtkkCfo++GdyM7YHJZcv5dsNKeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgBVE3Gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgBVE3Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63901F00ACF;
	Sat,  1 Aug 2026 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785587142;
	bh=fR5GQklAEmMIRAxF5ZINhcf10poKg1/4k56TIs+euS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XgBVE3GbYz9QXwCf2ZRYlPhwPyUGUCO6C6tk9Pc2sQnSY35UCRgBrOJw4nNPSBjJe
	 7mKzbtf9C50CiWxQ+T6Ch+6bbkQUy64hdggkkV1/GPNmT9VegCkXhWu1RnPPl9AOGh
	 JwTWoJKtKGgQsh7iwJKb/A3T4FRUr1gvYiQOPe9eRlvISnD38j5w7BZiUyc/asvyxk
	 jwMlqIeV556EQIBILYc4nBH6N7PoML3cOtJeTYYA7nkEEsj9pMA66ZY92+kc9ncQl0
	 h8DQx1B9KOEObFLTFXfe/gYKYXAoodT2LqnpKvKNsVcWzClr7BOtVsn0dTipceSeuQ
	 rGy2YU4jTfIDQ==
From: Harry Yoo <harry@kernel.org>
To: Danielle Costantino <dcostantino@meta.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [7.1.y 1/3] mm/slab: decouple SLAB_NO_SHEAVES from SLAB_NO_OBJ_EXT
Date: Sat,  1 Aug 2026 12:25:31 +0000
Message-ID: <20260801122533.319272-2-harry@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801122533.319272-1-harry@kernel.org>
References: <20260801122533.319272-1-harry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Harry Yoo (Oracle)" <harry@kernel.org>

commit 982e31382d9a1a3c8c4e6a13702a53711f4efe9f upstream.

Bootstrap caches are created with SLAB_NO_OBJ_EXT to disallow sheaves
and obj_exts.

To allow disabling obj_exts while allowing sheaves, decouple
SLAB_NO_SHEAVES from SLAB_NO_OBJ_EXT. Bootstrap caches now have both
SLAB_NO_SHEAVES and SLAB_NO_OBJ_EXT.

No functional change intended.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Link: https://patch.msgid.link/20260713-kmalloc-no-objext-v3-2-47c7bd138de7@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo <harry@kernel.org>
---
 include/linux/slab.h | 13 +++++++++++--
 mm/slub.c            | 10 ++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1a69255bb87f..fda7e24a762b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -58,10 +58,13 @@ enum _slab_flag_bits {
 #endif
 	_SLAB_OBJECT_POISON,
 	_SLAB_CMPXCHG_DOUBLE,
+#ifdef CONFIG_SLAB_OBJ_EXT
 	_SLAB_NO_OBJ_EXT,
-#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+#ifdef CONFIG_64BIT
 	_SLAB_OBJ_EXT_IN_OBJ,
 #endif
+#endif
+	_SLAB_NO_SHEAVES,
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -239,8 +242,14 @@ enum _slab_flag_bits {
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
-/* Slab created using create_boot_cache */
+/* Slab caches without obj_exts array */
+#ifdef CONFIG_SLAB_OBJ_EXT
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_BIT(_SLAB_NO_OBJ_EXT)
+#else
+#define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
+#endif
+
+#define SLAB_NO_SHEAVES		__SLAB_FLAG_BIT(_SLAB_NO_SHEAVES)
 
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 #define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
diff --git a/mm/slub.c b/mm/slub.c
index fa24b985a783..33e64f21ecc1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7726,12 +7726,12 @@ static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
 		return 0;
 
 	/*
-	 * Bootstrap caches can't have sheaves for now (SLAB_NO_OBJ_EXT).
+	 * Bootstrap caches can't have sheaves for now (SLAB_NO_SHEAVES).
 	 * SLAB_NOLEAKTRACE caches (e.g., kmemleak's object_cache) must not
 	 * have sheaves to avoid recursion when sheaf allocation triggers
 	 * kmemleak tracking.
 	 */
-	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
+	if (s->flags & (SLAB_NO_SHEAVES | SLAB_NOLEAKTRACE))
 		return 0;
 
 	/*
@@ -8513,7 +8513,8 @@ void __init kmem_cache_init(void)
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
 			sizeof(struct kmem_cache_node),
-			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_SHEAVES | SLAB_NO_OBJ_EXT,
+			0, 0);
 
 	hotplug_node_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -8523,7 +8524,8 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, per_node) +
 				nr_node_ids * sizeof(struct kmem_cache_per_node_ptrs),
-			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_SHEAVES | SLAB_NO_OBJ_EXT,
+			0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.53.0

