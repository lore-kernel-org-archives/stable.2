Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638308;
	b=h3rIEov++20XAg8GLFzjgLuqP5vvM3TCW7WN79k8tFeJ5eaCQIokOlP7uGTNefm8g3OX
	 rHEHVdef7bfqxzbzjD5d4QPpXoBjziRF/YQ5sPso62p7SkCdC9mkp2SGHZyE5p4s8MbF2
	 mXYXwV8r7K1v6fPYWx3u59HaorN7lBRXm4PkutnuGjJo+y/L7yLRo58g/kJieYioYhXEc
	 L8ZbcEZs3VwT2Q8gKdhbKbNpSn73XihqdoJ0F7QJb5dloeLdAsC7yXGaEGKd0zTpqCGSx
	 P7ojp+h42y9o4PX3sjC+snEyXOH+cGaVgW52K+CGMjU99gGdHqhd0YE84DiSyzUtOJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638308;
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
	bh=MeogoBll4osR8WVZpLxUTDCYxp1VK1IUhcWt7b9BcC8=;
	b=0RR1Dlls1/IEi1yY5x7uJvA23QI2ojISZfT/OZ1ca0tkVxfKLpaMTg/9al9B7vMW3zVE
	 vGJtzXG8ChMdvXZVETNdI9CI4swfdpTTaPmFhZF9ziKv5oYWMES1oEBO5aTsVqAgq1Uk2
	 NwBBKcsQGQ/SUYknu3KcqKAb30o7tzQmK9F4jyHzcHWEF02exJQ0FJtCM8M0trPk43hYR
	 PaxZHx9wh7ndYuL0Q/88LvzuPdyp7BfQF7YRIQyEMhzbL7pvBVuzkBuH/tTyQxOondC7v
	 h9FP9jpzFlnKc/gVNmCk2fQJNxX4OVi8rGIcV4d9GDRlwkBjJPSGYWzy6uOlkn0ufDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mzX5FGih;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.55
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F70606A33D;
	Wed, 25 Nov 2026 20:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08F70606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mzX5FGih
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+wQgQP9IkqwzcvDxpQDT7TGwoToJex/osZi809Mdf8VqgMbGX3kOUSS3AH35xIxCxotErnvhC0c134sXmDu3EIS1UOYacQlvzAGTHOjnXcoWGZlpQUjI5HUmW053ss+tWm53YLLjGnEvzTigBKa0ETcLHoLdGimk2Vm08tzt8aUoN6IDfMjcCoS+LGJWaJ9pEjlO2wRr5/2yV8usNdRZV7LiPwEjSXCgdffDVhi2I0VXTxQ6pFln2mYY764ZiRlaYtg3BdDsHp5D4HnrLYxrhZK+veVWe0Y9ZDtEyy7jMdCtxfqCXcPy6+HobI0g01PYDUMdWoEu+8cH7u9kExQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeogoBll4osR8WVZpLxUTDCYxp1VK1IUhcWt7b9BcC8=;
 b=QU9BwdnZuzTLYcKOh0EPR8c7t541E7gmBzHmIzeU3fiul27TY+oSZAeehLTmTkgPe9uuFMJ9i63ckb/qAJrJwZP7LebIcUA4plqswGTRJXyHEj3fSU3IZobnYqV8YuwxAv42E1/c3zrWRRC/da3xvPz2srVr53zVuwL+Skzo6xYjIA8ff+jspUqOjTy+vPlx3qFbx9u2qm2fn2lwGmB4eK/SiqWTH7QdIQRAeDi1YF7c+DfGn7O8B5MXbFH3HiHpuXl9YoRQTHVQ4BaM4/JDD8PDmA8w4/B0H8wMdjnC6h2WQzEtrbEV5mPcfA47jxA4JLHdcu+xMGaZRFvT34mj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeogoBll4osR8WVZpLxUTDCYxp1VK1IUhcWt7b9BcC8=;
 b=mzX5FGihEJ42SL6eGRViyfhROR/Tlv42jmkiY8zN5W3S+bmwBakjpWjlUm0hjYunRw5KGM9qN5/Lt0TJik6pTw/X9rCHOtMuUXI5X/ZDHHuT8+pBGk+xTMVl9SZWUYrvrFyn7ZJI/gBEQXQqGTNoWObHhil8inLUq1OMzi5EB1KSoNoCL4anhY8Vl6oxdYCq+Jn7bjzaRZ7QKiJto7JbXOdDW2Fs2uvfiJYxWhvpkLgg5STn/6gpbyrSFrMFIdEyM+tKoHO/XGaSucyTheTHTFTNkE81aNlBYjgZla3sEAqxoemfEZOmV6NI04+EKJsZRfW8TEVPjJhNCF7YFXJ2nQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 20:25:05 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 20:25:05 +0000
Date: Wed, 25 Nov 2026 15:24:57 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: dmaengine@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: don't call pm_runtime_allow() from
 terminate_all()
