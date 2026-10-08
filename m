Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7638D6B5;
	Thu,  8 Oct 2026 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493949; cv=fail; b=nPs1qMTsuyBGavinJEKYTkPGrI4jZ2ZGabzMxil97vRrbuGyEDHeu/IflSJPyIJLw55Lh0Y8tHR4w8j5ZoW7dQO/mstX0ZczURHRVC3fPMGApI3GWSnEDjwyjURNzNC6TLWZU7Pnmyr6sF2gNTYQ3pVMbS1kIjdKuEzgPkXHIaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493949; c=relaxed/simple;
	bh=kBj5v6OS4FkPAcWwmZ4KjJH7zZdtKJ1aHJ0H1VpNMQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fI+6vsMD9DykWHop+OExuu3BKFnY2zgqxVqQXVKqyV+7Ycy2b052izKd+08iZzR2TxaBz+uouiLAd1YjqqbAJZCh5UXm3my71lNt2EqOpnKJBtoTonjIrozjzragvgCtywykGkfaAyrYmT0NG6wpJ1XX01y1YoFRmD1MzcPGlfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0RGpeFm8; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0RGpeFm8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU0kSSvGTb2PXdlZE0exP0APYf6aYrCoFkMddb5WAV7Iu0Uv5B6NcoywcswXL/DRaSGVXL8Va3fLkQuK12ogwatxSnl1zhRHKuIOCYgpyqwZegLo9Q/T5an/mY262Tm64N87lHBY4gr1AOkZGNisuJ98UR6jw922+TXpnSEyaLxtUfP99lfGqNArKs5xLijxFjAvil25rQzhv16BiwWwQjY3wl7lnwWuKIYQB7uC6Z5OVPRAiWDRbg/jIqrPwLI0cF+rXwwvD63SXwbq/cKV6FmkO21c6vEnqffwOa/Us9vRzj2bQHc/NFSkJEZbrvjfmk/4TH2j1s5qRwYxFqLQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnxFE50ky/APfLOFD5qUvqHJAEkZyyYGbLaXEbLUVy8=;
 b=KvScUFS4wKpKCCvDWFJDkGnUafDaOnyxcBG0Lf+64Wszza2sCXIkfGp6u2s1+Xxw52GTRXy20qFkkicfqzP6NN1jm862SuWlNzqg4aqQ69H7zVtfFamhjW3xw4sVDoieMTLq0q8O7ZKFzymd8uJpS3vRqlcU2fJf/Y1YsmmzB8A02vfCGJUl5zaKEkg5v+qIIEjElp/qR95xkmPX4K5/6CQPlvktaysl5Ja9ICO2Qh3l9L+YQv5Ituwrgpg2nCxuxnny7KXC+N3avvTXUEsh0P0sjMS6MPFEBOmJfAFPnQDK46Lni2U6Tjh+vyQ2RlaQyV4DKrT3lxX6/48Iccj02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnxFE50ky/APfLOFD5qUvqHJAEkZyyYGbLaXEbLUVy8=;
 b=0RGpeFm8Cp92OD9Tp3eM3ILWbbl26Z7k7NOkx3zpcl4HSMkH0nVNMwiujLUQ7g518duHjXrbwd3V/DzCyZE7PyFGMhtzCJwT0wsu2PsbNMgRLSMYd9LBv3Eq4DTf21to0IkcZQJeTGuVcmOkLNtZZ/V4S6YBY8mbp0zp1TgktHk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 21:12:24 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 21:12:23 +0000
Message-ID: <851316da-2cfa-4a22-947c-1838532d05cf@amd.com>
Date: Thu, 8 Oct 2026 16:12:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Don't fail active mode init on
 read-only auto_sel
Content-Language: en-US
To: Akram Boulahia <akram02st@gmail.com>, Huang Rui <ray.huang@amd.com>,
 linux-pm@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Marco Scardovi <scardracs@disroot.org>
