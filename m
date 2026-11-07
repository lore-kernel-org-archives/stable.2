Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080009;
	b=GPJdW0XB9vh7igqGx1Zg564KQlY61H+6S6IycBC0gS4p8pTHIoYYkneB16OmSUaURrSv
	 3eIKjkJq/TfssBEb0z2UvDvaPktsQ7lA5CfYATRKAd9LNI4QVD8FZ+oqZjRJTMbnbvy5+
	 MjTHyjJVnkEMcs/darKjNO8OxmP4YtoMoSh1gs/Avpp4hFLfp2Fm/CVeU915uyaF8co/G
	 El2QN8nGG/uUiet9gzVNGq1ZyLL8/fCP3BCZrsWqu5NK1ifNT4IjJ+S5k4gnRt96E7HFE
	 R7d2NTCZ3Sb/i6omZi1hZOD5WcLgCuBi6xzLCT0XQ6izWRT8MObb6RYOU/cL9HC8YvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080009;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=bdEnRhaq9naN/jfM+EgRhagkLAGd6elDVRBsfzO9N9c=;
	b=l8DYCso8pzCcnXfiw9rc6JPDSZI15f9lcQv1+NP5+p/4800McrmHVPZkjbbQ+lGoiGNp
	 hi3yoQclc+exl0HczmH7TT6zJN3io3I5K/CmqGrWchzR/n2Z/BRTPmraOJsVHHQrC1YZT
	 HVWpmd8wXV0PCGGHMXWKJ8kAbytDm/VSa+R1rrG7biC83pi9HMbvwHMVoIJGSmXqLzZ2g
	 x2rMa2IEe0/mIjlcuz4bmDnUhvKRGNlPt6ZgaH8VrHsnetpm4fSoTl1L1T2bUpNYe0TLJ
	 jK8yprmtn8DlDeeOR4PWCNK48qBiyjYz2xq/euhp/FVuZ/0cRmMg+eyKZx5CuQA5H1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftQfmrgX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF8606A326;
	Sat,  7 Nov 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftQfmrgX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C431F0089F;
	Sat,  7 Nov 2026 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080009;
	bh=bdEnRhaq9naN/jfM+EgRhagkLAGd6elDVRBsfzO9N9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ftQfmrgX0PTL6OyPr21ItVBP7iEotgJoBBodKYZzA9N+WTPgVMGgNEt7hRvo8RcW6
	 aQ0PevE5CQFQNDEijOMftez1rUxlx71Q/4QI+2JjPZsru6Ascqo0HoBhrHkQjeoWn6
	 tSejtejf+yz41ID74q+dJDLcq7PwtP0rNph9cqRo8zVJ/ANC37AuElytIy7b1KOj8l
	 3u1PF4itd0zJ2DU0wEzj3v3dRa9voEvSE0mamgbMPpilnqGMl1YFM3pCr/8AhoBwVE
	 60Fu6EBLAlsHK9iOoTf97nGo532cXVaNYsgqrJXZ+Md/QzdrUuMOU0CTtmEp+pGXal
	 uxFoWTxTMFGig==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>, 
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com>
References: <20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com>
Subject: Re: [PATCH v2] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Message-Id: <179408000316.4465.8734683078485520816.b4-ty@b4>
Date: Sat, 07 Nov 2026 20:33:23 +0100
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

On Fri, 06 Nov 2026 13:28:46 -0500, Zi Yan wrote:
> __split_folio_to_order() calls prep_compound_page() on each new head page
> to create a compound page after clear_compound_head(). prep_compound_page()
> uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
> and frozen and no one else is supposed to modify the folio's flags.
> 
> However, code calling migration_entry_wait() can reach the folio by PFN,
> then access its flags. It is because softleaf_entry_wait_on_locked() used
> by migration_entry_wait() sets PG_waiters concurrently without taking a
> reference and the frozen refcount during split cannot block it. Meanwhile,
> __SetPageHead() does a plain read and write, so PG_waiters atomically set
> by softleaf_entry_wait_on_locked() will be lost if the set happens after
> __SetPageHead()'s read and before its write.
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

[1/1] mm/huge_memory: prevent losing PG_waiters in __split_folio_to_order()
      https://git.kernel.org/mm/core/c/654fdaf4

-- 
Cheers,

David

