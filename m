Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F21343896;
	Thu, 13 Aug 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591570; cv=none; b=bTxjRMvU9f01SUaLPEvYnlH12NElQub5g/80cF3kWbgBkkK0jjaOMbFGhh+ePbz+4qnTQ35Bv49bWkDg/ypSJiavGqvB5aTFx8yGpuMyY2HKQP13hJdv0RJtlkKxamox2rBYiAXl7qtdhbY7JX29DYO0qU3WvQBDImRO1c2UwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591570; c=relaxed/simple;
	bh=h2uxDNeoSu5cIxSdf79jgMoNXAs1VFqo6QCLDgzhuOI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=peCU2PQdhP9zOmAtTCFXM5dJNDcuWMFVEcns9keEOsMQa9o50xha5ak0ueEetlxmkOqd7HQs7CN4eB+L3BauKzrLknItodKE67UopEOvOaWzwArl5WM7QzgBbvAy6jrP0xhSKXROJtIL0L8/Bri6SXZAS6JOyB5zNZZuihH6Dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b3a7dec096c611f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7fea67af-adbc-46fc-bda5-31a0ebd4007c,IP:0,U
	RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:a7435a22c99046ef5c7514087897a004,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:11|85|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3a7dec096c611f1aa26b74ffac11d73-20260813
X-User: luoxueqin@kylinos.cn
Received: from [10.42.13.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoxueqin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1752279995; Thu, 13 Aug 2026 11:25:58 +0800
Message-ID: <043577d0-4b42-43c7-be7b-abcedbbffc46@kylinos.cn>
Date: Thu, 13 Aug 2026 11:25:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: luoxueqin <luoxueqin@kylinos.cn>
Subject: Re: [PATCH v2] usb: typec: ucsi: Add ACPI_COMPANION() NULL check in
 ucsi_acpi_probe
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, pooja.katiyar@intel.com, johan@kernel.org,
 pmenzel@molgen.mpg.de, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811095827.1001654-1-luoxueqin@kylinos.cn>
 <anw-41p6cVPQyrDP@black.igk.intel.com>
Content-Language: en-US
In-Reply-To: <anw-41p6cVPQyrDP@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heikki,

Thanks for the review.

However, I'd like to point out that this exact issue has been recognized
as a security vulnerability (CVE-2026-64227), and Rafael already applied
the same fix pattern to 14 ACPI platform drivers in commit e4865a56d013
("ACPI: driver: Check ACPI_COMPANION() against NULL during probe"), which
is marked for stable backport.

The NULL pointer dereference triggers a kernel oops/panic - a full system
crash - not just a silent failure. Returning -ENODEV is the correct and
graceful behavior, consistent with all other drivers fixed in that commit.

Could you please reconsider?

Best regards,
Xueqin Luo

在 2026/8/12 17:37, Heikki Krogerus 写道:
> On Tue, Aug 11, 2026 at 05:58:27PM +0800, Xueqin Luo wrote:
>> Add NULL check for ACPI_COMPANION() in ucsi_acpi_probe() to prevent
>> NULL pointer dereference when driver_override matches a device without
>> ACPI companion.
>>
>> Since every platform driver can be forced to match a device that doesn't
>> match its list of device IDs because of device_match_driver_override(),
>> the ACPI_COMPANION() may return NULL, leading to a NULL pointer
>> dereference at adev->dep_unmet.
>>
>> Test steps:
>>
>>    $ sudo modprobe ucsi_acpi
>>    $ echo ucsi_acpi | sudo tee /sys/bus/platform/devices/alarmtimer.0.auto/driver_override
>>    $ echo alarmtimer.0.auto | sudo tee /sys/bus/platform/drivers/alarmtimer/unbind
>>    $ echo alarmtimer.0.auto | sudo tee /sys/bus/platform/drivers/ucsi_acpi/bind
>>
>> which triggered the following crash:
>>
>>    [ 6599.180948] calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 24208
>>    [ 6599.181198] initcall ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] returned 0 after 207 usecs
>>    [ 6729.051074] BUG: kernel NULL pointer dereference, address: 00000000000005f4
>>    [ 6729.051102] #PF: supervisor read access in kernel mode
>>    [ 6729.051113] #PF: error_code(0x0000) - not-present page
>>    [ 6729.051122] PGD 0 P4D 0
>>    [ 6729.051136] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>    ....
>>    [ 6729.051300] PKRU: 55555554
>>    [ 6729.051306] Call Trace:
>>    [ 6729.051314]  <TASK>
>>    [ 6729.051327]  platform_probe+0x41/0xa0
>>    [ 6729.051348]  really_probe+0x1a9/0x410
>>    [ 6729.051364]  __driver_probe_device+0xc9/0x170
>>    [ 6729.051377]  device_driver_attach+0x46/0xb0
>>    [ 6729.051390]  bind_store+0x77/0xd0
> I don't think kernel can protect the user from everything. I would
> rather keep the NULL pointer dereference than silently fail in this
> kind of cases.
>
> Note that you can use the driver_override like that also with a device
> (not UCSI) that does have the ACPI device node. In that case the probe
> would just continue pass the condition you are introducing below.
>
> Thanks,
>
>> Fixes: 1f3546ff3f0a ("usb: typec: ucsi: acpi: Check the _DEP dependencies")
>> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/usb/typec/ucsi/ucsi_acpi.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> index 18286d3e9cc5..b4a783217dc6 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> @@ -188,7 +188,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>>   
>>   static int ucsi_acpi_probe(struct platform_device *pdev)
>>   {
>> -	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	struct acpi_device *adev;
>>   	const struct ucsi_operations *ops = &ucsi_acpi_ops;
>>   	const struct dmi_system_id *id;
>>   	struct ucsi_acpi *ua;
>> @@ -196,6 +196,10 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>>   	acpi_status status;
>>   	int ret;
>>   
>> +	adev = ACPI_COMPANION(&pdev->dev);
>> +	if (!adev)
>> +		return -ENODEV;
>> +
>>   	if (adev->dep_unmet)
>>   		return -EPROBE_DEFER;
>>   
>> -- 
>> 2.43.0
