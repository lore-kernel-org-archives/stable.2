Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8837DE99
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991455; cv=none; b=BYRniuW7Je2r4OazU5c3io43W1EUN8Y98Bs4iVdgzkAKPklwbkW4i907MCFeqnTY389+sP661s6jTMNttEp9m2e7XnB9Aq2ZahKFAB1bGVJZgA0b9/VlnGlDJ32aVhNsodOqsA+RmRUS5XoyQCxSiz3Quka5o4pSm3XPgk3mVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991455; c=relaxed/simple;
	bh=uSvhEAqyPaF9DS1lIT77dCJ+dwwoN5i8B6hTnC6Brj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uag7P7dzihi8FErEWT3cXJvH8/lc6l6Slv0Xkffjh0ahwUNyix1zWrNtU7kkf735GXs+jNzDO0RpmwCm/oDjfNZEZCZRNR8ItTWeEjaM1MUt5+6ZIUqS/9AQqbQUXkD9ZczJbrhx35KAGD7yBjtzqOuDAobwHAFoe0r6wYsSejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=Twz9nXha; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="Twz9nXha"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2cce930cso37093341cf.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1786991453; x=1787596253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3Et/3n5ITlvJxpO+xTy2H305JPgTylywrosUJl6XNw=;
        b=Twz9nXhaXLFck+g8WlTK4E9xrtMQA5RHwWqE0pCbcgqZNUijUTEdg+eGkJ3luwsmtn
         LqHMTc0KWJqiGV2oXomkadEZAQ2HhPejEi37ckec4xcNbH47AP5TutWqopAcPiTXREuM
         GThZB7eeAVy0bAKJU2621LtoNiSRzHdb97mpg6VmAjy8/X2DsGj3x3kte+nMFlryxGGP
         aIzNQL1TiNWuJMWHRa3cdaFOLa8dcxClfV/Sg+gFKUbvMeSIoH1uLPxb1jTst/Bzvelr
         fd4GtheVCuy8joG28xp5To3Pb9ySb3GHFbU4BTBb5VyvoudvP+gxofjhVWxysZhsHqm2
         0Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786991453; x=1787596253;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3Et/3n5ITlvJxpO+xTy2H305JPgTylywrosUJl6XNw=;
        b=tNFghZguV+lcvt/uGhjTwJrwKmUodsHaHL4veZCkigjKJy/gA5m9qcr6HhrbTJtX4v
         OXlZO4HmwlaovNK/RkpSsRdliGDbpw7XoZKjMisAdZiZvCajx2cyvtvyHdyUJM0LLu5/
         MS7RI4An5OONVQaFXcIgOIWKqsdDEABsN7vnGNaBIMqlL0PJPyGMm26AWs524sf15fSG
         jngJr4ogSKXh1jwMLf/gJSB++WUJ2gUo3PphXqz1mRKZxjgKiUR3Nv9Lnk78UJZIlJqO
         kxQPAs5IbgM8a+2knUIOHD1RnKcfyWtFLzww0JiAVs3z8af+JGNshEKIFICATxfqzTsE
         FSBg==
X-Forwarded-Encrypted: i=1; AHgh+Rrm4O71y3njTcR68/jAjjrLPhjhhGO6vtvNX5WFiX0u7ZUIJQy7PvkAmC2MO53YTZoFAxpQwj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4zGHfm9EbOG771jXIXBSvSVgPGW76+LJUMFdC3G6szjXqdvo
	+88tXf4C0+TybgBYXBERMtzz7PQ/1drY+OeamcFwk5odEzCc24rihvgyE9NQIL0FdOo=
X-Gm-Gg: AR+sD12Ay39IX54W8XxIEO5AQVQLqHuTTqw0yYls4etWyzqzO7PobBFIWxyylg2yDdw
	PdNCnOVh8e6N5M66N+6MkphRlysiWORrzFtfHqIm2jZXeQV1Ub/T/wyWmK8fMlfGnnIIF58TThh
	dpi4sUvEhZ6aIu/mbYylapILhKKWM4soXJpyL4zwFfY1kvUws37KHlMYg5IyaW3yXcD6qrcKZ9s
	vVGqo68RkHgSq9VwS6sq9hiZyccMZMEjFe3Cepiv6JvlreHatC2jKSSFWEhJTsGTr+p/2oBwTni
	mEOQKIejlulxHW2f0sgpt21F20xlk6U0uFDEJG5toX2Vb3Cg9YMACGlLFUaj7qdoBiyCNvR/SI3
	FJp/jq4n26M3eOZWU1hwy1VqpYqEXRb1vT9KksMW4EFMaWgWprXKt7pSU6tOfNQratnb+K6jlNG
	XUSDZhSwxBI20m/zlIFKNMKZRRUu/pXfeg7z3PWplB8+z3zWwckIRO5Jw/Y7ODV2IBpfHS2haPV
	ZM=
