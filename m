Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512064;
	b=aMVf6yChaiTBCS2sM9a/qdbckIrCP47EdD9CskLdsknF5qsMQ+wrGbvkflJQO/8xd81i
	 CA53Imhe+j3QwjrCP02fOeZYSjfs+b9+MrwuRt3AHNaqSO9/HXmTGCdWEYVL37Qj0zyfg
	 /rV1CjHSKWWvYyqGzDecUzB0Cn0RWcdPhQECrIANDXYYj11mLwm8HKgNhQxBVknF9yuTx
	 5VJBONzqSOQ9kCoY3eqUl/490ucFK3ISsVWIj1uStnEBp1w4IeemFZyOl27s2SuQQtZkG
	 VZlQj4t46XwpeZH7atiQVrTDJtzDXagOX4z7FUUDcfsATADLIEH1wMyWil4t/y57piA==
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
	bh=qNGvv98/wgSjodfZ6qkYMnq+CeMdog++vp0bvHhosOM=;
	b=o9Oo9UuTmKkFjLymavqnHGHutBPplJ2J3li4m28q5a4Ay0vAjtN+59JVU8CzmG8vgSPe
	 rjdOdqOcPHEGxVbo5G3slrFt879Tnq9W79g4zDk8hzX9wbqS0Fykx9q27IVrY6+Un6Dj1
	 co/sdnFAF+EpRhXVdu9HaUExPGxSRvCq+/8trS4xPI/Iy8/wfE1JLyuD04lDscB8r5E61
	 HAH36tAsPY/rc2pMy3cOCMNTDKSmZFeop9sCzKF/NzKqUgV9DD86vsEmxGjYU5XItch2B
	 XQNaYf6d0tjbHIxWXGsj8vvftLHBbbEMwiHGFTS2GNWPocG37b7klLJOVDh14197HJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FeZPH6q8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.68
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC3606A331;
	Tue, 24 Nov 2026 09:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DC3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FeZPH6q8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzvDk3clNmJ6uoALSezbXO2lW3rAzf+AnEfVwADbdF/JArcLBdfM+wAG610pMElxt0Fjd4LGkriSJ0pIxjLPuEMAyV3VSxypVPVVfy7qCCyh+yfp54GH02wjbsLDXit3R8+JQ9msKhj4QneObh0UmshpC+v+5ysMnZBHgBOb7V4J2EAvZc5YA0hwikF23UzGoL1OQvq2qi8qoDfQ+DY2HpjlKYgRTMHzMLSOMyh0GpluUb9KznGC7PoqBgFN2vaAhTK5XlPGYnC3t/OFEE0RLF9u0fFEpi37tVGCZbS7lr9q50bk2McvTSKSenYRX5zg1143Ab3bbogWqEcdBqnb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNGvv98/wgSjodfZ6qkYMnq+CeMdog++vp0bvHhosOM=;
 b=BIJs2Rm1MqmA9dGi1ma4GorCP9ruLxxy+5efx333mBELw6BaC/x+nwKr/CapIqdr2naKG3aL4PLjlrYkwDdnC60B3dOL7yT5MOVLNtC9E1WRYLYA362WlIxjx/xgRHzp8+h6Wzkvb8jC7wj7Qy7whG4I5z/TJdoVW3BX2xrUWlvi37RyI22m3RSU8JMTBJOFo17WyaQjAbPEK6VgEt7ULhRVlz24Kb19XqHoXZH75MoUBHZrCQrY6ChZYtGGvP8FRh1Pf7H0yXo40TPnAp4rIrhN7Ma4so94xwk2cIwgmkQ6ch+m2En2lFhwUAY6Z8QPDxwKVNaDNX0LaFqROni0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNGvv98/wgSjodfZ6qkYMnq+CeMdog++vp0bvHhosOM=;
 b=FeZPH6q8NseUSKJxSFJofcLscy14zeyYhtn3hD77MJAp3maGm3meavqDKhyaYAr74HP1VBNxB3tCWFtS0Dz2vSAx8dGzHbIMdTlQR2dSvDfXjv+gS0i1dbYrEHgjBckl4DEaL+JWlxlDw9J6OrNUHdQmWfeHBh0IPaHqsRqOPHTrtkvJYGCSuII5MehzIGP/xNGVJY2C+MGc4XcqtwoboVQFupHbfnebepptz6IopbxRafpCqotPZQgA+SMTobJNUtRVnevw0IgUBsUDVoz/szW4+gfY/MGd/96K9CHoEDgR2ptYw2YGOcSmoIU7g2Su6PHxbUgQ1pQzjkad8ZNqiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 09:20:51 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:20:51 +0000
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
Subject: [PATCH v8 3/8] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Tue, 24 Nov 2026 11:20:34 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f245004-2bbb-459a-ff18-08df4a0c3b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|261022075727099003|261021123027099003|261102123227099003|11063799006|261026121527099003|5023799004|261026140227099003|261021121427099003|261028144727099003|56012099006|261022105027099003|10067099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bk+m8Kf18384K5xnti3hJC0zsMvBRWvgVmDDYHcE49o95xF8PGGA/CMuFLCT/rYkmB1m9qPdyhvuVf2LfRbkv0Icn5Z7qMJscfBbVKWZ69ajfZfS8jgP/ttWv2OGoHRaZ2si/4m9YR0ll7I4g6CE649uYh52tSql+Z6bncr5hpVO0EaaoNi8FHc7xlItKNpjbcYmMoZNWNO3pSdUZFdGVE7g4smwbxLItC4CAsYWRuf9KIusEBy3OaoSkAlfbDTKfuAm9te14BVb1YkckSz4iNI8l4mKdFUuxCQPQIxXZ348J1MSpGVtoKuKz5u541qkemOWUUj4//4W9DIcuffBZ81mm0V02sLNJwSINHFlC+0a5G6PTYk8mA0oK0mZzQZlCLycECyrL4eG/+dgB8BVZd9YRQepXjESVJH8ptl8hx0HwcRNTbBhzqoAVa6fxHDEYv8PnYxfgmr8Ev3Ur2D5HigMK80PadaLkcg4h5tZSF0jyHmnOniTUDEqrVc1fY5K7ip6WQVVryLnaO+lohnNK3ik+jGCfAu6IX+9MvdFb6u/112WL3wa7joCbHu09bPURcYuOmZEgSiJPavqtRTovKSZMQ40tcVDdTQOfYceDfhAEAVF1mbD5JDZa10+G1taX/vTGK1jE/w0fHeOr4SU4AXyoJArt4zBSZn4XAFs60M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(261022075727099003)(261021123027099003)(261102123227099003)(11063799006)(261026121527099003)(5023799004)(261026140227099003)(261021121427099003)(261028144727099003)(56012099006)(261022105027099003)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/omzZO9LjyZx4BaAppZ1Yq9G50lNJkFr6g4iGTPv59PvSQgwGPsGN/NSUT/e?=
 =?us-ascii?Q?UwB8haEAKXJ+yKx7A69infsRpGDUwB2CB+UE7guib0kYary9obpFyaWa1zlZ?=
 =?us-ascii?Q?KksBTG59KAV4jMvhV7QzgKYrY9qe/CG9JI/h3XTgEvScXwMqEknG3AL265Sj?=
 =?us-ascii?Q?LIxDyvDBjsa/iBtXDFFPfMjH1ZRi481p2nU+9Zqlr7Qnok8i6fKwYjpDnVoZ?=
 =?us-ascii?Q?1M1ZPPyBwE7VdbMFLtiA6utLlMKSBLih8fkoTSSWUJt+Bb3DXhIwJipEnJFt?=
 =?us-ascii?Q?q/Pb7LNMJaA0SqefcWmqva/GETAAGcJbIxFMqM7l23hQSeJot85xU1R2Ny1Q?=
 =?us-ascii?Q?l58uhpyY7ENiQ8X2qOkXfUUq4KI2c3WmflZs0r7u4a72guhMMcMcabVhRIQt?=
 =?us-ascii?Q?Yyhr0lZvQzX8+z40mxOcqpbhKVLdCReTgeEdVjH3k6pm9rxJCv7OvtaRsqkP?=
 =?us-ascii?Q?mLcQg6UqalFxLWKNOE4Hl00r3J5yMDTv1o9eXlkTZny4ozgwS2+GoDli/NfJ?=
 =?us-ascii?Q?Fey304BT+VNx/5/Rg11uxda6S3Q/huCqe5uOInOuNY9kUMmviODL8ldQwla3?=
 =?us-ascii?Q?PYCRcpFkPgqTcrJKvFkHaaVBMfhREI41henVrR4JUm+NHjPsk1CvPB15NDI3?=
 =?us-ascii?Q?VytTCYbF+H6hVTDrfz+NzNzJNt1XCWuw7urYuOQZeP8PPZM/boE+1mdxVgSN?=
 =?us-ascii?Q?JxkhRTI/tQ7PzJkxLK5LjM4kveWWIFFYJK+0VPIBQpd4UMLrYYENF/rmwbYq?=
 =?us-ascii?Q?by+ec752wmWcH8qc9E6A9GiJshvLEBAt0VYZBqOwJVHTNqdd80j9ERPFqj2R?=
 =?us-ascii?Q?Rf1Vdv0J9abho8Vkq0yXsWcf5Uz9lwacm5lNA+PiD9JbG/qpBXR8bpjQALve?=
 =?us-ascii?Q?glgKs+kA8sU7exjARe5TgF+wYjwrFpSZke9ami/oBTDshwsIaObgFEuPqAae?=
 =?us-ascii?Q?Xgcs/EmDLs/nsmisPfH+gTvuqRaN0eYkAZ38cBMK94iqhPrlvQq/x3rHzwum?=
 =?us-ascii?Q?Z4Rm+Nko5mMPOh3UpI/oefq8WnQQLro9D3r8+rgtXRUlJ4/DdoEeLWEVRx5D?=
 =?us-ascii?Q?syYgmgRE3N8qX5teJZXolrX0ArSZR06iZXQFPc8U2cWkovoa+ZtqjQOS8qbX?=
 =?us-ascii?Q?cZa7maIVCl4fWh/mXXjWbg2pdQAglLzM7VwDAzO8J5XPJ8fiwARC7MwBz4af?=
 =?us-ascii?Q?2jphdDD2soon6jLG45cLgI9INNYBn5T2D8tuzfkM7CRmkmdlZuJIqfxFWA7L?=
 =?us-ascii?Q?K/urb1ToRLU0IVtpgxcXpc0AKU0h7JhgM+XhWJ5wODufMFAWbKJs38/bIz7H?=
 =?us-ascii?Q?XQLN9bSozIR1v59uzcLxLmuEAEUygb8kfW/V7ArhaoUVQAuh5zFoGAxOsy0S?=
 =?us-ascii?Q?92Jv77AQ5Dw9MgsBS80j/lYOJ6bH6PwhTHKc7+t/P48hCsxnB29tAHAiFsE5?=
 =?us-ascii?Q?Z8zY8aWWOdjWw1XWBKWq+kjW6vQazTf8YgCAkkLkOfD6S2jFZkYv9urcK6Z+?=
 =?us-ascii?Q?D5CPIHuowu58RDKFpBdawFk8/ye0qsXXi7w7lHeu6PjtdJfRjgPKK5PFChwG?=
 =?us-ascii?Q?OiyGtlB9pvkd7pDq2NSgxkEGI3g/JTmhwdSF0/dabtQEyMtme4oEDA6uSnSO?=
 =?us-ascii?Q?iFwXf/15YjTl1HNFgAWcZsQVq5l9h+mWg6a08uCxe0mZxuNQiGQ3RzVAvWPl?=
 =?us-ascii?Q?zFSu/6ZxzfBfxlo6VUqadNO1Ya67utvgUCkIG1AuJAj3JegrWr5ex3NDxSeg?=
 =?us-ascii?Q?vlgk6D9uIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f245004-2bbb-459a-ff18-08df4a0c3b7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:20:51.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqhTvXIQUiVPC+Au1G7yJWD7TxYt8cmh/7RoEnXEQjamiZSfpPq2oNc09B1Y/hRdaDlQH9ziQnZi+uOhJBGqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
