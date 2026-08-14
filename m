Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F63537E8;
	Fri, 14 Aug 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716561; cv=none; b=Ifn1BxPhqQvUg8m4if3JkpIV5Rf0JHqdo9kCw5v1gIjqPiB9/4dGrlG/NWODWJqx0ltdaYRIVXAE7GJXRuPFjmHfI7r7Q5gRbXeIAHyEz2GrQ9uFrbDyen2zkL7cWRUQNfJ4nrJTw3YnCIvz76upaKI26qOZrCSFofuRhkIOLCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716561; c=relaxed/simple;
	bh=8mOo4smhMMUvh3mVQ92iE8z67i3k3eUEdQXA0/fFUxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLd4Y95Vzbawsf6lLCEwlaqLyfKBD3j1pM9SIuxRLRe0GEmRdRFv94beqB9oj7J3vqRGCOXM2fXXIjFDdIDiKf1od+0a05RTBTGRvwCDm2tta/r/dff6Pqr2VyvEZj4Tw6LuPfnCisrzqHL+FaaGR0RKueZ1/w8Tlkfxh2vD0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZpD0SfMV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZpD0SfMV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hD/HYIDNlTIWF9lsI80VPm5RtqwA7Pq0p40F/L9u9uE=; b=ZpD0SfMV8G34pLwtjTg+ymmFf1
	3sSGKl6Mtv53W15dfvXOsJV0adWqX0qseC4MVeZtMubnNV0IA3uLBW4Q1vhBYhFehKUyM3optzdjD
	pfoQXDCdud+1cSWAGlkGDe608LAWszneLzaxj4VzcnM77PKZP4DlzXWLWi7osRoWFQ9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wusam-00HamW-B8; Fri, 14 Aug 2026 16:09:04 +0200
Date: Fri, 14 Aug 2026 16:09:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use
 gpiod_set_value_cansleep for reset GPIO
Message-ID: <e52dcc7b-3545-4e43-888f-7a7b3811af8a@lunn.ch>
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814110102.2362246-1-o.rempel@pengutronix.de>

On Fri, Aug 14, 2026 at 01:01:02PM +0200, Oleksij Rempel wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> the probe path, which may sleep and is not timing-critical.  When the
> reset GPIO is provided by a sleeping controller such as an I2C I/O
> expander, gpiod_set_value() warns:
> 
> Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
> be used without triggering the warning.
> 
> The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> since the driver was added in v4.19.  The call has since been refactored
> across several files - from realtek-smi.c / realtek-mdio.c into the common
> rtl83xx.c module and then into the rtl83xx_reset_assert() and
> rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
> applies as-is only to kernels that carry those helpers (v6.9+); older
> stable kernels need the same gpiod_set_value_cansleep() conversion at the
> corresponding open-coded call sites.

This is one of those fuzzy cases. It never worked, so this is not a
regression. Nobody has needed it up until now. So it probably should
be considered a new feature, and merged via net-next.

   Andrew
