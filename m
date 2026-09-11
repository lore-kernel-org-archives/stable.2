Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C81274B4A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085923; cv=none; b=czQ7+vfzw03lbY3hOa3dvpNLN8YEehqVCgWy/FhmZVIv+370Zz3sqi1EMe/ClU8XTxEvNmPIk/K8rs1A50cebFbuWfbeWpbhYuGCKP/ra1RQNMOE4xm6obcHM6UieIC4RBLFZlKsFObqREIV4OqlgGpNDFWU+0tsJ8VVF7ZjW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085923; c=relaxed/simple;
	bh=MbCDYm5ROgW+FhjLtzZnAOPPKxmb4d+M7CPyKUkZdHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+rM26CvIe2XpZpADbDGkqNoFKpxz/Pm03eIk0MHTCjc2IK2ShstH0kmf4H1hLn72IS6Zh7sId9VS1ejj0dvgPby2GRC9hEEXOp9KlYil/mXe36WV+rh5pzUU3yiY/ES6f5iK3u3hgmnrsGeRI1GOBMiAFsnF9l5XCZrfjeCznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eKzHeCjB; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eKzHeCjB"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa6so43985985a.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789085918; x=1789690718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdeGUk78rOtPCIG/0kxB5vZ5w0EIZpg3hPrMBzGs7bI=;
        b=eKzHeCjBxsA1oJHX/yRG79/lLg6Sjgoog4OZohyMsVneXKA7/sF+q5fztO42LviodM
         FHQw4taURmCmDSQPL/6kZSjMO1QQ8dz8dRz67d9kFcuGHSNseAJCn1qh+0w0ACLtGKQV
         iXy8UIXsL8PPnF5AVn9BdGbIbAZ6+GtWeFf7tTd/X/dafkw/xMqofNxm9nYrtjqc5fYR
         W1YC42wT4fBLz/JA2T1lpj5QttccY/8ymVrUGKhWSc/wdKT4Z2w/L1dPka0JO2hBcqeA
         9QlyVM9il7EwEN2iKnVf2AQW2QJeNwmS+/S40/VkcbFjgObAnjuWhZRBpPm4C/ynTqHQ
         UJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085918; x=1789690718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdeGUk78rOtPCIG/0kxB5vZ5w0EIZpg3hPrMBzGs7bI=;
        b=KmK2mpwuAk0vP8qnl4Ib3GP1fGynGoTYMw89gWfb2S0i69FIv2ajajLRjCvUw1ag95
         XlSOrG5SZdp5KzoEhBWwxhS72HjEDcEOxcEt8IGKrYKQAtjWKzhvaf/Nc6DjRAT2PPra
         XVkY75kHLAk42ThjebBOqYOvnBXG/eT41ZCr3ryabsD+RL/3b1cieDfG7QtS+NFrKLYp
         kYHYFyiLphhrQ5eOiRU/HSRvwxYT7NzEVd0W+j8huph0QLR225XNqIHKqft0+YgyQi4q
         VoEktzk2ZFXJO4x4nZ5aYMdFTxpMAsfnuzOVvFb8LgFwzwqR3q2a4VPG+3UAeLPr6uO1
         YPjA==
X-Forwarded-Encrypted: i=1; AKwUvBz+bfoAc/aCFwu+C4h59Ck8RVSdyUNqdEhQ9+/uXoMeC5HG99i2DHMfcIyi5ev5TiFoah9+mlE=@vger.kernel.org
X-Gm-Message-State: AFuF++knfFp6kqd7jJG6K0o8tMvBRrX4TOOFEU44Hm6dNVoIF6XqxT4u
	Pmjej5s5M764wv/hsWLiAv06u+Wr4gYc9hWOu6Vpp95pzCYBwP1GyEv/B2+rOK8i05w=
