Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF34908BE;
	Fri, 14 Aug 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726816; cv=none; b=lQ2D4wiw5bU0DudwT73pDRh7s4JpaK1tBKjyhFBP0MXqHN4E08qQv0ZyKsii3CFjwtS9/HUsrXHacxthpWrky23+EaLQuDwJx7eR1olKqo6tkEz24DL+M/u/5vxOJwkorxaZvGiPjrv+ESUcovQlECkKWm/dMwexGM1nzcWyB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726816; c=relaxed/simple;
	bh=0j4sMZwSQBTBrNHFEEo+1jlkGARAYTEx0W9fsMuPfig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4SoUNUSIhoumhg/kf28oChBljzEMq98Ol9Cr/8+CXPYTA2ykOj86C74A/KlQUHE90jB4bweDCarJOqvl5nRdgyKGpONp0kAu7p9tV52gT9VtFVNWIHyIlAjEOTCgshMwfIZpTPaBlSkQ2+xGanHEYSIfP/SX1ZM15PJQNCAhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzX7rQXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzX7rQXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220D71F00A3A;
	Fri, 14 Aug 2026 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786726815;
	bh=1oDtecK6HZo6VjWo6jZVoTiUvdVOFCm6aPPnvhGKK4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hzX7rQXRwUpdU0b1zSyoFDbPCWrG2eFbq+lWdtYpchQb0uskGtGjZijbBe+7JKRrb
	 CulxfxY7OxX18v1bUhtM0c0ab8DHzCy7T2JNckfBAt+3O8TmsZL4f5hIp5/KTBJppV
	 RQL5n5428p9kGmSCxbjSwB84vRqSCDmAnziVC2oRbhZxcB/b1QRSQiZ2Sd8w4bwtLP
	 9huhzMzOKEXF2yp3G+S6ki+dml3RXfy0Rkl6XxkDGDSZe3ZSfskSc/GUYcVAwjQ2gb
	 657mf6VotABhd1KcgDwziDslczM8FvbCt9J8TeDcAlPCpdzEAxn/sukO8IW+ty7oC2
	 4DoB+M9sdyANg==
Date: Fri, 14 Aug 2026 10:00:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Linus Walleij
 <linusw@kernel.org>, Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Alvin =?UTF-8?B?xaBpcHJhZ2E=?=
 <alvin.sipraga@analog.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use
 gpiod_set_value_cansleep for reset GPIO
Message-ID: <20260814100014.1122e66a@kernel.org>
In-Reply-To: <e52dcc7b-3545-4e43-888f-7a7b3811af8a@lunn.ch>
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
	<e52dcc7b-3545-4e43-888f-7a7b3811af8a@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 16:09:04 +0200 Andrew Lunn wrote:
> On Fri, Aug 14, 2026 at 01:01:02PM +0200, Oleksij Rempel wrote:
> > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > 
> > rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> > the probe path, which may sleep and is not timing-critical.  When the
> > reset GPIO is provided by a sleeping controller such as an I2C I/O
> > expander, gpiod_set_value() warns:
> > 
> > Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
> > be used without triggering the warning.
> > 
> > The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> > since the driver was added in v4.19.  The call has since been refactored
> > across several files - from realtek-smi.c / realtek-mdio.c into the common
> > rtl83xx.c module and then into the rtl83xx_reset_assert() and
> > rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
> > applies as-is only to kernels that carry those helpers (v6.9+); older
> > stable kernels need the same gpiod_set_value_cansleep() conversion at the
> > corresponding open-coded call sites.  
> 
> This is one of those fuzzy cases. It never worked, so this is not a
> regression. Nobody has needed it up until now. So it probably should
> be considered a new feature, and merged via net-next.

Sounds like it's a false positive, but it's a WARN, so if it hits on
real platforms -- I think it's a real fix?
