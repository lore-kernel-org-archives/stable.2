Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104288;
	b=opjWB7zo8NVbG3j3BSWgEDktfnCe8selfWcJFSmSre3hetTWwfEv9+kpx8nP9Ie0Eu3u
	 vdaQTveQgjTMse6vn39OLCKOy9xvxayeqc9C2Fqd25Tu5aKdkLEDDUEF37L5po5t6zJbI
	 yX1uvuSvTQ/9Jr9lauQ28HbZL+mjKVeY5DxGHujhmNauv+uz9gfr5sI7/WFi26k7tPmiV
	 IW/QFd6XFKjUH1wVozMPuzi4C4pIv2eRGC+qcBuCMBlkqcDAdZsiIV6IEM6CkZ+kbVOvD
	 ZJrvjHwrRbAhqEM5JUyk/LBRT0cpb8psVyCR/+JMTePx/0u/0GTaMSjlo7bpcFWT38g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104288;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yhaisaAAN1Avtw/qa8Xj7ZQOfB9giXxwqMgpPlclG0w=;
	b=buNyu3hhMwBjsxmrUIQYegoT7NxPRYTe7gof+awqYdvNAN0OEze1xOnijKt6YSEigDtX
	 G/w8W/iCAHjJvy2oefmhYQgKP96ZOx/qyfN2YW1G/LapXlAE86P/PmeOiWcy/wV1NNHVn
	 doMZcmS2mA//besVIxThKs0O9TPBRqvXBUQkCoKWxPjPOcEPSMuuIv6/ELzjWQ0ib8r9q
	 KftMuyvLedqvQ4TfeNjUZZJdhJyRQJFTq+Q23iHb1yS7IjelFHIbBitLO2PcUjPW2hG7p
	 ir/u9P75q+rpJBu91RhDevFOuw9eNIESC4w5mAFUvPD12II9tXUD4j2QEKyOocwa+fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdLqVltT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480F606A320;
	Thu, 19 Nov 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdLqVltT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCA51F000C4;
	Thu, 19 Nov 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104287;
	bh=yhaisaAAN1Avtw/qa8Xj7ZQOfB9giXxwqMgpPlclG0w=;
	h=From:Date:Subject:To:Cc;
	b=PdLqVltToPcnV2Kr96HMTvrYV9O486YB5OgE2IXS7ZoweYhsRhmhnLstNVaEUIi8b
	 v5TB8wShJq7LkbWiDqzEk2OYi/qQXgE603SFXFE5Y9nf9rvBfVFZpg5uByOUnu3841
	 ac9E90IUbgE8Q3sRmFdisH+KFtPI9fzPHdHlF8e3XRAjqZ/GxxSVyXdle0dmvV4MNG
	 vOrTSxKhHkc3or71n+2v5Bm+HlTCjkORqrqwiDCz29A94nf0ySwbPXpIkaRBD9YfRV
	 jy3dmvHCocKC9BG5Utbh5BzC7xIrmgZo3ojJbKqeTiL8AQI0+sc48HHjaMO27ZDZ4W
	 97tCgMoPIIPoA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 19 Nov 2026 17:04:34 +0100
Subject: [PATCH] mm/madvise: fix MADV_FREE handling for PMD-mapped THPs
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMywqDMBAF0F8Z7tpAM4KP/EopEuNYp+CDREUQ/
 13aLs/mnEgSVRIcnYiya9J5giObEcLgp7cY7eAI/ODCWlub0Xd700eRZh0Wkwf2dVWVvmRGRli
 i9Hr8vufr77S1HwnrN8F13ezBYKxxAAAA
X-Change-ID: 20261119-madv_free_thp-3c2a9887a722
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 Sashiko <sashiko-bot@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7097; i=david@kernel.org;
 h=from:subject:message-id; bh=KreIxZq3TY8k1cY6VRwhN5I7d4jwyXkzZnKkz4xPVPc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+y0nkeZ/ZuDW9y/L//eV/z2z31ux+yjI1+sjJky75v
 x6feroho6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJnMlk+B+8f897xtAjM6b9
 vOxvNs2u8mJf/1fx8qCs9rs/rm+cvG0lw/98y3NaqxZeOyp3c/18zZVpHz7+dOJPbgtglTp6oN/
 //DF+AA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

After MADV_FREE cleared the dirty flag of an anonymous folio, reclaim will
later free the folio without writing it back if no mappings are dirty.

If our folio is still in the swap cache, the swap entries then point at
swap slots that were never written, exposing stale content of the swap
device. Bad.

madvise_free_pte_range() therefore frees the swap slots first, and skips
the folio if that is impossible. madvise_free_huge_pmd() does not, and a
PMD-mapped THP can be in the swap cache if try_to_unmap() failed during
reclaim, for example due to a racing mlock().

Further, madvise_free_huge_pmd() checks whether the THP is mapped by
other processes before taking the folio lock. Another process that still
has swap entries for the THP can concurrently map it from the swap cache,
and we might end up clearing the dirty flag of a shared folio.

Fix it by factoring out the folio handling of madvise_free_pte_range()
into madvise_free_try_prepare_folio(), and using it for PMD-mapped THPs
as well. Hopefully this prevents further bugs.

