Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807C38F92A;
	Mon,  8 Jun 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903684; cv=none; b=JQpYIT1IWSeVmLQY8lEeKsYSo50tIo8x45M2P18uifvb0TdkyUWzw2aVmIz28H38D+DZdlVzIppYnBxyuhDegdtSki6nGAtdcDFayXXqwh5HttGBA+ViCymALneR0epVfVexpJfjyqUn6l8OzjuyOAM2xWYL6ab/m8x5RQJHY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903684; c=relaxed/simple;
	bh=HpyMmubOcPvyWorT45bTjO+FO1/5rhG4CaYGSpOW8gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD4oCbLwm41C841M4iKsxaFJEyv47+2LxABKki89IHnjbd3gfJa6sp4y90VMet6/ykK3ASLQWfD693GSXgOfiIigoau1gB/T07XwLCV1jH0gSu0Gxb2OgWzJMIt45kpxTDECxF/YTQv0uggPKPwvUKwGf2ZAq5rSGDwjHQEFiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SRnTMIcH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SRnTMIcH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Pri1h6ADGZ2CCChD8luQiY8dTtehWge5N8Z3rhqf/s=; b=SRnTMIcHDOG4nvb3I8Uqs93MGF
	+/YgyUA+MGLMd0MEqyBOHPZ6cCQKI+CXJpDeWDq5X2b0eaJPmi15coN4LBnKWhn32Y/vtiwQD0mwY
	/Zsae4Y8bJ4MIpShrw6CkUg2me4w9FE9UaVp8CQkjA9n7tX9DTEtxabXvFBo5gkW4OnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWUOp-006ZuF-1R; Mon, 08 Jun 2026 09:27:55 +0200
Date: Mon, 8 Jun 2026 09:27:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net] net: ethernet: sunplus: spl2sw: fix phy_node
 refcount leak in remove
Message-ID: <04e42457-af7d-4cd7-9454-2443bcd04e15@lunn.ch>
References: <20260607193029.589736-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607193029.589736-1-shitalkumar.gandhi@cambiumnetworks.com>

On Mon, Jun 08, 2026 at 01:00:29AM +0530, Shitalkumar Gandhi wrote:
> mac->phy_node is acquired via of_parse_phandle() in spl2sw_probe() and
> stored in the mac private data, transferring ownership of the
> device_node reference to mac. On driver removal, spl2sw_phy_remove()
> disconnects the PHY but never drops that reference, so each
> probe-then-remove cycle leaks one of_node refcount per port permanently.
> 
> Drop the reference after phy_disconnect(). While at it, remove the
> redundant inner "if (ndev)" check; comm->ndev[i] was just verified
> non-NULL on the line above.
> 
> Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>

I assume you don't have this hardware, so this is untested? Please
state that in the commit message.

Does this issue bother people?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

	Andrew
