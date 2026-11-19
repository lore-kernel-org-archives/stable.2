Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098832;
	b=SRYHwillY+9xFlGrVFZq4+NGu+cz8sHbzyStM088BoFsSg6PZk/0xas6Rz8yW6TWqx5g
	 vzByXCgofd4p+bWmkfCvgjyfr1ygAj3kEuVSHZW/oMbdfqyKvZqR7S07aE5DFhcf/Lkpr
	 1t3nYfLxWPLJL2a33EubavtfvOveKrZzEbYmnOY9k5BHUDQVNy6Cd/dVqYHG5dB0usXca
	 L3yniuSn4tean4gHNdRK3P4VaBnawcZhd2wOe6zLEte1IB2sqyGZDlwKZV5auMyG9mXkT
	 W9xfw7CmM6EJamvLOeW60SudHLB9vtprKcJOO6pVr8ax3X9rMomevU3jSoVzAO9deWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098832;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dhlf17hlYcth1/KTGn94gfBGdrOLHnQzSpQfypZZWDE=;
	b=VmSTCg98xxFXf8AcJ8ptt0HXdZ66IoeXpM0Gq5kDNMIXSxuzhA4ueSDHY4Qc5TAV/FcB
	 wHz94WVOOHVg8UDgS1Q+y9j8/GU1IOIva5dubA0c8dQlspCobMnghjbWBh8NZjyYhPtt4
	 tnOO5UeDDu3Yct9YdQkEKmUdoOabe31jaQ4lI13EEmWP9R6u1fyqzbZk3IXmuIfgxzw+0
	 Y4NeEpLC+EhZuJPNf4Zmo9JAJ4wYNsFPV8qYwr23GF7LGJDDSfWTg4auvViFc08CgFRN1
	 xNX60Gpi4tzC5lqCkYEnzpU0eTrCQ6eS+qTvrkFFNBupyVlQPiscayOtSYjfEoWzNiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HR2nC5z/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D3606A324;
	Thu, 19 Nov 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HR2nC5z/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0371F000C9;
	Thu, 19 Nov 2026 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098832;
	bh=dhlf17hlYcth1/KTGn94gfBGdrOLHnQzSpQfypZZWDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HR2nC5z/FErj3cW4XSsKXHudQkhpI524f3NBI+iQ7JnwaZQCgZW0E4VIwpf7XCeJO
	 3J8ks5U8kMTx1bsFT7NmhyTM06RZm6tUiDNV5p/74fYxR2IDTSq0ch2xWP7FW7+guO
	 5Sb6Jd9UKjGApQ8imxnMSG7vR1Vp99hFO0bNBmzB/q0noEPVNuXUhSDAC3a4tH+dDO
	 eB3nzmBZduue3hMPCFYBGr234z33RPxAwz+iX/2q9ztB04fBANJNHxz/GP11/RFAjZ
	 oZsjWTlmMZKYlnR2BsbrUShf6kLyeyp0PGonlNhhGZjn/bgJz3G9sTVvD0jVsd6SXQ
	 z2DxN6StUusmA==
Date: Thu, 19 Nov 2026 14:33:47 +0000
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Foon Tan <lftan@altera.com>,
	Graham Moore <grmoore@opensource.altera.com>,
	Murugan R <vadivel.muruganx.ramuthevar@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <p.yadav@ti.com>, Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 06/10] spi: cadence-quadspi: Bound chip select against
 f_pdata array size
Message-ID: <20261119143347.GS98456@joneslee-macbookpro.roam.internal>
References: <20261119091810.3440619-1-lee@kernel.org>
 <20261119091810.3440619-7-lee@kernel.org>
 <DMZ3XW6ZEFDF.2WJ1XU4UKTRAH@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DMZ3XW6ZEFDF.2WJ1XU4UKTRAH@bootlin.com>

On Thu, 19 Nov 2026, Théo Lebrun wrote:

