Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB9388E7A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427140; cv=none; b=Jfz1cMp7J+5Nhs03jyoVqTTek0E/bAnKkMs4CHlC+q2GLzJReR37QN0Wf+U8Q4hoT2jd9pGkcMVlpFyQYP02jOmDPx/6rmApJjyksL6YQosQlhr6AH0u98/KaHSSGYdazOyD2oP0tYAvu2rPxIIwdaaTLaIKq/C2G7JBZJaPz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427140; c=relaxed/simple;
	bh=SA/ByAfl33A3SmtveGFdEcVzOtWlDIVnIcu87FOB+mw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgdlXFC6LJdTQoIjbfESQO/EhlqRHnmTcmdzg6PKVSyJBjrYMNcO4LJXsxOZlznrmnaka1nsFfwWhKzGT/7uMYhj3qu6mqI/2CsmJCMXKnFlgfZHL/JtWL/lPuubjdFOW+qBjGDtlLTmAqANkYjWSHbwY9sF3YRWhJ6fAWCpwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J31DsGVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J31DsGVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026C61F01563
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427138;
	bh=TyP+1heiG2JEBN69Ba3VRBjXPtuiPpOB0ezh0Qpyxzw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=J31DsGVDUutt95pMD514Ba8PAg7m8gJCdL92ln8qiLGGOmIftNAkLvBtj7g5svbZV
	 GRgbC9rnXLwZJFgaCSY+56y6R8fTN6jQ7LKdvsWlig/gtFmNPXLZvaMFctf7lkcuMB
	 crvPbdA2mUAGHUeQ6QiIoqoVBaSDHiizc/hyQ9TEZ5Uxv6ty9CLMoBQEnuGn+rS3sN
	 EFI63w/XgsU5CnlpfeS7P89JVTOjhbg1X2dwaQH3VcAAyC2tJRdPwSeGlRWE0Lmomz
	 5YtM9PPBG+SzCy0uKoHTu802YvG20C8wWW+uLnrPIOQYCV4Ej/jCE8iUkXiUpVi23P
	 Q1ME/XlH7usNA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b457a0b4e5so2189511e87.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 02:18:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxk2YZP0jujWc3aKgMSNHG+yyJ6mCrcf0BYh0q2hUdrddoLf0Q+H/OTy9bcws3C9zdgv6gB0Gc=@vger.kernel.org
X-Gm-Message-State: AFuF++lW3wCgg1Bmmq3+HM2oYCMBwE9lh1ZYd7xPjbXMuyzygVRiswzU
	G03d2Mj89WXkj3I6xbQiyHw1lMrsV2v/Dj01NQRU1pkXsMEpdeX91oO5msR0DPu+IZYHkfZaQez
	0H3cp0skz4LwkEZFwoo8diBhTMefZ18xobboPUwZdJw==
X-Received: by 2002:a05:6512:688:b0:5b2:158e:9918 with SMTP id
 2adb3069b0e04-5b60868c684mr3234117e87.19.1788427136571; Thu, 03 Sep 2026
 02:18:56 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 02:18:55 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 02:18:55 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
 <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
 <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com> <qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
Date: Thu, 3 Sep 2026 02:18:55 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeizXYV+2B-OsXa6xWvaJX3moU7hMDNNZa60P5LBjuHxw@mail.gmail.com>
X-Gm-Features: AcwNN1Xsuk5iYGbI7r2LEhNTEEDGndwtxO5wmbinbo_3GryhSalGZ9upGbmn2h4
Message-ID: <CAMRc=MeizXYV+2B-OsXa6xWvaJX3moU7hMDNNZa60P5LBjuHxw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Sep 2026 15:22:36 +0200, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> said:
> On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
>> On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
>> <ernestvanhoecke@gmail.com> said:
>> > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>> >
>> > GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
>> > through gpio-map properties. fw_devlink instead parses GPIO properties as
>>
>> Unlike PWM, there's no such thing as "gpio-map" properties.
>>
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

No, sorry, it's me who didn't get that part correctly.

>> > direct phandle references, so it records the nexus node as the supplier
>> > rather than the mapped GPIO provider.
>> >
>>
>> Can you point me to an example? I'm not sure what a nexus node is in the
>> context of GPIO.
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
>
> Admittedly, this hasn't seen much (any?) actual use in the device trees
> yet.
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
>

In that case it makes sense I guess and good to see someone actually using it
eventually.

Bartosz
