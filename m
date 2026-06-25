Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9767212564;
	Thu, 25 Jun 2026 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371906; cv=none; b=F3zUQqvSIrdkmK8T8+RO38al2zGCDmcYdgLflWCHyJ9waXub2/Hkvewl8qlrUDZxr+OBZEJJp36P3FUJnTawl3q4NWX04Dtxiyf6dTLd3xA1Ee702SgXzQQci0RixRfSMfqbV1j6jZ0HD23szsHsgks9Q98EOjVX+94cnZG4CSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371906; c=relaxed/simple;
	bh=sJ+CCPF0CYyGnCSQxtoQ9+ZKYBlQ0GV4hzUB+BKi3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQLfjMJ3MiF5KLRQd/BZ3DIZhWlc3m6OoYtiRKJpV77hxIlHLLgpQrkd3oFSHn1rmsbaIVYkX0M1/PQ4GryBDJ5vFys3s4Cauxi4GaloQSSn5TT0dkSKDxX9XxQd/ZbWUmlUtakPH/KKCq0yDfJHjb8NTjxR3d4maZSON8cxC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2961520066B;
	Thu, 25 Jun 2026 09:18:23 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wceLv-004YMz-0G;
	Thu, 25 Jun 2026 09:18:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wceLu-0000000DGBy-42LG;
	Thu, 25 Jun 2026 09:18:22 +0200
Date: Thu, 25 Jun 2026 09:18:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vincent Jardin <vjardin@free.fr>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <ajzWPi3L8MjyrKfo@pengutronix.de>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Mon, May 25, 2026 at 06:43:14PM +0200, Vincent Jardin wrote:
> i2c-imx rejects a SMBus Block Read byte count of 0 (valid per SMBus 3.1
> 6.5.7) and it returns without a NACK+STOP, leaving the target
> holding SDA so the bus is stuck until a power cycle occur.
> 
> The same bug is occuring with two independently introduced spots, so the
> fix is two patches with their respective Fixes: tags and backport ranges:
> 
>   1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
>   2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
