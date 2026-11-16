Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853599;
	b=D+l8d9qI0lXl3gxF5mJoZMQp3DdawbFT2p1hqBeWF0PWHquDV4Dvpi7RLdFN1MMFeSKW
	 R4GnxK5UCZNCXyfghLMaAyeFQoYfjvrU28/9whY/cavZ7U9IVzDVxLmbQHQSHo5fgWNYP
	 VYUCNLtPmCmTOI8UBRzko7ZMawTj3kS7AKPO5l2HveqYQH3YNwCcG7oUJPCGf+QG4oiGL
	 8JdpHga/l70wJ891n1clR5eYKuL0HqmwNInKHIRIu3zkhXqA3lx5YO3YS2osc1Y6Oyj/u
	 Xa/04Aj0/sQjGT1McIiA1vb7FV2vyIPBcAJIUDYARg24ZRjPi6gzSDszEZHcm78++kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853599;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QDQfzZl7+S98CScsAZPFpY0/VTlWcWGpji92V9vmtd4=;
	b=FZt42NX+uvP2RJQWHSTaxfpA8RpPssrPcfjFsITfng1+wE64O5pMM1oSYk5z9Y2rejnS
	 PZDS5/kOo/AwuP3kksdF2Y08+PAjBxOYdNAlYccAfsQqZfCvoY5gk0IaK9EsgK5BJ3WZP
	 o5hbkds8x8ZYyKhAVRiU/ot0Xtzr54RvuT/XzTedF+hYiNk/y1/CQ9KQSUVB7QN/NBJdH
	 nEzqLYm3WaggUfO45+R71LgI6QIRM8WmHNPcgqvcWbfxagTR++ftl9o12bbrdFwVOQSM5
	 N2L/Q1C/sr6F/vePg2QJFPvIGuurXvlTPWTSTZswrIu+5zxO8lpes4h7frJO16CosVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwcLBwIV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E0606A31C;
	Mon, 16 Nov 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwcLBwIV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945191F000C4;
	Mon, 16 Nov 2026 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853599;
	bh=QDQfzZl7+S98CScsAZPFpY0/VTlWcWGpji92V9vmtd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iwcLBwIVbzU3ieJETlB9dx16WqhRfHDZYg2h/IEOMb4RCPdTRWoohBpkfzpTI6GW+
	 tzTBaXJnEWgunNfpsWt18LWM+UiTVGj4Rl+NuqSmXXJKdz5Ov4mQ3kaSHI2UouavIc
	 FNc5NnQCy9w9qWaxxCQvLzeuEX2v+vDdooB2vPk1lrb2JArIQneSmbIb+unEkMVZcz
	 AbfVnIH1TxPh5BRyb9mRklF5zhMOoSeSlYrWMs2rzN8I6UcZjnym5hOgyNEGmKvOc/
	 Ul647N6gtzBKWanVB9xN+4jN0oAFVoM4ZsOeZLvb8jynpqzGOufyq9D6Rx5zXdEJ6Q
	 jEYGxYcBd5vuQ==
Message-ID: <200c4dca-63a4-487e-bd59-dc89c9018b0a@kernel.org>
Date: Mon, 16 Nov 2026 19:26:27 +0100
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
Subject: Re: [PATCH 5/5] mm: check permissions and bounds for vm_ops->access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Matthew Auld <matthew.auld@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, Chris Mason <mason@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
 <980220a5-390e-40a7-bd5c-16a2225bd75b@amd.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <980220a5-390e-40a7-bd5c-16a2225bd75b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/16/26 16:51, Christian König wrote:
> 
> 
> On 11/12/26 23:09, David Hildenbrand (Arm) wrote:
>> GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
>> falls back to vm_ops->access without checking VMA permissions and without
>> limiting the request to the VMA size.
>>
>> Consequently, /proc/<pid>/mem can bypass protections even without
>> FOLL_FORCE, or cross into another mapping without checking its
>> permissions.
>>
>> Check VMA permissions before calling ->access and limit each request to
>> the current VMA. Implement similar access permission checks as GUP,
>> however:
>>  (1) Reject writes to CoW mappings because the callbacks access backing
>>      memory directly and cannot handle CoW.
>>  (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.
>>
>> This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
>> MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
>> ("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
>> VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
>> exploiting the missing access-permission checks fixed here. Reads remain
>> supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
>> in May 2023, already does so.
>>
>> Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
>> Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
>> Cc: stable@vger.kernel.org
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Reported-by: Chris Mason <mason@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/memory.c | 25 +++++++++++++++++++++++--
>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d4370c1b331c9..9872f289c1e49 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -7362,6 +7362,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>>  static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>>  			      void *buf, int len, unsigned int gup_flags)
>>  {
>> +	const bool force = gup_flags & FOLL_FORCE;
>>  	void *old_buf = buf;
>>  	int write = gup_flags & FOLL_WRITE;
>>  
>> @@ -7401,15 +7402,35 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>>  			if (gup_flags & FOLL_ANON)
>>  				break;
>>  
>> +			if (write) {
> 
>> +				if (!vma_test(vma, VMA_MAYWRITE_BIT))
>> +					break;
>> +				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
>> +					break;
> 

Hi,

> I might be wrong but IIRC that was brought up before and was rejected.
> 
> We even had a bug report for AMDGPU from a security researcher claiming that you could circumvent security checks using vma->vm_ops->access() which turned out to be complete nonsense after spending tons of time investigating it.
> 

independent of all actual security issues, the current core-mm is completely
fragile as is.

This needs to be fixed independent of driver hacks that are in place.

> The technical background is that there are applications which runtime generate shader code which is then protected by making the VMA read only. But the debugger is still allowed to write to it using vma->vm_ops->access().
> 

Yes, that's precisely what FOLL_FORCE is for, which is what debuggers (ptrace
access) should be using.

So if there are debugger interfaces that are not using FOLL_FORCE, we would have
to see what we can do about that. (and not keep core-mm fragile)


> That behavior is ok because drivers specific and drivers have checks in place if their backing store is read only or not.
> 

"trust me, drivers do the right thing"

Core-mm needs to to something reasonable.
> For an example see this code here: https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/i915/gem/i915_gem_ttm.c#L1163
> 
> So if you do this here you might break intentional uAPI.

Let's figure out what would actually be broken to then decide how we can keep it
working without keeping core-mm a swiss cheese.

Thanks for the review!

-- 
Cheers,

David
