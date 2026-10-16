Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021127.outbound.protection.outlook.com [52.101.76.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B672F0673;
	Fri, 16 Oct 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160618; cv=fail; b=rfGUBrXeWxZ7Q+UE0TUEMQ7wMHb6Kha+aAQHdcIah81HIwVYxfKChXHnxshwi29kMdwaiLndSL/woUKWk1MQjzLzPPGBCaV2sa6zWugRi1Cp1a+6TL6fOyBDho65V8IgrT1Fze1x48DUX643dOJZaJtXs8pbAeVDPhVWhDreLoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160618; c=relaxed/simple;
	bh=weJRJXU8mlmZH3LA+STFqNpVNZ8Rx8sss21o4UPckic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KKpLvvfTHUa7uJcd9oCGGAdsqp2woQhb9UpvmulUlNPYdHnyT7te+QZrgDnT1TtuRnLngeRDhHJ0JLkcHbx5c8OZzLKRnh+EbtDTFU87f0gHh49xRa28ATMrVEw5KNrr7d2UBkuNitnJYx70cp4aJxyXxEk6vrwjCacHAo56wps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=qKlTocfS; arc=fail smtp.client-ip=52.101.76.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="qKlTocfS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuiTP5UPRtahLdnU59iqWZSjzgchWDxCAtnMKvosH4aTdb1YCGoZ8ZTOJYn/13Lw1aBXZOGAy/nNhevZH+CCjarzd7Nb+87XgJdbCibJc1XhFEJ23YZ5QstgKLixdXjVXa9zQUgPFL2+9pxGWXDHhJG4Ri+fPJtBC3SxtBBgx39Mi5lqSsJ4wzutEdJAZx1Qk4EBN5rZxkKOWC3UMfWfHlE/l6dGF7v6Xt2MsLBUYT2NOghYn5BMizotJfkce3MXG5kiS45nlWuhjNzFQ0KTIOGoya7KzeqxfM/ID52XphQn6q5Kk9rkjLUVSYw3r3PupCclxqiWvE2LukWo0JZt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x9VJ4gQ9HmoOAFhTE6njOEkjAhDMlkmCkUoR8QddnA=;
 b=Yc338N4AIhZXgIrlKoDcy3tm4K2T93TLzYwHpooly+NfYRaKlOYOf/bJ5k2gbUm2wFdzren1bHsLOvuOyuPcmt1pGNcdlkMr0SbhJtbq5Dr9kwIZJZH1kAQxsiEKbHrf6NUhgE8y2oGMdNQuW3VLIRFpIP2ZHS2faLwHQcmWgK1aow+MApZ15NQhfv6Tyj47ZIsSdJxgOtixPBwgzNzwnaef9OnduS17xgCrMK8vhKenPnWku41e1iltISDTneznQx0U8G0gITb0NTMEkPI0IVItJziGNI10NLYthuHaok7KIIHYpBQPV9lcNFIAF/ClvP6OWwFX1yiY+nmB/79tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x9VJ4gQ9HmoOAFhTE6njOEkjAhDMlkmCkUoR8QddnA=;
 b=qKlTocfSMhaoD8632tBTAVf92nZ6yRjmYdkli3zWzSCiiepq8i+PucquhgOdj0U6wxnraBzemz+JJ6589ZjEsEYpfcNP8RrWyWJ0KlVmtJelmDf2UPnLpIPtGKgmE6KRu2wWJi1J61lsmFXM0y4IaSljs/785WUy1qvHdi/+WLf3lXODUCKcAyhAOkybegl6rUUOhzYa029S1z38Fz+XtQ1j/nlK7vDSVJlLZcuxKWcBFVlsEV+vYILIsl7HzD+aVGIebkvvgY5AvPXbbreq02fhrBrifSXqt8BRiOOBc4IArgpbVBIuEqhOsZFcmOj6Z9RhVKubUTZxpk9FdqXwaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB1980.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:23:30 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 16 Oct 2026
 14:23:30 +0000
Message-ID: <f641bf79-d831-4dda-a27c-731ee1741594@gaisler.com>
Date: Fri, 16 Oct 2026 16:23:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc32: keep PIL raised on the SMP ticker and LEON
 IPI exit paths
To: Imre Kaloz <kaloz@kernel.org>, sparclinux@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, stable@vger.kernel.org,
 Ramin Moussavi <ramin.moussavi@yacoub.de>,
 Ludwig Rydberg <ludwig.rydberg@gaisler.com>
References: <20261016080942.13167-1-kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261016080942.13167-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::17) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB1980:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ae26de-e884-4741-b060-08df2b910d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fOIJA58QxquUAGiRIYlVdcqvbATLsuxx7WZafDLRSRI+SLKqSl5qVgWsvnBiXwGV8F9SJdBTOA6cuU5+/T4Pt07GeT212olsKSBY4HxsYJdTvk0bxg8mjXMXQYvRxcKfZ+xoP4x8e7iJ0EqSEDxBE0F8dszmMWdWl5nlD3RaQ5AWskM4Xsx3HkN7oKFpasxiNDPH1GTKwKhmJ0aXWkhLkO6zBcRzq8Pi6UZr5kfgzDzLfB8tepK0QDOC1HcLP0FWIJnaygQFNUjI1IXbrI3JpWRMY4b2b1U68uU+1pfi3LVeWTYzbnlUUplf3RouLzMgNkUaplU49fvsSFGin0arpBkFaSDG92qNna0uPmBYgHO3HeuSo76kdCxqq2hWPJ1NUMxtDvYYmeKbLRqspdebjBL0Ro/LCNNM+TqYtX16BJk20hVfIIpndD+Zw66Qwm1VSWAc2y56EgjOqWZuTbItR1+DebL+/88tX/YM8cisoC/LXLeZjIdBwOYeuPfJqyq2Fg0fnYhQe/1OzM6c3km5AVllsX3OeBzTByx/ap8GJ2It9lQCbSmpJsa3ji+QhCCOpfyPMpOn2PM7cmqKuo4EjgaMfh2kwq2+Fix+mgLFmKjkdsJGamsu9rjwqYiWM9Ia
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDY2eC85elRCUlBNVmFjTmRCZk1OL2FnVzQ2bG9RZmw0b09MVlIvaktnR2xn?=
 =?utf-8?B?c2VsZzRraWs3bHBmeC9JQzNrbUVQYjU2aSticDZmbDgwb1I2d3hnb3didHhu?=
 =?utf-8?B?Rm84WHZ3eWJaUmZ0TWdYY2FqL1FMNXBMblRCVFFaeUpPcWV4clA0bnk5NXp3?=
 =?utf-8?B?UGt3eUZwU2ZYM2w0WVBPc2JwaWJtaWxudmFtd2FjdHU5RTZoYXVXdFlsSDRm?=
 =?utf-8?B?S2VMUEprcWJEa044TzRTMi85QWVZd3ZyV2RBOEVzMmllRXlwaWgrNlhhWWtT?=
 =?utf-8?B?RGJxV2NJUXc4SXgyM0gvNnI3ZVhpZ3JVWnhkbkw0REpvRGw4dmZmSVllRExa?=
 =?utf-8?B?bEttSDB1cmtkeUVvWFpzN0dpb2NsUktqQXo2aGNpdmZocVB1bE1lZi9Fd3lR?=
 =?utf-8?B?ZFRsaCtKZVZ0YlVReGJoUHFIWDZISmsrejlSdTQ4WVhuSDJUUkpsWndoOHZV?=
 =?utf-8?B?TWVFcjBZdlF0VHhKaktBNmVweG0xdXZ6b05iTEVxemJJSTF3Q2s4ODN0aUpT?=
 =?utf-8?B?STZYaGcyRlFPc1lUeU51d2Q4Y3F6OGxpY2VaN0dpUVFtWVEyN0syT1dyMkln?=
 =?utf-8?B?MXdoQXlGN0tudlN3TUlVaU5pRHNGZmJ1TGcxWlptanNsMFFPcFNtd0VZZFU3?=
 =?utf-8?B?ckV1dkt0a3BwQkkvdXdtdnA2aGlhQnFNVUEybmRrcEJjVFFLbnpDbWZSSkZ1?=
 =?utf-8?B?TEc3YUF2R3c5RS9tb1V6WnVrUTZ0MW5LUno2S1daNklqdjFXZS81cUpmN092?=
 =?utf-8?B?eDRxbnFKU1hvbXU0cUtDNCs1TkI1WklIYVA1UzgvOUZrelg5akFEMjNEY0Iz?=
 =?utf-8?B?cGtJbEE2WS9DbzJJcU1rc2hJQVFxVnRLS3FOZTkyeUFlVmEvMHNtbmUrYnE4?=
 =?utf-8?B?V0IzZ0Mxd2ZCT0tZZzFpbDdhTUtscnhmdktYWUQ1OEpkVThjZ3dxZ3BqZENL?=
 =?utf-8?B?S0lBTS9zQzBESmJyNlpHdUF5MGlGRFlmOEJIMDVtTW8rU1pFbCtwMEtrd1kv?=
 =?utf-8?B?RG9hV2RpUVVkMW5pQlpPdEdBY2h3ZjVFeXBUQkt6aU1zYVIreDJ1ekpKc3ZP?=
 =?utf-8?B?aEU4MjllbmQzaUYvODAwUUhDSnNIR21OU0VWZUU5bVlaZEQ4blpFY2htN3da?=
 =?utf-8?B?YUpzb2NRTDErV3pEcU5zY1k0QXBRYTAxa2xmNitZQnNqeVpFUlZoOUowajk2?=
 =?utf-8?B?OU9yeDZxRVdhbFBHbFBkK0tCMHNpUEhOQzVtb0F0THl3Y1MwVm8rNlJwdlZj?=
 =?utf-8?B?Q3Qwc0ZOMmx5aFpCTGczMi81UGtXUWRJY2V1RG8vOE1DclV2eUZLZDVXRmg5?=
 =?utf-8?B?UXZxdGRXNi90TDNWTjdubEx3blF0RFRNSUFCTUlCcVpFbWsrRUViMnNXaWhK?=
 =?utf-8?B?dDlJZlp5aml3aTZmR0RVZHV6dThUbHMvKzUwSUsvbzA5UU9mUG9maHIzOGsx?=
 =?utf-8?B?SlEzdjJMMC9FdjF6MEt0L0ZtM0JhNEZQemJ5SVMySjA3MjBJOHA2Q0VKODVD?=
 =?utf-8?B?MHdwL3c2dTBoWHMzUXVia1RrcXJ1ZVRad251OW9tZHFsWTZvYXVhNWE4MjN4?=
 =?utf-8?B?SkVTajdyZkduR3hOVFNtOS9PQnlGYlA1Z09PbGJ1azgvMTgrVFNlTFVpRWFV?=
 =?utf-8?B?QlMyVmpBNzhDYVN4QlI4OHM5OGlITmpWeXZzM3Axb3R4SW90T3Vmczk4N0FT?=
 =?utf-8?B?WGhJUFYrWllwS2JWZHJtWHUyNHgrTENka0l5L2dKRjNSbS9rdWU2WW50aXVq?=
 =?utf-8?B?Vzh5WDhENlF2c3VLc0l5OFVjMkZCWTJqR09id1BOSmlLajV5MTlTcld5TkhE?=
 =?utf-8?B?RlN2bjdaaUMwQjc0emQzOGcrK0xWdm5DcmhIK2tVTDUwVDkxOThFVzhZK20z?=
 =?utf-8?B?MVNSL3N3dlJFNFBVZERnVVNjOTJ0dTBGR3VobDNJSE1Ca0ZkQzVpK2RoSEtv?=
 =?utf-8?B?TVI4bjZlb0tWdzhqOEZzNUxXNitvYThEK1F5aEVVRE51R2lTdHV3YkVLRldX?=
 =?utf-8?B?cnU1SlZNVlREY3FoVk1Fd21kK1RzRkZEUTdIYm1oTG9BeUEwLzlQUTFSVkZh?=
 =?utf-8?B?NzFNYUdsMDVhTFFGVWVZWkh4UVZOMUlqdFAzOHdZTHhOYWZETnRrUFV5cm1U?=
 =?utf-8?B?TThPQzIvQjFMaXl5TThrWllUc3ROVFNwekllZGRCdnRMVjNwVldwcmRURERP?=
 =?utf-8?B?Zm1idERXbThiRExGWFg4S2FzMm40Nm5EaE5RMy94OHhJNys4c2w0NkRFaHVR?=
 =?utf-8?B?VkFLSnhuZXFSRmxTcnRDUkRZTnZtRllEdW5rL2VpSU56dXhFT1RNQis2UzNH?=
 =?utf-8?B?Yy9pbGdCclVIYTg5aEUvaG45MHlQUUQxRys0c01jbk1hTFBBS3cvb093bExj?=
 =?utf-8?Q?4x7i7jAMOwM3Vjkg=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ae26de-e884-4741-b060-08df2b910d67
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:23:30.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4HwQe69Pxw1L593y7TeiA6t2gdaw4U2vXc4ZJwk5/QvFeEzGRcf3maIm+pdUPFP/p+ccZsFehXA6iqvNwH9dwf81h1U9e05uJ1et+KXbP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB1980

