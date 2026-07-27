Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E464137B6
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158865; cv=none; b=F2bvxmWchx9mbKavilLa9yp0xc9Co4Z5OawlwL99Fk6ALxLZ2//H0KXkc+qYSMXHfI8bDFVVwg8b3nUUAyYP2imoLOlXogubk43DS0hEudkwqx2X4XNTk1jvN/yRnGca8r55NAjD3eXF7yUnGtJmEkE9u3dknFkuaRpYNnUKu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158865; c=relaxed/simple;
	bh=qMh3iMW7LAK2gw7id80SDhhXwFYFcOQeuiXlRrdCxL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYeEpXk3F4jhCV27MXIBYS7YcAGHs2xQYTb2gxLFA7dKa8OvpPyKV1hzuH+3DXUlidn1RiNsqmhlYt0sjED35nsSuZ20BhpdwE5HCQVjiPAi56xJp6N5RxvJmbR56hId1MD+240NLn4PExUC/rWTRijmZp10LtVRGHAcczjExGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RbQLOnkg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RbQLOnkg"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso911330a34.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785158857; x=1785763657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=862duEuJG7xgtpJCUOI3pjr65DD4q6n4TnDbBPD48MA=;
        b=RbQLOnkglwzKzgr0Kjl6K3aMlyy4V7xnvV3gk9yr5ucJNTQl9e2AGSBibuDqt+hrxD
         6AUTzZEdggf1kbiCjhf01cZAut/+Hp3tBbEVPxWnOwzG16hm9hg70OEAyb9y0H6ILZU4
         LI8widvgk2gR2xNTNQfpvJ/37qZmm0oDouPiB22rd6A0IpPlirLDOYOiaa+8kL4d1PdI
         aONa3Kujb0xdgjBs2jFBx7FCR9nopRhCq2UzB40ZVxQ+2jI3aPcJUVEZM0s5LBUO54eT
         GcRLHKjiKdlLJzXietwpC2WwoQcGnP+5+ze+++20mKnra3hl+g2aZxSkuMwlEqmqWl6j
         TkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785158857; x=1785763657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=862duEuJG7xgtpJCUOI3pjr65DD4q6n4TnDbBPD48MA=;
        b=LmxPc8mRmidN/soWduzEpm2Hpn/4EFYmy5wtV+Zxft+hPiWx2Hb7gLl0wiUcY+9crj
         D/siEbpUaAI9P/U1tyBxXWw4VCY5xkFiWFJ02ZNTQA4PaakniRfPINiz9uGVk00dJtdO
         Ts/hEDwbtu6SA46QV+EEiJ4OosIl0gRtAm/svcf6QetRKof4e+iQW0f1eIvmv9Ps4ZGO
         OvyshJywRzUjAoWLIDFOtpKJXgC2If1to17M9krgrnIl6O0YXo5oUwTqn7cjmKQAjmR9
         Hc8vizGH+zn1h52hZyccSGnNQcA7yItejrVtE90u82+5NLv5IQD1/eHcVy2d7xm+gNeC
         bG1A==
X-Gm-Message-State: AOJu0YxfOMiPIeyEE4Y3ixFA7DLCNZn7o4+UrPxc4u3gCwu9plsxJm3l
	KkDeNQnE/cr6aPZ4m4tBdpmuqsUGui5gWV3Y/QGFV2cTGo6PaCxJMiCDm46DmeAn7L4=
X-Gm-Gg: AR+sD11cufnIqmjAkx2eUYxRkvfAc+nQnXLwN5VPPGn+v+Bjka9eH0Ds1qC/Jlsb2Mi
	SnIdi5NON1AdTfK+Nmvbx2gRV43KeKzengqXkKGlbDqwrCDotRavu2JWUweNtKG1ofgydx+Wl5k
	vEaGntp7AvtWDVkVdv+uJLHbNk78MRNn1RTZbvHjjUwSX30LEQg0X1NbPORKUseu156KTb13Qr3
	24gq/fFZ8vcNOurGISbelMNT30BkTwGgoV2fIhLCBO452IDOjRBcju/a/6xYge1gfr33A0nGOjz
	E/CgdZgf7lTg4dmuR1lU81vWybeTfaaOMXHHS+wBFgO1ZsMLjxukKebWTddWyWZyPyKaH048SHJ
	Hh1sPhvl+sRjZUGFw+uhmP9Ap7Emyb7jirTcXjDOmKX8X2m2k8fZISNaxbqFAkBg4r5aTJY+1KC
	bhivCunacjQUhTjq4ANQgh+UEb+IG0keQ/VaZVg3TzlE01Rban+Fun
