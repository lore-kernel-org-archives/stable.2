Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625209;
	b=UraNjDVUIuKJadzSghfV5GhleoGuA8Ws+tmGDuaweVfxN/puwKVYhnVmy1IQsvckp0Uy
	 6qebwMGlilTLOs7JHMZdAadxMJPWs8w19wJOEFpPmtVfirz3YNuWnPhaiT8Q9uqbOd2+O
	 mnPR7/9a8ymEUADDPDv0rQS0Opyep984N1U5VdUXke577xCND0+bgSlwj7MqPw5qjUmde
	 xxfzFGIrTsbuECSUMG+oTsw6O7cAvMSQZqjxGIda0fy2cLoRUPm1khlw/wHdBB0QEE0CW
	 d6+zyY4JPLcJpQ3u1CshuziuSjpFiEm9K2skYDdIg00yAmunFIl94Dqo4qsA60SlofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625209;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Yvtg7UEHcDn0BhPld9BffcD6kymWDnPG5L08CfILpNQ=;
	b=1auLWzy42ViIPZ5hWmUMiLelC6zCgm4oLrb21tDJOOUe+iTtft7hBDeKDEEvxn8BEmSv
	 EuZcqzOz2p87brU18d7dKJRI92+kCC/+wajcUa62UZUVKomj99Dl/KiHRaUxcd0fKAcDZ
	 LCCH1jiNaaAci75egu9TIM0pDyrNiFPDeHnmutuwJeDnYBHS5nWc6qzSABZ9rVVmCN3lc
	 SebiImJ9irQ4y5cqoM1NUy3m4tld79yzbGbJIdggbxSlt11nZKVh/WFcsfSpxM1s6KsJK
	 PNQ13q911aihFHda4o0bP1JntX8mKa6vVkY8K1ra0ItSbRGi4VQP3Yu5lFS7rL5eVUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JO/gGD9e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C998606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JO/gGD9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE751F00A16;
	Mon,  2 Nov 2026 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793625208;
	bh=Yvtg7UEHcDn0BhPld9BffcD6kymWDnPG5L08CfILpNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JO/gGD9ewHyz2SLuQSnWnv5SkRYnjW6Jlif4kKehidqN1K7Ls90VV+U9KAKZIAX7q
	 I68srTMzUM/97p9GI4YCKRv+h2VcTO1HFSKU5iLgqQH/1KhZn/bImVB8RnGEUwGkuR
	 j9ZuAHOca+gT5pcdFkG2v1PqNoqpqWzgQzUa892tURhDbsdXJ4vWvXEL9swBYlIdCm
	 ygLFkZxPMK+1eDYPrerqdItygGbXfPvJDCRnSR+bQOxzPIbDTuMSv7T0uf6cUMwaVz
	 Q3MNvnI4nJxN/nWFEqeuQGh1hU6ksvsx4fD01hsq0nNa2P59pjXg3az+vM/YmLn7gP
	 A7qEIsD2DHJ3A==
Date: Mon, 2 Nov 2026 13:13:23 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/mremap: fix hugetlb reservation leak on partial
 move
Message-ID: <auiJW4jzNs76F90O@gremlin>
References: <20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com>
 <20261030-b4-mremap-pre-split-v1-1-c1829811aed0@toxicpanda.com>
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
In-Reply-To: <20261030-b4-mremap-pre-split-v1-1-c1829811aed0@toxicpanda.com>

On Fri, Oct 30, 2026 at 02:42:46PM +0000, Josef Bacik wrote:
> Moving a part of a private hugetlb mapping with mremap() leaks the huge
> page reservations of the parts that stay. They are not returned when the
> mapping is unmapped, when the process exits or when the pool is resized.
>
> fixup_hugetlb_reservations() takes the reservation map away from the old
> VMA while that VMA still spans its whole range, because the moved part is
> only split off by the unmap at the end of the move. hugetlb_vm_op_close()
> then finds no map in the parts that remain and returns nothing for them:
>
>     mmap() of 4 pages, MAP_PRIVATE | MAP_HUGETLB    HugePages_Rsvd: 4
>     mremap() of the second page to a new address    HugePages_Rsvd: 4
>     munmap() of all of it                           HugePages_Rsvd: 3
>
> The source is unmapped in this case, so the number of VMAs ends up where it
> did before and the check against sysctl_max_map_count stays as it is.
>
> Fix by splitting a hugetlb VMA in prep_move_vma() before a part of it is
> moved, as commit 597e4b9ab48a ("mm/mremap: fix locked_vm leak by splitting
> VMA for MREMAP_DONTUNMAP") does for an mlock()'d VMA. A backport needs that
> commit, which is tagged for stable itself.

Ack, that one goes back to 5.7 in theory, this one 5.16 so all good.

>
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Some nits below but LGTM, so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/mremap.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0d06d7f37f19..cf746bafdee4 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1038,7 +1038,7 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
>  }
>
>  static bool __check_map_count_against_split(struct mm_struct *mm,
> -					    bool pre_split,
> +					    bool source_stays,
>  					    bool before_unmaps)
>  {
>  	const int sys_map_count = get_sysctl_max_map_count();
> @@ -1092,14 +1092,15 @@ static bool __check_map_count_against_split(struct mm_struct *mm,
>  	 */
>  	map_count += 2;
>
> -	/* If pre-split, the -1 observed above doesn't apply. */
> -	if (pre_split)
> +	/* If the split off source stays, the -1 observed above doesn't apply. */
> +	if (source_stays)
>  		map_count++;
>
>  	return map_count <= sys_map_count;
>  }
>
> -static bool needs_pre_split(struct vma_remap_struct *vrm)
> +/* Is the source range split off its VMA, to then stay mapped? */

NIT, but slightly awkward wording. Honestly I think we can just do without a
comment here, the name self-documents, and the hugetlb 'stuff' is documented in
the comment below.

> +static bool split_source_stays(struct vma_remap_struct *vrm)
>  {
>  	/*
>  	 * An MREMAP_DONTUNMAP of a mlock()'d VMA needs to unlock the
> @@ -1109,11 +1110,23 @@ static bool needs_pre_split(struct vma_remap_struct *vrm)
>  		vma_test(vrm->vma, VMA_LOCKED_BIT);
>  }
>
> +static bool needs_pre_split(struct vma_remap_struct *vrm)
> +{
> +	/*
> +	 * fixup_hugetlb_reservations() takes the reservations away from the
> +	 * source VMA.  The parts of it that do not move have to keep theirs.
> +	 */

If only we could swear in comments... :)

> +	if (vma_is_hugetlb(vrm->vma))
> +		return true;
> +
> +	return split_source_stays(vrm);
> +}
> +
>  /* Do we violate the map count limit if we split VMAs when moving the VMA? */
>  static bool check_map_count_against_split(struct vma_remap_struct *vrm)
>  {
>  	return __check_map_count_against_split(current->mm,
> -		needs_pre_split(vrm), /*before_unmaps=*/false);
> +		split_source_stays(vrm), /*before_unmaps=*/false);
>  }
>
>  /* Do we violate the map count limit if we split VMAs prior to early unmaps? */
> @@ -1162,10 +1175,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
>  	if (err)
>  		return err;
>
> -	/*
> -	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
> -	 * case perform any split ahead of time for an mlock()'d VMA.
> -	 */
> +	/* Perform any split ahead of time if the source VMA has to be distinct. */

Nice reduction in comment size too :)

>  	if (needs_pre_split(vrm)) {
>  		VMA_ITERATOR(vmi, vma->vm_mm, old_addr);
>
>
> --
> 2.55.0
>

--
Cheers, Lorenzo
