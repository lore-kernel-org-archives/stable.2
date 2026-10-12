Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199983A4523;
	Mon, 12 Oct 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812989; cv=fail; b=qHmdScts0LdkuTBYq9sx1V2HnI1gEV21csWAIs7VuhnAIPdGEUWV5LJnLc2RMX/R9XtEE3J2C45MrCHjnSEkkSJMh6Do/5QkR6AmmoMuhYQhFoF+ugSsDdBCf25mKkzSGB880h0od43oogctY2MatEyADZjC8o0tyLp8r1VsbG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812989; c=relaxed/simple;
	bh=ysIbGs+ZsDy5B/CLsDarKZAF9tToEaJ4yuyNVpdRsjg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P7l/xawShRKzAGH+zJuF5pCr4QldpRnzS9PbCgnASr6XyVvCsDbA5BBUnwyF0kvZ2qiXugLWgxDr7jR4Ao1B/zb3dKnDocXTWaZJc0wGcmxvDqao1XbvWBDS1gnXM6CRAjqNUZ5r6Wdnc+0PXW/a9nwgoZbCFW+rm4/Rjg57y9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JKiQQSZZ; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JKiQQSZZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X46W2yTP3Nn4wfxbyU3f2HVj42w+6pufAq10Z+VtR4BEDr1n8CuWNVoYv3J3X5KPgYFrV3/so+KP5tzOJIj6xyAnvfYBfxz6rALjyXdfo0gttq3qs0K5qm/Xgt3A3WeVrgLkB/HlY6/7U2p83BLLNrzxAKPwZqp6EgnDLwmxCwOgnT4IL84Ih1khf0Lgup9Q6rrfSh7dOzuBBFU5KkL64J1WvDi7nxTbf6LlvrS3X6x32AhmwotldRVMUuVlMBsZwjYqAenAl0lLB5o/IQBRvI9rwl+OuJ1q89x08xLs7z6TYBIt6HKijdg2oHo4QqVjBKfU0Z7lsFwR8Ly5Il47Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvGBQdwylGnL2XyLVIWYgAxlzIIoNR0C5oKeIWrfhPk=;
 b=ih0OqI61q+UD3gwlLa14cPLzpoB66icS6DEzWMkRjYPGwmEkHJgZv45EWX+6VXvq0ahdE89PF2Bn1beETc0KgGRoD74djINVDzhg4HtAVN5yJY2X00B4Ne1itt9rHfxxU2REJ8WYvuh4YLSxfISuFoEBYWARYz9HCgzYEoPcKdn3W7TRBcNiL9vx2uGWwt3PD25Z7jdgRoGAmVnwHsCDI2C/JlKdx5tk3LldmkwFyurBIsq7onkKri4qCH0ZC6j9TObk8az8LCMaFbvTovfSZqghmqpNNnnpMXc5vO5FF29zrgXRrkheKP68B/BlPDbEjOVG7ttYaUlGZbZbmKW2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvGBQdwylGnL2XyLVIWYgAxlzIIoNR0C5oKeIWrfhPk=;
 b=JKiQQSZZD1O+FnRvhMp3VsVYF6oFzVCHTfA627aj3qxNkkfhjiaXasbOPdU1MpzomU7SeiHuH4TtLd5mBgICXQK+XF8V3QK1CUXcG4XWKeMTZESAZwKnYPQAtkfP3aXYksgoMaZqghe2WZ1d6OonS5mU5+4P4UeR1HnXAUTDP90D9MqjlOaIV65hi9RI/zB4+XwMzkMs0EKo/shN7/AOPrFPJocU6B5llHV0p2tCcUOzgX6KyjYL8a4dqaCnY1ycefdJxi4AEmjVJPSfA0dZdagdMCPoXwaN7HGbkRuIMJpoLvHytxd0NH726reqd/FWCHecgjFWgBPRkq4IwK3R+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:49:45 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:49:45 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gpiolib: cdev: don't record a line direction the driver refused
