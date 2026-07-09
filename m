Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862417BB21
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631783; cv=pass; b=vFUzBiuepAMuf1wTampFGPmVCI45+IGNP1rQwkjurrkZwmqisBx7mWSyKG6I9zui86GlaIttXoT6r9QOPLL+T98Q9NmHRO61WCSKmwJME8yxl9LqV5DRJj1BS5mK15F3MaSkh+ybmufAx0kXg0TyBWyIZndMhMtqPTlnsR6vG5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631783; c=relaxed/simple;
	bh=jea2pkAA6ea7ThGIL5ZY5V0mW7MFcoJRXwU1VdT3S6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAcb4bknbz8d+ibG54d31c0vQFflEBBgA9/7cYbdRQs6RRQkSpzX+7PW1rViMslY2qMrwwEZzCpwex2qgN2+NCDLKIF4tqNGLjpC0U8x1TSexod9biQX6ZD7HPkvYXCNU8uxNkQtoI34sEoNGATG1JlArkdNN1S7+yjEpBG1yYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=C18R02Fb; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="C18R02Fb"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so2140436d6.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783631779; cv=none;
        d=google.com; s=arc-20260327;
        b=M6P+Tz0wTuwcWHTZlERjdaSkjj9BhLZq3A916QabupPxNgDYKVgp8Xw215PNUE358z
         6JFdvLvfrr9czMLJArn3UfxUggNz+yIMU1fviVCcqzOAa54DTAiXN0y0AbwQp8WjQrJw
         RrZ8ZrGh/vazXoq6oD8FerQE4ikROJNGaEqS7rB6/a0kTSIN93dSRNTtsECu99BdWlmL
         ip7oEn8ppiT8/KVI8bXTjMtQJl2jqfsXl/c8c7qrhwBovz6ph4d2vbJ8bmWHx3T9aXZQ
         QYyVdmFoth23SRedxAl+i6nl86Fh5DMBI/Cp+CpWuufHNKymn7nn6TVnZ3cMGF7u6clt
         Zk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/eyQ3BGdkreyE1jriesgVUy/TQf36x8ArcgwmCBFp0=;
        fh=ORDij5FV5B3nK1pvpap19Sdbi0P3ne65QN6LGdGck4s=;
        b=GKS90CDld3NGqltcWo0UCxa3cZ029J/D5poZ7JOK5cKItXKE1P1CliDJS/3uyIDN5R
         zj4H8rkf4TTxsifLs9zaGQGKFJNSQrd4+JIpbLIGUZB7yUEXjwsr3cFO9Rwu6QowTRlQ
         +GMAz5MIHudl2q2OS4RqXR0bNyoey3NTl8bLOyLBkycA1mYDXVV9/jry/11wSYZOsMFi
         SbhucBVMJGTZ+2XbgmZ5pqh+oUQHbG8+wD2pXG82rTlDVHN/rM6HCZsUUBiexXZaNYik
         61YmD64A0ebDpJvRXBnt/X+hN23meAlcHs7RIWTK9Advrlpdzu9sIhwk1eYYiTKRsxhc
         HXAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783631779; x=1784236579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/eyQ3BGdkreyE1jriesgVUy/TQf36x8ArcgwmCBFp0=;
        b=C18R02Fb3BUQufj9wwmkHoSTUK0o3UsG29MfuB+6PPzh2JnMMqoNSmhdFQR79B8vH2
         bzQS/LX+xR52c2R+in9Xf4Ru6JayqONrLBsRj3zapgzkofJXmDwXntbbnMd3Ao1eRCma
         IkWhv0va2MRcLadCB9ANU0cVRb+/0xji+fT6GgmPFSq+yWFmqtiUbt6o3fpimGtgi9es
         pbfZtmqQGSs94Dj+IgHVL+upqrrcI94Rrcy7o8a8IXgP0T7UvmQca1JA725QNF8R3AnY
         ZFC0tyMulL9pa5s2eIsClmjumUqOz0ssti5W7fy3VZzbRUlMXF0QS47O0LW1rYVmqTZv
         y7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631779; x=1784236579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/eyQ3BGdkreyE1jriesgVUy/TQf36x8ArcgwmCBFp0=;
        b=i4p/K3iFCnK09cXDQbuheNieLM+Zq5RnwXkPicyD6I17/VpgOGG7OWojdV3+S54k2k
         oThWkIXNe/saZ1PYEZdaeLRxkcGedBvNtiR+PhtKIcAK6Rz0cNGYt259KkpFZHyba33e
         NfNioOwgJbUUjQrz74VIucROcJ151/AagPnW7wjXV4Pqge9lAxYMuAxxM4ga95KBxdoR
         N/F9QizLS2RuGrXOPO+wYdqzz2xr67g+Aq/4pLXPAyTkfsG3pocmS4TnP7cCphGwSOmb
         NJuGtx9QO/tsqzwFd1AjXGmkFWD5XPlr48bT1XD5NTglul1wMdy3i74qzkC7d4d4Pv2e
         LQYw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7BeYyXmSQ3BX57e0b18Hvuwf+FRy9s16sguK/ILOf+RzoOPaU+jiiaXvr/a8iZVjQPQhEZsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdRKHKNRVRm/Ri5JVv6OOAknwnxvpZqZffPaY6APkNku7J4zn
	tfmWl6lwXxHgrri+0aKQEBHPNpfnzS+wnElXJAV3Qm/aVUxFULT+BO9whVNCmHf0/LBO+PwyHP9
	685W0Fcg9JtK7j2KaclUf95XOsrnY/zZRRzLFy9ys
