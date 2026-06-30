Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4C1F3D56;
	Tue, 30 Jun 2026 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822989; cv=none; b=A9ZmXI+NKXFGFcqhfvVJoZW9i9OoHTUIcI9mPL/K05nd0UE66hJODl5e4z7wMGhaChv8eBqytVsP6eKnHMG0yjL095FY/WLYJBO/WRtrK5QQCRgTSKjDtjDt+NC4ef346P0OXC2/j9PLDGXCnQaiqlo8sG8x6qtMENvJgNlNsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822989; c=relaxed/simple;
	bh=+9gtoXI7zpH1/d174ZpBP6VfcwKOyAPrwaYEiqqHFfo=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aWDqCT5vWWmHhlmQqArVoIdKvXy/EaBirMRpZkvFDwFOGYFtUANp0NcN+eWQASpSnJ6i5khddzNSSBFi4kbPiivP39oJhOmysYqTq17E6ChsrnhWR2ebChqwEpee7OkxkTKleAqlYW/e5Tb0iqjcC2CdtbA2K7l7LM9vDm5f9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Bxh_BIuENqPwkAAA--.149S3;
	Tue, 30 Jun 2026 20:36:24 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxaeAzuENqzQq5AA--.24273S3;
	Tue, 30 Jun 2026 20:36:23 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
 stable@vger.kernel.org
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
 <ajHRVJhAzo3V4C9g@zenone.zhora.eu>
Message-ID: <c63e2126-02a0-18d9-896a-89257201cb0a@loongson.cn>
Date: Tue, 30 Jun 2026 20:34:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ajHRVJhAzo3V4C9g@zenone.zhora.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxaeAzuENqzQq5AA--.24273S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF17tw1ktr43tF13KFW8KrX_yoW7GFW7pF
	W8JF4UGrWDJr10qr1kXr1UZryUtw1DJ3WUJr18JF17Xr13Jr1jqF1UWr1qgr18Gr48Jw45
	JF1UXr1UZr1UArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

Hi, Andi

On 2026/6/17 上午6:55, Andi Shyti wrote:
> Hi Hongliang,
>
> On Mon, Jun 08, 2026 at 10:45:33AM +0800, Hongliang Wang wrote:
>> The i2c-ls2x driver supports dts and acpi parameter passing.
>>
>> In dts, uses clock framework, by parsing clocks property to
>> get i2c bus reference clock, and define the div of reference
>> clock by device data.
>>
>> In acpi, by passing clocks property to describe i2c bus reference
>> clock and clock-div property to describe the div of reference clock.
>>
>> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
>> and div, calculate the prcescale of i2c divider register. The
>> calculation formula is
>>
>> prcescale = (clock_a*10)/(div*clock_s)-1
>>
>> Reviewed-by: Huacai Chen<chenhuacai@loongson.cn>
>> Cc:stable@vger.kernel.org
> what are you fixing exactly? It's not clear from the commit log.
> Do we need to add the Fixes tag?
The modification from v5 to v6 only removed CC stable from patch 1/2 and 
added
Reviewed-by tag to patch 1/2 and patch 2/2, the source code of patch 2/2 
has not
been modified.

Best regards,
Hongliang Wang
>> Signed-off-by: Hongliang Wang<wanghongliang@loongson.cn>
> ...
>
>> @@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
>>   static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   {
>>   	u16 val;
>> +	u32 pclk, div;
>> +	struct clk *clk;
>>   	struct i2c_timings *t = &priv->i2c_t;
>>   	struct device *dev = priv->adapter.dev.parent;
>>   	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
>> @@ -107,12 +117,30 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   	else
>>   		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>>   
>> +	if (dev_of_node(dev)) {
>> +		clk = devm_clk_get_optional_enabled(dev, NULL);
> Here you got a valid comment from the sashiko-bot, did you check
> it?
Yes, I moved this part of code to ls2x_i2c_probe and only called 
devm_clk_get_optional_enabled once.
> There are some other comments that is worth checking.
I added div non-zero checking. Other comments I evaluate have no impact 
on the
functionality of the i2c-ls2x driver.

The modify as follows:

60 @@ -107,12 +116,13 @@ static void ls2x_i2c_adjust_bus_speed(struct 
ls2x_i2c_priv *priv)
  61         else
  62                 t->bus_freq_hz = LS2X_I2C_FREQ_STD;
  63
  64 +       val = (priv->pclk * 10) / (priv->div * t->bus_freq_hz) - 1;
  65 +
  66         /*
  67          * According to the chip manual, we can only access the 
registers as bytes,
  68          * otherwise the high bits will be truncated.
  69          * So set the I2C frequency with a sequential writeb() 
instead of writew().
  70          */
  71 -       val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
  72         writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + 
I2C_LS2X_PRER_LO);
  73         writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + 
I2C_LS2X_PRER_HI);
  74  }


  75 @@ -290,6 +300,7 @@ static int ls2x_i2c_probe(struct 
platform_device *pdev)
  76         struct i2c_adapter *adap;
  77         struct ls2x_i2c_priv *priv;
  78         struct device *dev = &pdev->dev;
  79 +       struct clk *clk;
  80
  81         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
  82         if (!priv)
  83 @@ -304,6 +315,25 @@ static int ls2x_i2c_probe(struct 
platform_device *pdev)
  84         if (irq < 0)
  85                 return irq;
  86
  87 +       if (dev_of_node(dev)) {
  88 +               clk = devm_clk_get_optional_enabled(dev, NULL);
  89 +               if (!IS_ERR_OR_NULL(clk))
  90 +                       priv->pclk = clk_get_rate(clk);
  91 +               else
  92 +                       priv->pclk = LS2X_I2C_PCLK_FREQ;
  93 +
  94 +               priv->div = (unsigned long)device_get_match_data(dev);
  95 +       } else {
  96 +               /* clocks and clock-div are only ACPI properties. */
  97 +               ret = device_property_read_u32(dev, "clocks", 
&priv->pclk);
  98 +               if (ret)
  99 +                       priv->pclk = LS2X_I2C_PCLK_FREQ;
100 +
101 +               ret = device_property_read_u32(dev, "clock-div", 
&priv->div);
102 +               if (ret || !priv->div)
103 +                       priv->div = LS2X_I2C_7A_CLOCK_DIV;
104 +       }
105 +

> Thanks,
> Andi
>
>> +		if (!IS_ERR_OR_NULL(clk))
>> +			pclk = clk_get_rate(clk);
>> +		else
>> +			pclk = LS2X_I2C_PCLK_FREQ;
> ...
Best regards,
Hongliang Wang

