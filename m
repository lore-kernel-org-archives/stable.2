Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9700386C2A;
	Tue, 15 Sep 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462093; cv=none; b=mh9MYsx69U9yWR5ROskmSL3/MfzMBGda30BhLU8IBgRIQG9l1oPHxMrbY0rwNnOHtGWZblBbw/6NCEVqhCuqMOlUm8DugOJEKCcHMMawWDepJQdok9SOrZYan3zWTW8D3Q1uH3qUn205A/8iF27qTHk2eSXu36iA9SuInPxM1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462093; c=relaxed/simple;
	bh=/vzdDlAJE99l9b+7WWElcpxYh18XTrN4NVT5ZEIG9s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhO3mksh7NXy3Jj0IT5O0FBpNwgdziFPhI/ImwL0Ae5rfSOg3pfRx3YXZ8Zmgc/e5GYO0k7BGjAVi+n7/ZVzrWlMWpyoofLv6XRBiZJlsjoWNTXm0p8C0ti3ytCeg49ccOZXVTw27mLto0nKsEeDmYfFgP4MyhLweHRCP+JUcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA4Q/Y52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA4Q/Y52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C607D1F000FF;
	Tue, 15 Sep 2026 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462091;
	bh=P9syazwThZXUn1aVDLlXlF81tphXK8lH2tEemacpfKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RA4Q/Y52/SbIfU6/XrwUkYSZuPwlmEUXii6Z+aSxA9Zkj/qvz4En3OagQoB9MJBDD
	 Lgvsh9BIS9hCBNL/ZTZSe26SE82mKfwQi5ZXNh8IHX/TWPRji6ibSN/gY6NReDb7T7
	 kOyKEznss6DMt9a40aXr4WPZuqZCuytpKhWC+6XUgsG+3ZPTwbLCkG17BJ47MljdHV
	 tKRLIp0+PR+X0vgkF5NnLvX6LIqDa0sL7acSSQMR4L/fNaTfmcCLCQ45gwmV2hn687
	 gWEJ8/wDsr4NwTuLp1QuJg9+fiae90MdLH/+6qb/wb4FHP8/pflP7TLmKL4nJqlI8k
	 Q2262FwtonOPA==
Message-ID: <2136d3b9-c227-4e05-9089-89fb4d565577@kernel.org>
Date: Tue, 15 Sep 2026 15:48:06 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] ata: ahci_st: Do not ignore errors when getting
 the reset controls
To: Niklas Cassel <cassel@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Alexandre Torgue <alexandre.torgue@st.com>, Lee Jones <lee@kernel.org>,
 Tejun Heo <tj@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
References: <20260915084127.692494-8-cassel@kernel.org>
 <20260915084127.692494-9-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260915084127.692494-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/15 15:41, Niklas Cassel wrote:
> st_ahci_probe_resets() treats any error from devm_reset_control_get() as
> "reset control not defined" and continues with a NULL reset control:
> 
> 	drv_data->pwr = devm_reset_control_get(dev, "pwr-dwn");
> 	if (IS_ERR(drv_data->pwr)) {
> 		dev_info(dev, "power reset control not defined\n");
> 		drv_data->pwr = NULL;
> 	}
> 
> This also swallows -EPROBE_DEFER, which is returned when the reset
> controller providing the reset has not been probed yet. probe() then
> continues as if the device tree did not specify any reset, so the resets
> of the SATA IP are never deasserted, and st_ahci_configure_oob() and
> ahci_platform_init_host() access the MMIO of an IP which is still held in
> reset and powered down, which can result in an external abort.
> 
> The resets are optional in the binding, as they are not part of its
> required properties, so use devm_reset_control_get_optional(), which
> returns NULL if the reset is not specified in the device tree, and
> propagate all other errors.
> 
> Note that an absent reset is now indicated by a NULL reset control
> instead of an error, so the "reset control not defined" messages are
> dropped.
> 
> Fixes: 76884cb2f7da ("ahci: st: Add support for ST's SATA IP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
