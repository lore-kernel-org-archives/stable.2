Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D23CAA55;
	Wed, 30 Sep 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797940; cv=none; b=YzrREASLYi2zsFcOHSts/gtlcnv8rwSjKhet+f5tvAidxEBR+9xJuCnlqwNuFw5RUEz0xI/1tPrcc+3924cVEvqP3LW27XHx+I2HBxTFg1Sf0MsZQMGM7gRbsbT0gXURjWJmmyEyYPBoNizYWxXLKmdWQAKkmY4aXCTC5+zODXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797940; c=relaxed/simple;
	bh=6jM1fhDx+QCBgdgXkDAEb3JdmHyfT2T3H+K6k8smOJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpb9Wios9g8S3yOB3+AEOsZVFBnseNxZYgzmLBzQkZS51EQCyoVhU02ubavptXNi8PnSeSJss9TGkucLjs8MrQox0jjHft+fXFQXquOQLsjrVtbxCOHzmep2X2w0YmLDF39+VDiu5crBj363JaKqFgS/mI8bssqOwU8Qb8k5qvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxHcC5Wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxHcC5Wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E7A1F00898;
	Wed, 30 Sep 2026 19:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797935;
	bh=YWrKUyDQfGPBFB++iIVHEuhs9Rh+LXrjwZ4LQ5+swnM=;
	h=From:To:Cc:Subject:Date;
	b=CxHcC5WtExILPkw1rNFX+85Dp0tqI5hLryNGXGobIt651WEBvh++61jlHJacRjW4z
	 OzwWXinJxpRZLc9sTLIvQyhk/jcfGmpaduajvRhmtKWTPd4kKY/e66JjwL4cC95ckA
	 r8gNP2z8EMJT0yIcCRofVEcdbJSOLjpxK30s1Yju7OBenQoIvRnI4lE5gESFI5XXxh
	 /aClYn4/8X49KyTAPqDiCOBbMmT3kNEqVLJDSuWr0kfSup/SzZ3qDAwKf1Mv16BiOn
	 xD8y/aATxfsFyGTgyT/q0VVBvunyytRDx4e/NHET6PT3+O5gnjn7uvWgZvXzeiQga+
	 V7hYcqoV6fAUA==
From: Imre Kaloz <kaloz@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()
Date: Wed, 30 Sep 2026 21:51:09 +0200
Message-ID: <20260930195110.13296-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmem_cache_destroy() tests slab_state >= FULL for sysfs_slab_unlink()
and again in kmem_cache_release() for sysfs_slab_release(), with the
cache already off slab_caches in between. If slab_late_init() runs in
that gap it sets slab_state to FULL but never calls sysfs_slab_add() for
the unlinked cache, so kmem_cache_release() ends up in kobject_put() on
a kobject that was never initialized:

  WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
  kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
  refcount_t: underflow; use-after-free.
  kobject_put+0x64/0x2c0
  sysfs_slab_release+0xc/0x20
  kmem_cache_destroy+0x104/0x1e0
  bioset_exit+0x13c/0x1e0
  disk_release+0x54/0x140
  put_disk+0x18/0x40
  floppy_async_init+0xbec/0xd10

Seen on sparc64 at boot, where the asynchronous floppy init tears down
its bio slab while the late initcalls are running.

Read slab_state once, under slab_mutex which slab_late_init() holds when
it sets FULL, and use the result for both the unlink and the release.
The kobject flags (state_initialized, state_in_sysfs) were considered as
the key instead, but slab_state is what cache creation and
slab_late_init() decide on.

debugfs_slab_release() is not part of the race: it only looks the cache
up by name in the debugfs root and does nothing before that root exists.

Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 mm/slab_common.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7223a7596dab..de11edfd1a0b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -515,10 +515,10 @@ EXPORT_SYMBOL(kmem_buckets_create);
  * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
  * protection. So they are now done without holding those locks.
  */
-static void kmem_cache_release(struct kmem_cache *s)
+static void kmem_cache_release(struct kmem_cache *s, bool sysfs_ready)
 {
 	kfence_shutdown_cache(s);
-	if (__is_defined(SLAB_SUPPORTS_SYSFS) && slab_state >= FULL)
+	if (__is_defined(SLAB_SUPPORTS_SYSFS) && sysfs_ready)
 		sysfs_slab_release(s);
 	else
 		slab_kmem_cache_release(s);
@@ -533,6 +533,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
+	bool sysfs_ready;
 	int err;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
@@ -580,10 +581,18 @@ void kmem_cache_destroy(struct kmem_cache *s)
 
 	list_del(&s->list);
 
+	/*
+	 * slab_late_init() sets slab_state to FULL under slab_mutex and adds
+	 * sysfs entries only for caches still on the list. Sample the state
+	 * here, so that a cache unlinked before that point is not handed to
+	 * sysfs_slab_release() with an uninitialized kobject.
+	 */
+	sysfs_ready = slab_state >= FULL;
+
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
 
-	if (slab_state >= FULL)
+	if (sysfs_ready)
 		sysfs_slab_unlink(s);
 	debugfs_slab_release(s);
 
@@ -593,7 +602,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (s->flags & SLAB_TYPESAFE_BY_RCU)
 		rcu_barrier();
 
-	kmem_cache_release(s);
+	kmem_cache_release(s, sysfs_ready);
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.47.3

