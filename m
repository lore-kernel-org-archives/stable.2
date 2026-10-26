Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057218;
	b=qfFiYUPrHuysT+zwWvgJ67ab9CGqKmfLSvy2xOFAg5UIUCC82MzG/fux9mNm/oQIQW8S
	 q5/DmU/lrivgpI2ugsarI9Zur7nEypZaqWFxWXfAVfh3Ay6VtCPkFEsb7KgNpXunIqiLU
	 9rJCgZII8K5vE/PqhpaiGnAUNomArAWWddx1l3unKGOYPVfhd7Tb+c/twTqEiSP81wXoK
	 C3SSi5fQOWladZ7t03CIWbQCoxSloeg1Hv+YeM2hENSzJt8vR0r2ra9eaZhTtcznKc38o
	 VGLJvzAdJzmCHp5YoODOE88BX4eaHCxHZ153uzLjJhPufVUHBdQMD0N7+MlTMktKreQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057218;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YyBvhh+qxm8IviEeyZzcz2JUI2QeD2dbSMePHEZqV6g=;
	b=vT8VT56e3RidDN0HJ+sCsSDuKHijvPVyxbVQELJABoxe0mJMxbbRswH3RtpCCbpXTjrS
	 HpmxiUf6Bu9S+jAw9+dVwjSfiga0W8jGPZ3xktoAFQKt69+hXFk9KJ46zvHMZVYcVgXY6
	 Kq2PgCnbyb3IPf/v5g2JfP9bFIP59bDd49yMAa8EtBX1VX7DF6MdKdFzmAGxH89vw6JAf
	 hYMfJr20I/S7xmk0lpxlJuvXAqcIElWaa1lM+Yd8dza3joqOB5+TD9U++/1TqtmSDDQEP
	 rPfq7KYSqLchP3HW/JW6gQB+SZtFP3Uy6DKghEuklb2KwHjQz+IKMmVR8ZmXih111hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+9XM0dI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D6606A31D;
	Mon, 26 Oct 2026 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+9XM0dI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BEB1F01828;
	Mon, 26 Oct 2026 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057218;
	bh=YyBvhh+qxm8IviEeyZzcz2JUI2QeD2dbSMePHEZqV6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I+9XM0dIDhfLQ2IrtZ5HzQkq2PPp0DrM/8mAfIcMw64Ptq/qajsTS2DA7ZdMXfeBV
	 KzWRZNQLeE1HtCF7Z8+s0hifNhI+1Vb/Kt6BUn3Vzgl6a/5dx3x0sQc+O5SblrAtSz
	 +609RXnj1OExUGqYPa4rMeLnQrLnCkVpRmEgfst771GTthyyEI3P6b50QzcHCt5Inn
	 8aD6kz6gF+uAMC3YoWmHKMAIojnOGVgj0WTqcxRfcUio0DEXIBjwW9P6PVQau07EcY
	 ylPS2tKtf/f2VVVAyPiXJ/UuIahnYmRJjSvJza9HqLkBdFlMGdC78NMSHtXKSQfz7S
	 D5Vhc4PJLlP1Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:49 +0100
Subject: [PATCH 29/46] mm/mremap: use pudp_huge_get_and_clear() when moving
 huge PUDs
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
Message-Id: <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=david@kernel.org;
 h=from:subject:message-id; bh=cg7qBpNaGh8akN6A4ocFJLR+o1S7mJxz4pw8YGNdmxg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35+2dMmjj5wJt/b/2rBVb8VCfdHGdoG7atodUvpiU
 579O/O/p6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJdL1i+MOvLx18KeX/IZmV
 AomWG35PMl3v83hldAmj3k4h2cZL35sZGZ59ZNuk6JnsFWOZJBjTdbvBWGBOhrf6ZQ1T04xI01P
 nWAA=
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

