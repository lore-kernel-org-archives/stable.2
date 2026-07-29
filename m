Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726B2CCB9;
	Wed, 29 Jul 2026 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312928; cv=none; b=i5//C2CFgyVEdK8y03wA+Gu8qdGj1SEWMjQ9CCjDFJUquSzXJO2kdHFsAwmTU7oAUqPg3BNi9e9tkW8DErpiPsZ0euNRvMWbg3M0TVzuk5AAgEKy1UJ3Wchga9KjTl6jRkRX/0mhv3bVny+J9rHhGVdgt6jR/VpeOm2y0X6PXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312928; c=relaxed/simple;
	bh=3XIP2yu70drfefACMoCE5CbO7PlTPuDv9WLOEtpk9bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbcfY4rjol+YcmsEx50e1PkBq2/RT2fwQjr461jjJqL79SrgH437FFpTIpi0NNgyY3sUsuonWWnQ3vsdjtWhDNhBofshCFIWqSYlUMiRpf8FYB/lZ2l94c3MI0c1EWwcMpG7AMYvcIGgZNI9fekN80yerK6v5DAQ6qvVX8Z9OB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfvD3uwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfvD3uwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715E31F000E9;
	Wed, 29 Jul 2026 08:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785312926;
	bh=3XIP2yu70drfefACMoCE5CbO7PlTPuDv9WLOEtpk9bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SfvD3uwxSqDewmJgHYlh9uh4Q6cetVYI0ulIbG+Bh81LWKPxJdqA1cDVhiuzPZRQk
	 aCMUvsGtw3wg8cAIcYTcOU4oUrLFRlSlBNgzoMOzqN6hDYxLB6JQoanDJySNc/8XMb
	 k0m3USzDhQIh0vG9W3asTyq0UKrH5J6kja3dMZguzhhmc1rrkDunNEj0ZfPA5itbjs
	 NtUHqFacqVkWRR1EayQqwHboYx2ERqLzRa1MOHkjMZZqLg+dL0h5Utr5/KpW6OGck7
	 tBzH6Y6ZclXubhFHI298wrrn7o0ea+aChF1dONHJiMyrI0pb5ju/hO+3MDSdDChE3r
	 tZiXm7dc5Ixcw==
Date: Wed, 29 Jul 2026 09:15:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hengbin Zhang <uqbarz@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes 0/2] mm/huge_memory: fix huge_zero_pfn race
Message-ID: <amm2GOFablLbBC4H@lucifer>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <f0e39f91-8dd1-4d9d-8d4e-da5d608a7148@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e39f91-8dd1-4d9d-8d4e-da5d608a7148@kernel.org>

On Tue, Jul 28, 2026 at 09:02:57PM +0200, David Hildenbrand (Arm) wrote:
> On 7/28/26 14:05, Lorenzo Stoakes (ARM) wrote:
> > There is a subtle race in the reference-counted huge_zero_folio
> > implementation.
> >
> > The fast path atomic logic fails to account for the fact that the
> > shrinker (which drops the final huge_zero_refcount pin) can overwrite
> > huge_zero_pfn with the ~0UL sentinel value in shrink_huge_zero_folio_scan()
> > after a racing get_huge_zero_folio() installed a valid value there.
> >
> > This results in huge_zero_folio being correctly set but huge_zero_pfn being
> > set incorrectly and thus is_huge_zero_pfn() and consequently
> > is_huge_zero_pmd() will misidentify the huge zero folio as being an
> > ordinary THP folio.
> >
> > This can result in the huge zero folio being split and otherwise treated
> > incorrectly.
> >
> > The solution to this is very subtle as there is an atomic fast path, and
> > thus ordering in weakly ordered architectures has to be treated very
> > carefully.
> >
> > As a result, this series first reworks the
> > CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic so it is separated from the
> > refcounted code in order to make the subsequent fix reasonably
> > understandable.
>
> For at least somewhat easier backports, can we reverse the order?

Since I'm going to be doing the backports can we keep it the same? :)

>
> The spinlock+proper ordering should be possible without #1, or am I missing
> something important?

It's possible but this way it's a lot easier to deal with and I'd rather keep
things consistent for stable kernels.

I can figure things out for < persistent huge stable kernels. It'll be manual
work either way.

(It'd be good to get some review on the actual changes also :)

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
