Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788728;
	b=MtFtDEOFsg+3Wl+yxu6Ks3wHlMY/s/Js0wrgLOmWvKOAmey8Yi2GAdNlkgL1E57g9RIE
	 k29Gxw8wxXsCCJpANzFSiHI+zaT3b0jIaBauHIhj345Gx74n8ZQxEurnP+E5EbGO/f9Ae
	 9vjhNIt032ReT4wZTqMN8cBXqDYjUNHjPjnK/Bna05E+5EMfnvtISljzW2HgrP60+JGDJ
	 630hfGXRjzcDvk1HucQC8uqaKr1gpJTcqGqGjoOxI6Vs5CaR0bB1/oGb0uWA8Ymghy3JH
	 Zj/qlch8Z3CRoOrUsK2jmXjEibntxvil5y7JQyK1GjQ4kDoDkL+Y5xlvoLBXbMeLPkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788728;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZkjWh42a8WjAqLsn6R2uQG+he4dwkBRnHOH3Cp49cH0=;
	b=WJOZliDcW0eeBKAPpFpY/o4kgh7kk4QRbba2o3KApjLYIt+OTEQHxpH5Djd6Mb7ZzeGg
	 REuFNBhoORhDMKE5aCVX+zYI/Zo5fS4z7b0gvarvDxsPc5xn9tahFyAuaFpCz5qu48wq8
	 x/GsxQgrcddB/+oAC1kbMExvQZLIF6vDg2Rrwa99iOGMORodB3JV9JFx4mX5Ek9rcZ+u6
	 uNxwLEw9EUOP1wUTWo23bieNlFR+vO7+nGc5a4EXOdU4utpnHqWEhQB0hbjqqrusB3WsG
	 j38TlA1+nVX28bWZ9G6S2V1/b67WJ67g+VBr75CbWaKmnLFrlGvDCJShhh5bcpENqCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KUjvvfEW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.66
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B3606A31B;
	Wed,  4 Nov 2026 10:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KUjvvfEW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0OvScziUJ5cO4KzgRIFeexN4rU+QJ8B3WYsuLKAP2AtRGj/X/26MLrP+HbIfqqTwIkJkj5TpDgaIgQnmJYVHJWNRx0XYuMBFt5v5Tvxrom31dR/RKppxDUAc7V7ZvN4589Y+yMg6er/AFBDX+QonSrRS+hNUdTnT7P34kRQbOibai0lqLM/mpLsQdumkmaZEhYrdOV3fZmfArvHlbOqhfcQWWVVLdMrHFwSU47kHDCWhwA77qG5U9PaQAio7wV2mEJRiSzRZ12aZ7k1NTlarC/VMI8MSpEaJUiEwYwqXdh9JYqaa+F7urAGjTRvGhcOM7bbwtuEFJ8LFl5AwwxrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkjWh42a8WjAqLsn6R2uQG+he4dwkBRnHOH3Cp49cH0=;
 b=BqMVaAc/jTYgb7V6qXMA0/O8IuFHAgO5lR6oN9ttwOtY3Mdsm+QJt3M9iMhjIBZQiywrmk6dQzR9eBRhT5WLvincE4L/zZW5oROfFygX04L7xn4YJYL7MRy3p7E5wRBbDcW0KLytbcAckh7XGdUN+Tbcu3oOnMvsP5mIHijwNErfGiqN9Qlvozz6rhO/2a8okGdXUuMG+VXKJ9Uk7PgAtv9JiDRkKaW8r4ZsRpfbwrOZjjwAhPKO0santOno58xyETIKNurQJlTGwUE1RIi+9RnhbJGrqsvPmClQ7E4EwXFwZL6qz29nPk7+9kbAcO4VEnzlmU7FI236M88G8INgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkjWh42a8WjAqLsn6R2uQG+he4dwkBRnHOH3Cp49cH0=;
 b=KUjvvfEWwGIj/6W6Pj5oa73A9c0IpYjWJzSvVkcR1nWWh4NuyhOMaZaFGY97UnEoYWu1bt72TkI9JgA6N49zopuxFLupnL87sASjdTzExmYvMKL3f36+SuEMRRTSaPz+v0pxEz69859VQ0t7orSqmQ2n0i5JgZ9RlYc+mqYlRXs=
