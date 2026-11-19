Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081417;
	b=4ucrTFud3wOS8L909NPklCZzTIbr17fCRLKLPcfWnzY1xAXa/htxyJ8YYBA9LSC7ewAj
	 OfyDJUhZHVQUsGyyuA4CaT5YLVlwWsc4T9SBCJFOofqxAn4+PCYf/jJwAYqlVkAgnt7r0
	 +4o0Fy60poknEjMpdzH8aITmybesJbsci3oXxslCvBVqkQgTX6iFWh2c5AfV0zb4xmsZ2
	 Kk1M/CjKRN+keDqmtKWXddaefY2dSjmnqaqt7MdfSqxHkb4lieoRxIHNMm3LYsIw1EjWG
	 lk9qoOlwUwu8S5p8Kiowl2vt+SR8FaK5XhbFNPYh7vT39KSVS1MN8SynAkBuZHvYimw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081417;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6Ftv5ohlhONZ/yV4mvsRDwnVdXpNIjyErplRrdF7F4s=;
	b=jL4YNsaOhNcH2Ht1NNDT4+w6yJLmi9tpsv1OWl3sm3VaORJpi/ovPHKn5S3cvCIA/I8j
	 iDaAOHJMC0vAWcPzqCHveuO09Fwu9IRxH5RuSP3DXlb8T4oNiJmDpWWYBTE3YSfShT4zQ
	 KWQpi/02rEmuDEew00mB3Mn5FySFVNnjmiHP1dne2fanTIRf4vW2EsAiNLXbVtczCUJtT
	 mCKT0c4UF7FsdDes6fFljc3dPUbqIxT0BGcgBdVY2Hq1WEeah3ooKtdxHI3dElfZ/NGQO
	 Fmx5sFC2D0fGdsIS63awBQ24K3sJtKV/FFhJcv35kCCtT7NbaVqR6a42TcslC0022/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z+JKqeSH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40749606A32A;
	Thu, 19 Nov 2026 09:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40749606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z+JKqeSH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8611B1575;
	Thu, 19 Nov 2026 01:43:33 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019EE3F882;
	Thu, 19 Nov 2026 01:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795081416; bh=sSQ2QhhUSs69+oHeCq7tqoe+5F8pEeWToCcaQfTg/Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+JKqeSH7mlb/yir8Memf0lOOD1DP5+CGVbkXwtHuiXgfIezHWEuwjY4iypaGvt49
	 3XwCieSPiNCi9PzFQQgdvIfUJXJPOzNDHEEdh5RsY+rrFOa0/C886+Wfa5lnZjkHTt
	 8y6mWryJ6LKvgsg918NaCBLgfmR/QV4ctgzWe44E=
Date: Thu, 19 Nov 2026 09:43:31 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: harrison@crosse.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/gup: make mlock() and MAP_POPULATE handle
 VM_FAULT_RETRY properly
Message-ID: <av7EwyB0V8DFqPzG@e129823.arm.com>
References: <20261118-mmpop-populate-v1-0-9c561d178d11@crosse.dev>
 <20261118-mmpop-populate-v1-1-9c561d178d11@crosse.dev>
 <e32482de-295a-4e26-b6ae-5b8b58f8b98c@kernel.org>
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
In-Reply-To: <e32482de-295a-4e26-b6ae-5b8b58f8b98c@kernel.org>

