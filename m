Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9151B173;
	Thu, 15 Oct 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064430; cv=fail; b=UJJzFiU5M+g50OdMfx3CYmc/WYbcuOqNVWBL2A6vJFj8+QYej0RPCWKaO/0FrY0RKzhmnatfH4wVEfo1pkUV1vPaJZ/3fmDEgbgoK10FuSoWcVH7+fgijJM0FkOhOIL3Tdw/kys8zM0nMe03RtKX2K/JnDbivgWhJrPRzXL4Kcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064430; c=relaxed/simple;
	bh=bMIfvdzqSwN9TRJQcwr7l8gVLdNRh6snTupXkbVswdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WDY62U+y7T9CvJS8kO28LXhFbn/Gxd2OD4M0DFN2CkKZXqJ5e9bkQY/hCzu3XDWmSsLQN8p4kmGeXExveyIKrOlcQ69CQ8GF9ktnI9c5mA9L9QNGy53Q0s2WfmJAhvTcRU1GmrM6LEfw4cks7DoQQNrsFyb+s5AZom8svpn4OBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=M4snPh/Q; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M4snPh/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAFIb8hZFJiCBprwgdEGoiz1m792azAGVOJNHnMnsYwyLWfa0il+JW3KgODk41+FcE40zYvg9XdYYlZVyYQyNiM8xOQ76WLU8Xq5uPz3UMUOsJwRyBKIWB54gIcbMalHwASkHpjILAjVav54bayOi39wmE1Rxz/1tuY52KWAse2ZKLVVxXS0RP43leONYV3SUvxNsTw8NHVNEFzN4FbB2A+peW6hQFtGsV7vi3zKKAS/byLh4JF0W1OVDZZHEYWLTi/rGLD5hXYeGDH8n8b7w/LLuPX9svfOR7+JWMtSfjB7cR2Naww9Ibq8ZGvqcIPhnmHxB7WE+AJzDaQnDSmvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7guicA1ee6KMFvHr7KiFtQmcaxpSVeQQQ/sfrssbLI=;
 b=EQ2/Cvvmxq4IRh60iVn8c3Ef2EzKSqh8stShpGZPu9wJjRWCnb9f0TH8tFZ972NTKFV6CnbAs8pbKaNRE5flnKFzOudJKcQ9gVOQienN0/3tMAytiQ2NmrjNOwkhGAKZNZB/bjnhaaUUM/0Bcym9AuTOxcAlLUzwV5gash/iqJ7EjdEmbcJj+oXSUdZbcP840KiiJdhxpgIXsT87CPtDUhmQPp9x/OjB5gmaiPCSGOnVosEZcwIzgbpJKuY0ggGeOXXKff1ZqGsN8Q1XBOAMY/Fbcxe/N+DFZVrF756o2+lNo7D2VUFlGhHLYthCPC5XB33oZ7OEd7g75f8fI9RZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7guicA1ee6KMFvHr7KiFtQmcaxpSVeQQQ/sfrssbLI=;
 b=M4snPh/Qme60/Y0lMYKBTx0VeRmAodPb0rvn4JKhHFE15BmLiCqHvhiXzpqP/74wCAS6GGmr3+Ci8VXsPNHisgQ91ZeVYvhJj8/9uwST0uCrQWplkKENFFTFbMoSA4QExuTKJKqK0aMma/stia3lZc2nCnR6CLG2jVual/mWHeXjzo9usJBTjuEMVDOSI02GXCc1yUl28t34rwcZ27LlII8Qgtifx1igia9/mxifHlsSoHuxFN83tGpL2vMolEH0lQEmGIqVDCpd8ZWM/zSX2Yrza0MShr66m6FtjvEs9K+PF55w4tIgb0tOhmkjxhEUSrewNrr6gWwK3LgCFVSZkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB021426.eurprd04.prod.outlook.com
 (2603:10a6:20b:78c::16) by VI0PR04MB11867.eurprd04.prod.outlook.com
 (2603:10a6:800:31e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 11:40:14 +0000
Received: from AMBPR04MB021426.eurprd04.prod.outlook.com
 ([fe80::1cb3:7fae:cd68:6de]) by AMBPR04MB021426.eurprd04.prod.outlook.com
 ([fe80::1cb3:7fae:cd68:6de%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 11:40:14 +0000
Message-ID: <a626dba9-6aa2-4cf9-883d-8c6f94770d6c@oss.nxp.com>
Date: Thu, 15 Oct 2026 14:40:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/nxp-stm: Register sched_clock once
To: Juhee Kang <juhee.kang@redhat.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Dustin Black <dblack@redhat.com>,
 stable@vger.kernel.org
References: <20261015113738.435986-1-juhee.kang@redhat.com>
Content-Language: en-GB
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20261015113738.435986-1-juhee.kang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To AMBPR04MB021426.eurprd04.prod.outlook.com
 (2603:10a6:20b:78c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB021426:EE_|VI0PR04MB11867:EE_
X-MS-Office365-Filtering-Correlation-Id: 909a761e-1647-4ab4-42d5-08df2ab113eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|56012099006|11063799006|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Supa+lngm36bXANZA6JqShM/Zb0vY5jcGNiO5mLkXWTMQ0F/ecU7gW9Sg0i6myBzBaUdqXMrgB78UpZ6yKjhLmGx2a0hFE5uITcoAPxFqazpeXEeqymnyQrD7wMSkR/irs/0mZ0scT5R8s2WGLglhQ85WmlYaKRekXMMlmunevjE3Ymf6GP3slf+wCH0LbWIUxp13DFc/f2UbTekzHxk3Envumport0zkjCYPzFku+6YJx3tVC5/lWn086Kr+PHfuDine7CUPjoOYVVasdwfc0IhA7CDm/Efk/yaZI3SSZ5Q5HwZfG7TqbBrbrYL/kbYt3DqIOdMdqiJiDTNszyLv7VOifK7fJyuvAPbcSbSbNvy/teBPNB7g0K1vIBUvHaD/7FOrkhEDwbJSF3sAFnm49sk5zx5tYIwEfXBTNrkWVPYpbxZmpxmSNYISR99xxJDytU2gr99R0NWuVDwmF1t+/nBIfyT1mPcGMSdYS3M9/NqlDrIBFwtvdUFCb0rZXW+yfshf0eVRimUP+spgMG9UUGrk0h8ZrNxwT3tn9w9967+gblSAGGkH81OZ63vTziE2PL4TNx+lRxwtWKRIdPirqsNLiSVP6uWDdY9YBorM+DBEGOL1ZYExo9UfAapeIprgdPWGTf1LZJBfq6N1MlVn6+SVMksdYA2xQXBaMl6HXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB021426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(56012099006)(11063799006)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGxud1hQZTUyTzV4NlpsaXZ3TnhKUGNIZW1kMU4vV3ZyU253OEZkY0J0N1BH?=
 =?utf-8?B?czZIT2lUMTdrYUMrZXEzNUc2ZFlMTE9GV1hiTEVCWEVZUGoxaHcvbnp1eDE5?=
 =?utf-8?B?cXB0bWdFbnJTYUNRM3dYaFZOd1VxOEtNaHdlU2JsaW9zTkpPaWF6MnFrVk5Q?=
 =?utf-8?B?MlZTRGNJTkx6RzVXY2FyZHhJc25aNVN4MytSK3JpbXlkTjBHb2FpNlJuVDQ0?=
 =?utf-8?B?TklmRzN0cW56R2E5cUk5cktJZ2U0dzhDRmxZMFh2bkhNUFFjVVdMQjN5UDdZ?=
 =?utf-8?B?ZERSb0VZVGdYbUdST09WTnY4eEswNVpUMzV5R0dHTVVrcEJyR1d1dXRRWXpa?=
 =?utf-8?B?RTFRMFBVRVN6TkhjSTBjSUNyREdXdFRaTHFteE9DeGI1ZHl2OGdPdndEMm5O?=
 =?utf-8?B?UVMxTTc2Tm0xNXpzcmVNV0I0Rmx6NjNCZ1o4cStlQ3l4V3cxaVdUZTRNV1pi?=
 =?utf-8?B?VmViUXlNeXVyNUgzTkpwTHJLNSs1SWVXaXV2ZE9rUmJLdGdhcEc5WlNBaThh?=
 =?utf-8?B?TlZrNWl4MSt4ZHRJSmRObzB2WnFXdWlpajFtODZIR2VLcmZJVWJWL3NrUHNN?=
 =?utf-8?B?R0dKUjRXSHZtQyt1MmhYWUgvMlZuWGE4OWxYbjc3VGtGQTIyUjJtNE5aRUVE?=
 =?utf-8?B?cTZ4SmFCSTQwTHhsais0Q0I3c3dod0tCcldxejJjcVl4bE5vR3IzSmJhWVhh?=
 =?utf-8?B?QjVadkpaSGNBN0FDU0hlU2UwMjNwamRKNGMxS0tVYlpCQ3dVTjI5aWs3bWtn?=
 =?utf-8?B?bFlQYi9kZnR1T3hLUlY0eUNlYzc2VTlDYlc3RnViL255MHJzODByd2tiTWhv?=
 =?utf-8?B?MGNXdVFZMUNnZUR6RWRMRXFnNzRMSHNXVHdiWFp4emFQTFZCdEpXNHdvRy9o?=
 =?utf-8?B?aC8zaW9GZ0hYZWtSTG9acXIxd0trTWpwbDJORFdHQjUvNGp0ODA5ajRFUkNE?=
 =?utf-8?B?NXhkVVpiNjZJaUVaUms3ZzZSMTN5YjJvTnQwTGlTcGZYdVZmZEpPbDRtYWhZ?=
 =?utf-8?B?TmhSa21iV0cwbGF6cG4vUENnRzhkdnBUOW41SmdUN0FNLzhBRzRDc2N0a3d6?=
 =?utf-8?B?dXdiRkxxcXBtbHg0QTltelRldkpscytTLy9NM0dTM3k4SFhZVjZESFJUZi9r?=
 =?utf-8?B?QllRSkNRWkh0QWFUTkhTb0hqV3doSHg0a2pWblJXOU1jNFRrT0hQcFNBcnh3?=
 =?utf-8?B?WFIxSGNNS2dyRE0vQW9PeGx5Y1RFU25OQ0IwdUVqTVUyMDl5cHlDM1lvRjJi?=
 =?utf-8?B?V1F0S052dHE5bm1GejErY05sVm5HYlEvZEFsZVdJcWlNbXZ2aHlNUEVtcStV?=
 =?utf-8?B?NFY0aC9vUS9iQVdEcjRhUU5qU21HeUVDWFZha20xRHEvMjZpOG5TdVlyWmJ6?=
 =?utf-8?B?bkszWnA0QVN1aGMwYk1mSVlCemFxcmZFQk81R296MGl5N2phQ2M0eExVTlZ0?=
 =?utf-8?B?MHd3ZUIyd0NGRW1JanlZdWFISHh2OTZTWkl4c0xyckpPRk80elkrVHI0ZlNq?=
 =?utf-8?B?K1dxYWxTYThnVy8rRVFyYytISkVmUjNoT1BqQUN5aDBvR3IwOXg4RjczT3F2?=
 =?utf-8?B?QVI1U0s1Z2YxcDV0eGtEbDNBVDBGVlRDVnFaSWVncm43YmhyVnhSVm1ydUVD?=
 =?utf-8?B?aUxwc3FRK3pxaG51MHVsV3c1MWRWTWRoSTFNR0dCZ3N0aXg5NHFHTjhLNk9t?=
 =?utf-8?B?ejN3d1hlRVJMektiWEc4UHcrSm05bnZGR2xkR3U0djNlOGVFRTVTT011QlR1?=
 =?utf-8?B?RTkra09iUU9udkwrdi8vVkltUnducEZVSVg3WE5JODJJKzlJaytzRzFibWlH?=
 =?utf-8?B?c0JQV2FzTnNqSnJIbVpZT3RZa0J5UzBlZmd1R0hQSjRMYXkyVmtQTGlDY0Nr?=
 =?utf-8?B?RHFLNEcxNlpNcW1oTWlycFYrSThQYXRCcnQ1eXVza2RWN1dkdWRzTTJtTVpL?=
 =?utf-8?B?Z1l1b2x2TTBpeWtWUE1UaExPMVdrZU5uMEZkNHplM2lvbE0wMU01T3R5Z2h4?=
 =?utf-8?B?aXUwL2hoOStTcmhzck4vdG5EVVhMN2k1Qmp6OVpBWmhwOTh5enZOelhLYzgw?=
 =?utf-8?B?aXJQOEQ3ZWVyRDIrK1pOWk56b2FvQkhidDk4Q01tajllYmc4cjdiWjgwVzBH?=
 =?utf-8?B?QzlLQTBPclpBZWlaVnZ1QytqMWl3dkZUYWF6Y3I5RVAxbmh4bFk3K05nRFJT?=
 =?utf-8?B?anZvMkdITkZpbG1XOGVQYnRvQ3VqZUpwenpxRzZGejJjdmhQaUZFeW1kd09F?=
 =?utf-8?B?WkdlRm5OSHM2cVkzMWtVRDA1QnVLSjdKcmVzS283STljWFVsMVN3QkU0Y1lD?=
 =?utf-8?B?RVp5bXA2d1B6Zk9MRHdpNzllZHlZM1J1ZGRYNExRUDd0MmdiOXd2cWJwcUNL?=
 =?utf-8?Q?kjMqPOq6XvxcnrdU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a761e-1647-4ab4-42d5-08df2ab113eb
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB021426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:40:14.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueNOwxY3+dG+z7yKEFKvwd5cpGDNlhvDoiI1ncG01HLvdfsus940KnheLNiRSBqsgfk4kO1UPkqObqfcGiVAIxtUaKblZy/f73O3ibSi+8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11867

On 10/15/2026 2:37 PM, Juhee Kang wrote:
> [You don't often get email from juhee.kang@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
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
> Reviewed-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> ---
> Changes in v2:
>   - add the comment
> ---
>  drivers/clocksource/timer-nxp-stm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
> index 6fe098a4a33f..23b2d44e4b78 100644
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
> @@ -473,6 +469,15 @@ static int nxp_stm_timer_probe(struct platform_device *pdev)
>                         return ret;
>         }
> 
> +       /*
> +        * STM counters run independently at the same rate. Use the first
> +        * probed instance for sched_clock to avoid timestamp jumps.
> +        */
> +       if (!stm_sched_clock) {
> +               stm_sched_clock = stm_timer;
> +               sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
> +       }
> +
>         return 0;
>  }
> 
> --
> 2.55.0

Thank you for addressing this issue!

Tested-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>

-- 
Regards,
Ghennadi
