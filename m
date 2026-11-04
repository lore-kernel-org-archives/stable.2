Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801933;
	b=Jai1vMk8pDHshEr/1tf3FVjxoFKUN916i02M1T3zyAE6gGcBMB8cVX/ZJtju7/yuLpN+
	 XTzkeROllJHi0RCRrDpsh0TAV6wUVryi3A8D9q9Y1xNNkkxnQhPOWJA7qv1ADGfUXxf5n
	 T4cdqvAzcD/baxFoW1Xm18UqA2RQn/xCQdSLqPVZtBrENggkDmwxWrOAvNxc7LZ7gA+11
	 dMubKWr4k9Nu3ddjF6Qg+wxNgqt3ySETON/9vwAfUOjhnwPKUzq+41RuBvHB9EBP8Z1lT
	 63CidMB9HkqwLAW/vCgjmop/FrvBDWbXSmB564BNBrvkxXbg23dkuQ4aBQAvAUx3vxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801933;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xtmLaj5+ks0lcYh8eZbA17IzH5OULkUWHegvWHSBEw4=;
	b=18Xdda2t0ofjIwvK78TudpYEeMIkC8hlAu76wxNLBULEYJIFHEhiQsqi7tPLwxx8roxa
	 uOWATWQ8rI081bodOutgubqWT10iM2kUoIYbQ/8eX984FkQ72+g3WVUyDyDwUWLATb+sR
	 AXD8NkqttpzAinhSmNcR0BhM3nu/8nkiUu5bQjcxPYvo3uU2Gijz+ubLXTVj1L4TJzZIC
	 O+F3wOlXk6s7p+QOun5a7YIHOaqp2tZhsJl9S2b8ESoNH0FGnn8qUmsxbRCEARbRVWLT5
	 D578r88g/15alzlLsBIZXs6scuEOj/TgWhr15y23pq/YND67W20Ge+Zckx7zSb23oOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uXWEpt6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE83606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uXWEpt6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE4D1F000C1;
	Wed,  4 Nov 2026 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801932;
	bh=xtmLaj5+ks0lcYh8eZbA17IzH5OULkUWHegvWHSBEw4=;
	h=Subject:To:Cc:From:Date;
	b=uXWEpt6sFsqXWH4Hf1oOdiNb6EGgXiDvpZkmdGnLDor49FRoE7jCEpiXEIRvn/+z1
	 v/c2pyVWa+VlvIpnTY/PwFC7Rq6vqgJ5Pqo3hpqVtIGtIIB4Sw5Qf1lgF00vkEJgyw
	 Gzil3pYEzbWyPqv/XX39lVcKOYt+vbVru9v8iFbw=
Subject: FAILED: patch "[PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()" failed to apply to 6.6-stable tree
To: kaloz@kernel.org,azpijr@gmail.com,harry@kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:18:50 +0100
Message-ID: <2026110450-golf-tricolor-c37d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 088bfdc0d7947d623f4899b9011c866e4445074d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110450-golf-tricolor-c37d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 088bfdc0d7947d623f4899b9011c866e4445074d Mon Sep 17 00:00:00 2001
From: Imre Kaloz <kaloz@kernel.org>
Date: Wed, 14 Oct 2026 17:08:43 +0200
Subject: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()

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

slab_state >= FULL asks whether the cache has a kobject, which cache
creation skips while slab_state <= UP. UP is the state just below FULL,
so a false sample cannot skip a kobject_put() that was owed.

Seen on sparc64 at boot, where the asynchronous floppy init tears down
its bio slab while the late initcalls are running.

Sample slab_state once, under slab_mutex which slab_late_init() holds
when it sets FULL, and use the result for both the unlink and the
release.

The history of this problem dates back to v3.2:

  Commit 69cb8e6b7c29 ("slub: free slabs without holding locks") in
  v3.2 moved sysfs_slab_remove() outside slub_lock and introduced
  a race condition between kmem_cache_destroy() and slab_sysfs_init().

  Commit 945cf2b6199be ("mm/sl[aou]b: Extract a common function for
  kmem_cache_destroy") in v3.7 accidentally closed the race while
  extracting a common implementation for kmem_cache_destroy().

  Commit 5413dfba88d6 ("slub: drop mutex before deleting sysfs entry")
  in v3.8 re-opened the race by dropping slab_mutex around
  sysfs_slab_remove() in __kmem_cache_shutdown(), to avoid a lockdep
  splat between slab_mutex and the sysfs lock.

  Commit 657dc2f97220 ("slab: remove synchronous rcu_barrier() call in
  memcg cache release path") in v4.11 shifted from synchronous
  rcu_barrier() to asynchronous RCU work for SLAB_TYPESAFE_BY_RCU caches.
  That commit, again, accidentally closed the race by moving
  sysfs_slab_release() to shutdown_cache(), but only for
  !SLAB_TYPESAFE_BY_RCU caches because destruction of
  SLAB_TYPESAFE_BY_RCU caches is done in an RCU work.

  Commit 0495e337b703 ("mm/slab_common: Deleting kobject in
  kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock") in
  v6.0 re-introduced the race for !SLAB_TYPESAFE_BY_RCU caches.

Fixes: 69cb8e6b7c29 ("slub: free slabs without holding locks")
Fixes: 5413dfba88d6 ("slub: drop mutex before deleting sysfs entry")
Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Link: https://patch.msgid.link/20261014150844.8536-1-kaloz@kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 980ca4cb6c43..e66c0778ee98 100644
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
 

