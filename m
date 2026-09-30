Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721E4C33DF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767339; cv=none; b=vDo3U6yQ0yQdp/xT6nO3auH/JuAYKYwAhnQOVxyRfyWuWR8QxkeiA8AX5TcULQxeWMg0Kaob0IWLo1FyXsHsXtf1MLMYRPCTsuYlh4NNCFiEaFZuWO0Ex6yaaE9cGelGx2Q/wzXJNhLGedt1pfqRExVWw24kfhiFIHYIOE2ElOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767339; c=relaxed/simple;
	bh=pFuKGH0pHrfypCiuXG+kmxnFLhtlyTlNQsdfhd0BQnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzOReKwpYmKa+AqU+00XyWrUNEio3sYqI6qIsnOWi6BEqxc+WF9A6CRb1lRozy3miEQE+FxyUichscMzq1Ik0B7h6f6zdpOxtsUUskZJsRktKwdwl+NP3EI0AY9bYxTcWDYRiKn6B6vuESC+Megbh8vZ8hpzPvEeUO2BoNQo5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FcToPbN2; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FcToPbN2"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c4f4daso345102f8f.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790767334; x=1791372134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lgfVC6O2+5z+LvR6FnOaw/aw8yOZeotv1eEzW1rW6w=;
        b=FcToPbN2bOeGgDUwwrsod1P1Txro1rsXzke4xSECUhS/feU5/tRCsGbsZ+bgftfgYW
         A8HeZjmOn5a/3nK3jYIb9SMwQ3mzp6eFNRLFJPEwv1pJ9kAWJI+q7bo8UxS+877A9v3Z
         dqCbqmyOnF9OmIhFHtomKLaxA2JQW2G56KqrVb74vE6bfQ1Rz50ZADy85O3SKoHDxPmL
         XZWd7OyhnTdSxURbuy03dgaPOnW8ifKtWQsd47TX8E6iJOlT1l8ol8kLgi1OLQ8Nrd0l
         2Cfd4gs+p2o5eIp8FR2UgyJLTKpI4dxa3pTkuauTM9aW9j9RcRKKyAxwviesjZFQRmzC
         +pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767334; x=1791372134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+lgfVC6O2+5z+LvR6FnOaw/aw8yOZeotv1eEzW1rW6w=;
        b=LwNO/3AQpSGSbW7NVmNCf+mqfa6kqS4x+pHhlHgDvN5SJ9yI2v+fGgBjAnzAOKZ1kR
         Zetr/xIV3bKrsgd523cEu9hIsRi1S1jQbX+OzW0w0AC5tMh0jYDEWC9jfLS9BYW8xkZg
         SjWvGRDoufrrIpe3EgnAfu710LP0E4JxUnqQypWhSnBi0PG9IR8+5EsQcSofHYTr9520
         Z7kiuVs1PXMha7gT3wDULEUUb8eK+Ly4gp6xHqeVK31Hc/1w/jZ+bOmc6Y9Ik0FPI4Do
         RW4l2nHiIqg47iTFvux6FHKFXhsTsA388/RhjvWvFA2Hocy6dR7JxJWk5AdtzoYbfH5T
         dJhQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8wUbJ0yRrCzWNkT0psFQqVxv86CIdm3NLk/F/A8obKuXvKX4aTPjE4OREgRLi74TQSjVK2kY=@vger.kernel.org
X-Gm-Message-State: AFuF++m2FuqStKw8m/PHXxQbt60G05DnBavh7SMietZ8W2A8gAd29e6q
	VA6e/Gtzy7DQ55K5h7RdEAz2/qR1bGpinQDqvz0fktk1W8BNJ9mkNAKeiDyuSM0y2Dg=
