Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456545;
	b=p8wu5JtbHzTApBU03u59BC53Wl9UCnixbtvAULYOE+BqfIod/uvbkxRGFCJvvE03/oFS
	 PifAPmMfvYJ7afxe945FAjnKMjpYr7Ech879MlEmi1UPDeaol5Rbe5Bpe1yN3EFXs740E
	 Cfbh5jQXH8Rxnbku4kvMIdD/P674W4z3fwaEzdCdWfCNX1UcglX0+tSV4hNjFMJNIX52i
	 sO2xGO91cKcjgJTHi3/Y/1jMiYszzYgs9liAh6+jlff/ZtD5qKIKzB4uOwH1lcU6JMimY
	 vrW5fuc89uDuK6UawW77cmmpTfSZf4Sx55VhXTflg9yGXJE8z7YiTcI8uBsz4IG2MRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456545;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7C7GZbdbo3a4H8A+zEhg8yGiQ1HjOPz6tQYB0uZWjAU=;
	b=FsBi9t4SkhjXdQKk+UB5NASYeghe4am/mMAcEuzb1UP/IyigdKIprFg8CJLFMZiWCEAk
	 mf5Q9n3TTE1Fuwa0qxOwkehsxvC3UHy488bmsgy3qC20Yw//Nm0hLKGidQHOeHNNnevax
	 DqlL3gJ+HNaJOm9VEph3KByN1c5Z6jdt5XHwUYDUw7gZEQmZEN4OVe3AYpXuJEcWOxpsN
	 KRf7WClBh0CUlY2BSHSZ3QHL8UsdocOlA3J9SOZOKAGZctA9SsJuBzGfqK61Qk3Wa2LuW
	 LJCwublvHZlGcPL+BRPjajM+Vcumzpxhi+i9wIdGV/TSbt45VT7yZZHStlRyGzqswVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="XF/nunrU";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC248606A31C;
	Tue, 20 Oct 2026 00:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC248606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XF/nunrU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7C7GZbdbo3a4H8A+zEhg8yGiQ1HjOPz6tQYB0uZWjAU=; b=XF/nunrUjxJNxPqxShgWFi9C6M
	JA8D5R9y3ZprWQFKpc7FmVKI8wCk2I/4QWLL7XHS3KM/blKVbwvfowcKdfDGDIrfEm4+usnTnAtiT
	f5JAEABnDuYY0PcX2H8rIMaOdxbPfWzXtkaoxQbvEpNzJijHuu9/oF7RfHqFGgTzgeLY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIxpE-00BjMd-Jj; Tue, 20 Oct 2026 02:35:32 +0200
Date: Tue, 20 Oct 2026 02:35:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] net: usb: lan78xx: reject short register and
 statistics transfers
Message-ID: <5c1e5db0-1149-473d-b71d-f30d3b96b5f7@lunn.ch>
References: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
 <20261020001621.2920-3-law.wei.jie@gt.tech.gov.sg>
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
In-Reply-To: <20261020001621.2920-3-law.wei.jie@gt.tech.gov.sg>

On Tue, Oct 20, 2026 at 08:16:21AM +0800, Wei Jie Law wrote:
> lan78xx_read_reg() and lan78xx_read_stats() read from the device into
> a freshly kmalloc()ed buffer, but only treat a negative return value
> from usb_control_msg() as an error. A device that answers with fewer
> bytes than requested leaves part or all of the buffer uninitialized,
> and those bytes are then used as the register value or the counters.
> 
> Treat a short transfer as -EIO in both helpers. lan78xx_write_reg()
> does not use uninitialized data, since it fills its buffer before the
> transfer, but make it fail on a short transfer as well, so that all the
> register helpers report a partial transfer as an error.
> 
> The write path validation was suggested by Andrew.
> 
> Found by code review with LLM assistance and reproduced with an
> emulated USB device (raw-gadget + dummy_hcd).
> 
> Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
> Cc: stable@vger.kernel.org
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Assisted-by: LLM
> Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>

It probably never happens or users would of noticed. Please post to
net-next, without the Fixes: tag, once the merge window closes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
