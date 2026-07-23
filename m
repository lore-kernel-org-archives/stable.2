Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04A4756B3;
	Thu, 23 Jul 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819851; cv=none; b=pQz1/rDvJKCRY14knz+hzO1GlF+d3d0SiMF/v28VhGtDJlE4Mv1dwZxZmMQfJRdPpVulVnQ87/K5zSXG+ZmEer9Xl1GLSmriVhRL5w1NkocRZq4fmfrR/y3Fak7OD+EimTJzqBkVse2Zti9mP00dhfE/KoTA4YLOA1MQ7Ua1OeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819851; c=relaxed/simple;
	bh=akxrj13lq/jN4z92xXrWGgQjWx+k4pmtig1tmCI1Rgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gjio6uvtkRdziyWLyZoCKrS4wkJbwNBFiFWs2l29m89R0MssV3BIESGq4oYWGdENe2KWKV/wPTyX3IfB/ga4SPicyENWn9+Fc952CMdAMNdHopcEueLLNtOOkRvn4e9YHJHRjKR8u1xzDOaHT3aYNtQUN7PYPQo9PjjKliofaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NotWd1pq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NotWd1pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B531F00A3A;
	Thu, 23 Jul 2026 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784819845;
	bh=Cp2mZdK6fJ1/si4CysQ56zitoOpwB+w35kScbOb2foM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NotWd1pqW5cSI0cTR7v9yu46zVCF47GX5WwS13EO559ek9XdS1VKv+VhM7bYjlSjk
	 wfnuNCgkjM3KADUhnUfjJfLN5ae+8XXCPt/u4afIW7HDlXbUJUOxjEYlQhu/hscZz8
	 x6v3t7J0Vpu2pc/e1Nmwx1p91nv2Ag7knaRRoq976gNfbXqe5eCupHWjc8TYkYPty2
	 lCBrXMHaDy0HoqayKPYfKfgY5QBb6qCpX2nBPGuyCCKN90/Gpt/blL2mfVIqg1zUEx
	 kDLCmK6XBlKYIfgtLBeKg42eXyRgwoKoscq5AxIdb8J2oYzOB5/geYfhDBpmtTYuPQ
	 2U0mqevzggA2Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 23 Jul 2026 16:16:33 +0100
Subject: [PATCH mm-hotfixes v6 3/5] x86/mm/pat: acquire init_mm read lock
 on attribute change to avoid UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-series-vmap-race-fix-v6-3-8cc77dcc0018@kernel.org>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
In-Reply-To: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, ljs@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, "Denis V. Lunev" <den@virtuozzo.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4639; i=ljs@kernel.org;
 h=from:subject:message-id; bh=akxrj13lq/jN4z92xXrWGgQjWx+k4pmtig1tmCI1Rgs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKSDGJZv/xpV/pzpMI449Xn74qeNttef6kPX1t9YNmRP
 xOnsp3O6ShlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEOGcyMqyt+rVf2Dh9loKt
 YdgqI4aJmooduV+fbbvNsUvG5kDfyqWMDNPaH/qzLrXY/599euTFu+mnXu/jTlStY9GPubdItt5
 jHi8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A previous commit protected us against races between ptdump and CPA
collapse, however one still exists between attribute changes and collapse
as reported by Denis V. Lunev (linked).

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

With the mmap write lock taken on init_mm over CPA collapse, we can now
resolve this race by acquiring an mmap read lock on init_mm over
__change_page_attr_set_clr().

This locks across the whole operation over which the walk and the PTE entry
write occurs, solving the race.

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

This work is based upon Denis V. Lunev's excellent analysis of the bug with
gratitude.

Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d1e63f7d267f..618f72096480 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -50,7 +50,8 @@ struct cpa_data {
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
 			force_static_prot	: 1,
-			force_flush_all		: 1;
+			force_flush_all		: 1,
+			init_mm_read_locked	: 1;
 	struct page	**pages;
 };
 
@@ -1250,7 +1251,11 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
+	if (cpa->init_mm_read_locked)
+		mmap_read_unlock(&init_mm);
 	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (cpa->init_mm_read_locked)
+		mmap_read_lock(&init_mm);
 	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
 	if (!ptdesc)
@@ -2122,7 +2127,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
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
2.55.0

