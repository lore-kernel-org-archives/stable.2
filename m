Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77231D372;
	Fri, 10 Jul 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688835; cv=fail; b=r6f3wnbQMtvHvBn/S7RGCLdtnwGDzrZssqWBEToJThaEQX2598xg8Exgp7bfZKAVHn58dOQ7nlD8N9/wczKA+3zsoVDk/NoZiVs5uzlxTy5F/SezdBvZC+Nv5UgFGvnqPYTU04HC/vshMnuHsMP3EqLmkbKjq/S1iCUNjnxlHMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688835; c=relaxed/simple;
	bh=eYZt402vYqOMQ/Lw9VSMlNKFueLae+JtBCV+RPGxr5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bz/WZS5wlY7gw3paxDhPEtyRI081LLBzdgQTRl2dPFlrzrklhx/a+kPhG1iE95XlSeYl2C8jwTQOUdRLjeFBJh/zk2LYQf4mvag5yh6XHQ7q5cbQPlLzCVYPBRpBOmmC0kK53jpRf1srQD3hL1B76jSOnkQ8WTz1J35/bRHtSCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycHOLsUv; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycHOLsUv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuYwENXqPholx4M3BW6RziPO5CJ8+6WSqQcEfruQunWXmbe/1tTFLGhC+PRa9g9XsbNYVfvj9QVx/wmO5BQxhhJ21V1NHEt81uehOmY/GkJ3+A5xSde7LrF7yyr2hLxSke/fYLKldEfPKG47RVObJyiYMHP5np1iox9Ta4yZO1AvEAgbsfsZ8GKs2bKyJTaNyVCrS46Ax9WDVtIToLw7W1rmkeUBzz84Nf6LOimkkO39OizRz7NULZ2EGBy4klA9MoC9G01+K3sBICxIlpY/lWdabaxVFQ7icBoJPLCFwCTJBV0F+OucI/0w8XFaY8jxG2WAg0ZenONVA1lHmIClUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3cWciys70HLfDcTWEy+9hsEcsPrHidRXMuqtN/YFsc=;
 b=WW7CUTXRknwOqasw6QYhsCxI33OPgF6yQhlLNPvIY939DVAtGYaGEHqiqLCCvzi1XQgZRdWIGd6rhysvx3jqi2LRXhlAcB3AXtXvMg7M7QdRQooskCBkiWq5mvcXg4yQaJOK5yY71UoIZGT2f4mtaME4J4jpMJLSLBQXf03e7eixk0CRY/9YmA7/jI+LdbNOdBwXZqkko2rseyNODovVaOaZxQnLPkMTJRjvJZZ0d48SROL9Wk0SCLWxZ8udGdTDzE0O1qk5R8oghx3G5UdQwUtXHen3SmkM/ChBeTGEdnHwEuNJTmUW+flrNHnjXRuLD3fDAQxVWGEcoxsjjoc2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3cWciys70HLfDcTWEy+9hsEcsPrHidRXMuqtN/YFsc=;
 b=ycHOLsUv/DL/Hi0TMg+0BS9SEG1gUA3Y7BweMETBcWz5ZjXPmXKetlaUadjwOs0Y2Ab+5mnhCrCf+1ZOMu0dWWbXsfkE5djgRlgvzYLVA2RCF/N/ZPNXVReQMl+otDslc+6lq14HEDl4KY81It46AmqPUyc7sl5y5H4tzr5YXoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 13:07:04 +0000
