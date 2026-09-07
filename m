Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D95372058;
	Mon,  7 Sep 2026 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761556; cv=fail; b=iJE6FEk0fy2iO7oMvNyZbxpyQ9mJS7GHxulWNXN4mptw+e86FBU1hvYmyNt4vBw24Jj80mftcYuBQTjVC6JbO8ciSgRAruiL0GB57WU2BBUfKdPssmsi2NiYqFQqmgUVEIPuXJ3HDAlHnE63OZod/bxe1ghU4DkCeypilXy55EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761556; c=relaxed/simple;
	bh=/V65iypWjIuZjHhqstiTJ1OV7y7VWCalB/ryW6bpIsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADwfh2Yc/NYAQCJqaJBM6aJei9jhbBn6FDGd0CBiTnVISf5j2EVlgmOUKvBpj4RvyvJ5p7V6ddpkZp7HDaUr4WTJfZLWVO5K5knLXZuLvFydXQVACFhP446bFXroE9UaY6vMu5OToBRSPpirXZULNXgL/8Pt4wHCm76PM3TsNOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o+WQ7u3w; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o+WQ7u3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6B/SSxkTOGjgYxaOCNMwwu514WFp8HkcZ8OxI3t9WZ3G7H40hWqvRvZulswqXiEXHlioSdUZuuBHF5b2xUEHu7OlCzaNxJKTJ+Dma6/kMyqA76R/xNNiHi32lSK9hk5Et8c2rrX239hLXqfQ7pwGI+pNyFdBaidNXGh424jcBemHY4QA22fISOpTa73auDms1msajqz1TjyHJFyXgJKwPHs9EvzI60pFbfFVFu4zyF0c3/fE4J/BNME4NA5FrcJZc0i/BRYcSnGCD0GxRs4zL1AautlNRFJ6o26YB013Vf2tOoWCS7/anJexFrrEZT7ak8tNyIKlvv5tIOhAw0N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXH2I7+krE08KiMbXfRUjihTpMemJdPGaU80zjEBbf8=;
 b=jS+SsfVpI/XmnSf57EbYhgfuqzASsD9ZmiDmEwXbH6tqAjugJq1wH23HmYqDIBhtgYGbdX0qWMAPrfmGgsb4/HzdojeWhJ1lXyN+KXugiBdQ2RTDcM+LcTMsMXpdwEv42oil6SZZUtFmC9ih6W6uy7djGaqAYKIlyG2IQ4lgEwE+j1dZgkMUxGhspyPh/qcBc19YFb5NcKMGY+J71GKuVzhE/3HcMEk5xydCOvrbUnMvPRk6ZCJF4Yefrzncf/8irE3GEf57w4GIhKcan6R5yt+58rICzWXAkHgE/g5i/H55Sy9gpAx5Thkuxiu8P/2FWHJ4b8ePDX88cc8bVpJ6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXH2I7+krE08KiMbXfRUjihTpMemJdPGaU80zjEBbf8=;
 b=o+WQ7u3wtZff+8H8jShPV8eo5/STA+YJyf+O2hI/WdWl0txOc9pabzHy2f0275CNHq3/qXqsVUs8k79UfsZWRN0k18Z2fpNC7fuR9iS50yBqMQDn0RqN6qAClAyOtpgX/TP79YvzgGW+CHZZu5UyVEmD6jSm8Gj+st0piWmxvtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19) by IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:12:30 +0000
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99]) by LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:12:30 +0000
Message-ID: <6afcaa49-75d6-4f80-be3b-16b81d354adf@amd.com>
Date: Mon, 7 Sep 2026 11:42:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
To: "Guo, Wangyang" <wangyang.guo@intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "Liang, Dan" <dan.liang@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260826171537.4167367-1-Vishal.Badole@amd.com>
 <DS0PR11MB80182E1B2DE32122C96B607192A82@DS0PR11MB8018.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <DS0PR11MB80182E1B2DE32122C96B607192A82@DS0PR11MB8018.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::9) To LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR12MB999069:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: b966457e-207d-49da-cb68-08df0ca6ffa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	fAP8QQVn3yQnCXXX2h6NNVUO3yG6DD5yytwm6Nog6CCaS2aAUGfNKvX9iNuOAlR8DaJSg4Z4Wp6Y6Cr2+ZZuOtmKSlODdOQSCajLK2DwyNI2z6tJQMaSJ9a45SpazuKLiN2bSW+5nSbEd9UprsB82RVpZsb0noF0uVvSqUlr2Oi3mqoa+maXt94CLIw1fZ3yi6tdNXLEvrzT4MAlxCT7FqiXYdZj2KEYe0LN4+invVmL8iuLs+CC0n0G3vZhrvQPPJFDjlFFZZBabFDzfn7rJjyzbrfSL9jXhsRUDNkrEijn/2yRklwaeQ4ugzEwXJ0r1HHjSRNXxUo1fhJ38C1v23FdX8iHoDSIuXjYdEiueX3+1OvTvo6xD9hv7tWxjGPfeJCULyfzIQpc7btZunadyHBXm5Ul9VGZdDRJiug5T7++NMXSPx+apeMCP6ZKHE1edXK+algfsSQOG7A9l6eLc/m4f1bK/DbajZF/6DEvISVrAmexMA4JF9xzYjAyTfBLNWajHH59t+R3uIh34G2mTWX7X8jCNMCYFdf8KpowJIWfkjbS2huYDV/2WLKsjOH3tF28MP2IStP0HhjjqaumLwqwuUKqHQ/ePWcZJr8LGfgTvVu/NaYtHiAwgjDVcTF+aZKHAB5wNQjFRT5sx7/sfZFgfhvoHknkwVhmVfwJJ4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR12MB999069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2prd015dlRnTVhtRHEwU3Vsd0hNdDg1bGxhcTJqWmNwQzBQekg1UlZKUEpw?=
 =?utf-8?B?TWhXQncwbUs1b256N3dWbE95UXhFTjVNemk3THVhQjM4NnNIY29xdFROMjgr?=
 =?utf-8?B?Y1U0R2h6cTVnMGlPbmVteHNYQnVJVjZ2b1d1YnhJRjgveklRZU9SY0IrQ0VN?=
 =?utf-8?B?WDFjYldMamZHaC9PbG1GTGZQQ1N3REpCL3NWWTJIY0t2T1EvckZ0eEV4ZUJD?=
 =?utf-8?B?R0VlMTMwSXd4eDlSK2sxeXArb0tMRWRLRm9GQ1hvSk5KNnRkT2Q3TjFaOGpK?=
 =?utf-8?B?YzY4eVVMZU9TRTFVVCt3MVRVR1JidmttRndwTjVvSENaQkFJUVdCQUhBVmxD?=
 =?utf-8?B?Zzh2NnUvcE9ZdTFwWk82NG5NaHhpNHp3SVFiZnpWLy9JZlZXOFFyUjFrY1dq?=
 =?utf-8?B?VmUzWllZVXZPR3dTVEV5V0p5SEs2cVdSclpyQmVMd2FpaUh5L1RhNE9PNVJB?=
 =?utf-8?B?S1hHTUMxRnI5d0pXYTZSaWRMQjV1OFYyWjBOb1pKZVRNWlNRQTIvdHR5OXBW?=
 =?utf-8?B?RnVFc3h2N2Q3Sjk4RzVUMnNXVERRVWViZjVFd3QwMVBQcXgxdVVvekdxNVNQ?=
 =?utf-8?B?Z2JnRytFaHJOMjVvVVhrYXNKWlJkWFlTMEthMlNadDF2VTEyQmhQeUpnbldo?=
 =?utf-8?B?anVFR2EvN3RsKy9BY1FHSDVJRzE3cVdtTzA4alVJV2VsTDQzb2pKYTRmRUp2?=
 =?utf-8?B?ZzdIVjJ4OTZNMUQ5T1ptcnlobHZRVnAxeldiaXRld3Y4RFd1MllmTmNSTU5O?=
 =?utf-8?B?NnZJWUlSL0h3N2d2YXZ4Nkd5Zmdsdit4NFFMK2dIRUxES1dIcXZ6VzRhZHJp?=
 =?utf-8?B?a2hHc2ExNkx1UThIcTNyTHkzd2NWUUd5NVFYUkgwdFpsMXNWcUEzYWR0UHNF?=
 =?utf-8?B?bHVGNEFFQ2ttR0RSSHIwZk85QnRuZ3dmbHFPRmZETllhTitCK1R6eDV6UnM5?=
 =?utf-8?B?aVQycWt3RUpoTVBFTzBMSVpzNUN6OWJsQzZoYkQ5eUVCa1pQYVJodnBuMkNl?=
 =?utf-8?B?TzFxM3NkTTQ5Mk9FSy9CcndTY3hLV1ZMVVJwclpiY0hSOHVyS0VIY09rZE5x?=
 =?utf-8?B?MTB0WnR6UjZsUnFNTjA4Qy8yRU1MOFQ5RDdpcnNuSzBsT3FPdGZDRGlYRFBB?=
 =?utf-8?B?ZzNGN3BQM2RyOHpadTBZSDlhQWgrY0trMHJldGNYSTlQK1ZwTHFzd3c5RVdE?=
 =?utf-8?B?RGVqMDlOYldkTmwxMGZGSW9HRTRrTFhsV1h1U1BvMU9GYXdLOG1MMHV2K2Ra?=
 =?utf-8?B?bVR3SGtOODhtc3BzUnpqNU1CVmI2Ukl1UmJ2cXJqNkNLMHFvQ1p1Vi9PdUNT?=
 =?utf-8?B?VTZVN0JhN3hTYW56QmhrYkY0R1dnRGJhMlFEY3RpNnVRamFWcjFtbk1uR2hL?=
 =?utf-8?B?c0dFZmtYYkMxTUNadkROTUhDc2t0WWZLMEI0Z25kcXVYOVRBUTYxNVc3NHF2?=
 =?utf-8?B?U1NIZUlRM3hoeFVZRHFwQzkyVExxaEZrQVNJQnA5Tk1QMGFiNGdSSG5VYWwz?=
 =?utf-8?B?T0pDNnBiRWF4UUNZWHNRWERiMGJiTGZrbzRZMHRoaFc3aThEQi9KRk02SklQ?=
 =?utf-8?B?MGJGeDlBR05mY1puQ1d4WlQ4NCt1QVNaT2JMUGV0MVVhcE1SYUZmNWtzeUxR?=
 =?utf-8?B?aWZqaW5TZXN0Uk4xTUpUaWs4UkN5YThxdjRPT24ySSs4VkZjOWhsbFlNMm1O?=
 =?utf-8?B?anliZWlCYlpLdWp0djU3TlB2Wjk1SysrRExzbEVON3E0UzNuNEFUQ015dDlv?=
 =?utf-8?B?RnFheXZiN0dYT29hNGUvbG80d3MwYktlcURBNG9WNkY5cWRicjE2QjlON0t2?=
 =?utf-8?B?QmxXTXJaemZFR0xaekRJMVB3bSszTmllMWlzbWVMWGNZQ0IyZWduQ21rb284?=
 =?utf-8?B?cnVKUlUwUzJVM3BQUGx3UVZrMG5uTlQ3SktiMDZ5UUZZK2dFb09EbVpUb2hq?=
 =?utf-8?B?N05MWnpFeVhmeGNhdmViU2JXNndVRURpYmhiOEtqNUd3NmNkV3hCV2Y4U2Ny?=
 =?utf-8?B?RzRsdEp4cCswQ1AxVHpWUjlWbXFkbmorTTZjZUJ0R1lrWVpVanhPWTZwakRp?=
 =?utf-8?B?UXJIcjRHZHA4enJSTWFKZGlScDBJR1ZPSExNS2hVeUF6a20vVkNqMkxIUTRL?=
 =?utf-8?B?UzNycFEvUU5IdWVxSDVrY25CUWdDaVZBWm9VQ0YwNzBGak5aUzVaMXJIOUFh?=
 =?utf-8?B?ZTJ1THJPMnQyY2MySlBjNGY3QVlSYktCOXdNZUp2SnRvbTBHU0pIQzZrbmZy?=
 =?utf-8?B?bjIxeWovZDd6K1k4cHNZb29waDQ5eVd3Qm5zYy9LMnhEdXZ6SXA0NlUySm1V?=
 =?utf-8?B?NnZTUldGL1pLVm9DQm1yRlFnajJYbnhiRzVINXJnNGtVelZsSmI0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b966457e-207d-49da-cb68-08df0ca6ffa2
X-MS-Exchange-CrossTenant-AuthSource: LV0PR12MB999069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:12:30.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B30yCtR5rX26kKH/VaExZApA2IuBr1clOBWfLybnk+XALwXP3cxzpglJvl+uWHYzflmTMPutOAUt9EMKXoYi7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

Hi Andrew,

On 9/1/2026 7:18 AM, Guo, Wangyang wrote:
>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>> ---
>> Changes in v4:
>> - Drop the index-based unwind; reuse the mask-based cleanup path.
> 
> Reproduced under QEMU via offline-cluster + reset_controller: I/O from the
> online CPUs stalls (QID-timeout/completion-polled). This patch fixes it.
> 
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> Tested-by: Wangyang Guo <wangyang.guo@intel.com>

This patch has been reviewed and tested by Intel, with corresponding 
Reviewed-by and Tested-by acknowledgments received. Could you please 
consider merging it into the appropriate branch or upcoming release?

Thanks,
Vishal
