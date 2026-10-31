Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440084;
	b=XxSekI5XyAXErBpPONSDgHHzVk7S4RJaIdXiod2V1WhgDy1LmZRjSjmz9Lfy+tNNEaCT
	 kBnHgXmPJHjb2UAHXayaz1kFu8rENOAIAbBCF24StVTTb9UVIY5DGXkZGUPLn1CpXFVUU
	 F4RMPzSEnKoAQWbWnleSmuQQEP1WzjU4i+UlM+sgaq9UndXypKIZxTz6UPywC5edqIM32
	 cNA5CVDOJ67hkBMphFwAJqMA8E/hvKtAARmb7tXCjD3FTMEwFoWkgfjs1DzQUKMuLgzRV
	 PlNnXdRLfZDD66Z9ekxnwB2P+EZcThS71f6M65Ae9ehteJgUdaj4J/Y/gfdBgOAeS6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440084;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oRdxulna6bx7ZoXAJZWTtTOwXgwkKcXU1p7Oe42EAqo=;
	b=TI8LGv+NYnCdboN6zUM4lhOhELLTfwI0jN7PpwDGhr+W+vloBNqaT47Cek2fIuNN+cGx
	 lqhocgH2QHyZTfPAJoPUIuzvnxJNLYeSqlmH4oFKmvgdfoKXDV4YYe0rO5AcxpWUCHFLU
	 EIv2n6e/rk87/SvLjAWB8IyJk4+pUYBQ2ui0hB4bugOicM8t0ulrRv46DqdK06AhnnxDQ
	 mPsmcSXvVqpL/Zh0APi7OHxFqY3/y/xfcY7QTCzQJ4sZeh+5QmuEMNjLJyl2mMU+82Yf3
	 tHsjRenpprtdCX+z1W1Z+ZeZO/MJGkac8BTHTesrDAjABKh+2iwEa6ch7eACpyE7C8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyYl5dm5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D51606A31F;
	Sat, 31 Oct 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyYl5dm5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC8D1F000C1;
	Sat, 31 Oct 2026 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440083;
	bh=oRdxulna6bx7ZoXAJZWTtTOwXgwkKcXU1p7Oe42EAqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WyYl5dm5PLsvVySkqKWeW4aQqBeXA4uNtbZ0Q7ESvQ9tb1cE7IFM8dVmAypfFv3ew
	 pK6i+F632f1aj9HT4Cz09nw5s0O0bZ5JJgEVYKNecloJyyHAvxJPkOtixdHmgd9HpI
	 ydeZ+vEbxoT2hxdhnYJAvglbZQ+7fd+Nssi6fmiuxZu5XAOtvh4jFDcMbwsyhFvb8n
	 YJpI0mC9y4/JQpQ/d8ePl8NBnMpf+oSAr2oC2r7k6ENsJMAClBoUl5GM/DJi9h5aZw
	 jNNqW+cyjceGWw0WFsiSKjNfEmU5Ecr8h4R26sYJPRy4YQVxh2ZZdfLKPRODE8MDBn
	 YEP3nGt6vG92w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:59 +0100
Subject: [PATCH v3 30/47] mm/mremap: use pudp_huge_get_and_clear() when
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
Message-Id: <20261031-fixes_core-v3-30-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=david@kernel.org;
 h=from:subject:message-id; bh=J+BkXcl4Qvwywi9WLcoERfpKcUUnTN7lTfE+aJlF+GQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs8s914UfNrOe/qM8PKSOwFhTJaPeWuqqvs6bhy2z
 XAoTOTvKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCJdMowMM/5zRgrnX8krOPRu
 eabUTz+9eNN3X64U7kiNWPKmVGDhH4bfrCkLONfNlpM/71PMcqR811mPT4cj1riv3S95hPloRs0
 7dgA=
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19a..16e736c72d9cb 100644
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

