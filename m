Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323098;
	b=rcnh7BI2uqQbCrgyjO7KJb0cuQaWnDaL+9Us4She42PXUFzVC0w+6sm+xO/10DIEZjqi
	 qaAFOaSY0rY924azirqbO5wBKp0Jwp5C+xVjKf9o9Wla2cUxAi9g2iTbtsJ/SaIuD5Pjd
	 HMEhGhWfNnULHZYknKRoZHA605ROUM5NSNxdpTSszK6OI2SO4pAnpYWp2ueurxfN9dl51
	 EoBEiqNotcSIbrSEq322YVPD7ORcRrjWUc/U84Q1XMI8DY5hVTB3EbHrcvTqmMhqQNkRl
	 K6llHjUSAY+AuhVIp1BpVGluewCqDnRBFjn2hpxrqMGuEfHGDaMJarKdZyyReXHBEQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Iw8lf9lVVTdEkl4zNFPBG5YINbT+Z3k0uho4I4jJR+M=;
	b=MNlwjq55qFUsvZqXbCcNIJUWuI1SW23e96+pPdSQezflb6B6NTjKXRJK/IaLa59LAzqD
	 jNkTpnFpFQpYUiPJLrt0F6sQStLCzfyyB/k3PQQn6hvv7JGpZSRlCfehcAgSZW7kBIXOF
	 O8Iy9uaU20KxpjLAnx1M8WA/vD1kh1kVUZMaLIa9n4Oi6r8RvEocTUcrgzuWmqwJURwmO
	 CucJr4B1x7NXs8uQQXtl+GrYpXoAdwbYT+Duwbuu5u2cqUHL6sa7roC0FOtucBbvwsQMw
	 zGd9gD5v9r56Fo8+wElpQVrjSHwdv+QhUvkePkKERj1MgMo4SQppCOY9BASRquS8mRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NqbY0l3o;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2A606AA69
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F2A606AA69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NqbY0l3o
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ec6f271883so1270672e0c.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794323097; x=1794927897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iw8lf9lVVTdEkl4zNFPBG5YINbT+Z3k0uho4I4jJR+M=;
        b=NqbY0l3o7Kgth/7+UZCm4xTydNEKgU/vJ2Wbi3KDaGJN49jPfYoP9GCPv9PXy7zg82
         e5JoeLDkbZ4aEdEIcm8H1O4blbxYxKFNOV6feeIPH2ti4UrKtkf0TEu//Qk8e6mjVsHz
         SNL17jyZTD4QkbM7qsD9z3M3tSjUP14G7fOBIFfs3MAeIWRUt/uQww1MeRyiobuG1e1R
         Wjr45fzwLef5DNYf3VFTSApV2X53haeHRKpYTIjiTcwngPHYhnhaG+XVicK3EloW+dG0
         5RxQ2dpbLE/o3s9Fmk+IZvGZdsDAndexg7D05JGcqr1YK02zuhztdIjk87dzae/R+ZN0
         jhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323097; x=1794927897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iw8lf9lVVTdEkl4zNFPBG5YINbT+Z3k0uho4I4jJR+M=;
        b=t9RfxwRIB3DkJHznetMom3oIEGV8Zm+UFjS40auBvbKjR1YVQAcSWpDIp7bLC578fl
         Y0vLuzD58O76LWhX0sumI1ADJecfchn8i9EvcjQL15md2+vCsUC2Femiu5xmAo4fn/tu
         upaQK7RmtANZSjZke/b0Luujrr0xIESDX/D12Z2+j5O8cTcAZ3V63NRtUkRSM6ayJubB
         DrbvijAYMeKe+8l7JLcwglT34JqV2QUsveGLRVg3HmKDvn24EZ0qOQfGeBTMdTS2/wQf
         RyclPnKWU6ByrZ2jQJgq6lcaEb8EfAUUlkMynYt+7YKhSMEREPOqMHA3vJSIdlr/JgrC
         WuKA==
