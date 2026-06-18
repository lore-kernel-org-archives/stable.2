Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F823EC2F7;
	Thu, 18 Jun 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779242; cv=none; b=n2W4ZXg/wTvqq7IjfMdw/HThI6BBp0aWRW12SKP7Lj+gsMtvj5S+Zzm4xSSIgaB5Ct/dsDlhGA6MbMhnZqBw+xOwEEsR0C1FoHZAVrIPQpgMiXvX8ZGoyIim5nbu0vpdTZCEZdZnwVFl37uoVieDOu0Uq+tKqQBendXICQEcsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779242; c=relaxed/simple;
	bh=I/1Wphc6q+b/5edUFM0ylFG5o1QAflgrZqXs0KE4rlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVjN5bWAUsP1qr5yjLRCo1ngrK0BsNdPHjTYWkEG1ar5Au7hXIJzefJ0Sfx+rNQNObLwp7KzMxcYKoM7hHMz6PPyZpTZ1681kGe9w6sldZ6+LDf1hmaJofeb2/x67CtWYyGS9OepfY+NUJSyUNR9REgXDF3qEWOLGMDoJ6tQyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua7XR6Bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua7XR6Bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34241F000E9;
	Thu, 18 Jun 2026 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781779234;
	bh=jq3BBrQkMxQMDe15lRxvO9yvg0JIM31vsM45qxbY3JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ua7XR6BlPPL0b11eG3YzT185HFMPQaW4nnDULBShc8DRBCgO23A3NtMZx4d1ollrC
	 oErKmxtpnmzN4p3pa4mbzBnbLSenZHdvn2sWdkfv3UupaVq8asg6CIOAZNLEvcSKLZ
	 1GsDSFUVWcmiYs4/C6btVP3jZZAKFaSBkwYgngZfB8keyW7SE3f813SvgaKtIU4hmx
	 mT+qzRzZqZLxUFBcWLStJ+PBi64+uQR/xeggd68h0WjmyvokskKpeDiw7WiCXuZ43J
	 utToWD1aX/BoOGuxWPrsKYiZbOl9OwOxPJ1HF9xiD8IqEc9duvi2FhiMdr2P8gKnVp
	 97AHC0R9W5u5g==
Date: Thu, 18 Jun 2026 11:40:30 +0100
From: Lee Jones <lee@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jpanis@baylibre.com, bhargav.r@ltts.com, mwalle@kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6594: copy regmap IRQ chip descriptors per probe
Message-ID: <20260618104030.GC1672911@google.com>
References: <20260611145632.2219430-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611145632.2219430-1-runyu.xiao@seu.edu.cn>

On Thu, 11 Jun 2026, Runyu Xiao wrote:

