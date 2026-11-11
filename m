Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356633;
	b=B/8GmQmBmDDf/AbFMrLUzuJKhNWe665jwWFiHLw4wCzj0CCzYC3NSVk31A6Gdjx6w2MV
	 K0bPNHXjCii+S1U593hsBvYu8ofUgCHRKjSH+ShnglHABKgPnvIXGL/dUxCmlCbuOUEnQ
	 XOys3877doaUyYsu2kLPHCbzW7qjN+HtF7n/OrXfUOhZ16WzVP9a9PhVDugzZsPrye2S7
	 ZAdb07hwxh7IjewogWwrYWPe1pHn1PdfuV2vyyhmHXihoM2st+M8ug/Qf0kS8cuxYrtXQ
	 Fg6N39Dr7RT+Qar20iOoaT63vhPotnw7+CR9eg8gANBx6FXLPinZv229wvP5r+5zHIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/jqsQx//57Km+wTcF4mtArZYDImIFskYwPOlHgb7KLA=;
	b=0zPLSzwaITaIPgAVpvg81qt7Exk5ipUPw5obaFKs/q+VT7wG0yfh5q6fc0hWNPFpRgbF
	 fut92iSESiKLRZtKwxIFryQvJGMJaZsIJ0AnWsHQT5In0UxHlPSzgsI+f+2n0BBINxuC2
	 a+LymMAVO/XRbyStO1tv8egzIS0I8Zwq1cBwXimDTXKICYioavD8N9eH9XsYFNSWGrBJ7
	 Bu8XS0tDncB3ZwA3SWYEVHwye8/L/f4XHjLoc7CK/Ix8tmfTUIh7uo4Ubm6IZ5ENpBhjV
	 bTXtRI5I8p/TZlrUKEAK588F1d4chSdB2+jV7PpPx/OCUU0aNiSnv8YqfGqs1PCx57g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWumpYEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B29606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWumpYEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF21F0089F;
	Wed, 11 Nov 2026 00:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356632;
	bh=/jqsQx//57Km+wTcF4mtArZYDImIFskYwPOlHgb7KLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWumpYEek6V15ldiKDd4mM9mtkkSRfM1SW3lku9VhpAMSouG5S283lYZZfF0ohRFK
	 zAI72E0R7+5oQ4C/ZHS/f8wenxSmp9SRdunxv2csN1sP0IoW9SkyNgC0rnJLXMqH9D
	 e7KP6RSr6bRseDGXV47TT6EHQOSxkThl15Ai7LjOJvATmx+plXt7WSgcKHsSjqxtPh
	 42dnKgG6ZisJk0QQGbppScnmMPPBaTMOaRaOByTwDPX/f7xW5rkxT0e4Kw9lhXk1sT
	 yx5uggZL0IUMqWClkPOvckas+UiXJ6IKjbd+NS3F/J8mPTEa9clKV/pF8BU2L5gCxa
	 +9MsWDVCt8pLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Alex Shi <alexs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Frank van der Linden <fvdl@google.com>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	James Houghton <jthoughton@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ma Wupeng <mawupeng1@huawei.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm: hugetlb: return -ENOSPC on memcg charge failure
Date: Tue, 10 Nov 2026 19:23:48 -0500
Message-ID: <20261111002224.251188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050856-failed-6.18-956aeff185e7@kernel.org>
References: <20261107050856-failed-6.18-956aeff185e7@kernel.org>
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

From: Ackerley Tng <ackerleytng@google.com>

[ Upstream commit 956aeff185e7e16b989202bde0bb29859adba99d ]

Patch series "Fix bugs in HugeTLB allocation when
mem_cgroup_charge_hugetlb() fails", v2.

In hugetlb_alloc_folio(), when mem_cgroup_charge_hugetlb() fails, there
are 2 issues:

1. free_huge_folio() expects a non-refcounted folio and will
   VM_BUG_ON_FOLIO().

2. -ENOMEM is returned, causing an infinite loop retrying the fault.

This patch (of 2):

When mem_cgroup_charge_hugetlb() fails with -ENOMEM, alloc_hugetlb_folio()
currently propagates this error.  This results in the page fault handler
returning VM_FAULT_OOM.

Because HugeTLB allocations are high-order and use __GFP_RETRY_MAYFAIL,
they bypass the OOM killer.  Returning VM_FAULT_OOM to the #PF handler
without triggering the OOM killer (or having it make progress) leads to an
infinite loop of retrying the fault.

Avoid this loop by returning -ENOSPC when charging fails, which maps to
VM_FAULT_SIGBUS, terminating the process cleanly.

Make mem_cgroup_charge_hugetlb() fault handling use a common error
handling path, the same handling used for
hugetlb_cgroup_uncharge_cgroup{,_rsvd}(), which also don't trigger the OOM
killer and hence opt to terminate the process with a SIGBUS.

Link: https://lore.kernel.org/20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-1-4b4a8a19a7f7@google.com
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
[ sashal: Adapted the change to alloc_hugetlb_folio() because hugetlb_alloc_folio() has not been extracted. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf1188e9b1c9b..2a79a3663bbc9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3134,7 +3134,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	if (ret == -ENOMEM) {
 		free_huge_folio(folio);
-		return ERR_PTR(-ENOMEM);
+		/*
+		 * Return -ENOSPC, since retrying the fault is futile:
+		 * the OOM killer is not triggered for HugeTLB.
+		 */
+		return ERR_PTR(-ENOSPC);
 	}
 
 	return folio;
-- 
2.53.0

