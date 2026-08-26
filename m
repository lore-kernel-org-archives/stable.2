Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4101279907;
	Wed, 26 Aug 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758387; cv=fail; b=px59X2EpOOYPtUcyzecWSlOM2nwwyZqfylewna3eYdgEPVBnxTd11wXRihyWBdo6k0f1llxasvCePDxYzdYvPkYR5+s1QUR0G0dE+Q+bIBwYYZI1O+1MGdMlc1PwWm+awQkB7v88Kv/LnuJ/1r3v5jvoLFninSLCzyDCteB0tJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758387; c=relaxed/simple;
	bh=CPbmtpJ8YRgtRQVuTFUVFnQAsr6F2RjbM9vU4iOpBN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3UlSkmztIGgdBL8WJDm19kmI+V7Vr02yAmv3ifyeFn/ZI2YYZaAS0sdU8MhDa5EaXZGwGEqvDexD/oWrnqKv5W3TA2Tu0UCFbuiNJ3GV0YKrpGIEr1Afd9ij8WeNnODcTUql/Jwl2JVx+lYhH6kM5kd0X8xtHvrI99x3rJ93ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wfA+pALw; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wfA+pALw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY8VtFjgX7W1a0jydYPII485TQUb1yjGvt50baAdCqRG+DsFc8E5by0IUhU507dznB2ujiZk7Nk+mfS0jVDtavW5gaFLpOcVMvss3X3qDwkRWMGKycQ2p/8DA4PQFsVTyz0bHEsW5KNMEgPYGteG187W25+WDF+tDM9H2SPf/FKiHFCUTkWZXWsbtUjhw1iKt2muAVMfXWxjNx05GYHZK2y6PlvDmuFji0g4qmgKfSMOcBgB6DH3XeS7u0UfyjgboKLO/tpGTuTddNweTM5wOA2CH5MlqIpir+4jhGQMz83UMKFGGKX0QrMQ3qH/o5xHBwn+nkQyJk7iNG2aHDDCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PrbtAK03DrQ5O4Flc0u4dmxRJ2KRnBnFcg9c1xG2gA=;
 b=s1ffgNEVdAJOC34u9Zrbv3LsI+O/fhW2a72HqECTzFedreGh8pGhw8RI6eO4IMr4WiqKE5eQYMkDs0lWoUEiQ12RVVsmAbEv4oOCNQX72c22z9CHWleFcC3eZ5NufpXl2tOvdhOJ4AHb+d0AcdSUmPKhD2HExKGHf/tlrqK7pvsaehOQIYldK8EBUJEUla3f2RlU9NMrUMa+SezRKRr4g6XhyDs6izrpDqQ8V4o2ZxFMj72TostY74uvzbSUybPdY8/aMJjs5KXQTsGUQmN+b6ERfqJ+dkknMQPaOnexvLqMfrPkkYTihgHIHILp1srMW1ZWHz1tIozK4FCJFg+Zeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PrbtAK03DrQ5O4Flc0u4dmxRJ2KRnBnFcg9c1xG2gA=;
 b=wfA+pALwyiW5Oi56kVMRBVfz6oHZRdOpN02o2vA/VO2WlzMOqFAT9VFeEet2rvMk60fmF3uHoYxygi4En1bHw04p602B1cogML477MbCq6lrEmm4JNafaCsNfag6ACaOx33Nl9njjAyKiz6hbhk/3mL3cWQrXKwUPcOyTmE5CWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 15:32:57 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Wed, 26 Aug 2026
 15:32:57 +0000
