Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4148EBFE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101777; cv=none; b=hwNkd8j7HLXAus5CXYXGXIQIHXzWyn2o560M6tC7wUSaXCMfKdAnQz3Xe3OVE0u4eSsv1ArP6SO0mrzUP6zuk5MCR0uAzvHcrAgPBasrN9doXUfy0h3kDjrZuf2FvtTxTEvVIZ7LJ2wGkoaHCU6G/SnuqA8cirWAigY6xo1ALxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101777; c=relaxed/simple;
	bh=DUuMJtRLPKdLJIOxwHMx3Bh+ZGPd3Aw74L7rounBegw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoKKWrt9uP2K2vKKLIxVKp1mvZZJ5BIVoig2V/YctNS5XR6miHhOyXHeVI6xHPhXsenXC+kWRNdVO4ky0styspF7YT5ekfZCb97wyNSoTu0vNewKbUntUL912pnpvGfmevhODQYjR4cqa+2SrzO5CvPWmjDiSDgBhd+YHVsaJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TRtFFBM/; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TRtFFBM/"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910a0cb7cso15766685a.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790101773; x=1790706573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I23ituCzWdUZNH9RRsiqmg7x+KgPhziEZ7cFA0c9iYo=;
        b=TRtFFBM/Vq/UQ4KkmD0Sl9Z+RtjQzb22ocMyp2NqeBz9I5ORzci9b6CwrCFmVnzQDf
         +ctDnr0s3vbAQXChnMzgcEaFD3BztNbZEp/8IG+0XCcqNrMOPs6LpThb9Jg6H+ca57Ck
         O5H78VYZZWkOKx10mbU+xVc0h+a7sMZiCZS2vMrZjwFUNNOAzOy0dAv/2BeNh7NdmoEl
         58k7fS2E2xU9sWtLismvXd6gWMcYb1j6E+ieaH4bUb9X3L3rk7ZOvwUDFgvKHXXxUQXW
         51EOp0tZ6RUPyjM8mj+Mo7vn5ryiFiTvhx1odveFEFEG2ha1jEbdjXbKe0uaJY5Xcom5
         VPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101773; x=1790706573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I23ituCzWdUZNH9RRsiqmg7x+KgPhziEZ7cFA0c9iYo=;
        b=vdEf8+ljeWkmloeCxk6kr87Mo5QMNMFkY07c4rBS2qPJOGNvHi6v2a+/2hH/PKflcl
         ikBMteqj+wvu8vHBDRQo93HIVySROUuKdw7Y0M/qvvQhArh2IcXGP3CahMTo4hmHrZ+u
         95SxfTcfTMDDqTP9Ffb82pDAvnAphxR7wbbn7f+RKSb5+o5LRIuaSXPmQ8jn4KwcHQMN
         xNSIVohPTXWQupTaOObRRCJ7MGzD4Dp9EJQZ68ZhCp81gkiuvEQDvrR+9KSfpZO9sXui
         k4DyvCYAosFkZC0sKMgK+6FtgMcrt4fCRARem9agPEkRFACeoY4ktkPB8QlCbqONdOXH
         V8tg==
X-Forwarded-Encrypted: i=1; AKwUvByGa3Pb5ORQCqBymqy0n3Ygg9JhAdMa/SVc77oBrI+xqVjL5SvTm4evmYRd8GkMdOjrv8z2Z90=@vger.kernel.org
X-Gm-Message-State: AFuF++mmhqKTtcJA4/uZDCy1xfnTnHCPqIxfcHpZqS6/i8q8968+YTP4
	v3/a3HD1QvNZk3X8dSvdBX1c/Hbg5rRnyGdNb48mC5Am/R5r0miyJN8p9QAVvNs7vkI=
X-Gm-Gg: AYBFou1QjC7a1YjxvEl8MyHIMC3tQAcT2O5S2F/9f1XF77kfnHs3nVpVZWEfbhbPlcj
	htQhs3RP7+vrQ8bc6DzJE4fV7xm+v5Nx1WkPZIzcyI56hygVUkONPaU5hzsf23Q8PZzqmtWAAv1
	Z7dSdegAv0yDjJ2Ps9/Pp9lj7jELvha6RRb0UoZkwzR5jG3siS2GDF4C2Qt3J2dQ/HP2X0dj7Cf
	maUjr0F9Tw1uoyhT8o+x2G9wjurbrJaDiXQt0As/XdLDl/VVMviOA6/eit4hk67tMGMM6Hu/TuI
	5Fx5bzweizLV9jx2shN8bfn7/nf99tcBqJ3bNG53LekSZSvGF3WbHAZGDp8beK72VunaEYFaR1Q
	JQNM9d16QWnS6USkBXmoj3aq2fi0kofq+RYi73t6wYAb3a20x3uxSdoe4b+jWXothd29SyWmNpI
	WpZ8FhTB/+uRMdZmzhwViLMl0u4fO/2TGFoyE959M03DVN0VOZBiAstNxSEUXIdnq3/9w4NKWq5
	3bkZYeiwdVImomUrSdhrCLaC7HGa2ZYCCRYZi3A7ggUg7GMuYMtOWyNTFYz
