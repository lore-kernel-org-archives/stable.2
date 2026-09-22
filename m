Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB549B44C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101785; cv=none; b=tLKWbTCpYnSRNYkMZ+hn9ddlCn3NITGI9pFrYX9t4AOP6ZQ435OCj+rijshCxVpgeA8bOX8NCdiQqRIMOVpiXkR6WbwJ0SeCsiqpAuV5MWK6Vac40yoBZoBWRrfDon3DyZdseI5OlO3Z2kZ3U9PT8rLkE090/WgNrO8Q/Gni7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101785; c=relaxed/simple;
	bh=k4NugTQESVNugUzaMMuu3OYQl8Um++AA2GKnIZL6+Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5uwiddw+u5An+EXAv0DcRYM8kSacdbAhMIdwxUr0xQSdiIYEzeySsj5m+FumeUsCehX6ZESALe5C4iW3JKECJKlJSsXmyyq+5GiAhjCCWKKvriYzzlLn7yc/P/JX3MFWgJtLbyU3L7pYfmVcsXZ8JvxC0rVPHRXPJxoAcgRPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iIAb+tlh; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iIAb+tlh"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d0d5ae11so2127461cf.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790101781; x=1790706581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axWZscC+v0nVIusaiMTv07a6IEIvhtM/ylITkcHKQpY=;
        b=iIAb+tlh2BOcjhJcOrzMjhd4U8PGcMXr/VmEIkt0r/qX5dYnOCBBBz+L3fbUg8b9ko
         aEl/h9+uN5s/pgSDqerKUIYiUsGJCMwkAqi8EBWWYd91ImqART76LVXn3CIJekS/eRhS
         eXR66VE+rQeXqgUobSYlX4psLSDyOPa5x8GeHpyZnYT96liwR+cB6MhFd08gqdWVPsUD
         tEcDVkqF9kvEqUzt7NoGueZ8ZmeEkQccVnLFGGP/AG8ullsb6DV4q8eleFXScAYg7f0m
         PvWRw1lGqwXWYQGefToMK30D5anbpG2YeLJ97UTK5jB+EZ9FQ0wAXXyuUVmWNB3wHA6F
         t1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101781; x=1790706581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axWZscC+v0nVIusaiMTv07a6IEIvhtM/ylITkcHKQpY=;
        b=y/PuiR5uSMxYbCaqkmwOxIlJGgMRnyXMs7tFiDrv+7AwRr8m7n7bLP6EYwm4V0Mu3c
         ubH9bwlHPlUHNQ/1e/8SHXch4iycDDnK7Hh39M4WxQ44AAPV7roKH8pkCgNR1IhWXJwE
         F07hMQ3AaYFfTC0wv8LDjj1KkstnWWAfBIAot/MheM9hkJZWgg1TwM97srHMvs2hoSwB
         EUaipC48H/TrnEBXQ0R7RLWpBjqyU9JRhdZ4c1ubHWt1ruMiRr8ZJpp+QgJcQgKX8jFo
         2hptMta2m+fEJQHIhXSuLgMC1KJf0UBwb/XkqovSS6LBWuCrF4YDsGDlwpUraLrssi6F
         FAVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEYe+ejLv97/IccjM3B4w8N7V9QbW8t0B0sWD6ksoe7UEJdOtAMYF9wBnYvZz365bsbGRvkck=@vger.kernel.org
X-Gm-Message-State: AFuF++kISNTWg8M8OR0yU4mK2UVEWS/N0ozrDVBOXjN02ixR21Rf5Jao
	dvwMNL2EOI1wHu7GB+Do2Q9mZeXPmlWSwLPLMvw0VzktCvAYeuwkJ4F/T3w+5SHifx8=
X-Gm-Gg: AYBFou3+/HDtiLmFaMLhVC8WczybbLbO7MxTkBCu19YwqIM2DCvJoTBWDPkZrzsI1j1
	lU1uvk3zzKERSForNLLpzIp4Ev4zv0y9q/yICB/4IJNChYc0/eA/nzjiFpb0W2Y0QDWdeS6iqx7
	Ty+/30WgqmYrF//4ZqlvBqdOHvljKk4MpjL8KjYqIYPRJ00lYZqlu9xOFKFbk9TTbz+dbGGL970
	8WQXwvB3P+b6VHrFYVTHQW9QH/mySgivQOLga+3up1IvVok37c3j82twNdspbdufp7674OHk5b7
	d3U3cOJQ0VT92DJtL5qnyqhvlTqQAoDL+9rSVPsUJuHtHUDPPieMz8uDrmeOw7GkHrJk3X0kO8K
	P17pwfV7XNDdJ/E5Yfu4lPMyR8kz/m9aAZbHZfAHFNs2rA+kJ9inmJxydRXF7CTkPUTmcqyT9H/
	onQP7Rt1CSZgKaor+lBVa5nn4G+Rpb+5aY5vuNLsde0dPg7GHl7e3JQWoBaj/3s+16S14ukRFXt
	64rfrzVu9tuv6FEGqlcnYIjsenlrdOAIwGWBx3z01HuqaRKU3FycUPaLW95iDlgebDrLAQ=
