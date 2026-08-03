Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462A3C1D62;
	Mon,  3 Aug 2026 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748346; cv=none; b=jxO67hJe3dpKI9dcQQ4np4B5FnyAIcowBWEu7ntz3rzRfb2KXa/6btzbAmAuTSNH2tTYEwq7oEDcYng3TawIgMymQ9gTKmxvxf96R4U25c59rpqqKqmT9ur97aIfQfiF2YWUYZ4ImszKCS7k+dfexqTVniq3ZFUmneL31sZnvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748346; c=relaxed/simple;
	bh=2lf5Ph1rkfA6Mj7KtrQZutViAdYU2nBThnlFN/K7DM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie81llkz39suXmilJxYjkjF+xYcn0NEhHkhja+czMNnSn7B+7r4DMRfP9kIoNMHfQ+3coBtT45mTpSXnpD0Z4OvlxlUv/d/dQIFd5Xp4mkcQkoa1khLUwe4HA0sg01jjjKsQfk2anwIgT/LIAYPxT4voA/AVzG11UyrDjv+BFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lhVhgSR2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lhVhgSR2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A8A143D;
	Mon,  3 Aug 2026 02:12:14 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09043F66F;
	Mon,  3 Aug 2026 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785748338; bh=2lf5Ph1rkfA6Mj7KtrQZutViAdYU2nBThnlFN/K7DM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lhVhgSR2mnTifeFoMQAaTi3EqZlAYklGOndRNEJz9kySBVlhz9ToWggwYAZPwEqyF
	 jLqoFue3wG/N2eY4joJdzCY/0q9qmdGM3UkvZ6iXPK8WmOHuuAI/H5VlhIsHTgZhI2
	 YJ8ioAoQD1LDbKmlckzf95uE/OyZXhTfcmUP7lnE=
Message-ID: <b4fcd43c-bd24-4b81-887b-dc3aa9d4d66a@arm.com>
Date: Mon, 3 Aug 2026 10:12:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, stable@vger.kernel.org
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <20260729100245.2628302-2-christian.loehle@arm.com>
 <5fd20dee-9091-488a-9956-ac8a0ae1d34f@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5fd20dee-9091-488a-9956-ac8a0ae1d34f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/26 11:45, Zhongqiu Han wrote:
> On 7/29/2026 6:02 PM, Christian Loehle wrote:
>> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
>> calls cppc_get_desired_perf() because some platforms repurpose Desired
>> Performance to report actual delivered performance.
>>
>> The fallback was added for platforms on which Desired Performance reflects
>> delivered performance. ACPI 6.6 defines the register as write-only, so
>> invoking that workaround on an ACPI 6.6 or later platform would require an
>> invalid register read.
>>
>> Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. Its caller
>> already handles an error by using the cached desired-performance value.
>> When checking the FADT minor revision, mask off its upper errata-generation
>> bits and compare only the specification minor version.
>>
>> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
> 
> Hi Christian,
> Please feel free to correct me if there is any misunderstanding.
> 
> ACPI 6.6 was released on 05/13/2025:
> https://uefi.org/sites/default/files/resources/ACPI_Spec_6.6.pdf
> 
> And the fixes tag commit c47195631960 was committed on 09/29/2024.
> 
> Would this be considered an adaptation rather than a regression fix?


That is all correct, but the fixes tag is supposed to mean "this patch makes
the commit in question work" (and therefore should be backported to all kernels
containing this), which is then correct, as older kernels may still boot on
newer (6.6) ACPI systems.
It doesn't mean that the mentioned commit is 'bad' or 'wrong'.


> 
> 
> With the Fixes tag confirmed/fixed:
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Thanks, I'll leave as-is and pick this up if you don't mind.

> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 53d09ca98f06..6e5381f8de38 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1316,15 +1316,28 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>>       return cpc_write(cpu, reg, val);
>>   }
>>   +static bool cppc_desired_perf_readable(void)
>> +{
>> +    u8 minor_revision = acpi_gbl_FADT.minor_revision & 0x0f;
>> +
>> +    return acpi_gbl_FADT.header.revision < 6 ||
>> +           (acpi_gbl_FADT.header.revision == 6 && minor_revision < 6);
>> +}
>> +
>>   /**
>>    * cppc_get_desired_perf - Get the desired performance register value.
>>    * @cpunum: CPU from which to get desired performance.
>>    * @desired_perf: Return address.
>>    *
>> - * Return: 0 for success, -EIO otherwise.
>> + * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
>> + * errno otherwise.
>>    */
>>   int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>>   {
>> +    /* ACPI 6.6 no longer specifies Desired Performance as readable. */
>> +    if (!cppc_desired_perf_readable())
>> +        return -EOPNOTSUPP;
>> +
>>       return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
> 
> 

