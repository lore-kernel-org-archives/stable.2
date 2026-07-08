Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7282F385D97
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552119; cv=pass; b=CB7rCNihyxWnDgAtjrzl9oTPLLsusOSbkdQWtzlQkQ0vE7mZI+DJSmRKNh3mhRUQWLAANBzf0w+f1sMD9iwUw3+u98e7bOytsOW//oQiXA4eHp6Xg/K7Rs8TwUGYcOwE1hDwDRodpnmpZY4SOUFFmfzlwdBvX9IvrZbPhZt/JBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552119; c=relaxed/simple;
	bh=5oDhM3CQ9FQQnfBEe8EqsSS7V5h57dHoN7VUrpoxS5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX6kNdYt69cJXhPC5tkjXWf7UnXzvkvXxxaLh7qL/fI/GFewORkaW6X9mFLu9lFOtzT9pFMq+VOedP5wRjmO+KvB0xNkeq04O+iqvjdd3AH+rEPsXCURQvzATdt4t9w3jzftSopmI11m789dHcigcfhsw082Vwg86M8AkfmwFqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTMITSxf; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTMITSxf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c733f15aso3166205e9.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 16:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783552116; cv=none;
        d=google.com; s=arc-20260327;
        b=mSjXLEFohHXgVQppov3SW0xiiNvQQ9PTKBlDDAHUI2jx7x84NZKrFcLhHI6yWdSSIl
         KAMjjeSJQdjCOCWVISMAIPhbvTs5owSPwpPZPGKf1OdBHrM7tHpzaN5O9N6J0JF6dgdZ
         gHnyPnM1ISUb8loU9HwgPLlu28LKDnf8mS60rMMpNFSZiN0PO7dwRy5N6JTDNdpqNKC6
         gQyS5IlqHO3ey5EnQMtOVdTqKNA12XBKocPt8thcgokcJSATDbNehKAdzWLegjtCnJMK
         JI7vEWaT9XEfFGa3j/QXLBHEWmMZrzzhsa+kOvKFLfvDP78AVhxDJM+XFeD+sbALBYi+
         tCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMeLfN37Sih0DPM+5bwgFixJafUbOgpeRhPzslYTy8w=;
        fh=M++shEKpbxMol4ra6XLPco+UyzfLzh6UZm1KCZfuL8Y=;
        b=bftEb9ZOLIBGZ6qkw5LA1lvuGYGyX2t79x/QQ8/6RArFjqWEvHlSsce3byWqf0yb+p
         p9cyCMiFelgHY9oY3PNIdx1Gbdo/h9AG6ukBuWdj0F1UH+iaBh502lEX8NIfetyeRVy+
         CQ5/B9DIrO6fkychjZF4H/lSnTYifvOG82qGSNUByMin9btYWdJGtn2GcFxUwo04zg9I
         FwkxZTYlIRfXbfF9BQkqY1TRZXEyhV68qFH/GHopad3emYIjueBAuGHiv3cscUUX5d3k
         bHAK2meqSeh0TESFyU0NK1cPXSMt2YmDLlWMVsvM++P8pXtgTw1MyG/kxujSTep/GKTK
         hpUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783552116; x=1784156916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMeLfN37Sih0DPM+5bwgFixJafUbOgpeRhPzslYTy8w=;
        b=aTMITSxfwtH0g64Ncab6mt0Kq1LH6NVIP+zFIaKYvfb5zb2NP2U32HtWtRZYicLqeb
         Z/ykoCFNZ0wB8DAIkR+zIrFJWJkuDRQUd4Cs+/5hGxuEeUw8FxJvFUBDDLqef4mqUkSB
         x7ceLgpp2uzPvsMKX7vQEQmI7HDQakFulD6ewv6ToG4V8PPONBO9J0lFMZsvLVySDTkl
         nxJk1mKXmVvumvtsKM6FQSzBntXZ96kGeAavgVL7xgj+MFjzLyMYUIP+h35T/s8ve1W0
         eUvD+4zObP5YrQJAHAmy/G+flltMD0cp5tN/ewlHfysA7EjRfFu2Vrn886Se5cNuNr9/
         1OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552116; x=1784156916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMeLfN37Sih0DPM+5bwgFixJafUbOgpeRhPzslYTy8w=;
        b=ckAAFKX6Y1zGqnqbxN1YN3DP9FJ91129+CJG8G399XLiZhDU0pWJI0qX3xydM8JSm4
         gkcsbCTP5+lvXa4P3EP0ogBGF+5NYgUgQw6znW/5OlweaX5y7GcxL2Fu3B5kHozENhTE
         rRe82lbugxxllBm7dmpYh2lx4EHXfPUv48Tczw42cLvGCUaecal5zw18lxuo4Gr1iw7E
         /m9mrI3K8nfKOvoLk9N8KOuaWHYWPxqqS2Pi1uh+PRNS9Okv8g8Qn0mOUQIfYGQrTjgJ
         3Q0vr3M8+QDK8+wCBAkDC2Zxl90UCFMnP7qSRlIjdR7vOWLwYFu/a5U1IUqkr8CA8wjE
         hVkg==
