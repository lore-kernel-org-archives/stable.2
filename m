Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA374CDA25;
	Wed, 16 Sep 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556159; cv=pass; b=lFtIN+40MOFXM8Kvgweynl4B8KsN2nsj3kc2d0O48c04oZYQeeB03GJ3Lb+XdA4fCmmeGDD+0ZtmN7H7cH2GktOH4kMbdUqGgQUZZeN+eUnKAVoAWrPNOUkQC7Vj17mhoryCRPGL7NQar7163eTb9EuvDQpeqwR3/U9U63H8LM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556159; c=relaxed/simple;
	bh=h7hwrBNm9KgLCgtXSIfqFteBSYkIeeEyEYqo+xhafss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWwtoM1qs2nga6CR5dw7qSkfFmbFxccOEk1AFzzWJ1SCYUCMyxBgNHnLRmHcjeXoaXLuwKdzK3M8HxPEAlyYKjlgXT14JQclqdOpOoq06iw7FG3PrSnBmJwKxz+icYKUEc/7VVmmzoK7yWmgRA1zzLpCAEu0MqeWk3zJQQ5Q9w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kaM1Hf24; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kaM1Hf24"
ARC-Seal: i=1; a=rsa-sha256; t=1789556121; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jEaBHBWW5yD1J0TV/UbG5j9Ewwl04zZ0anGKtYuxZaxWTDAnAaAn9hIMaKxRayNED76FPKo9p4NTfRBSMdROVlzvQ8TJazYtmd9JoZffPyuH8Ys6Ryl7awiwFy0rutLa6WlEAaob6pyrymdltl3Sf1UC+CoeOu0EpWOGZwCu7OA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789556121; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uva0NgB3KxuwVZLkt485f87mZRbvUkG56Nz1XWwQ3aQ=; 
	b=ZBAYs5YLuR0GEBF34x5oeX6OxtXp/UjG18mSMlftfgaxj3TTDJ9YyL/Jpba/oammHpNpGGF5XPhCfv8YoZdGWcKbyoSBCrWVAfVAuuN15TjyZdwuNAn16r1DMYQuKU5lFtLBxZHf4xjfiatE58u9aqr0pGegHFXo9ycFJPy04bc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789556121;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Uva0NgB3KxuwVZLkt485f87mZRbvUkG56Nz1XWwQ3aQ=;
	b=kaM1Hf24gWrC/DYDPNrI1n9Mt7jEguW0zimgpIshelsPRysqaJLfZKM+rwO/tiPl
	Q06kEQNpxhH8w/ZzLv5vXZ31v0cgwiyrNMTY6XH8pWKqVCuU/fROC9nVNp7ellxtBM0
	UCW+fqrJkMfkzireW/BhnOYPIWmXGVWmgklpDe34=
Received: by mx.zohomail.com with SMTPS id 1789556120046516.7994642098594;
	Wed, 16 Sep 2026 03:55:20 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id EBB86180918; Wed, 16 Sep 2026 12:55:15 +0200 (CEST)
Date: Wed, 16 Sep 2026 12:55:15 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andriy.shevchenko@linux.intel.com, brgl@kernel.org, heiko@sntech.de, 
	linusw@kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, ye.zhang@rock-chips.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: rockchip: Fix bank clock leak in
 rockchip_get_bank_data()
Message-ID: <aqpxJaYqJ5NHG1No@venus>
References: <20260916102258.2018689-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pceyosqab754y6el"
Content-Disposition: inline
In-Reply-To: <20260916102258.2018689-1-vulab@iscas.ac.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.544.40
X-ZohoMailClient: External


--pceyosqab754y6el
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpio: rockchip: Fix bank clock leak in
 rockchip_get_bank_data()
MIME-Version: 1.0

Hi,

On Wed, Sep 16, 2026 at 10:22:58AM +0000, Wentao Liang wrote:
> rockchip_get_bank_data() obtains the bank clock with of_clk_get() and
> enables it before reading the GPIO version ID.  The reference returned
> by of_clk_get() is never dropped on the error paths that follow:
>=20
> When the debounce clock is missing, the bank clock is disabled with
> clk_disable_unprepare() but the reference is never released with
> clk_put().  When the version ID is unsupported, the function returns
> -ENODEV leaving the bank clock prepared, enabled and referenced.
>=20
> Drop the reference with clk_put() on both error paths and disable and
> unprepare the bank clock on the unsupported version path so that probe
> failures no longer leak the clock.
>=20
> Fixes: 41209307cad7 ("gpio: rockchip: change the GPIO version judgment lo=
gic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

This got fixed in 3e46c18d5d87 ("gpio: rockchip: convert bank->clk
to devm_clk_get_enabled()") and 950007767823 ("gpio: rockchip:
teardown bugs and resource leaks") already. Please make sure to use
latest kernel trees.

Greetings,

-- Sebastian

>  drivers/gpio/gpio-rockchip.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 44d7ebd12724..69a7cd8c9a1a 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -673,6 +673,7 @@ static int rockchip_get_bank_data(struct rockchip_pin=
_bank *bank)
>  		if (IS_ERR(bank->db_clk)) {
>  			dev_err(bank->dev, "cannot find debounce clk\n");
>  			clk_disable_unprepare(bank->clk);
> +			clk_put(bank->clk);
>  			return -EINVAL;
>  		}
>  		break;
> @@ -682,6 +683,8 @@ static int rockchip_get_bank_data(struct rockchip_pin=
_bank *bank)
>  		break;
>  	default:
>  		dev_err(bank->dev, "unsupported version ID: 0x%08x\n", id);
> +		clk_disable_unprepare(bank->clk);
> +		clk_put(bank->clk);
>  		return -ENODEV;
>  	}
> =20
> --=20
> 2.34.1
>=20

--pceyosqab754y6el
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqqdZAACgkQ2O7X88g7
+powAQ//a5Z8xeBh85w663VZhDaGQvR2X2ve7juhsvd1Tnd6nC8HkT0qj226YZIg
RyT32AJg6xMJwpXYFHljIdJURzWF71WB/qIEn+JPwEeYM2pBrqcFK9ULt7fgeJ1N
Jas1rkSyeFmHajw+9Hq3uWyLAcPLV7qJKZJcuuTFu4EtxDG9gmZTr1WxXk9x/wRe
bGEAGtgmCqeXUiizIc1OklUVQ+mG3RxxckCd/KrmFQH1MPfTtAElPWI+kCaB018C
4myy1GtEisUSYe4Oy9j8FR+d1olFCFVz2gtSWE7I/7U6E5zOAH0oJcY3wrdZ2UnQ
kOtGhlU2lnyUtAvbhCpSx8P3Kv/9/sfBKKNW2g616VsV5ISco2tQMByEc+2f7yF8
5iDs3ItxwmjTWuV4FTUPhOkjfm55ObQbK8TinY1GseG2ZZchJKuSnzMbkOKsxi2h
pt62dmxrSpNR8DVL4o9kibM+ro/rjPTgCbWmTjq5oA2bL5/S28rATmewYcxS53Op
9k1QWa5p+3++gRENV0RyswrGMB0KLbiGjR8lWbI1nrZGtYC7tSDRYfoMWTATx/YM
R+Sh5hSDEZJXs8uLA0cFCPjWP7sz0FX0mA5VXY2FUhO1zxSWqAynsPNVrIz7MvIa
r1Vo0ZPa5snWt7h0JRm7eYw64w4/raHcfk2PZlqu9pLwt8392kg=
=JxUH
-----END PGP SIGNATURE-----

--pceyosqab754y6el--
