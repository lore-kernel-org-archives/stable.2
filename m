Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD74F4744;
	Thu, 17 Sep 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648872; cv=none; b=WArvOMhbogQPSiWnWniGfHHkkizeJ9jKiclsxHoNwCigYeGEMMTBavCCdIfRMlafjTJ5m3V5CMEBOz9Yc7HC+Hpr41hKtcECNtIBjXH47AUz/RjgF6IFA+TOtV0yW77273mKEj4JVhi4w00zuqUsLSPiOkEoS0KB2CpTtrZAnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648872; c=relaxed/simple;
	bh=lvM8SYRjAcBcBrT16/M1DFbGCMnx7QwHI/t3PYebSqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1Nm/39qfbCvZgq5XQm8g8wievwqwgCZmaWNBx6FD7ErKspyCg3skTznKcW/D0kCwOHRgLkwfqHBBs5a0XLH2bmLMcmSmZcYNSxprWz0d/QYMuEg1xxT9+VuWVf8PFAgC3NO2NLTJWpPZuOqSRneFiKZfel2I0oH7ByS6BNhjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vc6//vrj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vc6//vrj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tme4FD6484qZNGZY5THeG5r5HmtUVcIxcQ6OTxLWhlM=; b=Vc6//vrjITTB1wSm0yu5m+pNb3
	YFnUiPTH83lYbuDW6c67qYXpojMQVGeEGUH9kBelHcJMkpIpsGgV1O5fTOcpQa9WFSV5EJIRnZpIz
	twM0oHTQUau8hxTme04Zcro9igHrOtxmsZNaxUKdubj/nnuwqCArwKYOiL4m9WHHHJCg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7BQ0-005fvR-Db; Thu, 17 Sep 2026 14:40:48 +0200
Date: Thu, 17 Sep 2026 14:40:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
	kuba@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
	paweldembicki@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
Message-ID: <8a60c2ab-6676-4a23-ab5b-84d9fa5399ca@lunn.ch>
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917104920.2147568-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 10:49:20AM +0000, Wentao Liang wrote:
> spi_dev_get() takes a reference on the SPI device, but neither the
> probe error paths nor vsc73xx_spi_remove() ever release it, so the
> spi_device can never be freed after the driver has been unbound.
> 
> Release the reference on both probe error paths and in remove().
> 
> Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Please set the Subject line to indicate net:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
