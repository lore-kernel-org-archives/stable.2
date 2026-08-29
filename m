Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872CB67E;
	Sat, 29 Aug 2026 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787963068; cv=none; b=i4Ja4fNo77QcYS2m62mDJFuErreWMt9TgbPGAYayb8bI1UhBQof0ZGZOuonRaZ4+ZCbnyhvVhxD5XYzYTUXqqpgmR6lYN1bTwpLgnEKCGrGaRsh3yTVEazoKSd7V4dcfQpePU54igLPZ2Lml9+icmaTTg2nDDyF0KvzPTeKlghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787963068; c=relaxed/simple;
	bh=BjPyQodUPsbUbOBrfjm15ObZ/fSnurD9x06s7YXYrE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR+OKpXMMlZA2ozCc805H+idmlK8DOZAphi/mfXopW2zkp9rs34ICroxeQj0znA8f7dCVvBFchOa/7BwpAZmiUTCKY8wSFOBsdztUPzBJKUGIRv6gbykhVtMydG80eHaX29hevY7Ct2X++aK3eBZwLhIvLQnRCDHS1Zx5HIq0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdLtyO7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdLtyO7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584CF1F000E9;
	Sat, 29 Aug 2026 00:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787963067;
	bh=kQAWhYNX0SuWWv3eBBuShtV05hfUqpxzn/crb4rmaGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HdLtyO7N309KcJcf2B3rmobF0/LUOAvW9C6UQJaMu1lMKCx6DC4XdGoxOj4UiURTX
	 u2izl8GV/cN4hj0ap5z+x/cFTftPi2Ua7OboYFhN8s2l/fFyHTJ2pgIklNJfb0I9/3
	 ZxO8jvx8A5+nCaUKwKfQamltRnf1EISoa08LozDqymr/Km//ZX/NHnvWE4owOmVXjG
	 i/WuXevj6My0WlvZjzN6AxoNKKRCEQrcG8wYlPWDn/NZGDEHkG7uPncf+KfseqfvwE
	 09dJvqW6/Ma/e8BBWji8zWA6XL6i3Wy/HdUzLfk88zFi5fMOPNcMk++W1Z01Lhtxu2
	 ypuuaEiKto+Ew==
From: SJ Park <sj@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Cedric Le Goater <clg@redhat.com>,
	Saravanan D <saravanand@crusoe.ai>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap mappings
Date: Fri, 28 Aug 2026 17:24:18 -0700
Message-ID: <20260829002419.73386-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 20:55:57 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The sysfs THP tuneables at /sys/kernel/mm/transparent_huge_pages/ rather
> confusingly only control the behaviour of THP in some instances.
> 
> They are not applicable to MADV_COLLAPSE operations, nor to DAX mappings.
> 
> Long-term, THP is predicated upon compaction being able to obtain large
> folios to populate THP ranges.
> 
> However, vm_normal_folio() returns NULL for PFN map mappings, thus their
> reference count is maintained by the driver, not core mm.
> 
> As a consequence, the folios are not subject to reclaim nor compaction, so
> are not truly part of the THP mechanism at all.
> 
> However, since commit 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> introduced the ability to establish huge PFN maps, they have been subject
> to THP tuneables.
> 
> This is incorrect - if a huge PFN map is available (defined by
> vma->vm_ops->huge_fault being non-NULL for a VMA_PFNMAP_BIT VMA), then it
> should be mapped huge upon fault-in.
> 
> Correct this by explicitly checking for this while ensuring that smaps
> continues to accurately report THPeligible statistics.
> 
> While here, abstract the entire file-backed THP check in
> vma_can_map_huge_file(), with sensible separation of logic into helper
> functions.
> 
> Note that drm_gem_shmem_mmap() and panthor_gem_mmap() establish huge PFN
> maps of shmem folios, however they are marked unevictable in
> drm_gem_get_pages(), and in any case would fail the reference check in
> __remove_mapping() even if they weren't.
> 
> Failing to map huge PFN maps has resulted in significant real-world
> performance degradation, see links for details.

All make sense the code looks correct to me.

> 
> Reported-by: Cedric Le Goater <clg@redhat.com>
> Closes: https://lore.kernel.org/linux-mm/20260805055544.1568534-1-clg@redhat.com/
> Reported-by: Saravanan D <saravanand@crusoe.ai>
> Closes: https://lore.kernel.org/linux-mm/20260821070520.25759-1-saravanand@crusoe.ai/
> Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: SJ Park <sj@kernel.org>

I also support Zi's naming change suggestions.


Thanks,
SJ

[...]
