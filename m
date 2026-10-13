Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6644F30FD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896249; cv=none; b=APMNEXRD6ZtWwskOKAIZRDJT5jkXWOZg6NIRP2aRshEcozaIuirK8oJ6RNYdCe51ZXDJZYQM3zU84zipav4lFniKCgdN4JKHFUlqDZvN37umdbiQKaYeXeDAPSKGZcbM5N/eBMUcvx9jGWBxek9FRLYjaFS/AuU++wVQDqPAuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896249; c=relaxed/simple;
	bh=EMvZFec+aEZgob/bO36XSk9Xavr5m3zM18K2N4GEyaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVcpZTfNRT6nCq3FDQapPwdQcG+ibInhFjvHC3QvEoio2IE0svU9+Fxx+DpWaRRnwBYYzvOrDbIRDrZfv50oiHqmefLAQlMdqJva88X28X+bBrKjaHlQz31xFNoPXz4IM11S5X2jviiM1+XrawxPeW38c3feMFwbXz+qy//uX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvs3LSld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvs3LSld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58841F00898;
	Tue, 13 Oct 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791896248;
	bh=X9BFwpcjmKrDdzhZwTDHl5KDt9LrzcnjBY0dqWfL9Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tvs3LSld6tUOqgkZKYngv0FmdeG0q1D4nK6h04teUeYxBoab4M5KthE50Krt/exvX
	 JyWmFbKyIdLtbdUddbPSqXTmGk1CxfRC4ancItw1dDxA7FcpxmnoVckHJb9GF4TXGM
	 eIIrxYa8LaA5aEQSzvCGOBVBq1isxW9CymOp7LsWQMDRhcu8+mHLYENEh8FsneAMz3
	 3WLZIpNLaMZv8G958r1z7Iqlen3ytbWiJ7BCjbwzc6o34+6JDBJwhad1kQxm+NXKQk
	 geGFq0J5M5eucOpf0Glj2uWASn+KdTqiQBD6jXpmamaIOPn7Y8Aoz42IWwFP8vEA7k
	 KES+tEtmYXRow==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id B609F198003A;
	Tue, 13 Oct 2026 08:57:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 08:57:25 -0400
X-ME-Sender: <xms:sirOaj7t20PPBmC0VgF_kX-BH_szYJkQ1lz5y8Ujzn6YONWN3iITRw>
    <xme:sirOalU4gdiujkt2P6LsVs_jbh5nWBI8zXgOpKSF_RPczri9K0FzdUDoz1dwCjYRJ
    vK6XnP2jojY0Tjhg_kQ3F6X_RGlAEMhwuWmWVpwnICQIvQ0_usyvsWJ>
X-ME-Received: <xmr:sirOahul2_b8Rh5BgbU47dVYAXwNtIUY0HIB8RfgeWHEA0qicCsOa_LHdAY>
X-ME-Proxy-Cause: dmFkZTEetqmizud+clew86He+iiifUKs94ePsfMAGNNPMmxgxaJcQtNwftmQ4FOsIRMZFd
    p1MeZZgEA67dwqEqwnkr9c8OjvKQsDfeAsifflVQReL3Pft+JJQzZK/OJoNXOjH6QFKY1a
    532uP9WhuX8Gl/oakRel8YxZcScQ182XP8mCDVloKrpc1ubB/YrgUwTFFzCtyoDK8vabJ4
    KmBMY3r/03LHp3KTiVQvPSpcMw8RIXIkBRo7d2UWWyg5HdQDMUQ5SJD4LgUB2hnRqejjuE
    E1ZFIiECiniGuVUPUMgC7vY+pflwKfQx2mdVyPbFen760/u7kdhq25cN79pi87MrgbR2HB
    i9QhoZxOz7VJYTBjfS2SH6+BIM6AqXvlQY7HkAxNrn/CUD3hBligPhZqBs1MWtMk1rjQrR
    CdLfeZu3RDnu2z2nrTqzR3NwlFsfj3utQppyMi+BQeDGbR2iO2rxS/p49qPmDzD6HmCLG+
    Dx8/Gem37n8bZyTqaMbP7yuyN4BXCyyTLaJCOhtODibFchmq18+3ExOlh0DHAaJmILTeYz
    NHZyQ9ZtbVyS+Qat+s5v5hPzl/+hCEfxyaOVr70AjmzlWwcuyHHjrvN4xJWidHZfUMsVLj
    qhKdlGgOAZX5kE2Jmf5p+9IAEihQKqaiu7KnsGEes40g2HF423c3tJ48JKyw
X-ME-Proxy: <xmx:sirOaqqqFM4nvubugARgJOFlU8NG2zgnWtQ1wJg84r-NRAMqsopH3g>
    <xmx:sirOanbLvGRBuLjeMPAKNFk2MMGzUwpGA7huIAcIBmf-Xy8vPEnIsQ>
    <xmx:sirOajycdr5YvGZP8lhrx023NDnRgbjQybVtD2iDv9z_H26Fx0wjDg>
    <xmx:sirOal9iEI2KeJoJunp9ApN6o8vMcOa5Okfy0tlrdFxwzWnVS8-HcA>
    <xmx:sirOahW_uXsL7xG2EIb5ixBaQ85q3xBwRNBArPSHh6vnFgNYgSzpac1p>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:57:21 -0400 (EDT)
Date: Tue, 13 Oct 2026 13:57:20 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Message-ID: <as4qKLx_XwQ6qY3p@thinkstation>
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>

On Tue, Oct 13, 2026 at 02:30:37PM +0200, David Hildenbrand (Arm) wrote:
> numa_rebuild_large_mapping() and do_swap_page() can be tricked into
> generating an address wraparound, crashing the kernel. All that's required
> is to map a tail page of a large folio close enough to the start/end of
> the address space to e.g., make
> 
> 	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
> 
> to wrap around.
> 
> Let's fix it by providing a better helper, folio_pte_scan_range(), that
> takes care of staying within VMA and page table boundaries while
> handling possible wraparounds.
> 
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f5d5f7d39cd2..a3823010aa981 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
>  	} while (--nr_pages);
>  }
>  
> +/*
> + * Get the address range in which a folio might be mapped, assuming its pages
> + * are mapped consecutively and the folio page at the given idx is mapped at
> + * the given address.
> + */
> +static void folio_pte_scan_range(const struct folio *folio,
> +		const struct vm_area_struct *vma, unsigned long addr,
> +		unsigned long idx, unsigned long *start, unsigned long *end)
> +{
> +	/* Stay within the page table and VMA boundaries. */
> +	const unsigned long pmd_start = addr & PMD_MASK;
> +	const unsigned long pmd_end = pmd_start + PMD_SIZE;
> +	const unsigned long lower = max(pmd_start, vma->vm_start);
> +	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;

These -1/+1 gave me a pause. I guess it is for pmd_end wrapping to 0 in
the top PMD? A comment would be nice.

Otherwise:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
