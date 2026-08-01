Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EB357CEB;
	Sat,  1 Aug 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575987; cv=none; b=SxAPc3kQALgM7M7w1LWUjES2crKgjjzWVe6c/N7nARthyBruRqXv2elAvqTWWPYR/k6/SHF/LMeGeGhPDF7cvPJ1pd9TItg59S6S1KIFevo759/8PipARVSdf/WvS7HygsSIaSxD/GjRA6yp0k7s9ShwV+u0RTCg6P3PHEq4BzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575987; c=relaxed/simple;
	bh=ajaevt4YwTaopIChz2raCCOWlCysctaxK5fPuVWE6IQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b8UDjyKVJKXnGrFJSV9Fmi9PVt0/QDU9nS4DmaZzAeZzP/OEhvsDyPKYOOl25gUarDSWpyTgvtCbDvvOlOOTH1/4YrsDnX4kA6eIsZEF++N29zj+bxkRjBosuhRHos71efgnQvkN7e7MRuH+da+c5pHmPtS7O/IG9VYbXiYdqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Dxvpsvum1q3nYJAA--.8276S3;
	Sat, 01 Aug 2026 17:19:43 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBxLscqum1qjcofAA--.55195S3;
	Sat, 01 Aug 2026 17:19:40 +0800 (CST)
