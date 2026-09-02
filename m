Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE637702E;
	Wed,  2 Sep 2026 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368132; cv=none; b=aSfpWm2sLBQQ6iJL6h1GbDv3cQhNANDxCPc01waPfxmHgUDWRbDdLvnW9XGBeoDycEcV0ZhJTc9LqTMonfOjFWwogS/dzgm6jgvZjy4HPn2iBvUsYzyDwj1vj3YeNM2MDQJ4Cwqr9q7KnVuMQgMZ0jQOUPBQmwsgId1UD9ZokEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368132; c=relaxed/simple;
	bh=sz/9/TcdM4YQwE3eI4Iv+AQZ0+0SbCoU9Tiqw9z/T+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zabra9ByVHvJfWEN5jEgrEf/kgP7203akxHsgkS1MSSav37KskXX6o45Q1JtbxvbYTKDUCogn2u6SNiRzkNQv0i/GR+eygcGdwulah5ZPyU3w8QDyj3TDSKUZsTA5VXGS5vbQF8b+7mL2DCv6qzlEhUpGnzVoAsFfy/MCbi/W4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sqLT8Ayx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sqLT8Ayx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 95E494E414E0;
	Wed,  2 Sep 2026 16:55:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D77E6053C;
	Wed,  2 Sep 2026 16:55:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2C5811C795A7;
	Wed,  2 Sep 2026 18:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788368120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZQYr6vIouYVEk/Ikuzb8tOHLdjgEOZtrS1Jwy9Of/G8=;
	b=sqLT8Ayxa836vSD5sWR0ycKtIppaXMbA0OKmrP62QCXWyZl+WBtUS7ZgYFHxtlD6c89uT8
	rVv1OpUvWcbtOOzBhpcCaOYRC0139YcuuLIEC9x/d0rMeH60trd6yMMxa+0nmKat2/d9me
	RraVmgbQPtzsH96XAkRp1yZP61N+HPnkMMFeAaA6rk5gf+W/HQmtOGckQThy/XVeTejDLH
	HoKI/6jYn9urFjiXqlMT4PG/xC1HVQdba2GjaRbyrEoILrjNLYp0CsAvKn/kkiY+Eswkxu
	4HmshDfFamGEDethvw75Qkr6V3V46XPGIPS2v5/nYZ2knGfEYV2h2u2kXsvZ0g==
Date: Wed, 2 Sep 2026 18:55:13 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, Bartosz Golaszewski
 <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li
 <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Linus Walleij
 <linusw@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa
 <leonardo.costa@toradex.com>, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus
 maps
Message-ID: <20260902185513.4867bc92@bootlin.com>
In-Reply-To: <qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
	<20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
	<CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
	<qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest, Bartosz,

On Wed, 2 Sep 2026 15:22:36 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
> > On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
> > <ernestvanhoecke@gmail.com> said:  
> > > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > >
> > > GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
> > > through gpio-map properties. fw_devlink instead parses GPIO properties as  
> > 
> > Unlike PWM, there's no such thing as "gpio-map" properties.
> >   
> Hi Bartosz,
> 
> bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a
> nexus node") added support for nexus nodes, and then c11e6f0f04db ("gpio:
> Support gpio nexus dt bindings") added support for "gpio-map".
> 
> Herve later added support for pwm nexus dt bindings modeled on the GPIO
> support in e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings").
> 
> Please let me know if I misunderstood something.
> 
> > > direct phandle references, so it records the nexus node as the supplier
> > > rather than the mapped GPIO provider.
> > >  
> > 
> > Can you point me to an example? I'm not sure what a nexus node is in the
> > context of GPIO.  
> 
> Stephen gave an example usage in his commit message implementing
> of_parse_phandle_with_args_map():
> 	soc {
> 	        soc_gpio1: gpio-controller1 {
> 	                #gpio-cells = <2>;
> 	        };
> 	
> 	        soc_gpio2: gpio-controller2 {
> 	                #gpio-cells = <2>;
> 	        };
> 	};
> 
> 	connector: connector {
> 	        #gpio-cells = <2>;
> 	        gpio-map = <0 0 &soc_gpio1 1 0>,
> 	                   <1 0 &soc_gpio2 4 0>,
> 	                   <2 0 &soc_gpio1 3 0>,
> 	                   <3 0 &soc_gpio2 2 0>;
> 	        gpio-map-mask = <0xf 0x0>;
>         	gpio-map-pass-thru = <0x0 0x1>
> 	};
> 
> 	expansion_device {
>         	reset-gpios = <&connector 2 GPIO_ACTIVE_LOW>;
> 	};

