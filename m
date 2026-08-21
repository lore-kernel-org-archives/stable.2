Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B312F7EF2;
	Fri, 21 Aug 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304176; cv=none; b=DgqmEcMh+jOdkCyutt+otD5z1htOWsupqg4Vzce3PNZC9m4DWaDEj/30wH3aDfTXa+nHx9DQkvdNbgYZAQhMmcMMI9zCepRtWY6W40y2P5ewwCNkMhyKKZCvwersi+KlG/M7Icq0H8DZqYJXPyRdumv8AWCBrTgB4GwKNVGSak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304176; c=relaxed/simple;
	bh=hz4RftnwsP8DS/dubnUJ8xEvfI6277x+E63P446Bi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxywY2bBCxbx2hzLte5o/oxTN5d/LdlOrcUXK+Sxws1ACNPTWhZBGSe14tKEsfvi5P1fHy4C3QLcAcS2AxmA5zqT6/LLM/XAhVy12F/qF2EaFb9Zz74hcrcdO2J68cTeLUbWMDMDrc8ztWI5coB4UFVOYUdlHeRlFinofjRKf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIwhA0GX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIwhA0GX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17111F000E9;
	Fri, 21 Aug 2026 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787304167;
	bh=gyHP7DtW0sshgDlPdPfV3Fb0wcri5Z4d+4N94kKmjCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LIwhA0GXgyX89Xk8x/6GbYlNrVLg4puy0BDTdWaNFwyZcC3Szje8S3aIX/zcRG+n2
	 2q3S5Y1rAqeV3Hc81Nt926VMWQywkcXH7RCxYIk7XGzkffbGx4AU/zU7qzknyaOD8M
	 AQ2usFXEPzjHOWubN3lBwVhfEMjKPIhxGtyC/jggyBKXKRzsh25b1E8eIvF7y416ou
	 JT7+G3rFYs5qOgF1SDeuh0TcrE1fTW7fMpzEe+5woRzM7RYBGSS3izU3+4Y4p6zVbS
	 Z92/JatSynV1wqtWNB5VUgC7kYhOMn7sEK7rlzZhB4UrL1ZA/OxaoVPW4D3nyF57pw
	 YzEiCCtMA2Qqg==
Date: Fri, 21 Aug 2026 11:22:44 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, 
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ludovic Desroches <ludovic.desroches@atmel.com>, Wenyou Yang <wenyou.yang@atmel.com>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: at91: fix autosuspend cleanup during teardown
Message-ID: <aogYAmDqlgmnEd3X@zenone.zhora.eu>
References: <20260808152654.2943371-1-lgs201920130244@gmail.com>
 <144ef4b2-a200-4634-a4ec-539a0ba9a15c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144ef4b2-a200-4634-a4ec-539a0ba9a15c@kernel.org>

On Thu, Aug 20, 2026 at 04:50:13PM +0200, Krzysztof Kozlowski wrote:
> On 08/08/2026 17:26, Guangshuo Li wrote:
> > at91_twi_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe error path nor at91_twi_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> > 
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> > 
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> > 
> > Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> > error and driver remove paths.
> > 
> > This issue was found by manual code inspection.
> > 
> > Fixes: d64a818859af ("i2c: at91: add support for runtime PM")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> 
> How many separate I2C, drm, crypto, hwrng etc patches you sent?
> 
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
> 
> Group your work per subsystem.
> 
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.

Is this a kind of LLM command or what?

I'm going to check only the patches that have been acked and/or
reviewed (people have spent time for that), for the rest, please,
follow Krzysztof's direction, put them all together (or ask your
AI to do it) and resend.

Thanks,
Andi
