Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517159;
	b=3lQ0t9H1F+ADOOM0Hn1ZmJXLVlmnLjKCfF7m2jlvi2fCX/WZCR3V3BoUEx5jeWyMTOHb
	 By3OpwpUPHc4k5HeapMTYeeGB7gBL4W7u4bPWW4w0hzc+3WrtaT4/S6aon55ODJqaTGZV
	 Nkj+N/DAfkHXi57x3Dcyd3zrI9mcjjL2kV5Tf1ByYm/6tPkACsQemAjeod9jPp9Jaicc2
	 LBUpsMoHgoExaLNzdoZUjhdsdQCxFjhzQnk5cnX0g5qNH0EdGjOJIRouefGiO79if7d3Y
	 kS1zJx3Ct+Z5mivNtpK/9vUShg5zRXa2a3b5f6hk8KKjNkoKPWIsosstBGP6TCpcHiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517159;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=DWxW0v3Yp3gUIU8y20wR7hKoi5jJwchqtRdIOf3GtkQ=;
	b=jkS/CbZ2mxMJxMk03D9QY/W3h61ycZZykCAD8JfdH5JgBxuoHdcwOR8uNBqVdCwp0/8w
	 3JKPuZJMXyCwNqTkebLR7XOIS0phWQ8z8nkpdI3JBtbH+hY+WSmItRjXTgwiGGQ0q62vd
	 RTePpr3Rxkn2kqIYGnvgqo14d2gObtjuH0+aXARbU2uOKfZ5EhE6W4iqqOJGSQo2RguXv
	 5m808cWFKi8MXatmZHxfBCHgfwWhrIF7XTST1AiU2VRRvjhC34vih5d20YIRJanYC4QO3
	 8CtqS+o5D6jieGp3RZTOWWFM+s+WsxwGroDCXNnWrG0psvaG4NjJG/oQ29g2tphzq+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="O0f92Jl/";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79D606A31C;
	Thu, 12 Nov 2026 20:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC79D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O0f92Jl/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DWxW0v3Yp3gUIU8y20wR7hKoi5jJwchqtRdIOf3GtkQ=; b=O0f92Jl/Q7JNZC57lF2m123DO3
	ZdljTMVUMMcWHgd354KPoiCaWYtR04IXtmDeLHs6jL3Hdw3NkGid7JuqrfD86VbShMe5qKFqG93lM
	xPF0YfPpe6x7snQwKe93O4nUpuJQDwf4pXzje+EttCMdg12x3aOO8xmD5pspmuKCclG34iCVYOwQ+
	0v3xQyOPAZWqClKkdiqhJYvDJrZmPhbvDlbOH9pq1mAHshLNcKkV+ue/9dzolAZ3QZ1mlsXmhgQo9
	lc8z1ev5qYOT8qaSHOzu4YTatxSk1r8nfbEkVXuvy3sw9HSfRdDhFTHgzZAKIn4B1lYTKIlUsMdt1
	ywLEKeNA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRbt7-0000000B2ea-2awE;
	Thu, 12 Nov 2026 20:59:17 +0000
Date: Thu, 12 Nov 2026 15:59:10 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: disallow guard region installation in
 uffd-armed VMAs
Message-ID: <63skl724i2jss7itcq63fbojykh462s3voi6to52ze6v3unp35@kgakyccedf64>
References: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
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
In-Reply-To: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>

On 26/11/12 05:38PM, Lorenzo Stoakes (ARM) wrote:
> In order to establish guard regions, guard markers are installed in the
> page tables of a mapped VMA.
> 
> However, problems arise when one tries to combine this with registering a
> VMA for userfaultfd, as such operations may themselves need to install page
> table markers such as uffd-wp.
> 
> When this installation is attempted the guard marker prevents these markers
> being applied, which can lead to unexpected results (especially if the
> guard regions are later removed.)
> 
> This is especially problematic because guard region installation causes the
> regions to be zapped first, meaning that the removal of userfaultfd-tracked
> ranges will not be logged in this case.
> 
> Therefore, disallow this.
> 
> This makes sense as conceptually, guard regions mark a part of a VMA as
> effectively unmapped at the page table level, and removing the markers is
> like mapping the VMA again, over which operation uffd markers would in any
> case be lost.
> 
> Only check for this on installation, as a VMA can be registered for
> userfaultfd after guard regions are established.
> 
> In this case, the guard regions cannot have new markers installed, and no
> faults can occur in the guard regions, until they are removed, at which
> point everything should function normally.
> 
> A survey of open source users indicates nobody is relying on installing
> guard regions in uffd-armed VMAs. Software including glibc, android,
> tcmalloc and CRIU were checked.
> 
> Fix the selftest to reflect the change.
> 
> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
> Reported-by: Tal Zussman <tz2294@columbia.edu>
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu/
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu/
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu/
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>

> ---
>  mm/madvise.c                               |  4 ++++
>  tools/testing/selftests/mm/guard-regions.c | 12 ++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0214efd2a014..268731e90f12 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1156,6 +1156,10 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>  		return -EINVAL;
>  
> +	/* Guard markers are incompatible with UFFD markers. */
> +	if (userfaultfd_armed(vma))
> +		return -EINVAL;
> +
>  	/*
>  	 * Set atomically under read lock. All pertinent readers will need to
>  	 * acquire an mmap/VMA write lock to read it. All remaining readers may
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 02f69244f9a4..97da54dcf3a4 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -1476,7 +1476,7 @@ TEST_F(guard_regions, cold_pageout)
>  	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
>  }
>  
> -/* Ensure that guard pages do not break userfaultd. */
> +/* Ensure that guard regions cannot be installed in uffd-armed VMAs. */
>  TEST_F(guard_regions, uffd)
>  {
>  	const unsigned long page_size = self->page_size;
> @@ -1526,10 +1526,15 @@ TEST_F(guard_regions, uffd)
>  	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
>  	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
>  
> -	/* Guard the range. This should not trigger the uffd. */
> +	/* Now try to guard, should fail with EINVAL. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Once unregistered, we should be able to guard the range. */
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
>  	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
>  
> -	/* The guarding should behave as usual with no uffd intervention. */
> +	/* The guarding should behave as usual. */
>  	for (i = 0; i < 10; i++) {
>  		char *curr = &ptr[i * page_size];
>  
> @@ -1537,7 +1542,6 @@ TEST_F(guard_regions, uffd)
>  	}
>  
>  	/* Cleanup. */
> -	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
>  	close(uffd);
>  	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
>  }
> 
> ---
> base-commit: 4318887a3efa4c53d6f083ccfd7105b809a3ac65
> change-id: 20261112-disallow-uffd-guard-install-a5294129ad7b
> 
> Cheers,
> -- 
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
