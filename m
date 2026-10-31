Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439943;
	b=5lW+PiW5k3XUmRsNQ7ytYqyGuJYMiymkvk9sbAhYCuWoZSYDvtce8Guq7hov9hqdoERV
	 Mm1/2x4Wyw7WSr7HGtiHbOWhTfi/yKvQngXfzvP6ggfHU9aIJ0BqGpYDbZWMKLSu5N3KO
	 iO9zFoo1A3Qw5LhtzHPpPd1vsjDYXSzxUQW9iRYxPQqZfBs6AiWCIoTvkCHYt9ECDqCHS
	 hYxqBKzb1wMNjo985UkwqYQl3200jJgDY10Tvt/ZjVF3NcqINXPDTvolc8GtffUOD14b8
	 1bibjAVIgLVh38ErD9fMs5MxaQNgi29yIV75fBAp1lK7TAiZzNnN5q2v3mzdtvy/DyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439943;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=foIE8/qjRxOslIMIVm5LWTcoDseO7kpGoD14hc0ILxg=;
	b=m0ryLl9ef99p4riUWw918zFO1JtX/TxIowu2LKgpNChvN2aqNaYU3iy1ZZW1cqgL4JHZ
	 vY8DPqQI1F4fv5vQi6ftnDDyBsLa37zJ7SyoKAqbCoXdx+/VibNH4648EUn44j2gHMJ3w
	 YGgJvQTP9Lln0OWthDjDy40sPrAKmhPoSiMuS237acZwq9BCt+hyQxmeDkmu4+dvj6wvE
	 jwV3Z3iOHEVoLa6ceo1Jyh3Uyb7pCbffpQM9dFYIHJbv2RZkYKaEbYdYYaCgPxBojGoMv
	 YICe9mb4pdSuJs7n+M+AdUR9wggu8TQ+LqXD0hkdqZwlG+2MIJTr2LbtbecMgD8cIYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhV9oGMq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50B606A31A;
	Sat, 31 Oct 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhV9oGMq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56871F000C1;
	Sat, 31 Oct 2026 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439942;
	bh=foIE8/qjRxOslIMIVm5LWTcoDseO7kpGoD14hc0ILxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JhV9oGMqjIuZGgcbHEUsRikcUmJNTkInVxMbDD2McBF1KHRCOovytr11YurFRKmY+
	 bzpFUCXJV07KGchANo9OXAYly2i+TAjzzG2qyAyH0zYRfED/AUnwLW/4JR6ep8DOEp
	 3ob8fsc2zXmkJajPfwx9ACN5aMF4fl4RqsnmBccaStiOm1Ik3W84FuIM9kDgSEnVcs
	 FnUcTU/F9+4T7XCWF7hfPk1mhEKqJzRhHlBbv4kVrzqvgm/NnX6C0xi3dX2J6sa5iR
	 Ryhd7cB6JyGhcESjQmqHd0GH2cyaVRdT7FizFV9PWwZW6Rt8Hkhe6GmVGYIIMTUxku
	 0gFPxVWBEFA7Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:50 +0100
Subject: [PATCH v3 21/47] mm/gup: fix out-of-bounds write for nr_pages == 0
 in GUP-fast
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
Message-Id: <20261031-fixes_core-v3-21-d6437171ecc3@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=david@kernel.org;
 h=from:subject:message-id; bh=R62eMdMsJypxqcni0WbltJmOI5kqokR7T4ahYSHS7oQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk9XufzzUt3qVRK79jW/zlzmvMenZ80MsUTHtrnHE
 7tlXOZqdpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRtAqGv6InnopkrO0IDNHq
 7pC+cvvWiW0b+d98XM7UJ9iq53RHYQ3Df69HC3Z+ryqu27DmAne4j/fJiz8+bFvAecZ3t5uDiFP
 eOk4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

With nr_pages == 0, GUP-fast still enters its page table walk and can
write past the caller's page array. The old end <= start check caught
empty ranges, but was replaced with an overflow check.

Users such as OrangeFS can pass a zero page count derived from a
userspace-supplied length. So let's return zero for nr_pages == 0 before
starting the walk, just like GUP-slow.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index cc4fa18783ce0..1c2ac7c66c309 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3215,6 +3215,9 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
 		return -EINVAL;
 
+	if (unlikely(!nr_pages))
+		return 0;
+
 	if (gup_flags & FOLL_PIN)
 		mm_set_has_pinned_flag(current->mm);
 

-- 
2.43.0

