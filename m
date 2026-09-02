Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF981724;
	Wed,  2 Sep 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337381; cv=none; b=CGqYtEHBDx+tdAS+taoRlb2fO/ATQmzDOqwCSTNnBYcZEM3MBd12761J0G+lt3aJzVLdbZIevQMQo4h7Nt7gaN83bk0kSPvF4E53u1kSDnsNJh8IwHrrcaOsxWtWuuIDy+oFGjz3TPr9htl0Pv9ivLmgY2cDlpyKcx9rjXBMmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337381; c=relaxed/simple;
	bh=pvVk4daAHR7Yy5UIGnTf8/tE6JkSvAWJQ6/StZs6/IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6x2DJjCa4vqjLV3v9lupEu5sw2o0Yt2Epv2d4C85RbZ6o/olnDKAcd5nauS7enKCY7JZCb4RFPDMB/jrSNQPDDwwbXtvxR9PVPZOcso8TL/UKJIkFCOCqD3m/Cfm5o2wsO2vEE3A8XtDUZFSPxnNLYQPTxzM1OlG3yIV2peNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqyQJ0C1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqyQJ0C1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79DC7C2BCF7;
	Wed,  2 Sep 2026 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788337380;
	bh=pvVk4daAHR7Yy5UIGnTf8/tE6JkSvAWJQ6/StZs6/IA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aqyQJ0C1tP4t8Z+EYuN8h7oJ57FyX10cf6mxo4BTZOtFiFk9SJA9kYKvzbryAgGQP
	 SEwpoa6f9Dyup2Rg3qyuPkQL8zBPRWA467KEI+USe8mF5hLXsbuG4tBGlw/yew+39N
	 xVsCTM6kqE8kkRWWqJaVQzgjP6IIE1V5xkxP9VBTYtWMqbQPIUKj5r7HhJl6/Aiv2g
	 XoNxGnTmSWn5ivHCifQta3hWKokmwk0fUnbFPw4wa9jDhr/A4SBzYKczPrWdQLWxUY
	 Rwj7anhaAhTak844iM44kDZcMhx5QR0PtE5Us9/aPEzrRvl+qkdzwapPlNOULlG8jW
	 DgK4CjByuwRKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C449C624D4;
	Wed,  2 Sep 2026 08:23:00 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 02 Sep 2026 01:22:57 -0700
Subject: [PATCH 2/2] mm: hugetlb: Drop refcount before freeing on memcg
 charge failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-2-e3e8942c141b@google.com>
References: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-0-e3e8942c141b@google.com>
In-Reply-To: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-0-e3e8942c141b@google.com>
To: Alex Shi <alexs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Hongxiang Lou <louhongxiang@huawei.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Peter Xu <peterx@redhat.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, jthoughton@google.com, 
 fvdl@google.com, rientjes@google.com, vannapurve@google.com, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788337379; l=1301;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=OnyqM/8Pr6ZsV+BsOfwDFJ0IbKPvQMMic3OIlvC9rcI=;
 b=B27Ds3U4PhbNKkOtqFYJY/xvCHiXLY5gLSpcHZYLqE1ILOZivlwW3tTQwCnRXp1T4sN1CklBi
 SqpDi7PBF7pBrwlr6s/WJ3+2NQ7j5mO3CbRN6vN8WwFFvpx6oChTAC9
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
its refcount set to 1 via folio_ref_unfreeze(folio, 1).

The error path calls free_huge_folio(folio) directly, which expects a
refcount of 0. Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
triggered.

Even with CONFIG_DEBUG_VM disabled, returning a folio with refcount 1 to
the freelist can corrupt allocator state later.

Use folio_put(folio) instead of free_huge_folio(folio) to properly drop the
reference before freeing it.

Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01b57f6d3b804..97c06f227ef8a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2889,7 +2889,7 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 	lruvec_stat_mod_folio(folio, NR_HUGETLB, nr_pages);
 
 	if (ret == -ENOMEM) {
-		free_huge_folio(folio);
+		folio_put(folio);
 		/*
 		 * Skip uncharging hugetlb_cgroup since the charges
 		 * were committed to the folio and freeing the folio

-- 
2.55.0.970.g62bdec98f9-goog