> Hello Lee,
> 
> On Thu Nov 19, 2026 at 10:17 AM CET, Lee Jones wrote:
> > cqspi_setup_flash() uses the chip select taken from each flash child
> > node's reg property to index the fixed-size cqspi->f_pdata[] array,
> > which has CQSPI_MAX_CHIPSELECT entries.
> >
> > The range check now compares the chip select against num_chipselect,
> > which comes straight from the num-cs property and is never clamped to
> > CQSPI_MAX_CHIPSELECT.  A device tree which specifies num-cs greater than
> > CQSPI_MAX_CHIPSELECT together with a flash node at a correspondingly
> > high reg value therefore causes writes beyond the end of f_pdata[].
> >
> > Reject chip selects which do not fit in f_pdata[] as well as those which
> > exceed num-cs.  While at it, store the chip select in a u32, matching
> > of_property_read_u32(), so that values with the top bit set cannot
> > become negative and slip past the bounds checks.
> 
> This commit message was hard to read! Can we do better?
> The issue at hand is super simple.
> 
> Repeating the last sentence:
> 
> > While at it, store the chip select in a u32, matching
> > of_property_read_u32(), so that values with the top bit set cannot
> > become negative and slip past the bounds checks.
> 
> Come on! 2147483648 chip selects?

Fair point!

Since cqspi->num_chipselect is already u32, C's unsigned promotion meant
a negative int would only have slipped past if num-cs itself also had
BIT(31) set.  Matching the u32 * expected by of_property_read_u32() is
reason enough on its own without the dramatic justification.  =;-D

Will fix.

> > Fixes: 0d62c64a8e48 ("spi: cadence-qspi: assert each subnode flash CS is valid")
> > Closes: https://sashiko.dev/#/bug/linux-cd463fc8-1b94-4bcf-8d06-fae21b88894c
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Is this worthy of backporting to all stable releases? It is a indeed
> a bug fix but which can only occur with a broken DT, probably during
> development. It sounds like a lot of churn.

Fine by me.  Will be dropped in v2.

> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > index 844df97111d7..fbb917c104b0 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -1751,7 +1751,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
> >  	struct platform_device *pdev = cqspi->pdev;
> >  	struct device *dev = &pdev->dev;
> >  	struct cqspi_flash_pdata *f_pdata;
> > -	int ret, cs, max_cs = -1;
> > +	int ret, max_cs = -1;
> > +	u32 cs;
> >  
> >  	/* Get flash device data */
> >  	for_each_available_child_of_node_scoped(dev->of_node, np) {
> > @@ -1761,8 +1762,9 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
> >  			return ret;
> >  		}
> >  
> > -		if (cs >= cqspi->num_chipselect) {
> > -			dev_err(dev, "Chip select %d out of range.\n", cs);
> > +		if (cs >= cqspi->num_chipselect ||
> > +		    cs >= CQSPI_MAX_CHIPSELECT) {
> > +			dev_err(dev, "Chip select %u out of range.\n", cs);
> >  			return -EINVAL;
> >  		}
> 
> OK this does fix the bug. Here is another proposal though:
> ensure at probe that cqspi->num_chipselect <= CQSPI_MAX_CHIPSELECT.

One slight hesitation with this.

In cqspi_of_get_pdata(), CQSPI_MAX_CHIPSELECT used to be 16 prior to:

7cc3522aedb5 ("spi: cadence-qspi: set maximum chip-select to 4")

... and cqspi_setup_flash() overwrites cqspi->num_chipselect with max_cs
+ 1 at the end anyway.

Thus if an older or out-of-tree DTB (e.g. with cdns,is-decoded-cs) still
has `num-cs = <16>` while only populating flash@0, failing probe in
cqspi_of_get_pdata() would break a working board, whereas clamping
num_chipselect or checking cs against CQSPI_MAX_CHIPSELECT only rejects
child nodes that would actually overflow f_pdata[].

That said, no in-tree DTS hits this, so if you prefer rejecting
(cqspi->num_chipselect > CQSPI_MAX_CHIPSELECT) or clamping it, let me
know and I will happily make it so.

-- 
Lee Jones