References: <20261008040705.10600-1-akram02st@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261008040705.10600-1-akram02st@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:610:11a::20) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: f34b6298-ff59-4435-4fc6-08df2580d87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9o/wyQ8kbp+UQtotkEv3R1OQRtxHH3kNt7mi5cIsEcfkD7Ujw4A1exiND6T4fEo9V0lS/GHlvF6/+kRxwMoNUpwSrUuFrG05r0/58QEDIFwcbAsnthwK0qUMn+6ch4PwOR/IxfdhNUJwTszjY+O92ZhxdQq6SYPOzXhhZq933OyA2TlllP1/vYX2Z9HTpAaCyb6Jb2jnpNS1RoSmrofiat0eed++yxqms2jyzWfk1vMpel6PqMzWuW1OPm0YaI0Fg3tzIBZ+d981AFzO5fAJRU6Oi6MLFBp1G/fFQq9yeDSocf6xWqGdPPaxln/nMWt3EXmsEm9OcIQkFzGDslqgPLodT4P6aDYn3CZyRhnL1k3zBwYWCORDqxg2xKMhRDSd4GB9CxdvGW0RvHoWelZx4QtJ3x1L6Ue1eOJ7WCs1+1YHy2q7GJv/MtyUFn5SpXRsbiYTMXzJU01XuV6lrs7VPnANNbY/gCVh5zN20sJ9j1offY6ltw97VX+p4tLgSsYIFe1mSIjgeKi0sA1DWkraqCpFaJunD1y5DxU1o1Pw9yFpEsR6S/r1/XjSVZgg2KfAJFtCLyhF2QNimPSVZ3AhaQ/5B4rEBDZxr2No8kRm+vFoXscvdvw8XZgNIqBFwo4RzBdLVYUKqpB6mYHPCS+NnLMUSvnCSb2EPyEVbHRdWpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDNuc3JlTmRNQVpaRXFnUjBoaDd4UjhoWm5lN0FKS3ErcllRZnVEWG1pbVpT?=
 =?utf-8?B?dkozWTBQTkpHN1NlSlhPV2ZRMUZEV1piQVo1ZlFSTUcva1pwMFBLWGRjZ1FS?=
 =?utf-8?B?cXN6emsyd1I2VTRncm80dXNGdmZ4UDhWREJZK2Z6blkwZ0ZUa0Q2aW9pSGVy?=
 =?utf-8?B?VE5rMzU2SmJpWWZxdGd4VUt1aWdOL1NtdTI4cjljMmk3OXVPcExWajFHK2Uw?=
 =?utf-8?B?VWFnb0ZyNjZRV3NQTmtjYm0wUVM2L1NabXBXUDErTmIxVEFKbmFrdHFXeUR6?=
 =?utf-8?B?bldLSjRqbS9UaVo2MjM1Q0pNUC9vMWJKSnUwU0pQR1FnWnVtakdWWVF5VUhY?=
 =?utf-8?B?cU5zNmZyTVpRZER3dENwUjlRVjJ6TVNiaVlyVEhWWFdLc1VvM0tMTTNRTk52?=
 =?utf-8?B?ZGZieW15SUNKejk2WEhIK00zMXRmbllQc1g5SzA0Uis0WWlqb3Z1WnRPTkJJ?=
 =?utf-8?B?amJLdG5iSmpTT2pEWEpkVVpZRXVnRVdyeVZOUXRlTXVQcFhWa09Qc0RqQXcw?=
 =?utf-8?B?V0dFM05uZkRLcTJCbUJuSUFMZE9HVWZzbm1NRjhxZ1VldFpaMnE0UWtaRTlk?=
 =?utf-8?B?MmU3Z1JRMlhseEloT1NBYitsLzdsd0w2eTJmMWZRTnlCRS9rVTNjOGZIRUh0?=
 =?utf-8?B?N0FlNzVaWUQ2cjA5aFgyUVpJRkpYNWs3N3dRNjNRK09TNVBQSzI3dTFkL1hJ?=
 =?utf-8?B?azY1WWdZQXRFSWVzL1VSOStmOXp6cXRSSHZrY2tXYzkvNnp0aVRWQzJyWEIw?=
 =?utf-8?B?MHJqYldoL3FmNXJGOFlEYUhRczlwY09WNEFuUGZMbTRXbzJkdWg2SkN6VUE0?=
 =?utf-8?B?bk5wRWd3cDJNRjFxWDlIUjEyaGZNamZvU3dyVGNmcERUQ05ZS2N5OXllcTJm?=
 =?utf-8?B?UzIvRGxVek1UbkZUa1pwUkJCYkpZUWFWcGdaWnN1UWJVbDFydzV2Mk03K2sw?=
 =?utf-8?B?dnVZSWxGcjJ6K0hVT3Bjek14M2NxZkNiSmExcGRyVnRtL05jdzZQRlpRVkxW?=
 =?utf-8?B?MGU3NjhIN0RDcjJSTHRCTDZGZjlBQm9nOXVGS3g4bDFVYldNK21GYm1VQXY2?=
 =?utf-8?B?Q2NSRXJPUS9WSEVqVFpjL1liQTJnNDZFb0Zya1duTEJKTVIzcWN6UW1kdnhY?=
 =?utf-8?B?NnBlSkwxVDZmSFE0VDc3cDArcW1XY0FNalR4LzlHb3B4VzUraFFQQ3ZVbUFH?=
 =?utf-8?B?TGZWZjdpakoxdWhLL3FWY1lPbGtvQTRwWndnMWdDY2tPOGtVdjA5QmlXQ1pI?=
 =?utf-8?B?eDNIV1lTRGtMRXllcGlQUXdiWGRqQXhTcTFJR3IydXdOV2dnbVErQkZkekdT?=
 =?utf-8?B?WU9iL1BBNUtaTEtuamU1cUx5NGFLa2d0OWJ5S3BOcVN2S3VtMzBuVkRJVG13?=
 =?utf-8?B?KzVOQ0xoOGlMOUw5ZGdxMWo2WlZtWFAzMUNZYjFWOXhyanB2dzQ0SVk3TEIy?=
 =?utf-8?B?Z0cyNjlYSnNyRittTmozWGhnSEt1aU41dU5HcGRuSXN3NGNRTzh2OGNkS0lR?=
 =?utf-8?B?TCtrRU1KamhQRUtCTzMvSDdaTFBhODNacTEraHg2ZVdFMi82OFB0QU1vUHJE?=
 =?utf-8?B?bWpEMWFaamx5S1JEK3hheWJYNTFvYlZwY0FxNENXWXN2bDV2VzdGMFNBWVNH?=
 =?utf-8?B?MTl6OGErU01sWGowdWxwS2tzN2VtdjhneUpvRHpWTG9PVmZMZ29GTElWNDJH?=
 =?utf-8?B?bUVka0Eyem9tTDNvWHFyM2I5RFZYNDI4Vm9ISGpqWWxPU3gzVVRoMW4zS3Bi?=
 =?utf-8?B?SWxQRFdFSXFHWXBvbTNhalczdDRDZ3lEZ3ZxYlV0UkhmWElhM3Z1Y3JCcU9r?=
 =?utf-8?B?WGtJeDcyaEg2Mlk2eUgySjV6dG9MQzF5dlZnd29LY291NWpSbUpRVHdwVU14?=
 =?utf-8?B?SnoyYjU2MmtXVkFUbVloYU5YL1JBdzBEMlIrOWk4Q1Ewb2xaSEpSMHFOS0to?=
 =?utf-8?B?bEJOUjBxVzdWNDYwWFRzVTZRbUNKYURmZzNEcnZLb0NUS05uZnZUREVYSGRV?=
 =?utf-8?B?QVFjeVVjVXY5bVJheVQ1T01lMDV0cHkzRlgwSVJLdUw5bjgwUGxYaXFCcWp2?=
 =?utf-8?B?amswRDlEWDRCeXhBWklVcHd1WS9sV0d4MzhGUExpYnVWQkg1QTlGak9NQWg5?=
 =?utf-8?B?MXFlSTVMWWNoOG1MV3BSVDRkSENzTTIwQjZ4MDMvMnI4YnY1b09KSEJDT2h2?=
 =?utf-8?B?K011L0FjQW81bU5aTUthdFR2THpyZmFnbDExbngxQ0JPc25hcUd6bnMwVUxt?=
 =?utf-8?B?MFNySDJrNkFxdFBIdUFvVW9MTVZXOCtuOEczK2NhZDcvZXNuR2tjc0lNakwr?=
 =?utf-8?B?QURzRW9sUU9JRzE1WUtyNTlJN0hYNFFDb1NlRXdWSm9EMzZNZmJUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34b6298-ff59-4435-4fc6-08df2580d87d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:12:23.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqU7wbWvRN6B2akOGX+SHSkfb1pWMY9XBrpM8rIwbldXFfvmQbhPN0Dtye9p7OWWPeeMsx2MA/bfecUa8BpklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593



