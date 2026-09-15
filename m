Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACB45D92F;
	Tue, 15 Sep 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462337; cv=none; b=g0yXB9ad22nl99KXaZzXUmOiJm34v79O4KipKA1NDaVHa0BNnB6LyiKzl4qeAhEjvtIGWkZVdd6P9h2jIuscq9II4C00IWeBgzpSFX1SJwinkv2f/Rxuo7yIxLNjtx313ZCvckzyotZaIXg3W15FUzHyWY28ZO/XAkZoPg9uA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462337; c=relaxed/simple;
	bh=Oz8y48tsDLf+ZiCue97ledA3/2VGaTQzrLGWhDemq0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2MtvhW7PcntiPhWcpbsJgIZhQUQQnxgrIvx11qkaUJhopbRZqWSsTRXnbgAbixNlEb6rghjSlYjXWHPcQ5RliI06xWe2izssAuPKIC+YBe4CQ2d6lzcaaN9xHlM2rzKv3xfNH7BEmgMFeKiogINEsaKJdlmDAnOI5GqQtTAyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxJF3Jjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxJF3Jjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EBE1F000FF;
	Tue, 15 Sep 2026 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462335;
	bh=U0n7nIEno6Z0GGCZLyMm4HVH/1jkj8xUjjv0THWE8I8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NxJF3JjriDgfYWpvLz/hqd9KMAefOMiukKcwvouREgILyh1R8JV4pC9/QJRmpjGEk
	 mkUcMrcTewdwo1p7P5T5p3Df0SKaGsM9Lh46kUaWECiEuc9hLlBNlwnj/pJmAZH1i7
	 iPL4u03VByeWvJ1YyOVOtaahIu9M5cVcqKvoBVnvxCGAbCUhx5CUnPtaWEk8vrYZom
	 0y9w3RZ80v0CkE3GSTxULKPMEOChNa2ih7+AGGtzUpAeTgnui3nNnvVNpgx7Ie9FnA
	 fzemZKzP080tSZw6zz/uHOYDdKw8l6h6yIc/Om6OafWvXwGxccb4K2RdDDNDptPhPF
	 VpgBGX+vl1QLw==
Message-ID: <a478aaf0-5303-4cfe-a85a-3773f5cc9558@kernel.org>
Date: Tue, 15 Sep 2026 15:52:10 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] ata: libata: Do not leave ata_host_stop()
 registered when activation fails
To: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>, Jeff Garzik <jgarzik@redhat.com>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260915084127.692494-8-cassel@kernel.org>
 <20260915084127.692494-13-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260915084127.692494-13-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/15 15:41, Niklas Cassel wrote:
> ata_host_start() registers ata_host_stop() as a devres action as soon as
> it has succeeded, which hands the release of the host resources over to
> devres: ->port_stop() and ->host_stop() are then called by the driver
> core when probe() fails.
> 
> ata_host_activate() and ahci_host_activate_multi_irqs() can both fail
> after ata_host_start() has succeeded, e.g. if devm_request_irq() or
> ata_host_register() fails, and they return the error with the devres
> action still registered. A driver which releases the host resources in
> its probe() error path therefore releases them twice: once itself and
> once through ->host_stop().
> 
> All ahci-platform drivers are in that situation, e.g. ahci_probe() calls
> ahci_platform_disable_resources() while ahci_host_stop() does the same
> through devres. This gives refcount underflow warnings from the clk,
> regulator and phy cores and, for shared resources, can disable resources
> which are still in use by other devices.
> 
> Add ata_host_undo_start(), which stops the ports and drops the devres
> action without calling ->host_stop(), and call it from both activation
> helpers when they fail. Releasing the host resources on failure is then
> always left to the caller, which is what all callers having a probe()
> error path already assume.
> 
> This changes the semantics for the drivers which implement ->host_stop()
> while also completely lacking error handling for the activate host call.
> Add activate host error handling for sata_qstor and sata_fsl. For
> sata_fsl this also means that hcr_base and host_priv are now released
> when activating the host fails, which ->host_stop() did not do when
> ata_host_start() itself failed.
> 
> Note that ata_pci_sff_activate_host() is deliberately left as is: none of
> its callers releases the host resources in its probe() error path, they
> all rely on ->host_stop() being called by devres, including
> ata_pci_init_one(), which releases the devres group of the host itself.
> 
> Fixes: 1896b15eddb4 ("ahci_platform: perform platform exit in host_stop() hook")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
