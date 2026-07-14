Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA342F6FF
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073410; cv=pass; b=Y+4hpK/+pF3Z2tN0eiK9PAwttcFhwN79AFGBG59qyX1f83STiRn1UsFRuLxqe8N9p/dVqA2PWQkVxNUcHOtbowCirGCXAB7O2TwOEQKZ72R1M6vWDjc+aAxcixvc85k2zP01i7k5fDRYLgS6DA8FQSH/Dsd8YLMdwBTeSL6+B/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073410; c=relaxed/simple;
	bh=6Fpv/SB25gudhh3flfFdWSjRk6FL3uKgMmFq0SGfsa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJGdDaoPGxrOruWf3glBmS1deObp3ox5hQ67no3iRFKpeZ2SfPqRtQlUv131OOwOjKE6lklfa4Tc+lHm1LuDzCF+V7zv9dzMszFqMzKu4xktZmyzuYpziA1/RPENkhlL8Eye60lz/5dkOnA5Hf+7OCkjt3TidW4DyeU8hgs4+PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=syjGEi1m; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="syjGEi1m"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2c90e383so67274b3a.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073408; cv=none;
        d=google.com; s=arc-20260327;
        b=kkfvJGTbgMJrzrlZlfYxca2dM4h7bZVNuzOhpW+mAm6ny3AyvwDwhHQkNr3cqb9dsJ
         umC2XZMFtp5yyd8Lb0m4i2mpYjvF+gIUHSjD8qf6EE0d+BvkyomnBgj0PWEeWoyWZHqq
         JuzAwiy9S4qrK3SZbKhjFC6f57kQ2f+RqrmepF1M6L+RTjcnEkiX2mOTIBQmSq+r5Cqw
         KzS6KouiXmo7zmrWdyVx8t+uiRI9MWiDda7aIsgPOByF9wpbS9z4lZooB9Urm/WyywJZ
         N4YZBz/F5dajeXbFaa13bqqAQUlrI65O0dKwBwFudw4Qy3HtYgbfUdHXFRHxq1Sv6wHG
         WbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wbAPfP4ZbZmDgX9Nwlzq5TjRPzqN58/bDtfUIlP4wNM=;
        fh=wjQROB7prUUdvXdJ5kJdXHgO8vBZTo7xwuwvWcCeqT0=;
        b=EsYJ3NdYGR9IgG0PqsybONHetKwXUHyn5Sawlzpfpvq0HtJQQwIEBpExd3m4FHlg/m
         U+rhIjmz09QezlQ9t51aKSbvj88XcaAzgCv/jllD7Mw48f5Dq1Tem5hsdRYF7rCQcT+h
         EegN8qOp+cNjPwIT69KEaJMSt0y8v+KFub3T1Yrr5Yz4IYJNqJBPOzmncs+oVJJ6iV1/
         HFO+EvfqrjKrgKlGstZKLZhrpjM2bXl9I/tJx1NfoV8o50e7dFU/umIOF4zEnCSaFHHe
         zvj+Hmzr0zPYqDcFcaU/nv84Pl9q8L0ryVMZxC1KTDPeGVzcZqGT5vaJoTpbFccDtSO7
         6OVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073408; x=1784678208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbAPfP4ZbZmDgX9Nwlzq5TjRPzqN58/bDtfUIlP4wNM=;
        b=syjGEi1mCJWwN+bTLaJ7Z9hGL2on/VW/ZLpsabEt6Uz/6t8ssln8PocyQBReKWwPV3
         whdxJKjv2Y9I6jd/5P/IX8pfp7g+G9U6nlIKbpt21nXyg3Fg2e4vjd7nEJ+zpZC4P5r/
         sX8Li96UgdHkKvEv3EyseCVRrumKlfBvftVPrOoueC75tNrO32fNbzP40FmX3dy41Sob
         +b9JkqaTUHK9b0iFPNdOtm3Csb2+Wu0KmyB9Ww6qPAy9z8O8vzTGHNQ0xxWtgQ49ZwwG
         6Qb3jtgye7jVnxP2AZ46a+Cy8J3ZQRv3nyLZNUV6hfP2tLSinCjP7v9rYqNQz+7SyPFB
         I+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073408; x=1784678208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbAPfP4ZbZmDgX9Nwlzq5TjRPzqN58/bDtfUIlP4wNM=;
        b=p5mL5omQIeq9HsY7gCXyWRaHfYhKzDab5f27dzMDUm/9mstZXuHN7Bs0f1jtonqhmo
         0vHL8A0CLD0uJavDGR8bMWfVqMp8wilIht+QMu75yGACgKatU6dn6aNmV2p/c9h6HTgJ
         NyUCCAjh2N/7AaerFFdcw7WMTbZYYx54tlPeD7Df/5wbveKH9VHfU/dDG1/Zzm/PFsI3
         jfnTj5OTv2aXovv0jT4ARJSWKXJcAka4YwgCq46eUYkvTpSSs1H8pyi9XQ/Ka4t2DY4j
         r5mcIVmGvFVcIhQHFRCuPe56fBRRPE+JihcI2OBr1nM7r+8Sa9SaO8oVDebp3u45nZtB
         WnXw==
