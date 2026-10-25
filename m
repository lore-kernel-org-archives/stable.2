Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925766;
	b=KVrAu9ZO4x5a6MYVcU4+Eza/pZ3BPsriPzpL+9zylZSL3a8gYuTNlzDGcZm+RoNFPgja
	 HYmokOfNQmUD+Hl9gqAy3Vw0RqgtV0GzOR35puGoF48EPBbgPY+4Ee7VCxlpEHTR9Eyg7
	 qM9IcypmH3LiNAI7ouGV0wLRcmpyPwmFPeLuHwH7cfwLVurVWYkl7lbTno/YrIN2p1KCj
	 nyqE4GvJHYS/BVO7CiUbIImPlD+/i72Z57te0uKs5GNeVHpfB+HbECGZAr6MvUBYuAqWi
	 c32NkAiLocWznnBdgGVv7NurT/oRHNr0gx2+IRbJFHKqeDNYF0a12vFfiD9Y0ZSS6jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925766;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=68QJafW62HgkjotUsbneO0EWoKRkIg6fDkzU/Qf+g1s=;
	b=mULmOSdhUpYubYF6n7HQyojBykGw1T4EIC45+zdGPxViEdKNEC0Ea2haaWmciJbjughU
	 e6AoawbIf5+0B535xo2erx1VWmpK8sW563Z0Buo4Sx66XgePVh/X9awQF9t7KK06j6FW2
	 8iu8T9EHJ+gKk9isToa99fPEiafEhvS7STxSJAvtnelw7u39AH2hQ6tH0j1x85HtaASDZ
	 RRMRQrDie5gLsdePOT02e5lxJKL2BuEAtr/U5jXZJiEnPi5zNs+gUQ9IKw0QfhEvAY4A0
	 VdNTA0ImbsMK3cMAoY4YXJEsvAgbosUWpqv4svFtb8M2lxFUUaLsaMY5RXsseY0Zc9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMXrqqMs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86F606A31A;
	Sun, 25 Oct 2026 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMXrqqMs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA25A1F01825;
	Sun, 25 Oct 2026 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792925765;
	bh=68QJafW62HgkjotUsbneO0EWoKRkIg6fDkzU/Qf+g1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QMXrqqMso456ITXiNZr90kPAO74wrbYx+z54a3x+l9eEMuCfAezKeCbqq2Y+wX32C
	 0qz/HU8V/DjMllMVNsZ7dxS2kR7tjv05cgXujnvcOFDLsJgM6noFufS+AkA9cfsGBg
	 0C85Lpvl1/EXlcjibTd/iJTpsmVptJ+cf7juyho5braCwFt0YC5MlKZfE4ASGGgeSx
	 JjecmP1+6N+QaI9Kppdd/CDp5h3GuqJBbtBE4rrInZxLZpDvcd3p/7+Xcl7UGbkQot
	 QXQZQwBFz+bxBlFkiGuMQ5BrHn3TDOa7ZpsXKfvZyeHiTnvEKf1Uu/Ty6n4qEBXv+y
	 8Z1Dbxv9k8c7Q==
Message-ID: <9aa49812-1132-458e-9bf5-6dba8b476b26@kernel.org>
Date: Sun, 25 Oct 2026 11:55:59 +0100
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
Subject: Re: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
To: Andrew Morton <akpm@linux-foundation.org>,
 Ngoc Quy <ngocquy0700@gmail.com>
Cc: liam@infradead.org, ljs@kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261014095540.3261469-1-ngocquy0700@gmail.com>
 <20261019174659.42c3529d5e35563cc6e5244c@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261019174659.42c3529d5e35563cc6e5244c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 02:46, Andrew Morton wrote:
> On Wed, 14 Oct 2026 16:55:40 +0700 Ngoc Quy <ngocquy0700@gmail.com> wrote:
> 
>> The PAGEMAP_SCAN ioctl takes mmap_read_lock() on an mm obtained from
>> /proc/<pid>/pagemap without holding a reference to mm_users.
>>
>> proc_mem_open() deliberately grabs only mm_count, so a consumer that
>> touches the address space has to call mmget_not_zero() first. Every
>> other consumer in this file does -- m_start(), do_procmap_query(),
>> show_smaps_rollup() and pagemap_read() -- but do_pagemap_scan() does
>> not.
>>
>> Without that reference the target can reach exit_mmap() concurrently,
>> and exit_mmap() calls unmap_vmas() while holding mmap_lock only for
>> reading, which does not exclude the scanner. For ordinary VMAs this is
>> harmless, as free_pgtables() and remove_vma() run afterwards under
>> mmap_write_lock. A shared hugetlb VMA is different: __hugetlb_zap_end()
>> frees the VMA's hugetlb_vma_lock inside the read-locked phase.
>>
>> walk_hugetlb_range() can therefore load vma->vm_private_data, have the
>> lock freed underneath it, and then down_read() a freed rw_semaphore.
>> The load happens before the freeing side clears the pointer, so this is
>> a use-after-free and not a NULL dereference. Any unprivileged user can
>> reach it with no huge pages configured, as hugetlb_reserve_pages()
>> allocates the lock before the VM_NORESERVE early return.
>>
>> Pin mm_users across the scan, the way the other consumers do. mmput()
>> from the exiting task can then no longer reach exit_mmap() while a walk
>> is in progress.
> 
> All looks good and checks out for me, thanks.
> 
> Except...
> 
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -3231,15 +3231,18 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>>  	size_t n_ranges_out = 0;
>>  	int ret;
>>  
>> +	if (!mm || !mmget_not_zero(mm))
>> +		return -ESRCH;
> 
> Why the new test for !mm?  The current call chain guarantees this is a
> cant-happen and the current do_pagemap_scan will cheerfully oops if
> mm==NULL.

I'd just keep it for consistency with all the other checks in this file?

-- 
Cheers,

David
