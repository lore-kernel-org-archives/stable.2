Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102340;
	b=nfbTA90wrPwKfGNPCL2E+s8ff1y/JvKc2oerNE5jnRX7nl5Ld2Y1NrypF7u68bl0IT5L
	 gjHewI7XuYoYffSuiAs8w2jUrobOnqctO+d5T01X2dglCGPmHXvshK2cHMpg6vLGeN6NU
	 LPtL/lCWNhiMh+OJ+6n0fHaQ6QP6v8metG9wEfBB00x37ILQzXZU/ac8jrfCLARhq03tZ
	 my2+zzynF+mJoFY6kPANjK1gdusYiuNn1XCM17cZcOkB4jWOuiL4bg6SN8zC9OgxWm8Gc
	 CHUTElIbYlwpstFoPr4ySGl8GXpwm3rTqjGXRlFXBxUAEroBuXXBg3ynX/HdmiRuuNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=bD8MLZ9ZbrchF1SpPDoVOJCryLSZEKz+5+1CuL2nnl4=;
	b=Aj4HIDjbCEaRqGhZ96E1TwN6QlALAaZO2Z8BA9C3CYeAVLRioBl3+J7N5ZtwRm8xLrs/
	 PxdAdKnfZxvSRrQjYRKu60Cv8SNhFsGBuXyAzMN5TTSL6PbRnsyfqCFplPJLuXWksLzu9
	 xStlhd/sAm/5gKTFXVKkrdhptleHAfFf+p8lIOe52rdxfTQvi0wM/rZjOpIZl6sg4/ied
	 VSOXl+xTxraFyvMRjPvdc9/KOQuD+zByiC0FySvmtdH1XIxCXpVoI7b+jHlgW9CTKIDqN
	 IHBp6Gz8PTSrxpNjKD+BT2YsGOenIiX/DSt5Ae4Vb2jIgwVSl5JPlol5nPjQxm4x2RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbxNNu9H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBA606A33E;
	Thu, 19 Nov 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbxNNu9H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C041F000D0;
	Thu, 19 Nov 2026 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102340;
	bh=bD8MLZ9ZbrchF1SpPDoVOJCryLSZEKz+5+1CuL2nnl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZbxNNu9H4CikBUIqN6pUHnayOTcS4d1AhNeXmnSDSZ8aju6rsKx0CRla62jYCzHKT
	 X8i5JGKVmlcjwARwvUDIGDmapAfREHOOmfaBh/os/jmZbtPIXSoSxZc5QLmguy5Zyk
	 rL0KgmRsph2ewjq2dfSS7b1o+gf88qQUBsEdkdNEVQA/qFYVJ12rVs6cCAxNirsiHm
	 LXVewLFxIIZwsdYCnoqlB8eM5XO87Lywz54BXSoCY2B80Nj3ooZQs1GPt2AZbXk6il
	 hOvGsq3jcXfkGiNT63FTQ7+JJRxgwWdIepd5+kL01H9mvEe7hANOexkxmNMWGwHKw4
	 MzBb4TBXLlpGQ==
Date: Thu, 19 Nov 2026 15:32:15 +0000
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
Message-ID: <20261119153215.GX98456@joneslee-macbookpro.roam.internal>
References: <20261119091810.3440619-1-lee@kernel.org>
 <20261119091810.3440619-7-lee@kernel.org>
 <DMZ3XW6ZEFDF.2WJ1XU4UKTRAH@bootlin.com>
 <20261119143347.GS98456@joneslee-macbookpro.roam.internal>
 <DMZ9VNGP6GSZ.15VHI64APKAQR@bootlin.com>
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
In-Reply-To: <DMZ9VNGP6GSZ.15VHI64APKAQR@bootlin.com>

On Thu, 19 Nov 2026, Théo Lebrun wrote:

> On Thu Nov 19, 2026 at 3:33 PM CET, Lee Jones wrote:
> > On Thu, 19 Nov 2026, Théo Lebrun wrote:
> >> On Thu Nov 19, 2026 at 10:17 AM CET, Lee Jones wrote:
> >> > @@ -1761,8 +1762,9 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
> >> > -		if (cs >= cqspi->num_chipselect) {
> >> > -			dev_err(dev, "Chip select %d out of range.\n", cs);
> >> > +		if (cs >= cqspi->num_chipselect ||
> >> > +		    cs >= CQSPI_MAX_CHIPSELECT) {
> >> > +			dev_err(dev, "Chip select %u out of range.\n", cs);
> >> >  			return -EINVAL;
> >> >  		}
> >> 
> >> OK this does fix the bug. Here is another proposal though:
> >> ensure at probe that cqspi->num_chipselect <= CQSPI_MAX_CHIPSELECT.
> >
> > One slight hesitation with this.
> >
> > In cqspi_of_get_pdata(), CQSPI_MAX_CHIPSELECT used to be 16 prior to:
> >
> > 7cc3522aedb5 ("spi: cadence-qspi: set maximum chip-select to 4")
> >
> > ... and cqspi_setup_flash() overwrites cqspi->num_chipselect with max_cs
> > + 1 at the end anyway.
> >
> > Thus if an older or out-of-tree DTB (e.g. with cdns,is-decoded-cs) still
> > has `num-cs = <16>` while only populating flash@0, failing probe in
> > cqspi_of_get_pdata() would break a working board, whereas clamping
> > num_chipselect or checking cs against CQSPI_MAX_CHIPSELECT only rejects
> > child nodes that would actually overflow f_pdata[].
> >
> > That said, no in-tree DTS hits this, so if you prefer rejecting
> > (cqspi->num_chipselect > CQSPI_MAX_CHIPSELECT) or clamping it, let me
> > know and I will happily make it so.
> 
> I still prefer the clamping or erroring from probe. A devicetree (ie
> hardware description) which tells us this controller has 16 CS has, is
> and will always be wrong. I don't see why we'd want to bother with this
> edge-case.

Noted.  Thanks.

-- 
Lee Jones
