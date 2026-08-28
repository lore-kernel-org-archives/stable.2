Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264E3D566F;
	Fri, 28 Aug 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922545; cv=none; b=LzMSOAsO5W8Gpvfjv612Mh9vmxbFHXeVV0DRGO8bAH43RjLjynjH5fHbaL2jgrPZ5mJdb0AzKhni5gUTsiQ3ov8lkobgZh2qerlY27sEgW69UvYPXHMR0xdNczfpNBAj25AzUYYdRkKqp/E/kTNecnt2W7czDhAcvw/DeIFQ3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922545; c=relaxed/simple;
	bh=GpAZknrMBRXWW+bZfpZyG60znjXYQsu7tPc03eLMNqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8SmcBTICZuG/Vct9qVvm1XMcunP5/OVxzaRCzP1LUge2ROjlJjbBik3/3qilDE7po8eEDZBPddY8Z9QpN9xlQUM7MkUm4n2hZXmwrllZkxMk45nx+scVNwEmjqRz4bq888oXG/acFCp1tzULP+YlsK5lEunuizfEP8YyQSaU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FHuMMzR+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FHuMMzR+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QMRsiKsZQYF4PHFFxZwdOkrqAXkbqotX7ULcFDnvPFE=; b=FHuMMzR+gi/BxnGIl6UHLEkTFd
	mzHjlpiDWQ34IgPn9xo1I1OTgH0MWI02Emeg95Kr28FlULUSDgxY2pyLT4dPUk1O14bAIkWRie47l
	xsTVyTJBeADQHwpZL50AA31mv2lx/vIchP8ZBGScqo9JpvqB/peq1UYr9gulUnochvxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzwKE-001odR-Dn; Fri, 28 Aug 2026 15:08:54 +0200
Date: Fri, 28 Aug 2026 15:08:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyou Xu <xuziyougm@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@mork.no, ericwouds@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: air_en8811h: restore AN8811HB LED GPIO
 after MCU restart
Message-ID: <0db183d7-3881-4f81-9e04-cd2c13d1dcee@lunn.ch>
References: <20260828032922.469449-1-xuziyougm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828032922.469449-1-xuziyougm@gmail.com>

> @@ -1265,10 +1258,19 @@ static int an8811hb_config_init(struct phy_device *phydev)
>  
>  	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
>  			    AIR_LED_MODE_USER_DEFINE);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	/* Restore LED GPIO output enables after MCU initialization. */
> +	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> +					  AN8811HB_GPIO_OUTPUT_345,
> +					  AN8811HB_GPIO_OUTPUT_345);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

That can be squashed down to:

	return ret;

    Andrew

---
pw-bot: cr
