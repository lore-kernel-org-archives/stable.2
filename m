Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022102.outbound.protection.outlook.com [52.101.77.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D543E8684;
	Thu, 15 Oct 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067380; cv=fail; b=BNo9ZCYr3/Pm7bGtGu6WKDMx5tVDQe5mBKQBPtQ9UuIlIM8UYvQKKyuQu/7aRfKnVkdBBF1rYqV6tsxMod35MbgjWVka66glOIJCisUHYH9cKHRBM125kQz1Vjvk4/tWK+3xG6SMCPtVmniPn6OXzVz0mzi1Vd3bV/tw7N67dJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067380; c=relaxed/simple;
	bh=N/3XLVXJ2Z+sW6qvkqmDYj9ZoePL53euU4g7WE2inbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YJ8N5QgagP99BJYvpGZlZQVDwUc7eN/tqO+MAwGh2aV/UXI2hSi+VaetgWsBBSGz0ZE9/GhqoFnyuHWIzfOnA7v55T7vBtNhbfWfLMMp3GMFiJpSYq4s74YBOBxzE9bWLNBHHaSruFJqFBAJXTENOzAkt9Gd+vipk+E3CGdlt/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=lFThCZdG; arc=fail smtp.client-ip=52.101.77.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="lFThCZdG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6yBHRexKj8hMq40IobYu67+zc+TO6Awcolt8Hg96ro5iOlvO3Ij+XsvUkJNGdzO4lsImk6yOdkPh2/Oos05vZ2ifFeQZQbN1Ke+n/IK7TlnoWQ0wWyXxuZRxaxHkklPE4SYvtRCoJFUkwQ6Tr8vITT3RnrjbBTSIxRhkarDIzwAs7AkXadOm5ALKC/xR/i9CiUNxwdiAvOxVgXS8i+w4tXrF/eRqk/J6Q+ddpPDOEpAL0NTn4zEwDV95mkYA4ZKYaYuhTlwmL+TcMod+f1sj1jzhLm/L3F5mfEplV9YUx4l227U44TT1EcyXQ7+1lwyLiaDfiIFc80qwrbhyRgH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4PLtd0IkZsy11Ne0kIDVK3fgsHEn+uMBVSsLwsAZ44=;
 b=g4NdB+IEyTEAInpAcCf4wThSTg9DVSnaK0uAvz+YWWF9/qdYjDmWDIpiJVAurHazp2Af/a4VH1hAkg0Xvc3rtBf63LKJe/n/ea0mUAN+BECos9c8VrXRA/nZea94kWz7f7kfpivNvLwEGVjbjjQ1u9ooTqSnantl2xA0abnNXRdTFDz8jUNKt1KnhzaHFXntKfpR6111onH/rZ8SJ0S3ZbBsaCm6BqUY+BhpgP45Q2bxpegx/hR70F1Emjp+JyZCvtCyIRRvmmtzQXIEajPiUfNhM17kXqs66TXVumW1EYTYaQuoBSK3wDwfNxeA/m9ZCewjC8gLoj6OJ2G3PBo6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4PLtd0IkZsy11Ne0kIDVK3fgsHEn+uMBVSsLwsAZ44=;
 b=lFThCZdG1VIij+iX1KLAuGgGOMcBFCOT19b0tcn3QGf1AoqnK/g2GsfymI/vfG6Ev7r9MvBO0EjpKbrGxeSxpcU3V2CBgBMTmCbMJIfELiQA8SSCLd9LFPNLUg79HwOWJvef9BowUEo6rN656BPP3BARc/2eGbf74aDRKL2ZZA6apFe3m1XSABcWYOYLTkXZ/LUiRkJBK5yDSGKP22IfIKGhMxXiXBw05IFyEBaDl6EL2KfzS/DrO+waXbalG8gshWzi7XEUCQ5EcJwQtDsMFB5P4Ni6NFnl+ol4rOBN5hgx3wgkPRrqCBRtPcs9iz/wP/tvxVeFIAxB23UiVdZbsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB0414.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 12:29:32 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Thu, 15 Oct 2026
 12:29:32 +0000
Message-ID: <4046ba01-d11d-473c-a5ce-f952dad64483@gaisler.com>
Date: Thu, 15 Oct 2026 14:29:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc32: keep PIL raised on the SMP ticker and LEON IPI
 exit paths
To: Imre Kaloz <kaloz@kernel.org>, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
References: <20260927005658.8242-1-kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260927005658.8242-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::11) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB0414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8ac596-49f7-4bf0-e2e6-08df2ab7f721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZAy/w33yBxT8kOQUlX1Tt85Ies7Kp5POrA59NcJyAyRpbpeLdYbr3zDnfxdPrNPCEyZmPXPihcE7L2a3Z4+r7cTatFaA8IMdsNpEASNHD1ZUc/qm+Nj2OLc1kNa41rLX4IxJWA3cT/qTEGK7Ik3SIIr5BpO2E6mgn9aNOYRKrZ/3VBKnjGTTBtf6O1D0GdMMN8SVZ/XWFexokYaqqlZo+MTAxmN6kQ/o5PIQDBR3SxejJ4evSkIWmh2xTvzJVYzAzXWQf/2C1iFz2iagZXCIfLgiHH5xbfl6PU9u0kRmEzTQ9QQK9ndx6EUz38gDESQ8ce5Qh8AOSIO6slk6CjGUGiMRJEMpyLErhbyhhLB91SOv4UymgMtBwYGTa7SWXwjjIbkQw7WDYYpP9QtTW7FPP2ldDqLtGxbYxAJBhc77VrdbeqrgawY9KlQSgnQLRB5pZQ7v4jqhGeLInvsXQH863Xb9QJKnNK0qlTeDEwDReuCQ9ubf62X/3ikwzMKe8QmtiFD0vELT1eIsEEFlLJLXMEaXt+E5J37p6H72UMo8I/o9273MCGpPWkeCJjiYTs2C5Q5lBhXu58ahUMkeMkudHQ5PIcjMYHRG0xazdMhEdWtU3wLtQqxwKlMRJ7K7kAyXHjQLZaQb4f8u3mnwL2k9hfAvy3jkReexmjcJE48PNoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUdPaU5hRHE0QW5iYnZmQVo2cUsxdzJJMkg3cHJxYVAvTHdpc1VQQWRpUlZx?=
 =?utf-8?B?d2JkL0dhRGFhOFNQVWFUMnBCdzRPQ0xZUURYaGxhWmdhN1BiWjgzM1l3UWxw?=
 =?utf-8?B?OHdqZnhSaS96Q3lBS3RGOUFBZUVZb21xU1VtaEtXWm94cnZ0WnBFWjFHcXFn?=
 =?utf-8?B?aWR0VkRHcnBoR2ZQckhBWkxXQ1g1YUZGNSthWjloaGU2RWduWk5XaEtpSDlH?=
 =?utf-8?B?eFRESk90VnNlRVVFYzhQR213ZHZjYzBucTRWSWhhYi8vSWRGWHA4eDlUcFBG?=
 =?utf-8?B?NTlDUU8rRFBDWFVUeGE4MDFwSEZPelBSVVd2djByUm5YK0xwdWxkS3FHVk9w?=
 =?utf-8?B?dHhVYjFJc09GZHg3bUgzQkY1SXYwUC9SU1hYVWVBa0JYSm1qdUVvTlIvNUpk?=
 =?utf-8?B?SlZuL3FDN2RVa1dOY1pZcVZpeG8xSFZaZ1czbjVxRi9SRmpoOXBCSkdXdWpN?=
 =?utf-8?B?K3BVM3JHdlZaaDJwVG9xYzR5dzdUbDRqZmhVOUdSVGM1UW1kN3crY1VIUytX?=
 =?utf-8?B?dDhCbUlRem84U1lvem9CUGhBY1hITDJmbDlnNktZTjVCUkdNZEFPRUpBekw3?=
 =?utf-8?B?SC9UTUJyYzhYOHdlZXpOeHUrSUNXYmx6YndqZi9xWmFHUDBJQXlYaU0rVWNJ?=
 =?utf-8?B?R0R5Sy9vMmZVVTNML2tkT0l3aUkxRlBqZmM3WFRBakY4NjQzUTRDdjhPbVR3?=
 =?utf-8?B?OG45L0czVkN2TmxZWVpnc20yOFRUUVlXajM0eE1Vek1VKzA4WlE0bkV6cWxn?=
 =?utf-8?B?UWRPc1oyUzYwRGd4aWlkMEluTDJlRTZtaDdJcVdZaVlYR2tSdUJBb1BDcVlp?=
 =?utf-8?B?d0VBdlRyUGRwVk9pcnlDRzV3OWlnTWpvbXMwdFZuVnU2WHdhblFRS2xWZmhU?=
 =?utf-8?B?L0oyckhYb3hhUmVOMmY5QnFiMkRCYXdDbm84emNoTUJHM3RrM05UT1ZoVjJC?=
 =?utf-8?B?SjNoRVhmYlNTM1JydjhBekNMdUM1OGNNQTlnSlRuaU9uZGYybURsK0ZyU3V2?=
 =?utf-8?B?S240K2hKMHJWWmRvOTBibDJ0M1FGN0E4bFFJNGE2T3BCZzhnTEJMZWQ5YXRI?=
 =?utf-8?B?T2pJb1E1enRCeUhKWm5GNHNmcUZxYm5hSnFuQ2lIQTkwUktBMkdYaStpZ0w2?=
 =?utf-8?B?T0F3cENGZldLRFhHYUhBcjh4K01zWXdYdWdDY1hhZ3ZnY0NTU2VqanhYT3Qw?=
 =?utf-8?B?SVF2Y2VuRzFhWWRzN3RqMmQrbnUvM2xnY1Q4YlRlK2RTUDhnRHBTL21lV2xm?=
 =?utf-8?B?VnZpcXpBN2R3VmtqQXRXV3FmWGVqbzY1Z0duWk1adkk0azVYOGllMlE4RnNG?=
 =?utf-8?B?MnQrQVdmR0xWbEpQdXB1YVV0Vkp2RkdyU3ZnVXpyanNGNExabFF2STBVMDg3?=
 =?utf-8?B?aXlxc05FWW9QT01vSjFQcnhUSzVxWVJGdzk2VlV2NnpURUp6eUZKVVh5dy9K?=
 =?utf-8?B?Um9TRTI0alY5a2NiaDN3R2hkamQ1NitpTFlYYnEwM3V0VHQ0SjFDVENvRHFN?=
 =?utf-8?B?WVhzbXFuS2VtYW8rTU14L2pRaDR4TDZ0VnZSZUdhemZSSlJrOGZjRldWSjBn?=
 =?utf-8?B?MGttcmd1dkhwZ00rQmRZVXhrTzdOREYyR2dMZ2NIQWpGSzVvSlUxbXJHWVFp?=
 =?utf-8?B?VitaLzZOdjN1cTV1U0pVMUZLK1NDMWhtTjJTb1dBM2F1aEJ4ZTBBSXN6MWhh?=
 =?utf-8?B?K0R0YmNCL0FRY0p6bTV3K3Y3UWxPVUplOXc3TjJ2NGRpbFQydTZxRlJmL2o1?=
 =?utf-8?B?SkxWeURObWpyQlJrTCtOMjJOR3ExaituSHpWZTRLWTR5Smdvb2dvUjdyT0wv?=
 =?utf-8?B?Y1UvSUJaTzhZK0kyR2lrYmZmV01wRHhzYSs3WnNGcENLMVdmK2ljL250eWU3?=
 =?utf-8?B?M203TFJITWJJWkxtZXJpWEYyMDZXZVhZVmI5ZlMrN1dGcjZNUWcxUnczTk9u?=
 =?utf-8?B?QlVZbWxGU2lVTXRFSUxXM2dUMURSZUhucGNYZXk3ZG9VT09qb1RCTU5iVGRp?=
 =?utf-8?B?Rm9nZ05sd3pvQm9CVkVrc3RJdmdSV21UOXNsTFpUMFVxeWNvcnJrSjNzcmFX?=
 =?utf-8?B?bTJRb0pnMVlTRDA4TmxPR2crTmJMdEtZUVJGQVNEWG13Qng1MGpCK0FjR0pr?=
 =?utf-8?B?Vjl5SlJVK3NxNlN4cVB5c2g4elArUlVQblhaZTZVZ2pSUjlRUUhwRkpETWdw?=
 =?utf-8?B?VnJaYVdvbytUM2h5VXJDTUdobTZLTjM3L0pEWldkQUZucTloTldWS1FVT1lY?=
 =?utf-8?B?QlU4NnplblFVSnpJOHJKa1ZXUHVjN1NRcXk3T2JYNEc5TThXNVl6cnJTRU9O?=
 =?utf-8?B?Y0VRTWphWGhRUUVORlpmR2Y1RVpmZE9KcklKemVEaEova0tGeW5TdlFoaVZx?=
 =?utf-8?Q?5eMPXahsf3r0gjUw=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8ac596-49f7-4bf0-e2e6-08df2ab7f721
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:29:32.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg0N2jh3g2L7zxvLB04nGF88dQvmqngOfm7pjQ/7osRcfCdlxM1sfP+7OpYI78a9JTX4nIEyiO8rFS/Su4ylo6y3pKTugZKAOX6CdJb2bEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0414

