Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A4386435;
	Mon, 24 Aug 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597446; cv=none; b=mmR4Nt0SZlGkE3pfkl3IfJa/vq1/bztZodBrjEW1rKzQQk/VNRgTl1WyV/o8r7iVHstIky6yY4du095wJJwh08LMVopg95eNfL/ZaUE2miFJIw0wsWmmGG89+5+IwO8BTZqsGbV/G1qh3JGSrNE6D4wR0XNX2fRSyv18DsIBVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597446; c=relaxed/simple;
	bh=tp0qs5KskZPC9bLgjjBIJelmk39ebd0b8P3RC89Xgx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfCUBafyDF+4a33znY3M8mzyfrz5ADqVNhCFVNw4XjqUpEzsuwPYif9nVTRtqsrbVNHf5jytyM4VMpUiy8VTjQ4Ou5PqwOItbyZ87yWPG8Tw89quKspD8Y7VGInokMjvIV9u0goRi9SobvWqyuaWPonCTiGMecPh5eI9TiUZ6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAhIlnZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAhIlnZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ADC1F000E9;
	Mon, 24 Aug 2026 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787597445;
	bh=Gw5cqatvUJD+UEYE9swbLVwuk7RDjDmNNLvkCRibJJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fAhIlnZGxiR7N65HWMX37ZGibQGYHBLGE+PnlaD4Q67rZzcEATHf1BE/nW0Bzt+Tk
	 E7LXqeKNBoN8SWA05RogBol+jpgXUKZ/qKhjxXI7XDSX9nDtIGtQYtZd3NTJeY8q5m
	 QLiHWxg1SQt2tyW/G/EdJUAzRiguoRXeQHwjXLcaK5+T6kw/+0G/zXLycdypmWWhhD
	 +AvKC9bd9z4OSsblb3fe8bDm7uEVr34cvhgLMf8Hs9XkH1+98v4rPV3qSqZk137n5N
	 HkXhB/WPccKozrDuc/hxk5e/NAFtSKLS7bDLulptXcXAMaA7q4oRG+jhysMk3m/J8p
	 B7S/Zf/k4G11w==
From: Jakub Kicinski <kuba@kernel.org>
To: xuziyougm@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ericwouds@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: air_en8811h: restore LED GPIO output after MCU restart
Date: Mon, 24 Aug 2026 11:50:43 -0700
Message-ID: <20260824185043.2701718-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820141034.1400439-1-xuziyougm@gmail.com>
References: <20260820141034.1400439-1-xuziyougm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Verified. Report follows.

commit 90353ad40d9c49a8f67a9cf009916549d394f63d
Author: Ziyou Xu <xuziyougm@gmail.com>

net: phy: air_en8811h: restore LED GPIO output after MCU restart

The LED GPIO3/4/5 output-enable write is moved out of en8811h_probe() and
into en8811h_config_init(), just before air_leds_init(), so the pads are
re-enabled after every MD32 restart.

> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index edd49c193e476..fbd87fc712bfb 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c

[ ... ]

> @@ -1317,6 +1310,16 @@ static int en8811h_config_init(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * Restarting MD32 clears the GPIO3/4/5 output enable bits. Restore
> +	 * them after every restart, before enabling the corresponding LEDs.
> +	 */
> +	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
> +					  EN8811H_GPIO_OUTPUT_345,
> +					  EN8811H_GPIO_OUTPUT_345);
> +	if (ret < 0)
> +		return ret;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but should the sibling AN8811HB
path in the same file get the same treatment?

AN8811HB_GPIO_OUTPUT_345 is written in exactly one place, an8811hb_probe():

	/* Configure led gpio pins as output */
	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
					  AN8811HB_GPIO_OUTPUT_345,
					  AN8811HB_GPIO_OUTPUT_345);

an8811hb_config_init() then restarts the MCU on every call after the first
and goes straight to the LEDs without touching that register:

	if (priv->mcu_needs_restart) {
		ret = en8811h_restart_mcu(phydev);
		...
	}
	ret = an8811hb_config_serdes_polarity(phydev);
	...
	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
			    AIR_LED_MODE_USER_DEFINE);

For AN8811HB, en8811h_restart_mcu() does a superset of the EN8811H
sequence:

	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
		ret = an8811hb_mcu_assert(phydev);
		...
		ret = an8811hb_mcu_deassert(phydev);
		...
	}
	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
					 EN8811H_FW_CTRL_1_START);

If the premise stated in the new comment ("Restarting MD32 clears the
GPIO3/4/5 output enable bits") holds for this device family, do the
AN8811HB LEDs also go dark on the second and later .config_init() call
(ifdown/ifup, or a repeated phy_init_hw())?

After this patch the two peer paths in the file disagree: en8811h_config_init()
restores the pad output-enable bits on every restart, while
an8811hb_config_init() still assumes they survive it.

Would it make sense to place the restore in the shared en8811h_restart_mcu()
or air_leds_init() path so both models are covered, or duplicate it in
an8811hb_config_init()? If AN8811HB is genuinely unaffected, could the commit
message say why?

Note this concern is based on the register definitions rather than measured
hardware behaviour: AN8811HB_GPIO_OUTPUT is the same 0xcf8b8 offset within
the AN8811HB PBUS window with an identical BIT(3) | BIT(4) | BIT(5) mask, and
commit 6b9c9def95cb ("net: phy: air_en8811h: Introduce resume/suspend and
clk_restore_context...") notes that PHY reinitialisation reverts chip-config
registers such as CKO to their initial values.

>  	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
>  			    AIR_LED_MODE_USER_DEFINE);
>  	if (ret < 0) {
-- 
pw-bot: cr
