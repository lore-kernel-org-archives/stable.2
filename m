Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044341;
	b=W9D3vDiPgSYLbJFZhpAN02Npp8UrGzeaLiXocr2aPA60rhRFGEBRVLFxPgV22OJFV6Yb
	 f661M5Xq1+6MpIxN29KmPIxzNjofi+kZfg4jk4rdCKQBSvjTCrg7l27yvdIh36M1vXY4j
	 DprsprLkWcRjb4NG08pLK7Wdh5FXv/lc9Cjlhk1Rr3LzM8jSgNaFaSlThMr47gyJJz0Fo
	 hODod15HZvxv8/i1R/5U8cw2QCfo0sbAe4Sq/xGk/72V+HVCuQsp4ZtoLZmncsjGTXSy+
	 JFZSHd1zkm7xKBDpWuKfku78tCw9zgyJMz5K/df7HgAAUeRRM1PHOgjJqQ2FPm1Xrwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044341;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WOYda5e3A5KKvpqZuIuLhWTICxZNXazCCYpYFCxSe84=;
	b=x6guCawJxYup4JW0DOdFXH9ZQNcQMb5n9zUTGYEi6cH2EjTJNCn89ea7d8e276gCh9aZ
	 Kn5QXQj+wEXzosl4h2Xz13L6Kf7dCUVGtZ5PUaOCIMzHNDeSFMraONZPJen8aPS+t0Zbp
	 4tvJjYlpusXYnZpC8hUFqH+/rnXykAhTwskMxNA+ic8wEccoOcUMaaM0iO5+RNik6KGZQ
	 BuoLhvh5pclnnN2u8vbBHF6C/+heTDNJgB6/axXXKlC72kYrKU5gSh8hXmjnwBA8r0KrV
	 jcNYDGtTLL/r0zhRWe7C3bO1h0xltY+nPVQ9jbFEQWC4t3/0GkmOuDZc62Uq3G2X5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSiYbTJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58AB606A31C;
	Wed, 18 Nov 2026 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSiYbTJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8531F000C5;
	Wed, 18 Nov 2026 23:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044341;
	bh=WOYda5e3A5KKvpqZuIuLhWTICxZNXazCCYpYFCxSe84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XSiYbTJCEe0e0ylf9UWuraISb3AzIJ/LS5jmctUicP9oaWDAPyxWCDQpGH4Q56k36
	 LUt2l4uzZW4xTSJazzR4gkHzmM/mRn9+jBpqa6NpGYlOiXjtuwLuEdAtz3hRywGIRB
	 dmlm6xW7btWMGgHuASEZ1ysowr9I4l/fq7K4zqMHbfyxhDFr7RmNVZwLtPRJ0IlcDf
	 wFzjz03CiHoQWgXj92mjkmmCOt2RJOVy1AvDPcJPAFs7pJNiL9v5fqPOCdBU5nW09Q
	 9BtW4/+FXhjaLNy2ISv3IaEF5FRVT1549fsrDebR9exH9XWhND7vbuoQ4vBaJq2gGw
	 so5R22LhA3YSA==
Message-ID: <e32482de-295a-4e26-b6ae-5b8b58f8b98c@kernel.org>
Date: Thu, 19 Nov 2026 00:25:31 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/gup: make mlock() and MAP_POPULATE handle
 VM_FAULT_RETRY properly
To: harrison@crosse.dev, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
 stable@vger.kernel.org
References: <20261118-mmpop-populate-v1-0-9c561d178d11@crosse.dev>
 <20261118-mmpop-populate-v1-1-9c561d178d11@crosse.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261118-mmpop-populate-v1-1-9c561d178d11@crosse.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 22:56, Harrison Crosse via B4 Relay wrote:
