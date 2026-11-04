Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793823499;
	b=O+kacqcYRtkMwubQee2YIwrHciREOgoGLL4vhQl6toarbFVd/My2TiDleY74MLVp3atq
	 QLn1NN/HRfWtY8g7oDT+56OnNH1/kyE7DT8hfdq5g7znPWG0+oJ2n9I/EWculfxH+WQWl
	 jaPjjmZRtdfF31PayTM+nsw/xcbFgcVCQFkiaaSII8GAPGJ8nmlNYUzsUIjIGLr9gWtJ5
	 PixWhOkehbs3DVg85ojIE2KFKrpR1YIxAnnVbrbLph5f5ApgOI5t38K5PR16m1ScoL9q4
	 +jzdKMXr43ft4EFfr2FI7ro/U/9rbusMIK6BQkf/T3JESDEKXoS56V6NKqoYYBPAGZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823499;
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
	bh=nLmDsueMVrXj3IDwodiC8FCbyZvBkd6OEfIHAU/Py8s=;
	b=wOx1HqHpNxZWrVO5ngTje8NuLDQGMgdaJBeXF94O+gNiM/5wcWc23kgAjZLoFhtXTILr
	 4B7FiFNDpqMpng1lFgWg2z5SF13WwfVjlmE01PtWdONDucesnaL6KQtcILwvoaVG1cZZ4
	 cS09sHo+9kNMo/phC1jDQAWOjpHal5xXb+EXwlvMvnnCY3xQxhKyXpCpk5+pBItpUVwTI
	 cK7fhwu5tUhvBGm4J7HAjk6zKNUVB8IetfyPMzgv6Yp5rNpCVJeh1cUAShe4tqEbXrIxu
	 NenPIFZzNPn8kS0kk1V3p6tdwcfCS63xW+6dInD4+4Z3UtxrnqMpkHcdGofkph/0B+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LGfwLUS4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.22
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B209606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B209606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LGfwLUS4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqP2OR7hbhuVk8me9nXdKoECzuN2fW/z6PJkdT75rTtBT6fCvz7GUG66Bw0QcXLQY2uvcymkgCUL7JiOjeIPXe4mVUk5qHnm2yKaZIN8sxh8Pp3p56jSmnysiExM8nHk9nr4JE988VAJeeauqgIvZ5umx3sZpkw5YSu3k9UY02sVq1klqFTqIeDUlHLS5UGd4M01CYzOQUKCAd9vJHfK6Vt304+uTQq9Rji38TlrZ95BB9k1ObIBaaVShz/fMOuOOqXg4tCagHbGIves7VSGHVUmdeHw+Br1JuoanYQvp9cceZ3YfH2N0WsqWlrfTNcqQNwpzQCPtfyyWh7Irpcl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLmDsueMVrXj3IDwodiC8FCbyZvBkd6OEfIHAU/Py8s=;
 b=PSPcTVbgupFoJdgR5fs8Yq2+NHdvbIqXlNg2zFZfkRwpP79Lb90B3FUKcbV2fzBp9QeiYeBF8gmSC4xwTXMtZ5iALTRajjpUHxGoI0k7wbubz5EmAwOcn1Lpl2cS2HKHaTjwHt53O2Ls5Jlr5tpg+X544zj9VBt5IbjWZ9+5RMmkFY9VpteMmM3CGiWpQxPx0JwgzNsbsACUy7qLOlgxPeSVDHCX18Rab2OJRHvn9SU9Agp7n5KLy30oEpOGJ5f1pQDuU+3tmlWxk7JolfLyFU9oGKknTdchbylL2q9vk7Z4+PlFZrVRqwdy2bwIc/c90ffUj6+yqs9tkTXH+tRmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLmDsueMVrXj3IDwodiC8FCbyZvBkd6OEfIHAU/Py8s=;
 b=LGfwLUS49G1XLNXpxOoSkUg2j/FoQOvtV6LtKTHUD0zvKdUXQTm1hxruEiTgg14rvd6RIPxp38gg3DfJSRESE2ApOBlqwAGX/jTreaql3j5fOMAZqOacQPYfNbmm2//VlqAnn7u40sWFyDcBMcDHgedSL0FpB/QggATGR8ZVPfE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 by LY0PR12MB748257.namprd12.prod.outlook.com (2603:10b6:404:21b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 20:18:15 +0000
