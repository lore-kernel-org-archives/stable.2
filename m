Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793404671;
	b=RGWTkpxxlPr4fy5+btR92SAYpImfduiuG7X7O2JqWLTEbwaK6n9gcH3jD9SkRNidGRO2
	 1gy1XEQbjHvoYelqrlpYu+hb4NERNeCG+SqoON1GDgX5G261QCsMdcVsI27jqGmPbv6h+
	 LZBvCVlO2qu32vYNcX9nP/m4BVOr1BZkCmhnSBc7FDJqtNpH/6Q58ia7Q9rqZoIawRn7G
	 IEmaJnuR6QIattnEgEPgFau0FKodPrVwFrFGrxnPj+zpEP7YRmBCI/V7BByXv3mQFX4b2
	 538kop96Digzc/TcOqxYHJqgvoFNfKVjYHR4W7SeL3KIg6NCuKq5MJVNE445AcNJzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793404671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yYH3ZHoy3wMBa62rdRKFlOT5iUEACgCaryz4Ge7v3YA=;
	b=qJOZc9SPrx7MlnlTgBte3tRxcqWCY7BT029wRdDYETF9Ydr3eeNNEoIGb6iSi6oH2mAi
	 Hnz25m85SbqQ7y5yQElCTGDMzrXGXKR1spL4brs1RXYifKvJ2d+lWSbIpPdJdm6VkZT9I
	 5eJaOvGGf+t06tKU9iJ6JPZMxfQp69MtGV0sxkEa9VjkhRn7KpeCJqhXb031jx2LJn7uo
	 VpML99dIDhJRkp3UWSIOPji7ZzKFlj3f3yXMKRkt4cyLMYBYEt9mMbi42uXXhhpJRFe4Q
	 ruiIh5i9t1XJdttPLU71AmU3LjNfWcJfvd/SCplLJEqZJKfuqqzjkt5nVc42o1qkJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H92dZjxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A012606A31E;
	Fri, 30 Oct 2026 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H92dZjxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0D51F000C1;
	Fri, 30 Oct 2026 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793404671;
	bh=yYH3ZHoy3wMBa62rdRKFlOT5iUEACgCaryz4Ge7v3YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H92dZjxoEBjeg93MdfYqW/6IAuzONdaBmZ/OVUIsM/rdieejBoUuPSaLoOlo/X9o1
	 LlUIR8KOWVCHXQJ0RXY6QJvgcTFZDjQ/SKuYB5lMYKKlKkip+akHrFT7sXCC+QTS8t
	 cXMzHeO+7K/QXNLgWd24gdJG0IuXHSKRDFzXJJyx+460C2uW4fEZiprWvkS9p5Z/xm
	 XcsKKOfRK6ab+J2juDoX2gfEAAT5ljzSTYck93sZyWI7z36GkDg4BEq9Fni2WcB9aI
	 mjhqPrj/7BdZ6vAmuIqFRM5iI7AFLcUsJ30+CpY1jeLBqohnWPf9I1ONGO9xBX9uKC
	 DGSaHM1C+gE2w==
From: SJ Park <sj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SJ Park <sj@kernel.org>,
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
Date: Fri, 30 Oct 2026 16:57:41 -0700
Message-ID: <20261030235742.87036-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6ac05dd8-321a-4c2e-bce8-bd7ffcac9eac@kernel.org>
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

On Fri, 30 Oct 2026 12:19:46 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 10/30/26 12:15, David Hildenbrand (Arm) wrote:
> > On 10/30/26 01:57, SJ Park wrote:
> >> On Thu, 29 Oct 2026 21:33:22 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> >>
> >>> From: Josef Bacik <josef@toxicpanda.com>
> >>>
> >>> __tlb_adjust_range() takes the size of the range which has to be flushed
> >>> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> >>> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> >>> gets truncated, possibly to 0.
> >>>
> >>> On arm64 with hugetlb, a 64k kernel can have 16 GiB hugetlb folios
> >>> mapped contiguously at the PMD level and flush them when unmapping, and a
> >>> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> >>> at least these two scenarios are affected.
> >>>
> >>> Fix it by flushing the proper range instead of the truncated one by
> >>> properly using "unsigned long" for range_size.
> >>
> >> Makes sense to me.
> >>
> >>>
> >>> Fix generated by an LLM and sent by Josef Bacik in private.
> >>>
> >>> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> >>> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >>> [ david: use two-tab indent, simplify description ]
> >>
> >> It seems the convention [1] is to put the above modification note right before
> >> the last S-o-b: of David.  Maybe you forgot moving it after adding R-b: and
> >> T-b: from great reviewers?
> > 
> > It's "b4 trailers" that apparently messes this up. I don't think it really
> > matters (some move it above all trailers), but I'll fix this up when applying.
> 
> Thinking again, I *think* this order is correct.
> 
> People reviewed and tested with these changes.
> 
> it would be something different if I modify a patch while applying it. Because
> then, what people reviewed and tested would be different to the original version.

Makes sense to me.  Thank you for the kind clarification!


Thanks,
SJ

[...]
