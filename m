Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382719;
	b=D5qV1pSfhUgXB1y+2QsljdREj/jXEQ58m/LhvIBI2ynyh3xv5MaXGvijEfNTaD8S9e+a
	 uyssRj4XD2cPe60HuHoU/4biHwrW/mhyJvmzfVvx3TJ77jKcV4heIvq6Vex24j3QvOpji
	 VnYLOOd5aTSG6QONC5ww4qCtW7t+xQBo76zwfuvQGE4y6z4Ws3kLIJEJTRboYVxCcLaAK
	 hmHUQJ+DCS+e66ObT4nfKHc1DWGSzKYNotS/eGe++VzPA56/AJCoH+zuJzGoGGbgJUZFy
	 GK8zuUnXNke7FcruegQ4fYLjvfR/2Ixoxd7zyYN60d1U7c9qP2oxcN+jdjIUZ9MI5wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382719;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=lhmlExdf0MelZAKOqNzZFBntyVoNsKlbfDLeJzzqUFo=;
	b=n4f8wDr6KZDIPR2uhqIuG1b3cqA8dzaq29uo4LDXoXgkk7DQ3F3SLsUk6V2ZuurupK8G
	 70mPprang5fNKcfSlvaigHtC0PKgU0Q5H7QBOpVcmZPq4EGRzxWm4J4V2/eEJy6oxmWNJ
	 SMW2cnPYFrSKufKy90Jv1r96bvk6UYDeuLB/mboZokA3NKvvi4Xp8ldaqMI1UQuHpKBVP
	 6WOwDrmvo5yLJvkzG8GMhQW+jf1zFyr7QEwOmezpex7Hwdm+az5egx7OI5aAq+jDh0AoK
	 n5khE1bxabohO3C0gIk1jX7l3wIXvuR2+9wV2oZmUt2397DattFU6TK/uhJB8i5WhFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN1E+pwW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E16606A31C;
	Wed, 11 Nov 2026 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN1E+pwW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D89E1F00A05;
	Wed, 11 Nov 2026 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794382719;
	bh=lhmlExdf0MelZAKOqNzZFBntyVoNsKlbfDLeJzzqUFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PN1E+pwWbP1/aBIuYWozEVC6Onp39zGoaiIzH1Lwx4Th1BngqUKaljpCtCCWPVdz1
	 cCknZguzdtZm2tVsO0wcJGjmSjElVXCIn0OsxW75VTDDpfuZ8y5HhKAZ/FIDOF8fc8
	 T4CQAbVKBFFNV9/F3wlZsFyvdOFENBqkkyLtvWaUEyUoJ37eGCQg7hU3txaiqEy3hi
	 MGA3gqq6mEFJJNtKbN7ZCSjpuT+j6Z8IeQcdcT2ZsYF0qoZx2C/yjIGJFyfYXjPvXD
	 z+vLNhYcUlpJT1KluTAgpiAmK8hA8jL+ZvtT4YfhDopXOZSSnJdURFE8lLe0E7JMt9
	 AgNqrrnGZvLfA==
From: David Hildenbrand <david@kernel.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Yuan-Hao Hsu <aa9736195201@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com>
References: <20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com>
Subject: Re: [PATCH v4 0/6] mm: gup: batch PTE-mapped large folios in
 gup_fast_pte_range()
Message-Id: <179438271528.6307.13271652883437039498.b4-ty@b4>
Date: Wed, 11 Nov 2026 08:38:35 +0100
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

On Tue, 10 Nov 2026 22:52:50 +0000, Yeoreum Yun wrote:
> GUP-fast grabs a PTE-mapped large folio one page at a time.  Every PTE
> costs a try_grab_folio_fast() (a refcount cmpxchg, plus the pincount
> atomic, a full barrier and a node stat update for FOLL_PIN), a
> gup_fast_folio_allowed() and a folio_set_referenced(), so a 64 kB mTHP
> pays sixteen of each and a PTE-mapped 2 MB THP pays 512.
> 
> The users are the hot ones: iov_iter_extract_user_pages() pins every
> O_DIRECT buffer through pin_user_pages_fast(), io_uring registers its
> buffers through it, and so does RDMA memory registration.
> With mTHP those buffers are PTE-mapped large folios.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: gup-7.5.ptebatch

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/6] mm: khugepaged: ignore MADV_HUGEPAGE for shadow stacks
      https://git.kernel.org/mm/core/c/0d100a39
[2/6] mm: gup: clarify a reason to check pte/pmd in gup_fast_pte_range()
      https://git.kernel.org/mm/core/c/6ae9ffb6
[3/6] mm: gup: move gup_must_unshare() and INTERNAL_GUP_FLAGS to gup.c
      https://git.kernel.org/mm/core/c/831549f9
[4/6] mm: internal: introduce FPB_LOCKLESS for folio_pte_batch_flags()
      https://git.kernel.org/mm/core/c/300a252f
[5/6] mm: gup: introduce gup_pages_not_requiring_unshare()
      https://git.kernel.org/mm/core/c/1b3ad4f2
[6/6] mm: gup: batch PTE-mapped large folios in gup_fast_pte_range()
      https://git.kernel.org/mm/core/c/3d738020

-- 
Cheers,

David

