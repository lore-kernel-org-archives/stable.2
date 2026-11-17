Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876454;
	b=Lf8XqxMf2sCjgZcU0bSwk8GyMGoPuPXYigOrrNIjxZ3RLJUCEndyYYvOvPtlZBya9tUN
	 7O1odS6+BItgnFYz5iUaJqewneAYz6PVe5SAR3W6DzIeD/r5BOeBZ1IMy8pQzYO6sxtHo
	 0eF7FG4k1D+2xIwlZM+mK1Vm5neqWd9cS+efaEcpvSfQrFpSddqjRWEMyAR+18wsohOJ2
	 jexPPSJQkQwjZiC5wpi3tbaWYGw8d3OnOmq6P+3E+F8fIYIq03CeeaFuZtynNjTugJJEx
	 MFYGEcY8OBu+iQfpNGq12R0rURciAYyc3qWACvonBU1vvjq647JiNKp665VetGuHC+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876454;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=EzHb/fuWX0qpgDrGWWE11dYasvPizPREh36LZjZG9d0=;
	b=El2WC03eIY/N0/QsLqtvMnOsxy8aoHow/xUhSltIxIfdr6e8M+tordqug8XK/HbHADMC
	 hyneTOCkPx9D5DjvvT4s3aeZzLUprJ1a3nxNL5iKTDSNoBy06pnogMujOimCGC8/U7bC3
	 1Rl+XUi0y81N3hlHGN1CEkNAg0F8iqmzV/Qqbs4EjKi0+x/c28wsk7LK70zgBYaCmIZyY
	 bbM9yJgPfVHpHowAk6nnmJJuQPdPNGFJ4gFSQFOlp0M2eAhiq60kpVRfl31kejt+o3E6f
	 mMvEHTA9sQA2pWUBiyFwzOYbd/c2BLIYnxjWTQrgXZLZpVSbff1uoyshR7Ut9w+19NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FJ0kL5B4;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202E606A32F;
	Tue, 17 Nov 2026 00:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6202E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FJ0kL5B4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EzHb/fuWX0qpgDrGWWE11dYasvPizPREh36LZjZG9d0=; b=FJ0kL5B4LlQjfAWBTEgwwfm1+x
	vwYO3BjSMf/rwUxFLd1RzMknv2bHViN+aLS+nMUFbHMXnTtH0kiyTghQsKybH66Ak2mXAktAu+eJO
	4BW8po2zMo3TLjkVpwyhIx6btV2MP87J/w9jHAm72YS82RfFZNcpKNWWOsALP8ga3vNE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xT7Ld-00H2hL-85; Tue, 17 Nov 2026 01:46:57 +0100
Date: Tue, 17 Nov 2026 01:46:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: mat.jonczyk@o2.pl, javen_xu@realsil.com.cn, hkallweit1@gmail.com,
	linux@armlinux.org.uk, kuba@kernel.org,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: fix listing of sysfs directory tree
Message-ID: <5f27878a-1206-4f67-aee9-833f31506997@lunn.ch>
References: <20261115214045.3704-1-mat.jonczyk@o2.pl>
 <179486542983.3136.9636959145442798025@kernel.org>
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
In-Reply-To: <179486542983.3136.9636959145442798025@kernel.org>

> [Severity: High]
> 
> This fixes one driver, but does it leave the root cause in place?
> 
> The symlink name under /sys/module/<mod>/drivers is built from the raw
> driver name in make_driver_name():
> 
> drivers/base/module.c:make_driver_name() {
> 	driver_name = kasprintf(GFP_KERNEL, "%s:%s", drv->bus->name, drv->name);
> 	...
> }
> 
> module_add_driver() then creates the link under that name:
> 
> 	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
> 
> kernfs accepts the '/'. When the directory is read, verify_dirent_name()
> in fs/readdir.c rejects the name and getdents fails for the whole
> directory:
> 
> 	if (memchr(name, '/', len))
> 		return -EIO;
> 

This is a kernel wide problem, so i don't think this patch needs to
address it.

>   drivers/net/phy/smsc.c: "SMSC LAN8710/LAN8720"
>   drivers/net/phy/qcom/at803x.c: "Qualcomm Atheros AR8031/AR8033"
>   drivers/net/phy/marvell.c: "Marvell 88E308X/88E609X Family"
>   drivers/net/phy/davicom.c: "Davicom DM9161B/C"
>   drivers/net/phy/intel-xway.c: "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.3"
>     (plus three more entries in the same file)
>   drivers/net/phy/microchip_t1s.c: "LAN865X Rev.B0/B1 Internal Phy"
>   drivers/net/phy/xpowers/acx00.c: "X-Powers AC200/AC300 EPHY"

Maybe turn this into a patch series and address all these, one patch
each. That way, if we have any ABI issues, it is easy to revert just
one driver.

	Andrew
