Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151259;
	b=GqhwBro5EhB+NrxmaTeVbDAsLSNuLdFcUVYWUX6GbeBP0k2Hd1rPVxGzqF3GqLgUX82d
	 EQigH5AAh0LY8wzoqUCMhqTVINgg8bv3UgLxXvv+tajzXuAtFXWNm6whrdA9ZmkcCJYuS
	 yxLb46jr+5Qmp1mAOZAzOdVzAw6TGBkretHIbwPeUnL5tBRuztHtxqeXynK7locjNUt8V
	 MCp1hjOAW16p+k2rmGxDOkBEx+AlWmP8ixtBRjiOL8NeaSJVwSXFKAFEubll7K2hSSXMA
	 v4lRza2QlTRWUD3sKBX38L/w40XssBKOTfULU86TDHi02SU4XMZrjNxgwqJWJLEMwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151259;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=LvfJUkmOSAdKcYHotMDiif25qiNyYOm87m7lAWGURV8=;
	b=P9RIq/DFSyvmN0yZ4yN6/G0wMsotq93jZmWFSf217nKSETuRlKfCSaQ+5rOKcg9tNVBF
	 UCEpcKgUN2xB9RlnctQFPbdseyT8mWn6cIUP6RIHKRX2TjN8Zs9xjHPJN40BHdOrUUK0C
	 SQGc+KbbB6hrUW4IXJH/cyV9aXR0vC7FrLnmNpp8+9N32/fhfdo+MzT0wXhjpOm5Lh78v
	 w+UT56lAYi7vSTo3U6anL2oiF63726PluM0T0N03HMHQol+fLUO/4fRQ2jSPHo8fAMQuc
	 GWZN5hebn/rwNQk+TeSI7ca+sezKzsLmcLdAPlXJxeB/fBcrqbD1w6mFrG/1MKDhxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=gCqKuPAw;
	arc=none smtp.remote-ip=154.81.10.51