X-Forwarded-Encrypted: i=1; AHgh+Rraa12jJb5mzLcsFf2BdpLOM2BzHe37A5e+32BWDPCujh9Hng+/3dqz1YC/8LLVGTHvqbodDXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2rT4hrb+5QFDeCMXTdm7dQCMIeMQwc1akxyGlSP3mXeAVygp
	CpAqeaZt0qd/XCp9MIidTrgrFFKtH3KPvfeRxe6UJN+L9S+oBNwT2ugN9ULbXu5Cqk0wAV+2hNN
	OHgTg19RkUtgXKNjpSkf1oNKV2eGoDh8=
X-Gm-Gg: AfdE7cnxjRoKt5Sn9i3uZL2wGB9MTLXfBuy2rvAhkV2OO3mPYku+gIFTGq7BHqP37le
	Jp018EFkd6kdg7F5W85BplyllWxkIKSW3hvkWV35BRrfpC3XlooVYbA4QOMeiwORR8IRme7Oqr3
	da9r6JFaR8InrGtypCnTyPTk//TSrV0sYvIsH8xd/yQCsCA10V4lVvwCXHYRqZiawSDSToNhaTv
	sOhVMD6e8RJN/P3n8aqBDmJoBF3FCK6WmsKt5k+H5MjuasvA0M6eypHSrHzhQPuZbDleaLwY4aL
	gDEDdLLBQgs+rbi8AzWjp5damfXHdupRciglcawUdCFSEBcChIcJ
X-Received: by 2002:a05:6000:2c04:b0:476:681c:4642 with SMTP id
 ffacd0b85a97d-47df07a8280mr4872351f8f.44.1783552115565; Wed, 08 Jul 2026
 16:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707184417.3682270-1-xmei5@asu.edu> <20260707184417.3682270-2-xmei5@asu.edu>
 <cf0574fc-03d8-4b0b-b1f4-bbca59e31686@bsbernd.com>
In-Reply-To: <cf0574fc-03d8-4b0b-b1f4-bbca59e31686@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 16:08:21 -0700
X-Gm-Features: AUfX_mznvTOiu1WXGWnG-l27X67eb5f5IdTOyMIwpjkQXYTLtlxgDSIJfN6t9Jw
Message-ID: <CAJnrk1Y3bkDtztsXdF-3JL0tqxhaarriKCvO4-N3-QrL6X_4oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: reject oversized payload_sz in fuse_uring_copy_from_ring()
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Xiang Mei <xmei5@asu.edu>, djwong@kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, stable@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 12:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> Hi Xiang,
>
> On 7/7/26 20:44, Xiang Mei wrote:
> > fuse_uring_copy_from_ring() imports the payload buffer with length
> > ring->max_payload_sz but passes the server-controlled payload_sz to
> > fuse_copy_out_args() unchecked.  A larger payload_sz drains the iterato=
r
> > to exhaustion and fuse_copy_fill() hits BUG_ON(!err), panicking the
> > kernel.  Reject replies whose payload_sz exceeds the imported buffer.
> >
> >   kernel BUG at fs/fuse/dev.c:1053!
> >   RIP: 0010:fuse_copy_fill+0x6c6/0x7e0
> >   Call Trace:
> >    fuse_copy_args
> >    fuse_uring_copy_from_ring     fs/fuse/dev_uring.c:686
> >    fuse_uring_cmd
> >    io_uring_cmd
> >    __io_issue_sqe
> >    io_submit_sqes
> >    __do_sys_io_uring_enter
> >    entry_SYSCALL_64_after_hwframe
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> > v2: add: Cc stable and Reviewed-by tags
> >
> >  fs/fuse/dev_uring.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 0814681eb04b..f6127c230dd9 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ri=
ng *ring,
> >       if (err)
> >               return err;
> >
> > +     if (ring_in_out.payload_sz > ring->max_payload_sz)
> > +             return -EINVAL;
> > +
> >       err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &=
iter);
> >       if (err)
> >               return err;
>
> Good catch and sorry for lare review! Hrmm, it just gives me a bit headac=
he,
> because idea for max_payload_size in fuse_uring_create() that it prevents
> exactly that.