Received: from PH8PR12MB7445.namprd12.prod.outlook.com
 ([fe80::1932:ff86:1006:b2e6]) by PH8PR12MB7445.namprd12.prod.outlook.com
 ([fe80::1932:ff86:1006:b2e6%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 13:07:03 +0000
Message-ID: <5b9b8ef2-1481-418a-951c-c48a75921f85@amd.com>
Date: Fri, 10 Jul 2026 15:06:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org,
 thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org> <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com> <ak_A6Yc5mBXCrtXr@lucifer>
 <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To CY8PR12MB7433.namprd12.prod.outlook.com
 (2603:10b6:930:53::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7445:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c86298c-4aab-4be0-55ee-08dede84224a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bQoUxwMoq+IvYyvi7XObcS/y3Uip1UAI0sMkVRKFOtZ3XDRQHXqN/uH9YTGHeZmsfWduSmrUlfnimmZjlTl/WsaHM7GRWcQfnhc2HmWKwSJIWl+ZdX4sqDcsYlnu5yy1KE0wu0zZHNbOqiuzr6ofhayDbfZd7JY5nibv56Ubybp9zPHNA9FULkuYKS3H9DRm3ief5gaD5fmoZVdDrJ/CP54Rytvx8wbZBUd4n3uP0UN2tfiP3NdJr+SM1mkVfFhBx4qaRMCAMRPPmmYtcJ2QvwuacDuuRSWg81KKojtuf7H6GzstTGUgjKVGb6rq+eBfVNLU91Eq7g7oMkFPC+pSJtJnBUQl08zDt1x0JkbaW/MFCFMxRoaUB/d6TAhkqdfcocM9avZp/vcr1Fs6TVsLGDSNsg8xt3OiucLMWY9G/ZfDAdoFpwadQ4cqv2EfMhKeuwtjLS0weHO+7ZD0WUwa0L10mheXa3J2RiTxzLy/wOzR4Ys7M9pTE5HI8e1hpmKBM8rBZI8mTcicPFFVLVtKhXQublpPmYKZm6m3PSthJzb5Z+jWr4b8qR+GrPDoPnYWMwT2b5ezBSqjq+k5CYmVGMuaFfzshqlRPnWf3A7NV10zTNgcWQxWs5noPMMHF7nlhJRcIVrkw+y10kJzPS71GAFucUbSvMaaw0Jv2Qpy8po=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVBzZTZLa0xJTjBEZXZURUpieExVeE9ydmtCWEliOHJTY2lTRk9QUXZNV0tB?=
 =?utf-8?B?cG9wV09qSGFHY044UlBYU0pHVnUyVUR1U2R4eVJqeHlXZ0haMnUyNGJWc0VR?=
 =?utf-8?B?Nml0QkZTUjVzSGdnNnErRHE5L2h5VlVpZ1dlUndZQ2hDVDRubk5leExRWllv?=
 =?utf-8?B?U2MwYXVTUlpDYTFnZHZXMDRmZmFsc2wyNzkzWWlrRWVIU3RCSG8zMjZDb3E0?=
 =?utf-8?B?b09aUlRLSnlMalJTZGluVG5XMnErQVBqQ1oyRzlEa0dGMGFkQ3pyWENRU01i?=
 =?utf-8?B?Q0ZtSWRmUFVyTEJjcEFwQ3B4S0JuaHk1dTl0Sk5za0xtaWQ5SlhMVHpTZHYr?=
 =?utf-8?B?dWxac2VyWHJWVzNFUkJWR1Flb0JPVGNPVEp3eW5RNTg0T0ZuNUpidnEvRzd4?=
 =?utf-8?B?ODhDS0RQZFZPaUd1dmFsTDFRcGtUb0hJMllSY05XVnYwaTdqM1JRVkNxMkU0?=
 =?utf-8?B?M2RNbnZzM2NGQnBQYkx2aFo1SUlJM2krZXNmLzFhSUxBY2lCc2cyb09mTWNY?=
 =?utf-8?B?S1R3T2g3OEE1TncvZmVROS9lNmpZdCswbmVPVjlka21QYTVodEJsT3NDZmVN?=
 =?utf-8?B?S2hsKzFQNGxyUXpKbHhneGtrQ3p1aU9BSm9hR0FMN1N3YldxMExwSmR3c1lM?=
 =?utf-8?B?WUphT0NvRk8rNk9BbFloOXNqVEtTdndaTVpnaURqOGhTNUZ5TG9Dc1p1UkRr?=
 =?utf-8?B?WjFGcGIxOGpyRlR0MGRPN1JYMEdha2JMNFdPeUdjTW5tS0VBdkJTOVU2VWdH?=
 =?utf-8?B?SFluNHI1NEZsKy9VdTY2OW9ITFVFRnRONnk4Ry9hVklZdnlnSmlVN1AvelBG?=
 =?utf-8?B?K2YwVjdWeHg5Q0NYY2lKMVA4YkVoSWh2R1puQ1diOW9LYlo4ZG1EQ3h5aTlt?=
 =?utf-8?B?S3RLcVJ4eXJGQnBiSHI3dDJXK0ZsM2syTDBTekFSeml6OWZhamJaVnlEdXRr?=
 =?utf-8?B?U2xxM0htSjRJZlQzQmxhcG9INWN5SXorK1ZEM1lIcDRIcC8yZUhXd0JpK21o?=
 =?utf-8?B?Qkd3RmxaL1hCRkZPeW5lYU1NS2JSWi9sOEJMbkQ4UGlNTmNGNUh1aFVpcGRP?=
 =?utf-8?B?N0I0Z1FyRmFPMmhuMXlya2NsTkdqVXRwRTh0Z2NSK2V1U01PejJEdGtLWElo?=
 =?utf-8?B?Qi90SEpWdHByaldOSHNodEk5Qzk0YkJ5MWIvcTZkTS9HMFdtRW1hUlptOWVL?=
 =?utf-8?B?WFJldUU3K00wVHpVL3AzZGgrZk9WZDE3SWJnbElBVmxnYk5LYUdVN3FuMEJR?=
 =?utf-8?B?VTM4SkRrYW4xVVpkbmRGUFE3WVdnMWxkMkF6TldBa2JyenIwMzVKL1Bkb3I0?=
 =?utf-8?B?YnVPajcwKzhkQjVaRnVkd0xpcDd6SWYrYllUcCtGMHNSRGNndlZsRXg1L3lW?=
 =?utf-8?B?Q21iLzNBYW82TzRxMW1YVU9MS1V1QllzWVBpN3VYOVpPdXIyVDFaak9HcFU2?=
 =?utf-8?B?eXJtbjYwR3VKNXlhOUtmaWp1YjdDS0p4S2pIbkUySUpoVGhLN2NCMGpSc3F0?=
 =?utf-8?B?cU5YOGRIMm1TaU5TdGhrOU9JcDJhenBRZnFoOTh4cWJieUhVM3ZWeFlyNk5m?=
 =?utf-8?B?MDIrR1c3bEkyK204WUswbmgzeHQwSThNYk1xRXNQL210cEY4enJNYlZPT2pn?=
 =?utf-8?B?VzZPaE9vL0tzY3FnTDVxbDFvWlF4WWtGVXFuTlNEL2dJeldCaWtXaENDQmlG?=
 =?utf-8?B?Vi9QUXh1MGVYY2JtSXNsdXRLRDE1NU92ekE1UjF2OW1tZEpaVG84MzBvT0NG?=
 =?utf-8?B?SkNkWDJ2TmMwdk81VHVQMFlIaVlXcmdJMUhDd3FFK0FSeGJtdm91ZG16WTR5?=
 =?utf-8?B?UFl1Tno0QU9NOXJ4SGtiVzRnWWR1MmhXSVptbzJXWTk1eHBoc1pXUnhOejZB?=
 =?utf-8?B?YzlhOFo0WEhxaEtjajlMV3JRZElUT1Z0bm0wMk9BZGNIY2VtbWFqUnJvV045?=
 =?utf-8?B?Y1I5eit6ZjhsRmZFektQbkx5Y2hneVpXMTl5ek4ySm5VZEJnMzZwRFcwaGZY?=
 =?utf-8?B?V3UySlNPcFd3RGN6enR2NkpWc0V0Ni9SUWJNQUFZaG1Gd3JlYkIrWlBwRFdx?=
 =?utf-8?B?b2hyUjVQM2JRZ3YvZTd2RUFWdDFocER0b3pCTmtHZ3BUaTNnR0dCN1lqcHBo?=
 =?utf-8?B?YWhoa0dIYXk0Zll6WlVCaWN3TzhzK3BydnJXRWJ5MU5Oc3pzQlNPc1pjY1Js?=
 =?utf-8?B?ZlAyY2hqYW1Dc1EyNFM1NjhMeGNMM010MzZBb3JkMW5CdTVFak10WkczTGlu?=
 =?utf-8?B?dmMxb3l4S3k0MmJtUjRCeExvais2WENVZExhd2tOQmFvV21oWko0L3YyVWs4?=
 =?utf-8?Q?uk/Evjhes2fpaaV1en?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c86298c-4aab-4be0-55ee-08dede84224a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:07:03.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqFk9JUge2fP6C7UoQlQUDhP1l+V62BXKPKppo7cEqdl2C27rOGDGgH5KZqwYngVw0R/Y4yasNorbISpVk3uWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005

>> hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
>> without - any checks that exist for that btw should be extended to this noew
>> flag).
>>
>> Also don't we want to encode the legacy aspect here?
>>
>> Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)
> I'm confused about the _READONLY, well. and the FOLL_PIN_NO_GUP_WRITE.
>
> We want to longterm write-pin.
>
> @Pankaj, how come you would call this "FOLL_PIN_NO_GUP_WRITE" -- why "no GUP
> write" ?

Honestly,  I did not finalize it then, just tossed the name for some 
suggestion :-)

> I agree that someting like FOLL_LONGTERM_LEGACY_* is the right thing to do, but
> I don't see where this is "no write" or "readonly" ?

Maybe  FOLL_LONGTERM_LEGACY_, still pondering what that name could be ...


Thanks,

Pankaj

