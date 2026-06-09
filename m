Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF39398910;
	Tue,  9 Jun 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996255; cv=fail; b=OJvOdRE8k35CJj6vvNOi0A+bSRfvKShI+HN5gElx+NLAt4raqMnmSm8mkrEQKbtgVAttAKGq9idrlV9UT3mNGjmGeJK0Efr+zbCuUhEO5jYQ/F2mP7up7xEAToVguJE6LkzTsNSq5CsiWl/csncJRj6v/qSac07Ihn0lisb8xhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996255; c=relaxed/simple;
	bh=BHBRPEFEdXqftYJUCaCb4ygPt71zoze64Bfx7VxpLj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bf51eCHNHosqFJ5/XnQkmCnBPlocryiOYy7wqsuyfrzuvCJ7OCErIXOTgtodBSt+ELWJvkmYsNxz3L7ha3CX7DfaW+EvCLahmLEacsWoXflpz1sBxraBoU8W1r0V8L3LRtIqSAzxUGpNt+pApb1izs33OocD8K2OZv7RH6zh2rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=fwE1CZVk; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="fwE1CZVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwCkrKoNvr5eRyG7bZ4f2fkhZw3CNt/QX5IIfr3g11d9D0et87GSh6e64qpdR5s91IZYwxV3HNAxzO/0RIVHXVYEdiJoPyRUo0mIwNiXhA9ELiExmjdI2PSbAkeB6bZs2p9v0clO4HUOpYtIYSoBqKsI7mDKMpXKNPpkevOYvHkrucNd/+69XzQHMmpmekAduOXQqXpa+kZuXkqadU8aJtJhvvLei1/DIV8o/K4FNCW4FVvBob9WUv3a1Cn61biasJpvx6YtPpyuvRxTCmOQ8pBM8GejKU30SfxN2OCoG/TadOMVhgKe3pvQVLOlFE5hCOENXasOHJWam3OBJw1teQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYx0Gs+G4NLTyszNTcpDcKzajK6vuAKKJ3e9/9RITjw=;
 b=l+mr+gSNCi+hjmIlF4BccdKiM+fxSnRyqgosPDqFXXciRVuEPxDd7Y/Ir5fE5q/Kn0IKg8a2W2KDQu8G7zVHn/YHwvaCEiieIqi2XzDGPRdMCmXfpJleHdUswT2J572hvi9eLngvBYRpvKTdS/dgiT8QQ2iEC6xp1Podqy9wPb4stMo46rRw60AwLPxiGlK71pvD0z9UfhXc4YrU7d1uB42Okd9nASpp2/vJqdsSyO7sPsrNjQmacp7iM3wgsjI9OUcpa6nPV1Wz37kuyfugGMFUndWtJwgjOzr3ZUdQmZtaLlC/PZQFg2Xv2/YosYY2ooJ8ZwxatZjHPVHqRdH48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYx0Gs+G4NLTyszNTcpDcKzajK6vuAKKJ3e9/9RITjw=;
 b=fwE1CZVkI3tB8OEz0TKwlXyFvf/zdwUJzvsYt0ix3mQIG7pu+F6E0K0neYpMVRQpU9R8CFDsf2Lbi4+bSjmOrbP6WnWdh48iUYEKldBiBPZHIJYv8iECRQUngcvXCaWVlC7mmZPHJmPoH+9PTaZrhjJKULtt1wtO1jkqXpfvBs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DUYPR04MB12665.eurprd04.prod.outlook.com (2603:10a6:10:661::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 09:10:50 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Tue, 9 Jun 2026
 09:10:50 +0000
Message-ID: <46835bda-c863-4284-90b9-8789031c0bb8@cherry.de>
Date: Tue, 9 Jun 2026 11:10:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix emmc reset polarity on
 px30-cobra
To: Jakob Unterwurzacher <jakobunt@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260609081728.30616-2-jakobunt@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260609081728.30616-2-jakobunt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DUYPR04MB12665:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c5c0ef-aa30-4398-6c2f-08dec606fffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qyJz6s4CMN7xSqIvdP/NPjwr8P2qFz5q61CmK13kvTCEvfKjmwfSVKF1XabS3O9LKQ/vRGK+3DPJDN5jTWJ+hzankNYvKGn6ghTfAhfjT/AF5CmijzHutEQasPfWnfDYAEJf9wfaR+wsN8qP98WCo6+ytdOweuWz0LsKfxZkXbtAbSm1wvqCitgbrQUQ5tYoPcfHPcERdhvgNMDdcDClgifPVD95VtVBJ8e3H650FGayy0VpvuN8gcXkGADYq4HMKSx9P3Pv8wPoSgodZmw9HUPNYUdL6bcZCxmPEmFqFalGb3syxkT+pma4PY0ye+L3A2u7XS28ORxSGXlNfHB38FXaE8cShoQeqGTsn7Hq+U0SnHXZuYy61bW+NFxuoBNR9xXPVKfZmE5MaQzF1kFv+DudLIUXt0muAQT6sfuh7gRD0WB4cLTPQ7Vhb9nS+IC7fSS5mwZpqqcPSU0ug7ixEKLlDu+Flhp0IlQXaOlSWtByD0lkEVvKvuMZJ+hfWqq365ARYtkzeW8plMZB/pddOVCj2NEXsMVJjpg02h+4s3QolyQmtd7DgjjVvlzYcCqRS1mGp1/9ugSyccYYHvayAkvLQJtxeqBRGvyDBfyKNq6WdIYjKW31Jitixw9gIntj4938j1Hc3+AQ4cnSfZZXfqinpHGhY4u32oONKt4G5PKljcv1Ss97cfRkw6EgH/fj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MndQQW52Q0JMMTdJalBsb1VlTllEYlZacFY2ZG5zR0gwazNpcFZxUUxUazRN?=
 =?utf-8?B?aFE5WFdtdWY2UTNaNUx1S0NYd3dlUFpVRlE2czlETlhmdXdnVmNMS1NUY25V?=
 =?utf-8?B?NlhoaWZSSXFHYlJKSW9ka1ArUWFGYzNicDl3Vjl5ai9HMjdJUC9JMXdnRXpj?=
 =?utf-8?B?TkFyMGQvbEs3WitEK0pta2Y3NENhb05oYUJkWG5meXlPUW11U3o0OW9HN1Yx?=
 =?utf-8?B?TndiMzA1dVBjQXNpOWs3a1laWGlid1UyZXlOOFVZVURSN3kxMTN2aHpTSDRS?=
 =?utf-8?B?RjJrUllwVk9KWCtVUi9sRDY5ZkZPNzVUKzlTZ0xjN0VIeHYydHdOaGl4dlFS?=
 =?utf-8?B?ZmZCZzRjUGZhUEJoRFhHUlJYU1QvMUJzMDFnZnRkdm5VTjhhS0tuV0pwZXRs?=
 =?utf-8?B?eTdlL1luVG8wckFiQWpUelVGODJFckZmVk1HbHd5bnROT0NJRmZIb0V1NGhS?=
 =?utf-8?B?SHVkV3l2RDQwMVJwb00rdnBqSFhmU3Q5Sms4VFZScmIvVUkzYVh6bnd2aEFE?=
 =?utf-8?B?WHY2V3JTL3dYRnBOenE2dDhDSHQ0YUIxUDNFNzRHc01PVC9ML21XaktOTVBz?=
 =?utf-8?B?bmxkaU5ia0liTmQ0djl4S1kvZ0ZVd2p1Y2p0c2d5UDdOTWw0bWgrL0FHUkRL?=
 =?utf-8?B?T3luU2lmb0RTUzMvN2hrZkZhY0xteVZMZVBINTdTeHZ6M1FuU1cyd0xJd3RQ?=
 =?utf-8?B?bGNncnhWVWYwWS9INlJJS01MRktNeUdENVZ2V254TXIvbzlzUVd0d3N5cW1k?=
 =?utf-8?B?T25weGlUaWpINWdNQTUxMUJFSE1NdUNTbC95RUYwdXhpcmRaQy9lSDlqeERE?=
 =?utf-8?B?OHBvQUxLOG11RVRGNitCd3ZSYlFmaVJWMkRFcFEwaXNubVBiYnh4VldnUkt2?=
 =?utf-8?B?RHpwTFRuTmVMTWhiaXdFT2JOc0RtT21CUTF4STBOenQ3UlVhZGkzOUgwcWZy?=
 =?utf-8?B?SlE1QUJGZlE3bUV5dVpidzF2Wnh3ejJOWE1TTEJuRmhSRG1XNHNjb3BoSmpO?=
 =?utf-8?B?Qkpvc0JVcHVsYzRyeFZVYXI5U3QvY2Z4ODdUYTFEYU5WT1oxZHR1WWtrcCtw?=
 =?utf-8?B?U3ZkTjhURHR5NTZpYWFpbHkvaEZWemdhT2gzdHMwcWJIT1BtTTBRUjNFajla?=
 =?utf-8?B?OXltKzJzbzJaUzFoRmVBMWNXc0tRNzFmbjA2RFQrbHJITk03dzZhUnluOE1T?=
 =?utf-8?B?YlFZTjhpVWtTMllBVkZ1Q2hnQnpCVTI0MlRMaHFsbjB5eEJ2QkZWc3BQOXRY?=
 =?utf-8?B?enI1WXVxdWdJV2lsdktVZjd6SUlldWhqSit5dmtsbVcybXg1Z0pVRmZMVEMx?=
 =?utf-8?B?SS82eUcremFhNzg4L1RMeDdaL2lBMzNpTDdPR0l2MVBtTXF0NGhoeU1teHBx?=
 =?utf-8?B?S1JBdGZTcEFBNFpWL21MaFFhakNVbWVDWFRZSEgzWlVwWndyUzZ1ajg5OEMz?=
 =?utf-8?B?NGRGMkxUMkhvV0ZUQ1E4Kytab2hxN2NScU5VbDVWSm42blBLQVdGb1VVdlhk?=
 =?utf-8?B?bS9VaWY4UG01SjBia1pYa2dDcmJGSDJONXlHekU0S3U2YnFiMXZwb0J4UjVi?=
 =?utf-8?B?RS9tazNFVkNSZVlJVUZydUY2YzdTVUZUOWpNVEhCL2VZenMzWVplNHNCUUdQ?=
 =?utf-8?B?TGlyOTN6SjRzZjMrOGpYb0FhR1VSd1lMeWtyREZHZFVCTWNSc0dQVHR3eXpS?=
 =?utf-8?B?U1dnQTRCbk0xYThRNmxzRE1oall3dEpUZWZtMzIyZjV4aFFjVEgvcXZUdWFp?=
 =?utf-8?B?MUUrRDlvS3g4YThwT0VKd05LemhjRmNQbWxNRGc1WUZ1aDVBVkdxVEw3aFE4?=
 =?utf-8?B?bnFrZEp0WkZoSzc5d3hXb2xlcXQ5dWdhQndBdno1a0FmQ3FyeUdOK2poWXpU?=
 =?utf-8?B?SE5Mc1hvVmQ0c0Fkejk3NDRVaTl5Q0oxdW1JTGZJS25iK2hPQndwZE1meUp0?=
 =?utf-8?B?UXd1QUdtaGNqVGJ3QWRDTVRnTEJZUFd2MXFFcjFYeWJ1R0svTG0zTXQzZnlv?=
 =?utf-8?B?a3gwKzJoUjV5VnR4RFVKakZYd2x3MDNkOWxsQXVjVC91MG1Pb3JOYVhxcG5q?=
 =?utf-8?B?QUpiY0tXaDdTRm5EQjNnQVB5ZTdvZTdxRDdqKzlmK0RZbDdrRzVmemYwYWxM?=
 =?utf-8?B?dTEzeFZNZi9vdjFadWU3OEV2VmNSQ2lrZ1ZtdjAxa2ZoWGFyUjhRTnIwcmkx?=
 =?utf-8?B?N0ZSR1FaNXZLWXNuU2ZLU1hRbzdXUHM4blJVbXUzZGNmM3BsV2lRRVprODFB?=
 =?utf-8?B?cURxaTlVQTlaMG9MMG1BWnhIYUVkVzZSTGZmcVhMS1JSYUE4VUpMNkV2b0J3?=
 =?utf-8?B?QjBVTHR0ZGIxTGZrSjNlVVFCZHNDSlh0Ukk0d3M4UlU1WFhwS050QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c5c0ef-aa30-4398-6c2f-08dec606fffa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:10:50.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvZOK+f8Y4x69c6VeEJkpSwAYZpx7yve6L4UlL0pOy9a3nT+8X52ka9f0mekv3VSf1PEoGPV8/20gdYK/7uQPlX4dA4jxy5OnkzTQQw1npE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12665

Hi Jakob,

On 6/9/26 10:17 AM, Jakob Unterwurzacher wrote:
> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> Technically, the reset signal is active low - it's called RST_n after all.
> 
> But it is ignored completely unless RST_n_FUNCTION=1 (byte 162 in extcsd)
> is set in the emmc. It is 0 per default.
> 
> For emmcs that have RST_n_FUNCTION=1 we failed like this:
> 
> 	[    3.074480] mmc1: Failed to initialize a non-removable card
> 
> With this change they work normally.
> 
> Cc: stable@vger.kernel.org
> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Please try to not forget to add tags (Reviewed-by, Acked-by, Tested-by, 
...) given in earlier versions of a newer version of the patch (except 
if substantial changes were made, which isn't the case here).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
