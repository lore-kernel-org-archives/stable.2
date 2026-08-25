Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884D33A70A;
	Tue, 25 Aug 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655068; cv=none; b=r2TgaMv6Y0rH994Zf8qbDXKP6m3wHAlmnI9PhJsYyVsIMd9sOEASLPhriNY3qOHZLKHfMfYeOKoswCIP7G93DuyI1U4zQDHiwKAUVdFTsESWeuUWwjBtqAgRkHZoP2sdHp5IwIONuGTWcgRetcNNRjSiyUcOyar9z7lSriusrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655068; c=relaxed/simple;
	bh=QMJp/8yGBxO4YI1i1A5XdUSc2vFmLkXPV/JY9qAuZ48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT5iEUYZcgYtLsZZUnoico574W3V3ux73Yq2Et/nNNCH2oI9iuGgE8Q/pR4xAMl3L1RqYJoFddje5RoQ80xSmqi0gzfvW3ogxkuTgxuwOuaqUajlN2o1p3PoAgKiZHp16UBQmoN8SprsDmFyNHN/FKkPhIBy6AW2D1/DU7e35xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQPZds2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQPZds2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB6B1F000E9;
	Tue, 25 Aug 2026 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787655066;
	bh=4dWbDNh7SefaqEmDQxom8V4ar9Vn3mt6p/4U2QAZfh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RQPZds2KrGv64fSlv8dfSkfENvn4AkQ4dJQWtdOG2edngpo35SmYXFrizNznv4LV+
	 ic67xjuq6VP5prYkXjr0s8IxgPnlclWoPxLynljPP6LKP1BcO7lZlLEXoN2Kt0hWzv
	 1Sk+SF+I7mFzbhWGeATiKlPQKof1b/Y4Oh59E5hY7U9WnpNj0vNIrwzHoGGCUCr6Ck
	 4qiPIgXHyb4zStAeqqjPPk3On9pQzfWy7qE8rRplrF0gq/UrhIT8kqQjR1XAkJ3+7O
	 eHgJbbX3uv4GLKohzTnK4Z/2e4AePT6sGvIIzZqZA698rKIWhBNc+vzC/YOe0makdC
	 HWP/uVH5WTeRQ==
Message-ID: <17e9f7d6-d095-44ee-9997-8dc10646f3f8@kernel.org>
Date: Tue, 25 Aug 2026 12:50:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Hagen Paul Pfeifer <hagen@jauu.net>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 21:14, Lorenzo Stoakes (ARM) wrote:
> secretmem has a relatively laissez-faire attitude to accounting the folios
> it allocates.
> 
> The intention is that the memory is treated as if it were mlock()'d and
> thus is limited by the RLIMIT_MEMLOCK limit if the CAP_IPC_LOCK capability
> is not in place (which broadly allows unlimited ranges of mlock()'d
> memory).
> 
> The lifecycle for memfd accounting against this limit is - account on map,
> unaccount on unmap but the lifecycle of memfd folios is allocate on fault,
> deallocate on inode eviction.
> 
> This mismatch is problematic because the folios are unevictable and remain
> so until the inode is evicted (set using mapping_set_unevictable()).
> 
> This is problematic as it eliminates usual mlock() semantics - mapping
> folios then unmapping them does not clear their unevictable state, since it
> depends on AS_UNEVICTABLE, not PG_mlocked.
> 
> A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
> map then unmap and VmLck no longer counts the secretmem range (or more
> involved - fork which also achieves the same thing).
> 
> Worse - they are not accounted in the process's RSS even if mapped again,
> meaning the OOM killer won't know to kill the process.
> 
> A user without the CAP_IPC_LOCK capability can therefore repeatedly
> map/unmap (or map/fork) and consume all available system memory with
> unevictable folios and cause system instability.
> 
> A secretmem fd can be passed between processes and over fork so a
> per-process limit simply does not make sense.
> 
> So follow the precedent set by io_uring, perf, skbuff, iommufd and xdp -
> track the number of locked pages in user_struct->locked_vm.
> 
> Since the scope tracked is actually inode lifetime, the RLIMIT_MEMLOCK
> applies per-user not per-process. Also given the change in scope it doesn't
> make sense to bypass for users with CAP_IPC_LOCK, so remove it.
> 
> There is simply no reason to carry on marking the mapping as mlock()'d
> since it's misleading and the lifecycle is now correctly handled, so remove
> this too.
> 
> Additionally, fix the selftest which checks the limit as this now must
> assert SIGBUS on limit violation on fault-in.
> 
> __secretmem_account_pages() is more or less a duplicate of the code that
> io_uring etc. use, but since this is a bug fix that needs backporting,
> defer any de-duplication efforts to a follow-up.
> 
> Reported-by: Daehyeon Ko <4ncienth@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Can we split off the selftest changes? This stable patch is already pretty big.

