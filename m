Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710A49E5CF;
	Tue,  6 Oct 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303044; cv=none; b=hvxXnnyzNWw4mbY5hWuzMz+8KGo9xeOvRKUcm7lMBfkvxZr7LGroSN7sYwl8PMaVHew6dVynIfH606iqtBgfDQx8/igZaLFoDJoCWEL0v2++Qn9xCyK73Y19jUBl5D85j7oFsopJU7wKm1O4FBxdcb2cxT7lmayNKJbn9jFlhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303044; c=relaxed/simple;
	bh=aNbsDvFZRK/+AHPuUdCwt746G0BRQlKOX+mNN+HHJ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZhWKBrImiF570AEk4bwdSxHJkTC8Ixi+vdNabrYJKrbf4Rhf2UNFalVnFy4s0vordu/X3Fxp98UcAGE7qGKEZTmk6wrwrwHdr11oHjQjZaHphI+wK4CuMafSUEe2Nm3X/MHMC3yla5MDbN2Xk9bjsWG5/ed0daMueTE9aJtGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hq5dKJJS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hq5dKJJS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qgSV4GBVU0LvkZzpXKbXapalbfhpM7Y/2Dcz6KnjfDY=; b=hq5dKJJSTWfsJZPMZaSK26cWO/
	yfadGeI9oklQ6q7+pvHMzZaPf836s9BHy65lTR59H9gL2A30ygoxo0M6EndUZ209nXpMG/5zM/4zf
	lWxaAPa55KpGyIdTTkR7WLG+AjXWAa8vPjbDmdDzg9gCPsqh/JGHuwXsl0pn9VolQ0q4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE7k1-009IFD-Kc; Tue, 06 Oct 2026 18:10:09 +0200
Date: Tue, 6 Oct 2026 18:10:09 +0200
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
Message-ID: <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>

On Tue, Oct 06, 2026 at 08:28:21AM +0000, Hayes Wang wrote:
> Linmao Li <lilinmao@kylinos.cn>
> > Sent: Monday, October 5, 2026 6:53 PM
> [...]
> > r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
> > BMSR_LSTATUS can still be latched low when the carrier comes up.
> > Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the network
> > cable is not connected"), the first speed query after link up can then report
> > SPEED_UNKNOWN, leaving NetworkManager at 0 Mb/s until the next carrier
> > change.
> > 
> > Use BMSR_LSTATUS in set_carrier() and rtl8152_runtime_resume(), so the
> > driver consumes the latched link down itself. If the first read still reports link
> > down, the next link-up notification triggers another read and brings the carrier
> > up.
> > 
> > Tested on an RTL8153B with a 6.6-based kernel. In 5 rebinds and 6 cable
> > replugs, the first read returned LSTATUS=0, a second link-up notification came
> > about 32 ms later, the second read returned
> > LSTATUS=1 and the carrier went up; NetworkManager reported 1000 Mb/s.
> > Runtime suspend/resume with the link up did not change the carrier.
> 
> I think this patch may introduce a new issue.
> 
> Our newer ICs do not generate periodic link-status notifications. They generate a
> notification only when the link status changes. Therefore, with your patch, BMSR
> will not be read a second time until the next link-status change.

But the link status in BMSR does change.

You read it once and get the latched value. That clears the latch, so
the link status changes to the current version.

Now, 802.3 C22 has no support for interrupts, that is a vendor
extension. But if you are not generating an interrupt when BMSR
changes, i would say that is broken.

	 Andrew

