Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072707;
	b=pqbDcJk+5VOoEEq+8470NFzK25oqNevoM1wCDFBYj0APH3ibY68/XT30NdAD6DRbaj38
	 tWzmKwogFwK88sKVdsIWNnol33Qf0wWI7+3rkuDPXtMdB/wB70L+kVgmaesy65h/hkHk9
	 6gqBJDpwuqimz0a0h2JO9GEKZqwpx0lf35Ot6YLyWwzY62QjQGsCrW/U8V9FszzkO6ry+
	 ttOlfikoNiUw2N71YthaNT5fvvnq+p6qUciRHIB5zeXadoeMeWCPHOrQJkPYyPNS48OMy
	 9o7BZ9lhylobvjWrOPU74dIMBx+VQ0O1hCtk1cDNda3I3JTy/stKZpJJbJdtddfwGSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=7Mznwc8GrpzJ8tK5EL1ob+iPEtoev+BzmKX7CHPnJ74=;
	b=xY0qbnZrNW5C6c/na5v3hUH+m7tCoBjuhFx/8llVi5HM3FtpoM5F/EsCI9N7rx0Okx62
	 hR77BHk/UHmJbc2sX3u/ZKpGKHHv1npPfs7nhon19aaEI+rV8suOUa4Ivq27IZGHGw0gK
	 xbGNEcKAnLmbYmAMRs6kpMYoIdsAgwJCfjzwE2jwbEaNNuEVY/3w3Wd0+749xjwpS0ihQ
	 1181B27I/8iv0YHa2eKNNvgkQ6DZ2FuHNgu2Ka/CQzR543+F0BlK+uhX7Go1T3Kf6vk8L
	 4uqRSVdTtStsnchOc6lRi3vqI85J9S2Vgr9ZzmHwB538s/yaINjWcUVabehG9fNKgpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LpEct1xf;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A4606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A2A4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LpEct1xf
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so645886a12.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072704; x=1793677504; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Mznwc8GrpzJ8tK5EL1ob+iPEtoev+BzmKX7CHPnJ74=;
        b=LpEct1xfjN1thI8TbP1fFa5w4w7QpAjyNF4cILo4hjgANhwzNTKcYl0/OAf4qytQ+D
         bTfw0B3W1YrJQBpG4CQa8BYUw8l2YA95j8Iad3IOM19h6jXJAZgZVZG4NeFqABxjmQVx
         cqyrWzfJOtShgzKATE8MA+KO/cZ6XpKKBzqfRYPV63n+KEkSREwYLpTIdKLylOucISku
         0b4t0cDOYZZ8VUkN5GYjeY7kLbNFUAZvUWcO7vKMGLuSX/T0QUI3kWhBk14nybsQgrpx
         sgvekJqRyNLDD3CwyDUMJUgSY/E+TGZ5+ZTFoQY3fbSMcNnskQ516a1VLRqdlAxCgpFM
         NMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072704; x=1793677504;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Mznwc8GrpzJ8tK5EL1ob+iPEtoev+BzmKX7CHPnJ74=;
        b=NJ0uFagUF3p2+Fjlfh8ICMHgbVfEozhXzbY3HZH4N1Ze9/geicxx7LZYkA5f4XrsCV
         k5hokvi9NlLQ3oWHqV5/ldEJH7NZ4lKLI5eTOxxUM4g7LsaG2V64sO719MplooqJfTx5
         eHjqT4Q36HvBZvnmnZDvWkbd2bW6CHBGM7lujkHaSPjcgJQEwbpG2dcvF+V5Z4TbbZoa
         9mvPLFH+F64x63DUgvbTbHheVcwKVDg/Cg1tVQtwXQnCMbv+Q0EC6oI7yOemBxt2GIRI
         RV+zEpQJMzYzGJKcnmHszQiVngLBqBOXe7XgICfDIdocmxdBAPeTcPWL2tgrZXx69iRB
         CQTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzJehJP34VMGU1EHZDvzhvCsDxMzKKRPqZbJlwYRHCSy6tFsUueH3LoLWOB9XQjlOrO6UcE4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5HQwX+ZG0amtWHt16gYa7Qgo3VIdV1OKODJieNnEjwZohDu7L
	igydwdTjaskc56pSO/L2y7OFPRTHdq0BO4J1mV7I7NgksMkrk9T9Zsov7r1e0Ny0+8c=
X-Gm-Gg: AYBFou35G6LV2gP9iVrN12o/l9DprZVh2+ZHzqLF+ZU30/cDlO1dD87+8zocwIJn6z8
	C3QtygGAorupc3B3pb0j3HV1BFmywNp5uJtIDAhDKNyRIIjwLI7NijFTUkORiXMsyLi2dWOff1z
	NfrKZdq/f1C353DJGBpuAEH9L9NCXbhfbXnsdWjsj6p+249VjTSaMqNAEb/rwk8Nb81pAuAljcY
	nIaE7a0tNYh5yP3gTekG0kEB78O9o5igIF6RXdTPrYGupxdjIPko0UL16/Wjfc1nUF+teg61paY
	23NGsQXfQvVZTA5HwDXpwgDsBpIdSOedZPUoDOvHA9g5qenvb1rJA9jRdFeBAvTWoLf5E93tgAY
	QP4h+ZboQqBTTywItji60/yb42iwpXqfcv04wVTpRURoaNOekZx3MoI8LB5oD8LLT4KOZ+AG4P+
	EWhm2MLv4FKYne3HMGFaTdAdC5z1cf97JvMoySQNsYMZSTIQJ7QhDl4JnQxk1n3BmWjPkoh0+Vf
	E8btC8Y0I+ufFGWU+uZxUiGfRNlOn+qUjaWmkkETgr/iEI=