X-Gm-Gg: AfdE7cmrUxzosjJUbszpsg4JYrvbwl2dJbMiKHbSLXgC5N/NAqIZk3ivMKpJIB2oI1X
	QvzFKkmThQ97Q3JQiBSO2ZNTMLC/THzheswkSijAWVopss6W/d0r8DYkrd0uD5hjTOw22LJZZge
	ZGoLUeWrjdw7A+cGnXVuNUwcB5ePawUttlJlPGGBiIqylUh8qprINRFUnKPFeN/SpmzYIymMHka
	QnBmQnFnJAZMpXiUyvNvQBiBhTYa+K3qffOWbULrW6gsPtqRr8WDjeqg71GEOpaPLhHmizw0uqo
	y/TLApbBLuEepXMcZKNfdTzPXarVVg==
X-Received: by 2002:a05:6214:5005:b0:8fd:6df3:b37b with SMTP id
 6a1803df08f44-8fec361d007mr104036666d6.63.1783631779176; Thu, 09 Jul 2026
 14:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707184417.3682270-1-xmei5@asu.edu> <20260707184417.3682270-2-xmei5@asu.edu>
 <cf0574fc-03d8-4b0b-b1f4-bbca59e31686@bsbernd.com> <CAJnrk1Y3bkDtztsXdF-3JL0tqxhaarriKCvO4-N3-QrL6X_4oQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Y3bkDtztsXdF-3JL0tqxhaarriKCvO4-N3-QrL6X_4oQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 9 Jul 2026 14:16:07 -0700
X-Gm-Features: AUfX_mx0e1ETlf8p_BtjrszUwOqDI7hMyfYya_SnA8ZWgjMZgNXtAJ8aT5FjZN0
Message-ID: <CAPpSM+TXbaA0YfaxoKjNhxxA3V4oqY3KYJuJpqDr4rSo+z8W4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: reject oversized payload_sz in fuse_uring_copy_from_ring()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, djwong@kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, stable@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:08=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Wed, Jul 8, 2026 at 12:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com=
> wrote:
> >
> > Hi Xiang,
> >
> > On 7/7/26 20:44, Xiang Mei wrote:
> > > fuse_uring_copy_from_ring() imports the payload buffer with length
> > > ring->max_payload_sz but passes the server-controlled payload_sz to
> > > fuse_copy_out_args() unchecked.  A larger payload_sz drains the itera=
tor
> > > to exhaustion and fuse_copy_fill() hits BUG_ON(!err), panicking the
> > > kernel.  Reject replies whose payload_sz exceeds the imported buffer.
> > >
> > >   kernel BUG at fs/fuse/dev.c:1053!
> > >   RIP: 0010:fuse_copy_fill+0x6c6/0x7e0
> > >   Call Trace:
> > >    fuse_copy_args
> > >    fuse_uring_copy_from_ring     fs/fuse/dev_uring.c:686
> > >    fuse_uring_cmd
> > >    io_uring_cmd
> > >    __io_issue_sqe
> > >    io_submit_sqes
> > >    __do_sys_io_uring_enter
> > >    entry_SYSCALL_64_after_hwframe
> > >
> > > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support=
")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > > v2: add: Cc stable and Reviewed-by tags
> > >
> > >  fs/fuse/dev_uring.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > index 0814681eb04b..f6127c230dd9 100644
> > > --- a/fs/fuse/dev_uring.c
> > > +++ b/fs/fuse/dev_uring.c
> > > @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_=
ring *ring,
> > >       if (err)
> > >               return err;
> > >
> > > +     if (ring_in_out.payload_sz > ring->max_payload_sz)
> > > +             return -EINVAL;
> > > +
> > >       err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE,=
 &iter);
