Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944233;
	b=Pyl4V8y9/gQfc2XPFdm4/vm7bqNH9jW2A4dx1N9ZGVeD+B+jyXAPDWZvjbgOtZXL5jUW
	 bto/9HV2VjRMTZmHhbB8HV+45pT38Ar0H+DAcH/TIyOnxHxhPYGgyQhWSSeIBW2nG7uOQ
	 5i5z1qDBOHT8540lmssZJYIiyoaGVy9cYx/fU9HIyv8lXvye3ig3WyE1BNb9sJY7R37Jz
	 aGAWBqLvo1TKFnqL1+HX5IlWLKNI6geGMIvGRbU3ItVZ0mT4uBgq4XKltzcpdiQUNxqiB
	 OOxQPIon54S4CLspA6P2C6K70bRW/CBrgbck4eSaHwYxWkuN0WFPsevlseMz8yClrSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944233;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nqpSIeC9Mow3Pk9uNxyHB/ScbHAUOjCVWGNSgRDoDQU=;
	b=Myrs2giBUAxY9V5yTyQceVSIJOzxiA4xckk2RLKqofr9byXxX2k2zeg3aTWUCbTuOrk+
	 gXibxMKRMw1zWGRux8eyboX1f8phyuFviL+sw2+xcWiuYGV214SriCZuhOFARtqeRd+iW
	 WPyMaHA7u2SUlQJ1x6IHKhBs7G+KF4kAl7RWrUmR7qe8egD1YWKpD4L4jhdHgBPvQuXAn
	 x9lyZdceX+Q7GPfWvBrK+oAhLDRuCxYFZgH9C0fZ5GgMZ2l7iSw+cPm99cgNB13hAUsy1
	 TjbFENcZzlt3gZu6D8Cxasf9GwhrZlRHdNfaaYgkwd0X7X4k62pj3JmrJsTzsHzHcWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DeruKW+x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.0
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D5606A339;
	Tue, 17 Nov 2026 19:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447D5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DeruKW+x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9uXwBrcYC0LbAPP4I/+M8fQSKgh7KKPY2TCzeMVIH1gk/suzWh3mm4gexrVXGkTqvhUF3c0gshvPau0FG0IrZ/uRbjLOYdHiCGW5SeUzpF/bGTqPmJDu2DsjkILu1nx2Sy63VFAssROMrtV+SObpq+clVmL0F0xcLuKjnWCLvOzTdIrtXViIGvxNzlx1gCGWE1NyrdjGFEL7cQyrCy7lHbDmPzbsDlqvM43U0WvDM80rd7wHQ0S/Qptzy3nnTImjQLMSmH3BfKrlKMz9N2rDhfpb1hzSIcOg4Dosl2LsIYgTmTFkAPJK2Xbrl7FGVjdxyYt/oJY7nRJzh+Kys5OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqpSIeC9Mow3Pk9uNxyHB/ScbHAUOjCVWGNSgRDoDQU=;
 b=Lt6XEV+GyX0YGSBNzeYMTC80/DsXLv1SDUmvfCX10cWOi1LDsNZjneu8Lpm1RV/XQJX4SxT1DW2DkfBAby1b44LfZR3+D/QYx/ERmcKdXg6HQMSIsrzjUggKQ2B3hAg2yYWKPTb7YReGJ6w7YxE/C5Y+ew0D6XSVCL6YB/d195a6rGvo6XnhBLwifPdYY4Gt8sTHvjezjz+GZ7UT51kxPp5WxvkI8javiT9WQsVkvdxetU17CCFEJD+HmcY7abWanvVZwqImq5HgZ6+ggUacep2MaMIHt2t5gX6GGLv6/R8/XsOJ4bXPbc7knJCPzAM8Yv6Zo9aDDm/iNDi8kwWh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqpSIeC9Mow3Pk9uNxyHB/ScbHAUOjCVWGNSgRDoDQU=;
 b=DeruKW+xf/qNfD80JnmOYAupqwCmeENEz4ObSxLpd0Bvi4Bu8b3cxGImLcRSzJgtc5enZJisYFQofJLmJyw90MOJKPE3qHoRgH8W5hsJGsy629Wc4FkkPsp/hWfkt0CXVWfPr95ciNQFG95lZYWsNPf4lW2QLdRi0dkZG9qhsPl+jM9s+QnAfj9QvyhQOjHCIVgwGzTpz9cb0BbxXljBz9zMXKXsqdqrz3MY3tFClXWgLBtBJyLnKFFXya8FKj4JQylA8uhAGQF+/kxVPRmj3wBdgWfa150ue0dCgzxe6TQaVd/+SamLDA4C6Vp5MqdR9bBRVe9umJKBdoNMoxv4RQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:37:10 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:37:10 +0000
Date: Tue, 17 Nov 2026 14:37:02 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Peter Pearse <peter.pearse@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Joachim Eastwood <manabian@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dmaengine: pl08x: Defer OF DMA controller
 registration until slave setup
