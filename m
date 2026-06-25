Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC42ECE91;
	Thu, 25 Jun 2026 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393138; cv=none; b=loQ3w9AIxLBNzkQQzzajDD3CsFMVUiMNMvgdfkY2TDEjgHtsHqCUT14ddWsdGM6vj+fUGDoVWGCQLw32pu9hu8YHkeg7ZOD+BADDrYUAWsK8EB/XzSdiMT6ZOUG/FE1pWmFVr8fZtTtGhf4b19P6P95YkrdCtdtLjfi+MW1LI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393138; c=relaxed/simple;
	bh=KaJcGnJ6r8JBco2fM1Z0ek6EnjCHDlGc6nEznvNC2CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlngS6gvv5SgMWsPXvATGMOSMK7NyIX3+jkJW1Odd98PRWJ/rvw10eAa1HkCN6X3J93QUFAKSqBYiSqYegQ+dkbD04H6xkOrcz0JGg3E8WjTwcXNKMFkZzYEyeNnwAzcY/gI7BLB9ihCjpmpJ26HJ56yzMMD5FORu3VKWR1c58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTLDowH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTLDowH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402091F00A3A;
	Thu, 25 Jun 2026 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782393137;
	bh=KaJcGnJ6r8JBco2fM1Z0ek6EnjCHDlGc6nEznvNC2CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTLDowH5PeF4TSMdSHX04kELKtpk2BBEbgHYeRXXnckqD9mJLpoCmxZNT6fkvzv22
	 N8EdfCekYiMkfyoUBQPyChzQzuAKsiIwTG30lScYPSUol2+G1unZd6mSIs1kD5UvXd
	 6zlSbgHwWz7NYiH1ZwtfC2jV9+rjIk6Qc6quFegBJq5anXxsthlY9AwgiQeOTKx1uw
	 rIaEg5jCt85UwzkEnYQ6tcOXnFC9CTxzh1wJiVT1oI3i7LONqxXEJ2e5qDdosLSY0x
	 AcZYmfS/FP7RSOdxCpA5QMaaIv0n9WovpRhn4GZGNfIpUtjumsRbzWttpBeArzSfu+
	 X/6diao8kdIwA==
Date: Thu, 25 Jun 2026 14:12:09 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, david@kernel.org, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <aj0nl4001L9zMxFG@lucifer>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <20260624085756.6598-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624085756.6598-1-lance.yang@linux.dev>

On Wed, Jun 24, 2026 at 04:57:56PM +0800, Lance Yang wrote:
>
> On Wed, Jun 24, 2026 at 06:53:53AM +0000, Wei Yang wrote:
> >Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
> >device-private entries") introduced the concept of device-private
> >PMD entries, but did not correctly update the rmap walk code to
> >account for them.
> >
> >As a result, when page_vma_mapped_walk() encounters device-private
> >PMD entries, it takes no action other than to acquire the PMD lock
> >and exit.
> >
> >However this is highly problematic for two reasons - firstly,
> >device private entries possess a PFN so check_pmd() needs to be
> >called to ensure an overlapping PFN range.
> >
> >Secondly, and more importantly, if PVMW_MIGRATION is set the
> >caller assumes the returned entry is a migration entry, resulting
> >in memory corruption when the caller tries to interpret the device
> >private entry as such.
> >
> >In addition, commit 146287290023 ("mm/huge_memory: implement
> >device-private THP splitting") allowed device private PMDs to be
> >split like THP mappings, but again did not update this code path.
> >
> >As a result, we might race a PMD split prior to acquiring the PMD
> >lock.
> >
> >This patch addresses all of these issues by invoking check_pmd(),
> >ensuring PMVW_MIGRATION is not set and checks whether a split raced
> >us we do for PMD THP and migration entries.
> >
> >Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> >Cc: <stable@vger.kernel.org>
> >Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >Suggested-by: David Hildenbrand <david@kernel.org>
>
> Shouldn't we add
>
> Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
>
> as well?
>
> v4 mostly follows Lorenzo's comments, code bits included. Feels only fair.

Thanks Lance :)

I'm kinda indifferent about it really, I'm really keen to ensure people sending
patches get the credit for their work, so if I send a patch in reply as a
shorthand for 'I think this might work better', I don't expect/require any
credit at all, it's just sometimes a quicker way of responding!

But if Wei wants to add a S-b that's fine by me also! :)

Cheers, Lorenzo
