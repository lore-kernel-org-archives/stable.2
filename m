Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478620;
	b=Js+HAOkHfuP+Nf+zv7e9WOzB8CCHy55NXf9DYuT8HkMZ2yybX9num+QKTs0EsBEu1RYM
	 jsueQxSJwNZpDNMoZ+8oyXccbJfRlCWZit4ql+bt7MkpoWROUvAC7onCJJnkViVt+f95y
	 ylnE+v5ZExf1wAqO0zSiyoaIcqG4MsILFqGN226fGa2FKl6ZVLBeTYI6n4NTaepgGpywP
	 1nzInUGQG+hPJdnEG8ilPYiwO3/rO+C9EhxJ4xLH9K6rPo8WQqNWQlIwR696LAudy4+fm
	 Oo/y1u/Q+ycxpHxqJalf1CHhDsmxNCXOzK8NM/ysbn+1OE/nniQ6gBF6x3DiKZG0/pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478620;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/RdHwbquKi+MVjjdJwJhpJsAsG12vtsmDqJfkK4Jwn4=;
	b=euOSgK5tEthNf6F5iTr6XKbRo+xa58DTGMeRIHiGv8HSkbXcImb9xDOy672A4xV3P13t
	 L0S4fQMyfSS75spN2JnKGypW3faag4T1gKUBGPHwwQ5Fuxn70tlhAz7Ree3THUkE4pWKj
	 kSz/FzbCQ8dphKp9C06Otwr6jrAbEwpiUOo84kJsSEecwa4p1ZA42xJnwrFnWOCR3fvkS
	 iKhVBBK0C/mSiJSXJW5kI1V0ey0veNqRgkF40mxcrhiDV+Bb9ZKTzqJ1EbcUS396b+9Gg
	 ++Xqv6xg/VQ58uiP/ncY63MSfzaIlHmG03tOO1qVqYDkdfT8A5iVkCgS4ky+5ZqUABw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATxohBFD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C8606A323;
	Thu, 12 Nov 2026 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATxohBFD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCB91F00A05;
	Thu, 12 Nov 2026 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478620;
	bh=/RdHwbquKi+MVjjdJwJhpJsAsG12vtsmDqJfkK4Jwn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ATxohBFDTHfYEdsLHe3UlmOS+O+rFc4eVDkGQL5vNv2fMs7+RZQ2uS9LAQMpJ1WDX
	 U1nnxjcThcj2dp6SOM2vKMcWmndIUgm3S4M7Ha/SXQrFkVe5VCcYa5pUh9hMYtPSiZ
	 oX/bb7PANfMg5zXIfar1jQGaoikxEQjvW75B4nky5n3nuzE2IHXAFi9nwXJsYCP8Cq
	 5C6rEl1ZWVu/4tBGW98KN2t3IODQgff1XJ4XLYblSVIVTIg9RhhyfMk96CBd3cBQMQ
	 bRd0FZ7V5P/zmWo6gyv4lDynLqam2JyY4ffjqKzj5/V1QBlMI/xgkuLr6eYus1kvQT
	 sSL9YR6adL6rA==
Date: Thu, 12 Nov 2026 10:16:56 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <20261112-truthful-zircon-narwhal-fa5d80@sudeepholla>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
 <20261112100448.GA53281@francesco-nb>
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
In-Reply-To: <20261112100448.GA53281@francesco-nb>

On Thu, Nov 12, 2026 at 11:04:48AM +0100, Francesco Dolcini wrote:
> +regression list
> 
> Hello,
> 
> On Mon, Sep 28, 2026 at 07:49:01PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > When multiple devices share the same fwnode (e.g. the SCMI bus creates
> > both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
> > the first device registered becomes the fwnode owner (fwnode->dev, set in
> > device_add()). If that owner never binds -- for example its driver returns
> > -ENODEV because it is blocklisted on this SoC, or because its driver is
> > not compiled in at all -- then driver_bound() is never called for it, so
> > fwnode_links_purge_suppliers() and fw_devlink_pickup_dangling_consumers()
> > are never run for the fwnode. The child fwnode supplier links (pin group
> > nodes such as lpi2c3grp, uart5grp, ...) stay unsatisfied and every
> > consumer of those child nodes defers probe forever.
> > 
> > On i.MX95 this manifests as a complete boot failure: the generic "pinctrl"
> > SCMI device claims fwnode ownership but its driver returns -ENODEV, while
> > the vendor "pinctrl-imx" device binds successfully. Because
> > dev->fwnode->dev still points at the rejected "pinctrl" device,
> > driver_bound() of "pinctrl-imx" skips the supplier purge and dangling
> > consumer pickup, so all I2C buses, SPI, UART, MMC, USB and PCIe
> > controllers wait forever for their pinctrl suppliers.
> > 
> > Fix this in two places:
> > 
> > 1. In really_probe() failure path: when the driver definitively rejects
> >    a device (-ENODEV / -ENXIO), fw_devlink_release_shared_fwnode() is
> >    called. If the rejected device is the fwnode owner, it either
> >    transfers ownership to an already-bound sibling (and runs the
> >    purge/pickup on its behalf) or clears ownership so the next sibling
> >    to bind can re-acquire it.
> > 
> > 2. In device_links_driver_bound(): re-acquire the fwnode when it is
> >    unowned (!fwnode->dev) or when the current owner has no driver at
> >    all (!fwnode->dev->driver, meaning the driver was never compiled in
> >    or loaded as a module). This covers the case where probe rejection
> >    never happens because no driver ever matches.
> > 
> > fwnode->dev is not serialized by a lock; instead every writer only ever
> > touches a fwnode->dev it already owns (== dev, as device_del() does when
> > it clears ownership) or one that is currently unowned (== NULL, as
> > device_add() does when it claims ownership). This patch follows the same
> > discipline: fw_devlink_release_shared_fwnode() only writes fwnode->dev
> > when this device is the current owner; device_links_driver_bound() only
> > claims fwnode->dev when it is NULL or when the current owner has no
> > driver (and therefore cannot be in the process of binding).
> > 
> > Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > This issue is triggered by 
> > aac4e67d6eb9 ("firmware: arm_scmi: Always create devices for standard protocols")
> > in linux-next next-20260925.
> > 
> > But I think this is a fix to
> > f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > 
> > Detailed information could be found in patch commit log.
> 
> Sudeep's series [1] fixes this in linux-next, but it is not yet in
> mainline. I'd like to have this tracked so that it is not lost.
> 

I have already sent it as fixes for SoC team, it must land in v7.4

-- 
Regards,
Sudeep
