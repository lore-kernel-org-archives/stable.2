Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034745;
	b=ODfKVOMQOx/iRwz4dyihMbByFFUZdMqYc+tMHMDgjGWZISQn+vd9MDQDLSgfuXxdwDnf
	 zScS4UlcQCnHkCFfPBZ6+fQyEfxxAWsbhiB0A8JOQFjTDsoXV/FjYoYZ59DmVI/USJbhd
	 DeVtSk2gzN/ltFgsO1F0eQe/nXAM/ssc6iOggXWbC1z1iNpnO16+2Bd4HTDpsIzrJRaJ5
	 iIR9McLGKGA4bdER1RtbIjKvcqY/vwQMb6cTwPiAad9wSj0vZLtnzlRyTaZZU9sXplQuj
	 1MtdDN5IUZcPtzNL1X/Qx5x9ABG7DkNxQ4+j04Wateq8Uw5BCIfzPkP/vXWwFc0zeLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034745;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QbybTSOHowhM6+drpSBiOiKPoSPcQxenEWxGQaVFFZ4=;
	b=UrO8vsL7zJeIOZsg/Gr6jkaxYZS5cr/Hdbc7kn/ODtA5eEcYdU+8Xc/2wOiB61raTv2T
	 AJQ8imIhmlsFKIiCOmavreVtxa5qYmEC4TOvlwwx88P0S/FMnmiQHruYj+qgHa5B5VAlN
	 ogQBFAUK8Aegd+lDK8nqyyz57fL2PbHd058XyHp3T8Qe0dpRmeQn0S7PkNDw8lzbW2ANN
	 4Ne7qekdzHFG9OqWzunCPKHl2F8Zrx5K6zWtvREQN1XxGLvGO+pW5HdzXJewxpf6Ug5ox
	 9y3KyAVpvHK3pexvfPOEOyCAiuI95tOstXdkTL88YX3Cq7yF8q+FQZRHBuMbEPBXuVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PURilTs9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811C606A320;
	Wed, 18 Nov 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PURilTs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A21F000C4;
	Wed, 18 Nov 2026 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795034745;
	bh=QbybTSOHowhM6+drpSBiOiKPoSPcQxenEWxGQaVFFZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PURilTs9qUY+9JKfys+WdrOIjfVfRogk4QEubI+D81/MQKsccgM7jVVlfZsljbGYa
	 ZkwHn0B8q6p44BRkLNw4mlvCDowwG4KeNy5mcPrvC6ehWJgfN9WdJJ7HRV3aSiJtrf
	 d5ztM7s4P7jpCxwPyfjxKEHgI83QxykAMGlet1HfEfRN6ZG4CuOdP6joKh5oIcLXI4
	 kZDfKPqTaaNgtMn5Uxzl5Povk4ILpY7L71tvnAuZHyknnpWPL2B+sacYPgWShRGfKQ
	 xksywGO/XI4IAEqjjMRdzWDGJJ/ATw3PlbNen9Hs6wjYN9TMtMDukYn+o3eUInH0kD
	 fLFqyC8PW+Kmw==
Received: by venus (Postfix, from userid 1000)
	id 1A8FC18044A; Wed, 18 Nov 2026 21:45:43 +0100 (CET)
Date: Wed, 18 Nov 2026 21:45:43 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform: arm64: lenovo-thinkpad-t14s: Keep the
 interrupt off while suspended
Message-ID: <av4OAxLNIIXWBz9F@venus>
References: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5izatejbdld364i"
Content-Disposition: inline
In-Reply-To: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>


--b5izatejbdld364i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] platform: arm64: lenovo-thinkpad-t14s: Keep the
 interrupt off while suspended
MIME-Version: 1.0

Hi,

