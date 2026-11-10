Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323103;
	b=U1ZX6ZiE8QDhQPL1WWqyew6rogZRK1vPxzUhvq23jPhyWcAz0bHZHITr9XIuG9wgS6Ko
	 iQL/rRWtrz0s9ni6OnNH5YcwcycEis70s/1gP/tLnxzAryv9rVUAG3ldYLkfaGr/hn7th
	 HodMjoJwILIr3gsARZy/VDshkGmyPUXqF0CdYo44JMi/JQH/jwXMTEjKmdBNgAupGl4ay
	 puZiQxh0X86PLAPenN4mgI9Ltiip1RTVXxm5CTf+4IfWI9AEbtXwLu0zkh26n9Qca75Im
	 5whR0+inC1d7xJFpCJO7v5QQ03L41RX3TPOcN9GjcuOIc57cWcgAJ8l4Yw+kNYQUwxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TDkJzFh0bkGIcyIq5xVYxCRO2DZY5fQgIX/NBTvaYAc=;
	b=kzipt0t5MACu1JloKt6HKZdmS28T517YCjCa9r3rk11VmjYlj9DyXfhXLFOAA9eaf7TB
	 kFe1LP9R4WAN11Zff/5AjxJQgKWWRpEy5y9YQNTPXW0qGNkbNOkCHe+C2hWQ8xFwmsbvN
	 3EGXIlcAa8pEpSZH+prAsn5l9wII8I+DESPW6E2jJ297MKpIwUJhIhMf/yaj7O6MNtaMT
	 kFJi40Jt5mOPKtPKX/82eTqtj20HzQPfzeUYkU2qvUpWuYnvv3KDVVzfHLL+BR4jvsULm
	 6nezplDO7E9QiO0TBBkp4RO2Zn4ZI/5iAwad9vkziCIBrgiIx+siOb+2r7YP+8+gQ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=OeAfKayF;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DA60A2637
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3DA60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=OeAfKayF
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb7d1478cso21041316d6.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794323101; x=1794927901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TDkJzFh0bkGIcyIq5xVYxCRO2DZY5fQgIX/NBTvaYAc=;
        b=OeAfKayFw/U8tXt5+8PF5aWc1zYYuu9pB5Vj1H962RidOXYXTsiG3wR/DVlxvk3H+l
         MlemwIPzI1Y5jf46zQFgEOeOB7YvK4K0OwbZ8RaBCi6F02UXyEq2HPJxmbflGr1tEyat
         zRr6tz/9CoxDvwENnPBzrVxlNNeT+H5POsUJcnLwUSL1UO8TYaCyosrPyQIHd9QXCgFt
         Wt+V+mH833LajUHFjMj70lrCVX+zcjGwZFT6NWZu2W7x3f081sdvVvVEouogFtKp0JSU
         tdm+Us8+0eZIfuQ0zpttREeKLvR7ihFt1MxG2CUvC3yhry8s3MpD27q0xjWR97zKbAtT
         /zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323101; x=1794927901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TDkJzFh0bkGIcyIq5xVYxCRO2DZY5fQgIX/NBTvaYAc=;
        b=iZmWd8yYDZxOFIB5HT4dvlRdqQBjXj5Ddh+ano/u15z8rvh7l2RbxDyXtjcMCNlg6r
         TiQulfmV3LVWx+1PVO76N5e9l2Fqd9OMs4Zn5urNazGkZMeNK82ycOsqHzcTxlhP/TN8
         OBuydp7OZuw/I+2oVm+dNSGa8M6cyJnSlereBHxG41g0jdzPUS7s1Kjw2BpfbSEqp4nJ
         ztULaGs6QSIjxYk5rnAEtewvKN2MQcOA66R96SDqlXCAWH1PKDWyuDRGmu3q8GYnYnBU
         3FYx3pcr6VphUSsEpH5qNkeAWxY2qyALMWhb7Z/SUWuLL5zoZquw8Qe8tuIdj9oRHVaT
         tkYQ==
X-Forwarded-Encrypted: i=1; AL+hErFf37oad5QplYVnOhox48/Y3TdIm+Cku4hqGQtMzV4xLpuW9Jnej+wqzBhVUTzg6LMz5VERg8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kl1KG8cm/TjGYPRGEGP1jIlV8ywua732bwi+tG+xp6ZYFI3Zm
	Gp0uU+CQExS5MBjX2msFl2I7UHpjpAI4w3KvzNU+CZVsujdZRpTrmZZQSNPTcURLKOM=
