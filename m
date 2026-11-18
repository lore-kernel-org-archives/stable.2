Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011949;
	b=NE4/S0gkUhs35dLNj6tAq+56qfcH1KByIXbEJ5E0vZwYbiHcv/k1xH67m9rvIwU+FqtZ
	 UbseMhG0DUwmW5d4Gx1GV451YKD1cwINmEJUDelHcbWn6cJnCkwfHa6M9xqV2VT32eD+i
	 unuZ8DTNL5zvcpB27V2Oyq+YiwbWNmiB1HqX0evRlXGpDjQF+XG9FdQy7E4Jwrhns/KRS
	 8V26jFEiWLt+ZYxC8SNbvw3f5DrItplW9pTNItqxByJVHgkwjz2yxgvg99j246rbf2PdV
	 kf4QM4C/AEELL42wczU6lwk0QRUjT5rT3CHkAjL3DpeaGD7FMHB1QMQzASAPeOMi50w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011949;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JRCol7DLLOPaehkBDoGQplGCUv5gKUcTOe56eokY+HU=;
	b=vQj+kcM2UoQHz09Pd1gkrjOpyG/ecqE+3ZCoa9x/3r8gCFW1VuJGKK8HdiAs8pMVX1+B
	 1sJ++qWykAXK4evd6AZGAhCwwLpYqxiQpaJTfkRJbxmQBPefpAE0mKkkGTuOTntDxKYGN
	 F9aWZAVsNIhRgTnjoBJ2npnRRW22wy+hW0Rfy5r1B6wsoa8G17gHudckua87GWO33QO/N
	 wRVEuPVFqYMo6oBIwb9qOOO3hc2WbBabwTOuXNFkkjY9xBQGxfI0gsfetBoc4rkb3nRgf
	 +ZqWIKVmK/hIk9koVgEY3EIlT87o1NDpDdf6Z+aiyPt0JJiYF7+am6lxZdr+RGj0dRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTWbZH11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653860A2602;
	Wed, 18 Nov 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTWbZH11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04641F000C5;
	Wed, 18 Nov 2026 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011948;
	bh=JRCol7DLLOPaehkBDoGQplGCUv5gKUcTOe56eokY+HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nTWbZH119XtpYG4VkarivQ77CRq6rpcwZDyQuH/XfcPvsSE0ZD7vgnFVzcIBQ232a
	 sLUteXFMmiMdkik4Niz+B8lvmSRjL4yw+kZbMrcvB6LR9BCmtk//Ckrz631tMMtgir
	 yn37h0iEoM9vlgJKYVSiI/Qv1JgmE5jkX7RNqe1lqkfI9laDHRHviHMBGl3VhYXuwq
	 DmEmOgyNqNJkyOktYlq58ITdMShayZYkDbt4wE8hUYuxdDKgCU44edCD8w5QhDjEnl
	 O6uVMokP4BR1rbEk4e9L3NWqBFqORdADw8WSqFGrYM5dvIpKPgRajwBNYdM8Y68bz2
	 uC3ZQ3kLuWXsw==
Date: Wed, 18 Nov 2026 14:25:42 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: akpm@linux-foundation.org, david@kernel.org, surenb@google.com, 
	vbabka@kernel.org, kas@kernel.org, dave.hansen@linux.intel.com, 
	mirq-linux@rere.qmqm.pl, arnd@arndb.de, sfr@canb.auug.org.au, usama.anjum@arm.com, 
	avagin@gmail.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	trivial@kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] fs/proc/task_mmu: fix uninitialized read in
 pagemap_scan_push_range()
Message-ID: <av20LHgDx5Bu5aqf@gremlin>
References: <20261118093959.1728-1-zhangjiao2@cmss.chinamobile.com>
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
In-Reply-To: <20261118093959.1728-1-zhangjiao2@cmss.chinamobile.com>


You are missing cc's. Fixing this is easy with b4 [0] (the recommended way
of sending patches to mm):

$ b4 prep --auto-to-cc

Alternatively, you can use scripts/get_maintainer.pl:

$ scripts/get_maintainer.pl --nogit-fallback <files-or-patches>

[0]: https://b4.docs.kernel.org/en/latest/contributor/send.html

Specifically, the following appear to be missing:

  linux-fsdevel@vger.kernel.org
  linux-mm@kvack.org
  liam@infradead.org
  jannh@google.com
  pfalcato@suse.de

On Wed, Nov 18, 2026 at 05:39:58PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> PAGEMAP_SCAN ioctl accumulates struct page_region entries in a bounce
> buffer before copying them out to userspace.  The bounce buffer is
> allocated with kmalloc() and only the first entry's ->start and ->end
> fields are reset, leaving its ->categories field uninitialized.
>
> pagemap_scan_push_range() decides whether an incoming range can be
> merged into the current entry with:
>
> 	if (addr == cur_buf->end && categories == cur_buf->categories)
>
> A scan starting at address 0 is accepted (arg->start is only checked
> for page alignment) and page 0 can be mapped when mmap_min_addr permits
> it.  If the first matching page is then reported at address 0,
> addr == cur_buf->end == 0 holds and the uninitialized
> cur_buf->categories is read, so the merge decision depends on stale
> slab contents and KMSAN would flag an uninit-value use.  No kernel data

Are you sure KMSAN would? Did you reproduce?

> can actually be disclosed, because the comparison only succeeds when
> the uninitialized value equals the categories that would be stored
> anyway.

This is too dense, can you simplify please?

This does basically amount to 'no actual issue in practice' :) please make that
clear.

>
> Fix this by zero-allocating the bounce buffer, which also makes the
> manual reset of the first entry redundant.  The buffer is allocated
> once per ioctl invocation, so the additional zeroing cost is
> negligible.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")

I'm not sure even this is valid, since this doesn't actually amount to a real
world bug. But I guess debatable.

> Cc: <stable@vger.kernel.org>

But this isn't debatable, no cc-stable, that's really silly. Zero impact = no
backports needed :)

> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

In general the solution looks fine, but please make sure to cc the right people
and fix the commit message + tags. Thanks!

> ---
>  fs/proc/task_mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 22361607020d..4e552f9db8ba 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -3082,11 +3082,10 @@ static int pagemap_scan_init_bounce_buffer(struct pagemap_scan_private *p)
>
>  	p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
>  			       p->arg.vec_len);
> -	p->vec_buf = kmalloc_objs(*p->vec_buf, p->vec_buf_len);
> +	p->vec_buf = kzalloc_objs(*p->vec_buf, p->vec_buf_len);
>  	if (!p->vec_buf)
>  		return -ENOMEM;
>
> -	p->vec_buf->start = p->vec_buf->end = 0;
>  	p->vec_out = (struct page_region __user *)(long)p->arg.vec;
>
>  	return 0;
> --
> 2.33.0
>
>
>

--
Cheers, Lorenzo
