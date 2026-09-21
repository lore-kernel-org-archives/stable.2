Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282A314D1F;
	Mon, 21 Sep 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013117; cv=none; b=kJAMaksYUs43ai36AJcM1Wii9xK92qJT7RnQwmNxLSZBvzdw7Gov752sw6/RqeOPZg/EaIEoRvxZ55VSmhGZiyhVIYVC7ybCqo99C8pHKsHvkWMtqSHDrFNZf/U1HnQ9cEbik1Zcq0uAnnOQQgQCPZ0+ZUXbGbjKyg/F2u6pHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013117; c=relaxed/simple;
	bh=6tDBzR4H1xE4m2xLqsm21QLM8P8gafVuKFMP2Nop5cw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hbE2qnM+kGr09/97GjGRr2ieC/PYJO5u3ca8Ip48CGmROBNKlq8lgPWAojAA6ECB5/BGD5uizE+jiVNoZUSxQA8kcNikuH8IV2BEETudKmVRwfdU3Gb2CxiFyyUXVOQWOz2rs/fA6zrGnLoj9GW4OkwZODEAAXxDlleSJVM30Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd/qdGZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd/qdGZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CE71F000FF;
	Mon, 21 Sep 2026 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013115;
	bh=ana627ztu3RItLtifDY6xX7vGyPnvHAMGPbYSwJWVOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fd/qdGZnnN2whBp8D6u4PkgmjVICnc2XdFfieocS60nAcHo5v9EAh2LwQYNj+Nq5P
	 3+vXNuHF0UwdCz9lIbuwDf8kF9al5tkX9l0zc3E+B09HbcE4omcTARyWBOkh1iOshH
	 vYg70/WbW0t3PSt8yLhznh4dXMT7xE3KZja0yhMdk+B8JF/7dgMogAtwkg5NAGT4aQ
	 CnlQFf5xZrfnv1jVodOHOq58w1J7DHaOGVIvRY3Zdrn0y01ebdfIVib1hfcimUiVgd
	 Iio0LbvCsAtilS2E/CP//8H86HvxEWM/jAwe/UQWiidl41u5dLmq9GAHZMWXckWXZh
	 808FrB7UN8mUw==
Date: Mon, 21 Sep 2026 12:51:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] PCI: pciehp: Make poll mode parameter read-only
Message-ID: <20260921175154.GA1332331@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921142608.270312-1-runyu.xiao@seu.edu.cn>

On Mon, Sep 21, 2026 at 10:26:08PM +0800, Runyu Xiao wrote:
> pciehp_request_irq() and pciehp_free_irq() select different resources
> based on the global pciehp_poll_mode parameter. The parameter is
> currently writable through sysfs, so changing it while a controller is
> active can make teardown stop a nonexistent polling thread or call
> free_irq() for an IRQ that was not requested.
> 
> Keep the parameter available for boot and module configuration, but
> prevent runtime changes to the registration mode.
> 
> Reproducer:
> Boot an x86_64 guest in QEMU with a native PCIe hotplug root port and an
> e1000 device, using these device options:
> 
>     -device pcie-root-port,id=rp1,chassis=1,slot=1
>     -device e1000,bus=rp1
> 
> Pass pcie_ports=native pciehp.pciehp_poll_mode=1 to the guest kernel.
> As root in the guest, replace the device name below with a bound pciehp
> service device and run:
> 
>     dev=0000:00:1c.0:pcie004
>     driver=/sys/bus/pci_express/drivers/pciehp
>     echo 0 > /sys/module/pciehp/parameters/poll_mode
>     echo "$dev" > "$driver/unbind"
>     dmesg | grep 'Trying to free already-free IRQ'
> 
> The unfixed kernel accepts the runtime mode change and reports the warning
> when the service device is removed. The fixed kernel rejects the write and
> removes the device without the warning. The mode change is a deliberate
> privileged test action and is not expected during ordinary operation.
> 
> Fixes: 2aeeef119995 ("pciehp: Clean up pcie_init()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied to pci/hotplug for v7.4, thanks!

> ---
>  drivers/pci/hotplug/pciehp_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 2cafd3b26f344..5ce32dc7e178f 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -38,7 +38,7 @@ int pciehp_poll_time;
>   * not really modular, but the easiest way to keep compat with existing
>   * bootargs behaviour is to continue using module_param here.
>   */
> -module_param(pciehp_poll_mode, bool, 0644);
> +module_param(pciehp_poll_mode, bool, 0444);
>  module_param(pciehp_poll_time, int, 0644);
>  MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
>  MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
> -- 
> 2.34.1
> 
