Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306453;
	b=SW2K0UfxK7c/m+xwUBcPpADC69KAGGOLG0RXoJ7JdhSNbKa5xz7OxMWIr7LAKGjn4N4m
	 97HsmXZ2WJMOVEw1kjbRC2z6zVJ3lrFQLaDvrsFWvcNBFnBa0sHZCIHvkB8CtWlN5xOmR
	 oTBUgFVLCALKqpSmNb1sfFyMZTu76BbbCVz0XX2DCpUyf2G7CF7np7FdBEefVhP+0EelY
	 B4buNezfu5YZ66G15LJ62TzOb3zMzGkOGyI7Z9tH3aZ2z48unuA2RKi7YhW1UnyQ2PfCi
	 DXEsEi+O8sSEaaGv0SrJIl0wVwwjgKjFk237jo+/u5Mz3jOcKQJO9+H3cWPL8P1SwqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306453;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=X+A4bDZDQi3RaQKtCdHq4Q8CuoDLcygQanGTwpRAvoc=;
	b=3f8UiSeHTgOiIi9d4hP7kZZp+EVCAM1GbCAYWwwUnBI+eIZwQkkjdcW9og4BgYE9fKbj
	 ok0qMotZLISZB39+cnJyoinTxnXIbX5hQF0ZfhROSj6AO6LSLxT3NfWH8zWb6FYvpCNBr
	 ftUiJlKKd91nFGp32jlpw8bJcHF6owJTLpA7m7+3lQCzy2BvfkXYP5UpcPxtPQWXJoI27
	 iwwiLua+qpcc43sa2CGVuXaFDKXNlP1ZJesLeqwRy8jZur2kRDfVXIZHWfgnpyli6uECy
	 rXqymu7XFnwZuZY56BW818azmHkShk0CqTYf8mir5B4rm139tp+d3Z+Wm5htXOxCrvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BizzfTpX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833C606A322;
	Thu, 29 Oct 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BizzfTpX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BA41F01816;
	Thu, 29 Oct 2026 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306452;
	bh=X+A4bDZDQi3RaQKtCdHq4Q8CuoDLcygQanGTwpRAvoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BizzfTpXd6POIT2VXSctKqd3AYlrKo21t0yuW7k67ZzOykQkrmsF70tvdF27m6nHR
	 yNjzirG7yxUIMePV6cd6o6LqX0pSAl/IgEUme2KHxm9O9PpZuALo6dRUKAQxGfhH+t
	 DA4gWLZ8yol5BW+DLrHcMvUGxusQPKgKUrtfujihDYvPnJt/TJ6tSS39u2H8P+KZTy
	 nZoUv3JERjR/gKqqgwAYI7hfD8T9nuqpmpfN6GDlxYR++om/RP/DZmQULDWoiS4s/L
	 v9kzIakhQuG4RHlpqlhNNq5l4cyBf7BOUkPJX3p8OED7PzmsQ16EQbSRbPchOgEa/p
	 CExcoOfTYv/tA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:25 +0100
Subject: [PATCH v2 30/47] mm/mremap: use pudp_huge_get_and_clear() when
 moving huge PUDs
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
Message-Id: <20261029-fixes_core-v2-30-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=david@kernel.org;
 h=from:subject:message-id; bh=Bwj0I+EdpwxOB+DXKGU57G1Zy0OI6QgT1Ao2qNPPN2Q=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+1YqffjAfvFE1GvVCPrynaJrxGaF5yRGLK27FbyY
 f3NFjY8HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEtJDhvzePiszu11vf/Jz+
 fcHuUKufNir2r8+1Gp+U2pslsLRl02qG/4lXDK3vLmCe9X8G+/cET8cdsvu85+ru1m57H2Vyc9r
 crywA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

move_huge_pud() reads the old PUD and clears it in separate operations.
Hardware accessed or dirty updates between those operations can be lost
when the saved entry is installed at the new address.

The raw pud_clear() also bypasses page_table_check_pud_clear(), while
set_pud_at() accounts for the destination mapping. This leaves the
checker counts unbalanced for mappings tracked by page table checking.

To fix it, simply use pudp_huge_get_and_clear().

Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19..16e736c72d9c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 

-- 
2.43.0

