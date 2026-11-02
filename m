Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793630511;
	b=XmJ9v5EBt5vwf4iLRONUHbGOGkANtLdy7123RnESIvM4y7Nt0Mokw+TJvxFNgthm9L1T
	 LbGUc9E22rhezyVyPAwxUWkwtb0A0Mso9ZssrHQHNZF12KznwphL5+21/mLaDA2osvitz
	 PPWH7HQsBfglYxrErAYIbpwtiavv/2Nu1FmVFHTrLNyyhNE+hSu8g8vlWEZ+E3L7LhqKd
	 WsdkSoew1mPo+aGA5ulWxswe7SQ2ve+VZDrg22DqibgPZtPuM/Q36I6CKGjXCghN7SUlV
	 J+xa8dFvXgUMzoQW08ht82YrTjuX8cwxZqxZFSC6QKjpr4WdrrUj6klPjHuO26NBTVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630511;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7ysebPoIuADTMQKwvAlLfSrcuB4ffwXZxRsIMtoP4LM=;
	b=0lSbzsOdmxQOm3NTrQEq1JO+F4tfIDGnGjbVldnlObw14iGG44UphnWgqTF7Fb4sAdEM
	 CSAnC3nNyWQ8n5VDoKV21Za9ESuo79CZiPpDnEXQvRdw1QM9ALF1lwiYsjMl5LjzXBw0n
	 7RQqMokh3dtJE7ldzSp5yVTjXYFbnNZho3KhNziFKQjRpj2zCoDkRp1FuG3CG9c1ZP5VA
	 xrkjx8iqJlP/FhowjCQ624g3rNU/9yXLwHd0Gtclsq/IsnVM/rwVckwAu5MqDPVm2fnHK
	 fDNuczUd1dgbJhjYvyHuTIpmhbTcVzKxu8QxzHJOQ3q+bw/o2KSZ6AXGYNQNHJ8VTxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zKHZnZ6s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1EA606F21A;
	Mon,  2 Nov 2026 14:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C1EA606F21A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zKHZnZ6s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC1xrT16hUWz7dg58cSAsV/p1WxzmRWChlAtwnAXZTA9hEeaxwneCL5AfgwszeqYjmdvBoDkH5CXla+cobgL8+IByEMxVuRhydx5U0gLDu4LI/7jVpOUHQyIccRvpZP0AvYeDW0gvpudDtnmuPwz1ykOn797bnH5p+GujVQmGwAdJDGZq8h5TmQO0SIhdUl/YRb//dEmGQ9HwgR5lQZRHu4tAqE6F3/QU8n+YJnQMK+4vir5MYSGR1R4cAyRPTxBovLuEada9jtpPiPkIgxhYi9//UbttdiWcnBgckckEAciE5+5Qi+PQIbJEdIMdNYihUYLhHvT8urGj7Fi18Ianw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ysebPoIuADTMQKwvAlLfSrcuB4ffwXZxRsIMtoP4LM=;
 b=k8AAtYYdCGZmUqoNMt9iPz1bubURZ/qIO72rOAiFAckYHAApoaLsWWkx/p1RzO5ZLBZXP1HY+U4sKFrKTgob7u8NkH0XxjKQBWpkjqzjw3jUgbs9A+Vhi5owXMskwfraFqw7PW0l1Vd+XvUynQI1GdoAbyXo3erOWUXNXpg2VSSL9+hHrcQQKtwHHBqkqY2csbEZd5T8ptiYqoQ1evige6eJB1zDLZkScMWlM6jePmlhi9qQVjlqMJ0A9vD/5ki5owmzUHNatUgWB3AR6b8rAH0w4nuuDLYwm4EA8mMMV7y70W1BslKRFAHE09fQ4wl1R55nKcC45NR0vph4U5EkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ysebPoIuADTMQKwvAlLfSrcuB4ffwXZxRsIMtoP4LM=;
 b=zKHZnZ6s6xkb9mWj93X1BRinHkGbyY3ddQAUKbTbGhUBAtpvQEg4+bqkgwwIDk9pt4ITyAmIHsmXJuZZYNRBzbkprtm+3Ngpib4F5y0R7JZYh848mmC+WvipYTAqb44byxF5ntsxy1961AFUrwBO2dIBK3vWSR+sPEJwza9cDjo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:41:48 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%4]) with mapi id 15.21.0569.010; Mon, 2 Nov 2026
 14:41:48 +0000
