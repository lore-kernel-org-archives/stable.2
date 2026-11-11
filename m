Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415343;
	b=OleQZAsmFQQNloNpW4MVOE/7S8GtFvNHQq0G417vXCl+gmHAMx3L4xvFrAmcw7n1jhq0
	 rmhXrM2n9c2hjYCFqupyYzsdPY831a52cZMRl9S75TPoKmnndZT7M+dM26bWvM5fxhWSC
	 dGpzadL3+lKHokxrYRWDZ2k4C3IdR8K5QAPxQ5kbZELI/nO7tjz4GKqVGAI01SsX7kydd
	 ittUmzZVYbH1Q1RYbjl8pE5+uTiMjWnoThSMK70Ri5RX2YZNQcpIBgp1UsRsS0Mlj7qFr
	 P5BLscipG6SVoyUprt3AquhhKrkdZ2V265Q3CbWoDE+VIbUbAP7iFyXPL6vUiL/GLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9EVb8xxl7M0OFJAYutZeyfBXqwEoH4tHsadk9QMMte8=;
	b=E/M2acA5llbrKuhHO5jQJ2CzROHXg8GZDdfTulblXrcrgy9yLP0EXa5FMT+yx1CtVQca
	 alikZGorjKF8hPcVu3InhSTiay69xl93u/H0Fe8ttvADIdCkMblaJzmPznAdrjxTGCT4G
	 JqDXFRk/xUAYg4/mM0n70I0kX4zYIrpNFhFmJI0VSlZ4IQgs9mLL5rLFAZHL6ZA05664o
	 sUrC0Zdjh+EX0HPmhAOnO1G4IJ47xKZPhtbN32N0oZXCXN2Ys+rXU8UEcgQEd+qOykbGA
	 9ddJ1lT7qunRpWFb8S9T0EBK9QSMSHrVWwZ+phlUS93/T6/S3mSzmazghhbNurkaBtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMGDZTwl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMGDZTwl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA711F00A05;
	Wed, 11 Nov 2026 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415343;
	bh=9EVb8xxl7M0OFJAYutZeyfBXqwEoH4tHsadk9QMMte8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMGDZTwlYur+tTozbWmoqX7h2Zeu2iy1IAafpJZWh4tsroqkM3pjPobKs4a2Yt5WJ
	 RDqAZ1rwa/ncP9ZJXvv9xQEsYo9nSqwFqgmsenFe6r9sswDxiSk2vVLefqmy/hqO9A
	 TMyI3rxOZO4LEtuHstM5+snZxsOdCBfy44oDftW4DYfF+cMiXZ0H6thNE3rb4lhUQn
	 mKiCkWc5u+zUhPPrT35jRGi+GT/2C/yIIDE3SQ1JYEJwNCgBaVWwYidI4nYyftRuTD
	 XCiJN8zlgynxTQg82s6KDuYCxSeP09gL5doJU4gxpbx2XK5iboy+56p0efDrAyy4tQ
	 reEMxEHZjgptg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ayush Ranjan <ayushr@modal.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm: memory: fix truncation removing mapped folios
Date: Wed, 11 Nov 2026 11:42:20 -0500
Message-ID: <20261111164211.3288275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200354-failed-6.18-243cf1f67b36@kernel.org>
References: <20261109200354-failed-6.18-243cf1f67b36@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>

[ Upstream commit 243cf1f67b365668389832463fc31cbb9fec47af ]

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
[ sashal: adapted to try_get_and_clear_pmd() and arch_leave_lazy_mmu_mode() with inline PMD locking in place of sync_with_folio_pmd_zap() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 52 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3049e4dc2651f..e37ae367c8c19 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1877,6 +1877,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
+	add_mm_rss_vec(mm, rss);
+	arch_leave_lazy_mmu_mode();
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
@@ -1884,18 +1893,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 * to hold the pmd lock failed, then we need to recheck all pte entries
 	 * to ensure they are still none, thereby preventing the pte entries
 	 * from being repopulated by another thread.
+	 *
+	 * Clear the PMD after the rmaps for the table have been removed, in case
+	 * an incorrect mapcount is observed after unmapping the folio.
 	 */
 	if (can_reclaim_pt && direct_reclaim && addr == end)
 		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
-
-	add_mm_rss_vec(mm, rss);
-	arch_leave_lazy_mmu_mode();
-
-	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush) {
-		tlb_flush_mmu_tlbonly(tlb);
-		tlb_flush_rmaps(tlb, vma);
-	}
 	pte_unmap_unlock(start_pte, ptl);
 
 	/*
@@ -1942,19 +1945,26 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
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
-			spinlock_t *ptl = pmd_lock(tlb->mm, pmd);
-			/*
-			 * Take and drop THP pmd lock so that we cannot return
-			 * prematurely, while zap_huge_pmd() has cleared *pmd,
-			 * but not yet decremented compound_mapcount().
-			 */
-			spin_unlock(ptl);
-		}
-		if (pmd_none(*pmd)) {
+		} else if (pmd_none(*pmd)) {
+			if (details && details->single_folio) {
+				spinlock_t *ptl = pmd_lock(tlb->mm, pmd);
+
+				/*
+				 * zap_huge_pmd() may have cleared the PMD but not
+				 * yet updated the folio mapcount, and
+				 * try_get_and_clear_pmd() clears the PMD only after
+				 * the rmaps for the table have been removed, but
+				 * nothing orders the pmd_none() read against later
+				 * mapcount reads without this synchronization.
+				 */
+				spin_unlock(ptl);
+			}
 			addr = next;
 			continue;
 		}
-- 
2.53.0

