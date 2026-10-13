Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B93E2771;
	Tue, 13 Oct 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874946; cv=none; b=D8WcXrmhE7OFeaPmKhE4nlbnCKcU7WQe7v938mO2FLjWEuEao1hpspLagvd001wFuxWiQZQ73xfP9TBWOGBGJ8swlVdAyNzJPkBa0hCAToSgTtk2akzCu6m0OKUNmK/3NemGaSNtVzIrwZUYQ7yvCMceIBxHdTj4CEnRjtptKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874946; c=relaxed/simple;
	bh=/89lckY/PTc6kyDo1iLD5RKfRTtknLooT4yQas4GacM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qia2fdVcJbpnBWPdDVoRPqrfrAqgn7Jui1rZ6qN3MVaMAVIE7FychmVBD/qWUDU/jzL35mIVNIw5TeXXr8jdonRu0rL8t9ZeP3vW+o9gO4xvHd3FuqZCMLbw+NB/rulXNO8NdEkm89G8zlSgRudD/SkqGTO65hc4Ymdo51VbnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkWWJhvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkWWJhvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ED31F00899;
	Tue, 13 Oct 2026 07:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874945;
	bh=EBi3WYFIcQXOY+oCNOIYgRcsLArDhRHYOXYP0UcHYVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SkWWJhvflO0HT+FNejWLp+rgiXeWqzDRO5RvkfirH0JhoAkTmcM4vZtNGrYdFBBnz
	 +Q7A9Vf/BRyIETCwm9hI+1nh+6dFfadglJvJcjZwbGEzc5qFIzV2gQeKGhabvutoOB
	 ZpU6AZDrZkWflMBhV1YKsQjIFTWQC/sOSQjjGggnglrRB4sCRZC9VvmYqhQlSLnc7G
	 oKTCY40DnCyFKu3OnYcXgVXjRFAfm2J6ImIjGH2h9jlczJ//+WR+PToxY+uTLL4ASE
	 e7nAcr+1DEYxtp2FcW4kN1Jcf+VFtTZj6LhGwYFJowray8v9d44A2z4N1/513nIGjA
	 y/p3RWecNGJvg==
Message-ID: <c08d306e-ae10-40d5-942c-791efa08e232@kernel.org>
Date: Tue, 13 Oct 2026 09:02:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: skip offline memory in mark_free_pages()
To: Yogesh Gaur <yogeshgaur.83@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+609c80047e3e808b465c@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261006125849.1998-1-yogeshgaur.83@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261006125849.1998-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/26 14:58, Yogesh Gaur wrote:
> mark_free_pages() walks every valid PFN of a zone and calls page_zone()
> on its struct page.  A PFN in an offlined memory block is still valid,
> but its memmap is no longer initialised: offlining poisons it.  With
> CONFIG_DEBUG_VM that is caught on the first such page:
> 
>   page:ffffea0005400000 is uninitialized and poisoned
>   page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
>   kernel BUG at ./include/linux/mm.h:2402!
>   RIP: 0010:mark_free_pages+0x49a/0x4b0 kernel/power/snapshot.c:1266
>    count_data_pages kernel/power/snapshot.c:1417 [inline]
>    hibernate_preallocate_memory+0x14f/0x750 kernel/power/snapshot.c:1859
>    hibernation_snapshot+0xd5/0x3d0 kernel/power/hibernate.c:416
>    hibernate+0x28f/0x680 kernel/power/hibernate.c:813
> 
> syzbot's reproducer offlines memory42 and then writes "disk" to
> /sys/power/state; that page is the first one of memory42.  Without
> CONFIG_DEBUG_VM the walk reads stale page flags instead.
> 
> saveable_page() and saveable_highmem_page() already use
> pfn_to_online_page() for this since commit 5b56db37218e ("PM/Hibernate:
> use pfn_to_online_page()").  Do the same here.  Offline pages are never
> on a free list, so the second loop in this function does not need it.
> 
> Fixes: d33695b16a9f ("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()")

That's very likely the wrong commit. Memory that was added but never onlined similarly
has garbage in its memmap.

Like similar commits, this should likely be

Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")

-- 
Cheers,

David
