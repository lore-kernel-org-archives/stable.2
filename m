Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370564E432B;
	Wed, 16 Sep 2026 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602144; cv=none; b=AVwOlZAZVL+54zGrKNx1BhyvkA+Lzx7Dtp6lf67W6+Q9KO2rbGCuF+JhmFOxdkKiwOko3CP75rNv5XbUylY3oH4r64PYLhpruD7ZX4gdG5JOhOc8i4F1QAW4pz8zpdE836PIghQwLXKzk6xT3GP0vBojuUtvzZtIHsAKYZzI4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602144; c=relaxed/simple;
	bh=Nll9OGHbGCxjZb8QZNwWF6g40MzhhmE4MNUM6cjObbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TALDe+s3ISDEVejtU9xxvY1Yi6dXpCK2In0EzRox94Y/ShWLqCSKhr6BDpGUvLClSHerzmZOHmorVPrfQV43gZkl1wzLTFkGFwCoP0wflFtHbQYCSEYVyQeW2C2iNCkyTd/EMasXY30ywphrvvApz0DfM8lFogF3J9WFCjJMiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZubSyk2w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZubSyk2w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KUFBmY6J/JxptuKRKRrQdn8H9NJg2yDCbCFeAvvwk40=; b=ZubSyk2w6DJQlpTY4UZUZqlPJ3
	h/mFc3uJ5OY3Rjjpqm0k9tegbQ49Uc2F0Uvg6gZGyql7YKShJ7RfMeygzjQTcDty/CdHBwnND+yHg
	X1PJLJ6fr/59buWDpIevp81U+/lnubJeXx19mTRTp6CgTo8GGxqr/xJAORqRzSjaYJ/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6zGK-005Yx9-CU; Thu, 17 Sep 2026 01:42:00 +0200
Date: Thu, 17 Sep 2026 01:42:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abhishek Ojha <abhishek.ojha@savoirfairelinux.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk, horatiu.vultur@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: micrel: Advance register data pointer in write
 loop
Message-ID: <c1b5781f-475a-4867-a95b-b4e85ca3c2d7@lunn.ch>
References: <20260916231928.1336305-1-abhishek.ojha@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916231928.1336305-1-abhishek.ojha@savoirfairelinux.com>

On Wed, Sep 16, 2026 at 07:19:28PM -0400, Abhishek Ojha wrote:
> lanphy_write_reg_data() does not advance the data pointer while iterating
> over the register table. As a result, it writes the first entry num times
> and leaves the remaining errata registers unconfigured.
> 
> Single-entry tables are unaffected, but tables with multiple entries
> leave every entry after the first unapplied.
> 
> Advance the data pointer after each successful write so every table entry
> is applied in order.
> 
> Fixes: c8732e933925 ("net: phy: micrel: lan8842 errata")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Ojha <abhishek.ojha@savoirfairelinux.com>

Makes you wounder if the short_center_tap errata has any value.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