X-Gm-Gg: AYBFou2Tn99b1M77bfC6hytuLsqZpmgXHgwkSW66wzAKNDJyIRsCr2gUefpBLAgYwX7
	6gljZ2HRPIA+/Trg1JYpjeMbw7EVyyMjCGDJ1q2q78j8Nea8EnhMcIoE3bW7n9OjlZIIgGK6p+b
	37n7bFQFUz8l8Ithaa6bG76dXnqzy0Q5gDGmv/l5hCdutE+9m8/FgrijPmIAcLqRPlulpu4mwMo
	oWeyc2Qyy+8szJVQHVZRt3bQXZXdCckediXbjoEy4T+25P5xXcJk+AU94n8YpzWozyqqZdVN8jG
	BRYw/sXEaNHKnbPd/vtvzEwJT9caOmZ3JWFY/2VXEeDrq49349/PDCOsSG1YJexGtFqlVOG5XYp
	AZC8JhQdDbzBlSj842LYD+JICXV04CjLr/mXhB4NS06mis5e5X2QB9IIa6Dn1HDUcs/wjJBanac
	sedoSGORr83CvRWLRVWfaEUONM8mHgtUkTRVJ1WxC0mOj4nBhFTdLstiR0gR/Joe4CoN4DC1q3U
	S3ysp50QFLOW+cstKD5y8Prj8PYEnSEo/UhpNCUUltxPuVA3XMhwPh36lcklYovp9Mz/Q4Bs9Vm
	cyJlG0V1ajDnwMKSKcoVcKn4oiHUNiEDuesfvfQn/NlGjVCJtjawSPhM4DWhgmfCgyzbS20tlkR
	5okx/oqZoFHPZ0j0=
X-Received: by 2002:a05:6214:3d07:b0:91c:78cd:3496 with SMTP id 6a1803df08f44-91eef963041mr42647946d6.30.1794323100558;
        Tue, 10 Nov 2026 07:05:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef031c7dasm22902406d6.1.2026.11.10.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:04:59 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@techsingularity.net,
	mingo@kernel.org,
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
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	jannh@google.com,
	pfalcato@suse.de,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	raghavendra.kt@amd.com,
	stable@vger.kernel.org
Subject: [PATCH v5 3/7] sched/numa: scan read-only file mappings in tiering mode
Date: Tue, 10 Nov 2026 10:04:42 -0500
Message-ID: <20261110150446.2452975-4-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110150446.2452975-1-gourry@gourry.net>
References: <20261110150446.2452975-1-gourry@gourry.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4591ce4f2d22 ("sched/numa: Do not trap hinting faults for
shared libraries") excludes file-backed read-only VMAs from NUMA
hint faulting to prevent east-west placement bouncing.

This filter hides hot file folios on slow memory from promotion.

Scan those VMAs when tiering is enabled, but make their scans promotion
only to retain the existing restriction. Keep the historical VMA
predicate unchanged for backport-ability.

Decide the walk type for each VMA from the balancing-mode snapshot
taken in task_numa_work(). A VMA gets a placement scan only when normal
balancing is enabled and it is not a read-only file mapping. Otherwise
the walk is promotion-only, and without tiering the VMA is skipped as
before.

On a host with 768 GB of DRAM and 256 GB of CXL memory running two
database services using ~430GB each, 169 MB of their shared 185 MB
main binary accumulated on CXL and was permanently stuck there.

With the change, the binary tier residency tracks its runtime hotness.

Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 kernel/sched/fair.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e353d3d3012ea..c0b7271f1bce8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4272,22 +4272,21 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 static void task_numa_work(struct callback_head *work)
 {
 	const unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
+	const bool tiering = numab_mode & NUMA_BALANCING_MEMORY_TIERING;
 	const bool balancing = numab_mode & NUMA_BALANCING_NORMAL;
 	unsigned long migrate, next_scan, now = jiffies;
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	u64 runtime = p->se.sum_exec_runtime;
 	struct vm_area_struct *vma;
-	unsigned long cp_flags = MM_CP_PROT_NUMA;
+	unsigned long cp_flags;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
 	struct vma_iterator vmi;
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
-
-	if (!balancing)
-		cp_flags |= MM_CP_PROT_NUMA_PROMO_ONLY;
+	bool placement_scan;
 
 	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
@@ -4375,13 +4374,22 @@ static void task_numa_work(struct callback_head *work)
 		}
 
 		/*
-		 * Shared library pages mapped by multiple processes are not
-		 * migrated as it is expected they are cache replicated. Avoid
-		 * hinting faults in read-only file-backed mappings or the vDSO
-		 * as migrating the pages will be of marginal benefit.
+		 * Shared library pages mapped by multiple processes are limited
+		 * to south->north migrations as it is expected they are cache
+		 * replicated. The benefit of east-west migration in this case
+		 * is at best marginal and may be harmful due to TLB/cache
+		 * invalidation.
+		 *
+		 * Allow promotion as a cold page incurring many cache-misses
+		 * under cache pressure can drive considerable bandwidth.
 		 */
-		if (!vma->vm_mm ||
-		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
+		placement_scan = balancing;
+		if (placement_scan && vma->vm_file) {
+			if ((vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ)
+				placement_scan = false;
+		}
+
+		if (!vma->vm_mm || (!placement_scan && !tiering)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
 			continue;
 		}
@@ -4461,6 +4469,10 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
+		cp_flags = MM_CP_PROT_NUMA;
+		if (!placement_scan)
+			cp_flags |= MM_CP_PROT_NUMA_PROMO_ONLY;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.53.0-Meta

