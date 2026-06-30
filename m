Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B3222582
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785747; cv=none; b=lprb/rdGcwtw8QcbxNnY2eNhV5DkP5dSiNP+EuC0UFD3b7b9FINAKURTpJF1mkeLV32jelS9GeRbjDVa63prmC8/PmtoBj0MdUh/gatVzKdoQ8mat55DxLQDySrOz0caK0tqArcV9hOn+FVfFAJHZ+gdLTVeXH2lUUOsLyIT2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785747; c=relaxed/simple;
	bh=ReUoazs1gd0HJAirt0KbIslMuUb1g9bojOUB+Uh3pRA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D2K4R1vkks/y3LiGYZFsHSsxJ/WSoLM40a/rzv2orpzPmuP/1GFw6291bQXXUh0r5RJpXUlvt19DQv4gLxBeQ8wJzfXy/mCVESrQXEUGC2zXUKKfDh4EIuj7+7U6bIKpjlVjp2nadRJvkk2wO1xv8LAXiUi3vlVo0lVQcpi3iZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym1SkqLL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym1SkqLL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1269e4721aso223469366b.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782785745; x=1783390545; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmwOM3kLmga60eTP4uif8DGldwNWcAncsPcoMOlri90=;
        b=Ym1SkqLLvCPyTGXmdAZ1MHakS2w1t0sHeA6Z5p6ahGHM5GrDqVHnwOpmmTxRUQeqRb
         aYtJyfHdwvV/upK9aQsdTmBUa6oGCfA1DeQqfhu4IfWfMnwxxFQV+PWj9cyRBf9IwIP+
         Nxt9EYji7CSl1EDW1CbkK1Giq+MpTKKDzGvIp9bgIaNhkRpj8A3avjT4fjsGflzAdxdn
         jWTgQszqTwjJmVw0TIySKXTeJyPNX/wTp7h+O+J4hxV7E0WBNlNIT/c8ywjyET6CDuim
         inDQME25VpQMk6lyaivYvB9qQhA8YrO/LDtc+tV3nEK6tJQvPCvsvTsZ5ty1ziPzaIs7
         SNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782785745; x=1783390545;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TmwOM3kLmga60eTP4uif8DGldwNWcAncsPcoMOlri90=;
        b=GrTuKbR/MnuxTz0w3KcsPXp9mNR4X+fatuhR3h/uoGNsWdzAhnDq//cgGsl8hXl7qV
         T45oo3Q7aTDpsJtwB1Rs6k4Aqe9oI2DQNlXd4+Mm2HHdSKVgmQLC7OwHopvZ51Z0afUp
         WiOukQbZKO9uv06rg2I/Fp0VdMTOn+vSLw8f1ExV0d/3VWikK0uJtb7RV+LFd0wGzLIF
         FAJwa/vmr+nfjfsFK2p+HdQD5tpDxAkwNnwwFppG4Xg1uhm/OEMdeoES3m9PKerC/jiE
         yGZMiq4yWqbpfG2s/KxvAgP//MBoDi9Hlr7e8ufyQcGDMmYXbuiYx+OuuloQnvA56de3
         +HtQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH/BLhPm1BUeEfd82pM37Rp6kOyAgSWleVAw7souBlI88NycQaPnHiJ/KgPh4FQ9RmpCJgrk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndWMeXuSf43m+NcVUi1LUZ9HfiBusTcnJsCUuWIIYdf0xbOuY
	CCn1upPeafF01kgddas6G34B8+hpzPo3Wf+XMit/rxRerjesn+s8it2Q
X-Gm-Gg: AfdE7clphM3+xMJAOU4KBXMAKrcqACOyhQUAbOLVfk+fHWavlt3ZEFSMkfHxgKkcZob
	hpkCQgoh7fIf4lI8EE+BLwAa26lUjV8qGhrhIGDA32HLxnx3fX9GwetpVjeHRhHlf+Dem+0jW9C
	hXFT38fZsm35vWr1ni84r8Cv/MeKIPSSYhpjF1PULApC1BHDyNZAUVS/XiUeiSKHAT/qWjB27f6
	PLa2vYp77FOQ31jVCxm1q3MQgTMasfy8xba5AX9KNKwoupzJR8yG2qJslRPBMJBVVsK5typ9iFS
	cjPP613iwks27n2USSBxJRmize7HouwAypxmfX5N0Jw5/dCvrJS8aW5YbnN53cBvVLlGEkHoVPK
	JgXlo/jSB8cRTdTPns/rcyyZhOxKu0wvoDMjgoUgdiOfHNRmtJAl0VIv5Wzb1a0naDNQ2MTAWkO
	OtZ8LMwoiRlIw=
