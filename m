Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793068496;
	b=W9qHSCv5XGEyTjasRnIH1U8JguNwJIFhBGRmcT9ItWq1KhITWBGG567lCDwtdc2ZdYCP
	 7Y5UodcAEY0OMXBBa8sjxn0dBkomnmqXj1stRiSJcwyO23lF6+wRD8HfMMDjcGF0Hv1rq
	 L1d/4bqn5ssjGajeKV5RiOBMXo/5o/GMN6EwQAFe7xNJeslWpzIvpqnBDvSDnXeBsBjge
	 INeVJiefWwtFNzlhHWGWj2Zv6ooUIdMGYg1zsLvxWhFW86WV1JYcIqqw7lERkM/wrskNa
	 Ow/maQ7jd1omdd0G2wva3wjC3LmW+F6BGQkW0WPHv5E+6Bffe+m2aRQ0xhnWk84ygPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068496;
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
	bh=1cun7plN/2wHw0gxNzsc+UasoKl4vDi5uCYI5E5Jyes=;
	b=AoWYRyJVbpfowMajjnYTmN3ddvaL3rKB9tS9OctbbQPwmZDSJOwQH3VhvLVZdTcULMwt
	 jzs+vP2F8n0nJ8w5wFy4SOPvEZduIJhzZpyy9frujYiHxPohIx5784uU6gAfO/bNX9pas
	 DaSe87bU5mIW74b27a3TAOINQlmKu1adfZOio8dZaZmICnzw2QcOj5I75nZ5m+5d8Pa5m
	 0vtupFscGm/ZII+OlsKmjGOdljkSJtavC2cJJ63dncj8YJFL8kTluxV37UF9XQvWOV4Cx
	 IkChuuYi0O2Hvc8tkZTMMBSiB50yTn03C/myjB+9lHwWE1BKJo+XtsgAHqWDX39RicQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lhv5RFbX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC387606A31A;
	Tue, 27 Oct 2026 02:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC387606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lhv5RFbX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMQiR59mM5AyRyQ96QdTjZ3pMrYFr0hHQ0d4wEzLmlwSRQ4Z9jklGov02ICEycC+B/cL3bnPBCJkPyDIa4jmdw62xsza/58+8GRGDms/SXxKRCJ5KLopLRXVXiy3j/Vrv0kE+rah6EOhd4AVJtjjZMCYsqbx9aaGQvFaQqGqCvsqcmlKbyhhji/Agwy2c4lc0+S+12tk56xyAN9j54AcX9y53Za+plSfBnRAYGIbaoiU6AgVpzJmAYMGSUumCdRBgfAUzXQct7p1WFpCYBhaEkHPidNw0Z7CRY44ZB/fK5K7rF42NK4HK8ykz9Y+G7WvLbbThuT4jKKuON8jiWhDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cun7plN/2wHw0gxNzsc+UasoKl4vDi5uCYI5E5Jyes=;
 b=EN5qThuO4gE/cwtUjxFT/nUJUw2h+ovlc8+YW7PSGC82glgYorzxl1f+JxAl7hITG/QHKMrraO5f4mMW7BhmQyJn7ai/HeheVoHtzJl5fH6138EAsDIYroNF+K90JktFUo4tR5RRjqkm6GmAVEWjSqImHWnLt4ColouWWvXJj7CafTurtMRAT4Zv5e0jrmYfiWyO9gujar3r22wd4yMHw9Z8oNy84CbJhgWp+veXlBLOYioT/p/XoAbRlQH2r/pV/UQU+0Q7m+ITSod/M6x/ZEcOjOBZzCQI0jf9SHJ3JDr9BMaNxaLfkOeRaFWNLJ8x1P2n/jSy1mWgAueTJ8T5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cun7plN/2wHw0gxNzsc+UasoKl4vDi5uCYI5E5Jyes=;
 b=Lhv5RFbXq/tYKLyxQ2mkcazwlPC+9KoJRconXyROGsjyODWhiGmXTtbCPf13MrSNqdlnf9tsZcsP+QnpfaEfuwvrUvKsbzG0pe9S2FXCxHZtCEi1ondtZRMgsgNIoSotZ9KOM4PL+0p70byM5yINVuOYu4CRLVITMlAXlt+J3DAZFpabok5JUqu34/k2Lhg7FwEglUstNh/1tuptKsOyaCWKc9Gvanpih6WNZqJAmR0NOq0IStEm72FweUmsj2oToCg/fIMbaTeJ5vvGleHvj4HHQCVDSUQXEbp+BBFuW4HEWgabdNgSt1IMKQf2w0C9qrhQp6fPwJXnaQ9bGuNNzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 02:34:51 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:34:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 22:34:50 -0400
