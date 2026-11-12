Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472090;
	b=kIG3yXNC+AjiOBq9MLlndPLcRZVSJK/5On4eqcsZYeCluDDovBaAQWZ4n9w8KPz5ZdzM
	 usvRQENlq+D3HwUMigrmg3Gi+B+Na1HxAnTt46zVBez0O7Bx41OfQ+bQ1ERz2DfrxYVBI
	 k5HyE1XCvmeBTbxEWBdtCJbjwk5S+VmQiIwDZzjUwSn6UZGHyPGvullvN1LATOBAuGnbu
	 u1od5hr+SxdEiGH5242eolAPasHLWOu7ZT3dxjYtBwetTEQVX4nx90Z9YOFEgfr1+gplL
	 HCQKS0DsAEwNrFZvwCNILEZuLsAh761ZjLY1cBzRYUioyfLmYtWMinmEqtq5Dv680jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472090;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=FsqACPeqlnYxJmJXczgM3wCIFdBzchwFSrFPzfCm5aw=;
	b=bTLDctjuGnyToeUwuz8fzoYalJ+ipxB3YkAJ9aj5YQdTlbpuJPVmcICR6u8DsBC2uvks
	 JXodjjdoKknN5oeNdk0BLFcRnKsMDxW8taeMOGpqdfBMXm1BsqyWBJmepSbJc3wyw55wq
	 ymY21p306r2DWxTsq8rfXyv7RP3qxuo+npTPxwZ9gvgEcfF5sqj6N6PWXPKkXTjNwASkL
	 wkaE/otjqN0dIqT/3yb3snXlbVyaeVA/9zOVvHE5BIhZMsNPJ5cvXk2jcLb4Oymi1ca3j
	 ByidAJc6FkflaCWnTjyzpOs1ldd+V+Q2fYxjnGxGfr7LC6wFfw1lO9JaxixpHl2nWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOFZUt03;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4E606A31C;
	Thu, 12 Nov 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOFZUt03
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF60F1F00A05;
	Thu, 12 Nov 2026 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472089;
	bh=FsqACPeqlnYxJmJXczgM3wCIFdBzchwFSrFPzfCm5aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IOFZUt03oPnkjnJPRCMWT3B+CaPwZlBB5078IQqwnu/QLUXwXwTihx5clXDHJtQUa
	 hoA/5fQXlDZX6O/s9GDI3PHHWNGaXzHnA2A9L501+edpTxIxL/FTplCkNJxjGOUWk3
	 oSF4Gmkst/VgOygG8dGVSUKIDd7ebx6FIu9gvwPaD0qfZ4dZFU9k8SjV8HhuQXtYem
	 TYKKZ2U7HtFD/6LVVr1UiF9UgeZUhChRiR9aujYWnadKRJyzSt3VxFgpviyJzX5UMW
	 usgFDU7oSyYh17z5pHwZKS0OY2XbZpemqKmNVJMoiK3t+ENj7nlQlzKZ0FheOj8GJG
	 syCIE+/DGy3iw==
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
In-Reply-To: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
References: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
Subject: Re: [PATCH v4] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Message-Id: <179447208361.3070.1557607226599858764.b4-ty@b4>
Date: Thu, 12 Nov 2026 09:28:03 +0100
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

On Tue, 10 Nov 2026 22:19:25 -0500, Zi Yan wrote:
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
      https://git.kernel.org/mm/core/c/0cedfa01

-- 
Cheers,

David

