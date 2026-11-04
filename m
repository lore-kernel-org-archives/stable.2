Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804368;
	b=sZtR5N7qDlYAq1IXRyao6jQTDgVqWCY3EcXeXcN9S6qYL0AbW0uUqTOCGIriFc2ercBF
	 cgNsHOoclq66JLXQcCx6iwkSfnwtoiLLEs0GSLygphNEEuLQZ1LujQ/qZ/CxQ6K+W1YcT
	 2oZsOrsDhtpq2pRQtGM56SaLW2VNr2ogWOB5iRcigbYKs1jycRZly/yyrp4R3KrTZ7qQG
	 1x3xtG8IkwByaxayHCGS/xOlpdeMQujOaxlMJKqlGY5I8YHVAvU0Xnb/EhTl28P9IXUk9
	 bgmxTIN8/hKkAEJIKDg8dIbF1uFPQAKCBAWUAGlCLMfLiuOsLSFPgtSg/GFbmpT8IOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T5ANptYopnl5748/p2sHm7qxklUriu1qCPoMwTQ9pxA=;
	b=oD2J3zh/HzNGZ2REcWIqlhv78qOXuf9xYsCQuptbm7vrMTVYvjJqT57SFEGgPx8T6dWE
	 Cdx2iXoUOAstu37igY/Ryzzd2Pejah+6OAANX8dZdVGJm1CsZHKct/waB069SX3m57kQD
	 yHBKucSKCyn4kdkbBAo1FCAy72yo1tBvRX/YACGHbIactJMIz41Hy7v5big6PuwPLPKv3
	 wnJ7gQze1lnjRCwboNLZqNSCUx9mKe4nX0tVj9JaL/ZlH7fLcK6mWKCyJt9W71cEEX9en
	 404Bqz9EDuCmODBLMS9lnOUpjrrvTon6GkVkZ5Dn2m2UIqszPhqOO46b8yGXx0ue3bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frHKW37W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52644606A31B;
	Wed,  4 Nov 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frHKW37W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224F81F000C1;
	Wed,  4 Nov 2026 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804367;
	bh=T5ANptYopnl5748/p2sHm7qxklUriu1qCPoMwTQ9pxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frHKW37WQrrbFlLhJok5407YPn09wzEYmhPuqaufJ7K9HzQ4BMN26qtMcMsBDoQNO
	 fZw4tBoJFy+J8NJaMWS1hP63l3CFB7Hai9WMz3Y8wVkvSem/QN+dbCmJaex8Rf5HHZ
	 G7p3p1z3nySVihNl3LQgcll+PCtED6bEZm9Uki1+vyseI4sxdwHKnj4MMv9CFR9Zlp
	 JynBqV4HbA6DibQSRx5lrvt6Sl1PLGa6tgkUhliNwgD887EUxGhwUSNMI1d0O4NKBa
	 v4jzyhFWgW3kM1FsNImRW3lM6C4+bPTav/gDr4MrSf/fC8LTj/w6KQgHj7E6XjWUil
	 4dDTd2Fvr9XqA==
Date: Wed, 4 Nov 2026 16:59:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] userfaultfd: validate the whole range before changing
 write protection
Message-ID: <autISNbq0kLikxlF@kernel.org>
References: <20261104093457.152245-1-umangpokhriyall@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104093457.152245-1-umangpokhriyall@gmail.com>

On Wed, Nov 04, 2026 at 03:04:57PM +0530, Umang Pokhriyal wrote:
> mwriteprotect_range() checks each VMA as it walks the range.  When a later
> VMA is not registered for write protection, or is a hugetlb VMA the range
> is not aligned to, the call fails after the earlier VMAs were already
> changed.  When unprotecting, userfaultfd_writeprotect() then skips
> wake_userfault(), so threads blocked on those pages are not woken although
> the pages are writable again.
> 
> An unprivileged process can trigger this with a range that spans an
> unregistered VMA.  It hasn't been seen in practice; it was found while
> reviewing the userfaultfd range ioctls with an LLM.
> 
> Validate the whole range first, as mrwprotect_range() already does.
> 
> Fixes: a1b92a3f1498 ("mm/userfaultfd: support WP on multiple VMAs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> v2:
> - drop the redundant error assignments in the validation loop (Mike)
> - drop the selftest (Mike)
> 
> v1: https://lore.kernel.org/all/20261102103621.156928-1-umangpokhriyall@gmail.com/
> 
>  mm/userfaultfd.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

-- 
Sincerely yours,
Mike.
