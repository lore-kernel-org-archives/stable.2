Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701982;
	b=wH8zosCVU8f1FL835IG1mfpau5TzhUyDspLRiNcQS1OYYTSCM0cPj+8UmCAfLoNqFwO7
	 bPEMcZgXVt2/KmWVYIwiDiw03BW731QUyzTiO0ENKT2QIMQGSlXBkNGdiON1/G4hjNKh8
	 +T1m7pb/WenzYSdvCjLn1mhhnHGZmfnbyIAf4xRUWoASFCeFX+rZRjz3xeKDn6+HoBEYu
	 +VQEWo1/LR4y4dN4SbHW8X1/jzWvnTuS2ILq22ZBCaRLEfP3Vpuq6SaUz9V9BfTDN1KK8
	 qh1uduIQaHE2SuZHTNvuA8Nt0nYUSD2kyezlvQvytz/336sFZ6MnlYjolFk8svaohwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701982;
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
	bh=zctGioLclglSoaHvjtktcD+2+ZFTxZfT7HwHArdX4xo=;
	b=p6/TC9/E1IOSeOuxGuFPJzhjMTaXxFatgzgLa3m+BHzgJwKdN/DfTTDsU+dCbYvXQXmX
	 bV8N2Zl1kfDmWZygIkWf0PF34/8pMLhVrSpoJGwPu/sYySWju3AqXCEVo8hM8m0Bgp0QR
	 pVjJq3k8kWso4fx77bz/LURgsie3l1v2xRXKgJQBjYuAYWO40f4INqQGr11r/4tOozRJw
	 as03fYUGDjpCaiNPmkRPDlDl9mJ1VielfjIbqlKeSvI0wV6qhntD5pNuzwatXPlp6ykFJ
	 LqAEgZu/jlsmVC9ppfmeaOXmdlHJNF5jUrlnwWg5LgN7VdeXFSoN0QmSNN8G3kCoafQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="aulYagr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.59
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7F606BA68;
	Tue,  3 Nov 2026 10:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F7F606BA68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aulYagr/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+YyFb8CGeZvHllfGDKbzRiwr+1/zPzn3R20xU6kJZ82lyh02AJ8IwQZBv3RP82xzYyDOiihP8cYb5am410UDAWnuaj3T33JrIQADJ99HRr4Qjzw83UG+e2fsKM54v8COPrZHgqhMiYV6+dusXRBBSjDwOz7d2K87TK6zGbtkmhFXIDqGnIN73xxv8ykGOgKVLIjHYzwwnTJbBaBBEaJoRaWWuTxio2YLMxfzSMwV7Cpr59Ql+AUF7Hja/8/W3qW2nGnt45EDS4whxi3Syy0afe3NNz6fb4JPjptbwTs8YNGxbdkR33TQZGbQovQ474IU/Vl0LevfV7Wc2QUa/A7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zctGioLclglSoaHvjtktcD+2+ZFTxZfT7HwHArdX4xo=;
 b=hqOGStchFVtplj3MVWbXWIv23fc7UVB/puqCW0+iFZC40hy0iG25SNoperfVi4iIE6EPS/jfocSvOosGcCUi+6fcWlVWvCZFk+hQkgC1DNlZfYeLzg7LgsMQIMnOjEGhG9sRxHxzxkaPibFLhOGIf/gCQsRlbfHVShGWV7TVaftDlpZPpx274uinRudgXsyATwNMApeRV2lNc1WEk/OuWboA4sjWUXhhiFAcGI7ehlUOZR3OUXjPsxEpov3wnxaUP6GiVz2/X0+cbb3PwtfIPDyDI4GzCbutWFO1HYFbs7kN/0cbA+wLx3c5UwijLH8InGu3QrjFfixi0EcoLcGqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zctGioLclglSoaHvjtktcD+2+ZFTxZfT7HwHArdX4xo=;
 b=aulYagr/oflGAzZ6478nE5PBezbWSOKGB77S5OceLqsOTciE3z8aDJa/jzONWW5oxgh+hQWIEfH25dfXMK1+M5HlsKY4M2EEXzD4ToyPd9qso7AxSCyd3OtCQb421UoosZf5iHBCrIg2OLUHCeB78SzxX4e7ALdsTgz9m6MY+G+aDMYhmrxDWw2iB4vBg3jqnh5diQDdxgeiPJpbgJuF69H3FF4kYFcCQIuiDunJy7QEREmUlCXUm6ip+qJAFFifPEANOQyQ3zqICMTIz9H+vT1ZlqhDXxk1tSNglTRfc0aMXx7GLtmOyta5KKYyHTI8r3lN/ZCVZYa2ao2kdByjTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:32:58 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:32:58 +0000
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
Subject: [PATCH v5 5/7] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Tue,  3 Nov 2026 12:32:38 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0cbcdb-3755-41f8-5650-08df3995d42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Rq4S8Rd7rL5T+Sa0rKw1laeF1hRJV6+fUhkQ5xd7LaKEvjuvU/iVhKxTz97RgUNTI5huQmBpOnexMcFG4s4PunM/8XP1wkiQ2IvfBbNL1Jea0HoF2q0AQgVfQZscYfhMTabL7+hjEr0Sd1BpMri4+9vH4mS/aYv36Tw/V9oXgIG1uXSn9GyRi1OiDjrw++AjfiIMSEBjGSXclvIlHJg+VIRPHodjCV84jqdCF24rtWK0ajg6j6S6ImTaX9HSxFKLQ3+K34aImxQdpZXGHdRxMDXSYVWHYPWJyj5/NtbAJBxWRVNfYVX/Y5EOKLHlg48NsvDXWVbm93g7xjEV2fN/hSObsI1SFAuH2W0ZnV/kpUGD0EYoFjfKZMk2n/p9bBTlcTUwSToctKZbslPTOeLPvrBhhrMPtHbr+UaLOSouLicG/nhi5lgc9MfIMgwbncATJWD2uwZFdQgi4cuwbqrDmL/yPzi6dST73uHjYTDJu46eN7yaBrUVAwQxsZo+TTjEfrEJOkw+WlOGBNAEEwKJ4uM2060fpkfq1EnwCD3bDRKvoXo7VgWpbRj8JMZ5XHfkk0XA3y/rDwc7MkQC4APfjGhkNMM7lwxugk9W9J3QneSFn/2a5JCWkT01DNjKT7tZ5LzDa4Xn7K87QTD1CM0ASD8mVrKjXjxegsDslzYNZko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BikEw0ZkhU4QEM1ctGukpqzVnSujMJJ87Ix7IACdreNS+avtVY73MmCt9LD7?=
 =?us-ascii?Q?gWnHWX9xkslmixlxNmYzh2GlFgrdkOWAOSAHth0M/fUdhF2Sqvpi9pu/1Sda?=
 =?us-ascii?Q?eDAZghsFBAoNSmyHOoMxaaBint9ZgYn0KFoFwSzjyB1/vkj7fKEE1dU1V1pv?=
 =?us-ascii?Q?Zo3tMOxJun8pABPQSf5fK0jj90x5dlLwzd8tifSGW3/gb8YXxcMukGVVsnUv?=
 =?us-ascii?Q?+LGUblLJA2+9cmSRJskFS0KAz5ch1QsjWRpIwqujMvVysNNabppLu8t7c7FG?=
 =?us-ascii?Q?oAqebHAXOskUxc+6y3bn7PgExcPZQizbgtAFiAs1ED6s8xd8fOG/69UibWXf?=
 =?us-ascii?Q?W69Em1k/hm1+gjSZuhinHgrkZRbsRwvNqi+pvzavCFIqNOEGb/rzDyIOuWGl?=
 =?us-ascii?Q?C4y8d4SEmwRmWYL0UPy+ugEtGRWK4fbVhbmu8cy9S7/VJ8hp4kALWzCegEbU?=
 =?us-ascii?Q?ZsWKWjQWTtul17Y6FAAyklAY/3ZWmNtoWv8cO3PqzqpcRot8HfolCAgZUEz+?=
 =?us-ascii?Q?1VhHGpeKuqoE8QeLj9BfRKKCntPGMXP52i/PVAjiKv+wa/Iwtr4QDRkHh5Ih?=
 =?us-ascii?Q?Je2IAj7Fc5sj1xt9LDvErEc6/BaRrzS3gsZVhy0p4unj2yC9s9MXrm1HY4mb?=
 =?us-ascii?Q?FMcUqzdQyFVofELuv7kWFjhjeR3CS1mpFyRJXDkHSLXO+JvbbgwZwVnT9zej?=
 =?us-ascii?Q?nS3PL20qwhiCRaDkDcK9Ak6Cua5XnHdUemzARbawkwxD/H23p0hrGrFhAoH9?=
 =?us-ascii?Q?ityfbxNMdTXELPWnLpHDugiZtLBL/5uMN05JLwpXCtfT+SFxx0jjZRy30WzM?=
 =?us-ascii?Q?+dnpStnUFhrb9eGQ540XLreBVaFnMHp1odWW7KEr+KJpOCp/huz0JpVYaKW9?=
 =?us-ascii?Q?yOdEpNtgTHnXzVSeduXClQhhx5/S1z8+Icof4hO+y5n53WsJ7bn+EgRlWU0F?=
 =?us-ascii?Q?17QT7cwmGwWYRnVBBSb50SIy0RiRbXh3+eTmW88ofjC7D9gEK3/97f4LRZ5v?=
 =?us-ascii?Q?kd0eXE0Lv56DY2cbRxHcXYXjrzoDGP/xDEUpQyq4x4091iU8+yvHXn5z+4xP?=
 =?us-ascii?Q?irKnfG1n2JUEGB4GEQBqQfV/d9h2Ef6jNx1S+8Yf0LWF1iohYXuMUFMu7eEy?=
 =?us-ascii?Q?keoCIZKbOwiCdzvm4nwRvaXVdt//xdgWyCnj+Tx8nNXyk8fW9QSr+14wHPJF?=
 =?us-ascii?Q?H8rrvwnzDMiZGQ+WUY3Q3LMpUJlK6MXfMpkN3nVMWTlrAnKj6Sb8DaaC1ecl?=
 =?us-ascii?Q?raGvlMhJV7PkXxn7Sy8fpCf7DLduLqZ1IerFi74NZiBgzYjFrMtjOFDfszEa?=
 =?us-ascii?Q?vTDLQjhQeyom65gM4524AjBq0HfAW52rdmJP7hnnvUwTKbtI9DQcTb6gtZyh?=
 =?us-ascii?Q?kT8JNNEg62QY3Gtd8HxJKClv5KTgW/a2B6AiYIecLqVLYabOLetTetF5jqwC?=
 =?us-ascii?Q?ZnLZ5QRl9gClUafzx2TywMddfmpENjnt8E00qj8+LuErsvwjwZNB74kKpE1+?=
 =?us-ascii?Q?dHtcXKhrq9/YjWllhgAx7/sWWbYtIOuUwCX4c75mr+tDnBRRX8i5GT7WSbYH?=
 =?us-ascii?Q?l/ywVwNpmWVdab4W6AJosjpKQGpojTMKr06dMocoZ5RpuTL98Nj7AnpzbC5q?=
 =?us-ascii?Q?Nr99oqXM9uOZhYw8cySXbsXqWrKm3sXib+yjNXEWnYW+eG5S+e43f94eczkn?=
 =?us-ascii?Q?jtiudT+dkBKybqfBH3Yh7A9GHVhX3upn/+Sc8f3hnzS53Rv1U89T755Q2D1b?=
 =?us-ascii?Q?tYHctkMW1w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0cbcdb-3755-41f8-5650-08df3995d42f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:32:58.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YojZUbryqUYg/3vOVNdrIgDs9E2jdGs0vojPNjR+F79lJDvC7PaLtHcpcBMCt4rj3l8pDE+Mto24HAbPJo9a+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

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

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 610628d0b475..3623b05fef60 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -399,6 +399,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
  * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
  * @timestamp_ns: cache for the timestamp storing it between hardirq and
@@ -422,6 +423,7 @@ struct line {
 	 */
 	struct linereq *req;
 	unsigned int irq;
+	char *irq_label;
 	/*
 	 * The flags for the active edge detector configuration.
 	 *
@@ -601,16 +603,18 @@ static inline void free_irq_label(const char *label)
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
@@ -938,6 +942,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return ret;
 			}
 			line->irq = irq;
+			line->irq_label = label;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
@@ -980,7 +985,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	free_line_irq(line->irq, line);
+	free_line_irq(line->irq, line, &line->irq_label);
 	line->irq = 0;
 
 #ifdef CONFIG_HTE
@@ -1080,6 +1085,7 @@ static int edge_detector_setup(struct line *line,
 	}
 
 	line->irq = irq;
+	line->irq_label = label;
 	return 0;
 }
 
@@ -1778,6 +1784,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1791,6 +1798,7 @@ struct lineevent_state {
 	struct gpio_desc *desc;
 	u32 eflags;
 	int irq;
+	char *irq_label;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1826,7 +1834,7 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	le->irq = 0;
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
@@ -1910,7 +1918,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2149,6 +2157,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	}
 
 	le->irq = irq;
+	le->irq_label = label;
 
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
-- 
2.43.0

