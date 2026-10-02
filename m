Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA92443C19
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928970; cv=none; b=Wf0FzjS6NJP1aaKM2rtA2yHDYLfkqUUFkm14kFuVmiZlVwlY5mpdSvmG6N482mqOTdVcJ10wiZOQ7eIy3ZgjicR0h40TibuaAIvwwvFlG7eMeVH0qrkAqDzBO2Zicio7t4bZlgsvsT6Px+2+YoU6FahOC9CzPpLXeyBVJ+8GQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928970; c=relaxed/simple;
	bh=SrkCUBs7QxzRS2ct6PfMjjH+MllOa63+vm3xFxenUMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBxwpLrdsvQ9qALAxuCWHWrlR6RZWPiZsjoy9+u8AuuhU8cncdNP/yukEpP2/SOFCTlNTeIy9AjXeP+nrNCYFGpMMk4NV2yCBM36zzwpOWS3Rl8K9Bu7NB5Y/9r9RpqLpsoQZrbdulhyajoagFI4om+G2vzy7sSVl+3aR7430Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QiQNvjst; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QiQNvjst"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so35119235e9.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790928966; x=1791533766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guSS/KYjl8+8j30rtfwxuibMm84o1LTrBp5a4oJHKrY=;
        b=QiQNvjstwbOumYLNiQN5WT7Y9iSHTzmkOl0eaL4otxyZEejYtFBdOyB3rJVYKG1Wvm
         UcKSIMb/SFW4gW83nqiKWTopeKMadBT029V+1f3PvpmbNRPlaiTMMhFEzPLzfQ2rNoKn
         5/hk3knivyzSIfT4BNvlNE75qXLCD4B87I2RITcuNAMhkKqIhAjcaXCbveS42kW45lnY
         xEmdKDax8Sn9OjAB5XEs0HxcUFuw4MzKfakjIocVrr8pnCYsZV69GXOZVdWsrgeSMrw2
         15D2PvHGGDq4vOSvN9V3Gx9u5j7rfQ5v7/DBs213GTvzG0wTS0j6loytWZPBTGw4T7sa
         aM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790928966; x=1791533766;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guSS/KYjl8+8j30rtfwxuibMm84o1LTrBp5a4oJHKrY=;
        b=dVcNJ03wMb1W5lb43Tq5OzbBVPTJx5iqcRYgJ/KROFXaaWTMrdHuVdCcUnf5S261kg
         Wua4w8+O7iPbPkGeBGhaKaCBdhffFhbYuw/Z+U6JNpNo/hrlVkeyZtR6rBV2ODx9jWsA
         eVBfF/wpWpm/eKVg49QekuDM5rqpnhvKSdqJBV0llchdqv4NJ6WccrML14/di35wDdE9
         ln5tcN3Ta+EyySVmrVKrxvfWyYvAiXKkwnoDRCYpF5SNDrw31qI/33AcXk0FRL3ZyhuD
         uz6NyWvR1/+9WAj8TtWbLIQjDvFnMLw1Hz4SeffQkHvNBQ/RJzyKXXsm76nFsPgn+TFw
         TJmg==
X-Forwarded-Encrypted: i=1; AKwUvBxDo4PlrOL9tON56yGlYTa+6cNG28o0FbWqt+STvVs+mSeMl8f1CzE/EHYFPirSInDLdCMDYlA=@vger.kernel.org
X-Gm-Message-State: AFuF++lk2DeKsT8dqGAshQ5L8Myz+el7kbrVrlzIiZaRa+JASn8lEGWy
	Re6Q5ppe2ncc0JuZcSv8e9Lvc/BAUnq7Re8ahqpVgQR9rbCXy1Z6FubjKWJxp36/WLM=
X-Gm-Gg: AYBFou2W+MiNjJBVQoyA8tA9u7AQrezIg2izdDIRac/cucZ2JKtdbIchXL2XhqQizW9
	gnH82ogAbypwsHgG1FaP5vCOJ3o/SZIxmOuywPnWSplH9+iB/HE0ZjKUu+vnD82w1c+aWKnDeqU
	KSHlHsg87jH1to1wsNeNdIcS0+0Ip3twKDFyCzTbrolvfbArpTIqlVt1zdOqdPw997Thi3jSD1n
	IlZVorlBft0PTW8nlEdVcpnS9U5GYbKAVJnLBILNCp8+nmx5YzV5gibapHL/0VSeNe4TbzqlV7e
	ry4NRX7PkB6sPcXhMVkvceaN6AebrNjxHcawUngvkgQW3iPtQunO2YD2tzEP4E0bMuj+srMC/WI
	I4GQWWkF01e7iIpv1286okGCBUJ4pP9VyqrpN12r+hT8q1AuOReVN90KNrT887kNlrom84D29xg
	+eWPfHweYP32f1opha4BDcmVrARBQHfvG86yxsfqEjXWRYldVtLEOkem0PZu6BfDn1ibAKfa4PI
	G8AyrfT/WQzi5rxyw==
X-Received: by 2002:a05:600c:1d15:b0:49f:e427:e88f with SMTP id 5b1f17b1804b1-4a027564ddemr35404475e9.21.1790928965827;
        Fri, 02 Oct 2026 01:16:05 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380fada5sm3689482f8f.24.2026.10.02.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:16:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Steam Lin <STLin2@winbond.com>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 08/12] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
In-Reply-To: <87o6ddmmc2.fsf@bootlin.com>
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
 <20260930-perso-ma35d1-upstream-clk-v6-8-48937ee6c9bb@bootlin.com>
 <1j7bk13gpq.fsf@starbuckisacylon.baylibre.com>
 <87o6ddmmc2.fsf@bootlin.com>
