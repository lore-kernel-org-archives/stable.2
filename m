Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021081.outbound.protection.outlook.com [52.101.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AC1A680C;
	Tue, 25 Aug 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648086; cv=fail; b=BYhJmuCW9Kx4YizOnCD61gdVeY/01I/uaIhTiyrfZfORlAv+s6wsKqJYYIzGlX5A+CY7Mz/36DjzVHCelel+c8r6HHrfb/h8KOmqcSsSs+j87hrrUuZm7yFwsJD/LhPqGTjSVIxfVK3foY4nFmMU1j0cTKDMJ2KJsBoxjq0SCnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648086; c=relaxed/simple;
	bh=OuZnMcGiOPjMOSHhCKHy73f09aj3o0/ZGvWQXX0T8os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJ3ahWbV+ED0VJjRAQs4a4OxOp4WVcSMDCe6U9c1iBq73rFHJobByPqkV5sfqKr7YD8U+lH2XEjVAAylJPJXjuZXnYXPIgf6sPchPH1Kff2Li2FOIdestDEEbIzclcgdpN+R/m9Iid5SbwktMyQgRUwjWYVUv9WcebIV96GWxEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkqnSXyWUlzeJAaAKPdY2uLH8+iy6Ptiu5DENPtq570zDgeu2Du5mSj9p9X6aG44m+wrM5EQfCIp0l3HJI0xUhzKHcIvvPuPWyAXeX+gvJUP7MVHV2TRn1sdBPBwjzsVExkOj+XTIKM254rmKGcj0dW/2AzugZ5xdDXJg9riLXCVcHR1Vtv5EMTYU/uz6S5dAJRhzwp7Q1tJ1g65u+2BGU3NBoqZICtbubUc1G9BgseZvKmHpFHrM0k9wRfec/Mp7iqqBKp69QzK99538c6Sr0Mwoa9CrO2cHMkdrUeaAD4fBP8gVtxYIYBGpRqARA1Sa+CA9f7YCzniUI3PpQ6cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SX2xXbZyt5Gd6pAlSCQuVwEBY74Gm20PC1gDo2clyOE=;
 b=fcjgNiD+NusG7WNmNJZJsE+dB3V55GMUhqjE5e/ywv0covanMcnImieQnHKUcEm/1qHyGHSBzV8uUviXWxhpf97H1GK6rhC0RP3Q8nyMCxDMw/v/s14YAF98Nhb2QgCnoYHWGigwXzWycIZNTGPyzW7Tw60j8emIRZcDG7fy4e+6XenrvRyneNINl9N/AnaQmFGXBXUwj6frKu75RSUZEcbfE6H5GilA6oYAMOTExKj7PTQWsfBCuyaEzOndNNRAaOqFpNETe4MhxaJqDZUsHID2y20cT5TSvEqj5y7959lmK2FhzhTyk/Q/P3a0H30BbSl7pK8DayBr/ic5ubCHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4250.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:159::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.13; Tue, 25 Aug
 2026 08:54:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:54:40 +0000
Date: Tue, 25 Aug 2026 04:54:38 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
Message-ID: <22w2z5iw5mkakrz5bypeygjl3ytlaakagcc77emsmbrzol5tvs@ucrorrfpcg5o>
References: <20260824014736.35026-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824014736.35026-1-hao.ge@linux.dev>
X-ClientProxiedBy: LO0P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::13) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4059d035-03bd-4d61-bcfd-08df02867fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7huFCH/iSfjsLwA2BMUGpvplb4pSczEeVJaqInQri2cONMOxlkMmLGQPbcMrYdxLyXKvJ+Kjrb1ixAOCFiU0Udq7gRbUAWDIhkyT2958VJ67eSY9T6Yi9JjYmkWkIKou+Q0WZQ+0LphXKw6unSdff6OEqGKVTSMIpj41GLBvrHPusPKkBFEUbAaydtn54bqy4vhnLNL9VsEhvlKLRjUnzAfvM1vG82wZDt1abSCNaFpUs8/HwcZLHkkT02gmBHE3r0R4qmpdB4txYOuIQOH8E0++K3z6SiSeV8eaXjjk5a33GFGKqYOKoFe6xxA9Jv4SzZisibAtW/Ca5MIenJixAe4xqGzJO7Etm9thyUgLQj9OKwdmQm8eStk1xpiyn44utl6y4SFhx2eyVHvUmL+y2VE2sQO20I5yjoitXfYfdUF5NFYanMXNoBw+XEuPpnsys5jq363ICGMDMrczUCcsD6wm/m0v41ATiR+8s7AFHItPs/OyytZqR+ljpFcmwFoqDoSn6vmmBuvYIShAPgWuqhLZ1H7zWO4lSKOvPwBOQh8TT+2Te5uqUZjLPFAwFxuAiiaJLqNjOE1xhZdLnhIYMxe7flqAsneGsUcXTuFoXU8ZAoBI6/gbpUBa0SSaTvPkBWGfwaCwMGc9KES2cuRMWPit+U7esFf8nsrEA4MNqEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VitZV0NCWFlHV0doRm05aGxmK29HaDhLUW5aVW4yYVNrR0doZkk5RGtoVlds?=
 =?utf-8?B?a0Z5d1IyRXJZM2tlSWV0RWVEcUlXSFJmNWw4bWg1Rk80WFV3b2crMDdKTCtl?=
 =?utf-8?B?ZmFXcTBVeGhac0xReWt2cE9hb0tQVi80NTcwRUc0amFyQ2RaQ3MwSXpUYWts?=
 =?utf-8?B?Zlo5cWFQcTM5cTBGdGJrNUNtOFlTTlZnM3ZtTDdMdEtTT295Ri9pOUhmZEJI?=
 =?utf-8?B?WGdWM1hybHZ5T1ora2pqM0NYNXdxY2RBYjZRTHNqODdxYVNhYmdodE85SDVS?=
 =?utf-8?B?djNSOXNHS3gxbmlFeEhvd09xRVcrRy9sWDRSNUgwOEROanBRM0RiZ2I4MGdn?=
 =?utf-8?B?TVNHUDgwN0FtYk00bjVMN0JIWktJcCs0RVNlK0cybVE2VGpEZzNMZjJXMlZM?=
 =?utf-8?B?ay90ZFhYRDVEVnRWczE2YXhZTkdFWUFFaFZjcWtEVFVoRmdmVExrNFdxYzVJ?=
 =?utf-8?B?bXlNVzlscUo1SDM4TUdRVDQ1YUNNMTNxM3o4MU5QU2FrRjlFQURydHZiV1BC?=
 =?utf-8?B?ZW12bVF4ZktLSjlJbDZsdGlVOVpta3gyb2NTcXhkM0gwRlR2Q2U3VmNIV0s5?=
 =?utf-8?B?cUt6L1B1em1CelY1M3NNcjJQTng0WjloQThBTjNmU0hQU1VWZ0VnYzRiSnRs?=
 =?utf-8?B?anQ1Rk15aFNNQnE5M3plKy81QUJKNjZyNG5oU1IvWDNpNVEzcHVKendxaGN2?=
 =?utf-8?B?dmZPUyt4SlJVZi96TzhvWGx4R2VDaGlaNVp5d3NaTmJzVWgrdGx5RTRXaXdQ?=
 =?utf-8?B?LzV5MVdjRVVFV3ZkZFhpNVFyQ3lwaE1qTkpKNTNqK3Evd1JBKzIxSWFkT2Zr?=
 =?utf-8?B?bmhabUVvWjRaclo0aGQxTDFKcmpFNnBWbm1abGNFMHdlNWVFWmtXQjJRekZm?=
 =?utf-8?B?N2JENDZUaGhwemJqb01xeDV2Qk54VFo0aEhPMXVJWkhRWHJhc0lSM0oyT1R3?=
 =?utf-8?B?MUJxMlB1a3ZUOHhPQ1dwUTBvckt3OGFVYjkzYmN2UzhnNVlma3dOMTZUN0k2?=
 =?utf-8?B?REt4anB3c1BCWUtWdDQ2MTkxM01YTzVQVkxubjlCamtLQWZyWTdzVEhpY2pB?=
 =?utf-8?B?aE9tdnBwbnk2TkNuUGxaRXdvY0RzajFvaCs4NVNEMm9aa0dYR0tpaDllMGdj?=
 =?utf-8?B?ano4RnFNMnNrcngzNkpKeGxBZ1Y4RkRmbTZrRVIvTnJPRjhKUkw1akVBMkJC?=
 =?utf-8?B?UUhxL3NodUVIM1BNeTNYSWg1Z1BkRzg5QlBzVjg4RjlVZEVSemFHYzk4UnpM?=
 =?utf-8?B?WDh5QjkydkQzVUJoeEFjYnczbFNreVJvdFY1NUJrMitPa0gxbjN5emc5ajRD?=
 =?utf-8?B?TTFPbGNodjZlQUJqTnNhby9uV09pMWsyMFVKSWpibE8xNXUrT3pzWTV3TjhU?=
 =?utf-8?B?NEdMY2VGanhaVTJsek50SkhIUlFxVTZPRFJTNkRYZnZJZjVGMDVLMzBFOHdV?=
 =?utf-8?B?NUV4czNianRJUXRrWHBZM3dydUQxL2dEK0pVQXgvNnZleGpqZ2RCWWczbGV4?=
 =?utf-8?B?cUc4eDM5Z0toYk5vWG52cHZhdTY0OUJSUlM1Z2N6UWxnb1YwUlpSeldwbzRE?=
 =?utf-8?B?V0V5RHEydlJIeVp0MDF2NDJwSTRNeUdYaVRjbFR3NmJ2Ry96emdPb00vMUJZ?=
 =?utf-8?B?a25zcmxvR1JhUnh3Ni8rMHV1dUlWZ3hRTm5WYWJDZEtBRHEvMkJKWk83dzg5?=
 =?utf-8?B?aVVzZUNWcVNHRUFXOWRGcjF0TWxNamxpM1BXdGZjelB0V0p3NzI5dWsyTDlu?=
 =?utf-8?B?NnphUGxIcDluVVVkcGlobVZ2YW9uVHk5SytCQkNlMElFWGtVOWpadWVGcjFk?=
 =?utf-8?B?MmV3RmNhdWtROWdxTlFubHF6NUl5L3lKUmZTdE5EUDZyVXRqMUsvY1BCSmxp?=
 =?utf-8?B?UlduTjUvUkNMSzlHY0N3RjlSTnh5aitMSWRYMGxDNUtVblNqWmdRaTVpM3E2?=
 =?utf-8?B?cUV6L0p0ZmNpYksvdjVPSC9SNmMyeFJ6ei9OV0ozLytPMGdJYW8zNzlJOVdk?=
 =?utf-8?B?ZHh4SEJ2Rlo3VFIwMFFKMkUrRFFyL1VkelM1bTErVmxKekJlR21FQ3NobmRv?=
 =?utf-8?B?QU15MGtaajlDa1NkNVB2a3preHJoQnZFazlrM0JsbzRjY2pHeFBwaFR0Vk9P?=
 =?utf-8?B?QVJsMytRY3lxVmc3NmpGRm13S2U3ODZYdTBhRlJxbXVlMU1QMTR1dWhRNmxR?=
 =?utf-8?B?ME1VaVB2dXNMSGtvRFRyWis4N0xQeExpMjRKdC9SVVUreUNJN0Y1UE9hNzI3?=
 =?utf-8?B?dG1nRWcyOG9OTmNpdyt6OTg1aERwNWxkNC9DTm9iRysvR0lvL0R0R3QyaVFQ?=
 =?utf-8?Q?6C07HocYpnCQnOUCMW?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4059d035-03bd-4d61-bcfd-08df02867fdb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:54:40.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELR+yTCjT07m13uswxZyIVCT+PF+dnmQJec9VP7rkVW6hsVUOprw4vcBirsDUEUm2vzFbGpTWIbYxHD4uQShiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4250

On Mon, Aug 24, 2026 at 09:47:36AM +0800, Hao Ge wrote:
> If codetag_load_module() fails, err is never set and load_module()
> returns 0 after the module has been torn down.
> 
> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  kernel/module/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..afb810f0154c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  			goto sysfs_cleanup;
>  	}
>  
> -	if (codetag_load_module(mod))
> +	err = codetag_load_module(mod);
> +	if (err)
>  		goto sysfs_cleanup;
>  
>  	/* Get rid of temporary copy. */
> -- 
> 2.25.1
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
