Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646E49B47F;
	Thu, 17 Sep 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683540; cv=none; b=FAEI1s8wNC1TkSPdjtw3uQxjAIJ/CKiRJkqXVwLYiB/GsRbX0o46AtybgVyQhwFjXYz+d8dI2h+zyyEnO5tgey625o37lIdpYDyTRFnrYkrxHFSydNIcT+AmMFS3pMNk9skAfQvPzlaC6/KLht6PuZwSCN5Uqqqsey2B9BBVtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683540; c=relaxed/simple;
	bh=TJozkBUA/3D26KgJeVCLra+LEowX7XPgFJI6tBrf5OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY0QavgboQUE7MJY4b7SlvN5zKdszKfFRN8QnK9W4dBUpJPdvu2xug2sHsFpHJYKmKkeJ7P3Vll7dH9SwWUXtUxQ/Iu+F7o7yMX53rb8hYHGMW2pV2UZb1RKhis6IEWlfWQ0zdTX3UrcdX3nabyno204R2U+DQjecCEMD3Ieax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVVHO9Hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVVHO9Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8891F000FF;
	Thu, 17 Sep 2026 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683539;
	bh=ID0yyjs86uvWzjzpkXQAyqsj+E11ye93NtAKSRfhkjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVVHO9Hw1kTiBcefgMiGB+m9wBlu3SPKUKP4+vaWxfsfXBnK9asXgEspqpWOBw/LV
	 7c7Kxzh58w5eQkaVg8/Rjt5AmakFIBZVq650Qio+IRVcuj4+bu6rpMv2lr5Jj+Bxw4
	 WL0eVk5oBtjLHUZ/8ShMyrmTrbjQu/Yc8fyut9f/g/AaviXxMJnCAUBgdOIU5bAVbO
	 VsRl97IVrQapzsxS2cq1WO/yz9Ls8TM714nB5gKShVs+WpUS21DQIVGVBRrLOpWZ3T
	 NSiX2hG2VEkpTKtQJLNAeVHvb2mjSgL5JDnE3+UVz4oZ1w1ydeeayHV9RXX3seJXFi
	 05tQcqStFmw+Q==
Date: Thu, 17 Sep 2026 17:18:57 -0500
From: Rob Herring <robh@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP
 CPU ID
Message-ID: <20260917221857.GA4056431-robh@kernel.org>
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
 <CAKTNdwH9QAgreJ-6+t1j_P1di4VyoMBSsFkf_g=mCi_-M8g9Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKTNdwH9QAgreJ-6+t1j_P1di4VyoMBSsFkf_g=mCi_-M8g9Pw@mail.gmail.com>

On Thu, Sep 10, 2026 at 06:48:33PM +0400, Alexey Charkov wrote:
> On Wed, Sep 2, 2026 at 5:08 PM Alexey Charkov <alchark@flipper.net> wrote:
> >
> > Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
> > memory, and Rockchip bootloaders use it to give boards which have no
> > dedicated storage for a MAC address a stable one anyway: they hash the CPU
> > ID and patch the resulting addresses into the device tree they hand over.
> >
> > Kernels started without that fixup, e.g. straight from the SPL in Falcon
> > mode or by any other loader which does not implement Rockchip's derivation,
> > fall back to random MAC addresses which change on every boot.
> >
> > Formalize the derivation in the DT binding and add a Linux kernel driver
> > implementing it, so that a Linux image can use the same stable addresses
> > regardless of the boot flow.
> >
> > Only RK3576 is wired up here, that being the SoC I can test on. Other
> > Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x7 rather
> > than 0xa on RK3588, for instance - which makes supporting them a two-line
> > addition to the driver's match table plus the layout node.
> >
> > Patch 1 is a prerequisite fix. The OTP hardware has its own internal state
> > machine which only works correctly with serial access, but the current
> > driver serializes nothing, which results in timeouts and/or corrupted
> > reads (e.g. returning splicing a TSADC trim value into the buffer of a
> > caller asking for the CPU ID, or mixing up trim values of different TSADC
> > callers). Hence the Fixes: tag and Cc: stable.
> >
> > Cross-checked on an RK3576 board: the addresses fixed up into the FDT by
> > U-Boot match the ones derived by the new driver, and the driver correctly
> > assigns them to the network interfaces when the kernel is booted without
> > U-Boot proper at all (via Falcon mode).
> >
> > Sashiko also rightly pointed out a use-after-free in the nvmem core when
> > a layout driver is unloaded leaving its sysfs nodes and the postprocessor
> > function pointer dangling. This is fixed separately in [1].
> >
> > [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-2d16bebeb518@flipper.net/
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> > Changes in v2:
> > - Switched from a scope-based guard to explicit lock/unlock calls in the
> >   OTP driver to avoid mixing styles in a function using goto error
> >   handling (Sashiko)
> > - Link to v1: https://patch.msgid.link/20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net
> >
> > ---
> > Alexey Charkov (4):
> >       nvmem: rockchip-otp: Serialize reads
> 
> Incidentally, patch 1 of this series also fixes CPU thermal throttling
> on my RK3576 device: apparently, the mis-read OTP-programmed thermal
> trim values broke the thermal governor logic, which now works
> correctly with properly serialized OTP reads. So it would be great to
> have these merged.

It would be great to have the sashiko comments analyzed and replied to 
as well if you would like this to be reviewed.

Rob
