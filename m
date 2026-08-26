Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B571DD0EF;
	Wed, 26 Aug 2026 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787714082; cv=fail; b=A6oGE1fnDj9gtkYUJrgAtpWfXR4WH2UwcCVYtIUKibdmQ9P2peOd+5z+D/00dqeM2id0WST/IPSjdkrRrW2ZE/0G5KKDqWS0pvnwR7A0mQCC9F0jHtj+iWJRKXq4T+7MmYHCJ3LdX8t5Lt/ZLBC2k0hSbKfIDkCq0Iu/iJPxqlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787714082; c=relaxed/simple;
	bh=G/kjhJ3YvCrpzwViDlE+FZXGIZWqpe0aAWPiCiFOwiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pos7UpVLfkBYgBiWXhq6dZ8aSRP5S4ux4bbEX5afnOqYCiZ1IvwTP3DmMiNOXoW9rrw0yGWHdSffOTN5Wf6CowW9P/nZhJnUSW7xzjuh5LnpgM36YgMTzZDaLXjkd+R3wYbHsz4i32g4EcV92CfbO9RP9emisw/PlfKDKZAjk2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnXMHGCH; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnXMHGCH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4cPIv/z90wqv3z1CErb+vvghre4C4Fyp5hlThnzON6b2usq8Ha3QgslnO+2iDJrk3lnQYElkMHxDT3g9PDFaB7+tOZ246aZlgFhRaMZKMhu6FW427Ep5YzVyK6nj3lb5ZeV5tMUmNRE+KVOOm90T3SSfrYOnKxGOsqegdHCxAHr2aUjO7U49RIvnPQCPHO5l0ixeD2yDigvlG8c8f77RZfTV9B4LTkoKXFpebbxRAJLMziIPAARRTkf9VDNszRgd6iMi2GJSTC58B7kxbQs1+RIwZpIEZHWwK/XzDkw7ojs+vx+NMbB/RdHVkEF2AV1L/zCTuBMudpUl0j5lz3Paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6icZwu9KbpmS1uTfiwbXJncCtj0zSfVfaUaNx+j7s6g=;
 b=A5y5C3a2Dcpt7Mdz3KzFlAmBk/8hjZfdtWysS3OMyhePBUkqPVLue1WcwrKObW8wSHU428ANX2D4oLZJLE2xmjVDn1pCCT+2o/okfnRkStAZk7DRTmYV/GFjgh7MNIAujDLjkMbtyGSwotHkZL9R4gS4VEYH671rN+iKIQR1d26OQ/vmzlvjiX4qTdAb6zWSsayDw0fwQgsiuBZ7r61ZYDf7V2SzqFQsfZaNgQXClPh3kqDalr3DYXDG23ydK5akF/2BvyjyksV8m+xDdYAGyQHqGxyQxbuPT9ZPxkkScswE+pDboHuR35qgrDln3r1oLFrfOCXkoHoqQ39kRc/C8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6icZwu9KbpmS1uTfiwbXJncCtj0zSfVfaUaNx+j7s6g=;
 b=rnXMHGCHbEnBTQsdRsStboCs8BHxZBvLqiKJg4bY3PZO7v9NB96k6zeGZhYLkv825nfGUh8uXHqTIYndZ3YyIV6+jg0UsPF6sOrAZCfjcbDVWsT6vHO5GLmJDwkx2kqq2QRjtijvLCiSme9Co2eMaVRyvRTuv1TdDmPYT786kqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 03:14:35 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Wed, 26 Aug 2026
 03:14:35 +0000
