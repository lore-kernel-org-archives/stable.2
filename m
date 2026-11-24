Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795550194;
	b=yFSTgzjFoSPAycCyNbe0JSSbkZlk1uplYAu47BHzh5404q1k00ondz75wsW+CYKsRH95
	 aOEtQYcUoSQ3t7duX6EepsfCxArlUQgAdiYy7THKpMXL/aZgTD2hbdeWsN4v/WMcDBStW
	 zHZkPAA6OS1ExfoA75O9bxlSkkF/3BQ1RIqbcz+z1zivzmkEgri/4FbexLq/f5eEC2DeS
	 Sqe3xsawRy9VlfFpjFiqbfOxpsB/ssIfMee4HpYCof6H+YdgrdYlTeDdD4C97LH99Mq7d
	 ObPrkXsVhHKY65qOplz4loPTTCFmsr9yIPtF7am1opjefa6SuGk0OQUMF7+gyQvujdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550194;
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
	bh=RQy6k97f0thR3yTz/+i8RTVC+IMYdMckItW2D0vfqK4=;
	b=cGUZ+dfBd+XqU24uaSS30AN6TYrx5dZLDJNL2iKVbLxnCuwdjW4vMl/HihctVYC4Uf4c
	 bH22lXUacwumnJPkSQL+vBc+pdM8qGPA1rPuSqh2hbhbd/wlH/m3FV2QY3V4voB9doJWV
	 Rc9/816ipJD0R2+zQmf26k8MNbx1NtnR0jeTbTJEU1IV+O9GlpIv+ZCyM0VvvGWJsoyH4
	 WOtT09a3OAFh19Go0HsEARdLu2pO5P2gF3j4VtcqsYXwV+Ymx0OSm52spf+Ozodsk3azS
	 8rgWttaVqdLfe8Qhkp22it+lY1MFQMYZlbi1wjBYypGoJ3Hn8IKM0UGyPrXvME4s8Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XKOqlG+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.15
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD5606A326;
	Tue, 24 Nov 2026 19:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1DD5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XKOqlG+P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYuX1hgUwagp396atcpg7Nas4r6S4edL0Fs22btsL18zms3+/YJgSAtup8GUOtKYjuoU602LMLBxAaiWmeeesjDvO4dvo64u6BPJRqwO9F44v9F4AiowYu8ZBn7jmnJdyYK3dlpkCOEPc/hdUauRDQD/ddIdtpYSOpZq/dpAACogHa6K1K11LZ87G7Mo3lgZI0JLS7hOk1y4H19aeodCkH1oth1EXooP+VtuuquVRjLUtG4d2yGv+ThHTUSMUAUmmCDVgblaZ7lscwb5OxG0jozbgBIxX3bj9zbZxesgNWmZ0RxoDlcaQrGZ+kvI4XhvQHFIuMV60zPsFl6jETWSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQy6k97f0thR3yTz/+i8RTVC+IMYdMckItW2D0vfqK4=;
 b=TMPjUYokqUqa7oskBPHHJWQIz5KzOANkLxR1Z68jTk5wLTyaLUdSHgA+8HJV17IavCZmsxMPMLtVElD2YoFo7GZyH144IB+zUzKgWL71KicG7IBTOWUnoOgzW7Cq5ID7VIEFM2nKFR9zwx4LUuRZ1tdEi5+CMddb3rhdjDsKYM6Zsgnk9KqEK+Qxk9LCh1XF7zpzLeO4KygrXPD3vQguMdMglEKEuWk3E/avodmxXruy8wHaZ5zaY+IdbVFgrhBh0xaji6TrgWy0tp4+cNh8ueGbylJJcknDn2/t2WEbvLUP0r8SdwuoYYHxjCmlvR3U9UWbWfsUgh71S+KiazGmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQy6k97f0thR3yTz/+i8RTVC+IMYdMckItW2D0vfqK4=;
 b=XKOqlG+Pj59LvnDwjJLIJm5sx6r8Bl3+6TwzYafuDtpJNvTTNVRef94XVlT7KgOBLcB6EBjwFK8nIO6d0xMq9mT0M5MLeh4KRQ5Cc3ineAWMLpyCEAwXf1lYnibzRHZ7XSCofQiK3fZozi+7a46P3PHQb+YdrxNWxH03heAmRkF9XZeNC4zAQGCpb+aZplHKazTCKJXkxZ+8vhzuqHnGA0JWCCWD/7crp+/b5jWKlaNPAR2feBFbopTP+EMpUIFTPw9ML6CWP8uC1dprmx+4t/qcmbe0ie11DG5KwfPjzNsCD0mYdoAM4lMk0vg8WaKiEsp89YMdhObvWT5VXwHzmQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Tue, 24 Nov
 2026 19:56:27 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Tue, 24 Nov 2026
 19:56:27 +0000