For PMD-mapped THPs, this change implies:

1. We free the swap slots of a THP in the swap cache, and skip the THP if
   that is impossible.
2. We check the mapcount under the folio lock.
3. We no longer lock and check THPs that are neither dirty nor in the
   swap cache, just like for PTE-mapped folios.

For PTE-mapped folios, this means:

4. We check the mapcount once before taking the folio lock, to not lock
   folios that are mapped by other processes.

Only compile madvise_free_huge_pmd() with CONFIG_ADVISE_SYSCALLS to keep
!CONFIG_ADVISE_SYSCALLS builds working.

Chris and Sashiko reported the missing swap cache handling for PMD-mapped
THPs, the other issue was found by code inspection.

This has medium urgency.

Fixes: bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped out")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/sashiko-outbox-202086@kernel.org/
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
I would queue this fairly soon on mm-core/for-next-fixes
---
 mm/huge_memory.c | 19 ++++++-----------
 mm/internal.h    |  1 +
 mm/madvise.c     | 65 +++++++++++++++++++++++++++++---------------------------
 3 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 79d400ea9553d..e22daf846dbe3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2421,6 +2421,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_ADVISE_SYSCALLS
 /*
  * Return true if we do MADV_FREE successfully on entire pmd page.
  * Otherwise, return false.
@@ -2455,21 +2456,13 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (folio_is_zone_device(folio))
 		goto out;
 
-	/*
-	 * If other processes are mapping this folio, we couldn't discard
-	 * the folio unless they all do MADV_FREE so let's skip the folio.
-	 */
-	if (folio_maybe_mapped_shared(folio))
-		goto out;
-
-	if (!folio_trylock(folio))
-		goto out;
-
 	/*
 	 * If user want to discard part-pages of THP, split it so MADV_FREE
 	 * will deactivate only them.
 	 */
 	if (next - addr != HPAGE_PMD_SIZE) {
+		if (folio_maybe_mapped_shared(folio) || !folio_trylock(folio))
+			goto out;
 		folio_get(folio);
 		spin_unlock(ptl);
 		split_folio(folio);
@@ -2478,9 +2471,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto out_unlocked;
 	}
 
-	if (folio_test_dirty(folio))
-		folio_clear_dirty(folio);
-	folio_unlock(folio);
+	if (!madvise_free_try_prepare_folio(folio, 1))
+		goto out;
 
 	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
 		pmdp_invalidate(vma, addr, pmd);
@@ -2498,6 +2490,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 out_unlocked:
 	return ret;
 }
+#endif /* CONFIG_ADVISE_SYSCALLS */
 
 static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 85cf7becf8588..96cb55d7816b1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -61,6 +61,7 @@ void lru_add_drain_cpu(int cpu);
 void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
+bool madvise_free_try_prepare_folio(struct folio *folio, int nr_mappings);
 
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/madvise.c b/mm/madvise.c
index 0214efd2a014f..ebb4ce7daf6cb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -661,6 +661,38 @@ static long madvise_pageout(struct madvise_behavior *madv_behavior)
 	return 0;
 }
 
+bool madvise_free_try_prepare_folio(struct folio *folio, int nr_mappings)
+{
+	if (!folio_test_swapcache(folio) && !folio_test_dirty(folio))
+		return true;
+
+	if (folio_mapcount(folio) != nr_mappings || !folio_trylock(folio))
+		return false;
+
+	/*
+	 * KSM folios can gain new mappings at any time, so we must
+	 * not clear their dirty flag.
+	 */
+	if (folio_test_ksm(folio))
+		goto unlock;
+
+	/*
+	 * Check under the folio lock that the folio is exclusive: we own all
+	 * mappings, and there are no references from swap entries.
+	 */
+	if (folio_mapcount(folio) != nr_mappings)
+		goto unlock;
+	if (folio_test_swapcache(folio) && !folio_free_swap(folio))
+		goto unlock;
+
+	folio_clear_dirty(folio);
+	folio_unlock(folio);
+	return true;
+unlock:
+	folio_unlock(folio);
+	return false;
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
@@ -753,37 +785,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			}
 		}
 
-		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
-			if (!folio_trylock(folio))
-				continue;
-			/*
-			 * KSM folios can gain new mappings at any time, so we must
-			 * not clear their dirty flag.
-			 */
-			if (folio_test_ksm(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
-
-			/*
-			 * If we have a large folio at this point, we know it is
-			 * fully mapped so if its mapcount is the same as its
-			 * number of pages, it must be exclusive.
-			 */
-			if (folio_mapcount(folio) != folio_nr_pages(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
-
-			if (folio_test_swapcache(folio) &&
-			    !folio_free_swap(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
-
-			folio_clear_dirty(folio);
-			folio_unlock(folio);
-		}
+		if (!madvise_free_try_prepare_folio(folio, folio_nr_pages(folio)))
+			continue;
 
 		if (pte_young(ptent) || pte_dirty(ptent)) {
 			clear_young_dirty_ptes(vma, addr, pte, nr, cydp_flags);

---
base-commit: 5e600d79135124a4eb8e9db30ad524224c267c07
change-id: 20261119-madv_free_thp-3c2a9887a722

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

