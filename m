Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412A3C1400;
	Thu,  1 Oct 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871165; cv=none; b=J0+BcArSuiQ1UvbhJgO4r4B535tW92p5wMkaeXHn7XCYqJxEWcX9AnQ7HLrqGYc4c1ZmKsGKWRE09FD1LK78nw/ArOP62eyCxMelSQC7ZrszsNBws9beRzwe/rUKmhBhuXksElGFqP2Y1unnZC0+GqfZO2J1KxqOya9VdS8PeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871165; c=relaxed/simple;
	bh=ka874H3cfxETDUqsV+uwIEcCwZa8EM9XwB8xJX1dSAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lTLR84w5vFZ5yEUQEpPRe+Z24Xz3X1WHG8K4IHXLlIZl8mMr9s29ETSlDZWUzvM2ukpD03G2aqZxvIcMnsfT/+paaepIo1E7q4qDaYlUBZtx2cD+iRt4dpmtiOACwYAunW+ENODBc31W0Y1YrD2bhtBCAtzokmFR6i4S6duD8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R8kSheh5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R8kSheh5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CF65D1A1458;
	Thu,  1 Oct 2026 16:12:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FB4160343;
	Thu,  1 Oct 2026 16:12:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4B5A103282A7;
	Thu,  1 Oct 2026 18:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790871157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BFgFgmJeZliuTaE95NHJ21R0tItMIZqm1nC1CcwqcAY=;
	b=R8kSheh5qpYXPb5+qnU/aZgN19+5zjzf79rXO5j1MDaBEr16DX5HFXmvvfC4i8WFKJReR0
	OVuCLQcRxsQvCh6/UfUXkR8dyvVkfGPytEoLSA3wR5tfe/jJqhTmrLVUCNGnNoqcjQgztY
	925PxiB7aZDCYY6Q4sPhoUZ5ZkI70ZAME6vqEmlB2TEb9tcyY3k/f10/XF5pPdtNK3kGBB
	VOnn+oL5VXMAPF+MDOTf0g5FTOwcALudFrp5Dkx2bdNt2KFkvvbtw/sU9uTnN0Tq+dwIpI
	YJo8ZbEaUfEPxBQ5/+hmlM6qT56bKq0EpoIiegxjAJoIgZqYtNrGCroCookNFQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Richard Cochran
 <richardcochran@gmail.com>,  Arnd Bergmann <arnd@arndb.de>,  Brian Masney
 <bmasney+clk@redhat.com>,  Jerome Brunet <jbrunet+clk@baylibre.com>,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-arm-kernel@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Krzysztof Kozlowski <krzk@kernel.org>,
  devicetree@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v6 08/12] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT
In-Reply-To: <1j7bk13gpq.fsf@starbuckisacylon.baylibre.com> (Jerome Brunet's
	message of "Thu, 01 Oct 2026 11:36:33 +0200")
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
	<20260930-perso-ma35d1-upstream-clk-v6-8-48937ee6c9bb@bootlin.com>
	<1j7bk13gpq.fsf@starbuckisacylon.baylibre.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 01 Oct 2026 18:12:29 +0200
