Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567199;
	b=bYPEFl0OTX6x+dYfNd7pGHYPUtlm+t01pC0Mj/bnlz6nrv/mV3WzYg3JOZwhZOlqixs4
	 mv+iYYHmI1OOYeSpMNDG9abhK4xSCGDmlCJk3IH/asIKsAVeYzxy9WatQvuNmOPQB/+do
	 r6+jVAm+DljkYbHkw/WcVDPVagcJ7pdR/8z120ob3+Cnv4n/sCuTwVvodBrNf7qCSGFhr
	 rzsNcbPrzT9WRpILltbwBud7G4/PPmTpvCTmMXcEEz1o3sDt5Ms7SOlzgm5RuW0th6Zbz
	 jRxWWrLQFx6KavmIMAOTpNBib3hyhZlmC5VAPL9SJQCHltj6jG+K/LGdRWsPYYhW0yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567199;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FXAR3k2XOmADxmocsX6uctWFtqeJu78i+LhIjLZQduk=;
	b=AtzhemjTLwrp2MyYDLZeBpYxGpcjFPmvw/jSh/GEZFY7+M7mwXpCn1d6iwHgmVlZ8tHL
	 7ZPLD4lALT4B41sGQs6+8wwWxsjdIDkFj2ow2LrCJRgsHR9bHgLnyPGlb/GrslZWpk9te
	 jD6m4umqY0M9vF/XhAVsEUzybrzPEYTTTzqtrU3Wqe8NQS/yCQDSqSUJgCLZ2w2ASEVj1
	 mebwdW9UvRlP59tvuV2AGcpXTYmv2zN0+4ur4s/GQ/HYTez09jxqxPIPEPcPv7uwRy9rz
	 27246lcQBNKPBdDZSK1DcZhZHIgdfDyMjTBKtuO/jIUpieM0mAdVN/r69MPjTx5phTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPtuJoKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B746606A32A;
	Fri, 13 Nov 2026 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPtuJoKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B244E1F000C7;
	Fri, 13 Nov 2026 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567198;
	bh=FXAR3k2XOmADxmocsX6uctWFtqeJu78i+LhIjLZQduk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IPtuJoKOgWndeSoW+Ft3DNggXS8gWEaDgnYeDpRAG/BlU2uN9HvsIaEXvK1oh4mgm
	 39cal93B7HS5m+6upMeYECPQ1Zyxj4IccScKEvkyMn/ULHL58tQ62QNgWDydbwEPyu
	 +nqDDxVxRKKW680xeSqy0Z02nhINaogVyU61pDYjSDRpfZgAA6tmITzkeVoOKUtKMh
	 DjWM8Na3+aAeVtBCznGkh8sY+5EA8owX5Qs/0RpY/uxHYPIrwY04cScd11itwqTscW
	 oXjeS2Gpc/3uepUzBJOBCspIJv1bF5djY+zFcYKECFQH8KUxdf6U7RK8YGjJCOlaV6
	 V5Di54SflxNNQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>,
	Rik van Riel <riel@surriel.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: (subset) [PATCH v4 0/9] mm: limit pagecache folio refcount
Date: Fri, 13 Nov 2026 11:52:56 +0100
Message-ID: <179456713145.6906.7073956264359546741.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Thu, 12 Nov 2026 23:53:19 +0100, David Hildenbrand (Arm) wrote:
> I'm resending this quite quickly, addressing Pedro's review (thanks!!!),
> so I can replace the version in -next tomorrow and move forward with
> this to get it fixed.
> 
> I un-RFC'ed the -net patches, but I will not pick them up. As mentioned
> below, they can go in independently.
> 
> [...]

Okay, updating the first 5 patches in -next.

--

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/9] mm: limit pagecache folio refcount when mapping pages
      https://git.kernel.org/mm/core/c/86c0d919
[2/9] mm: limit pagecache folio refcount when splicing into pipes
      https://git.kernel.org/mm/core/c/6ab934de
[3/9] mm/mmu_gather: flush pending references early before the folio limit
      https://git.kernel.org/mm/core/c/89b412c7
[4/9] iommufd: fix cleanup when adding memfd folio pins fails
      https://git.kernel.org/mm/core/c/35e8fbf9
[5/9] mm/gup: limit pagecache folio refcount when grabbing references
      https://git.kernel.org/mm/core/c/a6f95654

-- 
Cheers,

David
