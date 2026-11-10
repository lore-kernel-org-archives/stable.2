Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272638;
	b=gnd5KxOHLXgO24Wa/zQELitlVKzkzKeMXfP9rcwdK8AJIwY93JTwBQMiiZypcs5I1+qv
	 Xhga61GA3EvJnHf6UdEiX8h+RUrnaPQicVeQGVo7EGMupJ/mz/gnTQ0zowGXXVn3+ds2/
	 2LiGj9A5TYSJcIYb5W77C29yIkJ8qhEKIcAYQZ0+dboLROKYtGVdHaMicSld26tiyt/ld
	 mg7IBJL/B30NlxpCFG0TBIN7ryLX3Q0Cz8y5jaSar5h6QfDD/3D/iEwI15CZ2aaDgcANs
	 M5ntZ772kcTAxgAW4OeNsiqG60YixP0uQ+/Zrd2PXNrtfVJq4sJmZae1Znl7Kr63K5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A09zaJ/2aTdi3zqhyeqgRchjmGN375gVSl0yaY68Bbg=;
	b=O9L6KdcI+MXgRdQooR7RAF4+6zoCIFjHsEgaHvbDXYURywPXl0O2tI4ABDQ1cE2J8UpA
	 dRqHDvpu/+MO2fVqpc7bCwUt5T4yvsmAR1HeLuHm2q9MXQbdeEOOkvn6xy8QqiFcE5ZQr
	 V+CEIY8a/14yr5habbz+7x1HTmYADgZgJeX4NyKCrOrhr7sbMFAEDIG1KE7CQ3qsMLNtj
	 69WOPEA2qak8gzoDtIdXMYRnlAOwI/srUTPXMGQNJVQjmIwAIq3xFE58NFVNqZtR+NIsH
	 WCBwc/KFUR0ZH/sRvzf2SFL4nVeNjI5lr+e9E5lXObJsdf1gblY08IOJqzEGZLNuIUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBJXxU8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBJXxU8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8B1F0089F;
	Tue, 10 Nov 2026 01:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272637;
	bh=A09zaJ/2aTdi3zqhyeqgRchjmGN375gVSl0yaY68Bbg=;
	h=From:To:Cc:Subject:Date;
	b=KBJXxU8K6yaebeuD6ldgyU47LvqUtADnKCUiyuFRS9gaXJNgn1bS4rlB16WU1fb79
	 NOFjedmtFWI4kNKyDXHxHYDBdKNM84Urzkh/9GKTPIVrNoqvNu6c1NR5et4B3aK3GM
	 vl79xeBz74eqExd37M46wMOkRBmgxu+QAcp9GMAEsKq2GSkIEFZBagulAxcmmGSrnE
	 HGSugUI0y478F/WEzZsQ0FsgtH21BJjXvZ/YI72VdzNpGrL2+hu4AQtX0PNj3IC0EO
	 +oxOl3iQcyzHDT8oB97jtKxxeIHnf8fSUnqhPczgw4aJUPlJzGLO3rhYvUn1NVRhVo
	 NqQdPvD+o3gCw==
From: Sasha Levin <sashal@kernel.org>
To: baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	ayushr@modal.com,
	qi.zheng@linux.dev,
	pfalcato@suse.de,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: memory: fix truncation removing mapped folios" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:54 -0500
Message-ID: <20261109200354-failed-6.18-243cf1f67b36@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 243cf1f67b365668389832463fc31cbb9fec47af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200354-failed-6.18-243cf1f67b36@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 243cf1f67b365668389832463fc31cbb9fec47af Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Date: Wed, 28 Oct 2026 08:52:57 +0800
Subject: [PATCH] mm: memory: fix truncation removing mapped folios

Ayush reported an issue that shmem/tmpfs folios are still mapped when
truncating them on production:
"
BUG: Bad page cache in process ...  pfn:...
page dumped because: still mapped when deleted
"

I reproduced the issue with Ayush's reproducer [1] with the latest
mm-unstable branch, and I got the following crash info.  From the dump
message, we can see that truncate_inode_folio() is really trying to remove
mapped folios, which is incorrect.

"
[  189.171977] page: refcount:3 mapcount:1 mapping:00000000fe168ee1
index:0x3880 pfn:0x191647
[  189.171995] memcg:ffff0000cc073d40
[  189.171997] aops:shmem_aops ino:3c01 dentry name(?):"memfd:runsc-memory"
[  189.172006] flags: 0x17fffef0002022d(locked|referenced|uptodate|lru|
workingset|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
.......
[  189.172017] page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio))
[  189.172026] ------------[ cut here ]------------
[  189.172027] kernel BUG at mm/filemap.c:155!
[  189.172057] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
.......
[  189.177721] CPU: 3 UID: 0 PID: 5521 Comm: repro Kdump: loaded Tainted:
7.3.0-rc4+ #277 PREEMPT(lazy)
.......
[  189.183986] Call trace:
[  189.184124]  filemap_unaccount_folio+0xf0/0x1e8 (P)
[  189.184391]  __filemap_remove_folio+0x34/0x160
[  189.184633]  filemap_remove_folio+0x4c/0xb0
[  189.184859]  truncate_inode_folio+0x34/0x58
[  189.185087]  shmem_undo_range+0x220/0x658
[  189.185308]  shmem_fallocate+0x2f0/0x470
[  189.185527]  vfs_fallocate+0x128/0x328
......
[  189.187078]  el0t_64_sync+0x184/0x188
"

