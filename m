Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECE1B4F0A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702121; cv=none; b=sGbkRvdRBPWlj2V8PBfN5YTpEDln3gkMRXngRozfagN1ispxbP3TrBHOywvbKsbDueTL+WthejO1dhAdtP7XufIQiDhwoeLyXPeMyZGXw29YoeKXBej3MxwKYutoZPV7wOcivx+PPuman1tqPJggZSjNoLKZHEGSbyzaF9s6IK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702121; c=relaxed/simple;
	bh=dMbXGNnxAke9RsfIOYoHkkphJMmX35xyGNdglwf7ZDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbcWcvWw5Y31E4YJThELs/2ZzvNpFwec6eqmYZpQMIBczFMRLUh4I1QxF/E9BZWMpFzUd7lupTEKeOqbLxsq3KIKz4QEAGsrOQ4u2LfobnmtsbajldUxoBDpuqx/LTL6HXt8KhyMuC+NlGvnPz1oIv5yDh/XIWGaTDc037QlhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARRo0MA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARRo0MA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7332D1F000FF;
	Tue, 29 Sep 2026 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790702119;
	bh=fTztzykW7y1/OoSat6K6kBgb18Mnst91Jsk41H0bROc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARRo0MA3drHhI+958RqRy1oB1Lqk0hBOduiT2sjbBU0mrYFP9im76YNLIqt6/DEFo
	 fw7U1CWMleFlpEim3hjvJ4/pTkwOODqVWdqeIp9ALXzkL4KrRVHy5Zv5B5Fuy39Ugn
	 wE4G1QzASdkQJL9GZPjyrFMoBckqcCPRnbWFUiVU7ehsl6ett8QScvMYPcW5Cl3LsQ
	 NyWkSycXtx+C2vKamREI/nhq7SwZF+c6RSUdxAxifiCZ0cY+rl1YleIvHAf7EHYP51
	 jbvU/Cw3UGpi53cD78ko5prNYQOTBREeTZeIAO/YDJ8Gql/tC7rG3bRuhlWRTLsUbY
	 /9OZtTDrvkjwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Chris Li <chriscli@google.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Jann Horn <jannh@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mm/rmap: allocate anon_vma_chain objects unlocked when possible
Date: Tue, 29 Sep 2026 13:15:14 -0400
Message-ID: <20260929171515.227695-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092945-shale-evident-4fec@gregkh>
References: <2026092945-shale-evident-4fec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit bfc2b13b05a1343bb60a85d840fd8956731866c5 ]

There is no reason to allocate the anon_vma_chain under the anon_vma write
lock when cloning - we can in fact assign these to the destination VMA
safely as we hold the exclusive mmap lock and therefore preclude anybody
else accessing these fields.

We only need take the anon_vma write lock when we link rbtree edges from
the anon_vma to the newly established AVCs.

This also allows us to eliminate the weird GFP_NOWAIT, GFP_KERNEL dance
introduced in commit dd34739c03f2 ("mm: avoid anon_vma_chain allocation
under anon_vma lock"), further simplifying this logic.

This should reduce lock anon_vma contention, and clarifies exactly where
the anon_vma lock is required.

We cannot adjust __anon_vma_prepare() in the same way as this is only
protected by VMA read lock, so we have to perform the allocation here
under the anon_vma write lock and page_table_lock (to protect against
racing threads), and we wish to retain the lock ordering.

With this change we can simplify cleanup_partial_anon_vmas() even further
- since we allocate AVC's without any lock taken and do not insert
anything into the interval tree until after the allocations are tried, we
can remove all logic pertaining to this and just free up AVC's only.

Link: https://lkml.kernel.org/r/624bf1ac0bde4871fcfca2c8c8e294b6d8f7ae7b.1768746221.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chriscli@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[Stable dependency adaptation for 6.18:
Keep the split of anon_vma_chain_link() into anon_vma_chain_assign() and
explicit interval-tree insertion at all three callers. Retain the fork
change that assigns the chain before taking the anon_vma write lock;
the interval-tree insertion remains protected by that lock.

Drop the two-pass clone allocation and cleanup_partial_anon_vmas() changes.
This tree lacks the prerequisite clone assertions, early unfaulted-VMA
handling, simplified root locking, and partial-clone cleanup. Preserve the
existing GFP_NOWAIT/GFP_KERNEL fallback, root locking, list traversal,
reference accounting, and allocation-failure cleanup instead. No new
functions are introduced.

The helper split supplies the context needed for b6ac0b3f6013 ("mm/rmap:
fix missing barrier between anon_vma init and vma->anon_vma publish") to
merge cleanly while retaining this tree's interval-tree API. The memory
barrier fix itself is left to that target commit.]

Stable-dep-of: b6ac0b3f6013 ("mm/rmap: fix missing barrier between anon_vma init and vma->anon_vma publish")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 29f93ecf34800..4c4496a619712 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -146,14 +146,13 @@ static void anon_vma_chain_free(struct anon_vma_chain *anon_vma_chain)
 	kmem_cache_free(anon_vma_chain_cachep, anon_vma_chain);
 }
 
-static void anon_vma_chain_link(struct vm_area_struct *vma,
-				struct anon_vma_chain *avc,
-				struct anon_vma *anon_vma)
+static void anon_vma_chain_assign(struct vm_area_struct *vma,
+				  struct anon_vma_chain *avc,
+				  struct anon_vma *anon_vma)
 {
 	avc->vma = vma;
 	avc->anon_vma = anon_vma;
 	list_add(&avc->same_vma, &vma->anon_vma_chain);
-	anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);
 }
 
 /**
@@ -210,7 +209,8 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	spin_lock(&mm->page_table_lock);
 	if (likely(!vma->anon_vma)) {
 		vma->anon_vma = anon_vma;
-		anon_vma_chain_link(vma, avc, anon_vma);
+		anon_vma_chain_assign(vma, avc, anon_vma);
+		anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);
 		anon_vma->num_active_vmas++;
 		allocated = NULL;
 		avc = NULL;
@@ -294,7 +294,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 		}
 		anon_vma = pavc->anon_vma;
 		root = lock_anon_vma_root(root, anon_vma);
-		anon_vma_chain_link(dst, avc, anon_vma);
+		anon_vma_chain_assign(dst, avc, anon_vma);
+		anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);
 
 		/*
 		 * Reuse existing anon_vma if it has no vma and only one
@@ -378,8 +379,10 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	get_anon_vma(anon_vma->root);
 	/* Mark this anon_vma as the one where our new (COWed) pages go. */
 	vma->anon_vma = anon_vma;
+	anon_vma_chain_assign(vma, avc, anon_vma);
+	/* Now let rmap see it. */
 	anon_vma_lock_write(anon_vma);
-	anon_vma_chain_link(vma, avc, anon_vma);
+	anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);
 	anon_vma->parent->num_children++;
 	anon_vma_unlock_write(anon_vma);
 
-- 
2.53.0

