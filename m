Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9ED2116F4;
	Thu,  4 Jun 2026 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535170; cv=none; b=Um8J6jSy+gLQdp8iKmzfbiFH2mqvA5d6u8IkUoKHbfwRgDm0Bf7VyWAkJpW6Te9Tho+ZCTf/GxwLKdsvmfoA25PBJYMpkOguAQZHHaqm4laecDstv473KBaHcmZBaQid9HMAW5oAFC9TLhwrpEFc2sn/yIPhsvuU2q6kcPTrEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535170; c=relaxed/simple;
	bh=f7GQZZnqctJ6cYpR+KuETnFX/Ab3AaJu/tFq2JBNFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONNuTZd6UdFeUbeJA4KHVC0beRRlGcLFhDQLsZ+o15ZJe96BW3oot8YUvCcYRxlEPKffXhyioqi7HkAaNRxz2IwglhinEqPFy1HxeRk0rXAASVoQ7AcvpLEl1cvovuNIa3qqmTScyd5ZxkKdw/IYiYTb4k1gtR0D44NYNhPIy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVkh6ysq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVkh6ysq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D921F00899;
	Thu,  4 Jun 2026 01:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535169;
	bh=0mxNTo4s9EPA10Hhr8XUSInD4aGmKlfSihvZ8Xl0bsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FVkh6ysqFoO2NL8KBR7HU4TLxhqyIU4KGss4bUb9qw4GDACENY+8H8PLASV87lG2F
	 +XcjWgcc1zXCGTKC/TmrUAbzkWG4++63Ex62tX9qmXXuZXrOxaxPgP7KET+ip81mZ4
	 ZpRxZDimx8R52mO8J3E7XAf0M/onAyO8ie40nZjOPqZ+XTMTAvX9Cq43Gdc2aaLN3I
	 Z6e8Af8qRbeYhoaBCFi0uxzJmgQAt1tsYVbqL0hOJ/g1KVOcR/ol2FEYLhQSLc0eK8
	 +PxXabUJTo5gKF9jBSViz74tcOJb7Am3cbaCglBgi27svB7BQczkvzC0+x2exgFX8b
	 Aoe63WaDPlH9Q==
Date: Wed, 3 Jun 2026 18:06:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDuHJu?=
 Mork <bjorn@mork.no>, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/3] net: sfp: initialize i2c_block_size at
 adapter configure time
Message-ID: <20260603180607.353551af@kernel.org>
In-Reply-To: <20260528205242.971410-2-jelonek.jonas@gmail.com>
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
	<20260528205242.971410-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 20:52:40 +0000 Jonas Jelonek wrote:
> sfp->i2c_block_size is only assigned in sfp_sm_mod_probe(), which runs
> from the state machine timer after SFP_F_PRESENT has been set. Between
> those two points, sfp_module_eeprom() (the ethtool -m callback) gates
> only on SFP_F_PRESENT and can be entered with i2c_block_size still at
> its kzalloc'd value of 0.
> 
> On a pure-I2C adapter, sfp_i2c_read() then issues an i2c_transfer()
> with msgs[1].len = 0 inside a loop that subtracts this_len from len
> each iteration; on adapters that succeed a zero-length read the loop
> never advances, spinning while holding rtnl_lock.
> 
> This was previously addressed by initializing i2c_block_size in
> sfp_alloc() (commit 813c2dd78618), but the initialization was dropped
> when i2c_block_size was split from i2c_max_block_size.
> 
> Initialize sfp->i2c_block_size from sfp->i2c_max_block_size in
> sfp_i2c_configure(), so the field is valid as soon as the adapter is
> known. sfp_sm_mod_probe() still reassigns it on each module insertion
> to recover from a per-module clamp to 1 (sfp_id_needs_byte_io).
> 
> Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Thanks for splitting this out.
This is a fix it needs to take the net/Linus route rather than the
net-next route. I'll apply just patch 1 and you'll have to repost
patches 2 and 3 on Friday.

In the meantime - AI seems to also be saying something the cap being
potentially off by 1 in patch 2? We add 1 to the len? Maybe I'm
misunderstanding..

https://sashiko.dev/#/patchset/20260528205242.971410-2-jelonek.jonas@gmail.com
