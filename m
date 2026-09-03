Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ADB4BAA12;
	Thu,  3 Sep 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445970; cv=none; b=d1gA7Gd2pi1cwkMVbkwKp5Z1o+VTmGUd0q93CEOdS+N8DuuVFY4xR05zCfS0S/Q6V+yRPPwkBtfFuDVP841qabvGv9LPqaCU0Nhuo+TpG+02Bz2mckPGy0CH7VhpF4jFzC0NbSHzRCjshGeGJFl5jB4Ffije/NQNap3TgqdFpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445970; c=relaxed/simple;
	bh=z09N1ErYZ7i9jcGioZjvMG2NoFquC+Afw8lh+lAHrlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r4s3wLGLDf9HlpvDh7Q+rLb/al0jg9QT33c8d8ReOMFydes2a7BnE8ERcXoUS2XdRO6babuXZKabR123B5oucF+VxAB4xSFAdybXP/1doPMkoAmpIOl5Oin4fqFR5vVYk0lc/gIdw7DXFEEGBgqEBe3+7lt4xeOrdfiKdseQa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGIIX70d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGIIX70d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AC81F00A3A;
	Thu,  3 Sep 2026 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788445961;
	bh=PdgEsXurPZK89WvQIyjXxZ95EwgJUTCrcbPCaco3wJ4=;
	h=From:Date:Subject:To:Cc;
	b=aGIIX70dSJhwGxEftvQp860ilXanbZ9XdDadPziZloXejX7omdRF+k1bi9BUvtbWq
	 0c02KJrV96Z087pnPJ3D7CLQP8fUuLdYR4hNZ3RqooHYLOTNo2KJjjpm0PlXD1akUv
	 f1MAn6PUGMi20CM5/q2kVA6lDBpzcM3ewJ4WmQzgUf4k1cNBc1FJTaD9SOfhf4AEKh
	 lW8AYWpEq3YU7ZiN2/fCyKWCHk1FZ98huuPHIbibAtFQkoQquExvZ/U0G+JMwL4ilv
	 aDISIKT9PeJF9LdDuhJFg3sXYqz2K+3ybdpOY6cKSK6g4t3Cn8wLJ3Fq6EOAfs2K5n
	 cjUjng5HPMB5Q==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Thu, 03 Sep 2026 15:32:26 +0100
Subject: [PATCH v3] mm/slab: take n->list_lock in
 __slab_try_return_freelist() to avoid race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-slab-fix-aba-v3-1-b44cb6badd54@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPmEmWoC/22Nuw6CMBSGX8Wc2WPagmidWIyLg7thKO0BGhsgL
 WkkhHe3MDt+/3WBQN5SgNthAU/RBjv0CbLjAXSn+pbQmsQgmCiYZAKDUzU29ouqVmgK1mSy0dI
 QQaqMnpK1z72rxJ0N0+DnfT3yTQU1vhTqx1PPk2QO72XMa3KwpaPYE/+vokCOhpMmflbXnF/KD
 /me3GnwLVTruv4AEPjmJ8sAAAA=
X-Change-ID: 20260902-slab-fix-aba-d60f39fc9dee
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Hyunwoo Kim <imv4bel@gmail.com>, stable@vger.kernel.org, 
 "Harry Yoo (Meta)" <harry@kernel.org>
X-Mailer: b4 0.15.2