Message-ID: <avys3pO6oWcGwNN3@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-2-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-2-lee@kernel.org>
X-ClientProxiedBy: PH8P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: af1356ce-caa5-40d9-ec70-08df44e22bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|18002099003|22082099003|261009223027099003|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261021133027099003|261026135527099003|261022105027099003|261026130827099003|261026140227099003|261021130227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261021135927099003|261022115727099003|261022113327099003|261102124527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JO8SHcGyKmDxcOm6HRCj0eMAg/eYY13ZxvLAdARmaTzma8oCL1BnvA53vbAtSfpvuo26FQXoaDjG33iAtjTPbKzQ/1yGnijPH81bnEAgpYFa9fcD82OevV+YgdhNUAl+hW1izs/i64GVwKEaeKIQ0x/gXvpopE/eJfIoN8VxuUZ3p6t/MvTCH5dx/m8z8xQYdn1G5G57XzvRxK1T/htZ5HR6mv78wOW7vwflAQA90q4ka0OisMlKaA5PPGiiuSXS80NAY11aVHRSKeZeBQp//bvFCxc3ekKYguyF//xfv252mVD3MYgu8zsb/hcztO30YSiSxGJ6lfzT0z/R+225bNj20PDpNg3g8WsEqjKV7/hLRrMspif22X1CNspJia4XGVGt/xzE/EBFCAMjdHnT6d5KNkwFURbS5oAz9ekXfBkOcIJryD8QVGi+ExXLb8VLuv8zMl20QJe4Z3/48CrzOGhoUP4knG2ly44RUgP1VegrSiOubtLlaa8of2zRag5CXyjEo7DVJqYFD295u4XDJfq7KXR9cXKL2j+GZUtHfu3XuBCn5kHg54BCYKrFEqQV7ViXSuZL2QRaWm6TrJFuXBlBy7eFMFEbPObXNWGWpGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021133027099003)(261026135527099003)(261022105027099003)(261026130827099003)(261026140227099003)(261021130227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022115727099003)(261022113327099003)(261102124527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kyE7Z/d7yBrMNOxwnOZi4vr+JJ3qnCgPi4sGJNodyYXMBPmVdxOL8bWqM/W3?=
 =?us-ascii?Q?BbZyvOgd65xo4qfHVtCCQuZtaPi8ZF6+P3JljBqLkWpqDtJVtZsovr99IgnF?=
 =?us-ascii?Q?6OmVp1t9D/GGdrG7CiwJ/ewiKmEdVK06dBQr9tNHU3BX2fXZJtfsVQ2DgeiB?=
 =?us-ascii?Q?gzT80p8wlW9Le0/1A6o13hzOLu5Y3iB0EzUa6Yzbb12amsuEf85TDYsnweKi?=
 =?us-ascii?Q?VsWipRSFZxGRm95KEP/6lQMeYtT5jVjog4fOWgrOkNdF2oEHSQ0tLJVwIItw?=
 =?us-ascii?Q?ZZCX+LcP+K2QRaAbZ958Ecx024wQAzvW3xHz+7bfwcz7KtbITd1DLjo29qhC?=
 =?us-ascii?Q?hMfIm95AaZx/qv2U71oePTWvgX7z76J5eKUlMCOMleFRwpv2jYVwb/XXLDeF?=
 =?us-ascii?Q?WKwGBsIRa9E2c4RdjC8jEsrx5K0Z7DNcNmHsaNMhB1CJKjpMWD7olGO+pTO1?=
 =?us-ascii?Q?WpMlgV93qYAx0BAnBg3zIMCtNOBruOaQN1QSwb9RuXXC0AZuAlOVWttTK2Ot?=
 =?us-ascii?Q?f449pu1/LZqGQxzYoSFzaGjw4escSN4rliWlogrENH50rXezHso9uz2IhG4D?=
 =?us-ascii?Q?FflGuzvDWvhF0uIxES6xU/hbGWbRBKgNx0bNn3o922m2KuVIHZ4/SGRUH3lS?=
 =?us-ascii?Q?AvhJ+MQN4jgDnILFvkdYgqQSzSTMiFG5xK0wytL6cqAPNmjrKlTyjKQ/g1mz?=
 =?us-ascii?Q?3vibbMbKWZ20t5jMtyF8cnoqwIbSQBfmSre48tT4D1dgzR/nj6BnCGAlwsPZ?=
 =?us-ascii?Q?zIou4O3Qg/rWApwvx05iu+dJHk+oWsvCF4vvc4FjWTk2tsEEI0iq5BRdwjnm?=
 =?us-ascii?Q?XmVkmHIjewg1GettzeavQb45ogixMUevkrQXKnCUAe4WJYVw8Ht/YiEmhqOb?=
 =?us-ascii?Q?dBWOwUORW3udK6LFfRWVfSuKw5l2W2cGySSahd4hFlOW7GdSvS3t5ynKv/1v?=
 =?us-ascii?Q?CbpwcPJ795ndmlvil2V2awwkOCC99ylgc0n4VmgkoClB4pGzD13IviKH0GIy?=
 =?us-ascii?Q?r0iREvDalMevXUSriHLyeCUwe4wK8twOt3LHD63qi/zmEp4ywfa9lq1GTyNj?=
 =?us-ascii?Q?NKSefB0mweI9+7CFscLKwLhqhxE+CKK7K8b5RtPS2XYBYwQzxhtZJLplD9wQ?=
 =?us-ascii?Q?+WtYtn66lp1qv7RpxWrpLvV9oWGhi0EESYaxqYDk0fcnZ0hSzNAmnrdIL2iw?=
 =?us-ascii?Q?M0PIsypr0itucIU8+yT6RXpbWpwnkKd26DwFbmE1xy7cD2rTZcSVyT1HAO2U?=
 =?us-ascii?Q?tJklsZIkUNORRe5txHC+ETZPp5+X8uP3mPN6lTGX7caIsAW8h7TtBSCZjGMt?=
 =?us-ascii?Q?ry3Cglyjs2nFaLPUxxeTuOOGQHUkPb6Vbgqf4SSBWLroGDzdCm/fYnulFX0C?=
 =?us-ascii?Q?0S/n06pDucSQr81HaEAXC+CmpUElDtbqjbqXnhry+JpNQg8c6D6nEaZSLByu?=
 =?us-ascii?Q?AnOO9ZawEo8u3llVNWeTt7jPM1dRsxz4cdMvnnxW4ZrugcDH29K7anQ2w25P?=
 =?us-ascii?Q?5aL+XJ5rM8DY7BauQ+g+xgH3Cu/XPUrRYjqgfloz2IJ12ACmtoZTouIgi+sf?=
 =?us-ascii?Q?YG2anD9rroNwk8rk52sCYYSy6x+GzyA9VsWz32WJULFaKNKGUp+SD9Zc+5gm?=
 =?us-ascii?Q?VgoMxc41nRmxaL3/e9ZwJ0DcmQmN47mD/6m+0lUZdP/KskM3sjW1Mr+aMKnm?=
 =?us-ascii?Q?V7vdgbJE25Gq0/LQM69Fwv97llvfREy1Znd76UIRuhuwz9LmWNvqcq7dFFlC?=
 =?us-ascii?Q?gEyvLPZI9Juj+mYqYJWfXgzOaxeQWk4qbV/wXq7TPgU0jwPyWm19?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1356ce-caa5-40d9-ec70-08df44e22bee
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:37:10.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P36wtIZJs8WQ0U/DQGVF66T67Fky3yrwJEeDBz4Zvy6H+Wrw63YH0iqSPOQDdhb0sTOLnXWHyzgCwjkOxu+gHeHG388ZaAb8CbPyxY5fxiRiFrVjLJFe/5+EEHbBRHGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288

