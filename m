Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273389;
	b=E5BwbpVgNTdpYqk/0B42UcAkCXh9B6kcRtY5UVzBzX5FCGFFIpJargWy3rDfr3UuEOSW
	 njXwLse86EePmcMsS0S1NYc9OEWfJTBiCmdu8V3r9OeO74jWjZ+1EO7EFqvWiQr1npA/J
	 m5Op5usE5VbjfgPuSQZ4g3r6U2tZi0c7qylmA4vtPgN8kXQYO8R26LC5rx60tHEuV5D4V
	 psCOASKc11SxthOnA2haZ5IlAPgiH17AE1RpSP7KmhOtQlEt8cRim+RTbXQHx0dvjFC32
	 1W75OpXMSUXLiFlb/VfdywyjDG1EFKZfYjCrrDzS0mmvuhnsUt3wKxpxEHBdUz6oVwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273389;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yD74xtoGCyvlgZua1tw5eFLgJtaHXCs35MrEwwHMOEI=;
	b=LXEV7P4ra6SJ4hQ+kDaxwuhCwJf4lbxpbwutMwEQCDnUUpXgt9PF+6ZbdG93qm/a4Da4
	 PGyCEpi2zJaE1VJCilLSePoMsqHlnObRHcS4KfTs2UPC6FRetUx/E+I19BGO4vryacdg2
	 +WQYFUQeqVKgh7bmBkUU2xuTaWIgn2DSpFB88OwkZMvTK1ftPVMtExGaUhPfYmz8HhloV
	 StztaFCkkzxugg4qYyw9KvLt4if1p6eWDOqATU9xB2kPT8tq56jlXDERjQSFfstr8FBM7
	 E97mNDGkQVZBCYQKdu5vFl2RU2N4Wo/t4y8X+4iEm4BneyHHWVMSSTAKkkq1ROQ1oYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ehw1WTu9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E4606A31E;
	Thu, 29 Oct 2026 11:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 650E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ehw1WTu9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG+ngZyP+f6RNu8UMaMrmQMo8wv7mQ7aXVDPKlwXVh+Em8plNSDhLuCgXzROA2YtHgEkjQ/cfdKNJ1LSi3qRxxwPY0Q0LRMS0hD8IZVWFCNNqhbCxg7UyF4CVAwTUc/CecsGgvcNeMsadAF9abYghsJZ/HHjkdk4bRfxdoHw3//jbm1lQDKmtSYpMDSQ14LuluiZs1FHkRkmSSAfuQre3NSbiCM5n+umeoVbxyseFZiS3oiYmD03KgYC4NJwVDelBIwIubwm/9iy4NHdqciWUG3eLs0K3cB9RdqZxHBuF4kHMQhE2d4708WVEuhwQDFbvjTv0nHRXlpLNVzCCDKrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD74xtoGCyvlgZua1tw5eFLgJtaHXCs35MrEwwHMOEI=;
 b=wjkvy0b6K96ibngJSRbC2CCK5vmYfAMnwkHbDk9dQFg40hxyNWEDj4yhOH1WxDX248l1KDS54W5KU7F623P/0WW7OU9LdEx75Pn6taUjHcjvGw1aaOly37u30ZeFemRx0pFZCIpONCUCPdT0CqnrHWjR68bWgpy8oyCJbcxmdbJ6wXrsKhhItgxCrChK5DZszQ2IGUoDMCKt/SNzapK5o85LL7myRrvjW3mn9GgfUKx/RABHptYAfRJafEQmto4tQ8YcnoXpXY4Y/ZFILLkRCEGympFwOpNAC8HFYRAFrnlh1e0dFPBGkqwgtQKiY0WblEF8L0e5pZSf04Bt3zsq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD74xtoGCyvlgZua1tw5eFLgJtaHXCs35MrEwwHMOEI=;
 b=ehw1WTu9F2HaBnNt5ECvRC5YO2ZlX1Fo5IW135E6AEcFHwe20o6NUMzYUvVcE2w69yhJ4zaRu7dx/rfeWrY5+7UW7HzctXiCk9JdAOi09obDGUNO4w6oLshp4Wvaof///2npanwf0Cuq/hC0cHm2tnLbr09/pUHOKkMuf9/OWJb03bIanDfpVj44Pr0u1TIbm25nYhMdkvcsRSG3qwVElqU7Yr4SGUB30URZBNnTBBX8uErab5QVdPsftXmQ7c4yrWBWhQ6Be9s4gop48Q+wDgiKaP952LOrZ85SL+kU39KOz+ngrG1X6G5IdtGv1CgGQH+fc/KqRAm8rVrwQPNPhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:25 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:25 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 1/7] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Thu, 29 Oct 2026 13:29:16 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 88edf4b3-e41f-40cd-5367-08df35afe31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261026140227099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xnNCmRgowMWCgUQGyyVGiuw1I5agmluY8UIw4RApUUmQt55gimi5TA9wAVHf/hIE1ztPo7FLmPhP6mOTBr57KxVqaV6DBwZY20yrYqJq3+88Gg06AZkBRk6KwBGrDui9rNmLfzm5tMLKcSg8X55Bhk0OrW6xS4GuXb3JkHKzJ5KRyPnV1FEuYiLvnOkJn+TGLsHUdlzUfTkH+xbJuh9Zh+EbwmYN62BLicyBbiaxsyOOnWF9RNkLs3SnEAyDpYWfK/T0jYHrWZ8ftyUhDrLALOXjD4KwpnYfjyUgcNprybrbRGj4tcu1ccshMiRNIN3mpsCDtBBC6neamT8dt76+/3Rw2yx5hp7+4VhOU882E8IM/Su4djjbCROgsE+6NJyHsxYHwlFi00497wLOHNNfhpcnHz66G4QFTWb0RNdKOzhdRVokEfYne87w3rIKGV+Iq311/dlCr37aSJA3EENCg6Wnimv4r+PmQyCwWWNpCUfMhjpGD1M0SVitzhSZMU6PlMi2b4NpafXDtIokysyES9i1fiFoCZHBvL3HSm1f7Ywx3RgSpZtkBCudw16lXwzcBA2rBnaD/VSCXdyzVJuU2VlF/wM6tzWfjmZ0q0CEQV4BPhafn6EF4KsAaNbJQp3QWh+M4fbsQ20mZEZ+MQhNwkdNI0qeh6bobwKNIWJNbvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yi5/psehVQ4ka0kyeHyarrD8JdTAhIf8aeeqSmRyvaPpmnC3X31SkC1HKHX3?=
 =?us-ascii?Q?iFoMtYwa5WR2tW3LPwsQQ9ccPp4cDgBZ64eE7zw9OgYBLlAGMhpHPTSKRysY?=
 =?us-ascii?Q?0CzCBZ6PGrglsDduwaOPhjWbFHG/zq9CjsHcWCtFju0XEOU6XE/IHQ1Pdvsk?=
 =?us-ascii?Q?dWyWwIzhCIE6V4BiX7oP9SrTmikhADQ7FgluEkNmzWQtgNLyAfhNm55ZCrv9?=
 =?us-ascii?Q?ZcTnc5eVGtvJSnaycbcsKQOz/8phHUs7N7DgvBxT0gd4jZYiCXWWOHcGbcFN?=
 =?us-ascii?Q?6v0KqVlxvZg4V0ojKbEHkVBTXkcNAonb5rkl3T5pbVTiIUighNeH+SrfxIvG?=
 =?us-ascii?Q?VFtJmW92GinlIWanjlGxQaFXEazsJtqkzDxRHA7J6BL/JRiiFR6QbJAaIh6M?=
 =?us-ascii?Q?DSH6lbzrmjVt8YL7EV4hjtXnzz6Tv9HoJOtojr0o37t35TTbIFDc/Pa7wOxa?=
 =?us-ascii?Q?E0Wq+xCdNRfLw7kWzdX+UkEYfGjre8qRxvx3FIcBiaEWw7Mxj3Df5B/V82X3?=
 =?us-ascii?Q?TRlVhZj2D3nGyXVmBlvHnGr81Owe0sHsmFQh9jfmMdOf2MsRxhitLA7r9BLG?=
 =?us-ascii?Q?1GhtLAtmiGHp/N9NrwQFY+leKdgcSCvuB5ba+m9zRs6mGVE+ARiEJwIKQ7I5?=
 =?us-ascii?Q?JjHNPme4WQlCHQgi+Wdrux016EfTapt+cvmGHEBs6sZAP065A3SL14Qoj0az?=
 =?us-ascii?Q?W4ouSTjjC9bgpmakYhC540W+0fti0JLG4QaE+Ec/EAlkf+NRHFdchp1A74/e?=
 =?us-ascii?Q?75RUiJbKC63SS2da5WEz0ErEoC7Ugu7UAhb9ierN6EAtjC+MapZmAjS/YjcA?=
 =?us-ascii?Q?uxrmPHzafkBb3RLE9PVjJo9TE1J8rwcpJM14DyDn/S9+Ipk3saeF6UU79G8d?=
 =?us-ascii?Q?eztOZm6RHfp+prvSHvkud03KJ4x6/I2admqj6jMS6mzl95hSAAFp6eW8wwMr?=
 =?us-ascii?Q?QdoPqKMIHMQg/5S9M1fBcv4p0ive4fhAV8L8QdhaPmCGTEru8tOAsgggkqws?=
 =?us-ascii?Q?qe4BJRGxuoD0YncE46dfdnXrXF/1nah6jcwNdp8w/9EaJEl48CymKrNa6+vx?=
 =?us-ascii?Q?IMZoJ8e1JZv2vDsFyC2kMyZ6+WYU0eqWbYu4zFV6esxwtp3PjC9mIXiTznMa?=
 =?us-ascii?Q?S2vm0pxT4UUvADUwmk22sLRpCPLZL/7TP/WlozyjgLzjYkhmwUTAdLAnAMeC?=
 =?us-ascii?Q?6Tv1oDy+CVofDTpAI8eQ+VrH46aHU4KZa+jMDsIDfB9RWXLrKiv7Zf1UdiKU?=
 =?us-ascii?Q?asgfcKYHsUT3PEE9jesYYTxE1rJ/UsU0jbkv0ElMRSMZoLNM5WdBsRkv41GT?=
 =?us-ascii?Q?9IQHmdnNAZqJgZdjWcWq5cT8pkYfa5hRef6uR111yOH3/xA7ScZvgEPzX5Yb?=
 =?us-ascii?Q?VKqnGxj4TWtu+DxepsunVi9KriVUM1F8AVdKmvDSB0BlBYEqBTsRZF9KZYN9?=
 =?us-ascii?Q?vYWO+u2sj5Rrbt7Q9GSm+E0m3+j8Wc5Y+EZDXKHALwF2D6EnSreOs8W+/ZO0?=
 =?us-ascii?Q?NITETlB00vhHB9Lt2rMw0j6t1GTQekuHrYTMGjhi+33ebpq981rp8BFdFsnQ?=
 =?us-ascii?Q?h76EQMTc+vgS6uXDDdHHLaWvYGxHHCMgRF5pRClWEIWbnj6CBtDBjHa3fYM/?=
 =?us-ascii?Q?IV+G6wKYKBivIFU8XbUPXhcYibx4f4lyldcBn4WhbPjI9jdzbZNOUBTUUFvi?=
 =?us-ascii?Q?g5qkGAhslCzYH2L8ypO551xmuBiDjzO/84JaNoinH50f85zGdPrV7YtJEVvG?=
 =?us-ascii?Q?ZvHv4kXP0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88edf4b3-e41f-40cd-5367-08df35afe31a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:25.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl5lKSDl1eMBelT4sdVuq5syV2LD3vZSM+nM+A4bauMiYYI/fmuZu/Onb9vpLQ5LfnFFYcouhiyuAoZAoJ8xLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

