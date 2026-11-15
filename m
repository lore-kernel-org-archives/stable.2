Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703263;
	b=VhYy45GG3wG6yOMRBRr78cckUdx5467MQYDrlJOFxvmQ0CHfbMWwnfA02sFA8jNXIfN+
	 0RgCPDC+O8UAFSfrHCtVBqLbNKJeuSRpPguCC4SQJ8HZ4X4pwoMKu/WNN9g2qUvic8WOL
	 do/znwQGQUwc6yyL+iKmIUycN39Mp4Bs27EzDzE8gEO5GGBX1p7bi8t0D9fRj1GQBc50Y
	 5NCWj4PB8tzHNL6Dl2MYaL3py1fjeEsRgyKzUE1ZJU4Cdj8zlJOAhPEb9JLeAwjEqvRyj
	 7hh3cKDkpQVt+BBbNLQaoCyFyWjav+c1neMRiZsIZUnkQvhqS2Zv3eLNrsAoj9kARKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2BTVNNTCmIwPJfoXXVJ//zsDmeVQkbRKEKOks+yQ03M=;
	b=34KmE7nQseg0W7cqkN5Ex/xIakttU7XBoi+zeu8solnbY2JyqMqRwgt+1Q08eSsxCMEC
	 E0p+vQ4KdZZjIDNy8Lo09LBm17j3SKJ8GEba/R3WkmZYcwA80L5L3W3h4Sg8DN7GdEHD2
	 ogqlodBJ/nmG8Yvy2agvpMehEKxWDRaXs9JsvI46d0q3KYci9MCeK8wSCvhCL35iwQQoq
	 elc+FV5jdfy5HVu3Zakn3LtUEhwKUC13kLqMs2SCZUqq91VMtLRrmcSKL/XjEiH/0aSov
	 2yRJ7mE+nHTZKinkIs2M2fGeuG5AGXVR0qg/o185dQ5gmiDs9OqMWIuF733trBgXhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kF3EXdw3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0876606A329;
	Sun, 15 Nov 2026 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kF3EXdw3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522FE1F000C4;
	Sun, 15 Nov 2026 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703262;
	bh=2BTVNNTCmIwPJfoXXVJ//zsDmeVQkbRKEKOks+yQ03M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kF3EXdw3TWJPwTpwQtZFMF5K2pjCdQRyDfavHHylnQlmjgWjxylL6UHu2cU6ZKxn7
	 yZaV45vzc+/6cvYt25WZmIh1tE402jTuHl262lXwAq/YXiAYQUFd0Xx0uDTCxkpWZO
	 T9BXiJY2vdagThy4kOjUuERsc4NMppyxbQW2JSXLXUm+1LQx1LnK4lKrVidwZFHReK
	 +sLPQZRPDmVOYRT1qd9Ltpea4Nnv0zyoHa+nA0Xf4O43ODPeqitpwozk3AGjXP1aol
	 PBKqQHOhUe2JEHwetjjF04fy2ZTIowf45Q8OWUYaTTPFalNQ960iop8P+CzSU6CYQg
	 +oCwaOMDxQSKQ==
Date: Sun, 15 Nov 2026 00:41:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: fix bounce buffer use-after-free on
 unregister
Message-ID: <20261115004100.0effe1e4@jic23-hlaptop>
In-Reply-To: <20261106-iio-fix-possible-uaf-v1-1-1bd8b94e771b@analog.com>
References: <20261106-iio-fix-possible-uaf-v1-1-1bd8b94e771b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 06 Nov 2026 16:53:00 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The bounce buffer used by iio_push_to_buffers_with_ts_unaligned() is
> allocated with devm_krealloc() against the IIO device itself. Since
> commit 699fb50d9903 ("drivers: base: Free devm resources when
> unregistering a device"), device_del() releases the devres of devices
> without a bound driver, so the bounce buffer is now freed from
> cdev_device_del() in iio_device_unregister().
>=20
> At that point buffering may still be enabled, as
> iio_disable_all_buffers() only runs afterwards. A trigger handler
> firing in that window copies the sample into the freed bounce buffer
> and pushes it to the buffers.
>=20
> To fix it, allocate the bounce buffer with plain krealloc() and free it
> in iio_dev_release().
>=20
> Assisted-by: LLM
Rules on that changes (again!)
So dropped it.


> Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_un=
aligned()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
I think your analysis is right and even without that we should never
have been using that device for devm.  So good to clean this up either way!

Ideally we'd get some testing from someone who actually has a part
using this helper?  It is rare which is why we probably had not reports
of this yet (and remove problems only show up sometimes as many users
never hit that path)

Anyhow, I think very low risk and looks good so applied to
the fixes-togreg branch of iio.git.

thanks,

Jonathan

> ---
> Found this by accident and do note this is just code inspection.=20
>=20
> I tagged the original commit supporting the bounce_buffer in Fixes: but
> to be fair, the original commit was fine. Tagging 699fb50d9903 also
> looks bit odd but maybe it's the real one to blame?
> ---
>  drivers/iio/industrialio-buffer.c | 6 ++----
>  drivers/iio/industrialio-core.c   | 1 +
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 4294101810fd..cc5fde0f5191 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -2464,10 +2464,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct i=
io_dev *indio_dev,
>  	if (iio_dev_opaque->bounce_buffer_size !=3D  indio_dev->scan_bytes) {
>  		void *bb;
> =20
> -		bb =3D devm_krealloc(&indio_dev->dev,
> -				   iio_dev_opaque->bounce_buffer,
> -				   indio_dev->scan_bytes,
> -				   GFP_KERNEL | __GFP_ZERO);
> +		bb =3D krealloc(iio_dev_opaque->bounce_buffer,
> +			      indio_dev->scan_bytes, GFP_KERNEL | __GFP_ZERO);
>  		if (!bb)
>  			return -ENOMEM;
>  		iio_dev_opaque->bounce_buffer =3D bb;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 825cf7f32059..ed097eb8d799 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1727,6 +1727,7 @@ static void iio_dev_release(struct device *device)
>  	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
> =20
>  	ida_free(&iio_ida, iio_dev_opaque->id);
> +	kfree(iio_dev_opaque->bounce_buffer);
>  	kfree(iio_dev_opaque);
>  }
> =20
>=20
> ---
> base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
> change-id: 20261106-iio-fix-possible-uaf-853ce6ff96bc
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20

