Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E1F43B3F4;
	Thu,  6 Aug 2026 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015172; cv=none; b=O6qsbgE2Cz86AiBLzZU99zyx6Q3aYAvZSndCpIgFtIBw+0++FZhHg+iWn6vEY/F+CX5j/8I7tBRHMriesK4cUPT8hVzT7n2Jfor28SW6Ay3vGpexbSZu0lVD4pfGeo3PeH272JmFAtyDOYqT8JCZLjvm5FFfTeo6+uDHpakckKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015172; c=relaxed/simple;
	bh=VZJLBZnRyPxnCLoEjoQyTL2E3KhxDtuYstjmKXmloU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjSTfDx7ZhDCiTMU2RCGh99hBYn1hHiFxPRcwjYV/0ZfDA5mGgD9lFj65uj2nE/J9vfB/iMhOCv5DL1q6vfsvkhG6zfsebGYg3wU7vEHivo6H1Fdfn6cAqvXJDMHG54vY/9Ej9MgRW4aAzw+xHtDXPMDmVMh8/31X3UBx8lRtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=t+gQlB1V; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="t+gQlB1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1786015158; bh=VZJLBZnRyPxnCLoEjoQyTL2E3KhxDtuYstjmKXmloU4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=t+gQlB1V0eTdunNlGu7Efvhp5s23euUhKrq6r0mCrUKAP+ZyJPCZcjD5rWEJV0a8G
	 +do9zHUtckn+wcm2J/HtiEghohNvu6748gAEhWdbxh6GdmWctUq/1GcJqgWQeAKKSH
	 Xk/5pR+QEFiuQthNPkjj66Ko3Zv2jBQJIpVixhp0=
Date: Thu, 6 Aug 2026 13:19:18 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: David Heidelberg <david@ixit.cz>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Olivier Benjamin <olivier.benjamin@bootlin.com>, 
	Manuel Traut <manut@mecka.net>, Alexander Warnecke <awarnecke002@hotmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org, 
	imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rk3399-pinephone-pro: DW9714
 coil requires higher voltage
Message-ID: <galrq4ug3hhny2ivpylqwuztwv7vnqvm6sdhlu6pucxk6qy2mz@zxw4ckkxj2sh>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	David Heidelberg <david@ixit.cz>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Olivier Benjamin <olivier.benjamin@bootlin.com>, 
	Manuel Traut <manut@mecka.net>, Alexander Warnecke <awarnecke002@hotmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org, 
	imx@lists.linux.dev, stable@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20260801-pp-pro-camera-v1-0-7b4d90788f9f@ixit.cz>
 <20260801-pp-pro-camera-v1-2-7b4d90788f9f@ixit.cz>
 <2j7ogeqj565sftp5wzqvtzi2id76fof623bifbmyu6ckhf6vm6@ya7h4tp5i4qf>
 <7d55eaba-967c-4de6-8021-6b2d17670b1f@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d55eaba-967c-4de6-8021-6b2d17670b1f@ixit.cz>

Hi,

On Tue, Aug 04, 2026 at 11:12:21AM +0200, David Heidelberg wrote:
> On 04/08/2026 09:39, Ondřej Jirman wrote:
> > Hi,
> > 
> > On Sat, Aug 01, 2026 at 02:35:21AM +0200, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > 
> > > By datasheet the VDD (in-kernel named vcc) range is between 2.3 to 4.3 V.
> > > Usually it's around 2.8 V. Here it matches the avdd2v8_dvp.
> > > 
> > > Fixes: 9336eb829a18 ("arm64: dts: rockchip: describe I2c Bus 1 and IMX258 world camera on PinePhone Pro")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >   arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > > index d46cdfe3f7849..bde35d9b2263e 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > > @@ -473,17 +473,17 @@ wcam_out: endpoint {
> > >   			};
> > >   		};
> > >   	};
> > >   	wcam_lens: camera-lens@c {
> > >   		compatible = "dongwoon,dw9714";
> > >   		reg = <0x0c>;
> > >   		/* Same I2c bus as both cameras, depends on vcca1v8_codec for power. */
> > > -		vcc-supply = <&vcc1v8_dvp>;
> > > +		vcc-supply = <&avdd2v8_dvp>;
> > 
> > This does not match reality, schematic says it's VCC2V8_DVP:
> > 
> > 	https://xff.cz/dl/tmp/6253a0465329df41.png
> 
> Ahoj,
> 
> thanks for spotting this, since I know you have the device, would be too
> much to ask you to send standalone fix for PP Pro?
> 
> I would drop the change from the series.

Ok. Just for the reference, vcc1v8_dvp here feeds an enable pin for VCC2V8_DVP
LDO regulator (which is supplied from VCC3V3_SYS and not described in DT, yet).
So in practice enabling vcc1v8_dvp enables both VCC2V8_DVP and AVDD2V8_DVP and
while DT does not describe the HW in detail, it describes the only regulator
that is actually controllable and enables all needed power rails for the camera
modules all by itself in proper order/timing.

Not sure what's the DT maintainers idea here about whether DT has to describe
every detail of power rails routing, or just what's pragmatic.

Best regards,
	o.j.

> David
> 
> P.S. I noticed I didn't mark this series RFC. Too late.
> 
> > 
> > regards,
> > 	o.
> > 
> > >   	};
> > >   	ucam: camera@36 {
> > >   		compatible = "ovti,ov8858";
> > >   		reg = <0x36>;
> > >   		clocks = <&cru SCLK_CIF_OUT>; /* MIPI_MCLK1, derived from CIF_CLK0 */
> > >   		clock-names = "xvclk";
> > >   		dovdd-supply = <&vcc1v8_dvp>;
> > > 
> > > -- 
> > > 2.53.0
> > > 
> > > 
> 
> -- 
> David Heidelberg
> 
