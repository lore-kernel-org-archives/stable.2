Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE13BED4F;
	Mon, 31 Aug 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215251; cv=none; b=XN5hBSAJmIanK+W2KCiu4a44fo5oph9CNMOz2S4Mcesqmu3vm84ngAjNspD5kwNDSaATHawstaveab9+LLuK4F+6vNtKZkb5+VeQhX7ZcN8Scf6PVPwjAFPEEXe/cFzWZB71J8Xykbb1V6H6ProS7WBrx9J+Dc5kTZq6DhGjPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215251; c=relaxed/simple;
	bh=hJ2dJFxkq0b8ahroH2qGKr217MbJ5rhk/zdKtoJNd5I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GfkroZdYq1nAJUJ2H3e+IdKh+ZseY8MCOvqNizxiLt39jUvftSUkpdjAGcFNX04+bYcnzU+qwuKOybrrmjQLtnd6WDeFeA9LlJlMXNXcGX/tDB9FoDsTSfP7I2peuhzCBcHqvuZgDzZTXSdpwv8HqFZt6GYz1bhtiU8BjiQwM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3f+fCriV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPVluOyw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3f+fCriV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPVluOyw"
Date: Mon, 31 Aug 2026 22:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788215248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWWZMgmMe05qLkpLsqbPK0W8A/dZVOlz9bmwYSpBHJQ=;
	b=3f+fCriVIRhh/QL9kTuPnHfsrmrYt5biPAyJSeOLcv/EmBaO2tlSmr3KuP64FrKiJ9QgHm
	59fxQDyBZe7c5eQcnAStlar4mLkA5eSvDZqaLS2YLW+G6onUfIb0frvlxsf7o/0wKPflsn
	hgi3sZZFVAf8wgcuCdR5ga1K+TrWK86TdART1B6qSdIwy15Ce/ZWDYcnHt7Ug7fyCsFVV8
	LcLx4j84YWEYjQPE3MSGnO4sgI1lL52giLEssBzQJsRZ93/sdWc8PcIh8TGTyQ7YbhrKWl
	Y7EvWoNTB2+k0Y1xoHOIA0GCqDolgmKLq/2DZQ7l+uaTZS/2XoGpr4drSOSyvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788215248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWWZMgmMe05qLkpLsqbPK0W8A/dZVOlz9bmwYSpBHJQ=;
	b=mPVluOyw2NSpyN5c9NpYzlZrguZxb6XdF1C+O3/kQKu9XpfF6jFGOixX/+kUwNzSYmK/Lg
	680eyCAZaU2Nd+Cw==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Acquire init_mm read lock on attribute
 change to avoid UAF
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178821524648.3717435.13938325908577682845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     477cf5cd1f698053df7426b7b8d9339e85e00946
Gitweb:        https://git.kernel.org/tip/477cf5cd1f698053df7426b7b8d9339e85e=
00946
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:25 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 31 Aug 2026 15:15:42 -07:00

x86/mm/pat: Acquire init_mm read lock on attribute change to avoid UAF

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

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation=
")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org
---
 arch/x86/mm/pat/set_memory.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c38faf3..cb5d6d6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/cleanup.h>
=20
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -49,7 +50,8 @@ struct cpa_data {
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
 			force_static_prot	: 1,
-			force_flush_all		: 1;
+			force_flush_all		: 1,
+			init_mm_read_locked	: 1;
 	struct page	**pages;
 };
=20
@@ -409,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
=20
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtabl=
es);
=20
-static void cpa_collapse_large_pages(struct cpa_data *cpa)
+static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 {
 	unsigned long start, addr, end;
 	struct ptdesc *ptdesc, *tmp;
@@ -443,6 +445,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cp=
a)
 	}
 }
=20
+static void cpa_collapse_large_pages(struct cpa_data *cpa)
+{
+	/*
+	 * Take the mmap write lock on init_mm to:
+	 * - Avoid a use-after-free if raced by ptdump (which takes its own
+	 *   write lock on init_mm).
+	 * - Serialise concurrent CPA walkers.
+	 */
+	scoped_guard(mmap_write_lock, &init_mm)
+		__cpa_collapse_large_pages(cpa);
+}
+
 static void cpa_flush(struct cpa_data *cpa, int cache)
 {
 	unsigned int i;
@@ -1227,7 +1241,11 @@ static int split_large_page(struct cpa_data *cpa, pte_=
t *kpte,
 	struct ptdesc *ptdesc;
=20
 	spin_unlock(&cpa_lock);
+	if (cpa->init_mm_read_locked)
+		mmap_read_unlock(&init_mm);
 	ptdesc =3D pagetable_alloc(GFP_KERNEL, 0);
+	if (cpa->init_mm_read_locked)
+		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
 	if (!ptdesc)
 		return -ENOMEM;
@@ -2121,7 +2139,11 @@ static int change_page_attr_set_clr(unsigned long *add=
r, int numpages,
 	cpa.curpage =3D 0;
 	cpa.force_split =3D force_split;
=20
-	ret =3D __change_page_attr_set_clr(&cpa, 1);
+	/* Avoid race with concurrent CPA collapse. */
+	cpa.init_mm_read_locked =3D true;
+	scoped_guard(mmap_read_lock, &init_mm)
+		ret =3D __change_page_attr_set_clr(&cpa, 1);
+	cpa.init_mm_read_locked =3D false;
=20
 	/*
 	 * Check whether we really changed something:
