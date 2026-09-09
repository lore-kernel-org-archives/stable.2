Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023236F916
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947263; cv=none; b=jQ7rD9FUR1/ET4utTfgr1REWB7qVl6VXSnwO+qopBdHnCY3+EMVg2WwAE8AtLKVlH/oOWMPSaHkt1r9dSQNj5unfY+RNvm8Tj9QH+M7LnlwxtVT6n7/7LJ9XAOIfLKkGAuTGovaq40N4fmxbd/aL1ADG6OjAEli6d2DeTVKCWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947263; c=relaxed/simple;
	bh=0blmMXbZYXx5KgzaS5baybo2K2+UKr+QNwkFbL2dfvk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c7UPvw8n0DBQg2B9Yyrd5ubP5BGljBxAeC61RrhYLYhHsp4ouu5x9B4GqQbX43DO0ZcNHC+QcKGCdSHcjtApYsNmr/xnJQWhUrBMAhT+jIJ5ApfusAPTABszQ33Gw7kI/GbQUmv5N/xbL+dXEdZ4qvyrGW/t1mLCfYs2/OqgW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yuVo38pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yuVo38pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C28D1F00A3A;
	Wed,  9 Sep 2026 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947262;
	bh=j5A74eWkmkFpFp69ghoNfTdv/p2klom3WAr1O0i4XC0=;
	h=Subject:To:Cc:From:Date;
	b=yuVo38ppFy5n8iDYFfTv8HQY09cCuUd0V0WhHTCwo8kxTZDUu77P4b5fae5Vz8bIC
	 SHVu3yq6EPF7O3HWkHZyOfHd9j7w27C0ig2xapJhO1Bj6tO8fSJP5WEgXiWUuhyQ1V
	 1iGKwNdCJxlQf1LbSp2rxGNxRuePKUtQz8dZaWHA=
Subject: FAILED: patch "[PATCH] mm: fix incorrect vm_flags usage when checking allowable" failed to apply to 6.12-stable tree
To: baolin.wang@linux.alibaba.com,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,dev.jain@arm.com,hughd@google.com,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:45:05 +0200
Message-ID: <2026090905-parole-radiated-b379@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2fd4e7693674b17807a6d082feb01a3fbf86f5f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090905-parole-radiated-b379@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fd4e7693674b17807a6d082feb01a3fbf86f5f8 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Date: Tue, 18 Aug 2026 10:47:26 +0800
Subject: [PATCH] mm: fix incorrect vm_flags usage when checking allowable
 orders for tmpfs

Lance reported that when nothing else causes the mm to be considered for
khugepaged collapse, an MADV_HUGEPAGE-advised tmpfs VMA alone does not
trigger scanning.

After commit 6beeab870e70 ("mm: shmem: move shmem_huge_global_enabled()
into shmem_allowable_huge_orders()"), the shmem/tmpfs allowable order
check reads vma->flags directly.  However, when MADV_HUGEPAGE is handled,
khugepaged_enter_vma() is called before the VMA's flags have been updated,
so the check uses stale flags and incorrectly rejects the VMA for
collapse.  As a result, khugepaged does not collapse the tmpfs file into
PMD order in time.

Fix this by calling khugepaged_enter_vma() with the new VMA flags in
madvise_update_vma().  Meanwhile we can remove the khugepaged_enter_vma()
in hugepage_madvise().

Link: https://lore.kernel.org/7d5b5eb27be798f89d563b06254c947ff53db0b2.1787020910.git.baolin.wang@linux.alibaba.com
Fixes: 6beeab870e70 ("mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Lance Yang <lance.yang@linux.dev>
Closes: https://lore.kernel.org/all/20260815181632.21453-1-lance.yang@linux.dev/
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 11ff98d55c76..75639298efc2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -454,12 +454,6 @@ int hugepage_madvise(struct vm_area_struct *vma,
 	case MADV_HUGEPAGE:
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
-		/*
-		 * If the vma become good for khugepaged to scan,
-		 * register it here without waiting a page fault that
-		 * may not happen any time soon.
-		 */
-		khugepaged_enter_vma(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
diff --git a/mm/madvise.c b/mm/madvise.c
index 96f2387b2f46..eeee82cf2b3f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -178,6 +178,14 @@ static int madvise_update_vma(vm_flags_t new_flags,
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
 	vma->flags = new_vma_flags;
+	/*
+	 * If the vma become good for khugepaged to scan,
+	 * register it here without waiting a page fault that
+	 * may not happen any time soon.
+	 */
+	if (vma_flags_test(&new_vma_flags, VMA_HUGEPAGE_BIT))
+		khugepaged_enter_vma(vma, vma_flags_to_legacy(new_vma_flags));
+
 	if (set_new_anon_name)
 		return replace_anon_vma_name(vma, anon_name);
 

