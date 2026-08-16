Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB281448E0;
	Sun, 16 Aug 2026 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786859544; cv=none; b=ePm3LFhaIUYzxK7Qi6SSWD5dxCeuc2m8/d31n7WUj9iY2DFM3Gp2Zi+Z+kiEDLfVIMooOSQnSRPDGDQA8xmC1Lh+ntAUoLbj3KyoQzH6DzIFjFqe2DKrGW4K8yX6DlEbJVWFSg11Xp0rtw5ZJ227AYQu5t3SRHyh0yi2Xv0oRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786859544; c=relaxed/simple;
	bh=jjLYOtMsf/8X5ap5w+BIuUhN1645Je41drTCwqcwytA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx+duZK1o++MwKROsFUhHKaMqurUM7ID9se7mTyA4Ob41OOZHlLZVevyjutmau0i1QshWc8S4k8JOWc01pLHCu6sQGmoxiThomdSBpacLnI0HpTCn4wWUbK7hzF1hI7oXHz0fi8smBkEvqBFV4ToSMPEOcFu7NO/4iZjuiJ3gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 767052010F4;
	Sun, 16 Aug 2026 07:52:12 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wvTn2-001jWm-1I;
	Sun, 16 Aug 2026 07:52:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wvTn2-000000077D7-19nU;
	Sun, 16 Aug 2026 07:52:12 +0200
Date: Sun, 16 Aug 2026 07:52:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use
 gpiod_set_value_cansleep for reset GPIO
Message-ID: <aoFQDApDOdRLANZa@pengutronix.de>
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
 <e52dcc7b-3545-4e43-888f-7a7b3811af8a@lunn.ch>
 <20260814100014.1122e66a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814100014.1122e66a@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Aug 14, 2026 at 10:00:14AM -0700, Jakub Kicinski wrote:
> On Fri, 14 Aug 2026 16:09:04 +0200 Andrew Lunn wrote:
> > On Fri, Aug 14, 2026 at 01:01:02PM +0200, Oleksij Rempel wrote:
> > > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > 
> > > rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> > > the probe path, which may sleep and is not timing-critical.  When the
> > > reset GPIO is provided by a sleeping controller such as an I2C I/O
> > > expander, gpiod_set_value() warns:
> > > 
> > > Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
> > > be used without triggering the warning.
> > > 
> > > The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> > > since the driver was added in v4.19.  The call has since been refactored
> > > across several files - from realtek-smi.c / realtek-mdio.c into the common
> > > rtl83xx.c module and then into the rtl83xx_reset_assert() and
> > > rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
> > > applies as-is only to kernels that carry those helpers (v6.9+); older
> > > stable kernels need the same gpiod_set_value_cansleep() conversion at the
> > > corresponding open-coded call sites.  
> > 
> > This is one of those fuzzy cases. It never worked, so this is not a
> > regression. Nobody has needed it up until now. So it probably should
> > be considered a new feature, and merged via net-next.
> 
> Sounds like it's a false positive, but it's a WARN, so if it hits on
> real platforms -- I think it's a real fix?

We can back port it for related product by our self. Otherwise, the
LLM back port bot from Sasha Levin will do it any way, as soon as it is
taken. no matter as net or net-next. Flip a coin :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
