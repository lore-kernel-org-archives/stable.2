Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAAB18C2C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073754; cv=pass; b=d7hqHeIkNnQs7ehVGnjknUSPAxvP2ZEkfAqMLmVepL1ForqFqJjjBvfBMYqOSrPgsty9kCBjoPZD8A8G4ZGlclZCdAVBnXqPS4sxSmha5J5XgrxUEmdtL4pBE3OfbrYrKLPEwBWsjtBiDtRZVvvUbr0ugEab778icH36gxxQT1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073754; c=relaxed/simple;
	bh=h+FfThwhAtsKLjTsiDbJn8yrjEOO6qbw5Lehz7z8BF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVMVN+CZ9SU1fkilxwW4azpXgu6N1VW5x23v/3CWb5zzjZkAPYX5R9nqSNhcqnnmBsIcj/DOB7oM4PVxj2TdocvN8fl/de3YKNz/VlCLd04TetLnV129CJeCnr2Nsna24AaWHuQD2V6ZhL2GdDJIPjuQCflRf33E3/jNyjp/XRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=F/kK9AfI; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="F/kK9AfI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1675390a91.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073752; cv=none;
        d=google.com; s=arc-20260327;
        b=gqjMLGmyiGAPH2KvLHhDS80kCPRUkaH+5LBGrp0lshzAXfzEsE1IP51pRbxiSSFXi8
         ORl3pf+G6AvnephA4zyVEo9dZbeFnWPjvpwOaKobAHXsuZqgyHK1lrI/s3SGRBLIRwpS
         xZYFvBJxISc/pqK9s9SiKYR2guzLsG3mP0WiRy1+xIwB0qd26dNojX8v2+FLy3g781De
         NnA3ekTW9oRF6njGW5XGB3JYlQa8DRR+ihQMUgYsCE3A5mT+6pg3A2nEhYW0503/lZfc
         mYNoFugEAfflZn97yB4VfJDsduPzUrHx7J8cMC6QEyOy+6+CtAjKk4No0FjN0G12rFQ7
         Ygew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnuTjnmFgMfuo6740K3Eupo1lRWLWkcBXrjIjKbCV6Y=;
        fh=/f6s5dtrNFXd1oDWqPhDrzAkGXDjiNGyxcJ44bF0T/0=;
        b=Hmo+5SLKdO0t8jh+Clya/Qw2WPtUqq729AnEkI5JgUWnoSHWul7mFJMOjqSlcBZVDB
         lLNCA+Klizubp5l0yQz8P5ugxK8hIA0nKJfRoinYBU2UgboLpmMdk92lzo8OOwQJx/GL
         K38wd/73CqUu/CNPv2nDDgkdbzP1gbxcoxElHEU8QJ3k5lQ+CD90T+k6eMp+A8vqV2Co
         dktsH66aP7S+xEG6ID2KzKMqyvvw6aLh9kgLEXx4P3kkdV5VHenzTxvGeWGDqXTzN1Q2
         jEQjx9fxwbXOV9vNET5lXQBqYNFmEeM4pNc+6D9gO3fHYJCS+RECygjq0CbTcXRSpIoe
         t8ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073752; x=1784678552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnuTjnmFgMfuo6740K3Eupo1lRWLWkcBXrjIjKbCV6Y=;
        b=F/kK9AfI6vcRzpxycO2Wvfng06ZYk5cYEBGtI9uEeOFrR1P/j5IC5SlUIAQJLZcYJh
         6AFx/y28yX8TOwo787sxZOmYnTigdNrd+ZEKKHHaWKW4fuJAzJoxdlpOyF7m6lxQYxrx
         vMpTJIHt6gRWzyr05dXyTIGJKR+gn78fmye/wfdw9FO87vAbjpUZgwjqQtCkF60E7X30
         mduuMbvwTcu1/kSc7Z2PoMs1wB3XO1z3xCuVPG5OWiAqL/tu6uimDL+ZYs7md1zBw6e/
         5y8gGg94xTPOcitj5OEf1zvRS7zFdCeSJwfdiNUrDWvDMY9RFyAUn0aHn3rNjeo80LHW
         u6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073752; x=1784678552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnuTjnmFgMfuo6740K3Eupo1lRWLWkcBXrjIjKbCV6Y=;
        b=jicZPMHYtiQtYx40mFTVtjGmLSd4YTJm8nW/LFW8gfG5iE6b/3djpg2l+vOGDFbeW6
         kJ8UXPkh1DUzJ6iyjG7ZEsClpxIQyzagBAIqwxLsWtCvOk2Hlb7ZmlvJr1Z4alhBxPlp
         y42QkoDY3Z9LgzJBx8+iWKjuXWuhbxxyg+tJY8V19xGWSVLJGyKZ2lzEte5vwWQXGjSl
         10Yb5P08RHP/tzOWqm0FSkobozszTjtlP/GFVbK7nFkdsmfYf0iTanEZ0xFNxuTQhAm8
         JP/b4Lkni7ljU5jrb46yzCOT9Y38hN9lyrtfVtGiuHRMFVtR5zL9L6zI2yg7AdnUNyWx
         MSjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWI9s1cC2YcHAUUBlWH2DJQn1e35pxsEkkDSfqlf2gQsr7wm+NMosIr45BV5uvwGPehREdOJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/1Qlbc3CBxoYjrGRwW6asCbI00zLZPsfvBtp33KUyubFotEM
	dOvIq4OAJfVoFUmY0WvnU9IQ3wo17CWnCVq2dFL8VYK8VFK4lZiVilMvnDLmpuwdmxTy+DC0W2T
	LdIBjVrBWmHu6iXkr1slGxyqpuzN+d7rgSeH5Q+bj
