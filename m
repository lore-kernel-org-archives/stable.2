Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618698;
	b=VQ4azZTceQzgWXmzg49ECMaI51lylNg8pjsZhPPuwmuptpu1vkZB9o0lsYJqOhO/H4+n
	 NZmpowIv3VfzaEw6EGURfosSxFIEToVIroSV0BUpw6rWO5JJcnEyM/OULb+1ZRKkl1dMW
	 xZoITXRB0AAVfSVpFVhtJ482E6UtdB+jWpTjx5a8xzxmPwRifmZC3XbCCrj8+/T5kn1Cb
	 uZjQpeGSbAglfz5XkePmiei9FOE3SB7ZqvKvMjgaZF01TdZHAytAIFYIu+XWO/YRd+qdd
	 /HV7OTqlicSFJBwx5+0sGk6mhSMvmY0hqxkZALlufJuVrHRxbZqU9DfIDyTNPPH1F+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618698;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=JzEDs0KztFR/dKb5P5JwPgBVJcYPax3Qtw4csTNntXI=;
	b=I96jHk9aPyDCscrB8B+NGum0mImQhrhEnARp6YkhSJkolXIY9h87k90VUpqEepKCBXzi
	 85h5HTy0Pu19dnkUMy2ivS1wy4PK9zs3xvQUicsO5E8UjUd67TKVPfl924C7wGK6pOoRV
	 mkQ2beeAwEoc0lkQGJ91qBrkx1dJo76dnCHggt6Lrjz0s6nddWNN0biC5RlvPdHZJ852T
	 bRczr9tvNmJ3ZXN0OJmaABHHraYAhdJ/aZ7FpG4WKqYyw73+4gGydq2ujKjONqSkdGpdV
	 DDdgUO6dU2ouQh58D7rQFLxCGnJbQY89ModkWJy7Y8/4iRC1RUIVOs0vzVpr+RGd5Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=wAZvJBWO;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF5606A326;
	Wed, 25 Nov 2026 14:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BF5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=wAZvJBWO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=JzEDs0KztFR/dKb5P5JwPgBVJcYPax3Qtw4csTNntXI=; b=wAZvJBWO3Qeia89I7OFd6jWVKi
	IXxVRszox3Am1a4Tj7nqerFw17uxC2p298VDHrYPzrOgXXMqS8gguCQ0W9IDuPQ3YHB12O2BZXdni
	sskaCPC4b8PpjeqDkJ772wVBXL2/Q6byh4C25AJ2nXHDOGOUBLFGjeqQ4GnEo5Ezh8bo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xWERl-000000006md-352o;
	Wed, 25 Nov 2026 09:58:10 -0500
Date: Wed, 25 Nov 2026 09:58:09 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Akshat Rawat <akshatrawat095@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Elena
 Popa <elena.popa@nxp.com>
Subject: Re: [PATCH] rtc: pcf2127: use const per-variant regmap_config
 tables
Message-Id: <20261125095809.02514aca6423f071c6a51b58@hugovil.com>
In-Reply-To: <20261125124416.468-1-akshatrawat095@gmail.com>
References: <20261125124416.468-1-akshatrawat095@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Akshat,

On Wed, 25 Nov 2026 12:44:15 +0000
Akshat Rawat <akshatrawat095@gmail.com> wrote:

