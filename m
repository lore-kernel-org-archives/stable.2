Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794761643;
	b=pRjrKsUHWjigDcNxYy6I/M36nUW4m+bUztqkV7JTqEaVVc8iTlsrAFcVrRCkhN/yL475
	 QYjACDcp/srB1cm2SzrXBbn07Wjn6h6hFbiG4cI5uEdBsoj5dwH90yJVuXbG0ZBw49u2R
	 e17d/OpRvgrmo/JcFwO+fq6L1uuYbngEplr/o/Q2xWjuXHArdKreMINnbnGwHu8TAj3e/
	 XeAoAjcN2R90q76icbLg0WqringqfuxS8sdylvUlmUSN4/KhOK1NbubYWlJa6hxedY5qV
	 zL4rzSaK9y874vJix1nzlp9JFphV1fip1pvWMjVnt1X5QQvDKV5T6peTEa///EzoJVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761643;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=jumnHgu3ABerM/M/znRe8+r4n3jB6pmcOu2naBFhqBs=;
	b=J+B+iRG+7YbnoMcWk/E39gxXqgMmBUKxaU+d2wkFz69Gf/xoLqUC8Gbbzj0hZPmCL7PT
	 pqMLHChxS4bPElYhpOunCSBQUKKWJ6SWCpotg95A0gYDDYS/TOSCVoQVfmECji8UxLAhN
	 VZiH4qvdYy8FU+zxIDNCG4Ms4L2mAVwOEvzztmqzYUNng3P6gv9xSZVPkPJcgZy/uKWBV
	 eRJwoWSavJO1vudoNlzMFrLmcTLtnTZZKz7AgA6+gIDJvjHtb1jzVYNYba32Fx2TUNkqF
	 6dAMtKvf6naxw2vZyahQ6293qQrSU5AvKNOjN1t/vZkJJI3lud57+EohEQjEwOnpckQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="xSV/PAzK";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D50606A323;
	Sun, 15 Nov 2026 16:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D50606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xSV/PAzK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jumnHgu3ABerM/M/znRe8+r4n3jB6pmcOu2naBFhqBs=; b=xSV/PAzK9COETLhDLplS59iMIE
	4ndKhdfufdmpJVkDja6laRA11+OG18m786DRO2VSkMEldi81CdwYjU+MDMmD3r2FSkRRilEgn5IQH
	k3v0aTPoCK5uxZtWkazj6fuJyT5K+34K4Kvr020jLjVaE0Sag4FPku/Je8c3mA8E6gX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xSdUD-00GdtY-1A; Sun, 15 Nov 2026 17:53:49 +0100
Date: Sun, 15 Nov 2026 17:53:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziheng Wei <zihengw03@163.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: reject non-PHY mdio devices in
 phy_connect()
Message-ID: <04781560-2b66-4ac2-9e7c-a786be43fc10@lunn.ch>
References: <20261115161811.941022-1-zihengw03@163.com>
 <06c3990a-8f2d-4e8c-931f-6ad77a79a84b@lunn.ch>
 <20261115164233.942709-1-zihengw03@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115164233.942709-1-zihengw03@163.com>

On Mon, Nov 16, 2026 at 12:42:33AM +0800, Ziheng Wei wrote:
> On Sun, Nov 15, 2026 at 05:30:15PM +0100, Andrew Lunn wrote:
> > > Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
> > > Cc: stable@vger.kernel.org
> >
> > Who does this bother?
> 
> Nobody that I know of.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> If you think the check is still worth having as hardening, I can send
> it to net-next without the Fixes and stable tags. Otherwise please
> drop it.

You have to defend your own patch. Do you think it is worth having?

    Andrew

---
pw-bot: cr
