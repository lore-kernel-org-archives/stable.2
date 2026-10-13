Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CD4071E5;
	Tue, 13 Oct 2026 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914242; cv=none; b=Y/fXWkKt63jDyI0k5mE8u6JFkwLOa/ys4DtRRJ4JeYwAcDXIRXobyw+nam4lUl44adA4zysBd0jDd2rEXJyrd6K+/id3tcaueDe8SpgIv3Dd8Q8ewOtWF2yf0B16Wdly10qP1uLI2TGs12AIlYesdWroSM0eaBiyz5G4LajbW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914242; c=relaxed/simple;
	bh=fO5u74203iypNJHOaxa72G8pL9dGr+tk9OReFQHRIp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1V9zJJqdf4YIxvxmIUyv9hrkx8DJe5WAaUzKYXVZ1noBWM73KVF5ZVyha5rOKiu+O59pxhoqJOWJaA86PXgjbo+KyndZXtW8baW6eoCifBdyexUqZ2B/6Qv1Hd25OQgk47W/B6u4Z3LHCvMrkqNA1lvLEwstPPSEzMr0n3MkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Uax6WXIP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Uax6WXIP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LaZ8xRmuQ+Il2zB6Ox9/aUcTtUubZsAch+lNoQEkwK4=; b=Ua
	x6WXIPj73rFNbD3up5Bt6ov4dXdf3GJhWPk4HdY/VQFa5KP/+FsxIsPaATSBLNBNfic0Ox/8AV7Ve
	Q1WdXRlUldK8xGfb7FxavPMLc4pOFHXdJ4HOzqvoNpSaiRhfVgCBBaKN8zAkjE8lPDeULGlWtEQTf
	CflTt5ldJkiw2ro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGgkO-00AZV3-6V; Tue, 13 Oct 2026 19:57:08 +0200
Date: Tue, 13 Oct 2026 19:57:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?S=E9bastien?= Royen <sebastien.royen@armadeus.com>,
	Julien Boibessot <julien.boibessot@armadeus.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: apf6: fix Ethernet support
Message-ID: <9dc52d6e-2f43-4451-925f-16f138aeca19@lunn.ch>
References: <20261013-apf6-fix-ethernet-v1-1-9530efe1d23e@armadeus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013-apf6-fix-ethernet-v1-1-9530efe1d23e@armadeus.com>

On Tue, Oct 13, 2026 at 06:07:24PM +0200, Sébastien Szymanski wrote:
> Commit f5d9aa79dfdf ("ARM: imx6q: remove clk-out fixup for the Atheros
> AR8031 and AR8035 PHYs") removed a PHY fixup that setted the clock.
> Make the Ethernet interface work again by doing as advised in the
> commit's log, set the clock in the device tree.
> 
> Fixes: f5d9aa79dfdf ("ARM: imx6q: remove clk-out fixup for the Atheros AR8031 and AR8035 PHYs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