Message-Id: <DMF9QCS3SQ5J.2NFHUBT3I1PFM@nvidia.com>
Subject: Re: [PATCH 11/16] mm/shmem: rescan after nonuniform folio splitting
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Gregory Price"
 <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim"
 <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Vladimir Davydov" <vdavydov.dev@gmail.com>,
 "Michal Hocko" <mhocko@suse.com>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Lukas Czerner"
 <lczerner@redhat.com>, "Carlos Maiolino" <cmaiolino@redhat.com>, "Christian
 Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Verkamp"
 <dverkamp@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Stevens" <stevensd@chromium.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "William Kucharski" <william.kucharski@oracle.com>,
 "Chris Li" <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Nhat
 Pham" <nphamcs@gmail.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Kiryl Shutsemau" <kirill@shutemov.name>, "David Hildenbrand (Arm)"
 <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>
 <at-MPTlXmfs7r5Xh@thinkstation>
In-Reply-To: <at-MPTlXmfs7r5Xh@thinkstation>
X-ClientProxiedBy: BL1PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::31) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: a08dab7d-6b84-4a74-62ac-08df33d2e097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|261026121527099003|11063799006|4143699003|56012099006|261009223027099003|261021135927099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	NZy70OCBRm696GLViIfRjI+DQW7SSwyJM0fDjPOIaZgIgPTKxtCZwj0UBG8uo9Oaj9lSQLHFnwSJ0hk4EZuE4+P5oJBHiWVCJh18uF8FGkkAxsaAMMDKIbPX4iioSwNSGw6LVheIbxla9K0D3far2rhfVDbSmThVGPXBMDEKRbu4AsFQPNKD+SkJzqtmDGg6gLhXhs+R9UeeE4OjDGdFfbgkujAobNPYxwyr+nyG21imLcND1uwUD3Eu4wUhHsH1iE7ovDeVlewm3oJO08ZPtrknU2K4+gVtg4y+pFFr52AAnW9r+VxtoIAaVg+LA8Wub/iSvrgtPdOnRKWi8rAWvgmSoePtcxBsV2VuuQWlvOV3Hc5tXNQKiJ+1Ow6j0uu6p3Dae698h3QQMiUh9CYWukSp5k/UKbQA6ovjTDK71LedqCG/AUjBdcgYOJDC+fwu332YtF2M8cipjS+Rw5vdAXyDyGlJ1iuaZmqfk6ol1bgfFGxeGE3EDXvifeRcRMMZ/CyMh6ob0HgEPPwuuVniDtohJpV7ZCUT/7wRgkzoiuTAwgekHdvUWZS8lJSCHGz++sA6otcOl2Q6ozG1DG+iQ4Xw0x5DcuRNc/F4qcuYVlzjjbVsW+pe+TGFi7nnzKVbaGIKWsNpRKiV57Fts1QI5kf0BeZ3nTsYO578edwV9s8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261026121527099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021135927099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZWcGpXbGZva0xaeFUwZTZLUnVnMVJzVmhxNUs2aUY1VFU2cWN2cUs3OE9D?=
 =?utf-8?B?d2UweFBSNk14QU1XaC84SFZGTWlnL0N0RGhrQWJtTHc1SmFnSzNqUVVzSXFQ?=
 =?utf-8?B?dEpCZCtZL201R2V0ZzY4aU5sSzM0WC9kSno2WW5FK0g5UlJSZFNvd3BhdUh6?=
 =?utf-8?B?QVJxaUdlcDhycHM5T0U2Vmg5VnlIYjhMNTVQRUxtTXdrdzNyM2RzOHJxb00v?=
 =?utf-8?B?U3FVS3BrdU5OczRZd3ZUQWpBU1BkdWJOL2l2dngzVllRS2kwV3VOY29DWHlG?=
 =?utf-8?B?WTVwMUtXQ1Z1bDVheCtKaG1LNzdreGphMk50MGpuYnl6VUZ4cG1RNlRyTXZ5?=
 =?utf-8?B?NUxnMHFBWDVzYjlyVnhTZ1dGSGJkSnlNNnlMaUduV3BtUEtDUU9HTlhIVDdC?=
 =?utf-8?B?dW03d29MQWFKb0Y4cmdoSEpGT0JnTDZCUWV2YnhXbGlDZzRUSmxyMlRtRFRQ?=
 =?utf-8?B?OTlrNi8zTEVzbkRQZzZOVWtCc281NnV6TS9lM2JwWm1ab0l5amNBdmtwdHNM?=
 =?utf-8?B?MmlCRnhLVGNkYW45eHhiVzlGY2NrSlZ2elJDemVZU3ozcFNiRll1MG5wQm91?=
 =?utf-8?B?bDFFL2dKZzNNZ0NBQ0tjSVRMa2o0RTlSNmUxR2xteHpqZTdzbWVhaTg4NzRX?=
 =?utf-8?B?ajB6Mi90bkxkVzRoUWpqZlBzaWY3MnBJWkZJS0FRS0I0WTE5QjJUR1lDK2hB?=
 =?utf-8?B?SzBuakxYTDFHaTYvRjBDbUVMa0pBeUxCd2RPaEk0dWxRV2RHS2ZmWUNQWHNm?=
 =?utf-8?B?VjVQTjNWd0dsc0JwMnFsOURVZm5kVzVxWkR1YzkvdWN1YVArcldLVmpkdkpF?=
 =?utf-8?B?dGxRMnBPNlJSRUkvdEd2bVN2b3VtY0tkdWlIQmwwUHM3Q3VkL3hCeFJMem4x?=
 =?utf-8?B?Qnc0dXpSeE14a1h6VXpXbVBvNXppRUh1OG1NQjJXdmU1bzFnVGZ2aUFiOUxl?=
 =?utf-8?B?S1VNeXQxZW5GaUtBUTh5RVZnMUxwZU53NkZhejZKdXNkQmZmN2dDN2NFQits?=
 =?utf-8?B?anhxbGg0UmNUalZWYnhuTmFjdTJmRHd1Yk5lWktaQlRsY0wvdE4xZFo3Q0Q4?=
 =?utf-8?B?VEdqUUh5VHNWc1AzUDlMY1ZNZFhZQnpBbUw4TW1UQUY2TmV3M3lNMkhOajhG?=
 =?utf-8?B?QllVUm1QVXk0ODZXTXQ5a3daSG9wdEkrMHRhRWxla0lJZTlXMjhncHJkLzdv?=
 =?utf-8?B?dTZOckszbzNnK3RzNVRZb083c2g4RTA1dThhWjRvM3ArdDRaWHd4bm1Ham9a?=
 =?utf-8?B?dDVlUkozLzlVaU8wU2NHS1IrZEw0WXozTGt5b0puMzFreEd3OW1hNExRaURO?=
 =?utf-8?B?STlIbVYwS01TdE5BRjcra2NRVDYvQVFCem4vcFlOTk1va0dJQUtQSEI1cnF6?=
 =?utf-8?B?SG9VNU4veHBHQjQya2pQTUN1bXdEQW1OMDB3SHoycjZZcGo5S2FoVTA1OHdm?=
 =?utf-8?B?aDhKU21jV1R6djZubDZqRE5IWG9LbDgvUnhHbEowYkc0MFJ6S2g4U0d2bkJ4?=
 =?utf-8?B?UGdnT280Qk9hMVlQWnFwM1ZVeDJtZ0dpUWQzdnRQTHFvM3owcFE4ZFBmSjRn?=
 =?utf-8?B?RTFXT2loV2NmYlFCWjFoNHcwSDFCcFphMUNkb3JSQ2ZoVzZ0azdYUVAyU1dL?=
 =?utf-8?B?OTNYVm1oUUNyZnN3Sm9VdUQ3dFNDbFFURWdKT0JEbFJQb1ZWMEh5QWVpc1ZD?=
 =?utf-8?B?ZE1Ud05NVlJOc1FtcG1Gd3hieGVRb0MwVk91R0laVHRyQjlkMm5MUzJyeTdM?=
 =?utf-8?B?RWhWYzFIYVd6alY5dEdkcTRrVjZxMzVUYVZQQ1RGeVo2VkJRbGVEUjN6NW9v?=
 =?utf-8?B?VTNKWCtGZExSRHJXL0ZjQXV1eGR4U2UyZ2NDSGN5TVcyUDcxNmdmVmd0Z0M0?=
 =?utf-8?B?QVZPZExGdWhBK1ptNXVWd1FoRGtqeERpeUxrZnhaVmFHUjcwQ0M4MmI0SXY3?=
 =?utf-8?B?aDVQcDRvMVo1dkxDK3VLem1HY1NDQVMrN1lLRVpObjRnVGx3V0ZQUE9tMzZj?=
 =?utf-8?B?a3pKQk9STEFHZFMwT0todURMREFadDFIam9FMnlYb2JIVm91REhZdis0N0xO?=
 =?utf-8?B?bm53WFoxVFlBaVA4RWNJdzRKSlhpMEc3V1d1Z1BxMTNMZGN4Nk5zZko4STFG?=
 =?utf-8?B?WkJkM2orbStGYkRuT21SeVo2Zk5KQ0Y1OEdMM0FXSzhZVWt3K01JRlV6R0pq?=
 =?utf-8?B?S05tUUFHeTNjODNkTlpBWVRwUTJKMmpDNTdMWm1FUkFTNW45eVhUSnFwby9q?=
 =?utf-8?B?MUJMSFQ1dDNpM1BRTVh4NXd2UGxvenVuTVp4Y002Y2pUcyttQ1dCREN5cnRN?=
 =?utf-8?B?RXgvZ2RGY3hhVWd2NUNLQWVGdDdENnQ4Mlp5WHdyTDRray9vbmx1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08dab7d-6b84-4a74-62ac-08df33d2e097
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:34:51.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiKFNjln6T/gMfAnK/KucSkLSZBkgXtABKE8jp3KIKhV6mQNrfcZRrxhO97vK42y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

