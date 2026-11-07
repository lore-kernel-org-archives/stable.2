Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046175;
	b=k+q8qh6mD8FB5sq5NayndeF3UPm2f8wO93o61NVht0RTBGBn6eRArsR6FJjAEFsVFSvJ
	 IVxalcmFULN4xcOA8hZ7PfjP3kbDVFo38a4hbxTpldzHZFwaVA8NefG3uo8E30Tz8cGEm
	 ZgU7/CeFLHSsWgJvfua5BSebLHbRJit5zAi2BY3JQiY6efpt56us64TVSag1ZzQJSk5GD
	 gC10U+J/CquatGqtX2/6Dj7/GcE8hM9etqOErDySZNsnM6udOBImTWIRJsgXLwN7N8Zci
	 FmiNKQh+AQm+21stNe1EwzM+olSy3smao8EutqHmNGEGU68GApdADK/eY1ni3yRLRiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lrtlk6vzwq3FNZRQQvYR/vQu9TVr6dt1JKhuKUGHcL0=;
	b=XG7p7F6FAyj+SENq0njJIFoOLSlOJXMw5bncRmqA4mLfyiCh5MzNVGYMC5cWbp/UHsOo
	 TiTpY/tHkM7Qdo+TKz6LWwrvWI88K00kNX07Z5afxpQ6BHDTLTId1aIuDr3ik25B7+wIl
	 5dq3YTHDuYtNcbi/Jw6yopPtZFrCc3+5CYkVD2Ep+R+VwEaYKt8b8uFu+sBwZmSRKQM9/
	 HGVdP4D8tdNIu0TSs0QvHMBMJI/b0QI92RTMmfCchoQ4JZTTyctb+Hb+hey0VzRnVNmEY
	 sO4GQrjEtrVauAVaCRHpBVkikdBMYp5+Psu+O4Ej75HVS42ZnnfdVhwmczmpAHtoLaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtLsg23P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB7606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtLsg23P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7485C1F0089F;
	Sat,  7 Nov 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046174;
	bh=lrtlk6vzwq3FNZRQQvYR/vQu9TVr6dt1JKhuKUGHcL0=;
	h=From:To:Cc:Subject:Date;
	b=LtLsg23PAJagOpk0g0zU8z6bQA6bVx+IhptxPQX8WUMhv56WOXSQgsD0k3RpeqdA/
	 5mEBDO6sqs0thEEVYd4ANX3WDv0nkC8hYOfeFDEdblJ0Yn4ZNJfnYTuAAU4ovywLgp
	 fdw7AZQtr1mmwr2Ww8TL/8hoAC6+ZzZFBKP5KZljAHboN6Wm4GUucL6xZZ5kP3Niv7
	 kVcGlz0SmC+7a4rAubW+wI20QhkOFVBo+6JGkY7kJFSw6K/ln9VX67NsFOakNN14l4
	 gGgKLFiL7GMUKdK+AC/sHKIOGg23afyqqtEkw+OWkDEUn8BjPwlaKuwjXSqYsJcC+l
	 wFRFDUoClOVxw==
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
Subject: FAILED: patch "[PATCH] mm/hugetlb: charge folios to the target mm's memcg" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:32 -0500
Message-ID: <20261107050932-failed-6.18-c2deb1356d82@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c2deb1356d82c9d54bd2fcf1241cc97eb66fd81f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050932-failed-6.18-c2deb1356d82@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




