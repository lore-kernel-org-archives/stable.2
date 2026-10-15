Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338013F104B;
	Thu, 15 Oct 2026 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093674; cv=none; b=EEycyNS2ITosLmHG8DzVW/tYdmrO20LusgIhfMcooto2CnXbu9XugVqHlzhxhbu0bPVEMZI2ds55uZjRsa45CqJ9tS/qCY+v2dbeJYsK2S8znvxE8m5Yw5E9k0Eggs5vhtediir+DRIYc2XqAdCw2Oz7hORJp4xTXNslhueffrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093674; c=relaxed/simple;
	bh=U4Q50Bch/7DY2meSVUid+sAQm6zjGxwuEGe2l2WAHzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq1Ydtv1d9VGR22Mnih2vpFDMWYcrvFPSO1eK3e2lNaWFaCR5qcVtecPPVueVaneHYeCG12gzUizNtG1+uK4xoW0s5m1559Mec7MOHXnukXPsy2u9kTeXsjagoVJrztYRyc+R0iqGpA87N+hHUSaQRvAR4wMvMXBJgBp4gA4wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThWtpvf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThWtpvf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CC1F000C4;
	Thu, 15 Oct 2026 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093672;
	bh=V9lVAl0inOJKZISTRP7bv977o2J5aqss+rBQ8yoS51c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ThWtpvf6zsTR30bHJIEGafp2NXw3++Q+jHmYCqK53yM75cv5dhwRcvhB0Jcf9rGbw
	 U4DIZQU8vzu+emd6urqBH0QG5KI1aEUnl9Ol9zdAdBbZTollbVlRykDUNmhos+QAU1
	 3Zj35yoE2B5rAlJ/+JXrWAOX+/qgUbR0B5qgBTLOZ3O9kEEjQC10STGDfwe9/EmXSc
	 p16Pi8Ly4hQClJGe5OLe+CL6T94vALAS7lAL+j+99CkiV78DtHicCG7MWw/cD492/1
	 n9Uh7WftNS1kdvfUD3l2OIDjTlbJOVCD5zHGTSp3tEstj5OTUYVQMowVaracNTNkjm
	 LTWyG8haewf5w==
Date: Thu, 15 Oct 2026 20:47:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Adam Litke <agl@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
	Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/hugetlb: tolerate UFFD_WP markers outside
 uffd-wp VMAs
Message-ID: <atEt2ULH6uQSeJH9@gremlin>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-8-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-urgent_fixes-v1-8-42796911043b@kernel.org>

On Thu, Oct 15, 2026 at 06:07:14PM +0200, David Hildenbrand (Arm) wrote:
> UFFD PTE bit handling is a bit like swiss cheese, in particular with
> recently added RWP mode. Having uffd-wp markers outside uffd-wp VMAs
> already confused this code in the past and resulted in uffd-pte bits
> confusing other code later.
>
> Let's play safe and just ignore these markers in hugetlb_no_page(), not
> silently propagating the uffd-wp PTE bit.
>
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems sensible so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/hugetlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ba6860b9b7f4c..1548a6156206b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5939,8 +5939,11 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>  	/*
>  	 * If this pte was previously wr-protected, keep it wr-protected even
>  	 * if populated.
> +	 *
> +	 * TODO: fix all cases where uffd-wp markers remain in VMAs that are no
> +	 * longer registered with uffd.
>  	 */
> -	if (unlikely(pte_is_uffd_wp_marker(vmf->orig_pte)))
> +	if (unlikely(userfaultfd_wp(vma) && pte_is_uffd_wp_marker(vmf->orig_pte)))
>  		new_pte = huge_pte_mkuffd(new_pte);
>  	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