X-Received: by 2002:a05:620a:31a4:b0:93a:2e8:5afa with SMTP id af79cd13be357-93c2514141amr37871485a.30.1790101773423;
        Tue, 22 Sep 2026 11:29:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24889ac9sm37130085a.27.2026.09.22.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:33 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	jannh@google.com,
	pfalcato@suse.de,
	hannes@cmpxchg.org,
	shy828301@gmail.com,
	raghavendra.kt@amd.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] mm: support promotion-only NUMA hinting scans
Date: Tue, 22 Sep 2026 14:29:22 -0400
Message-ID: <20260922182928.2199090-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922182928.2199090-1-gourry@gourry.net>
References: <20260922182928.2199090-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gregory Price (Meta)" <gourry@gourry.net>

folio_can_map_prot_numa() derives folio eligibility from the global
balancing mode. The mode (normal, tiering, or combined) describes
which balancing mechanisms are enabled (placement vs promotion).

The global setting itself cannot describe the intent of an individual
protection walk because normal-mode tempers its scanning activity based
on a number of heuristics (read-only VMAs, activeness of VMA, etc).

In tiering or combined mode, applying these normal-mode optimizations
to an entire VMA is incorrect and breaks tiering.

 - Opting VMAs out of scanning because they became inactive obviously
   breaks tiering - because the intent is to identify when a VMA
   becomes active.  Applying it in tiering modes causes

 - Opting Read-only file VMAs out of scanning is just incorrect for
   tiering modes because its intent is to prevent bouncing between
   sockets (east-west), while tiering controls tier migration
   (north-south).  The result is hot read-only files can overload
   lower tier bandwidth.

Add MM_CP_PROT_NUMA_PROMO_ONLY and let task_numa_work() select the type
of walk. Build the change-protection flags there and pass them unchanged
through change_prot_numa() so its PTE/PMD paths use the same decision.

Have folio_can_map_prot_numa() derive the single-threaded private state at
the point of use instead of adding another precomputed boolean to the
protection-walk interface. This keeps the interface focused on scan intent
and avoids plumbing VMA-derived state beside cp_flags.

The tradeoff for the cleaner interface is an atomic mm_users read for each
folio, rather than once per PTE range. Check the promotion-only top-tier
exclusion bit first as a mild optimization.

The scan-intent interface is required by the following memory-tiering
fixes and must accompany them when backported.

Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
Cc: stable@vger.kernel.org
Suggested-by: David Hildenbrand <david@kernel.org>
Link: https://lore.kernel.org/r/4d2853c9-edf4-4685-b186-7214ed6abd84@kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mm.h  |  6 ++++--
 kernel/sched/fair.c |  7 ++++++-
 mm/huge_memory.c    |  3 +--
 mm/internal.h       |  4 ++--
 mm/mempolicy.c      | 27 ++++++++++++---------------
 mm/mprotect.c       |  7 +------
 6 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e3d29f87567f8..beab621e6f88d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3608,6 +3608,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
 #define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
 					    MM_CP_UFFD_RWP_RESOLVE)
+/* Whether a MM_CP_PROT_NUMA change is for promotion only */
+#define  MM_CP_PROT_NUMA_PROMO_ONLY        (1UL << 6)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
@@ -4980,8 +4982,8 @@ static inline void vma_set_page_prot(struct vm_area_struct *vma)
 void vma_set_file(struct vm_area_struct *vma, struct file *file);
 
 #ifdef CONFIG_NUMA_BALANCING
-unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long start, unsigned long end);
+unsigned long change_prot_numa(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, unsigned long cp_flags);
 #endif
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae6c1a606eb5d..9f544e3df9490 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4124,6 +4124,7 @@ static void task_numa_work(struct callback_head *work)
 	struct mm_struct *mm = p->mm;
 	u64 runtime = p->se.sum_exec_runtime;
 	struct vm_area_struct *vma;
+	unsigned long cp_flags = MM_CP_PROT_NUMA;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
@@ -4131,6 +4132,9 @@ static void task_numa_work(struct callback_head *work)
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
 
+	if (!(READ_ONCE(sysctl_numa_balancing_mode) & NUMA_BALANCING_NORMAL))
+		cp_flags |= MM_CP_PROT_NUMA_PROMO_ONLY;
+
 	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
 	work->next = work;
@@ -4307,7 +4311,8 @@ static void task_numa_work(struct callback_head *work)
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
 			end = min(end, vma->vm_end);
