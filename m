Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F678379C36
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711114; cv=none; b=IZ2+VC03HZs0A3x843VB+Q7MXKjdeRteEYpXz9Gp2oxlR6Q8nW2TjDzRIyvE/xTcy+tbU71znvFb7a/WS9PAh/5+iwVBesRC6woevgQ0n0WbmwfQbgf+ILrBr0ubHFnMo+sOQ9theUGjrR32Zjfn41ckpVWF8CbOMrwDvrQwX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711114; c=relaxed/simple;
	bh=Pkzq93VysouvMV4sOok85BWiz22/o2bRhcPNPa9P+iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keNl9NmF3nisDIU4e/FTSbpHmZ5TjttZKEZlMe2bBhe501CKAwJ7tAqzq+02zUz90HXepcO7NgqUlWyiNINBaIDTWy4I4EflDVaGA2wi4OkVT9yYOcftDZ4xS0TGJi6xWk4o4t4/AO4xLw/GjRTqbRuDkksQ7dNaLzwkVfvI1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e8qdxb7d; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8qdxb7d"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51bfbe05683so7687721cf.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711110; x=1784315910;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ivQlEJtZ0zxa8yf3dIj+FATasL8wavCjCs0e2VSoqvc=;
        b=S1LmmC+DXgxiAoG2i3MPHVRETJJIDrG3BRGbVfMs1xNgPycrtDaUOVUVT9oyvleJqx
         4q6tC4ddOM2foJLvSAmiZvQ7dhtoa6Dou0FS9HpDjj7bqSpMKdymN+jE1ifiVPdnoue4
         rE7AwrhQGImr2RiZn+SqF3VsXRWv/o7e3pc960TLQbdU1MAdyGUyfC+YF714P95S+t3n
         bYiMwuL91Rtgj4Ww2TC3zMNiMGd89mLZIJASWiOVWU+tHPM2JO2HJj+pUJssgcNh6XN4
         z/nfwfRCV86oy8ijQwQmH0YCukf1kXpM42vJMUov0BZVkCKNaJK8TnArzHjelG/WnoDd
         fqpA==
X-Forwarded-Encrypted: i=1; AHgh+RoJaEVWfs7XeNirTDzp9o4lvO6+OUPU5miS+BkTEH5HoHf8Rm7gcj+hiICuAdp2bv1UjUKSxgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnCyBfuGkHVhrwpCQMqpL784FxGKvutOUnEzs05RuVIuKW+U6
	6hb+wJCHyb7tGiEiO7WuMN3z1yAWBUXRnyN726OD+28p+VHCnFU9tsKg4BoL7KrReMoMzVKB9d6
	5YKuaLjha08wJy0hEDQBbpn/v91Md0RPzKz50pOTlc+bnVNwN3O4pHI4M7LMDx5g1xYmLQ8Br4F
	WasKaLNte52xj2LwQNF2kInHkcXEByqLC/FmefUYMeOEeyzVeFULMHHakWK/viwjfSqLI9G0OGn
	yYGYJP8ErMcZLgdRg==
X-Gm-Gg: AfdE7cmOFCLwP9XksHthjq6jr/+920o8Iz6F8iBMzdlzp7n8lLiZ/DI8R8JIunyuxIf
	IDSu+WPQX4c5XERZCwQIOrFT6RzN/QDqvhdAb3SgNkXGPX09x2RnFpao40HR7/2KMr57gY5eNlk
	/s6dFU+z7y9XLMsTTJbCnCZ8zm9blMUT7nqnx1R+Spl2hHsq7grCTYyP0A3FIdg13aPrv7TRLYN
	6/Fto/tXlrxnM3PrUz5Ws0BVy6ZSdXUrUAbJQTeGL0AlHP3FMTeNpi/pbw7/I6Fd7J9OZJUagXu
	o6BqsRVyLTCIT7E4dFiBus7bgP80mffPHwEJMrWbS1bdZ74tZ7i36Q1I7M5SL86fFWmYfeZdvSE
	OXP6iv0NCySEiR1jDMIYdWDSVa0UBgG0WDhIgC/OJThf9qWm8u5PpdRkr9tIN6kWlekKRQsZVla
	IYw9jJmS04Nvn9nY4ehHm+omFkzDe3oS28iWBTbYUMV84qrbvOeQ==
