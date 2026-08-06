Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BB3839BD;
	Thu,  6 Aug 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030183; cv=none; b=m8hwp2SjmMN2iW79DrFcoumbseFx0rviUJ+N2r1gMSdqV3Bl2U+wUNT1sesZvkWas6JHEuInBgg4mpT7ef9sBYOhUx+NzV0EiFZmC9XxsfpRvgBUXTWw01kAUa3eD+r1yOtC/lRBK34c0XYw3rvcPzNHelOzmKBCx53pZX/GLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030183; c=relaxed/simple;
	bh=kqrTdqTxsSFEwpyxOMxu0i2WeLbZuurMpbJw2mE/1VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo73wOcVr1PZn2ERo+2+WpsNlIJbnZu517GB7gfPx2U9Fo915RZe3rT4fglzQeRHB6HRrRzzdmGkon2r+7WHS+ltsNw2n8x2/Qrj1cLIL2QnGn+gTrE9lEdWlt3XfSaS6D6YJ4sQ0dKP/zkAxZhhAfRAb1BIQYyobV3iF1XNrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HX5OBluE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HX5OBluE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E711F000E9;
	Thu,  6 Aug 2026 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786030182;
	bh=1xeD69Ldhyg8SF15ND4Gphd2g+OF9/6lMyGYU7KCDWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HX5OBluEaWkJ1hu+TlG/xqt6fb6mWLDWakkoRaYVnqEbPf/J8cGl3tAnhLUoNOhxN
	 eLUYaNnh9iyNjcm+DyWumHt25eCbmvQk8KIYVr37B+LZJkn9RquzvhAeHP1V75xDpV
	 t7y7IT8Lle+KfPang7lrvgakqj4T8DxNIj4IU0jo=
Date: Thu, 6 Aug 2026 17:29:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xk c <shinnkka1@gmail.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Fix memory leak in io_wq_create() on success path
Message-ID: <2026080636-financial-iron-4bd9@gregkh>
References: <20260806142314.557312-1-shinnkka1@gmail.com>
 <2026080644-suffix-earthy-2f30@gregkh>
 <CAGeKw7JFxZ6QBg_p6ma2NjPMBe5utoZ715z3763d0qH=uLehYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGeKw7JFxZ6QBg_p6ma2NjPMBe5utoZ715z3763d0qH=uLehYA@mail.gmail.com>

On Thu, Aug 06, 2026 at 10:47:02PM +0800, xk c wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2026年8月6日周四 22:33写道：
> >
> > On Thu, Aug 06, 2026 at 10:23:14PM +0800, Chen Xiaokun wrote:
> > > The commit 657ca82526d0 introduced a temporary allowed_mask cpumask in
> > > io_wq_create(), which was freed only on the error path.  This caused a
> > > memory leak of cpumask_size() bytes on every successful io_wq_create().
> > >
> > > Fixes: 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io worker")
> > > Signed-off-by: Chen Xiaokun <shinnkka1@gmail.com>
> > > ---
> > >  io_uring/io-wq.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> > > index 66fdd69fd6cb..34a1a9067cc2 100644
> > > --- a/io_uring/io-wq.c
> > > +++ b/io_uring/io-wq.c
> > > @@ -1218,6 +1218,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
> > >       wq->task = get_task_struct(data->task);
> > >       atomic_set(&wq->worker_refs, 1);
> > >       init_completion(&wq->worker_done);
> > > +     free_cpumask_var(allowed_mask);
> > >       return wq;
> > >  err:
> > >       io_wq_put_hash(data->hash);
> > > --
> > > 2.55.0
> > >
> > >
> >
> > Why is this a stable-only patch?  Was the backport wrong?  Or is this
> > also in Linus's tree?
> >
> 
> Linus's tree has not this issue.

You need to explain why, in great detail, Linus's tree does not have
this problem in the changelog.

For example, try answering the questions I asked here, that should
provide you a framework for what to write.

thnanks,

greg k-h
