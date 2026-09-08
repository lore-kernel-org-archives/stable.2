Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01E55C1AC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874695; cv=none; b=BRuZAm6eRDe39ZeR5y1nbTekzho4bh2NQ1H1on3AxSzjnOdUfcyLs394rWPWMFF8BkuBwkYGjIlgt5JA8YiL06Wlim1pau/YkkAfiJpgFLvL320ATngYYrPFuTqH81wUuBQWS/Lsja+O6KK1fY4NevqzWPo5yyqfYEIWPq9YrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874695; c=relaxed/simple;
	bh=19RzczjS1sOPdf9qsO0dfiEfKeqBqcv5X46cEuDJPFA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ABNcHVYVOgb2CiWB8yQh+c7doZaH1IWmUg8S87dRIAcTsvf8/WfJWd3pyOw0zO4caSTdhBlLiZyYiAVaz5fQ4voH8KlJj7zeS0tkFsr0fcbRuUXf6GDw1rfqUHAYVQEwRCw8ZVPhMxOCG4bx0Ui526uH80yzyOg0+ceVvIMPPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGSdA6JP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pGSdA6JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C601F00A3A;
	Tue,  8 Sep 2026 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874685;
	bh=Q7MT22EcJ57jZmO/UmhwSYqGPShwZiqrgtEoDUHOpBA=;
	h=Subject:To:Cc:From:Date;
	b=pGSdA6JPKz+mGDzJSuMj+msQwtciU+uzLMGQ4UmXk3FJNsfnRlZJJX8QLifw9jFf5
	 K3g4cIQeZ5AKa6LqY/lf3QlBQd/CvvVWHiw0Ag/OFAubxahbZhrI63+xmgDsMN4IHt
	 C86T/WodvLGW5ecXvkiIQFy7ToT/tn5X/TJhvDks=
Subject: FAILED: patch "[PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio on" failed to apply to 5.10-stable tree
To: usama.arif@linux.dev,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@kernel.org,dev.jain@arm.com,hannes@cmpxchg.org,hughd@google.com,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,nphamcs@gmail.com,riel@surriel.com,ryan.roberts@arm.com,shakeel.butt@linux.dev,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:33:50 +0200
Message-ID: <2026090850-matchbox-foil-749a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fe6cf984939d8e12cb33a99673c8d026c5135e68
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090850-matchbox-foil-749a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe6cf984939d8e12cb33a99673c8d026c5135e68 Mon Sep 17 00:00:00 2001
From: Usama Arif <usama.arif@linux.dev>
Date: Wed, 19 Aug 2026 03:12:22 -0700
Subject: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio on
 zap

zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
file case, but not the dirty bit.  The pte path does propagate it, in
zap_present_folio_ptes() and so does the pmd split path, in
__split_huge_pmd_locked().

For most file mappings the omission is harmless, because writing to a
shared file mapping goes through page_mkwrite(), which dirties the folio.
tmpfs is different: it has no page_mkwrite(), and vma_wants_writenotify()
is false for it, so a *read* fault on a MAP_SHARED tmpfs mapping installs
a writable pmd via do_read_fault().  do_read_fault() does not call
fault_dirty_shared_page(), so subsequent stores through that mapping set
only the hardware dirty bit in the pmd and never call folio_mark_dirty().
A shmem folio allocated by a fault is marked uptodate but not dirty (see
the clear: block in shmem_get_folio_gfp()), so PG_dirty is never set at
all.

Unmapping such a folio - munmap(), or exit_mmap() when the process dies -
then loses the only record that it was written, because zap_huge_pmd()
drops the pmd without transferring the dirty bit.  Reclaim afterwards sees
a clean shmem folio: the whole swap-out block in shrink_folio_list() is
inside "if (folio_test_dirty(folio))", so pageout() is skipped and the
folio falls into __remove_mapping().  There, folio_is_file_lru() is false
for a swapbacked folio, so no shadow entry is created and
__filemap_remove_folio(folio, NULL) simply empties the i_pages slot.  The
data is freed without ever being written to swap, and the next fault on
that index returns a freshly zeroed folio.

This is silent data loss for any process that keeps state in a MAP_SHARED
tmpfs segment across an unmap - for example a cache handed from one
process generation to the next through /dev/shm.  It requires the folio to
be PMD-mapped, so it only shows up once shmem THP is enabled (which is
what we did in Meta fleet and started noticing crashes); with THP off the
pte path transfers the dirty bit correctly.  It also only becomes visible
when swap is enabled, because with no swap device shmem folios (which are
on the anon LRU) are not scanned by reclaim at all, so the clean folio is
never dropped.

Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
2MB-backed region, write a known pattern through the resulting mapping,
munmap, force reclaim of the cgroup, then re-map and read back.  Without
this patch the region reads back as zeros and vmstat shows zswpout 0 - the
data was discarded rather than swapped.  With this patch the region reads
back correctly and the pages are swapped out as expected.  With
huge=never, or when the first touch is a write, the test passes either
way.

Link: https://lore.kernel.org/20260819101222.3732660-1-usama.arif@linux.dev
Fixes: b5072380eb61 ("thp: support file pages in zap_huge_pmd()")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Acked-by: Hugh Dickins <hughd@google.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ced400f72d43..afbb5974bd22 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2449,6 +2449,8 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 		add_mm_counter(mm, mm_counter_file(folio),
 			       -HPAGE_PMD_NR);
 
+		if (is_present && pmd_dirty(pmdval))
+			folio_mark_dirty(folio);
 		if (is_present && pmd_young(pmdval) &&
 		    likely(vma_has_recency(vma)))
 			folio_mark_accessed(folio);