On Wed, Nov 18, 2026 at 05:39:25PM +0200, Abel Vesa wrote:
> The interrupt handler reads the event from the EC over I2C. Nothing
> keeps it from running while the system is suspending or resuming, when
> the I2C controller cannot be used.
>=20
> On resume the interrupts are enabled again after the noirq phase, while
> runtime PM of the I2C controller stays disabled until its early resume.
> An EC interrupt that is pending by then fails, and so does every further
> one until the controller is back. On the ThinkPad T14s Gen 7 that showed
> up as more than a thousand of these in a few milliseconds when resuming
> from hibernation:
>=20
>   geni_i2c a84000.i2c: error turning SE resources:-13
>   thinkpad-t14s-ec 7-0028: Failed to read event
>=20
> Disable the interrupt when suspending and enable it at the end of
> resume, once the EC can be talked to. An event that arrives in between
> is handled then.
>=20
> Fixes: 60b7ab6ce030 ("platform: arm64: thinkpad-t14s-ec: new driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> The EC interrupt handler talks to the EC over I2C, and nothing stops it
> from running while the I2C controller is not usable during a system
> sleep transition.
>=20
> This was found on the ThinkPad T14s Gen 7 while getting hibernation to
> work there. The support for the EC of that machine is not upstream yet,
> but the interrupt handler and the suspend and resume callbacks are the
> ones the X1E based ThinkPad T14s uses.
>=20
> Resuming from hibernation failed the read of the EC event more than a
> thousand times in a few milliseconds there. That many, because the
> interrupt was level triggered in the GIC at that point, as the SPI
> configuration is not restored after hibernation [1]. With that fixed,
> the handler still runs once before the I2C controller is back.
>=20
> With this patch there are no failed reads on the ThinkPad T14s Gen 7
> when resuming from hibernation. It was not tested on the X1E based
> ThinkPad T14s.
>=20
> [1] https://lore.kernel.org/r/20261024144720.113165-2-zhuling2709@phytium=
=2Ecom.cn
>=20
> Prepared with help from an LLM-based assistant.
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

Greetings,

-- Sebastian

>  drivers/platform/arm64/lenovo-thinkpad-t14s.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/plat=
form/arm64/lenovo-thinkpad-t14s.c
> index 873747838a4f..a291daba0577 100644
> --- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> +++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> @@ -616,6 +616,12 @@ static int t14s_ec_suspend(struct device *dev)
>  {
>  	struct t14s_ec *ec =3D dev_get_drvdata(dev);
> =20
> +	/*
> +	 * The handler needs the I2C controller, which is not available
> +	 * again until this device is resumed.
> +	 */
> +	disable_irq(to_i2c_client(dev)->irq);
> +
>  	led_classdev_suspend(&ec->kbd_backlight);
> =20
>  	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
> @@ -633,6 +639,8 @@ static int t14s_ec_resume(struct device *dev)
> =20
>  	led_classdev_resume(&ec->kbd_backlight);
> =20
> +	enable_irq(to_i2c_client(dev)->irq);
> +
>  	return 0;
>  }
> =20
>=20
> ---
> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
> change-id: 20261118-platform-arm64-t14s-ec-irq-suspended-5fd6892d7e26
>=20
> Best regards,
> -- =20
>=20
> Abel
>=20

--b5izatejbdld364i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr+DnMACgkQ2O7X88g7
+ppOkA//aIBrZEoYRI0N4spyPKuZ3/aU2T1SuY5JsTJGd226Rrbd1vh92h0VqVfy
1Cy0MOvr4GPrDewHV/VU/TPkuejillNUFOrTnNqX/Kk+3fPmIJS8+9RMhIfrqNWv
JRxAkBpsR+qLwwzaelymVV25S5BleqPGecs6PHNdgIz0WqwFdAeRigHI0CyzFnLM
IsEpkuS4RZMezpyi3Qbzake02CLP4CgZR9KQGVbLjxx2IVT7HYiFURmbI4v2bQXV
VS32/KkPNqHWTulE1H3c+2Ce6rHkZhrvC6EN7ZF+MQNpjyO1Yc/7OOUs96NkzTW6
Vn+N/+8LJMsJ4TuBAT4y9u4ZiAWk7Os9mBREA37sVRoZu8wqHPd/dbgmp+MknF1g
IcRXQrTjJujfocCiCzhNbjEgDQDDX5bIYvkkfXN3dAy9srlZU91b+vvaB9Gx/tSA
S/RNj7S4ndG018n7WgivrSKoq+LGApxg5K1biSMiNaonp1wFN7/5lMpKGS+q2mad
4z1OVakGRmIWXPO4aJN8WVw9cv8+y7Z0oXEQYXQ0aZ6A9BJpmEkEIMXJB5CUuoL3
B6zwIXE74oNVL8MM/09kmufa1rxp+ohCwwVEkIUXYiGEI+jJE5HhZTve3Oj7BfIl
XV/tg8Kf1YnjSUoE2jbhPBq/gjHIF0Vxy/SYLRZs1Qr1GIVnM9Y=
=IZ3w
-----END PGP SIGNATURE-----

--b5izatejbdld364i--