X-Forwarded-Encrypted: i=1; AHgh+RoJ7gErmChtaHWefojlBpNLRBRtCqlnCZDKIXjcfszfNsgttvz8LURqrgjP9bcpC9MiBYmt0dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6wDFk8B5ZfZqMcbekAs/oE9WslBmXQOFlgfCiY0HBg/TwK7o
	iYbxwieNUdfw0CDonBm9m9xjEceQivEnhTc3XsNT6pjBp7knTxXUnc0kl9c94CyWP/Qvhf0gAAi
	ZnL2iCYQUKBkBnNsWCqPApSTSnN8oNqg4k0QJVIzK
X-Gm-Gg: AfdE7cnnVBZ2ucEM/FRHNp2tgdBPGfcwn1joS5y3e8nAILHC/HrDj6LiDDfhhOdWxNE
	YhVEDT+IwtZpKOate1FUH9QB4E6jr0LOQxm6b6x4rA6zOt03FAMP62/lo3tKRoNwfZ+e2C9tBRK
	XpvCNaALKkwIeGuwoc+sDrlU2E9LQUtxXeofJuiHpvaKvLJ3yKVXm+boWw8w38qc/XO/nGbE4n/
	Be+ZqfYElTOyXbEmhsawdwUkbXEklrbg2NG8C8qphUzrXalnhs4un6P8xFx9sTI4GukHVYd
X-Received: by 2002:a05:6a00:1d09:b0:848:2f58:e1ec with SMTP id
 d2e1a72fcca58-84870798902mr15715102b3a.39.1784073408405; Tue, 14 Jul 2026
 16:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211130.543773-1-xmei5@asu.edu> <26a9a225-617c-4492-af1d-152d71414f4d@linux.alibaba.com>
In-Reply-To: <26a9a225-617c-4492-af1d-152d71414f4d@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 16:56:36 -0700
X-Gm-Features: AUfX_mw5OdcJsljs_oJJ0LuEjIoWcseG9aZEf-wHZwZ0vy0tq-WnqPuMiDAI62k
Message-ID: <CAPpSM+QrQk8k8NH5Qz5XHf-O=U0Et_OJFpP4iBtX4dkJ8gamEg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: copy request headers via a stack buffer for io-uring
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Kees Cook <kees@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:20=E2=80=AFAM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> Hi Xiang,
>
> On 2026/7/10 05:11, Xiang Mei wrote:
> > The fuse-io-uring transport copies req->in.h out to the ring in
> > fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> > Both headers live inside the fuse_request slab object, whose cache
> > (fuse_req_cachep) is created without a usercopy whitelist,
>
>
> Then why not allocate "fuse_request" with kmem_cache_create_usercopy()
> to add a usercopy whitelist instead?
>
> That would avoid the extra stack usage for the bounce headers and
> the 56 bytes of copying they incur.
>
>
> Thanks,
> Baokun
You are right. I have dropped previous reviewers' tags and sent a v4
since it's a hot path:
https://lore.kernel.org/fuse-devel/20260714235408.1666063-1-xmei5@asu.edu/T=
/#t

Xiang
>
> >  so copying
> > them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> > panics:
> >
> >   usercopy: Kernel memory exposure attempt detected from SLUB object
> >   'fuse_request' (offset 56, size 40)!
> >   kernel BUG at mm/usercopy.c:102!
> >   RIP: 0010:usercopy_abort+0x6c/0x80
> >   Call Trace:
> >    __check_heap_object
> >    __check_object_size
> >    copy_header_to_ring          fs/fuse/dev_uring.c:618
> >    fuse_uring_prepare_send
> >    fuse_uring_send_in_task
> >    ...
> >    __do_sys_io_uring_enter
> >    entry_SYSCALL_64_after_hwframe
> >
> > Bounce both headers through an on-stack copy so the usercopy touches
> > stack memory, not the slab object.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> > v3: no context change; add Bernd's Reviewed-by
> >
> >  fs/fuse/dev_uring.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 77c8cec43d9c..0814681eb04b 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -744,6 +744,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring=
_ent *ent,
> >  {
> >       struct fuse_ring_queue *queue =3D ent->queue;
> >       struct fuse_ring *ring =3D queue->ring;
> > +     struct fuse_in_header in_header;
> >       int err;
> >
> >       err =3D -EIO;
> > @@ -765,8 +766,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring=
_ent *ent,
> >       }
> >
> >       /* copy fuse_in_header */
> > -     return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->i=
n.h,
> > -                                sizeof(req->in.h));
> > +     in_header =3D req->in.h;
> > +     return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_hea=
der,
> > +                                sizeof(in_header));
> >  }
> >
> >  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
> > @@ -871,11 +873,13 @@ static void fuse_uring_commit(struct fuse_ring_en=
t *ent, struct fuse_req *req,
> >                             unsigned int issue_flags)
> >  {
> >       struct fuse_ring *ring =3D ent->queue->ring;
> > +     struct fuse_out_header out_header;
> >       ssize_t err =3D -EFAULT;
> >
> > -     if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->ou=
t.h,
> > -                               sizeof(req->out.h)))
> > +     if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_hea=
der,
> > +                               sizeof(out_header)))
> >               goto out;
> > +     req->out.h =3D out_header;
> >
> >       err =3D fuse_uring_out_header_has_err(&req->out.h, req);
> >       if (err) {
>
>
