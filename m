Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324742CAFC;
	Fri,  7 Aug 2026 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099977; cv=none; b=s97jP0b4MvLVCNDkuXF+v5y4+8PcJHVQlFJy5sKzagj+g4U/7wY/IVfAZ+b4gGXPrR2/caMnpiI8DQkh/Z8Gkbm/lRKDgnAy5o7T2k6BHa+jcVk6iBfBy7iTMY/mErs1H+Xb8QsB6B1hwQVuW3aMuJ2TPqKP8A2DAPDJjZdIt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099977; c=relaxed/simple;
	bh=Hci5B3HoXZYM1gVfIlAaPk+u9hbcO8AFAEieO41GUvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk30lT7ZA62CgFnJEx34n8bU19l2iS+hKG8MgEAhEF1HQW5j9OtXmNc5TbSj2svkjSlsxZ5fkP+kdgAo1LNnwFwn38OkXYQTMq0ct/FJ6PXyAV5mSDsPgo3ioosNwPxZpD9bQw0Ghy4QCOnDrd4x4ESOalOalO6c2GXFrEbjEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q/hkMmgu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q/hkMmgu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 353B44E41089;
	Fri,  7 Aug 2026 10:52:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F310D603F0;
	Fri,  7 Aug 2026 10:52:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED3D411C375E6;
	Fri,  7 Aug 2026 12:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786099968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=udsIZByR6nXrBMYeuDGR7VhqRs+/z5Z8JQt5P+St6UM=;
	b=q/hkMmgublUw0TZYsw8Ko4mhUC4l005Ze0dg0njiYvqXrdLcNHmc52ikR7xnDZP/qoUe2L
	dt95Zf/2ayi4lKWhRHKoBM/Z5CtGDaw/hhM906YqifV+uFMVBwoY37lHTVaCAlVI5Vwjaj
	lVtYgPkjxd+1eRiZEXXg7JuEzLC+DpMnuoTMaYa5IWSrlEsBmdCvG7P0Pf2aSojMA7iwpj
	qzc42rn/x+dpRf/ogMpRRPIvphqeFAXB2IyPbRiViV4BHEj3lylMUFbgWxUeNY7bWvluao
	VRjHKS+bgt3r3oo/SXttfMgFP15trG2dvV9+GwNG2WYFsYpX+O3ltAipCAAd+A==
Message-ID: <fe783935-3759-4dc3-87bb-59681d24e087@bootlin.com>
Date: Fri, 7 Aug 2026 12:52:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
To: Adrian Hunter <adrian.hunter@intel.com>, "Mendez, Judith" <jm@ti.com>,
 Ulf Hansson <ulfh@kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pascal EBERHARD <pascal.eberhard@se.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
 <20260803-am654-sdhci-v2-4-a5ee5be86133@bootlin.com>
 <4721675e-e3ae-4e81-89db-eb0f7f419d1e@ti.com>
 <6fc6216a-5e57-4df5-9033-d3573409ed78@bootlin.com>
 <9cdf448b-436c-404f-bf72-b946204629a8@ti.com>
 <fe3c58b1-5b34-444c-8149-e9a836f0a303@intel.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <fe3c58b1-5b34-444c-8149-e9a836f0a303@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Adrian,