X-Received: by 2002:a05:6830:8385:b0:7e9:c481:ff8a with SMTP id 46e09a7af769-7ee78c25effmr7740900a34.11.1785158857019;
        Mon, 27 Jul 2026 06:27:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:41b4:f2ef:8a0a:2104? ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a03d30asm12348470a34.18.2026.07.27.06.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 06:27:36 -0700 (PDT)
Message-ID: <bb74b15e-6a95-4eaa-82bf-7c256b554c45@baylibre.com>
Date: Mon, 27 Jul 2026 08:27:35 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: dps310: fix pressure result shift bit
 definition
To: Rupesh Majhi <zoone.rupert@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: stable@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727070547.649074-1-zoone.rupert@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260727070547.649074-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 2:05 AM, Rupesh Majhi wrote:
> DPS310_PRS_SHIFT_EN is defined as BIT(4), but P_SHIFT is bit 2 of
> CFG_REG. Bit 4 is INT_PRS, which enables the pressure measurement ready
> interrupt on the SDO pin.
> 
> The datasheet requires the pressure result bit-shift to be enabled when
> the oversampling rate is higher than 8 times, so
> dps310_set_pres_precision() sets it for oversampling ratios of 16 and
> above. With the wrong definition it leaves P_SHIFT clear and toggles the
> pressure ready interrupt instead, so the result register is never shifted
> and the pressure values read at those oversampling ratios are wrong.
> 
> Define the bit at its documented position. Temperature is not affected,
> T_SHIFT is bit 3 and DPS310_TMP_SHIFT_EN already matches it.
> 
> Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> Found by inspection while working on FIFO support, and checked against the
> DPS310 datasheet V1.1 (2019-07-11), section 8.6 "Interrupt and FIFO
> configuration (CFG_REG)", where the bit table reads INT_HL, INT_FIFO,
> INT_TMP, INT_PRS, T_SHIFT, P_SHIFT, FIFO_EN, SPI_MODE for bits 7 down to 0.
> 
> Not tested on hardware yet: the driver probes and reads correctly under
> qemu-system-arm -M rainier-bmc, but QEMU's DPS310 model does not implement
> the shift bits, so it cannot show the difference. I have a DPS310 breakout
> on order and can confirm the raw pressure values at oversampling >= 16 once
> it arrives, if you would rather wait for that.
> 
>  drivers/iio/pressure/dps310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 45bdb8c7670f..473973dd0694 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -50,7 +50,7 @@
>  #define DPS310_CFG_REG		0x09
>  #define  DPS310_INT_HL		BIT(7)
>  #define  DPS310_TMP_SHIFT_EN	BIT(3)
> -#define  DPS310_PRS_SHIFT_EN	BIT(4)
> +#define  DPS310_PRS_SHIFT_EN	BIT(2)
>  #define  DPS310_FIFO_EN		BIT(5)
>  #define  DPS310_SPI_EN		BIT(6)
>  #define DPS310_RESET		0x0c

In your followup work, it would be nice to start with a patch to
sort these in a logical order.

Right now, there is a mix of GENMASK being sorted from high to low
while bits are low to high (with DPS310_INT_HL being out of order).
Normally, we go from low to high on everything because that is how
datasheets usually list things.

Ideally, would end up something like:

#define DPS310_PRS_B0		0x00
#define DPS310_PRS_B1		0x01
#define DPS310_PRS_B2		0x02
#define DPS310_TMP_B0		0x03
#define DPS310_TMP_B1		0x04
#define DPS310_TMP_B2		0x05
#define DPS310_PRS_CFG		0x06
#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
#define DPS310_TMP_CFG		0x07
#define  DPS310_TMP_EXT		BIT(7)
#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
#define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
#define DPS310_MEAS_CFG		0x08
#define  DPS310_COEF_RDY	BIT(7)
#define  DPS310_SENSOR_RDY	BIT(6)
#define  DPS310_TMP_RDY		BIT(5)
#define  DPS310_PRS_RDY		BIT(4)
#define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
#define   DPS310_BACKGROUND	 BIT(2)
#define   DPS310_TEMP_EN	 BIT(1)
#define   DPS310_PRS_EN		 BIT(0)
#define DPS310_CFG_REG		0x09
#define  DPS310_INT_HL		BIT(7)
#define  DPS310_SPI_EN		BIT(6)
#define  DPS310_FIFO_EN		BIT(5)
#define  DPS310_TMP_SHIFT_EN	BIT(3)
#define  DPS310_PRS_SHIFT_EN	BIT(2)
#define DPS310_RESET		0x0c
#define  DPS310_RESET_MAGIC	0x09
#define DPS310_COEF_BASE	0x10


