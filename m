Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871571;
	b=1WtCcG5Feocr1zgwJWBNdWbSs6B5Y2IYYysWeSSZp15s3JhsOjvsCKvMgAufhCDttGxF
	 hCS/gBU2uJ3RqLHLscuyuzRXyHhTw5f9gViwXOlTKIcV9q1/Aqrubea7KWWrOVs/py2Ww
	 odV9t174bhJbc/EIQdtWQb5KHxz1K5j8VVJhzU2tZhqE/8G4KOHNgqvJVcdDjxGigTbeY
	 JLgG7Lf66zKmE0YL4spIytI7PbMcgdwOrDXaijnYfrEsEn4rMQvbfnjBHIMr/ufYF32XP
	 ZO/2hv+KUXSrsf3JGpC9lq0YqleAHM0D/2wYAjebGBjrnXmLsNjEoY5QzmfA+qZMpXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871571;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tvox01c/LdtBVnbijieWNltU+WV/o1xordbJtEhjTKQ=;
	b=uN75IHcd1TAdOS89a23HH1HYU6JLf1cgH91kTUIXSGOR5fMBd+tVXo+qKvhe9ChG0V3c
	 6iTikE29m6/vzeUrMfPqcNT5yruDaQitFdXPI9vfpKkf419Bnw85whXqLWOmbo3qyST/R
	 PJl4TooaH4PJG6GxMCbpoc9drcVoOgNNiMAluYfbXn+k17fnp8GD80gxShbHH1PdUqwqy
	 TUhfcjtgOd9BHix5BPX0uWOfvInL5XnKqAM92evx3w+OmweXuaJJHVmoBZhV4TXhcq6zM
	 izDbMYBDSx8FHfxsVIEHrA7Fc6InRjXlDa/tngjUDLGJUnH56LAQGe3t0lI9nfqYpWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cQBVG3Ux;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4E606A32D;
	Thu,  5 Nov 2026 09:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D4E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cQBVG3Ux
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341C319F6;
	Thu,  5 Nov 2026 01:39:26 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B15363F628;
	Thu,  5 Nov 2026 01:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793871569; bh=jLw5x/FRptMVvMRjQnGefDSs408NvBXTJ8hj0KuIrAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cQBVG3UxH6xAs18O2apuMOrY9rPW8MkbyKg874xfoia2zPmzC0dS+S9O76+BnGm1/
	 K+5CnP3u9SRoE3WB1kb8dWR2aolZAoO8+kctuUuLRrRWCaFu38nviCqJ36+TVTXQuE
	 Kapu0jldllBYIlNs7XXD6BpQEVwZB/Fb0VSERY0s=
Message-ID: <e7cd2bf6-f9db-4a90-b11a-665f8219f7ce@arm.com>
Date: Thu, 5 Nov 2026 10:39:26 +0100
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
Subject: Re: [PATCH 01/10] pinctrl: sunxi: Fix out-of-bounds irq_bank index
 when first bank has no IRQs
To: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-2-lee@kernel.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261103213002.1673560-2-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lee,

On 11/3/26 22:29, Lee Jones wrote:
> In prepare_function_table(), irq_bank and last_bank are initialised to 0
> and last_bank is updated on every bank regardless of whether it supports
> interrupts.  On SoCs where bank 0 (PA) has no pins or does not support
> interrupts (such as Allwinner A523 and A733), the first IRQ-capable bank
> has bank > 0, which causes irq_bank to be incremented to 1 instead of
> starting at 0.  As a result, the final IRQ bank receives irq_bank equal
> to desc->irq_banks and writes out-of-bounds past pctl->irq_array during
> sunxi_pinctrl_build_state().
> 
> Initialise irq_bank and last_bank to -1 and only update last_bank when
> processing an IRQ-capable bank so that irq_bank always starts at 0 and
> increments sequentially across IRQ-capable banks.

Can we please hold back this patch for now? There are more issues around 
the IRQ bank usage on recent Allwinner SoCs, patches for which [1] are 
on the list. They should solve the out-of-bounds access, I think, though 
we might want to add explicit checks, maybe.

But taking just this patch here would torpedo the efforts in fixing the 
correctness issues that we see.

Cheers,
Andre

[1]
https://lore.kernel.org/linux-gpio/20261025142412.112216-1-pmazzini@gmail.com/

> 
> Fixes: f5e2cd34b12f ("pinctrl: sunxi: allow reading mux values from DT")
> Closes: https://sashiko.dev/#/bug/linux-9c4dd832-02d4-4096-9e91-a03c1d4d85b3
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
> index 8bcd566593ae..79ca1a7c4837 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
> @@ -208,8 +208,8 @@ static int prepare_function_table(struct device *dev, struct device_node *pnode,
>   	 * Assign the function's memory and fill in GPIOs, IRQ and a sentinel.
>   	 * The extra functions will be filled in later.
>   	 */
> -	irq_bank = 0;
> -	last_bank = 0;
> +	irq_bank = -1;
> +	last_bank = -1;
>   	for (i = 0; i < npins; i++) {
>   		struct sunxi_desc_pin *pin = &pins[i];
>   		int bank = (pin->pin.number - pin_base) / PINS_PER_BANK;
> @@ -222,17 +222,16 @@ static int prepare_function_table(struct device *dev, struct device_node *pnode,
>   		func[1].muxval = 1;
>   
>   		if (irq_mux) {
> -			if (bank > last_bank)
> +			if (bank > last_bank) {
>   				irq_bank++;
> +				last_bank = bank;
> +			}
>   			func[lastfunc].muxval = irq_mux;
>   			func[lastfunc].irqbank = irq_bank;
>   			func[lastfunc].irqnum = pin->pin.number % PINS_PER_BANK;
>   			func[lastfunc].name = "irq";
>   		}
>   
> -		if (bank > last_bank)
> -			last_bank = bank;
> -
>   		pin->functions = func;
>   
>   		/* Skip over the other needed functions and the sentinel. */