> tps6594_device_init() selects one of several shared static
> struct regmap_irq_chip templates and then writes the current probe's
> irq_drv_data and generated name into that shared descriptor before
> passing it to devm_regmap_add_irq_chip().
> 
> On a running system this is reachable whenever another TPS6594,
> TPS65224, or TPS652G1 instance probes through the same descriptor
> family. regmap-irq keeps the raw chip pointer, so the later probe
> overwrites the earlier instance's callback context. A later IRQ can
> then run tps6594_handle_post_irq() with the wrong struct tps6594,
> name, chip_id, regmap, and CRC handling path.
> 
> The issue was found on Linux v6.18.21 during manual auditing of drivers
> that reuse shared regmap_irq_chip descriptors while filling probe-local
> irq_drv_data and name fields before devm_regmap_add_irq_chip(), and was
> confirmed with a focused QEMU no-device validation harness. That test
> showed a later probe could overwrite the earlier registration's saved
> callback context through the shared chip descriptor, while per-probe
> descriptor copies preserved callback ownership for both registrations.
> 
> Copy the selected descriptor with devm_kmemdup(), mutate only the
> copy, and pass that copy to devm_regmap_add_irq_chip(). Also mark the
> static descriptors const so probe-local state cannot be written back
> into shared templates again.
> 
> Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
> Fixes: 9d855b8144e6 ("mfd: tps6594-core: Add TI TPS65224 PMIC core")
> Fixes: 626bb0a45584 ("mfd: tps6594: Add TI TPS652G1 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/mfd/tps6594-core.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git "a/drivers/mfd/tps6594-core.c" "b/drivers/mfd/tps6594-core.c"
> index 8b26c4127472..36904979b6b0 100644
> --- "a/drivers/mfd/tps6594-core.c"
> +++ "b/drivers/mfd/tps6594-core.c"
> @@ -531,7 +531,7 @@ static int tps6594_handle_post_irq(void *irq_drv_data)
>  	return ret;
>  };
>  
> -static struct regmap_irq_chip tps6594_irq_chip = {
> +static const struct regmap_irq_chip tps6594_irq_chip = {
>  	.ack_base = TPS6594_REG_INT_BUCK1_2,
>  	.ack_invert = 1,
>  	.clear_ack = 1,
> @@ -543,7 +543,7 @@ static struct regmap_irq_chip tps6594_irq_chip = {
>  	.handle_post_irq = tps6594_handle_post_irq,
>  };
>  
> -static struct regmap_irq_chip tps65224_irq_chip = {
> +static const struct regmap_irq_chip tps65224_irq_chip = {
>  	.ack_base = TPS6594_REG_INT_BUCK,
>  	.ack_invert = 1,
>  	.clear_ack = 1,
> @@ -555,7 +555,7 @@ static struct regmap_irq_chip tps65224_irq_chip = {
>  	.handle_post_irq = tps6594_handle_post_irq,
>  };
>  
> -static struct regmap_irq_chip tps652g1_irq_chip = {
> +static const struct regmap_irq_chip tps652g1_irq_chip = {
>  	.ack_base = TPS6594_REG_INT_BUCK,
>  	.ack_invert = 1,
>  	.clear_ack = 1,
> @@ -707,7 +707,10 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
>  {
>  	struct device *dev = tps->dev;
>  	int ret;
> -	struct regmap_irq_chip *irq_chip;
> +	const struct regmap_irq_chip *irq_chip;
> +	struct regmap_irq_chip irq_chip_copy;
> +	const char *irq_chip_name;
> +	void *irq_chip_desc;

Putting irq_chip_copy on the stack and using void* here is pretty rough.

How about declaring a typed 'struct regmap_irq_chip *chip' pointer
instead would keep things cleaner.

>  	unsigned int pwr_on, gpio3_cfg;
>  	const struct mfd_cell *cells;
>  	int n_cells;
> @@ -738,15 +741,22 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
>  		cells = tps6594_common_cells;
>  	}
>  
> -	irq_chip->irq_drv_data = tps;
> -	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
> -					dev->driver->name, tps->chip_id, tps->reg);
> +	irq_chip_name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
> +				       dev->driver->name, tps->chip_id, tps->reg);
> +	if (!irq_chip_name)
> +		return -ENOMEM;
> +
> +	irq_chip_copy = *irq_chip;
> +	irq_chip_copy.irq_drv_data = tps;
> +	irq_chip_copy.name = irq_chip_name;
>  
> -	if (!irq_chip->name)
> +	irq_chip_desc = devm_kmemdup(dev, &irq_chip_copy, sizeof(irq_chip_copy),
> +				     GFP_KERNEL);

Then we can perform the 'devm_kmemdup()' call first using the template
pointer and modify the heap-allocated structure directly. 

How about:

chip = devm_kmemdup(dev, irq_chip, sizeof(*chip), GFP_KERNEL);
if (!chip)
	return -ENOMEM;

chip->irq_drv_data = tps;
chip->name = irq_chip_name;

> +	if (!irq_chip_desc)
>  		return -ENOMEM;
>  
>  	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
> -				       0, irq_chip, &tps->irq_data);
> +				       0, irq_chip_desc, &tps->irq_data);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to add regmap IRQ\n");
>  
> -- 
> 2.34.1

-- 
Lee Jones
