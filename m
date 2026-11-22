Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345386;
	b=vbqyiMDsbadz1ecJiu4Z01DoDLRxrE++XbksOD/L9vvOvcHz5THR5a0NEBmNSF/XrQq4
	 QLa/FKsqz0qGISSyUyyaarzTAleEnh0i0k0aqzfAqjOxFoUNb5Iie+IU1wFFBuqtNrmsJ
	 MEcjow6kOuBbtJlSGw4c0Vkj5zHTWWPy5tSCVaaasA1z9fEXj9tkl4rPZWhK71lHXIhcP
	 8F0IYVrG9Xsa3LA/2B05JXcGF0HyMJ3bvtM4VWxeozggC9jzyBoP61ChlTAH7E55NhZj5
	 q0kn58BCLWhY3SwDTSgf0wBNQaqPuNlQw5bJGYRT9QVMe4q6/Gg4BfQTqLba6X5B+Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/R61nVuigPlV5/7Nputf93i2b6M43PwhsuF4+XKXE40=;
	b=XLw0gGd2QkpQ2L99+Rbai2K67OSzbpJ0OS/pwzRGbt9TSmvUIrkyh7rzgWvZwfiG6Xmv
	 kNhd1hfGmh8Sna7LMKM0A8XrU58hTqwxQHmBJ6gf6Nt7A2ku4KLKlrJF7NlW6jfhPRsvW
	 1CBg6LtkuaLyBszwsdTQm8B1Lphu3uj7xAgG1mHRVGINrbyLeBYt5GyaJbtInYuXLeAac
	 V3O5jhkfZz5exU6QewXPatj8uOAHuqQdvlsTQo2xJ3Xmk9ktHldYfqolECC/8H/mtXzqq
	 SixA5mnGSmO5m6xlVUQJ1FrTidZ/Vin0x7aQy7LQAYspQR6UoKFRRowQKbNQyCT3LQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Nh6sxdry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B42606A320;
	Sun, 22 Nov 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Nh6sxdry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EA21F000C4;
	Sun, 22 Nov 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795345385;
	bh=/R61nVuigPlV5/7Nputf93i2b6M43PwhsuF4+XKXE40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nh6sxdryFwJh3rlhR3PyPt+PWQUa4BmEcFsi6un62bL8r6DrDZctiXS7fnAmm3Hwm
	 LyaR3MDlJAnUUvCJPTQsVTUI2lGWfNMpK/DEjgx0pepZV25FHX76GdXXBlzfXN+rl0
	 jrRsIoOMRIZmewQOuhJMP5CqR1BX2TjXuDNnLbKM=
Date: Sun, 22 Nov 2026 12:03:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Patrick Fischer <admin@tsv-stahl-riesa.de>
Cc: Shardar Shariff Md <smohammed@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 0/2] serial: tegra: Fix 32-bit overflows in the clock
 rate adjustment
Message-ID: <2026112206-bluish-washed-05da@gregkh>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <dc9e1dff-a8f0-4b2d-b4f2-52248196800a@tsv-stahl-riesa.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9e1dff-a8f0-4b2d-b4f2-52248196800a@tsv-stahl-riesa.de>

On Sun, Nov 22, 2026 at 11:13:23AM +0100, Patrick Fischer wrote:
> Am 25.10.26 um 23:50 schrieb Patrick Fischer via B4 Relay:
> > On 32-bit ARM, both the clock rate adjustment from
> > "nvidia,adjust-baud-rates" and the check of the resulting rate overflow
> > a 32-bit long at the high baud rates the adjustment is meant for. On
> > the Tegra Note 7 (Tegra114), Bluetooth at 3 Mbaud therefore ran with a
> > UART clock 5.6 % too low, and the check computed -0.18 % and let it
> > pass.
> > 
> > UART clock at 3 Mbaud with a tolerance of 136 for 1 to 4 Mbaud
> > (pll_p 408 MHz):
> > 
> >                     requested    configured   check
> >   without patches   47.79 MHz    45.33 MHz    -0.18 %
> >   with patches      48.65 MHz    48.00 MHz     0.00 %
> > 
> > With both patches and the unchanged tolerance of 136, Bluetooth on the
> > Tegra Note 7 works at 3 Mbaud: the UART clock is 48.00 MHz, and the
> > WL1801 scans and connects to a paired device without HCI errors.
> > 
> > With a deliberately wrong tolerance of -500, which gives 45.33 MHz at
> > 3 Mbaud, the check now reports the deviation (out of range by -555,
> > i.e. -5.55 %) instead of letting it pass.
> > 
> > Both bugs date back to v5.4. 64-bit platforms are not affected.
> > 
> > Tool use (see Documentation/process/generated-content.rst): both
> > patches, their changelogs and this cover letter were prepared with an
> > LLM coding assistant (Claude Code), which traced the wrong clock rates
> > I measured on the device to the overflows, wrote the fixes and drafted
> > the texts. It also recalculated the old and new arithmetic for the
> > affected rates in a small userspace program; the results match the
> > rates measured on the device. I reviewed the changes and ran the tests
> > on the device.
> > 
> > ---
> > Patrick Fischer (2):
> >       serial: tegra: Fix overflow in tegra_get_tolerance_rate()
> >       serial: tegra: Fix overflow in tegra_check_rate_in_range()
> > 
> >  drivers/tty/serial/serial-tegra.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > ---
> > base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> > change-id: 20261023-upstream-serial-tegra-overflow-48d3d0f7afd9
> > 
> > Best regards,
> > --  
> > Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> Hi Greg,
> 
> sorry, I am still new to upstreaming and sent my earlier ping without
> any context. This is the series quoted above: it fixes two 32-bit
> overflows in serial-tegra.c that leave the UART clock 5.6 % too low at
> 3 Mbaud on Tegra114, so Bluetooth fails there. Both patches have
> Tested-by and Reviewed-by from Svyatoslav and still apply cleanly to
> 7.4-rc3. Please let me know if anything needs to change.

It's in my review queue, which is huge at the moment.  You can help out
to reduce that load by reviewing pending patches on the list.

thanks,

greg k-h
