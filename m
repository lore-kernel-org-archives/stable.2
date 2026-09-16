Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F64BB80D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567807; cv=none; b=fOG1kBwPCFgSjNS+23aiHnI8UY1TvpK2Q7VgilSBsFuIrKRGuK9DXA7jNc5lJZG8JX+/082rURKoV2CLq0Xc1YDrShASqnmgxuw7yddcFc+E4T0H+9VRfzoCfFp5ZYAgi0XtChC7MgSGSgf6Suko6SziSQ2Bst8zz7ZhXS/JeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567807; c=relaxed/simple;
	bh=TMogDQj4dB5tfUlD78RMGV75gesb9MZjVgXiEGC/ZFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlAJa8R17erE0QYtKhqdyKhRsmr2cNSC2cSTDxIQR8Y6M7YfdKWr4QJCwT0xz6SN3HnDe5qd4M5k4gfBw30fCkbmlMTI61Ndis1vwvArBLM2I/b8SM5IlwoywD5iyTYB8hk5umA1JynJzc6t5+E3QNs56KuvPTDaLvXeuqiumhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDtyN5EQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDtyN5EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984231F0089A;
	Wed, 16 Sep 2026 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567805;
	bh=gVwz0JoaJx+8mHU4hdEwYtA2i4PcO6zolS2JuFJGKe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TDtyN5EQsqBzAZ9Ed5DRdHUsuDe6fO8pFbTM1QuJ+9fQtb6JFhYikCfAiG+9Fa+ov
	 A/8pTDXOb0NSMVklGBFMURz1/MY2/O/W9Ws/Y5M/u5wrEGFCaerpB9jh20sfQpp9hd
	 DlGS244I8HMxxFeu/3WWDU5Ln6S7FVVz/mvj2AugqVGrZ8UzdUSLzRcS9oCWlQLXym
	 wVHs9FH9wMkvLUX8jczCPX/v0K3KNN6pIN6yJ2T+N/sllX4mncOs2ETTR5BefbN8lL
	 k7Gb/UeeYzg+iEP2SyyUUDHEuaxxBdoy7ZgMyiWVrnyAfbhaaWKi5MOmHA6u2atRFz
	 XKIUKDa23akdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF
Date: Wed, 16 Sep 2026 10:10:02 -0400
Message-ID: <20260916141002.2927195-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916141002.2927195-1-sashal@kernel.org>
References: <2026091613-lark-dioxide-099d@gregkh>
 <20260916141002.2927195-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit d5d8b8662e6e5a565b47a0388640e88402f23274 ]

A previous commit protected against races between ptdump and CPA collapse,
however one still exists between attribute changes and collapse as reported
by Denis V. Lunev (linked).

When an attribute change arises, a lockless page table walker obtains a PTE
entry, which is later written to via set_pte_atomic():

  ...
  -> change_page_attr_set_clr()
  -> __change_page_attr_set_clr()
  -> __change_page_attr()
	-> _lookup_address_cpa()
	-> lookup_address_in_pgd_attr()
	-> [ lockless page table walker ]
  -> set_pte_atomic()

There is nothing preventing a concurrent CPA collapse which can free the
PTE that was retrieved here, resulting in a use-after-free.

With the mmap write lock taken on init_mm over CPA collapse, resolve this
race by acquiring an mmap read lock on init_mm over
__change_page_attr_set_clr().

This locks across the whole operation over which the walk and the PTE
entry write occurs, solving the race.

It is safe to do this here, as no spinlocks are held upon entry to
__change_page_attr_set_clr().

However, the lock must not be held over an allocation, as allocation can
trigger reclaim and shrinkers may call into CPA recursively, making
deadlocks possible (init_mm -> ... -> fs_reclaim -> init_mm).

A page table is allocated when a huge page needs to be split:

  -> change_page_attr_set_clr()
  -> __change_page_attr_set_clr()
  -> __change_page_attr()
  -> split_large_page()
  [ pagetable_alloc() ]
  -> __split_large_page()

Avoid deadlocks by dropping the mmap lock across pagetable_alloc() in
split_large_page() and track whether this is needed by adding a new
'init_mm_read_locked' flag to struct cpa_data.

This is safe as __split_large_page() (called with locks re-established)
revalidates that the page table entry is the same as it was prior to the
locks being dropped and __change_page_attr() repeats the entire page table
walk whenever a split occurs, so concurrent split and collapse are
accounted for.

Concurrent ptdump is also safe as the lock is only dropped over page table
allocation during which time the page table has not yet been modified.

The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
operates upon vmalloc ranges, and on x86 only within the module mapping
space.

This is important, because some callers directly invoke
__change_page_attr_set_clr(), bypassing this lock. However, none of these
operate within the module mapping space.

  * cpa_process_alias() - a recursive helper called by
    __change_page_attr_set_clr().
  * __set_memory_enc_pgtable() - operates on the direct mapping and (via
    __vmbus_establish_gpadl()) the vmalloc mapping space.
  * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
    valid]_noflush(), __kernel_map_pages() - operates on the direct map.
  * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.

This work is based upon Denis V. Lunev's excellent analysis of the bug
with gratitude.

[ dhansen: move to imperative voice in changelog ]

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6dda81a629d69..18f88e578be35 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -49,7 +49,8 @@ struct cpa_data {
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
 			force_static_prot	: 1,
-			force_flush_all		: 1;
+			force_flush_all		: 1,
+			init_mm_read_locked	: 1;
 	struct page	**pages;
 };
 
@@ -1241,7 +1242,11 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	struct ptdesc *ptdesc;
 
 	spin_unlock(&cpa_lock);
+	if (cpa->init_mm_read_locked)
+		mmap_read_unlock(&init_mm);
 	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (cpa->init_mm_read_locked)
+		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
 	if (!ptdesc)
 		return -ENOMEM;
@@ -2110,7 +2115,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	cpa.curpage = 0;
 	cpa.force_split = force_split;
 
-	ret = __change_page_attr_set_clr(&cpa, 1);
+	/* Avoid race with concurrent CPA collapse. */
+	cpa.init_mm_read_locked = true;
+	scoped_guard(mmap_read_lock, &init_mm)
+		ret = __change_page_attr_set_clr(&cpa, 1);
+	cpa.init_mm_read_locked = false;
 
 	/*
 	 * Check whether we really changed something:
-- 
2.53.0