-			nr_pte_updates = change_prot_numa(vma, start, end);
+			nr_pte_updates = change_prot_numa(vma, start, end,
+							  cp_flags);
 
 			/*
 			 * Try to scan sysctl_numa_balancing_size worth of
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 493b29cabee59..da9cf87903a55 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2769,8 +2769,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (is_huge_zero_pmd(*pmd))
 			goto unlock;
 
-		if (!folio_can_map_prot_numa(pmd_folio(*pmd), vma,
-					     vma_is_single_threaded_private(vma)))
+		if (!folio_can_map_prot_numa(pmd_folio(*pmd), vma, cp_flags))
 			goto unlock;
 	}
 	/*
diff --git a/mm/internal.h b/mm/internal.h
index 0434dfcfc36f1..cbeaf1fc38cfc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1248,11 +1248,11 @@ static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 
 #ifdef CONFIG_NUMA_BALANCING
 bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
-		bool is_private_single_threaded);
+		unsigned long cp_flags);
 
 #else
 static inline bool folio_can_map_prot_numa(struct folio *folio,
-		struct vm_area_struct *vma, bool is_private_single_threaded)
+		struct vm_area_struct *vma, unsigned long cp_flags)
 {
 	return false;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4c0b8ff1a7e66..1427e1b6213b6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -847,7 +847,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
  * folio_can_map_prot_numa() - check whether the folio can map prot numa
  * @folio: The folio whose mapping considered for being made NUMA hintable
  * @vma: The VMA that the folio belongs to.
- * @is_private_single_threaded: Is this a single-threaded private VMA or not
+ * @cp_flags: Flags describing the protection change
  *
  * This function checks to see if the folio actually indicates that
  * we need to make the mapping one which causes a NUMA hinting fault,
@@ -857,7 +857,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
  * Return: True if the mapping of the folio needs to be changed, false otherwise.
  */
 bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
-		bool is_private_single_threaded)
+		unsigned long cp_flags)
 {
 	int nid;
 
@@ -880,22 +880,17 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
 		return false;
 
-	/*
-	 * Don't mess with PTEs if folio is already on the node
-	 * a single-threaded process is running on.
-	 */
 	nid = folio_nid(folio);
-	if (is_private_single_threaded && (nid == numa_node_id()))
+	/* Promotion-only scans do not mark top-tier folios. */
+	if ((cp_flags & MM_CP_PROT_NUMA_PROMO_ONLY) && node_is_toptier(nid))
 		return false;
 
 	/*
-	 * Skip scanning top tier node if normal numa
-	 * balancing is disabled
+	 * Don't mess with PTEs if folio is already on the node
+	 * a single-threaded process is running on.
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-	    node_is_toptier(nid))
+	if (vma_is_single_threaded_private(vma) && nid == numa_node_id())
 		return false;
-
 	if (folio_use_access_time(folio))
 		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
 
@@ -907,19 +902,21 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
  * These are later cleared by a NUMA hinting fault. Depending on these
  * faults, pages may be migrated for better NUMA placement.
  *
+ * @cp_flags carries the NUMA scan policy through the protection walk.
+ *
  * This is assuming that NUMA faults are handled using PROT_NONE. If
  * an architecture makes a different choice, it will need further
  * changes to the core.
  */
-unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long addr, unsigned long end)
+unsigned long change_prot_numa(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long end, unsigned long cp_flags)
 {
 	struct mmu_gather tlb;
 	long nr_updated;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
-	nr_updated = change_protection(&tlb, vma, addr, end, MM_CP_PROT_NUMA);
+	nr_updated = change_protection(&tlb, vma, addr, end, cp_flags);
 	if (nr_updated > 0) {
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 		count_memcg_events_mm(vma->vm_mm, NUMA_PTE_UPDATES, nr_updated);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e59c69cb5a238..7a247ed4cd55f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -335,7 +335,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
 	long pages = 0;
-	bool is_private_single_threaded;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_rwp = cp_flags & MM_CP_UFFD_RWP;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -346,9 +345,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 	if (!pte)
 		return -EAGAIN;
 
-	if (prot_numa)
-		is_private_single_threaded = vma_is_single_threaded_private(vma);
-
 	flush_tlb_batched_pending(vma->vm_mm);
 	lazy_mmu_mode_enable();
 	do {
@@ -383,8 +379,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 * must set protnone regardless of NUMA placement.
 			 */
 			if (prot_numa &&
-			    !folio_can_map_prot_numa(folio, vma,
-						is_private_single_threaded)) {
+			    !folio_can_map_prot_numa(folio, vma, cp_flags)) {
 
 				/* determine batch to skip */
 				nr_ptes = mprotect_folio_pte_batch(folio,
-- 
2.53.0-Meta

