Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458B499F0B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101783; cv=none; b=dG8bqthGJWSBXV6l3zUHjyGa6vL3PdMFW59lzSCcXK5MwzXFmbHlZ4EEITlootzC/GUFi1zWqqlIlcez8rpUTZHKXHaIm5XBjlPJOuMBVT5sH+wYp2s5whuOAjOhWMlHF8hYyqlNczfOhP4Lm1UFZMfAbHdJP+iE9SiFWoFvwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101783; c=relaxed/simple;
	bh=7YChvBHzQ8DGOUO9tClkDuQmXSsjmELLb2ZSb68vG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg34q+nPei+Rldj0f+USBTSfFix16y/LYVZi7QQn8jLKllyMY1iISBuMeRFaC5Vzao9+9IuWxbkIpngnZ9Q1hTucOofzkfUyhdUQfkQ9zqa+DNRP8Fbon86zZX1kttg2aieaLY3ZXgmpWKW/cD0V/npvVLFBYn8zovWZqfnBRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UTjSOxVp; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UTjSOxVp"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd3208so1314636d6.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790101779; x=1790706579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfgiKa+YRyMtK2RiU6jcCWMC566+XGPfa3bnqM4rs00=;
        b=UTjSOxVpdI8mvzzZDoYYaq9lRgOlymMuD5SWMdZOqm7xqmxK1ogfYNnelvFk/HlwEg
         mv7FGX+JvL0Q7NyJZ9AJsuQofX6Hs4HKRCrPn3Cg4p86CQ1wZS0pVzF2SAG78Gkw5/RF
         /Ocg5tuEUhHQp1anP6MqSYX5QTVM45EenfqzRlGV5yeKsIIofaDrTSDlqDFJikbMbNxX
         ixg2X45zr12ecZqwf8sxXWRakga38xDnZM7orcMhHKGkpgvOSlwh/3PnWMosdHjPNWIE
         PRw/0Bb1sLSirI7vXmZzjx1j2ddhMRNE4BwtWemjfHFjhof0Xyc+3KNfhc5saKyDcscs
         ug5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101779; x=1790706579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfgiKa+YRyMtK2RiU6jcCWMC566+XGPfa3bnqM4rs00=;
        b=wzP1RFO9igepACyoTTJqixBMO5aMAIn3KPVl+YITP3rI69HsQoTA8jyyWhdH9aZvph
         74JWBvXuxIRsOzyDC+p4lDW+jBkoQJa3i34LbVqhOLkGv46KlJshT+bUWcAwFrpcP0Ve
         HKsgx0cdvasjgKepC+MA1gT+VcvivsZkQpyG23NdLjce2g6PL++odENKRNJXXJxlR1QJ
         yJb8wUSRApCCimMCeA2xuEWfayHfdfshBzfV7Pi3H/kDMQS2lnk+fRJTfNyF2TNBdCqr
         VZqFUeRCEtwBxNuMHXvcoXR2sHPRR1SMv2Siyr/3eRqBngKWrGpxKzs308CAueIfVGUj
         n5+A==
X-Forwarded-Encrypted: i=1; AKwUvBxinS8/t0bLHfLLnsHc1Br5AQMu3j5NJ+bEIkcqoJtoZdvSAE2qM108kIH4QprGPMGhUWBvEsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mZV10pO/hDkyKBVX+cHMdt5caMvvxN3W0YgowmL2gHmH3u5DvD
	WPwWUEhz19mvG+QIrGF4LmY+rdadOWCe/mATzspjNE5z8ZWR31aryyFe4GFPdq5Isps=
X-Gm-Gg: AYBFou3+Pprc6344gVZOZYU9142w8eU9ZIxt+ZnNE+9ZKcAns02SSYRQwFDSzhAg/9R
	oxQnCMXwnXIJh1jc5g+dbDIM+ybpO1ML5+M5rOMMRr8wj28Z3tn21IOXpgpM0SOzlBUsCYJoW0Z
	kUarD1R8j254s7bvoZyTi2ab6zqz4wVY6SSRoJfChKIYTCb4+M50LeoBqzBcJKHiq0BeqmGnbVI
	WaEgn4/EBywOUWh5MDvJhOFEob0yYhwbXe53l043mwsrFuBCwKrlN/tmGd8mMzh0vOVaMAd/jUV
	0ewLH724wg9BsSC6tot7BwnPLtXKnfdrKMiEQeF6S+SUQHICNSsAMq3+ucLxCNeCcoZAoJkNlhM
	RcA1YFT2ZVVuk3gohkGvvJKya7NbjMSyiRuq4Ng033piYdTFuipkjzFquqxzaHdO9HHeFIwRZzN
	fwdG8NM875KWmmnYayk18rqNFy0ADe6/AjTnvutD6LmBxwYQOim0f5FMfvv+uRY0licocze15Ql
	REkYjghXVUhAMP181GmMYrfor6cO7BwRFG/C0Sk0BXxsQrmax9zk0QETrYH
