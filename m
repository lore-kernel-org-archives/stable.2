Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1A426D16;
	Tue,  4 Aug 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829192; cv=none; b=Ze+dewAJ71K5qTvQ4KPIYV2eZOfn0jKaTYof9ujT5kuD//FtFql9X9ri4gR0MAN3KBu5mfTV6y0k807qD+wPLy+pd0kS5sp8W1cq/8/EvH/kH7RO05ACPTR7gZ3Z8O5DiQDZjcWAJZN6y+MS+aYZ4INO+gy/GfzyFC/LIq8syhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829192; c=relaxed/simple;
	bh=NEF8spb5u7CiwNS+iTwEBVYL0bpl2VvikQOwHzvJeLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOwcWQFdAz4YezwOzvj1uc+aCnZwk5rO4OA2lQvUqCBiSu0sIEcCh9hC+YKIn/iPGLzoJbSL7uuT42e/SVAgH1ULZW86+46FwSGbsjIgEaRYS8p3oNGa2+ux3rB2Ej+B2I+sde1eQdzcpTZ5URr2GI8Ybi4h8Hsf2ufSfBh9WCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=kOZQ0H0n; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="kOZQ0H0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1785829186; bh=NEF8spb5u7CiwNS+iTwEBVYL0bpl2VvikQOwHzvJeLU=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=kOZQ0H0n7b4gT77O6FBv02l9YBjBiXc3PjJevI3AcTpQiuCrJKoGdy8lThP1WN8O+
	 LYL6yXozTGg6QoO71NQ2O/8HW2d6OcbzYlnWX7KEjrdZ8wve5TZzLAvlmV4VvdTMcx
	 LQ77Q1yNMEjykXQO5teDSBR6JP/u93MDiL9nLKAU=
Date: Tue, 4 Aug 2026 09:39:45 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: david@ixit.cz
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Olivier Benjamin <olivier.benjamin@bootlin.com>, 
	Manuel Traut <manut@mecka.net>, Alexander Warnecke <awarnecke002@hotmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Martin Kepplinger <martin.kepplinger@puri.sm>, Shawn Guo <shawnguo@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rk3399-pinephone-pro: DW9714
 coil requires higher voltage
Message-ID: <2j7ogeqj565sftp5wzqvtzi2id76fof623bifbmyu6ckhf6vm6@ya7h4tp5i4qf>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	david@ixit.cz, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Olivier Benjamin <olivier.benjamin@bootlin.com>, 
	Manuel Traut <manut@mecka.net>, Alexander Warnecke <awarnecke002@hotmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Martin Kepplinger <martin.kepplinger@puri.sm>, Shawn Guo <shawnguo@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20260801-pp-pro-camera-v1-0-7b4d90788f9f@ixit.cz>
 <20260801-pp-pro-camera-v1-2-7b4d90788f9f@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-pp-pro-camera-v1-2-7b4d90788f9f@ixit.cz>

Hi,

On Sat, Aug 01, 2026 at 02:35:21AM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> By datasheet the VDD (in-kernel named vcc) range is between 2.3 to 4.3 V.
> Usually it's around 2.8 V. Here it matches the avdd2v8_dvp.
> 
> Fixes: 9336eb829a18 ("arm64: dts: rockchip: describe I2c Bus 1 and IMX258 world camera on PinePhone Pro")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index d46cdfe3f7849..bde35d9b2263e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -473,17 +473,17 @@ wcam_out: endpoint {
>  			};
>  		};
>  	};
>  
>  	wcam_lens: camera-lens@c {
>  		compatible = "dongwoon,dw9714";
>  		reg = <0x0c>;
>  		/* Same I2c bus as both cameras, depends on vcca1v8_codec for power. */
> -		vcc-supply = <&vcc1v8_dvp>;
> +		vcc-supply = <&avdd2v8_dvp>;

This does not match reality, schematic says it's VCC2V8_DVP:

	https://xff.cz/dl/tmp/6253a0465329df41.png

regards,
	o.

>  	};
>  
>  	ucam: camera@36 {
>  		compatible = "ovti,ov8858";
>  		reg = <0x36>;
>  		clocks = <&cru SCLK_CIF_OUT>; /* MIPI_MCLK1, derived from CIF_CLK0 */
>  		clock-names = "xvclk";
>  		dovdd-supply = <&vcc1v8_dvp>;
> 
> -- 
> 2.53.0
> 
> 
