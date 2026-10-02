Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1869311C1B;
	Fri,  2 Oct 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972966; cv=none; b=fnVO12dJZ8aJ34ZZ+xCVZFgyInR7xkWK5jgRY4jmxTpFah3MgRqDyrB39Adxqq88L4o920dj7096zTIQ0f29CkDu3e2xLpZt4NZ8r1ZLavS2nAH9HMTz2LGnQFd/8RkDbI7oZa5Yb7CPCV/1Y9sPrZyxBP3WKWDy7tBqKbp7qw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972966; c=relaxed/simple;
	bh=C9CkNGFYk38veMUQQAmio7JIy7xHbjUHpHUaLwMzfIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbtGhKyiZeRoKSPkHrG5Hl2ugWULlknapQLkLF+skH35mCdi7hfDugdrgPlKp2aLapfXJrajkb06yR9HTR4hg4zB6zOBWbw/VDRHE9r0NLrwZLDnu7xBmP2C11NYnoVUaIoc2XnkJ3eZOT5jEQWyAJVp4NRO1sz8gf9OxIvXmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GmYg70Tr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GmYg70Tr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=t4ppJIHMACIG+GVrT2uMsYVo+rOVPj35NF4hUvE6mWk=; b=Gm
	Yg70TrCvNFUOi87YQBDyWLfnMEcTOOnWZ/138sU66bkM6uQypPlilJU93LAnNuKAh0XflK0+xUxSR
	B8zbHO8CTtgFeE78LYjI5JHFxv4Ys56sK9ds8RFIjRutVMQIPgCqHQ2vuWNqeYzQjIvOTObNDAeo5
	+O12H1F2RzsBYRY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCjs8-008fE9-5G; Fri, 02 Oct 2026 22:28:48 +0200
Date: Fri, 2 Oct 2026 22:28:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Grzeschik <mgr@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2 3/3] net: fealnx: allocate the card index from an
 IDA
Message-ID: <72ab97f0-b688-4227-a0ab-bfcdec29022f@lunn.ch>
References: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
 <20261002140954.261779-4-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002140954.261779-4-r.zhambakiev@prosoftsystems.ru>

On Fri, Oct 02, 2026 at 02:10:10PM +0000, Жамбакиев Радий Рикардинович wrote:
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> card_idx is a static counter that is incremented on every probe.
> It can overflow and wrap to a negative value, which then indexes
> options[] and full_duplex[] out of bounds. Large values also no
> longer fit in the 12-byte boardname[] buffer.
> 
> Allocate the card index from an IDA and free it on probe failure and
> remove. The IDA reuses ids on re-add, preserving the options[] and
> full_duplex[] mapping by probe order.
> 
> Store the id in the driver-private data so fealnx_remove_one() can
> free it, and size boardname to hold a full 32-bit id.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

How have you tested this?

The advantage of the KISS approach is it is stupid, so unlikely to be
wrong. The complexity here is much higher, so it is more likely to be
wrong. That is something we have to considered.

Have you put it into a loop, and probed it 10342432341 times, on real
hardware?

     Andrew
