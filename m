Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B85505F8;
	Tue,  8 Sep 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876168; cv=none; b=HsdFyprVcKZJVmNL/co3e2ml/azgOSHsz//NWPODN06EXMT50+U1TOmMdUX/oQHkdvDYBkZSYEDb1x4XkF+3kNtDTks+TusmBJCiQO2S+0muiyroGTwKKabWeltqynVyO9E3Su9SIlsfvid0KA8s27qUQMvySb0tQiQkV1FJX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876168; c=relaxed/simple;
	bh=kF3LKAARWQizVNE+qH0R94O/9WOnLGwrvU3Qm6uBEaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFLffCypedDewsNuWxYDxysh6JAUcr85S5Fk4AXSqKZIKJDwZ/ZH3NKMBK873bTzE6Wra+2ZHV0ykfs5uc+55R9YRgfXwUbHCCAPnEazG2wOg/SVGPxWmUlpEVVrIG9TRrlm0qsqx+NyZw549q27/liAvl+oS4CGZELMDGYty30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CoiUyQ64; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CoiUyQ64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kek9Jm5onQkzyAbCdbm8LAc6qHIsTh0LobTQe/hAH7s=; b=CoiUyQ64z3JotxjdgkGckaNrcq
	ort5zM466hiO6uVu7HecCb3HNyimvwQV1os/0sl/GEP+E2r/aRgGltvXBbOtyy9WdZQxdANixDxev
	vWEMhjKYUcfMHTW0oB928gm4RGdAAVyneVkhGyWxaqbDzw2dAz2yz+KfwF1FKcMfUNBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wOx-003uLZ-FS; Tue, 08 Sep 2026 16:02:19 +0200
Date: Tue, 8 Sep 2026 16:02:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	daniel@makrotopia.org, o.rempel@pengutronix.de,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] net: phy: dp83867: handle the active-high LED
 polarity mode
Message-ID: <7929059d-c55f-4adc-bf6b-f6d3d9b0598e@lunn.ch>
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
 <20260908105959.70453-2-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908105959.70453-2-donggeunyoo.kernel@gmail.com>

On Tue, Sep 08, 2026 at 07:59:57PM +0900, Donggeun Yoo wrote:
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
> bit in the modes mask when a LED node carries the 'active-high'
> property. dp83867 was not part of that series.
> 
> dp83867_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
> PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
> of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
> so far and passes it on, and phy_probe() returns it. A device tree marking
> a DP83867 LED as 'active-high', which leds/common.yaml allows and
> ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
> unbound, so phy_attach_direct() falls back to the genphy driver: the PHY
> comes up without its DP83867 configuration and loses the RGMII internal
> delay setup.
> 
> Active high is what the function programs when no polarity mode is
> requested at all, so the initial value of polarity already satisfies the
> request and only the case label is missing.
> 
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
