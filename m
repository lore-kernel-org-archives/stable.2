Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964795;
	b=rdLEF1ILoEEXBKLHrnIQtppa0HkAzS9H5FzKU0CLS8oMXzNiB6ChF1ocEtmkHsTV/FP1
	 z/oSSjJYoHRXuDilCD6nc47QUitnMjo7NXKnDFaFH0zzqdyNa4PiVAMJY6y9a9GlpX6N+
	 xZBW25SxrfcRaJjz45R9QEf+/bSEPM7/NOTAmGjXdANokQvqIEl6os2q0ZR+oHfKa7Z0f
	 28ZsHg1hgweFlr+VZQF/H76170aeSqfPJAls9wE9QSnqbgDRgzCMeFuqPJ+dAlpYgP85B
	 9EQGrNFx1gs/EpdCcbSaeddxcqYhKmGiwNwfVcRVzEGdFrnAKZNd7VRzx9DZepbgtTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964795;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dwhjR2jVQFrycXPK2wViGRifyfXgiVWt6Joh/0g230U=;
	b=ozhHueefxfyPWqxJdXjrPDntluIoa3146YA8shyCqnUxjC1PV8jLWbC0g/ahJ7kaqiEV
	 ryXzu7dTT7e38GhwOY5R8Sg9W7qG0y3vMhK7i/fJQ2sWDfh7c+frmcOKhCi9UdaI6ii07
	 Tjre/vqubNvkAcsxuT8I9JeICSFLdoiZMg7OWRLuKb4fODozed2HVu/QZjZTNPkoD47Pa
	 eEEYn6cSA7aShxI5Xsqj9IkkXbwcgfTOP7apUYPOivs6oK6tFgsm2cXsbjQOj6fqBj5Io
	 v7cC9Q7WHrC84lyucVo3miMqRNk2EtbyA/6UPCg//Lns7EqQd10XPB2s2F025Fr7hww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoqO1Qim;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1026070969
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoqO1Qim
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876741F0089F;
	Fri,  6 Nov 2026 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964794;
	bh=dwhjR2jVQFrycXPK2wViGRifyfXgiVWt6Joh/0g230U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KoqO1Qim6fhPciC3HrjGQpiNGTwfFkaaXnbHF/sP3XEWozhHAXPaWtoWRY5xXxTze
	 eoeBWbY+1e+iiei4kEtpDFZkgWVi1NnJjmmD5F8Cp1ysUYb0CFCThB71XKqLhs6Nr+
	 TSHxDqrRA1Nk4MJkHxtKif7C5VT1dbiGt2+HXmlV5ve0AnML+weKBLu7Xza/Y2j3vH
	 0XuZnoQlmW/YQ2MwmJlpufFDS4W3DNSthfkON++SKyn7Qzy8SAkajdVWr0Q8vJ25Va
	 T3dQpWZfOXJuAZYXgBTtazrbQUwosSq5FlT+W9+lViaQx4kjtlYjoS8Gm3JiJ9EOfD
	 D7+ozfAk3yCXg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 725E6198003A;
	Fri,  6 Nov 2026 06:33:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 06:33:11 -0500
X-ME-Sender: <xms:9Lrtaqkp9-3qkexNMvtLxgPrPnal44LmqtyIgUdwLB4SmxkS8dGE1Q>
    <xme:9LrtakI3cPRKr4852ao8p7a2WlMa65T0MWCOFdxesHhJ83q3rl9YZllV-pvXxREAG
    3TEBByUImzVX4Za3JlhhvmQ1vIgAMAsID2k9o4d_TJGi8RnelAkbgm9>
X-ME-Received: <xmr:9LrtanUwGC87sY1OI40EDIoynU-OFR5U63teqDTIuCXa8opSVure6Gds49o>
X-ME-Proxy-Cause: dmFkZTEEFydlobSPmqq0NWC3mdnVpucy8xcvPzschiasYSG+OlRLasLiG9TZecSqeMAclu
    7ECEtWVEhVpFWw9L6x3TGu7nLR1O8zMFRELSlvLmXKF62TGeSu+644g+WtnosqAEJIBj3U
    1C1xys8WSxfv9kl/qzdvEzw3Cmj6rt7AE0u4GPfINkxDQ8zw5DYnQjjQtbTR4RRoqjyH3J
    xSUHuMOjWG/Jv5cLkhX/zTYDAz1ltDGIqG6hWds/QusvUCZGhIPZDTiXfUTJ7XCWMS2Inv
    DKk+mMT3lijC1m0RacMemu8D1Nvwd5LmLGsePLgiHP+eq5CrM0rj8rw3sU2o8aU0G/aqZY
    A69lcB4t4u/6I3XF0CLKZG7/FrHRMbIFy91zFZsNq52tbDvUbCUw92oGtyfOeBsfeeHeww
    szcOiH3p4asmaQMuWqhZSIJATRQx6Yr1IMLeUQMILL65RAq7YfKG+2GdkT/+LIcpxUBzwR
    XqFgJ8wxShaUOclMoMCNjGFiRyWU2+xFwKDBGiHXON7plZ5a0RyLEHmhszCw6SdkseHAUi
    iQvRY+kFYPLRCy8uR2wh+SKRWNDRH6kJe8WsrQ9L5nRgDt4qaub4NojRxEwuzGRpYfEmTk
    JXgOWukBYX8wmNJNrd8qNKlhsASz34Kb9aA7VBHVdrD+CSShqlN4PNWOK6sA
