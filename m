Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372E3FADEE
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922416; cv=none; b=TbmgVy1YK/POBTxH3V1b2cpny46eNmpyFEHKHsFSHSjK6JYJNUKO+ftw+nxSPwrx93PivBgbh/wDSDBYTFZObBVMu9P1zABuvN+casK3IyRNr6mictJ/cmcomrbO8p00A5u9gx7Qr9KDsTYNFLqmXoBEbflOSvrOvvL7nSORIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922416; c=relaxed/simple;
	bh=Kqymr7CNih/567YvlKgByUCsaD/2civHJj689IViI9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mYf1sN+JJb9NUpMxrEksBgONR7Za27CP7nABx/ucyRyqBZB3K9kgaGj8uGmnAyvG4+tX3cVcmLJ3XYZfa84gUXDLCu5wVfHUfx4lGCMPTsFsPA9/S/s/gtMHDml2dBlxv0CwNVEKlHAQ+NuOoCFUGS1dNLe5MWdV2Cigf98JXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T4kSLon4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T4kSLon4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1C51F000E9;
	Wed,  5 Aug 2026 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922410;
	bh=UnQhV2QEcA1pIfBrOfa3HcH++/NFdROwzr4gyRgdXL4=;
	h=Subject:To:Cc:From:Date;
	b=T4kSLon4OfrmdPm174aqcksb4AbjQV0r2LYsm6KVf2jXrT68dwfzXBCu/NNjZuKNI
	 fFX+ou9pagyKBataRzK4kEgPPXilAIrs90o2NysXOf8hryXas7V7wrhxkOLCvrZv/T
	 y5miHUSq6J/3XrGyrZsW0yFy/CZa8FLJoFU2J15U=
Subject: FAILED: patch "[PATCH] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD" failed to apply to 6.6-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,david@kernel.org,jannh@google.com,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,peterx@redhat.com,pfalcato@suse.de,rppt@kernel.org,sashiko-bot@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,usama.anjum@arm.com,vbabka@kernel.org,zenghui.yu@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:33:14 +0200
Message-ID: <2026080513-ambitious-sage-b240@gregkh>
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
git cherry-pick -x 40de8160ca7f67d14619ee0351ce5d68fc4a237a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080513-ambitious-sage-b240@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40de8160ca7f67d14619ee0351ce5d68fc4a237a Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Wed, 15 Jul 2026 15:42:33 +0100
Subject: [PATCH] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD
 holes

PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written, but a
range with no page table at all -- a PMD hole -- is skipped:
pagemap_scan_pte_hole() tests p->cur_vma_category, which never carries
PAGE_IS_WRITTEN, so the hole is neither reported nor (under
PM_SCAN_WP_MATCHING) armed.

In a uffd-wp VMA, WP_UNPOPULATED installs uffd-wp markers when protecting
a range, allocating page tables as needed, so an unpopulated slot is
treated as written -- see the pte_none() handling in
pagemap_page_category().  A missing marker therefore means the range was
zapped, e.g.  via MADV_DONTNEED.  This applies to anon and shmem VMAs.

An anonymous THP is write-protected in place as a huge PMD, so a full-PMD
MADV_DONTNEED clears it to pmd_none -- a hole with no page table -- and
pagemap_scan_pte_hole() misses it.  For a MAP_PRIVATE|MAP_ANON mapping
MADV_DONTNEED has fill-with-zeros semantics, so a write-tracking
checkpoint/migration tool (e.g.  CRIU) treats the range as unchanged and
keeps its previous contents; after restore or live migration the process
reads stale data instead of zeroes -- data corruption.

Report a hole in a non-hugetlb uffd-wp VMA as written, matching the
pte_none handling in pagemap_page_category(); the existing
PM_SCAN_WP_MATCHING path then arms it via uffd_wp_range().

hugetlb is excluded: pagemap_hugetlb_category() reports an empty hugetlb
entry (huge_pte_none) as not-written, unlike pagemap_page_category(),
which reports pte_none as written.  pagemap_scan_pte_hole() fires for a
hugetlb slot only when it has no page table; keeping that not-written
matches how an allocated-but-empty hugetlb entry reads, so the hole and
the empty-entry cases agree within the VMA.

Link: https://lore.kernel.org/20260715144234.442721-2-kirill@shutemov.name
Fixes: 2bad466cc9d9 ("mm/uffd: UFFD_FEATURE_WP_UNPOPULATED")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Zenghui Yu <zenghui.yu@linux.dev>
Assisted-by: Claude:claude-fable-5
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d45c729ab6bb..229d1fc3d7f1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3049,12 +3049,28 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
 {
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	unsigned long categories;
 	int ret, err;
 
-	if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
+	if (!vma)
 		return 0;
 
-	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
+	/*
+	 * In a uffd-wp VMA an unpopulated range is treated as written:
+	 * uffd-wp registration populates page tables and installs markers
+	 * with WP_UNPOPULATED, so a missing marker means the range was
+	 * zapped. See the pte_none() handling in pagemap_page_category().
+	 *
+	 * hugetlb differs, see pagemap_hugetlb_category().
+	 */
+	categories = p->cur_vma_category;
+	if (userfaultfd_wp(vma) && !is_vm_hugetlb_page(vma))
+		categories |= PAGE_IS_WRITTEN;
+
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		return 0;
+
+	ret = pagemap_scan_output(categories, p, addr, &end);
 	if (addr == end)
 		return ret;
 

