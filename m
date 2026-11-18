Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016398;
	b=q2Uy0krJ+o2szWalCJ5ABatn1sKr5fyFYD5jzxCHh6GAe07kRy3m3mwoGwcFhOouo/nO
	 KPfVTmdYu/YVdOkySP8Dj7/Jv/IIilUFITvE4BNb4Yqm9SDDQHXin347fNlZYqwr+ffgO
	 xBDRQrmb6AMV+xmuYP3dVvhJ9C0CXbXvu5COPeI6QUMQnw0mglpI6otDZOZNa4nLS7i0l
	 wUbA/yP1ncbCVoxFG7JENu7Gj0A5QJ2L6Khv84kyFHcqcR8FntTNxz3VPPBSGkc0yAHhf
	 jFVnMhq8KAuB4PD86ODNmJx3qOAyxqadMCv5e6P+RxvD4ZqttWfmVgPw3F9Cx6lIB8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016398;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QXxc5ot+vlrpdqmyd7tRC2ZxCHOrFo4InfagjyJYHbQ=;
	b=kpjxvS2rdiISjpnellu9S3zn8EtYNDqrbt3rgzFTUk8gTvXtIh2byPEU5f2gqwN05XC6
	 xnMcbpz89V7mz/fd0zdX8WXELDEgL82N7PUIZ0yhlXg7AHwbunO+vi3LdBJfw84fWVERP
	 irTGppWvSIsKol1UlRoHRlSVxCUTEYqW5K4wfNOBH3BUQb/tMNwUdp+jY12d+oQR1N6qA
	 p6725K9ohXO5W8FiVTaIrTmug7h6xKMeoTcKelgu8EGOkBGcPGzuodf9efYw/VAAaUiyt
	 Dp+rKDM6qWfFPSorLIzeNO3oPZdjZDC5Ok5ZyDyU8fBI8nBKtZDiHjGQysQSn03KuVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iIaSAgs7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A060A260F;
	Wed, 18 Nov 2026 15:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 657A060A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iIaSAgs7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F285C1477;
	Wed, 18 Nov 2026 07:39:47 -0800 (PST)
Received: from [10.0.136.98] (M0PRX50XMG.cambridge.arm.com [10.0.136.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28CCE3F632;
	Wed, 18 Nov 2026 07:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795016390; bh=pRHQq9jHd5WU+gVj8Uypqp7K7FRf83zEeV7eEsHdPRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iIaSAgs7fJabN3cXkoWC0i7T/2byGsPZWGMkOppHww3EtYoeJCk3+DAzoW4j3+B/z
	 c4w/sTUuoR4PKhtq85KPwOT2ZATNpPB3PJ/1DdInpXxZS/dmJ+VO6wn/vHHQaIk8yt
	 h15zkNUxCf6nMhw+9KCOEPh4tiTU5xQSO7OZ+ync=
Message-ID: <535a378e-4d68-4a5c-a85d-3366e2a1626c@arm.com>
Date: Wed, 18 Nov 2026 15:39:47 +0000
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
Subject: Re: [PATCH v2 04/10] irqchip/gic-v5: Serialise ITS invalidation
 commands
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Timothy Hayes <timothy.hayes@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
 <20261104-host_gicv5_fixes-v2-4-e47ad20ea3c8@arm.com>
 <auw-5EyY_aifcv1N@red-moon>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <auw-5EyY_aifcv1N@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2026 08:31, Lorenzo Pieralisi wrote:
> On Wed, Nov 04, 2026 at 05:47:58PM +0000, Sascha Bischoff wrote:
>> The ITS uses the shared DIDR and EIDR registers to select the DeviceID
>> and EventID whose translation is to be invalidated. Event
>> invalidations for different IRQs can overlap, as can an event
>> invalidation and a device invalidation. The per-IRQ descriptor lock
>> does not serialise these commands, so writes can interleave and cause
>> an invalidation to use the DeviceID or EventID of another IRQ being
>> invalidated concurrently on a different CPU.
>>
>> Serialise the command register writes and STATUSR.IDLE polls for both
>> invalidation paths with a per-ITS raw spinlock. The KVM
>> gicv5_its_set_vcpu_affinity() callback calls the event invalidation
>> helper via irq_set_vcpu_affinity(), which holds the IRQ descriptor
>> lock. This path cannot sleep, so use atomic polling.
> 
> Same comment here as IRS sync. This one though looks like a host
> driver bug that can happen regardless of KVM, so I'd just fix it
> and remove/rephrase this paragraph.

Done, thanks!

> 
>> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
>> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
>> Link: https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11
> 
> Again, this is linking to a report on a series that wasn't merged
> yet but probably it makes sense to leave it there for context.

Yeah, I was just trying to make it clear where this was reported and how.

Thanks,
Sascha

> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v5-its.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
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

