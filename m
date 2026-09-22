Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00F49364B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101778; cv=none; b=ltBirh3bNlCSmuKx93KUqfgMPev37+EshHldg1qitcdLtq0FzwYKtYz8sjvfJRvvClpr58W4BW+xiygyWfy+ZL6HdicZsvc0I0G1Es0vK3GDMB6Afa/BG0tX4wlLIBi3zTULlRTFaQXi4LrgoUsveROxsfTNWBtcGXRYJUTo1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101778; c=relaxed/simple;
	bh=3VZh/Vv8oefReRSPIMQMONopSVybIFo51Rb6XMBQI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQSM1UMRCsqrPwd1QVy+Ionul6vuwJF++dUCROVEbeoStHgcR9m9YiKvT/7oSgH7oklXUFwSWn6QcGpHAPgfW3fpHbrkIDj0QOGzbkEejKhZTg5QGD0U/klrmgqMhHh47yKPb9/IyBhdrSIgDD2f04V/d8IBqCb0ExD2ELEHFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PGUlStLP; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PGUlStLP"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ad20d4so17481085a.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790101775; x=1790706575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRwVfr0lfTUMkgCOhTSEinsHZrcpdOMoOOSVu7rzRt8=;
        b=PGUlStLPB5+U5nyzh48gC+bmjptn8iNWrTjSpZsu1v2m43jtZNI4LPT+b1E0Mqn5kL
         6xhRI++xdTTehL2mu/6Ln2SwDgRIQArqNB5hP7vJnWwm1AwdT34kUI72NC8TdMisEjhE
         TsCLxxzP7ED/xr4RE6VJ8Ri3ksaEdSiZCPLELt0NMj0vnqeKs/3L7lybMarPtPhSeNay
         Wp6bk5IY08xoPEeMwQcifY52Ax/i1fme9P/SlsJjhQfae24yNgaRsOGqt9xm/ipVd1lK
         fQFFIsM7/G/R5zoQDh3fy5Rs4BcaJvI2qSkf+VY9c/a13uyTUJ9MoUzTBY15vBxrhYNF
         G6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101775; x=1790706575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRwVfr0lfTUMkgCOhTSEinsHZrcpdOMoOOSVu7rzRt8=;
        b=xxu6orM8osbDqwVw7bExbPwWC2zhoabjHX+al+u8Sy+AxfP5qoQ1ptr7X7iwr8mh5K
         ww7EQ+jgvcXEa+G6+SxYkxUzrSs//rAe7jFopD8/pyOBMcyH+gFgqZq/9Nq0hE5aSP5S
         FIkBIOJnHMYGhLXn+f6mxKuvVaiJJt7ffx5B15/KbLxhvoVQBvu5h9huBQOLfVNrWVAG
         GwxewxIGdPidoiZitWK/EWY0TVPTiUFduVT3TVQnpAeiIlpFKFDu1xwU/WeD69S3RL90
         ZK+HAzxRhJX9kdOnMG5+AK9lkOCcmGPD6MayLPPwJLg2NkRm+5mkqFu9KgqvhDADmlQ7
         LQgQ==
X-Forwarded-Encrypted: i=1; AKwUvBywNkB5OxC12ichSIEXXs7tzGw5ok4ggfeMHed3y9NUy+LCakXhljrdA1yFzrXXJ5YSpKvIiQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++ksC4e6eU2g9c9QBHGyrlzYlkM4UqBH1clz7gPq3Y+N0FmPsRWx
	+nVd3Vf5sr7am4nAE+Xb5sbxXN6HSzM5bU9CtjrD058Ehp6FFlXUfKbBLEjKjspET0s=
X-Gm-Gg: AYBFou2yD1XrrdpYwnGgDmAMLbWQscrJTK6Qe2Heg/s33mQ56OXks16eekXKt0vgV4R
	F8UNlFa99hq3C+5oWa1659hoSMb1LTDGVQOFpHJxzTV0x6bboJHqMhTJv/+kGcsezUMEukdcjwO
	ewaitiYu2xz8qN379z0ZBtqKVGP2rdFz7RpuYvN+J4j/5i54eM1gsytN1i0yUDgAS6grq4mRfw4
	6xWcodSSssib0i3WaH9ELpI4FGdlZy6TPdVmmgVv3+ZrNWkNtinJxR+SQRbPYZlE3+b3fo+B+bq
	vIltrEMbSvSkLdnA8ryCZwsI/rw+nvi2THK4ECHN045HwWT5Mm+nedZeJ/0pJazrzmFaCWcLM0k
	WpjJpothxqYM8gqUOxknLljILPg4wC5BD1QtF89G4ioXTUdaEhkNxyh47Mqi3eINFB8vp6joG2B
	Q8YSFluH3T9kS4RxLz0W7UCyL43cbG3mqgmLwDVnjTfclQHoY8aE4p7GgxGiKSKe/WOxUrv6BPo
	S9h0p7zMNmadUQ8u84F+gFO9AedXFbPZjhmc6f4nPUI1OkQZvj3tXUgKi+QcLztYFDdQlQ=
