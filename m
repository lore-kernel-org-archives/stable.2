Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021100.outbound.protection.outlook.com [40.107.192.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46269339719;
	Thu, 23 Jul 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824274; cv=fail; b=Mb5qWYO1Gbkrwd7hpCcISNOYTbM6mQzokWBTntC9WkorAIyEMtc4Jn4jkg4356aJWcj7tfpgmrKabLsbkULhZHcrWsCrr9eY+wrUin1r9BCC47mbmLJH4fCe1Q4G0y4LXeVfVMctDTXJl4Vt2KqxyEVrv+1ZgoUjmacPAbUkrBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824274; c=relaxed/simple;
	bh=GRHxMepTg2yyBBPYyzuyfvKRZWJO2fvbZWfUE5jfEAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EIvGGBhWYQQtuuTCYy43kw4ujmRV/W7ME5nJhZdv4e/eCwDn8YH5WMqGFNudV7w4EztOI9G4zsEmlgS8QjMP6GNtNGIh1vH6YqzGwuwklk+Lmx9/DVZwJRDzLkn+7RRpSkwH+foAYxORUX3TXDoQMvo/yIwKqzfNiAb85jRb5mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QRO4IOjK; arc=fail smtp.client-ip=40.107.192.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QRO4IOjK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1wK6/VThhrGM963CPwOaa0g9pSvvvat+Z6Xi/QE6pYTFjlvSN0AIywzZqEgvItMoXWGdeZtn4jKInEFNmXtOQ1GnUs7tmEx8Zz+VRpyFDFKhk1cfSf5vVF2MI9c919EdJySJ2xt8uzqP13IBC9mmQw86hkqCunYekMmU7afHkDCn8AMk5SucYw8f+PawDFUbWiKx3lAoiDqfhN0kJJnynYzt/UjN1emJWrAzNqcdBVCz79QSUT0pa4w81evLgT9rP/b/9CLvD9B5Y1dFKra6vrNQ5SloMxhd81zE42Nw/ZvbpgzeM20AsiwtvxJRCuJbQN2XAqt9Tt5afDKG5R6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzWKzHlmja/0Yoxzu+YbLBg1CWSDZsx6bJjsHl890GU=;
 b=UKCz2Kxz4O8BzwUNjJPmoMVuPEfnEZT64/VVjQdlXbbmz8Z5RM6vG4tnwLunUUnx7qMg06C5kBrB2Hxrc2TPq3EJKJqaMmhH5Kej4HKz0kt5NoTA/XsCsN7Xph+8lHxnlN0H6A3kho9OqafbBao41pWqi1uZYPOOfnQ1fif3ajkjWoPGcxY6bmiSA7YBzYGhx4rS8c7IVKaDQPfu06NSBCYTrlx0eqqUIaXqBx80NLWjYDDt/mbhBe0B7ytSXybQHDKfLZo314ozvOugOKNQwIyJ3JTIRUhKnIpkftLzOKZ4+O3+cZ5sDcRDSKmNTL707vyC4p26lYXYCzvUd6Xs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzWKzHlmja/0Yoxzu+YbLBg1CWSDZsx6bJjsHl890GU=;
 b=QRO4IOjKcvj9+b1gyu6fjs6Ot9803Ve4DQKmxg2QoPauoTut4fhD33bc7HAT7ggFzMSStX+irC2a40eGE0c3Z+U0cV/+NpIRBW1PU9CGDKUy6I2/iPrupZ+8tHatDomGw6pnwrQM+fohPAAxgQhFs81IF2YRC4fjEkr998k4kqPFZgngMHUskpApyBzv7Y1dLy1Qvg4n0XGPuX1l4PhaZg13jc/853JAnIXgv54oPwvEDbD9jjGP0D24+U1u6T+qyHoZ03YAp1SsG66Cc6p0vBnY0blwuFQBFSjLV/LmI/mvd7YHlljBLbCIAkIG3rpvFXQRZhQyRlrfwMNfpeP9AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10692.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:31:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 16:31:05 +0000
Message-ID: <21d24fc4-141d-4957-8b96-6d5887ef4027@efficios.com>
Date: Thu, 23 Jul 2026 12:31:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: use precise current RSS for high-water accounting
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260723134158.1473841-1-nirmoyd@nvidia.com>
 <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com>
 <20260723162133.877125-1-nirmoyd@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260723162133.877125-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10692:EE_
X-MS-Office365-Filtering-Correlation-Id: d58e9a39-32ae-415d-b1b5-08dee8d7cab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r/9+T9PjITeFuYad5dJdLd39TQ34uXMUTzGcXkfYU7dF7hNFuItBIt2En/9+PTpRLhMc/Q2YNKEOHp2yj7EjhfDA8FDt2ajoZ0PPXrpKOwZncqKPp9lNkgfYIQlul0EYhQKDoFxEKsM6WUgVM3lGamPEgJm/z5uW25u7juV8LezsXAlmbNTeyGOE/UJQp+q00gC+9aELE8mh0RD0z6e2/dpnPxnsbWhqfofgVaVa1RKHLS8bUG3wd4g9gg6Y7oFnsJhelYljVUN96g3+GsGftVYX4r6BatnDh6EEZqufRXnGyCseU+6V2BM2EtFkYbbswgIgSBuRDEiUmBhxDRMusFsv16z2hJznGR+9VTu5Cderc15X6M9SV8KJG6CZJ5tUBiiGRG7hAB+HRfI9U3RkaWanaWWf3OZt0bl02L1Xlh9cftbYwcAwZjVwW6xf3xbSqvZZ1ovKoBtBD46myay9esdHEyQGku0JOhyGsfz23jEkv/IAyhO651XzxICe12kVyc/Mk9c8l1b/Ei0lWN2BIyeNMNNNi/VdmFb8Z86OTsYcgrwi3ZJdvzH5A++fTBoEHcK94itZnUpEDMwEhgqVgq6VubInwowh3cI59gqTYTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm9JaXZOOERaSk5TUnRQdFg0L0hkTWtiZ1laSEtEUUZCMS8zdDZzQVl4WXZZ?=
 =?utf-8?B?VnlLdmNHT2JzNE1tbldLbVlDN2VQSzhHTTJqQ3hMdHI2MktaSXBjZmhxd2Jy?=
 =?utf-8?B?V2RLVVpTOHIwTmRyVXFZc1ZiZUo3ZE1kSW1vOWU0NEs5RlBlZ3pKV3lWUmhk?=
 =?utf-8?B?T1NFa053dmMxL1VuUkRjVDdocnoxT280ekZheTVMRnlkQ2NPRFlLbGNlKysv?=
 =?utf-8?B?MXpXOEU0WDBzQmZTcXV5WUdzSFVVSDlNcFNpSDZZaGxFVGtpRk56R0MwZXMv?=
 =?utf-8?B?RGV1bU9yeFZwdGVlN216M3AzUFJoN1FXZkxiNWwvVFpnMTJnR2VuZk96SDkw?=
 =?utf-8?B?aGl0VGczSHkwdzVNdHQ2blV2SjNqLzFOUW9GeUYxUUJ4WndhZDhBSFgvamlX?=
 =?utf-8?B?anVld2JuZkhkNHhuN3lDRWJRUDFXdzdMV3NYM0QwQ2hLWlBJRnNuSVgwQ2RF?=
 =?utf-8?B?bGFFYVJZbkNLZ0V1QjZsZWpaUmVqdU1ZMDBublhFY3ZUZHo5N3gwbEpLRktO?=
 =?utf-8?B?ZTlVZ1hjUml2SzNWKzk2UTBwZkhHTlZSTzRlKzBMS0htbXl3bEVCVnlLT2ZE?=
 =?utf-8?B?THdlRVo1cVJ4bTFKR3F5MWM4QklZbEw2VVlPUUM3eEcyZm5YR0JObG5ZK2Yx?=
 =?utf-8?B?cmxhZkx1Qy9CTklFTTZ1WGlYbzQ1dE11Sy92cm1wTWtybHY1b3o4VWt5WS8v?=
 =?utf-8?B?RVVUay9GNW51ODJCbGV3V1lra29lY2JSclN3aTIzMnI1MDlTUGZtcC91Z2dL?=
 =?utf-8?B?MlRuMkVsWFVDZFBFK0NjTHl1aS9xZkVOaUNlV3Jmc25zSEM3R3JDcEwrQlRh?=
 =?utf-8?B?OHpoL3NyWW1QL1RNVmo2NXY5VVhqM2VEcEIzZ2dtT3NGcDZ2Q0djR2lEaUtz?=
 =?utf-8?B?R3hwVDRpQVdOK3JhREJyV3Zad1Q0SHhSMXJtOW5QMzIvZW4xbTFsQ3JEL3Zx?=
 =?utf-8?B?ekFTK25pT1l3LzZ3ek1YMVZtYmROS1pVa3ZRM08vMDA5cTN4a00rblp3Tzd1?=
 =?utf-8?B?cHBGUlA5WGlEOVZuaWtqSFdHcHdmUEJZYTJINThsSjlGZDdGL05IaUM4OTFT?=
 =?utf-8?B?TFlSL1BoZm1PdHdVbVUrSjdNSGVVaXZyeUpMdzVRMmJmNEErOGNhc2UwWnVx?=
 =?utf-8?B?SVFPS1V4RmR0WTJsNENEbGR6NFJvOUxhM0VnSnFSZnE0VGZVSFFrVUlCYXV3?=
 =?utf-8?B?S3AvVUxiQWNFYnlBQVBxUGhQcUMxOWpCREx1NU5MSDVYaHBJQzlPbFJMSStH?=
 =?utf-8?B?c0lJVlJNNENSUS9MTTRaMWRtRFJlaCtzNzRmU2JCUGVWNGlOdWxVOG9TYUtl?=
 =?utf-8?B?VHdOT1UrWXZaUFR2M0NkWFFOUlRvY2dFTlZhMWZDcG1CZW1OR0VVNHRlZ2Vl?=
 =?utf-8?B?ZlExdk52Z3oxZ04rT3J2S2hkRnVSQXVBMDBKSHFxS3RkeWRMbnFtWjQ4YkhM?=
 =?utf-8?B?NzBQZ1lEcVovbnJFSmVTR0FCQUhnU1Fzc0Q0Um52V3RnSUpqUStQdkFpR0Vw?=
 =?utf-8?B?YW0xQk5wMEg5WXNRZ25Sa1JMb1dzd3JlWUJpY3lBeFBhTml6eE9lNkJBVjNM?=
 =?utf-8?B?Umpld2dvb1daTFhNT203SzlMZmlVcnV1bG80NXNiQ2dDdk52T2JtRVgxRjJa?=
 =?utf-8?B?YW5OZE9tMm1ydjF2a2xSMkZvSXhhYllmN0wyR2dzVVMxdHlyRGs1YUk2YUdJ?=
 =?utf-8?B?YVZYbGdpZWVzZW5XR3BsNDBkaUw0TmM2a1dHbDFnbkpMQ3oyZnMzbjZCUzBS?=
 =?utf-8?B?c0dhdkppV0trL2x1Rkl0U2dMMVdvaFFvRWYwbzkrUm11QVZTZjcrdjNKdEgw?=
 =?utf-8?B?NlJja3JpbFlhNDRNa2ZkU1FOYnhJSUlXRENJWnlvbm02eG9nNkkzSUVhS0dk?=
 =?utf-8?B?dmhPYUk2eTFJUFQ1aXpHeithbFlPNTA3b0RscUlEWlRSalBseWlVaHVlT2Z1?=
 =?utf-8?B?VEMvb0x2bU1HdDE4TXVMaDVYcTBtQy8zL2pQeExIbTREcDRtQm5rMW5qUVlr?=
 =?utf-8?B?UHJKSS9RNzRYOEFqcjdLcjVTU1lNcTRlVi9UVWk4ZEFGY1dYS3F4ekhWelV4?=
 =?utf-8?B?ZXovdFl3RTV3Q01MNElHMVozelZwd0FwcmU4RjllSmJ3WmN6aWduSFpseFRm?=
 =?utf-8?B?NmNyMjN3Z2NDblBReHNsVEFQQi9HREJ3L21JL2lLdGdlaExwenBKbk5DdzJ6?=
 =?utf-8?B?cDBhWEhIV3p3V2hsM3paR0Q5cFlYQUhRNGpwOWI0UEVLc1ZTSWdJYjBFSGR4?=
 =?utf-8?B?Sll6a1FtZWc0N2tOejkxMWRCZDMrN1NDclNPZzVValhMdGlrQi92RG53bjJ4?=
 =?utf-8?B?MmpJY0J1Y01WbWl0VTFSTUN0TGhDbTFNR2RXQ1QyMmZpNmpUQ2JzbWVaNDZJ?=
 =?utf-8?Q?7pWWApyWLIc1QJONiFtAKyJtLajkNpPgnOlhq?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58e9a39-32ae-415d-b1b5-08dee8d7cab5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:31:05.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNHNPqwYLYL1xKIrK0VjAskxQipwhoKkYQUEaMyFjWPOuQGUxNycuwsA+uQuXRU0pmQ9xx8tAGq/TpXt3V2i4CSJx2BFNe+HBavdfPOX2CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10692

On 2026-07-23 12:21, Nirmoy Das wrote:
> Hi Mathieu,
> 
> On 2026-07-23 09:47, Mathieu Desnoyers wrote:
>> Did you compare this with my hierarchical percpu counters series ?
>>
>> https://lore.kernel.org/lkml/20260707131544.75906-1-mathieu.desnoyers@efficios.com/
>>
>> I've sent it to Andrew two weeks ago but have not heard back from him
>> though. My series attack the same issue you are trying to solve without
>> increasing overhead when reading those counters.
> 
> I tested the v20 series on a dual-socket system with 352 CPUs and
> 64 KiB pages.
> 
> On the v7.2-rc4 test kernel without the series, getrusage03 failed
> 10/10:
> 
>    TFAIL: child.children = 270336, expected 307200
> 
> With v20, it also failed 10/10:
> 
>    TFAIL: initial.children = 0, expected 102400
>    TFAIL: child.children = 262144, expected 307200
> 
> In v20, get_mm_hiwater_rss() still calls get_mm_rss(), which uses an
> approximate counter read. The series did not help this test.

Correct, my hierarchical counters keep a approximation there, but is
improves the accuracy of the approximation (worse case inaccuracy
limited by the topology).

What is this test validating ? Does it actually matter for a real-life
use-case, or is it just the test being too strict ?

What is the overhead impact of your change from approximated counter
read to a precise sum on this /proc ABI ?

Thanks,

Mathieu

> 
> Let me know if you want to me to try out something else.
> 
> Thanks,
> Nirmoy


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