On 8/7/26 8:35 AM, Adrian Hunter wrote:
> On 06/08/2026 02:13, Mendez, Judith wrote:
>> Hi Diogo,
>>
>> On 8/4/2026 3:45 AM, Diogo Ivo wrote:
>>> Hi Judith,
>>>
>>> Thanks for the review!
>>>
>>> On 8/3/26 9:59 PM, Mendez, Judith wrote:
>>>> Hi Diogo,
>>>>
>>>> Thanks for your patch, couple of doubts below.
>>>>
>>>> On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
>>>>> DDR50 mode is not required to support the tuning command CMD19, meaning
>>>>> that calibration may fail on cards that do not implement it, in which
>>>>> case a known-good itap delay value should be programmed into the host
>>>>> controller.
>>>>>
>>>>> Do this by reading the (already defined) itap delay DT property for DDR50
>>>>> and, if tuning fails for this mode, fall back to the DT-provided itap delay
>>>>> value. If the DT does not provide a value for DDR50 fallback then this
>>>>> simply disables using itapdly.
>>>>>
>>>>> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
>>>>
>>>> Should this commit be the one to blame or should it be the commit that
>>>> introduces DDR50 support?
>>>
>>> I'm not sure I follow you here, as I wasn't able to pinpoint a commit
>>> that specifically introduced support for DDR50. Could you please clarify?
>>>
>>> Taking a look at the git log of the driver I see a0a62497f6aa, where
>>> reading itapdly from DT was added but without reading the DDR50 value
>>> and 13ebeae68ac9, the commit where tuning was originally added, but the
>>> "responsibility" seems split between the two.
>>
>> Yea I think because each of the three commits in question are adding
>> support for something else. This bug fix that you are sending was never
>> really discovered or debugged before. IMO (: Not sure if this requires
>> a fixes tag then.
>>
>> I will let Adrian or someone else decide what to do here. ^.^
> 
> The Fixes tag tells people whether they might need to backport the
> patch.  It says "if you need Fixes commit then you need this commit too".
> 
> It should be the first commit where DDR50 could fail because of this issue.

Sounds good. In that case commit 901d16e46296 ("mmc: sdhci_am654: Add retry
tuning") is the correct commit, since before it the code was writing itap=0
in the case where tuning failed. I have also tested the driver before and
after 901d16e46296 and it is indeed the commit that breaks I/O. I will
send a v3 with the debug print suggested by Judith.

Best regards,
Diogo

>>
>> ~ Judith
>>
>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>    - As suggested by Sashiko save values read from DT for DDR50 in separate
>>>>>      variables in order to keep them across multiple tuning cycles without
>>>>>      overwriting them.
>>>>> ---
>>>>>    drivers/mmc/host/sdhci_am654.c | 25 ++++++++++++++++++++-----
>>>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/ sdhci_am654.c
>>>>> index 8ce10422bba0..27ef79420eba 100644
>>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>>> @@ -126,7 +126,7 @@ static const struct timing_data td[] = {
>>>>>                       NULL,
>>>>>                       MMC_CAP_UHS_SDR104},
>>>>>        [MMC_TIMING_UHS_DDR50]    = {"ti,otap-del-sel-ddr50",
>>>>> -                   NULL,
>>>>> +                   "ti,itap-del-sel-ddr50",
>>>>>                       MMC_CAP_UHS_DDR50},
>>>>>        [MMC_TIMING_MMC_DDR52]    = {"ti,otap-del-sel-ddr52",
>>>>>                       "ti,itap-del-sel-ddr52",
>>>>> @@ -144,6 +144,8 @@ struct sdhci_am654_data {
>>>>>        u32 otap_del_sel[ARRAY_SIZE(td)];
>>>>>        u32 itap_del_sel[ARRAY_SIZE(td)];
>>>>>        u32 itap_del_ena[ARRAY_SIZE(td)];
>>>>> +    u32 itap_del_sel_dt_ddr50;
>>>>> +    u32 itap_del_ena_dt_ddr50;
>>>>>        int clkbuf_sel;
>>>>>        int trm_icp;
>>>>>        int drv_strength;
>>>>> @@ -579,10 +581,18 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>>>>        } while (++tuning_loop < RETRY_TUNING_MAX);
>>>>>        if (itapdly < 0) {
>>>>> -        dev_err(dev, "Failed to find itapdly, fail tuning\n");
>>>>> -        sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
>>>>> -        sdhci_am654->itap_del_ena[timing] = 0;
>>>>> -        sdhci_am654->itap_del_sel[timing] = 0;
>>>>> +        if (timing == MMC_TIMING_UHS_DDR50) {
>>>>
>>>> Should dev_dbg be added here to let the user know that tuning failed but
>>>> DT defaults were set?
>>>
>>> That sounds useful, I'll add a print here.
>>>
>>>> ~ Judith
>>>>
>>>
>>> Best regards,
>>> Diogo
>>
> 