I'd assume the changes to the selftests are not required just to get if fixed,
because the changes should not be breaking existing user space (and cosnequently
existing selftests).

[...]

> v1:
> https://patch.msgid.link/20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org
> 
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Mike Rapoport <rppt@kernel.org>
> To: David Hildenbrand <david@kernel.org>
> To: "Liam R. Howlett" <liam@infradead.org>
> To: Vlastimil Babka <vbabka@kernel.org>
> To: Suren Baghdasaryan <surenb@google.com>
> To: Michal Hocko <mhocko@suse.com>
> To: Shuah Khan <shuah@kernel.org>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: "David S. Miller" <davem@davemloft.net>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Jesper Dangaard Brouer <hawk@kernel.org>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: James Bottomley <James.Bottomley@HansenPartnership.com>
> To: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: ljs@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> ---

[...]

> +
> +static bool secretmem_account_folio(struct secretmem_inode_state *state,
> +		const struct folio *folio)
> +{
> +	unsigned long nr_pages;

Nit:

const unsinged long nr_pages = folio_nr_pages(folio);

> +
> +	nr_pages = folio_nr_pages(folio);
> +	if (!__secretmem_account_pages(state->user, nr_pages))
> +		return false;
> +
> +	atomic_long_add(nr_pages, &state->nr_pages_accounted);
> +	return true;
> +}
> +
> +static void __secretmem_unaccount_pages(struct secretmem_inode_state *state,
> +		unsigned long nr_pages)
> +{
> +	atomic_long_sub(nr_pages, &state->user->locked_vm);
> +	atomic_long_sub(nr_pages, &state->nr_pages_accounted);
> +}
> +
> +static void secretmem_unaccount_folio(struct secretmem_inode_state *state,
> +		struct folio *folio)
> +{
> +	__secretmem_unaccount_pages(state, folio_nr_pages(folio));
> +}
> +
> +static void secretmem_unaccount_all_folios(struct secretmem_inode_state *state)
> +{
> +	unsigned long nr_pages_accounted;
> +
> +	nr_pages_accounted = atomic_long_read(&state->nr_pages_accounted);
> +	__secretmem_unaccount_pages(state, nr_pages_accounted);
> +}
> +
>  static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	struct secretmem_inode_state *state = inode->i_private;
>  	pgoff_t offset = vmf->pgoff;
>  	gfp_t gfp = vmf->gfp_mask;
>  	unsigned long addr;
> @@ -72,8 +134,15 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  			goto out;
>  		}
>  
> +		if (!secretmem_account_folio(state, folio)) {
> +			folio_put(folio);
> +			ret = VM_FAULT_SIGBUS;
> +			goto out;
> +		}
> +
Okay, that works because secretmem does not support any form of truncate, in
particular, no FALLOC_FL_PUNCH_HOLE.

Overall, the idea sounds good to me. Nothing jumped at me.

-- 
Cheers,

David
