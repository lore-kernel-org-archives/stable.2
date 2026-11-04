Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814047;
	b=RIPBkSDLMMoxmfBK4InH4tKS7VRv2IL2jhhLvfLG0y6/u9f5I6VPb5YyXOSf+gEGJbTu
	 OC0hcF/PyrVbW55OQF0ff6lXaIK9A4bq45fHmCCQEoDRxFzqSZJHxeVgfUWCXuEX8DA08
	 RgPDAbSs/ZdmOEklwdVvJK2NwT2y7tqmIsqDMgpvzorbjBVDmfhJ6iAVRohMgGmj2W9la
	 ppJ4V0h5rYOc2sJYueSLgPRBuiV2Ne6Q9aUDNkGBC40Fw/qSEQK3qZh5cBrPMV6lXp8gS
	 hHvIyAfdqzVG0H7eZNwOzB5JgjlgP/mcGEWxULpeRVWbB7EIqQwf/aTM3OGprKS2BvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814047;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TQnRvPeX0s11xwNIzy2fTv5gyAO1V6iutDNVwBAIQGw=;
	b=NbWS1F3gJo157dedGwPsSk56Mar9qF7wirgwcUfT6ySGLRStQ0FHBjJg34N4lh3zwq35
	 2SroEb7UeMtkMlJUeJn+qi5/0rfIMuwXT+NMC1dbBwpL6V1DC4l9EhA446unTF9LijaoR
	 AWR4yxdJJI+WUv4i3a1x+ut6kFp3sQ1PG2zI2VnOF2JJ6cskfk8bS91sLC12kQrI39mzw
	 EfiRBLOwu09wtNz8uKHcVeL4op++cPX/4RV+UrgDCfyoRNNjZFLffITIAIJH7BUnWLjWJ
	 myjhQ7qVQym0tDz5zWqmXj/uVzZfninA7y+wEuQ2bagEeUiehRdR6SJFUBFbYsvtO6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C6OJR5TU;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1E606A331;
	Wed,  4 Nov 2026 17:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D1E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C6OJR5TU
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DDE81BB0;
	Wed,  4 Nov 2026 09:40:43 -0800 (PST)
Received: from [10.57.90.115] (unknown [10.57.90.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158A03F673;
	Wed,  4 Nov 2026 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814046; bh=+W72MjjHirhzVA/qDT+k2DAMSV2VvDQzAofbMpBBwSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C6OJR5TUg1o9qDAz7haD+JUV0dWjrhETeV6oWpF8Z1Xl0ya74LmaqfHTaz7bpxff+
	 5PwdOYNd3un5lwbYrQrG7cslAkDMCC6/ni1jA2XCr0oALAWU14yhVn52MSttnogBJY
	 nGIlmpqVsdnM9KYCGjy44d0lfG2ZuSJiJzOHWycM=
Message-ID: <a2677ff9-e342-4f06-bf28-8f56aadb14a4@arm.com>
Date: Wed, 4 Nov 2026 17:40:42 +0000
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
Subject: Re: [PATCH 00/10] irqchip/gic-v5: Fix misc IRS and ITS host driver
 issues
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Timothy Hayes <timothy.hayes@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <aun2udtwaIo2RiRC@red-moon>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <aun2udtwaIo2RiRC@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/11/2026 14:59, Lorenzo Pieralisi wrote:
> On Mon, Nov 02, 2026 at 01:32:53PM +0000, Sascha Bischoff wrote:
>> This series fixes issues in the GICv5 host IRS and ITS drivers.
>>
>> The ITS invalidation serialisation fix addresses Sashiko's report of a
>> race between event and device invalidation commands [1]. The other
>> patches correct IRS allocation and routing behaviour, serialise IRS
>> synchronisation, and fix ITS L1/L2 table selection, cache maintenance,
>> ACPI coherency handling, and resource cleanup.
>>
>> The IRS changes:
>> * Reject allocation of an SPI without an IRS, preventing a null-pointer
>>    dereference, and warn about low-quality firmware.
>> * Only program IRS_PE_CR0.DPS when 1-of-N routing is supported as this field
>>    is RES0, otherwise.
>> * Serialise IRS synchronisation requests, as the IRS ignores a request while
>>    an earlier one is still active.
>>
>> The ITS changes:
>> * Serialise event and device cache invalidations because both use the ITS's
>>    shared DIDR register, so concurrent writes are a bad idea!
>> * Select linear device and interrupt translation tables when one L2
>>    table covers the full ID space. Currently, this selects the wrong
>>    path, then the L1 table code rejects the attempt to create the
>>    table.
>> * Check the ACPI noncoherent flag with ACPI, rather than checking the
>>    DT's property.
>> * Correct cache-maintenance sizing after limiting the DeviceID width.
>> * Invalidate the device cache before freeing an ITT.
>> * Use firmware-node names in initialisation warnings.
>> * Release the reserved MMIO region if DT-based ITS initialisation fails.
>>
>> I've CC'd stable for the IRS/ITS locking fixes, the ITS table alloc
>> issue, and the ACPI coherency fix, as these are the most important
>> changes to backport.
>>
>> The series is based on v7.4-rc1. Thanks for taking a look!
> 
> Thank you for fixing these bugs Sascha.
> 

Absolutely no worries. One of those times where one pulls on a thread, 
and a few more things unravel than one expects :)

V2 incoming.

Thanks,
Sascha

> Lorenzo
> 
>>
>> Sascha
>>
>> [1] https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11
>>
>> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
>> ---
>> Sascha Bischoff (10):
>>        irqchip/gic-v5: Reject SPIs not backed by an IRS
>>        irqchip/gic-v5: Only set IRS DPS when 1ofN routing is supported
>>        irqchip/gic-v5: Serialise IRS synchronisation requests
>>        irqchip/gic-v5: Serialise ITS invalidation commands
>>        irqchip/gic-v5: Use linear DT and ITT when L2 covers all IDs
>>        irqchip/gic-v5: Honour ACPI ITS noncoherent flag
>>        irqchip/gic-v5: Use firmware node name in ITS warning
>>        irqchip/gic-v5: Invalidate ITS device cache before freeing ITT
>>        irqchip/gic-v5: Clean the allocated linear device table size
>>        irqchip/gic-v5: Release ITS MMIO region on DT probe failure
>>
>>   drivers/irqchip/irq-gic-v5-irs.c   | 22 +++++++++++++++-------
>>   drivers/irqchip/irq-gic-v5-its.c   | 29 ++++++++++++++++++++++++-----
>>   drivers/irqchip/irq-gic-v5.c       |  9 +++++++++
>>   include/linux/irqchip/arm-gic-v5.h |  1 +
>>   4 files changed, 49 insertions(+), 12 deletions(-)
>> ---
>> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>> change-id: 20261102-host_gicv5_fixes-1eeea29d2ea4
>>
>> Best regards,
>> --
>> Sascha Bischoff <sascha.bischoff@arm.com>
>>

