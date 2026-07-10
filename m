Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21671157487
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663749; cv=none; b=oLSYqvZqbz3UwEk6isHs+0sdQ8vGivSfKLSzI6YVh9xZQHr79jgLf8EDEpZo5Hq9kYCc19YBu3rT4l1hfVeIByOAr+Jv8/2HTw1hocuGJtAf9i8SDtmCANTV/vrt75AgtatMsBcCrY8bnAGeRjpEfnyRJLLA2hCys8hGc2lPNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663749; c=relaxed/simple;
	bh=MfYJ+oEzlsf0x97FdWPY3fKwT6ni+UfyHnQ/PR00HJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qufiZIzSOy8D2DOXQ9bf9UZw2oSDn3MyxFVU/ghHOnRxgrrc5FMWosXygWAOEsyzdY+Hh4ugNJRExLTqV59+uIPa693vtrKXv0OuXUnQ7bxohwaojaIl2qxHmu27hX6vU4IXpW7leBzRPzlk+s9la3o1Q1FRQ9Dd0/UJAudc/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Emrs4e5t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Emrs4e5t"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nbj3075696;
	Fri, 10 Jul 2026 06:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H5fK/4
	DnTdj1zOGAhZ5K0j5H0qxQtWwVRIt9dVTLQcA=; b=Emrs4e5thp2OWG0tIuPdAL
	W1lRFGEPb2xDZtS0/JO/dFiK05zl+Hk4KDMl+X2FDAye0RkQFJSLStN1JCGbqvpT
	hdnDw5qXi8vwlCT4SQ7nENtEd39oIQi6H+XzhFW+7bNedDHSslF68poJAbwGmRpE
	nC66vI/gfjykC2jmK1diSyNcbzwgGuolMyIjtGRguM4P+M04BfiPcNNIbyqm3moe
	lkjRcTnr4j9sJTycSkw4vwxGO/kGD4ym1Y7evYgG/Lzya5tWB3Hc9ryWt8sxO/4d
	p9lZw6dsUX21e7XhRhvirpzrNWpDgNm2fMtm0nVpAT3Ke3kXsRqRArLKP2oxAJBQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknvmky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 06:08:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A64ZGQ015351;
	Fri, 10 Jul 2026 06:08:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqgux3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 06:08:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A68bV847382792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 06:08:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8677920040;
	Fri, 10 Jul 2026 06:08:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE6B320043;
	Fri, 10 Jul 2026 06:08:34 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 06:08:34 +0000 (GMT)
Message-ID: <094c3b8d-8ec7-4358-8bd7-f1b7eaa3a0c8@linux.ibm.com>
Date: Fri, 10 Jul 2026 11:38:33 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] powerpc/crash: stop watchdogs before booting kdump
 kernel
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Mahesh Kumar G <mahe657@linux.ibm.com>
References: <20260603070217.483696-1-sourabhjain@linux.ibm.com>
 <20260603070217.483696-2-sourabhjain@linux.ibm.com>
 <4ii8w2ex.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <4ii8w2ex.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a508c6a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ntgFhEv9RpcQT0gMIhEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: M6HfYugZN9tqJ4SWhFz_zDxVevuBnT-E
X-Proofpoint-ORIG-GUID: kreRaiRulEmofPtCWOTbyWut2kbZOVOC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MyBTYWx0ZWRfXyLn23xmsAiQG
 C5pijH2EPFXGLs627MQRbG4ZbpWCXxv9OJ9Rf47Ub2fv7KbOS8Nt3ATLEo3BdNm0A2P93SaUgAU
 GHYEJya0dmzh+MIJ6xxji4YIX7/Mwc8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MyBTYWx0ZWRfXzAPaiA+nQXnO
 YpmyaHTgCaJ/XyCGFzhHLw7iBqk+kOs6nCppXzP6lDC/6OM6kGVm4I6bt01eTrsWWy8z08LYNLP
 BJOb2LhTawlDCAY/Zu/9ma0oIPRgYqFzC9DQB72kL4pLPH5+yYG5ROUu3Uf18HTtEm5bIi/SZix
 fHdBwBigqzA0ihGNtr6ZJcnt2FYyuWeNH6MHitWPdtkHmfOb9GB2ZAg1XfVyZqc3c8v76HoW7MJ
 kcLTXX3nA/baqWUVqpgZjTLwCaUV8FUN8YzQWonessnMCFG6QRG5AwY/S19u9aXpd1+48lvgW1w
 y4hwg7vGdXOHvzQK6CCxPUuI2hHUGdpttjfVhWE/DNGAHWjOhTKfP6XUNv8qvtDKET6sI0TnE8g
 Uqi2qSOCeQKcL1M0OFZh8xEcdOu7EjmBhQMInFlhY2nAPKCUF8gkp1MYPpm4Zfi+SNx1YDmraeo
 Eztdu2jMy8aYyTKxf+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100053



