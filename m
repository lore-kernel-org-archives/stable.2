Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5D41D223;
	Mon, 24 Aug 2026 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576105; cv=none; b=qfyJTvqVDMdiBWyNSanFJBAasdbmotsgI49e69jGkUuDIo6pUhMhDvFTV/HLs6gGE8Knf6CVr2dXTYXodp+x7Qr8YB8E+wSZxrvq6z5+zUQZlmAxcaVvw4KuPcqp6drLhgT3teJ3MLpjO3soOOI9+AXFuXoQosCJ3wYZxLMhfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576105; c=relaxed/simple;
	bh=ZlM6xsIiViLJz7owZRxtVA3Y/seJp36RqcP3jOyJbMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzwrUYZa+96bhgoxi23bbK4KT8cEHjBKW36gnAkExP4IbIqumzS4dzQo2CFowRGDz3xcFcxJyyVMgTz8RR7wpQ/HmDFWIr2XDY+MmziSytumSeR56i5hi1SQvBldvE2uGV6tE+oE3+VJ7k4PheB6eiAgd70LSLvL16VKM8uTAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y0jPZCAH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y0jPZCAH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HyVKkr1W6tET6ztDc79VEHgMX8JlNF0ks0TWdenQgiw=; b=y0jPZCAHfhE4AMGIegRoJkA8ba
	W9hn5Y3DVq2W9TpY149lmG9ydEadX3EI8Jd7uLDjYRW75mMO5FvkItqM1oG7frsnX2lUUdUGlwSRM
	n/TTkX2LKAHI3TQ8fP8Xp8K69W87awnn2alH10hm7fszjzzqsqQUmKvH8UHjQAUB4cKM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyUCN-001Ea0-85; Mon, 24 Aug 2026 14:54:47 +0200
Date: Mon, 24 Aug 2026 14:54:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: fix NULL deref in IRQ handler after
 unbind
Message-ID: <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
References: <20260824120703.107412-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824120703.107412-1-xuanqiang.luo@linux.dev>

> The IRQ is requested at attach time and released by phy_disconnect(),
> so phy_remove() cannot free it without a later double-free.

So this sounds wrong.

If you unbind the PHY, you need to also unbind the MAC, since a MAC
without a PHY is useless. When the MAC unloads, it will call
phy_remove() so everything unwinds in the correct order.

    Andrew

---
pw-bot: cr
	     
