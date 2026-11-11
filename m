Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368069;
	b=HTy7DBaufD2vhgatyhZtfKBI5GZG1t6X7GtyJttb2ervMTSIUwmXcJOlMe74GjWmsNwi
	 9cA4FutohpQDy9Den2uqFm8Jk1jEXhIN4sAYOpPoh+bRiGzXqHP3vXjxOdTD7wojqzoog
	 szvwWMpff3LNHF2mr/Otq/4PM3EVI5LmY1I67HtyiWXvw77XuNi/DPC6ICvnNzA/h23ss
	 5OaHHV9/10ofCzYBmh1llv59bTl66VgzwoFOG9AlRgzN0NwSt3SKWaB/F/Q5NCKR/UwJR
	 RuQ/m4bhnSeZbRmR/ACsLczcPC+77nVSthrDHSytcbrd/Q+yctxZ7/WAjItth3tZ9fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=brfLXQTtBAEVz4tA5zjwQJrZAN1zMoJqcCFWCst0xxw=;
	b=coad6XFasv/HO7Z6n9xjin8hAPgapsAcAnUkDcQFeEG8VESAQYm387hjP9lVMP9qXK45
	 jNkR+VjNRjrQv9Hwfr90WiXygG9uQiysZksKLRExerysMeH5yLC1wkUOf+DxNyFUvSzVQ
	 C4qYnHdv9SygUtplzBp3rOEGf5AxXN9TKOzwb3ZAW/kHKnLWXeMPTMP44gZsoVbGKdueP
	 na1y1TUr2bdn/zYSVu6ubhShhCF/bDQ4d99Jqw9sb+ceGY4chxdXQrFo3wCO1CiEJU3Fg
	 gGPWKVXIwgNMDAJFW78zU8dZ1gHXxsqi3D9MuiItfcEdBpQg/wvxJ20dOg56cB/A+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zoo/ppen";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49A606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zoo/ppen
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3BA1F0089F;
	Wed, 11 Nov 2026 03:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368068;
	bh=brfLXQTtBAEVz4tA5zjwQJrZAN1zMoJqcCFWCst0xxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zoo/ppenG1K7XvdhIg/VrX06oGRlqoD1UsU9OfPW7ggMGD/s6XQjtTfwDDr4mOiTn
	 aQgcXh7MmhwoXZ7LwI6k9YPeW72Lv2j7uvsz9Y85fZpTKFne1Ofu1A9McwTTydgO5n
	 2t5/JvgLwWEYYG5Rf2YNFcxjKPmqCZxQovbyOTYs40QhSEMD3p//mZz5BYruXGg3nY
	 chxsDLtCPMrOUpjXi+uhnJpqzf5VvAxrqs8Rmzf4bzDO3lUBdiPnLeFAXC7X/unz/2
	 6ON1wXoQOXUxvgcT0hLx4RXlxa2A+YZNXTxX7dEgdyU4QHKp2T/6ZKzhtIa6cSkIOq
	 9ebZ0hidrywQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinmeng Zhou <jinmengzhou22@gmail.com>,
	Jinmeng Zhou <zhoujinmeng@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hongfu Li <lihongfu@kylinos.cn>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/hugetlb: charge folios to the target mm's memcg
Date: Tue, 10 Nov 2026 22:34:26 -0500
Message-ID: <20261111033332.882305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050932-failed-6.18-c2deb1356d82@kernel.org>
References: <20261107050932-failed-6.18-c2deb1356d82@kernel.org>
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

From: Jinmeng Zhou <jinmengzhou22@gmail.com>

[ Upstream commit c2deb1356d82c9d54bd2fcf1241cc97eb66fd81f ]

HugeTLB folios are currently charged to the memcg of the allocating task.
This gives the wrong result when a userfaultfd handler populates a HugeTLB
VMA that belongs to another process.  The UFFDIO_COPY ioctl operates on
the userfaultfd context's mm, but get_mem_cgroup_from_current() charges
the folio to the handler's memcg instead.

This can be reproduced by placing the faulting process and its userfaultfd
handler in different memory cgroups.  Have the target process register a
HugeTLB mapping with userfaultfd, trigger a missing fault, and let the
handler resolve it with UFFDIO_COPY.  The hugepage usage is then reported
in the handler's memory.current instead of the target's.

The generic userfaultfd population path avoids this problem by charging
folios to dst_vma->vm_mm.

Pass the target mm through hugetlb_alloc_folio() and charge the folio by
using get_mem_cgroup_from_mm().  This preserves the existing charge timing
and error handling while making HugeTLB userfaultfd population consistent
with the generic path.

Link: https://lore.kernel.org/20260903075048.3316-1-zhoujinmeng@bytedance.com
Fixes: 8cba9576df60 ("hugetlb: memcg: account hugetlb-backed memory in memory controller")
Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Hongfu Li <lihongfu@kylinos.cn>
Cc: David Hildenbrand <david@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
[ sashal: Passed vma->vm_mm directly to mem_cgroup_charge_hugetlb() in alloc_hugetlb_folio() because hugetlb_alloc_folio() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/memcontrol.h | 8 +++++---
 mm/hugetlb.c               | 2 +-
 mm/memcontrol.c            | 6 ++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 706ddda4a60b1..d88f241e565bc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -662,7 +662,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
-int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
+int mem_cgroup_charge_hugetlb(struct folio *folio, struct mm_struct *mm,
+			      gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
@@ -1172,9 +1173,10 @@ static inline int mem_cgroup_charge(struct folio *folio,
 	return 0;
 }
 
-static inline int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp)
+static inline int mem_cgroup_charge_hugetlb(struct folio *folio,
+					    struct mm_struct *mm, gfp_t gfp)
 {
-        return 0;
+	return 0;
 }
 
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf1188e9b1c9b..8993bd37f6cd8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3124,7 +3124,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	ret = mem_cgroup_charge_hugetlb(folio, gfp);
+	ret = mem_cgroup_charge_hugetlb(folio, vma->vm_mm, gfp);
 	/*
 	 * Unconditionally increment NR_HUGETLB here. If it turns out that
 	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 97ed5ad4053f0..2860de542a4af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4768,6 +4768,7 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
  * @folio: folio being charged
+ * @mm: mm context of the allocation target
  * @gfp: reclaim mode
  *
  * This function is called when allocating a huge page folio, after the page has
@@ -4777,9 +4778,10 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
  * Returns ENOMEM if the memcg is already full.
  * Returns 0 if either the charge was successful, or if we skip the charging.
  */
-int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
+int mem_cgroup_charge_hugetlb(struct folio *folio, struct mm_struct *mm,
+			      gfp_t gfp)
 {
-	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
 	int ret = 0;
 
 	/*
-- 
2.53.0

