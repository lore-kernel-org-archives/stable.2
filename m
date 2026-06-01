Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1B25B0B9;
	Mon,  1 Jun 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289819; cv=none; b=jlqxH4GAvlITHcnf1COrus/dKiwRPQxGmvWLH/x5byrJ+utMb+j9HI2nTDJk3RmGkOr6fRaDfgkTj9XmDFZ2RYvYYbuyyNh8NVIhtTDPW7qGOgIUlt/FbkdCcaq9fc+1ptuMPcMT/9N3W18ghB20F6Z/n187GvaX45ChMxpdymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289819; c=relaxed/simple;
	bh=uh04jOx1nBkRcF0Uf+qmlp1xwS9hdzC1jSrjru2+IQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrqZOaimYef0mIAzO/J1pV0wM+L6AwBN7QjasKeZXnxCw8nANRHzCbitudpGY2rAiqIND6Mki/hEil1DrQNVaQwnwrNEGbuBv6aIqvmi/EximpeI2FdsNRioeTrJm0AsR4JW/fYpUkPObDGr20bszUL2Z4IpHxNp/BJcU4kykpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HaUyy/Q3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HaUyy/Q3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 169751E8D;
	Sun, 31 May 2026 21:56:50 -0700 (PDT)
Received: from [10.164.19.28] (unknown [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7FB3F93E;
	Sun, 31 May 2026 21:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780289815; bh=uh04jOx1nBkRcF0Uf+qmlp1xwS9hdzC1jSrjru2+IQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HaUyy/Q3QQY8LFo0HHWNssQu++Ryy4dWmAHD4fasvlTInFEZouDCQj/vtZBX+P2ZC
	 VtrFIsX83pVwwuosFxTpDu3u1Et3kGCE7TcgrBQlrgqw5orWkEXPYGukRONyM8mxS9
	 fpXC/jZe5fUPVnPzy7oIKCbV0BibT+oV/WFEDKT4=
Message-ID: <9d13d62f-df3d-46aa-8411-4abebb92c35e@arm.com>
Date: Mon, 1 Jun 2026 10:26:45 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: do not warn on seeing non-migration pmd
 entry
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
 liam@infradead.org, ljs@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 shuah@kernel.org
Cc: vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, balbirs@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260529111704.1078346-1-dev.jain@arm.com>
 <a62302f8-24ea-4d21-963d-48bec766766b@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a62302f8-24ea-4d21-963d-48bec766766b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/06/26 12:41 am, David Hildenbrand (Arm) wrote:
> On 5/29/26 13:17, Dev Jain wrote:
>> pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
>> entry. This became false once device-private entries at the PMD level were
>> added.
>>
>> One can hit the warning by patching hmm-tests.c with the following:
>>
>> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
>> index e1c8a679a4cf3..7f0a3384f3c5f 100644
>> --- a/tools/testing/selftests/mm/hmm-tests.c
>> +++ b/tools/testing/selftests/mm/hmm-tests.c
>> @@ -209,6 +209,37 @@ static int hmm_dmirror_cmd(int fd,
>>  	return 0;
>>  }
>>
>> +static int hmm_read_self_pagemap(void *addr, unsigned long npages,
>> +				 unsigned long page_size)
>> +{
>> +	const size_t entry_size = sizeof(uint64_t);
>> +	const off_t offset = ((uintptr_t)addr / page_size) * entry_size;
>> +	uint64_t *entries;
>> +	ssize_t nread;
>> +	int fd;
>> +
>> +	entries = malloc(npages * entry_size);
>> +	if (!entries)
>> +		return -ENOMEM;
>> +
>> +	fd = open("/proc/self/pagemap", O_RDONLY);
>> +	if (fd < 0) {
>> +		free(entries);
>> +		return -errno;
>> +	}
>> +
>> +	nread = pread(fd, entries, npages * entry_size, offset);
>> +	close(fd);
>> +	free(entries);
>> +
>> +	if (nread < 0)
>> +		return -errno;
>> +	if ((size_t)nread != npages * entry_size)
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>>  static void hmm_buffer_free(struct hmm_buffer *buffer)
>>  {
>>  	if (buffer == NULL)
>> @@ -2314,6 +2345,10 @@ TEST_F(hmm, migrate_anon_huge_fault)
>>  	ASSERT_EQ(ret, 0);
>>  	ASSERT_EQ(buffer->cpages, npages);
>>
>> +	/* Exercise pagemap on a PMD device-private entry. */
>> +	ret = hmm_read_self_pagemap(buffer->ptr, npages, self->page_size);
>> +	ASSERT_EQ(ret, 0);
>> +
>>  	/* Check what the device read. */
>>  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
>>  		ASSERT_EQ(ptr[i], i);
>>
>>
> 
> 
>> Therefore, remove the stale migration-only assertion.
>>
>> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> Applies on mm-unstable (404fb4f38e8f).
>>
>>  fs/proc/task_mmu.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 1e3a15bf46f4e..58938e62154d9 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
>>  			flags |= PM_SOFT_DIRTY;
>>  		if (pmd_swp_uffd_wp(pmd))
>>  			flags |= PM_UFFD_WP;
>> -		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
>>  		page = softleaf_to_page(entry);
>>  	}
>>  
> 
> The whole thp_migration_supported() guard is a bit shaky, right?

I think if you remove this, then you will trigger a WARN_ON in softleaf_to_page(),
for the case of !CONFIG_ARCH_ENABLE_THP_MIGRATION.
> 
> I guess device-private entries currently imply thp_migration_supported(), but
> that thp_migration_supported() check is really questionable and should likely
> just go away (else if -> else).
> 
> Staring at pte_to_pagemap_entry(), likely we'd also want
> 
> if (softleaf_has_pfn(entry))
> 	page = softleaf_to_page(entry);
> 
> to prepare for PMD swap entries.

Correct, and this is done in
https://lore.kernel.org/all/20260427100553.2754667-4-usama.arif@linux.dev/

I think in addition to that, Usama can also remove the thp_migration_supported() check.
> 
> 
> Anyhow, both are unrelated (can you send patches to clean it up?)
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 

