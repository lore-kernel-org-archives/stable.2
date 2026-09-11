Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBC27FD4F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085923; cv=none; b=Dtx/aDQUY2PBWlHI1fZIeUKMPlbym1lgHt/HQtNm//t2zE3To+YRdYYQytL8kQu/C4TbYkdWjET7B9mCtrX6fIc8VCr9Ivuj6Z1cOSHjnonOvKIwpnIx9evVxr1AvlroIv0VSJ+GWIbhmHudQ7jvl0qneSv4m1BUj07FEPXpjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085923; c=relaxed/simple;
	bh=Egofb6FnPwJOzI2OGYLWyIi9uKbwLgCrzOqXLr2nxM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8OhalX41wdHezZn3Iu0HRU8PT2QBIOo3WgqFyRfRgNIcTfDUZmh//PckGGA4FC69DwOxQFgBBKnZ5G7MbzYkaMDhP/NHNAYt4FWviGdlPY4X3KHO70pX35/XxpLBy9TdR4DdnxU+J1D1hNEU5H+cgN7xUiUh4k53VyqBvQRaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WhWxV6o4; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WhWxV6o4"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939949d9c33so31022585a.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789085920; x=1789690720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sdb+na/h6ecDzLaWx78ptxSH3vM79ZXkyzQFAMwq7RI=;
        b=WhWxV6o4tedF4d1afpB6KR3vD1WhgVxoDVIdBhjDHlo9I1XaoAei587YIp82o1QGwC
         Z6LasDuv5mubK4t2ZnAuEbaqPvYWEVxwe+B38U1WbaW1CC+r2TldG4nwqfhzgL2LShuu
         +X65qViLESm3vimf5xzoPDKcga3QqlE4m96ldI44HJLA5+wCwvTMX/B0gTuTpetqtir+
         ztpAt58mAf0pK3X349znXMN4Gkc2ybgHv6fmD13dMe+f1flblJHJOPksxQc0P8mftoNJ
         JhQDAOgL5ZFnxf1Y3SLPPqaZRzqzY19mHyHGZ/BMZjAB7pCsm6sZ6Lvo91AJKphZtfB4
         O5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085920; x=1789690720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sdb+na/h6ecDzLaWx78ptxSH3vM79ZXkyzQFAMwq7RI=;
        b=Cw/x7Re1axDt/9wqPZPW03YEvT04+1fsQ3ztrS5kzj0g2/hbduVTjVlp296nEADbGu
         0qUsw2NeHpID2N/HL7CKTeXfTVLw66KFswueiLyEAFds0xphxCuNQ6Pa1hDfmoS/sBlw
         g4AxidK/fZah4il1MzzEunm/Xu1ndRIvTlR64lfyYL4YGI76R0l4zrzj3t8TlvJlWGhz
         t9102xVLx82smr6OYH8YAf11Bk7dxHd+98jvjcMwWcbARifI3xU6FLVIgiH/ElINtZEh
         oV8BrfcnckklyvBAVrzTjFji//V9Cj41+nB/iDAZhrVgcCaZkZ/ulJm3kfyTBQYDQ6RH
         9NLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6onlNVWGeGVlLVfgXzWIDjQmpT89M+bFwOoagxMcM1MDR7aiLW07Br3BtrMeLWbwVjx5y2S8=@vger.kernel.org
X-Gm-Message-State: AFuF++meg6LCBciRyItodmxcPVMrhOPfqVAAx+A/V8bqy+ug5QOW1qkC
	VHidAfoEl80+uXmy/ndkaLm8SUn1GCVM4P7t/Bek4dYVFBYwe7x+3g4z0K3ngvFOciA=
X-Gm-Gg: AYBFou2dWy4v+IOINQtW4FC7ammWpO5RN4KkOHWEt201Loj+eeffUoHnUke+QN9T3dY
	8zquFUxomQHP4Uj3Dc4Eh4n49HKSDtNvltk4RE/O28/o0fnsM/5PdGlCDn7IIScQdDX2YTOkWUi
	x54bGPeAOP1G6MFsuddZys9C0U7PnuOWc0eM0shNH8CRUDxGONqhE+QtVFH6tWjLaxgvCdNOBnt
	XWVdad9arApa4UAk+EKw0JkC7kn/wuGoLtgEW5YBgzbq66hmk8zkx+rDWfMvX6sd0xWrVCAFeIF
	2JxcRNayRYn8qSRK3fJzHS40bQk/8NhrqYlUbgKxloFDH5XbEfH299mguilZY1oXc7YWLSnEI90
	fIGhOYUPa7fWL+40ecwndkSPtGdYCQB3UWcuEddoQ3eIiZZxDIBQlFXwMsxBy72ltSXZvbmvQ12
	c0nPFM9Q9lcAuXnpZhgWGUfkxpUvFZeSqroTWrG20jB0ErCIyWvHQqj0YKHZxzLFQin4AKf+0hm
	DeAOj/HQ9N6F7SyhwFDYDMtg1qwOH7YgjsFcD3SvkH1l1O6h7Kzf+rON4kt