X-Received: by 2002:a05:620a:8006:b0:93b:c209:b6c0 with SMTP id af79cd13be357-93c250ad128mr41734385a.5.1790101775234;
        Tue, 22 Sep 2026 11:29:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24889ac9sm37130085a.27.2026.09.22.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:34 -0700 (PDT)
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
Subject: [PATCH v3 2/7] mm: allow shared folios to be promoted to a fast tier
Date: Tue, 22 Sep 2026 14:29:23 -0400
Message-ID: <20260922182928.2199090-3-gourry@gourry.net>
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

NUMA balancing rejects shared copy-on-write folios and executable
file folios mapped by multiple processes to avoid east-west
migration bouncing. These checks break promotion from slow memory.

Allow such folios to participate when the folio being migrated is
a low-tier folio and the destination is top-tier (south->north).
This allows promotion, but prevents east-west or north->south
migrations (north->south is handled by reclaim demotion).

Keep the existing restrictions for ordinary placement and for
migrations that are not slow-to-top-tier promotions.

Rename folio_use_access_time() to folio_in_lowtier() so the source-tier
condition is more obvious (timing is the mechanism, not the condition).
The helper retains its existing behavior.

Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
Cc: stable@vger.kernel.org
Suggested-by: Zi Yan <ziy@nvidia.com>
Link: https://lore.kernel.org/r/DLHS4KFPQ86I.1J4LN3352RI71@nvidia.com
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mm.h  |  5 +++--
 kernel/sched/fair.c |  2 +-
 mm/memory-tiers.c   |  9 ++++++---
 mm/memory.c         |  2 +-
 mm/mempolicy.c      | 12 +++++++++---
 mm/migrate.c        | 14 ++++++++++----
 6 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index beab621e6f88d..225ba26c9d503 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2671,7 +2671,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	}
 }
 
-bool folio_use_access_time(struct folio *folio);
+bool folio_in_lowtier(struct folio *folio);
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
@@ -2725,7 +2725,8 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 }
-static inline bool folio_use_access_time(struct folio *folio)
+
+static inline bool folio_in_lowtier(struct folio *folio)
 {
 	return false;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f544e3df9490..dc78d24ed8bc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2734,7 +2734,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (folio_use_access_time(folio)) {
+	if (folio_in_lowtier(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 25e121851b586..082ca74d51ae9 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -53,16 +53,19 @@ static const struct bus_type memory_tier_subsys = {
 
 #ifdef CONFIG_NUMA_BALANCING
 /**
- * folio_use_access_time - check if a folio reuses cpupid for page access time
+ * folio_in_lowtier - check if a folio is in a tiering-managed lower tier
  * @folio: folio to check
  *
  * folio's _last_cpupid field is repurposed by memory tiering. In memory
  * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
  * record page access time.
  *
- * Return: the folio _last_cpupid is used to record page access time
+ * If memory tiering is disabled, then lowtier has no appreciable meaning,
+ * so we return false (the folio should not be migrated on this distinction).
+ *
+ * Return: true if memory tiering can promote the folio.
  */
-bool folio_use_access_time(struct folio *folio)
+bool folio_in_lowtier(struct folio *folio)
 {
 	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
 	       !node_is_toptier(folio_nid(folio));
diff --git a/mm/memory.c b/mm/memory.c
index 79fa57a381ce0..f05c469e32a2a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6240,7 +6240,7 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (folio_use_access_time(folio))
+	if (folio_in_lowtier(folio))
 		*last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		*last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1427e1b6213b6..3c3ee28f0142f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -864,8 +864,13 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
 		return false;
 
-	/* Also skip shared copy-on-write folios */
-	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
+	/*
+	 * Shared copy-on-write folios are poor east-west placement candidates.
+	 * When tiering is enabled, folio_in_lowtier() identifies a promotable
+	 * folio on a low tier, which needs a hint fault for promotion.
+	 */
+	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
+	    !folio_in_lowtier(folio))
 		return false;
 
 	/* Folios are pinned and can't be migrated */
@@ -891,7 +896,8 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	 */
 	if (vma_is_single_threaded_private(vma) && nid == numa_node_id())
 		return false;
-	if (folio_use_access_time(folio))
+
+	if (folio_in_lowtier(folio))
 		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 7bdcdb57652f8..6a08690cfe219 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2694,14 +2694,20 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 
 	if (folio_is_file_lru(folio)) {
 		/*
-		 * Do not migrate file folios that are mapped in multiple
-		 * processes with execute permissions as they are probably
-		 * shared libraries.
+		 * Limit east-east migration of file folios mapped in
+		 * multiple processes with execute permissions as they
+		 * are probably shared libraries (limits bouncing).
+		 *
+		 * If this is a low-tier folio, only migrate if the target
+		 * node is toptier (this allows south->north migration while
+		 * disallowing east-west migration between slow tiers).
 		 *
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if ((vma->vm_flags & VM_EXEC) &&
+		    folio_maybe_mapped_shared(folio) &&
+		    (!folio_in_lowtier(folio) || !node_is_toptier(node)))
 			return -EACCES;
 
 		/*
-- 
2.53.0-Meta

