Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020106.outbound.protection.outlook.com [52.101.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1B47606A;
	Thu, 23 Jul 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814444; cv=fail; b=HNA1ma35EFlgaWn1l4Mw2r9x4KZUDCmIVY3meZ+b3r4hLJvDQZuNp1ViaLdQ/+DMwOSX7jLAVH62EM/YKjBZg8O3+CvxKpdclWFrXX2hmCKiHFUBbpUszw5wXnsDwNCUcYYXkW42YNY8NZgKro0Y5nbJEqHfeizyFYshzfLhHFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814444; c=relaxed/simple;
	bh=W1ttP5ZHUy5sRwMjlxXHMeRylJVzuGXCRfQ3Csc4fgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IveKdqQLfzjJ8k6/piTZFG292EifD6umdAYgllS4NG87DBFdTtyBCN7pDfO9BtmpLb5XioHB5qNMo4THrSC9o2pTAcXgvkIHUtODGCg6KJY7YivBWariGXNjT9eeQIY5NA0EyHbGXXmXeRfYw1O6xvJDkcj3mD522ekfGtD052c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ga0dRTGb; arc=fail smtp.client-ip=52.101.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ga0dRTGb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJP+I0Ase6a7RvEA9sseWncxnFvAU+7BRVy4iQNGhKamQL1pQLMGIVsFqL+g94GZuZ1yCgYtaRAJypc54qsw0HHB+mpulhIQAcZQiWqz8b3w3WDrvNilNvYjO6LDCiJq0t2nhvqrHoUetHBtLVXh9dFojLk9WrsY81WSjdXTVx6Zbqy3pes+Uu9smZbzKk4dCywpUCGkXbMHFv0G35jRCm8zAXYlz/NCn7qBNcNhfylPEFP6wPsKjEkVw6e6A3GUd1yQ6ztsMe+8qEfQfg0QF8IX5Zzo8ptwEGQyLjqpwFomgQ1MjytV/bGQ+OJPraVuBaDNur4tAFrK0I/OpUQzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/GitQjcGH2mIiNI+a7xN9/s8PzYXfJ7Jl66civdlFU=;
 b=igF886IP/7p+FUY0KsVy20mIJxNThbWJ0j1U5Ygi4GJLtwx1g9k/01SDZxGUnbWkoa7K62yZet+45GKcAWbP3u0nEcz2MS0DVqJFnW1x3krs0SUpWsQf2pr0te1OXVkQ336UlQAu66b/TwcnpjhLLawnz1X0glPrG9el2QYwDzZ87XtUcFaeDtHEsfuIUyj1ffFVK8hBbh7q+DbKteIXUZJPnt62Ru/s7aGJBgAsfgOaX6vFmt/kTAy4N6HnVG55xIPaUcwINoFRjvVt7XwraU1LbjVhE6Hab/nfjE24rWDFDRa4tBlYlqLfATzONjgwGNjq7c9i8fqopSpq9vuX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/GitQjcGH2mIiNI+a7xN9/s8PzYXfJ7Jl66civdlFU=;
 b=ga0dRTGb8m0RVU3+Wwf6v43fdu9dgKwHG27YOdykGs09fOGaTkSEngv91XJZ3T8nseb9J7AjVgRRwlIvsEDdsIGAJ5NxINvlrU46IcdJ3xD2uq8oxpy5kWQuh7PEUHzmnT1UdvH1iWcUbixLWQENVCPKxmPnAgEekmo7cgj2qkPBSoj4wma211vTSpd8qZo7Aur11jhW53nWRbmerxQgKo+TR1KWzbfyxlzRx+jO6lCK8zB+Otg5U2x4rZuju0yhRHtGZZbFGkJph1p+huSx8s6NYiuO/LW4TwgYVBTWhamr5WpomHCS2UEfEu5f0hk8f4x/vYPWcGdhADY8zSKC1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5739.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:47:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 13:47:15 +0000
Message-ID: <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com>
Date: Thu, 23 Jul 2026 09:47:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: use precise current RSS for high-water accounting
To: Nirmoy Das <nirmoyd@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260723134158.1473841-1-nirmoyd@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260723134158.1473841-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5e595c-d220-494d-81e6-08dee8c0e7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h6TZp3sUszzVi37Zc21J0dz7w7HpHhfnGCua0FnD7XllmfvHDqa5FVrZFQu/XCXtfguu4rLOI5jHwapIahRiVJRCz2adcOZFW5LkUarE/NCIbxqStAT30U4zIpNhtoXGtCHoSa/PkB8zfd6cLVLOBfBIZBCj6Boq0z7wbSpKQ1bRQif6/3g80dvcJFHP1Zn8Bhl3ZAmwE0gZKUI60/jeyOKYq0hzycPUHPY4jz1iX3T2aguD5QPGtJTVgkMfs6YWH9gwTM+HVbcTJ8CccFzvomuWQ8gyPAGuug+ZXUPT3HZTaNk87U+KQxMHVHfczxpI/fNPnjLQ+aF9bKLDyWQy+P5ik88i/xCsdGQqzql4vv+P6d6j0GmYe1ZjzNjv+LEX8qMBRZlHWff/u1WgOs91cG20dIsdL2wEp3A7ZGk73pH2W0xt8up0XrVG88qKQZYIqQQUOROHSDy0vpdklrVZtHSYGi/ti+FoxM5VsCyLQQeCVQ9Tou4cZh94cETkvb9ci/oIyxPOZ7fjU3Xwu30hOptFSLvbXaB9iu0CdIyrW69RRyt2bX8XUZScCPLWSeWQi9FY2NRWD94r2r5VOlKooG2Hox8dJvP9Vfhn0NJuIrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0d0VVVlaDBQYTZwejk1aFlpTmpCZ1NXMzVtVnpRaXJrbHpIQWttRVhEKzYz?=
 =?utf-8?B?ajE5alFnOGJseHdpRjRqT1VFTGxldVRBdTZXNzJXd1BMZ09sWk0yYjVVdjBl?=
 =?utf-8?B?REZjbHhIVkhJSkpTT3RySjVaU0s4bm1zT2svdXlPMW9kaUFwVVNzaXdxRUsw?=
 =?utf-8?B?UWpXODF4a25RMUc0Y0VvT1RuYitESHArdHgxNFdRaCtSMXFJaDgxeklTbmdH?=
 =?utf-8?B?RzJGSXpiNjhob29SOWFzQzJjUXhQeDc2TDUrTHNaT0JCRWNRRmJxeXFEempY?=
 =?utf-8?B?Tm1OZ1hLMFBPSGxiQnNVNnE5Q1Z5alJySytBWVZkNVVJNE9rUHVXc2lKSmdr?=
 =?utf-8?B?dUhkZGZiY05QUlhIYU1LTEV3RGZxckp0VFlReXlUMHk3RG5heEN0a09SKzN6?=
 =?utf-8?B?KzY2STlacTMxdHhEZW9MSUpzZzhzMG11VmdMTlJiR1V3Wkl2Tys4QmUyY2Fm?=
 =?utf-8?B?NWJIZjBGU0pUQkcycDgzU282ZHlrc2FXK1l1b055cUhJdzFRbXMwMUdzVjBU?=
 =?utf-8?B?MWlDS2VSNVdxaERoMlprOGFGdG16bEk3MzhHRXo3YjNFYklQb2h0Umo5OGlK?=
 =?utf-8?B?d3h3ZmpZYnlidWl4eEU5cEpPMzB5OGFUTUhIMEUvSnF6bGVjTkJCUllPdDYx?=
 =?utf-8?B?WXBDRUtVUUNmYUE4eGIxYzR6RUhxRThXQUErWENvcFpGbm5DcE9PYkdnbjB3?=
 =?utf-8?B?VkQzUktGaC9sQUZEUTNuM0VOblI3UGRDdEFTRmtZNGJYRGhJMVRSZXlHSXBi?=
 =?utf-8?B?YWNNcDFEM3IxbW5YRWw5cjRsMktiYlk5b3hpeXdRL0EzMzRyVXRXelhIcVdW?=
 =?utf-8?B?Z0RpK3dpUzRoL1BCNStRZmtsR2ZoYkhxTmhhaXZucEFqUUZCNTd4YisvZk1T?=
 =?utf-8?B?eFlVMzAvMkRPRk94ekJrU29oR2NBa2Q1SzZOdUloNEdsSGYrMXNOM0lJN0tS?=
 =?utf-8?B?cFB6a3pURDZzN0xzK0krT25YSHNQSlNacXhPc1hyN1lLRHduV0dxOFdtbCsx?=
 =?utf-8?B?ZWo1MWk2TUJPZHFROUhvT3FXbFhkT25LOWVMZ0pTY211TTRQNExvNExUQnFE?=
 =?utf-8?B?ZXY5KzZyUGNzc00xWnExTGh0WVZNcENQZjV6ZVc0eEh6NytYSXBna2IxRnpk?=
 =?utf-8?B?dWpBQXlQa09aZTFRTTlmVlpUZlJRa3M3RllPV1JxeGhRTU1CM3NTZDh1RVB2?=
 =?utf-8?B?cmxQeWRVSGZobTdSdVozc0JHczlmSmpod3Yzdmx3VkR0TVlrbWcvV0tQVFhr?=
 =?utf-8?B?N3B6NEVFcVdHSjh6TjZ6NWlES1hoWmkxM2hFSjVVbFk1UjdZTFZoeGRUTE9F?=
 =?utf-8?B?VC9EN2wxRHloRFVGQld1cFVaS0JXeS9oMVE5NGgwS09UaHVOejkxK2RiaWVD?=
 =?utf-8?B?Z2tPNWdvUnhPM0x6b3ZMeXBvR2xmZ2Nzb0ZBbG5rN0F1ZGo1Y2NKcXN6Mndu?=
 =?utf-8?B?bmN2V09qUTBsaldiUkFIWWlna2VjeDVCSE1EZTlpU1cxSkE5NUJDRXpRamhG?=
 =?utf-8?B?Y09xWXM0blRkYjh2KzBFaWVsZEpoY29FeFl1UWFnSWZEWFhFY1YxblF0TXNE?=
 =?utf-8?B?dkszeERxWXZ2ZHJFK2dQMUJPUmRwSUZoMkdFZDhlamdNR0ZkQ3c3MDdOdldT?=
 =?utf-8?B?TkNaQXlQLzVtcTVOdGNBMWJvU1FBMEhHNUxzVmRUQzQ5eml2OWZ5dE8yRDhK?=
 =?utf-8?B?NUNKbjd5aS9PZ2U1SUozakp4Myt3dGZlT3RqaXdWNW5LOVhqQ2RLSjROcWlO?=
 =?utf-8?B?L1grSzZwS20wc0pYUzk1cUZUR0Q5OHYwZUczd3U2TTlNY0NMQ01HMUV2ZWJK?=
 =?utf-8?B?VjVjQldkbUVYTTlUYXgwd1lzNUNMdG1Dakk3REJab3VPcDlLakNMQmt6UHN6?=
 =?utf-8?B?Mm03clUwbTZOZUpMUkVlV3E5K2Q2bmhuUFQrMGdrTEZJck02N2x1a3Z1MVRx?=
 =?utf-8?B?eHJuMWpqUk1sNHJFbUNvZS9zSHp5YzJwaHYzaGF3dlZGbHhkQmc1OVB1c1Jr?=
 =?utf-8?B?d2F6MHVZcFpjdnJvRE5hQzVIWFM5eWRRQ1pWOG1kNnlRZUNTSlcvdGJBU0tW?=
 =?utf-8?B?RGNtaTdwV3NtZ1NQN2tJRWM4bTV2VHdmWXQrbC9QSEFvVm5rUkFsTkVGanVU?=
 =?utf-8?B?VVdraXRaT1psbHNIZDBaYzVjYXVCUFkxRWJrZCttTVFkOHFkZW1IR3NHK3ZS?=
 =?utf-8?B?cUFzSDk5enpDdWVweXFFdVpWOFFRK0R0TE1wd0hkV3E3Z2ZDdmduRytScC9G?=
 =?utf-8?B?YlRxTmxhUFlVZkZ3aWRkcFdKczgxa3F4ZE94ZnNaZnBRMUVZYkFWZVBZNi80?=
 =?utf-8?B?NnFsZ1d4TjMwMGpZS3BFM2dreFRKMk1KbEtXbFgySlFMYWVNb0ZXQytkSnZ5?=
 =?utf-8?Q?Ojnx3omgIosahcjUNEh8yLgj9//mV5/fMXq0y?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5e595c-d220-494d-81e6-08dee8c0e7a6
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:47:15.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2NHAtVKUYvgyZhqVJKvB9yieKpvWbxH5UtrZenmukdtibETilmGS/TdnPyJJ0XBPwxHIwOfs5qudIWuVP4mWstHNVlWwRXQjvPzrbApuVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5739

On 2026-07-23 09:41, Nirmoy Das wrote:
> get_mm_rss() reads approximate per-CPU RSS counters. On large systems,
> this can under-report the current RSS used for high-water accounting.

Did you compare this with my hierarchical percpu counters series ?

https://lore.kernel.org/lkml/20260707131544.75906-1-mathieu.desnoyers@efficios.com/

I've sent it to Andrew two weeks ago but have not heard back from him
though. My series attack the same issue you are trying to solve without
increasing overhead when reading those counters.

Thanks,

Mathieu

> 
> On a 352-CPU, 2-node system with 64 KiB pages, reproduce with:
> 
>    sudo -E env LTPROOT=/opt/ltp \
>        PATH=/opt/ltp/testcases/bin:$PATH LTP_TIMEOUT_MUL=5 \
>        bash -c "cd /opt/ltp/testcases/bin && ./getrusage03"
> 
> The test failed 10/10 times with child.children=270336 instead of
> 307200.
> 
> Use get_mm_rss_sum() when reading and resetting high-water RSS. Keep
> update_hiwater_rss() on the approximate path because it runs before
> RSS-decreasing operations.
> 
> The patched kernel passed getrusage03 20/20 times. getrusage01,
> getrusage02 and getrusage04 also passed.
> 
> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> Cc: stable@vger.kernel.org
> Assisted-by: Cursor:claude-opus-4-8-thinking-max
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>   include/linux/mm.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbddb..1b613c6356baa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3405,7 +3405,7 @@ static inline unsigned long get_mm_rss_sum(struct mm_struct *mm)
>   
>   static inline unsigned long get_mm_hiwater_rss(struct mm_struct *mm)
>   {
> -	return max(mm->hiwater_rss, get_mm_rss(mm));
> +	return max(mm->hiwater_rss, get_mm_rss_sum(mm));
>   }
>   
>   static inline unsigned long get_mm_hiwater_vm(struct mm_struct *mm)
> @@ -3429,7 +3429,7 @@ static inline void update_hiwater_vm(struct mm_struct *mm)
>   
>   static inline void reset_mm_hiwater_rss(struct mm_struct *mm)
>   {
> -	mm->hiwater_rss = get_mm_rss(mm);
> +	mm->hiwater_rss = get_mm_rss_sum(mm);
>   }
>   
>   static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
> 
> base-commit: 4539944e515183668109bdf4d0c3d7d228383d88


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