Message-ID: <37a625b6-45b5-4bfc-878b-ffc16784b0f1@amd.com>
Date: Mon, 2 Nov 2026 15:41:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm/cma: accept memory of CMA areas reserved with
 memblock_reserve()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0218.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::11) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 508b0a1b-af65-426c-e912-08df38ef6c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|11063799006|56012099006|261009223027099003|261021121427099003|261026121527099003|10067099003|261102123227099002|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4kw+089uckEdJ4x9jSdjGzJmfpaDQ83psVYELfpdIsJPsNsJsSn7dpAktHx8RVHDnr1Z6yxU/7+JcSITvAoM4UE07vh8wIz3VfuwYIA7PJFUXBg8WHdsQuDBHB9bSGVghS9jusfzigCWmIQKEXUhMFThm1Rp0sRhlP+q+pXjOFhjzISkgheRgWBegQOoCNx4tWhW1PwjNy21g5qU4IQdBoAw3CNVXUtdLuizu9Fd9c0GSXFcQsRKVes9vQDJz8LwMvgr/I0WbUJjZkjg4L7hGF58vFEn2F6IP+3cSiwLSXqAMf/3C5QQNBWs6b9m5pb39UBrCuT9XIZScqdU6crsbK3tpwnsiodegwmMx9c5GhsUDtpWWQf6Djnlld1ncXBLwgNBYU0YlkFJFirhf5PLnj9xA7SGZN96uhOf0l+6yx58x+8DiwslAXYbzh5Xezmog0MePO8F7T9vHCqD9ycSoD60Pnb3zEgJSIwiaHt4uBKzI6ghlEYn+35eotBLjBNnH5nSSYd8jfu/O6hGXStxxLMErp9OvCqRXiVR8whLxLfX9Ez+0wjY6fqSq/Ij5tUpKg1nm5HEJZM4Biaj0JZ1WRjiEqdWEH61BPyneZ7uRcaL+iRqCGs25yh1162pee42WtBwKc2hlkzidFA9Z4723O9UOKw8lEGtBMCUQjMAHwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261026121527099003)(10067099003)(261102123227099002)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VSb0JsY2ZNN0lrTCtKaTIxMC9OMlVGREZvMUpUeUdBeEkxbld0SDZmcXQz?=
 =?utf-8?B?LzQvQjJXNmFWaHVPSHNHYWh2cm81cDB6UDhqSUNkL0hmS3V3dVdWaHFQay9s?=
 =?utf-8?B?RDgwRDBiQXVFOVF4QTdyeHR1N1d3UVB2WjlmalgzRjRMTHZXcmUxWCtNUUF4?=
 =?utf-8?B?ZmdCWUJtRTVKWS9FbFcxcGUrVDRWTm95RDV3d0NVUWRLUTNyREdkTHNqRk16?=
 =?utf-8?B?bWlOaklkd25yVmc3MnRlTlI4QWF2YzlsUzhFbStSSHBWZTlCWE1QcXFDaXFU?=
 =?utf-8?B?ak91T01oZGVDbGRaWFFGT3BORmpkeXJwdjJXNzZweWtJQXVGanlST3loTTh5?=
 =?utf-8?B?R1hWODJ5OHdjQ293Z2MreHpnOEdPVVU4U1BGM3N0YWVHN0JiMmF1REdQMEhU?=
 =?utf-8?B?QWx0OWxFcmlmK201NXI0dHVzeC8rdysvT2lCOVh1bFNQcTRaOVVFNEtGTzVN?=
 =?utf-8?B?VEdlYS9yMkhXejZETXhPV3NWaHhXZGN3OHlNWnJkNEpZWmRLMWN6c1FwYTA2?=
 =?utf-8?B?QW94N0VyemQvaVBqQ2srSERaaTB5eFdhQ2duNUpKdTREUE43clJDdWZkK3FG?=
 =?utf-8?B?cEtWYWRpYVVTUGRNNlY0WXBncFZNZi9PN29pYzhXN0YwK05MRFZMa2dRYW83?=
 =?utf-8?B?U2o0SkhHTjY0QTVzbmtTcVROWDFqOVRGK3NYYXJyZDVEbzZ6QWdneEFhemVa?=
 =?utf-8?B?WldwV2l0QXNETnJFUTlUeCtOZTNSUXAxUE91T1FsUlJvbjNuUVY5d1VaNXpJ?=
 =?utf-8?B?eDZ3bDQ3UDlvL2Y0bFpweS9DNVp3TE9HazdsVnBOZnRIUjJVK3BTc1ZUZk5z?=
 =?utf-8?B?d0xvRjNoK095SVFzNmQrUngveCtUMk83MW5ISUJSbWpTdm5haERUUlVkYUp4?=
 =?utf-8?B?ZkdnQjB4N1E3S3htekFxT3dqaWg4NnJKYjgybnQrZU1VZDdzVWhyMEFKK0JW?=
 =?utf-8?B?dUJCZ2JRd2poSUxEOWs5YU1LQlZOMm9OMG5hMFJiNmJUQzFuc3ByalNNOExr?=
 =?utf-8?B?OVM5MGNxT0lWS25UMGxPazBhU0FDQTZJWnJ5MklRK2hZNzZwcG9rOG1mZHUv?=
 =?utf-8?B?QVJ3YWc0MnpGZyt2MExCV016ZzR2VkRyUEhjdXJnZHQxQi95TjZDdFpPVzA0?=
 =?utf-8?B?SlUveWJjQmtZb2Q2dDRzSjA2V3NZd1c5eENsc1VtbEI1WFZRVE1zaXUwNUxH?=
 =?utf-8?B?TTl3STZEUFJyYTkxNVBFb1JTWTZPZkxQS2p3WG1CM0R4TU5nU2NhUGFsYkRT?=
 =?utf-8?B?aEJaODJXclJzWGNJaVBoblUzUjVabWtkSHlVZElnUEJJNUE0WVJaVTY4R2lD?=
 =?utf-8?B?bzg5NzJQZ2pxZ25GemNOaUc4c3RHUjVQcGx6ZFNKZnBXVVk4WWZFR2pTaCtq?=
 =?utf-8?B?Q3Q3WnpHam5kaytNaHpERThHUStTRGxPUHVwQ1F5cnFmZFVKTkRCWW51T1Rj?=
 =?utf-8?B?L1BhWjM2Q0xQeENQMDNtRllGTWdpbVNWc1RmUnJDN1hjeXJQcWVUdUV2VU5W?=
 =?utf-8?B?THNlUG51dklac1Btd1Z6cEFPSGMrQ0NsT051UFcwY2ZuNUIrendyb09teTA4?=
 =?utf-8?B?cFlNYmVMSmRkWFllSG5kcGo1dSttcnl3ZUNFOUdvMGpsNzE5TkFPcGpjOGtV?=
 =?utf-8?B?YU1FYXFZNUhZcmJpeXJNVC9oS0FIcW9ScjB0WVpjc0lQNGxMa21pclpaem45?=
 =?utf-8?B?THMrTHpxSWlrWUlqbnIyeHZ3V0hhejJJbWRpYWd1RE9hbmdERVRoZ1ZZdy9z?=
 =?utf-8?B?QW8yUmRoWUZhYlR3ZGlFM0wwOERmOXMvN1U4UHU5Y2Z0RUxoRUhHL3FySFdZ?=
 =?utf-8?B?WkxFTWRRQlBmSkI1TlR6aGxES0tyd2hEcytmcld3RkFjNnZUTHI3V1FoRFZl?=
 =?utf-8?B?V2tuaFZ4WkhDclN2TFNKMVJhTzhpYksyQ0Z2cGo3RnFkaVgzaGZYTDJsbURE?=
 =?utf-8?B?YkIvV05YT2srTm9wWHUrUmNrNUNMam16dWcvZDZ1ODBoTzZoTmhWY2pjQnNn?=
 =?utf-8?B?NEdINVRMSSs0RWhoOUFrcE9UYVFCcWtEUURnSVV5TXVnZWF4NDhGZXBsVzlT?=
 =?utf-8?B?di9ySklFcDhvaVEwMkw4VW1tcDVHZnFsZlgya1hGN05zdEwxcUVRTGlhTUg4?=
 =?utf-8?B?UFpTM3dUVDF2ZnJpSTUyMU45S2RWRU9DZFgyT0dTcnhKZi9hR21LSklEQS9z?=
 =?utf-8?B?WnVSWGk0OHlVdUpVY0VEczhQWXVsQUx3MUFlVjdlODZzd1ByQ2U4Rzk0UmtF?=
 =?utf-8?B?aGUxNkhKcW5lSmJqN2YyT1VXcDE4TDBtQ1BaSmhtV2xUeGxHektVci9mODlH?=
 =?utf-8?B?L1lYYk5OaXRVVHpWZkswVjNDQ3dlYmNQNXd1djhMZmNBOWhWcHZBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508b0a1b-af65-426c-e912-08df38ef6c79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:41:48.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH4mhu5JttJ8SX/ecYCOcwHk3t9uBz8/Wg4luEgPDyPEEiBe3r37gqL+pxOMl26hQDcczYi5mkPEpf0Kf2EIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271


> Pages of allocated CMA areas are released to the buddy allocator with
> __free_pages(), which does not check for unaccepted memory.
>
> This usually works because memblock accepts the memory it allocates.
>
> However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
> requested with cma=<size>@<base> are reserved with memblock_reserve() and
> their memory is never accepted.
>
> On TDX and SEV-SNP guests the first access to such a page is fatal.
>
> To ease the backporting, each case is addressed by a separate patch:
> - patch 1 accepts the memory of multi-range CMA areas
> - patch 2 does the same for the fixed CMA areas
>
> The second patch won't apply cleanly to 6.6 and 6.12, but I believe the
> stable team LLMs will take care of that :)
>
> ---
> Mike Rapoport (Microsoft) (2):
>        mm/cma: accept memory of multi-range CMA areas
>        mm/cma: accept memory of CMA areas reserved at a fixed address

For the series:

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>

>
>   mm/cma.c | 4 ++++
>   1 file changed, 4 insertions(+)
> ---
> base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
> change-id: 20261029-cma-multi-97fd4e58aa08
>
> --
> Sincerely yours,
> Mike.
>
>