Subject: Re: [PATCH v8 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
 stable@vger.kernel.org
References: <20260721122604.12717-1-wanghongliang@loongson.cn>
 <20260721122604.12717-3-wanghongliang@loongson.cn>
 <amPz7-dljqdfwNGc@zenone.zhora.eu>
From: Hongliang Wang <wanghongliang@loongson.cn>
Message-ID: <c317044c-e579-d9f0-8a37-83dbf2a96df2@loongson.cn>
Date: Sat, 1 Aug 2026 17:17:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <amPz7-dljqdfwNGc@zenone.zhora.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJBxLscqum1qjcofAA--.55195S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtFWDXry3KrW8Ww4DXr47GFX_yoW3WFy5pr
	W8GF4UJryDJr1xKwnrtr1UZFy5Aw1DJa1UJF1UJF1UJr15Jr1jqFy2qrn0gryUJr48A3W5
	X3WUXrnruF4UZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU489NUUUUU

Hi Andi,

On 2026/7/25 上午7:39, Andi Shyti wrote:
> On Tue, Jul 21, 2026 at 08:26:04PM +0800, Hongliang Wang wrote:
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
> This commit log is not understandable, what did you actually do
> here? Please read carefully the submitting-patches documentation
> (under the "Describe your changes" paragraph).
I'm sorry for the unclear commit message in this version.
In the next revision I will rewrite the commit description properly,
following the Describe your changes guidelines, to clearly explain
what this patch does:

The original driver uses a fixed PCLK frequency(LS2X_I2C_PCLK_FREQ) and
fixed div(5) for I2C bus speed calculation. As PCLK frequency and div
vary on different SoCs and ACPI platforms, this leads to inaccurate I2C
bus speed calculation and poor adaptability across platforms.

Improve the accuracy of I2C bus speed calculation across different
platforms by parsing the real I2C bus reference clock (PCLK) and div.
Support both DTS and ACPI.

For DTS:
- Retrieve I2C bus reference clock via the common clock framework
- Fetch div from match data for LS2K/LS7A series
- Fallback to default values if clock lookup fails or the obtained
   pclk or div is zero

For ACPI:
- Parse "clocks" property to get I2C bus reference clock
- Parse "clock-div" property to get div
- Fallback to the default values if property parsing fails or the
   obtained pclk or div is zero

Calculate the I2C clock prescaler based on reference clock, div and
target bus frequency with the formula:
prescale = (pclk * 10) / (div * bus_freq_hz) - 1

Dynamically acquiring PCLK and div per platform ensures accurate I2C bus
speed calculation and reliable operation across different platforms.
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> I haven't seen Huacai's review on patch 2, as far as I've seen he
> has reviewed only patch 1. Have I missed anything?
>
Huacai has already confirmed on the mailing list during the v6 discussion
that he agrees with this patch and the tag can be retained. So this 
Reviewed-by
is valid.

Link: https://lore.kernel.org/r/ai-3ZiF7RL8J4lNP@zenone.zhora.eu/

>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Is this a Fix? I asked you this already. Please read carefully
> the paragraph I suggested and add the necessary tag.
>
This is a correctness improvement, not a fix for a bug introduced by
a specific commit. Therefore no Fixes tag is applicable here.

The Cc stable was added on suggestion in v4 from Huacai Chen, in order 
to keep
clock configuration consistent and accurate across stable kernel 
releases for
Loongson platforms. If this improvement is not suitable for stable, I will
remove it in v9.

Link: 
https://lore.kernel.org/all/CAAhV-H71ZiakZaLVKYg2Qvp8ZJiT7hr9P9bAmXCrjWkHg+-vGg@mail.gmail.com/
>> ---
>>   drivers/i2c/busses/i2c-ls2x.c | 40 ++++++++++++++++++++++++++++++++---
>>   1 file changed, 37 insertions(+), 3 deletions(-)
>>
> ...
>
>> @@ -107,12 +116,13 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>>   	else
>>   		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>>   
>> +	val = (priv->pclk * 10) / (priv->div * t->bus_freq_hz) - 1;
> Sashiko pointed out that this might overflow. While your replied
> that the expected platform values may not overflow, the code does
> not enforce those constraints.
>
> The clock rate comes from firmware or the clock framework, so at
> least a zero rate should be rejected. Using 64-bit arithmetic here
> would also avoid relying on undocumented assumptions about the
> input range at essentially no cost.
>
I will fix these issues in the next version:
- Use 64-bit arithmetic to avoid integer overflow during the clock 
calculation
- Add checks to reject zero clock rates and ensure valid clock inputs

The code is modified as follows:

--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -116,7 +116,7 @@ static void ls2x_i2c_adjust_bus_speed(struct 
ls2x_i2c_priv *priv)
         else
                 t->bus_freq_hz = LS2X_I2C_FREQ_STD;

-       val = (priv->pclk * 10) / (priv->div * t->bus_freq_hz) - 1;
+       val = ((u64)priv->pclk * 10) / ((u64)priv->div * t->bus_freq_hz) 
- 1;

         /*
          * According to the chip manual, we can only access the 
registers as bytes,
@@ -319,10 +319,13 @@ static int ls2x_i2c_probe(struct platform_device 
*pdev)
                 clk = devm_clk_get_optional_enabled(dev, NULL);
                 if (IS_ERR(clk))
                         return PTR_ERR(clk);
-               if (clk)
+               if (clk) {
                         priv->pclk = clk_get_rate(clk);
-               else
+                       if (!priv->pclk)
+                               priv->pclk = LS2X_I2C_PCLK_FREQ;
+               } else {
                         priv->pclk = LS2X_I2C_PCLK_FREQ;
+               }

                 priv->div = (unsigned long)device_get_match_data(dev);
                 if (!priv->div)
@@ -330,7 +333,7 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
         } else {
                 /* clocks and clock-div are only ACPI properties. */
                 ret = device_property_read_u32(dev, "clocks", &priv->pclk);
-               if (ret)
+               if (ret || !priv->pclk)
                         priv->pclk = LS2X_I2C_PCLK_FREQ;

                 ret = device_property_read_u32(dev, "clock-div", 
&priv->div);

>> +
> ...
>
>> +	if (dev_of_node(dev)) {
>> +		clk = devm_clk_get_optional_enabled(dev, NULL);
>> +		if (IS_ERR(clk))
>> +			return PTR_ERR(clk);
>> +		if (clk)
>> +			priv->pclk = clk_get_rate(clk);
>> +		else
>> +			priv->pclk = LS2X_I2C_PCLK_FREQ;
>> +
>> +		priv->div = (unsigned long)device_get_match_data(dev);
>> +		if (!priv->div)
>> +			priv->div = LS2X_I2C_2K_CLOCK_DIV;
>> +	} else {
>> +		/* clocks and clock-div are only ACPI properties. */
> clocks is also DT property.
The comment is intended to indicate that the clocks and clock-div properties
are used only in the ACPI path, as requested by Krzysztof in the v4 review.
For DT, clocks are handled through the common clock framework instead.

Link: 
https://lore.kernel.org/all/20260526-pompous-gopher-of-serendipity-d72f1f@quoll/

I will update the comment to
"clocks and clock-div properties are used only in ACPI path" to make the
distinction clearer in the next version.
> Andi
>
>> +		ret = device_property_read_u32(dev, "clocks", &priv->pclk);
>> +		if (ret)
>> +			priv->pclk = LS2X_I2C_PCLK_FREQ;
Best regards,
Hongliang Wang

