Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A52423769;
	Mon,  6 Jul 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339430; cv=fail; b=bKIhFFYHa+uUuJEEeDQZYa5KE242Z6raLBMRUkHD9Gp2xtOI6YNIZuS+9OWJCmgudRmO6jaiA6txI/15SK6nEnun6rdYgevPD93bYkpkdcJT7dk1D1tE7p8hgE82SERRAAJDyqWrvQy9WrDXDCPeLVmdGVvPTP9QezHBu7HKQrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339430; c=relaxed/simple;
	bh=/mx9khyzxoBqS14UKfOvwePIQKur1ZK1o4WeAiIFm3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXHGzwpURiAeB/wwAIJeHPJfyRUwo8AIqjxzF4XVzsXOPuwH7Kraiee9Ugt+XMlxFOHEBMStx7DRJAiCJ6DEg5MxALzuARvpGyzNvf85lDI9sXz5yezF2MVGdjNXmDxKtLHqHaGKViNsPFG2sqjcBUHCNZv3beyFS+yUolrsckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XcfzaEEe; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcfzaEEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV7lsAjpgHG7+qvJzjyrdog64MrUEibt99pTsbZZSTeRzCYUeNjoArxMI2cnONb/9XKSfanZPESJUbMYn8DLjR6y2IjqBhy0LS+bmMgqaoOSXwnEKTHZ+46i4Sy3ZXM8x/NVs9bDka/su7QIpsdsqYozl4cm5x2beiu+ENX+h9yNR8WLTrHs90UG7l4aBwtZnOv/R2ZZZcBeCVtx8gZsmeUZonAoEpHcCZ83wRTY1r8IqXiP/HWvW8rzIb/URzUnx2ORPMrrOC2DM9IaITklpFgMRMO0Xq51Zz3RQnFHiMw3yi9dHSUQFeOKtVhBo819NZlcglYTZqPuUlnMz31Bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEB34T79Y1zcJ8Y3QBGh5Lp6wjRNpnPcRHqojgV7cjY=;
 b=oV6lCQpuVRbamccJWMPYzNxtJF09wxl6KetgbnkwCf1tYp/43I15D+EIPUbeDWGh6wZYkKQm6gFTR1rSi/kkm3NWNExrZBeyNE77iR8MyHNPXytPTCCAkK3B8OqjBq5q80+OfY1YeCs4FfS5fyUg/Pq+Dc8ltWY4SJafiOasREj0bAtZ2COziaE+Q/aB3nRvQTDjdo7JEfIUrQa4LGcnZyfSB98lojHt9Ock8qfKIbBVSOUUTWxZ0zRNzlmYB/M9aIjKpF/JuKTj2ln68v+IUD+YG9wDJVwnU+35HYtg1bOkaPQqB3Z+RyVmS6tgzSzd5GrfYuegAVsTs+oyRuB22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEB34T79Y1zcJ8Y3QBGh5Lp6wjRNpnPcRHqojgV7cjY=;
 b=XcfzaEEeUPP0yRk+cQj7sh2AUx0EttZAl7mrbcQoThZNWAJOIxQG48yhNjFg4ayV5YLRSHdMshgFKQ+mq3rGyXQs9ghbSGmEaECHirbTAja98OitbaSJvEgPsPq42fFKvtdORqr2gpr3ssQOlbuoVk47Cq5ZBSFS8zfdDNr9F7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Mon, 6 Jul
 2026 12:03:46 +0000
Received: from CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6]) by CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6%4]) with mapi id 15.21.0159.018; Mon, 6 Jul 2026
 12:03:46 +0000
Message-ID: <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
Date: Mon, 6 Jul 2026 14:03:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: "David Hildenbrand (Arm)" <david@kernel.org>, seanjc@google.com,
 pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com
