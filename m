Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004756;
	b=oa6pHNroBU5tJQbnj5g+HnhyZAL5jDNZPfXdSncbPyePLCwrP5c+MPUlFSjmL1puDe+F
	 XCv611NAxO9bC064KSNHrLvXIUzp3QHZ3oOPwZiyq7A48QUHoffydlcMfGa3AKq0r9rEH
	 ASqpBxez9FMiaZqNmGr7q7flQAl4vG0SAhDBnXPOys9f6VbElkWZA5DRB6bXxRlWTbjmt
	 /2nOsqn9Y/p+Vu2zCjdzMvUDiU1UtkKrha2lYWTXLsXZALWzocMHFx6uxZPbRlucYd9Af
	 6ox1lzTCOIlEEOQOWDYBO3irZB7wzLN/qnUiKp4MIPhencpnK9aXnc2zbEEmpMGmHxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004756;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gusY0KSUVKJcXw6Hq1PL8ajvvWfgIQrgRs/gFrGi9gA=;
	b=xV2FEy8PqCuEbRzEA/gPGAPbMbhwhTYBghw62u7t+c0uhy6BmaQH+U830cgjZvb8l/HP
	 A8YkIDjill8HnxNJWRtaC7BlnCO/MCZC0bqKe4CaM3LsK4SmXlR2iz0XtXvpku4ijDpx8
	 VPXXkGBmpnC+WaxXPdBEnKXNEHZlL3+k0SIWlDScx/QRIFoLnFrZ44D7gCt8W1fA56vX4
	 WGADsgjIgU82Uiu+szjftx7Y1pejdC7m9Q4KILs21+WGAc0KQlSFB3sjF9I9gi57jROLp
	 KAkX5xYLSuYIWJkQHZmPTdbQMxOtzyA5TPCjvrFchv3bm3KHLS2jQFfaAEWS8BDfm8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xNYCnS85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DB606A326;
	Fri,  6 Nov 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xNYCnS85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA091F0089F;
	Fri,  6 Nov 2026 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794004756;
	bh=gusY0KSUVKJcXw6Hq1PL8ajvvWfgIQrgRs/gFrGi9gA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xNYCnS85enGxqL0orgxtArZoKCY5STlQNAhTy563XuE3RJgdU4JNFllcCADOnxuIY
	 PRk4mq1utmrnYWLqkJwBzSijnliR4rjbFetNmdtJwT4DWUp4ple6ih0LYBA3R9Y7qC
	 S3Rjwu5qLxnwrJxgOmqm2d9NLqtQtjyiX4auMD9E=
Date: Fri, 6 Nov 2026 14:39:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: mt4022@columbia.edu
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Kiryl Shutsemau
 <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 tz2294@columbia.edu, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
Message-Id: <20261106143914.16a42b8cdf7436d045b85aa6@linux-foundation.org>
In-Reply-To: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Nov 2026 11:09:50 -0500 Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org> wrote:

> From: Mani Tofigh <mt4022@columbia.edu>
> 
> memory_failure() checks under hugetlb_lock that the page isn't part of
> a hugetlb folio and sets PG_hwpoison only after dropping the lock.  The
> page can become a tail page of a new hugetlb folio in the meantime.
> With hugetlb_free_vmemmap=on its struct page then lives in the tail
> page that all such folios in the zone share, so the flag lands on tail
> pages of every one of them:
> 
>   Task A (memory_failure)              Task B (nr_hugepages write)
>   get_huge_page_for_hwpoison()
>     /* P not hugetlb */
>                                        alloc_fresh_hugetlb_folio()
>                                          /* P becomes a tail page */
>                                          hugetlb_vmemmap_optimize_folio()
>                                            /* P's struct page now in
>                                               the shared tail page */
>   TestSetPageHWPoison(P)
> 
> The error on P itself is ignored, while healthy pages of other folios
> stay marked and are never reused once their folio is freed.  After
> freeing the pool, /proc/kpageflags shows them as hwpoisoned.
> 
> This is the allocation side of the race that commit 32c877191e02
> ("hugetlb: do not clear hugetlb dtor until allocating vmemmap") fixed
> for freeing.
> 
> Set the hugetlb flag of a new folio under hugetlb_lock and set
> PG_hwpoison of a non-hugetlb page inside the locked check, so that the
> vmemmap can't be optimized in between.  The retry path clears it under
> the same lock, unless the page has become part of a hugetlb folio in
> the meantime and its struct page isn't in the first vmemmap page of the
> folio, which HVO doesn't share.  The retry then knows the flag is its
> own.  With the fix, no healthy page gets marked anymore.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 35s.

Thanks.

So as I understand it, if a single 4k page turns bad at just the right
time, we can mark a lot of healthy 4k pages as bad (hence lost until
reboot) while the bad 4k page remains in use?  But that race is very
unlikely?

> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> Cc: stable@vger.kernel.org

I'm hoping we don't need to backport, because the race is so unlikely,
the consequences aren't world-ending and the backporting story is
messy.

But I don't think I'll get my hope, because the consequences of this
race are worse in older kernels:

In 6.6.162 HVO maps shared tail metadata read-only, so the misplaced
PG_hwpoison write can cause an oops.

Also in 6.6.162 memory_failure() still has a ClearPageHWPoison(p) in
its PageCompound retry block so with HVO enabled and
CONFIG_TRANSPARENT_HUGEPAGE=n, its compound retry can still reach
read-only tail metadata.

Miaohe, wdyt?
