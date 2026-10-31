Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440272;
	b=FBSz+UTbRbOcDM29smC0BvYZC5eGD56KpdDBgaXH0qL6Cj0sbgRynabwzPyCZm1o65Ms
	 POf6A+gdjABmDgG3LXeYzofQauIj4Jl4a5ImbDBfLNgCXQinFi4BbcS8hS6JYk0RtpLpo
	 hqY1OjcLy+esdVQOoiZznomNCDdSr0XoLWO+ix9gYwX/5nrYqv57p8ch0jbIeZllfswP0
	 L6C1X4Nsqu/LB2eSluO0pvHnuAsgEMEavahjeUQjhXlYbyifzc+UECKKcNRR4ejt4o3HJ
	 v9OhepHrkwdM1STO+SZKCpnNDjeWR1D1E27YPl76zh1Vp2Jf4xb5Aa1rEhiK2ckXdGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440272;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+mdqIzAsIIX0hDPtIGlkqTrJ6UqGsvnIxPYb47Tkxp8=;
	b=DfEAL0OyMt4uuBYZe+5xkRoMcdgO9dJsxRwJKwb89GKfxs772deGAdAAUl6Zz4gkq2ij
	 fFYr0goRSI58O2x7h31Pemz8FmVBuZ/ZNj8vRlBczy5WU/i3GYwA0rh4Dfsqat7XDTUPt
	 +nvzihcuyvPHKkQ8vm8XfKPSfT5M6cDCvoBGG0zsySx1ORQ3ZFMwPeDUkzdMHVqnnWnYJ
	 fhYcd7UmOcnV8u1f3HTXuEBdin3mnRPbpw9guqhLtsvFjX9dL9eySIYfOpz9SzaD3ZaBB
	 rJgzOb7/hVzNBY9yocQ6iLA5Nk75VgaD4Q2N9pdCt3gGnXUZZo+Qo2WHtVrcdkc2lwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1L2IJBk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E018606A31D;
	Sat, 31 Oct 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1L2IJBk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A031F00919;
	Sat, 31 Oct 2026 09:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440271;
	bh=+mdqIzAsIIX0hDPtIGlkqTrJ6UqGsvnIxPYb47Tkxp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q1L2IJBk1UYzBtfKDnuKjvt1Eh6Q3bIUktoLikNCZ6Jw1+TriQW0C268VSGaBMAbz
	 Q0/hPGOR2DcTFYb29h7kiLQgDFE8ucwFgC8XWTOeOGwlqU1cE9Ile2Fk+xM0w5kPib
	 MF1ETc10nv04XMQE9BLy1BlHaloqBmLbha5DvRvoDpGHew1Zi+23UZXfCl/d2YyyV9
	 xXNN/HkAtDr8f3FK9D2m6zzJc8oL9rnn6jaj95I0vAeQlobd1HXipH+uBLNAqJScol
	 FlMkXqUKBKa2NlqXz+PbC/xrGvz50oAYOx1dJY+lv6gkq+VJAeWOXdMROyLBJv0bL8
	 +m58m6DyHiUmw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:11 +0100
Subject: [PATCH v3 42/47] mm/vma: call ->may_split() before a partial merge
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-42-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4117; i=david@kernel.org;
 h=from:subject:message-id; bh=y6ysHZk3en/dCY/5r795mBFI+9cSzDUZixTlFNwSLV8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs9K7DF/vFo4xHC2muohn02c+joai/n2Hc+Q3JT0i
 +Xr3z+lHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzE1oDhf07D1E29Gun3Dpw6
 YaW8IOiXeYx63skrTyQsWVvqv+pWTGD4X3Ih54il9dXzVWEn84+KiPhvYe3zqr4qYFZk+u/bk0u
 /GAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A driver can use the ->may_split() hook to forbid a VMA boundary at
certain addresses.

A device-dax device is a character device that gives raw access to a
range of memory through mmap(). device-dax refuses any address that is not
a multiple of the device's alignment through vm_ops->may_split.

vma_merge_existing_range() can move boundaries, but does not call
vm_ops->may_split.

If a range at the edge of a VMA gets the attributes of the adjacent VMA,
the function moves only that range over to the neighbour: one VMA shrinks
and the other grows. This is a partial merge, and vma_modify() tries it
before any split.

Take a device-dax VMA that lies next to another VMA of the same file.
The user calls mprotect() on the one page of the first VMA that touches
the second VMA, and asks for the protection that the second VMA already
has. The result is a partial merge. It puts the boundary inside a 1 GiB
mapping, which is a single leaf entry at the PUD level.

As part of the merge, the kernel looks for a huge PMD to split at the
new boundary. That code does not expect a PUD leaf:

    vma_merge_existing_range()
      commit_merge()
        vma_adjust_trans_huge()
          split_huge_pmd_address()
            mm_find_pmd()
              treats the PUD leaf as a pointer to a PMD table,
              so the "table" is the device memory that the leaf maps
            __split_huge_pmd()
              reads a PMD that the user wrote to the device memory
              folio_put() on the folio that this PMD names

Bad. While the code must at some point be taught to split PUD entries as
well, the issue here is that we move VMA boundaries such that they are
incompatible with the driver.

Fix this by calling ->may_split() on the address that a partial merge
would move the boundary to, and by abandoning the merge if the driver
refuses. vma_modify() then tries the split, which fails with -EINVAL.

Factor out existing split handling into check_split() and reuse it.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: improve description; cleanup the code ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vma.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1be613044b4a5..acdf00346cda5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -516,6 +516,15 @@ void unmap_region(struct unmap_desc *unmap)
 	tlb_finish_mmu(&tlb);
 }
 
+static int check_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (!vma->vm_ops)
+		return 0;
+	if (!vma->vm_ops->may_split)
+		return 0;
+	return vma->vm_ops->may_split(vma, addr);
+}
+
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
@@ -532,11 +541,9 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
 
-	if (vma->vm_ops && vma->vm_ops->may_split) {
-		err = vma->vm_ops->may_split(vma, addr);
-		if (err)
-			return err;
-	}
+	err = check_split(vma, addr);
+	if (err)
+		return err;
 
 	new = vm_area_dup(vma);
 	if (!new)
@@ -948,6 +955,10 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (vmg->__remove_middle && !can_merge_remove_vma(middle))
 		return NULL;
 
+	/* If middle isn't removed then it's resized, i.e. splits. */
+	if (!vmg->__remove_middle && check_split(middle, left_side ? end : start))
+		return NULL;
+
 	/*
 	 * If we merge both VMAs, then next is also deleted. This implies
 	 * merge_will_delete_vma also.

-- 
2.43.0

