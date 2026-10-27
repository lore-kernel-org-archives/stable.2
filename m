Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793066465;
	b=rizGJhVNeaEXtbIaQ8PO1jao8RHyfLyFAtIagVv0whr5Bl6kWfBkTO9HBVobkSuI+xFd
	 AjXIDh27FeIv6aW9u7g/I1oDc0/MogZe3hA57+p1ftVhcVR2IcNEi6M5FfrLzi1ZnoaKh
	 frEAPrdZeTxj+LnRjbfA/t5hcP8/gCe5nC7R2Z6fhmS2gleoitjEjr3qV43pWEBs4wFEb
	 7Gdc1OBuBmawG9HR6E7n6LaLrqHpIwEEPqRBU+wn3MDeFkY6+trdX0Oqp2BQJeCsjmVWy
	 AbcZQ/K1Ghq5fys3mqbEwzNg6JW3YGNukRpK7zi9DD4a2FCdADMUNgM0kXLx33n8USg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066465;
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
	bh=ZJXeSH5eRoyu1WcwxWHgJvicUgtxRWa0d3FiCGgRq3g=;
	b=RsN+TH7rGztSsYBH4eSyH/T36EUvqSR3kFP1YOpTcbhyaQKC7KaV3FalWE94IIHGqQEp
	 20DxvDha19Atc1fDZ4+jbOyHg/wnoGvozkRwWZ727ndu3LkytsQSJ+AW5+TwUi/RU0hFT
	 JsiMzJbz5M5+Xpr3j6xESGn3qzr0Fw6Y8b1figWMd34cJ4mU689+TZRhvRs8kApZlUB4V
	 aDAbQ1RuvcSzImE2EVtS8pEj/WlZEyefZ3yhhul6KDlmgcdZsFXdVrfpf6ZczafrYEeTQ
	 Ew4jeyIB8COoxK9fUrd3ETFMpks5eu2NI2IzRxJxRZ1Xa1JG+x8xyFcQUxzQTe+iF/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oyk1SfTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.23
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99563606A31A;
	Tue, 27 Oct 2026 02:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99563606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oyk1SfTD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJm6YpNrW8UZTPhyBi8/NKFnivunKH2Lkbq/UPfwHMCPb9FAZUNCBakfX5OFskmJBncw2s8qxV6JipiwsRlDUNUIHnTzv1UHIRG/PaNN0iMxVau+IZxywmn8lkICpQY7v0qygAsjpWWMCcLCRuMpHlkFgKTdveyXrf7+jCL7kECv0eooQ1MeVvTYIghP1Yme3C+9bUOMgbp7V1CGMcG9AyNygeR+lczz1hdACs+b4Ukpl0rtGofn4QspN0jrsDq6eGdJUACzeeQih+AiPxn9Zj+c1mqmjW98Xplnae3dz/rC2SrGoKZLWbph31gkBi/hoziC63pZUr7vFubbjPyNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJXeSH5eRoyu1WcwxWHgJvicUgtxRWa0d3FiCGgRq3g=;
 b=RkDe8jeroua5yxc8B9kbW6jvsDxBeAQGiwiD5pnSQivwQ6MsekPAEZfw4Zf4BrxdiRBi8XnQCdNlXL9wQpq7Pi1KCc6W5YKvJ9i4Aiz7o//IaVGNdvvD8gpJ/JHMtT8/Skpov5UoTNJA6GmxOWZQQmJOfS4YrTJ5LuqtPI2+4V3eBFXm/qExGjEyouo817+gHjLbKe9Y3OLN5NQnFAceTHcHc8rm9JKj2E1hnKcrnLCnYYtScBDjUUlWdSY/Rqs/fDO65uFWHWWQ8B3SydwGLDYQpTSASDDsYZY8kfRIBxjfcbDcQ82743Cmv7m9ZFQOXinQnbCIdzlx2YQ0mFeFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJXeSH5eRoyu1WcwxWHgJvicUgtxRWa0d3FiCGgRq3g=;
 b=oyk1SfTDBTIcilfa82lbwzHoOFMSqwO5DWEIcTtuF03sxn2ocsu9rRvDEHw1i0T7BiF6TUvLnJDPNwxhN6YOyt6Mcr21ePhfv3z7egrVwc/YAxioWbG0yW9XCgufQHDMFBeOIB3J7JR2E26e7b8YbI3nGMoz/cQSJrj+5g6u/BlvysoagSR2f3VS+1gVZSjk3HmwFQnqBkUpsaGWAZCjTIdGb+YnzfsoHwRtawEiU3Ft/1BuL4M4cwvMwRqwkjYtYaIXSBLoySKgiMr2fkO9qAnXHfJA/Vb1c2teK1hYfHs6dFb0Da5GUuN85yYFK4pLZfYvEBxptwA6XMBEQ10XBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by FT1PR12MB281198.namprd12.prod.outlook.com (2603:10b6:170:1d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:01:00 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:00:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 22:00:58 -0400
Message-Id: <DMF90FIEGBQS.2GVI2Y0R5BTV3@nvidia.com>
Subject: Re: [PATCH 09/16] mm/shmem: preserve data in clean folios when
 splitting fails
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>, <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Vladimir Davydov" <vdavydov.dev@gmail.com>, "Michal
 Hocko" <mhocko@suse.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Lukas Czerner" <lczerner@redhat.com>,
 "Carlos Maiolino" <cmaiolino@redhat.com>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Verkamp"
 <dverkamp@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Stevens" <stevensd@chromium.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "William Kucharski" <william.kucharski@oracle.com>,
 "Chris Li" <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Nhat
 Pham" <nphamcs@gmail.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-9-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-9-703206d5fa0c@kernel.org>
X-ClientProxiedBy: MN2PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:208:23e::34) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|FT1PR12MB281198:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3314df-af06-4db9-1386-08df33ce2599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|10067099003|18002099003|261026121527099003|22082099003|921020|56012099006|11063799006|4143699003|261022105027099003|261009223027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	6hCqe3y3xv6w73KcauvP+JfD4iWe9bF7j579jTJdEpfPW9nP10uAOwO9Hi8FdMOnN12BXvkovVQdwEaxH5Bi0Al8TQ4i34CNRfZEC2eV5ypSHnIPMEtJ85SKvUEM8Bb3jwOeb4P+HNgKPld2dojUnO5qLh3WpQ8ICj2gPCXX4dzMFP/ktXtKhY/DbUdBEBe1g3mTyjf15Drzx/ruUDWJOAYBRrNuGeoOp/Am5MgrKODGjIr10ReuRjsvgKTAWjGJ0knTBQ+EKGyML8djEjwVcVAH39txoXJtoPQ5bX/MuJLCtY+oMRBUXcTIyYAK9LN0ldKhOFerKZhrnUjfuCdjUS/EZjiAOzdJzNHhiSrr5qhbIWEHpW+rI13qrNAakjuxBRw1Hk8ogOV2TdKBZHW/WR5bapsVT9fpaj9wFrwUw8XeqsbMY+VkVXQrdDOynZorV9BceEmF/LXWvSWxBSRuvQRgo7eY52VE3fXoMBYS4HJUTaZ1nI74x5U292rqEEne0wVAnYGOUaXvjSpeXSiydos3YAGqSqTlRvVDvN515J9NS/y25q9NkG21Nd5ONmk1W+vxJKDAxWV/REeunlTGBbRe9CKz4d0mBqJ4V2q72JGuj/BmeBmhIKX6CyZ5rw0BRqmhJBDdWN87P9npLUTVq59smYc8rDdMaIoGIS4SbOT0aHxwknQyXa6AdL8py9DQfl5+HUY+JcDGwaFWdMILCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(261026121527099003)(22082099003)(921020)(56012099006)(11063799006)(4143699003)(261022105027099003)(261009223027099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUQ1TjAwMEs0Yjlib0dqdGI5ZDFaLy8wSnF0L1dEMThlTVFlM3lVUm4wK3d5?=
 =?utf-8?B?cDdTR0x2WUwxOXpZay8wU09KdGVDcnVMWExJY0RrSTFZV0RRWE9nWUZZMG5X?=
 =?utf-8?B?SS9kV1ZLNitnMGtSaEZYSVRHaGx1VVA1ZzU3bUZvazdxbWIvZDRxZFlTUkZx?=
 =?utf-8?B?QzN6TWdVakYwMVBJWnNCbXRHSFFRNzNHbk9GN2E2WVlVdTNrUnczM3c0cENq?=
 =?utf-8?B?TTZKRWRxbUp3Mjlac1JOV21DWmZZTkhIM1ZTdUdlVHdnMGM5QmhUM0YzOEtz?=
 =?utf-8?B?OVBhSUljY0E4U3E2dnNXeHc4eUxEOWJ4eXVxZm1WM2VwRlAwK281SndROVVM?=
 =?utf-8?B?Z3kweEZabWVwL1ltMFpDd0tHUVJsWVN2eEkvUXBNdzBINzRkTUlNN0Uza3V0?=
 =?utf-8?B?cUxzL0RZeFozTlNPODFZeDJ4VFFKNUwzQktmZHRTZGR1eVR3bkphWG5VY3dT?=
 =?utf-8?B?M1YzOU02Smk2M1dHMUljTE9HSzBtNmVUWThIblNTbS80ZnBGVk1EWGVoVFRr?=
 =?utf-8?B?OEhsdFJ5TjNLRXoxemhmbnlmQTBKaGdmcm94aC9FY1pUS3RqbFlSdFRVNWov?=
 =?utf-8?B?QSt0VlFIakJyK2ZyeVdsaXpXajFYanQrMGFFc3VNa1N4UEtSTWNxTnhFdHpl?=
 =?utf-8?B?Y21WNEhJVFNDcHJadlJFSFdDcmx4QWVqUjZlYTdVVTNDa3JKZjJNNFVvTzhs?=
 =?utf-8?B?aXpZSVdtZ09oTDArZzl6R3dLU0JtRzBnYVMzREowRnNlOFFhQndMSHBoUFZS?=
 =?utf-8?B?YnowWjhibzBoREJPcnN6VjVsL3dWMmVPL2dmTnBFbHVpdElMQm80Y0FBNG1w?=
 =?utf-8?B?MFJnNFZVOTVKeGg5bVZjZWZtWFpYZkRsR09zN0hJMHV4ZitTY3hGOTdEUHIy?=
 =?utf-8?B?ZVpGSHkydnRiQUQrYTZhVFlwbUtuR1BQTnMxTUx1MS9uaHpFRnd5bDZmb3hl?=
 =?utf-8?B?ZDU2NGVoblpKZWYzemJ0RlArS05pR2g3L2dPdUsySTExSndkd3VnRGZYMkxi?=
 =?utf-8?B?b3B3TkNNSjlEdlB0NzBzQU1ZNVFTRU5FSUhvWTQrWEtmYnpQdVdPNExsRW1a?=
 =?utf-8?B?NEIxYnB3UnNEY015VnpBMUJwbGZkVlMvR3pyR0xhODRMRisxZlNmNHZyWC9D?=
 =?utf-8?B?M2ZtaTgySmk1N2ppUUZXeTlGSG44K1hGeGNyRDJRZzBiTXpzL1h1Sm5xUitq?=
 =?utf-8?B?dGVNVjR4YjhkWDUxZkI2c0Qzb2x4emh0L0owT2NLNUdsQmFaOWwySWs3R3Va?=
 =?utf-8?B?MmhQQ3YwdTdoNE9PT3gwTDlsOXJqWFkxWGZzQkx4MkxDZUhQZEJLQzNXSmhN?=
 =?utf-8?B?WkVQVUxIWnJIWUtLVndJVUdmelFnOXR4TDl4UlRTTG1NcXFNR0lsZjJ1aXh6?=
 =?utf-8?B?eDBpWnVLRUZsT1l6YlQvdFVlUUpSSVNrRXllOWo0SkFJcUlZdTZQZ0xvMzhB?=
 =?utf-8?B?KzAzMDlRV1FoK1BPVldwSjJYcVZxKzN1dTNPSlNKTENMTVJSV1hzbnZRY3dp?=
 =?utf-8?B?VmZhVTU1ZEVLelFRdWhuNDFHZ0xFZjdveHFFSlRDd3k5cEdxZEtobDJTNDhs?=
 =?utf-8?B?S2Zvb1E5cWlFRHY3UVJZRkM2cUlDYWJtMHVDRE44SXZqVm9JdTJqRHFHbE5h?=
 =?utf-8?B?VHRDOUxvOGdZT1pjeHZZUlVlWm5GeFJWVjhmc20ybjBYV0RYREZMUUs5bjdn?=
 =?utf-8?B?YVdGUlNNSElCR0d5STVzYWpmTlpRdHBHcXloNGdaU05jN1VZZHhmV1Q4bWdE?=
 =?utf-8?B?VFhKSVVrcUFsSytRS1Rsa2dQdmlIeWZOSHQrRjlIaTA4dG15ZE44RjkxNE9S?=
 =?utf-8?B?dUp5Sm5qNXc0SWk3a2dmZHV2WEd1amdvM0o5SWNuOE1JeVJUc2Q4Mm9JRGxy?=
 =?utf-8?B?aUQ4MEUwRW5VTVpqSXd4MTR3b0JUYWNSQnY2emhzdkVhd0FGbFFFS0sxckZv?=
 =?utf-8?B?L2VRWktJcTMrSkk0KzJCWWhEdnR4MlZBZkZUcm9FZDZuWkNEaitBb0d2TmFl?=
 =?utf-8?B?UDRzOHNQWG9MZWc1d0tGbXAwczBHQUp2aE1rUm9PSVZUM2FrYS9YclR6NFFT?=
 =?utf-8?B?cEo3cHNlQVQ4M0tiU2UyZkFLWkFXOEdlZGQzdGUrTTJQMVNzTURyY25oalpN?=
 =?utf-8?B?TUUvMEwvQnVBcWZuQzJZcFdqQTRMdHVROCtLQlBKN2hSbWQ4T3YrSEFwdXlt?=
 =?utf-8?B?ZVVYTGs5cGo0UWpwZTc3WUdNMmN3QjJTS2JQN0JKNk1zWWVwa1NJYXF3YXFR?=
 =?utf-8?B?aWhiTHR4ZTVUQ2EwNUpjZHFQZlRYSFVFYU1oVWt5UHJnbXVIREkvQXBOOG5r?=
 =?utf-8?Q?dK2ApRTdRc6VWVSYiW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3314df-af06-4db9-1386-08df33ce2599
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:00:59.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j23eL7f6B5HP74xkNOAGfW5bbIBmfZpuqveN7H4hjzPTVMinrNkJ59VTYh6Im9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB281198

On Mon Oct 26, 2026 at 5:40 AM EDT, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> A shared writable mapping can have dirty PTEs while its shmem folio is
> still clean. A read fault can install a writable PTE, and a later store
> sets the PTE's dirty bit without marking the folio dirty.
>
> After shmem_undo_range() has handled the boundary folios, a concurrent
> read fault into a hole below the new EOF can allocate a large folio.
> For example, on a tmpfs mount with huge=3Dalways, the fault's offset must
> be within the file, but the allocated folio can extend beyond i_size.
> The final scan then finds this folio and calls
> truncate_inode_partial_folio() without marking it dirty.
>
> Splitting normally collects the PTE dirty bits when unmapping the
> folio. An extra reference, for example from vmsplice(), can make it
> fail before that step. The fallback unmapping on split failure excludes
> shmem, so the helper still sees a clean folio and drops it, losing data
> outside the range.
>
> Mark large folios dirty before partial truncation in the final scan,
> as the boundary handling already does. Exclude failed-fallocate
> rollback, which must discard the folios it added.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large f=
olios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

This fix is still needed, since Zhang Yi's patches do not fix this
issue. The patch below is rebased on top of mm-stable.

diff --git a/mm/shmem.c b/mm/shmem.c
index efd54a624974c..e9f98d526fc52 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1463,6 +1463,15 @@ static void shmem_undo_range(struct inode *inode, lo=
ff_t lstart, uoff_t lend,
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
=20
+				/*
+				 * A shared mapping can have dirty PTEs while
+				 * the folio is still clean. Mark the folio
+				 * dirty so a failed split cannot discard data
+				 * outside the range.
+				 */
+				if (!unfalloc && folio_test_large(folio))
+					folio_mark_dirty(folio);
+
 				if (!folio_test_large(folio)) {
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio,



--=20
Best Regards,
Yan, Zi