On Mon Oct 26, 2026 at 1:26 PM EDT, Kiryl Shutsemau wrote:
> On Mon, Oct 26, 2026 at 10:40:44AM +0100, David Hildenbrand (Arm) wrote:
>> The final scan in shmem_undo_range() restarts after a successful split
>> only if the original folio is no longer large. A nonuniform split can
>> leave that folio large, so the scan skips the newly created folios.
>> Hole punching then leaves pages within the hole allocated even though
>> they could be discarded.
>>=20
>> For example, a fault below the hole can allocate a 2 MiB folio after
>> boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
>> folio successfully but leaves the original folio at order 4. The scan
>> continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
>> The hole reads as zero, but the pages and their block charges remain.
>>=20
>> Restart when the original folio is still in the mapping after partial
>> truncation, identified by checking folio->mapping. If the helper
>> removed the whole folio, no rescan is needed.
>>=20
>> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operat=
ion")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>
> Do we want split state after truncate_inode_partial_folio() to be
> communicated more explicit? ->mapping check works, but it might not be
> obvious why. Just an idea for a follow up.

Zhang Yi's truncate fix has done that. truncate_inode_partial_folio()
returns true only if the folio is split[1]. His patches are in mm-stable
but not upstreamed yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/mm/tru=
ncate.c?h=3Dmm-stable#n248

--=20
Best Regards,
Yan, Zi

