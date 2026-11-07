Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046826;
	b=GA6AkAjVvt2+Dfa0ysHUOmfplce1DxL9ChsqTDfa0Ckl+LPoCHa1mtKpiaeWWvffashP
	 ytYReLf0n5OvwGKVK96on+4OHpJVc4QjYEhucn8nilFkuH+hPhTaYrSXHBVH2T8Niu6jK
	 vM3aHQNDTyo4JEM4ulMqokuOhczX4VmbEvwdXjsvqc5rUEZezAUov7Efw9fU7h5LDCYbE
	 5/f2ui3ZqbTDoi7OK6W8C+h2VF1IVD4+1q0jJBHmVrNooAWA//Pn1kBdzvAYxghu/vFk2
	 lLuWWuythRi14N3MTy8nWytGbyWBpessJ1+vEol5fCldJKAtHGL4sAxaXeq3BuvysiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Iy1L1PvNDCqykgODwwaxpnAJfm7vgBqMZOOlU5gERh0=;
	b=jCdtS8YlKjU2tLtF0HnV7xRcT/hihzn/5Nak235EtGJjh8/8eSyV8+cXnHafUav3L1um
	 8Wihcj3px+Wwu9RUqWWxF7KEMeNibzAC6zXZ6a0QkGXcn06Ik7olLbV4hyK3dNBYpagxt
	 SQHOMCrQE581Gx7cKsWf/0Af5lc3Un6ltWKpUh8YGjJfR3BnQEbBES+JAHeyGXEbLPvyg
	 RoQ1udyM3p2X9iFmtOGOisUMqgnSglQSsSjsP3IixcQbLH6VH9QanaMeBZoTuk85eCvOo
	 +ex0U+nmgN8W222pS/epg7/TCqGh59LOQylJSocNtyP+zIt8nW46bPc9Qvye1Qyf9Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evD28z2t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F64606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evD28z2t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46001F0089F;
	Sat,  7 Nov 2026 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046826;
	bh=Iy1L1PvNDCqykgODwwaxpnAJfm7vgBqMZOOlU5gERh0=;
	h=From:To:Cc:Subject:Date;
	b=evD28z2tuJRgzanlWGdymm6ZD5xxa54u+SzN5Baw9XZyqSla/bcN9ME/6rCM7AGwy
	 6m1EDS5weIyu9P6nVcZ2VPncryoTSYcEHDV8i1TWoUmRUlTo1yACO79MeV7P8X037Q
	 o98JSexyTrUlaCQqmgvT792VO5QyNJObeVp089FAGMfQhZVpXjmj5X0TDa2HVA/X+H
	 Proo0PflWgIN0MQo7gzgMML20JwED0QBd458dnMilRgyhY8anMvdTHH2OpkLSrWsZK
	 xReH43CEKtimJWyFLuz/ZBcl8AGLYfdG2emO88XncoRSGN45NX9wiim90BbWL6BsNN
	 JNo9J9R8npwqA==
From: Sasha Levin <sashal@kernel.org>
To: jinmengzhou22@gmail.com,
	zhoujinmeng@bytedance.com,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	lihongfu@kylinos.cn,
	david@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	nphamcs@gmail.com,
	osalvador@suse.de,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb: charge folios to the target mm's memcg" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:23 -0500
Message-ID: <20261107052023-failed-6.12-c2deb1356d82@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c2deb1356d82c9d54bd2fcf1241cc97eb66fd81f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052023-failed-6.12-c2deb1356d82@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c2deb1356d82c9d54bd2fcf1241cc97eb66fd81f Mon Sep 17 00:00:00 2001
From: Jinmeng Zhou <jinmengzhou22@gmail.com>
Date: Thu, 3 Sep 2026 15:50:48 +0800
Subject: [PATCH] mm/hugetlb: charge folios to the target mm's memcg

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
---
 include/linux/hugetlb.h    | 3 ++-
 include/linux/memcontrol.h | 8 +++++---
 mm/hugetlb.c               | 9 ++++++---
 mm/memcontrol.c            | 6 ++++--
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 900c95e346b2e..80a5a03e9cee7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -694,7 +694,8 @@ enum hugetlb_alloc_flag {
 #define HUGETLB_ALLOC_USE_GLOBAL_RESERVATIONS BIT(HUGETLB_ALLOC_USE_GLOBAL_RESERVATIONS_BIT)
 
 struct folio *hugetlb_alloc_folio(struct hstate *h,
-		struct mempolicy_interpreted *mpoli, u8 alloc_flags);
+		struct mempolicy_interpreted *mpoli, struct mm_struct *mm,
+		u8 alloc_flags);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c799926435560..058ebd73ff160 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -647,7 +647,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
-int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
+int mem_cgroup_charge_hugetlb(struct folio *folio, struct mm_struct *mm,
+			      gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned short id,
 				   struct mm_struct *mm, gfp_t gfp);
@@ -1146,9 +1147,10 @@ static inline int mem_cgroup_charge(struct folio *folio,
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
index cdb7d8df666a7..c59ebbcf66845 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2844,6 +2844,7 @@ void wait_for_freed_hugetlb_folios(void)
  * hugetlb_alloc_folio - Allocate a hugetlb folio.
  * @h: Hugetlb state control block.
  * @mpoli: Interpreted memory policy to use for allocation.
+ * @mm: Memory descriptor of the allocation target.
  * @alloc_flags: Flags controlling the allocation behavior.
  *
  * Allocates a hugetlb folio and handles cgroup charging and global hstate
@@ -2853,7 +2854,8 @@ void wait_for_freed_hugetlb_folios(void)
  *         -ENOSPC if cgroup charging fails or no folio is available.
  */
 struct folio *hugetlb_alloc_folio(struct hstate *h,
-		struct mempolicy_interpreted *mpoli, u8 alloc_flags)
+		struct mempolicy_interpreted *mpoli, struct mm_struct *mm,
+		u8 alloc_flags)
 {
 	bool charge_hugetlb_cgroup_rsvd = alloc_flags &
 					  HUGETLB_ALLOC_CHARG_CGROUP_RSVD;
@@ -2908,7 +2910,8 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 
 	spin_unlock_irq(&hugetlb_lock);
 
-	ret = mem_cgroup_charge_hugetlb(folio, gfp | __GFP_RETRY_MAYFAIL);
+	ret = mem_cgroup_charge_hugetlb(folio, mm,
+					gfp | __GFP_RETRY_MAYFAIL);
 	/*
 	 * Unconditionally increment NR_HUGETLB here because if
 	 * mem_cgroup_charge_hugetlb failed, freeing the page will
@@ -3051,7 +3054,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		.nodemask = nodemask,
 	};
 
-	folio = hugetlb_alloc_folio(h, &mpoli, alloc_flags);
+	folio = hugetlb_alloc_folio(h, &mpoli, vma->vm_mm, alloc_flags);
 
 	mpol_cond_put(mpol);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bd1e7e1544265..86ff580c70183 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5265,6 +5265,7 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
  * @folio: folio being charged
+ * @mm: mm context of the allocation target
  * @gfp: reclaim mode
  *
  * This function is called when allocating a huge page folio, after the page has
@@ -5274,9 +5275,10 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
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




