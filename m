Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68E3FB7EB;
	Mon, 28 Sep 2026 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597353; cv=none; b=fRMYfoqVMgE0u2/eDMawk7xUqSGg9t3OTgJ1UhIL/tjWeOt8s+tQgah21/zTLrC2nIHssr2vL5JLaQltQpa7lDFblEL6CLaaHwm8EliuByNfIpx5QbFDXX/HCIv+28pAv9EkhC60pD86PNKO5OmKm8iUbKjeT0uajQUtd+ks/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597353; c=relaxed/simple;
	bh=ZhtTiN8KD7+PCBVbMunI3SXyiYpT/PgLcIE1Jvorxr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAjGiSWAbHo1gwvZnf7XyARt296W5zzecHDMBOS2Gm2hj5YrvGAg2bWNR2oLWIaOZG3y7vIq2Vz9pjpsarB5bR6jpdyOwKaooR645MqfL7vhfgIWPflkDMxrHzz8cFESKZPNCi3JIR+BNsC5hzq8GibsATCP3No8Po+74i8h2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRF4/Ta6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRF4/Ta6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141DA1F000FF;
	Mon, 28 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597351;
	bh=scWuw41pwIEFku2HqRpmbw+maa4pAQ5w7f1wOR2IJkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cRF4/Ta6JCrgzQdhqPlqV2OKD/4glovbpqU7vwvjk8W4MChlu/SDB4gEStviUDEgU
	 gfnFwPvZeTe+oVI817NmzReLyKHYJ7J8JNHz2LYv8sI0QLSHzYkxgyx+nW2NO6nmJW
	 Ey6iU5I4/0G8akK0KNy7XDyGZLz7GNj7yT4g5O/tqtyualkJwsB/ElYRNqcLAQhWva
	 o4rOcVjMLCpMWE1BiCTXivUay+PNk+xnBygm/iUftC8t8E3+2wo4Smf8T2aqN3+jVI
	 S1UIwPPPJf+dqnzEr+x3Cc5ckm/KWW1EcOLSfIhNi2nIanBeeb8JhqOD/zgJDaw0hI
	 a+Y18RQQLD7bQ==
Date: Mon, 28 Sep 2026 13:09:08 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <20260928-conscious-spectral-manul-19bc10@sudeepholla>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>

On Mon, Sep 28, 2026 at 07:49:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When multiple devices share the same fwnode (e.g. the SCMI bus creates
> both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
> the first device registered becomes the fwnode owner (fwnode->dev, set in

This has been rejected in the past. Apart from the trigger in -next,
anything else has changed ?

> device_add()). If that owner never binds -- for example its driver returns
> -ENODEV because it is blocklisted on this SoC, or because its driver is
> not compiled in at all -- then driver_bound() is never called for it, so
> fwnode_links_purge_suppliers() and fw_devlink_pickup_dangling_consumers()
> are never run for the fwnode. The child fwnode supplier links (pin group
> nodes such as lpi2c3grp, uart5grp, ...) stay unsatisfied and every
> consumer of those child nodes defers probe forever.
> 
> On i.MX95 this manifests as a complete boot failure: the generic "pinctrl"
> SCMI device claims fwnode ownership but its driver returns -ENODEV, while
> the vendor "pinctrl-imx" device binds successfully. Because
> dev->fwnode->dev still points at the rejected "pinctrl" device,
> driver_bound() of "pinctrl-imx" skips the supplier purge and dangling
> consumer pickup, so all I2C buses, SPI, UART, MMC, USB and PCIe
> controllers wait forever for their pinctrl suppliers.
> 
> Fix this in two places:
> 
> 1. In really_probe() failure path: when the driver definitively rejects
>    a device (-ENODEV / -ENXIO), fw_devlink_release_shared_fwnode() is
>    called. If the rejected device is the fwnode owner, it either
>    transfers ownership to an already-bound sibling (and runs the
>    purge/pickup on its behalf) or clears ownership so the next sibling
>    to bind can re-acquire it.
> 
> 2. In device_links_driver_bound(): re-acquire the fwnode when it is
>    unowned (!fwnode->dev) or when the current owner has no driver at
>    all (!fwnode->dev->driver, meaning the driver was never compiled in
>    or loaded as a module). This covers the case where probe rejection
>    never happens because no driver ever matches.
> 
> fwnode->dev is not serialized by a lock; instead every writer only ever
> touches a fwnode->dev it already owns (== dev, as device_del() does when
> it clears ownership) or one that is currently unowned (== NULL, as
> device_add() does when it claims ownership). This patch follows the same
> discipline: fw_devlink_release_shared_fwnode() only writes fwnode->dev
> when this device is the current owner; device_links_driver_bound() only
> claims fwnode->dev when it is NULL or when the current owner has no
> driver (and therefore cannot be in the process of binding).
> 
> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> This issue is triggered by 
> aac4e67d6eb9 ("firmware: arm_scmi: Always create devices for standard protocols")
> in linux-next next-20260925.
> 
> But I think this is a fix to
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> 

Does dropping i.MX specials from list of devices solves the problem ?
I am more than happy to drop i.MX special in the code and let you
sort the pinmux mess you guys have created.

And also I remember you creating situation disabling cpufreq in the cmdline.
Will that be ever used on those i.MX platforms ?

I am not against the patch if others are OK.

-- 
Regards,
Sudeep
