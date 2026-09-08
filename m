Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B373B4EBB;
	Tue,  8 Sep 2026 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907923; cv=none; b=KRIJGVYC4EU79hJH2v4eVCrDiAWQKdXksSeVETWBJtRzqgD4NEChT8V2X3+gBji1MxybmD6sdo1bVoMGXoBJ++gjJdW/4Ujjp1859SQN8cKjv+anlUNDF40mMye1Z2Jg0pPoBjTpkXlK3mGqrCPIV7ASggG9JPhNn5DwwzGQ6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907923; c=relaxed/simple;
	bh=TV4UjsM3oi1sCtyOdCdaObPhL0oayklrd2wSkp1zDms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g6ckGqIBYwPQz4tSy728FylWqTslh/Z/mXHtBrQ78gdKXPU42IuCgIgSx9EppDW52QSDBmzzfeOZTlVzBp+m4F76DeeJZuOQw6DMSQ74QTBLV2dwdaum1XEKmtHfJAT45KNuvIfoNnH3WA56Afd4/qFvACuUp9nWRulIgt52FTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mAnhXdJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qcfkrGZH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mAnhXdJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qcfkrGZH"
Date: Tue, 08 Sep 2026 22:51:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788907918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aY5KZmVRe9Y7el+roFlzopB31BbXBLPw4ZZ7PZRHcnM=;
	b=mAnhXdJJa4jd5nBvXXlId8NeHFCOjBZ6jJveDH44BwsRIcU1Hqs2yHi3F1P0xEer2tzKJ4
	r7WgbIlKYlM0IuXzn1Vj3jd2GcGvcwwr+y4C254uxVJw7g2h5GF0tMDki91FAaYAspyX9Y
	iDjD6c1BRxJuJrP69AYR0I+WouZy9pdqa0vPXpc/ni92ZQjnI4/ntpiPbOW9QTm/3f5tvG
	NIeE9piYh5FrSDns76zc+qYXlzCTdCFz2ofTk5iG5bFwpQoo79N5g7aB9oj9FOCwz+NryA
	tqzPkcP5PbZ0hw2RWUuzD5T5JKsWTjbkuL75jYP7nEGWVhUQdKd21lFwfJr0LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788907918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aY5KZmVRe9Y7el+roFlzopB31BbXBLPw4ZZ7PZRHcnM=;
	b=qcfkrGZHFY/NKbho3XXzZD44q7LCqAcO7//LEWbQLCKiG0lpLDZnNYspTfURtSwBwrEifm
	DYfk0Sjll1l60fDw==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Acquire init_mm read lock on attribute
 changes to avoid UAF
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178890791678.623050.2290749626721475583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ac20c594d88b2809b7d6a6e496ab16e0a39b82a9
Gitweb:        https://git.kernel.org/tip/ac20c594d88b2809b7d6a6e496ab16e0a39=
b82a9
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:25 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Sep 2026 15:43:06 -07:00

x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF

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

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation=
")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
