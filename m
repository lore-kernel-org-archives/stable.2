Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AB45A29F;
	Fri, 16 Oct 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142586; cv=fail; b=BqO3h3367LKo/xBoO9ob3IxmyJxEwrkFCCR+Rt1nOTjtNLBL/MxDCGvbf5CKEQcCTXlbMVx9Q6yPPqUW/UobIip138lzFx8/QLqC5qIb/nNU7RuvlQa2H4UXuraGlJgooXP6t9DDGGEBHHW07Axd3J6g+x5XYe7esv/9F5WSxkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142586; c=relaxed/simple;
	bh=KQZPf89/pc1l6SSnBSooYeqpAjwVMTJOoah9tQBj8ao=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bp7Es7zq4itRfCcXdoDAYKILS/k7kypTeV978dYvZjEp83Ks7h9TLEKRIroe0g4iAJMhhdkUr5EYTeF7Wa0TeCMW11VlsSrUuHbg1Fy2W7AqCz4xq55ltAk6J7IEY3sQhCgZi0vY1PbkdVXYbeslKGHUXjunmck4wk63Q5m5Sqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvY2Jm3c; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvY2Jm3c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py6OF1EuahnX5jEUGd4LNxpZOvIgr9l69V3ZsY17XWYQCtfhQAMnjompIaUUiW++fyfdyR5sajehvcWfm1ed7S5ZOuW0+f9tgHee5VbhPBDXVuOyNK+dQgRFWGBd+/mqqvXpqL7IPOCfGnFVWuatdABjdkbp0dPWQpd88nPaaa4M7RKNwhrYY8jvxYmKi3h6VSbSkW93pzwea1ZVM4HDRjjHKM2nu8qfXHMyMTZ/YQAVHbZ0lKqPjmYZSGn5ytfL2bN5vky74owNOgYSqf8BPHgXBF1Udrh7lfEosneAdP0aJRS6F+WqyMLfo1LHJ76tLaXy7NzurWuHujHlcrZfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wgg8XeBubbqR/fvw2umN5528mdjzZ9HKT6Q1oO0oQs=;
 b=rmYiGOst5Uee8w6qWsCCCL5ZLnZw5lPYcvUYrBwJBqlsExO94z8NLGMiqbRs6joZfJZ+VAkE8+PTmji4l7YyOtJqWgwCTRrGSDnfDwsp4AYKoInGUDFLE3j1Cqqodqx4eHOm31NLNw3iP07M5DkyCaVqWdBNZt74XzpyibTEG2hXKqUTVDpmhC+ixvFXFwbX1QCAmbkB2zD7u2Fs3OId1qUBU1sdGGEa1isWoYsBmv/I9iUXkvJ44kv85rsLf6SE5aHRGEzKaR0Qd9zpayL+QDjDTIrL15e7pkpMLVQx/F+E8VuDLsT+cbLom2pUsaU0AOP6L/m/X4OdiUWE/aYkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wgg8XeBubbqR/fvw2umN5528mdjzZ9HKT6Q1oO0oQs=;
 b=DvY2Jm3cyRaALxDSrw/xKjN2i/g+Tt8aJybdPZlEn9LflW2oGjaU003JwOkPxvI3vttlTVTsgMtvEqwQHCHBjQG38BdASsJGMatXcFgKCL6O450GkVvZadBLgnu2oC9lYAq3F6RKU3jZyBp75W9VIIxowm1IOou24FebuT0SPGBUpJkfwCDqxycoSi1sH18YfDla1Zqaw9v1Lk3Pt+P7nauhbG+dd5L5LMU16N+f4DyeV2sG0SvxkhgY87zIjgC15LfBXiuWoKoSf4MWKRpKMKzqw+xhU8KxJGg8ZT6PTuBI6PgbiA+Pl31nVf9usmrAxQnURxVSt4CX79muSCz7qQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DSVPR12MB195923.namprd12.prod.outlook.com (2603:10b6:8:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:23:02 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:23:02 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT
Date: Fri, 16 Oct 2026 12:22:58 +0300
Message-ID: <20261016-gpiolib-cdev-direction-v2-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DSVPR12MB195923:EE_
X-MS-Office365-Filtering-Correlation-Id: b11034e1-cf02-461e-5460-08df2b6713b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|10067099003|3023799007|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Uc/Wl7y+B/wOEOHGSQ0Q30R4EK3GwKiwmqMxS+ze265/bmmrm/wvbQTb7fdqXvUF339bpoqsSoUoNP23yB79qTn1E2B/zFHIAc1XFAemnm9a9ZlkYgdRCysz9OysRB1TujYhIaWoXYE1KyDoL1bsVDItKRNe5vgOzYUys0nlMlyxS2dpu++K+rtgl1w9i98UHn82S1ZbjU1CGzqjluqZgLgElNa3Hi2AbLO7LVhztMFC7HPe6BvX9Rm02/eVKi1FCyd+Ld9QBekQBgKAOScgc6QmloNWOHV7PVFR1XA9JPqLNWCwN30VwVOmDIlUWZgDL2/kUYbakLFtFUpJWwbcQR6q9z9dYwdDSkSlMO/Odzsx2lRbBY0xXUzIrt0dMef1Mp1Rsoq+gHYzNanXysq01zb6K5bQ+i0OkdAJsF9Q/yG8uYb4IpH23UCxBzYxfRs0KnMU3mBXbAJAgdp1AkvrUMx7vLSc7ZxCNZPyiR4xwA3C/Z1eGdy6KpF6t9u5pG4v5mJHjQlb2qSEI+0YuMTVGm6eMa0qwu7ShOfamNeUVe4LqAlsNfIWMz/q8YvnKZKkKWkHX28YIFimXW7WM7kLLaa68Rlec5RyxOh8itlC4VfppX9r+IDatqgUkuJxiTpUpuBwoG/Ors7GwHXRO9T5qnH2KyuRJsIy6y1yhiZqrI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6CrDpckGhYdeaaQBu3gpfuGDWWJM39eFuJ6aaf/sXtrDlSz1HcSsJHPB47t?=
 =?us-ascii?Q?i5qNaLeN9Cv4CFqHRNuW8UDT9jWZS3u+TVtJB7ukrG2jX/wDvAkQ5o3wB4O3?=
 =?us-ascii?Q?8E10jahVsyXNOh5jMe46yzsOmW3TyIc13etEASmlRZU4C6ckopC9nJzr8mx3?=
 =?us-ascii?Q?19b377wINeqb3bO+Vvbksxya5WizEaMFwacaGciTXCOO/BlbKZUoUdFmj5Ms?=
 =?us-ascii?Q?4s1yIoiGXmHIyL2kum97xuwlGWe5VMdyj6Jskkih0Zr7Xna4CUgsMXQhKx5a?=
 =?us-ascii?Q?St9Ch5v3Cu036U9AU2OtHG/v5hfw+VE4NFGD/v7Gh/dtQ7L9g+1RTcDpV9Hs?=
 =?us-ascii?Q?gSbEG0fwvPhGbsLME0NgPIxcdnld6upyaiu0SGguiMiCdCgvFUzbXfGqtslB?=
 =?us-ascii?Q?3iTjqnXYS6qkv63NfCnTLrEyO+aKtoOzU1qa0NdHdVcZPPgVNKD+rrIJ0yO6?=
 =?us-ascii?Q?lkONMyHIErrf3B9r7qiU+/phmSzt1RtEuM0XbaRywenO5GRBr6HZuWL469qO?=
 =?us-ascii?Q?fg9kYsT/5Wi9CDzwRk1GDt6y51CPsyYfFBU6WEVAZ5OdNgvAS4JWSOsKVKRb?=
 =?us-ascii?Q?+KCr/A2kbmzCTI2aVUdIMXfiG/ZNF2YurUfunMPXAJn/jHEoIZ5OdId8aote?=
 =?us-ascii?Q?SmI66HhKEgi31IOMYYE08pV7wdpp+rRDTIsK6yVDYFWvZGlVK3PNCMgt8cGL?=
 =?us-ascii?Q?1V8YuFJSG5dHdByZsdQ6928N7tH6k6i4gC8EeYHKKsDLkDD4ripsbMTl/8uz?=
 =?us-ascii?Q?Q1bcA/NqplJtoAkqalbMk7rB5QTixXVuZk0CjaiNrzg0WgQb9sUQoaaHBNSL?=
 =?us-ascii?Q?MsTwGFcPnr5U9a5KKzeMoqmPtDOLVplhPD8cI9Zko3WwclMIHxaJqGZTnftg?=
 =?us-ascii?Q?P5b16RK/y3Jm8o+S7XLCaaKiEOyM+7fcTIObMlWHvvu9JUH5WrMPEwTpUOi5?=
 =?us-ascii?Q?ANkH52LxB5uczon5UTFffgr5kORdQ7UA5OMM3aMpIoxNcStIQRVh8ZH7zZVn?=
 =?us-ascii?Q?TdKs7LDl+9/WksAo70gg+Z9tIhNEChujuwR1zormsaZzyVwUzhUsIJ0esdMa?=
 =?us-ascii?Q?ITTcFA8SCSPONOmz/GUrU5dM/CZ3gM/gyZ4/OH2D/NFOIP9iDXRrKYGuAGVk?=
 =?us-ascii?Q?8Up3sPDbIGSXZSVG7gAdgBvE75hqTaE7Rl4jwv1cD1VO0GMkmn/gYJv1c5TD?=
 =?us-ascii?Q?vCFj1PZ2hodvoD+v/iQJp8xl0qIjQvNX3bnjpaRm/P6C29kssTzGzFTHQjcK?=
 =?us-ascii?Q?foP2V+ZiMk6y0uyh+n0A0QFniIwDM66eUHzw12EH3ecxI/r4cQxkNZ1lHfp9?=
 =?us-ascii?Q?ZfBOk2Kkrim13daamWdE6m0ipKKi+MlhndRVYTYFpu6ogHDB7nOsG065bJZL?=
 =?us-ascii?Q?UCBR0GXMvFebBlWEK3hkNaYZZHEz+fnaUlmJ0qDb8GkwY+w19pOQsviu8PhB?=
 =?us-ascii?Q?g8GJsQD7xuuwJeI2bRIAHd/9rxBIzJVAsFRzqD1pDaH0CatKHu6iBJyoqOlQ?=
 =?us-ascii?Q?/bFr7G/Xbmzakf9hKZT908M5gQmk0wBN1pH5jOHKfa3cKopOGOBhXw/k/yLy?=
 =?us-ascii?Q?XMx0rn5pkfDQsYo9saEdod2DGphjAAZwajKq6OV7ez+0nIgHIFrzmAA6/J1s?=
 =?us-ascii?Q?guv0E37FTBhpZpMvtYgIpeQ2aaZgqtax45O3ubcjyLAL0ngUtxaZagANaH/3?=
 =?us-ascii?Q?zobbt/t+5Pyu7jYxSXSsMaDH5+aOAot2EZxktyeMGCCnm+ijuq1ST6trdw/V?=
 =?us-ascii?Q?Eo5KD5OZ2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11034e1-cf02-461e-5460-08df2b6713b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:23:02.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q74Ncr0bmTFnGEKJph+zU7xvcG1UlK0qqN5BqZkoBLqmgoXbrX3apxG2fj1/AoGJCvbLK+bdYG3BF+Q2pS9qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB195923

When a line is requested or reconfigured through the v2 uAPI,
gpio_v2_line_config_flags_to_desc_flags() copies the requested
configuration into the descriptor flags, GPIOD_FLAG_IS_OUT included,
before gpiod_direction_input_nonotify() or
gpiod_direction_output_nonotify() asks the driver for the direction.
If the driver refuses, for instance with -EOPNOTSUPP from
.direction_input() for a line that can only be an output, the ioctl
fails but the flag keeps the refused direction. gpiod_free_commit()
does not touch GPIOD_FLAG_IS_OUT, so this outlives the failed request,
and GPIO_V2_GET_LINEINFO_IOCTL reports the line as an input while the
hardware still drives it, until a request without direction flags
makes gpiod_request_commit() read the direction back from the driver:

  GPIO_V2_GET_LINE_IOCTL, line 0, input:         -EOPNOTSUPP
  GPIO_V2_GET_LINEINFO_IOCTL, line 0:            input
  GPIO_V2_GET_LINE_IOCTL, line 0, no direction:  ok
  GPIO_V2_GET_LINEINFO_IOCTL, line 0:            output

GPIO_V2_LINE_SET_CONFIG_IOCTL updates the flags in the same order.
There the line stays requested, and since commit 92ac7de3175e
("gpiolib: don't allow setting values on input lines")
GPIO_V2_LINE_SET_VALUES_IOCTL on it then fails with -EPERM, though the
line is still an output. A line whose driver refuses to make it an
output is likewise reported as one.

gpiod_direction_input_nonotify() and gpiod_direction_output_nonotify()
set or clear GPIOD_FLAG_IS_OUT themselves once the driver has accepted
the direction, emulated open drain and open source included, and
nothing between the copy and those calls reads the flag. Leave it to
them, as the v1 uAPI already does.

The other flags that the helper copies stay as they are. Active low,
drive and bias are what gpiod_direction_*() applies, drive and bias
possibly before the driver refuses the direction; edges and event
clock are the character device's own. None of them is read back from
the driver, so there is no earlier state that is more accurate to go
back to. A failed request releases the line, which clears them, and a
failed reconfiguration leaves the line, like the lines before it, with
what was applied up to the failure.

Reproduced under QEMU with a test GPIO chip whose line 0 refuses input
and line 1 refuses output: both refused requests and both refused
reconfigurations leave the line info with the refused direction, and
setting the value of the reconfigured output fails with -EPERM. With
this change the line info shows the direction of the hardware in all
four cases and setting the value works. First seen on real hardware
with v6.12.

Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- Subject says what the patch does: cdev no longer sets
  GPIOD_FLAG_IS_OUT (Kent).
- Comment dropped (Kent).
- Assisted-by tag.
- Link to v1: https://lore.kernel.org/r/20261012-gpiolib-cdev-direction-v1-1-aambrozewicz@nvidia.com

 drivers/gpio/gpiolib-cdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5d53bfcdf726..f4d78113ade2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1229,11 +1229,6 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 lflags,
 	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
 		   lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
 
-	if (lflags & GPIO_V2_LINE_FLAG_OUTPUT)
-		set_bit(GPIOD_FLAG_IS_OUT, &flags);
-	else if (lflags & GPIO_V2_LINE_FLAG_INPUT)
-		clear_bit(GPIOD_FLAG_IS_OUT, &flags);
-
 	assign_bit(GPIOD_FLAG_EDGE_RISING, &flags,
 		   lflags & GPIO_V2_LINE_FLAG_EDGE_RISING);
 	assign_bit(GPIOD_FLAG_EDGE_FALLING, &flags,

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0

