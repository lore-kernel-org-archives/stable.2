Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162467;
	b=V+8Hj57bj+iOoBWiRwK/Kr+8JI8VF4zzdOHxaPBtm6H7OEMJoNWVYj9eP/VgJHTqwLwI
	 gGuMyp7IB0Ab0Hw6Etu/TqtinusPMaAlptcgZZhiW+qfa5GWmAZo0qpfUDFGPBagv6clM
	 I0oRv9D5fGMqZ45bip0NPvh/tFzGb/wz/DDTLvrlJINnvvJ/OOtEYNdlMsVor4z+1G2/J
	 bMeKz+P1Wkw0Dy2gvJko53j4z0sIse+vD9+zOE/+wNLK3e4evAip9RuR7qEk27GvwXxFd
	 ov8oPjqfklpFhHiElhEAHIXYIJrEmP0AlLILbPHffzIMM5xX96G5yae6DHVn/j7VIcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162467;
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
	bh=PxFPG2sIF876+Ru4o7Ni4Ykc2KkAqEBz3Zd6r1UGMzk=;
	b=aHgY1mfbUsCweJ24nFyqFde3IAw9e8xaKCq4962OL/FZB1U60ShR/ByxzSoM6Poq59Sz
	 k9J1fHp0y5PC7bPa1CbgBJhCJzgnMggRy+/aBMykUQXYfVS5Z+XNGhzVjVAxB6rtjarvF
	 Vr+cbO0OT68bzEJOpeJaxIDiLBftDmDbva+04bx0g3eWnC0Ty7L2iafepPaPc1hjGf5rl
	 nu/Fp8HyYf0b6Z5yIkL+mx9yFobC8VBkGCE6ZlSQZxlb9ioRgwIRDq617s7I5QJRpvyqQ
	 F/H+kZAtUWzLajdAMztXrrEjtNNqlbVCMRl+yKRsQt9TeJrVIaymf0STU16EEc8RCTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m2sLdEkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.64
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54335606A32C;
	Fri, 20 Nov 2026 08:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54335606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m2sLdEkF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijEHJYD+MbEvclvEQ6F9bspveNf+8/G+HziGSKgS5QCKrpzrEaHoX9QWYHMnRxXsSB4i8W8EjqGcVoPRysWkZYfCX2QuegFHZrYk6kg2CT9si3FOFOgMUtG2hvrPROiKrmkdLrNalA9wVxrpLz22k2YL8ScwegamGWTWUeeKuHyajo5XwfSuW+0zc1oO/rQvdVHCc7kmh5ZAYxjDb4bBsNqKXBRjjbEpQTGCJmUgZLq7uawweQd9v9iE9WT0UZ2jQbvbmGnMFBC/TH8cr8ugzh1ZUyAJR8BSGSHLX7lE51I9enQVgfMSNSuRVN/3b7ONMUDuO5rvJHBD4E5iRT8Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxFPG2sIF876+Ru4o7Ni4Ykc2KkAqEBz3Zd6r1UGMzk=;
 b=WgUKrJmcTM21dPd2TU7VrdrV0P3UjusIjM4ECq3pqkX60BGGRMaaaXEvP4LauESF+UkJsSs9x6mk3KFW+n1/vAz0WrhTINnMZ7tQda7K8Kfcls0Fh3JFjnQX0V2JJtazZxl+gsFMJQoacIPuyCZpyQrz7zVRCZXiDAjM982AuO7xQbzaKphCaWGZ0Z9xr1a7FLZvyeFOC8laQs9waiYTB4JhumdFwx++j6sghFN61yYs313JOnNofWwzVQYBG2gSkAAYvoCRyfJR0sdr1tB3tLGXPeFLRi1r1GEj5IUQxREUd1VePWGYyijsVqoqCt6EFQEYHY9/wXcygISOjlN9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxFPG2sIF876+Ru4o7Ni4Ykc2KkAqEBz3Zd6r1UGMzk=;
 b=m2sLdEkF3EaITjrD6lQ+vFuFJ4gBTMvfBOdm+p7H/7VbIjRyzSPVqs7yf3fG0WeldGEC1xJ9QK0shHGFmlKX1rUI20hEB+BDMgjWIoZ7xpeTXcXdBRI4p5AEASkakhyNtoqKuBjXDdUwtZB25NvEyddUhzpMxznowbK/u/AcKT8LAEe8bzbEhR7O7RG8Y58BdSKy2/KgjfHmRctMMtIPeXtn22jRmAonO1P0DNr65F7IcgHZKl74Adue8v23MmnGSk7ABTpmFbXvABsSbBdnnH3OWwrRs0igEMeqCigcIHXkHI+2IVpvjidcgO8P4sazSUEIGKq36tpj4Su+zhsfrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:22 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:22 +0000
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
Subject: [PATCH v7 5/8] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Fri, 20 Nov 2026 10:13:57 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 811eb0b6-a84d-4c16-d607-08df46de4883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BqEaIc8A8GF/1EuWtslTeu9kxi0hcVNfcBR1vSOlRwpWRnKXOeqnUDbq1VjCJXnipaQdZIheorKaHCFCNV0t0rf1YTfBs+J9NWV61lgi6OvJ8dGR1k7MilmAdclMjqzvUi27yjnohbJE2M+LqkDSR1GntW6i9e/tHnlcnfMfh1U4cRvq6Em9z+uM890NlpW7IpLYDsTWIcbvta0Lou4Hb4ckneiBuvnDH1RmJuqYW/PLPiMtUFicKqWVvHPcpcgYOd+atPcnhARFcTKkzHvOmODg/rJFdP++/MX+V/WOxhhhvUvzkkn6fd+3sCjTinNnRxLygdOY+YYaz/09yDPeTMkYW4ZBBYD1Cmt/aZab5ufG0J6xIhK0jhhdjwGqttBAnRM7qpNlcJ7ZbxqiaokdQh3wlBSAmDYda3yqEy/ESQ+UAo7MqJ2VbNphpMr9zH9YNHN4iG17sctSrqtcJHug0QWjIQMyD1LHe+nJZmty3ecZbMQ5e10Yih7qX77qtpsIuuY9LEMNk70TXY1hfEUuShL0+baH4+HwNsTn0fOQLD4o006M0dcffChsASimUo+KvksZnX/LA9zHtT8/54FHUkqjRNeaWFaGZjIFHqYVxoAiqHcwTKuqoO66nIx4nREy97R2GTUwznxg5DbR6tRjBAPgzMbOlS0uP47Fa6V3q1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UXvwwmgWbPTKgq3SlTlBjSSV1mlcBBZBfI5mioXxvQ1Mj2LYZMFuUJSWvsDX?=
 =?us-ascii?Q?GZOqGtSM0TjZHP/R+ds3qQD34wZWnRSlIJPhkmi7Ab9Rlzsti71aBAvFS4Fl?=
 =?us-ascii?Q?H09QSCP2ZUdznL+M9arprVPmhScOTRoKx3XZhTZHB6YSztURjLvFTnrZVewT?=
 =?us-ascii?Q?nVuM8uIMPOoC1kWF4ZCB23a4rCqYKA3GLUKsrOO0oWDd2nEFgCggQZrhVTD0?=
 =?us-ascii?Q?euW3gJsCDibnxNv6YGAiCNie6jA0tTZ3QUfcetFKqQiiVgRsCThX4q2/yEGf?=
 =?us-ascii?Q?7A7YOPGhXMNWiI6tk++XxJdKgeG6tA7xFrmuAAKqBes3SITJ10ePr2z6Ksbp?=
 =?us-ascii?Q?7mmqsdM64Sx4grACZledWVyn04FygBTP9UZMSkTPG6FpbwDWHMasctGQ7puB?=
 =?us-ascii?Q?H8Yb31wbKv/nZ3x2LpxruiuLLHXzMzWIKe6HaQOp2m/iApDS2GXn6G47acSp?=
 =?us-ascii?Q?2RD6j2c/cfW8QJAAwd1cL5j6ol7aOXe6tctslzo0CsLtoR6Mj/jaG+4h5gSn?=
 =?us-ascii?Q?VdpwsjbVKjg+IRN+FDcpSMp/pm92xyXWxYaQPpCw6w3ZEmfrMU/1FSV1KV2j?=
 =?us-ascii?Q?PChlzCDy1wejU+pSK2+/fwvp5uaPdv7+bsR6BYWj4fHEjTGaLIez22ggmyP4?=
 =?us-ascii?Q?Ghg7I3VBRO0n2jbPGhn7MlAdDDQPJHVjhNBLC4mS+kvsnxkFpjW7kT6B8D9H?=
 =?us-ascii?Q?dsge7e1NqpCMEpQVF7ZsngohbCH+hj0wuQ6tQxVtAFD5apWYbKakP9eSepaD?=
 =?us-ascii?Q?XgOXxsYPtD/e+kfHJFSyyQKShu5Pm5QtGyTxCLyEUK0BRLgcLTFFmX66iIhB?=
 =?us-ascii?Q?1fHw+Hsfy86E2TG4T88rfFJNBIaZzklIrM3VyyQbiDrdn53/9Dy96Q4MoYbh?=
 =?us-ascii?Q?U6lnSvXpc4D9+WeKZ5VUtUL2rrRp6RbsRc/cYi9XSFD7kcCBi7pDgng6cVHa?=
 =?us-ascii?Q?BuqOEL1eA34hbZQZlHMVhzPjR00zrAliBdtGvesYXikKtWvIQBDcMetBnirm?=
 =?us-ascii?Q?XTE94GQ+H8veCORFw8Qi633RyBOgWC8phzMjJO/xtBH+hy1KisjG1LSzIdbL?=
 =?us-ascii?Q?bBuk0eYpYEPRXzcbC+BCs8KdFTWWMFL8AgpU9vgxBVAOiLTfTiquxwOc1sMs?=
 =?us-ascii?Q?uu0zQv2GlAjiXk8dUyppxNGVqO7Am+/2MnbYZf/H+yw71FfRyszGvXTd3HT3?=
 =?us-ascii?Q?jsf7apKOLq1TlA1MTytXNfMKGvYDIDRAcaQ3Ezja/c9Aw5JN06n4rslEExyY?=
 =?us-ascii?Q?YlsgWmX8ZUuQN53C6VLDmX3RHdTqPMKHRINtKmnbrAvSgPjKOntthVYjAYll?=
 =?us-ascii?Q?j+WvFS5OtZC5L8F50eRtkj/aDOTzoBki9Q0antVZpSgEfTZPD22IGK4ffuFj?=
 =?us-ascii?Q?3LOecBJV7gJKAXV9y+trWrVbUd8s20HEC7ddt8DyBjBIuDDwm6LrAd5z+rWR?=
 =?us-ascii?Q?BCK8bfgWqmpA7X5fHOyNR+PEYieZlXauIJ1ofgOHv5XQ6TrdppkYmAAPVS+B?=
 =?us-ascii?Q?8vYH8mp/24Equnk6voiZZ0KqGr4FADxzIqd/YZkvFRtBXqaKU/10V0CnbueP?=
 =?us-ascii?Q?1IdFGY46NR4YDGLAMIDPbgLgofLN+nU2X5sfd+g4vFHOUTNciXeN1dSXGHFF?=
 =?us-ascii?Q?1+nrDKHOH75YelBnKNha4AWZILFnDFfk1j/n4xrKsAX7iwNSF1/77Z7GQLuU?=
 =?us-ascii?Q?hWzG41kuspUTsKc68eqss/8F9mVzEsjh+fgRNK0ygit54VMXiESALIG6by/V?=
 =?us-ascii?Q?XMgmsc6u0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811eb0b6-a84d-4c16-d607-08df46de4883
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:22.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hjbv1Bhipex/SiV1IW8dEDKocRmcGkwDTTZK60Nm8q3JRRLB3r22rqUCkO72masg59nH3CuOvzapcuypZUkbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

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

