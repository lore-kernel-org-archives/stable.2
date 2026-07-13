Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9813B5B3;
	Mon, 13 Jul 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905138; cv=none; b=qMEtuuEJNrWGt6sD6XCKHgDlxlSxovKsibAGBMSUd7VYsuT2+8lt112gMvvMCesaoAYXu7KwBojlbfhoeZVJruGsk92SVydL6hKSHRkkK1KrrKETtthEuF9UAzuEgg3Q2qddnv0t1gBgstjGU20JwPz+H2sAc6SAkgpLSZ9L3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905138; c=relaxed/simple;
	bh=u9SDqKvrlnMY82JDbnD9khiGodRQTChxzUQJ3PoM+/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQbgzg0W9ZLIk/5L+jtOGjRGwo+iXkxFVfq/B0S3YXCvHEzXnEbTKVSSaWXIi4tbyUywPPqJEIqkAfmrzh5CqxuyFEqD+YM7O86JnfQjcpDXr3lYwpju8LIsevXssi5viho86wUYsEMR9VZiE73eyFSXM6SqwWKiKgSXiQOETsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMbc6yya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMbc6yya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BD31F000E9;
	Mon, 13 Jul 2026 01:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783905136;
	bh=SjHSeeF7vUQ5X6MLMCggjMuDp75OzmSjcIL2grGv3oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NMbc6yya+P/o+sY3VXKgwU7y12k+tXVixWH5VjF5lwJHAUd70JiTOzqhdi/FbpOxw
	 AX5vgwrhunfCaRV3lw2WZfnzpEqCrFRP6Y/YNwtXR9zRXDTvluUTfxKfD1c6VOl4iG
	 9thpADgtULzLbrkcIPf/EiiAz53ph4d3qBa1KdrNAcfmkxJqbc1zkjm+nDeM3UdOsq
	 E+SqHKw4XtMeGCysQIT+TfTy2Yorie4YUsY2Qg+0WQ6oB8WOpSDWMgXUImLb5KSUQ/
	 SxVXWqQ8UOoy0uPapdWhxnsSfC5XGuz78FX5khWZJ1g8VE/dY0RPXgT4iLB+VHbvu0
	 wvHW/zGBsescw==
Date: Mon, 13 Jul 2026 02:12:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4] iio: accel: kxsd9: fix runtime PM leak in write_raw
Message-ID: <20260713021211.1fb3e5b8@jic23-huawei>
In-Reply-To: <20260712083106.97429-2-birenpandya@gmail.com>
References: <20260712083106.97429-2-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Jul 2026 14:01:06 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> The kxsd9 driver previously used manual pm_runtime_get_sync() and
> pm_runtime_put_autosuspend() calls around the entire kxsd9_write_raw()
> function. If the user provides a non-zero integer component for scale,
> the function returned -EINVAL directly, leaking the runtime PM usage
> counter.
>=20
> Move the mask and value validation checks before pm_runtime_get_sync()
> to ensure the early -EINVAL returns do not leak the usage counter.
>=20
> Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
> Changes since the reviewed version:
> - Reduced to the minimal write_raw() leak fix. Dropped the remove()
>   rework (no underflow is possible =E2=80=94 pm_runtime_put_noidle() floo=
rs at 0)
Ah. I think I wasn't clear on what I was thinking for minimal fix.

The floor thing is something we should only use when we know there is basic=
ally
only a single user or we don't mind giving garbage to others (so in teardow=
n flows).

Here a few things are different from that.

A single user:
- We need the power on, no point in continuing to access device.
- Carrying on may result in an error, or maybe garbage data.  Either way
  the real source of the error is hidden.
(I had another one about underflow but as you use get_sync that one didn't
 actually apply)

See below...
>   and deferred the PM-macro conversion and style cleanup to a follow-up
>   series, per Jonathan Cameron and Andy Shevchenko.
>  drivers/iio/accel/kxsd9.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 4717d80fc24af..1af04cb4bf86a 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -139,18 +139,18 @@ static int kxsd9_write_raw(struct iio_dev *indio_de=
v,
>  			   int val2,
>  			   long mask)
>  {
> -	int ret =3D -EINVAL;
>  	struct kxsd9_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =20
> -	pm_runtime_get_sync(st->dev);
> +	if (mask !=3D IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> =20
> -	if (mask =3D=3D IIO_CHAN_INFO_SCALE) {
> -		/* Check no integer component */
> -		if (val)
> -			return -EINVAL;
> -		ret =3D kxsd9_write_scale(indio_dev, val2);
> -	}
> +	/* Check no integer component */
> +	if (val)
> +		return -EINVAL;
> =20
> +	pm_runtime_get_sync(st->dev);

With above in mind, I'd fix this as:

	ret =3D pm_runtime_resume_and_get(st->dev);
	if (ret < 0)
		return ret;

	ret =3D kxsd9_..
  	pm_runtime_put_autosuspend(st->dev);

	return ret;

> +	ret =3D kxsd9_write_scale(indio_dev, val2);
>  	pm_runtime_put_autosuspend(st->dev);
> =20
>  	return ret;