Received: from MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321]) by MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:18:14 +0000
Message-ID: <887db5ed-9d8a-4930-b959-193eac04c7ce@amd.com>
Date: Wed, 4 Nov 2026 14:18:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix __udivdi3 link error in DCN6 DML2
To: ivan.lipski@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Linlin Yang <yanglinlin@kylinos.cn>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Dillon Varone <dillon.varone@amd.com>
References: <20261028151111.1888807-1-ivan.lipski@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261028151111.1888807-1-ivan.lipski@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To MW6PR12MB8705.namprd12.prod.outlook.com
 (2603:10b6:303:24c::18)
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
X-MS-TrafficTypeDiagnostic: MW6PR12MB8705:EE_|LY0PR12MB748257:EE_
X-MS-Office365-Filtering-Correlation-Id: c7189fd7-45ed-4ab8-2c9b-08df3ab0c169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9Jme8aRfHB8vunQ3gH0NTB93RyagKD8XMID5qTG+ho783sL4ZWC98saFt4lF315QJyYT7REE7J2pRUQNmuVeXmNUSPD8i/nSf0Tg6Pj0sL3aGiw6pRfoZJ+dK6RGhQ2MKkHBf94Rek2znwp6tPb2kFQrO5AWDLXdQkcrsPMGsLHISdjZKePTyRxEh96R4rdJN/4Lk+OdPN8UG9TXr1XfzmqoB4Sy+yFEP5YCof0v0gBaYiOj3TMsV3V+snLVXZQguoHg/fvUYOQYQ4HkgniAvHxMg47i4tfXxwWI50DOymtWlkCDMYWvxTnKUDvBSMcZ8i900ws8iqokJwn24XHi9yvEHqUZLFS98aYxe+1F6x6Y3EAmJuvFx6U/VE8E/t02ih/EhcPI7IVMxHw5K3Ic7XvtlX8ciL0nevd3xS4PLYM5ym4Q3Wpzc/xRA40CkRH/2xudjFRYzjV0R6VTadjdtz0hHKwKFxDuYdi5NvRUwnrUkMHyr4QgnQXdiLA9SFefuhleeF7GbP1OyY18XLKoNVjtn09xAH9gGJl0C/+frp1HKoQkEN09aeTJSIBO9nqIl4XIUJq75ffsOcux3fJ55+YCbfgX+3A7aC7mU7iPLi5QbT7jyAJIIOuu472gcbPyG+kdfrwiZHqgLX7uq7mWzMLBURFz3ba0yD9kpZ6mvHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmRHMVk0T3A2OGpsMFZ4VTRjeTFwKzFBLzZmYjRTRzZFWm0yNkc3Qy9tYlhJ?=
 =?utf-8?B?NkhQSUpaV1FUSTZVOFQxRCttTXZBb0hZejBQV2JhZ3VsbitUbGluM3Y4cVZh?=
 =?utf-8?B?OTN4Rk9rQTJnY1BQZDY1N1pDMk56UXBBekltMndQb2VNd1RPdXMyQXJyMlMy?=
 =?utf-8?B?amNuUklpZ1M2dk9RREJIRFYxVENIRDV0OTl1Ynhway9UbzhEZVVqVWw1N2hG?=
 =?utf-8?B?OXNqT2ExbU1OeVFJNXYxUktXZXFTU0wvL2ZaWlZ3Mnc0WUpnZk85ckVjWStQ?=
 =?utf-8?B?b1hFbDFNZ0t1RVg4ZHlOdlJmTUlsc0tHZE9RcUdZWnI3Y25LOGFVc0pITXVj?=
 =?utf-8?B?alRNMHgreks2bFFEa3drTWQvNjhzZ0NHSFk1czlMdjFFVEFlMnBEME1ZS0di?=
 =?utf-8?B?RjdXdnN1VHdmc1V5bDdqZ2RXOFpZOFZIa3lDcUFGVnZudTlSTVFIM0toUzl0?=
 =?utf-8?B?VFVXY1lkUyt5NHRsVWRtYzNkUnhIT0xnT3hpT1FQdFVoUDBRK1pMVWdnWTJy?=
 =?utf-8?B?RzArb2NZVG15S3BXWi9ZSERycU5QVTQxc1FrdzBLWHlmNWpMczFyeUlnL3R2?=
 =?utf-8?B?dUlSaUxJUlNabUpFTjQ4YlVReWpqMUl3aXVGZVkrcjZicFI3d216ZmpNSUFz?=
 =?utf-8?B?THdLcFlQQnBoaVhXTnNaaWY0NGFGUkVVN0hNK25BbmNlYUpUczZmZWkyMVFE?=
 =?utf-8?B?MTBueGJGWFJPSlpGSEg1S1llQUUxdUF0clBUQ2tmb1R5VldGa2RiRDJIdWxX?=
 =?utf-8?B?ZkdVMFRaenZwajJhbGpYMXdEZVNlYlJGdHRGU1VuTnRvek8rRE12VExydFpK?=
 =?utf-8?B?bHNnM2Z2bnVvNyszZmFEZ2hoVWRtcTlGOHp5QVlIeXFLN3ZUL0JmOWRNVjcx?=
 =?utf-8?B?SlQ0dU5hM0ZIU25DdElUNGRKZEFDQTVyZTRkRUlEVkRXcWJuS0U1WHpkeGNI?=
 =?utf-8?B?cERjdWY3c2swZFdNOXRhaXp2a202eUhnSHJOY2ZJYW1WODVyWG1WRkRPelBJ?=
 =?utf-8?B?Y0xNNHlPa0Y5Yy81MG4zWmtEQTdkdkovQ3A4Q3E2YVJrMmh4TEEzdHh1WFFQ?=
 =?utf-8?B?K1ROTXRXQThyMjhJUzFlWFZScFJ4UXRKMFhDbzdFck5kMUgzMjlhcmlEbC9D?=
 =?utf-8?B?bVdUT2U0OFhYaGtha0I2UG5hRkdEbkVYenFML3hsa0hmRmhIQ2tubm1QckpX?=
 =?utf-8?B?SllVNEk3aHJlY1Boek5kSi9iNlZkZGhQTmJ4Q0g0VFovbURzQ1pySWV0Znda?=
 =?utf-8?B?bHJYZVUrcHlPblJ2NlVScERNeG9VVzV0MlVxR3JvVEZRZ3JPc1BJSndoUk12?=
 =?utf-8?B?SFpaNmF4N3A2bVJqcUNqQklGT0tzT1hxKytXdFYrenUzRTdxRjNQRHpkRnVz?=
 =?utf-8?B?QUNvQzlMcEJVcjlwY1Y2Z1VQN3laUFMydG9IV1Y1bTRvZlhxNFlKNU9jMU5V?=
 =?utf-8?B?cURVeitKUlBrWkwrNGxIYm5Ralp2Y2pPUVJJWWlRNlU1WFJnaHdIcTZaMEla?=
 =?utf-8?B?clVaR1FNR1MzS0VuVHNIdnpzNUFYYjd3dzIrUnZzQUpDLzdiZVA0Rzk2TkZw?=
 =?utf-8?B?MnhZZVhHbTV5aW5HdnpxcGpYejRWa1kyM0NhazVXdjBZbWJ1Y3M5bm1zMG1y?=
 =?utf-8?B?Um9XSmpjKzA2UXlBUVE5VTREMnd5eEtUNmxTblR5elBjN2t1ZWRCZTMyakVC?=
 =?utf-8?B?K3VadzNyRk5WU21kbHVzMU9VQVFjUEtBZ3dKR0JmOUFZSDdQYktqaFhZcHdS?=
 =?utf-8?B?MXpaRC9CMkpQWk5yMW0zVnNNZU14bEhOWS8veGFsVjVlK1N5N2w1b3ErcVRy?=
 =?utf-8?B?QndXZHJFUDBta3Jubit2VWpPOUIydW9ka1dwcitDbGNZa1oxS2xacmhhMk81?=
 =?utf-8?B?b2UyV29lSFRVSXN3TFJPRXdLblR6bUVPNnlqb1lBejVCdENEY2ZNWlRNanlF?=
 =?utf-8?B?NU5EZXErUVhqZnFyVVBtenRZTjY1TWJ5V1ZoYk5ZbEVSd29XdVFkcFp3ekpz?=
 =?utf-8?B?T3NMZDJWdHVrMm1wN3JOQk1SOFUycnpaNU9wZUpNbi9NZVdDQmU5Z0ZvSVR0?=
 =?utf-8?B?NS9nbEREYkpWWlVWMXNzU3dCTW1ycXVVWFNUazhJdXBVbTZURjNoUXRCZTJC?=
 =?utf-8?B?ZFVrNTJrOUdiUnQvVnM2WmZQdG5JWEZQZDduNkw5U3ZoOHFhTDNRMkJNU2Q1?=
 =?utf-8?B?bDVSOHh5Z1BaaHpHTU50SFBSV2s0a044ZC9UeVRaLzBpZFU1NFVtemkrVlNk?=
 =?utf-8?B?d1hLVnAwdFZldDl5R1FrV2tpZGN4VWR5bmhJczdEU1RlRkR2cmZuUmkyZ3dU?=
 =?utf-8?Q?xTx40HFdNfUtq5Jvfm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7189fd7-45ed-4ab8-2c9b-08df3ab0c169
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:18:14.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AyngJCkL10wPfMBUV9YbemP1rcI+IQbX430u/jWvkuZHBMMiTVYaYSrbrctqG9L8IC9HXDtELkMWFWRc4OpSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB748257

