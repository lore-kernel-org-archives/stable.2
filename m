Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88B43E08D;
	Wed, 29 Jul 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313780; cv=none; b=LLV85UOZ/5LesBeepg26Q+B9vK8tck4/gVKxYxK6Ibw5iPiVZVD270aEqvdDAftmTtLrnB3nsfZ9Q9zHokiGgGhdV4ckIe1QTs4nbppHh/HN5z1vvZG9W/SLDcdYORjRXZvosIxv+vUXAkZqxVp/3/deaPobLILBo76DE/ieK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313780; c=relaxed/simple;
	bh=xu+lZ8hVpR0bAOa+Gf7ziJ02+uwLLIQO8uBArGBWEXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEGj1EG8wmBafgLzPvQGs0D/EStyuPpzagtwH1ZLLCyjCT9nfi7c6Wefle4pJAxJPPbM6qQj087Tmd/t7VPd5ZzQ2y6d1hyQsgtDqXyZYij+HAjr7iPo3Eujey/AG5NOwKGg3XRusSBs3CLb0aO0amchY5fZdCVLozr4TKsJlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYnuj248; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYnuj248"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A16B1F00A3D;
	Wed, 29 Jul 2026 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785313768;
	bh=Cfu1N3tOE1o/Oy/YjhHFNvRrezJJT59H45jMYiDUFZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYnuj2481EO6tOKiNtVbIF9jpqnq3xV89fY5FM6DpElYawOZswy1FBtjU2Oyd5wgn
	 x0o64AR0t+hMIKTKegnRK0T5lN7FRAxaYjZt9xa869iUheSlc13Ft4kCkydDXtWWgL
	 nV/I9yKpSeLGm5yCikQIn7Qxij0tHybxGrYO6+ig=
Date: Wed, 29 Jul 2026 10:29:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Feng Yang <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org, stable@vger.kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org
Subject: Re: [BUG: 6.6.y] bpf fentry hook on _raw_spin_lock_irqsave triggers
 hard lockup
Message-ID: <2026072938-broaden-curator-e89d@gregkh>
References: <20260729075322.628521-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729075322.628521-1-yangfeng59949@163.com>

On Wed, Jul 29, 2026 at 03:53:22PM +0800, Feng Yang wrote:
> When attaching fentry programs to _raw_spin_lock_irqsave/_raw_spin_unlock_irqrestore on
> the v6.6 kernel and using the BPF ring buffer within BPF programs, we encounter a hard LOCKUP.
> 
> Reproducible BPF code is shown below:
> 
> static inline int test(void *ctx)
> {
>         struct event *event;
> 
>         event = reserve_buf(sizeof(*event));
>         if (!event)
>                 return 0;
> 
>         submit_buf(ctx, event, sizeof(*event));
> 
>         return 0;
> }
> 
> SEC("fentry/_raw_spin_lock_irqsave")
> int BPF_PROG(aa)
> {
>         return test(ctx);
> }
> 
> SEC("fentry/_raw_spin_unlock_irqrestore")
> int BPF_PROG(bb)
> {
>         return test(ctx);
> }
> 
> We suspect the hard LOCKUP is caused by the call chain:
> aa->test->reserve_buf->_raw_spin_lock_irqsave->_raw_spin_unlock_irqrestore->bb->test->reserve_buf->_raw_spin_lock_irqsave.
> 
> Mainline has merged the rqspinlock patchset
> (https://lore.kernel.org/all/20250411101759.4061366-1-memxor@gmail.com/)
> which resolves this issue. Should we backport the fix?
> 
> Alternatively, would a fix modeled after this patch
> https://lore.kernel.org/bpf/20201029071925.3103400-3-songliubraving@fb.com/
> as outlined below be viable?

Do not do stable-only patches, that's not how the stable trees work.
Fix the issue in Linus's tree first, and then backport the needed
changes to the older trees.

thanks,

greg k-h
