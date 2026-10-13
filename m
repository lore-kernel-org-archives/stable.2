Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616C3FC5C9;
	Tue, 13 Oct 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907015; cv=none; b=ksvxvZy+hICKr9YftQKCIBTzownTDTYANYtIQJwSUV2zWcLWpSIbK/IzDNBG1+Gjo9LqT+AeImf21OhBoVJIsiqhf+kYi1WiAV0wVhFJaLbiHXoYPi8Hkfbzo4sl+T/K4z7g1o2ADzYHuSxR8QonuOxZL2GPuLsJIhNZeIaWt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907015; c=relaxed/simple;
	bh=9G1XugHRINvmwHOQzshtjzO2MxpAe3PmKNLpV/Swmtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqaiHQl662XG6JQJSNHt+OJxGx++a5u9dmCVUcLBzecIIEO8Y4scLiyRCNRpGUQpp8JfWdcdljX7taox4m5st23oI6ChtoBLH5PtW1vHfmfX/xV+MoDjSeoKolJ/V3JUk4o0yQwOl+ahWwYciflxz4RIRnWMrcHhpUBhMQ6i1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKjG9aqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKjG9aqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168301F00893;
	Tue, 13 Oct 2026 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907013;
	bh=NPx6DSV+4j0EiNoTg6BI5ljLh5I5fhSgaI3qnLWLPmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jKjG9aqR/NFKyzM9hSQJgqgrhKzeAMUeH4nmyVQZBF18/6bLwiIA0wwCIoJto4wQr
	 mYTcRSCdiNFskdTNuU5jjmNNQwz3rw21bVgIAi//rvVjDW1qOy7tqBqTowFYsOWBZ0
	 DG66fN7fah7/IN0x+OGv1P7gTaoAlaZASZ0zzbwb0JG1u1h3bUxS74wtuRw7Jfii/t
	 Bu0fiGWwGEqZwxAgib1ftjVNEjUS/5buDMB8sVPXJMrvAuNZCsvHLVIrC/fSnMVkqO
	 saPja/KSPrYF8BkCAW/MqK/0j3gGfBnE9aURwNtn4h6SF4bEJVONc3uKuIVZVRJuFD
	 awiQ8eIZRguIw==
Date: Tue, 13 Oct 2026 18:56:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Benjamin Herrensmidt <benh@kernel.crashing.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Rik van Riel <riel@redhat.com>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: disallow ioremap'ing ordinary RAM in
 generic_access_phys()
Message-ID: <as5UvcuKuVjCOvuN@kernel.org>
References: <20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org>

On Tue, Oct 13, 2026 at 01:41:24PM +0200, David Hildenbrand (Arm) wrote:
> generic_access_phys() can end up getting called on CoW PFNMAP mappings,
> resulting in it trying to ioremap anonymous folios, which especially
> the x86 code doesn't enjoy, and which is in general just odd/wrong.
> 
> E.g., with a CoW mapping of a PCI BAR:
> 
> ioremap on RAM at 0x0000000045623000 - 0x0000000045623fff
>   WARNING: arch/x86/mm/ioremap.c:216 at __ioremap_caller.isra.0+0x4c2/0x5f0
>   Call Trace:
>    generic_access_phys+0x130/0x4d0 mm/memory.c:7178
>    kernfs_vma_access+0x1ce/0x280 fs/kernfs/file.c:437
>    __access_remote_vm+0x58f/0x890 mm/memory.c:7256
>    mem_rw+0x2a1/0x670 fs/proc/base.c:912
> 
> But more generically, we should disallow access to anything that looks
> like ordinary RAM in the system: including allocating memory (e.g.,
> alloc_pages) and mapping them in a VM_PFNMAP.
> 
> For pages with an online memmap, allow only pages marked as reserved
> (PageReserved). This also includes memblock allocations, however,
> distinguishing them from other MMIO is tricky, and nobody should really

With ARCH_KEEP_MEMBLOCK it's actually easy ...

> be mapping them in a PFNMAP (except someone abusing /dev/mem, which we
> do not care about).

... but yeah, it's not worth it.  

> So only allow access if there is no online memmap, or if the pages are
> marked reserved. Reject other pages with -EINVAL.
> 
> Note that, just like other pfn_to_online_page() users, we won't care about
> concurrent memory offlining; mapping memory that can concurrently get
> offlined is highly dubious.
> 
> Reported-by: syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=49b1021becba70c1f3f6
> Reported-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> Closes: https://lore.kernel.org/r/20261001152524.171115-1-ngocthang2710.1999@gmail.com/
> Fixes: 28b2ee20c7cb ("access_process_vm device memory infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memory.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

-- 
Sincerely yours,
Mike.