Message-ID: <f6f2f984-f31b-42c9-b120-6c179803dd2b@amd.com>
Date: Tue, 25 Aug 2026 22:14:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
Content-Language: en-US
To: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 Michal Pecio <michal.pecio@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Forest <forestix@gaga.casa>,
 Slavik Dev <developer.slavik@gmail.com>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
 <aosGtkE_diwVJJtB@eggarch> <20260823174059.46fec036.michal.pecio@gmail.com>
 <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>
 <CAPyJwA9GvqeaBYhN56L1S9YW-rwWgFejrcNcE=54DQC3Eaqxww@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAPyJwA9GvqeaBYhN56L1S9YW-rwWgFejrcNcE=54DQC3Eaqxww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:806:27::25) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8026dbf6-05fb-43b0-03fb-08df03202757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|56012099006|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WM0iJA5FsJLeXr9mhZaOQTpoEey1vA+PgwNsvJK1bQbPucBYcpaykanOv7pfXMKXnMJT/TWHTF7sTpypHk3PQsmVHzUHSRTIFCgmCdfKPpeWEzIiVSRZ7+T5nJA5db0jnhdAVIIU3RdWPVm1kS28JWRFzShmqEtB4T+oBlRpNhRszoDpdTQC/hl6lZWGUuyGhcBGT54NxdNcu+Us8x9/8u4tRi0xHxNTiLpAmh+z4Bc+zOoHmNSJv/QtkI8pq2/aGxwkeNByCNFXasr7iGY/A2F8q58b6cRhj3IgEdhkNQmO0WnbQbz3BiH4j8gj3wahEuSVn9WYuAyFtRdhQQR550BWgGv/XmwHyajf+9WTxCve7ALM+O8ebLaNfb1aZl2MCnhtaGxRECv4TD7ABv2R3guRySXEcGe/LaSpSQCFmLEECWeHWQUbeGUTj+0zA7aTqY0lfCphCGl1WawBe8h1Tl3iuFaeYPrz0ApP1poQ85cYi84695AfM+/mtUYnj5PNAvGiac+IlIicRZuag7/nX0Czb0KuhxAfe72q/zqLEQYhEXIC6o9LlpDsba6VIYi3EIE/VBIGlxJvHOpSI8nfEpIF3LlF6Jrn8aFSlQzChG5WaLDmKnR8wfg7RWSDMc7OCaxjS2xei1RQI6Yr1MuglONZ/kwn10POmeBE8FkGhQA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktGbk1qeHZ1bG5haDdqTGpFcWphZmFMMUtIZDRjdlFabW5qZTR0UWRwdGkz?=
 =?utf-8?B?cFpKRjhUNlR3b0NUeWZxRlVrZnAraXpNcm9uSUVXazRFQ1NxTmRFOUJ3c0ps?=
 =?utf-8?B?N2wyNklOU1dXMjRFZ3VSRmVRYWRicElRZ0V4Szh0SjkvbERjY0FQVWJZSFlN?=
 =?utf-8?B?Q2tZYzZRSngzRnNsdTdFMGxrVTA1djhFOHJ0dHN6Q3BHRHEzcS9EWXR1TkpH?=
 =?utf-8?B?YWptcSsyMDFkam91VWFnTHdlUVUzNlY4S1J2VW51bnYxMFJ2eG1mMHUyRnlS?=
 =?utf-8?B?Z2hBdlYydVZTTXdtRjc2MytZUWVDYnV5K0lET0ZhNkgzam9KUDgvTUlYMVA0?=
 =?utf-8?B?TWgyR1NpbURoVnFmeGxxbmRrK0JEY3oxNGlMTTlxQTE2Y1hEWDVBTmI3YlNX?=
 =?utf-8?B?ZVM0QkhCWWhyNGYzR3NabjdIbHdlR01nZEowRFZ2UDE2MENrblAxenlMbHZ2?=
 =?utf-8?B?N0hyZmFvRURBbm1RMzNwMWtVa3d0WFpQKzQ4TVB4MlBUWlZSV1FhNjFDSFVU?=
 =?utf-8?B?b0hvcFR2NHdLang3QlJnck5qdWU2VXBaTS82VXR1L1VBZnZ3Vnc3UEZaTzNM?=
 =?utf-8?B?N1p2ZUZoZUFTY2VtUEg0dG5PeExqbUg4ZTVOcWJjeDZLbDA5YjlzbXBCMzRk?=
 =?utf-8?B?RlpjbVQyRXRFYkd3Y2tRdTNENENzV0lLa1ZGMW1kUG1pbHNHL0hleXVVUTJ2?=
 =?utf-8?B?azM2L2R1blN6WnozUDFqOEloSVplckIxOXEySUk0N2RBYWVoWi9PakY1WlVD?=
 =?utf-8?B?TzJEaWp6Q0VaQ1J4SDNNTFFiQ3cwVU9Ob2dySU5oUEhLWklPYnFrSWpaVW1S?=
 =?utf-8?B?WS9RSkV3bG1CTHFvZDdKM0RJcEI5Yy9LMyt0Wk9rcnR1aHFDRXRwQ0RPbVBZ?=
 =?utf-8?B?VWJmK3pCWFVpbzV2MmVRQ3ZsZkhxalpRUytUeFA2NjYyMXQ1NDVRbWtHRDUz?=
 =?utf-8?B?aWJXU3lVa2p2dWVPbjVEcUZneGdMWDFWanViWFdjaXJHMCtpL3c4UFdyTi9s?=
 =?utf-8?B?V3JrYlRDL3V0RHV5S0ppc1NLQ3A4T0RnUU5HdmNyeGlnNXYzM2NQWHpranRn?=
 =?utf-8?B?NmZObElPaWNFWnc5NzR3SlJZMXFsZWNKQjFQa2RwVzBJekppRUh6VmpVSTQy?=
 =?utf-8?B?cmVDYWRDc0c0RzBVZlA4UkUrejZxOGpkMTAvOEl0MVczdkNxUHpRVWU3NnJC?=
 =?utf-8?B?UUpFYWxITjVGWFVFWXBMZUd1Ukt4aXJxa090a0NYZWtjK1g5eWdnWmpEWVF4?=
 =?utf-8?B?MCszcVViN2ZMdGgvY2ZWWFViMkI3UXgwVldNa1JucHYwZlJpWTZ0QmRBRHNT?=
 =?utf-8?B?dFRKWE9rMmxKSFBZaUxtbXZnTkNLdDFlMGJ6Z3d6WTJzckhibnkzaFo0ak1X?=
 =?utf-8?B?MWtGMzI4dHNFd1FPb2pLUi9uMjUvVFJFWHJzemRBaHZpdGpJU2RLN0tyVWFr?=
 =?utf-8?B?M0ZiV2dEVVkrVjN1S2h1cGIwZHluak5ubHRsZ0hiRno2RVN1WUVZT2lzTVE5?=
 =?utf-8?B?NUhwbnZwZkpKVFBqekpzSjZNTkxid0R1SFJ1T1Rxb1NwMWpTMTdFMjUxYU1x?=
 =?utf-8?B?ZGhkVVQrZGdEUnFxR056UFovc2svb3I2TXFnWFh4aVNxYUpWbGxLYjFaMmFS?=
 =?utf-8?B?TEFjWmRKU2ZuKzZyd1pCQ2E5VFYzRHdJUzdxcWZ3OTdEdkVmaGFjVU1tWS8x?=
 =?utf-8?B?c1UrNVY4VWtUL2M5ellsWTdzZDVEcDNWY3pZcEtHcHZBV1IrdWFHMmV4R2V5?=
 =?utf-8?B?WXZaSVpNNCs4ZGVZSGw5cm8wTjloY2ROK09nL2l4WTZOVEI0Wmk4R2dTRVhR?=
 =?utf-8?B?bktiU3dXTXgrU2xydDE1SHF4eFVGUm9wTWxsTHNZWFJOeTJiQzdLQkxmbGtL?=
 =?utf-8?B?QVNPVE1FYVNTT2NuWFYzeUd2MXBWRU82SVE4SCswbUFBTU9WWHQvQ0lZWWdv?=
 =?utf-8?B?dWN3MXB1UzNNclN2Q3dqT0lxN3l4OFR5ZkpQaFFneGZOUWhORG0yOUMzR0RY?=
 =?utf-8?B?cXZ4MUNsQzVNNTZTcDJjcWRHZnZuVjQxeUY2NDQ3eFJGTUVJYm5FU09NQk1H?=
 =?utf-8?B?Q3l6RDJKRHowTzJGei9lSUZYbTc5dHJrT0ROdEp2RVdiMWZ2OHhnbDZmQWV6?=
 =?utf-8?B?cUIwbE9lTkpuVHNyRndkSnIvOHc3bmxQZFJsNUozZ2hzQXhOQzVNZHdhUlNV?=
 =?utf-8?B?U2JOMm94VkVZbE95SDRFOXhWbE9iUVlteFY1bjRDT3JMeHlGTWx0ZldFY2dF?=
 =?utf-8?B?a2llRnRiNnRNSUlMQUdselU2Mi9LTUcrTTJ6Nkpxck5uTWZjVlJ1MWlKNUFk?=
 =?utf-8?B?SGp2SFRKM0ZwdjhmSVZ2aitpN3lmYUhyZVdNVmdEMXlpUXJvWFM3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8026dbf6-05fb-43b0-03fb-08df03202757
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 03:14:34.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrZPESk8Yru3j0j9kRoqrXPGC1wepJ0gwFpUZ7sd6g5Yoq7n8i9q1qOF2EuXl4Nlvj5bgW7tqmDi9bBhHYcLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253



