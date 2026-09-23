Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA933FE33;
	Wed, 23 Sep 2026 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128976; cv=none; b=YkCdrNETJx12Mn6Nuya9UG7ybFAXGiuEeQDF08ehV76N43LKikuBJpXz4BYEYdtihgaw+9WCEDFRZbkLSEICNt+psRDnK89E9N6uszKdp3ka0/Vk/wylyJixRvVXajGUJtBbcfvuikGk+i5I2L0nlHhWYENqsR+EBDEpqLL/KTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128976; c=relaxed/simple;
	bh=l9cUm7b1VTQnFg+PqSSFond5DaTkqWlQn+1a0vrudts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAUh+2NGpeney5u2L5euzQc3yMgn5+mh1jXrVVbb+Uvntb5Q6Fxz3ylw66Wa+OUSVM1jOsUQNxbFzBBs4loqqptdkuio+5dUlqCo9Vm1/OUkRnpqukq0vp+9ix7YUHuHeRiRt68jEpZUjC1BtJ4CkCEoIxBUuioC5V+zCFTUL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTHTfcR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTHTfcR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B21F000FF;
	Wed, 23 Sep 2026 02:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128974;
	bh=izCT6r+fEuhlkRxAjd7R+/31l1thtr3i/dcImqkT4hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CTHTfcR2pkpkIpe7ycoJPDU3rosVvg/dWR2ZV/0+/J5zAsSoLP82PIGS21yM93y7z
	 ls7Bc3N0yfy5lboHg4flQfTNw50niVHaH5C7A1FYalURizG1XsVz8pYrljD4U6ONGl
	 EpwFOeDQ62dSgYE+duFwM5Sgek2A83RhJn1C9UOlzpWtHkLMOZxt+99O1nykQrbNVa
	 tqBjYBPp+Db06xlwUofU+PWIN618V+W0+aL+E1GXq8VHKdBtghRunhmf7tT5zEzmJI
	 528Me1q5p3aHNt4cr/JDaVs1V2OWOK3GPAhyoIsVO3wQ2xsAQpx98L4NGrTzoZoBsO
	 fCu+v4fCzS29g==
Date: Wed, 23 Sep 2026 03:02:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux
 <linux@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Message-ID: <20260923030249.22abd603@jic23-hlaptop>
In-Reply-To: <CY2PR03MB6499337E7D978ECB90CB61C3BD9B842@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260826083156.2287106-1-lilinmao@kylinos.cn>
	<20260831005728.4c2b80b9@jic23-huawei>
	<20260921041227.61e00143@jic23-hlaptop>
	<CY2PR03MB6499337E7D978ECB90CB61C3BD9B842@CY2PR03MB649933.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 10:51:46 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> --
> Antoniu Micl=C4=83u=C5=9F
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Monday, September 21, 2026 6:12 AM
> > To: Linmao Li <lilinmao@kylinos.cn>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>
> > Cc: Sa, Nuno <Nuno.Sa@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> > Andy Shevchenko <andy@kernel.org>; linux <linux@analog.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.kernel.o=
rg
> > Subject: Re: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference=
 in
> > clkout registration
> >=20
> > On Mon, 31 Aug 2026 00:57:28 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > On Wed, 26 Aug 2026 16:31:56 +0800
> > > Linmao Li <lilinmao@kylinos.cn> wrote:
> > > =20
> > > > ade9000_setup_clkout() passes NULL as the register address when
> > > > registering a divider clock. During clock registration, the common
> > > > clock framework calls clk_divider_recalc_rate(), which dereferences
> > > > the address through readl(). As a result, probing an ADE9000 config=
ured
> > > > as a clock provider with an external input clock crashes.
> > > >
> > > > CLKOUT passes CLKIN through without changing its rate. Register it =
as
> > > > a 1:1 fixed-factor clock, which does not require register access.
> > > >
> > > > This change does not affect the configuration using the internal cl=
ock,
> > > > for which the driver does not register a clock provider.
> > > >
> > > > Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Linmao Li <lilinmao@kylinos.cn> =20
> > >
> > > Looking for a tag from Antoniu for this one. =20
> > Antoniu
> >=20
> > Please take a look at this. =20
>=20
> Sorry for the late response, thanks for the ping!
>=20
> >=20
> > Jonathan
> >  =20
> > > =20
> > > > ---
> > > > Changes in v2:
> > > > - Clarify that the configuration using the internal clock is unaffe=
cted.
> > > >
> > > >  drivers/iio/adc/ade9000.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> > > > index e57e24b6acdf7..4e96cc37fbedf 100644
> > > > --- a/drivers/iio/adc/ade9000.c
> > > > +++ b/drivers/iio/adc/ade9000.c
> > > > @@ -1647,8 +1647,9 @@ static int ade9000_setup_clkout(struct device=
 =20
> > *dev, struct ade9000_state *st) =20
> > > >  		return 0;
> > > >
> > > >  	/* CLKOUT passes through CLKIN with divider of 1 */
> > > > -	clkout_hw =3D devm_clk_hw_register_divider(dev, "clkout", =20
> > __clk_get_name(st->clkin), =20
> > > > -						 CLK_SET_RATE_PARENT, =20
> > NULL, 0, 1, 0, NULL); =20
> > > > +	clkout_hw =3D devm_clk_hw_register_fixed_factor(dev, "clkout",
> > > > +						      __clk_get_name(st->clkin),
> > > > +						      CLK_SET_RATE_PARENT, 1, =20
> > 1); =20
>=20
> Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git
Not that will probably not go upstream until the next merge window.

Thanks,

Jonathan

> > > >  	if (IS_ERR(clkout_hw))
> > > >  		return dev_err_probe(dev, PTR_ERR(clkout_hw), "Failed to =20
> > register clkout"); =20
> > > >
> > > >
> > > > base-commit: 6b9f23b5460818aaf199dda90210d5fc08d66c8f =20
> > >
> > > =20
>=20