> > >       if (err)
> > >               return err;
> >
> > Good catch and sorry for lare review! Hrmm, it just gives me a bit head=
ache,
> > because idea for max_payload_size in fuse_uring_create() that it preven=
ts
> > exactly that.
>
> I don't think this is related to fuse_uring_create()'s
> max_payload_size. The problem this fix addresses is that the
> ring_ent_in_out.payload_sz header value returned by userspace can be
> whatever arbitrary big value userspace wants to set.
>
> Maybe I'm misunderstanding what you're saying, but i think this fix is
> orthogonal to the setxattr issue you mention below? afaict, that one
> has a different root cause (unbounded in_args copy coming from the
> kernel side when sending requests vs. trying to copy in an unbounded
> server-set payload size when handling a server's reply).
>
> >
> > After tracing through the code, I think we have two cases where max_pay=
load calculation
> > in fuse_uring_create() is not enough for xattr and ioctl
> >
> > For xattr we have an additional in addition to the patch above - it sen=
ds unchecked
> > against max_pages and  fuse_dev_do_read() has an additional op code pro=
tection
> > that I had missed
>
> Nice find, I didn't realize setxattr had a special error value either
>
Good catch, that's a real issue, and we triggered that by modifying our PoC=
.
> >
> >        /* If request is too large, reply with an error and restart the =
read */
> >         if (nbytes < reqsize) {
> >                 req->out.h.error =3D -EIO;
> >                 /* SETXATTR is special, since it may contain too large =
data */
> >                 if (args->opcode =3D=3D FUSE_SETXATTR)
> >                         req->out.h.error =3D -E2BIG;
> >                 fuse_request_end(req);
> >                 goto restart;
> >         }
> >
> >
> >
> > And I think with the current patch is incomplete and missing something =
like this
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 77c8cec43d9c..449b84ac24e7 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -725,6 +725,14 @@ static int fuse_uring_args_to_ring(struct fuse_rin=
g *ring, struct fuse_req *req,
> >                 num_args--;
> >         }
> >
> > +       /*
> > +        * A FUSE_SETXATTR value may exceed the ring buffer; match
> > +        * fuse_dev_do_read() instead of overrunning the payload iterat=
or.
> > +        */
> > +       if (fuse_len_args(num_args, (struct fuse_arg *)in_args) >
> > +           ring->max_payload_sz)
> > +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EI=
O;
> > +
> >         /* copy the payload */
> >         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
> >                              (struct fuse_arg *)in_args, 0);
> >
> >
> >
> > And a generic patch, but that has the potential to break existing users=
pace is
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 449b84ac24e7..d25d7922bbdd 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -251,7 +251,14 @@ static struct fuse_ring *fuse_uring_create(struct =
fuse_chan *fch)
> >                 goto out_err;
> >
> >         max_payload_size =3D max(FUSE_MIN_READ_BUFFER, fch->max_write);
> > -       max_payload_size =3D max(max_payload_size, fch->max_pages * PAG=
E_SIZE);
> > +       /*
> > +        * A max_pages-sized paged reply may be preceded by a fixed op =
reply
> > +        * header (e.g. FUSE_IOCTL); reserve a page of header room gene=
rically.
> > +        */
> > +       max_payload_size =3D max(max_payload_size,
> > +                              fch->max_pages * PAGE_SIZE + PAGE_SIZE);
>
> I hope we don't have to do this because imo even with a feature flag,
> it gets confusing/cluttered. What about just having it be the
> responsibility of userspace/libfuse to allocate a big enough buffer to
> hold ioctl reply headers if they want to handle ioctls that have
> max_payload_size amount of data? On the kernel side we'd just need to
> store the buf_size value the user already passes in at registration
> time and use that value for the import and payload-size bounds check
> instead of max_payload_size which seems like a pretty minimal change.
> If the kernel insists on the + PAGE_SIZE headroom, across lots of
> queues that have lots of buffers each, I think that memory waste may
> add up as well :(
>
> I think with bufferpools being the primary interface going forward
> (not sure if you agree with this, but with zero-copy and other
> optimizations being gated on it, I view it as that in my mind), the
> ioctl issue won't be a problem since the kernel can allocate more
> memory than max_payload_size to that particular request from the pool.
>
> Since they have alternative solutions (libfuse or buffer pools), maybe
> we don't need to bake this in here?
>
>
> > +       /* getxattr/listxattr values are bounded only by XATTR_SIZE_MAX=
 */
> > +       max_payload_size =3D max(max_payload_size, (size_t)XATTR_SIZE_M=
AX);
>
> afaict XATTR_SIZE_MAX is 64k, so if a server deliberately sets max
> pages to a very small value because they don't have enough memory, it
> seems counter-intuitive to force all their buffers to be >=3D 64k. As I
> understand it, the vast majority of xattrs are small (tens of bytes),
> so maybe better to just let them proceed and return an error on an
> oversized xattr than pay 64k/entry in every queue? If they really want
> to support 64k xattrs, then imo it should be their responsibility to
> allocate a big enough buffer size for that.
>
> Thanks,
> Joanne

This seems a good way to patch both paths. We have sent a v3 based on this.

v3-0001 keeps the same as v2.
v3-0002 patches both paths based on your proposal.

Please check, and we'd like to hear your feedback:
https://lore.kernel.org/fuse-devel/20260709211130.543773-2-xmei5@asu.edu/T/=
#u

Thanks,
Xiang
>
> >
> >         spin_lock(&fch->lock);
> >         if (!fch->connected) {
> >
> >
> > Question is how we could add it in, maybe with a feature flag?
> >
> >
> > Thanks,
> > Bernd
