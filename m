Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475334;
	b=BKxDnIHheHfKuxTYfYiSsZZqq9buL/R95/nL4OX2Fj9KcSv0rV4bfbFrYYjyiepazTrb
	 RdX/HwXzq3m4v6KSOSNgyew3/wj/TUwJVKYslBNjvxS/PGUmBwFYdRRnjXHDn0kYR1/8+
	 Le1JZyfa8GF0p4gdz+Pb+DzoZdWk4vl7XIBF/Ydb4iduA4tH7bPyw6wi+VZ6pK+eeesQR
	 6w5H3SJFdEgDUegtCOXe6AcCHk+T8hZvcPRqqjZhwSFXjr3QDsFs8Cx62H2iLs5SUaTrK
	 Cn/1kszZo/zGFkPmnBb+ZukCtrKRhcnRAkz4Ntcq/fXFLo0kvYlD39m6fWp/gXdnibA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475334;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=lEBNes9WZ6YlYMttj1cy98GuEcLLQz3c97TIzqpDgiw=;
	b=Mw+X0YSr2HxUp/yhYCvOfWcYVaebvHSsMm5iTKJpJj3d66FU0Lv+/C/TCqjPnwussQDk
	 1ckblr4W5Kr9jrwq8L4la2sSWXD7CgdtASKr7BpxlSyxNMwRVAnTZoSQOV2wC3uBvTxsb
	 cr8pIl5G1w18Ft9EMTIeU0fu1hEsi9M7IMXcUeN79X7su1gqe7bJre3H+YAdLr3+pwDN5
	 fc2p08iiThrfDeFLEdmTZmVyoTfCooqyW8/gvKIEuzpuhLxbf3XSn0lCi4sMZOSgL3FKQ
	 hJuZpXHJIz92dNZ4d3O8bFfHU7MfL4p3eU8iy6F0G4oBTH6xZA1mDQLzgY9R6p/VS6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dd2hxb+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17347606A31C;
	Thu, 12 Nov 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dd2hxb+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FD41F00A09;
	Thu, 12 Nov 2026 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475333;
	bh=lEBNes9WZ6YlYMttj1cy98GuEcLLQz3c97TIzqpDgiw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Dd2hxb+zBo3V5eqRPFxmMyyaeh4MczoWOPu2fljcl+Hi/GlqKioECJQFEXurY1pdw
	 TYDqVg/w4/8eXZsZHpDG2Jq/2NGiIcUqcWgiPAyCLmc6D0PfavU7/MDwQd+hLVCDvf
	 EBV32TpEIc55z0OwZe2k5xfDu+FcpelKvRRXcA72XT+8nTfWvO3vjanN9LJXVKg/UK
	 fZB373KULjgugUGxbEKFyxz/Lf0imrdqp8Oivzv/QAj6IkXzmh5Q1sI9so9caPLhRj
	 k3Y6l/qM5I7iNaHShYon/2mEOFcgc8GbQRJ94KN391W0H285epX40wECoWnv4DkGST
	 Xs/EkqtHUNTzQ==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, 
 Barry Song <baohua@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
In-Reply-To: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
Subject: Re: [PATCH 0/3] mm: fix PTE table overruns with folded PMDs
Message-Id: <179447532820.4855.13160220470264902013.b4-ty@b4>
Date: Thu, 12 Nov 2026 10:22:08 +0100
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

On Wed, 11 Nov 2026 22:59:58 +0100, David Hildenbrand (Arm) wrote:
> Fix 3 pmd_addr_end() abusers that can result in PTE table overruns with
> folded PMDs. Let's factor out a helper from a place where we
> recently stumbled over something related, and use it to fix these 3
> cases.
> 
> I'd call these more urgent because they can corrupt memory, although
> folded PMDs are uncommon.
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

[1/3] mm/userfaultfd: fix PTE table overruns in UFFDIO_MOVE
      https://git.kernel.org/mm/core/c/654b0d18
[2/3] mm/rmap: fix PTE table overruns during batched unmap
      https://git.kernel.org/mm/core/c/bd94d906
[3/3] mm/rmap: fix PTE table overruns during batched reference checks
      https://git.kernel.org/mm/core/c/dbedd8e6

-- 
Cheers,

David

