Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476405;
	b=38O1/0JD0y/b3cGrhD/w0ixgXHL54ddVlYq3SLiJ8b0zQsbuxL5/sXH0pRsO9f0Y/AWO
	 nffuFDauq1c4S/0sVKhOrrHjFKd8TVFDSS6opB4pNMqGmlvaa6C30NiKn2iscdQkf2LH5
	 7uSL0GDHhn1bxjSPLUwf9ea3otKI4Y3I5FR8W8KZLBxlajjRUAeq5xkMrW/H0rsdFN2qv
	 VU4wZe7gODDcj2I2TjaBI9NKqSfBrZqvCfSAbJI/z1azB6Wo9qiFRvntU3W5eC3YW5wF7
	 DHWy2U8XiZRXfVaCbizU4WDyCMxPSEcH4QbGuH+dZUIVtvP0aFZMjkCJXcjvuI6ts+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476405;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=IfhBgU9bzNjyzCbMLI08qHDpGZfOfIhIVxpnfJz9+gQ=;
	b=vnvf7V4yKLpYkAJ8AV1sglG+jC4jQ9lRpO0nXIKEGUxyhKnOdzh58/o8jDhdBVtb4ZdX
	 ghwg3/WpzPi9uLH+0xhqF1t/3xvcSyAfzF8SIlcWGQ/VrmUaRjKjbL6Pd3dtHCH1ioyBU
	 8behmcXMcujxtQFqxpqTcDbYDd1dTc5LWLsu//UfmzSi4ACiI7Bm6lId/7VTm3SHMEe9O
	 ZbUiwTvwZIjdu9ADxGrQOnscXd2aQa9vKalNvWu3G/zJcq1A+sKmg81nlbfxQutL7nFW/
	 QhpiTVYcUtML5007Mc3hxZelTvtRDSyLiDj33HiFSQwolAeLCBlCRBX29luTbWygXYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoMrAWhy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076B606A321;
	Thu, 12 Nov 2026 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoMrAWhy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C635B1F00A05;
	Thu, 12 Nov 2026 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794476404;
	bh=IfhBgU9bzNjyzCbMLI08qHDpGZfOfIhIVxpnfJz9+gQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VoMrAWhyX9Mu8dmXuJL0tzpqovAGH67dTxFbjd4TxmhmE1/c0FPVOzA9Ic0I2dr8O
	 R1LEPqRDp5AZW1NtPA3Ct7Mk7SEKbgWIVeFl1BNL5iEUe1bTvUvtWIzoKx+CYUZmQy
	 GE8NIXtSJJ7ZrGaRM5fNNGKitBWEN5/Q6Tq+JK0378GDgv0YZwNQ5bsIqcTjglpUxq
	 +rRcWDYtIVXhXlC40Ldkc9s2FE3hdEDpugkRygfnLxQixI1iNmJpEI1jDUtJdy6Kj8
	 Vw/b/Oo7ZPcLQ5a4p4SUexF7KHm5VqcENXFZHkOCDlVpUBNHuwr/mELTYjRHRonOtj
	 9U2s9/qqKtsKQ==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
Subject: Re: (subset) [PATCH v3 0/9] mm: limit pagecache folio refcount
Message-Id: <179447638951.7244.5228149003624496001.b4-ty@b4>
Date: Thu, 12 Nov 2026 10:39:49 +0100
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
X-Mailer: b4 0.16.0

On Tue, 10 Nov 2026 21:35:40 +0100, David Hildenbrand (Arm) wrote:
> Note: I really would prefer doing something else right now, but this is
> rather urgent.
> 
> Users can create a lot of folio references to pagecache folios, making
> it possible to overflow the refcount of large folios.
> 
> While we knew that one could in theory overflow a folio's refcount, we
> mostly assumed that bad things would happen and it wouldn't go
> unnoticed.
> 
> [...]

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
      https://git.kernel.org/mm/core/c/61351dc9
[2/9] mm: limit pagecache folio refcount when splicing into pipes
      https://git.kernel.org/mm/core/c/0ff9a420
[3/9] mm/mmu_gather: flush pending references early before the folio limit
      https://git.kernel.org/mm/core/c/bfbf74ba
[4/9] iommufd: fix cleanup when adding memfd folio pins fails
      https://git.kernel.org/mm/core/c/6d0d782f
[5/9] mm/gup: limit pagecache folio refcount when grabbing references
      https://git.kernel.org/mm/core/c/6d3ff38d

-- 
Cheers,

David

