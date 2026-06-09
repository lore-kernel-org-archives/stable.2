Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6E3EDACB;
	Tue,  9 Jun 2026 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992973; cv=none; b=UPRSmxTQLFBmlj2pGqW6ieymlsoRoW0CKz7a+e7vJg0DYEk8b9fK+HNBmqxYdiERNTVYC0ohQRkqSneVusRqGGSUSjJmgHzHMYkP/IMdI/K23uoV42z4dauERL/twR/Eyge793UrAs89olbY7oT1c9bPxrfthg7b7O4R2h0apCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992973; c=relaxed/simple;
	bh=qmLAknJDi9ljkQLvRZ4VV6nTEnsTGPu0rWLa0vqgDJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op6suroC8QJiGWjutGjoR3bSq2zEAh+vxHf3fFefvefOdc3wPGs+FqssOC3AV3iXQBUIZAJ//u7s02fqj9pVjdyn9Ufun53hinJLKi0B/MSdaVlUzG6QT7viyKzQP/BCKxA/gE7TegRs7NzL6Nu3qz7801yGe0RJzCodjLWn658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOGtJdAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOGtJdAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B8F1F00893;
	Tue,  9 Jun 2026 08:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780992971;
	bh=Pwx2gnjzoEu6wS23A8/5F0BeRt4mUzsviwvSFFA+naA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dOGtJdAFu05vzTyBNYkhG2GJPMKtw828JD36nf94w2GGCiM54FlLj92vY85ZhQWzP
	 IBGz6JOH74vtZ5Uuso2BrhmwZMZBhG0qbsFR7kdOII1mkcOL0OHzckvaCzqUsfx3MU
	 1K0MugCOw9vD3D41NUdcQzPB3LU2qxGV0VQh4dxHfVyEXl7+Qu+em9GBxjDK840RTl
	 Qk60eJI2nutYACIIyKpPbTI9yZVdz48EjF+KASGrJej24cnDZixytf2UFE5K9DSiMy
	 77OAeX0T+sg7/7+3Hh5LX+9Z2/wQSCQF0zjq+up8njry9PhtLfx1eXqs6widOSyHM2
	 znZiNvsg7kVyg==
Date: Tue, 9 Jun 2026 10:16:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: aisheng.dong@nxp.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: imx-lpi2c: fix resource leaks switching to
 devm_dma_request_chan()
Message-ID: <aifLtWlPdLr7EEnj@zenone.zhora.eu>
References: <20260520093323.2882070-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520093323.2882070-1-carlos.song@oss.nxp.com>

Hi Carlos,

On Wed, May 20, 2026 at 05:33:23PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> The LPI2C driver requests DMA channels using dma_request_chan(), but
> never releases them in lpi2c_imx_remove(), resulting in DMA channel
> leaks every time the driver is unloaded.
> 
> Additionally, when lpi2c_dma_init() successfully requests the TX DMA
> channel but fails to request the RX DMA channel, the probe falls back
> to PIO mode and completes successfully. Since probe succeeds, the devres
> framework will not trigger any cleanup, leaving the TX DMA channel and
> the memory allocated for the dma structure held for the lifetime of the
> device even though DMA is never used.
> 
> Switch to devm_dma_request_chan() to let the device core manage DMA
> channel lifetime automatically. Wrap all allocations within a devres
> group so that devres_release_group() can release all partially acquired
> resources when DMA init fails and probe continues in PIO mode.
> 
> Fixes: a09c8b3f9047 ("i2c: imx-lpi2c: add eDMA mode support for LPI2C")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