On Tue, Nov 17, 2026 at 04:37:02PM +0000, Lee Jones wrote:
> pl08x_of_probe() registers the controller with
> of_dma_controller_register() before pl08x_dma_init_virtual_channels()
> initialises the slave channels list and before
> dma_async_device_register() registers the slave DMA device, and
> pl08x_probe() does not unregister the OF DMA controller if subsequent
> initialisation fails.
>
> Move of_dma_controller_register() after dma_async_device_register() for
> the slave device and unwind slave device registration if OF controller
> registration fails.
>
> Fixes: aa4734da6674 ("dmaengine: pl08x: support dt channel assignment")
> Closes: https://sashiko.dev/#/bug/linux-4e233fb9-3b0c-4442-b601-c6706c9f5aba
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 => v2: No changes
>
>  drivers/dma/amba-pl08x.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 543c2eb8cfa8..d8441e338502 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -2678,6 +2678,12 @@ static int pl08x_of_probe(struct amba_device *adev,
>
>  	pl08x->pd = pd;
>
> +	return 0;
> +}
> +
> +static int pl08x_of_register(struct amba_device *adev,
> +			     struct pl08x_driver_data *pl08x)
> +{
>  	return of_dma_controller_register(adev->dev.of_node, pl08x_of_xlate,
>  					  pl08x);
>  }
> @@ -2688,6 +2694,12 @@ static inline int pl08x_of_probe(struct amba_device *adev,
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int pl08x_of_register(struct amba_device *adev,
> +				    struct pl08x_driver_data *pl08x)
> +{
> +	return 0;
> +}
>  #endif
>
>  static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
> @@ -2944,6 +2956,15 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  			__func__, ret);
>  			goto out_no_slave_reg;
>  		}
> +		if (np) {
> +			ret = pl08x_of_register(adev, pl08x);
> +			if (ret) {
> +				dev_warn(&pl08x->adev->dev,
> +					 "%s failed to register OF DMA controller - %d\n",
> +					 __func__, ret);
> +				goto out_no_of_dma;
> +			}
> +		}
>  	}
>
>  	amba_set_drvdata(adev, pl08x);
> @@ -2954,6 +2975,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>
>  	return 0;
>
> +out_no_of_dma:
> +	dma_async_device_unregister(&pl08x->slave);
>  out_no_slave_reg:
>  	dma_async_device_unregister(&pl08x->memcpy);

It'd better switch to dmaenginem_async_device_register()

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  out_no_memcpy_reg:
> --
> 2.56.0.679.gc527c65306-goog
>
