Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604B373C10;
	Tue, 21 Jul 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641752; cv=none; b=JAV0nZ7y5HM/PB/ZHHOr3PyGjBq8NyhEshzG5EWO77JJmigmG4BNwQZm4DcbU4OCdEKPc92bRq3+kqBpIuNprJHu+8gswLbHA/FBizQw94hcLgON7A8H82MG3s50Vlr9c8r94OUsnVJ/qXwqdmi7DCaX1lQchSx1c9mlxvt51yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641752; c=relaxed/simple;
	bh=2pMitxr8h3dju6qIefG3cMKyqO6M24/P9s7g9GHPrL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbpLyI8h/ceJRWGugI0m7+Y4pZtG7n/JsYueQ0GCyMv1P+4ONIK7z8jaaJEBumkSEr+jjyEru803DnURC1VYG0Kc4L2REvNCIG83LpcMusbAOCSAAbeCrRRBHN+2G/kzQ1r7tQmgIvV9n7HVxBkJMXC3feT3C1NVBXlP/9kKh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNiz+QHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNiz+QHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32541F000E9;
	Tue, 21 Jul 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641751;
	bh=gt0r4eFtUYu9vgkUjUSOPX28KChsmWBAhEYVp38RFPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dNiz+QHlmfkly9Br2iTanLPZcnhuYQIKomL6rhr2onP1AI3OkeBcBCPwmP1Q7Ar58
	 U8iiZFr/chO/1x7tUtCU9Yzk9pBmZAHrYTnfrlgiIfllcHwDfdTyBLCWBOOejXxrT7
	 GrhxE1rzXu8DfTl3/aDIdZbnb3ruIDqF8bV5Xyz9C2/f3g8/m6ZuGwSmvJnBVCOsXU
	 tnA220FBOUMuO5OaaubMrrOyJu2ST7EIuEYUd3RzEBHKdnM/vGrCz5Hx8cc8dgI8/N
	 OND8jmcxhGelADRhzD2iiBXWw/meaDcVwLB5ie0zaBnGXy+F8pOH1KYerruMY3WcqD
	 5nhm1s5CAvj3w==
Date: Tue, 21 Jul 2026 06:49:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
Message-ID: <20260721064910.217a6af7@kernel.org>
In-Reply-To: <7BA9366A-3243-4A46-BA8F-BB170C8AD912@gmail.com>
References: <20260704214808.1566710-1-coiaprant@gmail.com>
	<20260720172433.77b83dc7@kernel.org>
	<7BA9366A-3243-4A46-BA8F-BB170C8AD912@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 09:53:53 +0800 Coia Prant wrote:
> I came across what looks like a runtime PM initialization issue while
> using pcs-xpcs-plat.c as a reference for the Rockchip XPCS glue driver
> (drivers/net/pcs/pcs-xpcs-rk.c).
> 
> The current code in pcs-xpcs-plat.c does:
> 
>     pm_runtime_set_active(dev);
>     ret = devm_pm_runtime_enable(dev);
> 
> This sets the initial PM state to ACTIVE before runtime PM is fully
> enabled, and before the clock is prepared and enabled.
> 
> If the device is later suspended (e.g., during unbind), the suspend
> callback may try to disable a clock that was never enabled, leading to:
> 
>     clk_csr already disabled
>     clk_csr already unprepared
> 
> On Rockchip platforms, the CSR clock (PCLK_XPCS) is required for register
> access, and this pattern seems problematic when a clock is actually
> provided.

Thanks for a clear explanation! A couple of sentences to this effect in
the commit msg could help backporters understand the severity of the
issue.

> I have a few questions:
> 
> 1. Is there a reason this hasn't been noticed before?
>    As far as I can tell, there is currently no mainline device tree
>    user that enables this driver on a platform with a real clock
>    dependency. Out-of-tree users might be using it without any clock
>    at all, or ACPI users might behave differently.

Ditto. I think we should drop the Fixes / CC: stable and instead
add a sentence that no upstream platform can currently trigger this.

> 2. Should we select PM in Kconfig and drop __maybe_unused from the
>    PM callbacks? Since this driver relies on runtime PM for clock
>    management, it seems odd to allow !PM builds.

I'm no PM expert but if it works for current users I don't see the need
to force the dependency?

> 3. Should we add a .remove callback to force suspend the device on
>    unbind? Otherwise the clock might remain enabled if the driver is
>    removed while active.

Embedded experts would have to chime in on this one. AFAIK this is a bit
of a gray area. Some users may want the link to stay up, eg to allow
WoL or avoid link training, maybe?

> I'm happy to send a follow-up patch addressing these points if you
> agree with the direction. Let me know what you think.