> [You don't often get email from akshatrawat095@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 

Your commit title message should indicate why you do it, not how. If
you fix a bug, it should say so.


> Both pcf2127_i2c_probe() and pcf2127_spi_probe() declare config as a
> static struct regmap_config and update it in place based on the chip
> variant.

Your entire patch can be simplified by simply removing the static
qualifier from structs in pcf2127_i2c_probe() and pcf2127_spi_probe().

 
> In pcf2127_spi_probe(), if a PCF2131 probes first, read_flag_mask and
> write_flag_mask are overwritten to 0 and never restored. Any PCF2127 or
> PCF2129 probed later reuses those zeroed masks instead of 0xa0/0x20,
> breaking SPI register access. Modifying static max_register and flag
> masks also races if multiple instances probe concurrently.
> 
> Replace the shared mutable config structs in both probe paths with
> per-variant static const struct regmap_config tables, and drop the
> now-unused max_register field from struct pcf21xx_config.
> 
> Fixes: fd28ceb4603f ("rtc: pcf2127: add variant-specific configuration structure")
> Fixes: fa78e9b606a4 ("rtc: pcf2127: fix SPI command byte for PCF2131")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
> ---
> Compile-tested (x86_64 gcc 15.2.0, W=1, CONFIG_WERROR=y) with
> I2C+SPI, I2C-only, and SPI-only configs; not tested on hardware.
> 
>  drivers/rtc/rtc-pcf2127.c | 65 +++++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 27c5fb9b2aaa..b665728c6c1d 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -186,7 +186,6 @@ struct pcf21xx_ts_config {
> 
>  struct pcf21xx_config {
>         int type; /* IC variant */
> -       int max_register;
>         unsigned int has_nvmem:1;
>         unsigned int has_bit_wd_ctl_cd0:1;
>         unsigned int wd_val_reg_readable:1; /* If watchdog value register can be read. */
> @@ -1020,7 +1019,6 @@ static struct attribute *pcf2131_attrs[] = {
>  static struct pcf21xx_config pcf21xx_cfg[] = {
>         [PCF2127] = {
>                 .type = PCF2127,
> -               .max_register = 0x1d,
>                 .has_nvmem = 1,
>                 .has_bit_wd_ctl_cd0 = 1,
>                 .wd_val_reg_readable = 1,
> @@ -1048,7 +1046,6 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>         },
>         [PCF2129] = {
>                 .type = PCF2129,
> -               .max_register = 0x19,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
>                 .wd_val_reg_readable = 1,
> @@ -1076,7 +1073,6 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>         },
>         [PCF2131] = {
>                 .type = PCF2131,
> -               .max_register = 0x36,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
>                 .wd_val_reg_readable = 0,
> @@ -1452,13 +1448,27 @@ static const struct i2c_device_id pcf2127_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
> 
> +static const struct regmap_config pcf2127_i2c_regmap_config[PCF21XX_LAST_ID] = {
> +       [PCF2127] = {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .max_register = 0x1d,
> +       },
> +       [PCF2129] = {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .max_register = 0x19,
> +       },
> +       [PCF2131] = {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .max_register = 0x36,
> +       },
> +};
> +
>  static int pcf2127_i2c_probe(struct i2c_client *client)
>  {
>         struct regmap *regmap;
> -       static struct regmap_config config = {
> -               .reg_bits = 8,
> -               .val_bits = 8,
> -       };
>         const struct pcf21xx_config *variant;
> 
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> @@ -1468,10 +1478,9 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
>         if (!variant)
>                 return -ENODEV;
> 
> -       config.max_register = variant->max_register,
> -
>         regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
> -                                       &client->dev, &config);
> +                                 &client->dev,
> +                                 &pcf2127_i2c_regmap_config[variant->type]);
>         if (IS_ERR(regmap)) {
>                 dev_err(&client->dev, "%s: regmap allocation failed: %ld\n",
>                         __func__, PTR_ERR(regmap));
> @@ -1518,14 +1527,30 @@ static void pcf2127_i2c_unregister_driver(void)
>  static struct spi_driver pcf2127_spi_driver;
>  static const struct spi_device_id pcf2127_spi_id[];
> 
> -static int pcf2127_spi_probe(struct spi_device *spi)
> -{
> -       static struct regmap_config config = {
> +static const struct regmap_config pcf2127_spi_regmap_config[PCF21XX_LAST_ID] = {
> +       [PCF2127] = {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .read_flag_mask = 0xa0,
> +               .write_flag_mask = 0x20,
> +               .max_register = 0x1d,
> +       },
> +       [PCF2129] = {
>                 .reg_bits = 8,
>                 .val_bits = 8,
>                 .read_flag_mask = 0xa0,
>                 .write_flag_mask = 0x20,
> -       };
> +               .max_register = 0x19,
> +       },
> +       [PCF2131] = {
> +               .reg_bits = 8,
> +               .val_bits = 8,
> +               .max_register = 0x36,
> +       },
> +};
> +
> +static int pcf2127_spi_probe(struct spi_device *spi)
> +{
>         struct regmap *regmap;
>         const struct pcf21xx_config *variant;
> 
> @@ -1541,14 +1566,8 @@ static int pcf2127_spi_probe(struct spi_device *spi)
>                 variant = &pcf21xx_cfg[type];
>         }
> 
> -       if (variant->type == PCF2131) {
> -               config.read_flag_mask = 0x0;
> -               config.write_flag_mask = 0x0;
> -       }
> -
> -       config.max_register = variant->max_register;
> -
> -       regmap = devm_regmap_init_spi(spi, &config);
> +       regmap = devm_regmap_init_spi(spi,
> +                                     &pcf2127_spi_regmap_config[variant->type]);
>         if (IS_ERR(regmap)) {
>                 dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
>                         __func__, PTR_ERR(regmap));
> --
> 2.56.1.windows.1
> 


-- 
Hugo Villeneuve
