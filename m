Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811964;
	b=VEk1XhSI9EW/6W17w6vYux8FEZ5Lp9B50dAmLQI6OmTnooyhvB6PsDLkIMQzz2Jrz6X5
	 z1EiJ7x79OezGF5Z0Hf6XcBi4X1TbKmrCs8pQ1AwBBb57kXBiNq1ZLsxUE0Ac7j1sUYg2
	 NAgLkDV0zIn8/oQvGjKeCLc9YWkNsZUeKjfgPKpZ8A4H5IrZhKsvHTqSw3A0+x7HHsfHu
	 Jzorgp0MfSs5GHzI0cD/Y+oWNTdwi4GZgSZzmfbPMy2T//n8iniBq8AfPI92f3SqlFFLg
	 AvZ424gB6rz3VH+HyWNjDr89+mOwnScCsaVtX1UIckMkXn6KJfhhIgnfnfFgjrRl3og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811964;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xHp9zcciDt9BQSTYUI4c3pqvrH6NfBZKhO/JkiSc8yA=;
	b=eLNGp0w4ZE9eNdTvJU+xULnJUSczG0EU1r0bDMx7UbmKFjF+z2YZbvhM4amAvXRXgXBc
	 ki3I54qPklKf2zSvPdjIfZrKNQRMNLKVr+h2H0qTsMOOOTczELD9RqbkJwhrqx5pvXm4J
	 +BmLiD28yNRsDq9KTi+h7tjjJ/2rK2GLhR14a8UJOt70llucqq071F4mcPbE5pGXARqz5
	 mIGg13vrjQzenI8SYvV+5BSZpGLaYe/vgaFOtSwAddLEisR5/I6UebgtugxoRwC9lZnsm
	 aHFkjXC6l+HhAW858oEWH/c9A2EiFuDc5j12FeNx0pNht2ygPZFHZpeCdl3sPaTbYbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aBYGdWw7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B15606A326;
	Wed,  4 Nov 2026 17:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aBYGdWw7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 813BE1BB0;
	Wed,  4 Nov 2026 09:06:00 -0800 (PST)
Received: from [10.57.90.115] (unknown [10.57.90.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909573F673;
	Wed,  4 Nov 2026 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793811963; bh=M5dLetY60rROLOEP0RTG1zWPi4zkfIzPuDEW8MB3PWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aBYGdWw7WH5tD8TaTad1UX5sXkFqHy3kJFkCIO/NV+nPvDKlY2sXMTXu+pv2gHLoM
	 z3vZUPDN/buLPybv/Q+X6+qfjoULVPVgWwTWUrdshr2BqKyGHwDH3WX9pynYyFbpe+
	 ECT6kIX/0a74V1YeaSzu7NMMtnYPeJE0Zi4A9SSk=
Message-ID: <ba2d9aa3-f14d-47e6-8cdc-62a6d385515e@arm.com>
Date: Wed, 4 Nov 2026 17:05:59 +0000
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
Subject: Re: [PATCH 03/10] irqchip/gic-v5: Serialise IRS synchronisation
 requests
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Timothy Hayes <timothy.hayes@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <20261102-host_gicv5_fixes-v1-3-743b61626fc5@arm.com>
 <aumlixJkwDBlv8Yf@red-moon>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <aumlixJkwDBlv8Yf@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/11/2026 09:12, Lorenzo Pieralisi wrote:
> On Mon, Nov 02, 2026 at 01:32:56PM +0000, Sascha Bischoff wrote:
>> IRS_SYNCR writes are ignored while IRS_SYNC_STATUSR.IDLE is clear.
>> Calls to gicv5_irs_syncr() for different IRQs can overlap, allowing
>> the second request to be dropped. Its caller can then observe the
>> first request completing and assume that its own events have been
>> processed.
>>
>> Serialise the request and completion poll with a raw spinlock. We use
>> atomic polling, as the lock cannot be held over a sleeping wait.
>>
>> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v5-irs.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
>> index 4edf787f3f97f..ead76560ea08f 100644
>> --- a/drivers/irqchip/irq-gic-v5-irs.c
>> +++ b/drivers/irqchip/irq-gic-v5-irs.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/log2.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/spinlock.h>
>>   
>>   #include <linux/irqchip.h>
>>   #include <linux/irqchip/arm-gic-v5.h>
>> @@ -22,6 +23,8 @@
>>   #define LPI_ID_BITS_LINEAR		12
>>   
>>   static DEFINE_PER_CPU_READ_MOSTLY(struct gicv5_irs_chip_data *, per_cpu_irs_data);
>> +/* Synchronization requests must not overlap in an IRS Domain. */
>> +static DEFINE_RAW_SPINLOCK(irs_sync_lock);
>>   static LIST_HEAD(irs_nodes);
>>   
>>   static u32 irs_readl_relaxed(struct gicv5_irs_chip_data *irs_data,
>> @@ -507,10 +510,11 @@ void gicv5_irs_syncr(void)
>>   		return;
>>   
>>   	syncr = FIELD_PREP(GICV5_IRS_SYNCR_SYNC, 1);
>> +	guard(raw_spinlock_irqsave)(&irs_sync_lock);
> 

Hi Lorenzo,

> Why does it have to be a spinlock ?

gicv5_irs_syncr() is also called while restoring the host ITTE in 
gicv5_its_set_vcpu_affinity() once we have the GICv5 ITS support for 
KVM. That callback runs under the irq descriptor lock via 
irq_set_vcpu_affinity(), so it cannot sleep. I’ll clarify this in the 
commit message.

Apologies for the lack of clarify in that regard for some of these 
commits. They logically made more sense when they were bundled together 
with my KVM changes, but now that I pulled them out some of the commit 
messages lack context.

> 
> Thanks,
> Lorenzo

Thanks,
Sascha

> 
>>   	irs_writel_relaxed(irs_data, syncr, GICV5_IRS_SYNCR);
>>   
>> -	gicv5_wait_for_op(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
>> -			  GICV5_IRS_SYNC_STATUSR_IDLE);
>> +	gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
>> +				 GICV5_IRS_SYNC_STATUSR_IDLE, NULL);
>>   }
>>   
>>   int gicv5_irs_register_cpu(int cpuid)
>>
>> -- 
>> 2.34.1
>>