On 10/7/26 23:07, Akram Boulahia wrote:
> Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
> mode on shared memory systems"), shmem_init_perf() no longer returns
> early in active mode and always calls cppc_set_auto_sel(), which was
> needed for shared memory systems. However, on firmware where the
> Autonomous Selection Enable entry of _CPC is a constant integer rather
> than a register, that write fails with -EOPNOTSUPP. The error is
> returned, every CPU fails to initialize, cpufreq_register_driver() finds
> no policy and returns -ENODEV, and the kernel falls back to
> acpi-cpufreq:
> 
>    amd_pstate: failed to set auto_sel, ret: -95
>    amd_pstate: Failed to initialize CPU 0: -95
>    ...
>    amd_pstate: failed to register with return -19
> 
> This was seen on an ASUS ROG Zephyrus G14 (GA403UV, Ryzen 9 8945HS, BIOS
> 308). Its _CPC tables are revision 3 with the entry fixed at 1, and
> cppc_get_auto_sel() reads back 1 on all CPUs.
> 
> If the write returns -EOPNOTSUPP while active mode is requested and
> auto_sel already reads as enabled, which is what active mode needs, the
> refused write is harmless and initialization can continue. Any other
> failure, including a refusal where the current value does not match the
> requested mode, is still returned as before.
> 
> With this change, amd-pstate-epp loads on all 16 CPUs of that machine
> without warnings. amd_pstate=passive behaves as before: it still falls
> back to acpi-cpufreq with the same -95 errors, because auto_sel stays at 1
> and cannot be changed.
> 
> Tested on Linux 7.3.0-rc6-00037-g7b63ef2d55f2.
> 
> Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
> Cc: stable@vger.kernel.org
> Cc: Marco Scardovi <scardracs@disroot.org>
> Signed-off-by: Akram Boulahia <akram02st@gmail.com>
> ---

