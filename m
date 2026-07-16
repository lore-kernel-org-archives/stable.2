Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370582D47E9;
	Thu, 16 Jul 2026 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245302; cv=none; b=Xt6KzzqK9Q5lF2Kw1VRkjjopDuJU1+dR1+K7lXFVWDPxZJBd8mMZQSC+BJQ+NfE+mYwPFEnugdw7v7ZgWaor3sdrAp/Owk2ZkqnETBcTnU/pd/jvvnytXsNhS/LYlHp6hrpL8w6TWH37nB3/JOMyv9XN94tE/rGDdJfmuPowV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245302; c=relaxed/simple;
	bh=005kKT4euDjnh2730Q5gBP/6ni43Mg9y9bJoGxfPaG8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lcu7YDZ5zPZe5uvrz9qwCiE/NLJjEe5iKWrFbgxArQL3b/Eaq+TxPzqXO3kZmw+sP3Rjl+0aqA3+m58oVFarIwNfhCDOeIexQaDeZv+6jhR1qBm+wxr3KisX7MDBKhIkD3NAJrQ9mwcshmX1LPyoeiDoG0Dz6XNFRe22dFyGP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GWrE81Xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GWrE81Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ED01F000E9;
	Thu, 16 Jul 2026 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784245300;
	bh=S/howEIvgndH8o3pTfe48AeTP4vfYaSSQLtkWDw5tX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GWrE81XllWQl5SeoAjAivl6b6wYYesCrb3N/mzexAllJ4UnlAwuaaRX7GYBfNhYIr
	 rUzjVX8SFgudmVpquJg4CpGAaGpYbm4V4SpJVtnrB0p3D/HJCveyAZSGNKLNPTz3Qn
	 +RaTiHE7dRlrCVuMrmUyMzGB6SBYcoddUR9tNrCE=
Date: Thu, 16 Jul 2026 16:41:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau
 Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain
 <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, David Carlier
 <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Denis V. Lunev"
 <den@virtuozzo.com>, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v4 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-Id: <20260716164139.0b447152db49db857cc73037@linux-foundation.org>
In-Reply-To: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 22:31:11 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
> 
> ...
> 
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
> Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
> support, and removing the ifdeffery with the partial revert patch.

Thanks, I've updated mm.git's mm-hotfixes-unstable branch to this
version.

> v4:
> * Rebased on latest master of Linus's tree.
> * Accumulated tags, thanks everybody!
> * Updated commit messages further as per Kiryl.
> * Took the mmap write lock across the whole CPA operation as per Will.

Here's how v4 altered mm.git:


 arch/x86/mm/pat/set_memory.c |   25 +++++++++++++++----------
 include/linux/mmap_lock.h    |    2 ++
 mm/vmalloc.c                 |    8 ++++----
 3 files changed, 21 insertions(+), 14 deletions(-)

--- a/arch/x86/mm/pat/set_memory.c~b
+++ a/arch/x86/mm/pat/set_memory.c
@@ -411,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
 
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
 
-static void cpa_collapse_large_pages(struct cpa_data *cpa)
+static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 {
 	unsigned long start, addr, end;
 	struct ptdesc *ptdesc, *tmp;
@@ -437,17 +437,22 @@ static void cpa_collapse_large_pages(str
 
 	flush_tlb_all();
 
+	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
+	}
+}
+
+static void cpa_collapse_large_pages(struct cpa_data *cpa)
+{
 	/*
-	 * ptdump might read these page tables, so avoid a use-after-free by
-	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
-	 * write lock).
+	 * Take the mmap write lock on init_mm to:
+	 * - Avoid a use-after-free if raced by ptdump (which takes its own
+	 *   write lock on init_mm).
+	 * - Serialise concurrent CPA walkers.
 	 */
-	scoped_guard(mmap_read_lock, &init_mm) {
-		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
-			list_del(&ptdesc->pt_list);
-			pagetable_free(ptdesc);
-		}
-	}
+	scoped_guard(mmap_write_lock, &init_mm)
+		__cpa_collapse_large_pages(cpa);
 }
 
 static void cpa_flush(struct cpa_data *cpa, int cache)
--- a/include/linux/mmap_lock.h~b
+++ a/include/linux/mmap_lock.h
@@ -621,6 +621,8 @@ static inline void mmap_read_unlock(stru
 
 DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
 	     mmap_read_lock(_T), mmap_read_unlock(_T))
+DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
+	     mmap_write_lock(_T), mmap_write_unlock(_T))
 DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
--- a/mm/vmalloc.c~b
+++ a/mm/vmalloc.c
@@ -163,11 +163,11 @@ static int vmap_try_huge_pmd(pmd_t *pmd,
 		return pmd_set_huge(pmd, phys_addr, prot);
 
 	/*
-	 * Acquire the mmap read lock to exclude ptdump, which walks kernel
-	 * page tables it does not own under the mmap write lock.
+	 * Acquire the mmap read lock to exclude ptdump, which walks
+	 * kernel page tables it does not own under the mmap write lock.
 	 *
-	 * Concurrent read lock holders are safe: each exclusively owns the
-	 * range it operates on and cannot reach this page table.
+	 * Concurrent read lock holders are safe: each exclusively owns
+	 * the range it operates on and cannot reach this page table.
 	 */
 	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm) {
 		if (!pmd_free_pte_page(pmd, addr))
_

