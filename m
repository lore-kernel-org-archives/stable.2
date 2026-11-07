Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062341;
	b=UDcItigkt4X73gE1ZRolrHR2KhH/E1rypMAASOdgP1QwDbcF5GJUm9isYst9tRNEK+fB
	 Kw1S07lLLNKfR22BzkHbYgryXs9V734sENRapca820h18aOqZN4mFuYIKwXsYp7B/BxVJ
	 BjGOo9+L62Xi6gcLxLsKcJz+vQ+WLDC3QzxA0Yu0SV2Szfm8FANDu4yr5if/sswNB37qV
	 yPt/IZ+WJpl2Z1Id4ssrZl8EOi4BlFM50LCEeBjwQQU+PwCsdrAjQJi7m4b79JGPvRhHe
	 UeymtOKzWbc75siq/0+9O2+/6c4UIDHrMBm+O3cXXxGvrfBE7VXc3uWkPZUIKtJ6QVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062341;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=NQCqFf/qR4D83VPEtwWEx/gZFVt7qS+g1ysVABuUlco=;
	b=N1xhzBdavHnZdhyGkTktleDF0Y09pWWaUDU09MlxAHluBWdvl/a+9FW7VDpbHmXZOraO
	 MjhtNxOE/4oh1S12xcQIAB2F4386dns+GlryXBPXv6q4tonVSbh5YgcxOWc5vggcpMj7H
	 CdbWVKMyd54L4f746xUnoOpxmlF1L+pziqvxZ5+8SlDOL7+5GmMm/Q5TnS+KJOcgZWgFr
	 4rxFuX6J7ft/62f2H2sX0dhLSU9Qxx2edDYe2hu4O6yoDpCHDfqf5owaekhPFeRdVB6NY
	 UQo+dBAgNTFrQ/t8IN4RC6Mann5CaXv51C7mobCSfCCv63T0NC4SgMWkQDjiwELXVcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0bSyMxmq;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC2606D807;
	Sat,  7 Nov 2026 14:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACC2606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0bSyMxmq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=NQCqFf/qR4D83VPEtwWEx/gZFVt7qS+g1ysVABuUlco=; b=0bSyMxmqad3Uoawf9HLxq/PFgP
	6lWhV+SDycY3M/RTYbZAnJQzo043phKNxxGM9zzRTVU02nThH5NI8kIP7AJcBGOXOvNTava9QYfTh
	asKzszvmwxh+WY3MWoJlhwRG4xIVfj1Kiejabg8nXW8Hm3HdLGftsWjepsEJJqtYMnPmPgzqYnC86
	jxFCyLy9+4+ZRRv9wC/V7vDN8jFkPWSAai2wMx7uJ1lkQOcosT3x3wyXfTZse07h9K9ioRhU4JpVs
	z5XsEbfkxHM31nscHmz1NF37cpk/QkxHw1Roy04GpOZyQRuYh3xNMSEhHXz4YAL6f0wm2wpO9yWOS
	uWAMWpPg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 iav@iav.lv
Cc: Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] gpio: rockchip: restore interrupt settings after hibernation
Date: Sat, 07 Nov 2026 15:38:38 +0100
Message-ID: <9970336.2WqB4rESCP@phil>
In-Reply-To: <20261107-b4-gpio-rockchip-hib-v1-1-19f4d163a55e@iav.lv>
References: <20261107-b4-gpio-rockchip-hib-v1-1-19f4d163a55e@iav.lv>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 7. November 2026, 06:55:00 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Igor Velkov via B4 Relay:
> From: Igor Velkov <iav@iav.lv>
>=20
> Restore from hibernation follows a cold boot. The boot kernel probes
> the GPIO banks, sets every interrupt enable bit, leaves the trigger of
> each line it did not request at the reset value, and then hands over
> to the image. The image restores only the interrupt masks, so a line
> it had set up for both edges comes back with the reset trigger.
>=20
> On ODROID-M1 the headphone detect line (GPIO0_B0) is requested for
> both edges and is low with nothing plugged in. After a power loss in
> hybrid sleep its reset trigger fires again as soon as the edge handler
> acknowledges it, and the system does not come back. With this patch
> the board resumed 4 of 4 times, without it 0 of 5.
>=20
> Save the interrupt enable, type, polarity and both-edge registers with
> the masks and write them back before unmasking. In a normal suspend
> the bank keeps its registers, so this writes back what is already
> there. For lines that emulate both edges on GPIO v1, take the polarity
> from the current pin level.
>=20
> Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Velkov <iav@iav.lv>