Cc: bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
 yangge1116@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::32) To CY8PR12MB7433.namprd12.prod.outlook.com
 (2603:10b6:930:53::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7433:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 255e78b5-86e3-4cd4-03d8-08dedb56a182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iA6u4JkYjBdC2pt/ff3myjy2uuP67mt1ENNokGaENLCR3fcyNZPa26xeZ14vLQaSZ6+C/e9aP/fqRcETRfos9g2jkB9XvBg0OLWHv5BcChJo4WNDBuJpATZQBOwik1kkRegbp//AO+LgAg5PihXMmmCupMBx5dTYDx6RP3HoFA1znMX0tvSgrNv7eOTZtgcWkvuR3gCa+HSADx1eUcRTIMnEaw8RYuhsw6oG+Gou66i5oedHB6uxSMSsqFlR9V/zi1ewILYGIGcF/r6r4yZVkQd+HkeHwO3z2Jc4Ru8DGM/QAYYPzP5ix/mclX4xD/Okj8MuqAyFHOSUeeyZCZLdQizJ4lWLj7B3oEw6EjGYcp32uzFfs6fufFVgMHb6eyrAxeU+L8rJXtT2Gfk4dL8A6pR87pNdO9tM2AiUNB3PXn+1VwkPdxZ9mwaLwcpO+i8Dkdd0vmjVXeFT45ex8LQGnOcwwkcffeLP59C0iZzz0pLpHZxUoaH8G5Js7ulWaKGoIwgVU7qoTig9jOL+LM81k2EM7LPnmeDv6DWNbymaFCQOLaZzCoCKFKEuZeAemdUigSLm/oLY+5jHUX3Mm4TTj5ds0w1HdagVh+UYTPaZTfJXv/0hqAKuJ9DvcAR/F8CsPSAWr6mPdw+2RcP50UXhe3d/Qm+dzHxA3u48CtU2q0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7433.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QS9vbFdqRnVZMWtSRGJVMmpGS3lVaklsR0I3U2EwM0VoRkkzWGhqQTZZeFdn?=
 =?utf-8?B?NVAwZXJIUVJQekRMSmpDcmhsWW9JMUVHTXJ5MUpUT091YldiUGhwcE9Ka2NI?=
 =?utf-8?B?T2xDSExkZUl4MFcvVGRSSWFkSEptRmRDWk9BS2pOL2VndFpJbEEzSUovcmpn?=
 =?utf-8?B?L0NYM2Vjc04rY3d5WnV5M0ZvY3o1UGwyTFZjNFRsSnl3eC9SUGVleS9YRGF4?=
 =?utf-8?B?VHVXNEJqZlNtWW9wNWRxNTFzNHMwaW1OeUFmejZIV0s3WnExSmNtZWpuaGt0?=
 =?utf-8?B?aktQUm01M0EwVzFEWGtvWUtzaHRLS2UvZ1RmT0JjODhpQkZwak1ZakhGWHN5?=
 =?utf-8?B?T2tVclpNNjdYQ3lrcWlGWndzZE9QdCtCZTdyb08yNllEb3VzM043K0YreVFp?=
 =?utf-8?B?SlZRT0pEWGdrMGJwSlA1bHNlczRXTUNXVUFPRXVhUGJMR0hDNCt6RDVGVmFH?=
 =?utf-8?B?ZXljUEw5MHJuNUJibzRTTWRGck5iSkNwaDZtRGVqaitiYmlqNGxtdWZYQVFI?=
 =?utf-8?B?YjdRdm9sd2QvN1k5bDZ5MTFOUUtoOFpBQi9Ta2ZFOTJ1TGdhcjM5OXRKaTFl?=
 =?utf-8?B?TWtaMERSUVZHaU1MRnBZR0NPSG1rQ3Z4Si9PUGxaMVA3amt3anEzTDhCR3RX?=
 =?utf-8?B?VVgwOHNJd2FqeklTYVdUQzVjZ1FRWitmTGNLRW1VS0tyME0yaHJMLzZDM1Fp?=
 =?utf-8?B?ZmhNTGpYWndlNmo0MnNXSC9INzdTUmx2aHFFU3lXdVlWeEJwWHZoKzI3a0dI?=
 =?utf-8?B?QTQxbjZhRy9oUXR0cStjWWRHcy9Ibmh4K2FnWEZlM3BQdlJObGQ2b0xvVXk5?=
 =?utf-8?B?SGJPWUhPSkFhbXFaU1FRZnlaS1RmRjJvNUZZMlZhV3ZzVDFPQm9KRGRlcFNH?=
 =?utf-8?B?Z0YreTBSelNwU1ZEWGJ0L3lsWU03UElYUVR5em8wOFBSU2NBV0RER1JtTzJn?=
 =?utf-8?B?NzNmUXpaYWxqV2ZQWHhnRHBXRUtvT2pReS91OFh0NHVicUdHM2lDenlWbGFR?=
 =?utf-8?B?YXdlN0cvY29BRmZlakx1eEo5U0VVemZCODc5M3d4Z292NHJIeE9SVFRGTDZn?=
 =?utf-8?B?UFNUcVNGMzc4K3BBUVB4WE5nb01MNXBaYTRDQ0ZwRkUvd0lWdU5hN1drbEdW?=
 =?utf-8?B?RkJ4N09TWW1UN2U4VWJKOUcyV3FPQkdlclFpSjRxbVZVb0o3SWE1STFLd3VW?=
 =?utf-8?B?ckdsbTZHd2hOaWRLMG1Fd2IzLzZvTGpNMzV1djFzN205b3hyemFUMnZHUHlo?=
 =?utf-8?B?MERxaWF4ZkRWdjc2QlFnR2pDb0EzSFZBNStSTWFXbDlod2JIcFNUWE1EanEy?=
 =?utf-8?B?NU01Q0J5dVA0T25zRGRHMmVvUFdBbDV4b1Y0Ukk4WVZVRVRHRW4wSTN1bFdh?=
 =?utf-8?B?Yi9PZHc2cHlqMGZqdmIvV2NnVmpydk9WeExBOUVOcDA3WGZKSUREUWN4UXVZ?=
 =?utf-8?B?ZmZHeUlrMlgrMVlvZWNhMWVacVM2N28yaVBhSWprWlRDT2tBdzl2YWFwd1pn?=
 =?utf-8?B?by95eXFHaENkVnhvR3NOS2xaS1A2T1RjTHVLY0M1TnhZRXVDT3IxVmxHd2dH?=
 =?utf-8?B?c3BIcWJKZmdYMXB5TkpvUytiajYwbS93YTNML01XSFlvbWNYdFJmRGxhRnY0?=
 =?utf-8?B?YWRPeSsvZGFiNnlIVnRVcEtzQkZyQjhJOUhIdTBaYm1jNHpMK3BBQU05ZXU1?=
 =?utf-8?B?YVh1c0pGTzh3c2lRcmdpOFlOaFl1Q2FaZ2VzVHY0d3FTekM4YzEyVkcrUUJl?=
 =?utf-8?B?NzYrL0FaMmhDczlxcFpUV2VzamZBVVZBMTVYazFZWEYydmozekN4ekc1enc2?=
 =?utf-8?B?T202ekpNYlQvMnRWRzJtSXR5UG4wNlh0K1RtRy93QWo2TzdidGNZa1pqZHdx?=
 =?utf-8?B?ME0vSjVxbUNad1BpSnVCWmEwZUJJdll5YkpxVWNidFYycHpKWWNjbU1TTzBE?=
 =?utf-8?B?NXJ5OVExL3RhNUZOQlhaTHNNZmRvdS9xeVpBTE9LcmhrVW02NTdxQSttN3Bm?=
 =?utf-8?B?VWRRK3U0N3lFVThDWHQ4RXhsL1hzcUNoZ3lRZHU1OS9xR3FRRWdMUDU4dUcx?=
 =?utf-8?B?VUp4MjRCNHRTZnNscFhqR3Z0d040U0NVZVI2eVBwZnBRRkJQV2s4UHFpaDg4?=
 =?utf-8?B?aG01S1pIUTVybXpNOWNLWlNjSWNkMWU2eWZadFNwR2lTNXlES1dSdFptTHUy?=
 =?utf-8?B?azNWODlwU2VHeXFGZkRBdXd6OGdFNS9hbDRMQjFEbjd4NVpBU0JYeGZLS09Z?=
 =?utf-8?B?eWxFSTRVQnBZbW5iQjVyMzArbUVKKy9tZWR3cjM2djlyVEtGTWk2MFJRRnN0?=
 =?utf-8?B?eXBMbnUzZDFmZXdoeTRhS1hSOExET0JldGE5c1EzWGI0Z0U1YURvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255e78b5-86e3-4cd4-03d8-08dedb56a182
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:03:45.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWkYll2PDJernhT2UWQlMDc13VaHOS8A+mlgVguo413DHuAglGeAWtM2O7AuVHDRi5mKyleHrX0ibUBJC+RS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

Hi David,

>> commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
>> added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
>> migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
>> virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
>> FOLL_WRITE | FOLL_LONGTERM since:
>>
>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
>>
>> Drop FOLL_LONGTERM when registering encrypted memory regions and restore
>> the previous behavior.
> But that breaks the original issue of breaking ZONE_MOVABLE/CMA?
>
> If it is a longterm pin, it must use FOLL_LONGTERM. :/
>
> I assume we fail in check_vma_flags()
>
> 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
> 		return -EOPNOTSUPP;

Yes, it fails in this path but for file backed mapping, vma_is_fsdax() 
returns false because

vma_is_dax() returns false:

>
> IIRC, fsdax cannot tolerate unbounded pins. Is that the case we are running into?

Host side backend is regular file backed memory (no fsdax).

Thanks,

Pankaj

>
> How does vfio deal with that? (does it?)
>