> From: Harrison Crosse <harrison@crosse.dev>
> 
> If every read of a page of a file mapping fails, mmap(MAP_POPULATE)
> and mlock() of that mapping do not return: the task spins in
> __mm_populate(), submitting a new read of the page on each iteration,
> until it gets a fatal signal. Touching the same page gets SIGBUS, and
> madvise(MADV_POPULATE_READ) fails with -EFAULT.
> 
> The first fault on the page reaches filemap_fault() with
> FAULT_FLAG_ALLOW_RETRY and without FAULT_FLAG_TRIED. filemap_fault()
> releases the mmap_lock to read the page and, because it released the
> lock, returns VM_FAULT_RETRY before it looks at the result of the read.
> It cannot report the error then: a fault that has released the lock
> returns VM_FAULT_RETRY or VM_FAULT_COMPLETED, and neither carries an
> error. faultin_page() turns VM_FAULT_RETRY into -EBUSY, so
> __get_user_pages() stops at that page without an error, and
> __mm_populate() calls populate_vma_page_range() again at that address,
> again without FOLL_TRIED. The page fault handlers and
> __get_user_pages_locked() retry with FAULT_FLAG_TRIED instead, and on
> that attempt filemap_fault() reads the page with the lock held and
> returns VM_FAULT_SIGBUS if the read fails.
> 
> Commit 631426ba1d45 ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handle
> VM_FAULT_RETRY properly") fixed the same loop for MADV_POPULATE_* by
> calling __get_user_pages_locked(). That does not fit here:
> __get_user_pages_locked() retakes the mmap_lock itself and carries on
> with the GUP flags it was given, while populate_vma_page_range()
> derives those flags from the VMA that __mm_populate() looks up again,
> and may skip, after each unlock. Retrying with a NULL locked instead
> would drop FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_KILLABLE, so a
> userfaultfd range would fail rather than wait, and folio lock waits
> would not be killable.
> 
> Instead, have __mm_populate() remember the address of the page whose
> fault released the mmap_lock. When the next iteration starts at that
> address, fault in that page alone with FOLL_TRIED, as
> __get_user_pages_locked() does, then continue with the rest of the
> range as before. The retry reads the page with the mmap_lock held, as
> filemap_fault() did for a page that was not uptodate before v5.1, and
> as the other GUP retries do. With a persistent read error the retry
> fails with -EFAULT: mlock() returns -ENOMEM
> (__mlock_posix_error_return() maps -EFAULT to it), and MAP_POPULATE,
> which ignores populate errors, returns the mapping. A fatal signal
> still ends the loop, with -EINTR from __get_user_pages() or, if it
> interrupts the FOLL_TRIED read, with -EFAULT. The other callers of
> populate_vma_page_range() pass a NULL locked, so they cannot get
> VM_FAULT_RETRY and are unchanged.
> 
> Reproduced with ext4 on dm-linear over a loop device, with the eight
> sectors of one page of a file mapped to the dm "error" target, on arm64
> (Debian's 6.12.116 and v7.4-rc3) and x86_64 (v7.4-rc3): mmap(MAP_POPULATE)
> and mlock() of the file were still running in the kernel after 5 seconds
> and ended when sent SIGKILL. On 6.12.116, the block layer tracepoints
> showed about 280,000 bios a second being submitted and failed.
> 
> The analysis, the patch and this changelog were prepared with the help
> of an AI coding assistant (Claude).

Yes, that's rather obvious from looking at it, thanks for documenting that :)

Thanks for the report!

[...]

> +		 *
> +		 * filemap_fault() reports a read error only when
> +		 * FAULT_FLAG_TRIED is set: on a first attempt it releases the
> +		 * mmap_lock for the read and returns VM_FAULT_RETRY whatever
> +		 * the result. So when the last call released the lock at
> +		 * nstart, retry that page with FOLL_TRIED, and only that page,
> +		 * so that later pages still get a first attempt that releases
> +		 * the lock for the read. Compare the address because nstart
> +		 * moves past that page if it is no longer mapped, or its VMA
> +		 * is skipped, when the lock is retaken.
>  		 */
> -		ret = populate_vma_page_range(vma, nstart, nend, &locked);
> +		tried = retry && nstart == retry_addr;
> +		ret = __populate_vma_page_range(vma, nstart,
> +						tried ? nstart + PAGE_SIZE : nend,
> +						&locked, tried);

Yeah, that's quite the ugly code. Let me take care of this (or find someone more
familiar with that code that can help).

@Yeoreum, do you have some spare cycles?


-- 
Cheers,

David
