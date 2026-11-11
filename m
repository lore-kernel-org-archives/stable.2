Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368875;
	b=YOObslU9mc/D41YgSJybViRSb4/acQnK/MNh+SKRR5VQppHnByZ/G2uYMuUoevNepkli
	 zgOw4Qxzzaf47XMYT+l6Q4e7e3aoZ2lcHoAK/GtMc83GNvB8icbRgVwQxcPOWTgWp9wxQ
	 FVQwkONhUyuCRz+H7iFyIBh4Roe69LgNTAw+svIuPLRC8MZ7uxZ49fLHGSd7C+9CIZg7U
	 Go7fzYxo/vsUSw9AsZWsR1sYzEzs5qb5COjgAFwOkURLOC0VjJTZtd8YYabLx4fKQzBCv
	 eUSsrLMcdz7s5R6+7KASrPeYOiDDR7xtgMUTLhqKEJVAOX2PKnS8ogQFfIs9OoAjJlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wF9OB5QsuXGnFQM/853UE5cZfziaxQ9tk5hF/Ow/D18=;
	b=ni0SvHNFe6IMyvQfQyxYnNxoJiDFA99aoFuwjhrsWD4jx5f5+WxcSy3x7tqZsSjH7a9Z
	 WzidEUQwRZeKyY2MhlKYaTeQAGM1NQj4HPyUfYvPgygOxGWOFAnPuNBuHTzF6WHUxF09m
	 fNzsQplxZ+HLiSuifHvx8dcDwuHmc22tVzRf9qEyS/Q+6dhXMISdzEZpbuUvwV89CheaM
	 DWpRhutTjNzfQWHCi6LNUzddA4WCc6OQONSVVkfXroIB5rND03FHzJh9A40CGbQAI+KvI
	 GWl4nDdVYEr48xmYgIV8GvHXWu03RBYPIJfIK3o3c5ZQGEIwPGqqbR66rdrY8KXsNSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3eiQlsr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B50606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3eiQlsr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F031F0089F;
	Wed, 11 Nov 2026 03:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368875;
	bh=wF9OB5QsuXGnFQM/853UE5cZfziaxQ9tk5hF/Ow/D18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3eiQlsrrPwwCSMJuU4agvMvio3xCYjAeFs1Yk+8bM66asonRBaVmSiMe/mnMY2aO
	 JAlbGjFCGEXicwvTwLEwymgXFhNwSKk6oWV46D504+phz93g1jIcUH6vv9Sgk16OzS
	 1Jt2TPxLxK0cuAtVGrOiF/LefAhA51KjYcFHRFldg2lZnpSi0OAyYwlY2Uiw+3f0tP
	 HqXRHDpojqwi/zjSvnCcYNNCYs1mJXnIh6/BElKFd+awpA9dgVx5fCYxO+Fs9o8Zza
	 U9P2m4lUfiM6WYAAxfDgL2qACKGx/HUir1rqUmToySANDvO9LIQcLS+ExUhTTtW5mi
	 yOqMecem0DUsw==
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
Subject: [PATCH 6.12.y] mm/hugetlb: charge folios to the target mm's memcg
Date: Tue, 10 Nov 2026 22:47:52 -0500
Message-ID: <20261111034526.953066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052023-failed-6.12-c2deb1356d82@kernel.org>
References: <20261107052023-failed-6.12-c2deb1356d82@kernel.org>
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
[ sashal: Used vma->vm_mm directly in alloc_hugetlb_folio() instead of passing it through the unavailable upstream helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d9443bdebc068..c60696b68462e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3013,7 +3013,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 
-	memcg = get_mem_cgroup_from_current();
+	memcg = get_mem_cgroup_from_mm(vma->vm_mm);
 	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
 	if (memcg_charge_ret == -ENOMEM) {
 		mem_cgroup_put(memcg);
-- 
2.53.0

