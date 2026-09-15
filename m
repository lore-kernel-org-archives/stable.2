Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5D418A28;
	Tue, 15 Sep 2026 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445274; cv=none; b=RYYmmVAm09b4jyiFszYm0AtFDLNfc+Zqb2vYRKsfm44u2k0LM7cOv89MfkElhxOJrt8YyWj3Sce7yrKPndA4FAehj4j4wXjve8Io8UlM3U0nRo+ZO6yFJYSwhYAq12JbzqMJDaMm+pLR3p2DDubHZwyEwyaVopp79pzeBYq64mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445274; c=relaxed/simple;
	bh=AjrBRAPt4szZhd3i6BHq+eBZov+LNQZSwKbU1n4DQXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+YjHGxQJYn46usvqoNk3IBSC6m1qezEFkNs3MFVWz5WvQqNvP7ZLQxgicI1A29nY90Mi1mV5EApji+rJfXjkfQD4txK//4W9InFXv6DXVC/n8GK+AsB22Iu/sLxXOYOaBYP6T6T5h+gaYIT2/k+G9UXDVouK9jY1bOLl3ihGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4ySrZP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4ySrZP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0B1F000FF;
	Tue, 15 Sep 2026 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789445272;
	bh=WTAZXMBVQbTdFy1g90yzcNOhidUJU9Bb2EItIW1QGsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A4ySrZP+pLiepK3WGXOMButg8VeGb3mKO8MHi4UpHPZ+um+z4/vemAmDL8krGIcBo
	 S36Sz5/2yFuXDxjWUij08SNEilqzhLllvoTp7R8fPsWyn+hsr3AF++CPNEU0klYJwG
	 znP/ltS7bf2yqlDm+xZMKxRxEHJ7pVQh29FjRNHzbloE25O2+mqLhrV+vK1b4dNyyx
	 SfHkXZZhtpoJ/lExV7oK7ZiBtJ76au8x8MVgAMS1Je5GjeaAx1L49I68LQS069PUOY
	 uBEnqhdfDd8fmBuOXHDEqzBAXYJqDrTpAFbEzFq3iryiYemt0zAsH1rpchkwwaTPpy
	 BGNo9JgxrqY6g==
Message-ID: <b88d6534-208b-47a6-b52e-0eadd8e91d1e@kernel.org>
Date: Tue, 15 Sep 2026 11:07:47 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] ata: libahci: Free the IRQs when activating a
 multi-IRQ host fails
To: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
 Dan Williams <djbw@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-10-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260910171406.131211-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/11 0:14, Niklas Cassel wrote:
> ahci_host_activate_multi_irqs() requests one IRQ per port, but it does
> not free them when requesting one of them, or when registering the host,
> fails. The IRQs are only freed by the driver core, when it releases the
> devres of the device after probe() has returned, while the caller of
> ahci_host_activate() releases the resources of the host in its probe()
> error path, e.g. ahci_probe() disables the clocks, regulators, resets and
> PHYs of the host. An IRQ handler running in that window would access the
> MMIO of a host which is no longer clocked.
> 
> ahci_host_activate_multi_irqs() did free the IRQs until commit
> 0a142b26921c ("ahci: cleanup ahci_host_activate_multi_irqs"), which
> removed the explicit free because devm makes it unnecessary. That is true
> for freeing the IRQs as such, but not for the window described above:
> devres is only released after probe() has returned, i.e. after the error
> path of the caller has released the resources of the host.
> 
> Note that this window cannot be hit with the current users: the only user
> of AHCI_HFLAG_MULTI_MSI is the AHCI PCI driver, which does not release
> any resource in its probe() error path, and the ports of the host are
> still frozen, i.e. their interrupts are masked, when ata_host_register()
> fails.
> 
> Free the IRQs explicitly again, like ata_host_activate() does, so that
> the IRQ handlers cannot run once ahci_host_activate() has failed.
> 
> Fixes: 0a142b26921c ("ahci: cleanup ahci_host_activate_multi_irqs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