Date: Mon, 12 Oct 2026 16:49:18 +0300
Message-ID: <20261012-gpiolib-cdev-direction-v1-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::7) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8f5703-d5a1-472b-55fe-08df2867ac26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|5023799004|56012099006|18002099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	xCInAlzbUH9fX2E0UBD1vdKhWmY4AUP6p8J93m4WMflu0NnjxgHUitebzTxvzYOITW6y17UXN55oONSIgbWi7OKRF/cQN7NKpHvvZMLoITo3CivMVWDP4LbwdFR/weglGNWQRpwzdsYuQmcKs+ynfwTs6n1pKSg5GsrTD8f1AsGF5/aQ8wRNHV/q8vSTM+egtzoayPz/ZAOL85BQZMnbNWyisnBrFywDBjKayRIkzcjBlDx+21dK6sRcSs/PsYy3kihSNOVZh/0BuoM5dXT7Vk/kfdMZVCmrtUtZvTVsED5yq5+YpWF8B/oN7B9jwCXQZ/L3C0o1CSTxJOBiiC4/SQUqdf0onGmrGzjZq+6Y0HPbWgQC1gPgyvmPDXa+FVoqmHYwx9WWsjtb+Uf6spnl8kYNhqSyqirq1w4gb45xlqzh6X+D8Q7oZJosALTVfOOQW+GxvSJiTYPZGr5dRqQtvfalM9yHTmiOH/nlew+Fhug4nxyo10pgh0SGKSKDyc1TT8l7tUQ5qZlvAI9Yq6Vbv3kloIvQGpHzgw9wSALQZVRSE/W9FKvTyEihmFzb5vJQ6oei2KSV7T9CjYmFyVeH5OR0+z7ULoMYOvchqg60LURm5P+kPeA0LbD6Svc1iglfH5D7J6tuoz+GZ6hdnNWyWIFRbMOsNcC6XVyshWu+iBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(18002099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIKe5itKeAXt5s/LSaOwmmrNk9JvDoqOYNfFeP31zLk55bhgbZh7vFX6mdjh?=
 =?us-ascii?Q?weHmKjGU+vlu7Kp4/MF9obxVvGKCimuim3ND5h01w39JInSO3cfBhVWM5wA6?=
 =?us-ascii?Q?GiGOliAp+8O2CkGqjPxFbEZN4Ivz5e5dbXtsuE3WYWm2dCp82897l7mo1UKP?=
 =?us-ascii?Q?SYURVy/FwbK0X3MeLY/ec3UB3UjmjygacfY+UwpFg8+JnyIMyc1lRMaEiFkI?=
 =?us-ascii?Q?06cOWtT9CSN1vfecosyefWwDyz97ebahSBB1RZ7Yd42hlVU18lUbxJ75Pzws?=
 =?us-ascii?Q?dF0GzBydqM2lClUbMoWnVc617BPCECX1flEVbHFzf9N0BzWNiPugKAh9D0DZ?=
 =?us-ascii?Q?Am7GZo7JZEJydeUBh8QkkP13UX/vLMAkidBKzpgNoToziFT8boJzvS3NlvvB?=
 =?us-ascii?Q?XUEjwILaJBiqHi1kiNqBG9GJdS03+YM1oKO1kArWaLH6cdye4Zt6Otb9cYhZ?=
 =?us-ascii?Q?G46ftmO0iH+NOFLo7j6uM8rRoNvM2nZVEO7NYnzzEI0X4NUk5gNagsEfBGSu?=
 =?us-ascii?Q?3j8PPiWUFw6v/1ZM5IEtIDob4CNWK/x/5Jl9q/fS0+UI7HY/N3SRypMcjqLl?=
 =?us-ascii?Q?0bC5PKbFfeFwx1nRerEAl07TAassXdgvbIXBWVfHbg5mINNdtaT0/8Eu8dr/?=
 =?us-ascii?Q?s6rwakx++BByJS1+PPF0vR4pQAapWPWgJEeawaQvp0BquVI8FWzJ3c7JyEl8?=
 =?us-ascii?Q?cW9UO1+17f0lJzeNkdtujda0kxsjHVoaorRAM/ctEU9WT8Gjcztu20L7xlV5?=
 =?us-ascii?Q?ilIthqE4+/KeFQ45pWUd0LK1egEmASV3yirwqtWvOgIY8OvuQ8X96gKBOfEs?=
 =?us-ascii?Q?i3ATgDnQs5I/6D8I6T38IDD+PtBi3FrnhTmTpydU7KDfVuqFONdmsMm+Q5aA?=
 =?us-ascii?Q?9+9xKZ6wQck8bRNkc8NAu2BEYnPyKG7QQCQoKSdc/V9Urg+yumnNuKlynqdd?=
 =?us-ascii?Q?MiPRq3T4E03OBNtyiouoUX7CDwBDvYCMt48POme5kNV82nelj2btur33Ki9T?=
 =?us-ascii?Q?XAAdG61t8Pxma4XvgodXN4m4+N9qA0LohZrb9wIr6uJZoMHDYjjT/KQdgzhd?=
 =?us-ascii?Q?RX8evdp3rZFsbGaOl4+BpIHSTPlJwPLyUXUHY9Kipz+tMa18A60e6NstDcNX?=
 =?us-ascii?Q?I/E7yRgM58zkfqrgmg0vgJFh/V/cEPj7y9/C3xtTMy2iE8bgjfQAr5xqhG1r?=
 =?us-ascii?Q?NYIPkCF9mxHnSowijlB4aPAILCLvM3z6Q5FZ3Rdquhd6ptH9a8792p8TP+L9?=
 =?us-ascii?Q?QLEgBbQV0I1ByoiKkm5E4peNTyHtDRVd6JJKWkDpN5uzVLyINB78NLv4rUqR?=
 =?us-ascii?Q?Q1Q7lozvDt4XLV6GvhNfyhcrjY04Sl4AO1TGEpwox0UJpyA507r4Yr9SWDcg?=
 =?us-ascii?Q?lPRYgBbzbDDy6r/54nHqruX6YO3iSx+EFFvwYlU99rZkoyVtKuXz7tQnWE8E?=
 =?us-ascii?Q?aqsYjnPCiYNJH1YGxkU7ej+40ZOcplCil3hvmLC6oPKu7HVdYLd1HFVZ3g4x?=
 =?us-ascii?Q?IdJ5I58zZ1NpojOMlqKRPYAQJYkwKLNjYcVpqQ4H+dCEpC43d4l+aKwAYs5o?=
 =?us-ascii?Q?RZiK+7OGpJcd4G0pUTiXNRYsmRPP0WcPBa5yxJ5xXRLrSCgsC1UYXzIowhcj?=
 =?us-ascii?Q?3RIF9fbjlYXOrOspvLjEl+Sw+Yua/+pw3WniCvHkEBD4BUaNI8CGdj/fFG2/?=
 =?us-ascii?Q?/BIO4krAEhdO6sMx9T0veTzuN9YKUiUfKgyHF7JU4T862+pdJyoWODmYddmM?=
 =?us-ascii?Q?w3dWS0p2ZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f5703-d5a1-472b-55fe-08df2867ac26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:49:44.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaWR/95Fdk2fd/iQotOL6sRe+uQiUPXHwUg4kavRwaOXZilec6/xAGVx3iNygnStZUQis/M1WW5g1mqseydzFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5d53bfcdf726..9bbee3a1f9c9 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1226,14 +1226,13 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 lflags,
 {
 	unsigned long flags = READ_ONCE(*flagsp);
 
+	/*
+	 * GPIOD_FLAG_IS_OUT is left to gpiod_direction_input/output(), which
+	 * only update it once the chip has accepted the direction.
+	 */
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

