Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9E5013A8;
	Tue, 13 Oct 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903834; cv=none; b=aYJSUo0YqkAjnl8zVpS3NehaFqSnkbaXdAP531afPZB1TlhjMhbUpFch/Hxdn4Pw3OyJ3x0Sc6CcXkI4VDc29tNaH8eAe1II4VOIVYDHDerplr3+5nJkaCc6DhAnsXpLLzuB68XCALwY1LvjLwH674VW4xL5PU1ysjcE7Ag26aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903834; c=relaxed/simple;
	bh=6wd92Cjt7lC7ps0qjtTrJPmKIiyBYGYR9rbSo2zIRmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwgHc6Z9pNLDtFbDnQWB54yuyzEaw7sSmJxChVK78Efs0IVeNgV/bgxauSGwVqz4vd7xFXXcbCHFlPK4bCZIvC5/mlLk4qlqZleXcrnFjVc9Eynnk8cvdf/7+jDjaYm+84j9adO8XOdZyBAKSmJR90qnWpVx4IuKi6efBHSTTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3tbE05i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3tbE05i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E11F000FF;
	Tue, 13 Oct 2026 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903833;
	bh=O462JKoBsK5kLKH34dERrDJEsMO/yC3R2yXeyHeFOP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c3tbE05iKYpFIjUv3vFpzuL9h4/yEgBGEM5i1reN/FbqxAeXsuVwpeIOq4txsfuuK
	 L/2Y/bu3EIyLMAxykkKLBWoKNiT8Bartce+GFzHMpAXu7G3/4KUrt9zQYPLH8oI1WD
	 8D5gOuyyvRqhYouGpUemUyCzI7j1Owy1BHYPKwu+Lqygcime9usdgp5cWkdpLKQKSf
	 kfEgUL6/Mp4KhvPeaY4KjgHuOEMmFT/KVTdqESyqF/hHQXkrCQIeeNiRNq/vnaD5tL
	 5knxNXJcoIPv7KVhNVog/fqjxrmHuIyJ+6oYRwkOGz4ooeWxRUUr5fl2cJf2vEUfaK
	 9pTunqG3q7whg==
Date: Tue, 13 Oct 2026 16:03:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Stian Halseth <stian@itx.no>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Andreas Larsson <andreas@gaisler.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix lost maps entries above 2^63
Message-ID: <as5E25F4xjHwYSGQ@gremlin>
References: <20261011162019.922436-1-stian@itx.no>
 <e300f046-dcae-4539-bf89-92eb8c575e25@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e300f046-dcae-4539-bf89-92eb8c575e25@kernel.org>

On Tue, Oct 13, 2026 at 04:40:43PM +0200, David Hildenbrand (Arm) wrote:
> On 10/11/26 18:20, Stian Halseth wrote:
> > When a read of /proc/pid/{maps,smaps,numa_maps} resumes, m_start()
> > rewinds *ppos to priv->last_pos so that the vma which did not fit into
> > the previous buffer is shown again. It only does so for last_addr > 0,
> > meaning to exclude the start of the file and SENTINEL_VMA_GATE, but
> > last_addr is a signed loff_t holding a vm_end. sparc64 maps shared
> > libraries, anonymous memory and the stack above 0x8000000000000000, so
> > the rewind does not happen there and one entry is lost at every read()
> > boundary.
> >
> > Reading the maps file of a process with read sizes from 64 to 8192
> > bytes in steps of 64 loses lines at 126 of the 128 sizes, smaps at 123
> > and numa_maps at 97, and the proc-maps-race selftest fails 4 of its 6
> > tests. Python's sys.remote_exec() reads maps with fgets() and fails
> > intermittently when it misses the libpython data mapping.
> >
> > Test for the two values that are not a vma end instead.
> >
> > Fixes: 5631da56c9a87 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
> > Closes: https://github.com/sparclinux/issues/issues/111
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Stian Halseth <stian@itx.no>
> > ---
> >
> > Notes:
> >     Tested on a SPARC T7-1 (sun4v, 7.3-rc5), a T4-1 (7.2.9) and a Sun Fire
> >     V240 (sun4u, 7.3-rc5): no lost lines at any read size afterwards, and
> >     Python's sys.remote_exec() test passes 20/20. On an amd64 KVM guest maps,
> >     smaps, numa_maps and the proc selftests are unchanged.
> >
> >  fs/proc/task_mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 5c54aebe21182..cdce513edcb1d 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -339,7 +339,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
> >  	 * Reset current position if last_addr was set before
> >  	 * and it's not a sentinel.

It's interesting that this comment differs from the actual code :)

> >  	 */
> > -	if (last_addr > 0)
> > +	if (last_addr && last_addr != SENTINEL_VMA_GATE)
> >  		*ppos = last_addr = priv->last_pos;
> >  	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
> >  	hold_task_mempolicy(priv);
>
> I hope Suren can review as well.

Yes Suren should take a look.

>
> Would it be cleaner to reject any special values, that is, SENTINEL_VMA_END and
> SENTINEL_VMA_GATE?
>
> That would match the comment and the previous code idea: exclude only 0 and
> sentinels.
>
> Could consider a simple addr_is_sentinel() helper.

Yeah that seems sensible.

I guess Stian should respin with something like that?

--
Cheers, Lorenzo