Received: from mail-m1051.netease.com (mail-m1051.netease.com [154.81.10.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE47606A31E;
	Wed, 28 Oct 2026 01:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE47606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=gCqKuPAw
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5294a5264;
	Wed, 28 Oct 2026 09:34:05 +0800 (GMT+08:00)
Message-ID: <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
Date: Wed, 28 Oct 2026 09:34:04 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, heiko@sntech.de,
 dlemoal@kernel.org, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, iav@iav.lv
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is
 already valid
To: =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 bhelgaas@google.com
References: <20261028005603.2399220-1-ehbello@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261028005603.2399220-1-ehbello@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa180249ad703a4kunmcee67671525d6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQk1JVkNPGE8ZGEweS0JLHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gCqKuPAwk6EMrudL9B35TW7LTcNUkDJ3ZYqGcf/yvX1m64qO5Ona3Ob54YAwMki45ZDFMn56HkqYO7tBhs8TXxDhJ03uCb4MPrPEkSmjpQAQmDpTeKBlrRvobXlx5RggIQF0E5NeLuI6g5MgHC5V072ltR5zR44Afgefsf+5YTM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=LvfJUkmOSAdKcYHotMDiif25qiNyYOm87m7lAWGURV8=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/28 星期三 8:56, Enrique Hernández Bello 写道:
> Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
> rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
> behind an rk3399 root port is almost never enumerated: the link trains
> normally, but the endpoint's configuration space never answers. On this
> controller a configuration read that gets no usable completion is
> reported as an external abort rather than as an all-ones response, so
> the machine does not merely miss a device -- it dies with an
> asynchronous SError inside rockchip_pcie_rd_conf().
> 
> That change added an unconditional msleep(PCIE_T_PVPERL_MS) to
> rockchip_pcie_host_init_port(). PERST# is asserted much earlier, when
> the line is acquired with GPIOD_OUT_LOW in rockchip_pcie_parse_dt(), so
> the sleep lands inside the assertion and widens it. Measuring the pulse
> in the driver with a ktime delta across the two gpiod_set_value() calls
> gives 1 ms without the sleep and 108 ms with it; msleep(100) rounds up
> to roughly 107 ms. This endpoint does not recover from a reset that
> long.

Intuitively, one would expect that a short reset period prevents the
endpoint from recovering fully, that seems more plausible than the
opposite. A reset pulse that is too short may cause the device to be
enumerated before it has completely reset. As long as the reset is
clean, a longer reset wait should make the device work more reliably.

Therefore, the actual observation that a longer reset causes failure
is highly counterintuitive. Droping this wait for

> 
> To separate the two things that sleep changes -- how long PERST# is held
> low, and how long the supplies have been valid when it is released --
> both delays were made runtime-adjustable on a single kernel, one before
> the assertion and one after it, and the host driver was rebound to
> re-run the whole probe:
> 
>    before assert   after assert   pulse       trials   enumerated
>    0 ms            0 ms            1-11 ms         5        5
>    0 ms           10 ms           ~18 ms           3        3
>    0 ms           15 ms           24-47 ms         4        4
>    0 ms           20 ms           ~28 ms           3        1
>    0 ms          100 ms          ~108 ms           4        0
>    200 ms          0 ms            6-11 ms         5        5
>    200 ms        100 ms          ~108 ms           1        0
> 
> Delaying the assertion by 200 ms changes nothing, whether the pulse is
> short (5 of 5 either way) or long (0 of 4 and 0 of 1); widening the
> pulse is what decides the outcome. vcc3v3_pcie on this board is
> regulator-always-on and regulator-boot-on, so in every row above --
> the failing ones included -- the supplies have been valid for seconds
> by the time the driver probes, and Tpvperl is met whether the wait runs
> or not. It therefore cannot be what distinguishes them. What this
> endpoint reacts to is the width of the PERST# pulse.
> 
> The wait and a short pulse cannot both be had in general: Tpvperl is
> counted from the supplies becoming valid to PERST# being de-asserted
> (PCIe CEM r5.1, sec. 2.9.2), so on a board that powers the slot at
> probe time the assertion does have to last that long. Where the
> supplies are already up, though, the requirement is met before PERST#
> is ever asserted, and the sleep only widens the pulse.
> 
> So record whether the supplies were already enabled before the driver
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
> conservative than what this driver did for years: until the change
> cited above there was no Tpvperl wait at all, and PERST# stayed
> asserted only for as long as the register writes in between took.
> 
> Boot-level counts on the same board agree with the table: unmodified,
> the endpoint enumerated on 0 of 84 boots; with this patch, 3 of 3; with
> other ways of dropping the same wait, 16 of 16. Each of the three
> PERST#-related changes that landed together in v6.11-rc1 was also
> reverted individually, and only removing this wait made a difference.
> Moving the wait later but still inside the assertion did not help
> (0 of 15 boots), which is consistent with the width being what matters.
> 
> The measurements were taken on 6.18, but the code in question is
> unchanged between v6.11 and v7.2.
> 
> Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
> ---
> v3:
>   - Rewrite the commit message. It now leads with the width of the PERST#
>     pulse, which is what the endpoint reacts to, and demotes the Tpvperl
>     redundancy to the reason the wait can safely be skipped rather than
>     the explanation of the failure. Manivannan was right that those are
>     two different claims and that only the first one was evidenced.
>   - Add the A/B measurement that was missing: one kernel with the delay
>     before and after the PERST# assertion independently adjustable, so
>     pulse width and power-valid time can be varied separately on the
>     same binary. Also note that this board's PCIe supply is always-on,
>     so Tpvperl is met in the failing configurations too.
>   - Note in the comment that the regulator_enable() calls are kept for the
>     reference count and are independent of the Tpvperl question, so the next
>     reader does not have to ask it.
>   - No functional change from v2.
> 
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
> v2: https://lore.kernel.org/all/20260911211559.207990-1-ehbello@gmail.com/
> 
> diff --git i/drivers/pci/controller/pcie-rockchip-host.c w/drivers/pci/controller/pcie-rockchip-host.c
> index d203c48..495428b 100644
> --- i/drivers/pci/controller/pcie-rockchip-host.c
> +++ w/drivers/pci/controller/pcie-rockchip-host.c
> @@ -314,7 +314,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
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
> @@ -609,11 +611,39 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
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
> + *
> + * This does not change who owns the supplies: the regulator_enable() calls
> + * below stay, both so that regulator_late_cleanup() cannot switch off a rail
> + * that the bootloader merely left on and so that the regulator_disable() calls
> + * on suspend and in the probe error paths stay balanced. Whether a supply was
> + * already on says only whether Tpvperl has elapsed.
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


The assumptions here rely on a very weak constraint. If some designs
don't define the 12V and 3.3V regulators in the device tree, but those
rails actually do power down along with the rest of the system during
suspend, then upon resume the reset wait will be skipped entirely. I'm
worried this could cause regressions.

Furthermore, even with the same power supply design, different endpoints
may behave differently. What if a particular device requires a longer
reset pulse to work reliably? How would we handle that?

>   static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
>   {
>   	struct device *dev = rockchip->dev;
>   	int err;
>   
> +	rockchip->supplies_pre_enabled =
> +		rockchip_pcie_supplies_enabled(rockchip);
> +
>   	if (!IS_ERR(rockchip->vpcie12v)) {
>   		err = regulator_enable(rockchip->vpcie12v);
>   		if (err) {
> @@ -890,6 +920,13 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
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
> diff --git i/drivers/pci/controller/pcie-rockchip.h w/drivers/pci/controller/pcie-rockchip.h
> index 3e82a69..e63259a 100644
> --- i/drivers/pci/controller/pcie-rockchip.h
> +++ w/drivers/pci/controller/pcie-rockchip.h
> @@ -318,6 +318,7 @@ struct rockchip_pcie {
>   	struct	regulator *vpcie1v8; /* 1.8V power supply */
>   	struct	regulator *vpcie0v9; /* 0.9V power supply */
>   	struct	gpio_desc *perst_gpio;
> +	bool	supplies_pre_enabled;
>   	u32	lanes;
>   	u8      lanes_map;
>   	int	link_gen;
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

