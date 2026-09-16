Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A934B95D1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573760; cv=none; b=FkT7c+UwzQg6duZmGh6flNxUjiTfYVMbsZpEWjysF41MAzYqYJZk9kxXpiPVDoHQpNLHBzH/fHamd8+90CB8GKl2M/tj53KKHgwamRp2DUfMUm0UmmkRBLkUimsP4miNd/YQrCjnVAfUbAxMNE3LXGwxATqTYhQhX64ngGR/NuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573760; c=relaxed/simple;
	bh=0SNkJ/TPtipXX9Iw9svAwZmyqUSBmKvyCbT+yfFRQlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctRqZ7FU3zfLfjntMWa2DnVRQly7m9npEL6KzR83l64DuM374JBn3PQa+xIA9OvrUuGtONL4QNoCGvisuzUa9N3kjE7GqKxIAYyS2FL3X8iG7dTfyCJKX0A7l0aAcUreVEYxs8xFa4cE4CdHZzS8bUEtWgssS/bVhmKEaqwPCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK62Fz0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK62Fz0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ED11F00898;
	Wed, 16 Sep 2026 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573757;
	bh=vEFQFtzaz0Kf0mygYADSexV3rZ2fKrCqmlB5mXcgO84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hK62Fz0nwImUFSNIWEGy1a+3d9vh/8azV30k2fCPtoXagvdK2WnkKZg3eAaXmmWR7
	 k7hi8J6HZGLCqWg4g5X9Xa/HBMI+IWxiNVgxT2cbLu5S2/EZSBGo1nEvOS8BA3Zyub
	 EeSkY96w5iLFvMrbFP4sW2WcXqFogJdou0wjHDCAq7oLVwbondWTTT9Pxb2BKIrb8o
	 Qud+HIL9rAZtTENJ10BR2Aft/e4XAHJCHyBD1hTkiKBwdtNoIU4WQCro2j/tiStVTN
	 Avc9WjUhH8nFR5LJtZvcs3XXQUMN8tiUEOxZvOWXQoqIkkI8f+DeJVgGdZTC95QVj4
	 tVsgvdDs4ZenA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF
Date: Wed, 16 Sep 2026 11:49:13 -0400
Message-ID: <20260916154914.4167599-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916154914.4167599-1-sashal@kernel.org>
References: <2026091605-rehire-self-1650@gregkh>
 <20260916154914.4167599-1-sashal@kernel.org>
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
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org
Stable-dep-of: 9e4a3ec3411b ("x86/mm/pat: Allocate split page tables as kernel page tables")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 5dc322409888f..560e9e4d8c21e 100644
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
 
@@ -1235,7 +1236,11 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
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
@@ -2092,7 +2097,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
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