X-Received: by 2002:a05:620a:1d02:b0:93b:d7a3:45de with SMTP id af79cd13be357-93c252538f6mr36699785a.71.1790101780908;
        Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24889ac9sm37130085a.27.2026.09.22.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
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
Subject: [PATCH v3 5/7] sched/numa: scan PID-inactive VMAs for promotion
Date: Tue, 22 Sep 2026 14:29:26 -0400
Message-ID: <20260922182928.2199090-6-gourry@gourry.net>
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

Commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic") skips
VMAs without recent PID activity. Since only NUMA hint faults record
that activity, the filter can suppress the fault needed to promote hot
slow-tier memory.

Let memory tiering bypass the PID scan filter. In combined mode, use the
placement decision to restrict top-tier sampling to VMAs that need it,
while inactive VMAs still receive promotion-only scans.

Track the last completed placement scan separately from scans of any
kind. Promotion-only scans still update prev_scan_seq, but do not
advance the placement-starvation horizon.

On a host with 768 GB of DRAM and 256 GB of CXL memory, one large shmem
VMA consumed most scanning activity, while 2,537 other VMAs covering
84 GB were skipped as inactive. One stand-out result: a hot 20 GB hash
table ended up trapped entirely on CXL and drove CXL bandwidth
utilization beyond sustainable levels - resulting in a large regression.

With this series, the hot hash table ends up split evenly between DRAM
and CXL, tier residency tracked runtime load, and CXL bandwidth
utilization drops from 45GB/s (maxed) to 5-10GB/s, while DRAM bandwidth
utilization increases from ~200GB/s to 250GB/s+, resulting in major
throughput improvements for the database workload.

Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-5
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mm_types.h |  7 +++++++
 kernel/sched/fair.c      | 26 +++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fd35db969bc94..dcca3ead9db59 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -804,6 +804,13 @@ struct vma_numab_state {
 	 */
 	int prev_scan_seq;
 
+	/*
+	 * MM scan sequence ID when the VMA was last scanned for placement.
+	 * The starvation horizon in vma_needs_placement_scan() counts against
+	 * this, so promotion-only scans cannot postpone placement indefinitely.
+	 */
+	int prev_placement_scan_seq;
+
 	/* Preserve placement-scan eligibility during an in-progress scan. */
 	bool placement_scan;
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2849e72c4e26..412c72084a63d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4097,7 +4097,7 @@ static bool vma_needs_placement_scan(struct mm_struct *mm,
 	 * threads can help scan this vma, force a vma scan.
 	 */
 	if (READ_ONCE(mm->numa_scan_seq) >
-	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
+	   (vma->numab_state->prev_placement_scan_seq + get_nr_threads(current)))
 		return true;
 
 	return false;
@@ -4267,7 +4267,8 @@ static void task_numa_work(struct callback_head *work)
 			 * to prevent VMAs being skipped prematurely on the
 			 * first scan:
 			 */
-			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
+			vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
+			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq - 1;
 		}
 
 		/*
@@ -4300,10 +4301,13 @@ static void task_numa_work(struct callback_head *work)
 		 * Do not scan the VMA if a task has not accessed it, unless no other
 		 * VMA candidate exists. If a scan is already in-progress, finish it,
 		 * but track continuation separately from starting a new one.
+		 *
+		 * The PID filter must not gate promotion. Allow PID-inactive VMAs
+		 * to proceed when memory tiering is enabled.
 		 */
 		placement_due = vma_needs_placement_scan(mm, vma);
 		scan_started = mm->numa_scan_offset > vma->vm_start;
-		pid_scan_allowed = vma_pids_forced || placement_due;
+		pid_scan_allowed = tiering || vma_pids_forced || placement_due;
 
 		if (!pid_scan_allowed) {
 			if (scan_started) {
@@ -4315,10 +4319,16 @@ static void task_numa_work(struct callback_head *work)
 			}
 		}
 
-		/* Keep scan policy stable while processing a VMA in chunks.*/
+		/*
+		 * Keep scan policy stable while processing a VMA in chunks.
+		 * A fault in one chunk can make a VMA placement-eligible. Keep a
+		 * promotion-only decision sticky for the rest of a partial scan.
+		 */
 		placement_scan &= numab_mode & NUMA_BALANCING_NORMAL;
 		if (scan_started)
 			placement_scan &= vma->numab_state->placement_scan;
+		else if (tiering)
+			placement_scan &= placement_due;
 
 		vma->numab_state->placement_scan = placement_scan;
 		cp_flags = MM_CP_PROT_NUMA;
@@ -4351,8 +4361,14 @@ static void task_numa_work(struct callback_head *work)
 			cond_resched();
 		} while (end != vma->vm_end);
 
-		/* VMA scan is complete, do not scan until next sequence. */
+		/*
+		 * VMA scan is complete, do not scan until next sequence.
+		 * A promotion-only scan did not cover top-tier folios, so it
+		 * does not count towards the placement-scan starvation check.
+		 */
 		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
+		if (placement_scan)
+			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq;
 		vma->numab_state->placement_scan = false;
 
 		/*
-- 
2.53.0-Meta

