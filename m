Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C62F9D98
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922002; cv=none; b=nUs93vXGdMl1Zt9hvqk6Grk/SbjlM6o8rSoGN5+xUqqFt7B0Lq+e/P+4nza+wxVnB5F3PjVBs3WFRVmyrHfmiL+pLAcihjOXwEC6Y0hPsTUZYsPrbht7LHP9HTiIMBRJF4wdkelm2hw52nV994lHMieL/XwDA8LOEbHemBVRQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922002; c=relaxed/simple;
	bh=2/nbGE727VCjRXbrrbs4dqW6NKJnLj/S5xNhoKUO/7U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jvsxkdqFdTolmspbE4lE7sngKicx4qbMuYk1dx5NaEbTT+lcUZGWKGVMDldZGROAzk2GUPARKp/Z5FXra5H+D68WYDgrlezfYm2bqSKKENZrHJocccbjKqJ7IMJ2mHCC+DuZs6dTd51fLB2DcXSsc4CKxLtxbbGZ7EQ1cTb54m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cuRQovcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cuRQovcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E765D1F000E9;
	Wed,  5 Aug 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922000;
	bh=5HT7hwgvE5aF/KFRGDxYhfwo82qaR/uLilCZvv2ogkw=;
	h=Subject:To:Cc:From:Date;
	b=cuRQovcCxRt5sCb60om1aLMuODoioqvtjWH9cFYcT66Z92bKEYW2SO17q6b1vVQzI
	 TuXWvJGubVPsL6PQDOxDY4E7FZbUZIzDClQVlp/I8pYiQwocm7B//eiNmsax0CEyTV
	 XXFeIOpLtb4V3EVlk/tNLflilMi8hwkaeAOeV1qw=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix swap entry corruption when clearing uffd-wp" failed to apply to 6.12-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,david@kernel.org,muchun.song@linux.dev,osalvador@suse.de,peterx@redhat.com,sashiko-bot@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:26:15 +0200
Message-ID: <2026080515-mangle-frail-8d50@gregkh>
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
git cherry-pick -x 83abe2fd5b3aeb3123b5408a5a91709c5538fb23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080515-mangle-frail-8d50@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83abe2fd5b3aeb3123b5408a5a91709c5538fb23 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Wed, 8 Jul 2026 10:01:10 +0100
Subject: [PATCH] mm/hugetlb: fix swap entry corruption when clearing uffd-wp
 at fork()

copy_hugetlb_page_range() clears the uffd-wp bit of migration and hwpoison
entries with huge_pte_clear_uffd_wp(), which operates on the present-PTE
bit position.  Swap entries keep the uffd-wp state elsewhere -- the
migration branch reads and sets it with pte_swp_uffd_wp() and
pte_swp_mkuffd_wp() -- and the present-PTE position falls into the swap
payload.  On x86-64 it lands in the inverted swap offset, where a
naturally-aligned hugetlb PFN always has the affected bit set, so the
clear advances the encoded PFN by two pages.

No userfaultfd needs to be involved: the clear is guarded only by the
child VMA not being uffd-wp registered, so a plain fork() with an
in-flight hugetlb migration entry (or a poisoned hugetlb page) corrupts
the entry copied into the child.  Instrumenting the clear and forking
after MADV_HWPOISON on a 2MB anon hugetlb page shows:

  offset before=120e00
  offset after =120e02

The fallout is mostly latent: rmap walks match migration entries by folio
range and remove_migration_pte() rebuilds the PTE from the folio, so a
within-folio PFN skew heals once migration completes.  But any path that
re-encodes the corrupted offset -- e.g.  hugetlb_change_protection()
rewriting a writable migration entry via
make_readable_migration_entry(swp_offset(entry)) -- propagates it.

Migration entries legitimately carry uffd-wp, so clear it with
pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
move_huge_pte().

A hwpoison entry, on the other hand, never carries the uffd-wp bit: it is
installed fresh by make_hwpoison_entry() (try_to_unmap_one() does not
preserve uffd-wp on the hwpoison path) and hugetlb_change_protection()
leaves hwpoison entries untouched.  There was nothing to clear there, only
the corruption, so drop the clear entirely.

Link: https://lore.kernel.org/20260708090110.136162-1-kirill@shutemov.name
Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260703140011.99E601F000E9@smtp.kernel.org/
Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: Claude:claude-fable-5
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..bca2707d02e3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4917,8 +4917,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 		softleaf = softleaf_from_pte(entry);
 		if (unlikely(softleaf_is_hwpoison(softleaf))) {
-			if (!userfaultfd_wp(dst_vma))
-				entry = huge_pte_clear_uffd_wp(entry);
+			/*
+			 * A hwpoison entry never carries the uffd-wp bit: it is
+			 * installed fresh by make_hwpoison_entry() and
+			 * hugetlb_change_protection() leaves it untouched, so
+			 * there is nothing to clear for the child.
+			 */
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(softleaf_is_migration(softleaf))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
@@ -4936,7 +4940,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				set_huge_pte_at(src, addr, src_pte, entry, sz);
 			}
 			if (!userfaultfd_wp(dst_vma))
-				entry = huge_pte_clear_uffd_wp(entry);
+				entry = pte_swp_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(pte_is_marker(entry))) {
 			const pte_marker marker = copy_pte_marker(softleaf, dst_vma);

