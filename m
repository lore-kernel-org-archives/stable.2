Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640832;
	b=0HhrjT3Q5e2/pML9Reyrcb4Oif+DzbnrofKr2D/acnQO6ETUzVdnUNc9EgUHd8AJ3QkX
	 8euojwcDPWLp6xIKDkYgr3VF7QlUh/VSM53klWTfqV8qAPC0jS7KqFJdF+YA6Yl+pJHqY
	 rEQt+zMpPLXY637d3WmJBLkG1F+m2WRdXhozFc96XweGPqPQ2IAQPhZTpvfF/xCJci5mW
	 zIKHIiPY6j2U70RdNzpJ14j9yZa8oRye+9U31sqy9zMkDE2d8cJ67Ah4z2CDerOD3sHvj
	 HuH2GXbKJi/yGQ1tcti+yHO4qrrZgAwLoVGBGeWyYcoWOzam4Eu1uJ22JHIJsYS35uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640832;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:
	 X-Original-From:Content-Type:From:Message-Id:X-Mailer:
	 X-Lms-Return-Path:To:Cc:Date:In-Reply-To:Subject:Mime-Version:
	 References;
	bh=EL4zKSYauXV7QL1vcktxiMTY6CZlzl+ylN8VKzLTC2Q=;
	b=pzIv3o13tW4nml+KtA7AjHmF6Npzsm43DAVnr0CsHjuAWoZtv9kcJ49cAP/Fpn7cHoh3
	 NrYWuzrrkVthdUzRC0pfPylmdKm+7sWgacn/MxHzMb1V6REM/D3u1pQoXwBZWGG6FPhrE
	 nZRC0UN//9GVkN41qT5Yd7Dhw3Y2APnfLiVO3GtMDZHL36ErEmBdLK8lApNoH6Aw0C2LV
	 kvOtFwzngUGqlcuQnLGpBSV1t2FELxH0U76zmCn1lXiPCmkq4vwI/dtTnS77OWghUAa8O
	 r/9lyh/y4T85ASfZg4rCRMO4Know51SBnfY6qSOwuo04sg+d90PeAtFnjB28KgRYrpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=K3f98Rs1;
	arc=none smtp.remote-ip=209.127.231.112
Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FD606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=K3f98Rs1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792640829; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EL4zKSYauXV7QL1vcktxiMTY6CZlzl+ylN8VKzLTC2Q=;
 b=K3f98Rs1NkB9oom9GLMnHZbnPNh9mShGWGYlODPn5T9y6oUXL3b7QLHpqScwXoxs4xluQD
 n0Mj4Z/PuCJz6JcV2cw708BrCmI0eCQ29J3E2/5rifIYK9N5wpzQFV9Kpx02fVj1ls4Z1G
 kenZ4t3hmsX+2G7CYKCW3JOOuo9p2Uz0EmM+mVVHYe+z4hyMIfCVIJMz/Ulb9EsyYzrIsR
 mVfxEUbdZGCpDuWk5MyVtQe88t0vAtmyu1W2bKokKOc7SDE7lCCdwuf9WkqxMVX/NcFoDJ
 lcJUlD078tqWfyKHEX+3HxZ8DXacewt7RYwMUs+bPJIu1H/8Svkq8SIw1zTwWA==
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20261022034543.51226-2-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26ad98731+c58b6e+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>, <muchun.song@linux.dev>, 
	<osalvador@suse.de>, <peterx@redhat.com>, <rppt@kernel.org>, 
	<azpijr@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>, <stable@vger.kernel.org>
Date: Thu, 22 Oct 2026 11:45:41 +0800
In-Reply-To: <20261022034543.51226-1-lizhe.67@bytedance.com>
Subject: [PATCH v3 1/3] mm/hugetlb: fix mremap move length truncation
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022034543.51226-1-lizhe.67@bytedance.com>

move_hugetlb_page_tables() returns the number of bytes moved, but
its return type is int while the generic move_page_tables() path uses
unsigned long lengths.

A hugetlb mremap() move length above INT_MAX can therefore be
misreported to copy_vma_and_data(). The out-of-range conversion to int
is implementation-defined; on common 64-bit builds, for example, a
4 GiB move can be reported as zero, making the caller treat the move as
a failure and use the wrong length for rollback.

Return unsigned long from move_hugetlb_page_tables(), matching
move_page_tables() and preserving the full byte count.

Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Cc: stable@vger.kernel.org
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/hugetlb.h | 15 ++++++---------
 mm/hugetlb.c            |  7 +++----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 16c4c4caa126c..d73e3cf7adf9f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -121,10 +121,9 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
-int move_hugetlb_page_tables(struct vm_area_struct *vma,
-			     struct vm_area_struct *new_vma,
-			     unsigned long old_addr, unsigned long new_addr,
-			     unsigned long len);
+unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
+		struct vm_area_struct *new_vma, unsigned long old_addr,
+		unsigned long new_addr, unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
 void unmap_hugepage_range(struct vm_area_struct *,
@@ -339,11 +338,9 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 	return 0;
 }
 
-static inline int move_hugetlb_page_tables(struct vm_area_struct *vma,
-					   struct vm_area_struct *new_vma,
-					   unsigned long old_addr,
-					   unsigned long new_addr,
-					   unsigned long len)
+static inline unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
+		struct vm_area_struct *new_vma, unsigned long old_addr,
+		unsigned long new_addr, unsigned long len)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cea25773a6c95..4a70716deaa41 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5139,10 +5139,9 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	spin_unlock(dst_ptl);
 }
 
-int move_hugetlb_page_tables(struct vm_area_struct *vma,
-			     struct vm_area_struct *new_vma,
-			     unsigned long old_addr, unsigned long new_addr,
-			     unsigned long len)
+unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
+		struct vm_area_struct *new_vma, unsigned long old_addr,
+		unsigned long new_addr, unsigned long len)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping = vma->vm_file->f_mapping;
-- 
2.20.1
