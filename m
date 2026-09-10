Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FF3793AC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084359; cv=pass; b=onSA9+PPlGQ7ZS4kRKi4RJLCWBHixjUwEGQLesq2hbtHxdRPIyqG2jAXKxKZYuh6atDdi/x9dPsN1tF1bqyMxD+uodLfo+SmOM698aNqZwhgKiA63ERkFtFCR8yF8wBVHKDeeqtYabSZADMl7BODnxuYamYIH1v9/+VQ6HXzKPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084359; c=relaxed/simple;
	bh=gxd9FXzpjEE7MvIjrTJWMqmaXboQI1HI9LnM+PCmHvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3HfMRgdEbJoZHzLljblyLiBMeewd020AyHN4Rg30BICv0T2muNfbrL7FHFBn2Jo+JsCUuAhtsCuTEQQmUdaFdMsIN36zj5ZtpDePUqnhFaidQyEVIykLKInE20wUQs4rBzhbBwDPjKxvHC+EL9wR35erytgxiRiPTbxtXPUnzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Jds34Im4; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Jds34Im4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-86a31708876so243288b3a.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789084352; cv=none;
        d=google.com; s=arc-20260327;
        b=EvKqncRLujSdLgk7HwXTV6KUev4CsP00b/xgImjn76o3HrXBm/Hb9dLK3+Ucrfwil3
         o7KKnDbmtTTzr6ptxUb8AlRpSnm+75ArpWNdcICiykkAax0p83uMilWbcm0/muP99aE/
         +LFhTKllj0gLKEZnmrB+DEjwunvuSOps7WvLjVSfCEacPG3V+umcltyceEps67TvrJQ4
         t28HdAnqqMIfR8S5kCT96gmFKohnvzn/QdJPiUutHra4vKFLxMCDZoHm+Ftl7A7UJDO1
         kI0wTbfdbFFi60HiB5Elnr0uUAOT3UwHX0t49W0gWgWMyqqn/flxA3x3EYptMY304iT0
         5nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NdnRvtVpKeaWT0ZN4s5Z5A0W0nAd0cRp7qQ/CRHsFmE=;
        fh=TZp/Uf6A8UoNdwBQY15XPmrmH64aJQPQlQmerKbkEGo=;
        b=VJ3jxM5WDd4+j+Wihf7tHrN+SPF6k2tmvRRiLVXorsDjZLI5PuFRuyjHTFKtRIJK9H
         DPS5mY8zz9Odv0ZSMkHdIxW5C4xYqISLQJa9nVRpDamKb2rrD8+mLVQUH9K8TVNIF/4y
         XtZpqsKlYon4+6ek3Eikga8MPodLVEMTxAj8yqow35jLYAwO/FSHWHIoLOll/r1EqKhU
         yZte9L2Khww9kHKZgOlfnC5kejGd/Q6GAbFdIHpg7URMAiOguISJmgu+EC2nlmNhTjq7
         k6jISTA5LfVbErfDwmgmThoztsiZb9f1bOP8AAjCCoMr3H9/HMD2yaT6at5aLUJzrY1r
         H1Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789084352; x=1789689152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NdnRvtVpKeaWT0ZN4s5Z5A0W0nAd0cRp7qQ/CRHsFmE=;
        b=Jds34Im4aCwqXPzNBr4bwci5iYEaCR+kK2U7cCVc6cVYN3BFKCex4HvuSopS3st5jp
         rv0u0TpW47eFpm6qug9+elTAy2QJgSTaHjWm7DWQS5/GE76pJ6N4AuiqYiL5OkWupbEH
         5ewTEaQPp9+nvFyjPB6vxRG2AXyFJFFZ0J901OwZjM1fCYkjtpv8pwFZLFgHTOanxesu
         vL1DjRHQTK9KC6szD6/ZVAcWf4wU1cikSBcGAssBjPwnwNJJrGMxvzNT0k7i5i1tEUK0
         jCXofabmHJ3CMZngxuGxgJnUe/rwPKsbIAB+ydNTcX0zVRf10c8QFB42T/yub/LvUMzB
         894A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084352; x=1789689152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdnRvtVpKeaWT0ZN4s5Z5A0W0nAd0cRp7qQ/CRHsFmE=;
        b=oT/bbNO65pLJLQpVqlMFUjNZddiOXwlp/+5nclprZcnagjlz1jG382t03UFAIBIDwM
         YGuH8ql0PeDoj68kMyyU4e2pTZwtTYDMHuT/IAF9edHyGZyGBXszF+mz/dH2lVBuf77Y
         qCZfbeGVd2mtYFxsULXLYT4R/pZqaeS+Pgabfqujm7hvqS21v2y/KMeIvo6C6nyMbrsE
         5c/Nj5gB7P5X52X8Dn0efq6QtfgBReJkq1m6Tch1gFHWEifN3sCBT/IHEcfEm8J5aD57
         QPKJv1Vw5SJdlTFyCoXfx8ceIqSoQN/9sge43Cw2z524uKdrF03KD8c0aHap+CX15WuI
         W0nA==
