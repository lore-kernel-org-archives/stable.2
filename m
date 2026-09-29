Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12225771;
	Tue, 29 Sep 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646179; cv=fail; b=gWIsbnVGji+hj+xtfVLtqoB5V/ll/343zY0LEFaT4QxJV3b6Zzhh8rhEzp5ugRK40YdNJ6S2XwnOhlu2D0X0j77lXB8NQjVkr+kNV2Rs6A+XJ5lM5jfD4propGAWJiIofk7bustDur0/rwdDBQPCHW2r3tI04FcHaqS0L8hVMb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646179; c=relaxed/simple;
	bh=c2U9sMJxFL+HswbUmeB3XiX/8R7IABjntYFhK6tKaWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2H01nRYb0xU8JP6tLRikbKQzoUXtJ3KyGQadlw9PStYxJYXfCLBU+u7JGoS28aYPHrky7fnx6v57UmlWRf3tftQEWr1qhge/YRRkCdLCPEtUt0SZZh3T1Q/S/dUTcEnUBM3DgHMNVMwMHsekKCfEl3nyOAmbXjwh5PBIXu4C7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UGFig+Tj; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UGFig+Tj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCLxSuigt09Y6dQN72jcD9p7KkZAw+/Ont/Ideg5VzumLAlR4ZvgShJJiK4x9KjruJcukxBAqexJFtDig3Io0hy9FMltdPKDq5KdbW23xzIvFDN6yf0yWnpb4etPWykKMKhVZDhh5l8rk+nABDdOSSrKp2rRJkpqbYp76tL5GkD72w67PKFg3knI0MblfggQ9kA28RBxfLRU0/bpaly7nqPeeboAdffRDaxdU9SdG6EmSVTi1/ekB1pE+GosmIoD3PjA2UCidBjhYEXLq862LWWX/98AyRvhI1ny+sUAoErHoj7DHico5lPSz8WxJRig6SNYSdr3V0T5iMwmNqeEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONW8xKHfWICVDIQLFs/IVfQLrAeO+jd+lAMZYVfPBKA=;
 b=La+WQSnzsT/HzIMN6FPwWxYeX5ffvK9oGdnDVzIqLyheKoyTqNrowdw5y17iHeU2gcm55MH7Yr+iCn6D5h9TEJ2hr5Lq1uWheyWa0EcxWQDpY4Um43Xi4zBjPSldqyZXCXy3r73FcKAwKYChgICH6iiWVETg111GghNu10OilcW9mWyxa5VdKM08tvY65xDHOsYJHLiNJVNtiw52FXZdMZuNazGDaby7a3y+u9hFgA8JoyoDgffzNgEboTj9n6TpaunvLnLY9G0Yf/J54neLz4PbMmOieR6XtqLNZZtEwBGvEs5+RoRhcR28CtdE4ur7UzXNplamOEJSIIMqQ5yX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONW8xKHfWICVDIQLFs/IVfQLrAeO+jd+lAMZYVfPBKA=;
 b=UGFig+TjC3xIQKZDg9cVDY0IEj6HkpM0bCXq3jbd27E8Yy9xzD+z8DRoIkHT0XVdNyw5+Vt9mUXrrcUtiI/xz6px9PeR55vei3O96c1VbZC7zzOE+hQxkDjk7dYUWyDKcNwd/d3xOnYSGTLMb/dkk3bQKgYNXm1Kc2IW00xQ9seF7tFMC4+RpLj2RYXtI6d1Fnbcq1ws/O5SQ+poUiGZkhzftM1Oudz/kz6EIILVu2DWTQHlKteNDQ87868zTerVoAvmGuCHSkI6LnnLArYA6D283pqOptU4Ktc3ISCoXw8nXtjLfFOUZX4nS720GMYQ7xQnnpGI6UnTr+uIKFLMWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9)
 by BESPR04MB12562.eurprd04.prod.outlook.com (2603:10a6:b10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:42:54 +0000
Received: from DB9PR04MB9791.eurprd04.prod.outlook.com
 ([fe80::806a:199b:49ec:b4f3]) by DB9PR04MB9791.eurprd04.prod.outlook.com
 ([fe80::806a:199b:49ec:b4f3%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:42:54 +0000
Message-ID: <2bb40419-6e9a-4a7c-aea2-7e811037ed16@oss.nxp.com>
Date: Tue, 29 Sep 2026 09:42:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] media: amphion: drain message work before
 releasing core state
To: Myeonghun Pak <mhun512@gmail.com>, Ming Qian <ming.qian@nxp.com>,
 Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260925191706.3144437-1-mhun512@gmail.com>
 <20260925191706.3144437-2-mhun512@gmail.com>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <20260925191706.3144437-2-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DB9PR04MB9791.eurprd04.prod.outlook.com
 (2603:10a6:10:4ce::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9791:EE_|BESPR04MB12562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9c61e5-b003-4665-6c5a-08df1dcafad2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	dIXfkfAtZR924wTrVchadPHCXc0dF1bOYyQyA5GRLN0a5fsTWlZU0vr19yiktyqhm7XAGNKLqZLTNqFSZSsigVMLzB52CPolLe6QJaZXXdm2EMzPDyDk/bWTQoPy0YXs6kYUSOyf0dfAgQqE1T8bjJYm6TBiTuPO+gZc3PrgPy32J3No7C3ejvhnsOzsnFT7IDkB7jXIwMSVkDdxA1SBgI2h8KCmbOzN6NFAjkw3l69ig5I1ydnfgay/lgcjciRWvYTlgPHDY4lxC7LJSauiOHVQTXviSpEMVYd/PijKTG5Jz94S8US42WIEilsL2JhaGQN3iKi+TKoj+MoMeG1fEVFb0vLqd5k+CshyGSaQoCFtdHgzSU4MCkPoBEtT4REkxZXKqBjoAj6ymSE0QA/FuVGph3lgYmr2UeWb/QM8XARFaShzzES28kDoeVSSWw2UWoHew/onTqZ+ubh6h1CIkFUQbK07Uq9qNvXx9uKY9QiGfnKCKibiSqxzPeAC2cTY8cPr6mfj4Mnbv0dbKLFmx+3wY/ghPgPFd9TgwHUE2HiPgSaa9EdSpJQaW0kvUbWve6FdGoNQTS8GMZ1ay5bEc0pRcZKyB9XAymhNyHyu+XYgLcCaK/y0WipKOJaV7LpQ5AdhteOQJpDFTk8nBI0/hTcvSVAULRde4NZfLJFCoZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDRPVkJwMUVDSFFJZlVHOWRreUo3OU5EbW9GUVBzS0NmWlBuUFJyOE9naG80?=
 =?utf-8?B?aFFoZ3JFMGxiMitDcDZSaVo4Yk9WRWNDVlZTc2xwVEpLdXJOWmRHRjgvSXZa?=
 =?utf-8?B?UFdrTWFackZZZUJZcG5hY1lRY1ZJNG4yUHRxeEs3N1UvZU5Idy9lVngxVWJs?=
 =?utf-8?B?c29QSGhkaXpScFZFaExVNzQ3bm8wVklYVWhodFh1bzlqL2hJL2xSb2tHdnVL?=
 =?utf-8?B?TUZweDhSak5IT0hCVlNIbENvR3VjdGdoQ1d6NVUvb3dQQlQ2WVU5TENiZXFI?=
 =?utf-8?B?OHJlUkE1SVVQN0tJZU01SG1waDdxanFVRHJHcHVMNmhCZEtwT0RmYkVGZFVs?=
 =?utf-8?B?YldGeVdvRlcvVjREVjNuZHlJSGQ2MllSN3g1Y2IvRnZkTjNqV2lXWXhxRGVR?=
 =?utf-8?B?bzg3YzZIRHdOWmI0TFRlVnpmdC8za3pEclExTXFKYUtyazRLdXNaeW1haVdF?=
 =?utf-8?B?dm9KV2lnZG1QeE5BeFpzbHEwbjdRSE5BSnlERGpldFVYUGM4enVqRm1ONWt4?=
 =?utf-8?B?REJxbkhQR1hPZnJIU2tibENjYkdWUi93NXJDb0Vkd2lQRDduNUVPVHE4RnVK?=
 =?utf-8?B?OFRXTk4vYWl6R1FTSDE5Q2ZQclVieFdDV1VMcHgxTXFIa2JUb0Z2VXBnRDRq?=
 =?utf-8?B?a1pUOFM0dno2RXQ4dW1hVGcxdHNHMWRqc3NDay93QnhvZlJFYzdianlieE4z?=
 =?utf-8?B?WVNEdTZtQjBmT1c3WklFQjJGOWpmaUxuRE53cGZPcGtBLzd1RDIwZXdFZ1Nt?=
 =?utf-8?B?bjBlU2FQdUxESC9tUVBDbmRBQlQ4RXhsVVpsOVhYWTJrZk14ZlNPS285Tm9X?=
 =?utf-8?B?VXlSdnlyMnl5ak45RWwrNlBFelp6SE1oTlZMQUlxWDRXR3ViWTU4UWxmOEJI?=
 =?utf-8?B?NWJnK3lMK3hTb2pERWlGT1JCTzB0UEZLSXk5Mm9kVjZhYnNqQk45NHNBT2xS?=
 =?utf-8?B?STNPMk53RmNuVDBvQnpEMlZmT2RZMmFuM3J1ZlZrOVNhYmppbjdKRVN6NEhS?=
 =?utf-8?B?WGtCYWdYTlNnTGN5N0NXQmgvQ29FYmZINm9UMlVSZUhrUDY5Q0dQRHR5V1NQ?=
 =?utf-8?B?YzU0Q29yNzNzaXhTajFLd0FzT01TTmdLYWMzRmlPbGVpUWk3NnJvSnp6QytU?=
 =?utf-8?B?MnphdGJ1SElnYmZ4Z2d2NFpzbkpzT3k0b2ZHaFRmaUJnelRDc3o3M0UvcVF4?=
 =?utf-8?B?ZGdsNjhRUDIzWXRLTzQ2TDlqVEphUFd6emNDWnZiRXZvZGFtT0hzMG1DMTNR?=
 =?utf-8?B?aEJHUDBMcjg5NGtKajJnWk5aWEcwZE0rV202WnJHTFBxQWFBWHBFbjV5eHpj?=
 =?utf-8?B?cHNONlpJem5PYXkrVVU1cVF5NHBTWjNkUDg2Y1Rkbi9IeFZqNFYyZ2pGR3pj?=
 =?utf-8?B?alJESkowckdaRmw2QzBXUTlCSXo3L0Q2RHlMUldKNEdDeDgwMWFvbnh4bnAz?=
 =?utf-8?B?azJ4dE1MVnc0Q1p1NGdGT2ZpSTdPb1V6TGtmaHIrOVBuSDlsdFJzckNBb1Bm?=
 =?utf-8?B?dW1PcFFDV2NRYjdmcWhMd2FCZ081OThBaWVwSndOQUo3cXhHK1hiTGpDNEdE?=
 =?utf-8?B?VUVlaFphUFVIUncrRDIyRjM0NkxPMU43eTZUZ01kWHUrclUvVG85UEMwazQ3?=
 =?utf-8?B?SDF2djgrS0FLVEE3WDZ2ZXg0YUVoK0xESkFaYTRtVm56cExYVnN4ZnpCT2Jw?=
 =?utf-8?B?RU51U3d2SHVuSEhoc3RVNEV1cEJQSWRYeWV5UDFmSHpjVGEyQm1EcHRPRWJI?=
 =?utf-8?B?UlgwN05rMS9kSlB2S0xiTUlLMEhCbzEzMFdyZy81akY3MWdkbERkSEJTTGIr?=
 =?utf-8?B?QmZVVC9FV1NRdE0zTUpGakNmUTl1QnBpbE82ZGFmTVBIL2Z1andCQjluQ3Jw?=
 =?utf-8?B?Y0pQdnhNREp6dVdFem91bjhsSURBVkdwK2t4amFrVzNnT2p2MFAyay9YeXY0?=
 =?utf-8?B?VW4zSU9ZR3VQazRsQ2ViSmFSUk9NQXZ0YWp6V3F5ZmV4UG96S2s4UWdEdGpI?=
 =?utf-8?B?SE16RDk1MzE1UUNnU2huK2F4MFAzRG54TDdaNm11cG5XbENtbkVEeWlGK1Zl?=
 =?utf-8?B?NE0wcUtoVU5TSU1pMlJZRTFSbS93OEhKQkdlK3BBMWZNWVBRQmFITmxQRDk5?=
 =?utf-8?B?aUo2QUZnakJOTEVmSGp3RFgrSVNRS2pJdklDbmhVZTNZUDVPSkF5aXovOWV4?=
 =?utf-8?B?QW5UNk5TbUN4dlgxKytIK0RudkdSR0ROU20wcXlCRE5GaVpjWWJZZjdFNGlr?=
 =?utf-8?B?OVVIV05ZYVpvUi9sa1ZtL2dyYXdPUFhwaUlwSnZWdHlvSkgyZW12NmE5Kzlq?=
 =?utf-8?B?TkJxQTRjeThmS2RRRDNXV0xSWklXZjlQTXVTeS8zUzZGK1ZxVTN2Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c61e5-b003-4665-6c5a-08df1dcafad2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:42:54.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3j1u2mnhG+jXu+IlNatzJXj8QVsfevpMz4AgNtuo6lW/va6JaIg37sewxUsfK5tQBzK3iW/Pbh7RsEXdFLF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12562



On 9/26/2026 3:17 AM, Myeonghun Pak wrote:
> vpu_core_unregister() frees core->msg_buffer before cancelling the message
> workers, although core->msg_fifo still uses the buffer as its backing
> storage. A queued worker can read it after it has been freed.
> 
> Drain the core and instance message work first, then release core->vpu
> and the FIFO buffer. This follows the ordering in vpu_core_suspend().
> 
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>

> ---
>   drivers/media/platform/amphion/vpu_core.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
> index 85cc4a14f8ed..a0c58ec97a42 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -299,22 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *core)
>   	core->vpu->put_vpu(core->vpu);
>   }
>   
> +static void vpu_core_cancel_work(struct vpu_core *core);
> +
>   static int vpu_core_unregister(struct device *dev, struct vpu_core *core)
>   {
>   	list_del_init(&core->list);
>   
> -	vpu_core_put_vpu(core);
> -	core->vpu = NULL;
> -	kfree(core->msg_buffer);
> -	core->msg_buffer = NULL;
> -
>   	if (core->workqueue) {
> -		cancel_work_sync(&core->msg_work);
> -		cancel_delayed_work_sync(&core->msg_delayed_work);
> +		vpu_core_cancel_work(core);
>   		destroy_workqueue(core->workqueue);
>   		core->workqueue = NULL;
>   	}
>   
> +	vpu_core_put_vpu(core);
> +	core->vpu = NULL;
> +	kfree(core->msg_buffer);
> +	core->msg_buffer = NULL;
> +
>   	return 0;
>   }
>   