Received: from PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::35)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 10:38:42 +0000
Received: from PH7PEPF00000005.namprd04.prod.outlook.com
 (2603:10b6:510:327:cafe::aa) by PH7P220CA0135.outlook.office365.com
 (2603:10b6:510:327::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 10:38:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH7PEPF00000005.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:38:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:38:40 -0600
Received: from [192.168.1.100] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 04:38:37 -0600
Message-ID: <b0723e5a-c09d-4892-be27-29f6daa00381@amd.com>
Date: Wed, 4 Nov 2026 16:08:35 +0530
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
Subject: Re: [PATCH] clocksource: Use the clocksource under test for the skew
 check timeout
To: Thomas Gleixner <tglx@kernel.org>, Mani Tofigh via B4 Relay
	<devnull+mt4022.columbia.edu@kernel.org>, John Stultz <jstultz@google.com>
CC: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
	Borislav Petkov <bp@alien8.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <tz2294@columbia.edu>,
	<stable@vger.kernel.org>, Mani Tofigh <mt4022@columbia.edu>
References: <20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu>
 <878q39y8da.ffs@fw13>
Content-Language: en-US
From: "Aithal, Srikanth" <Srikanth.Aithal@amd.com>
In-Reply-To: <878q39y8da.ffs@fw13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000005:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: f1823b13-004f-445a-161c-08df3a5fcb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|4143699003|5023799004|11063799006|261022075727099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	108imQ/Wtvj2wX6Ir0mILHv6bgEOod3Rqa/ORX/yTVB8e7x5xqMwogqmsv1jtereop7jEQ7fq8L3tnpgvq5q8r5zm9KxhU8KzOn0BKYIaxNp8bSU78IF8uYI4aHD4tqkhwFblWQnVxQNCZOfvLCu4cNVWZPgGXfLYFo2r0iUFwZsYRZZl8eYdlcJ2CSzKRy7NGMTWfaA0ouKgBSZV2pVwiZh7TtV6kQiEUs68eOVvENiPaelFkgthuNXlEsO4dCc1QqdcrYVBztSrDfavto+Ly5Jd3X+DWLg8mRJval1kqEJHK0aO1txpRy+W9wHXUhCVKYgzz/SOZmC8xDPAmwOABJl9KMgC85MpI8VnUszIB3YDcMFU6h14ik8cFo+ehhMN4REpRcSKmJD54rGWutVG6nJ+/cb0RYXLpCkpaZXnztiWpjpj/QM52Q/+jgerPA/bB+qFCTTUhpCk/L3MvNO+Z3+s92aSxomDo5C4aKqfBH2DnOxkKnCttK0DKnKmkYuN+FmPxeJbq75WR4Sexi270AbNEXqBYUbACbP+C8j8XWRZeAPIRTaZWtZVrYS5lR9GYqz+P444meYsCzULjlDUGf+iOTiUxiX4JuUuSBmsZeHbn7uZtqW+/Z5xsrjphLMo/r93IKKWjy2+7s7lrtajLstwv9teHjAypy9SFenYxpbk2xiBx9AHrLTdNY+gIuckIb6p8Z/id9PUpAVo7k5iA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(261022075727099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RqtCfn7CL6EiINuH6kEUoWA7lVaJTl6fPFV4Nht6L0IbKG0LgAxZu56+b0eRS4CgUj/i0STiFRzaW1Vv+C3ea8RU2o6Rq0mm+4vG3R5rhTXfeVHUF7rSEP900EughycHhE4zEXKZ8ld6INkutZGRwqSTH+jgDWEeVhz9Ldpw7RdrmxECayPINBZnk/VT/6RpxpqZkhoYD3beUg8N+hM2nX1foJsZY7FsPoAzdanJTI2BylW6qGKgkD55cdoyLi5n+1zWCHTSjWQ5dSUWoaMouhC9OwnF/SFUgQMtF1jH7a+AQJZ/w3J11BhFoYyLJqjL/sIKHVYzlgaXSt6S7/cEt0gnrDDysKX1N+qPYS/rT0AtJLSOx0cyr5HE1i67GFVR77HuyoSzC+6upRv9GMJcczr6rpcaKMZWsp7kiq3nOY19Fbl2MZwfLvbvocqr+rB4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:38:41.6369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1823b13-004f-445a-161c-08df3a5fcb4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34


On 11/4/2026 1:50 AM, Thomas Gleixner wrote:
> On Mon, Nov 02 2026 at 16:45, Mani Tofigh via wrote:
>> watchdog_check_skew() waits for the remote CPU with interrupts disabled
>> and gives up after a timeout measured with ktime_get_raw_fast_ns().
>> While the clocksource is still jiffies during boot (or with
>> clocksource=jiffies) that timeout can't expire, because only the boot
>> CPU's tick advances jiffies and that's the CPU spinning with interrupts
>> disabled.
>>
>> The boot then hangs when the remote CPU can't answer, eg in the
>> stop_machine() of the switch away from jiffies:
>>
>>    CPU0                                  CPU1
>>    multi_cpu_stop()                      multi_cpu_stop()
>>                                            local_irq_disable()
>>                                            /* waits for CPU0 */
>>      <timer interrupt>
>>        clocksource_watchdog()
>>          /* sends CSD to CPU1 */
>>          watchdog_check_skew()
>>            /* waits for CPU1 forever */
>>
>> Nothing gets printed.  With the hard lockup detector on in a KVM guest:
> The above explanation is enough. No need for this backtrace.
>
>> Measure the timeout with the clocksource under test instead, which
>> keeps counting with interrupts disabled.  With the fix, the watchdog
>> gives up after the timeout and the boot goes on.  A 2-vCPU guest on one
>> host core hung in 4 of 150 boots without it, and it didn't hang at all
>> in 400 tests with the fix applied.
>>
>> This bug was identified and confirmed with the help of a deterministic
>> hypervisor currently under development.  The C reproducer below however
>> hits it within about 80s on a kernel booted with clocksource=jiffies.
>>
>> Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
>> ---
>> Srikanth reported silent early boot hangs of large KVM guests that he
>> bisected to the same commit [1].  I think it's the same bug but it was
>> never confirmed.  Srikanth, would you mind giving this a try on your
>> setup?
> Yes. I gave him a similar patch which simply uses sched_clock()
> instead. That solves the problem, but I was reluctant to post it due to
> the lack of explanation why this ends up in a situation which does not
> allow to make progress.
>
> So your reproducer does:
>
>    while true; do echo 0 >/sys/devices/system/cpu/cpu1/online; echo 1 >/sys/devices/system/cpu/cpu1/online; done
>
> right?
>
> Unfortunately it does not reproduce here within a reasonable amount of
> time (still going strong after one hour...).
>
> But yes, your explanation makes sense and triggering it with the hotplug
> code is obviously a matter of probability.
>
> Though one thing I thought about before looking at your mail while
> reasoning over the possible causes of Srikanth's report and the possible
> consequences is that such a timeout might in the worst case result in a
> stale CPU state which is silently ignored. The consequence is that the
> watchdog wont run on a CPU with such state ever again.
>
> So something like the below delta patch on top of your fix (or the
> sched_clock()) variant might be appropriate.
>
> Can you and Srikanth please run that on top to validate that we don't
> end up with that?
>
> Thanks,
>
>          tglx
> ---
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -250,6 +250,7 @@ enum wd_result {
>   	WD_FREQ_RESET,
>   	WD_FREQ_SKEWED,
>   	WD_CPU_TIMEOUT,
> +	WD_CPU_STALLED,
>   	WD_CPU_SKEWED,
>   };
>   
> @@ -398,7 +399,7 @@ static void __watchdog_check_cpu_skew(st
>   
>   	wd = per_cpu_ptr(&watchdog_cpu_data, cpu);
>   	if (atomic_read(&wd->remote_inprogress) || wd_csd_locked(wd)) {
> -		watchdog_data.result = WD_CPU_TIMEOUT;
> +		watchdog_data.result = WD_CPU_STALLED;
>   		return;
>   	}
>   
> @@ -590,11 +591,16 @@ static void watchdog_print_freq_skew(str
>   	pr_warn("Clocksource %20s interval: %16lluns\n", cs->name, watchdog_data.cs_delta);
>   }
>   
> -static void watchdog_handle_remote_timeout(struct clocksource *cs)
> +static void watchdog_print_remote_timeout(struct clocksource *cs)
>   {
>   	pr_info_once("Watchdog remote CPU %u read timed out\n", watchdog_data.curr_cpu);
>   }
>   
> +static void watchdog_print_remote_stall(struct clocksource *cs)
> +{
> +	pr_warn("Watchdog remote CPU %u stalled\n", watchdog_data.curr_cpu);
> +}
> +
>   static void watchdog_print_remote_skew(struct clocksource *cs)
>   {
>   	pr_warn("Marking clocksource %s unstable due to inter CPU skew\n", cs->name);
> @@ -635,9 +641,13 @@ static void watchdog_check_result(struct
>   
>   	case WD_CPU_TIMEOUT:
>   		/* Remote check timed out. Try again next cycle. */
> -		watchdog_handle_remote_timeout(cs);
> +		watchdog_print_remote_timeout(cs);
>   		return;
>   
> +	case WD_CPU_STALLED:
> +		watchdog_print_remote_stall(cs);
> +		break;
> +
>   	case WD_CPU_SKEWED:
>   		watchdog_print_remote_skew(cs);
>   		break;


Tested on 6628e7d4c6b25 / v7.4-rc1:

1. Mani's skew-timeout change + your WD_CPU_STALLED delta
2. Mani's patch alone (without the STALLED delta)
Both passed on my large-KVM recreation setup (5× smp=255 SVM guests, 
~2500 reboot stress).

Without these patches, the issue is still recreatable on 6628e7d4c6b25 / 
v7.4-rc1.


