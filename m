Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1836A02F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134350; cv=none; b=BafbG+FZiSUT/ZZ4THCY3PKdkmg3dSfLCKThqtZ4uPVvQjrgZzY+aBLLOokMeTp/g8BRxeeS6KFpYJm9tXe0J9DXjTWtG764szE4U69tVCc+6WcWefoVJo59XLwi8JqjQJ2zY9WBNTIvxxnkInmm5Aus49wh6OBxE0QnDIdGoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134350; c=relaxed/simple;
	bh=l+PKb6jTUmXifbhyWqtNEUsE1xBMlun/8+6U8Y84oHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIuABqbaNI9ISBLugVYGfcCoAJbl5BMIuHfLRV+ZqB2xk+Vhu4RejDMijZkbPsvOomytlu4XgCPeF2vUIl2hZ1p6C22LoO2WUXakgw33ZtUebTCjnu+sceP5h1WPVkzIgcOT9SIIPiDJltHwQTqBIlONJ6A4CZEGF+iyQ2yt/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ph6h+Yb0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ph6h+Yb0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l+PKb6jTUmXifbhyWqtNEUsE1xBMlun/8+6U8Y84oHs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787134346; v=1; x=1787739146;
 b=ph6h+Yb0YLxYrPkVtD+RFRO8SJJTbiffXnAqXuoIU99wi/Npp+7gxvW83khT6KotMangyYQS
 gmdeC7fKZ+BLs2QdiR1ekdcgTsTEsZCCIqvBdL3VPPt96BwuNrO2d8bpGbRsPLAz556c9xiX1ps
 5bMZa/5porzu/UIxEQzqWDL4=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost (2a03:2880:10ff:51::)
	by mta12.migadu.com with ESMTPS id 52389be3d342616d;
	Wed, 19 Aug 2026 10:12:25 +0000
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	ziy@nvidia.com,
	kas@kernel.org,
	nphamcs@gmail.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Cc: stable@vger.kernel.org
Subject: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Wed, 19 Aug 2026 03:12:22 -0700
Message-ID: <20260819101222.3732660-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
file case, but not the dirty bit.  The pte path does propagate it, in
zap_present_folio_ptes() and so does the pmd split path, in
__split_huge_pmd_locked().

For most file mappings the omission is harmless, because writing to a
shared file mapping goes through page_mkwrite(), which dirties the
folio.  tmpfs is different: it has no page_mkwrite(), and
vma_wants_writenotify() is false for it, so a *read* fault on a
MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
do_read_fault() does not call fault_dirty_shared_page(), so subsequent
stores through that mapping set only the hardware dirty bit in the pmd
and never call folio_mark_dirty().  A shmem folio allocated by a fault
is marked uptodate but not dirty (see the clear: block in
shmem_get_folio_gfp()), so PG_dirty is never set at all.

Unmapping such a folio - munmap(), or exit_mmap() when the process dies
- then loses the only record that it was written, because zap_huge_pmd()
drops the pmd without transferring the dirty bit.  Reclaim afterwards
sees a clean shmem folio: the whole swap-out block in
shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
pageout() is skipped and the folio falls into __remove_mapping().
There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
entry is created and __filemap_remove_folio(folio, NULL) simply empties
the i_pages slot.  The data is freed without ever being written to swap,
and the next fault on that index returns a freshly zeroed folio.

This is silent data loss for any process that keeps state in a
MAP_SHARED tmpfs segment across an unmap - for example a cache handed
from one process generation to the next through /dev/shm.  It requires
the folio to be PMD-mapped, so it only shows up once shmem THP is
enabled (which is what we did in Meta fleet and started noticing crashes);
with THP off the pte path transfers the dirty bit correctly.
It also only becomes visible when swap is enabled, because with no swap
device shmem folios (which are on the anon LRU) are not scanned by
reclaim at all, so the clean folio is never dropped.

Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
2MB-backed region, write a known pattern through the resulting mapping,
munmap, force reclaim of the cgroup, then re-map and read back.  Without
this patch the region reads back as zeros and vmstat shows zswpout 0 -
the data was discarded rather than swapped.  With this patch the region
reads back correctly and the pages are swapped out as expected.  With
huge=never, or when the first touch is a write, the test passes either
way.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ced400f72d43a..afbb5974bd225 100644
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
-- 
2.53.0-Meta

