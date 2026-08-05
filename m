Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023084.outbound.protection.outlook.com [52.101.83.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59573009CB;
	Wed,  5 Aug 2026 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925331; cv=fail; b=AjTqKuIz2gTbumA9P/IYFrJVNiaSkc5BKBa2Jzr2T++zCFTLaRixoIe9ONu9/WNCxyKMcflEZ24RF3SPxKSyjygIwIc8gobmelY2lmLrGA4ugDLK4VYDHJe2I2r+CcEG87XnsuI9QFEqCpcON8LUMZAHNHKKbwxmuEeLavk6CD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925331; c=relaxed/simple;
	bh=C41wvMOMSvsOcf54DAFb54BjiORRFR8boXFUsE5hhv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDm33UzaImwcpyGVeUp4G61rriTl19nlp4EYRJw5PgsDXHVlus9xIn+rkO/tA5i3qsGfj+HA91r1WNQxQKdRUlgUSiJ1u8Nob79ulezjHZZvDPcxn2XQ7q2J4cdXuhfq9fVEu0uEn5onS04OZx9jxr3KDj8d+kovXh0T1CjRRhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=oO5BZk7T; arc=fail smtp.client-ip=52.101.83.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="oO5BZk7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lE01Bw1EjMyvcdfCBdygNA1VS80ahjn2p9bw1dXCAw0qvlOjOr34rH39UGSsMVQgxMxmE0y/hf0GBWTrJ8RyyzmW6V3BOL4rpBfr+rdIt32dDbfqQpFcBVYou24vfW8iuJQTzg3ThEbK3A+a+gpvPrG8V1Beb/+Y7+sc2/1vwUyUdz5Byq5J8w+MnfDD4Be23I2rslpO7IIlYs9W5XNMKUCFIE9LcfqcA+YFj/0tNU4OB/CSlDlUQfvPVDlSR4m6LxUvXNC4kLZxswGEBZGVfm1m5HmxIOq7IHFlQBV/5m7Oopj1W499KMtDZpKtMRJ8LKNaPLKek3W7HiGfy5afNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SDVwYLnqpdvR0WJyx5Os+A7SNvGI+eLxCamJG5uSTE=;
 b=e2LVHeTMdzPs8qcMZo8m5N+7z56ymr4oulFjxs0LHjOK9Z76xUErBGGYSkO03p88Yv2hlujiu2mQTln47H0xljTloZJTzIVdtaXkrGpxNZ82jyw3N0twzw4+bGf1RbIByVPv1e/WWLnW49KG8w5SGxKBZm8Ij663wZPvHV8Wupi0C4ayeNde+9I7+1/tZ4TiXk8vy/QaeOExxNueRlav2RqXZBnIsuluPDX1Vbe82zF528IdlrjfqZDwGdE9+L15PD2jI0aUn9BV9AG+Vk4G0a5Qdd1V11F3IFU0TAE1ziiI0xp3DoDE1GSAIiIPxeACVmn/AR0e2E4hLmufsSEIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SDVwYLnqpdvR0WJyx5Os+A7SNvGI+eLxCamJG5uSTE=;
 b=oO5BZk7TF4d9d+OUBzRosMbhWk6kTs8J37xZ0hy2LAWugJvrIREANOXJA0wr3g0QVvwmLb1Dp1huNzsdUOFefYGdNLvAG2aBapuw+HAtWnL23tKevpNLqTo/Tdr8HKAfm8FpvX2D3FUXkgqvzg6yE/ws9WvVfEvl7SufWCI0/y7tV2h2pAClgMLaGZlk2Sb3PEeVQgHfcwZEJF0BDKjjXR9xqsrNeD+vOFyf0OmARQPctu+lDRzxWVvOL8Ag7brsuUWG+ZgKu9nBcavUzMpb3vDfFYgXuji1uk4+NFFBEz4DCDud5xomU5JCNbZ3ck2o4eb963K5KwG40YYMiuHjJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by PAWPR08MB11088.eurprd08.prod.outlook.com (2603:10a6:102:468::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 10:22:04 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 10:22:04 +0000
Message-ID: <8f04fb34-5651-42bf-a85f-64cb7e37461b@genexis.eu>
Date: Wed, 5 Aug 2026 12:22:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: airoha: fix wrong value for PCIe reset pin
To: Christian Marangi <ansuelsmth@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Linus Walleij <linusw@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: stable@vger.kernel.org
References: <20260805084143.3901-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260805084143.3901-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0001A325.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::691) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|PAWPR08MB11088:EE_
X-MS-Office365-Filtering-Correlation-Id: d54afe9e-63fc-4c2a-0332-08def2db6547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vAxxVRQrw9SU3QZ5LftN41CTqPpqMoOomaJYvaHVPiAWIMSya3iwbVlL5frQglvCn9Q8MAP6fhAz6hH9xCi7BDfhN9kW0bL9lbWrkodQNTNh6Ptl4Z5Np9dUBqs4czZ4gtW2AKSniWt/Vs0HZA+YwoxcnDEb/1Qmq6FDfKKL5eG5+SoLewM5PQFuqqdTMNAyI13nG1nGE+f7px0jirowF5YR8n5OdDMZeeRv88e7cDo/aXn4eKDAWqbI0SlLBrkMwgedDuK5b1cDnhZwjiLos2Z+6k8Rl7snt21BL1TWWGY0GMhOB7OHWTeSbBpe8oIt1vvlWM08SjyKOGIfFEGDpRhewOy9b/kVR2sf3fjtLkpSB1PO5B/R1vkuvKoqq8OUINJNq5XAVrgEsCc3Aapz/lRwZ2lbjofAiXbyzMui3U4f6DFqmxNtdR9DTDECGmZTr1VNoQMxBTUWt4fyzWQlskUHfMK1EwVHbmtvZH4O9PpzfkU2spdF7f+MOovjkNk1ZKcKPY5X7D+mJCjh5i0qYYGj/MScPe3ldl26mMKJxLNjO0k61NdzM22bSrb9DRCQ053cXPUNJ16ZOkdBXv4u5SVq1HwRTREKbBTK1V86BMwt8YOLYLd+929oVyaBo/4Lhr62UBHgMACcLxyAnR9N8LXnqxkRounVqWkzdm+2azA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhJL0dyMnlxVUtSUnVqamhOMThXSUx3dmt4dEQrbWtUczhOZDA3YmJnbVJv?=
 =?utf-8?B?RlJoUjlqNm9XV1pHYkg5S2VSU09MZVdpVVBoZFVPaGY3WGN3RTloSGJ6bTR4?=
 =?utf-8?B?RG5lTnNETkczeVlMaGR3bndBcVVhbklPeDIwN1h0MStDcFhEdkJzQ2l4NjU0?=
 =?utf-8?B?RWxOdkFYcUxFMzhWUEVCZUFpY2VTMWcvdmJGd1lybnA5R25mckdMWFI1WTFN?=
 =?utf-8?B?dWxoTnQ5STd4QjdkdFJYT0FxWDRYblRVQTF5QjZ6Tng4VDV1TXY1T3VJZGFK?=
 =?utf-8?B?bHRHQW9QRGRGbWlkNXhYT2MxNzd6OWt3RDBxb3AvMUxRR3lTcm5sbVA5eG5a?=
 =?utf-8?B?aGl0Q2UrTkRpZm5yVkRma0VHUjdLRmgyUHFidHRyTXlGUzQzdDJLQ0hUSVVn?=
 =?utf-8?B?U2RnY3NuYmhsRXMvZjBHQUh6M3FXNEpvTFdaN0FmZjBkZkVGYlNxUjNKMWhZ?=
 =?utf-8?B?emdjWDU1L0xFUEc4SnNLZ2x2YmlEZGhvSGhaNVFNRmpyWk5Sb25ObktyN3d0?=
 =?utf-8?B?NFNGNnBLUzc0dXZWSkFnejdVWWc5M0pDYmxFQ2haRWc3U1dQYmRXdjlkUUQ2?=
 =?utf-8?B?eXRxbFVidHNLcmxvSnVSc1AyaWRpQ2J4QkwvcWNjenJKSlNOUlE2WHZMRmdJ?=
 =?utf-8?B?NmZCdWRHWDlIa250UGVqd0ZXeFRPYmI0ZmJEY0tXRzFlYnI2ajUwZ2NSclZy?=
 =?utf-8?B?WEk4TFR2dUVHNGZ1Si9mWTVNdTYwMWhuZGFra0lCVzQzYmEzQkJBZ2RaQmh3?=
 =?utf-8?B?bU4yTTZtRUxEYkZrRUw4MFlEM3NZaGxnV0Y5NmtVMStJdkwveEorUnAydS8x?=
 =?utf-8?B?cFdPUHhpckhwZnp0NWFuenpENDhxb0V6aWUrTXpyNHVueEhQWG15dGFNbDUw?=
 =?utf-8?B?K1pIdDVpY2lSc0JyT1krY204RWtmQjJnK1pnR2ZyWTA4Njc1cWdGOCs1RWdr?=
 =?utf-8?B?bVJCcEVaWXVtcmVyV2ErNit6NXhKTU1KK2tycm1VSVE5eThicEFNM0VxaWFR?=
 =?utf-8?B?ckY0MmVuYWFwV1J1SFBsUnhlSkVLVDREVVZ6MjI2VGd0YVJoOGhaUThJbC95?=
 =?utf-8?B?QkVhakxJSlcyS1F1UU5JT2lEU2ZZOVB0dkVYVXBKS0hlNHJnTElneXc2OSts?=
 =?utf-8?B?ai9lOGFBalkvQzdDRE91TVAvTkJraytQZGtaOXd1Q3YyYytnckJrSHErdmlm?=
 =?utf-8?B?YllKNkpMVlg1QlhIbThHTEhrRVUrb1BZckk2MkwxS0NMS0xQZWZ6SGxERkRK?=
 =?utf-8?B?dDRScHYycmhMLzdmM0w0QjdpMmZNMXBRa3pMT0dUa1VZV3NSTUFRRk41ZzNa?=
 =?utf-8?B?c25JYWpZNVlqSkVSdURwV1FuQ0xUbjhNSnpoZDFuKzdEQWR4R2QrbCtJaXVu?=
 =?utf-8?B?MTFwZ0p3U2FWQVVoWjRacGdXNnltTUswTEN3d05iU01aNjdiUTMvNjdQUHJa?=
 =?utf-8?B?S1U3TnMwaUk2MTduc2xpd25yMkdGaGJ5RXVwclpLVmE5RXN2UXpOamdhTDZz?=
 =?utf-8?B?R2lKY1ZWbEJ5eFBsY2VlUmxuSEhNRW1heTJDeVFhTG1zeFNvSitLcGhRMVRp?=
 =?utf-8?B?cStrUWpBc2xzdlRXSmFKbzhiUXM1Snc3RGtDZXJMNFpZc0dQbWc3STB4bTI1?=
 =?utf-8?B?L1d6RVdseEYwSUMzU1ZJeFZCeWJKL2JyZGRZYUFKd2lndUVRdDU5Yk9TRk90?=
 =?utf-8?B?bXlab1lRWHJ5d3FrbXorUWI5aDB6RjdIMlkvMkVsdkdiZzRRaER2dWJtc3dq?=
 =?utf-8?B?cjRTVGpuQkszOEM0NEpjMWhEVkh4Slk1L2d2TU5EUk11QkxIclZtNG1pYnNH?=
 =?utf-8?B?L1JlN2pWWUdGSEtDb1lUclRnNlVJQm5EblRIMW5NUDhaOEQ3TiszYWJIRXYr?=
 =?utf-8?B?VUtHMEM0S1ZaUGVBcDd0azVycHMraTRJMjZKYTAyaUpHZ3lWSTdmZmFwM2J2?=
 =?utf-8?B?OHMwdENOenFjQjZFT3lnT3NPRmljaWUzRXVIQUV0aU0rL3QwY3dlaHN3eHdy?=
 =?utf-8?B?L1FoZkRwdXFzd0tFVk5OZEpIajFYU2ZheXZmRlFQL2cxWnZOZzVhaHg4bHZP?=
 =?utf-8?B?NWN1ZUVUL21XbUZBMGFjMmlURDFDQ3p6S2Q4MDl1RVo4WnV0a2FLWnE1ODVX?=
 =?utf-8?B?UkZPSGlxem83cUNmaVV3Nis1SGdZOFhxbmQ2TEMxR05jWHIvL2xXZVNLWkxk?=
 =?utf-8?B?QlhIS2JjOTR5RldhWnNwR1ZNN0EvaG5YVkpOcDlRRnRsY3Y3eGM1UGtVdHRH?=
 =?utf-8?B?SGtSZ3djWG9Ca2JEeEV5UVB4UFdjZHRkMG8wcUZnZG1TdWF2TlZNR2xvaGhV?=
 =?utf-8?B?VUhPSnBaNVNLT0NtbG1vWVQvZW9PRDZWaU4ySys3b04rYTg5OE9rL1BPY2NG?=
 =?utf-8?Q?hZxzExuMUmOaObLk=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d54afe9e-63fc-4c2a-0332-08def2db6547
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:22:04.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7C3lJobfvmbd9OgZrjGcGBFlmlCy8lVXpvE2LZTyKmZe7/PMqp8m4fV2tV0+Jfko92F3rjcIDrpuEwz2wo7NXr0Ajqfc736tlhxrp7oydc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11088

On 05/08/2026 10:41, Christian Marangi wrote:
> The PCIe reset pin actually require the bit to be set as 0 to work as PCIe
> reset pin. When the bit is set as 1, then the PCIe reset pin act as a GPIO
> for GPIO44, GPIO45 and GPIO46.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/pinctrl/airoha/pinctrl-airoha.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
> index 04b4424c688b..6409572c0a4b 100644
> --- a/drivers/pinctrl/airoha/pinctrl-airoha.c
> +++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
> @@ -1412,7 +1412,7 @@ static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
>   			AIROHA_FUNC_MUX,
>   			REG_GPIO_PON_MODE,
>   			GPIO_PCIE_RESET0_MASK,
> -			GPIO_PCIE_RESET0_MASK
> +			0
>   		},
>   		.regmap_size = 1,
>   	}, {
> @@ -1421,7 +1421,7 @@ static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
>   			AIROHA_FUNC_MUX,
>   			REG_GPIO_PON_MODE,
>   			GPIO_PCIE_RESET1_MASK,
> -			GPIO_PCIE_RESET1_MASK
> +			0
>   		},
>   		.regmap_size = 1,
>   	}, {
> @@ -1430,7 +1430,7 @@ static const struct airoha_pinctrl_func_group pcie_reset_func_group[] = {
>   			AIROHA_FUNC_MUX,
>   			REG_GPIO_PON_MODE,
>   			GPIO_PCIE_RESET2_MASK,
> -			GPIO_PCIE_RESET2_MASK
> +			0
>   		},
>   		.regmap_size = 1,
>   	},

Reviewed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>

MvH
Benjamin Larsson