X-Received: by 2002:a05:620a:27d5:b0:93b:d7a2:83d5 with SMTP id af79cd13be357-93c252aabb2mr34297885a.68.1790101778939;
        Tue, 22 Sep 2026 11:29:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24889ac9sm37130085a.27.2026.09.22.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:38 -0700 (PDT)
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
Subject: [PATCH v3 4/7] sched/numa: separate VMA placement from scan continuation
Date: Tue, 22 Sep 2026 14:29:25 -0400
Message-ID: <20260922182928.2199090-5-gourry@gourry.net>
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

vma_is_accessed() returns true both when a VMA needs placement
(east-west) sampling and when a VMA is already mid-scan across
multiple scan windows.

Callers cannot distinguish placement eligibility from scan progress.

Rename the helper to vma_needs_placement_scan() and handle continuation
state in task_numa_work(). Cache the scan eligibility decision while a
VMA is scanned in chunks so a resumed scan retains the existing policy.

This separation allows PID-inactive VMAs to be scanned for promotion
without treating scan continuation as evidence of placement eligibility.
It is a prerequisite for the following fix and must accompany it when
backported.

Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mm_types.h |  3 +++
 kernel/sched/fair.c      | 42 ++++++++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 77c90b1994131..fd35db969bc94 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -803,6 +803,9 @@ struct vma_numab_state {
 	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
 	 */
 	int prev_scan_seq;
+
+	/* Preserve placement-scan eligibility during an in-progress scan. */
+	bool placement_scan;
 };
 
 #ifdef __HAVE_PFNMAP_TRACKING
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a4687f67d82f..a2849e72c4e26 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4074,7 +4074,8 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
-static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
+static bool vma_needs_placement_scan(struct mm_struct *mm,
+		struct vm_area_struct *vma)
 {
 	unsigned long pids;
 	/*
@@ -4090,15 +4091,6 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
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
@@ -4133,7 +4125,8 @@ static void task_numa_work(struct callback_head *work)
 	struct vma_iterator vmi;
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
-	bool placement_scan;
+	bool pid_scan_allowed, placement_due;
+	bool placement_scan, scan_started;
 
 	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
@@ -4304,16 +4297,30 @@ static void task_numa_work(struct callback_head *work)
 		}
 
 		/*
-		 * Do not scan the VMA if task has not accessed it, unless no other
-		 * VMA candidate exists.
+		 * Do not scan the VMA if a task has not accessed it, unless no other
+		 * VMA candidate exists. If a scan is already in-progress, finish it,
+		 * but track continuation separately from starting a new one.
 		 */
-		if (!vma_pids_forced && !vma_is_accessed(mm, vma)) {
-			vma_pids_skipped = true;
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
-			continue;
+		placement_due = vma_needs_placement_scan(mm, vma);
+		scan_started = mm->numa_scan_offset > vma->vm_start;
+		pid_scan_allowed = vma_pids_forced || placement_due;
+
+		if (!pid_scan_allowed) {
+			if (scan_started) {
+				trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
+			} else {
+				vma_pids_skipped = true;
+				trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
+				continue;
+			}
 		}
 
+		/* Keep scan policy stable while processing a VMA in chunks.*/
 		placement_scan &= numab_mode & NUMA_BALANCING_NORMAL;
+		if (scan_started)
+			placement_scan &= vma->numab_state->placement_scan;
+
+		vma->numab_state->placement_scan = placement_scan;
 		cp_flags = MM_CP_PROT_NUMA;
 		if (!placement_scan)
 			cp_flags |= MM_CP_PROT_NUMA_PROMO_ONLY;
@@ -4346,6 +4353,7 @@ static void task_numa_work(struct callback_head *work)
 
 		/* VMA scan is complete, do not scan until next sequence. */
 		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
+		vma->numab_state->placement_scan = false;
 
 		/*
 		 * Only force scan within one VMA at a time, to limit the
-- 
2.53.0-Meta

