Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7748BD47;
	Mon, 21 Sep 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034973; cv=none; b=pkxGYuDK0w+0/SFl69lKT5bfkwUT//k1blAEfTRoeR677fkamWZCb4s4+lurRpB98wNwWFmu2RjuhTN9FSTfakCkwo1cWZo/MN1241+28thrb65a7BM614zhgGL5RisTENsHWyq4DcFTy0zybddA6G+IdTr5dXt2Pg3ARg+NpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034973; c=relaxed/simple;
	bh=CNpH2CiJdLH4J8i0FELeSpqlURAM6+z3/Kfw7e3mFsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/0OBVrdqPgnrAsQMELWIXh8E+W2JdXHEz8/9j+f8kBm+NAErtpUIoU52cv8holzdhRAF6dEmcOgq3YdQs20xMkIDVF5xzr6Lsp3UanZq3DL7C+2Zw73t0p6bSDqvZw1bIiftFnM1y7p3Ym5SU/L/2QMeBRUcVUe6Te1M5pCj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIxivc17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIxivc17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DB01F00893;
	Mon, 21 Sep 2026 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034971;
	bh=YzzecS67/0aUSkLWxgELsl3YaUCRgzFDJOg+Ant+wdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VIxivc17/0ZSLAyaV5P1Er+Yq5GdR7Brr0B0eshyk7ACkgvDf9lp7nOZ42576+Beg
	 sSJ2wH6PsjbDDyAmm1AwT981aksDPrMT7vZmx11ulEKOxC536lA7kOIcVaj3r38k30
	 lBpo3vJDQi08hBdcmbzq1WEGgtY2iA7blNi+UW1LnX00ma9BWb8dvHe2vbGiMzsZ1h
	 5wTX3ghOQZBm3gKb/PVimjI1gSD6oDgAI7CioDSlH3wEF/ai546rTU+GkxK3G0GJyf
	 2N97DSw/kdqZCSUDuttX1yYetCJ3R8orfxIxXiQM4kRl28LL6l/TdWO81g2ZGFXs/q
	 QTYrSCYZg556w==
Date: Tue, 22 Sep 2026 00:56:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <andriy.shevchenko@intel.com>, <dlechner@baylibre.com>,
 <joshua.crofts1@gmail.com>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <sashiko-bot@kernel.org>, <conor+dt@kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v7 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <20260922005607.4de00f3e@jic23-hlaptop>
In-Reply-To: <f8ac8ad69138fc9e19074e491f91f2892e7bba95.camel@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
	<aq0J9Vs1_rUAlcoA@ashevche-desk.local>
	<20260921000803.1148e493@jic23-hlaptop>
	<f8ac8ad69138fc9e19074e491f91f2892e7bba95.camel@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 14:16:34 +0000
<Ariana.Lazar@microchip.com> wrote:

> Hi Jonathan,
>=20
> Thank you for the review.
>=20
> > Anyhow, let me queue some of these.=C2=A0 I doubt we'll see anything new
> > from sashiko given the minor tweaks the rest of this series.
> >=20
> > So with that in mind, applied patches in this order
> > 1 2 4 5
> > held 6 back for the thing about checking if property present.
> > 3 7 8 with link dropped.
> >=20
> > So just 6 9 and 10 for next version please.
> >=20
> > All the above on the testing branch of iio.git. =20
>=20
> I was wondering if the correct approach for the v8 series is to create
> a new branch based on iio/testing and add the remaining patches onto
> it?=20
>=20
> These would include the needed changes: the property_present check for
> the label (former patch 6), the new precursor patch for the EEPROM
> mutex (former patch 9 split into 2 patches), along with the refactoring
> and SPI support additions (former patches 10 and 11).
>=20
> Please let me know if this is the preferred way to handle it.

Yes please do that. It will probably confuse sashiko but as discussed above
the chances of Sashiko spotting new stuff at this point should be low
anyway.  Prior to the LLMs becoming useful we used to do this sort
of partial series being merged a lot. It's less common now as we
loose bot coverage.

Thanks,

Jonathan

>=20
> Best regards,
> Ariana
>=20
>=20

