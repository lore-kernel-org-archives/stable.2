Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D51A6813
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085918; cv=none; b=rdYZ9k6569ImpUEJo2d62m8/2dRRBzG8qy1zc6Ya6kFT6+egu79ODOSZnchd+I7IcNqOLpYSgprKpMVeWTYue5TwXvEvkqLY7mZ5/U0Noo0toO3eS7ZXwvDUDumKu+UTWy/Zp9O2iLjSsI5I70B1cyLlVwTZ4EhC+Jva8HLFyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085918; c=relaxed/simple;
	bh=Jljp3ztDhFP6O+PAfvk83+8GLPXNCVYLh8IZWY/KNiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNcujlIATTN/G+kgg/H65a97au0N8KkUKc8VRqreH/hf/V1st4r6W2Nj8njedgHy3+wGUXE0aSfLYlG1tvZ9u3JzBT8W7PvDdyacrEv7E33UVBbmfNfs/HRxfUfNQNNNV0VgBdCP8Y3VcPDBXpbcS4MLw7rHVNEUUjznG8MALqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s2N61fim; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s2N61fim"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9309d4ea213so34381085a.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789085915; x=1789690715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XlfoGyQgrNSRVIxWxP7qSy7UsF5M3AH+3KUxqb60W44=;
        b=s2N61fim4h9Hyo1KG80u1cKEqeKti0m5D1U0+FTkwcCoc7rOkZzPPx6Pty7Jjojqkf
         xmzAC1oIaD/AvxQJQI5isg6B2kBJ7OhwYUiDyzjq/NtY5z8LghxbWKFg2lZUQsF+3dHX
         noFPRbxcoFRvL5jmnafdtrWxWG/eK/JYj7bSWnLWfixKDAotQyoK0PebTZxqnI9Ll/fv
         /8wTWgTHzPv7zyDfhFcZWXoxHYsnAwCyR3wYgUsq95SIVJYKb7EzOBJ0wWAV4CszNCi4
         rIjJZwMbZToZdUjNRm8Tzi60Ws2RkTB899x5fSbHd4KE+iBiG/loyAsu24eSV/hNwvjB
         byQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085915; x=1789690715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XlfoGyQgrNSRVIxWxP7qSy7UsF5M3AH+3KUxqb60W44=;
        b=qdUm2CaV/Jk7Teizdx8mMnuuClhrWT+WaBy+LdIV88Sqz6EKNMMuVb7NNxv6qftRRw
         xAP2VboPJhUq6dKYU7a65yE7J5iOBGAfXkqAmpQX3WZuE0jwqF3+mXcD1OnITvWfKcfr
         Ki9VZEbYlyQfvPIjhQLAL5ivfYuY/uGMPYutGVfpdJXu+7AhyGwf9CP/63U9EiuL6xdi
         lngY7OUdZbBn3oLPrs5Z2tlR82HKOqkSWurgO1s0s2SAL/9EG4nQJPLatR3F9l2jZVsv
         9gbM5Ag1T41oDLBTQTrx9yXH7WvXBUtRvraqi6ky4WFDbSgWeFEgziqs6wkZURYmLOBx
         VUDA==
X-Forwarded-Encrypted: i=1; AKwUvBzkWGeKqSWjC9HnqUGgbgUdElqB0tOWAsbKrYfSMQm9dbFJ9PDaDmMVoOXbKxdCPqj9MS5rYls=@vger.kernel.org
X-Gm-Message-State: AFuF++mYy/+vgv09xpTWOHvEPXXibu/8zlIkobTQ42FgUoaccIJ6ojSi
	tc8B2JxLThR8M+ivdMudsnSG1re1xerOSY03IROj+mPAhFAx7Ig439gzuulX4TRhPW4=