Date: Tue, 24 Nov 2026 14:56:20 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Frank Li <Frank.Li@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: bcm2835-dma: Add missing
 of_dma_controller_free()
Message-ID: <awXr5ECg_48cMBkR@lizhi-Precision-Tower-5810>
References: <20261119-bcm2835-dma-of-dma-free-v2-0-ebde4846d206@yahoo.pl>
 <20261119-bcm2835-dma-of-dma-free-v2-1-ebde4846d206@yahoo.pl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-bcm2835-dma-of-dma-free-v2-1-ebde4846d206@yahoo.pl>
X-ClientProxiedBy: PH7PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:510:23d::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cdd7ec-4610-4479-d11d-08df4a6506c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|19092799006|10067099003|56012099006|5023799004|11063799006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k0RnKawYKa90ole90vF5tkIPN9s87YBs7QVj94Aj0VrOLIVcNUWwlVpl1aw40Ucawqn2iUNK9a8yx4X6+3aIKxLl23vaEb8cnyzwNtfSkc/9UfyYfJ+1F4nfSJw+RlJqUa8xjiF+I8sOgRLMn/BjpWqvlWpwgl7dIGjVruVOE8PRd3Co2ipAkk68hKlL1U8YW/Z1E247Mk4vHQKWvzHQZG3XzaQKkKBSZCRAw8VNwNJJ8FHd+b+gPsc/fl6hXCf6TEFytt20pAI1xg5R3qcD79FaIxVi/qj0nzPkSlnMioCST8/n6q08KqVc1Gx8n02QFw9GM/1K3jEPy3R6cJRDIuoie4eIRxm+ZieAIv+MIYUvxma2PsACuylC3oxaibUYfmlelLMLIp7djgeBPyGOFoFYfQKqXgSLKfyB+33c0myebsJjBH3PxDCDC4EN/M9aUU+v6m1WpU1YZsF5H60JkMhGSJEFW4Rg4578asYhVr+/0aIIpiyMV7AKy1UMJZgk/Fs7+LAMrdEFfgFwzdh9WAkbDxzzFAtsUv3g/MrGabDP0SXCfqE9fvijrkaoInWG+2zo4Tek5AOtgGljMtxE9wxabMpf5N/SE5t5T9Fi4FlKHT1pmyYVV4XNo9hAGjKUYCB8yyRnqUhsZSC5BZglgKSyiAqfSb8zn4VtGtH9a4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(56012099006)(5023799004)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+20YKhc05IEuQONbPkDg9fxdAj6ArSCepmELz6XbxxjgOHhceCikEnD07rP?=
 =?us-ascii?Q?BO+RKBxH2hmxSPFjAArIT2wS5fI+3a3gpCAfF5EV+9aFOaGb5z7M820n81ej?=
 =?us-ascii?Q?NWBEhTR056p6FHIGspqzh9Y3Is2YsJrh9pYrd3l25TLsr34pY0tIHqfUk1ap?=
 =?us-ascii?Q?4fZrW/MJATry7ia11P6yYWhexJusS0FqeFsP/AoD+42iABIZerVd6s+WFQNU?=
 =?us-ascii?Q?m6ZrtrXk8HZnjrVhD82lzRaMd4nP8LSme7w1AnJvj7EqrOfUiowvwK5xFBwF?=
 =?us-ascii?Q?z0bDtAYd1vFINm6btcjaW1F6i4jGTeJTPkLR0vK12KRYwncdyoX/lQBX0bI8?=
 =?us-ascii?Q?ZAUnMbJ8bWrKdbxiTX9wgUKb2RK3ZYbn65dbDVmVorxkwid0A3eh5/C5oaA3?=
 =?us-ascii?Q?6L+9AkwGsCJesCuS/dzSVsuOVNH+cX8j+CsYsSrUMOVwyvoY6frv2bS/mxd3?=
 =?us-ascii?Q?uuqEMdGRuNCW9V20V1FgPFKBvK2bnm0ppaVyIg+aJFDrQzu0cgF8UAkvDP3W?=
 =?us-ascii?Q?iVKSYIvFJW054YApzd74B3KAn9PUm6u8JxdKcFZZQSIqGY9C2wXuM7QPqazv?=
 =?us-ascii?Q?yBxtX52C3vJTrCCRJox3/Q7TD024s0xyoilrjKILRksdqy6jN7/8hALHpxzl?=
 =?us-ascii?Q?XCPC55ffXlmJ38zQOAVb9dCqhkgcpoOjWfDs/ovoDEBYj7ICve4vD5KlPIUi?=
 =?us-ascii?Q?bN5fDZXupcwzlS9KLOoGzByCi0LAuscTINkIGgq+9wO1GrzqCwB/etYjSY64?=
 =?us-ascii?Q?r7ZUVtoCrWgOtGBmGhWVtOWojSqzfiUFs+75jqqciHrNUubW3hrTPZfFoZHK?=
 =?us-ascii?Q?hmI1ZCaOw74h5chhwpVPNmPUNIQ01JO8I6ITm5VWVHkGIxAvCPPhPZNzyUHB?=
 =?us-ascii?Q?/HF532RRA7DJSXQi+N35N4YdznBnvpeGrMy0DODJIgvPRbwkq9yJjnWU03jo?=
 =?us-ascii?Q?y71XqSfxTmKy0hEa+AyEZQJU2BtRsfjAgT/YGYVyFsOdhf+3AlcwIRAHF+Rm?=
 =?us-ascii?Q?OD0luep0gJvnqKS12rD2WQaNkHJfsdI3/yc306T52z7OpJxmPKDyP+dfo/S0?=
 =?us-ascii?Q?nbad5Jyy1y65WYwycALsuoAyK2yxB20M3pi5zakN1DMRcbI4nbtORD5x8ll8?=
 =?us-ascii?Q?k95HCUgegDqxDoHCWmVv+bgCtJHSHAT5DkFD3kdCbZpLx+fJLb5RcvR2pSTx?=
 =?us-ascii?Q?72tUOhjt0/DjVl0tbbPl5gI/AK7lbw6zCeFhwry33+IUG+XxxF/Yn9u9gEMh?=
 =?us-ascii?Q?K0CREgN1/zHlRs5evwzZRrlJMvva2N1mdEIt7Ak57qPZaPbnlCQtv+3dEfKZ?=
 =?us-ascii?Q?+jAWrn/Mtr/X+9EVl4F+Vzt0QzYx2rAuu58czTpGjKUfURKqzK25myeqMxiE?=
 =?us-ascii?Q?/KqViStkzkD1TK0lG/TvRFocBf5dJCelWD/uiRW/2MDV8gxIZFTWTIDdoiXa?=
 =?us-ascii?Q?20KOyh1+EKlKE4FL24iJDe/1R7Ae9nAuvrbAUGRiqlAPIsjASq2Y7UZMvfj+?=
 =?us-ascii?Q?gR+ijtj23Wa2q+cDXfoFD0Zhmqsa/4wSHjTdL+b+iVL+hxWtYhcVRAHUx5XS?=
 =?us-ascii?Q?PnIjj8+R+86aYH+ru86QIeOedOuibsp0S6jCxkwST6aOAxEoqAp1s7LCgfbi?=
 =?us-ascii?Q?kwJOyI3iRbz/ZWr2d4xujayGgXlNuOcKSSurWVxwbuKLWkUrneXC+sOy5/42?=
 =?us-ascii?Q?MAw4ws1kNQBtP1dJ9BkPwg+OVWp87/Kv+uATp9OYtBBXwxISlBmypnOwaefM?=
 =?us-ascii?Q?Sy1is1+dSPli1KSzOikIA93r31ETWFnMSwp4quTVQmKJKmaqqtuJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cdd7ec-4610-4479-d11d-08df4a6506c7
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:56:27.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAZmGfOATq/PZ3/eM3IVB4wWN9bR7OQ1FRF/QXUeyCxPPGUKOEGDzcPwMdvOeMa9ejCtu+cxKxuRdBFpCwcPjPHW/Lo/9/F4L48BZfOUu8iQiipI8Nw3kKr2gEm4ArfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