X-Received: by 2002:ac8:6546:0:b0:51e:47a4:4851 with SMTP id d75a77b69052e-52d8530dbb8mr314632181cf.8.1786991452831;
        Mon, 17 Aug 2026 11:30:52 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::c41? ([2606:6d00:15:e221::c41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db60eb85csm21612111cf.4.2026.08.17.11.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:30:52 -0700 (PDT)
Message-ID: <311a2dc7cb1d95a518f9a97b643dcc05c38c4f4b.camel@ndufresne.ca>
Subject: Re: [PATCH 1/4] media: v4l2-mem2mem: serialize REMOVE_BUFS with job
 execution
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: moonafterrain@outlook.com, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Dafna Hirschfeld	 <dafna3@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro
 Carvalho Chehab <mchehab+samsung@kernel.org>, Yuhao Jiang
 <danisjiang@gmail.com>, stable@vger.kernel.org
Date: Mon, 17 Aug 2026 14:30:51 -0400
In-Reply-To: <20260815-vicodec-fixes-v1-1-12101572eba7@outlook.com>
References: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
	 <20260815-vicodec-fixes-v1-1-12101572eba7@outlook.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-UmT6kcNk5jTJzN0Vqpr/"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-UmT6kcNk5jTJzN0Vqpr/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le samedi 15 ao=C3=BBt 2026 =C3=A0 22:56 +0800, Junrui Luo via B4 Relay a =
=C3=A9crit=C2=A0:
> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> VIDIOC_REMOVE_BUFS can free a buffer that an in-flight job is still
> decoding from, giving a use-after-free of the reference frame.
>=20
> For stateless decoders a reference frame sits in VB2_BUF_STATE_DEQUEUED,
> which is exactly what REMOVE_BUFS frees: userspace dequeues the decoded
> capture buffer and names its timestamp as the reference for the next
> frame. device_run() resolves that timestamp with vb2_find_buffer() and
> keeps the vb2_plane_vaddr() result for the whole decode without holding a
> reference. Nothing serializes the two paths: REMOVE_BUFS runs under
> m2m_ctx->q_lock and q->mmap_lock, while the job path holds neither and
> reaches device_run() from schedule_work() outside any ioctl lock.
>=20
> Hold the instance off the job queue and wait for its in-flight job before
> removing the buffers. The pause is per-instance rather than device-wide
> because the buffers belong to that instance's own queues and the caller
> is inside one of its own ioctls, so the context cannot be released while
> the wait is in progress. A losing race degrades to vb2_find_buffer()
> returning NULL and the job failing with -EINVAL, which is already
> handled.

I recognize this is a bug, but the fix waits, where it should just fail (EB=
USY).
We have flags to track the buffers owned by the driver, and that should be
usable here and entirely done at vb2 level.

Once this solved, you should check if this isn't actually a vicodec bug (th=
ere
is other related bug  report iirc) rather then a m2m framework issues as yo=
u
subject state.

Please don't just prompt this back, read and understand.

Nicolas

>=20
> Reproduced on vicodec under KASAN:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in add_deltas+0x450/0xcc0
>   Read of size 1 at addr ffffc90000a77bc0 by task trigger_bin/71
>   Call Trace:
>    add_deltas+0x450/0xcc0
>    decode_plane+0x1799/0x34b0
>    fwht_decode_frame+0x173/0x620
>    v4l2_fwht_decode+0x595/0xea0
>    device_run+0x6bb/0x1850
>    media_request_ioctl+0x2fb/0x450
>    __se_sys_ioctl+0xb1/0x110
>    do_syscall_64+0x12c/0x360
>=20
> Fixes: 2f2419502f69 ("media: v4l2: Add mem2mem helpers for REMOVE_BUFS io=
ctl")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 60 ++++++++++++++++++++++++++++=
+++---
>  1 file changed, 56 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-=
core/v4l2-mem2mem.c
> index a65cbb124cfe..10a0a74f782c 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -41,6 +41,8 @@ module_param(debug, bool, 0644);
>  #define TRANS_RUNNING		(1 << 1)
>  /* Instance is currently aborting */
>  #define TRANS_ABORT		(1 << 2)
> +/* Instance must not be scheduled while its buffers are being removed */
> +#define TRANS_PAUSED		(1 << 3)
> =20
> =20
>  /* The job queue is not running new jobs */
> @@ -309,9 +311,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev =
*m2m_dev,
> =20
>  	spin_lock_irqsave(&m2m_dev->job_spinlock, flags_job);
> =20
> -	/* If the context is aborted then don't schedule it */
> -	if (m2m_ctx->job_flags & TRANS_ABORT) {
> -		dprintk("Aborted context\n");
> +	/* If the context is aborted or paused then don't schedule it */
> +	if (m2m_ctx->job_flags & (TRANS_ABORT | TRANS_PAUSED)) {
> +		dprintk("Aborted or paused context\n");
>  		goto job_unlock;
>  	}
> =20
> @@ -1388,16 +1390,66 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file,=
 void *priv,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
> =20
> +/*
> + * Keep @m2m_ctx off the job queue and wait for its in-flight job, if an=
y.
> + *
> + * Only this instance is held back: the buffers about to be removed belo=
ng to
> + * its own queues, so no other instance can be reading them. Waiting on =
this
> + * instance is also what makes the wait safe -- the caller is inside one=
 of its
> + * ioctls, so v4l2_m2m_ctx_release() cannot free it here.
> + */
> +static void v4l2_m2m_pause_ctx(struct v4l2_m2m_ctx *m2m_ctx)
> +{
> +	struct v4l2_m2m_dev *m2m_dev =3D m2m_ctx->m2m_dev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&m2m_dev->job_spinlock, flags);
> +	m2m_ctx->job_flags |=3D TRANS_PAUSED;
> +	if (m2m_ctx->job_flags & TRANS_RUNNING) {
> +		spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
> +		wait_event(m2m_ctx->finished,
> +			   !(m2m_ctx->job_flags & TRANS_RUNNING));
> +		return;
> +	}
> +	if (m2m_ctx->job_flags & TRANS_QUEUED) {
> +		list_del(&m2m_ctx->queue);
> +		m2m_ctx->job_flags &=3D ~TRANS_QUEUED;
> +	}
> +	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
> +}
> +
> +static void v4l2_m2m_resume_ctx(struct v4l2_m2m_ctx *m2m_ctx)
> +{
> +	struct v4l2_m2m_dev *m2m_dev =3D m2m_ctx->m2m_dev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&m2m_dev->job_spinlock, flags);
> +	m2m_ctx->job_flags &=3D ~TRANS_PAUSED;
> +	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
> +
> +	v4l2_m2m_try_schedule(m2m_ctx);
> +}
> +
>  int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
>  			       struct v4l2_remove_buffers *remove)
>  {
>  	struct v4l2_fh *fh =3D file_to_v4l2_fh(file);
>  	struct vb2_queue *q =3D v4l2_m2m_get_vq(fh->m2m_ctx, remove->type);
> +	int ret;
> =20
>  	if (q->type !=3D remove->type)
>  		return -EINVAL;
> =20
> -	return vb2_core_remove_bufs(q, remove->index, remove->count);
> +	/*
> +	 * Removal is only allowed for DEQUEUED buffers, but that is exactly
> +	 * the state a stateless decoder's reference frame is in while a job
> +	 * resolves it by timestamp and reads its memory.
> +	 */
> +	v4l2_m2m_pause_ctx(fh->m2m_ctx);
> +	ret =3D vb2_core_remove_bufs(q, remove->index, remove->count);
> +	v4l2_m2m_resume_ctx(fh->m2m_ctx);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_remove_bufs);
> =20

--=-UmT6kcNk5jTJzN0Vqpr/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaoNTWwAKCRDZQZRRKWBy
9A+TAQDzT19jvMHuEkO79vd5IoN/64y4cPUOs4LQKpVLeLe8/AEA/NknG6GW+Z4O
odGAQjeIJtsvbcYPUflJfer+oqHksAo=
=gTE2
-----END PGP SIGNATURE-----

--=-UmT6kcNk5jTJzN0Vqpr/--