X-Gm-Gg: AYBFou0YpaS+l1VR+yfFSUsxqlXjbyBoYUdVK91K+6vtu/0MXcEmwq17x56+dLdzG1X
	ZHWqp+aTMDM1df2oguIay31DO/USlCrsH37mTKheq7RAl6EgcHLsk8hMGrmDO3CKpEiitRAgX+a
	EwSzaRq79FlFTFTiUFBcVa8y6ASk7OBuuX5HevIGFdLSc+kO+a3BfePJ2m6m4XckT8zvh6gUlig
	98rXpHSeNYGuxJjwykzr4PNI6bPGT7UlUg9VToc6czbafPaqPLSOgGl7jhF3GItUhHNDjGCuEd5
	ytApR3VKZrNdMc5iejrKkkh5YRiJEEV+P1vdV5Yw8xCI9QDHK48WWMKhy2Pz6bZ2zigzCkMtjTJ
	3COEH281Dm6C7dXv50LHl5Hui9zthI35TONOmzEdLjGog9ReTAgRuYAeJYKa+JNprxVOGmgqw0x
	dE0axJ/SO/Q4FyYsWRVgzbrszHstLGnpLZKevry8Iu4EjBMKwZJvo2Yci+2mtqhhCJqG7eu6Kpd
	9b/SJVdnskfz2Ke20q/Ew32fAfatpWOooE6rK+n0RmF41VNm8Rsomku1zMiUA==
X-Received: by 2002:a05:620a:2989:b0:939:7f2f:b17e with SMTP id af79cd13be357-939e9efcaf8mr205827185a.30.1789085914637;
        Thu, 10 Sep 2026 17:18:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80e4c36sm108896485a.40.2026.09.10.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 17:18:34 -0700 (PDT)
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
	osalvador@suse.de,
	hannes@cmpxchg.org,
	raghavendra.kt@amd.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] mm: support promotion-only NUMA hinting scans
Date: Thu, 10 Sep 2026 20:18:23 -0400
Message-ID: <20260911001826.2109390-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911001826.2109390-1-gourry@gourry.net>
References: <20260911001826.2109390-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gregory Price (Meta)" <gourry@gourry.net>

folio_can_map_prot_numa() derives the eligible memory from the global
balancing mode. Combined mode needs the scanner to distinguish placement
scans from promotion-only scans.

Add MM_CP_PROT_NUMA_PROMO_ONLY and let change_prot_numa() callers request
a promotion-only protection walk. Carry the choice with each walk so the
PTE and PMD paths use the same decision.

Initially derive the value from the normal balancing mode, preserving the
existing behavior for the following fixes.

Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mm.h  |  4 +++-
 kernel/sched/fair.c |  7 ++++++-
 mm/huge_memory.c    |  3 ++-
 mm/internal.h       |  5 +++--
 mm/mempolicy.c      | 22 +++++++++++++---------
 mm/mprotect.c       |  4 +++-
 6 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 969594074fd2..2d1b59a27629 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3408,6 +3408,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
 #define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
 					    MM_CP_UFFD_RWP_RESOLVE)
+/* Whether a MM_CP_PROT_NUMA change is for promotion only */
+#define  MM_CP_PROT_NUMA_PROMO_ONLY        (1UL << 6)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
@@ -4736,7 +4738,7 @@ void vma_set_file(struct vm_area_struct *vma, struct file *file);
 
 #ifdef CONFIG_NUMA_BALANCING
 unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long start, unsigned long end);
+			unsigned long start, unsigned long end, bool promo_only);
 #endif
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dff37059faf..81359b414947 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4129,8 +4129,10 @@ static void task_numa_work(struct callback_head *work)
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
 	struct vma_iterator vmi;
+	unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
+	bool promo_only;
 
 	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
@@ -4304,11 +4306,14 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
+		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL);
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
 			end = min(end, vma->vm_end);
