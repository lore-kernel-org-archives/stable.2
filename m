Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836932;
	b=dYF6kJ2IGJKiJe8h97E/lmlKDiRnr5bKZgUys5jAswTuLj5Chid3xNo33huHkKgWWcln
	 lry7BCiozT+CsK5c4ocY2PzPAsGLkOfwMULTrefGAYVZRd2Vm/G+n6W0/PJwlGDzOpr7B
	 uUKZcmjSwp3b9QGi9KTi88ESquLORtV2fOdMKIe5I//MpopMBalNTkh8olzVfC3n/qYgE
	 kfWCdLbFM9i9h7Q/x3EAa0EKER16bYcADeKx3dbvPsZoMXgyQc08ZG18Hem7ZdARXNSix
	 2UGucXZJCyMFAxQRJvvlCTLHMaMNbTl3Dhdkty7jaBkeYqfblLDlsFy8mDr6SSv+zUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836932;
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
	bh=aHIagMEUnRyumhd9Qn8iXYgEwKGcTo2bpo1iTSLS8JY=;
	b=Akjg1HXONrDpD6HDT1VnveXKK3QqlMl8jXOexWCeOP7ZO7GbGeLuiYutmz33FDLj3g3T
	 X4dc8YMpwAJpnuqodQ3mYoXbTwoFSKB9wR6OGQYKiTQzfqTSJlqm7bWkQV/iX2it8Qcbn
	 Qz59tc4YKDQ4zN8c0r1+gy+GG/f92kLzkSWXCi6XY/ji42RJHw5G6G24jT0n81cczl1xP
	 EZuUeq/A1VDlYhYZ4AXoU3XAHe3Y4RIBC/QNtkmoQLeDC5Ji0fc+mUhijzXfxFockOgux
	 iYcVcxO9z0DBN85/7ixnZCFWxSR3lypqUAFAqQNrzAHIobhX2vKdnY8pbun05ZSK6Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ANdPysBr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2642606A896;
	Mon, 16 Nov 2026 13:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2642606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ANdPysBr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2YJVUdBUGJhNzC1Fz0TFEWBRkgrKG9DEiVkN6jEcQEgoPGmbdBvQh9zQIbeSbiYClsy5JFK2X22+LpPLVw2+sX41eKxi2AqElFAwb+4Ocrug/0nHjF/Hgq/GdjfNEI+5xW1vQRsSzOBg0F3FP49QJmhZMkzatsgjRAi9Yc4xjG/nQ+FUVDug9Trdlrw3qdTtoEnBJY4dPIpZTa1gLhFIqsgsN7KmGiERc2Gmn3GBWtA8G4aomwSytH6l2iEOXpI6A2x9wbrVKJGrnIFKrHEqYKYYIux72tgauUG/m4HbJ414iz/aah85QL1MKZXY6ILvGdoLqCC+zFBJnAv8csovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHIagMEUnRyumhd9Qn8iXYgEwKGcTo2bpo1iTSLS8JY=;
 b=FLtmmZonUVkmFCNrkca/6JsvHM6jpYox2+36w+uWlgAEl4YFIGIzS07nK3JEspBpBeh6Vxj/4OwKR/teWulgUE6db7j2hJUbK28k9MXNh/L/n1LIHGhe7f/sdhwb0bZwax31ILtr1qIDRdYibTjel+iYWw/W+L0h867HG9hdsy62MCU6exhQA/mynaIOV9EU6mAJ5rGR61Zmuf8/VW9oZ9qCTlpNE9DcV0EBtMEUsNuvQ845ee49zw1nNtqT7lUeN6VRUv0nXRKoLQ9IliGsZ0fZL+MdHNDjqBcbDZYbLgjn5Ltq4rsg6Id/iDhNpWwzMzYA+zEhhhtpecgGGHMzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHIagMEUnRyumhd9Qn8iXYgEwKGcTo2bpo1iTSLS8JY=;
 b=ANdPysBrNp+KSQhf79Qky/980ce9q4fMpiytE+3i4yOQ/XO2TeQ+WR96waR6sYQjHCx9zL9mAE+Mj7WRSVUa+NYIuIw4MbBOogbWs4F3Y3JVcqu+fMQ1+YwE6dzJs4dtuU2N7hvHGNybWiNC0Hf0YrMJRLKDrMiMS/6St5Z8tbeFnBFMoePteinHcRnIYjl7hWiTCkxu/i0YPobMMJjBk1UkuXMYcC1Lrthx8DUhJDciTBTvyGnvjgCCeDm/OhzoHR5NuX1/yhTCVgwSwM29GNz34WJ8JC/sPudwx8rqHUSXtXuPPTbMsjoC7D8esds1hkHmTQX/e791hLDy/rJ3bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:42 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:39 +0000
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
Subject: [PATCH v6 7/8] gpiolib: let the character device free its IRQs first on chip removal
Date: Mon, 16 Nov 2026 15:47:10 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 706eacb3-9854-4d85-19f4-08df43e82e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|261102130727099003|11063799006|261026121527099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|18002099003|6133799003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	INRTRLNGpMTIX7B5bkykIBOwRazvTMyuOZGX0D4KMfF9o5br4XHYMSWUbLKKwWYeIYUaQpjmnKwWTjov6J73qsmCeX5WEIFJBZI/NGC1DLM2Dpy6rtjQyxj7qpg6uhI786bBQg3OgkndiiX6tp2UE1h8zR8Ob033NzXwb6gVHaGIzU17/W6dIUIMQ4Jp9wL+GwIRrQEnYCjZlQDESrgAbx9ap6HBCErBpLvbcRf/Z+yVa4VRd5JEe3UmIKx81hU/ghTSjDkVeUnJZF16cZfAkwYhg9oAgI0KsJ7aA/BHExC+xr+nT57n0qktrmadcbi89ChnytgREohRaQyWpU11vK/61vXqNNs5Trk2x2Dcx8fkCW00FDsgt6cmZE7jgjnpzw8hu+h5D7zAezfglIuEaIJT0ULbPbK8Nb4sOMLowEpakGbFsMpjZZNlTvLoU7XQyayOoZBh5E5x4gGduoSsl5nZh96yLsS3uLh8NLtH/BMpi0p1P7dYA0kPNNGloimbRQq1dg5Nhwx2XYR3BSgw0DGp/GRTL07TrDPAAPlZEJzbda7r1sYG+D4ZhKt9IoQLDoe6XwbndIHGOKJr0b82fP7SUylMy32MWNvKlnqOO1tQPNBOgHIJjWc7hnJud1GXuDMhjVE//poo9c1baft/cCj0ehd/FgHjYHw7AYOghaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(261102130727099003)(11063799006)(261026121527099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R46qt2duHgdQdAf5XUSbFpmi4QlsVu2Y0BbjsF0BLK6b5LtCxALhNTHguWaC?=
 =?us-ascii?Q?Ytnl6mQfcBmUKajZaAImc4ErsUW56ctHsPKt13QSTsXBMFnLzahn9nzP2mvV?=
 =?us-ascii?Q?4QTZOaFwR93Y3GVo08e+wONSkM0GyxOEeBRw8vOowCH9pFqgH8Lbdr9TtwB+?=
 =?us-ascii?Q?mRbbP+uNm2Fdp0q1yD35P421m5FmmvVetiRbI9MwyH6mqr3JgzGV+Km26k9P?=
 =?us-ascii?Q?kpDgcLdD1R/uLQvA+OigcHXhqkWy/0Qi7pVPKzO5CDkjJsyAIwrDWDpIgLgj?=
 =?us-ascii?Q?5fS+BfDEiUOyEZu2lYfKytM7WDSz4TAUJwf7y2LledXwiVInQdjAiSNxi+0E?=
 =?us-ascii?Q?IszG43lfk5tOAAlqaWK/dDMT/Ntlr7D8zpE+7rMMxFHov8TjQfS+iOeQi/0K?=
 =?us-ascii?Q?QTQ4XeC5t4ovTCPC0yQRGQVUra33ajGrRE7YGVngPgBxzYpbslY+4ex6qXnc?=
 =?us-ascii?Q?pJu95b5w48P8RdMMn9tXM2On9/QzR6Dj8592VmcUw07v6dQbfNI6uYtFYbM5?=
 =?us-ascii?Q?p9XH7/zF2ai2hVxILlUz7fHE79yVcfnHN0K654CNgXGUh0YJQfT1qpFJiS2v?=
 =?us-ascii?Q?ScZ3VcFessN4ei1/cGjsUaVrniF69YUmrBq+4XE5VTCjC6cc03RIsxfxFgkJ?=
 =?us-ascii?Q?DICCbOBIbMvM8i5zM/nv9LIZ49KYqEep5sDn+4gbkCExCnthwJzHSkC+1gw7?=
 =?us-ascii?Q?XEW1AOPTpcceGQdYsWptf9Fn7tYMMxdAERw6A9PbZ4FnE+GTleXZazBgM9a4?=
 =?us-ascii?Q?WMcjRhQ4sFp7cOorj0QPLYBheTsXNTZGiudvBmFEwJneHqmE6HFuSED4Ug+2?=
 =?us-ascii?Q?VIDn8DywakmfREBmKqVdX66TONi7HGM4sa5NuwOWH1IXh0zRcNNzZ0Z2qy4E?=
 =?us-ascii?Q?aeDhtXDqdCA1KA6jlOR7kIXTyJn5oTGJb3sFnoKHFYmoCHAUFWfi5Oa0xLvS?=
 =?us-ascii?Q?2QPy8dKxsM+WhoJEh5fWzb1bKu15QDxeUSPhS1v/mrDwW87WKmTY1rtPJ/Hz?=
 =?us-ascii?Q?MyYX2FfKkN+kXeVsB9o195Q8wg/y3Ibyq0q13ZAqaaOP6lP7pfymSMZCx+YS?=
 =?us-ascii?Q?XxyHukOke4FNN1NOlLbQUyxL0u7FCgfjoeWtrgSuI5DPata2V9lQUqHzmTY7?=
 =?us-ascii?Q?W9Ci6Fxs70QiBvG+LtW2+lJgwRShN6ZfANjTbXotSsfrVU7vjpGErA+1k2kT?=
 =?us-ascii?Q?sgvqYT3lKjsoRHLslBE+TERDXuBSruUm8qbIHb/+VXoBAPNVcBzs5A/42++x?=
 =?us-ascii?Q?835JO0z0nLpsdjxSiQNv3fYtLovvxHgXNbuqai0ognFG6yspYkLs8UNMZey3?=
 =?us-ascii?Q?DNRl7Dt2jiTHbLidTeS5vIB5tiAm+aYynN3WSLI5jOIOevSZdE6k9cAzM2ww?=
 =?us-ascii?Q?gOkgTQteol73/yuqaPkH8zPRnvd8O8i21PLm+upS/h9xRPClSNnb+JZ/1ow3?=
 =?us-ascii?Q?nlCROlEpJr6deWJGCnKdCZiGI9vPPjxsRi2GjQds+RjU9kzyF+/OxW4b2cAa?=
 =?us-ascii?Q?VRgXAdRPfi4Ws4gNhxGYbbHSe3XWAdXvyIKupaIVpHpvRUrlk4cEXx5wQm1P?=
 =?us-ascii?Q?567A8AGR4vzgxileRz9V3C8BzyVR7Sxu8ApEktCGY1cTKzknJwBWxcWsPLAJ?=
 =?us-ascii?Q?NwcvWkqam04oxwyGS86dv3UVhJ16GpDIWTjUVuas3VLGgEi2b9+vZ9jxTxsa?=
 =?us-ascii?Q?+Id9bFHb+eMrtfta/wxFME7vVe9ntl3NCLRFgLmiFswSrBq6ctDk7PplLDAQ?=
 =?us-ascii?Q?WGfV/6HBUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706eacb3-9854-4d85-19f4-08df43e82e24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:39.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZqOq9zAIVUD1r9D83f+9ds0Nlv0ObrOjo3Y/lYin1ZBf4PrK0ZIjoFg4bNRtyWGs86YM6fD3R/trQOhX54gcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

