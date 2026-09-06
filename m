Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DB36C5AE;
	Sun,  6 Sep 2026 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788696809; cv=none; b=QFHSSONT0vaTqpLZvHcgLac+UBJTzoVlXHU0C4mINJxwZilkNmVwH0XcdZOUPjqSRVT5YzaCv15izrssqfuWUf9q6UB9m6yV5bB74vb8h9EkSRTmnc8XB77EF3rVF5j5laFR8GLy2Yq5teuOqAsvWecy9PNVilYdCsZaEWJkyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788696809; c=relaxed/simple;
	bh=JoX+4qSFFMN+L4xHTJtPsdvCJAw9oVa5W8xkDhz6TVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae5dJZg9gwJ5Y/NagcTx/cNFHZ6aX4ExuEpwT1r9Qhc/C2ZM0HyKssAWrlO0QGfWmVLOm16JZmjAJImihPLUr34ao2xhcN+MyFwojiMncX9QgQ/znocDJNlfdxqPUXpBzhzdWxmltzwGp7UwnmZq6ehnAVoSXUn2K8PkcXYhVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3f8DTWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3f8DTWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E191F00A3A;
	Sun,  6 Sep 2026 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788696808;
	bh=a1tOY4MZQE507M9gRXR1BfxSF3zDt0wgYos6fdygY4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A3f8DTWGiM6k3CWQMROCBVAVm4eKmgo0Codp9squ0pf7yHZrAw+DL0bxmcCWQrDCP
	 MzzHkQ1ZEV8k59pqEUPDe1+UfxYCPZ/eBSrzg12d73IGcVZC2L0zDFnaIvt4kWnce5
	 fvAwWj6S5UOY4TlySSkQWeDXjpu00coZH/40BdJJs9QMbKHVCzme9NRC1fGygWJQFW
	 3Kcze35RlRhqieTOyEZuXZX9/Npmx1YWOO9f/JuruqnJVoChy3vI4Uc78kX6n6ANRu
	 bt+/gB49NWyEOSMoONPDVRcU7DSpANF27W1qUZtWnXM4LZHXDiLccuNm/2/Eh4dvGH
	 2fSE9tD9BEx5A==
Date: Sun, 6 Sep 2026 12:13:25 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] clk: spacemit: k3: add CPU PLL rate tables
Message-ID: <20260906121325-GKA2346@kernel.org>
References: <20260903-k3-pll5-pll8-1800mhz-v4-1-afafd9cb47d9@linux.spacemit.com>
 <apmuG46sBg2rGzCD@aurel32.net>
 <DL67LEVCXFA5.39M5FO7JGKWZS@linux.spacemit.com>
 <20260905220746-GKC53903@kernel.org>
 <DL86Z6P8P2YI.160YXDVBSSC6I@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F2FCGouVpjxJtywV"
Content-Disposition: inline
In-Reply-To: <DL86Z6P8P2YI.160YXDVBSSC6I@linux.spacemit.com>


--F2FCGouVpjxJtywV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Troy,