when the chip is being removed"), gpiochip_remove() frees the IRQs
still installed on the chip's lines. A line request or v1 line event
kept open across the removal frees its IRQ again on release. If the
mapping is gone, that can touch freed memory, as reported with
virtio-gpio; if the number was reused, free_irq() warns:

  Trying to free already-free IRQ 28
  WARNING: kernel/irq/manage.c:1881 at free_irq+0x193/0x2d0, CPU#2: gpio-hold/111
  Call Trace:
   linereq_free
   linereq_release
   __fput

Stop edge detection from the device notifier that gpiochip_remove()
calls, under config_mutex so that it does not race a reconfiguration.
Free the IRQ there only if it still has an action, as gpiochip_remove()
frees only those on lines flagged as used for IRQs. The release path
then finds nothing left to free.

Reproduced with gpio-sim: remove the chip under an open request with
edge detection, set it up again and request the same line, then close
the first request. Every cycle warns; with this change, 100 cycles pass.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Reported-by: Jia Jia <physicalmtea@gmail.com>
Closes: https://lore.kernel.org/all/20260817070429.157993-1-physicalmtea@gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index bfe442db7cd3..e6d41a8aba70 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -545,17 +545,6 @@ struct linereq {
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_EDGE_FLAGS)
 
-static int linereq_unregistered_notify(struct notifier_block *nb,
-				       unsigned long action, void *data)
-{
-	struct linereq *lr = container_of(nb, struct linereq,
-					  device_unregistered_nb);
-
-	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
-
-	return NOTIFY_OK;
-}
-
 static void linereq_put_event(struct linereq *lr,
 			      struct gpio_v2_line_event *le)
 {
@@ -610,6 +599,21 @@ static inline void free_irq_label(const char *label)
 	kfree(label);
 }
 