-			nr_pte_updates = change_prot_numa(vma, start, end);
+			nr_pte_updates = change_prot_numa(vma, start, end,
+							  promo_only);
 
 			/*
 			 * Try to scan sysctl_numa_balancing_size worth of
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 30b7c63b0e35..2f9ada1bbcfc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2784,7 +2784,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			goto unlock;
 
 		if (!folio_can_map_prot_numa(pmd_folio(*pmd), vma,
-					     vma_is_single_threaded_private(vma)))
+					     vma_is_single_threaded_private(vma),
+					     cp_flags & MM_CP_PROT_NUMA_PROMO_ONLY))
 			goto unlock;
 	}
 	/*
diff --git a/mm/internal.h b/mm/internal.h
index 0dca33db068f..f3e093168f84 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1237,11 +1237,12 @@ static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 
 #ifdef CONFIG_NUMA_BALANCING
 bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
-		bool is_private_single_threaded);
+		bool is_private_single_threaded, bool promo_only);
 
 #else
 static inline bool folio_can_map_prot_numa(struct folio *folio,
-		struct vm_area_struct *vma, bool is_private_single_threaded)
+		struct vm_area_struct *vma, bool is_private_single_threaded,
+		bool promo_only)
 {
 	return false;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2ad0a5f18280..a082ccfa09ec 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -846,6 +846,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
  * @folio: The folio whose mapping considered for being made NUMA hintable
  * @vma: The VMA that the folio belongs to.
  * @is_private_single_threaded: Is this a single-threaded private VMA or not
+ * @promo_only: Whether this scan should only collect promotion candidates
  *
  * This function checks to see if the folio actually indicates that
  * we need to make the mapping one which causes a NUMA hinting fault,
@@ -855,7 +856,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
  * Return: True if the mapping of the folio needs to be changed, false otherwise.
  */
 bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
-		bool is_private_single_threaded)
+		bool is_private_single_threaded, bool promo_only)
 {
 	int nid;
 
@@ -886,12 +887,8 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (is_private_single_threaded && (nid == numa_node_id()))
 		return false;
 
-	/*
-	 * Skip scanning top tier node if normal numa
-	 * balancing is disabled
-	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-	    node_is_toptier(nid))
+	/* Promotion-only scans do not collect NUMA placement samples */
+	if (promo_only && node_is_toptier(nid))
 		return false;
 
 	if (folio_use_access_time(folio))
@@ -905,19 +902,26 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
  * These are later cleared by a NUMA hinting fault. Depending on these
  * faults, pages may be migrated for better NUMA placement.
  *
+ * With @promo_only only folios eligible for promotion are made
+ * hint-faultable, without also sampling for task placement.
+ *
  * This is assuming that NUMA faults are handled using PROT_NONE. If
  * an architecture makes a different choice, it will need further
  * changes to the core.
  */
 unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long addr, unsigned long end)
+			unsigned long addr, unsigned long end, bool promo_only)
 {
+	unsigned long cp_flags = MM_CP_PROT_NUMA;
 	struct mmu_gather tlb;
 	long nr_updated;
 
+	if (promo_only)
+		cp_flags |= MM_CP_PROT_NUMA_PROMO_ONLY;
+
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
-	nr_updated = change_protection(&tlb, vma, addr, end, MM_CP_PROT_NUMA);
+	nr_updated = change_protection(&tlb, vma, addr, end, cp_flags);
 	if (nr_updated > 0) {
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 		count_memcg_events_mm(vma->vm_mm, NUMA_PTE_UPDATES, nr_updated);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2888ee638d87..4e66e4c7665b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -337,6 +337,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 	long pages = 0;
 	bool is_private_single_threaded;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool numa_promo_only = cp_flags & MM_CP_PROT_NUMA_PROMO_ONLY;
 	bool uffd_rwp = cp_flags & MM_CP_UFFD_RWP;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	int nr_ptes;
@@ -384,7 +385,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 */
 			if (prot_numa &&
 			    !folio_can_map_prot_numa(folio, vma,
-						is_private_single_threaded)) {
+						is_private_single_threaded,
+						numa_promo_only)) {
 
 				/* determine batch to skip */
 				nr_ptes = mprotect_folio_pte_batch(folio,
-- 
2.55.0

