Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD7367F2F;
	Tue,  4 Aug 2026 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833156; cv=none; b=Q4oIZh8XnW67vWU/JQA1IsN4k6zsF3kRiER2fvTS2fFdiXrmw7xvvMCkTM5ktyMbYZQRf7G0hVZSWvcLNeKomx0jE8nu5fmDxdC+KvRAmaefY53T9D4T0l8O5/5TzJpB1ILQhQA7gnOS3TZyJejUbdjLE3Foe4lw+l2onvYZUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833156; c=relaxed/simple;
	bh=S//OlL8n6dGgAq9CSHuh2ghfxRpqCbbXnwB/NP+WXjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJOAJ7iAuYl/oDlJB6wOGFJwr14feBhWBCm9aTPknDQf/tNsBVYRc06F2j3MGUv/ACszyUr9NhfW3dGN/7PBSy9UFjRZO+kEt1DAJY8/zjbiFu3GO5FIm/i4ZUzRI+HKpaLuEiJdW044ym287EW3OvZ3AaMS23H3CMwNLedk7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kygwDI5Y; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kygwDI5Y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6873F1A13F6;
	Tue,  4 Aug 2026 08:45:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 336F66029E;
	Tue,  4 Aug 2026 08:45:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6267611C32665;
	Tue,  4 Aug 2026 10:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785833145; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2IrhJb1f1JY7GIAXVHYDGZwNXTKJIHbIo7dg8wZa84U=;
	b=kygwDI5YHL0kPko+oQd5TbgvAZn80Uz7lUDETgYniRDJbFRWJtnlQPSZK0ChzpMUeNFFl9
	7KO6GJfTrin4r1ETW+cCvea8fsVmtySjZMy7SlpwoINutNm4WXgGNL6p9MLmBg2K0Rza3U
	s5SoyEWBYML9Uxpdhugf3t5ZOUQgyov2Hns/7I8yEZXU4MLaLcajaPW0jQyXrZ0K0JwrJX
	KjDG4lki8XaPjA9JqjqXgLnbmULTeYI1i/WPtgC0WUKf4ARXqHUkfndVLETaIr4TDUk+xW
	1WGORaUmEGxCkkdaa3PdB0FZKzFz/jsPHdkWV8/MLY/NFJX0y+RMtju6UT36Lw==
Message-ID: <6fc6216a-5e57-4df5-9033-d3573409ed78@bootlin.com>
Date: Tue, 4 Aug 2026 10:45:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
To: "Mendez, Judith" <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pascal EBERHARD <pascal.eberhard@se.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
 <20260803-am654-sdhci-v2-4-a5ee5be86133@bootlin.com>
 <4721675e-e3ae-4e81-89db-eb0f7f419d1e@ti.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <4721675e-e3ae-4e81-89db-eb0f7f419d1e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Judith,

Thanks for the review!

On 8/3/26 9:59 PM, Mendez, Judith wrote:
> Hi Diogo,
> 
> Thanks for your patch, couple of doubts below.
> 
> On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
>> DDR50 mode is not required to support the tuning command CMD19, meaning
>> that calibration may fail on cards that do not implement it, in which
>> case a known-good itap delay value should be programmed into the host
>> controller.
>>
>> Do this by reading the (already defined) itap delay DT property for DDR50
>> and, if tuning fails for this mode, fall back to the DT-provided itap 
>> delay
>> value. If the DT does not provide a value for DDR50 fallback then this
>> simply disables using itapdly.
>>
>> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
> 
> Should this commit be the one to blame or should it be the commit that
> introduces DDR50 support?

I'm not sure I follow you here, as I wasn't able to pinpoint a commit
that specifically introduced support for DDR50. Could you please clarify?

Taking a look at the git log of the driver I see a0a62497f6aa, where
reading itapdly from DT was added but without reading the DDR50 value
and 13ebeae68ac9, the commit where tuning was originally added, but the
"responsibility" seems split between the two.

>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
>> ---
>> Changes in v2:
>>   - As suggested by Sashiko save values read from DT for DDR50 in 
>> separate
>>     variables in order to keep them across multiple tuning cycles without
>>     overwriting them.
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/ 
>> sdhci_am654.c
>> index 8ce10422bba0..27ef79420eba 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -126,7 +126,7 @@ static const struct timing_data td[] = {
>>                      NULL,
>>                      MMC_CAP_UHS_SDR104},
>>       [MMC_TIMING_UHS_DDR50]    = {"ti,otap-del-sel-ddr50",
>> -                   NULL,
>> +                   "ti,itap-del-sel-ddr50",
>>                      MMC_CAP_UHS_DDR50},
>>       [MMC_TIMING_MMC_DDR52]    = {"ti,otap-del-sel-ddr52",
>>                      "ti,itap-del-sel-ddr52",
>> @@ -144,6 +144,8 @@ struct sdhci_am654_data {
>>       u32 otap_del_sel[ARRAY_SIZE(td)];
>>       u32 itap_del_sel[ARRAY_SIZE(td)];
>>       u32 itap_del_ena[ARRAY_SIZE(td)];
>> +    u32 itap_del_sel_dt_ddr50;
>> +    u32 itap_del_ena_dt_ddr50;
>>       int clkbuf_sel;
>>       int trm_icp;
>>       int drv_strength;
>> @@ -579,10 +581,18 @@ static int 
>> sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>       } while (++tuning_loop < RETRY_TUNING_MAX);
>>       if (itapdly < 0) {
>> -        dev_err(dev, "Failed to find itapdly, fail tuning\n");
>> -        sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
>> -        sdhci_am654->itap_del_ena[timing] = 0;
>> -        sdhci_am654->itap_del_sel[timing] = 0;
>> +        if (timing == MMC_TIMING_UHS_DDR50) {
> 
> Should dev_dbg be added here to let the user know that tuning failed but
> DT defaults were set?

That sounds useful, I'll add a print here.

> ~ Judith
> 

Best regards,
Diogo