On 2026-10-16 10:09, Imre Kaloz wrote:
> smp4m_ticker returns from smp4m_percpu_timer_interrupt() by writing the
> interrupted %psr back with traps enabled, which drops PIL before
> RESTORE_ALL. A level 14 tick pending again at that point can be taken
> on top of the current trap frame, and back-to-back ticks can nest until
> the 8K kernel stack runs into thread_info. Keep PIL at 15 until rett
> restores the interrupted %psr, as real_irq_continue does.
> 
> smp4d_ticker and smpleon_ipi exit the same way and get the same change.
> 
> Broken since 2.1.36 (sun4m), 2.1.97 (sun4d) and 2.6.33 (LEON).
> 
> Cc: stable@vger.kernel.org
> Tested-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
> Tested-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
> 
> Notes:
>     No Fixes: tag: this has been broken since 2.1.36 on sun4m (as
>     smp_ticker) and since 2.1.97 on sun4d, before the git history. The
>     LEON exit came with smpleon_ticker in 8401707ff645 ("sparc,leon:
>     Sparc-Leon SMP support") in 2.6.33 and moved to smpleon_ipi in 3.0; a
>     Fixes: tag naming one commit would date all three sites to it.
> 
> Changes in v2:
> - Shorten the exit-path comments (Andreas Larsson)
> 
> v1: https://lore.kernel.org/r/20260927005658.8242-1-kaloz@kernel.org
> 
>  arch/sparc/kernel/entry.S | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index ea51ef52c952..7ceaa328a9e3 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -252,7 +252,8 @@ smp4m_ticker:
>  	WRITE_PAUSE
>  	call	smp4m_percpu_timer_interrupt
>  	 add	%sp, STACKFRAME_SZ, %o0
> -	wr	%l0, PSR_ET, %psr
> +	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett
> +	wr	%g2, PSR_ET, %psr
>  	WRITE_PAUSE
>  	RESTORE_ALL
>  
> @@ -353,7 +354,8 @@ smp4d_ticker:
>  	WRITE_PAUSE
>  	call	smp4d_percpu_timer_interrupt
>  	 add	%sp, STACKFRAME_SZ, %o0
> -	wr	%l0, PSR_ET, %psr
> +	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett
> +	wr	%g2, PSR_ET, %psr
>  	WRITE_PAUSE
>  	RESTORE_ALL
>  
> @@ -407,7 +409,8 @@ smpleon_ipi:
>  	WRITE_PAUSE
>  	call	leonsmp_ipi_interrupt
>  	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
> -	wr	%l0, PSR_ET, %psr
> +	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett
> +	wr	%g2, PSR_ET, %psr
>  	WRITE_PAUSE
>  	RESTORE_ALL
>  
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