Message-ID: <awdEGcZM9HUeOfGX@lizhi-Precision-Tower-5810>
References: <20261125075525.2640884-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125075525.2640884-1-alexander.sverdlin@siemens.com>
X-ClientProxiedBy: PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: effc1138-e997-4047-ef85-08df4b3230da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|6133799003|261009223027099003|22082099003|18002099003|10067099003|261021123027099003|56012099006|11063799006|5023799004|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	neaZggThR/gYLEFOkdN5yojz0fAaoNUtmbc5JeY9L7oGzCCMJO4HeGZXtyoGRuB3cgEEjDMje0mBjEUecKRz9/ysT+BFJgbtA1jtEAH1/nJdsZeSmCdyxV9oDsR3byNwSgZr1JO3L0b2zy4cwhjCmJHxyBzCJz+f0EAEflgyXTQ6JGin9xZPmnZy5sNbZNvnFnpDuzBKInxgRBLxFixUTZceJMH/611Trq49dOKyOIVfhuLlxQFaBuuoeo9cWnpzKI+jBOdOVcmqeVkfClxT3O6g+G3lptxR/sPzJnj1cGJzhYtSpdEMZoSn6bpeh6q5/EHkvwt/v8KXFFckufcgnDgWypV9vwcSgG3OlTkDHfb/qhqo0dB2jDTXgfmCBjPwVUXOhv4e+7Ma1pDyhufTHMCYlZ9NiuR+eHw0eiDl/ZZe469S3TaSE7IASqPaULdWQFl7qrrBfH1gTQPuYJuGruwEXRlSMN4XKpPPMYnCW0zY+TcvKYRVYKaPoRKjxB0e5yJ+xg48WC19ctK7Dv5GRN1OsKirPyfgmgvjywGPi6Cg+GUZ19PQyOFMHltTfYs5YbZoeaQFAVgMKybTAbbRAr/0hgYythQaI94cAVzXZmsqikCI37aMEnIQtEiF9L0Tq38fwIKlKPf5zlwAuCVKYF/MqoVUtFKSa2fzYlulWAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(261021123027099003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJpXF1Pvof+peXnG/SBOZetLbjwakRD61HyPRbyT2ZMSm0ZeuZoqKc7jOm/w?=
 =?us-ascii?Q?b0kRwXUQu5r2KJyqRVtcCQG5yM0Rs/60MpJ2njXkvOFNPTwOKh5Gq0vVAGxO?=
 =?us-ascii?Q?/+HUa+ATKIpHXpJ2/33rf3XpheZZjcJgJ0bnH7ddj8XRREGqzO46NDihoQsS?=
 =?us-ascii?Q?WqHCvE0pdfaDGeeGRlNVQGmmgB7h8Ep4XZHiSfSETy44shWgHZHSvGm8sD5Y?=
 =?us-ascii?Q?iNENo5IuQI6zp5RvVPv5eMLlQaG8HHZ4y6FWEjSsgofdZHMD5ZX8z1mgr+la?=
 =?us-ascii?Q?KURKGg/gyOUSZzUMQv03+QW/TE9yQh+BvcB8YmTiYJZy39NzrXh3KtLc2nE/?=
 =?us-ascii?Q?9WQoiTiBYJ4pFJ5tJpjIRUG22jUVZ4tJATrP660OIhCzjTqx07MMd3bTlrz0?=
 =?us-ascii?Q?/hT7FIsgKK6+i4ZI/eY/fVus8wpCHk2swkbhqu4GgzXBXxC4LSQLDrNgnXaT?=
 =?us-ascii?Q?EEjxdTKXLx4nRxfJaqu0Rll2aZSIKwZi+jTeT2CVjTeNgwLeol666c5wP/sb?=
 =?us-ascii?Q?moKAscTFuFArMZoP2S1eOs9i20nLi7tEhjKAI3FgRuZwP+btCwiiu0Lf1seK?=
 =?us-ascii?Q?gYEtj//sGYb2kv2u4cgk+MuRBthxIqidOh+ervsKzieGdj965de/pa3TAaFX?=
 =?us-ascii?Q?SV3zkOcuBQ047RFMjIcOuVF8MBY9A/QztGVmwfQ+Z0JNlwTX5EkCogIgfvNd?=
 =?us-ascii?Q?fvJ9reZmMW3/QAd+nbGRU4Ug9zrDzwte3+A1RgyuTNVJlY7QEvIJ7O2BnXAU?=
 =?us-ascii?Q?xeUI4R2s679vkpV7aon00KKjSe3DaJLNtu1WSXj7c2rI1WoHsWY2ig0G6a5U?=
 =?us-ascii?Q?coudZEMAVB1ICOegBQJMcT0Q1X5zRLJjr/dNLApZak6DsPeGw1XwUihKT0+a?=
 =?us-ascii?Q?p7esk7hyzR5hI7RB/9y5UH/wG6yG/O9Jcpp2f+4b1xjLOtj7aaGm54Npa7yL?=
 =?us-ascii?Q?pp/HKVpsOtMrGNVQZSF2pVlacKYGUjXl/uHkZXASYgoxmqjzC2jRJQOWH732?=
 =?us-ascii?Q?vd85y+BJ0jPFEiWcdfRP45pt0MFle9dTvlPTyuA4WzdHuGPSuJd55uR4D20P?=
 =?us-ascii?Q?ln6rk7kuF6BsdhFeyezaRJPlgtp6k4n24Q6k47YQI6rLSGZhZUT5MtzMWXwN?=
 =?us-ascii?Q?t82Z7Ul1qBrBZjEE4n6XXB4H6AX6q9LZwfiUwt5vX7l8SiOoQx/dXT9nSVS7?=
 =?us-ascii?Q?JKutR8tKPuKwNJglitvQcvbVnkLZyiue/xWFLl27MoyJ4aCioSKFWa4RsDt4?=
 =?us-ascii?Q?xo3/xdVMawhv5q/3dDNnWmnMwuOes6fWgNCHLYK45Cdjp8zmoMFDkr759k22?=
 =?us-ascii?Q?NbPPp3UHvp6af7YApMl8qwLx6AXLT839bWmjp+yojDQbs0h34gHuxh74vFG2?=
 =?us-ascii?Q?8seBu5oT2Lc0F9xTO6q9hQw/vrJ8BlI5hALYZM7PiAse6HErLzfic/MyvSwu?=
 =?us-ascii?Q?rEuLqSikg6QeQ4+0YC84N42zXwU/j+kJWHil5iBu9Ijt4mD1n2CmJ0IaFnK6?=
 =?us-ascii?Q?YHI0jIOyI5YW+IejLkAo9sguBl/k8PiuGAnyGy4TCiRU87ShSE11RDxus+rj?=
 =?us-ascii?Q?P7vRc+YfamLc1xZWX0NN4y64FeIRRJbhzt+QSMIxCp1i3UALK5LzmCq0FmJD?=
 =?us-ascii?Q?L3Vxue2zcNP4plFFiqutPkH3qVIWGkjXrAFqluSkjMfHjx0UD50Y2wynDzNT?=
 =?us-ascii?Q?zm/CXJkNFmmZAPHUUcRa63ryIcOVfnlGd4Md6tqQreOLlFYu8vuUhX+Glmfx?=
 =?us-ascii?Q?XQlbnc2TRS5/43Jc/6IK+AKnT8H/AXUcHYoBqdmAwrztpqg6uEQ/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effc1138-e997-4047-ef85-08df4b3230da
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 20:25:05.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uu7rQ9X+/j4yE0+Dbd21w18ThbxUMWGD51kWz3eovmski2MTXGRBw5dDmrxUpnGaZljxqhLbsdgWBfuiEdwRO2lSi3CwIJIY4n1p81Zjp87/xpeY1Uuy8Nz8VzSqcO5V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

On Wed, Nov 25, 2026 at 08:55:17AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> fsl_edma_terminate_all() may be called from atomic context via
> dmaengine_terminate_async(), which the dmaengine API explicitly allows
> (Documentation/driver-api/dmaengine/client.rst). pm_runtime_allow() must
> not be called from there, because it uses unconditional
> spin_{un,}lock_irq() and therefore re-enables interrupts.

I think pm_runtime_allow() also need be fixed, which should use
spin_lock_saveirq() although should not call pm_runtime_allow() here.

>
> Calling dmaengine_terminate_async() from a UART interrupt handler on an
> i.MX8QXP triggers:
>
>   DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>   WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4404 lockdep_hardirqs_on_prepare+0x1a8/0x210
>   Call trace:
>    lockdep_hardirqs_on_prepare+0x1a8/0x210 (P)
>    trace_hardirqs_on+0x58/0xf8
>    _raw_spin_unlock_irq+0x38/0x80
>    pm_runtime_allow+0x34/0x140
>    fsl_edma_terminate_all+0x1d0/0x1e0
>    ...
>
> followed by the IRQ core warning that the handler enabled interrupts
> (kernel/irq/handle.c). Both warnings are one-shot, so this is only
> visible once per boot.
>
> In-tree, fsl_lpuart's lpuart_flush_buffer() calls
> dmaengine_terminate_async() with the port lock held and interrupts
> disabled, so the port interrupt can then deadlock on that lock.
>
> The call has no counterpart: pm_runtime_forbid() is never called in
> fsl-edma, so runtime_auto is always already true and pm_runtime_allow()
> does nothing except the illegal unlock. Just remove it.
>
> Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Alessandro Zini <alessandro.zini@siemens.com>
> Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 513b0f4e5be21..1f1f5fb353cc8 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -10,7 +10,6 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
>
>  #include "fsl-edma-common.h"
> @@ -274,9 +273,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
> -		pm_runtime_allow(fsl_chan->pd_dev);
> -
>  	return 0;
>  }
>
>
> base-commit: 2e02fb103be058cf8b2fb24112a74a2715e090f0
> --
> 2.56.1
>
