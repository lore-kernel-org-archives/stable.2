Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560340;
	b=iCrD/QigXLywApmK7RBn2YYsxTsvkpy9DoU1mprLGGz30vmefDgm2b5h8E1OgNiHprLr
	 o6Gg63yTrIQ578xlC0xkwg7AVZ60/Nv7815rglXK2BetcXOxsBNZOMbuF0UjTtF+LXuwl
	 SUVMSl9eIzb9PaYc0VmkP7fA6+AMaTFa/5J8GdVzacbSwbbrL0G5cOD68TdAzcL1IBUjM
	 Lh6X8quPrnVvHAQltLJaSJ0/6EP8my9XaPC/i6p6MJoFdVpSA7zOzW33muN+OXa9xZ++p
	 5/Je0eWcklUMUPsUJ7YHv1cXe4v5WvUttHqvQ1yNoZCKpH4ieh50mDWHJLDLTV73HRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560340;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YF7NHY1fVlGveMHNsJnnjtGJ3+1XgRTTULcBOP2fUbI=;
	b=AZG+DMFY+Vd5lLKHGrn0vLm/yQsiMbArfrUXNvfSlagp8lMkMlNA1hgwPGEdBDXRQE0t
	 WexZSyYygIdiRVaWIhOn6aknCvarg/b9r/UJWa8GLLAW4CjacqmM6Ak0nLKne8+t2G8sd
	 0Jy/63zYCRNGUqQaq1+9UryPI/8g6o2LWoHGihr4gi/OK+yf7PV/dCLcSy37hmJthzYWt
	 XIV+J29ixkrW85TCVZhW//ubcoInt1XHh6q9ZxbYXazjpvwxLt1yMijEd0QWfN4Ra4ozl
	 yY0MAem6CCKa2SvElzLr4EJnE402UrTLGuDwEkYHjfmUfZC65s+nsumb7hAk8CUbnxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+Sj1rnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597E606A321;
	Fri, 13 Nov 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+Sj1rnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA721F000C4;
	Fri, 13 Nov 2026 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560339;
	bh=YF7NHY1fVlGveMHNsJnnjtGJ3+1XgRTTULcBOP2fUbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B+Sj1rnLIABT2rcMAHDb8ZnEfd0jTex4c1qrfj0CSRk0gqZnxgNlbeKj4GqmwtC9I
	 o8Xe/mfzfwZupSsAirIa5j4T99BWCeooiaGkcPxrha+PA2hMxNFQo1B5qgiclciRvJ
	 H/0QS47NbbvNelQKUZaLYxLikkesF1eucTGQ3XHglrVcE3sGxrTRW1h3QpwV9v3R4O
	 YauwalFMafdrHEV4zgip1oDQUDuo7PK7wcQaXMuie0pD5uDbIAM5svIaPto7fRy0mo
	 a6tlA/n7GVSd3t8dEWO4ZLrpdgPAAEY7SBncyX5yBNeewHKMKVczi4UYxnM0JXkXp/
	 ptXy6a57Iw/5w==
Message-ID: <01b19c1e-b87d-4996-acaa-cd5103f30edb@kernel.org>
Date: Fri, 13 Nov 2026 09:58:55 +0100
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
Subject: Re: [PATCH] mm/madvise: disallow guard region installation in
 uffd-armed VMAs
Content-Language: en-US
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jann Horn <jannh@google.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 stable@vger.kernel.org
References: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 18:38, Lorenzo Stoakes (ARM) wrote:
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

So IIUC this means the other order of operations (first guard regions, then
uffd) already prevents the two co-existing. Makes sense to prevent the same
in the order of uffd and then guard regions then.

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

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

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