On 19:20 Sun 06 Sep     , Troy Mitchell wrote:
> Hi Yixun, Aurelien
>=20
> On Sun Sep 6, 2026 at 6:07 AM +08, Yixun Lan wrote:
> > Hi Aurelien, Troy,
> >
> > On 11:24 Fri 04 Sep     , Troy Mitchell wrote:
> >> Hi Aurelien,
> >>=20
> >> On Fri Sep 4, 2026 at 1:27 AM +08, Aurelien Jarno wrote:
> >> > Hi Troy,
> >> >
> > ..
> >> >>  drivers/clk/spacemit/ccu-k3.c | 96 +++++++++++++++++++++++++++++++=
++++++++++++
> >> >>  1 file changed, 96 insertions(+)
> >> >
> >> > Thanks for the patch, it makes sense to add all the values, to suppo=
rt=20
> >> > future firmware changes. The values match the ones in the vendor ker=
nel.
> >> I forgot that you had a similar patch as well..
> >>=20
> >> >
> >> >> diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/c=
cu-k3.c
> >> >> index 92b930d5ff30..950bf531c734 100644
> >> >> --- a/drivers/clk/spacemit/ccu-k3.c
> >> >> +++ b/drivers/clk/spacemit/ccu-k3.c
> >> >> @@ -29,15 +29,91 @@ static const struct ccu_pll_rate_tbl pll2_rate_=
tbl[] =3D {
> >> >>  	CCU_PLLA_RATE(3000000000UL, 0x0b3e2000, 0x00000000, 0xa0558c8c),
> >> >>  };
> >> >> =20
> >> >> +/* Keep the firmware default as the first entry. */
> >> >>  static const struct ccu_pll_rate_tbl pll3_rate_tbl[] =3D {
> >> >> +	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
> >> >
> >> > Is it really necessary to put this entry first? I guess it's the cur=
rent=20
> >> > default frequency, but we have seen it can evolve. From my tests, th=
e=20
> >> > driver seems to just keep the value configured by the firmware=20
> >> > independently from the table order, so I am not sure it's necessary.
> >
> > I agree with Aurelien here, the default frequency isn't a solid stable =
settings,
> > which it may changes in the future
> >
> >> I think keeping it first is necessary. If the current register setting=
s do
> >> not match any entry in the table, ccu_plla_init() falls back to the fi=
rst
> >
> > Isn't it a bug if all frequencies added still couldn't cover all settin=
gs?
> > I'd simply suggest to bail out and yell loudly if there is a mismatch
> >
> > I just don't like putting specific frequency at first one as default,
> > this logic is kind of fragile and tend to fail easily..
> I checked the Rockchip PLL driver. The RK3036, RK3066 and RK3399
> implementations calculate the current rate directly from the hardware
> register parameters. If that rate is absent from the rate table, their PLL
> init callbacks return without reprogramming the PLL. With
> ROCKCHIP_PLL_SYNC_RATE enabled, they only synchronize the parameters when
> the current rate matches a table entry but the register parameters differ
> from those in that entry.
>=20
=2E.
> This approach seems preferable to me. Would it make sense to sort the rate
> tables by frequency in the next revision, and follow up with a separate
> series to calculate the current rate from the registers and preserve
> configurations whose rates are absent from the table, as Rockchip does?

Yes, I generally agree with this approach, so let's push current patch firs=
t=20
ith sorted frequencies, then improve further later in another series.. than=
ks

--=20
Yixun Lan (dlan)

--F2FCGouVpjxJtywV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKvBAABCgCZFiEEtbq4ycMbcRVnAiPcMarqR1lNu+0FAmqdWOEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMywyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNUJBQjhDOUMzMUI3MTE1NjcwMjIz
REMzMUFBRUE0NzU5NERCQkVEAAoJEDGq6kdZTbvtmWIP/iCrHq2W26Wfvg8tEN7m
n2hSpjT3d1mMqJKafoClEXJiAAh+rPE2it5vXye3FHlfTXjxp6DdsQKClkAgU7Uo
7RrFXdsU4c2dXfXJV+eqNCtos2unPhgIMelxu+rLRp9ZvqiI7qJ7ud8mnCyYHDf5
8JzrzdfdkE2nZ5J1NeK/AntbfrIFBn07lceNKpZJDELwwomO4vkoBfcuf2/+knGb
xiYSE12MD0F5JUbZSlFmaiMkpDA2gckLQqa0bZPsfGEfVN5sWDYwVfDKSA7HH+3U
/M+mGzUJQgXcxKTGPH3UI74EEzp6t6OUK7JEL9YLmusO8wXGfOfJMhww/FpwcoIH
EBx+HhsvL5U/ZbEksoT4/O236JcGpE228krSUFGcolJ+TLkluqFqWT48vARwLjOs
GmdDDOAM56MDHgi5oh9nus2FoAgpdjRbHtmHOIIb2IWZP/ky7Q5lLzM3qD+wIymG
GhPH98S8NxRP3Ns1OqfG78GNpSe1Wfc2FMkZIhtJw2C7Z2vSRvs51jJE+qxT1l8U
LSz5CjyHHZq3FHWViq7Sn7aa0iU/mE5EmGQdxvNWej11F6takNQBlakCeygBzuIL
TXElUH+s8VjZIDq5pahgpvHpPy6KgcOtUZSsFIUnVPHfx2H7IALFgcm2+9uZ2sze
0m/lt5UaqJzeZPxisPZgdTK8
=QtQN
-----END PGP SIGNATURE-----

--F2FCGouVpjxJtywV--
