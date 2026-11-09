Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233410;
	b=Rc7ZcqlrnJ5pNF99A/UQltBzDqAg0zxV6v4lUnAdKFPR6f7O1jAppLE1fBut968rDMf6
	 BlCBxfJ/yT3HVqfUYqs9Bfw0hxbrz82OdnHqDDLhA3RZrnrGnkowkaBwVk3hlwl9FRxE4
	 CJa1OAAZmYbtxR4G9O2Qp31uxp3rLALRbtvpUfaxj9TxATpe6I7U/hGGsKXZYFdxCUe/b
	 3euIgYY04V01Mfa/t1ICQGfPU4w4KJDg3m4KvHlV9+fB/2j5gtu0Gn7qP3WzLmtK8KZVD
	 98BsYH8TtjfNsdf0D51TvfUZSHfIppYe+dOUV3sevuAl+RQNjpFy0Ok8Y+Ft4JEyBxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233410;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zXDzhjAT9R0FNsl85MpNlLYfFlMVbyNabR7bM1DWwJk=;
	b=pC2U/5MX4LhxHit9leKUfiRUvMGK8lV5OVAikuQbNbO2bVSlfaKFdVn9VU70tj932jH5
	 zbJ1UUhPpRi7rEJAbOjewsi0agysEz3PQVq7ZjgdHYB+UqVBLGjtvWGeahlLHsRfZLgdZ
	 bY78s+4nI6Uqs3GQHBwD4Dq4KzZ5DERSg7yWC8PC1f0dcfPp8Z+k/HJ+pIXvhlMf+jMZH
	 xRt/8fWniAdioLLmhOLhmjG7PjimzUepQ/qnF26YDlSVTTBbWReJN0Sf99Ot85gQ2/1wc
	 Ot8VtUdgiC8e/W3ChwtUA/kz17jsPBwRgQvPSCVvN7CLVL/iNlmSxsvLZDBSbs73RTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ApsSWzCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5B606EE8D;
	Mon,  9 Nov 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ApsSWzCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87611F008A2;
	Mon,  9 Nov 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794233409;
	bh=zXDzhjAT9R0FNsl85MpNlLYfFlMVbyNabR7bM1DWwJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ApsSWzCrvMXScR+CmxaKL8Ulf9qAm6QEctwM6iy8b82NIWwEqLnwAavPY8S17B4pi
	 8ZWLxyZWBDDIr8TmsKXh6Sb7XvCtI3SpeYvW8Ts6mU5LilnkQT2iBfVlxaxMKu2Ij/
	 CkhzJbxUMmc3YosYNCcUGzG/Wfhxa9rv5ezVWJqQ=
Date: Mon, 9 Nov 2026 09:10:06 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] net: macb: wait for a running xmit before
 resetting BQL on close
Message-ID: <2026110940-familiar-slick-4d2e@gregkh>
References: <20261109-nb-macb-close-6-18-y-v1-1-51af4b20dffb@tipi-net.de>
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
In-Reply-To: <20261109-nb-macb-close-6-18-y-v1-1-51af4b20dffb@tipi-net.de>

On Mon, Nov 09, 2026 at 01:57:09PM +0100, Nicolai Buchwitz wrote:
> macb_close() stops the queues without waiting for an xmit still
> running on another CPU. That frame charges BQL after the reset and
> never completes, so after the reopen the queue stays stopped with an
> empty ring and the watchdog fires until the next close.
> 
> Seen on a Raspberry Pi CM5 with ethtool -G under load.
> 
> Upstream fixed this as part of the context swap rework in commit
> dcc3288b9433a ("net: macb: use context swapping in .set_ringparam()"),
> which is too large for stable.

Why is that too large?  Please backport that instead.

thanks,

greg k-h
