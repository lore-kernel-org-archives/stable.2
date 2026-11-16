Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836929;
	b=voz6Q4y8eNkpu/Q2pGbhC3TI/IL12QLOzlsBhM/9LCynDcjYPtK64jDDPQmDeB2xmRVc
	 4mCxW0U1lXPA+Cpp8PhmXwqVVt6sV/EZx7d+tfCqR3YmBwp0evBLtuxlP8iia4XyMsKoF
	 8D8Ej33/OTETZce7mBQ9GD4ksF1NRT20pxPRA8bi0KFH5UG+OxO3ClPNhaOFtXHDNGoKD
	 Lu46cNivOmIVJc66i/6uZfDDq5MKiZpaLhbCMpHSgvE4aJAKX+akbsqo0GjO0X1/ZkOev
	 qg1EWWQN3NlcIMMsxWjJFb8jKjZesIane2fy6aCnEwp27H0ENawNPoP3ngAH2YIwO9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836929;
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
	bh=jEt032FbTIYREEFl5iiGPu8ObQ1zwXP9Mia4PHUb4bI=;
	b=p+OodnilWahtrW4z+KANLZtlawFAWbmkq8FATSD4mlAFujqaGbzJ02TQ5w+P03HB9b7X
	 VySK182vY0h/muhjk1G/iplRtUInkngqZiXseZuxZNmox+zK+TThYdqJhjAJyhTyjfwuU
	 KAAy97drhJWRt6kHT7JzS21OMHAIRpWCARyI7nDdXEBc6QloDxw4kZu6rASZfJCGvtp3h
	 woMvZKAvXcZRA5EQagSiSK3Q6dj8Xba/IgodBhzPB/qb7p3L3Tf4/QBFHqx6tS1ZzW8ZN
	 FTwCLmzUusqOIGteFDCZof3UPCJ2cvCP6rQVhfVPm5b32ZEIOjrrxh52KJ0wV4dfs/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cN01jiFz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354F606A898;
	Mon, 16 Nov 2026 13:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1354F606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cN01jiFz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5NI+bu05E2kXDoUWUjuYuM5qkVuuEkXQycmj1VqKtaW/5+UNwoXBwKbfKzeEMXOOB84rcisFn9AlSVRtmkRn7w8OTriAKKlcuWSDvI4hgKDctswuXgKmwxIGEoHjN3GxPgToR3oGvKRxgW+BO/gYnokmGbErFgVV0lpzUb0rZFDcjoqQ6qlxrq1rUZ/sfHMPuBfv+PsV0VzKx8tAYywqRQuZKoA3bOPeSoJVreZvl82qx0xLggXnm5cmiX0xUu1HK9aNmCOiZ0UgUD7in3LuJlq7c3OMGJBAHO5fydUmqCFmRseaWJZnzCpDWqvu3MAmfF4TKNSKaJijETZgAGWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEt032FbTIYREEFl5iiGPu8ObQ1zwXP9Mia4PHUb4bI=;
 b=GxLhryb5VOmi1jr2LaJgE7/0tq4ULDd/21VlR9WcLTAXeYafjMfZSzorknxRbKl8AFeJSVE5deN5IqNx8cUT6IMXZ/35yrW1gUMhXqU+8kPZBSkPQgxFJimMAWt/WEFtNRWr+em5GeRNt+H+U/KmeWIVo4itwthz5w6JcPMcsfflSBg1YAaqSHwfUrarNKs4BVyVw+TWEkWuPDCvK3ukwAo28t5gBw1XNoD1X+MMuaoCZVQx1pADRvvpaBs8TkpKNkW3ZKqEC6o3S88eWfhRhU3xBIYKONojLqzKaTmXiuZc+TxxHuDOYCFu4rQAkgfmh70aKtJgxwClVigxpnouQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEt032FbTIYREEFl5iiGPu8ObQ1zwXP9Mia4PHUb4bI=;
 b=cN01jiFzhoLpbZKuF4ddbH0i1ug8GTl3fvsrMEUs9/NLjoMYRHME/cM8aeLwncGJafty1IMVPr369hCyrrts/msh6UvdT8FajiFwWjJTYgoujK2F6cBh0YVFcu/6Js2QVQrIiqtHNBcR9NnbJQLp7aKOkxdrw/VmtDOseB2YUEXsyXMFxgEXHrqSzQNXw3/E49prOAsSonen0cFCGY2iPADku2HcjaSzgju3rX9OGd8rQN4NU5+u96KpVkbOLP6TZl7PJN0xNEFuu7mddJEeGT4JJVT0Tp6UJg80Pr33Jlv9e8vAUBAuySXiQsqBU70kefuffBhZpQz3/QTUoP0vZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:34 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:31 +0000
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
Subject: [PATCH v6 5/8] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Mon, 16 Nov 2026 15:47:08 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: e6930d88-ae94-435e-a724-08df43e82916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|11063799006|261026121527099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|18002099003|6133799003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	W+IVayg7mrEHNK8ZELN08Ph74bn96zOxWAYWTyjVqN2gnxXpZM6DlI6lmMtWCGlG8rIU9wYX5tAjKIg2rPxVpm5m2D4Wx3g9KM7uBDzJ6wcM1hVpZWz0TcEI/d+sNmZ1tOMiKaR6azCXIdTd9m/RCsD83M25q8lox7L4q32/Zz6pY8ZWqJ1Xsjv4tbL33vD9ZQqMxfSMOa6/lljFNc5MHuyfWm22oQnw+5JCUjO+cIoWbht5fhI2h05WpWLYHrDgVm2MBA/haKw8DqpSj1nFMuTs5nVr89+Pcgy+soYul835swKtZLMR8gftOt9/pGeoZXkBoTLXDhdnmF2lZxOVqtdGtryQpRaIa8OuztPBWcbWvlDaYqnUe+HSQUMKPf0WuVzgHU4U9rewisbaJijExblIQ1YjOSK1s4EqKvRVcx4VkpC/OvIaQEy//yVbS3VvhZJ3HYYsj8qcF6tBbCTtWXFImLFPjxW8wesPTszzGlF8q8sTmmiLB67wDG6+iI9OGxYPxbD0MPM0u1ChqXbllVJJvaMmk4wOVRz/fMLSbNyD2fBEf7G8xBK1R7NlYXWNVxyW3ket1CIliuuGy8/hbgyF00lb/gZqD6O/GZ3fM6WncnAUFtQFF6nOGuPoQk+6bFlgokiZpM/H0VExTLz1a2nXQQf011U/g2SVEMrupGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(11063799006)(261026121527099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79dDC6rzpBSa7zfEB1aDlbix3MvfLAvprT2jZXw8dBC0sGpSvplDB1Ia6+lu?=
 =?us-ascii?Q?f7wVc3wHAQ+gwLI/bK8VRx6FSkjmOmOy6uid68GnU4fkxh8AvGiAtAdQcjfj?=
 =?us-ascii?Q?ymC053Rs1AT9iJS8KkFjAv5IajzYhIxUmmXlnbwQxrYYRn4yvt18vd91Oni/?=
 =?us-ascii?Q?gmDkq1ymGbMci8wFlIQmlW2SpTBFL0K+WlY3uXHAZdOL2U/SsDr8pj/p+cZJ?=
 =?us-ascii?Q?xh6tQDbUIj3sFNvRnjomQRzcn/94rqgybZPdYEEaFGHCIiD/dPKk1bP+pknZ?=
 =?us-ascii?Q?ziPkHtEHfo89rAzvsvMjuDVKnj4+P/AQGp2GqmxOvDLK/Yg5PmWZyONPBrC7?=
 =?us-ascii?Q?OOsGl4lh+Myb7RceT7Fesh0m3pu9HNudcj5ueZtAqoMyTExUXC4Cc68ZXSwa?=
 =?us-ascii?Q?ogbFCZ5w4PT8T3+pFrCXKqbPYrW2POaLMxI496SgIfifObFASMrLNWMIrUWR?=
 =?us-ascii?Q?I941v5PyVXBWt+LjnTcjWYTFBvPB9kcWtOpxEjXOYYZ8NWwafrpX0FUTdz7x?=
 =?us-ascii?Q?zfNnqUnQd7tLTL+atY704ynnwVWQQvFng7Uo92OqFVxTd7JLPK/ntJfcI/t8?=
 =?us-ascii?Q?4sj1RUIHp1snu5Q5LgtGVz4xsBOXsSgTR+mgww2bHSRPlDTnQkjl+0oovx7q?=
 =?us-ascii?Q?/iW4N8E/zOZiEu5TXqAnbdiLBKRbCaboGRdtuS3aJHNmRbqf2BfQ1EwS3KiD?=
 =?us-ascii?Q?ZLBSZspr29o5dxgPinPRZP+9171b5UE61fgnWieHMqvjP5hp93E3CXzUNyEX?=
 =?us-ascii?Q?RdO1hXSmeQVd0EEEe2eKvM1DSYYhVuj3oy+KzdaI/fhRukETGMRibe2RBIDj?=
 =?us-ascii?Q?2FFTsj0saWvh2lqg3CanRHq7xL9Jb6T2o1kc4knwgzMVJv5jyuDha2Q8um49?=
 =?us-ascii?Q?kIuP1bdKQ8pe2dFbjXqKrkBAqO7Au+SNO9Kvd6l7MQw5VCYcgPJv4V5r6aMq?=
 =?us-ascii?Q?4wktjRZrbL5gToc/MZT97N/jD9S7f0IQ02jjf2487XXZIT2OW4Pq7F1DymxG?=
 =?us-ascii?Q?9WwKMe1BVOY0nq6s2NnPbiq980n8+Srr7dnWjLjarm0FaRdaRLkHQvX2cJAm?=
 =?us-ascii?Q?EqK0MdXNXmZ8m60/hkiDGY2ccl/HRStqvPV8n/My7qwDKBCgdG2+C8i8wB+I?=
 =?us-ascii?Q?TQy+M04XxGUKhfqVTLfLwaQOmzQcEXgPpNguxc7n8c969Q9flLZLMj2ABnUB?=
 =?us-ascii?Q?0SpeFqi9o/Xd/uv/DTvVcKsFIjE3KZmqqwZGteUOvfgy9Y10uesknkNkITW1?=
 =?us-ascii?Q?XuUF3XVDzWg1+CKltNbGaMjV2DYc4itdhyjkrjYpkIBgB8P2XNbC2e7Od7b+?=
 =?us-ascii?Q?qrie9uHX/T/obzg3X4ku3MI6MteM8f0VbJvlWY0WnBrKHU7QNtgEuLlSXsBU?=
 =?us-ascii?Q?ZsgnrR9izmpqxXoRA73Hmx6Zzv3Ujj8BGb6MLdqgElEQQ1WZ3U26lCtZ7Wma?=
 =?us-ascii?Q?au/CMN35QZhsTnDFeXktsgYnq/oFCpbkIG+1VygMAjq7uSOyScjDnpuZ7iZL?=
 =?us-ascii?Q?Sw3A2kLIo9LAMVVWXF2tkjOtjGBzYrJ55TtvH+BmTLwhBSToAZPxM5V5FiyC?=
 =?us-ascii?Q?/fRkC/N2A1qhVlVCxPTZxo7dW5IWtd3tCrOkqbt9V8Ifa2UWAV65jzSYxuyP?=
 =?us-ascii?Q?fknry9GcGSShKF84VDsgE9wjqwzLdGEwOtPmFHmXIUtCvLSUoU2/3CJxT0Lc?=
 =?us-ascii?Q?QSl0ES5uAETPjen85jKo94+fhnKr2ustaPP6wgXhiFoyUR2bZLlKdO9Kh+4j?=
 =?us-ascii?Q?tjHNZfF+Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6930d88-ae94-435e-a724-08df43e82916
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:31.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zBbBe2/EoivNDsKd8o2aT6GHRqafZCtUBmdiWYEW+xh6W9vbulyxno7PdWKmqn3ZhsO0pEmEojGpXyblgcjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 9c7b820248ab..3f378748f508 100644
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

