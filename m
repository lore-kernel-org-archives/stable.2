Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51FB3AFD1C;
	Fri, 25 Sep 2026 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315152; cv=none; b=eZDpN2U45tv8nh/1+T+3Uxd2j+oGWP4zK1xv/9kSuRqymjU5/drxNMBk96sttW7fFSh1fn0dksDyZfbKPl+o759zqA4feD1RANC1tTcfDmpLjoCUs4ju/PaXcm3D01ka9kn11ro6vDPEJWD9/tcc7tnVuFskD5+2ew1T+LtrzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315152; c=relaxed/simple;
	bh=LWV6LVJjHdI4OvxOP2og39LbhlJ5VFHd88GjFXX7OdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4gAq8lHFg4N0xyvoWusIf0265fdzgyRhlelFbSrsF6zOdGY+SEuLH8tPbWwPEyL+8uGjlc0kqSsPfT5OFkOGzjM2/vEfQ2yKbxxWoF6jx3u9YdJM1wKiZ9d/LJyC5yGwMv+kX5NHc9XP2Czdlf6+uJec1Hy3zTX0iU5LOSwChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RL1H7N+Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RL1H7N+Z"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 00B1140E02C3;
	Fri, 25 Sep 2026 05:45:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MtBkMgRwCoAC; Fri, 25 Sep 2026 05:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790315140; bh=vgch/mbwhJBjvGWR38g64Y3Z0HQP0UunvP8KfpIpt18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL1H7N+Zj4lP4SDfpoB6NBKQF88iSUUp4ryL0gqAMzBzp0p/rDknZdNrGYUxlCcVT
	 f2vpq+6jLfZPxxTIV8bJ2KKEc9avRGnKYZOVu+YhTdwgC7qMDH+t6zvCxITZT5/pZd
	 PVCnpupA62ge9yrkmv2QRfU8K75Uqh+eV7ZsfAjoGbDhGJ5bLkPHYfRfyk2oMT9f1j
	 e94M2OVZjPsMu4YsY9nsXWkp9RzgpkQy9ryMWZD3WWNGb6rdfWQRr8lpnWYlMhIMlh
	 9M9kaNW5G69YDDk5Zs60B8aFCfpJtoWinCzUMnMW1FHefgBcE+cgIhz6RtNcEUWcLj
	 9Za1VN8qmmrsVucvQo6IxGp0Q5vsKAxZQu76WOcTUbuN7huIk1QX+h9AIfIG9StdDE
	 9LqNqGW7HzxEbdpuybNAFS6eUn9f9JsecKba0DUMO4qMpECW/9DuqmMEDWY1LbHBzZ
	 IuituXGP2ffb0gqu4D39QlIBdjwzcvHG7aazB3CwHQYDvMW/NUhiZZ7zQbHdxfbPx3
	 Q87p9kFU7XcYDjP5wabNolDeS83Ajl7oZzZRs5T60ThXKYofp37XQaQ5QXmwtA5Mun
	 iKbgIZ40nEEgHEOiCz8am0dCSnOxkF0sxM0x8K5hSYdPqSXOl1fpoAyAXjGi1hw8Wr
	 YVEB+3HOkAZBoLxkmOQR+BjU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E254F40E015D;
	Fri, 25 Sep 2026 05:45:24 +0000 (UTC)
Date: Thu, 24 Sep 2026 22:45:22 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] EDAC/aspeed: Set the DIMM grain
Message-ID: <20260925054522.GDarYKcvFR4mLdAhSe@fat_crate.local>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260916-edac-v3-2-23e9ed2fbdf9@aspeedtech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-edac-v3-2-23e9ed2fbdf9@aspeedtech.com>

On Wed, Sep 16, 2026 at 01:30:39PM +0800, Ryan Chen wrote:
> The driver never sets dimm->grain, leaving it zero. Since commit
> 3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
> edac_raw_mc_handle_error() runs WARN_ON_ONCE(!e->grain) and forces the
> grain to 1, so the first ECC error reported on any Aspeed BMC SoC emits a
> warning splat, e.g. on the AST2600:
> 
>   WARNING: CPU: 0 PID: 0 at drivers/edac/edac_mc.c:924 edac_raw_mc_handle_error+0x4b4/0x604
>   ...
>   edac_raw_mc_handle_error from edac_mc_handle_error+0x364/0x4a8
>   edac_mc_handle_error from count_rec+0xdc/0x124
>   count_rec from mcr_isr+0x110/0x1e8

All of that is fine and dandy but you should talk about why the grain is
chosen to be 16 here. The warning is just to make you choose a proper grain
for your hw and doesn't need that much 'splainin'.

> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: stable@vger.kernel.org

Is this really stable material and if so, why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
