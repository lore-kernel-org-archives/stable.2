Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3F37A83C
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783814; cv=none; b=gWqP7pvGFUHn1wjMPXZq5eug9A/dA9EaiL9uIe86pTTc3CMtPQHBTgXdO8b2BkXnfCrXj4rzzD0Zpmj78hqSOsjdUV10UUa9FEhfdChPGDoF+TW/0vkoUo0Uq7NI3x3VgMpPafVWfF3yJ5s0BmKnNuzRB/c5wJL6ZW+qaxxcK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783814; c=relaxed/simple;
	bh=XfrnwkKA8RLxG11yXMzLXYbbGKJeu8aH/81XRsywFKM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k9oTc6EPWK+4UeJ7qqC84GdhB5qSG5w0s+rTyGZWb64yc3daJvxlRPogUGe8HtiWSpAELSXE6bv131X9Mb39rihZNWDFbuP/TwX5bIqsf4VWlnIBQfHpKzh1aMyX/94Qn25ycD7PIBr3bcQyis5OjxxULdqXmbSkjL0y5yVeHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=IWykNoSp; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="IWykNoSp"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1783783798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzKdp7Hcvs6+zEuzXa7LVO8auZ6H7XjMLgYVqU0x/Zg=;
	b=IWykNoSpjn7zW6CuDj+8yy6zrE53QZYDQY2TzlqVtj1c/WCfWhVl5oUwsq3Pld2XnFxavJ
	OKeLDcV/KyN5suJ2aH1WQVEyg4gcRMhLCpT1prSSIOYp38kOvKYEXQhEcNHQjx0afWN+VX
	+EdqGbLAfKwg33sq0+4BBveY2JjDcKK5IuF+Ncs8koPzsyU2lRxld5eD18854judDqrTo8
	8cK21M6hgoN4iBwdB2b+1ENYTUpLRy6GVzi3CaoZfcMXqv3Drl7huNW2ppa4bjtVF358fy
	v6OXN6B8Y1h0B6i6I9mpOvyaFxAl0ZRbXRpZs4LlfUeZq6Grs/KqXaowmLqR7w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 17:29:52 +0200
Message-Id: <DJVUKXFUVH2Z.2O9IM7YHJOKYT@cknow-tech.com>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Marcin Juszkiewicz"
 <marcin@juszkiewicz.com.pl>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Fix USB hub phy-supply config
 for NanoPC-T6 LTS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Diederik de Haas" <diederik@cknow-tech.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
References: <20260610081400.758687-1-diederik@cknow-tech.com>
 <20260610081400.758687-3-diederik@cknow-tech.com>
In-Reply-To: <20260610081400.758687-3-diederik@cknow-tech.com>
X-Migadu-Flow: FLOW_OUT

On Wed Jun 10, 2026 at 10:04 AM CEST, Diederik de Haas wrote:
> The MTT USB 2.0 hub is connected to the SoC's USB20 HOST1, so the phy-sup=
ply
> belongs to u2phy3_host, not u2phy2_host as that is for USB20 HOST0.
>
> Fixes: db1dcbe5f752 ("arm64: dts: rockchip: add NanoPC-T6 LTS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts b/arch=
/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
> index 0ee67ee24f3c..0e15a2e1f2ff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
> @@ -38,6 +38,6 @@ usb20_host_pwren: usb20-host-pwren {
>  	};
>  };
> =20
> -&u2phy2_host {
> +&u2phy3_host {
>  	phy-supply =3D <&vcc5v0_usb20_host>;
>  };

Please drop this patch.
I was hoping to confirm this with an M.2 WiFi+BT card, but let's say the
results were kinda disappointing (to put it mildly).

Diederik
