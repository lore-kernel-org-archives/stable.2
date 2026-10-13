Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CC4E73AA;
	Tue, 13 Oct 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889269; cv=fail; b=J2TBQNxRtXPC49GXA/3akc37hTMAmEPy+vNmmXv31PJapwFCd5BfVG15nxkDX4F9ElcTuKLqEcpJyUKiO4Ge1FWfqocoVg2wY5KHvo3tSjJ1z+ez1mxNShIeJUy+glhn5AHJq+f46mqE69rFGgvDyb7qFt/1Xt/Eyqv6kWpt2SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889269; c=relaxed/simple;
	bh=glZEhHEw6yvUDoOAOKJL3Ry+TWubFj4GiDGivgaLPdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TOyYokFDsGE/o/3orracdsaMf1zcBa+uzMgxFR+RA1VOh0d3wR+IYqkxQ56S5AIVzGacgOlEzhe+Wp/mIkqDZMm6WTrU1/nON1c06qXpz2p/uJUUX+8DzIq3bHC+4nz64YYdzkhvq7/jD7U5hM897Lz8PL/ZBC27Ij/3ijsSQzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GirZ5AAj; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GirZ5AAj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRSmipK/pkCi205sR79kdAYlpQQWNHrqcYM8gXHjhtulv3jF80Mj3UASvx3F3Zr4p27ng1GBjcMn8FyTSJrgdcgn6pnlFBNOhBek/zMqZehlsvZfH15OCcCiEqtigM1/skX2gTcvaQ4Se/B9KlfwapwGP375LoBzoSyTtvmNNe/k1Pol63OiR5xLzyPzWI23HrrUwSACs9sbLt8DP8ubLCw2aH+Jph5awJyaDKxb5BZ3baPeNvoNaUwvqIvfvrLPoW0HowJ0EOq/Ux0FWF2s9ZCbWQSC8yB+jpsJ323idg9KuSr/HDz9z0izddHR1aMCl5RZYEne45pi3kbr4GM80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIlwWl9VvuRB7lZ2V3SV5Hbe0z7vUL7H28qfYAitlI4=;
 b=uSfLO7tLa08CnDJ4JsOXv+KFEaRIb86F8pNGx6q1I6WUq4y247BDWIosOmpguuzLG2EYsqmcdmBvcaUeK7SidJWzyKWKTDg+tS830avBpMa8d98wVhXOg95AEqeIJGGGY/Qso3B/A4LChRgdtK+XpUMLkATT/+2LVNYcaJyhQIbqvgCESnNEBmYL57dFhvBifrxk5239EqoIG/I19pCGOuq5J1XpKokONqdRcetqNMa9KgYV8YAVFnq95WtxBuntx2wIXdKUX0cNprwvk45QERKc9k2IOlEqXjcssNcwDWvl+VZo+PT3O7GA9rZpyto3HBCkPSfMs2RJhWKyukSM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIlwWl9VvuRB7lZ2V3SV5Hbe0z7vUL7H28qfYAitlI4=;
 b=GirZ5AAj3iq1U1q47Vdn1ynyjiamo4eHw75YRI0fYLiNcasoHAsLhIJ+GVYz2zNTIw5fNn4q9I2OHZv1NKNJthfqtMY89LjkhPmYW1eZB0D7mAghIhm9x7FCwxBQ8FEVuGDJkdg15P09fcKkWGm1O3Rtdzt4BqIeg6NH/KgUUxHShInWwkt8y8KZ26akgPTm7zG6FQwyQmTK0qJNq/J8Ryj51ImU5rztAQebE2K4HPZStQKCRPx1lPYknmvnl78Fq0RcGEx4oues2WbeYgfrhVuu8sZ3u4f+NPxhEEE6ckA/TUakqMdH221HkuulSD3a55ZvSel4uEHAVi1BGknc0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB021426.eurprd04.prod.outlook.com
 (2603:10a6:20b:78c::16) by AMDPR04MB11607.eurprd04.prod.outlook.com
 (2603:10a6:20b:71e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:01:03 +0000
Received: from AMBPR04MB021426.eurprd04.prod.outlook.com
 ([fe80::1cb3:7fae:cd68:6de]) by AMBPR04MB021426.eurprd04.prod.outlook.com
 ([fe80::1cb3:7fae:cd68:6de%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 11:01:03 +0000
Message-ID: <54e1f3fb-136b-45e4-9ca9-6c73383851ab@oss.nxp.com>
Date: Tue, 13 Oct 2026 14:01:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/nxp-stm: Register sched_clock once
To: Juhee Kang <juhee.kang@redhat.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Dustin Black <dblack@redhat.com>,
 stable@vger.kernel.org
References: <20260913133645.1102997-1-juhee.kang@redhat.com>
Content-Language: en-GB
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20260913133645.1102997-1-juhee.kang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::24) To AMBPR04MB021426.eurprd04.prod.outlook.com
 (2603:10a6:20b:78c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB021426:EE_|AMDPR04MB11607:EE_
X-MS-Office365-Filtering-Correlation-Id: 186615d7-5e05-4b6a-f43d-08df291945be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|22082099003|260925021911599003|260925022911599003|260925021311599003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gaAhXNS1eK7bKPtZbkNGMArM/hGV5TGvFSLrxfCyfBnX9cHMyqvNPR1DXPKF996gCKvG3lU3k8SHFBu3IFr/BB6rnUEYXX2KF1AGkwh0rTEo83kBHluciFaptBl+ypBReeU85pFOx+7yJ/Iwzk9B50IKCIJfyCLX8++tQ74mdo6B8lnAq/59TV+DrMO/iIhxPiDmvtwMYS2x40pVvrt/IR1VkHnFAK29kSkRhrcizWGryhE4s8iu3r1Pw52jjVMns58LW0eLRynFdxlF/l6DlwaaqbP2Yv2BqlQPVqFWptdY2pY1xwXJQ66HyUr6WVO78/C2GKACQNjkh2lSMvCilGltI2fKKhqhGVik8j8LCf5P/tDVIHVHJ7hv0UQTI2Cf6AbRaMeSrgJOj84eAOKwZQvbw8J1k+lk2+RFHyhC2puxLMWThLEUMisnh05gP3fExdVFNklhhuPZ2VrVebdCqkYxUuLRlR7Z+Od0rLjSwESZnDykrrIlQZ9Pvv7RwKeEZXXAuV22PzzNEXu3zUWNswiJQG0TVINKJoJlZiZ9uEcvevR+YYnKb+rABtwHdzlbF+jSUjE3EPtuP5lSO+eJ/1Zwb82iFpAZWMrCvi/FiCUncCnRtjO128bzOG1Zf5KIk2j1/m3LVHiqODBRJ/I4NCUgupNhul/smRnjqbNv/ZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB021426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(22082099003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3ZxQzB2YjJ5ajFTeGpMemFHdUtlTmRYTWZab2dOc0NIVjRvZ3ZoOU1lVXNW?=
 =?utf-8?B?RzkxZGNTZVJ2cE84T1kwWitGQ0ZQaGYwRU1tY0dua0JGclYvalhPQ3BSUVJv?=
 =?utf-8?B?MXdzcUp5czVXR1VNMnFaL3VhaWxiYkF0ZkFDeFdTdk9tUG9CdVY5QUFkYmd1?=
 =?utf-8?B?VjRXczJJQ2NFRmU5bGpidGlHelBCc1o2OWorY3NXaFMyYXArS2dmZklnOStK?=
 =?utf-8?B?YjBpSTQ5QzBjajUzVkU2bjNSTXhsNHh4VzA5RDYwRm1UejlLbXpSWFo0U3FX?=
 =?utf-8?B?UEtKeGxWdVJpakNlYlg5YzBVdUhSTXZrcUk0MnQyQWpzNk5vYkdzZTFjQ0Iy?=
 =?utf-8?B?QlNyNVF1QjQ3b2FoTFRXTTZvOEZpcFpUVWdSWWxLZjY4MnNER0pRbmNPbGZ5?=
 =?utf-8?B?NkphODBQaGFBY0VPR01oYVVkMW1YRGFkRmJHeTY5Y2RWVlNBSFl6aFVkdVVT?=
 =?utf-8?B?dmVJMGNKSGFxbjV0cFJxeW0rUjNWTm90MDRVODRiSzZaLzc3RmdtZWxDSUpN?=
 =?utf-8?B?N0Z5S1pXdzdRdk5WaXltZ0YwVlpMZTNBU09iYU1Hc1IzNWRWMWlmR2ZqODF2?=
 =?utf-8?B?TWZXdzZyTTdubVU0a2U0b3gwYXpoWnMzcVBQYUV1WnNSYzVBN1FVNkF4RFd5?=
 =?utf-8?B?NTRKb0w5VDlQS3VXbTBuZWxCeE80WDRSckxrRnVFQm1oZkJHU2ZFQk4xVUZv?=
 =?utf-8?B?MTViOW9TMWJOYmxzeExheWJwQXBucCs0K1E2ZGt5ZDVOLzE0RENEclBYOHgw?=
 =?utf-8?B?UDEwaCtDN3ZqUmZaQnY1QktYSkwrNGZua1NZMkt3ZEVCOFU5QTJtbVBEVHlr?=
 =?utf-8?B?SFB2N2tYb09DTTFjRzZPNk9uNy85RjJlZm1WTE11ZEJ1S0lzRGwzNlZvT0Fi?=
 =?utf-8?B?QmJScUpFNjdYOVVydWFtQ0pqbllub1BPUE1Qc1pwL0hCRWhRU3BiM085UVB5?=
 =?utf-8?B?d2dtSXNKb3Y1VUlsWEFMN1dvYnRtWEVvbGtqWkdPRnd6MHd4UTRtOWtuRWtz?=
 =?utf-8?B?VGowbEdYQWVWZ2orWU1rRzdBU1kzWTBNZlg4dTIxVjY0WVdPTUxBekxnZWVI?=
 =?utf-8?B?NVdudkI4czh3a3VLRXAyVXdGbkMwa2dpbWN4T0ZHcWRLWlJEVzZkdlhwSTBn?=
 =?utf-8?B?NVdIcDBJdm0yUE13VXgyV2ZhZ2hiN3diYXFJalpWQjNLN0thR2cxaDhlckZl?=
 =?utf-8?B?b3ZCZlA5ZEQzMTVEaGhVdUlWUDVHaWtxN1c1Q05sdnN3VGN6cEc4U0hybDA3?=
 =?utf-8?B?Nml2ZEw2ZEErN29QcXZubmY1alltbnljK0VFN0ppcGR2Si9wbWdzOFBobGp5?=
 =?utf-8?B?TENFbXNsWkZoQXZrNGwyVVc0Qzdnc0ZSQzIrTmNxRk5taVBJczEybkt0VTFU?=
 =?utf-8?B?d3ZLNG10YTJZYSt6Y1ZlQVRGdGFOZVNEWSt1SURTQnJWL1I3N3JHNGtuWFE3?=
 =?utf-8?B?YnNKSEpoRnVHRitkRWlJR1k0Um9KclhkdmprVTdaSDUvemE4a3VReU1VUFMr?=
 =?utf-8?B?d3JYVTVsbUZrK0NHK2FvU2hpRW1OMVNRb2swWjB4K1I2TkU1M1YvTGo3TTVO?=
 =?utf-8?B?b3Jvczh4Z2tiWFZFMi9OLzNYV0Rud29SMTFoZWRKQWsvakJRYy9PcmVwaS8x?=
 =?utf-8?B?Qm1UWHhzbkV3aXhOVUx3cS94Tlg0bENvT0gxeHlyUmxqakNsMDA3cllqd2NT?=
 =?utf-8?B?N2tnVnZSQ0E3SVhXRUtMYnNRL2RTLzRML0lQRGhqYVlYaXJHbGh0MDZXWXU4?=
 =?utf-8?B?R2dNUk0wdzhzNy9EVURYcmFndG04TkxtMjFHU0MwRkNDYlQ3c2MvM1dnMVdP?=
 =?utf-8?B?aTQwUnZtbHF1M1prS2JFeXIrSG5SRkE1K0VjUWNSa3BWRW84V0xjK0VlRTg1?=
 =?utf-8?B?cXpueW5xSkwrdzJCNzg0RGJLNWJIQWZ4aE5EMEQ3STR2RnZGZ3JsRHhpWUNC?=
 =?utf-8?B?bGxkQkJoVUlYWE5zYkNsR3lQemlHOWczUWNBK2c0MjdpWjJGTkVMNDIwZW5J?=
 =?utf-8?B?Y0F4V0UzRXV1NTdiSnNZcUpsaDd6Mlo3QmdNLzZNUkZYVWJOdGhWWXdNa08z?=
 =?utf-8?B?bVlXNXJJUy8yQTNlVTZLTDF4ay9ycnAxZFZ5eXQyQUNwTFFkeElXN1R4aGR3?=
 =?utf-8?B?TVBWT2lNVStoR2d1NGhVRzU1MUNBUHBNanJzWmx1MGpFUGgyWDVmNUNLM0hR?=
 =?utf-8?B?cmlrMGlNaXBUeC9XZTVxU214VlE2QW0yMnM3bmtzSmR6OGFCMGhpbU1ZOHp4?=
 =?utf-8?B?T1RPZXNzaWVhMlRETGJtYTErckE2RTB6U3lzYW5TY3AvcjBRZnpPWWorbGht?=
 =?utf-8?B?MVFncTRYb2drekhBL25hcXZxZmJHbzJFN2ZYLzEvZVRXU0FVUDl0ajJZYWd1?=
 =?utf-8?Q?xCr36tThpF6+UjFM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186615d7-5e05-4b6a-f43d-08df291945be
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB021426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:01:03.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mr3NbeSCp6qSJ09fjfRfX1OvXelSQXQksLxyH2sxLxt0heIbuGB1QRMFUbxc0qEfZb3UUQJCDzELMHYqWaCCehP9h8WKsNkOzQyDUPuZFkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11607

On 9/13/2026 4:36 PM, Juhee Kang wrote:
> 
> Each probe updates stm_sched_clock before calling sched_clock_register()
> again. The call then subtracts the counter value saved during the
> previous registration from the new STM's counter. If the new counter is
> smaller, the subtraction wraps and the timestamp jumps forward.
> (e.g. from 0.4 to 32.9 seconds below)
> 
>   [    0.403653] sched_clock: 32 bits at 132MHz, resolution 7ns, wraps every 16243448316ns
>   [    0.404056] clocksource: timer@40120000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 14456668980 ns
>   [   32.890509] sched_clock: 32 bits at 132MHz, resolution 7ns, wraps every 16243448316ns
>   [   32.890882] clocksource: timer@40124000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 14456668980 ns
> 
> To fix this, register sched_clock once at the end of the first
> successful probe. Clocksource and per-CPU clockevent registration
> remain unchanged.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Reported-by: Dustin Black <dblack@redhat.com>
> Signed-off-by: Juhee Kang <juhee.kang@redhat.com>
> ---
>  drivers/clocksource/timer-nxp-stm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
> index 6fe098a4a33f..7572cd20732f 100644
> --- a/drivers/clocksource/timer-nxp-stm.c
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -211,10 +211,6 @@ static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_ti
>         if (ret)
>                 return ret;
> 
> -       stm_sched_clock = stm_timer;
> -
> -       sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
> -
>         dev_dbg(dev, "Registered clocksource %s\n", name);
> 
>         return 0;
> @@ -473,6 +469,11 @@ static int nxp_stm_timer_probe(struct platform_device *pdev)
>                         return ret;
>         }
> 
> +       if (!stm_sched_clock) {
> +               stm_sched_clock = stm_timer;
> +               sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
> +       }
> +
>         return 0;
>  }
>

One optional nit: a short comment above the block would help future
readers understand why it runs only once, e.g.:

/*
 * The STM instances are independent counters running at the same
 * rate. Only one of them can back sched_clock, use the first one
 * probed.
 */

With or without it:

Reviewed-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>

-- 
Regards,
Ghennadi