X-Forwarded-Encrypted: i=1; AKwUvByqeyhewqVju2LaowMaTQ7SHpD46Wdk4TOEJCg8NXYOEhFiiJ3BkRLxOkMfXGbSXF0rn2WXXzM=@vger.kernel.org
X-Gm-Message-State: AFuF++nzuKGWRPfQSpZJPELsLhkQEhrbhR11niKepQvQO+JvDBy8pwJ/
	ltDIss9VYhJVeDRf5IYf3ADTvoTn4BARSw78MnXbeqytIWkN4HTYxO4hrN5IP65u6fEP/NOSnBx
	7ymjeSaylguk1C9QIEqajtF2bfVfaCx/WJwuBqTbU
X-Gm-Gg: AYBFou0pUEXKWjn7O/mgCNO4ji1xbym8+FteOs99C6KZr27IEFeQR6WDa1CIUPCyXGB
	bQIpkZDXfASaIbMIazo4zq+mxvzS5eintLadBSq4HziyUfuVvy65omB2cp4SLYsdxwa7P2x23MI
	05zxgUZRmrEx/60ysZoJ+aUtbGTG2RU6nXgeihi35IQ4mfrYb4J+YQWWyX6OyndREo5sixQVMY+
	LVeKW9AM0Bt/GJ6gdZJHdy89m/ZlNX8SUfGH1CupMb26BHUkfbpwgnGQlJbf5aS7gUIG16+SeXO
	HqIXq3/0ReJ/4w7RJd0N/wFTFmfFfihHHenhxKasdoh+chcTWOqlJcJC7cyJMgznNsewBrtjlQP
	NY9JSuTiupMnEKdF69i5wlA==
X-Received: by 2002:a05:6a00:aa07:b0:85f:b00b:8760 with SMTP id
 d2e1a72fcca58-86b30f13aecmr2172804b3a.5.1789084351986; Thu, 10 Sep 2026
 16:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910022442.3594649-1-xmei5@asu.edu> <CAJnrk1bVwezZwMFmOE-4T6KTa5SzQFapkATS2LVeo7+bMcjdbg@mail.gmail.com>
In-Reply-To: <CAJnrk1bVwezZwMFmOE-4T6KTa5SzQFapkATS2LVeo7+bMcjdbg@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 10 Sep 2026 16:52:20 -0700
X-Gm-Features: AcwNN1Wt4X8PS2HRrjI9CWe-1228S10-2EjcXULM81Hw8G_R71GCSrBJ2wPt8_A
Message-ID: <CAPpSM+Qd=yEc=NsuK_fE12KHH+qnYvvHLFUs6fvcw0SsfP8tcQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fuse: don't BUG when the copy buffer is exhausted
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:22=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Wed, Sep 9, 2026 at 7:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
> > runs out of pages.  Over io-uring the amount copied is not bounded by t=
he
> > payload buffer the server registered, so an unprivileged user can drain
> > the iterator and panic the host - mount a FUSE filesystem with small
> > payload buffers, then setxattr() a larger value:
> >
> >   kernel BUG at fs/fuse/dev.c:1064!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   CPU: 1 UID: 0 PID: 148 Comm: exploit Not tainted 7.3.0-rc1 #2
> >   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1033)
> >   Call Trace:
> >    <TASK>
> >    fuse_copy_args (fs/fuse/dev.c:1354 fs/fuse/dev.c:1380)
> >    fuse_uring_args_to_ring (fs/fuse/dev_uring.c:891)
> >    fuse_uring_prepare_send (fs/fuse/dev_uring.c:940 fs/fuse/dev_uring.c=
:1057)
> >    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1745)
> >    tctx_task_work_run (io_uring/tw.c:96)
> >    tctx_task_work (io_uring/tw.c:133)
> >    task_work_run (kernel/task_work.c:233)
> >    io_run_task_work (io_uring/tw.h:84)
> >    io_cqring_wait (io_uring/wait.c:278)
> >    __do_sys_io_uring_enter (io_uring/io_uring.c:2676)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:61)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >    </TASK>
> >
> > The reply path can drain it the same way, via the server-supplied
> > payload_sz in fuse_uring_copy_from_ring().
> >
> > An exhausted iterator is recoverable, so return -EIO.  All three
>
> super nit: imo, the reason for returning -EIO is unrelated to an
> iterator being recoverable.

You are right.  Also added the comment you suggested on the -EIO mapping.
Both Reviewed-by tags are kept in v8:

https://lore.kernel.org/fuse-devel/20260910235110.3922068-1-xmei5@asu.edu/T=
/#t

Thanks for the reviews, and for steering this to a much simpler fix.
Xiang

>
> > fuse_copy_fill() callers already propagate the error.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Thanks for your patience with iterating on this fix!
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Thanks,
> Joanne
>
> > ---
> >  fs/fuse/dev.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 4fec31fc0b84..4148e4488d77 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1061,7 +1061,8 @@ static int fuse_copy_fill(struct fuse_copy_state =
*cs)
> >                 err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE,=
 1, &off);
> >                 if (err < 0)
> >                         return err;
> > -               BUG_ON(!err);
> > +               if (!err)
> > +                       return -EIO;
> >                 cs->len =3D err;
> >                 cs->offset =3D off;
> >                 cs->pg =3D page;
> > --
> > 2.43.0
> >