X-Received: by 2002:a05:622a:1b1d:b0:517:6d6c:187f with SMTP id d75a77b69052e-51cbf0df52amr2793211cf.14.1783711110039;
        Fri, 10 Jul 2026 12:18:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ffd2c76d91sm3438756d6.0.2026.07.10.12.18.29
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2026 12:18:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38001e788d6so2250572a91.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783711109; x=1784315909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivQlEJtZ0zxa8yf3dIj+FATasL8wavCjCs0e2VSoqvc=;
        b=e8qdxb7dumpMHLgGKMHeJYR5u6Ap4uMlT9MNmButbEK7YUz+ompB2Y6ZW43NcqZFdi
         WIbhKhAO+rjkJk5rrL8OaTqRW0YxOYRTbAPfCKbdWyc2vg1HXX4d9BPUUAGrJmz9uZCK
         TrIR+xMEInce6m4NkWY/V/43rWnAaabg83Cl4=
X-Forwarded-Encrypted: i=1; AHgh+RpCFKaAHf+9XWIeIGlSDOURU1f4ztBhTXYnGCk1OEjygwxOgm2A8Wx/snrQqSfGn4drgOzNhbg=@vger.kernel.org
X-Received: by 2002:a17:90b:3805:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38dc77ee67cmr215920a91.21.1783711108640;
        Fri, 10 Jul 2026 12:18:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3805:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38dc77ee67cmr215891a91.21.1783711108045;
        Fri, 10 Jul 2026 12:18:28 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311838c9235sm39074609eec.21.2026.07.10.12.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 12:18:27 -0700 (PDT)
Message-ID: <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
Date: Fri, 10 Jul 2026 21:18:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
To: Eddie Phillips <eddiephillips@google.com>, Fan Wu <fanwu01@zju.edu.cn>
Cc: Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
 Wright Feng <wright.feng@infineon.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
 <20260710002451.500112-1-eddiephillips@google.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260710002451.500112-1-eddiephillips@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/07/2026 02:23, Eddie Phillips wrote:
> On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:
> 
>> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
>> drvr->bus_reset, whose callback recovers drvr through container_of()
>> and dereferences it.  The teardown paths free drvr (brcmf_free ->
>> wiphy_free) without draining the work, so a bus_reset callback pending
>> or running during removal can outlive drvr.
>>

[...]

>>
>> This issue was found by an in-house static analysis tool.
>>
>> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
>> Assisted-by: Codex:gpt-5.5
>> ---
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
>>   .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++--
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
>>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>   7 files changed, 66 insertions(+), 2 deletions(-)

[...]

>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> index fed9cd5f2..b934feb9b 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
>>   	return 0;
>>   }
>>   
>> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed) against the
>> + * teardown drain: the remove path takes bus_reset_lock, sets ->removing and cancels
>> + * the work under it, so a racing armer either schedules before the cancel (and is
>> + * drained) or observes ->removing and desists.
>> + */
>> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
>> +{
>> +	mutex_lock(&bus_if->bus_reset_lock);
>> +	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
>> +		schedule_work(&bus_if->drvr->bus_reset);
>> +	mutex_unlock(&bus_if->bus_reset_lock);
>> +}
> 
> Is this safe in a softIRQ context?
> mutex_lock() sleeps until it can get the lock.

What softIRQ context? brcmf_fw_crashed() is called by PCIe (thread) and 
SDIO (worker).
>> +
>> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
>> +{
>> +	mutex_lock(&bus_if->bus_reset_lock);
>> +	bus_if->removing = true;
>> +	if (bus_if->drvr)
>> +		cancel_work_sync(&bus_if->drvr->bus_reset);
>> +	mutex_unlock(&bus_if->bus_reset_lock);
>> +}
> 
> How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> path is already running, it can invoke the worker thread. Is there
> potential that both try to reset?

What is "both" here?
Regards,
Arend
