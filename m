Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1B3A3E7E;
	Sun, 19 Jul 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473387; cv=none; b=hSiiNzuT0OTYpjE63znsntEdUev8YQBxngP8Zl3uWL3MaDc53BBXUQYJztszqmswZcIDKwIEGeJR60DqxNXAAAtELhmlfEen0bORA5E+OPH9bnaym/5UdwuJwg04jRZjQf/vPU6xSpCOtXz84TKLpOY9wtTzN1MsTMbwdZnqlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473387; c=relaxed/simple;
	bh=B8qK7lqEuvyus4sqtOERzmEfJ4WVIkOIgPFctA386ks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUM5V5AnxWfPqX7NoA5PUj+QhOMr23gzs5vOsokHCp8Os3U25dS4M/nZ/PFxWd8F3etdxCiNpG399aVntuAfodB1ghh+am2mhoSUcOisfHfwCrvQVzMShJ+CS3HiX9e06zsNQG+0torMFhHCDw2qahKAELUtjmlWKDdzou38cSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=fRCW4Qqi; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fRCW4Qqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1784473382;
	bh=B8qK7lqEuvyus4sqtOERzmEfJ4WVIkOIgPFctA386ks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fRCW4QqifXu8a5lcyBgnb747dUdSyJMN+TblaTBKvW0EA1+dz7/BVB4sRmDuN8H1x
	 P4KneZFr57LfYDK1R8N3nGwQjHfHc9e/A+n3awoNqww6yfFEO68UL9u3eOsXq59gpL
	 eg1NOcYGg0J99KsmSCD3xRsr0wRsPBv8nQEcWUDg=
Message-ID: <da19028e919ac510f1248ecb1bd3d9e218cbae7c.camel@crapouillou.net>
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: Paul Cercueil <paul@crapouillou.net>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-mips@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	letux-kernel@openphoenux.org, stable@vger.kernel.org
Date: Sun, 19 Jul 2026 17:02:58 +0200
In-Reply-To: <E96B15FD-5B86-4375-B8B2-2051AC477F0F@goldelico.com>
References: 
	<c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
	 <alf7rSWaLBO8WBkR@zenone.zhora.eu>
	 <36148F30-156F-4E74-8765-D718F6FE7E76@goldelico.com>
	 <aliLbNJ51Ns0dIHX@zenone.zhora.eu>
	 <9421BB47-EFC8-4D82-989F-82A84FE46749@goldelico.com>
	 <aljCGkhZEQHzZVSW@zenone.zhora.eu>
	 <d869fc2e2fe6eec530a65a2e93b642fad1fd9903.camel@crapouillou.net>
	 <E96B15FD-5B86-4375-B8B2-2051AC477F0F@goldelico.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nikolaus,

Le dimanche 19 juillet 2026 =C3=A0 15:23 +0200, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> Hi Paul,
>=20
> > Am 19.07.2026 um 14:53 schrieb Paul Cercueil
> > <paul@crapouillou.net>:
> >=20
> > Hi Andi, Nikolaus,
> >=20
> > Le jeudi 16 juillet 2026 =C3=A0 13:41 +0200, Andi Shyti a =C3=A9crit :
> >=20
> > I think there's a misunderstanding.
> >=20
> > The JZ4780 I2C host's parent clock rate does not change here, so
> > caching its rate should be fine.
> >=20
> > The clock rate that can change in this setup is the one of the
> > Si5351
> > clock *generator* that is a I2C device.
>=20
> Exactly.
>=20
> >=20
> > >=20
> > > > But again: how would you solve this?
> >=20
> > I believe you have this problem because your Si5351's clocks are
> > parented to the I2C host's clock, am I right?
>=20
> No. There is no direct reference to i2c clocks:
>=20
> / {
> 	ref25: xtal {
> 		compatible =3D "fixed-clock";
> 		clock-output-names =3D"ref";
> 		#clock-cells =3D <0>;
> 		clock-frequency =3D <25000000>;
> 	};
> };
>=20
> &i2c1 {
> 	clkgen: clock-generator@60 {
> 		status =3D "okay";
>=20
> 		compatible =3D "silabs,si5351a-msop";	// 10-MSOP
> package has just 3 clock outputs
> 		reg =3D <0x60>;	// 61?
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
> 		#clock-cells =3D <1>;
>=20
> 		/* Connect XTAL input to 25MHz reference */
> 		clocks =3D <&ref25>;
> 		clock-names =3D "xtal";
>=20
> 		/* Use XTAL input as source of PLL0 and PLL1 */
> 		silabs,pll-source =3D <0 0>, <1 0>;
>=20
> 		/* Don't reset PLL1 on rate adjustment */
> 		silabs,pll-reset-mode =3D <1 1>;
>=20
> 		/*
> 		* Overwrite CLK0 configuration with:
> 		* - 8 mA output drive strength
> 		* - initialize output as floating
> 		* - PLL0 as clock source of multisynth 0
> 		* - Multisynth 0 as clock source of output divider
> 		* - Multisynth 0 can change PLL0
> 		*/
> 		master: clkout@0 {
> 			reg =3D <0>;
> 			silabs,drive-strength =3D <8>;
> 			silabs,multisynth-source =3D <0>;
> 			silabs,clock-source =3D <0>;
> 			silabs,pll-master;
> 			silabs,disable-state =3D <2>;
> 			clock-frequency =3D <8000000>;
> 		};
> ...
>=20
> >=20
> > So when you try to change a Si5351 clock rate, it will get the
> > clock's
> > lock and the clock parent's lock, aka. the I2C host clock's lock.
> > Then
> > trying to send a I2C command will indirectly trigger clk_get_rate()
> > on
> > the I2C host's clock to be called, causing a lockup.
> >=20
> > I think the solution would be, and CLK people can correct me here,
> > to
> > just drop the relation to the I2C host lock. Your Si5351 clocks are
> > not
> > derived in any way from the clock used by the I2C hardware in the
> > JZ
> > SoC (unless they are?), so I think they should just not have any
> > parent.
>=20
> The problem appears to be deeper, that an already locked clock
> manipulation
> requested from the Si5351 drivers issues an jz4780 xfer. Which asks
> for clock
> information. This then tries to acquire the same lock which blocks.
>=20
> And the next i2c transfer from a different i2c client tries another
> jz4780 xfer,
> which is locked because the previous one with the si5351 never
> completes.

Indeed, clk_get_rate() gets a static lock.

> IMHO the standard solution is never to ask for clock rates during i2c
> xfer
> but only once during jz4780 i2c probe and cache this value. Drivers
> for other
> SoC are doing it the same way. And this is what this patch is fixing.

Yeah, agreed.

>=20
> BR and thanks,
> Nikolaus

Cheers,
-Paul
