Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807914;
	b=YoyTv20ycMOtyqjYElzr6Lp5FLGqqdKNvc8y0vF+LuxfjMpkrB9uo/m6ljo5X0eVHb6x
	 /uPHw2ZgwtS/ZVsjIY6cowubX1j8GYGTgOzXFOEUxSAyAM29MIXC/709nqroRAFO1oGHd
	 /KY2iE3nreoCNHIJvWbRpopMtz7DKGwsfHG6Pgpu3ZOz/HZ1OrOkdsEE/8LMPKhfMIQcp
	 S27ST6Tca0vtL1Mg8uITGZiZCtnArEUhZaXvcGLKgPuiZCN/7aCN+Ixdy4sQDiwnOl+dF
	 gn+cK3DNzAGhLq/8GW2tv2/zlIADV2kugCu7QXgDG+lvoLa1vUZCOGr/YsN+QH4dr/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OTEemdsRY+2XczJ9fXOIsg10ryCFgSHT+Mbnqk/oCXA=;
	b=hqxYxRjOLzgz0pTM1jCdHFyPLdEcapdijPwU1O2JmkbuoVusRmaTQzNOvPY5Eo/F02Sd
	 MZQwDSYJ6gYMeTJh1hDolDd5jmzMyOp49S+xrQX6ErLNfFP5rtrNoNl1IzIj+gUgVMQBS
	 Xqq0eOk2PkHaufL9Dgt65WGLZgUufEu5p5UVRXnCGCgt6bvGnY/bM+PBYcfjcDXTFwEAJ
	 dybxYuwtamowoJNrrOsC/7qq4E5CIiMvADgWQnuDHfEBjnnXYPDc3z+8cpy6fQMO0BEXK
	 Ba71iH1tuEdTH8AcXgSlHfvZJEXa4iFIykaxvg9Syd1hRwgd5ekQmDvnbk6Pt7SE5Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdtD6cki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88411606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdtD6cki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085C81F000C1;
	Wed,  4 Nov 2026 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807914;
	bh=OTEemdsRY+2XczJ9fXOIsg10ryCFgSHT+Mbnqk/oCXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdtD6ckich8rYo/vlKTkcrFS3BjdLDaHCceIHI2EVcDcJH9K5aKy6sIUYAP2ux00f
	 gqk5Ypu+gJzSMqB+ci5OX0ax00iN2qFZfDDbx57YR8y6EKRYmp4vYb9DA1n9Roj/sW
	 oee6HeS+ooryWQXutfuUtHGEOM03246P8gQ5epsCE8a57s4HSE5f8FwpsW+XzaNHwx
	 +cq//LmZZRVQR2OCIOVw55TXqq2qvKRFHhqyEFlIJ7fgjFYWqfZbGbzR4TSCWkZ8Ee
	 c7uRNTda3cAjP84hlT/IOuiNU6iMhuOzSV9sT+L+IzuYDb5RNcdZdtZu+PJr3J0dpu
	 AbL/nnRM+Q4iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ackerley Tng <ackerleytng@google.com>,
	Breno Leitao <leitao@debian.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] mm/hugetlb: stop using avoid_reserve flag in fork()
Date: Wed,  4 Nov 2026 10:58:27 -0500
Message-ID: <20261104155731.3920547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110456-remix-oversold-9ee1@gregkh>
References: <2026110456-remix-oversold-9ee1@gregkh>
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

From: Peter Xu <peterx@redhat.com>

[ Upstream commit be8d7314b18ede1c6cdebbb982c9659020e2f1f2 ]

When fork() and stumble on top of a dma-pinned hugetlb private page, CoW
must happen during fork() to guarantee dma coherency.

In this specific path, hugetlb pages need to be allocated for the child
process.  Stop using avoid_reserve=1 flag here: it's not required to be
used here, as dest_vma (which is destined to be a MAP_PRIVATE hugetlb vma)
will have no private vma resv map, and that will make sure it won't be
able to use a vma reservation later.

No functional change intended with this change.  Said that, it's still
wanted to do this, so as to reduce the usage of avoid_reserve to the only
one user, which is also why this flag was introduced initially in commit
04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that
called mmap(MAP_PRIVATE) on hugetlbfs will succeed").  I don't see whoever
else should set it at all.

Further patch will clean up resv accounting based on this.

Link: https://lkml.kernel.org/r/20250107204002.2683356-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 824cc56bf43c ("mm/hugetlb: fix use-after-free of a new anon folio")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 80f25497b54f2..a1dc40a06eb0a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5366,7 +5366,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, 0);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
-- 
2.53.0

