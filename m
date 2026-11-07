Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046147;
	b=rvcs46DHRpOgkjzo/lWVGJmCk07rLe+8PxOxbNYK23BSrVvw3/gGbQagsfl/Co5zc6nW
	 3RVxVBXeWNk04+YnJdu6bE040Lh3ZgChWKRSuk51h42ccfN2KRjt7aebK0Blsr53RZxoD
	 vCiTZ7U0yPCXT2PoIaY/j9Hcg0cA0Xjt7EazYVX6dQtcpusteJ/4qDklLiKRGl13LEhFI
	 9yoUqIoZfNdxcbVGJ3NR4Qu9NcZTy6z1oBt8/yc5eWZHp1s5CYIORrJ8ABMQHzSiV+zMw
	 2ojx0aqxZg9nCP1dygDOopG8NEeHkxZLoFO2Lie4CBoFgQHbdbceW43ihQaBucU15vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nKOebVwEdJLcbwLp+AGv/DXzjjsNzihXrrCs62L3iuQ=;
	b=kZjmMMlN+vPqMJ6ZKilVj1quqHdyO1+dMOraDgCDF2O3Op2SW+aM9I8H5rQLz7Nm8EcO
	 8Ljp6wpDpgGl5BdFow5a+QA3k5fKPV02Q2183x4soSfP6j5XH3jWLArcezznOQLBCO6Vf
	 0CC7cyz8b0GQiuJ1nRrgZqSboB768Ll/R6ICWyqfjG12oA4GccPaigx8f6fVWapgqs+uO
	 bT3zx8hauBP6mD/E1UOjm4yjBUNBWkpdghM91JBJ21MksaBv7Pb3kABD9I7Ldvy5r9gZE
	 imRhsY64R6M/qbyUJlyNjw1vMB98OanjiImfb/wjkYs0qrfOJjNDzF7MrZGpsv7gl/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqZ8rNZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EFD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqZ8rNZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872091F0089F;
	Sat,  7 Nov 2026 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046147;
	bh=nKOebVwEdJLcbwLp+AGv/DXzjjsNzihXrrCs62L3iuQ=;
	h=From:To:Cc:Subject:Date;
	b=fqZ8rNZiXAln7SnsI14YlrCMTABAx/cxbSJOIA64A6JJW4P8gAgOhVWDesGZckn0W
	 VyrFVRM5RK753NQCyIb0XtIxbSdSxSa0FcRWn27ZIObUZ9iTrRdt26M1rIwWZ4MwcS
	 SL4MDUb1nwdjyHlroYR4z57VOyOnxLqqDFDUNy+II1PGKY6m7GcvHEUfY31HpBDrZk
	 9QDNlHkn9CIbjooRTu38nBkBwTqwdQXIqtOMVh9AnJqFEHHk+jHlN6MWBUnPzgFijP
	 A2DLUQlaPGqPt0p/8kCNJVT7OdQ/92B5KmrohpqYgZ5u8P8hgr0+UnBa9Q1/7Zy85A
	 GBtd8vnp8EWog==
From: Sasha Levin <sashal@kernel.org>
To: ackerleytng@google.com,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	joshua.hahnjy@gmail.com,
	alexs@kernel.org,
	david@kernel.org,
	rientjes@google.com,
	dzm91@hust.edu.cn,
	fvdl@google.com,
	louhongxiang@huawei.com,
	jthoughton@google.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	liam@infradead.org,
	ljs@kernel.org,
	mawupeng1@huawei.com,
	linmiaohe@huawei.com,
	mhocko@kernel.org,
	rppt@kernel.org,
	nphamcs@gmail.com,
	osalvador@suse.de,
	peterx@redhat.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	vannapurve@google.com,
	vbabka@kernel.org,
	si.yanteng@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: hugetlb: drop refcount before freeing on memcg charge failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:02 -0500
Message-ID: <20261107050902-failed-6.18-e95d29c5df84@kernel.org>
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
git cherry-pick -x e95d29c5df84f19881cd30b491fc81aa98f44b45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050902-failed-6.18-e95d29c5df84@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e95d29c5df84f19881cd30b491fc81aa98f44b45 Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Wed, 9 Sep 2026 10:11:01 -0700
Subject: [PATCH] mm: hugetlb: drop refcount before freeing on memcg charge
 failure

When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
its refcount set to 1 via folio_ref_unfreeze(folio, 1).

The error path calls free_huge_folio(folio) directly, which expects a
refcount of 0.  Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
triggered.

Even with CONFIG_DEBUG_VM disabled, returning a folio with refcount 1 to
the freelist can corrupt allocator state later.

Use folio_put(folio) instead of free_huge_folio(folio) to properly drop
the reference before freeing it.

Link: https://lore.kernel.org/20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-2-4b4a8a19a7f7@google.com
Fixes: 991135774c0e ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Hongxiang Lou <louhongxiang@huawei.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Ma Wupeng <mawupeng1@huawei.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a16d04aae6196..cdb7d8df666a7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2917,7 +2917,7 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 	lruvec_stat_mod_folio(folio, NR_HUGETLB, nr_pages);
 
 	if (ret == -ENOMEM) {
-		free_huge_folio(folio);
+		folio_put(folio);
 		/*
 		 * Skip uncharging hugetlb_cgroup since the charges
 		 * were committed to the folio and freeing the folio
-- 
2.53.0