Message-ID: <23682f17-e6d6-4fd6-86ae-823637e9c568@amd.com>
Date: Wed, 26 Aug 2026 10:32:55 -0500
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
 <f6f2f984-f31b-42c9-b120-6c179803dd2b@amd.com>
 <CAPyJwA-DqScij982KfUQQ3ad2nHF4=SEBjjQhQGr1yCumdMXHA@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAPyJwA-DqScij982KfUQQ3ad2nHF4=SEBjjQhQGr1yCumdMXHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: b16c571e-0e69-463c-65fa-08df03874dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hJBxJvCvr7LS/zz0Df7isgicLI1I4ltBDC2X/TmnsaG/NxCL0cjqnEAKjS0FfAojluIzrbaawB9tVZ+aKdmnr+0JoTIvSc7sz5xrH14TLaxINBcRNgv9yVWD10iFuqIZaCGzxh0SLCYcd7Xym04R7kHu5mKmFjIGceMxUeLvJVfxmDIlzcc9B6pa2UxBKjGqQLgyL58p/oMdnCDpQ6kzrckbdglQWfFEFSl5weXphPGtj4SYJYbs5g1bmt0MN1LqUxnv4XKPryw2gyG1u8Cn7OuEhWH/2MDvFcknbATMfZDf/IsPLP9vMIidZpahG3KIdaL/NYrpuS5JlMnXtdA+SqLKbzjhgRhS2VFfKHdIA0cZMAttEJfXqVvNKLO8QSmfIc4IDP8hAQckMhfyCykhNucHwWpwq4ULqouiXiAqSPndfBDyozqphTay7ZSsZS7cat1quhqyohfDsQklF/bqNyoAn7ziufrW3HdNk2b3ve/hJ6b+e1iYitfLAJrNAYmMww3/VQG8vBvxLktc45YIW1g+SechrIbbfCuiVllm0+7HIgt5ZHUGDlhn4yI+BRUi4noD8eWB8NKOdEH2TUIIpdOKTBX4ymnU6xC+mYVeCl5wUKa/Q9BGpfH2jv38mx+PCwvBwLB5n8x1lSlap51DCdm99DZWlCaBSmPlM7zigUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTVZbVBWRkV3bS9qand0bGRaRWVtbmplSWJ5QWE4UVV1SGEyVVgvcHJTQjRm?=
 =?utf-8?B?NU9KUGhZL1RaUUU2OTVnOEpJU1ZnSUNSMFdVbGVOdUxYSWpiKzZHMTdLeVNE?=
 =?utf-8?B?UmUyUXdpSVJpcyt2TjBtcjhCODFJdzU1cVZDRUcwZ1paZzB3UHdFOHAyRFEx?=
 =?utf-8?B?RXFMZFVmN2dDRW5ldzdpL1BjTUpuQlF6Z1JaWVlsdnRsNVo1NkNPV3JJK0RE?=
 =?utf-8?B?YitlbHZlYXlFaENFcEZLQk5FcVlqeDMvMnpuZktWU1dBemwxd3ZuOVhRY09C?=
 =?utf-8?B?QUYxcFY0VGo2TzRZbSs5WDJjN3krZVNVUTFnakYyanU5OTk3L24vSVVJalgv?=
 =?utf-8?B?cXZxaUE1SlpURFYzeWhHTk5rOHhlZEZnK1Z6ZEEwRUhGN080YVVibmY1REtZ?=
 =?utf-8?B?aW9UNnh3RkNaN1liYW9aaXRidndXbVVBeU5nbisvK0Nyb2RUTVg5VzMzeXow?=
 =?utf-8?B?U3BQbHh4Z3k4TlNHQjFDdWRnekxsL0ZydktDTzRYNksvbHFJWlljYlFXSEUv?=
 =?utf-8?B?RWZTQjd6OWJHNUdaY3Z4RUlqN0dWcTlXbGczK1FTb20vL3VhUnJ2aHRGQ0hM?=
 =?utf-8?B?ZE1VSHJqRHBDNTJobVRNdmxIWkI3TEtYWk1UTUJVNXMrZGZIVW5Xb1RCYTlk?=
 =?utf-8?B?NUN2bXFXMHZUbnFrTDhtdnZZVEpibmVHY0VjeGhxSXpnbHRXd28vazZTNDNs?=
 =?utf-8?B?L1g4K3NNbk04cnFwcWUrUzU2SUZWV29ZTFl0OVNzRDJhZ05zMGt6a3FlaDlu?=
 =?utf-8?B?b1VxMHZxK2pEMUgyZW01T3Eva1AwTXhLSllreHRSYWR5ZWZBNEVUZ3RtNEdw?=
 =?utf-8?B?U0NDMDMwT2tETVZHQ3pLU0lFWmZteHJzNmRqVjNidnY0aWNSMHNHQmZQQWRT?=
 =?utf-8?B?dzJuMmpGdEYyQTdXMDNJcEExM1VkQ1UvcERxbVV6UUNtcWpIdysreW9MOWxH?=
 =?utf-8?B?TzU3ZFAzeWVhQ212M0h1TjBwbnEyeEt6Y3BjVTNHTTkrTDVmc0lTTTVocUta?=
 =?utf-8?B?TmVnN0V2dkNtQnAyZENzQlQwd1BmYTZhWmRiaUxlZUVNNjk5RDhKZUVVRHNT?=
 =?utf-8?B?Qnoyek5vbFNwNERIcEVvVEpJSUhNSlBYdXQ4Q1ZNbFBZTExEbXhPK2htdmt0?=
 =?utf-8?B?cUh1cWF0K2pBNkxmMHc1VkZwS29hbG9CdU9odFgxK0Z5UHhrSzR1a0dIaWIz?=
 =?utf-8?B?K3dtRlhCVUlEOUpDR2NhTGVlczB6S2htK3ltSmtkWXNOQTBqVENOZWI2SU9T?=
 =?utf-8?B?aDJqUW9tL2MvSm92Y1ZtZkJnSjhJdHk5a2ZqQksvdUs0ODNtckJHbXdLLzJj?=
 =?utf-8?B?d0I5SXVKK3R5NXBVZ2xKcCtlUW5kZmsrSEo2L1gvT1YxV2tBYVcxc3JsMWlJ?=
 =?utf-8?B?YzNIM1g0cllVQStmMW5DNVVIWGdiaXRUeGdiNEwyd1FvMFQySm8zdjhvRjd5?=
 =?utf-8?B?a2hSU1BFdDAwOFBaWER4Nk9mWldRd1JUWUhTOVVuSlJxZDMxeGxGSjBPYWc4?=
 =?utf-8?B?TE1TcUxMRUNWTUpmckdNZHpyZlB2ZXhoZG0yMDM5bmdYRUZDVlRPbFV3UDND?=
 =?utf-8?B?Zjh6WGxhbitGVVdNYkxZTHcwNWZIbXNTVDUwRzB2QUZIa2UwSmM1clF6U1Zk?=
 =?utf-8?B?NENvR1Z5ZytXZThsYXlRb0J1dmxvMzNMVmlmODRyM2lnV1JOTjdZdkNjSEEr?=
 =?utf-8?B?Z3ZrNFgxcFdNbnY4dHFDd2o0MEpBOEhhYnQyYkVrOTRJY1NjandjQURRSlVP?=
 =?utf-8?B?ZEIxMmxJZ1ZNNzcycEhYZmdwUCtXcEJYb0JGaWt3cmFxVk1hSVlURjZMcVVi?=
 =?utf-8?B?SDJPV3JDaEwxcnZha2dtR1hKZW1nMVQ5cHRoQWdqTXhINkVDSjNqenNiTkpx?=
 =?utf-8?B?MWxVQUUzTlA4WkdCNEo2ZlB5dm5sS3RIdXRrVkl3emdkdHRjV3dFdmFSdVlM?=
 =?utf-8?B?TllKcHNFZXArb3M4d0lReEo0blpRV3JaTWZvdTBBYmdpU2Foa3VEMHF5d2Rl?=
 =?utf-8?B?VW0zSEx2ZjVFVGVzNFBKdFVzY0kwcXhLUkY3V0x0TEJlcU5GUEpXdExxNlRr?=
 =?utf-8?B?RW5HdVdNRVlxRzVwNVhpUHFqeEJJZ3NORmMza0p6MThSUzFGZFhiYWI3V0Ns?=
 =?utf-8?B?QmUxVmt3MkdZTGwzc1pjVlVuVFk2WDQrVWlBR2dvOU5tTnNtZkM0L1VvdXJV?=
 =?utf-8?B?aU5xbTFJQmNlT01WbUthbDl4TEkzdWx1M01tclVXNXNVeHZDUk9QMjFEVmFy?=
 =?utf-8?B?cHFNVjhLb3dDRElnMUxQenVqT0FoRFJGc21VeHRIOWhXdGFMSldBQ0d0Rld6?=
 =?utf-8?B?Y1poZllPaHRoMWRUZkJFcElCUzQ3VnZqK0QxSWQvb3ZYRmhKL3dCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16c571e-0e69-463c-65fa-08df03874dce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 15:32:57.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rKoFq7EBnaFSaqpDhh0CCmolX077BOq5pnS0lQbrOcAxCadTc3wFrt4L6SropIv1IY4h0HPIVxgx2l1Ajsrrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B



On 8/26/26 01:27, Mathieu Fluhr wrote:
>> The workaround you can do for now is to disable runtime PM on the XHCI
>> controller to avoid triggering it.  But it's a platform issue.
> 
> So, long story short, the kernel source code is correct, and the issue comes
> from the BIOS/AGESA, correct?

Correct.

> 
>> For a proper fix you need to reach out to ASUS to get an AGESA upgrade.
>> You can ask them to reach out to AMD if they need assistance/guidance on
>> the versions that contain the fix for this.  You can share this thread
>> with them for reference.
> 
> I will. But this leaves me with a few questions here:
> 1. Do you already have a fixed AGESA on AMD side, that ASUS could use?

Yes; it's already fixed by AMD.  ASUS can get the fix from AMD.

> 2. Does this issue also affect other threadripper generations, like the 9970x?

It's only in Storm Peak CPUs, not in Chagall or Shimada Peak.
> 3. I guess not only ASUS is concerned but Also ASRock and Gigabyte which
> also produces TRX50 mainboards, correct?
> 
Yes; all board vendors are affected.  I know that some vendors already 
have the fixes out.