Commit ba7425312607 ("mm, slab: add an optimistic
__slab_try_return_freelist()") incorrectly assumed that nobody has freed
an object to the slab as long as slab->freelist is NULL and cmpxchg
succeeds.

However, as reported by Hyunwoo Kim [1], other CPUs might have freed
an object to the slab, insert the slab to the partial list, then
allocated an object from the slab, and be in the middle of removing
the slab from the list under n->list_lock.

Since __refill_objects_node() puts the slab back on pc.slabs
outside n->list_lock, it might insert the slab into that list while
the slab is concurrently being removed from n->partial.
This led to a list corruption [1]:

  list_add corruption. next->prev should be prev
  (ffff888100000248), but was dead000000000122.
  (next=ffffea000416e410).
  kernel BUG at lib/list_debug.c:29!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 1 UID: 65534 PID: 144 Comm: poc Not tainted
  7.2.0-16172-gcf72cbb39da8-dirty #1 PREEMPT(lazy)
  RIP: 0010:__list_add_valid_or_report+0x80/0xd0
  ...
  Call Trace:
   alloc_from_new_slab+0x183/0x300
   ___slab_alloc+0x31c/0x890
   __kmalloc_noprof+0x3d4/0x800
   lsm_blob_alloc+0x2d/0x50
   security_msg_msg_alloc+0x26/0x90
   load_msg+0x1aa/0x210
   do_msgsnd+0x91/0x800
   do_syscall_64+0x109/0x5d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  ...
  Kernel panic - not syncing: Fatal exception

This is a classic ABA problem where cmpxchg succeeds but the state has
changed since __refill_objects_node() took the freelist from the slab.

As Vlastimil Babka mentioned [2], it should be rare to return more than
one slab (due to the racy read of slab->counters in
get_partial_node_bulk()). Therefore, instead of introducing additional
complexity, acquire and release n->list_lock twice in the worst case.

Return the slab directly to the partial list and hold n->list_lock
across the cmpxchg and add_partial(). This is similar to the initial
version of commit ba7425312607 [3]. This is enough to avoid the race as
the list manipulation is serialized by n->list_lock. While at it,
bring back unlikely() hint now that the condition is unlikely.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/linux-mm/apPa-cGLcyt90l-E@v4bel [1]
Link: https://lore.kernel.org/linux-mm/ae25c193-b95f-40c1-83b6-1c2546467e41@kernel.org [2]
Link: https://lore.kernel.org/all/20260421-b4-refill-optimistic-return-v1-1-24f0bfc1acff@kernel.org [3]
Fixes: ba7425312607 ("mm, slab: add an optimistic __slab_try_return_freelist()")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
Changes in v3:
- Don't repeat "As reported by Hyunwoo Kim" in changelog (Vlastimil)
- Pass kmem_cache_node pointer directly to __slab_try_return_freelist() (Vlastimil)
- Link to v2: https://lore.kernel.org/r/20260902-slab-fix-aba-v2-1-d1ece15a8417@kernel.org

Changes in v2:
- Simplify the code to hold n->list_lock across cmpxchg + add_partial()
  and acquire the lock twice in the rare worst case.
- Link to v1: https://lore.kernel.org/r/apPa-cGLcyt90l-E@v4bel
---
 mm/slub.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f9b56cb439e7..eac95b8f94c3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5680,10 +5680,12 @@ static noinline void free_to_partial_list(
  *
  * Fail if the slab isn't full anymore due to a concurrent free.
  */
-static bool __slab_try_return_freelist(struct kmem_cache *s, struct slab *slab,
-				       void *head, int cnt)
+static bool __slab_try_return_freelist(struct kmem_cache *s,
+				       struct kmem_cache_node *n,
+				       struct slab *slab, void *head, int cnt)
 {
 	struct freelist_counters old, new;
+	unsigned long flags;
 
 	old.freelist = slab->freelist;
 	old.counters = slab->counters;
@@ -5695,9 +5697,15 @@ static bool __slab_try_return_freelist(struct kmem_cache *s, struct slab *slab,
 	new.counters = old.counters;
 	new.inuse -= cnt;
 
-	if (!slab_update_freelist(s, slab, &old, &new, "__slab_try_return_freelist"))
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	if (!slab_update_freelist(s, slab, &old, &new, "__slab_try_return_freelist")) {
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		return false;
+	}
 
+	add_partial(n, slab, ADD_TO_TAIL);
+	spin_unlock_irqrestore(&n->list_lock, flags);
 	return true;
 }
 
@@ -7296,10 +7304,8 @@ __refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int mi
 			void *head = object;
 			void *tail;
 
-			if (__slab_try_return_freelist(s, slab, head, count)) {
-				list_add(&slab->slab_list, &pc.slabs);
+			if (__slab_try_return_freelist(s, n, slab, head, count))
 				break;
-			}
 
 			do {
 				tail = object;
@@ -7312,7 +7318,7 @@ __refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int mi
 			break;
 	}
 
-	if (!list_empty(&pc.slabs)) {
+	if (unlikely(!list_empty(&pc.slabs))) {
 		spin_lock_irqsave(&n->list_lock, flags);
 
 		list_for_each_entry(slab, &pc.slabs, slab_list)

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260902-slab-fix-aba-d60f39fc9dee

Best regards,
--  
Cheers,
Harry / Hyeonggon

