Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058B4AA414
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439628; cv=none; b=lE2Ykfa7K/fCsT/xUCGQeAfokJ9kbxqy5VWdg9b8sTfM8THZ+ySf++lMxDq6bounqTNZKj1WJ4aZxg2vLNQJQh7zNdJsYM/hoKBgpG4+JEm6983Sgswv/AKRbWmRy6NEliI4u3MEDYf2MahczCn7Rz0O6Z8WnojJLvdQmI5GObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439628; c=relaxed/simple;
	bh=R9U1N/qdllnGViBOZkH8aaPeZ+YoCNbvjcRLf8AYfrk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mth/fmIVF5lKGoNrRAwWnS+haJGXwZVILoX6gKWXvFxH96njWsVF2irGdVe6882HoE6LwEcQ8W4EX0dLuR325WSjMB6rkPZKYtaspzIl+O48vhXNGkwQwb2WHsSSf9nNuLvQJuY7YSyQfET6NWrL1MDAWxrdMflHEyDhdlWOrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DhWpqhLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DhWpqhLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4581F000E9;
	Thu,  3 Sep 2026 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439626;
	bh=5J3IqEbUQ2FnfHXIqduRuXTZK76ya1aV6V4vwextVqw=;
	h=Subject:To:Cc:From:Date;
	b=DhWpqhLnAO3GvLkpto82sB26pKHrMSkDE36tX2JeX2D+3m9ngqTcTiSz4iff6dsE8
	 SNVjF3KHvu0lLHcFNgruuff3JXWdBzW+LuI0LI06mR3/zyH1Pn+FUhGJFDlhBCOFGg
	 aRJNST96yGInHgbar8SF1WH596MgHffWmDK82fYY=
Subject: FAILED: patch "[PATCH] mm: mempolicy: fix automatic numa balancing for shmem" failed to apply to 6.1-stable tree
To: hannes@cmpxchg.org,akpm@linux-foundation.org,apopple@nvidia.com,balbirs@nvidia.com,byungchul@sk.com,david@kernel.org,gourry@gourry.net,joshua.hahnjy@gmail.com,matthew.brost@intel.com,nehagholkar@gmail.com,rakie.kim@sk.com,stable@vger.kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:51:24 +0200
Message-ID: <2026090324-eggnog-aqua-d0d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d230991493b521eeff39f32434fddcbcdb109eb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090324-eggnog-aqua-d0d4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d230991493b521eeff39f32434fddcbcdb109eb0 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 29 Jun 2026 12:33:37 -0400
Subject: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem

Neha reports that mapped shmem aren't considered for NUMA balancing,
noting convergence problems and bandwidth bottlenecking for cachelib based
workloads on tiered memory systems.

Looking at the code and going through the git history, this doesn't
actually seem intentional:

Commit fc3147245d19 ("mm: numa: Limit NUMA scanning to migrate-on-fault
VMAs") added a vma_policy_mof() gate to task_numa_work() so VMAs whose
policy lacks MPOL_F_MOF are skipped from NUMA balancing scans.  The
motivation was a real usecase: Oracle was pinning shared segments with
mbind(MPOL_BIND) so trapping faults was both expensive and pointless.

The handling of NULL from vm_ops->get_policy, however, treated "user
explicitly opted out" the same as "user never specified anything." For
VMAs whose shared policy is absent - the common case for shmem - the scan
was disabled too.

This issue is old.  It probably hurts less in conventional NUMA.  But it's
very noticeable on tiered systems, where entire tmpfs workingsets can get
stuck on lower-bandwidth memory.

Fix this by having vma_policy_mof() use __get_vma_policy() directly, and
thereby handle the fallback to task policy (-> preferred_node_policy() has
MPOL_F_MOF per default).  Every other consumer of vm_ops->get_policy
already handles it this way, the scan-eligibility check was the outlier.

This preserves Mel's intended fix: don't scan stuff the user explicitly
pinned.  But allow default policy vmas to participate in balancing.

Link: https://lore.kernel.org/20260629163337.1264881-1-hannes@cmpxchg.org
Fixes: fc3147245d19 ("mm: numa: Limit NUMA scanning to migrate-on-fault VMAs")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Neha Gholkar <nehagholkar@gmail.com>
Tested-by: Neha Gholkar <nehagholkar@gmail.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 501e0b80d7da..5720f7f54d94 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2060,24 +2060,15 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 bool vma_policy_mof(struct vm_area_struct *vma)
 {
 	struct mempolicy *pol;
+	pgoff_t ilx;
+	bool mof;
 
-	if (vma->vm_ops && vma->vm_ops->get_policy) {
-		bool ret = false;
-		pgoff_t ilx;		/* ignored here */
-
-		pol = vma->vm_ops->get_policy(vma, vma->vm_start, &ilx);
-		if (pol && (pol->flags & MPOL_F_MOF))
-			ret = true;
-		mpol_cond_put(pol);
-
-		return ret;
-	}
-
-	pol = vma->vm_policy;
+	pol = __get_vma_policy(vma, vma->vm_start, &ilx);
 	if (!pol)
 		pol = get_task_policy(current);
-
-	return pol->flags & MPOL_F_MOF;
+	mof = pol->flags & MPOL_F_MOF;
+	mpol_cond_put(pol);
+	return mof;
 }
 
 bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)

