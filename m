Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021137.outbound.protection.outlook.com [52.101.76.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A81E98EF;
	Fri, 16 Oct 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792130800; cv=fail; b=jFtmds+tMkpQ1P8gmHloj5An1ztYklhCAxnwGUHe4ETrXZgdF8BqBqR4H2LMMfy65Jcb1Z43FZE8EIL+OkdAQRli78gez4ObweMtfJowPHSD3uBUHpt26+WdGT3OGZuOQcCk904kKxHhK2h18u5vsTioSIvP3D8wvG2UMovRdUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792130800; c=relaxed/simple;
	bh=lyPIWBzS0Ew8wdtWSDeW8dvKlFREmqY648nGyrX9HoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3uwfgPRcDoq3eSBEzHNkrkaG5pELGi71JKOM+jfkEM7zKf3sNJo0T89r0i35cs9yOGO63uvwv4ENVCPDK1G+SbGOjsXj7oGkHSqnPAwcZM9svm6bGt0WgSkWdF8Jztdqzdk2VGHqdFnbZ7uQ82TZCj37NZirbm8n7FCFvRqo+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=bo7Gcbmk; arc=fail smtp.client-ip=52.101.76.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="bo7Gcbmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFk9KEoL2/ADNeAU8SKDoGEr1s7XzDuJG3Jc2i2t5AyJLUPyAx2HfbzjJoGTJYMLA+vuU+SO4S5syHnrhvrHcsw9c7Hp+7tSkxxEZNERVWyQP1eyDfXSPphCLWKITCS36w5FbKIIZKmfx6rzAsE/CaOBB0tGZRzK1BNsMARiX+jDq0DIYnCcHEGjl0pON44WJbrQNbDR8bvCfR/tG22q12ukwgdNHE2Pxy1D6jffvUmPRfZYNirG0tkx6nIoNuLb2C7LybYnuFSx2d7P+sL58ziFBT4ivDHH6yWke7r4LLTyqxWT8Xcou2tnYu9Eup8d/jiOd2RUQ6vkveIDoC53cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSBRYFsk1upOoiJsqJxb+rHxgO9fBr9PG6+1KhRZx7w=;
 b=Dn2kYRbz0xqB3ngwp5bIvgZFUArk54CFcufY/coCQg3HEvGAdBGAz9Z+Tb9uDGBXwYlo5uwAFZUhS+bbULLSmR3dV5jdsFA5iqggEwZEOmzpIhfii8M49A1naeRXZ6BhDZsKyF7Igix8PGIqkdY60HhWW/deX/EkV/rvVgigV18NKLmkWs3alltnlKoez5Pn7itgx9/t/saJHqrWIvrIWu+12ED+fFXFWGESNbaHWoXiIgmv4ujqnD1k1MvcoPMwN80N/SxhQb1ZTkEMrnTWNDy7O/paJzFtSmwVTshgbThpl1m/rWbPjh7j+bZHOcbJnGb4blfwmi7WQV+tSyqhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSBRYFsk1upOoiJsqJxb+rHxgO9fBr9PG6+1KhRZx7w=;
 b=bo7GcbmkC709hY9jjpcgMBtfpJHlLi5KQQZmxQ+E2tQWYweEkNHmAfgvQwUwcxiioyYNwMo0O6+2Iru3+hLDmkwlQiY51RlM+H01PqflRQh0p6NH24thZ5N+VTm59vmJgIDty/+BDlH+cUBM1zWpLPGic3SiKTcLsCqQrHW43IqmhwS39X8dpkWu0yYr8rtaXYOHk32G4sUcFb3Y3i2s4QV5l31LJ2Bf3t9G9FAhrNkXzC8SneFodxuJWyWodXKddHno4fSNn/5xZGINr4AbieklS30eRybxesb4FfbrxAL5+WkKAzXrNxbcaU/+fpGu0w5K5jJbsQKF32nVrlpw1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GV3P280MB1105.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:18a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Fri, 16 Oct 2026 06:06:31 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:06:30 +0000
Message-ID: <bdea5f12-e00d-4a78-bb88-19bee4c0f929@gaisler.com>
Date: Fri, 16 Oct 2026 08:06:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc32: keep PIL raised on the SMP ticker and LEON IPI
 exit paths
To: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>,
 sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
References: <20260927005658.8242-1-kaloz@kernel.org>
Content-Language: en-US
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
In-Reply-To: <20260927005658.8242-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::16) To MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB1058:EE_|GV3P280MB1105:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9b6ff0-f7b3-4a84-d1f9-08df2b4b9f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	VO+S+tbie+Tswtr1Waxb1vsagsYa8l4tWAkvicT95w6DB8RohnV7JoCivyl8f/AW2+hcPtSSY9Jr2mQt7o+BjGDGGIqO6vu0iiEv3YoZmeKnjblaYsNpn64xMHIjGptL95pY2WXFZ92XG1S9Vhx8AjhYvcSfZxkvguZhwa5wvKjNWjdOP3Twbb18uaCo3GhiuDez6/wUx4ZQa9tzU7zG4nMN8yOuL4jsjMzFwa+pjMp1ylrGT6rlxUkm4PRCLz9uC7uQFjX98TVXnwZrSIqaPWprI/DA0fvAN1RmyU/1EnNfrWA0V24WdcM0E6KqXyZncPM5LKWCjCxVuDuIQCJYA85YlGkO1wOvT4QmbJdRdmNaxf5chP6nIBqVb4pOjSxqqR8FDIEL0iE9HRaOKtTDOb2KyPDCf1WCp1fkHtbFWDEP58FzmKJFl6EFdunlcsEj8rcCV0T8ZvrKDnH7/eQ43B0izovssCRzW/eIituWOoobW8N8J3ItW566gz6V+9yxmGoyNpTAE1XxKeu0M7MlaqDeBTwQLiNt2y1GSugNYEZsLtZn+mTg8QRzQB9+rPMcAYPhLTQCnYk3ql/mOMu6vois7+Z5IgbWsAXYPRScqwwq2ZEkF+xpI1diOR60qXiUx1hPQuMJ6120+19gQcVuMV15CGVJRHb7IKpxrjUeP8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFJ4dHR3b2R6NUN5am5xZy9CNW52TkdPZGFOQ2ZKNy8ySW1YNUpKSnZaSVRh?=
 =?utf-8?B?SUdrNFVrNzJwc09XSFBmRTIxcTlXMGprdjNZRXZ2TnEvQXBORlRUdnZjTnp5?=
 =?utf-8?B?NEUzQjVlQWpYNTNSR3hVT2t0U0RJWktXUjc2NEVKK0wxeVliVlQxMlhzS000?=
 =?utf-8?B?WTJrTFNVRG9hVUw1dS9zWFlYUFBGM0NrVVBFeWswZXd5eWhJcWtMV3JwZ1ps?=
 =?utf-8?B?bEgxajJBSy93UEw5UkIvYnRBbEdmT0IybHBQRDBJY1pLQjBBZFpRK2hRYStj?=
 =?utf-8?B?OVFuK0lUb2s4QjloZTEyRytONnBoQzBtU3lMajhvWGVyZjlSSHpmR0lwNTFU?=
 =?utf-8?B?SWl4MkN4N3dxTllEMWVDTkJaejNhaTNLcWdVQ1JWUlN0ZGluOTk2NHF0SUtV?=
 =?utf-8?B?bjFTZlBUSUc3Q3ZGa05jaWVGV3dFNTk2RlRDQmt1ZytITVFDdVdsRzJOU0Uw?=
 =?utf-8?B?NmtmYTdDaVozdmRybGRpSG9LMzZsRHloU0ZxNmtvN0t1ZlpQSnZKMVJLdzFT?=
 =?utf-8?B?bW5sZlFOYnM2bTFuZ1pjMVp0V2lpdmJwczVjMGJLUGRIaU1zcVZudWhRSlh3?=
 =?utf-8?B?VXRPL2t4ck9iUVIyRmFhSDUzWWdidmRsZU41ZUFTeWsvSTRoMnBVNVc2bEFh?=
 =?utf-8?B?R2hoUThIL2N6K25hVlBYNXdpdlZPY2R0cE9FM1U2cng3dzhaS2ZCTHMxRVl6?=
 =?utf-8?B?d1krRDgxbUV4SjBSdlNLcTZRcWs1dGk1T3huK1JKRk1rVnord1lRakZseFln?=
 =?utf-8?B?WXBRU0dlejcrSDhhb2ExeVY0VFFjVkduaE5Dazc3Tis0Uk5RSXhkSnd5QS8v?=
 =?utf-8?B?QTJyM2xjSmpYMG9iVFdnMXIzdE0xNEFHUGt6M1l3ZlVCcm1DcGZibklFYjN3?=
 =?utf-8?B?UEN4VGZoWVZtOXFXc2JwZ2FsbHZGblRKQ1JoSjJOb2xZYXJMV05oRVdhNFh0?=
 =?utf-8?B?dEtlZWM3VExRV3RBQllScnhzc1FPdTFnbVhOcGxiM2hWRG9SeHREM3g0UEtT?=
 =?utf-8?B?a1dkRXoyMnRpcklRQUlmYUhnem1LaUtyVDhSczZ3dzM1SGIvZHAvQ0dkOXNw?=
 =?utf-8?B?b3ZqZ09XZ0dKaS9pRzJnZCt5UzBMUVpId1dSdzdxTEdERkxQc2ZQRmRlQmQ0?=
 =?utf-8?B?SUYxdGFTUTdvRVFoMnM0emxsbDQrK1ZnZ283YUNYUFBXSHhnMkg4QjB3ZDNZ?=
 =?utf-8?B?VEs2MzQ0cUNLNkQ1b01ORGZBYUZlVUZkRTd0YXQyYzNRN3U4WHJpOEoxL3Bi?=
 =?utf-8?B?TmRvcGxINTZWYTZRQyszdzlrZ3lGM1VYRXdLZ28yNERtcXh1akhEcnFTYy8z?=
 =?utf-8?B?NWZ2TGtGa0NLUXd0bmZxOGZxT211Z2dPTTlWTGhYcW5BSExOQXhEV2h2a2py?=
 =?utf-8?B?MHZSczk5OHY5cGRxWXEyRVh5dXpRdmlLRHJqVUZoNGhScm5zdG12dXFFNDM1?=
 =?utf-8?B?YURQbEp3b3o0byswWXNqM0E0L0xXaWVFWTkyM1lmcTFWRjA4R0l4MVlkVzNO?=
 =?utf-8?B?dnNBSGxnQkpaVXh2ZjRWZklIMGFxazVCaGtsY3NuM0tsMjlkMHpzMHpvVGR3?=
 =?utf-8?B?MG9RVzgwUlVZdkFJeHZMZ3lRSWdLbk1keHQxR3hsL05lSUM5S29PREZwS1pw?=
 =?utf-8?B?Q3FlWWdXNW50WVl5dHVjcWdSV01KejFHbWUzM0hwalNmUElnNnpKVkd1NmNG?=
 =?utf-8?B?VHk0ZndyWmFPZndrVmY3NEF3MjZyTC9LRTRpUlExOU9WU1pKb0ROL3VtNm5R?=
 =?utf-8?B?MVVDWnYrVCszTkdmaWZqRUtxTllMbzJKdmxsckRpNEkwTURrU0JSRW1razVt?=
 =?utf-8?B?K1IyVE96THovMkd1MzdkSCtFbVFIS21iWnRjbkNaL05IcnlacXdQRVE1WHE4?=
 =?utf-8?B?UVpFUkpMMUtlbEJuVU9EZWlBSlh1WmxBNG9ES29PS253VHF0QWZlaXJQZWtY?=
 =?utf-8?B?alRrVmgyckpKazVNbjVBYy9OOFF3TTJjTGFEZnBsaUVBTlFTZ0lkbUt4ZVhn?=
 =?utf-8?B?K256QysxdVExY2N0MDc0RkU1QVk3MXRGRkJYQ1pNT0NHNmh4WVJsdEgwYURS?=
 =?utf-8?B?V2QxVjR5b3E2bGZHVmtnRVZCWlNOQzc0M3FNMHA3K1hCTlF3a2c5Y2NhSFBv?=
 =?utf-8?B?SjNNczZUSE5TalROYWh2Sk1DZklCSEhxa0toQ2tMd1RCN0VzdTdQUi8waEtp?=
 =?utf-8?B?eitYaEJYZHcxdnM0dDVHRVFhUitjbEcwUHhGQXJ1MlZDQzU1K1h2bEE5Q1Nz?=
 =?utf-8?B?OHRhWlk0ZEx0UnBlYnhUWlFYSWNkRjRqSTE3UkN3ZGVNbDFmZS9YZzBXSmlp?=
 =?utf-8?B?cDY4SndpbHVvRFNLTlBSYWNjMVcvQ25ZNHUzSXdFeWZTOW1pbG1nVGtTNG5S?=
 =?utf-8?Q?QZbwzs6A9OOYJ0lk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9b6ff0-f7b3-4a84-d1f9-08df2b4b9f45
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:06:30.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mabSPEPGeJj5qc+0kmnPyRApETAXVHqo/Og1StvaCDzfudDP0jXVBcUvmD7gl0+a5B+3EsEcBCaOK/hnF3D6yRIK5l06P4jVacjgT6swEtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB1105

On 9/27/26 02:56, Imre Kaloz wrote:

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
Tested on a GR-CPCI-GR740 board (LEON4).

Tested-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

// Ludwig
