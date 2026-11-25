Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616108;
	b=c/AHnHnHp4fbTiFYey9ShYgzKwKFAnI/UgnQOe/KesczsxF8/do7EnaDYOYRNfHw8k9U
	 Y6r05/YAqUqJsCn3zl4jqsYqMJ7+e8Ncf+ycOm4aWyPJ8Fd359hUDfgE9z1sj/1n5gsAv
	 9CK0NeXY1WtG0dYluLfSy/eE71R9GHD7JAMRrdgzkNFDI5izoWUov4RbJluLHFzghd1QJ
	 VevdXiI1CyyGfaRaqWxArDJBQ45EEVuMZ5ye/8O3bgYdceUeoLjoktkqhv24NDVsgKkqM
	 oVmS9yjFTvkKNA0RRtr3tYjuEemviuyOchm1JENn3XWP1V7jX9R95015bwhubkHpK7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616108;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=d/+qYvyLZHeG1kOykHPXzeEZDLRzhRfnNwJtUaDjUd4=;
	b=sxrR8CBzK2RlJDjrcqSYR5HlAtfyZpk+9gZMxwAcAZjbSq/VEioJeTcTZ1SY24w4Z5Db
	 pw5xdfW+tqsdIZ2TZ7hEgckITNCovylwM+SzLXNrHA9GkNub2bnPu8DnPf+pMKoSOXNgK
	 9apvdE2/Jx/ea/fdX2yP3Ji+kU1tNn4w0fKnbDq72grd9jdaID6JdDseKVZlrFOrPKTqg
	 OeUEWqqcpmJBQMljuIUg8y5/gTgD7rLFxXGNs6v1CdHwCrm26+6qhG8ZtfnXgkpfA2hy5
	 L+NIQ4N8L63vIcojCH4EPK5kUHfdHDKG7doiLgu0igcXCYHlMbJR9G4Aewt4528tfUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mgpMkxzh;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB683606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB683606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mgpMkxzh
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 213FB339;
	Wed, 25 Nov 2026 06:15:04 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 150F23F763;
	Wed, 25 Nov 2026 06:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795616106; bh=bW3E4SbeYQhH2zRyHlW+z0xxKv0+xWnfrGDaIYNZ9II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgpMkxzhZM1KtRa0AA6hXuxobdOzkN0nHaqk3xtbg2XuiZUU6TszYdViptBjz1Wqn
	 5L8+m00c5+r2Zxd3X+FB+f1zGxRUtVudw2fBrvZqnI9Iqmvo4NnNCdJDztOObwioJk
	 3dDIyGxa18ywS6pLGCjd5en3pKT+ICHWU83IFkrw=
Date: Wed, 25 Nov 2026 14:15:02 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private
 migration
Message-ID: <awbtZjtII9h1oJ5R@raptor>
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
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
In-Reply-To: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>

Hi,

I tried to test this patch, applied on top of v7.4-rc4.

With the changes to the migrate_anon_huge_fault test, but with no changes to
lib/test_hmm.c, to see if the test fails without the fix to the kernel, I get a
kernel fault:

[   95.571212] Unable to handle kernel paging request at virtual address ffff7fffdfe00000
[   95.571221] Mem abort info:
[   95.571223]   ESR = 0x0000000096000004
[   95.571225]   EC = 0x25: DABT (current EL), IL = 32 bits
[   95.571228]   SET = 0, FnV = 0
[   95.571230]   EA = 0, S1PTW = 0
[   95.571231]   FSC = 0x04: level 0 translation fault
[   95.571234] Data abort info:
[   95.571235]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   95.571237]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   95.571239]   GCS = 0, Overlay = 0, DirtyBit = 0
[   95.571242] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001cc71d000
[   95.571245] [ffff7fffdfe00000] pgd=0000000000000000, p4d=0000000000000000
[..]
[   95.692002] pc : __pi_memcpy_generic+0x110/0x230
[   95.696623] lr : dmirror_do_read+0x7c/0xf0
[..]

decode_stacktrace.sh says that happens in lib/test_hmm.c:503.

This looks more serious that the use-after-free that KASAN reported.

With the changes to the test and to the kernel, I get this error when running
the test:

$ sudo tools/testing/selftests/mm/hmm-tests -r hmm.hmm_device_private.migrate_anon_huge_fault
# [INFO] detected hugetlb page size: 2048 KiB
# [INFO] detected hugetlb page size: 32768 KiB
# [INFO] detected hugetlb page size: 64 KiB
# [INFO] detected hugetlb page size: 1048576 KiB
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           hmm.hmm_device_private.migrate_anon_huge_fault ...
# hmm-tests.c:2156:migrate_anon_huge_fault:Expected *(int *)buffer->mirror (0) == (npages - 1) * self->page_size / sizeof(int) (523264)
# migrate_anon_huge_fault: Test terminated by assertion
#          FAIL  hmm.hmm_device_private.migrate_anon_huge_fault
not ok 1 hmm.hmm_device_private.migrate_anon_huge_fault
# FAILED: 0 / 1 tests passed.
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

Might be something on my side? I'll investigate further, but I'm not very
familiar with the code.

Thanks,
Alex

