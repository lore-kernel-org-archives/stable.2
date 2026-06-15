Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DD211A14;
	Mon, 15 Jun 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516639; cv=none; b=jzLwufLn8OTy3DcRoD8EYBemfybDO2/lruSO3DcIo81BbqBO1vMJM4iffjkZPt+r2nrHx+gVe8ViSi/D+12qCAUB1cBTaqVV9P5EttXk6TymG5FuBDdDukyWep3ePxsaGP4lXn+EsMy1R8CYutNtIhNgu2AXstpayPHl69MgAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516639; c=relaxed/simple;
	bh=KChDnzIFB8LnEC5SidZPV+v786gS9QKb5p37tgRiis4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiNJCC8EcjQjO47rUDMSv8T/eMjfDebgom/S/30erNpWu1W2qX6gFiZKJc4z0P+j6obln4BJe7UnTAoYSSlcbQVYF23rRBwziZJ471BKep2ZUVPkpmFBYpF9iwv4y1SPf7GLxWNfHm8IeCdwqrN2VAvJxvPiLYsiYZIsl3hWDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=B4MVgt2w; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="B4MVgt2w"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 0E1C21F91B;
	Mon, 15 Jun 2026 11:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1781516635;
	bh=IES+l93RpBOikmpagWwEnHcIIfJUfwn+CVgv1ELGJ58=; h=From:To:Subject;
	b=B4MVgt2wjxkr6uNhb9CEuK3JhTGC3u6JVXoXseBtiDS4Y7sI5ggL/+bJ5k2zjUi09
	 +Fc3n0XayFxN12GcxPPosC7m04/Mo5KBy+9yqAk/CpVKQm/b/Fxjsm0/p4gKVD4UyQ
	 3CMVDJB8d9EHlfd+2ttVngjohGfeJyXOfXg9uNQV36qhJb0bEmj7D6RSjF6IpAla2a
	 2Xw72REAeUMknhQpBFNGlwQ3xu6RD9fuQUcaZiWJmo5bWL0BIB8Y6FFHdFm8KZyPte
	 dMNYL25uWXZLFaLRn5UoUdn2dMLWfZVIcMJSaMhdhBM8O1bx2/ouUQjOzvT9IhFzLC
	 L1TKArVjEkhUA==
Date: Mon, 15 Jun 2026 11:43:53 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael@beims.me>,
	Brian Norris <briannorris@chromium.org>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy
 scans after multiple roam iterations
Message-ID: <20260615094353.GB6878@francesco-nb>
References: <20260612122547.1586872-2-rafael@beims.me>
 <20260612130607.GA7651@francesco-nb>
 <ai/G/C7VxxzDVWXW@nxpwireless-Inspiron-14-Plus-7440>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai/G/C7VxxzDVWXW@nxpwireless-Inspiron-14-Plus-7440>

On Mon, Jun 15, 2026 at 05:33:48PM +0800, Jeff Chen wrote:
> On Fri, Jun 12, 2026 at 03:06:28 PM +0200, Francesco Dolcini wrote:
> > On Fri, Jun 12, 2026 at 09:25:46AM -0300, Rafael Beims wrote:
> > > From: Rafael Beims <rafael.beims@toradex.com>
> > > 
> > > In order for the firmware to sleep, the driver has to confirm a
> > > previously received sleep request. The normal sequence of evets goes
> > > like this:
> > > EVENT_SLEEP -> adapter->ps_state = PS_STATE_PRE_SLEEP -> sleep-confirm
> > > -> SLEEP -> EVENT_AWAKE -> AWAKE.
> > > Before sending the sleep-confirm command, the driver must make sure
> > > there are no commands either running or waiting to be completed.
> > > 
> > > mwifiex_ret_802_11_associate() unconditionally sets
> > > ps_state = PS_STATE_AWAKE when it processes the association command
> > > response, outside of the normal powersave management flow. If
> > > EVENT_SLEEP arrives while the association command is in flight,
> > > ps_state is PRE_SLEEP when the association command response is parsed,
> > > and the forced AWAKE overwrites it. The deferred sleep-confirm is
> > > never sent.
...
> > 
> > Jeff: same issue in the nxpwifi driver.
> > 
> I looked into this for nxpwifi. The nxpwifi driver currently only
> supports IW61x.

Up to you, but maybe is worth applying the same change there. I assume
you are going to add support for more Wi-Fi chips over time, and you do
not want to have to debug this issue again.

Francesco

