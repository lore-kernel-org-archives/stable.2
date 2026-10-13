Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122184FC32D;
	Tue, 13 Oct 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894607; cv=none; b=YVWfWeAU4xGJbJkcb8mKGWNZWKgo4XGIBm2v0kfQLj4DQoAxSSeXn9kW1wkRQE6VMdviDWUfODgmGVAmRtJHlopCCYpFzlM9j+wvmcI9t6XKjJUwpoFTiy8TjeSTvtOeEToOnK1y+722VdUt43gqnLP12E1qNzwM6oFFXLDBgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894607; c=relaxed/simple;
	bh=B2UhcZv6wX0YdSYb+gZa47T0Q2peLLEgfPoACQqd0ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6jlVgiOKhTTCG39pq6Qr1iA6dHERfmTfbGRTyoJtxSi9Y6Acn0VVEB2e1/roOfrRJTX+Hc0YcbA8BKYQborVmX+yJdfTLYTT5Ub4RyYMapZ1bigpFnBCJSIq1scGIRB4ckGysCyVpeq6h1Dbnhaj6ghEFzrzAFpAwhlLCiifBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlnL/hy1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlnL/hy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B6A1F000FF;
	Tue, 13 Oct 2026 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791894605;
	bh=W1KVneCgXArp9zppiaGo3yxvYAKNVn0jTmgz8OZUh50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlnL/hy1yfvWUPlwGgRpNziga7S536l9AtbIIdBcPDHXBeex7a011lJvl3QJXrpMu
	 nq6wqtcldjoLyPz/FTp5XqzlgoJgG5dWHc6bsSDy+MEx+ANP417gSJh5G6lAcq1qRE
	 6f1EwkqpiyhFHQPbIWhLSgacm20PByzywuye3tWz8c5fpvSku3CQ3mPKQEE1A7jZqQ
	 6S3cQIqOGKQtxiRTQfcwm/VBqUHillXFZ/xXLZikhv5ezLwt5GHzxb7PkJXR5WFmYG
	 dfM42lXX+JVdBLra9GjTF9b+Q/gRT0T8qG8h4w/Wqq6+Uv3PSm4KDYkOqBR/aF1IQY
	 MLoI8E6342m+Q==
Date: Tue, 13 Oct 2026 13:29:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Benjamin Herrensmidt <benh@kernel.crashing.org>, 
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, 
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: disallow ioremap'ing ordinary RAM in
 generic_access_phys()
Message-ID: <as4aeYkqZywLo4Gx@gremlin>
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

Ugh god.

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

Yes.

>
> For pages with an online memmap, allow only pages marked as reserved
> (PageReserved). This also includes memblock allocations, however,
> distinguishing them from other MMIO is tricky, and nobody should really
> be mapping them in a PFNMAP (except someone abusing /dev/mem, which we
> do not care about).

Yeah I guess we shouldn't try too hard for weird edge cases, or at least
can revisit it later potentially.

>
> So only allow access if there is no online memmap, or if the pages are
> marked reserved. Reject other pages with -EINVAL.

Seems reasonable overall.

>
> Note that, just like other pfn_to_online_page() users, we won't care about
> concurrent memory offlining; mapping memory that can concurrently get
> offlined is highly dubious.

Yeah sounds like the user would be doing something crazy in this case,
therefore their problem!

>
> Reported-by: syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=49b1021becba70c1f3f6
> Reported-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> Closes: https://lore.kernel.org/r/20261001152524.171115-1-ngocthang2710.1999@gmail.com/
> Fixes: 28b2ee20c7cb ("access_process_vm device memory infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> I went back and forth 10 times and concluded that using PageReserved
> should be the right thing to check for now.

It seems the sensible choice, yes. And locally, AI review agrees with you, FWIW!

--
Cheers, Lorenzo