gpiochip_remove() force-frees the remaining IRQs, removes the irqchip,
and only then calls the device notifier on which the character device
frees its own IRQs. The character device can then free an IRQ it no
longer owns: after its mapping was disposed of and the number reused, or
from a release that races gpiod_free_irqs() and
gpiochip_irqchip_remove(). free_irq() then warns "Trying to free
already-free IRQ" or uses a disposed descriptor.

Call the notifier once the chip pointer is cleared and the SRCU grace
period has elapsed, when no ioctl can request IRQs any more, and free
the remaining IRQs after it. Have the release paths free their IRQs
before unregistering from the notifier, under the lock its callback
takes (config_mutex, or a new mutex for v1 line events). Herve Codina
first proposed calling the notifier earlier [1].

IRQs that in-kernel users leave requested are now freed after the chip
pointer is cleared, when gpiod_*() calls on the chip fail.

Reproduced with a test-only chip on the hierarchical irqchip: both races
warn in all 30 cycles; with this change, none does.

Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/ [1]
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 35 +++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.c      | 28 +++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ffa8175b78d8..3fc0a21c1273 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1590,19 +1590,29 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
+	/*
+	 * Stop edge detection while still registered for the notification, so
+	 * that gpiochip_remove() does not get past it until the IRQs are freed.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (i = 0; i < lr->num_lines; i++) {
+			if (lr->lines[i].desc)
+				edge_detector_stop(&lr->lines[i]);
+		}
+	}
+
 	if (lr->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
 						   &lr->device_unregistered_nb);
 
 	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
+		if (lr->lines[i].desc)
 			gpiod_free(lr->lines[i].desc);
-		}
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
 	gpio_device_put(lr->gdev);
+	mutex_destroy(&lr->config_mutex);
 	kvfree(lr);
 }
 
@@ -1673,6 +1683,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1690,7 +1701,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1790,6 +1800,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1804,6 +1815,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1839,8 +1852,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1920,14 +1935,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 static void lineevent_free(struct lineevent_state *le)
 {
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
 	gpio_device_put(le->gdev);
+	mutex_destroy(&le->irq_lock);
 	kfree(le);
 }
 
@@ -2101,6 +2120,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2836,5 +2856,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 27037f8f2422..d5c62e5f1340 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -853,11 +853,22 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 
-static void gpiod_free_irqs(struct gpio_desc *desc)
+static void gpiod_free_irqs(struct gpio_chip *gc, struct gpio_desc *desc)
 {
-	int irq = gpiod_to_irq(desc);
-	struct irq_desc *irqd = irq_to_desc(irq);
+	struct irq_desc *irqd;
 	void *cookie;
+	int irq;
+
+	/* Called with gdev->chip already NULL, so gpiod_to_irq() can't be used. */
+	if (!gc->to_irq)
+		return;
+	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
+	if (irq <= 0)
+		return;
+
+	irqd = irq_to_desc(irq);
+	if (!irqd)
+		return;
 
 	for (;;) {
 		/*
@@ -889,7 +900,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
-		gpiod_free_irqs(desc);
+		gpiod_free_irqs(gc, desc);
 }
 
 static void gpiodev_release(struct device *dev)
@@ -1435,7 +1446,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
-	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1444,6 +1454,14 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* Numb the device, cancelling all outstanding operations */
 	rcu_assign_pointer(gdev->chip, NULL);
 	synchronize_srcu(&gdev->srcu);
+
+	/*
+	 * No new interrupts can be requested through the character device now.
+	 * Have it free the ones it holds before forcibly freeing the rest, and
+	 * both before the irqchip and its mappings go away.
+	 */
+	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
+	gpiochip_free_remaining_irqs(gc);
 	gpio_device_teardown_shared(gdev);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
-- 
2.43.0