X-Received: by 2002:a05:620a:270c:b0:939:a3a0:9a70 with SMTP id af79cd13be357-939ea0a39e2mr191963485a.18.1789085920053;
        Thu, 10 Sep 2026 17:18:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80e4c36sm108896485a.40.2026.09.10.17.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 17:18:39 -0700 (PDT)
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
Subject: [PATCH v2 4/4] sched/numa: do not let VMA PID activity gate promotion
Date: Thu, 10 Sep 2026 20:18:26 -0400
Message-ID: <20260911001826.2109390-5-gourry@gourry.net>
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

Commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
skips VMAs without recent PID activity. Since only NUMA hint faults record
that activity, the filter can suppress the fault needed to promote hot
slow-tier memory.

In tiering mode, scan PID-inactive VMAs using promotion-only scans.
Reevaluate this choice whenever the scanner visits a VMA and pass it with
each protection walk.

Record socket-placement scans in prev_placement_scan_seq. Promotion-only
scans still update prev_scan_seq, but no longer postpone the starvation
fallback for placement scans.

On a host with 768 GB of DRAM and 256 GB of CXL memory running two roughly
430 GB database workloads, a large shmem VMA occupied each scan while 2,537
other VMAs covering 84 GB were skipped as inactive. A hot 20 GB hash table
remained entirely on CXL before this change and was split evenly between
DRAM and CXL afterwards.

Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mm_types.h |  7 ++++++
 kernel/sched/fair.c      | 48 ++++++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5413bd10fff2..9f042d6ad465 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -803,6 +803,13 @@ struct vma_numab_state {
 	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
 	 */
 	int prev_scan_seq;
+
+	/*
+	 * MM scan sequence ID when the VMA was last scanned for placement.
+	 * The starvation horizon in vma_is_accessed() counts against this, so
+	 * promotion-only scans cannot postpone placement indefinitely.
+	 */
+	int prev_placement_scan_seq;
 };
 
 #ifdef __HAVE_PFNMAP_TRACKING
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e636e8de53f1..6d1da13a2ef5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4085,6 +4085,10 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+/*
+ * Decide whether this VMA should be sampled for NUMA placement.  In addition
+ * to recent accesses, periodically allow a scan to avoid starvation.
+ */
 static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	unsigned long pids;
@@ -4101,22 +4105,13 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
 		return true;
 
-	/*
-	 * Complete a scan that has already started regardless of PID access, or
-	 * some VMAs may never be scanned in multi-threaded applications:
-	 */
-	if (mm->numa_scan_offset > vma->vm_start) {
-		trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
-		return true;
-	}
-
 	/*
 	 * This vma has not been accessed for a while, and if the number
 	 * the threads in the same process is low, which means no other
 	 * threads can help scan this vma, force a vma scan.
 	 */
 	if (READ_ONCE(mm->numa_scan_seq) >
-	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
+	   (vma->numab_state->prev_placement_scan_seq + get_nr_threads(current)))
 		return true;
 
 	return false;
@@ -4142,7 +4137,7 @@ static void task_numa_work(struct callback_head *work)
 	unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
-	bool promo_only;
+	bool accessed, scan_started, promo_only;
 
 	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
@@ -4278,6 +4273,7 @@ static void task_numa_work(struct callback_head *work)
 			 * first scan:
 			 */
 			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
+			 vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq - 1;
 		}
 
 		/*
@@ -4307,17 +4303,30 @@ static void task_numa_work(struct callback_head *work)
 		}
 
 		/*
-		 * Do not scan the VMA if task has not accessed it, unless no other
-		 * VMA candidate exists.
+		 * The PID filter must not gate promotion.  Scan PID-inactive
+		 * VMAs in tiering mode using promotion-only scans.
 		 */
-		if (!vma_pids_forced && !vma_is_accessed(mm, vma)) {
+		accessed = vma_is_accessed(mm, vma);
+		scan_started = mm->numa_scan_offset > vma->vm_start;
+
+		if (!vma_pids_forced && !accessed && !scan_started &&
+		    !(numab_mode & NUMA_BALANCING_MEMORY_TIERING)) {
 			vma_pids_skipped = true;
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
 			continue;
 		}
+		if (!vma_pids_forced && !accessed &&
+		    !(numab_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+		    scan_started)
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
 
+		/*
+		 * In combined mode, only VMAs the task uses need placement
+		 * samples. Without tiering, every VMA reaching here does.
+		 */
 		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL) ||
-			     vma_is_ro_file(vma);
+			     ((numab_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+			      !accessed) || vma_is_ro_file(vma);
 
 		do {
 			start = max(start, vma->vm_start);
@@ -4345,8 +4354,15 @@ static void task_numa_work(struct callback_head *work)
 			cond_resched();
 		} while (end != vma->vm_end);
 
-		/* VMA scan is complete, do not scan until next sequence. */
+		/*
+		 * VMA scan is complete, do not scan until next sequence.  A
+		 * promotion-only scan reached the end of the VMA but did not
+		 * sample placement, so it does not count towards the starvation
+		 * horizon in vma_is_accessed().
+		 */
 		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
+		if (!promo_only)
+			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq;
 
 		/*
 		 * Only force scan within one VMA at a time, to limit the
-- 
2.55.0

