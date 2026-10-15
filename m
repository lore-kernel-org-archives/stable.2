Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB1463B69;
	Thu, 15 Oct 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095229; cv=none; b=rfcC398arCR4l9aGx07n37OddoTd7AiRZYrS2dN4p4x4/tMpagnktJLTUz7isbUUbaay8p8gqUAbccivkvPZLDfZPX1tfZg4fAdGmGN1tPcvtmsxb23rO3k7MZQYhAaci4Qbx1bnW0v+KI0zevoAIbdq2f7hftLKMVuVr3UJhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095229; c=relaxed/simple;
	bh=LelcTQpGfDAYxPDNWTt+0DVq5zuw61As++YgO8deqFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reJ2v4TQtvt+XqoKDjOaHoZHQkTq8QN1Mbh6PwpTcpDmxWou+J7pa4mgL8BQ6GgEh1NqFkuB6iMEZhCXTE/U3vjvCLCpWyzAMS8BmwFQwZlFFCPu6vUl2j1N29xmTYcYzJcSngBxXhhMqvILYQgg01oQtzlYhg7O/gAVTFzXvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFBprGoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFBprGoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4BB1F000C4;
	Thu, 15 Oct 2026 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095228;
	bh=oeu7IPs+bOeo1bu+3Qb1TsSjju14FLD65wrejrRGqiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bFBprGoarmRriOKc11aeVf8OYnVppRM1CFkjd33Eiv7bO3CB4iTshpHO3W/nl33mW
	 c1x2ipeUrJ00b274FY2h1kpGmqoQEtTXdf1jefMU3D5kXzokz0vphK6t+Lvpv5tSXx
	 rNyo49R4YycPTkZ/EuM0zMbHZqYhmqTvdHa4Rc9D5wUI5AUiGWyOgEXle3502b8XrE
	 LDRY0yguY16AI8hSdELHV6JmJPCmBhBVc9Ya6n8WNDXnS0ccoWhIwmZ6+C6KlBUpqH
	 hDoGxaHy0YwdQf7AhEZtfYksTHJ7afF9RhqWmINWY27FOrzVZh2Il6RWQPdO0o6Q+1
	 w1cIAOXO2unmw==
Date: Thu, 15 Oct 2026 21:13:40 +0100
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
Subject: Re: [PATCH 07/10] mm/hugetlb: tolerate uffd bits set without uffd
 for PROT_NONE PTEs
Message-ID: <atEzjnc734DMvFd9@gremlin>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>

On Thu, Oct 15, 2026 at 06:07:13PM +0200, David Hildenbrand (Arm) wrote:
> The whole uffd handling when a VMA is unregistered from UFFD is shaky:
> there are still some scenarios where we might have stale uffd PTE bits
> in VMAs no longer registered for UFFD, which confuses other code.
>
> Let's just tolerate that for now and simply clear the PTE bit. Add a
> TODO to really clean up any uffd leftovers when unregistering a VMA from
> userfaultfd.
>
> The handling is now more similar to what we have in handle_pte_fault().
>
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Ugh what a mess. It seems like bad code makes any edits going forward
problematic because of the labyrinth of bailing wire and chewing gum left
behind.

Anyway seems sensible to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/hugetlb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c3823f1958568..ba6860b9b7f4c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6127,16 +6127,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * NUMA hinting), so let normal hugetlb fault handling proceed.
>  	 */
>  	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
> -	    userfaultfd_rwp(vma) && huge_pte_uffd(vmf.orig_pte)) {
> +	    huge_pte_uffd(vmf.orig_pte)) {
>  		spinlock_t *ptl;
>  		pte_t pte;
>
>  		/* Sync: drop hugetlb locks before blocking in handle_userfault() */
> -		if (!userfaultfd_rwp_async(vma))
> +		if (userfaultfd_rwp(vma) && !userfaultfd_rwp_async(vma))
>  			return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
>
>  		ptl = huge_pte_lock(h, mm, vmf.pte);
>  		pte = huge_ptep_get(mm, vmf.address, vmf.pte);
> +		/*
> +		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
> +		 * are no longer registered with uffd.
> +		 */
>  		if (pte_protnone(pte) && huge_pte_uffd(pte)) {
>  			unsigned int shift = huge_page_shift(h);
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