I don't think this is related to fuse_uring_create()'s
max_payload_size. The problem this fix addresses is that the
ring_ent_in_out.payload_sz header value returned by userspace can be
whatever arbitrary big value userspace wants to set.

Maybe I'm misunderstanding what you're saying, but i think this fix is
orthogonal to the setxattr issue you mention below? afaict, that one
has a different root cause (unbounded in_args copy coming from the
kernel side when sending requests vs. trying to copy in an unbounded
server-set payload size when handling a server's reply).

>
> After tracing through the code, I think we have two cases where max_paylo=
ad calculation
> in fuse_uring_create() is not enough for xattr and ioctl
>
> For xattr we have an additional in addition to the patch above - it sends=
 unchecked
> against max_pages and  fuse_dev_do_read() has an additional op code prote=
ction
> that I had missed

Nice find, I didn't realize setxattr had a special error value either

>
>        /* If request is too large, reply with an error and restart the re=
ad */
>         if (nbytes < reqsize) {
>                 req->out.h.error =3D -EIO;
>                 /* SETXATTR is special, since it may contain too large da=
ta */
>                 if (args->opcode =3D=3D FUSE_SETXATTR)
>                         req->out.h.error =3D -E2BIG;
>                 fuse_request_end(req);
>                 goto restart;
>         }
>
>
>
> And I think with the current patch is incomplete and missing something li=
ke this
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 77c8cec43d9c..449b84ac24e7 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -725,6 +725,14 @@ static int fuse_uring_args_to_ring(struct fuse_ring =
*ring, struct fuse_req *req,
>                 num_args--;
>         }
>
> +       /*
> +        * A FUSE_SETXATTR value may exceed the ring buffer; match
> +        * fuse_dev_do_read() instead of overrunning the payload iterator=
.
> +        */
> +       if (fuse_len_args(num_args, (struct fuse_arg *)in_args) >
> +           ring->max_payload_sz)
> +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +
>         /* copy the payload */
>         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
>                              (struct fuse_arg *)in_args, 0);
>
>
>
> And a generic patch, but that has the potential to break existing userspa=
ce is
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 449b84ac24e7..d25d7922bbdd 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -251,7 +251,14 @@ static struct fuse_ring *fuse_uring_create(struct fu=
se_chan *fch)
>                 goto out_err;
>
>         max_payload_size =3D max(FUSE_MIN_READ_BUFFER, fch->max_write);
> -       max_payload_size =3D max(max_payload_size, fch->max_pages * PAGE_=
SIZE);
> +       /*
> +        * A max_pages-sized paged reply may be preceded by a fixed op re=
ply
> +        * header (e.g. FUSE_IOCTL); reserve a page of header room generi=
cally.
> +        */
> +       max_payload_size =3D max(max_payload_size,
> +                              fch->max_pages * PAGE_SIZE + PAGE_SIZE);

I hope we don't have to do this because imo even with a feature flag,
it gets confusing/cluttered. What about just having it be the
responsibility of userspace/libfuse to allocate a big enough buffer to
hold ioctl reply headers if they want to handle ioctls that have
max_payload_size amount of data? On the kernel side we'd just need to
store the buf_size value the user already passes in at registration
time and use that value for the import and payload-size bounds check
instead of max_payload_size which seems like a pretty minimal change.
If the kernel insists on the + PAGE_SIZE headroom, across lots of
queues that have lots of buffers each, I think that memory waste may
add up as well :(

I think with bufferpools being the primary interface going forward
(not sure if you agree with this, but with zero-copy and other
optimizations being gated on it, I view it as that in my mind), the
ioctl issue won't be a problem since the kernel can allocate more
memory than max_payload_size to that particular request from the pool.

Since they have alternative solutions (libfuse or buffer pools), maybe
we don't need to bake this in here?


> +       /* getxattr/listxattr values are bounded only by XATTR_SIZE_MAX *=
/
> +       max_payload_size =3D max(max_payload_size, (size_t)XATTR_SIZE_MAX=
);

afaict XATTR_SIZE_MAX is 64k, so if a server deliberately sets max
pages to a very small value because they don't have enough memory, it
seems counter-intuitive to force all their buffers to be >=3D 64k. As I
understand it, the vast majority of xattrs are small (tens of bytes),
so maybe better to just let them proceed and return an error on an
oversized xattr than pay 64k/entry in every queue? If they really want
to support 64k xattrs, then imo it should be their responsibility to
allocate a big enough buffer size for that.

Thanks,
Joanne

>
>         spin_lock(&fch->lock);
>         if (!fch->connected) {
>
>
> Question is how we could add it in, maybe with a feature flag?
>
>
> Thanks,
> Bernd
