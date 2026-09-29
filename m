Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6F2D7DC6;
	Tue, 29 Sep 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691088; cv=none; b=IjHK1HE5/uwNoqAEcR/2W7bFA/pE+Nd5+Zi7iFMROyHjVtIGPCXkvGx/kb1XQWXeGHT0ifOFmzbyh2epZijPVZcEmDQbB9gscZr7QdcJdKoAWvUBxULz7YSRpZ+Me4E+TrIN4B54Ds6CHwlEoifBc6S/GT2swwOZQEDIgg6NUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691088; c=relaxed/simple;
	bh=tO/tba5jXD5iVMXles2C053HVSnPmKePS8i0BMtv1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EioU8Lx7MDOsqVWFU8mxWfdEQ+PuzYrk2nnnrGRCN6M7L2pVVRsGHDZ+VkwzkrXVhehDrzsLA5SRJERxoKvTCZzaOvENYD9ji5USveRBPiNde0EYRhnJr3D9T7D4GEpEAn85QLQxURMD+JCzFUBXrfQBBlgY/JmTDEnZP1ct4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQvcJUe/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQvcJUe/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 35B151F000FF;
	Tue, 29 Sep 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691086;
	bh=PSoUcSOmRxRNwi1ucGgVkqYsy8T+yUZsTairMLPrfjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQvcJUe/kevPavMB+V8F4mKB/mGUU5SFAX8IPMLJQZXHbWufS3bTPxNqrXY/BoAEY
	 l9d2XGahaR3hvpiuYqxlR5NSamwyBsbuq2T5zSsaOdb52eYTdKJ9ix6KA7d3hauxM1
	 OsXX3riAzoP2Z5HXZEeUHzdcpfZpYy4cFdRwcPzou/E3qqtrMLKco8pW6AZnCFCHGs
	 vNeCKGBqPmn4AzqYGzjVPdoZH57ApiuNExLWVLsFQ11s3sMouFjkzxZIDxR2xiFdTu
	 rWm6w8tkyJnQ8OV1yJrzzNHpKi6GfZagaE89fhMZnljQo7efVbXG7k9VlzLMJjcEfE
	 XlcGrNBEkv0PA==
Date: Tue, 29 Sep 2026 16:11:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] pwm: Allow 32-bit tasks to use the character device
Message-ID: <arvFsimmYhZWcOIR@monoceros>
References: <20260928184422.380520-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqehw3h2q7uh5lyd"
Content-Disposition: inline
In-Reply-To: <20260928184422.380520-1-danishkhateeb03@gmail.com>


--tqehw3h2q7uh5lyd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Allow 32-bit tasks to use the character device
MIME-Version: 1.0

Hello,

On Mon, Sep 28, 2026 at 01:44:22PM -0500, Danish Khateeb wrote:
> pwm_cdev_fileops has no .compat_ioctl, so every ioctl on /dev/pwmchipN
> fails with -ENOTTY for 32-bit tasks on a 64-bit kernel, e.g. armhf
> userspace on arm64.
>=20
> struct pwmchip_waveform has the same layout for 32-bit and 64-bit tasks,
> so compat_ptr_ioctl() is enough. PWM_IOCTL_REQUEST and PWM_IOCTL_FREE
> take an integer rather than a pointer, which is fine too: compat_ptr()
> only changed the value on s390, which dropped compat support in v6.19.
>=20
> Fixes: 9c06f26ba5f5 ("pwm: Add support for pwmchip devices for faster and=
 easier userspace access")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>=20
> Notes:
>     Tested on x86_64 in QEMU (pwm/for-next 17dbb6938d3a plus this patch,
>     KASAN and lockdep) with a PCA9685 instantiated on i2c-stub, which gets
>     /dev/pwmchip0. A test program runs all six ioctls, including the error
>     cases (hwpwm out of range or not requested, __pad !=3D 0, use after F=
REE,
>     SETEXACTWF returning -EDOM):
>    =20
>     - before: every ioctl from the -m32 build fails with -ENOTTY, while t=
he
>       64-bit build works
>     - after: the -m32 output matches the 64-bit output line for line
>    =20
>     No splats. W=3D1 builds are clean for arm64 (COMPAT=3Dy, LLVM=3D1) an=
d for
>     i386 (no COMPAT).
>=20
>  drivers/pwm/core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 2a050ff4608b..4c6d716e5fde 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -2389,6 +2389,7 @@ static const struct file_operations pwm_cdev_fileop=
s =3D {
>  	.release =3D pwm_cdev_release,
>  	.owner =3D THIS_MODULE,
>  	.unlocked_ioctl =3D pwm_cdev_ioctl,
> +	.compat_ioctl =3D compat_ptr_ioctl,
>  };

Not entirely sure about the stable backport, but the change looks fine.

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
but dropped the Cc:.

Thanks
Uwe

--tqehw3h2q7uh5lyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq7xwkACgkQj4D7WH0S
/k722Qf/RkVwDK/fYcWyXAkowVtqmyQTt3ThfJJ4Z5B2au9+i/2qfiJuV+g36ppu
KxspSISvpQtQTlwlXf479CkgrHdJyL5crsISCCMYfPyTTpOIoanWfEFa9CMZZQhv
/UpK9G0sSG2igz/tb4ZLbKPMSCGntS2i9DLN5/VVBr5FHvhXISExDCSt/b5PIg4G
9ROyZstjAymdSGC71hABI0pt8SEEr/CeDbiS6H/wScfR/ZqZWw/MXkLsg1a/hdJE
b5UlB00uLd2XmUhJqa6BEKDrYZvB+18YMh6UuVTldvp3N+MKXQaS+zmriz+EuQld
A/xHXvH8M1oU3/jGFYmr5VulNNu5WA==
=Y4q/
-----END PGP SIGNATURE-----

--tqehw3h2q7uh5lyd--