On Tue, Nov 24, 2026 at 10:53:38PM -0800, Andrew Morton wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: lib/test_hmm: invalidate all mirrors on device-private migration
> Date: Sun, 22 Nov 2026 08:53:12 -0800
> 
> When one open of the fake HMM device migrates a folio to device-private
> memory, a second open can fault the same address into its mirror page
> table. The second mirror then stores the inaccessible device page, which
> can oops the kernel when dmirror_do_read() copies from it. Store the
> corresponding RAM backing subpage instead.
> 
> That conversion also makes the backing page's lifetime significant to
> the second mirror. migrate_vma_setup() notifies all mirrors before CPU
> faultback, but dmirror_interval_invalidate() skips the notification for
> every open on the same device. The faulting open clears only its own
> XArray entry. The other open can read or write the backing page after
> migrate_vma_finalize() frees it. Aveline reported a KASAN use-after-free
> and stale data through the second open.
> 
> Handle migration invalidation for every mirror under its mutex. This
> clears pointers before faultback can free the backing pages and waits
> for an active mirror read or write. During system-to-device migration,
> the migrating open installs new entries after migration; other opens
> refault on their next access. Remove the now redundant XArray erase
> from the faultback copy loop.
> 
> Extend the PMD migration selftest to read its last device-private
> subpage through a second open, then fault it back to RAM, change it,
> and read the new value through that open. The trigger is available to
> a process permitted to open /dev/hmm_dmirror* when CONFIG_TEST_HMM is
> enabled; it does not depend on physical GPU hardware.
> 
> [akpm@linux-foundation.org: fix device-private backing subpage selection]
> Link: https://lore.kernel.org/r/20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org
> Link: https://lore.kernel.org/r/179535872126.34.4789080961796247940.b4-reply@b4
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Aveline Noir <jm5905938@gmail.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Mika Penttil?? <mpenttil@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
> 
>  lib/test_hmm.c                         |   20 +++++++-----------
>  tools/testing/selftests/mm/hmm-tests.c |   25 +++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 12 deletions(-)
> 
> --- a/lib/test_hmm.c~lib-test_hmm-invalidate-all-mirrors-on-device-private-migration
> +++ a/lib/test_hmm.c
> @@ -292,6 +292,12 @@ static int dmirror_do_fault(struct dmirr
>  		page = hmm_pfn_to_page(*pfns);
>  		WARN_ON(!page);
>  
> +		if (is_device_private_page(page)) {
> +			struct folio *folio = page_folio(page);
> +			struct page *backing = BACKING_PAGE(&folio->page);
> +
> +			page = backing + folio_page_idx(folio, page);
> +		}
>  		entry = page;
>  		if (*pfns & HMM_PFN_WRITE)
>  			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
> @@ -327,14 +333,6 @@ static bool dmirror_interval_invalidate(
>  {
>  	struct dmirror *dmirror = container_of(mni, struct dmirror, notifier);
>  
> -	/*
> -	 * Ignore invalidation callbacks for device private pages since
> -	 * the invalidation is handled as part of the migration process.
> -	 */
> -	if (range->event == MMU_NOTIFY_MIGRATE &&
> -	    range->owner == dmirror->mdevice)
> -		return true;
> -
>  	if (mmu_notifier_range_blockable(range))
>  		mutex_lock(&dmirror->mutex);
>  	else if (!mutex_trylock(&dmirror->mutex))
> @@ -1198,7 +1196,6 @@ static vm_fault_t dmirror_devmem_fault_a
>  
>  			src_page = pfn_to_page(page_to_pfn(spage) + i);
>  
> -			xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
>  			addr += PAGE_SIZE;
>  			copy_highpage(dst_page, src_page);
>  		}
> @@ -1822,9 +1819,8 @@ static vm_fault_t dmirror_devmem_fault(s
>  	}
>  	migrate_vma_pages(&args);
>  	/*
> -	 * No device finalize step is needed since
> -	 * dmirror_devmem_fault_alloc_and_copy() will have already
> -	 * invalidated the device page table.
> +	 * The migration notifier has invalidated all mirror page tables
> +	 * before the backing pages can be freed.
>  	 */
>  	migrate_vma_finalize(&args);
>  err:
> --- a/tools/testing/selftests/mm/hmm-tests.c~lib-test_hmm-invalidate-all-mirrors-on-device-private-migration
> +++ a/tools/testing/selftests/mm/hmm-tests.c
> @@ -2087,6 +2087,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	void *old_ptr;
>  	void *map;
>  	int pagemap_fd;
> +	int fd2 = -1;
>  	int *ptr;
>  	int ret;
>  
> @@ -2143,12 +2144,36 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  		}
>  
>  		close(pagemap_fd);
> +
> +		/* Read a device-private subpage through another open. */
> +		fd2 = hmm_open(variant->device_number);
> +		ASSERT_GE(fd2, 0);
> +		buffer->ptr = (char *)map + (npages - 1) * self->page_size;
> +		ret = hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
> +		buffer->ptr = map;
> +		ASSERT_EQ(ret, 0);
> +		ASSERT_EQ(buffer->cpages, 1);
> +		ASSERT_EQ(*(int *)buffer->mirror,
> +			  (npages - 1) * self->page_size / sizeof(int));
>  	}
>  
>  	/* Fault pages back to system memory and check them. */
>  	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>  		ASSERT_EQ(ptr[i], i);
>  
> +	if (fd2 >= 0) {
> +		/* This open must not retain the freed device backing page. */
> +		ptr[(npages - 1) * self->page_size / sizeof(*ptr)] = -1;
> +		buffer->ptr = (char *)map + (npages - 1) * self->page_size;
> +		ret = hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
> +		buffer->ptr = map;
> +		ASSERT_EQ(ret, 0);
> +		ASSERT_EQ(buffer->cpages, 1);
> +		ASSERT_EQ(buffer->faults, 1);
> +		ASSERT_EQ(*(int *)buffer->mirror, -1);
> +		ASSERT_EQ(close(fd2), 0);
> +	}
> +
>  	buffer->ptr = old_ptr;
>  	hmm_buffer_free(buffer);
>  }
> _
> 