On 8/25/26 03:57, Mathieu Fluhr wrote:
>> The behavior that is described here sounds like a platform firmware bug
>> Are you on the latest BIOS available from your OEM?
> 
> Ywa, And I even rolled back 2 BIOS before, All 3 are showing the issue...
> ...even the exact same one (with the exact same CMOS settings) that I
> used in 2024 without any single issue.
> 
>> Can you please confirm:
>> Your CPU model number/codename
> AMD Ryzen Threadripper 7870X 32.Cores
> 
> mathieu@ubuntu:~$ cat /proc/cpuinfo
> processor : 0
> vendor_id : AuthenticAMD
> cpu family : 25
> model : 24
> model name : AMD Ryzen Threadripper 7970X 32-Cores
> stepping : 1
> microcode : 0xa10810c
> cpu MHz : 2188.582
> cache size : 1024 KB
> physical id : 0
> siblings : 64
> core id : 0
> cpu cores : 32
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 16
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> pdpe1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology
> nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor
> ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx
> f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a
> misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
> perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp_l3
> hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall
> fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq
> rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw
> avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc
> cqm_mbm_total cqm_mbm_local user_shstk avx512_bf16 clzero irperf
> xsaveerptr rdpru wbnoinvd amd_ppin cppc arat npt lbrv svm_lock
> nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
> pfthreshold avic vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku
> ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
> avx512_vpopcntdq la57 rdpid overflow_recov succor smca fsrm flush_l1d
> debug_swap
> bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso
> spectre_v2_user tsa vmscape
> bogomips : 7988.27
> TLB size : 3584 4K pages
> clflush size : 64
> cache_alignment : 64
> address sizes : 52 bits physical, 57 bits virtual
> power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
> [..]
> 
> 2. Your OEM (from /sys/class/dmi/id)
> I am using an ASUS Pro WS TRX50-SAGE WIFI
> 
> root@ubuntu:/home/mathieu# cat /sys/class/dmi/id/board*
> Default string
> Pro WS TRX50-SAGE WIFI
> 231230340100705
> ASUSTeK COMPUTER INC.
> Rev 1.xx
> 
> 3. OEM BIOS version (from /sys/class/dmi/id)
> root@ubuntu:/home/mathieu# cat /sys/class/dmi/id/bios*
> 02/03/2026
> 13.17
> American Megatrends Inc.
> 1317
> 
> 4. AGESA version (see commit bc91133e260c8113c1119073c03b93c12aa41738 if
> the OEM didn't tear it out.  Otherwise look in BIOS menus)?
> 
> The BOIS shoes this information (I also put the ones from previous
> BIOS I tested):
> BIOS 1317: ComboSP6PI 1.0.0.1e
> BIOS 1203: ComboSP6PI 1.0.0.1a Patch A
> BIOS 0803: StormPeakPI_1.1.0.0g
> 
This isn't a BIOS regression, it's been around since the beginning on 
this threadripper model but it was harder to trigger.
The Linux kernel changes in the bisect exposed a platform issue.

The workaround you can do for now is to disable runtime PM on the XHCI 
controller to avoid triggering it.  But it's a platform issue.

For a proper fix you need to reach out to ASUS to get an AGESA upgrade.
You can ask them to reach out to AMD if they need assistance/guidance on 
the versions that contain the fix for this.  You can share this thread 
with them for reference.
