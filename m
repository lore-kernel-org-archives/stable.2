Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477896;
	b=MnHSn40trxcHF/yIkwj94s3NXkr5ZLrL1SopuWompmNlbt+JykLBmgEm1od9k7ikmwUM
	 JKaX3WKFPu3rXMg4pdpEUOxpyc82+wJg0S+Rn2pcNEt4fUq5ULdxM1kHYUOLlXb956If3
	 PLWvgCA03ShxVtzV0He7HjLfTT4GM2Xb9w6Sc3uznU/Ln7L9SB9550f/oo/mBJQUgBx1k
	 56/WNmspDBgTm9fkVYqHtHX58v1UWX14lwQDqUdQ8PdQeJb/ka/BhaUKFUgMNNJx3AicH
	 t2p946IR2hEDn9gpWmyKTJkFnqsR7CGsblwoIv8TeNu8foG2E9qt6tsWytb2oGm2HfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477896;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=12FxQz40ZG0aBXbOpbg2g2yd/BGfhAmZAB/dUKb2ZeE=;
	b=l/8rh+bYsy7Dvi2YQHN0Hw2Qcn7v88rL8DUvPFQs88gTvM7P1p2hlnbxm4W4yQ/Yr2WE
	 8cCw6tcN1WPgKMfq/Xy2SNlKYfoOCmSdf5KoG5SJtX2Iq6T6KhWYyjcsBUhY+Np1ECHP8
	 ZDM6YmVmmFnRi7Vcz3kEPM4NuOke3JQBRXcwm1uokkTRgFMLOp4DcOFJVoT39dcKqqJD7
	 PVOLuuvhro4YcEFzJeYcf7FXSN755YqyTI5oerZRG1S0TX7mq/ROrDYL8awcUJhNjMNir
	 CuR8On58H9r1seZ+PYZrmrUZTE/iJGkBwauqG37OKTspYZQEP+RXTkXZQcJr40req7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=EwVro4zd;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E3606A88D;
	Thu, 12 Nov 2026 10:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518E3606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=EwVro4zd
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3F8C021447;
	Thu, 12 Nov 2026 11:04:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1794477892;
	bh=12FxQz40ZG0aBXbOpbg2g2yd/BGfhAmZAB/dUKb2ZeE=; h=From:To:Subject;
	b=EwVro4zddjIo4VKA5LMoi5hY6WS6oYjLYIW3pLBAhZEtcrPJL7OG3Gw+6Mgi+ZdbM
	 CH5ZI8CTi+aWldncyyeQd33H9WrPwKL0Z/bQUw9CL/Hw8viEiQwXMxqAuieEU2mWwv
	 VoWZaGMdIjayD37MhMmpD9MI0w28sKu9+YHn6Ymboc4YeFLR84lDJHpzMdegGyAYIS
	 tLm3szk1apuqKYfIlR1M6+611kM5Zi2IgLr8QViCXglUJpaN4jkCvgjYDgONsZMdz1
	 Mg0Qp7Mv21oOhfYy0UXS10xuQv1Hd8DXOOyBuhENDdbp9z6e4bW1nmIoDkxgevwze7
	 yq+t72XwHJAOA==
Date: Thu, 12 Nov 2026 11:04:48 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, regressions@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <20261112100448.GA53281@francesco-nb>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
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
In-Reply-To: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>

+regression list

Hello,

On Mon, Sep 28, 2026 at 07:49:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When multiple devices share the same fwnode (e.g. the SCMI bus creates
> both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
> the first device registered becomes the fwnode owner (fwnode->dev, set in
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
> Detailed information could be found in patch commit log.

Sudeep's series [1] fixes this in linux-next, but it is not yet in
mainline. I'd like to have this tracked so that it is not lost.

#regzbot ^introduced: aac4e67d6eb9
#regzbot title: arm_scmi: i.MX95 does not boot, all pinctrl consumers deferred
#regzbot fix: pinctrl: imx: Match the standard SCMI pinctrl device
#regzbot link: https://lore.kernel.org/all/20261005-scmi_bus_fixes-v3-0-d9bada32ed38@kernel.org/