Message-ID: <87o6ddmmc2.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 01/10/2026 at 11:36:33 +02, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On mer. 30 sept. 2026 at 19:24, Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
>
>> HXT and LXT are crystal oscillator inputs of the clock controller, they
>> are described in the DT, so retrieve them, in order, and store them in
>> their respective HXT/LXT hw table entries.
>>
>> Since old DTs reference the HXT fixed-clock without naming it and do not
>> describe LXT at all, we assume that HXT must be present, and fallback to
>> creating a fixed clock for LXT if it is not described (for backward
>> compatibility purposes).
>>
>> The downstream gate clocks can directly use the hw clocks as parents,
>> instead of relying on string matching.
>>
>> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock co=
ntroller")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/clk/nuvoton/clk-ma35d1.c | 43 ++++++++++++++++++++++++++++++++-=
-------
>>  1 file changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-=
ma35d1.c
>> index ceebcbd8c18b..d955d79abdd2 100644
>> --- a/drivers/clk/nuvoton/clk-ma35d1.c
>> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
>> @@ -4,6 +4,7 @@
>>   * Author: Chi-Fang Li <cfli0@nuvoton.com>
>>   */
>>=20=20
>> +#include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/module.h>
>> @@ -191,6 +192,15 @@ static struct clk_hw *ma35d1_clk_gate(struct device=
 *dev, const char *name, cons
>>  				    reg, shift, 0, &ma35d1_lock);
>>  }
>>=20=20
>> +static struct clk_hw *ma35d1_clk_gate_parent(struct device *dev, const =
char *name,
>> +					     struct clk_hw *parent,
>> +					     void __iomem *reg, u8 shift)
>> +{
>> +	return devm_clk_hw_register_gate_parent_hw(dev, name, parent,
>> +						   CLK_SET_RATE_PARENT,
>> +						   reg, shift, 0, &ma35d1_lock);
>> +}
>> +
>>  static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *pl=
lmode)
>>  {
>>  	const char *of_str;
>> @@ -215,10 +225,12 @@ static int ma35d1_clocks_probe(struct platform_dev=
ice *pdev)
>>  {
>>  	struct device *dev =3D &pdev->dev;
>>  	struct device_node *clk_node =3D pdev->dev.of_node;
>> +	struct clk_bulk_data *clks;
>>  	void __iomem *clk_base;
>>  	static struct clk_hw **hws;
>>  	static struct clk_hw_onecell_data *ma35d1_hw_data;
>>  	u32 pllmode[PLL_MAX_NUM];
>> +	int num_clks;
>>  	int ret;
>>=20=20
>>  	ma35d1_hw_data =3D devm_kzalloc(dev,
>> @@ -240,12 +252,27 @@ static int ma35d1_clocks_probe(struct platform_dev=
ice *pdev)
>>  		return -EINVAL;
>>  	}
>>=20=20
>> -	hws[HXT] =3D ma35d1_clk_fixed("hxt", 24000000);
>> -	hws[HXT_GATE] =3D ma35d1_clk_gate(dev, "hxt_gate", "hxt",
>> -					clk_base + REG_CLK_PWRCTL, 0);
>> -	hws[LXT] =3D ma35d1_clk_fixed("lxt", 32768);
>> -	hws[LXT_GATE] =3D ma35d1_clk_gate(dev, "lxt_gate", "lxt",
>> -					clk_base + REG_CLK_PWRCTL, 1);
>> +	num_clks =3D devm_clk_bulk_get_all(dev, &clks);
>> +	if (num_clks < 0)
>> +		return num_clks;
>> +
>> +	if (!num_clks) {
>> +		dev_err(dev, "missing crystal input clocks\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	hws[HXT] =3D __clk_get_hw(clks[0].clk);
>
> Don't open code it. use .fw_name

Ok, if I understand your suggestion, I will go for the use of

    devm_clk_hw_register_fixed_rate_parent_data()

for these fixed clocks.

>
>> +
>> +	if (num_clks > 1)
>> +		hws[LXT] =3D __clk_get_hw(clks[1].clk);
>> +	else
>> +		/* Old DTs do not describe the low-speed crystal */
>> +		hws[LXT] =3D ma35d1_clk_fixed("lxt", 32768);
>
> I'd give it another name so you can clearly see the difference between the
> DT one and the manually registered one.
>
>> +
>
> Don't need to open code this either.
> provide both .fw_name and .name - CCF will fallback to the name.
>
> When you want to conditionally register the fixed is up to you.

Ok, so if my understanding is correct, I should use parent data with:
* .fw_name being the clock-names entry
* .name being the name of the clock that will be created ex-nihilo
Am I correct? And clock-output-names in that case has no importance at
all (hence this strengthen my wish to get rid of it)?

In the fallback case, what naming makes sense? I don't know. I would
have preferred to just name it "hxt" (respectively "lxt") in both cases
because we truly don't care about the name, except it would be nicer for
the reader of clk_summary. Do you mind if I keep "hxt"/"lxt" for both?

Thanks a lot for the hints!
Miqu=C3=A8l