X-Received: by 2002:a17:906:f598:b0:c12:34ed:e100 with SMTP id a640c23a62f3a-c12873e7ce6mr70015966b.62.1782785744410;
        Mon, 29 Jun 2026 19:15:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3b7335sm323776a12.11.2026.06.29.19.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2026 19:15:43 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	balbirs@nvidia.com,
	sj@kernel.org,
	ziy@nvidia.com
Cc: lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private PMD handling
Date: Tue, 30 Jun 2026 02:15:40 +0000
Message-Id: <20260630021540.17297-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
device-private entries") introduced the concept of device-private
PMD entries, but did not correctly update the rmap walk code to
account for them.

As a result, when page_vma_mapped_walk() encounters device-private
PMD entries, it takes no action other than to acquire the PMD lock
and exit.

However this is highly problematic for two reasons - firstly,
device private entries possess a PFN so check_pmd() needs to be
called to ensure an overlapping PFN range.

Secondly, and more importantly, if PVMW_MIGRATION is set the
caller assumes the returned entry is a migration entry, resulting
in memory corruption when the caller tries to interpret the device
private entry as such.

In addition, commit 146287290023 ("mm/huge_memory: implement
device-private THP splitting") allowed device private PMDs to be
split like THP mappings, but again did not update this code path.

As a result, we might race a PMD split prior to acquiring the PMD
lock.

This patch addresses all of these issues by invoking check_pmd(),
ensuring PMVW_MIGRATION is not set and checks whether a split raced
us we do for PMD THP and migration entries.

Instead of checking for a subset of the cases after taking the
pmd_lock(), put device-private along with pmd_trans_huge() and
pmd_is_migration_entry(). Also remove thp_migration_supported() as
it is already guarded by pmd_is_migration_entry().

Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>

---
v5:
  * put device-private pmd handling along with the other two cases
  * remove thp_migration_supported()
v4: https://lore.kernel.org/all/20260624065353.1622-1-richard.weiyang@gmail.com/T/#u
  * refine subject and commit log based on Lorenzo's suggestion
  * put pmd device-private entry handling in its own if branch,
    suggested by Lorenzo

v3:
  * remove cleanup part, only fix the issue for device-private entry
  * refine user effect description based on Lorenzo's suggestion

v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
  * specify the possible error case of current code and user visible effect
  * besides fix, cleanup the pmd entry handling based on David's suggestion

v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
---
 mm/page_vma_mapped.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2ccbabfb2cc1..2d6c58488e3a 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -243,21 +243,30 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
+		    pmd_is_device_private_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (!pmd_present(pmde)) {
+			if (pmd_is_migration_entry(pmde)) {
 				softleaf_t entry;
 
-				if (!thp_migration_supported() ||
-				    !(pvmw->flags & PVMW_MIGRATION))
+				if (!(pvmw->flags & PVMW_MIGRATION))
 					return not_found(pvmw);
 				entry = softleaf_from_pmd(pmde);
+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+					return not_found(pvmw);
+				return true;
+			} else if (pmd_is_device_private_entry(pmde)) {
+				softleaf_t entry;
 
-				if (!softleaf_is_migration(entry) ||
-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				entry = softleaf_from_pmd(pmde);
+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
 					return not_found(pvmw);
 				return true;
+			} else if (!pmd_present(pmde)) {
+				return not_found(pvmw);
 			}
 			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
@@ -266,17 +275,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			/* THP pmd was split under us: handle on pte level */
+			/* THP/device-private pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
 		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
-
-			if (softleaf_is_device_private(entry)) {
-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-				return true;
-			}
-
 			if ((pvmw->flags & PVMW_SYNC) &&
 			    thp_vma_suitable_order(vma, pvmw->address,
 						   PMD_ORDER) &&
-- 
2.34.1

