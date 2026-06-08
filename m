Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0228CF4A;
	Mon,  8 Jun 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900257; cv=none; b=mF5c1s0r2jG0F5e+zo9C7H6bVynqrbP+7YD7otXrUWB3UiT/obJWlsNzqmR/2fRhoV7E30xoGCfR5+9UH99AcWti2ZhBN/HBgUoFo6Q+OqWhWrYnZPmG5da9S4R0cuiihyBaR+yvF95wtjSkb+5vDHoJOPnA1oWmkJqZyUHUsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900257; c=relaxed/simple;
	bh=PmTj2ntYlT0hFTsceg3H+NF3uQVcrK8SzQw4KCBituo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrExWBdH2L4CB2b33y4k8JbR40Ua/Qx1tMo+fhCwv7dkEfbJvakfN6vq3sgYVblOcbpBupDHOW2imC+9uRap6jXiThF0dBv/2FvgEAw3WcfD5SBAvxpftjgYzdSwBuUrISBMo+01+Dn319J952/X0TV9uAVhbRHNCsch+uiwXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Kjw/Ui50; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Kjw/Ui50"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 469C11F92A;
	Mon,  8 Jun 2026 08:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1780900244;
	bh=f4vlcejmN+4pqyqSMq9klPgT89unpijOOfOwM67ow4A=; h=From:To:Subject;
	b=Kjw/Ui50l1fYNROPB2HfdBMHcMKbNUdFYl1BCY0mEIhvXyrlDTIPVbuKYv98cR9Ro
	 9Lefp0KF/CySG1hqafoXRM6cADu5/ljUi5RyuuQw1mYHGuVSIAz3Pa+yShuF0DZJNa
	 lLTd96dWIiuTCg1bLK58LqaZ/xqmA0pl5ZVF6rOmh5DYAMSoBk+a93Cdk/OVfmwG2f
	 UACHZRI/JQVpD683HUmzUv9EuirYBlf2yu+x7bTPn9UqQyx8hezNFEnrrvCRROLK+2
	 AI628OugaW4Nr/pD3fPLU2LUVHmQh8A9YdQHBrbIT1LEWL8tko04ntTbgyRCisbhNE
	 gkzKYhPyCvnUA==
Date: Mon, 8 Jun 2026 08:30:40 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
Message-ID: <20260608063040.GA11711@francesco-nb>
References: <20260607095727.647295505@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>

On Sun, Jun 07, 2026 at 11:56:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.93 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

