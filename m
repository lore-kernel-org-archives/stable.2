Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218774AA010;
	Wed,  2 Sep 2026 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374022; cv=none; b=jIKJ9SXjvTHMAPb9vqMismWCyCuyBU3sOkjvGiPAdYQnhNblM/nrNQGRRD18GkkYIa5Ey+oYOssl0eVl2b+UIy+9obRVIleZnWemGFW1wJ01qm7Fr6n4m+RrBnB7N3x69/FuvOUjbiv55zkKebNtulnARt1cqdLzXuLuF5TzBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374022; c=relaxed/simple;
	bh=4PDC+xoMvAfUVU0ftDQDSBDbp/I4XzvimSiNu/bXrMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mpWwdCTTYp7+VnZeTSJ3CqCUi+9EALk7tS0Un8xOOTmH3T6mK5E9RV/oiJanNiZJR9ubM6GyEsfQtM02r/Xi527Px38d0zktGeYaiSg0e7zu+xyvgtx9on8/68HB8VTVJ6zOA7ZQP/QIZDVzdWQuyDYJianbg8fIli56DxUrcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+Z0F1wr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRLXETc7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+Z0F1wr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRLXETc7"
Date: Wed, 02 Sep 2026 18:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788374018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3XrYVqtJR3RXjS9VB6HsIF/w8yoCsG45mNqiA0FdUE=;
	b=0+Z0F1wrR8+i221x1hJGutt0YF3UqVguNDP4Ie3OmCTEKte2FzQRIE91qSrby4lJcRHhmF
	02iT50vyUB99LKKkqJtQSnOjhFB1p+UbH946c3EbcIqnzo3dZVg4hCUXvOAc/bY2u6VVU/
	oolxrYUfiPz+GG+JNxF/0q4f3BNhwgIatMBpFFCAc+EtC7YJZEYBnTUid3Xkw1DeWFy6vl
	paRTluoIJxWfQEVA/ePXAzHFL616RfKN3h0tiEhrv0CBMR3yAMxTn6mzVEaxbimmxMDMzL
	lbrIbeQx4nsOgGfaPOvgYDtVcFgQG0EEhHokzgKueIIT/340DjNcOIsAYOTtpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788374018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3XrYVqtJR3RXjS9VB6HsIF/w8yoCsG45mNqiA0FdUE=;
	b=MRLXETc7rKjNgDfsbE3SYhvDNJP1z8kxozH5cO2HOGpR+kBeicIPO+OD7JUZQgmy1kv9Ty
	F/QPjhsYB/3IouBw==
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
Message-ID: <178837401646.3717435.3126936579227000946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     884801a901bd340c44a202e2ef5c29b48e3a4d93
Gitweb:        https://git.kernel.org/tip/884801a901bd340c44a202e2ef5c29b48e3=
a4d93
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:25 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 01 Sep 2026 14:35:22 -07:00

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

[ dhansen: move to imperative voice in changelog ]

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
 arch/x86/mm/pat/set_memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 4abddd7..cb5d6d6 100644
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
=20
@@ -1240,7 +1241,11 @@ static int split_large_page(struct cpa_data *cpa, pte_=
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
@@ -2134,7 +2139,11 @@ static int change_page_attr_set_clr(unsigned long *add=
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
