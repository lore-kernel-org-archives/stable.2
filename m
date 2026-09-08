Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70792372B3C;
	Tue,  8 Sep 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853270; cv=none; b=qyau6RAEYnCFS5O9vZK/ANR98NR5uMJ+WhCkXSr/lDBJ2UPqiN7abBJVNWstyWRHYwlizOvQZi1Zn+zk8VSCWyPjb//InlczFm20CbOsEX7hHERMmHtQz5LzGf/BKJf3YCBIWS9lQOWFB3q8n3C4GWqRsls2jR3tF04Z6Q2iIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853270; c=relaxed/simple;
	bh=iqajFf/WYI7jPAHYM3bkB/PBvREzAQGjJp8v2Li8o3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9wqw+ZgNonmeAhL3Zltd0GYvlHGy5OBPmGFpX/8SZktEybYZTcTqfIgKkvBtJqekoffvRWCPrthbexJdFFglu0KqhNGNtcMOOEdKkC8SwJuBYnNsvv0SLyXWMkdpIVcF3ASLXTG7CgmmOPFE60uN5A4E+iS39GDWcVvJUrSH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSHlpVkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSHlpVkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E61F00A3A;
	Tue,  8 Sep 2026 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788853269;
	bh=vmQrWS5hLAks8PCrVwczAHtggIpr+4bF8y0hX2HdQ3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YSHlpVkF+p9pKv2cMlGGeLC99pScBBkeNIrRnMllT6ED+GMpjkHWxQjqmyohTIRBs
	 oQ2ntC2zeHslmnV398yWF3ZsixXsIb49RjEb8LWptWBS87iQB+FMWE3Nvwe/hRRlv7
	 SZR2BdKxaOReCfai9ROKVS4oN5nhIr/a/m3bF3ZweDM9mDFjh1NBdYeUQkrrhADbfj
	 zRI1OKeNRY5CgddbFA3+OJ9mZpu0OKYAUZiq1i38UrCBwW9zl8JD4lkZADptHTHJYS
	 qwonHce61aJ5D7sDRuCf7Ul6LxGDPup/xzRBa04sjfmDC4DcPKoZ6V+ffhbTSdogRa
	 KVTOaLgTT1BMQ==
Date: Tue, 8 Sep 2026 09:41:00 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: yoshihiro.shimoda.uh@renesas.com, vkoul@kernel.org, 
	neil.armstrong@linaro.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org, Pavel Machek <pavel@nabladev.com>, 
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH v5] phy: renesas: rcar-gen3-usb2: Avoid long delay in
 atomic context
Message-ID: <hwv6geqxbph5xfcqeu3r6pz6dvb5cteuxg3bh3dzsosl2viuxj@rma3ox42igkv>
References: <20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev>

On Thu, Jul 16, 2026 at 09:32:46PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The OTG PHY initialization sequence needs to wait for 20 ms at a specific
> step, as described in commit 72c0339c115b ("phy: renesas:
> rcar-gen3-usb2: follow the hardware manual procedure").
> 
> Commit 55a387ebb921 ("phy: renesas: rcar-gen3-usb2: Lock around hardware
> registers and driver data") tried to address various problems in the
> rcar-gen3-usb2 driver and converted the mutex protecting HW register
> accesses to a spin lock, leaving, however, a long delay in the critical
> section protected by the spin lock. This may become a problem,
> especially on RT kernels.
> 
> To address this, release the spin lock before sleeping for 20 ms as
> required by the HW manual and reacquire it afterwards. To avoid other
> threads entering the critical section and configuring the HW while the
> software is waiting for the OTG initialization to complete, introduce the
> otg_initializing variable alongside the otg_init_done wait queue. Any
> other thread trying to configure the HW while the OTG PHY initialization
> is in progress waits for the wait queue instead of immediately returning
> errors to PHY users. The IRQs were also disabled while waiting for the OTG
> PHY initialization to complete, as the interrupt handler may also apply HW
> settings.
> 
> The OTG can only be initialized once. It is initialized by the first PHY
> that calls struct phy_ops::rcar_gen3_phy_usb2_init().
> 
> To avoid failures when multiple PHYs call struct
> phy_ops::rcar_gen3_phy_usb2_init() simultaneously, and the PHY responsible
> for initializing the OTG either fails or deinit quiqly and another PHY
> takes over the PHY init role), the code waiting for the
> channel->otg_init_done wait queue retries up to NUM_OF_PHYS times.
> 
> Fixes: 55a387ebb921 ("phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data")
> Cc: stable@vger.kernel.org
> Reported-by: Pavel Machek <pavel@nabladev.com>
> Closes: https://lore.kernel.org/all/afhkX2Ys2BG1gnqy@duo.ucw.cz
> Reported-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Closes: https://lore.kernel.org/all/afhkX2Ys2BG1gnqy@duo.ucw.cz
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
