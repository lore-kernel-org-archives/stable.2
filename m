Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801920;
	b=W4LtUPtv1cnwjIyDUDNsw15UP8L8ca6VDPreQuQ/wJm/grVFBb6NsWydYhDCbrwmHhjd
	 BYVkse1eoKraAWJh1ZbYvj+AwUpELN/b1mF/7w8/cAiejDexEkbNvfu0LXyUFoUkyxtrP
	 q3lGr+1WldRmciJHhhW8wij9zWc7mRh6mf7P6wX7oMRO52UeoKXjg4kgCF7zrOKFMfx9Q
	 7aHv2PFrko993DimXXsoHkh/gipZper7hAMVY1SRY/JO1Zih/OYhTpqyxIQ0XXIrVsxXB
	 cOxyUNux40N/5yhL7fv0+wgfTqGT50tD2IBsK/Dk4lJIVKajV3sJlGrarnke+elDKaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801920;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UG1xZK4Hutm9q/gCj+wsVrVDDhDfcv9Y9Qh/8CIo1SA=;
	b=UKsz0Jtz2Gr2B/MS/my9jVOMV3OISJseEepcdrW76PZs2XPFXCg+iw+x6WQAfJFc0u5+
	 /iEWMfQ/H/pszmnMb210g7eW7IT/SrGReY962ZckPT93G1djHsWTAEiI3i/MVOKCQ9BKM
	 USx9FAwWEOLCDE64ASK15++uDG5g8cV/B7BJCAEsDuhUiSHKbX7CzHIEjjir79EvsEtg8
	 /6fhqwLKIX0woEAc1FStRvO8lZZc4DY4cZ2qNGnVVb7FOGkPey7tdreuPrY4lh1rnHkIg
	 xUjys10P+QhDiUIQ2f4E4nKfiFK5skJTT3Y/jiRRW1DSt6YFuMcuzSRZ9AR/wVYS/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t+HqCNUY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t+HqCNUY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03171F000C1;
	Wed,  4 Nov 2026 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801920;
	bh=UG1xZK4Hutm9q/gCj+wsVrVDDhDfcv9Y9Qh/8CIo1SA=;
	h=Subject:To:Cc:From:Date;
	b=t+HqCNUYi0noOOgILEOpnGLbIXyjB+4u3RkUFdgBnd7Uc7HbLuRTwfnC/v02WT7am
	 1dP9Yq+5/ag5aGezrw4vKPz9btxj0GOp64QfIRM5XhHTJyT6Wq1FRIiqYVQy+rRkSb
	 /T+S6d2TdJojdu9tgLYygNu1nSHMgGF7MPIGKeMs=
Subject: FAILED: patch "[PATCH] mm/rmap: don't discard lazyfree THPs at PMD level" failed to apply to 6.18-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,david@kernel.org,harry@kernel.org,jannh@google.com,kylebot@openai.com,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,malhyuk97@gmail.com,riel@surriel.com,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:18:37 +0100
Message-ID: <2026110437-sizably-daylight-e650@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 984c0700854e35779a2bcce6b02783e709b6efa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110437-sizably-daylight-e650@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 984c0700854e35779a2bcce6b02783e709b6efa2 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 12 Oct 2026 22:20:16 -0400
Subject: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level

__discard_anon_folio_pmd_locked() clears a lazyfree THP's PMD before it
determines whether the folio can be discarded, and restores it if the
folio is dirty or has extra references.  It is done under only the PMD
lock and the anon_vma read lock inside try_to_unmap_one() and no mmap lock
is held.  The temporarily none PMD causes UAF.

A parallel munmap() or mremap() is supposed to serialize with it on the
PMD lock, but zap_pmd_range() (called by munmap()) and move_page_tables()
(called by mremap()) do not take the lock when they see the temporarily
none PMD and skip the PMD.  There is no more page table walk after the
none PMD is restored:

- munmap(): free_pgtables() waits in unlink_anon_vmas() for the anon_vma
  lock, then free_pmd_range() drops the restored PMD as bad without
  removing the rmap, so the folio keeps a stale mapcount.

- whole-VMA MREMAP_DONTUNMAP: dontunmap_complete() unlinks the source VMA
  from its anon_vma while the restored PMD still maps the folio.

- plain mremap(): the THP is not moved but unmapped, so the THP's data is
  lost.

In the first two cases, the folio stays mapped, but no VMA that maps it is
linked to its anon_vma.  When the anon_vma is freed, it is still reachable
when one rmap walks the folio.  Racing lazyfree reclaim against
MREMAP_DONTUNMAP as an unprivileged user reproduces a KASAN use-after-free
in folio_lock_anon_vma_read() as reported in the Closes link.

One solution is to use an invalidated PMD instead of a cleared one until
the discard is committed, but it needs arch fixes first.
1. GUP-fast still follows an invalidated PMD on riscv, LoongArch and s390.
2. sparc64 miscounts thp_pte_count when an invalidated PMD is set again or
   cleared.

To keep the fix simple for backport, stop discarding lazyfree THPs at PMD
level instead. try_to_unmap_one() splits the PMD and discards the folio at
PTE level.

unmap_huge_pmd_locked() and __discard_anon_folio_pmd_locked() are left in
place, unused, to minimize this fix for backport and the invalidated PMD
approach is planned as a follow-up series to use them again.

Link: https://lore.kernel.org/20261012-lazyfree-stable-fix-v2-1-6387d6e30063@nvidia.com
Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: JongHyuk Kim(MalHyuk) <malhyuk97@gmail.com>
  Link: https://lore.kernel.org/CADQRuqvXQ=YE=7T3oR66vTxE33pi=ygEeZKPTOU=cALZL0Figw@mail.gmail.com
Assisted-by: LLM
Cc: Rik van Riel <riel@surriel.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>

diff --git a/mm/rmap.c b/mm/rmap.c
index 805db93fe042..1131b76bbbc2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte) {
-			if (folio_test_lazyfree(folio)) {
-				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
-					goto walk_done;
-				/*
-				 * unmap_huge_pmd_locked has either already marked
-				 * the folio as swap-backed or decided to retain it
-				 * due to GUP or speculative references.
-				 */
-				goto walk_abort;
-			}
-
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
 				 * We temporarily have to drop the PTL and

