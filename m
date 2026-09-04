Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDC4CA798;
	Fri,  4 Sep 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533137; cv=none; b=BaOpuv8wMFuFqoVserRcO6vTZDZYSPgtL6EpuFoZRH7Dv7XPOInjBAOD4Qm849DDxc2RcnHo8Lb3OHsj+fXUmqf4889Wgbx76axGwlfzlmVaX5goZzBduQSXNyp+2K8I+8gZEq2DEH3iUQgBUiGL2Iu8f4iottU6RNHFJTd1kPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533137; c=relaxed/simple;
	bh=NvE0i2xSZm320IJccxnaaRhSvCNdJoNqSwX7+TjWVpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HItYLhk0O1o/t8/gZpo0C1bdGDy1Ezs0iJjYuWgMJCQWbQOK9pjXF/KAsHYkZLPSe1mYYb4kPG71a8dDOaBTDeSIToyqWYVjMX3w7guNOAA+D/txlN1vGt3iH/pFstTlnpcgCNmEjlkudBHXXRwWSPllSqU/zb8v4EZ1oKyUhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um8FX8u8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um8FX8u8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906281F00A3F;
	Fri,  4 Sep 2026 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533135;
	bh=PrDDr8NI2FK3jDRjUsXNIjhn1kZmrYRJYnSWxsVImPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Um8FX8u8nmrAhBGtabQPp7wE6GTvVuPHHc8jGx51CsGTlu4LyxvwYMHT5OwcrM45J
	 42Cu8peJLBOFlmUpXPq+9h/13n49X0w5ldiszMxt3ds7pFtTZhEoVbEKjou3dwM3S9
	 qjWyfZXrk21fCScdAHTgNSDHXLvTwJqVJJaIeiYQG4XvJxDIf297qOMuQy23jEoyzV
	 VllHBaWrlPz9Dx64CV6ksuQgMghm91pCre+hGH8S+lfrupuXaMyVlCFgtcvnP7HU7V
	 gu/0AIhQBM0sio8xZP56gOQjqbUFgWSpH4xUKibssuxf4+rEClQRXLvKmYDz+9fIKe
	 zFQW50A5OwF+A==
Date: Fri, 4 Sep 2026 16:45:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Cc: Pali Rohar <pali@kernel.org>, stable@vger.kernel.org,
	risc4all@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: ahci: work around lost interrupts on Marvell
 88SE61xx
Message-ID: <aprZi3G9Yks1Gq9-@ryzen>
References: <20260831124303.920391-1-hajo-linux-ide@noerenberg.de>
 <178818641418.216562.3155723702033731494.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178818641418.216562.3155723702033731494.b4-ty@kernel.org>

On Mon, Aug 31, 2026 at 04:27:24PM +0200, Niklas Cassel wrote:
> On Mon, 31 Aug 2026 14:43:03 +0200, Hajo Noerenberg wrote:
> > ahci_single_level_irq_intr() services the ports first and clears the
> > global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
> > 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
> > for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
> > PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
> > looked at again, and the command in flight only ends in a timeout.
> > 
> > [...]
> 
> Applied to libata/linux.git (for-7.4), thanks!
> 
> [1/1] ata: ahci: work around lost interrupts on Marvell 88SE61xx
>       https://git.kernel.org/libata/linux/c/22f2ba34

Decided to send this for 7.3-rc2 instead:
https://lore.kernel.org/linux-ide/20260904144228.1473602-1-cassel@kernel.org/T/#u


Kind regards,
Niklas