Hi Imre,

On 2026-09-27 02:56, Imre Kaloz wrote:
> smp4m_ticker returns from smp4m_percpu_timer_interrupt() by writing the
> interrupted %psr back with traps enabled, which drops PIL before
> RESTORE_ALL. A level 14 tick pending again at that point is taken on
> top of the current trap frame, so back-to-back ticks nest one frame per
> tick until the 8K kernel stack runs into thread_info. Keep PIL at 15
> until rett restores the interrupted %psr, as real_irq_continue does.
> 
> smp4d_ticker and smpleon_ipi exit the same way and get the same change.
> 
> Broken since 2.1.36 (sun4m), 2.1.97 (sun4d) and 2.6.33 (LEON).
> 
> Cc: stable@vger.kernel.org
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
>  arch/sparc/kernel/entry.S | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index ea51ef52c952..7288da5f6727 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -252,7 +252,8 @@ smp4m_ticker:
>  	WRITE_PAUSE
>  	call	smp4m_percpu_timer_interrupt
>  	 add	%sp, STACKFRAME_SZ, %o0
> -	wr	%l0, PSR_ET, %psr
> +	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett, or a
> +	wr	%g2, PSR_ET, %psr	! re-asserted tick nests on this frame

The nesting is just something that could happen. Please change language
of these comments to reflect that or keep them shorter.

>  	WRITE_PAUSE
>  	RESTORE_ALL
>  
> @@ -353,7 +354,8 @@ smp4d_ticker:
>  	WRITE_PAUSE
>  	call	smp4d_percpu_timer_interrupt
>  	 add	%sp, STACKFRAME_SZ, %o0
> -	wr	%l0, PSR_ET, %psr
> +	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett, or a
> +	wr	%g2, PSR_ET, %psr	! re-asserted tick nests on this frame
>  	WRITE_PAUSE
>  	RESTORE_ALL
>  
> @@ -407,7 +409,8 @@ smpleon_ipi:
>  	WRITE_PAUSE
>  	call	leonsmp_ipi_interrupt
>  	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
> -	wr	%l0, PSR_ET, %psr
> +	or	%l0, PSR_PIL, %g2	! keep PIL raised until rett, or a
> +	wr	%g2, PSR_ET, %psr	! re-asserted IPI nests on this frame
>  	WRITE_PAUSE
>  	RESTORE_ALL
>  
> 
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9

Thanks,
Andreas

