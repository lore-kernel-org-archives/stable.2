Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512064;
	b=q/wNdlgwA6Lo/JyoiZYnD8LQWR3h/Ka2WFi5JYJ0Jk83MAX6Tjr9ZhWYwGCU4Sf7vQGk
	 2ZeDd9cDqsaUDYxUnb3Q37wk8ETGCPGH6njqmuOSbs+eM1hE1M6WRdcvW9gP3/zpTdOkK
	 XuMIgTrlevxMDqahDJYncYzGUBjwcc3fysMMopjVrH4WqhNPuMgIvCkRWFVTNNcec1zuD
	 FvGn9aosscJi3I51iMPCaUSuF9NhWm+Kff1vw0HntdgTfl+U9Tnh225xsPLR260n8MwW/
	 rIPZyqyC6T42q0rv0xlEuHQiS1OoovDtfK/Spod+vftxejHCo/T54da6YCISt8ZLN+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512064;
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
	bh=DdEwVAem/3FnkDFJ1Pty4QBq/bhbOGPxjzpQIKBOf84=;
	b=OcNIdG+6E0bCFDZOUFkxFT+t8y7mBUXEJypwW7uX3cW7ARmsCvIPxAFyXlBCHNMPa7J/
	 mRCBKW4Y2QJr1Ows6FT3l1+nigRnArTTZ/bru2TbQ94FmDDPzUqMr+IxyBLYIVsRzf8ND
	 3ReAf7/W6iH0AUVNqyce0H70DQc5dhWjQNw120mpr3KVo8VP5q+tzuh9d2+MwwYfPm+iT
	 JVN4vMf/YcmPfaPhqqgc+PoPgSOR1WrrTvM5A2J+fxOUR5DZwVPUQ50dPJWCXx+lhD1Jn
	 H+/cWb57wNFWaMfFkTXjQf1SgC3KGPg8Egme8yD51QX99aQXmpgJI4TmHsykiiL2yWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LjcjNnRV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.58
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF00606A693;
	Tue, 24 Nov 2026 09:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF00606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LjcjNnRV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAom3Wf2/Snn8VRQdWdqrcaYXeJR+QogMiI53rY9WHrumZJjbS0tEI9GcGgQpZgvFYw01wtiImaCEN6XCvkAX69J9oRfFw630/o5y//CgD519SCxb3R8rrk3vBR6MamGMem6X6cWRKI745EacmPLsWUs2zYBH+9WcCLfDdvIvSuzrOGanTqKx2Y4kTMF5uIM3O956Js15oRNhgAvUWpV5vOTX2n7RI+ieYPcDVMZMUaCMwfrffrJRFq+Bec+3PBUFd0OAMCEBW4CCQlY5utiO7zjU22PPtF7Vg39/XX+DeFYyohmoD3w6nZm1td+u3Ai8jeM3NsiRAvdA6KzBPlNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdEwVAem/3FnkDFJ1Pty4QBq/bhbOGPxjzpQIKBOf84=;
 b=kv1tbsRkao73Haj+9NNfr8k+KySXShQMGqoBRHGfaBnkRUsYn5DQ7VLZb2/O6oXXOSji9iOJGyIEkH4zixZQqf5XMMPrTbVSFJ4LSI310Shg+ry4jXUIwMLiNP/yiJ1PbK2Zt1iLNsvL6OK+U/26Ou8x18NF+HuzNZeVWTXFwZo1jVk+uQOw62Q8k9k71v64JMjaMPYAdhDjPZdoriDzaYBG11RZgICVXYfGERe6wjLEPqw6sV2u6LIbnFwQjqVT0OGpGdGZDfJg6rGSE2XE1ei0fcvbJ8YIusxwruA3JkR93Z/xH+JEq2pREWFlZhoJc+eMd9ANvcK7zAyh5IUEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdEwVAem/3FnkDFJ1Pty4QBq/bhbOGPxjzpQIKBOf84=;
 b=LjcjNnRV+u4h5PFK6n90SultMO7oZMRh+YwA84PU+cA5J35lvrUmRd1mj1+U7ubGJ3u1X3LxvHwynw7yjZ/pXBY8FC2gNZkiFn1Nsdx7Qfx6h4deCfNFNwQAKz1B3yGVT7HubBq35B+xrGxQOsCHznFEGcCZlQ1oXFsMAgyMi1eSIAyRaedf2xXkuqdXkJU2EMunMkVnnrR6d4++Ep1xsKSM/unksHWcJ597nbNjx5v9IVnXc8/ME5/GbYxoGvUthhigyJcl+Pzqf2/W1PQ7jKljOkPrK2s5ml2Ct7xtwD7AJ8qdtWsLDHtYFanYXX0RpFAwMT2nr2NM72erFedmHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA3PR12MB870191.namprd12.prod.outlook.com (2603:10b6:208:712::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:21:00 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:21:00 +0000
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
Subject: [PATCH v8 5/8] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Tue, 24 Nov 2026 11:20:36 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA3PR12MB870191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a38e1e9-5a66-485d-7f90-08df4a0c4133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w3DsCCCqWnb8+KqWxpOFwi+DdEC/ayCJUgtuCPEJDfuEcBPpH4In7gPnpKvdGVeVinISBW01UYSk2pIWEt2BGHrygJhoGVtS0UIVxzjvC05PHcIHdzn5803RhEtn0slAe7/QIvf0nQhq7S/1zwRusXhsWLIZMGndqZ33JlMQbzk5LgOAWRq/PZ7bJ7zRxg79RVYCw6HFLI8EHnuNsfOxoY9CP/bsTl5nEksNCie08KQ4RfAmI/y7Vk+QqgvsJd/YvE4XVnzfxq7WTsoIO12wpiWElLR8PkCTHOxM5lnQVEZRBzORSfSJpx90OHMHTbFctdCROjEWe04RlghTSE493QAeiNvSpWexgZHlqZxc967JTB7NcEj6M6GaRglZ3wxRiDvuTuUd+JpmB56LLczbXIze4ni2VRpudlZnLE40/dZ01ffWVHx/h7CAuFJCfV6TnlxEGNya5I02i1tD7f9XOCHtRc9q8uS+cf5SPHo5mB27Z04+QXuZBKp/FklhebFfUy83Tv+dAdvOp/keGlU28rRpev3e3qypzMMolwjbnWZK9ruBIq8aJogy1xyyc4K0Ri305k9E3s/cfA1Rm7liZThQAPX/4CpqWw2JyzP+bUkSBFl7xdn9NcNhkBC7TAqXr7J2h5TRk0sT0+mgatWEzp0KhLeBxqwDKhctfygTahc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDMyotAjSmgDHMxAdisYquYEpkE7+TNYLiCgdB9tzhgU0IdXF9cZzasyCF1H?=
 =?us-ascii?Q?n+LjgK9P54fmikBcF3vcWDhtx/ptNWJVNvaGwzZPzBemSarWpvHBmxXddOmz?=
 =?us-ascii?Q?uUQ5H8ljxS6VERKUApYlC2fY6NqkKaJmyaB9YfnJLKLcOcCqxwJTsSyfuS1B?=
 =?us-ascii?Q?16wjLLf4bXoUDmP884ltBqpe1U4fbUiGi0H2ipQBPHUY0lJo0j7wRHcv3P9G?=
 =?us-ascii?Q?/Cou/yh09Pw4m15+llMRScChVTVXMivJr/v0OkJ2fMwq/xfgCulgP4wPKpq5?=
 =?us-ascii?Q?WTSKWQgqt1DEmRq9tUkz5yAtj1nORebJuaWGVsoD6ahwvdEeclAS0hAi21MU?=
 =?us-ascii?Q?8ytC4KwRmGX5W6PqYlzjg7u7V6L7WXb4uVGnHgQcxBMmOpgkdDPZ2npNH+Bn?=
 =?us-ascii?Q?uA58jjIpo0WlmxmJ/VZuSGyK4Q2xB5mab0t5ep7z+6/So9hfL6rcfNAzNuA8?=
 =?us-ascii?Q?PNFzZrqbw3cndiGPVaerqkZ1tx4ISSeaKCaBGzz4eJbYc3fm7dBfeCPB0irA?=
 =?us-ascii?Q?joEHQ8i7HFyaTN+IzHZGr9slEvgx6RmhIE6wUSQUed6p4Bl+9B5a9b/hDqzP?=
 =?us-ascii?Q?+nCI6XCjKEzUtH3zW828wqpvqZHRX8K9I3Fjb1zVhssniyUWmosQtmmf8qBI?=
 =?us-ascii?Q?q7jgTz/9tIMklniXHEFHba5a24AXUCcfRSgPCbHbny5VW27QGWL3xZTTD8bC?=
 =?us-ascii?Q?b4M0P/augDsX20oOlsDkvvX18alqH0NxnTeTCjUMC9osMoOTLhGFcghvNDlZ?=
 =?us-ascii?Q?p2SPAKN4pJnEQZbE+vIvH0SAaojADf5Zl+T81I8d8OKRb9sFzyuEwpCOJlpe?=
 =?us-ascii?Q?NKTDI0w5DEaOECxHkjM5AeFTnPmyqX5iHMaq4rACB4OONC5FXDs1t3TiCuBV?=
 =?us-ascii?Q?NihPvs937RVtXK3Jpw5nnMx7YnKao3UM31qUsmHH62HHO/QIsOz3ETs3b7uj?=
 =?us-ascii?Q?w/Y6li5qsKqNCld6vFbzoyCo3r+9iq5molz/McrRx8XWm/xIFDPV33Djk0Eb?=
 =?us-ascii?Q?T38kz8Lm/VAofMNoerzzuT8GmkYkc643TUX5VsIe/31kIVNDXPsSvZtfHY7U?=
 =?us-ascii?Q?4NLJqs5S3gciclVDAC6KMMWC6pJfLlLWcplZkBaw/yRQyrOmr4yb1WD4SUR3?=
 =?us-ascii?Q?0RUVjG2A3Jl75zcvg3af+9N1tlNu8CVkJoaDkgRIggwgui8YC2oPYzt99BR0?=
 =?us-ascii?Q?yLxHWG7gOjZqcw0qGHAUgu4ZofbRT0m7fi/ykQkFo/qYW0r9spDIXJmR1OK+?=
 =?us-ascii?Q?DZC9Sfo+nAFEOuN9hfYpn+nJA7GqqLhrfiO4UIYIgewDrOTpVz+siyMVQsEw?=
 =?us-ascii?Q?0dxoTMEzWrzaUro8gn9SVQYCrREvYxte6bN31ijUkx/x3tpMrmDu1t+FbwdX?=
 =?us-ascii?Q?qfieB3FhGAMVvbFrho8c6r1tfc2a/3DSa+gXgNzR746TvfL5mvuq0jvJGM0s?=
 =?us-ascii?Q?EiYUKbyvrZzU6OvGeTNT8FeViU9GjNJnV7laybnWaLJ5/lOd2DGqAiVJB2Rr?=
 =?us-ascii?Q?dQloXp6Z7WGoeE/qUpOHRP2/MJBRtk8ATECSx5tb9BEIIssVPFmG6Yw3kS1A?=
 =?us-ascii?Q?h4ta/Sx3/HEd6i7i7Q1kuyiz90vVvkhrCrMYF+f/OVOWn7BkCet7ONk1kolO?=
 =?us-ascii?Q?j52+oaHkS7EZpPAjsXnQJBTzWFHSLhbPHistxPSA9Rhsi2dYiQ2uYGotLqcY?=
 =?us-ascii?Q?ZSsyy+V1UjAiPpJfplhiUOs2+cmCZKrEAJpcBfclsQ1mIahZuO4N7yEblEFo?=
 =?us-ascii?Q?j2CeKc11Fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a38e1e9-5a66-485d-7f90-08df4a0c4133
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:21:00.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TP7wiHST86yde7l4TqLElcbM/15WoZVy7ryJvLaS8jNFE/zsSkb6JHwyhYD9wx58LqJk2Yb3af9YoVWBanYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB870191

The character device requests line IRQs with a copy of the consumer
label as the name, and frees the name that free_irq() returns. When
gpiochip_remove() frees the IRQ first, it drops that name and the copy
leaks:

  unreferenced object (size 8):
    comm "gpio-hold"
    backtrace (crc dc8eac94):
      kstrdup
      kstrdup_and_replace
      edge_detector_setup
      linereq_create
      gpio_ioctl

Keep the name with the line or v1 line event, and free it there,
whoever freed the IRQ.

Reproduced with gpio-sim: remove the chip under an open request with
edge detection and a consumer label. kmemleak reports up to 23 such
objects after 30 cycles; with this change, none after 100.

This patch depends on patch 3 of this series.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f2da4f2646bc..fdcd315e776b 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -400,6 +400,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
  * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
  * @timestamp_ns: cache for the timestamp storing it between hardirq and
@@ -423,6 +424,7 @@ struct line {
 	 */
 	struct linereq *req;
 	unsigned int irq;
+	char *irq_label;
 	/*
 	 * The flags for the active edge detector configuration.
 	 *
@@ -602,16 +604,18 @@ static inline void free_irq_label(const char *label)
 /*
  * gpiochip_remove() frees the interrupts still requested on the lines of the
  * chip being removed, so once the chip is going away the IRQ may no longer be
- * ours to free.
+ * ours to free. The label is kept by the caller as free_irq() is then not the
+ * one returning it.
  */
-static void free_line_irq(unsigned int irq, void *dev_id)
+static void free_line_irq(unsigned int irq, void *dev_id, char **label)
 {
-	const char *name = NULL;
+	const char *name = *label;
 
 	if (irq && irq_has_action(irq))
-		name = free_irq(irq, dev_id);
+		free_irq(irq, dev_id);
 
 	free_irq_label(name);
+	*label = NULL;
 }
 
 #ifdef CONFIG_HTE
@@ -939,6 +943,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return ret;
 			}
 			line->irq = irq;
+			line->irq_label = label;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
@@ -981,7 +986,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	free_line_irq(line->irq, line);
+	free_line_irq(line->irq, line, &line->irq_label);
 	line->irq = 0;
 
 #ifdef CONFIG_HTE
@@ -1081,6 +1086,7 @@ static int edge_detector_setup(struct line *line,
 	}
 
 	line->irq = irq;
+	line->irq_label = label;
 	return 0;
 }
 
@@ -1777,6 +1783,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1790,6 +1797,7 @@ struct lineevent_state {
 	struct gpio_desc *desc;
 	u32 eflags;
 	int irq;
+	char *irq_label;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1825,7 +1833,7 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	le->irq = 0;
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
@@ -1909,7 +1917,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2148,6 +2156,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	}
 
 	le->irq = irq;
+	le->irq_label = label;
 
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
-- 
2.43.0

