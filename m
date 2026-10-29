Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306380;
	b=f5jMjbNiOPr7iJ08ctzFEjhAkZVLh0/4yjHSTv1FLiHoj5l7+CYSqx1Upm9sa/nZeWno
	 uEKj0vFxgE/SV2NQfiF/A8uUSovUw3duzOnwWI1haVIajKt7ljjigH2bzzWDJsdHmtT9s
	 mFQ2/M4vo8TW8LpZ7gzKiZcEAnf287IolX1SGFy8cLSbznryG/F4sqzkQ7AIbSD8IMuuV
	 afG5IOPtnGi5odAaqlCjE0/zcuWWClbmI+EoKgSbEpP4vAndhXnwgYIZXplqYZG//Ob/c
	 Spn/k7HjCYBBL/NoJP051G2BIsWtj0O/WKkfQpz/gTkT8Z5PlpzXnyOYutNhwVtdydA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306380;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CAhC4MbhnDJXKKCQ+5YFJHRaqlB0ve7BM+PvgIjSMcY=;
	b=I5E24v9juoVI8kfXQQkhvG2le+8F+6NTs1cANj/1hm3ZgykhyZWwwQPRzm3AZGJOd1og
	 LEMHiyiCXKEqkF9YMpy2wuhciimTdPo3nUkvBkqAV0k+M3g1alZa81d8ZJ+U5bNTpp5xT
	 LaCR8Mufg5PvfuDAOFmfGtUDhGk8/XQp495mOnpcDZKd/TovdKPddvlYNDyBMIzhrkG41
	 HBiYLkdXkgvVun9aCve++gPvunGXlZ9oq+XNEM/b+YGZZZ65X//h6wdxnNYNnNNbByNHK
	 +5xo/HKJMUOPWgXhg6+Fr+Ia23IiiAAPvTeOJK9LXTCKO9ZQlnoyk8vwlDV/l9hPCag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGJhzxYl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF74606A322;
	Thu, 29 Oct 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGJhzxYl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA91F01824;
	Thu, 29 Oct 2026 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306379;
	bh=CAhC4MbhnDJXKKCQ+5YFJHRaqlB0ve7BM+PvgIjSMcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KGJhzxYl+9r92Bj9W2YAR+wgi/sM5nkmr2lgTbQ30j8ZUhL38hxRUC4bC5dp1p0E3
	 JHssW2r5kV05NN1RN0oNO86QRqKkSxnFUPWqVRO/1w8jPj0xBXyUFR1kMY+59f7FTY
	 9hZ0Drs+/V7tulyIr4vt7QO2GHInOb6FbOYl8Gq3QTUkufyiJLpdmPX7lLx8CWCV91
	 h9tesZc4td3L9agPTyeb8/iri3/sTsBiTHeu31Zd9M30RSZId3o/7i2lTFUMgD+EW0
	 5AxwI0RNtgE2rzG27RTB7FGyMtVkUfNrCk23sMzr/ddhNnQk/JNJAy8M0Bz7sROrk9
	 q2m2I+ZepkH5g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:20 +0100
Subject: [PATCH v2 25/47] mm/userfaultfd: wake waiters when registration
 modes are removed
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
Message-Id: <20261029-fixes_core-v2-25-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=david@kernel.org;
 h=from:subject:message-id; bh=p4m2oymzzbSLDXhAc0Cf9hknbaIjiA7t2PJNdiOyskg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21/bClg2vOzuLmVceYDuUKBTqGtbMq1QSm+LduOv
 F3V3JDUUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwES2vmH4H3T+ZnsN28rm2Pt+
 3GWvjafpfElmyHwp0Fm41MjI86z5eob/lfGbmP428sZp9c5n652hqvnusTvPzKqadww7fm1e/+U
 ECwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
faults that are already queued. For example, switching an anonymous
range from MISSING to WP leaves a missing-fault waiter asleep until
userspace explicitly wakes it.

When a registration change removes a UFFD mode, wake waiters in the
affected interval after updating the VMA. The VMA is write-locked at
this point, so no new faults can queue under the old modes and woken
threads cannot retry until mmap_write_unlock(). Waiters for retained
modes in the same interval may also wake and refault.

The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
with both read and unread fault events.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index be630674fda9..03f1b15bfe63 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2270,6 +2270,9 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 	return ret;
 }
 
+static void wake_userfault_range(struct userfaultfd_ctx *ctx,
+		unsigned long start, unsigned long end);
+
 /* Assumes mmap write lock taken, and mm_struct pinned. */
 static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
@@ -2287,6 +2290,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -2332,6 +2337,10 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 */
 		userfaultfd_set_ctx(vma, ctx, vm_flags);
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed)
+			wake_userfault_range(ctx, start, vma_end);
+
 		if (vma_is_hugetlb(vma) && uffd_disable_huge_pmd_share(vma))
 			hugetlb_unshare_all_pmds(vma);
 
@@ -3648,6 +3657,17 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 		__wake_userfault(ctx, range);
 }
 
+static void wake_userfault_range(struct userfaultfd_ctx *ctx,
+		unsigned long start, unsigned long end)
+{
+	struct userfaultfd_wake_range range = {
+		.start = start,
+		.len = end - start,
+	};
+
+	wake_userfault(ctx, &range);
+}
+
 static __always_inline int validate_unaligned_range(
 	struct mm_struct *mm, __u64 start, __u64 len)
 {

-- 
2.43.0

