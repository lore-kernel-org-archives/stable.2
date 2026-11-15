Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783640;
	b=uCTfqluhq3uFC9J5mr/o+X5iQAYzVU008ivPmgRINwWsaQjB4SPyMoMf4ch8uarAumQe
	 SAsJM9tZCE//S8Wdi/IyKeBt87tQaMxzS3oW6T/z3UxmMHJs1zlR59agUov7nJ/pz2UWp
	 mC1MJGt4vNjzYy/SAzTrwEGdYHMwhZ31Wq+k8ktrYn4/+ydqEOM8N9VF4yLy7FHr//m2J
	 //KOqkHVYDmnF/BHmHOgeA72ayALzD2A30Kzi0MYJj0sYUJCX7RCQN8f1PI/CX8SvMSh6
	 AiBeaqF/cqDdUQC/jd1nSTKduyhoB7Mzem/2J6KEtY8hpcnLchGHK3iKc1Cmap09BJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783640;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Dtzz/VpouXrrXDmorVx10zRi4oO7y9Kg47BHVA7WTBk=;
	b=rONcdXnqjPAiaxi2KLwkcVWo3tRSvNjInUilciXXpOyF8k8APHP3/WG4yzNcSOK+jJsh
	 2haFHUCNsAXxJPZjSF7ud00avFt8YYIiq51Xf+z+pky5GvPC7ZRjurYmXlfJrAHAe+9NK
	 vbu5G4W6UIt/O4+MpyawWuTDQNcw40SYDGa+nRZlE1EXEk7lNKYTnDmW5CzXMoih6+rOv
	 8t8y7R5t73EZLjwCRY7uHeYss1F569sMuRPvPsuvVN9lBD+9Qpo11KZzlrDvkyBPN8L1y
	 bK2puggBZeAKSyeYmMi6ZSmVF5Q7s9aXpThvahlwR/iYBNqnLTqD+dlYE2knD6/fEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2FzAPsiD;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B3606A31F;
	Sun, 15 Nov 2026 23:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388B3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2FzAPsiD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Dtzz/VpouXrrXDmorVx10zRi4oO7y9Kg47BHVA7WTBk=; b=2F
	zAPsiDu6d79iVDQ0PWRJKPD+elLD+ekKINgX9rBaG+xbnIjGKd14ERsKr+TRDZGSEvgL0Nl7zrkzp
	9/PwMis0I99vSbJvEZkcYnulX+Qdfmjq1bN1EiwGUAj/WEA4Ed1eO/OVIN++Odj0TSZzhBd93v1Ew
	Z0zcB3Obq1lCC3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xSjCf-00Ghqs-QW; Mon, 16 Nov 2026 00:00:05 +0100
Date: Mon, 16 Nov 2026 00:00:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: Javen Xu <javen_xu@realsil.com.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: fix listing of sysfs directory tree
Message-ID: <5dda104d-da46-4020-9af5-941fe9d5c8f9@lunn.ch>
References: <20261115214045.3704-1-mat.jonczyk@o2.pl>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261115214045.3704-1-mat.jonczyk@o2.pl>

On Sun, Nov 15, 2026 at 10:40:45PM +0100, Mateusz Jończyk wrote:
> On git master, listing the contents of sysfs produces an error:
> 
> 	root@mateusz-debian:/sys# LANG=C find -iname foobar
> 	find: './module/realtek/drivers': Input/output error
> 	root@mateusz-debian:/sys# LANG=C ls -1 ./module/realtek/drivers
> 	ls: reading directory './module/realtek/drivers': Input/output error
> 	'mdio_bus:Generic FE-GE Realtek PHY'
> 	'mdio_bus:RTL8201CP Ethernet'
> 	'mdio_bus:RTL8201F Fast Ethernet'
> 	'mdio_bus:RTL8208 Fast Ethernet'
> 	'mdio_bus:RTL8211B Gigabit Ethernet'
> 	[...]
> 
> Investigation shows that the forward slash in the driver name is the
> culprit. Fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: f0667918d5fc ("net: phy: realtek: add support for RTL8261D")
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
