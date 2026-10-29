Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273390;
	b=FXiLOdT2Z9lFpcyKK7oRquJmgjX4qEqDngJfXiLW6YcVnlVM3aNnH2mPbIhCILSPE1bz
	 PZjEo9aAchA0LuFe1o4VYuU7J9QaSP3llhtcrJ59ZsZlJESiunhqjY126E+A0DpFOK6qc
	 Hwhz6vnLSDchGa97esSVkOV611tlPKXjn2CcPMtS2/On7Rt7p04IvY1GaChx3bG33Sq3f
	 RTL+bnn7ioibYZGCoGuHVrFNwlihE+Pl9Zp90ETKSE8KwbiYcCO+pfsrXYVwhmmf9v52q
	 aBEK6kmZjnWJO78mtKFoAYoXuFk55camIns94kXhcFEDfySSHFqgpA6n6uBro+D6IgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273390;
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
	bh=fcHgTr3BLGD3fglzqWKLT9Wxl2S5/THKys97voWDxNc=;
	b=3aRCnh2vqMRoO4/o+soj/Sd+A3NVc1jyvkv4xvJfO9P1kw/o7PVo0XTFHyAXjqVxlHNH
	 pxUDp5BYOxQNvjxpopFSxRuOkbi5+sjlTPxBJUxIXsv+KA3Nwd0yBHICnaSzgaxdAEmHj
	 GVhTfHJMeYSMkRJaMjquPLQBTl+KogOBI2GCafVqQtsYyJ/Xq2tLdRR9w2AvL/Grn4+2a
	 PqSEukKPbvhlMejWv8KwWRFQ99+xDBoNoSqySzF8qUvhNASoltwDmNUDmfAvtQ5M+k8L3
	 6Kib5x37xv35HKph/UEq7pnV/Qq8pEqA9way1ERE3mfAAdioFyTaFTqRjsvyM1uG+Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gqoBf107;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12D606A329;
	Thu, 29 Oct 2026 11:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A12D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gqoBf107
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRxk/ZyJ6SXzlFa9ERjWpuFW3gCPryoI7RsfHBJY62EwSC4VI1UiGMS/sSiE4OA0pv4QVW5Hc4/zzq+tTGIECCleVOM16jJS8AR+VcxMsRGvm93P0JaS44UWFjjJZOP9KXbBlW4+zwJ09KWtByOyHTRd0RVhlNIXT7ilojID8RfdWSH5MYHQRccFBx4MoQQpNPLzCw15Lwzfkrb3EzD6u5i1jLBghTA0jwkLInbcXjjmzA3zDxwuW0oMTJmXsq486HQcpoUoJ9C689RCtEhDEM6CKd6vx0Rlw58xdv5fRCyq1RVDAmRvy+Rx0T3P15hwRvi6lF1NBCYAtHzXqUhQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcHgTr3BLGD3fglzqWKLT9Wxl2S5/THKys97voWDxNc=;
 b=Ce9u5OVj7F9/OQVzZVU0aCNvy6mwpx9cfEbAE0iOw1WU4hyDSzCa6OVK3w60I1CZzEaXEjK2UxvTvPHrizcnX9pDOel6J3/SlXVn884Ql/2+Km5jpLYjyL8zxGSj3bARoP4oKNdivm9L2KWdAkXlyYYTlhoN30XiQQqejagwt1JjxFFJIbNgfEYLgOyAmnkkhUIaf1cd0fe+t9zy+aTFQrH8QI8k4ejuga7hV9645FgIZkZ4VyQ4WN2wxHpm3+HmFO7xpIy3XlgUV2dR0kxtInxnQR+lrhD1vTXUywA52e7kJZM8pxjdjjMviisXXb4S8FTxYB3vABaPFoSL7l9hog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcHgTr3BLGD3fglzqWKLT9Wxl2S5/THKys97voWDxNc=;
 b=gqoBf107aGGLFrpLPS6YW1hyu83+YFflRcc7t09REfiSWlX03RYPPTF9JS+rPlCfMFu4Oy3TPbDYfOhYNkzQl03jXM7h5Kz9Hy6j+wbGqlrGZJiHg0+b/Q+vmrGJFKp+DNwgPIDhPvnIyVdRMjCUzzDgUzQupLmSrnoinkUu/T7H7lHaXw3EIZOe7jQXwyb6u6YXMzGLyPiM+9rgbiTw0QEHFcnRk2CCJc67ISD2TLcO8A/rp0mHY2x+Go13wRNPmfjDH+FGJbm7vDh1TrAaeAceSlgEbATlzjrgxAsulbsGL1lSJ09HHF0mNuNKG3Oc0M76AnfIeE9oJc8uTASJKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:30 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:30 +0000
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
Subject: [PATCH v4 2/7] gpiolib: free the label of lines released after their chip was removed
Date: Thu, 29 Oct 2026 13:29:17 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 258fcb2e-298c-4b47-31fb-08df35afe5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	95zAArRYmgKfXnjHavoCm5JcLz150P2MPAn3CZPiiPznGiQfvp9m4FPk5IJf6dD8TzL5wbEecwT3v0qXGu9XLTYWXUQvdJPmv+Cbq9dGv5p7NAa51GlaltNZlHB+tFYF1XjOVRAF+dieOARTElzJnf4Kzr992vtk2PWvkO8P+eWvD6V7SqDWjVZTwoQmy7svmjaB0nCopWRPUyrQ6XOMvghcqJbLzKP7/f2An8H3FMtmitpSP+FfxRlNMgF0dcqVWrWN4wRXPzrKVJ2n0EilcFG8Dq6zp9/5g1yuqrxnv5wok1J3ewVst8ZHCZ/ZHW9wezFL8uTt1PnszKZ7bt5ZOpNS9hITb9F7T0fyzl4aAls7ZMS1mQViIv8Nybfazhcst342ciYbIRP9wlPAaZ7kEL1SIXm1yJwp1xVOJ9V55yYgcLvyVzTud2S5RfF/IK3Ormzj7wIpnXm8tkuIEDnPaXRaJUDQw6K9WfX2wAw9E4zHdAVxlNRIevFwXaCVTcgdGH2IeDfecXGl0S8fJZ+rAfsBpWdD7MYsUkZHSm3OgVG43ccUabQ34S5mttiL3rS/Us7M2MQZjwqU0zdCUDRKVmAy/WGxIpojzTzQts2ukt1pD34tD8GU5PcCCn9QSilsCZwpyfuRJyhJ4b2auFZL6I7rBe3srlvSkRNo4/4k4PQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJt3u1DQmlD1Q/g1whSXePCvRH0f1qX8Xs49bLhy1++0Tj2F7RjxtOrX+3To?=
 =?us-ascii?Q?a6QNN3zTOR2n6cg6HlHk1nzn5g2lD8Kxw/jvVMZhyuxkIzGve8uo/xkKfLYe?=
 =?us-ascii?Q?GjdiiyeYCDRKoZAhtx9DAC366E3QwdIV8YS1qCtAfzXk2/5A/RSE1Xk10wH2?=
 =?us-ascii?Q?vmVupAtqNN1ZaxM444MUfGQvM2yGOf2QTqxRPWetzJMkQdzFlhZgEXNZVW9Y?=
 =?us-ascii?Q?LgtI96V1e5RjO/9u+KssqleNxT5nxc7iHafXjcrM3ztrKmtbp6HGKVsT14t/?=
 =?us-ascii?Q?aXQOIBKRgixDgmU5YEFo8JDVUtRJnNBl7S2hhpvWsxziFgjVKQmqDw4aC7Ww?=
 =?us-ascii?Q?HeQGqRtS9a7uWlRSqG8dKYT2EdNlpjgy4wuRJWwr2cE6rVtsX1jFbIFVkiJX?=
 =?us-ascii?Q?6ZVGL38wuFGdZ4idf5hOh+mlYCS1oItvg6T7TdP0cNZLACvcqvpC8OMNAHWw?=
 =?us-ascii?Q?W9OwYgoLXfIj8mWEzBnC4GyeVnFgwdpQvemvpwSY5JVxD5/K9+zrJ6cKRllF?=
 =?us-ascii?Q?WjFUBm670G4AP9lX8lAZ6NOhayHDB88ATLxVkxx2OKHrziSO2bSKA2vaBXFY?=
 =?us-ascii?Q?glsdnaTcp+2ePHu+UpH5d+WNWIrfv6TA1btOHRjk+UO53n0Ap2GeaNeQlgSm?=
 =?us-ascii?Q?P4glSX0rSd1tXgQPW9cwp3IT/Dbdw0ehpkeBcPC3Z8Yzmua43ldBa2kYn3zQ?=
 =?us-ascii?Q?lPc2bFf+j49ZLvUjlEebCbI/fy1xGUzsnLHe8MU5evBEH5QE16WCjMUI8ZoN?=
 =?us-ascii?Q?Dlnf2zL7seapZSx4g9qku0hgBHXtY0Wh650XiJiLLfmyVORETSf7jSa2K1D3?=
 =?us-ascii?Q?t6+lurMWNhbWHoPhAuiyXMexFpF+islQPXKAWOaeGHyUseW8HdIXQwc7kAfi?=
 =?us-ascii?Q?CfWNDjLnzyamEwDiNjIG1s6mud6G9TuwcAjwh6VfZ6Idhhjn+hp25gUVCQYH?=
 =?us-ascii?Q?bWptpw68g0/5WxNV6AjrspwS7SF0AdokwODwiCcl4d7+nDOOG4GwpecnhW+I?=
 =?us-ascii?Q?PJNxngGf+AFqYN9lR1KTs2yIPz68+vUS85gXHUb0kwLbjuuYglDhw0MXkSo9?=
 =?us-ascii?Q?JHb3nMRJCEZjBtynEzKLkUCkfDwcUBZhc9zTQR6fqeKezI3jSrBzz43VEtma?=
 =?us-ascii?Q?1Q8C4q98IFhjFBq64eG5bSbxsa4OJmTF3xKPBz65PWgMylPiaiFlsW82ryjZ?=
 =?us-ascii?Q?oE3/PgQBcifn+whaK/uc0DRDA7yBhFHeKHdQ9hZehzc3W7XAL+lTbLO+B21S?=
 =?us-ascii?Q?+1yiIfKmmI3VjOcrkDcCPRV/N/ffR8hNzjBJnPsvCxXH7wj+MDQdBCFTp7w9?=
 =?us-ascii?Q?kL3dW0EpbKo90aXdIsivutmWQi5GpH0eCxOq//ib/1PN6MFCs4Xb2bs+kHZS?=
 =?us-ascii?Q?7is9YIx5s1/8V9yDPEfARube6MnetSbM6byX9ZAtXSjYsBCZF0087XlxXFDt?=
 =?us-ascii?Q?mw/DA7Rg3FkOWWTpMgEjlOyZc+5VFs/qFewTNThmZ63oTxVRG89qmNBus0sw?=
 =?us-ascii?Q?xLkEi7zIYihYoJH3IpAUdEoVrhmIN6S7kByFcNQXzapasjNqKMGvREagFtnX?=
 =?us-ascii?Q?5vHxqOU/N/i6tcpymNJlZfUiUu2K7337536HFhdJ921xK6ijtOVhLDhO0qa4?=
 =?us-ascii?Q?0xoEivXZj2gl2GvqrccI3HgopJ+sJg18xTbHQ3tdb0RRYCdb+aaKGoc/I6Go?=
 =?us-ascii?Q?Gl+BHgdnxQK9cc4s91gVw/p5oly+YqKaLyrLFucgUz04YE6uCE14CHU68/sb?=
 =?us-ascii?Q?45YoxXreAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258fcb2e-298c-4b47-31fb-08df35afe5ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:30.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiEsZ+iPH3/z+SS0NhxOpx9sClYziRhwsq5ws0/bw8wTa9GQ9QB6y82vguvO9Lv3jwJotf0Gd5Kgvz9evLk/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

