Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF54CC26B;
	Wed, 30 Sep 2026 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769455; cv=none; b=k/0aCVRY+ogCDgAMK4e7zixIZp4mS67GBzSAG5V3D05SS3SQucaYA2sokUNRlCMUR/rRVLUY0Ubhxz3b/GFaQda7ao5l0cc25cybymcEJU62n9/zpNpK75Siol22uOe20/2cOWo+Hxx7oFMp0IkWwFMt1x523wjk2GQ7UC1o2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769455; c=relaxed/simple;
	bh=IVNHAQULBkdxEEqyuoHwpWoInZzLYk+Waybl1wvgMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnlpKEYtd3ohtcdHh3bJ1Cir29Uqdxtdu/8U3bdw5rzbeyks4fuelVZjtBuYGV+bBXOxTTkMBD/NFhDc3ok9jiCgSG26D8Bj6onePnNHK4G87b8S6Mkyj1Wc4ASpsq0TEvLbeH6uCZmWKvc8zCRevOgdzH+OS3zjAzqL1wBOt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNDHsUMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNDHsUMa"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 83D451F000FF;
	Wed, 30 Sep 2026 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769454;
	bh=nsQeYX/EoFycD4Nppj/CByNnNPVbJQJPfN8ZUCTZ7Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lNDHsUMaWeP+SD7d85miFKYIl54SDAwMFEOTXN9IBNXhhO7bphe9IHOh6RfswPp3x
	 B2X4rUQb2vTMN0sUBfZgFMF1P+eFMeaggLe6kqW5kl0nfqh2piwlQzBkN1gZUXFCwe
	 JezstYFUoWRNOm6WSpDcpvGD06MfZexwOy0gxXOSDbS5GXz5ofTfmu7QRSDIrX2g7A
	 Utb3O/bl32vI/z73rjk47izAjo613G8hZJCEqjjEYJcMysWKCxQYquLthpa3KG+Xd7
	 4UJe7PjhnZJK8p07CTT0El2tEpZMk3teRVaeGknTac1JtKbx4Uf99LYmqVLfW4qIc/
	 6sZIM3fJ8bo8w==
Date: Wed, 30 Sep 2026 13:57:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, wefu@redhat.com, 
	a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org, 
	m.wilczynski@samsung.com, ojeda@kernel.org, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
Message-ID: <arz487DLBlaBrWLN@monoceros>
References: <20260930101257.1649945-1-tomo@flapping.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jqdpbk4j34qnyqff"
Content-Disposition: inline
In-Reply-To: <20260930101257.1649945-1-tomo@flapping.org>


--jqdpbk4j34qnyqff
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 07:12:57PM +0900, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>=20
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>=20
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' un=
defined!
>=20
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
>=20
> The TH1520 is a 64-bit RISC-V SoC, so the driver is only used on
> 64-bit kernels. There is no point in compile testing it on 32-bit.
> Limit COMPILE_TEST to 64BIT instead of changing the arithmetic to use
> the div64 helpers.
>=20
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Cc: stable@vger.kernel.org
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/=
topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> v2:
> - Fix a typo in the commit message
> - Add Cc: stable, Reported-by and Closes tags
> - Add Reviewed-by tags from Andreas and Gary
> - Rebase on v7.3-rc5
>=20
> v1: https://lore.kernel.org/all/20260929095612.1072417-1-tomo@flapping.or=
g/
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 729776086879..abecd95b0c3c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -772,7 +772,7 @@ config PWM_TEGRA
> =20
>  config PWM_TH1520
>  	tristate "TH1520 PWM support"
> -	depends on ARCH_THEAD || COMPILE_TEST
> +	depends on ARCH_THEAD || (COMPILE_TEST && 64BIT)
>  	depends on RUST
>  	depends on HAS_IOMEM && COMMON_CLK
>  	select RUST_PWM_ABSTRACTIONS

Can't we do better than that? For C code the right thing to do is to use
one of the div helpers instead of a plain / for types bigger than long.

Best regards
Uwe

--jqdpbk4j34qnyqff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq8+ScACgkQj4D7WH0S
/k7KLQf7BjRATiykUsx7bSWzQisndytpY59lORjR+lDeN450aSqE4NGutWfo/zMk
mSBK6sGxpeyhYXxvSuooyu0sq/nI0lK1NVJwBqIYJb2B/DpQZ4rtZDjB9w4EqCRx
YRIxQWHhT7QkR7/br9ooB8kTJSYraeVBbvI+FpZheNrfXO3XKrVB/1l7Rq9NgcEL
j3FX1CRPdx3uJwZ73f41KwK3UBaPrhc0Ao2yHmA9ub/Hfg0IGJCG+RpAFs7kRFOT
74RY/qS+g62RnwZT3yBmDDro9BPNmcD5lV/eD/q7NgQxOGgbxDWkv91W0PZYgxga
mcfeJSqvTydk7g+nRkHKXN0xP4SemQ==
=FhuR
-----END PGP SIGNATURE-----

--jqdpbk4j34qnyqff--
