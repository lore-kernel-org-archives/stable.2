Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2423D25C5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971143; cv=none; b=kUCdgYVlEh81GFz+27vU84QYVH4RhKw69dMSjnD4IBfYPwLKXHpzMJ4rcWbkWeEU3t+HyquWyJdGigm+konM/8Wy6/MgV2rlDNGZn7TUGVuofUjmgcm0Mi2ccnc8qIF1Eh8LXCgBHRYsZ0n+r9KJNC68cpqEf1RLniGNxprV/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971143; c=relaxed/simple;
	bh=3ADIxZwnU96kLNmtILQdrFDYJTRd4capg9PBC4Pr1Mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WVgOu0Od7pOc0Ikj9wpnw4hLfDsSXfWYcr+yqSLXaPR6c5FTBgk/S1dciyMEAXKMeqqkNBSDXPrsMnarGwRDlZASxvdduA/eoJxAyn72wp1+4BWSXlQRqu9SMGAQ702BiUcgmiuF4gGESGs6EVuopOAy0aOxcxOXkrWpkDpHnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=chZUhSIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="chZUhSIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA3B1F000E9;
	Mon, 17 Aug 2026 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786971142;
	bh=XIDzjwDSr/hTYUsGQ4Vvg/Pe9200HzkNWVwMbeaLVjg=;
	h=Subject:To:Cc:From:Date;
	b=chZUhSIunAKrIqLJZO1Q30dyT8ho3F5dWz1FoLzbhdbYazLaJHDpDYFxWidzwidXu
	 9xCWG36DzLSrcEhj9qC0t3yxWaPAERy5Vdc/04719JEDeDfFNemDNC0w881WK1VUhU
	 szIWSKRNAZDxbr1pIaynkq3cMflzS938X2HBRuos=
Subject: FAILED: patch "[PATCH] mm/ptdump: always stabilise against page table freeing using" failed to apply to 5.15-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,bp@alien8.de,catalin.marinas@arm.com,chaitanya.kumar.borah@intel.com,dave.hansen@linux.intel.com,david@kernel.org,dev.jain@arm.com,devnexen@gmail.com,hpa@zytor.com,kas@kernel.org,liam@infradead.org,luto@kernel.org,mhocko@suse.com,mingo@redhat.com,peterz@infradead.org,rppt@kernel.org,ryan.roberts@arm.com,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,toshi.kani@hpe.com,urezki@gmail.com,vbabka@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:51:58 +0200
Message-ID: <2026081758-womb-earthlike-dfac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 27c32e5538344b13c1505a08861e04620c125d47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081758-womb-earthlike-dfac@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27c32e5538344b13c1505a08861e04620c125d47 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 23 Jul 2026 16:16:34 +0100
Subject: [PATCH] mm/ptdump: always stabilise against page table freeing using
 init_mm

Previous commits have established the invariant that kernel page table
freeing is performed while an mmap read lock on init_mm is held, which
fixes races between ptdump and kernel page table freeing over init_mm.

However, x86 and arm64 can perform a ptdump over an mm other than init_mm
via ptdump_walk_pgd() and since kernel memory ranges are shared across
non-kernel mm's, this means that the race still exists for these cases.

Fix this by acquiring a nested mmap write lock for init_mm in
ptdump_walk_pgd().

This is safe as we take this after mmap write locking the mm, and nothing
acquires the init_mm lock first before locking an arbitrary mm, so no
deadlock is possible.

Also update walk_page_range_debug() to assert that init_mm is write
locked, add a comment explaining why and remove some redundant code, and
eliminate the unnecessary and confusing invocation of
walk_kernel_page_table_range().

We can safely remove the non-NULL check for walk.mm, as the mmap lock
asserts would NULL pointer deref if it was (and of course no callers do
this).

The first point at which ptdump can race kernel page table freeing is
commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table"), so we target this in the Fixes tag.

Link: https://lore.kernel.org/20260723-series-vmap-race-fix-v6-4-8cc77dcc0018@kernel.org
Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index bbcfd68d0907..5d87c632a255 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -702,12 +702,16 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 	 * to account for page table freeing on vmap huge page mapping.
 	 */
 	mmap_assert_write_locked(mm);
+	/*
+	 * x86, arm64 ptdump allow walks of efi mm's and x86 ptdump allows walks
+	 * of arbitrary mm's.
+	 *
+	 * However, they both must also hold the init_mm lock to account for
+	 * concurrent kernel page table freeing.
+	 */
+	mmap_assert_write_locked(&init_mm);
 
-	/* For convenience, we allow traversal of kernel mappings. */
-	if (mm == &init_mm)
-		return walk_kernel_page_table_range(start, end, ops,
-						    pgd, private);
-	if (start >= end || !walk.mm)
+	if (start >= end)
 		return -EINVAL;
 	if (!check_ops_safe(ops))
 		return -EINVAL;
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 973020000096..5851096e6f65 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -178,11 +178,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
 	get_online_mems();
 	mmap_write_lock(mm);
+	/* To stabilise kernel page tables we must hold the init_mm lock too. */
+	if (mm != &init_mm)
+		mmap_write_lock_nested(&init_mm, SINGLE_DEPTH_NESTING);
+
 	while (range->start != range->end) {
 		walk_page_range_debug(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
+
+	if (mm != &init_mm)
+		mmap_write_unlock(&init_mm);
 	mmap_write_unlock(mm);
 	put_online_mems();
 