After analysis, I believe the race exists between truncation and
MADV_DONTNEED, and shmem's ->map_pages() merely makes the issue easier to
reproduce.  Since MADV_DONTNEED synchronously releases the pagetable page
before calling tlb_flush_rmaps(), this could cause another thread's
truncation to skip zap_pte_range() (due to pmd is none) but still observe
the folio's mapcount as non-zero.  A possible race scenario is as follows:

CPU 0                           CPU 1
shmem_fallocate                 madvise_dontneed_single_vma
  unmap_mapping_range            .......
  ......
  (filemap_map_pages() remap folios)
				  zap_pte_range
  truncate_inode_folio		    zap_empty_pte_table(pmd clear)
    unmap_mapping_folio
    ......
      zap_pmd_range (saw pmd none, skip)

  filemap_remove_folio
    BUG_ON(folio_mapped)
                                    tlb_flush_rmaps(remove rmaps)

To fix this issue, we should move the pmd clear operation (via
zap_empty_pte_table()) to after tlb_flush_rmaps() and use
sync_with_folio_pmd_zap() to sync with concurrent zapping, so that when we
find a pmd_none() while unmapping a folio without holding the PTL, the
folio's mappings are guaranteed to have been removed via
tlb_flush_rmaps().

Meanwhile move the second pmd_none() check to where it belongs: if
splitting zapped the PMD.

Link: https://lore.kernel.org/14ebbd556cc4941f0ebc43da59fa6a2fdca25dc8.1793148609.git.baolin.wang@linux.alibaba.com
Link: https://lore.kernel.org/all/20260925065013.3682431-1-ayushr@modal.com/ [1]
Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Ayush Ranjan <ayushr@modal.com>
Closes: https://lore.kernel.org/all/20260924061708.1645968-1-ayushr@modal.com/
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
---
 mm/internal.h | 10 ++++++----
 mm/memory.c   | 35 ++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 566cbd2dce485..8b1263e81054e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -589,14 +589,16 @@ void free_pgtables(struct mmu_gather *tlb, struct unmap_desc *desc);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 
 /**
- * sync_with_folio_pmd_zap - sync with concurrent zapping of a folio PMD
+ * sync_with_folio_pmd_zap - sync with concurrent zapping of folios
  * @mm: The mm_struct.
  * @pmdp: Pointer to the pmd that was found to be pmd_none().
  *
  * When we find a pmd_none() while unmapping a folio without holding the PTL,
- * zap_huge_pmd() may have cleared the PMD but not yet modified the folio to
- * indicate that it's unmapped. Skipping the PMD without synchronization could
- * make folio unmapping code assume that unmapping failed.
+ * zap_huge_pmd() may have cleared the PMD but not yet updated the folio
+ * mapcount, and zap_empty_pte_table() clears the PMD only after the rmaps
+ * for the table have been removed, but nothing orders the pmd_none() read
+ * against later mapcount reads. Skipping the PMD without synchronization
+ * could make folio unmapping code assume that unmapping failed.
  *
  * Wait for concurrent zapping to complete by grabbing the PTL.
  */
diff --git a/mm/memory.c b/mm/memory.c
index 591592bc5a941..916637e8381da 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2036,6 +2036,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
+	add_mm_rss_vec(mm, rss);
+	lazy_mmu_mode_disable();
+
+	/* Do the actual TLB flush before dropping ptl */
+	if (force_flush) {
+		tlb_flush_mmu_tlbonly(tlb);
+		tlb_flush_rmaps(tlb, vma);
+	}
+
 	/*
 	 * Fast path: try to hold the pmd lock and unmap the PTE page.
 	 *
@@ -2043,18 +2052,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 * to hold the pmd lock failed, then we need to recheck all pte entries
 	 * to ensure they are still none, thereby preventing the pte entries
 	 * from being repopulated by another thread.
+	 *
+	 * Clear the PMD after the rmaps for the table have been removed, in case
+	 * an incorrect mapcount is observed after unmapping the folio.
 	 */
 	if (can_reclaim_pt && direct_reclaim && addr == end)
 		direct_reclaim = zap_empty_pte_table(mm, pmd, ptl, &pmdval);
-
-	add_mm_rss_vec(mm, rss);
-	lazy_mmu_mode_disable();
-
-	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush) {
-		tlb_flush_mmu_tlbonly(tlb);
-		tlb_flush_rmaps(tlb, vma);
-	}
 	pte_unmap_unlock(start_pte, ptl);
 
 	/*
@@ -2101,13 +2104,15 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 				addr = next;
 				continue;
 			}
+			/* We already synchronized with concurrent zapping. */
+			if (pmd_none(*pmd)) {
+				addr = next;
+				continue;
+			}
 			/* fall through */
-		} else if (details && details->single_folio &&
-			   folio_test_pmd_mappable(details->single_folio) &&
-			   next - addr == HPAGE_PMD_SIZE && pmd_none(*pmd)) {
-			sync_with_folio_pmd_zap(tlb->mm, pmd);
-		}
-		if (pmd_none(*pmd)) {
+		} else if (pmd_none(*pmd)) {
+			if (details && details->single_folio)
+				sync_with_folio_pmd_zap(tlb->mm, pmd);
 			addr = next;
 			continue;
 		}
-- 
2.53.0