X-Gm-Gg: AYBFou0+lv7MtQrBKG8iOlG5m6DxRgPfCZWa92ORrFIAG4sCXcM8DmIitwj3RW02vnX
	55yNh+s1sd2l6BCz4vxlryiVB0xYUrUHjICUgm13VEwS5932a5zqQfnnZ4p3Lgseg7uYvq7VHUu
	InBBZQpiziGJ+tdoCDuyFP7+ioTAGSF/FAz57PvVsWpdz1y8ESgl6IwgR5MV1xJOOv0td4vm2Pg
	ZKfSOfvbaOtIKyxPt50Y3+3wkN2d5gaNfMP2nUh0mkvw75wwNCe91V7RBxkz5APAoi/UKbSUoFJ
	ZopTl1pC10XFCGEfndwFrb30XGm6z3e/QP89c8DkYor1j6xFmqiR1bMPr47YawOeJm1BRRn7jA7
	TIeVN7sSGvCIuV8tKZkrDnmi847hBZR17pkBIwFaHpUozR2POt6rnTC/B2KN1cZjtrNvYfMpOHd
	owagNwBSCYKtstzd87AB82s4GeT2CDCBvr0D5VwrAd9GXDcEX4ymRWmodirx1IRFo3uHIqNA08s
	87vBURYldnRs7tjHKDSnZdWJ756ex+1VfqSdt55gYq3lURSeSl2H2Q7uC/H
X-Received: by 2002:a05:620a:472b:b0:939:d440:e530 with SMTP id af79cd13be357-939ea0e3717mr224092885a.9.1789085918183;
        Thu, 10 Sep 2026 17:18:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80e4c36sm108896485a.40.2026.09.10.17.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 17:18:37 -0700 (PDT)
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
Subject: [PATCH v2 3/4] sched/numa: scan read-only file mappings in tiering mode
Date: Thu, 10 Sep 2026 20:18:25 -0400
Message-ID: <20260911001826.2109390-4-gourry@gourry.net>
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

Commit 4591ce4f2d22 ("sched/numa: Do not trap hinting faults for
shared libraries") excludes read-only file mappings from NUMA hinting to
prevent placement bouncing. This also hides hot file folios on slow memory
from the tiering code.

Scan these mappings when memory tiering is enabled, but make their scans
promotion-only. Ordinary NUMA placement retains the existing restriction.

On a host with 768 GB of DRAM and 256 GB of CXL memory running a roughly
430 GB database service, 169 MB of its 185 MB main binary accumulated on
CXL before this change. Afterwards its tier residency tracked runtime load.

Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 kernel/sched/fair.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81359b414947..e636e8de53f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4061,6 +4061,16 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	p->numa_faults_locality[local] += pages;
 }
 
+/*
+ * Read-only file-backed mappings are expected to be cache replicated between
+ * accessor nodes, so they are not worth sampling for placement.  They can
+ * still strand on the slow tier like anything else.
+ */
+static bool vma_is_ro_file(struct vm_area_struct *vma)
+{
+	return vma->vm_file && (vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ;
+}
+
 static void reset_ptenuma_scan(struct task_struct *p)
 {
 	/*
@@ -4220,13 +4230,13 @@ static void task_numa_work(struct callback_head *work)
 		}
 
 		/*
-		 * Shared library pages mapped by multiple processes are not
-		 * migrated as it is expected they are cache replicated. Avoid
-		 * hinting faults in read-only file-backed mappings or the vDSO
-		 * as migrating the pages will be of marginal benefit.
+		 * Read-only file-backed folios are poor NUMA placement
+		 * candidates, but slow-tier folios still need to be scanned for
+		 * promotion.
 		 */
 		if (!vma->vm_mm ||
-		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
+		    (vma_is_ro_file(vma) &&
+		     !(numab_mode & NUMA_BALANCING_MEMORY_TIERING))) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
 			continue;
 		}
@@ -4306,7 +4316,8 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
-		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL);
+		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL) ||
+			     vma_is_ro_file(vma);
 
 		do {
 			start = max(start, vma->vm_start);
-- 
2.55.0

