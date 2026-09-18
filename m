Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A43A9D83;
	Fri, 18 Sep 2026 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696410; cv=none; b=An1T+p7zI6oaMmpQ+DQ0nxn3tC58DusFIUwSArqim2sJmdVAScJjYqUeLzGmP79lshFFkwAIhYzy0Pi5xtU2NxCvlvbdVfC3RC5DwQHJvcJgbJ5Pg3VfGAU5US34z4xLW10nL++S2LDdo1lcX/t9qULw5kF/ni+azZJ9Fgwis6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696410; c=relaxed/simple;
	bh=mPPqfh3PnTxFru32WxJ4lVJ3g4NfSLC4xy+6D4GP/u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9HerlvXHxyhE25BxpqQLW87nHKeJS/KWw4184hJcLrSaFf42boS0HBeGWIfoazDRs3fIRafe+OLX5gRyCUMYQUubojhWgdiklzcIVmy+1XltJjYhAdI7X5ww3xPjWQe7vNukpg/ZPqqA9BY1DRuziYatsQysYfkdlJucC57xmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=26j69VBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="26j69VBm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QEW9lDN/vnBvzIBFpAIPbkoyudlyt1kwkJ46y6KTBgk=; b=26
	j69VBmvfCfkxS3GddrbUAWqSKSj2TdmPcs8e3TsUoJp/rdmCz8kbMJ47rOSpNrQvADxDHEmwtf6ra
	PUoW4nG8Mrwlwgp6E6188EbOEA7tK2WpFvE/OjIVAfaiaQiZwPEP2A3P/nOrH+bua3uLNo9u3RqVT
	F6O2Rr2hM3vowbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7Nml-005mYL-LV; Fri, 18 Sep 2026 03:53:07 +0200
Date: Fri, 18 Sep 2026 03:53:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linusw@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, davem@davemloft.net,
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	olteanv@gmail.com, pabeni@redhat.com, paweldembicki@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
Message-ID: <26e9c43d-74a8-4d70-ba71-f50c2ac77e65@lunn.ch>
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
 <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>

On Fri, Sep 18, 2026 at 12:22:12AM +0200, Linus Walleij wrote:
> On Thu, Sep 17, 2026 at 12:49 PM Wentao Liang <vulab@iscas.ac.cn> wrote:
> 
> > spi_dev_get() takes a reference on the SPI device, but neither the
> > probe error paths nor vsc73xx_spi_remove() ever release it, so the
> > spi_device can never be freed after the driver has been unbound.
> >
> > Release the reference on both probe error paths and in remove().
> >
> > Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> > Cc: stable@vger.kernel.org
> 
> I think we don't set this on networking patches, the network maintainer
> decides himself what is stable material.

That was true when DaveM did all the Maintainer work. But it is no
longer true. Please follow the normal stable rules.

	Andrew
