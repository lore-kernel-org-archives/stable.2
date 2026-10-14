Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AC3F2100;
	Wed, 14 Oct 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994276; cv=none; b=is3nJGtnqph7BA67HU4ngowJSHoj4DirDwNaRG7+ziJC2JFW5RQSPM8nDMbNb4r0ZVuIGpVflcytnMQ4AvYGa4Xbz8V/bvxsoVHPXm4ojq/rZWRVjwN2krO8WF93g5kj+Rt2iBkLNchScCoPmNZMJo8Vt72sIWl1ZN9EyTinA/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994276; c=relaxed/simple;
	bh=Xcxm0b+DqyH/3qMsa5XE2XcxHc50OQ0RC/55/HYpVxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gisa6H6tYn6k4RhUMuNn0YtIDBVRV25EDIYolgNT9wTf5gNinD4/7rP3hE6fxszRC2rjsLE3mlhB57MNyumufAQfWMWI6vMDlhz4Av8Ux2+/gYrYApBHxAGAZRtXEmkaZU53yaSWRMiN1CSkOZpGf4Qzvtu6ZjouWbRTu7dGluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KrF+/Auw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KrF+/Auw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ATveWh08eRUA1brkma7A3rEyXoH7sGRO7VGs5ZCBaUM=; b=KrF+/Auw5uql60aFJQ3SgTNHCQ
	IbYCxSzDKQDVgyTlDWJurCpJ+6knYhwH+xE4h7yOs/sVQfHLITlgFGzUW6P6y/CEbFHyiH47/PixC
	lwHrGHTNHqoud+td07EVeElT3FTyfRtU77A42/7aQBbgaQe51d4qbweLdpeH+tP8o2lQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH1Z9-00AmBl-K9; Wed, 14 Oct 2026 18:10:55 +0200
Date: Wed, 14 Oct 2026 18:10:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hayes Wang <hayeswang@realtek.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	nic_swsd <nic_swsd@realtek.com>,
	Birger Koblitz <mail@birger-koblitz.de>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
Message-ID: <06aaa778-ad49-4e30-b1c6-a7dc68718a21@lunn.ch>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
 <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
 <16d9caec96e8449d88ac456e8512f08b@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d9caec96e8449d88ac456e8512f08b@realtek.com>

> > For those devices which are broken, double read the BMSR.  The danger is,
> > somebody who quickly unplugs and replugs the cable is not going to get the
> > down notification. The dhcp client will not restart, so the old IP address will be
> > used, for the next hour to day, and the network is broken.
> 
> Could this actually happen? 
> I think it would take several seconds for the link to go down and then come back up.
> Wouldn't this issue occur only if the link transitions from up to down and back up before the driver processes the link-down event?

802.3 thinks this can happen, otherwise why make it latch?

If i'm just going from port 7 to port 8 of my switch, it might happen.

Or i reconfigure my managed switch to change the port from one subnet
to another subnet. The RJ45 is not moved, it is just a configuration
change. The switch should do a down/up on its side to indicate
something has changed, and that needs to be reported to userspace so
dhcpcd gets a new IP address.

       Andrew
