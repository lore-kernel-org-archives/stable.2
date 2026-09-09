Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6D53ED07;
	Wed,  9 Sep 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952699; cv=none; b=gM/mCUi5JXUlOqwhuvv7juQ1ierGLzVUmvMxZ6e6qp9vp3dL+kY5Vi/v+4A63HEDeAJBeBgB1a2snTs4YHqtY3eWZFtN389w/+DuNCQu/684UCBtT8eElCMCxmt3GIPWd+UDcACgTaWgwg7iO8o/CMLpZLm9W91xA8YNxNz+pno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952699; c=relaxed/simple;
	bh=CeuyHAdXSMKYba/pxpASw1tZT86hlAGRnF6kiA1JTIo=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=Q3ooB8pqPkc8VNQ7R6sD6cnUvMMLxamI6KMSeJu5wM+yZa+PmT2/KyQjX6sx1q8JZfu/d5uB3zcIkwmXDrqNdTburtqMjRDffAfXQsLCTExb+D9qpQmQks71TZaDre/G2MFMxeBzdd8PVesZxs/qqwL31IESrLFxjXnLwBg/Tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=aPL2Gl9l; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aPL2Gl9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=2+G3GOCnrTRmVz6JASGr0p2d2fHHRQdn/hOPCjtmJiU=;
	b=aPL2Gl9l85qSLA2erk5mimQKBMuMufmacdw/Yrr1GXLO+LsSncvnqRutdH4fcg
	oqv5GqUcT8P0YxaSm3WHTKgkCopulGa3giaAUWaakCFgl7j1A8fjqlQIvcgxMoi/
	sJyjCQfWSaPSZ3KgT3/6FPP6CZGqGBni3oiPh4o6fI9Xk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDX175BQKFqkFKgAw--.46613S2;
	Wed, 09 Sep 2026 19:17:22 +0800 (CST)
Message-ID: <6AA14022.6070905@126.com>
Date: Wed, 09 Sep 2026 19:16:50 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: vkoul@kernel.org, neil.armstrong@linaro.org, johan@kernel.org, 
 kishon@kernel.org, rogerq@ti.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 4/4] phy: ti-pipe3: Fix clock leak in init error path
References: <20260619030214.1779043-1-zenghongling@kylinos.cn> <20260619030214.1779043-5-zenghongling@kylinos.cn> <lsywnpxioldkbvb6n7pi6uihlnofjdwrhvm7yt3qiarori4hua@c6wueslryla4>
In-Reply-To: <lsywnpxioldkbvb6n7pi6uihlnofjdwrhvm7yt3qiarori4hua@c6wueslryla4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX175BQKFqkFKgAw--.46613S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar13urWrXrWxXr4UCr4kJFb_yoW5JF18pr
	nxWa1qkrn5tayv93Wftr1UX34Fy393Kay3CF1UKw1rZ3Z8Cr1kWFW7Krs8ur1DCr4DCF4S
	va1UJFnIk3WUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Hq7UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrwIj82qhQEIvdAAA3v


在 2026年09月09日 15:58, Manivannan Sadhasivam 写道:
> On Fri, Jun 19, 2026 at 11:02:14AM +0800, Hongling Zeng wrote:
>> When regmap_update_bits() fails in ti_pipe3_init() for PCIe mode,
>> the function returns the error without calling ti_pipe3_disable_clocks().
>> This leaves the clocks permanently enabled since the PHY framework won't
>> invoke the .exit callback on init failure.
>>
>> Fix this by adding proper clock cleanup in the PCIe error path, consistent
>> with how the DPLL program error path handles cleanup.
>>
>> Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
>> Reported-by: Sashiko AI <sashiko@kernel.org>
>> Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> Cc: stable@vger.kernel.org
>>
>> ---
>> Change in v5:
>>    -Add Fix ignored clock enable return value in init patch
>> ---
>> Change in v6:
>>   -Fix all clock leak paths comprehensively:
>>   -PCIe syscon update failure path
>>   -SATA DPLL lock check path
>>   -SATA errata path in ti_pipe3_exit()
>> ---
>>   drivers/phy/ti/phy-ti-pipe3.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
>> index 9ec228c2a940..860058f31594 100644
>> --- a/drivers/phy/ti/phy-ti-pipe3.c
>> +++ b/drivers/phy/ti/phy-ti-pipe3.c
>> @@ -518,6 +518,8 @@ static int ti_pipe3_init(struct phy *x)
>>   		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
>>   		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
>>   					 PCIE_PCS_MASK, val);
>> +		if (ret)
>> +			ti_pipe3_disable_clocks(phy);
>>   		return ret;
>>   	}
>>   
>> @@ -531,8 +533,9 @@ static int ti_pipe3_init(struct phy *x)
>>   
>>   	/* SATA has issues if re-programmed when locked */
>>   	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
>> -	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA)
>> -		return ret;
>> +	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA) {
>> +		return 0;
> Why are you returning 0 here and below?
>
> - Mani
>
Hi Mani,

Thanks for pointing this out.

You're right. Changing the SATA PLL-locked path from `return ret` to
`return 0` was an unintended change and is not related to the clock leak
fix. I'll restore the original code in the next version:

     if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA)
         return ret;

Thanks,
Hongling