You're in a really weird path if you have an 8945HS that is using shared 
memory.  That system has MSR access.

IE this sounds like a severe BIOS bug.  Let's see what happens after you 
update BIOS.  If it's still failing please share an acpidump somewhere 
(like a kernel bugzilla).

Need to make sure we understand why your system is behaving this way 
before making code changes.

>   drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8bfd46d60843..05b496946d13 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -500,6 +500,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	u64 numerator;
>   	bool auto_sel;
> +	bool want;
>   
>   	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
> @@ -518,14 +519,23 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>   	WRITE_ONCE(cpudata->perf, perf);
>   	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
>   
> +	want = (cppc_state != AMD_PSTATE_PASSIVE);
> +
>   	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
>   	if (ret) {
>   		pr_warn("failed to get auto_sel, ret: %d\n", ret);
>   		return 0;
>   	}
>   
> -	ret = cppc_set_auto_sel(cpudata->cpu,
> -			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> +	ret = cppc_set_auto_sel(cpudata->cpu, want);
> +
> +	/*
> +	 * Firmware may expose Autonomous Selection Enable as a read-only
> +	 * constant. If it already matches what active mode needs, the
> +	 * failed write is harmless.
> +	 */
> +	if (ret == -EOPNOTSUPP && want && auto_sel)
> +		return 0;
>   
>   	if (ret)
>   		pr_warn("failed to set auto_sel, ret: %d\n", ret);

