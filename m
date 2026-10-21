Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.75.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592292;
	b=l1FoZdDw4xqblRZRzrQpsnHELfS0ThWO6cefDaKJx98URnmfK+JCwiNkLQJpH70bpnI8
	 B58VU1l/76ofdheCami1TbO5U9mbRfYQJf4RATmrgc39n3qWjg+HGYHjOE91hPygiUr9p
	 Oty8VGkC9NIBL9wvKXG4N41f1vWe4o+XqXlv+pwXYYPwEGJpu8rLZpOCEwyl8WigOEm0j
	 hItgUEDXnDEmL4FB/x5R6epWrAgGUTgTZrzPsdFglV71QbeIZR4tZMFNUGf9ampKDlrpr
	 3Ibj3C2qwWzr6W51AxQelAviIVWZMMkDGiE7o0iPcAtEnu07/TYia4XbIe05n6HP3Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592292;
	h=DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=xJVyRhqMugmiODCMmIHwgfhe++iO3cVb31aMk0TEDEE=;
	b=UMFBhkrHp34WKIKT9fxNL+dttQokkC5aerm9vR6LqOdCDJz6M7KqdRlqRabl2Noq8jAV
	 Gk/BRLWq1QIovDeZzyoD9j2ksKDkab6cftQhZ+XZ0TTG2BtH9UwHjQRoMB33JxXUK+dvR
	 mTvH0ExuFpvunqvAs2ECknIE52eI1OW6bhZ4N9QTHAwjzSQXBZubiV1PhSZe8wIMtrCet
	 j6vFNSrxg3VNKca0GERn/hzZBtP1nVB1DprDt6Asfy8jkfadPTeAS/9nalMg/Ik0AKcOY
	 e1cxPrMR1u44TGz39D19apgpO4pVnGeE/gAry3J+q/inUf3g65cJor747lQKB/dKL4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=VZbhyMIx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.75.78
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020078.outbound.protection.outlook.com [52.101.75.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931BE606A31F;
	Wed, 21 Oct 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=VZbhyMIx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec7d7HSJdpbNs/hDZJUmep5tHDVKtd4SWIsdJvgjFwn6yL/5Ejh0tqK9WD7qQNMIxJpLKS+e28rRqe7XKDCpYTrrnyC29KqnoTmndZxHeX+Z5C5jHtBx8rmV9lwxIjCa2px6Bfs5kLhIlzqagBATkSJ/Uy8dPh6BLIzXsvOE+sTw5q4rf4i9WWDscvY8n243YLTpxSrgICw67epUvT8U5hPgekmCR4gXVWMwQ48bIEuSgISOWDV6AOKdqSd8n79QPZrHtFq+Hafvuf1bdwjqfRcRBW2HLLR4h+wkgGZogizPDdPUjCPomUamza7BtL9aIiQgxvzjhH/KGTSbDGuqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJVyRhqMugmiODCMmIHwgfhe++iO3cVb31aMk0TEDEE=;
 b=jf7cXcgloaG1I+243Ey3VXbRCQuYYT0A9DhT8ZYEqk9owr0aUojN5WBfFMnsvRmOT0ofRcIFqGEJRlpfaW76RretsmXjIhWoYfs5ahI1Xf2RWMoCRvX1TyyobuCh4pOiHa05z5lsBgRrsMKbxl6vOG6VSaKYN9I8MYfpZrjS+aLU+Aur8uS64A0oR8BC93uuOJH53scSKsJ6WLxqd1yzNs2MAVX2rL0U4Cw1T33z3/UIi9ZQVtjrbFvuhnkyLuX27xHN3hBWqePONvXAnHR3S0xI4/4caJC7iQpU9rRBJkq8jGDjTL0RoA0KHtO9DRK/qdhWYw14E21qpkIE8n5ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJVyRhqMugmiODCMmIHwgfhe++iO3cVb31aMk0TEDEE=;
 b=VZbhyMIx8K2tKJwrBDxhoM9hp08S2/ajUr1Yyoo4uv8fwIl89oNg7IfcIULdBQkQ+QeJU4siBNpcQxekJq2wiGzON+y/TAZ80IRvZE85aQrBd6PhIWbnqnB964yalDbLVxEWaNuF4ErAFUzfvX2hN0nY0+fKGpF16GrU2NonwXRp/9YlCxQRhLuihXGP/lUblrwEhKwMkV+8j2vgxvMT+P3Q0nlB43Az+gx5M/9xkpUoGRntmzz5ex0qvkpQoqa29JZglfykr+FSCNG7pScvDANany4ZkCJiD7jSMM7DcZQcmyyhYo8oY0GRF623MdwYo6Qxv6LmRToa/Gz8/UOJSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV5P280MB2219.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 14:18:05 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 21 Oct 2026
 14:18:05 +0000
Message-ID: <1649afcb-ae04-406c-ac41-92f62d7343ed@gaisler.com>
Date: Wed, 21 Oct 2026 16:18:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sparc64: flush vmalloc ranges from the D-cache on
 map and unmap
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 nsafran1217 <54966414+nsafran1217@users.noreply.github.com>,
 stable@vger.kernel.org, Stian Halseth <stian@itx.no>
References: <20260928132102.1707-1-kaloz@kernel.org>
 <20260928132102.1707-3-kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260928132102.1707-3-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::32) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV5P280MB2219:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aad6c60-8ccd-4bda-4ec3-08df2f7e1fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|23010399003|376014|260925021311599003|56012099006|4143699003|6123799006|260925022911599003|11063799006|10067099003|261009223027099003|260925021911599003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BarULVdq1ZvFwasrkweq06gyn4Ja/9RWYdQMVrruVLv0H5rZSpjlAx9C2iLy5Wj3O7Mujonw2WBj1eVdsD0ak8SsQADbN62wwzStocU/aIgh44fyYyd1AwUnT/q9NqtX1S52rX/RCUxIFeNPQaPwPc0ZJLx+Sg9tC4v47bUxjDs7eCBJk7wA3vOKKm7LrX/2AxVk43O3GE6d8pqK1HAj7zb5/RzqPwQrQoN0sTRh7icuygZyD/WB/X2YASZsVf34d0yHT6SJkIwbFr5et9fZ/4LsFzJHM6SNcCwPK+byLDIsmIk07YI6C3CzyO58tf8Sa54rUVrOZIDzEaebCxqcQ6YyTwwuHrCSC13I82o7th53CvgeTeoBwiros6rLklL1VQuHbratG32NqG8+DG4QMj5FRQX8aHELcXgUDpt8nDbQzHWeVOuaT6QFDfRZQL83VhUpQRmGZTJD7138IKEBlnNURlBgbYbWV9jnEosrfSVfVWGJoRoWxZFwzfv++FK/M0SBPlvI+yjDcxTvsdQNPv7wYvmObYq7T3bfSS1cV1yrU8/BS/ASPKqxhh9JgoruhkNDvotJ12dysZC69Uttgq7sMwHxZjxv7Dl+vnGhonKURKCAOyEOEE3o6UE2r+Mj3+wlzG0ZMA3tKdK23UiKDtbN1EyLnjO0SC8vaqG05M8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(23010399003)(376014)(260925021311599003)(56012099006)(4143699003)(6123799006)(260925022911599003)(11063799006)(10067099003)(261009223027099003)(260925021911599003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkNuNTJhL3EvMzFoVXhQTVVZMGhVeDB2cW5jMWh3R0lyMHRWdTd0RHAyME13?=
 =?utf-8?B?aW5DMnpaYUdXRlBnbU5veTBubVI4R0pnSFNJRFdTQWE2RUk0NnhRaVpZZk5P?=
 =?utf-8?B?MlhsOHhuemV3aGlMdmdmdkpuU1VkdXlvdTllMUtrOWtqc2g2Rm5kZkhneHV1?=
 =?utf-8?B?TnBKYlVLcFNZVXhKRTcvSS9xV2tMMjRlVk9RSkZFWU1iZjlQb0F5YnN1bzgr?=
 =?utf-8?B?RC9OOWlUclZ1L0QxRU05M0RnTUUrbkY3K2luUHZZcjMxYW1rcXdwd056T0lV?=
 =?utf-8?B?WWFSK2NXRE9wa05HYXVBdnV2K1MxcjBoTnRJZVpRTWMrZ1lPTXNnTkhHQ2Fn?=
 =?utf-8?B?REpBbFpqN2VranVLTjJqSEpzMjlUYjVwaVhDMjhPbE9VcmJOYjkzaW40SlJp?=
 =?utf-8?B?Q0d5L3dsSm9sQ0pjT1pwdE5GWW1FalpPdjA2QmEydjVlRncybFVVZDVsTTFo?=
 =?utf-8?B?L01EaHRmejZYWWF4Ykk5Q2NhK29QUzFxaUZ1blFCaDdKZTI5T21kVnZwNlV4?=
 =?utf-8?B?b0k1NjV2ME9aWUJweXRQTUMwWktmMTVjVU5XVWd3TFdYb1lOQ0VLQytXK1Nq?=
 =?utf-8?B?SzFEcC9YNTBvNnpQekZTL0JMVHFFcWlxSDNiUWtRL1hKYmkyWGxHREU0VlVz?=
 =?utf-8?B?c2JScjk2S2xpUmd2QXNIdjJtd0FjVVhWekxiT3JkYlZ0RVN6WnhTWERTVU41?=
 =?utf-8?B?L1FhbWQycDZpb0lFbng2N3RvSCt1WGRyNE13SnFIdUE0eTJUYjNUU1lLRXI4?=
 =?utf-8?B?MWZQYmNtZXJTeGhDcVpGdy9ZTjRCRGR1RzBDaWFTZW1HdVNneFFtNGNWR1Iv?=
 =?utf-8?B?ZWVHbnZNOW1GcS9TMkpuTThGL21ZTDZwa0lXUzFtN3RhVXJXaXBXOGV2cHM1?=
 =?utf-8?B?QzEvdHFLRjV5Y2lRRkRBM25Lais2Vk01RVlnUElBbmcrS3FSNVhWek5LSFp5?=
 =?utf-8?B?WDRuSy9Mc0E1bFJzQWxjR1ozR1hsdTU2Z0d1QTZ5N2o2VWF6M1ZheFNNNnQ0?=
 =?utf-8?B?RktXdUZqblJvT21Jd29GeGsvTVJ2R1J6VnBlcW5STFJxc2sreTlyNzBiSmlx?=
 =?utf-8?B?aGNwcDNVUzNDZnA2MHBINWt5T2Fram85T1lKRnlNYndPNndVU3dESmZjTFhL?=
 =?utf-8?B?N0F0NXJlUGFVSjFoMFQzOUgzelhtam1Fd0V6Tng3S3o0RUNkWktUQzZjREth?=
 =?utf-8?B?VnV1RitrUEt6TUd1Q0locGhlLzBsN0NMc3J2SjMycWVPTE8vTlpaMGR4bFU3?=
 =?utf-8?B?UzU3RmwxcDJkNDR2djRDM1lMVG5iK1RMc2tSMXJNS0dUOFdxUW5vYnVuYVFq?=
 =?utf-8?B?d0NOdjdrQkJTMTJ4SHI0QlhRVXFzQWMzQjA3bWsrSUsrNVpGcEo1aDFBS1p1?=
 =?utf-8?B?bWdFMk92MW91Q3RjUTZnTGNCaGZHMzJqYzZRbU81bjAxVkZBcEZsTU9MQWc1?=
 =?utf-8?B?djdkam1tNWtsNW5OUzZaRUM4UGFyQnBQUWxoNDdVd0VRdnZERkxuQXZLYXUy?=
 =?utf-8?B?YU84OFhtNGZKK05wZmp2K0c1OU1LU2xVVzhHZ2NGNmdaeExhK3N2WUFabkRz?=
 =?utf-8?B?eGNlV2JNMU5QTlovQTd2eFRzVHhDOG9xWVdLYjZWWkUzZWhvcEoxL1gwSDVv?=
 =?utf-8?B?ZUNMdURUNVQzTlEvVUJUdGtHYTRqSHRudUNhalVhVFJWc0JyaHQvamlmN0lq?=
 =?utf-8?B?OU1nLzFzTDZYSW45azNPbUdHKzVEeWpMWGk4Wm16MlNLVFNLRDl4WmNDMjMx?=
 =?utf-8?B?TVVUcWJFcncya0crSVI3Nm1KM2lnRTcxYnY1azgxK1lSd3duS1ArSjNmMHhW?=
 =?utf-8?B?S0hTRElWZWxHUW1ObUFJUTFVNWw3aHVTaG94Ukw0RTdtN0lVLzArTGhwTHRF?=
 =?utf-8?B?N29yR2w5M3Y5Q3BQVEttN28xaUdiVVprWWdFQ1YwN29vYnN2NXdmWFVDL1BM?=
 =?utf-8?B?Qkd5Um5jekY2Ymg4b1htQnhVSDBFS2JlbnpYOFFXOHNCWHF0alZkQXczbi9n?=
 =?utf-8?B?cHBSd0VqamlGbFJuUGluUEg0eThrbW5Gc3JhRWpZNjkzWUZQQ244enl6Y0Fy?=
 =?utf-8?B?dmhvdmwybFNHOVpHYUFpT3Q4K2NMSkxlYTk2cTlSZ3FyMmY2ZUJLa2F4VHVF?=
 =?utf-8?B?OEJKWS8rZUErRGFzcnpEZU9QVkQxd0FhbnNlVFJRanYybk5CSlAvOFJac2tB?=
 =?utf-8?B?bURwWUxwUThuZzVtU3llWnhKYW5YWDNpZG50c1FtUEsvM3dyUkVEaDI3aVcz?=
 =?utf-8?B?RHRuYzRhVzY2Q29Qa1ZGY2svOElpSkhNVGhTTVh5dUJ3U3BDcjRPTFZMMTRn?=
 =?utf-8?B?dmRlbVVjSXlmcmR0WXNwVWY4VnRyaGFSbXRiOUp1S3FiczdmSm5qZ3RRd2tp?=
 =?utf-8?Q?9GCsQoADSO8KQHRo=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aad6c60-8ccd-4bda-4ec3-08df2f7e1fa4
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:18:05.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBSj+tTEdJAgDNFkmu+iaPPiKlJUkQQLvw4V2NXLi2NkbLG69bN1Tr7KbLCg85HyEmmxrH2FCrh3Ein9CFHkzL3t8ub1IM7evzUWIA70lUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2219

Hi Imre,

On 2026-09-28 15:21, Imre Kaloz wrote:
> The L1 D-cache of Spitfire and Cheetah is indexed with VA bit 13, but
> flush_cache_vmap() and flush_cache_vunmap() are no-ops. Lines loaded
> through a vmalloc address survive the unmap, and once the page is
> written through the other colour, e.g. zeroed through the linear
> mapping, a later mapping of the old colour reads stale data. Anonymous
> user pages arrive the same way, as tlb_batch_add() does not flush them.
> On UltraSPARC III this corrupts BPF programs and module data.
> 
> Flush each page on every CPU on map and unmap, or the whole D-cache in
> one cross call once the range exceeds its size.
> 
> flush_cache_vmap() also runs on the vmemmap, from sparse_init() before
> init_IRQ() sets up the cross-call mondo blocks; with the mondo block PA
> still zero, flush_dcache_all()'s cross-call lands on physical address 0
> instead. The vmemmap has no aliases to flush, so skip addresses outside
> vmalloc and module space.

I would not say a cross call lands on address 0, which kind of sounds
like execution would end up there, rather that it would do writes
starting at physical address 0. Clear language about problems that
"would" happen would be nice so that it cannot be read like it happens
with this patch.

I'm afraid this solution could be a bit fragile though, in case some
vmalloc() later on would happen between vmalloc_init() and init_IRQ(),
we would be in trouble here. Better might be to in xcall_deliver() build
the CPU-list first locally, returning if coming up empty, and only after
that start accessing the trap block. This could be a preparatory patch
that is not marked for stable. 

This patch under review could still do its job as this manner and have
the is_vmalloc_or_module_addr() filter be a performance enhancer in the
context of a less fragile xcall_deliver(), but needed for a stable
pickup, clearly mentioned in the commit message.


> Link: https://github.com/sparclinux/issues/issues/29#issuecomment-5041121375
> Closes: https://github.com/sparclinux/issues/issues/29
> Suggested-by: nsafran1217 <54966414+nsafran1217@users.noreply.github.com>

This is a strange email address to use for a Suggested-by

> Cc: stable@vger.kernel.org

Given that this patch depends on the previous patch in the series, that
comes with a Fixes: tag, which this one don't, a comment that this
depends on that previous fix could perhaps be good here


> Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240, SPARC T4-1
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
> v2: skip the flush outside vmalloc/module space, since
>     flush_cache_vmap() also runs on the vmemmap during sparse_init()
>     before cross-calls are set up (Stian Halseth); picked up his
>     Tested-by.
> 
>  arch/sparc/include/asm/cacheflush_64.h |  6 ++--
>  arch/sparc/kernel/smp_64.c             | 18 +++++++++++
>  arch/sparc/mm/init_64.c                | 43 ++++++++++++++++++++++++++
>  arch/sparc/mm/ultra.S                  | 25 +++++++++++++++
>  4 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
> index 02c969417e7b..54a2d37008e6 100644
> --- a/arch/sparc/include/asm/cacheflush_64.h
> +++ b/arch/sparc/include/asm/cacheflush_64.h
> @@ -42,6 +42,8 @@ void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
>  #define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
>  #endif
>  void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
> +void __flush_dcache_all(unsigned long size, unsigned long line_size);
> +void flush_dcache_all(void);
>  
>  void __flush_dcache_range(unsigned long start, unsigned long end);
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> @@ -73,9 +75,9 @@ void flush_ptrace_access(struct vm_area_struct *, struct page *,
>  #define flush_dcache_mmap_lock(mapping)		do { } while (0)
>  #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>  
> -#define flush_cache_vmap(start, end)		do { } while (0)
> +void flush_cache_vmap(unsigned long start, unsigned long end);
>  #define flush_cache_vmap_early(start, end)	do { } while (0)
> -#define flush_cache_vunmap(start, end)		do { } while (0)
> +#define flush_cache_vunmap(start, end)		flush_cache_vmap(start, end)
>  
>  #endif /* !__ASSEMBLER__ */
>  
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 18b6145da591..bebfc44241b3 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -915,6 +915,7 @@ extern unsigned long xcall_kgdb_capture;
>  
>  #ifdef DCACHE_ALIASING_POSSIBLE
>  extern unsigned long xcall_flush_dcache_page_cheetah;
> +extern unsigned long xcall_flush_dcache_all;
>  #endif
>  extern unsigned long xcall_flush_dcache_page_spitfire;
>  
> @@ -1025,6 +1026,23 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  	preempt_enable();
>  }
>  
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +void flush_dcache_all(void)
> +{
> +	unsigned long size, line_size;
> +
> +	if (tlb_type == hypervisor)
> +		return;
> +
> +	preempt_disable();
> +	size = local_cpu_data().dcache_size;
> +	line_size = local_cpu_data().dcache_line_size;
> +	smp_cross_call(&xcall_flush_dcache_all, 0, size, line_size);
> +	__flush_dcache_all(size, line_size);
> +	preempt_enable();
> +}
> +#endif
> +
>  #ifdef CONFIG_KGDB
>  void kgdb_roundup_cpus(void)
>  {
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 8792e5d92517..3e2096545e52 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -27,6 +27,7 @@
>  #include <linux/percpu.h>
>  #include <linux/mmzone.h>
>  #include <linux/gfp.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/head.h>
>  #include <asm/page.h>
> @@ -234,6 +235,17 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  		__flush_icache_page(page_to_phys(page));
>  #endif
>  }
> +
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +void flush_dcache_all(void)
> +{
> +	if (tlb_type == hypervisor)
> +		return;
> +
> +	__flush_dcache_all(local_cpu_data().dcache_size,
> +			   local_cpu_data().dcache_line_size);
> +}
> +#endif
>  #endif
>  
>  #define PG_dcache_dirty		PG_arch_1
> @@ -3072,6 +3084,37 @@ arch_initcall(report_memory);
>  #define do_flush_tlb_kernel_range	__flush_tlb_kernel_range
>  #endif
>  
> +/*
> + * The L1 D-cache is indexed with VA bit 13, so lines loaded through a
> + * vmalloc address outlive the mapping.  Stores through a mapping of the
> + * other colour do not update them, and a later load through their colour
> + * returns stale data.  Flush at unmap so vmalloc's lines do not follow
> + * the page back to the allocator, and at map time since anonymous user
> + * pages are freed without a flush (see tlb_batch_add()).  Past the
> + * D-cache size, one whole-cache flush is cheaper than a cross call per
> + * page.
> + */
> +void flush_cache_vmap(unsigned long start, unsigned long end)
> +{
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	/* The vmemmap has no aliases and is mapped before cross calls work. */
> +	if (tlb_type == hypervisor || !is_vmalloc_or_module_addr((void *)start))
> +		return;
> +
> +	if (end - start > cpu_data(raw_smp_processor_id()).dcache_size) {
> +		flush_dcache_all();
> +		return;
> +	}
> +
> +	for (; start < end; start += PAGE_SIZE) {
> +		struct page *page = vmalloc_to_page((void *)start);
> +
> +		if (page)
> +			flush_dcache_page_all(NULL, page);
> +	}
> +#endif
> +}
> +
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
>  	if (start < HI_OBP_ADDRESS && end > LOW_OBP_ADDRESS) {
> diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
> index 70e658d107e0..ff190670a235 100644
> --- a/arch/sparc/mm/ultra.S
> +++ b/arch/sparc/mm/ultra.S
> @@ -242,6 +242,20 @@ __flush_dcache_page:	/* %o0=kaddr, %o1=flush_icache */
>  	retl
>  	 nop
>  
> +	/* Zeroing every D-cache tag invalidates the whole cache on
> +	 * Spitfire and Cheetah alike.
> +	 */
> +	.align		32
> +	.globl		__flush_dcache_all
> +__flush_dcache_all:	/* %o0=D-cache size, %o1=D-cache line size */
> +1:	subcc		%o0, %o1, %o0
> +	stxa		%g0, [%o0] ASI_DCACHE_TAG
> +	membar		#Sync
> +	bne,pt		%icc, 1b
> +	 nop
> +	retl
> +	 nop
> +
>  #endif /* DCACHE_ALIASING_POSSIBLE */
>  
>  	.previous
> @@ -801,6 +815,17 @@ xcall_flush_dcache_page_cheetah: /* %g1 == physical page address */
>  	 nop
>  	retry
>  	nop
> +
> +	.align		32
> +	.globl		xcall_flush_dcache_all
> +xcall_flush_dcache_all: /* %g1 == D-cache size, %g7 == D-cache line size */
> +1:	subcc		%g1, %g7, %g1
> +	stxa		%g0, [%g1] ASI_DCACHE_TAG
> +	membar		#Sync
> +	bne,pt		%icc, 1b
> +	 nop
> +	retry
> +	nop
>  #endif /* DCACHE_ALIASING_POSSIBLE */
>  
>  	.globl		xcall_flush_dcache_page_spitfire

Thanks,
Andreas

