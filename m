Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813765;
	b=34xbTy452nvvU0lBw6w/YoSZzfiq8zgKSItxO+3IakQjIgq9+mcj4JhL1oCRykp19f+e
	 dXCtnPyjzClcyxdalPrOzU0ZuSj0p5RUgwNTioZaMVn5OOw9TuenBhVIo2+ntPFeoSWqa
	 05dSnd+riED6bcTEuCeb8+rlPnA+W1Mhs1d4Nl4oaCZCZ8iSSBTqpPkGBYxhALdaJvJQE
	 9vkSuRK+oc0UDIQbWOAo87upcRYRaYOTT8dzcgQGK3/+/yRi/XAOmh7d0xY9hYMVBzvfr
	 Pr0abFEgVICkv7dHuBlDquuCxMVGbxjCa8frXoqejMYOGeJocisOsNQdOLwRZV176OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813765;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G20Wy6mvQhIhx6DbI6mVst9t/UsYM5tKx7o8MtawhC8=;
	b=2LvNpdNcxqxF10dvbBE//+rE4mBEIJaNC9VOvoIvNC5eSky44/0fE9A3yc/a0cZaAErJ
	 94j7VPqHcA3cQXiUddPa1HIILkAHiEwpuS12IU8vcjTKQkEXAPVogKdsTlxTJzGC95osr
	 bC/HxY7CWMakOn1YCECv7PaGCAeYR/W9R3TXRbZwxvA7LcVJRE8xNGCrRF5kyZuLcee0J
	 ybag1MflbcmQSI+1juka/RyMsO6JUVirR/QOtll/DrWiZ/5KBJs/3QUJ6QmsAYeb4pURK
	 sTdiJWeiqeixdUP/1IKvsJrEZhw0xyRhTXSjo4tWdgFjwvSpjEuKS302QcmdR/Rtj5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ndfZr0Qf;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F82606ECC0;
	Wed,  4 Nov 2026 17:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F82606ECC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ndfZr0Qf
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2A391BB0;
	Wed,  4 Nov 2026 09:36:00 -0800 (PST)
Received: from [10.57.90.115] (unknown [10.57.90.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 783133F673;
	Wed,  4 Nov 2026 09:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793813763; bh=8YUIckxR/Kf62QtZ2ufF3DzvzhbMTOa7JbCXcU787hI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ndfZr0Qfl4BmjWFbLIDOfv7FasvdeCY1iV9z4z1mlwaskQYTjslhGpmaPhLOTjzFU
	 AihpTEpECsvh4sn6Rx9EoLuW14kAiy4hZEduQSYinChn7Nz4vrSYooKESOowNOJmSQ
	 QiDM1orkqob7nAvLCkHGiY7JpvCAU51GAtv86Hxs=
Message-ID: <7da011fa-5bb1-4090-8421-eeebb42c1b26@arm.com>
Date: Wed, 4 Nov 2026 17:35:59 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] irqchip/gic-v5: Serialise ITS invalidation commands
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Timothy Hayes <timothy.hayes@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <20261102-host_gicv5_fixes-v1-4-743b61626fc5@arm.com>
 <auiyrFXjX0hGgd7D@red-moon>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <auiyrFXjX0hGgd7D@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/11/2026 15:56, Lorenzo Pieralisi wrote:
> On Mon, Nov 02, 2026 at 01:32:57PM +0000, Sascha Bischoff wrote:
>> The ITS uses DIDR and EIDR to select the translation to invalidate.
>> These registers are shared by all interrupts targeting the ITS. Event
>> invalidation can run concurrently for different IRQs, and device
>> invalidation can overlap it. The per-IRQ descriptor lock does not
>> serialise the commands, so one CPU can accidentally issue an
>> invalidation using another CPU's DeviceID or EventID.
> 
> "Another CPU's DeviceID or EventID " can probably be explained better
> (or just removed because it is unclear) I understand there is a link to
> Sashiko's report but it is worth updating the log IMO.
> 
> "using the DeviceID or EventID associated with an IRQ that is invalidated
> on another CPU" or something like that.
> 
>> Add a raw spinlock to each ITS and hold it across the command register
>> writes and the STATUSR.IDLE poll for both invalidation paths. A raw
>> spinlock is required because the forwarding path calls the event
> 
> Can you please define "the forwarding path" more explicitly ?  See above.

I've tried to clean up this commit message to give the required context.

Thanks for the feedback!

> 
> Thanks,
> Lorenzo

Thanks,
Sascha

> 
>> invalidation helper with the IRQ descriptor lock held.
>>
>> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
>> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
>> Link: https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v5-its.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
>> index 28e39b065de0e..6d98f3dbe34b6 100644
>> --- a/drivers/irqchip/irq-gic-v5-its.c
>> +++ b/drivers/irqchip/irq-gic-v5-its.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/slab.h>
>> +#include <linux/spinlock.h>
>>   
>>   #include <linux/irqchip.h>
>>   #include <linux/irqchip/arm-gic-v5.h>
>> @@ -28,6 +29,8 @@
>>   struct gicv5_its_chip_data {
>>   	struct	xarray			its_devices;
>>   	struct	mutex			dev_alloc_lock;
>> +	/* Event and device invalidation commands share DIDR. */
>> +	raw_spinlock_t			inv_lock;
>>   	struct	fwnode_handle		*fwnode;
>>   	struct gicv5_its_devtab_cfg	devtab_cfgr;
>>   	void	__iomem			*its_base;
>> @@ -129,6 +132,8 @@ static int gicv5_its_itt_cache_inv(struct gicv5_its_chip_data *its, u32 device_i
>>   	eidr = FIELD_PREP(GICV5_ITS_EIDR_EVENTID, event_id);
>>   	eventr = FIELD_PREP(GICV5_ITS_INV_EVENTR_I, 0x1);
>>   
>> +	guard(raw_spinlock_irqsave)(&its->inv_lock);
>> +
>>   	its_writeq_relaxed(its, didr, GICV5_ITS_DIDR);
>>   	its_writel_relaxed(its, eidr, GICV5_ITS_EIDR);
>>   	its_writel_relaxed(its, eventr, GICV5_ITS_INV_EVENTR);
>> @@ -371,6 +376,9 @@ static int gicv5_its_device_cache_inv(struct gicv5_its_chip_data *its,
>>   		  FIELD_PREP(GICV5_ITS_INV_DEVICER_EVENTID_BITS,
>>   			     its_dev->itt_cfg.event_id_bits)	|
>>   		  FIELD_PREP(GICV5_ITS_INV_DEVICER_L1, 0x0);
>> +
>> +	guard(raw_spinlock_irqsave)(&its->inv_lock);
>> +
>>   	its_writeq_relaxed(its, didr, GICV5_ITS_DIDR);
>>   	its_writel_relaxed(its, devicer, GICV5_ITS_INV_DEVICER);
>>   
>> @@ -1112,6 +1120,7 @@ static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode_han
>>   		return -ENOMEM;
>>   
>>   	mutex_init(&its_node->dev_alloc_lock);
>> +	raw_spin_lock_init(&its_node->inv_lock);
>>   	xa_init(&its_node->its_devices);
>>   	its_node->fwnode = handle;
>>   	its_node->its_base = its_base;
>>
>> -- 
>> 2.34.1
>>