This looks sensible in general, but I wonder what happens with the other
registers of the gpio-controller here after hibernation?

Like does the direction + output value, debounce get restored from
some other means?


Heiko

> ---
> Tested on ODROID-M1 (RK3568, GPIO v2): hybrid sleep with power removed
> during sleep 4/4, deep sleep 10/10. The GPIO v1 path was not tested on
> hardware.
> ---
>  drivers/gpio/gpio-rockchip.c       | 21 +++++++++++++++++++++
>  drivers/pinctrl/pinctrl-rockchip.h |  8 ++++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 0f46ff095a24..83a5cc8f3fe6 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -489,6 +489,11 @@ static void rockchip_irq_suspend(struct irq_data *d)
>  	struct rockchip_pin_bank *bank =3D gc->private;
> =20
>  	bank->saved_masks =3D irq_reg_readl(gc, bank->gpio_regs->int_mask);
> +	bank->saved_en =3D rockchip_gpio_readl(bank, bank->gpio_regs->int_en);
> +	bank->saved_type =3D rockchip_gpio_readl(bank, bank->gpio_regs->int_typ=
e);
> +	bank->saved_polarity =3D rockchip_gpio_readl(bank, bank->gpio_regs->int=
_polarity);
> +	if (bank->gpio_type =3D=3D GPIO_TYPE_V2)
> +		bank->saved_bothedge =3D rockchip_gpio_readl(bank, bank->gpio_regs->in=
t_bothedge);
>  	irq_reg_writel(gc, ~gc->wake_active, bank->gpio_regs->int_mask);
>  }
> =20
> @@ -496,7 +501,23 @@ static void rockchip_irq_resume(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>  	struct rockchip_pin_bank *bank =3D gc->private;
> +	u32 polarity =3D bank->saved_polarity;
> +
> +	/*
> +	 * Restore from hibernation follows a cold boot: write the enables and
> +	 * the trigger back before we unmask.
> +	 */
> +	if (bank->toggle_edge_mode) {
> +		u32 data =3D readl(bank->reg_base + bank->gpio_regs->ext_port);
> =20
> +		polarity &=3D ~bank->toggle_edge_mode;
> +		polarity |=3D ~data & bank->toggle_edge_mode;
> +	}
> +	rockchip_gpio_writel(bank, bank->saved_en, bank->gpio_regs->int_en);
> +	rockchip_gpio_writel(bank, bank->saved_type, bank->gpio_regs->int_type);
> +	rockchip_gpio_writel(bank, polarity, bank->gpio_regs->int_polarity);
> +	if (bank->gpio_type =3D=3D GPIO_TYPE_V2)
> +		rockchip_gpio_writel(bank, bank->saved_bothedge, bank->gpio_regs->int_=
bothedge);
>  	irq_reg_writel(gc, bank->saved_masks, bank->gpio_regs->int_mask);
>  }
> =20
> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl=
=2Drockchip.h
> index 950097699643..ea280843fcb9 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/pinctrl-rockchip.h
> @@ -303,6 +303,10 @@ struct rockchip_drv {
>   * @db_clk: clock of the gpio debounce
>   * @irq: interrupt of the gpio bank
>   * @saved_masks: Saved content of GPIO_INTEN at suspend time.
> + * @saved_en: interrupt enables, saved at suspend time.
> + * @saved_type: interrupt level/edge type, saved at suspend time.
> + * @saved_polarity: interrupt polarity, saved at suspend time.
> + * @saved_bothedge: interrupt both-edge enables (GPIO v2), saved at susp=
end time.
>   * @pin_base: first pin number
>   * @nr_pins: number of pins in this bank
>   * @name: name of the bank
> @@ -332,6 +336,10 @@ struct rockchip_pin_bank {
>  	struct clk			*db_clk;
>  	int				irq;
>  	u32				saved_masks;
> +	u32				saved_en;
> +	u32				saved_type;
> +	u32				saved_polarity;
> +	u32				saved_bothedge;
>  	u32				pin_base;
>  	u8				nr_pins;
>  	char				*name;
>=20
> ---
> base-commit: 0fa38ba784896f2fc32c9dacd33822f844b21906
> change-id: 20261107-b4-gpio-rockchip-hib-705c3fd52b49
>=20
> Best regards,
>=20




