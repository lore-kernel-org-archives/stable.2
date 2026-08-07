Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E82C031E;
	Fri,  7 Aug 2026 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110409; cv=none; b=iIUwmYEVDR1rx9kyvioud5+vYsAQOE4SfenTOBRKKFo/tWrfkOLNab1FMhAcQCEeYo5d2YSpYDMnUBEGDMxGuq9QTsXR5xS0jE4dm0dyavmAZcMPy9RpbCgI9gF+4k20XDsg6eljl2wJZxUms9ZIWitBjtQQtf/117wCnuzRGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110409; c=relaxed/simple;
	bh=cmqYBlnct7r1eSvl3keP4l1RODPew0sPkcfPKeIwyw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPTQbq2QiTqHvA+mKtG/CD1QcdZZqU90YchcPBIm3k/pP5jPJivc2uHBgGaWn6ccxNdmhh9RnEpn6iI+yEDDM9bWTiXfiKfZ87uoluDQXUgO/mglhFp9NK45Mnls9j2I47FvixmFWA1+AXVUptASFUlWLDErtLbXAWEl+bLw1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4NZxl55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4NZxl55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E465D1F000E9;
	Fri,  7 Aug 2026 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786110402;
	bh=mr2oycUYSpgdrZRRCb02qrSx4UWRahk0vdIrX+0vKxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q4NZxl55Osgx09mPim3swuRsEV5oVH+tKtv/EKF7bGOXmaQZGWvGoBHfvzyC9x5aZ
	 K3wVtubrtJ3v7a1RfFKtMCyswe7VlXs1jvqf1bK321t4gBK92dHqX8HUpbM6N059rY
	 DmjyJwkRx2xNn3pbEVlLJBjmQtjrUBPcbqjWXhEw=
Date: Fri, 7 Aug 2026 15:46:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	Pascal EBERHARD <pascal.eberhard@se.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/2] spi: cadence-quadspi: fix probe error path
 and remove
Message-ID: <2026080717-payday-closable-07be@gregkh>
References: <20260807-cqspi-pm_runtime-v1-0-5973a0a208c4@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-cqspi-pm_runtime-v1-0-5973a0a208c4@bootlin.com>

On Fri, Aug 07, 2026 at 01:49:19PM +0200, Diogo Ivo (Schneider Electric) wrote:
> This series fixes two resource leaks in the cadence-quadspi driver's
> probe error path and remove callback.
> 
> Patch 1 fixes an imbalanced pm_runtime_enable()/pm_runtime_disable()
> pair: when probe defers after cqspi_request_mmap_dma(),
> pm_runtime_disable() is called without a prior pm_runtime_enable().
> It also adds the missing pm_runtime_dont_use_autosuspend() in both
> the probe error path and the remove callback and a missing
> pm_runtime_put_noidle() in the probe error path. This consolidates
> fixes from upstream commits 5ff4d5d1af0c and 5e8bb0cc72f1.
> 
> Patch 2 fixes a DMA channel leak: when spi_register_controller() fails,
> the channel acquired via cqspi_request_mmap_dma() is never released.
> A dedicated error label is added to release it before the runtime PM
> teardown. This fix is one part of upstream commit f18c8cfa4f1a.
> 
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
> ---
> Diogo Ivo (Schneider Electric) (2):
>       spi: cadence-quadspi: fix runtime pm cleanup on probe failure/unbind
>       spi: cadence-quadspi: release DMA channel on probe failure
> 
>  drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> ---
> base-commit: 7351870f56cba79097a2ab57e609469719ea4f73
> change-id: 20260730-cqspi-pm_runtime-a8a1c6122944
> 
> Best regards,
> --  
> Diogo Ivo <diogo.ivo@bootlin.com>
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