X-Gm-Gg: AYBFou0p9Z+nrQcP7nTo6cvP0wH27oygdu7CxuxfUpzOmaxm6CzzQXAebOccp0mzF0z
	lKzHalYWaQgqkF36787eGHqMuR2t+Xm8UXd8cm80XEkot+dkp2GWKcZSc1QHFr//4tQKEcvGbo9
	CSa3+gfklJH8JQ5TqfDqV37BIprjWJKR9Zr2bZsr3Z5DZtS2AwavKHP4nwkqn/SmZeWw4hASbiH
	m8dYgK7zHk97R2sgVrgWvYIUyvLWJmGEXQ0of8ioMj0KWPRNO5Uu2mVIQmfAYqv2bgKLWLK8CtU
	zznn77njpfCMc+6oUtYWGsTLmHhrnW1IQikcp/qu17qtSdNRx0Ds50BdQzRp7HIo1CVlah0aqk2
	EchVnUOqrEzSRQIfV79SjLN3QkClp1vEnHFRhuh4jiWZUhJAuk3cYVXRbhliZ88v+DdtkhoZozM
	7CYOfSlhvMeftQXjKTv1a7saJHTtSXMf2XGZLz6bRYOZ1TJ19ZLttNsNjDzM6w8OP9a1XSnH3z+
	3FMOGX/JCuPVkrt5aqjm2aGEbA=
X-Received: by 2002:a05:600c:4f56:b0:49f:ce73:4b with SMTP id 5b1f17b1804b1-4a01b010271mr22762315e9.35.1790767333702;
        Wed, 30 Sep 2026 04:22:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.thefacebook.com ([2620:10d:c092:500::6:13b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a019740c34sm34097095e9.9.2026.09.30.04.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:22:13 -0700 (PDT)
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
	shy828301@gmail.com,
	osalvador@suse.de,
	raghavendra.kt@amd.com,
	stable@vger.kernel.org
Subject: [PATCH v4 2/7] mm: allow shared folios to be promoted to a fast tier
Date: Wed, 30 Sep 2026 07:22:01 -0400
Message-ID: <20260930112206.205083-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930112206.205083-1-gourry@gourry.net>
References: <20260930112206.205083-1-gourry@gourry.net>
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

Rename folio_use_access_time() to folio_numab_promotable() so the name
captures the combined memory-tiering and source-tier test. The helper
retains its existing behavior.

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
 mm/mempolicy.c      | 11 ++++++++---
 mm/migrate.c        | 13 +++++++++----
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 623ae61e52cb..69107e877fd1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2672,7 +2672,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	}
 }
 
-bool folio_use_access_time(struct folio *folio);
+bool folio_numab_promotable(struct folio *folio);
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
@@ -2726,7 +2726,8 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 }
-static inline bool folio_use_access_time(struct folio *folio)
+
+static inline bool folio_numab_promotable(struct folio *folio)
 {
 	return false;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c3dfa398d0bd..3be18cf10eca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2742,7 +2742,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (folio_use_access_time(folio)) {
+	if (folio_numab_promotable(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 25e121851b58..086d5695e656 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -53,16 +53,19 @@ static const struct bus_type memory_tier_subsys = {
 
 #ifdef CONFIG_NUMA_BALANCING
 /**
- * folio_use_access_time - check if a folio reuses cpupid for page access time
+ * folio_numab_promotable - check if NUMA balancing can promote a folio
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
+bool folio_numab_promotable(struct folio *folio)
 {
 	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
 	       !node_is_toptier(folio_nid(folio));
diff --git a/mm/memory.c b/mm/memory.c
index 330cde31bf8b..4ab6db22ad4c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6240,7 +6240,7 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (folio_use_access_time(folio))
+	if (folio_numab_promotable(folio))
 		*last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		*last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8ff37f60b710..f70f4f795840 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -864,8 +864,13 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
 		return false;
 
-	/* Also skip shared copy-on-write folios */
-	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
+	/*
+	 * Shared copy-on-write folios are poor east-west placement candidates.
+	 * When tiering is enabled, folio_numab_promotable() identifies a
+	 * low-tier folio that needs a hint fault for promotion.
+	 */
+	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
+	    !folio_numab_promotable(folio))
 		return false;
 
 	/* Folios are pinned and can't be migrated */
@@ -892,7 +897,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (vma_is_single_threaded_private(vma) && nid == numa_node_id())
 		return false;
 
-	if (folio_use_access_time(folio))
+	if (folio_numab_promotable(folio))
 		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 7bdcdb57652f..c0f5f3ac71fc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2694,14 +2694,19 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 
 	if (folio_is_file_lru(folio)) {
 		/*
-		 * Do not migrate file folios that are mapped in multiple
-		 * processes with execute permissions as they are probably
-		 * shared libraries.
+		 * Limit east-west migration of file folios mapped in
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
+		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio) &&
+		    (!folio_numab_promotable(folio) || !node_is_toptier(node)))
 			return -EACCES;
 
 		/*
-- 
2.55.0

