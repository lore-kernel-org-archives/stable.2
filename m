Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321856;
	b=c3WrQvWd4iR2c/5tkAgxT/9tkncVN0z6xSW24WlhTlOHT9dspMrRI7XXCApCIHlrCUO9
	 fYjoExFqQOtqmgSo0359wOBdqHLN+ViXBd2d2iCeanNuUZomcB7BhOtbGdGEsx1zLPAH5
	 6nCM5zRGiukaO5Ch7jpuUIOnwTSHufIsjv8Nl1WNnqDNjbS8daxGnFe6Gfz3XRTJIxdyK
	 JxKh43YITvcDyDurzR7XO1VF3r+vKg6hvOJk4I9Zw9mRXPOZ7Yy+d60P0L3bSbHU/X6Xn
	 MfUqW19NJXJbvU7mfSaxii8ZJ9vfd9s7u1uZJ3GhbjbQpNgTdZ0ndI0zmDEjXLL0d0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321856;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M6bpDqyFL1t6pXSfv5Po8tZyxphIeTUYr2/GTeN0+Ow=;
	b=By5COuiElj8L1m0sqckkX2lnkKV+QizJTUVQNPWPVanjeSwWQt5SxUYBg6qoDb8cQqd6
	 yoiqfYC8osTFlYcOHOZbUTVhCIO6Kc7N/TC0BtyzBN84sDoUN5OUa8T8yJA8wmTcuD3jR
	 HurW+dX71DGTraTKZFzJY51Gr9As2251GAL2C1jOA4a8ZZJTMoVjLmZlbf5+o7+iJMdzm
	 O75zZkApayFFiHENllBBTRFv3RVSRhbeuvjskrvcIlvHXT60qG/Btyl1461wlzTC5TERp
	 xeQQfXXssY9imQGqtZdQXg6hZmOC4vBbL7oKM0NPdGzBo0EaRgnlTkGriXCf+gejQ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bck9LEQ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0F606A31A;
	Fri, 30 Oct 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bck9LEQ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5070C1F000C1;
	Fri, 30 Oct 2026 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793321855;
	bh=M6bpDqyFL1t6pXSfv5Po8tZyxphIeTUYr2/GTeN0+Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bck9LEQ0UPt4LikhQsWdEDa6SKxVHXgeqY8QxTgswXVFtiDdPukVSUu4n9MbVtYs5
	 9bJB0UhYlqNoSAncXFJ2j1+NWPJNqcsDIAUWHsMxFaaWRhN5euG3twTUKMEQOkhMHq
	 kCqRFz7lMFFHp8ifCqslKWbUlluFBnrNX2Gsx1QQZJ1my3+Qiqa83Vi4wtVn+wWcXY
	 yr12zqlMfd4YaoyLMi/eCnYBn6ROMiu9tbRatmj2MhIT5+dvt+dbydBKyR+FVLJc9O
	 dqXK/TupCXUvbOJG5GZZZVlCKD/5zJ1rV6kAoCfn2B0Pn4nRrmkZIvQ909w4V4Nmjy
	 P8zEJJwppvlEQ==
From: SJ Park <sj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 27/47] mm/mmu_gather: fix flushing ranges with 4 GiB or larger
Date: Thu, 29 Oct 2026 17:57:25 -0700
Message-ID: <20261030005726.155279-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029-fixes_core-v2-27-a64ce7f83abb@kernel.org>
References: 
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

On Thu, 29 Oct 2026 21:33:22 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
> 
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
> 
> On arm64 with hugetlb, a 64k kernel can have 16 GiB hugetlb folios
> mapped contiguously at the PMD level and flush them when unmapping, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
> 
> Fix it by flushing the proper range instead of the truncated one by
> properly using "unsigned long" for range_size.

Makes sense to me.

> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]

It seems the convention [1] is to put the above modification note right before
the last S-o-b: of David.  Maybe you forgot moving it after adding R-b: and
T-b: from great reviewers?

> Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: SJ Park <sj@kernel.org>

[1] https://docs.kernel.org/maintainer/modifying-patches.html


Thanks,
SJ

[...]
