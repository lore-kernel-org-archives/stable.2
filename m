Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FC4A92DB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439495; cv=none; b=fvq0/pX8tIkOkiNHomV7pbuU7IdA+A7c2vADOF1kL5HbpqG7cmusNVQYDeDBpdQBzs8xAVWYk87gwm3rP196astNEvTMNrAyBFs+cjXXMruhDpTsE6xiqH1sl1nHp6c6U/S0oLvq+NYyX4+1iz8jLAQoDmpRLmSOkgE1t0bBJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439495; c=relaxed/simple;
	bh=AWnJ83haEWWQ2cXw/QL8YGNmrwMs/+OzHNi94hsetxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lVr2K78BWurI6zbD6XT2RdC3evfvuol1jbEZIRhWuxmu3OSyAxPT3iaYRQPwK/9GtuMlMW+nYTcbVRkHCVchj3yXMStdbb9mfKYm/OL/x3rSPr4KI6596MJQY7HKgyTv+uuEbLog8kiEToqAYbE8OzZuxo/oZHKxPc+8NyB47/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Krja3bXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Krja3bXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AA01F00A3F;
	Thu,  3 Sep 2026 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439494;
	bh=PRiDsGkGbMXNB6y7dGInWmQwFuKw6gz2aL72IY2DSl4=;
	h=Subject:To:Cc:From:Date;
	b=Krja3bXOrjW/9zDJqFKsfOzYncP4fTluBVpphwRcmRtk2FWPEMGwJPlBPePzLtD6b
	 aqVrkDYF5ZqcXdpcJ5JQBDoX8r/IEBHhbEvFka5AP9ptq8USfCdnsKIyUGDfaVoN4L
	 U/iXybAI5Wl5ZTcV2YAtOui23GqAMuaIpBCJikao=
Subject: FAILED: patch "[PATCH] mm/huge_memory: use folio's memcg inside __folio_split()" failed to apply to 6.6-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@kernel.org,dev.jain@arm.com,hannes@cmpxchg.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,william.kucharski@oracle.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:46:57 +0200
Message-ID: <2026090357-daybed-breach-27b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x c299a2285d9d8bda4da024455de65e3d00de6f17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090357-daybed-breach-27b2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c299a2285d9d8bda4da024455de65e3d00de6f17 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 4 Aug 2026 17:04:27 -0400
Subject: [PATCH] mm/huge_memory: use folio's memcg inside __folio_split()

Patch series "Honor XA_FLAGS_ACCOUNT in xas_split_alloc() and charge to
folio's memcg", v3.

__GFP_ACCOUNT is needed for xarray node allocation accounting when
XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
convergence regression") fixed a workingset regression with it.
xas_split_alloc() does not have it and needs to be fixed.

In addition, based on Sashiko's review[1] and Johannes' confirmation[2], to
charge the right memcg, folio's memcg needs to be active during folio
split. Add that before adding __GFP_ACCOUNT.

There is no workingset convergence regression related to missing
__GFP_ACCOUNT in xas_split_alloc() and the impact to userspace should be
minor.


This patch (of 2):

During a pagecache folio split, an xarray node allocation can happen and
needs to charge at folio's memcg instead of folio split invoker's memcg,
because for example folio split can happen during reclaim and reclaim's
active memcg might not be folio's memcg.  Switch to folio's memcg at the
beginning and switch back afterwards.

Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com
Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-1-38cb3ff325c5@nvidia.com
Link: https://sashiko.dev/#/patchset/20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838%40nvidia.com?part=1 [1]
Link: https://lore.kernel.org/all/amtcBZ-_QVRgCd6b@cmpxchg.org/ [2]
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a8174d1d3848..ced400f72d43 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4105,34 +4105,42 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
 	int nr_shmem_dropped = 0;
 	enum ttu_flags ttu_flags = 0;
-	int ret;
 	pgoff_t end = 0;
+	int ret;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	if (new_order >= old_order) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	ret = folio_check_splittable(folio, new_order, split_type);
 	if (ret) {
 		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
-		goto out;
+		goto out_no_memcg;
 	}
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+	memcg = get_mem_cgroup_from_folio(folio);
+	old_memcg = set_active_memcg(memcg);
+
 	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -4275,6 +4283,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+out_no_memcg:
 	xas_destroy(&xas);
 	if (is_pmd_order(old_order))
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);

