Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1842BC43;
	Tue, 15 Sep 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488530; cv=none; b=Oq6yigFoQE2DkCJarFVB+D+Fykbq8LCvQOAMItqLv0N+epVhGssI3MXl3okYRqi0BTOu+5atBZTzGZ5OIhdOBSHETxiKW0Ir4aoT0XKtili7M+ZB1XxNxpFoGs3ZNm5lX6H9ZyRqCNP16vaSJ/bl5qhsvnk130DMAKDKw89vJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488530; c=relaxed/simple;
	bh=C/usodZ/rL00N7obJgCC4jFta8AalHdWTyUXeUYcmvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpJJO2JaBVuA9vrT9fONwtap2hJUR0ieF4vg8+sdIX2we8Ij/zC1YxpLtRJplSSzvoCMMPWVrco2wXCRVPMoY3w9i7eDjtmBbaO+lKxsdaqv/Z/E4WA3sjxQqHxCP4Axmp/KISRP07GFzj6dXJG1Y8Cj94Ntqlf3lV7DB6PEN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g6jaHlNG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g6jaHlNG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6ahlJLNA/H3ZAXfkZzlkdf2AY1eLbDRCPd8g1GK93gI=; b=g6jaHlNGgjVITTT8J2te6I089w
	PvRnB6NbQGPNC+YjHRdgMlyf152Lcs1JD4E1iHkvSpG6yv0Bfcwv0Sfn8DklKjr3y6T1K5tdn73xV
	IY3i8la6VXhp/s7UL6OkoBP1Mh+tbqKr+wfsldpDh3En5PttVHUtBfAleGBPLXqFbgio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6Vi4-005JH2-A6; Tue, 15 Sep 2026 18:08:40 +0200
Date: Tue, 15 Sep 2026 18:08:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Michael Grzeschik <mgr@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: arcnet: com20020-pci: clean up failed
 channels
Message-ID: <92cbc37a-833e-4369-b5ff-4199dbefce6e@lunn.ch>
References: <20260915013946.73963-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915013946.73963-1-mhun512@gmail.com>

On Mon, Sep 14, 2026 at 09:39:45PM -0400, Myeonghun Pak wrote:
> After com20020_found() registers a netdev and requests its IRQ, seven
> allocation or LED-registration failure paths free the netdev without
> unregistering it or freeing the IRQ. The unfinished channel is not yet
> on list_dev, so the common remove path cannot clean it up.
> 
> Route those failures through unregister_netdev() and free_irq() before
> free_arcdev(). Keep failures before successful com20020_found() on the
> existing free-only path.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")

I think this tag is wrong. Please check it.

	Andrew
