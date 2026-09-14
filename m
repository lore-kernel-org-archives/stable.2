Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25AD448B9B;
	Mon, 14 Sep 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385531; cv=none; b=Zt1/ZfLuzHThU4Mnfrq7EKFm6bS8uImYt518qdNWMqYsmt+LtBPio5+U+cZdprjBJs0wOrhNcIJlt2qlydygnnJjwmYBvvMAeLJCFeMwpzykpc8iYLqI6gWvhVZJ0CgATwGuWESsXRyqX0w+JeJxHXSq0SaKCeyABHt8Qw+3miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385531; c=relaxed/simple;
	bh=Zqz/YBama82idufgQFRjdf+mojRujH+4XfJGD0Ez3Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t10Gn9Hoo2nZWCF4wkvXdz5cZebK2IfT/YnhNK/dEMGC301gW/+VuwPVv3SPrOIuN2hQgi7MX67RjIDSRXFzm7O/QXCzBfrSu14UuDsNUiyqQY1aAUi0kiiGJQ/rdxmoGdw3lASL50HbBeG7yX/aGTT25FTwFh0bFSLDOyDxLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FtQiHDDW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FtQiHDDW"
Received: from [192.168.1.22] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id DBD5920B7168;
	Mon, 14 Sep 2026 04:31:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBD5920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789385482;
	bh=esSepxVumQzKD1UYYxNO+aYDJjPH6X5V74k/9fUhk+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FtQiHDDWX3RV/kFKMKwH/P3ztguNs9vaaiDtLyQqJdVBohHDpymSxYRsfZ9MC2Sm6
	 vLlvWvxYyX0373N2OgNFk9zkZEcxk/j79W2kzF1DO5mUISaNTNWc1Saj/fxnTkzR0D
	 ulcl0kD+kGasVdzaLETnUWeC8hAgXXcmz35rJSU0=
Message-ID: <210aa40c-88e1-4d88-ba6b-9224b05b0820@linux.microsoft.com>
Date: Mon, 14 Sep 2026 17:01:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
To: Roman Kisel <vdso@mailbox.org>
Cc: glx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 decui@microsoft.com, yunhong.jiang@linux.intel.com,
 ricardo.neri-calderon@linux.intel.com, rahul.tanwar@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 stable@vger.kernel.org
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
 <aqTInOmsyr8AiciA@xps-8930>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aqTInOmsyr8AiciA@xps-8930>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/2026 9:05 AM, Roman Kisel wrote:
> On Mon, Aug 31, 2026 at 08:25:28AM +0000, Naman Jain wrote:
>> get_rtc_noop() is used when an RTC is unavailable, but leaves its output
>> argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
>> timekeeping_init() may therefore receive a nonzero invalid persistent
>> clock value and warn:
>> "Persistent clock returned invalid value"
>>
>> Initialize the output to zero, the documented representation of an
>> unsupported persistent clock.
>>
>> Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/kernel/x86_init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
>> index 252c5827d0634..3b9b41820c84c 100644
>> --- a/arch/x86/kernel/x86_init.c
>> +++ b/arch/x86/kernel/x86_init.c
>> @@ -37,7 +37,7 @@ static void iommu_shutdown_noop(void) { }
>>   bool __init bool_x86_init_noop(void) { return false; }
>>   void x86_op_int_noop(int cpu) { }
>>   int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
>> -void get_rtc_noop(struct timespec64 *now) { }
>> +void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
> 
> Hi Naman,
> 
> Could be
> 
> *now = (struct timespec64){};
> 
> to save a byte :)

hi Roman,
Thanks for reviewing.

Tianyu pointed out offline that this is handled in yet another way in 
jailhouse code:

arch/x86/kernel/jailhouse.c
static void jailhouse_get_wallclock(struct timespec64 *now)
{
       memset(now, 0, sizeof(now));
}

Regards,
Naman

> 
> LGTM.
> Reviewed-by: Roman Kisel <vdso@mailbox.org>
> 
>>   
>>   static __initconst const struct of_device_id of_cmos_match[] = {
>>   	{ .compatible = "motorola,mc146818" },
>> -- 
>> 2.43.0
>>

