Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D916DEB1;
	Tue, 25 Aug 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663024; cv=none; b=pK2v4MWQFRJc7qxMGljS6noXax1UcoW1ph8VB0336nlTKlKfFc9Q3+x/O9nzN6ascFz67rQ8FXEqgRh4ALedu145eLNCk8Bi48zFyDv3uJiW3WFnveIcevaydwpAlGfAKgNE4siA+XvHmVPtR58BcYmWEcWUJSdjULQmbDTFyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663024; c=relaxed/simple;
	bh=S38liw3LQ2YxnRq/bt6rgz9P2uEU47CDwBUneJA0U/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqABP2TWjETA6HX1Pj8tKBlGRuXI3bpv1JuZ8B9f6si4oEh7rYbluv8jJLpE5gpejKxsKbM798J5+/tbAE+5pIK9QrJYuz2cyZjAAz7xk9sOKVsaygaY3k8cIAdK5I8bilOWPeyaS+LqBKbMCLsZVuuZpll5flMZNd5984iTjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xfz9tqeR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xfz9tqeR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=RzrieIl4Wb7lJ/dUiuec0z9emkFkl8ZmhIs4epKKP3Q=; b=Xf
	z9tqeRao7Rlvn4RoW6IDyrqXF+oO2aybD5zhePSW+WdvMFa8P2V2YhxRAdohfqnqIyUqwSjZfLEAS
	uqEhvmqla/ovVOOkN2XERvrgzdwid9Lv0WZ2px/rwd0ips3Mm3vicaDQsx/OHIKqCdV2965vpGAc9
	noUKmuG1zLSiEGk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyqoB-001OG7-C3; Tue, 25 Aug 2026 15:03:19 +0200
Date: Tue, 25 Aug 2026 15:03:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: fix NULL deref in IRQ handler after
 unbind
Message-ID: <667fb4ef-0822-432f-ad0e-aeb4bf66dccf@lunn.ch>
References: <20260824120703.107412-1-xuanqiang.luo@linux.dev>
 <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
 <749d7a16-df31-4bcc-822b-3153fc69d072@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <749d7a16-df31-4bcc-822b-3153fc69d072@linux.dev>

On Tue, Aug 25, 2026 at 11:34:04AM +0800, Xuanqiang Luo wrote:
> Hi Andrew,
> 
> 在 2026/8/24 20:54, Andrew Lunn 写道:
> 
> > > The IRQ is requested at attach time and released by phy_disconnect(),
> > > so phy_remove() cannot free it without a later double-free.
> > So this sounds wrong.
> > 
> > If you unbind the PHY, you need to also unbind the MAC, since a MAC
> > without a PHY is useless. When the MAC unloads, it will call
> > phy_remove() so everything unwinds in the correct order.
> > 
> >      Andrew
> > 
> > ---
> > pw-bot: cr
> > 	
> 
> I agree that the MAC should normally be unbound before the PHY.
> 
> Also, the paragraph about freeing the IRQ in phy_remove() was
> misleading. It was not relevant to the change being proposed,
> so I will drop it in v2.
> 
> Do you mean that unbinding the PHY first through sysfs is not a
> supported operation?

To me, unbind is an odd thing to do. What is your use case?

When doing development work, i tend to reboot the target. If not, i
would unload the MAC driver and the PHY driver, to ensure i have a
clean state.

> 
> The same sequence was used to reproduce the issue fixed by commit
> c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver is
> unbound"), which made me think that it should at least not crash:
> 
> https://lore.kernel.org/all/20200917034310.2360488-2-f.fainelli@gmail.com/

A crash is not good.

But we also need to look, is the fix the correct architecturally, or
we are actually making it worse. Drivers have function pairs. A
function which does setup, and a mirror function which does
tairdown. A function to bind to a MAC and a mirror which unbinds from
a MAC. That symmetry makes drivers simple, easy to reason about.

Does this problem happen if you keep to the symmetry?

Does your fix to this problem make the symmetry worse?

If unbind were to cause the MAC to unload, is the symmetry kept?

   Andrew
