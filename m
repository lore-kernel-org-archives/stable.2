Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794279224;
	b=NCqCNpfudA6wC4HTglLDwI9t8rcYUkKm69SecIaHe61BNGoL9UkPqYkaH+RAcd3i0KeA
	 zKuiSlzK9mx/qi5YAglWhPg4/cQY0nwUOaKA83r9yKYUePeQU8rxQcoIduNhV1ShvVZG5
	 XArDuSD87u/fcLu0iWp64Mf2xxOsy0r+jiifxnvsC/EvcIWzuhx/4OwGPL/BhUxZ7p3Ak
	 DjXHZDBNb3qzgHkvmP304WhtNQg01Rwmjq+fNwHVCtjdKqTwQSh3t6r2NIizHdWq8M9MV
	 fEKBSTtOpk8kDqOJf30iagW+RyUym38c4esAiL89DIyRz19hRiTBe7C5mlu+7FGGptA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279224;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=S30c3dHoLqAXiWqUO3OHhVR3jMFfvUV2/dAf7t7FcuU=;
	b=JntZ9JP01dlOD37qlir1Qh6RrtL0dmGiSYjP6O2Hk9RVarka5yBqMH7lTyXYQIfEDWjc
	 gPx2fSpyIOLpCLC1h1EnfyuBvlSr/ktN+wyDvCGd0RLRv1D3jqaHZVIgsNDws0HATECE9
	 uAJJZ28/QxeQcNuzoog9HyuOizFC5I9FO0Z/JrYl8OAn4jFr8v2jQ3opGEelRLqtbbjjs
	 HU4g4N+1VLYsLxXMhNu45lTsePQboDF/O9/3GpWk65wqQfpxB3OGksukKND3d6Pom80DA
	 lJMHuw7l6fQmhirhgSWoJRRkhRfTngmeUHeQJtyxuoqbJoaGw658NxO5GLy8ahvzlLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kziIw3tj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.30
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF606606A321;
	Tue, 10 Nov 2026 02:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF606606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kziIw3tj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylZ9iZiaTHFmMclU5+2cT9b4dtNUQkTdhFQ3DT5kMS6fdxi208Xzvdjby6ahadiUO9Cz50r/4VzokT1gxUv8V0WF2IBdzbZvgP+Gd74dU0+DGJuYaHUygCCRks3UdIRTQebKHpXffw7NfdSLptsFUGWp/fOda3QyRLMT2U3eTcMH18m4XGwf4LTTMgQuXOu+FF6x0/1DW3bFi/BEtyFDtMfnHH8EYppXlWzrMYzzhVXs0kssezd04wuABFevrK5zuZG+wjAtfHJVbUCckuo2hJWlVbT1Ic37nQvxhLdSZH1joKQsqXAxegdBxyFgRX3qr8yPKQN7qpC3Ivr8iBw0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S30c3dHoLqAXiWqUO3OHhVR3jMFfvUV2/dAf7t7FcuU=;
 b=vbcKbYy+Ie0hTscS4BcndDQBS0lUZAadSrvsqS1l5FiaK2U8v4kgDV8AQi6WDx4obTmmPEXFhApgziygOBvLMk//8znLcyh1lTF1J2h6RquSKLr+RGqG0v0cQO2G4ReuaYVodkyoxoTU7i+FeSfbsdP7Zvk+XQFUGlZ7IxLu3j5FgWus9ixr9JbHy/NrrG3iUANTnA7K7lHPcHtRnadALtm6g9IUCirkYHjTLXOz7RbbHobmMoSSb0sj5UttqetkwXh4s3MqFPP0IKHG9RrMAS4qFo2Bl7CgurFjZ0CEctiu+VLqCaZsLubCGUbjFop0g18Y8ImXxy+1/4y/1YSUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S30c3dHoLqAXiWqUO3OHhVR3jMFfvUV2/dAf7t7FcuU=;
 b=kziIw3tjWDauFL/PljrlRbsY1jqRF6VlZgnkj+zPVJMjsHW3Kt6XhAvHyy42ARXVCBQPG9REBqdG6+AB04Yqeg4S/wIRjMcDHQ7ad87KS/z5LAYqgmn6nLxRKpvWhymoD3sRxddwgyV2GwixWcIi6o56l3RrekrUq+lB5YWN3IzH3jB0bZ95L1W4d+Rl1AvKWOjpKAFLLrFRSw9E3MDer7kMre6dScnSEXForRc13lEpXATchZbQED3Etd7rEvPdIarWb3AahKlXrQzfnz3KdVilUqxp5CE4N0CRM+nD1BHjeVR7sVEqRDfAeQONZcBDRmOIIcIoVmFly+fKWAzbFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SACPR12MB439974.namprd12.prod.outlook.com (2603:10b6:806:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:53:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 02:53:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 21:53:40 -0500
Message-Id: <DMR6WEDDUB9H.3LRNLDL9QJMU6@nvidia.com>
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_move() with
 huge page arrays
Cc: <linux-mm@kvack.org>, <matthew.brost@intel.com>,
 <joshua.hahnjy@gmail.com>, <byungchul@sk.com>, <gourry@gourry.net>,
 <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: <shao.mingyin@zte.com.cn>, <akpm@linux-foundation.org>,
 <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
In-Reply-To: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
X-ClientProxiedBy: CH5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SACPR12MB439974:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ba37e1-49e7-4fd2-998f-08df3ed5d3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261009223027099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	MTH3YJ5FCTuc9/Wi6qGzpU+wQ4jASQKu4fNAYXbjCFKKLug4Uyo6YtcQskgNVnWc+fIXScfdb4oDSQAphK3guVPW6ey0KdQLq69x8sgXFOtGZP6rWUOI8KCSqx2mTq2MHvp3WwSJvDhKowfsSfdyfEpapdHsRCGIA/75V1Ck1tKsLiI1lp6OemczlIDDalpKweha3L80WqRBUxB0g3gjIhSvDRhp8Hcabi7vAKFYq5bsSp1zqT7YRYA453tZ4XmgNRnn9FwqznOk4cw3oHk5Bpk2u6/xJDHOxdl073fGumVNNLrIIZMy0f5GBp4G/0n2U/OStQiAFUiwSZxPdcJQEJVFTkO+DTOpDYA0fyg1liHuJCWhsk6fdI3fPO06HlUTJ75uwrPbmDoTbD+g+lF3oRAdd6all2IEm1hXgnZxrb4pgH64ai02kic8LYkHYF5MH5w3bVO7LB8rp5CNJA9MrQLumwaIjxaamq5buCri2Bzed8bPUErZskWLC0IWwBdKm/J0Wf5VbnOI2IqUZC7bngQS7fKBi+M19wJsd0cHUXsV7p3yzbop3OJ2J/M6JTJOmyQYZsZhLkDwdXfEu5IZ7W4vUomdA7+hgTDU9SUDfd0flHIPaLCcvGnnXREfqmkNTXwYAB7eHgGo5l14ISgdpz21x/ip+1YKezQwnPCLzvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDdKOEVkSy8xaFNvczh6N2JZRDVCV05uTzdzcnVvRlJOWTdYdVlMTkl4ZTU1?=
 =?utf-8?B?b1Q5Zmd2TUF4SXQwVTBSN0JHcmlmdmFqcE9reGVWNkRuSXlXRTVJTXh4UGFh?=
 =?utf-8?B?U01EY3VFcFFheHVpcFdmanlXVDY4cFF2ajA1ekpqWWFxZTNYNkxCK0JUVXlW?=
 =?utf-8?B?WEN0NXJMUGdINFVyb2JZR2crbGtVT05EOUhlaGlDVDZQZC90N3l6YnlVQmZZ?=
 =?utf-8?B?UHpWYWhtU0k0TzlwS0plWGc1NGZyZThzRENQZDdjaTZQRDV2YkFHZERiSVhL?=
 =?utf-8?B?eVEzRHh1WWFSWkZ5Z0ZkWEtsMC9qQ2RDWXEyd1o3KzQvY1QxcEFqb3BDeXA5?=
 =?utf-8?B?aXVkMHJTSzBsN2JvTStuYjN4eWtkaldSeUYvNklUcWNsbkpXeHl6TDZwa2oy?=
 =?utf-8?B?ZFdLcDZVcWsxcFhOK29VUitUWDNpM3ptckJEOTFvanZmR0pZdnU5V1k4SWtk?=
 =?utf-8?B?ZnhNWWp2TXF4enV3NVdjalhYMWhkeGw1TmVVYzZTb0JRMWNIb0UvN1FXYW9U?=
 =?utf-8?B?QUhoa2pJaXJqeUJNWnN5SFpPaVFrcGV4VW9nSTFZR2xUSUpBYTRWZWVhTk01?=
 =?utf-8?B?WTQ4QmJKUjVIYUg2MmFFQnRKc2grWmpsbDQyZzRJMkJWdkFsRzBpK1VnZElC?=
 =?utf-8?B?enMxcmQxRXFmZk5EdmhFRVNVQnpKcnFVTThWcW83TzczaDl6UXlUYm5tM0JE?=
 =?utf-8?B?a1k1WkF6R2NzSG1BR0JtcVBOaSs5NXZ2NmkrcUtNZjNJQkZQNll1TUlhaU9Z?=
 =?utf-8?B?M2VlNDNWSjZ2d2lvZTFQTytxTEs1VTVyZVJOaWlCTkFWVE5HWVNWc0ZVS0kw?=
 =?utf-8?B?STlXRFBndUVFRGd6dTlobWFtanpialUxQjFKWHY4QU9mM2FpVGZRZE1ySUxP?=
 =?utf-8?B?ODQ1dDNPVXFyeDg2QmtqMm96MXlRV095UytyNWxsdnI5UmJuZmQ3bnpuT0Vm?=
 =?utf-8?B?MkNtcStSd09tZnkyL0dxamFyL2t6bDI4NTVGWmlaT2lnUkQyS2lSY0YzQTZK?=
 =?utf-8?B?YjkxVXJmNFR1c1FjNzJ0VWN3UlRTQ1NCaVNPMGp6VkJMWE0rYVNQUWJUVkd3?=
 =?utf-8?B?cWgzV05leGxqYzhVK29rS0FuLzBWVVE3VEgwYjdwRXo1WG1iMXZ4THlEZEZD?=
 =?utf-8?B?bGtGYWxuMVEvcGE1TktGTHJPNHdkS0IyS0I1M1FWK1JQbTJjRjBvSzFFczRy?=
 =?utf-8?B?cisybGpueGpLbk5ybVRHZUdpSUpoWjhudlRIaTFqeDd1RGxkbTlTcXUyQklk?=
 =?utf-8?B?OUFEOXJUYTRESmJFeENVSmpJeHJHdkZyNk1Wc1pzeE9Zd2RqTmlNMldGWDVq?=
 =?utf-8?B?a2hVdDg5enB0Y3JabDlPRk01cEc5bVljcmNkT09WYnhEWlNrSWVrYkxqWC9k?=
 =?utf-8?B?UGNwS0h3eWgxc0JqOWNQc2plK1dPdGVlNUQzbTdpTGRZUWNTb0N6UisrSTda?=
 =?utf-8?B?a3lXYzBPSXVYNUhEQmF1M0hoeWtZSUZ5a1g4TDc2MlNsMU91eWZ5akR1THY1?=
 =?utf-8?B?b0pVR0NpV0RyYkQ3WXlwZjBudk5JeXpIV0pjN2RlREh3SVVJc3dGdUFsSnB4?=
 =?utf-8?B?ZDU2eElVbCtvUlczVjE4SkZ2MCswNXNabDY3N0hsY1o4SGU2NHp3QjZTUWZR?=
 =?utf-8?B?NEltd1FRSVM2L21LODZpVDJ5K0NaM3VSNWFGZldEUjVuMjRINTdPelNHVEVO?=
 =?utf-8?B?K1pmMVZyeEdWSDZBaVpVYjNuSjBkcXc0M0NrS3h6ZnlpVGxEYi82cktSK3Ux?=
 =?utf-8?B?Smk5Y1IwVkxvbzl0TGRmZEg4bWgwZVd4MmZ3VkIzYXp1TnhaYnRkQXRqKzFY?=
 =?utf-8?B?MnZCOUFlRDl3SmpNVHJqTXZ0SzJWdVB4eWZKMWVyWG5rOG9YSFVXUXF4am5D?=
 =?utf-8?B?Q1BySW0yd1Q3UXhwN0hIR0lYTGFPUDJPdmgxVGtldi9NNVJCV2pnMmE4M3JR?=
 =?utf-8?B?c0dQK2pZUzZ3SzV5QkVPTVk1NERqZ3pLZmp0dENNSWNESGhCYWU4MU9kMEFr?=
 =?utf-8?B?ZEVqTk1PVFlpbXFkdXdTa3dBNndVRWtocUpkOEZlNU9JS1VLRkJqcXlpWk1w?=
 =?utf-8?B?YzluK0JLek55dUM3bW4zODJOVXFLYm9mVmdrUURwTGlzNTZSOThDc1Y0QldM?=
 =?utf-8?B?WUg3U1R1eFl5dS9MN3hId0lmMGtnS1Z3cTVpekFYcVlHenQ1Z3pEK1pYL3pE?=
 =?utf-8?B?b2pUZU1CdlBZMXlWaDVIRmY5L3huM21nQzhBOXR1VGJWbGgzSllCYnRPWGwy?=
 =?utf-8?B?cW95VllGQlZrQmJ4MzEraWR3MXZxUFBDVHhndzBua1gzVGhBZElTUUVIek1q?=
 =?utf-8?Q?7emIZ41Ehqq8Wigw0e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ba37e1-49e7-4fd2-998f-08df3ed5d3f0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:53:41.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VU3CUiib9jLtP8Ea/pL+3Q8P0lO4kyXFWH0Lw/nNEqj9tR7jBlf9mPgEk9NvieY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB439974

On Sun Nov 8, 2026 at 1:28 AM EST,  wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> mm/migrate: fix softlockup in do_pages_move() with huge page arrays
>
> do_pages_move() walks the array one page at a time.  An entry naming the
> node its page is already on is never queued, so the loop runs without a
> voluntary preemption point on a non-preemptible kernel; the existing
> cond_resched() calls in the migration code are only reached after a
> folio has been queued.  nr_pages comes straight from the syscall.
>
> A 6.6.60 x86_64 kernel with CONFIG_PREEMPT_NONE=3Dy and CONFIG_NUMA=3Dy
> reproduces this under QEMU TCG: 50 million entries pointing at a page
> already on the target node keep the CPU in do_pages_move() for 42.9 s and
> trip the softlockup watchdog; with this patch the same call completes in
> 44.3 s without a softlockup.
>
> Add cond_resched() so that long calls yield periodically.
> do_pages_stat() had the same problem; it was fixed by 8e934ab44389.  In
> current mainline only alpha, hexagon and classic m68k can select
> PREEMPT_NONE and they cannot enable CONFIG_NUMA, so this mainly targets
> pre-v7.0 stable kernels.
>
> Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Changes in v2:
>   - describe the reproduction and the code path, as requested by David
>     Hildenbrand; no code change
>   - correct the do_pages_stat() reference (fixed by 8e934ab44389)
> Link: https://lore.kernel.org/all/20261107213856462Jx8pIdgdtLvPLfOFTwV4X@=
zte.com.cn/
>
>  mm/migrate.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Acked-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