desc_set_label() frees the old label with call_srcu() on
gdev->desc_srcu, and gpiodev_release() calls synchronize_srcu() before
cleanup_srcu_struct(). synchronize_srcu() waits for a grace period, not
for queued callbacks. Once the srcu_struct uses per-CPU callback lists,
a label freed by gpiochip_free_hogs() can still be pending, and
cleanup_srcu_struct() warns:

  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
  Call Trace:
   gpiodev_release
   device_release
   kobject_put
   devres_release_all
   device_release_driver_internal
   platform_device_unregister
   gpio_sim_device_deactivate

Use srcu_barrier(), which waits for them.

Reproduced with a hogged gpio-sim line, setting the chip live and back
on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
cycles; with this change, 1000 cycles pass.

Fixes: a86d27693066 ("gpiolib: fix the speed of descriptor label setting with SRCU")
Cc: stable@vger.kernel.org
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 90731a547ed6..faf4a8507dd6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -895,7 +895,7 @@ static void gpiodev_release(struct device *dev)
 	struct gpio_device *gdev = to_gpio_device(dev);
 
 	/* Call pending kfree()s for descriptor labels. */
-	synchronize_srcu(&gdev->desc_srcu);
+	srcu_barrier(&gdev->desc_srcu);
 	cleanup_srcu_struct(&gdev->desc_srcu);
 
 	ida_free(&gpio_ida, gdev->id);
-- 
2.43.0