X-Forwarded-Encrypted: i=1; AL+hErExuBVrAOADq1LmMX5jseFYbCKP+2pd6vt+CoBzm30S/Q8GQ8mMMFOLC4tTPvyPrD5y771I1XI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fkw8rsUGByc819p7iMnQCsHrfrQ7QZhLL1j3wZl485QuG1QLh
	U4miN24X1d4KMePOhH3nOF8J+AUWKHtJGuYH0xcklncAq+i6SBvTnZLKfR+B4DU2+Io=
X-Gm-Gg: AYBFou1RwgMaMsFLN4zqUZeN99GVXWV83NhkGVcpXQAadh8OKS5GZhTVQ4f2cJemBPI
	VoxxlUzh43YxGu/0WUP7X1Ovc55qgmkgUKr1mEmp2Yh7pNPRz8WcEXkymmo9RhYETrTxJYqp27Z
	zmlN6kg0FCEGyLvkqy9aGmvAbf6DCtbcz+WqkkYNAfrcEPkSTzIFjtOPI3bTI/zJL6wBtbzUMYM
	SQz9lCglEdAyXiZRdCPVrC7zBZ45rgEQY88tc7xMCyTQbqRlnPEfItiACNSYKPHJjTeSUgDvRb/
	CtfX4uvsHhzNBWCAAtjlUgMn/7oxbKCAcUVr4LMHj2neThwDbe/MM2Lbxa5JOV0njWIbg+SQ/bM
	9XOG5upVbvSPqZ+SnaipBMPisDfFgUjrzjrLFacAOPAGyB9BLKhiPAmK+hGuDcB4csYstMG1A+m
	oYWwoIwimbJeN7R1JP3u6Oki9pCWVjLh9O5i6BgRZjcQrbDQi3X6H9w949kSwK9iy7/dcZyRtJJ
	EbXHK9ZdA9hBtEDLZaC7eesk2YdGw9MNix9uBCkKKsVRxmzRfS4Nj4bwtNgVPJZapxrlXO71Rwz
	wbFBfGNe6Twqycotb/nOnegjhLBiEvOx+pciwRiLkUDFyf9NF48O0qmZNBr08Z5RkZeGepRK2tY
	gSAHlqZ/N+026HT8=
X-Received: by 2002:a05:6122:d25:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ee0d0d2a9amr1167542e0c.4.1794323096756;
        Tue, 10 Nov 2026 07:04:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef031c7dasm22902406d6.1.2026.11.10.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:04:55 -0800 (PST)
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
Subject: [PATCH v5 2/7] mm: allow shared folios to be promoted to a fast tier
Date: Tue, 10 Nov 2026 10:04:41 -0500
Message-ID: <20261110150446.2452975-3-gourry@gourry.net>
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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
index 40de653041f92..55817dea7307f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2647,7 +2647,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	}
 }
 
-bool folio_use_access_time(struct folio *folio);
+bool folio_numab_promotable(struct folio *folio);
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
@@ -2701,7 +2701,8 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
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
index 5d3d7b61d0257..e353d3d3012ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2877,7 +2877,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (folio_use_access_time(folio)) {
+	if (folio_numab_promotable(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 7fc56a8c66518..0df54dc556f19 100644
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
index d477a4f986bc8..e70885653475a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6262,7 +6262,7 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (folio_use_access_time(folio))
+	if (folio_numab_promotable(folio))
 		*last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		*last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f0933e9b209c9..49cfeab501b4a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -866,8 +866,13 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
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
@@ -894,7 +899,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (vma_is_single_threaded_private(vma) && nid == numa_node_id())
 		return false;
 
-	if (folio_use_access_time(folio))
+	if (folio_numab_promotable(folio))
 		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735b..50a0a2e11a353 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2704,14 +2704,19 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 
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
2.53.0-Meta

