Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908465;
	b=Q2XRgJYg+cC05xVXWEcOKEnKSyCZZ/Yu0h6w0xu83fXzQY4Vqmsse1/07AyCLC/cB61s
	 HZOHuowkKq/+rJpOOLuvGTbE+2RYSDo5ag0y4yzFoALqyy+kBCbLIuDLODYfYuw5sepYT
	 aD6wJpJ+yX866VhKUrfS5CxhtRWjJpIeAktyGVQTC7YPqrzLwkO2LSq0/GURGnOVfQTSf
	 lw5OHdaUrqWFbR/1rKH2Yl0tpWh0wOu43AfhvEoQzeL0g3p3XNEbiW6s5g0ewoNWwZ4zZ
	 RT7g8QxNsqt8Y7TBdQAg5md8SQFFNtm705zY6SVDzXctJK7wknEgMGPjBx4COn8k/fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908465;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b3iFdC4kvUX11Us3pNRfwEgLX6l6dmfhvWxrnpKmb54=;
	b=CPA0xviSnGcloBWDyC2n+t/Mer5eT8EIqphh7g3A44yp3oK2dTlQzfdwWdRmgoCOzSHJ
	 cYoV6tNI7Uh3R+LPrTkFQvQBPzGyJhz5gB29JPskEe9XHRV9PkO5dfG4qQCl/QDHayjtG
	 CrDcpASJ7YxQCrcBRRBFl9ciU8EGCJiPhYi/tLmws40V8FcHGtIY62RENODAOlYPn4TXX
	 Qcp0wb9J+p7y5AmSFM0d9mQ3LfRFB8Lwn/ZHt2kewEo2pO0Oo9fRSw2/JMTPY06U+cPJC
	 4fVEM08MHtDIT0JWzaqY0tpfu4uAbv26vm+YvT4alxKfCpKlBeZ6Udp2J6KtcQoFPUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0VAwbxv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CF606A31C;
	Tue, 17 Nov 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0VAwbxv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEDB1F000C4;
	Tue, 17 Nov 2026 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908465;
	bh=b3iFdC4kvUX11Us3pNRfwEgLX6l6dmfhvWxrnpKmb54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O0VAwbxvvdV/COcwnjk9DUI1gzqKmA5WOW6yybIKHp7iL1VZs0zyxDA8bU0Ax+SDz
	 a5/x+uOnG73FmZfXWfFDvUTBmbc/Gsxc3qHa+EfcYchf2gO2o/ZMqdNDgtseFRtXDI
	 JXrGvOD/S5KgB3czpgF9hF1S7VenW37S5aIX1ZUnkOZBGPumAunw4H9od/rVQGuSSE
	 zIXcVmc9fCg0VV0PdjHNH4VqJlxh73WMqxF8VXUDBNPWmRqOKLkwWyzJUYAyKrj1ka
	 e7IjzRiS7ROcUCXVixjLwRQjs4JadJsIIMW4j43IMa3kQhgObLgpLv7uxQ7TtUvSnp
	 cJG9oNXGFA8pw==
Date: Tue, 17 Nov 2026 09:40:59 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <nico.pache@linux.dev>, 
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	Daniel Wade <danjwade95@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: mark ptes dirty and soft-dirty on mTHP
 collapse
Message-ID: <avwhJHQN_w5nUbzj@gremlin>
References: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>
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
In-Reply-To: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>

On Tue, Nov 17, 2026 at 10:28:18AM +0100, David Hildenbrand (Arm) wrote:
> An mTHP collapse can lose soft-dirty PTE bits if pages were written and
> the VMA was then made read-only, and not setting the PTE dirty in
> VMAs without VM_WRITE can interact with a later MADV_FREE on a COW-shared
> page such that all processes lose the data even though a single process
> MADV_FREE'ed it.
>
> Collapse does not preserve the soft-dirty bits of the old PTEs, so the
> new entries must be marked soft-dirty. map_anon_folio_pte_nopf() relies
> on pte_mkdirty() to do that, but only calls it if the VMA has VM_WRITE.
>
> Further, after CoW-sharing such collapsed folios later, all PTEs will be
> clean and the folios will be clean. One process doing a MADV_FREE can mark
> the folios as lazyfree and result in all processes sharing it losing the
> data once memory reclaim zaps it.
>
> In map_anon_folio_pte_nopf(), call pte_mkdirty() unconditionally, just
> like map_anon_folio_pmd_nopf() already does with pmd_mkdirty().
>
> Consequently, we always mark these PTEs dirty (including soft-dirty) but
> only set them writable if the VMA has VM_WRITE.
>
> This essentially reverts Hugh's commit 1ac0cb5d0e22 ("mm: fix anonymous
> dirtying") that back then touched do_anonymous_page() to avoid forcing
> clean anonymous pages through swap instead of discarding them. This no
> longer applies as shrink_folio_list() allocates swap for ordinary
> anonymous folios and unconditionally marks them dirty before unmapping,
> regardless of PTE dirty state. Keeping their PTEs clean does not make
> them discardable.
>
> This now also marks fresh anonymous PTEs dirty and soft-dirty in read-only
> VMAs when page faults allocate real pages.
>
> This has low urgency.
>
> Fixes: e22f2fe72c74 ("mm/khugepaged: generalize collapse_huge_page for mTHP collapse")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reported-by: Daniel Wade <danjwade95@gmail.com>
> Closes: https://lore.kernel.org/all/20261117075246.61336-1-danjwade95@gmail.com/
> Reviewed-by: Daniel Wade <danjwade95@gmail.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM and:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d2f48d78b0d7b..45875d1d3b3df 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5522,8 +5522,7 @@ void map_anon_folio_pte_nopf(struct folio *folio, pte_t *pte,
>
>  	entry = pte_sw_mkyoung(entry);
>
> -	if (vma->vm_flags & VM_WRITE)
> -		entry = pte_mkwrite(pte_mkdirty(entry), vma);
> +	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  	if (uffd_wp)
>  		entry = pte_mkuffd(entry);
>
>
> ---
>
> base-commit: 1c2962a57377c9878cbefb747488324d4e678982
>
> change-id: 20261117-khugepaged_mthp_dirty-067f734d38aa
>
> --
>
> Cheers,
>
> David
>

--
Cheers, Lorenzo