Some minor nitpick as below, but lgtm

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/28/26 09:11, ivan.lipski@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> dchub_v2_get_sop_total_available_bandwidth_KBps() and
> dchub_v2_is_qos_bandwidth_supported_by_sop() divide 64-bit integers
> by 100. On 32-bit builds this emits a call to __udivdi3, which the
> kernel does not link.
> 
> Use double-cast division instead.
> 
> Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
> 
Please remove the new line.> Cc: Linlin Yang <yanglinlin@kylinos.cn>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> 
Please remove the new line
> Cc: Dillon Varone <dillon.varone@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>   .../bounding_boxes/utm_qos_model_dchub_v2.h   | 32 +++++++++----------
>   .../bounding_boxes/utm_qos_model_dchub_v3.h   |  2 +-
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
> index ebca5ddda2848..32049c17c0802 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
> @@ -58,27 +58,27 @@ static inline void dchub_v2_get_sop_total_available_bandwidth_KBps(
>   {
>   	const struct utm_soc_operating_point *sop = &model->sops[sop_index];
>   	const struct utm_qos_model_socbb *socbb = &model->socbb;
> -	uint64_t dram_available_bandwidth_KBps_nominal;
> -	uint64_t fabric_available_bandwidth_KBps_nominal;
> -	uint64_t dram_available_bandwidth_KBps_urgent;
> -	uint64_t fabric_available_bandwidth_KBps_urgent;
> +	double dram_available_bandwidth_KBps_nominal;
> +	double fabric_available_bandwidth_KBps_nominal;
> +	double dram_available_bandwidth_KBps_urgent;
> +	double fabric_available_bandwidth_KBps_urgent;
>   
> -	dram_available_bandwidth_KBps_nominal = (uint64_t) sop->uclk_khz
> +	dram_available_bandwidth_KBps_nominal = (double) sop->uclk_khz
>   			* socbb->dram_channel_count
>   			* socbb->dram_channel_width_bytes
>   			* socbb->dram_transactions_per_clock
> -			* socbb->dram_derate_percent_nominal / 100;
> -	dram_available_bandwidth_KBps_urgent = (uint64_t) sop->uclk_khz
> +			* socbb->dram_derate_percent_nominal / 100.0;
> +	dram_available_bandwidth_KBps_urgent = (double) sop->uclk_khz
>   			* socbb->dram_channel_count
>   			* socbb->dram_channel_width_bytes
>   			* socbb->dram_transactions_per_clock
> -			* socbb->dram_derate_percent_urgent / 100;
> -	fabric_available_bandwidth_KBps_nominal = (uint64_t) sop->fclk_khz
> +			* socbb->dram_derate_percent_urgent / 100.0;
> +	fabric_available_bandwidth_KBps_nominal = (double) sop->fclk_khz
>   			* socbb->fabric_datapath_to_dcn_data_return_bytes
> -			* socbb->fabric_derate_percent_nominal / 100;
> -	fabric_available_bandwidth_KBps_urgent = (uint64_t) sop->fclk_khz
> +			* socbb->fabric_derate_percent_nominal / 100.0;
> +	fabric_available_bandwidth_KBps_urgent = (double) sop->fclk_khz
>   			* socbb->fabric_datapath_to_dcn_data_return_bytes
> -			* socbb->fabric_derate_percent_urgent / 100;
> +			* socbb->fabric_derate_percent_urgent / 100.0;
>   
>   	total_available_bandwidth->nominal_bandwidth_KBps =
>   			dram_available_bandwidth_KBps_nominal < fabric_available_bandwidth_KBps_nominal ?
> @@ -99,8 +99,8 @@ static inline bool dchub_v2_is_qos_bandwidth_supported_by_sop(
>   {
>   	struct utm_qos_model_dchub_memory_path_bandwidth_v2 available_bandwidth = {0};
>   	const struct utm_qos_model_dchub_v2 *dchub = model->dchub_v2;
> -	uint64_t nominal_available_bandwidth_KBps;
> -	uint64_t urgent_available_bandwidth_KBps;
> +	double nominal_available_bandwidth_KBps;
> +	double urgent_available_bandwidth_KBps;
>   
>   	if (nominal_utm_budget_percent > dchub->max_nominal_utm_budget_percent ||
>   			nominal_utm_budget_percent < dchub->min_nominal_utm_budget_percent ||
> @@ -112,9 +112,9 @@ static inline bool dchub_v2_is_qos_bandwidth_supported_by_sop(
>   	nominal_available_bandwidth_KBps = available_bandwidth.nominal_bandwidth_KBps;
>   	urgent_available_bandwidth_KBps = available_bandwidth.urgent_bandwidth_KBps;
>   
> -	if ((nominal_available_bandwidth_KBps * nominal_utm_budget_percent / 100) < qos_bandwidth->nominal_bandwidth_KBps)
> +	if ((nominal_available_bandwidth_KBps * nominal_utm_budget_percent / 100.0) < qos_bandwidth->nominal_bandwidth_KBps)
>   		return false;
> -	else if ((urgent_available_bandwidth_KBps * urgent_utm_budget_percent / 100) < qos_bandwidth->urgent_bandwidth_KBps)
> +	else if ((urgent_available_bandwidth_KBps * urgent_utm_budget_percent / 100.0) < qos_bandwidth->urgent_bandwidth_KBps)

The changes from 100 to 100.0 aren't neceesary, but it doesn't hurt.

>   		return false;
>   	else
>   		return true;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
> index 9390cad316914..fef7b1dc3060b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
> @@ -50,4 +50,4 @@ struct utm_qos_model_dchub_v3 {
>   		sops[UTM_QOS_MODEL_V3_MAX_LOAD_LEVEL_COUNT][UTM_QOS_MODEL_V3_MAX_SOP_COUNT];
>   };
>   
> -#endif /* #ifndef UTM_QOS_MODEL_DCHUB_V3_H */
> \ No newline at end of file
> +#endif /* #ifndef UTM_QOS_MODEL_DCHUB_V3_H */