On Thu, Nov 19, 2026 at 12:25:31AM +0100, David Hildenbrand (Arm) wrote:
> On 11/18/26 22:56, Harrison Crosse via B4 Relay wrote:
> > From: Harrison Crosse <harrison@crosse.dev>
> > 
> > If every read of a page of a file mapping fails, mmap(MAP_POPULATE)
> > and mlock() of that mapping do not return: the task spins in
> > __mm_populate(), submitting a new read of the page on each iteration,
> > until it gets a fatal signal. Touching the same page gets SIGBUS, and
> > madvise(MADV_POPULATE_READ) fails with -EFAULT.
> > 
> > The first fault on the page reaches filemap_fault() with
> > FAULT_FLAG_ALLOW_RETRY and without FAULT_FLAG_TRIED. filemap_fault()
> > releases the mmap_lock to read the page and, because it released the
> > lock, returns VM_FAULT_RETRY before it looks at the result of the read.
> > It cannot report the error then: a fault that has released the lock
> > returns VM_FAULT_RETRY or VM_FAULT_COMPLETED, and neither carries an
> > error. faultin_page() turns VM_FAULT_RETRY into -EBUSY, so
> > __get_user_pages() stops at that page without an error, and
> > __mm_populate() calls populate_vma_page_range() again at that address,
> > again without FOLL_TRIED. The page fault handlers and
> > __get_user_pages_locked() retry with FAULT_FLAG_TRIED instead, and on
> > that attempt filemap_fault() reads the page with the lock held and
> > returns VM_FAULT_SIGBUS if the read fails.
> > 
> > Commit 631426ba1d45 ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handle
> > VM_FAULT_RETRY properly") fixed the same loop for MADV_POPULATE_* by
> > calling __get_user_pages_locked(). That does not fit here:
> > __get_user_pages_locked() retakes the mmap_lock itself and carries on
> > with the GUP flags it was given, while populate_vma_page_range()
> > derives those flags from the VMA that __mm_populate() looks up again,
> > and may skip, after each unlock. Retrying with a NULL locked instead
> > would drop FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_KILLABLE, so a
> > userfaultfd range would fail rather than wait, and folio lock waits
> > would not be killable.
> > 
> > Instead, have __mm_populate() remember the address of the page whose
> > fault released the mmap_lock. When the next iteration starts at that
> > address, fault in that page alone with FOLL_TRIED, as
> > __get_user_pages_locked() does, then continue with the rest of the
> > range as before. The retry reads the page with the mmap_lock held, as
> > filemap_fault() did for a page that was not uptodate before v5.1, and
> > as the other GUP retries do. With a persistent read error the retry
> > fails with -EFAULT: mlock() returns -ENOMEM
> > (__mlock_posix_error_return() maps -EFAULT to it), and MAP_POPULATE,
> > which ignores populate errors, returns the mapping. A fatal signal
> > still ends the loop, with -EINTR from __get_user_pages() or, if it
> > interrupts the FOLL_TRIED read, with -EFAULT. The other callers of
> > populate_vma_page_range() pass a NULL locked, so they cannot get
> > VM_FAULT_RETRY and are unchanged.
> > 
> > Reproduced with ext4 on dm-linear over a loop device, with the eight
> > sectors of one page of a file mapped to the dm "error" target, on arm64
> > (Debian's 6.12.116 and v7.4-rc3) and x86_64 (v7.4-rc3): mmap(MAP_POPULATE)
> > and mlock() of the file were still running in the kernel after 5 seconds
> > and ended when sent SIGKILL. On 6.12.116, the block layer tracepoints
> > showed about 280,000 bios a second being submitted and failed.
> > 
> > The analysis, the patch and this changelog were prepared with the help
> > of an AI coding assistant (Claude).
> 
> Yes, that's rather obvious from looking at it, thanks for documenting that :)
> 
> Thanks for the report!
> 
> [...]
> 
> > +		 *
> > +		 * filemap_fault() reports a read error only when
> > +		 * FAULT_FLAG_TRIED is set: on a first attempt it releases the
> > +		 * mmap_lock for the read and returns VM_FAULT_RETRY whatever
> > +		 * the result. So when the last call released the lock at
> > +		 * nstart, retry that page with FOLL_TRIED, and only that page,
> > +		 * so that later pages still get a first attempt that releases
> > +		 * the lock for the read. Compare the address because nstart
> > +		 * moves past that page if it is no longer mapped, or its VMA
> > +		 * is skipped, when the lock is retaken.
> >  		 */
> > -		ret = populate_vma_page_range(vma, nstart, nend, &locked);
> > +		tried = retry && nstart == retry_addr;
> > +		ret = __populate_vma_page_range(vma, nstart,
> > +						tried ? nstart + PAGE_SIZE : nend,
> > +						&locked, tried);
> 
> Yeah, that's quite the ugly code. Let me take care of this (or find someone more
> familiar with that code that can help).
> 
> @Yeoreum, do you have some spare cycles?

Yeap. I'll take a look soon!

-- 
Sincerely,
Yeoreum Yun
