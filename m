Received: from mail-m9373.xmail.ntesmail.com (mail-m9373.xmail.ntesmail.com [103.126.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E34BEE51;
	Sat, 12 Sep 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176078; cv=none; b=oQc4aR2LfIhEgLN7RUWPVueDXNykqcqs1VAYCs1dB7YyL4jMfW/LRUqRIDRJI/c8BwdZR7sVYB9VkgahtR2oNxn8DYfloV4flDbnOOYvE97RIZY9wKGyEwIqwyxkJ/J/5XaqNw6i6RH0dvNcopWIwAt2VNwV6IMc9x4jX9+huIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176078; c=relaxed/simple;
	bh=oTCwzBZ3Uw+xUer9WiCbSmkm6bYKXnJjisJ6oK0Fmbs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IiRvwV/XtvyOCTAQwhjGZfbOM+RkoXCUexrRlpx3bpXZLYwVFl+ZkiNLs/imcdTTTLpMbaphnHI+y16ed4kGp725XsetksHWzWz2u/VJywbeDgdI7UMZgqUM+4qeCRDgxVUlNxtDPVqax+zJAV+ObOav+GBvC2HAEStwWz8oiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cxf08jnl; arc=none smtp.client-ip=103.126.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cxf08jnl"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d7dade84;
	Sat, 12 Sep 2026 09:21:03 +0800 (GMT+08:00)
Message-ID: <577c2a79-25f9-409d-be46-275821e3a2f7@rock-chips.com>
Date: Sat, 12 Sep 2026 09:21:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, heiko@sntech.de,
 dlemoal@kernel.org, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, mani@kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is
 already valid
To: =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
References: <20260911211559.207990-1-ehbello@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260911211559.207990-1-ehbello@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0933423fc03a4kunm40c32d25659aad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0xKTFYYGUlDGU8aHk
	9PGEpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUJCSU5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=cxf08jnlyk6piigolkqCttl0YSj1g+2QbmF0qfW48jixSdNXBS62RrdYfpyeCe4ykg6faZFb5n3tENxhSudVN+Dhw1HlUUlL8evUWbYcja4hDbROnVo6+pNHZL82UCkMN79QJ9F2cFOLT/jyGDVtItkX/YetjYejI3fJze03Y2k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8/QG9JqLLnNaub/oqU9gkVaGaxueCMPbNMwP2fsCHcY=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/12 星期六 5:15, Enrique Hernández Bello 写道:
> Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
> rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
> behind an rk3399 root port almost never becomes usable: the link trains
> normally, but the endpoint's configuration space never answers, so the
> device is not enumerated. On this controller a configuration read that
> gets no usable completion is reported as an external abort rather than
> as an all-ones response, which on arm64 brings the machine down.
> 
> The change added an unconditional 100 ms sleep so that PERST# stays
> asserted for at least Tpvperl after power becomes valid. The wait is
> performed while PERST# is asserted, so it also extends the reset by
> 100 ms, and this endpoint does not tolerate the longer assertion.
> 
> Tpvperl is counted from the supplies becoming valid (PCIe CEM r5.1,
> sec 2.9.2). On boards whose PCIe supplies are always-on -- vcc3v3_pcie
> on ROCK Pi 4 is regulator-always-on and regulator-boot-on -- power has
> been valid since boot, seconds before the driver probes, so the
> requirement is already met and the sleep only lengthens the reset.
> 
> Record whether the supplies were already enabled before the driver
> enabled them, and skip the wait in that case. A supply that is already
> on at probe was brought up either by the bootloader or by the regulator
> core at boot, both of which precede a PCIe probe by far more than
> Tpvperl. When the driver really does bring the rails up the full wait
> still happens, as it does if regulator_is_enabled() cannot tell.
> 
> The same check is repeated on resume rather than assuming that power
> was cycled: suspend calls regulator_disable() on the 0.9V supply, which
> only drops a reference, so on a board where that rail is always-on or
> shared with another consumer the power stays valid across the cycle.
> 
> Skipping the wait only when every supply is already on is strictly more
> conservative than what this driver did for years: until the change cited
> above there was no Tpvperl wait at all, and PERST# stayed asserted only
> for as long as the register writes in between took.
> 
> Measured on a ROCK Pi 4C with a Radxa Penta SATA HAT (JMB585) by
> booting repeatedly and counting how often the endpoint enumerated:
> 
>    unmodified ....................................  0 out of 84 boots
>    with this patch ...............................  3 out of 3 boots
>    other ways of dropping the same wait ..........  16 out of 16 boots
> 
> Fisher's exact test, pooling the last two rows against the first, gives
> p = 4.1e-21. With the patch the endpoint enumerated on every boot and all
> four disks behind it came up.
> 
> Each of the three PERST#-related changes that landed together in
> v6.11-rc1 was also reverted individually; only removing this wait made
> any difference. Moving the wait to before link training is enabled,
> rather than removing it, did not help (0 out of 15 boots), which is
> what identified the length of the PERST# assertion rather than any
> interaction with link training as the cause.
> 
> The measurements were taken on 6.18, but the code in question is
> unchanged between v6.11 and v7.2.
> 
> Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
> ---
> ---
> v2:
>   - Re-evaluate the supplies in rockchip_pcie_resume_noirq() instead of
>     assuming that the 0.9V rail was really turned off. On a board where
>     that rail is always-on or shared, regulator_disable() leaves it on,
>     and forcing the wait there would reintroduce on resume exactly the
>     failure this patch fixes. Spotted by an automated review of v1.
>   - Factor the test into rockchip_pcie_supplies_enabled() now that it
>     has two callers.
> 
> v1: https://lore.kernel.org/all/20260911104952.4190994-1-ehbello@gmail.com/
> 
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -318,6 +318,7 @@
>   	struct	regulator *vpcie1v8; /* 1.8V power supply */
>   	struct	regulator *vpcie0v9; /* 0.9V power supply */
>   	struct	gpio_desc *perst_gpio;
> +	bool	supplies_pre_enabled;
>   	u32	lanes;
>   	u8      lanes_map;
>   	int	link_gen;
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -314,7 +314,9 @@
>   	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>   			    PCIE_CLIENT_CONFIG);
>   
> -	msleep(PCIE_T_PVPERL_MS);
> +	if (!rockchip->supplies_pre_enabled)
> +		msleep(PCIE_T_PVPERL_MS);
> +
>   	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
>   
>   	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> @@ -609,11 +611,33 @@
>   	return 0;
>   }
>   
> +/*
> + * Tpvperl is counted from the supplies becoming valid, and the driver waits
> + * for it with PERST# asserted, so the wait also lengthens the reset pulse.
> + * Supplies that are already enabled before this driver enables them were
> + * brought up by the bootloader or by the regulator core at boot, both of
> + * which precede this point by far more than Tpvperl, so the requirement is
> + * already met. Treat an error from regulator_is_enabled() as "not known to
> + * be on" so that the caller waits.
> + */
> +static bool rockchip_pcie_supplies_enabled(struct rockchip_pcie *rockchip)
> +{
> +	return (IS_ERR(rockchip->vpcie12v) ||
> +		regulator_is_enabled(rockchip->vpcie12v) > 0) &&
> +	       (IS_ERR(rockchip->vpcie3v3) ||
> +		regulator_is_enabled(rockchip->vpcie3v3) > 0) &&
> +	       regulator_is_enabled(rockchip->vpcie1v8) > 0 &&
> +	       regulator_is_enabled(rockchip->vpcie0v9) > 0;
> +}
> +
>   static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
>   {
>   	struct device *dev = rockchip->dev;
>   	int err;
>   
> +	rockchip->supplies_pre_enabled =
> +		rockchip_pcie_supplies_enabled(rockchip);
> +

If it's pre-enabled, should we still need to enable this regulator just
for adding a refcount for it?

>   	if (!IS_ERR(rockchip->vpcie12v)) {
>   		err = regulator_enable(rockchip->vpcie12v);
>   		if (err) {
> @@ -890,6 +914,13 @@
>   	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>   	int err;
>   
> +	/*
> +	 * Suspend calls regulator_disable() on the 0.9V supply, but on boards
> +	 * where it is always-on or shared the rail does not actually drop, so
> +	 * re-evaluate instead of assuming that power was cycled.
> +	 */
> +	rockchip->supplies_pre_enabled = rockchip_pcie_supplies_enabled(rockchip);
> +
>   	err = regulator_enable(rockchip->vpcie0v9);
>   	if (err) {
>   		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> 
> 

