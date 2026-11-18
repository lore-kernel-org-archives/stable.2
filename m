Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016093;
	b=yFGVtt9sn1NbzhydheRQXkAGiBThCzhA50ShccRu1u+mHuj9Ys9/jelSop0ye5swFQxz
	 +RmdFANuJZRgMbhLXZlPRRn42LvZN4S6aZe/C436AZtsE04DDBT5NCv4v4MXb9pQXEp3p
	 paooIMOsRQ/ZNlaGsAPve1wMPXD883hr8NvCHnEBnYR85LOEzcMGwuQVtfPpHCiJ0RVZc
	 2NnEEaywCDdkEYgUDqoe0Kf1AQkjTAtzBaA43+REY5fNx36lgZJs3uxcraIyJfBtJVg39
	 thQccnH5Qo1jB05B+hrPvplq8wAjUDhYPhd97/X+eYxUx2eecq7qlKebXBs7DW/XMZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016093;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TTOWgexBBg/MVW0b5stJBvTCU1KsO22oMvb+9fg5rIs=;
	b=zPa8FKF7mE4Cr0lrPoFXk20DIhufKl3Biq/de2q/LdOV/r93TmfnhUJa6oXv5Z/SlNp8
	 aAEJIC6v8LmEJ0qfEkt6DX1zCoPN5XkMOvys7SyaMTkdBmNBpfK/20auECXNTaxYoGNQD
	 IinN3ScQLCLnbB09av4hVodzVCWM4FTOjrd2vv+FT8CkUWV8WvS9KChoxPutRNjGlFHsa
	 agRwNuiS0jc+7FF1w2FcXcEG7gHLM27WBWDhMGis+2J7g1fUD3TfXeEFMIDIYpLln8OgX
	 GDkAblynH0pkFVDqjLoRhY2HssDeHfl9+6qMA/8PZ9qOe91FcxHXDFkSBfYJuCkAKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hSU9vXMZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00C606A331;
	Wed, 18 Nov 2026 15:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E00C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hSU9vXMZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413EB1477;
	Wed, 18 Nov 2026 07:34:49 -0800 (PST)
Received: from [10.0.136.98] (M0PRX50XMG.cambridge.arm.com [10.0.136.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CB6A3F632;
	Wed, 18 Nov 2026 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795016092; bh=2BBJ1suAnTPS6/YPDbka46qhf9/+FM2sALeGOYTfwRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hSU9vXMZlJnCa4XqPjRCwtNV6uXMCZHpWp9OKCcFMpV7fWDhrfoyYtFhu1M6433SY
	 G7gYi9FjVVcyW1m9pIV+m0RUlTPgepTX56bUP9dqB7zppCyHf8RXxFFtu12K0w3XSk
	 xk9aMeyZ0i6KN2KAzzRfQ3jIwicqPxkatRa3vP94=
Message-ID: <71b9323b-902f-4bf9-9cbf-6d0d90ee7ca0@arm.com>
Date: Wed, 18 Nov 2026 15:34:48 +0000
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
Subject: Re: [PATCH v2 03/10] irqchip/gic-v5: Serialise IRS synchronisation
 requests
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Timothy Hayes <Timothy.Hayes@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
 <20261104-host_gicv5_fixes-v2-3-e47ad20ea3c8@arm.com>
 <auw0ulR3wrsKVcYe@red-moon>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <auw0ulR3wrsKVcYe@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2026 07:48, Lorenzo Pieralisi wrote:
> [Remove stable from the CC email recipient list, leave it only in the log]

Noted, and thanks. Hadn't caught that had been added in from CC. Will 
omit henceforth!

> 
> On Wed, Nov 04, 2026 at 05:47:57PM +0000, Sascha Bischoff wrote:
>> IRS_SYNCR writes are ignored while IRS_SYNC_STATUSR.IDLE is clear.
>> Calls to gicv5_irs_syncr() for different IRQs can overlap, allowing
> 
> Nit: gicv5_irs_syncr() has no notion of specific IRQs, this is
> misleading.
> 
>> the second request to be dropped. Its caller can then observe the
>> first request completing and assume that its own events have been
>> processed.
>>
>> With GICv5 ITS KVM support, gicv5_irs_syncr() is also called while
>> restoring the host ITTE in gicv5_its_set_vcpu_affinity(). The callback
>> runs under the IRQ descriptor lock via irq_set_vcpu_affinity(), so it
>> cannot sleep.
> 
> Technically we are talking about a use case that does not exist yet.
> 
> I understand it is churn to fix it first and change it again later,
> I would just say that gicv5_irs_syncr() might need to be called in atomic
> context.

I've reworked this commit message to make it clearer.

Thanks,
Sascha

> 
>> Serialise the request and completion poll with a raw spinlock, and use
>> atomic polling because the synchronisation runs while holding the IRQ
>> descriptor lock.
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
>>   	irs_writel_relaxed(irs_data, syncr, GICV5_IRS_SYNCR);
>>   
>> -	gicv5_wait_for_op(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
>> -			  GICV5_IRS_SYNC_STATUSR_IDLE);
>> +	gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
>> +				 GICV5_IRS_SYNC_STATUSR_IDLE, NULL);
>>   }
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
>>   
>>   int gicv5_irs_register_cpu(int cpuid)
>>
>> -- 
>> 2.34.1
>>

