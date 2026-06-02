Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48273314D9;
	Tue,  2 Jun 2026 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374083; cv=none; b=srDYFG9KaXHpxzrAeuQWs9ddUS7qEA2nt6ygr6e1P4c4gDB2yuHlivOBEJH65lV0M7/mzzTOOj8qUZc7otHGPjQ0LKW2WmSiNZwG0PANfjuxRYzfvIqSSiU3GaF83EBbEUS3p9E+wxamg9yI8IpT3cTsfMcP8gaCJ/yQNX754yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374083; c=relaxed/simple;
	bh=H7kv1oVIGNpG97wf67N8yQnZ3vaX7YWckS62O7uo4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNMKEb9osU+xq6H5+bL79qCk+M9Y+kkZUlH+3njGLu8+HvdxW/DCCr4pkfY8gcIQ3wprlXkoMExYWB2eI/snsmHOj5LkyDnywWBO5yzwWbcxOC3222U65r1ykH90MgGgrcO78NhnKU6hyAxG2/ubE2fW4S16EjiTa5YDgbiSQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpqk5/rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpqk5/rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4351F00893;
	Tue,  2 Jun 2026 04:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780374082;
	bh=FG6uaynttx+7wL75om2XoMHvK6wM5vAOEXDW7jnm7sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tpqk5/rqismZ1mVczwfr+hex8navjFRtNT0GQdQ+HL8MmufzKlsGp2JNqYb1PgVLg
	 tpeRX80+x+GwnujKarHY8k97sZSSJ5Y29Oka3hY/ApvhdWUUTcnYvDQI8ylGoYkCJ7
	 7G7M7+Yv627VnZqwvJJbpuX7fdkb5mj+N/MkoY2DxHlxHLm6hRcy1uVRBQwQ71TC33
	 DzEOH/c5EPU7OfNuGfMAaQ3cK++DKIVhYjkjbVxXEMRnR7a5v/6mDWphe9rLV1Iqoi
	 4uxzTGNruCd1kecpId37rMNDYPtUfdn61JqBbDPv+2SzQ1PkUdnbVMentg7sInUfbt
	 BeouJ7KXMBo6A==
Date: Tue, 2 Jun 2026 06:21:14 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org,
	jgg@ziepe.ca, leon@kernel.org, david@kernel.org, shuah@kernel.org,
	vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	balbirs@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: do not warn on seeing non-migration
 pmd entry
Message-ID: <ah5aOoroOs2FpLhr@localhost.localdomain>
References: <20260529111704.1078346-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529111704.1078346-1-dev.jain@arm.com>

On Fri, May 29, 2026 at 11:17:03AM +0000, Dev Jain wrote:
> pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
> entry. This became false once device-private entries at the PMD level were
> added.
> 
> One can hit the warning by patching hmm-tests.c with the following:
> 
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index e1c8a679a4cf3..7f0a3384f3c5f 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -209,6 +209,37 @@ static int hmm_dmirror_cmd(int fd,
>  	return 0;
>  }
> 
> +static int hmm_read_self_pagemap(void *addr, unsigned long npages,
> +				 unsigned long page_size)
> +{
> +	const size_t entry_size = sizeof(uint64_t);
> +	const off_t offset = ((uintptr_t)addr / page_size) * entry_size;
> +	uint64_t *entries;
> +	ssize_t nread;
> +	int fd;
> +
> +	entries = malloc(npages * entry_size);
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	fd = open("/proc/self/pagemap", O_RDONLY);
> +	if (fd < 0) {
> +		free(entries);
> +		return -errno;
> +	}
> +
> +	nread = pread(fd, entries, npages * entry_size, offset);
> +	close(fd);
> +	free(entries);
> +
> +	if (nread < 0)
> +		return -errno;
> +	if ((size_t)nread != npages * entry_size)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static void hmm_buffer_free(struct hmm_buffer *buffer)
>  {
>  	if (buffer == NULL)
> @@ -2314,6 +2345,10 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	ASSERT_EQ(ret, 0);
>  	ASSERT_EQ(buffer->cpages, npages);
> 
> +	/* Exercise pagemap on a PMD device-private entry. */
> +	ret = hmm_read_self_pagemap(buffer->ptr, npages, self->page_size);
> +	ASSERT_EQ(ret, 0);
> +
>  	/* Check what the device read. */
>  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
>  		ASSERT_EQ(ptr[i], i);
> 
> 
> Therefore, remove the stale migration-only assertion.
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM,

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>



-- 
Oscar Salvador
SUSE Labs
