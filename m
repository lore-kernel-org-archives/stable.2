Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836848;
	b=QnVtYbAOE4ol0AxrKOoSqrTp8Iz4SA8p4q/dnx52VOGJBS95Bm7f0yCDc6RTuzOvDD53
	 dU967oaLGNhB3Ta1m5sD76poBIqtVLZTS1jl/ej2rWB1Lfe20j56EsILG8bKs7hjbLxg6
	 qRy4meSV6ZflcqTdfm0Q3mOQYDDGPA0Brfo4qac2tg9FDNkMLtpLEI+yGnS8I1y3MOS/2
	 RSdD3DOpNqY4/wWp8YS5RCjhWtEyOd/zPGqg/TQkfxlXBHxU4GPMqZ69A0L6KJIQVaqfq
	 4F5nnC0On73W04maq8qZ2jiVWbQb6dODY81jLiG63FqD7hjCbt5Bg9e27ar3+VuYqtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836848;
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
	bh=LLCgPbHNbN9RGh4EfG7WmDGTrnvabyPhSIChu9ZIUv0=;
	b=hHwZB/met6RunBX0M6+9MLbT366gQB7isRCk8r0GeJZOQAkZaOXYVJTqrmO1FnZpU7Kj
	 Mq8LbdXpGudzWdli/lfsOAWO0XTHUiE3CHKO2xG4JN1YX3KwZV19zbIcFrvPI6xD6W5sN
	 03+Al0oF9AtOYCIAT8n2VzAvaHN34eJJVgvX0WKwpXujCcawkCdjJgQ0gDNXqQJFZ5FWv
	 MaJNkHEbGi+0mycnIZFH0lXlufkXaIRp0sBTLYO3GYF6ZyQKgG9JxCJAmKyN1Wj3EXI1+
	 Ln4ebtcqJTQC++1B90VWbJQQ1JTPjcjJomIdwHVujzKfRnBrUrLbDnp6g4FeGemwDnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fVh0XJb2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.61
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3938606A32A;
	Mon, 16 Nov 2026 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3938606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fVh0XJb2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcyRfBzGM4KsWB5zl4/qGttD5SLZpNoRXOZ6/6yOK/XLCTdIA/jfaYOp39XRkPvKUcHgbh6bEIhnfxdWg0mHS8rXmRP395ZY7O8ClSxW7UvBXu+yCVJnys9YMwXEBicsG5L3yZIT/neyMzBxd3UubHNb4MFz3DzwTbfzuZ/yJHmMRj2yIxRPoosSeMFYCaiNyQ0xOhORSprzQVe+6HhXuMN516pRZdKP3Y6SmPAwHuNR2sPCqkF0KC9BGZTkHf4pTCMvm20kcnNYeGAvHz7WINox1Jxay/SNGMiNgKXm4RSPE9mpCtsUyuaNehvwD0zsHUW/SUl8XGo1RkqiW/tRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLCgPbHNbN9RGh4EfG7WmDGTrnvabyPhSIChu9ZIUv0=;
 b=U3SkGDbVJUuhnHrxHM816EWNK+ByjsJQ/sqltItDbY/kdRwURCnbE0YO0RMqi2lQiNMZyWV0X7xdaYfPc2C5F1qHEAXTGtK01dhhVVcMvGtkltevtotOkFfk29CbzohWCrrWWnspt5yLFJBEabcegEm8ooGdR6pGzmNvRi4LRrHX46JuFZNpC9j3Vi+DaHoePxsT85o/lpoq62btlZ+hKUMLTt/xoNBrpgz4pJNNThKOs268U7SMMO6d89LEsvW4vtRN9evy3dy+sOqSDdUw5b/KuqhNRHvKgVlNrM2Q5gXIGs0fte3Cd7iCHwcEu7ubY96TqxnUASX6cgB3pByylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLCgPbHNbN9RGh4EfG7WmDGTrnvabyPhSIChu9ZIUv0=;
 b=fVh0XJb2U6kwOqPnG6hf9fgcnS0e9agJWbo/KW/nQ4R8JSZs/fh0TLGw/O3x0ejFSnaVPfYGoHd62GxKNOuh0dOx5NhpAl6EV+cHb9TipxSKayTJdT37RraKzdcLEIWiIqGu3OCKR24KdjbWqzBzonX3AXQ0/QpMIzRYKimTtx5PtKWuAzVnNVzSLQha9rOttEeFSV/Yay773OmgQ1kvrz2ygF8lNlSxXQQkF1X4liHs7MU7baRpsTymEh9GK+4KDRbVf4goqiGtkPUThr1u4RaOy0POih6MRdNTrC67nqmYSHW6unVm2Z+w+v2oIbBh4fpLf281QXYncAPE8sMorg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:20 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:18 +0000
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
Subject: [PATCH v6 2/8] gpiolib: free the label of lines released after their chip was removed
Date: Mon, 16 Nov 2026 15:47:05 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c0f848bc-48e4-499c-f866-08df43e821b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|11063799006|261022075727099003|261021121427099003|261102123227099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gp+SWhQBpkgZQwSbUcOmrOoq/FDAsnefr8sc16gv1Lnfq9o/bSjoDyUf1rjCLK5yJUpqaAYnmoCofG7hY9HNZzozPP4aUstxf36V+J1d8D7l12a5D7kgN88HxzKfyUprG4GXdCf/uSRT8Jy7j4GYEU0nCWH7Wj+7tVLs6dEiwf1LX3L4xonkMZHHzNVqUwEaDeTngXNfJq/dlTWSP/GAD/wM4YQeRXDHCb+2/9d4UzVivy/Cs4xgA1VbRBOLrjGFcCYCOZUxhJDCTTX14mIm1faNSZBgg4MWDBWnEIdqdVfMG/wvKKGc44sTSRgFZ+Xj1fgJWxHXq5CxBOcZrjUTHrmInO0FqD3KNQhI1JaowsM0nCl2l9ojD6ZDfF2Jp83MZrMmCRGaolPGKj5j8iDjIzQwOXQbixX1dE79+rD6b1BpaHIy1QWXXSMsPoTJcCR388V7lQ5+sz4c8LuelZNopqIMUsgltLINCxJ+1LHIDG20MeKpGeRb0xnzs6onvt7cDGhBv0UKOE06qCpp2+ciMscnoWcAODq3Ar+lQ/8LJBclqwdGT9LzgY6zVGmqmWGOmdwa6xlb3Rx5RfMCdARh7vpRsTf7Ao9YkgvJIGYvCCM7uiJNoy+nbY0yuhXGN/+guwmCh1X+eNpbCF0NAGA0HX/m5l0ooObvdvbg6SClyaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(11063799006)(261022075727099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1t3ho9KBeI1AlPUaRIYb8YNg/eKHPo2lqtAHoQGvETAFtgd/jEqeQgg53o3i?=
 =?us-ascii?Q?oohMtPjZRDVXg2hOtRFzNPsnzIpa7GVsrEzoOIj2nzpEoSjpfO/N9pZZJQMQ?=
 =?us-ascii?Q?vFCH0KkxvgmgzuRmsDhuRVDPKFyW6glKRhH3pYRtc4+aPlomXirj2VdsZ9Sq?=
 =?us-ascii?Q?6wNENlkWeO/TNHLxB5wGlC3/Xh2bqb6kU8o5vcJqDurgXSJ+EfdqAeUUdxwQ?=
 =?us-ascii?Q?e1qoeOT2yxLeTllN+aoADEIbeZDxik7ZbR2BKLhFI8yQnFvCDl6SWWEjGSJX?=
 =?us-ascii?Q?WdZynZNc6nWcZo7/QxAmrCa6+ZA746EIc7YrMFRwiuk62pPe7NgwLkNgLVhk?=
 =?us-ascii?Q?Fqrut+DrxCEY/QhpwCvjaaIdsLSKTr7aqpFpm2nZt9Df9z7O9i5ghm7/I1eL?=
 =?us-ascii?Q?zacUUM2hGbbacQJgt2OlMoK+CXJPZcH7orRxoindcLIIAPfD2yYXugG/iubO?=
 =?us-ascii?Q?ADCqjhVozNP8h9PpqzQkey9MnYotOPRWv/4LU+axiw5YEkRSUsLdFfYWD7CF?=
 =?us-ascii?Q?DVbWKFkQabKXqkC2SM9WIlQWN1KVIsz/VjTrWEkUqjyApPPBLvuTt/zqC7eW?=
 =?us-ascii?Q?9Y9kf9pfIU3LSkgs/7M4bB2aVNHrvWbTGyiJSzTj2+cR9ZZlLQHdPZJu3ylc?=
 =?us-ascii?Q?m1M60b2fnTOYlkuq6k7gRz3n3bE/VTBo/lvbPgEutGTMKMjGQZB1WSBYJ27z?=
 =?us-ascii?Q?sOK0lV+XueBPnfmuIrsAbCsd9oPVQ+L+7RnDlGbVCYB6slanOCbqaeOLhRZ+?=
 =?us-ascii?Q?doYbXAP35eOKJcqlOkBRqsNFQp102CWBcpWliCadwyqt2LHLIw9fdG0JS+31?=
 =?us-ascii?Q?FvBzZcpNiD7PU4ejSwJEdseV9EucJ/8Cw1hXA/6Xxrv/qFMa5LfXo260FROY?=
 =?us-ascii?Q?s2T+oiWzY6hcncUuNfUvYE4RFmWQpCWoWOnzV0vfRTUtKHhB+S1xy+4VrQbn?=
 =?us-ascii?Q?mAGdulgQFz7M0XZKceXY0q0nj2nkHaAOF6JvxZSfVO0rbgZPHSm37jkTOZY2?=
 =?us-ascii?Q?T4VstS+XVivWIO6YBSMgoc7X+KK6a+WXwf8RhvkrLzTqzelNEshr9M+iHA45?=
 =?us-ascii?Q?LHd5Fdl1XtVO9Dm1Gja1nagi/96ODnPavEK8PS+kbq0GtQRY5S9YCsrvXZH/?=
 =?us-ascii?Q?IHtFB9CihbTR/QWS7IXcqOn5L/Lu0t0nDp9RZYzCyOYQwM0HcpiN8c1HFTBJ?=
 =?us-ascii?Q?EaohrYBg0NWAFd51812dNAIyS2TgtBTpZ9JTqgNAZBZbz2KbXdhAK/5Ib/iD?=
 =?us-ascii?Q?B/61MisPnWN3JhTVmLbsn2F3WAOnBupFshgcRcDOcVXoFgVHdYRQCKdIWuKK?=
 =?us-ascii?Q?v3e4wKX28zi2R9kX0wk3FFBDl0vINtgGkb5Kdxnzq87ghADOBC9xHwV0yws6?=
 =?us-ascii?Q?2A+pJYmJ+1IK7Ye6dzW7nQFpWKVFYpoFveeb0Md9VCXG12nfe6iAPOAAgKhs?=
 =?us-ascii?Q?s8rYeju4ALsOzP2bs1i6pd+rVk5NmXD1aXf1FVFz5/ltSfkJUeiNfNo2ZnQg?=
 =?us-ascii?Q?5SJAo4YIbpqiGuDeMFlc7BHb6FCRdGkJ5Ys2dkQTcW/SQvaad/T4UbrupDjF?=
 =?us-ascii?Q?sAdyPswnBEUBff2atLJaPhSJ31Vt+YH0FMb7C7w3Fxbk7sdNi6VcUYw+sgLS?=
 =?us-ascii?Q?D7G8Uv7aogD+lUQwayL1G58KNcbqxjzXnMngbRyTOHBMCrJju2n341kb4cIG?=
 =?us-ascii?Q?zSGyHteUH40RfDLRKVqd0MHDKCec1PdmKgVrlS7J+cPbsYvODOFm5wEVpiBR?=
 =?us-ascii?Q?xdWgQdK/8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f848bc-48e4-499c-f866-08df43e821b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:18.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zs6JH0VaFN0rMd3VFIRims+WJIk3LT5YF6gISGFczPfXdccyoDib4d0NQ/5s6cjN20E0X0FeJvsBKqu2nlsvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ce04277a8900..27037f8f2422 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2703,7 +2703,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
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
 
@@ -2713,7 +2718,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		set_mask_bits(&desc->flags,
 			      BIT(GPIOD_FLAG_ACTIVE_LOW) |
 			      BIT(GPIOD_FLAG_REQUESTED) |
-- 
2.43.0