+/*
+ * gpiochip_remove() frees the interrupts still requested on the lines of the
+ * chip being removed, so once the chip is going away the IRQ may no longer be
+ * ours to free.
+ */
+static void free_line_irq(unsigned int irq, void *dev_id)
+{
+	const char *name = NULL;
+
+	if (irq && irq_has_action(irq))
+		name = free_irq(irq, dev_id);
+
+	free_irq_label(name);
+}
+
 #ifdef CONFIG_HTE
 
 static enum hte_return process_hw_ts_thread(void *p)
@@ -977,10 +981,8 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	if (line->irq) {
-		free_irq_label(free_irq(line->irq, line));
-		line->irq = 0;
-	}
+	free_line_irq(line->irq, line);
+	line->irq = 0;
 
 #ifdef CONFIG_HTE
 	if (READ_ONCE(line->edflags) & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
@@ -995,6 +997,25 @@ static void edge_detector_stop(struct line *line)
 	/* do not change line->level - see comment in debounced_value() */
 }
 
+static int linereq_unregistered_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct linereq *lr = container_of(nb, struct linereq, device_unregistered_nb);
+
+	/*
+	 * Stop edge detection now rather than when the request is released:
+	 * by then the IRQ numbers of the removed chip may be in use again.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (unsigned int i = 0; i < lr->num_lines; i++)
+			edge_detector_stop(&lr->lines[i]);
+	}
+
+	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
+
+	return NOTIFY_OK;
+}
+
 static int edge_detector_fifo_init(struct linereq *req)
 {
 	if (kfifo_initialized(&req->events))
@@ -1788,6 +1809,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1867,8 +1891,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	if (le->irq)
-		free_irq_label(free_irq(le->irq, le));
+	free_line_irq(le->irq, le);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-- 
2.43.0