On Thu, Nov 19, 2026 at 09:38:25PM +0100, Tomasz Unger wrote:
> bcm2835_dma_probe() registers the controller with
> of_dma_controller_register(), but of_dma_controller_free() is never
> called, neither when dma_async_device_register() fails nor in
> bcm2835_dma_remove().
>
> The entry stays on the global of_dma_list and keeps a pointer to the
> driver data, which is devm-allocated and freed when the device is
> unbound. The next DMA channel request for this node is passed to
> bcm2835_dma_xlate() with the freed structure and, depending on what
> that memory holds by then, either fails or crashes. As the stale entry
> is found first, this still happens after the controller has been bound
> again.
>
> On a Raspberry Pi 4 Model B, unbinding vc4 and the DMA controller and
> then binding vc4 again results in:
>
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000018
>   Call trace:
>    find_candidate+0x64/0x210 (P)
>    dma_get_any_slave_channel+0x64/0xd0
>    bcm2835_dma_xlate+0x24/0x48
>    of_dma_request_slave_channel+0x178/0x2a8
>    dma_request_chan+0x20c/0x380
>    snd_dmaengine_pcm_register+0xa4/0x2a0 [snd_soc_core]
>    devm_snd_dmaengine_pcm_register+0x60/0xc0 [snd_soc_core]
>    vc4_hdmi_bind+0x4d4/0x8e8 [vc4]
>
> Free the controller on the probe error path and in remove. In remove,
> do it before unregistering the DMA device, so that no channel can be
> requested through the node while the device is going away.
>
> The bug was found and the fix drafted with the help of an AI coding
> assistant (Claude).
>
> Fixes: 96286b576690 ("dmaengine: Add support for BCM2835")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5-2

Now tag Assisted-by: have gone. please remove it.

Frank
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> ---
>  drivers/dma/bcm2835-dma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 06d830d36882..cf29d897450e 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -1011,13 +1011,15 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  	if (rc) {
>  		dev_err(&pdev->dev,
>  			"Failed to register slave DMA engine device: %d\n", rc);
> -		goto err_no_dma;
> +		goto err_of_dma;
>  	}
>
>  	dev_dbg(&pdev->dev, "Load BCM2835 DMA engine driver\n");
>
>  	return 0;
>
> +err_of_dma:
> +	of_dma_controller_free(pdev->dev.of_node);
>  err_no_dma:
>  	bcm2835_dma_free(od);
>  	return rc;
> @@ -1027,6 +1029,7 @@ static void bcm2835_dma_remove(struct platform_device *pdev)
>  {
>  	struct bcm2835_dmadev *od = platform_get_drvdata(pdev);
>
> +	of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&od->ddev);
>  	bcm2835_dma_free(od);
>  }
>
> --
> 2.56.1
>