X-Received: by 2002:a17:906:9f85:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c46bded5befmr907107666b.41.1793072703836;
        Mon, 26 Oct 2026 20:45:03 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e7c83sm382468666b.30.2026.10.26.20.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:45:02 -0700 (PDT)
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
Subject: Re: [PATCH 41/46] mm/vma: call ->may_split() before a partial
 merge
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
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
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-41-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-41-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:45:01 -0700
Message-Id: <179307270137.1171062.14886397073081900278.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:18 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A driver can use the ->may_split() hook to forbid a VMA boundary at
> certain addresses.
> 
... snip ...
> 
> Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: improve description; cleanup the code ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Attached a vma unit test I used to test this

-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] tools/testing/vma: test may_split during partial merges

A partial VMA merge moves a boundary just as a split does, so it must
consult the driver's may_split callback. Removing an entire VMA during a
merge needs no split check.

Exercise permitted and rejected partial merges in both directions through
vma_modify_flags(). Check the callback address and resulting boundaries,
including unchanged boundaries on rejection. Also check that a full merge
succeeds without calling a rejecting may_split callback.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/vma/tests/merge.c | 87 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/vma/tests/merge.c b/tools/testing/vma/tests/merge.c
index b26f1a66a1707..fcc052be15601 100644
--- a/tools/testing/vma/tests/merge.c
+++ b/tools/testing/vma/tests/merge.c
@@ -1488,8 +1488,95 @@ static bool test_expand_only_mode(void)
 	return true;
 }
 
+static unsigned long split_checked_addr;
+static unsigned int split_checks;
+static bool split_allowed;
+
+static int merge_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	split_checked_addr = addr;
+	split_checks++;
+	return split_allowed ? 0 : -EINVAL;
+}
+
+static const struct vm_operations_struct merge_split_ops = {
+	.may_split = merge_may_split,
+};
+
+static bool check_partial_merge_split(bool left_edge, bool allow)
+{
+	struct mm_struct mm = {};
+	vma_flags_t left_flags = mk_vma_flags(VMA_READ_BIT, VMA_MAYREAD_BIT,
+					      VMA_MAYWRITE_BIT);
+	vma_flags_t right_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					       VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
+	struct vm_area_struct *left = alloc_and_link_vma(&mm, 0x1000, 0x3000,
+							1, left_flags);
+	struct vm_area_struct *right = alloc_and_link_vma(&mm, 0x3000, 0x5000,
+							 3, right_flags);
+	struct vm_area_struct *middle = left_edge ? right : left;
+	unsigned long start = left_edge ? 0x3000 : 0x2000;
+	unsigned long end = left_edge ? 0x4000 : 0x3000;
+	vma_flags_t flags = left_edge ? left_flags : right_flags;
+	struct vm_area_struct *result;
+	VMA_ITERATOR(vmi, &mm, start);
+
+	left->vm_ops = &merge_split_ops;
+	right->vm_ops = &merge_split_ops;
+	split_checks = 0;
+	split_allowed = allow;
+	result = vma_modify_flags(&vmi, left, middle, start, end, &flags);
+	ASSERT_TRUE(split_checks > 0);
+	ASSERT_EQ(split_checked_addr, left_edge ? end : start);
+	if (allow) {
+		ASSERT_EQ(result, left_edge ? left : right);
+		ASSERT_EQ(left->vm_end, left_edge ? end : start);
+		ASSERT_EQ(right->vm_start, left_edge ? end : start);
+	} else {
+		ASSERT_EQ(PTR_ERR(result), -EINVAL);
+		ASSERT_EQ(left->vm_end, 0x3000);
+		ASSERT_EQ(right->vm_start, 0x3000);
+		ASSERT_EQ(mm.map_count, 2);
+	}
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_partial_merge_may_split(void)
+{
+	ASSERT_TRUE(check_partial_merge_split(true, false));
+	ASSERT_TRUE(check_partial_merge_split(false, false));
+	ASSERT_TRUE(check_partial_merge_split(true, true));
+	ASSERT_TRUE(check_partial_merge_split(false, true));
+	return true;
+}
+
+static bool test_full_merge_no_split(void)
+{
+	struct mm_struct mm = {};
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_MAYREAD_BIT);
+	struct vm_area_struct *left = alloc_and_link_vma(&mm, 0x1000, 0x3000,
+							1, flags);
+	struct vm_area_struct *right = alloc_and_link_vma(&mm, 0x3000, 0x5000,
+							 3, flags);
+	VMA_ITERATOR(vmi, &mm, 0x3000);
+
+	left->vm_ops = &merge_split_ops;
+	right->vm_ops = &merge_split_ops;
+	split_checks = 0;
+	split_allowed = false;
+	ASSERT_EQ(vma_modify_flags(&vmi, left, right, 0x3000, 0x5000, &flags), left);
+	ASSERT_EQ(split_checks, 0);
+	ASSERT_EQ(left->vm_start, 0x1000);
+	ASSERT_EQ(left->vm_end, 0x5000);
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 static void run_merge_tests(int *num_tests, int *num_fail)
 {
+	TEST(partial_merge_may_split);
+	TEST(full_merge_no_split);
 	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);

-- 
Gregory Price <gourry@gourry.net>
