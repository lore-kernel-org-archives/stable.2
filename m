Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427336A017;
	Wed, 14 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990599; cv=none; b=qk9nX1Xn7JlxOCSMfkm6QP1bnO3/CnNxYpmWBnL95QD4WhGivHdimDU+k04kfQCIBXHKQSCtnPW3tTOt7vdB/1ATN1vNJkk7oyf0lhzhDssKDY1N6fwMHXSGQkD/nMSm3zHh7WRFIV9Rp1YIGjPKDmEi+yVVyMfeUqI5MllKwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990599; c=relaxed/simple;
	bh=bRSl6QCUOlMwTnQp0Nc2ghUbsfhKxW9lVhgrHK5DE5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF47JPpyXumb+vFMx9u826O3OUiQL+1X7WRgn42/QIExMbnLM50/KmkFU76fpJDGCxbac8yR8kWVa5luu8qDQTzLslIbsR8ky1Bs721aJWhx+cYhbTbrN5DBCGEu2VfH9bk/XpVgil7pmuXwmBP1RkXIaSWkpftkvj30yZviLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lROYBOm5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lROYBOm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA111F000C4;
	Wed, 14 Oct 2026 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990591;
	bh=nPHLR9bYg/QZflrtwH8ufJo1Nfz90UGK6o7IybcntJo=;
	h=From:To:Cc:Subject:Date;
	b=lROYBOm5BZAj+QLmXazpo/oVVQ0JUIoyqxflq4V00f1yZWLjcQtuRfOnug+NohuHe
	 kmK3BDbqB7VH4LOQiZXRZrt+s/5g6OlqD0ezNLDZrz2CSDonBPaW4t06tK375GvDC8
	 3X4Z+ajqmhREtHjDjyR6PwGbPUw7iFKxnGMeI58SYGFTMR72k4WBcuow3OnWDPFwjp
	 1rN7w0XzCmcpTxRMfODsIy7lqLFcG3muqNOBU2Tk/S+1v837KrgK/VBsLlo3eH0XKs
	 GIy8SjnQQMZIcQslNKqY53L7gmNtTkWrNMji9xoA42eKPmAUQqdzvJxYC3dPOp+1qe
	 WpX6Pnhq9dOVA==
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
	stable@vger.kernel.org,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH v2] mm/slab: sample slab_state once in kmem_cache_destroy()
Date: Wed, 14 Oct 2026 17:08:43 +0200
Message-ID: <20261014150844.8536-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
has dropped slab_mutex and unlinked the cache, and for a
SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
before that test it sets slab_state to FULL but skips the unlinked cache,
which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
on a kobject that was never initialized:

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

The release-time test has run outside slab_mutex since at least v4.4 for
SLAB_TYPESAFE_BY_RCU caches, and since v6.0 for the others. Since v6.12
the unlink-time test in kmem_cache_destroy() is a separate read of its
own, also after mutex_unlock(), so the two can disagree. Both tests ask
whether the cache has a kobject, which cache creation skips while
slab_state <= UP. UP is the state just below FULL, so a false sample
cannot skip a kobject_put() that was owed.

Seen on sparc64 at boot, where the asynchronous floppy init tears down
its bio slab while the late initcalls are running.

Sample slab_state once, under slab_mutex which slab_late_init() holds
when it sets FULL, and use the result for both the unlink and the
release.

Fixes: d50d82faa0c9 ("slub: fix failure when we delete and create a slab cache")
Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
v2:
 - Changelog reworked around the release-time read outside slab_mutex,
   with the separate unlink-time test as the second read; Fixes:
   d50d82faa0c9 added, as discussed with Harry.
 - Correction to what I wrote in the v1 thread: the release-time read is
   older than d50d82faa0c9 (the RCU work function had it from v4.11
   until v6.12); d50d82faa0c9 added the unlink-time test under
   slab_mutex.
 - Added the explanation Jose asked for; his Reviewed-by from v1 is
   kept. The code is unchanged.

v1: https://lore.kernel.org/r/20260930195110.13296-1-kaloz@kernel.org

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
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

