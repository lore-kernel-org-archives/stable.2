Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA265519B3;
	Tue,  8 Sep 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876601; cv=none; b=G6WxIyqXaPGpRO9wod3yeGWkyXh6yxAsPdt3biLKMzGQCO3gHlW5nCKzr7X1vLa3fA4JkUXSopc05+hBWpcj/CdIjfUllaWCMJGoFCOt49bZi+9MfJGPE+AS8gWCTqkRsqgTwzcalMGKTGXE10ViCGlvTCyofeV5JtaSPi5Q8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876601; c=relaxed/simple;
	bh=rnLaVit06OzDW4FES2ZWKFmrxmrrb70gfISQF15UfNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+kIxYGZxxSZZHynBvHk2wzpxS/XWiC86jZ6+gSOp/qzNKCnQph9K15sIbtofPrITlr19e8dyt1V8Vw8D5POtAZEdQ5BvyHYCXeRA3jdMPFe7yurAUkdq4LtcSeFny5ROm1+6gEN1ABp1fAYWc9Rp2eMnEnUUUQ8X5mteycRLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VuPkg7qa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VuPkg7qa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fESSj1tTvIUqfnjMLCcB0pmtGvETmrydsQtVwdkYIYc=; b=VuPkg7qaBfjwlEH8/EbA2breNT
	CUgZ7nsLaxvfs6HPeSRIKP/bzpTs+VJzlumet1kI2XriyGzZpIuXC+phDgO9PkyTAfROZOrxPo0k2
	KbSVKIRACAXbNA0xymfv94WfIeL7X8yT3cam8SrZriHrnYowhuZWt5fnuepdu1JQIoz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wW0-003uUl-4N; Tue, 08 Sep 2026 16:09:36 +0200
Date: Tue, 8 Sep 2026 16:09:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	daniel@makrotopia.org, o.rempel@pengutronix.de,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] net: phy: qca808x: handle the active-high LED
 polarity mode
Message-ID: <9cf54561-a3ea-4e6f-9cf8-9945d82c3140@lunn.ch>
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
 <20260908105959.70453-4-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908105959.70453-4-donggeunyoo.kernel@gmail.com>

On Tue, Sep 08, 2026 at 07:59:59PM +0900, Donggeun Yoo wrote:
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
> bit in the modes mask when a LED node carries the 'active-high' property.
> qca808x was not part of that series.
> 
> qca808x_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
> PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
> of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
> so far and passes it on, and phy_probe() returns it. A device tree marking
> a QCA808x LED as 'active-high', which leds/common.yaml allows and
> ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
> unbound, so phy_attach_direct() falls back to the genphy driver and the
> PHY loses its QCA808x-specific configuration.
> 
> active_low is already false when no polarity mode is requested, which
> programs QCA808X_LED_ACTIVE_HIGH, so the request is already satisfied and
> only the case label is missing.
> 
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