X-Gm-Gg: AfdE7ckme/tV58jeGIq5OIUP5EqkkV27KI7/3M3bPRd+ZQw4dPdo1ZZaw8PCeiQEkWk
	rLiuVX2c2ks7yVRgtABqgtaTX15gldCjRq064RB3AMrC/rQ+2Md8uxk1Ixg9Q+5/x/f5E5EOYID
	zNN3PKsnYR4KpvkBPhMTTB0XgQYVuXl7moM3lPtm2CtxCJTvsCSPtWDYH7zFBrbJsYV9nuTp23S
	4/ddOskCaJ1TkeaC3dohlKfYhWrzUMPBdSXOYT5gY8uYMBmnCcA2wljmiRQ2aewC8y4u89V
X-Received: by 2002:a17:90a:d888:b0:38d:e442:901e with SMTP id
 98e67ed59e1d1-38de4429227mr11151009a91.27.1784073752604; Tue, 14 Jul 2026
 17:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211130.543773-1-xmei5@asu.edu> <20260709211130.543773-2-xmei5@asu.edu>
 <CAJnrk1Zek9hHOehCjfmR42+Gc=K6vixmyn5977ZHv3J5fUUS_A@mail.gmail.com>
In-Reply-To: <CAJnrk1Zek9hHOehCjfmR42+Gc=K6vixmyn5977ZHv3J5fUUS_A@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 17:02:21 -0700
X-Gm-Features: AUfX_mzd0bNUZ1WrqBewM4QFIpp6lYAazaXnydYq8-EXrZeSN8zxpdJ6-98A3gA
Message-ID: <CAPpSM+QQ0BRuVizUePYBj9+UJC0Sxsg1RpEa_u1woShg-TkRhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fuse: bound io-uring payload copies to the
 registered buffer size
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:24=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Jul 9, 2026 at 2:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > The fuse-io-uring transport imports each ring entry's payload buffer at
> > ring->max_payload_sz and bounds both copy directions against that value=
,
> > ignoring the buffer length the server actually registered.  Both the
> > server-supplied reply payload_sz (fuse_uring_copy_from_ring) and an
> > oversized request payload such as a large FUSE_SETXATTR value
> > (fuse_uring_args_to_ring) can then overrun the imported iterator and hi=
t
> > fuse_copy_fill()'s BUG_ON(!err):
> >
> >   kernel BUG at fs/fuse/dev.c:1053!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1022)
> >   Call Trace:
> >    fuse_copy_args (fs/fuse/dev.c:1329 fs/fuse/dev.c:1351)
> >    fuse_uring_copy_from_ring (fs/fuse/dev_uring.c:686)
> >    fuse_uring_cmd (fs/fuse/dev_uring.c:1226)
> >    io_uring_cmd (io_uring/uring_cmd.c:271)
> >    __io_issue_sqe (io_uring/io_uring.c:1395)
> >    io_issue_sqe (io_uring/io_uring.c:1418)
> >    io_submit_sqes (io_uring/io_uring.c:1649 io_uring/io_uring.c:1934 io=
_uring/io_uring.c:2057)
> >    __do_sys_io_uring_enter (io_uring/io_uring.c:2646)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall=
_64.c:94)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> > The request path overruns the same way, via fuse_copy_args() ->
> > fuse_uring_args_to_ring().
> >
> > Store the registered payload length (payload->iov_len) in the ring entr=
y
> > and use it for the import and both bounds checks, so the buffer the
> > server provided is honoured and an oversized reply/request is rejected
> > (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> > fuse_dev_do_read()) instead of panicking.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v3: propose the patch fixing another issue found by Bernd by Joanne sug=
gested way
> >
> >  fs/fuse/dev_uring.c   | 9 ++++++++-
> >  fs/fuse/dev_uring_i.h | 1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 0814681eb04b..248e5a3e340e 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -650,7 +650,7 @@ static int setup_fuse_copy_state(struct fuse_copy_s=
tate *cs,
> >  {
> >         int err;
> >
> > -       err =3D import_ubuf(dir, ent->payload, ring->max_payload_sz, it=
er);
> > +       err =3D import_ubuf(dir, ent->payload, ent->payload_sz, iter);
> >         if (err) {
> >                 pr_info_ratelimited("fuse: Import of user buffer failed=
\n");
> >                 return err;
> > @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ri=
ng *ring,
> >         if (err)
> >                 return err;
> >
> > +       if (ring_in_out.payload_sz > ent->payload_sz)
> > +               return -EINVAL;
> > +
> >         err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE,=
 &iter);
> >         if (err)
> >                 return err;
> > @@ -725,6 +728,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
> >                 num_args--;
> >         }
> >
> > +       if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->=
payload_sz)
> > +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EI=
O;
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Not saying you have to do this, but if you wanted to, I think it'd be
> nice to have a separate cleanup patch that deduplicates this setxattr
> special casing logic between the /dev/fuse path and here.
>
> Thanks,
> Joanne

Thanks for your review. I updated my 1/2 to make it an elegant patch
and added your suggested cleanup as 3/3.
1/3: drop previous tags; reserve the fields for user copy
https://lore.kernel.org/fuse-devel/20260714235408.1666063-1-xmei5@asu.edu/T=
/#t
2/3: no change
https://lore.kernel.org/fuse-devel/20260714235408.1666063-2-xmei5@asu.edu/T=
/#t
3/3: add a helper to return the correct error code
https://lore.kernel.org/fuse-devel/20260714235408.1666063-3-xmei5@asu.edu/T=
/#t

Xiang