X-ME-Proxy: <xmx:9LrtarjV3mOSTqEcSTQaGqQ2WA_JhkjmAFoYe-W-js3fCWW1Rhs4Rw>
    <xmx:9LrtamdsFe3goRTjxc25y1zLrqNTxsgWzYZAgDmI_q9uhStOCjquiw>
    <xmx:9LrtatthR6KhOJSalUybeoTVfZ8N3aeen0odPHYe4f9nfn4kmqSvJg>
    <xmx:9LrtajmCqGSLd0xyR7P5i5lLOhaPZJNytvL5pCRdx8z8e1yoZXVm9g>
    <xmx:9brtahOQu1ng3v8YW7uyxKi-JWtXj0BnCwjxZwKEUJ6w-uO2HTj4DZXi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 06:33:08 -0500 (EST)
Date: Fri, 6 Nov 2026 11:33:07 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: free unused page table when setting a
 huge PMD fails
Message-ID: <au263-sEU03puJQm@thinkstation>
References: <20261105-khugepaged_set_pmd-v1-1-cb79ab117199@kernel.org>
 <aux9liPvdZgpKCpa@thinkstation>
 <aux-ZdKu97JHLY96@thinkstation>
 <c13cdd25-7d7b-4059-a22d-af0a48fabaac@kernel.org>
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
In-Reply-To: <c13cdd25-7d7b-4059-a22d-af0a48fabaac@kernel.org>

On Thu, Nov 05, 2026 at 05:40:39PM +0100, David Hildenbrand (Arm) wrote:
> On 11/5/26 14:04, Kiryl Shutsemau wrote:
> > On Thu, Nov 05, 2026 at 01:02:08PM +0000, Kiryl Shutsemau wrote:
> >> On Thu, Nov 05, 2026 at 01:16:05PM +0100, David Hildenbrand (Arm) wrote:
> >>> do_set_pmd() can allocate vmf.prealloc_pte on architectures that need a
> >>> deposited page table, such as PowerPC with the hash MMU. If the PMD is
> >>> no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
> >>> without consuming that table.
> >>>
> >>> Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
> >>> userfaultfd operation can install a PTE table before taking the folio
> >>> lock. If that races with set_huge_pmd(), the unused preallocated table
> >>> is lost when its local vm_fault goes out of scope.
> >>>
> >>> Free vmf.prealloc_pte on failure, as do_fault() already does. Successful
> >>> PMD installation consumes the table and clears the pointer.
> >>>
> >>> Having to do this cleanup outside of do_set_pmd() is rather nasty, but
> >>> other callers depend on it already having been allocated. This needs a
> >>> cleanup at some point.
> >>
> >> I hate this being outside of do_set_pmd().
> >>
> >> What about making do_set_pmd() freeing ->prealloc_pte if it was
> >> allocated inside? Nothing changes for caller.
> >  
> > Or if we want to keep in set_huge_pmd() then set_huge_pmd() has to
> > allocate it too. At least, it makes some sense.
> 
> It's all rather nasty.
> 
> I thought the callers depend on it, but if we just free in the function
> it will behave the same way independent of arch_needs_pgtable_deposit(),
> so that makes sense.
> 
> From 4e8d0a928f0b21e0583dac9234fb1821f3c973b2 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Wed, 4 Nov 2026 20:56:37 +0100
> Subject: [PATCH] mm: free unused page table allocated by do_set_pmd()
> 
> do_set_pmd() can allocate vmf->prealloc_pte on architectures that need a
> deposited page table, such as PowerPC with the hash MMU. If the PMD is
> no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
> without consuming that table.
> 
> Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
> userfaultfd operation can install a PTE table before taking the folio
> lock. If that races with set_huge_pmd(), the unused preallocated table
> is lost when its local vm_fault goes out of scope.
> 
> Track whether do_set_pmd() allocated the table and free it after dropping
> the PMD lock if it was not consumed. Preserve any preallocated table
> supplied by the caller for PTE fallback. Successful PMD installation
> consumes the table and clears the pointer.
> 
> Returning without a preallocated table matches the existing behavior on
> architectures that do not need a deposited table. All callers
> already handle that case.
> 
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
