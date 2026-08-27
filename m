Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5973F9287;
	Thu, 27 Aug 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826887; cv=none; b=akiGS419VQWmsmkpU9MkRzvGMGmS+kWHEI80PGYfZcWxbrA70sALJ0ya0y9IFMG1thQ8LO28LNLpTFlErnPzOQ88MsiMY4TNOP5sJTbl8gvZyHcLE56RhE3Z3eG9uZoli98zBUtbD85EJoMi3vmwGpA2d/8yzY+Mz8md96cBE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826887; c=relaxed/simple;
	bh=KK5NJ1PV1hiyZgOypx7mFBurh8nt0ZkZ5eiZ5+3GAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3N0XsvHcBHP2hWfEdA53UFS8x4DXvQylyOpMlWO2nUo+zrV+PxjlfQlXdcCqzpA2OFr617JE4ymo4RPiBGQqgMSjlX7Ws5XiJmqOGcpw2QYa15TZjtTkZrKxEQWKT3FzvFiHjgPC2gh/KNRWoRCblQR9Khq9uOrk+vH4g4ZwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsI2aRry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsI2aRry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23FA1F00A3A;
	Thu, 27 Aug 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826886;
	bh=T/AnzTG4qR4BsGrKzsY7N+S07WkDz2GkP8AvfN3T5m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hsI2aRryVKLYJWanLZ3CmqO1rcYnhJ4swYDHu1LdSSLpizFKjgh8fO2D49Xnjl+6n
	 YFiSHwKM1LNr+lq9htUVLUfz7oKHYq0qdqrDwwB6cFqtvG99UpKbScoKe4PUK1Svcc
	 sTPiVd9LtCPXsPXBlb7rfY/wQTEpg+AUXrD21fL1dUGqkuFnbel2Ts/IPVC5FXPxCl
	 M4eUFTPqTbe/26V/8DsVkUYxwjlFrxDajeCshDYs8snBmLKrlLLUoLs+48PVQC0g7V
	 fzwsOSZ9YxO+rsUVGdvqOS+11zeDz895S3xHP2ThP4EMajpwYwdcipPCj7YArgd8/e
	 CupksjgIoPB8Q==
Date: Thu, 27 Aug 2026 12:34:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, wenst@chromium.org, rafael.beims@toradex.com, 
	avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, robh@kernel.org, 
	conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	arend.vanspriel@broadcom.com, peddolla.reddy@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: net: wireless: add flag
 marvell,invalid-reg-hint-in-rom
Message-ID: <20260827-helpful-icy-donkey-9bfdaf@quoll>
References: <20260821010728.45065-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821010728.45065-1-gvalkov@gmail.com>

On Fri, Aug 21, 2026 at 04:07:26AM +0300, Georgi Valkov wrote:
> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> from the mwifiex ROM, which conflicts with the platform regulatory
> configuration on units sold outside the US market. For example:
> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> 
> When the system boots, it detects a conflict between the user selected
> region and the radios, e.g. BG FR US, and applies extreme restrictions,
> preventing phy0 from starting on any DFS channel. phy2 works.
> 
> Add a device-tree flag, which allows affected devices, where the radio
> conflicts with the platform to ignore the incorrect regulatory hint in
> the ROM of the radio, so the platform regulatory domain can be used.
> This does not allow the user to change the regulatory configuration of
> any radio. It only allows phy0 to start and operate according to its
> certified configuration.
> 
> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> [2] https://github.com/openwrt/openwrt/issues/9956
> 
> Cc: stable@vger.kernel.org

I don't think there is any bug to be fixed here. Support was incomplete,
so you add a missing quirk, but there was no bug in the binding.
Binding was correct.

With stable dropped:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