gpiod_free_commit() drops the consumer label only while the chip is
still there. A line that user space keeps requested across
gpiochip_remove() is released when gdev->chip is already NULL, and its
label leaks:

  unreferenced object (size 32):
    comm "gpio-hold"
    backtrace (crc 7ff222d9):
      desc_set_label
      gpiod_request_commit
      gpiod_request
      linereq_create
      gpio_ioctl

Clear the label before the chip check. The ->free() callback, the flags
update and the line state notification need the chip and stay under it.

Reproduced with gpio-sim: request a line, set the chip's "live"
attribute to 0, then close the request. kmemleak reports up to 30 such
objects after 30 cycles; with this change, none after 100.

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index faf4a8507dd6..49b2823dab0c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2669,7 +2669,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
 	flags = READ_ONCE(desc->flags);
 
-	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
+	if (guard.gc && !test_bit(GPIOD_FLAG_REQUESTED, &flags))
+		return;
+
+	desc_set_label(desc, NULL);
+
+	if (guard.gc) {
 		if (guard.gc->free)
 			guard.gc->free(guard.gc, gpiod_hwgpio(desc));
 
@@ -2688,7 +2693,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		WRITE_ONCE(desc->flags, flags);
 #ifdef CONFIG_GPIO_CDEV
 		WRITE_ONCE(desc->debounce_period_us, 0);
-- 
2.43.0