Date: Fri, 02 Oct 2026 10:16:04 +0200
Message-ID: <1jy0cg1prv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On jeu. 01 oct. 2026 at 18:12, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> On 01/10/2026 at 11:36:33 +02, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>> On mer. 30 sept. 2026 at 19:24, Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
>>
>>> HXT and LXT are crystal oscillator inputs of the clock controller, they
>>> are described in the DT, so retrieve them, in order, and store them in
>>> their respective HXT/LXT hw table entries.
>>>
>>> Since old DTs reference the HXT fixed-clock without naming it and do not
>>> describe LXT at all, we assume that HXT must be present, and fallback to
>>> creating a fixed clock for LXT if it is not described (for backward
>>> compatibility purposes).
>>>
>>> The downstream gate clocks can directly use the hw clocks as parents,
>>> instead of relying on string matching.
>>>
>>> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock c=
ontroller")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>  drivers/clk/nuvoton/clk-ma35d1.c | 43 ++++++++++++++++++++++++++++++++=
--------
>>>  1 file changed, 35 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk=
-ma35d1.c
>>> index ceebcbd8c18b..d955d79abdd2 100644
>>> --- a/drivers/clk/nuvoton/clk-ma35d1.c
>>> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
>>> @@ -4,6 +4,7 @@
>>>   * Author: Chi-Fang Li <cfli0@nuvoton.com>
>>>   */
>>>=20=20
>>> +#include <linux/clk.h>
>>>  #include <linux/clk-provider.h>
>>>  #include <linux/mfd/syscon.h>
>>>  #include <linux/module.h>
>>> @@ -191,6 +192,15 @@ static struct clk_hw *ma35d1_clk_gate(struct devic=
e *dev, const char *name, cons
>>>  				    reg, shift, 0, &ma35d1_lock);
>>>  }
>>>=20=20
>>> +static struct clk_hw *ma35d1_clk_gate_parent(struct device *dev, const=
 char *name,
>>> +					     struct clk_hw *parent,
>>> +					     void __iomem *reg, u8 shift)
>>> +{
>>> +	return devm_clk_hw_register_gate_parent_hw(dev, name, parent,
>>> +						   CLK_SET_RATE_PARENT,
>>> +						   reg, shift, 0, &ma35d1_lock);
>>> +}
>>> +
>>>  static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *p=
llmode)
>>>  {
>>>  	const char *of_str;
>>> @@ -215,10 +225,12 @@ static int ma35d1_clocks_probe(struct platform_de=
vice *pdev)
>>>  {
>>>  	struct device *dev =3D &pdev->dev;
>>>  	struct device_node *clk_node =3D pdev->dev.of_node;
>>> +	struct clk_bulk_data *clks;
>>>  	void __iomem *clk_base;
>>>  	static struct clk_hw **hws;
>>>  	static struct clk_hw_onecell_data *ma35d1_hw_data;
>>>  	u32 pllmode[PLL_MAX_NUM];
>>> +	int num_clks;
>>>  	int ret;
>>>=20=20
>>>  	ma35d1_hw_data =3D devm_kzalloc(dev,
>>> @@ -240,12 +252,27 @@ static int ma35d1_clocks_probe(struct platform_de=
vice *pdev)
>>>  		return -EINVAL;
>>>  	}
>>>=20=20
>>> -	hws[HXT] =3D ma35d1_clk_fixed("hxt", 24000000);
>>> -	hws[HXT_GATE] =3D ma35d1_clk_gate(dev, "hxt_gate", "hxt",
>>> -					clk_base + REG_CLK_PWRCTL, 0);
>>> -	hws[LXT] =3D ma35d1_clk_fixed("lxt", 32768);
>>> -	hws[LXT_GATE] =3D ma35d1_clk_gate(dev, "lxt_gate", "lxt",
>>> -					clk_base + REG_CLK_PWRCTL, 1);
>>> +	num_clks =3D devm_clk_bulk_get_all(dev, &clks);
>>> +	if (num_clks < 0)
>>> +		return num_clks;
>>> +
>>> +	if (!num_clks) {
>>> +		dev_err(dev, "missing crystal input clocks\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	hws[HXT] =3D __clk_get_hw(clks[0].clk);
>>
>> Don't open code it. use .fw_name
>
> Ok, if I understand your suggestion, I will go for the use of
>
>     devm_clk_hw_register_fixed_rate_parent_data()
>
> for these fixed clocks.
>
>>
>>> +
>>> +	if (num_clks > 1)
>>> +		hws[LXT] =3D __clk_get_hw(clks[1].clk);
>>> +	else
>>> +		/* Old DTs do not describe the low-speed crystal */
>>> +		hws[LXT] =3D ma35d1_clk_fixed("lxt", 32768);
>>
>> I'd give it another name so you can clearly see the difference between t=
he
>> DT one and the manually registered one.
>>
>>> +
>>
>> Don't need to open code this either.
>> provide both .fw_name and .name - CCF will fallback to the name.
>>
>> When you want to conditionally register the fixed is up to you.
>
> Ok, so if my understanding is correct, I should use parent data with:
> * .fw_name being the clock-names entry
> * .name being the name of the clock that will be created ex-nihilo
> Am I correct? And clock-output-names in that case has no importance at
> all (hence this strengthen my wish to get rid of it)?

Yes

>
> In the fallback case, what naming makes sense? I don't know. I would
> have preferred to just name it "hxt" (respectively "lxt") in both cases
> because we truly don't care about the name, except it would be nicer for
> the reader of clk_summary. Do you mind if I keep "hxt"/"lxt" for both?

Picking another name is merely a suggestion. I don't have a strong opinion
over this.

>
> Thanks a lot for the hints!
> Miqu=C3=A8l

--=20
Jerome