On 09/07/26 22:01, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> On pseries LPAR systems, watchdog timers configured from userspace
>> can remain active after a kernel panic. During panic triggered crash
>> dump capture, the crashing kernel jumps directly to the kdump kernel
>> without shutting down userspace services. As a result, active
>> watchdogs are not stopped before entering the kdump kernel.
>>
>> If dump capture takes longer than the watchdog timeout, PHYP resets
>> the LPAR before dump collection completes, resulting in dump capture
>> failure.
>>
>> Fix this by issuing the H_WATCHDOG hcall on the crash shutdown path
>> to stop all active watchdogs before booting the kdump kernel.
>>
> Nice catch!
>
>> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
>> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/kexec/crash.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index e6539f213b3d..5651523e3a70 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -28,6 +28,7 @@
>>   #include <asm/interrupt.h>
>>   #include <asm/kexec_ranges.h>
>>   #include <asm/crashdump-ppc64.h>
>> +#include <asm/hvcall.h>
>>   
> would be nice, if we could avoid papr specific header into common crash.c
>
>>   /*
>>    * The primary CPU waits a while for all secondary CPUs to enter. This is to
>> @@ -352,6 +353,28 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
>>   }
>>   EXPORT_SYMBOL(crash_shutdown_unregister);
>>   
>> +/**
>> + * stop_watchdogs - Stop active watchdogs before entering kdump kernel
>> + * On pseries LPAR systems, watchdogs configured from userspace remain
>> + * active after a kernel panic because userspace services are not shut
>> + * down on the kdump crash path. If a watchdog expires while the kdump
>> + * kernel is collecting the dump, PHYP resets the LPAR and dump capture
>> + * fails
>> + *
>> + *   0x200UL : watchdog stop operation
>> + *   -1      : watchdog number, disable all watchdogs
>> + */
>> +static void stop_watchdogs(void)
>> +{
>> +	if (firmware_has_feature(FW_FEATURE_LPAR)) {
>> +		int rc;
> ditto.
> Also I guess this could be FW_FEATURE_WATCHDOG
>
>> +
>> +		rc = plpar_hcall_norets_notrace(H_WATCHDOG, 0x200UL, -1);
> - 0x200 is hardcoded.
> - -1 is hardcoded.
> - I think it's return value is long.
>
>> +		if (rc != H_SUCCESS && rc != H_NOOP)
>> +			pr_warn("crash: failed to stop watchdogs\n");
> Let's print rc as well.
>
>> +	}
>> +}
>> +
> Looking at the code, we already have a mechanism to register a crash
> shutdown handler which anyways is getting called from
> default_machine_crash_shutdown(). So, I think we could use this generic
> crash handler register mechanism and keep the wdt specific calls within
> pseries/setup.c file...

That's a good idea. I wasn't aware of this crash handler.

The main reason I wanted to stop the watchdog as soon as the kernel
enters the architecture-specific crash code is that, on PowerPC, the
crash path sends IPIs to all other CPUs and waits for their response
before continuing. Because of this, I thought it would be better to
stop the watchdog as early as possible.

I knew there was an IPI timeout, but I just checked and it's set to
10 seconds. See crash_kexec_prepare_cpus() in crash.c.

The crash handler is called after the IPI wait. So, in theory, the watchdog
timeout could occur before the IPI timeout. But I think that's a very 
unlikely
scenario, though. So I think disabling the watchdog from the crash handler
is a reasonable approach.

Please share your thoughts.

>
> ...How about something like this?
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 50b26ed8432d..4e557694d724 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -59,6 +59,7 @@
>   #include <asm/xics.h>
>   #include <asm/xive.h>
>   #include <asm/papr-sysparm.h>
> +#include <asm/papr-watchdog.h>
>   #include <asm/ppc-pci.h>
>   #include <asm/i8259.h>
>   #include <asm/udbg.h>
> @@ -185,14 +186,42 @@ static void __init fwnmi_init(void)
>   #endif
>   }
>
> <...>
>
> +static void pseries_crash_stop_watchdogs(void)
> +{
> +       long rc;
> +
> +       rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
> +                                       PSERIES_WDT_NUM_ALL);
> +       if (rc != H_SUCCESS && rc != H_NOOP)
> +               pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
> +}
> +
>   /*
>    * Affix a device for the first timer to the platform bus if
>    * we have firmware support for the H_WATCHDOG hypercall.
>    */
>   static __init int pseries_wdt_init(void)
>   {
> -       if (firmware_has_feature(FW_FEATURE_WATCHDOG))
> -               platform_device_register_simple("pseries-wdt", 0, NULL, 0);
> +       if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
> +               return 0;
> +
> +       platform_device_register_simple("pseries-wdt", 0, NULL, 0);
> +
> +       if (crash_shutdown_register(pseries_crash_stop_watchdogs))
> +               pr_warn("Could not register watchdog crash shutdown handler\n");
> +
>          return 0;
>   }
>   machine_subsys_initcall(pseries, pseries_wdt_init);
>
>
> Note that I added papr-watchdog.h header file in above. I am guessing we
> can move some definitions from drivers/watchdog/pseries-wdt.c to
> arch/powerpc/include/asm/papr-watchdog.h in a separate patch before this
> change.

Yes, it is better to keep the watchdog definitions in a common header 
instead
of duplicating them in multiple places.

> I think you get the idea. Can you try this way and let me know if this works?

Sure. Thanks for the review.

- Sourabh Jain

>
> -ritesh
>
>>   void default_machine_crash_shutdown(struct pt_regs *regs)
>>   {
>>   	volatile unsigned int i;
>> @@ -360,6 +383,8 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
>>   	if (TRAP(regs) == INTERRUPT_SYSTEM_RESET)
>>   		is_via_system_reset = 1;
>>   
>> +	stop_watchdogs();
>> +
>>   	if (IS_ENABLED(CONFIG_SMP))
>>   		crash_smp_send_stop();
>>   	else
>> -- 
>> 2.52.0