The binding is available in dtschema
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/gpio/gpio-nexus-node.yaml

And the gpio case is mentionned in the Devicetree Specification
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#specifier-mapping-example

> 
> Admittedly, this hasn't seen much (any?) actual use in the device trees
> yet.

Not yet in actual device trees but needed for handling hotpluging of extension
boards.

For instance you can see at the following patch [1]
https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/

tests/fdtaddon_realistic_base.dts [2] describes a nexus node for gpios allowing
to use "gpio 1 available at the connector" from the dtsa instead of "gpio 3
provided by the GPIO A controller". This allow to decouple extension boards and
base board. The common part is the connector. Extension boards dts uses
resources available at the connector while base board dts "wires" resources to
the connector. A translation in needed and Nexus nodes are part of this
translation.

tests/fdtaddon_realistic_addon.dtsa [3] uses a gpio that is translated thanks
to the nexus node:
--- 8< ---
  /* Use the connector gpio number 1 */
  reset-gpios = <&connector 1 0>;
--- 8< ---


[1] https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/
[2] https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/#Z31tests:fdtaddon_realistic_base.dts
[3] https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/#Z31tests:fdtaddon_realistic_addon.dtsa


> 
> We (Toradex) would like to use it to specify a LVDS connector on our
> boards. This connector appears on different carrier boards that all mate
> with the same display and have the same pinout. The only potential
> difference is which PWMs and GPIOs are connected to the connector.
> 
> There, specifying the LVDS connector as a nexus node on the relevant
> carrier board DTS/DTSI would allow us to reuse the same display overlay.
> That example usage is given by Leonardo Costa here:
> https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
> Note how we have the connector on imx8mp-verdin-dev.dtsi but could also
> add it to other boards, i.e: imx8mp-verdin-mallow.dtsi
> 
> Note that in that example we used the "tdx,verdin-lvds-connector"
> compatible for the connector. Since this is a nexus node and just a
> dumb connector without driver, not having a compatible would make sense.
> In a final implementation we could specify a compatible + binding if
> that specifies the ABI better. It is not entirely clear to me what is
> preferred at the moment, but that is disconnected from this patch
> series.

Hum, do you have a look at [4] ?
You could be interrested by this work?

[4] https://lore.kernel.org/all/20260826094950.1088288-1-herve.codina@bootlin.com/

> 
> >   
> > > A nexus is a translation node, not the GPIO provider, and need not be
> > > populated as a device. The resulting fwnode link can therefore remain
> > > unresolved and indefinitely defer the consumer while
> > > device_links_check_suppliers() waits for the nexus.
> > >
> > > Use the map-aware parser for all supported GPIO property spellings. This
> > > makes fw_devlink resolve the same provider as the GPIO consumer API. Direct
> > > GPIO references continue to work because the map-aware parser returns the
> > > original provider when no gpio-map property is present.
> > >
> > > Add OF unittest coverage for mapped and direct GPIO suppliers, including
> > > the deprecated singular and unprefixed property spellings.
> > >  
> > 
> > Since this is a fix that we may want to backport, the unit tests should go in
> > a separate, follow-up commit.
> > 
> > Bart  
> 
> Thanks for the feedback, if we want to go with the direction proposed
> here I'll make sure to split it off in future series, I was unsure about
> that.
> 
> Since usage of this nexus system seems limited, I'm also not sure if we
> need to backport but it technically is a fix.

Not sure it is so limited :)

Also, I agree with both patches (PWM and GPIO).

fw_devlink should use the end device and not the first nexus node.

Best regards,
Hervé
