Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162452;
	b=V+KVGXapXOVrLjPyjYNVl2DMJokDTTpawkMuXDfFDF1wJ/YXQ8wNB/J8Q84ytuXwpwnv
	 jo+lsY63kjbH8mR4Zw9HrhNjdAvayvMmQixQKQp9sd0il3f10aW0JPxRbb/GJOIHh8zWp
	 DbXi4yGce/I7hood4fHLLxbvfl1YXs60hsF2avrBOa8j1IKpbN9ZtEX0bUGxK/xMmaYYu
	 SU/v+FaqY+HkYTNCCL32KhkB5sC+WfMEnv9eu09N7eiqc8gE4hZuBS91aP0nw/R3B84Pf
	 Yn+oUJ9bZhqFF2ALYrzv1iH/zb3Z2zX/ZtZXzgMxVk9Bop8a5OkUl4IM5M0glSpWWDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162452;
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
	bh=4vRzZFkpKkpiasAiHZYtMm4gaOcUq7NQRnMtwKNDFK0=;
	b=WgnY6pPYmihMoUG/Z9bg78V+ZJitmGTdTWw5W5trSTthcyal6TtKt/PnMmnwVLH2HqXn
	 ZK3uCFDHGy9zrHajoxeAHs6Ss3HxxC9JMBDufcvYQmBO39S5Rd1SMPMcK3iYs2uYO3Nty
	 4QUgNA0hf8RtC7T6ifpG5N3iBjj2hXWZ+ChvEhmYrh2Qd1k/bE2DA3czYt3taJEpgPyFi
	 ADGHZ4tLEaf8Fbr8QslYxuCfCLcjRCljN9uwhg6LeLCYV0sOcc2SMjbklUnKPcrQzPsXl
	 qmi39RiR/BGCAXH/wKhskZL5odIdIBvVbvVTDX6rrKt3JhurJJXT/bG59mZzBSsdBww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RUsOMY35;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.14
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D69606A33C;
	Fri, 20 Nov 2026 08:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D69606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RUsOMY35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7RnHibvA1GDckeGmb5hrf8fQelFNwH4cIIzer3s+/0PGU4nk42e/Wy3BLWevR6VkifQctx+lP7ri2ur0vRP6nGPdgO6IGJ8DmyXO/okJ+LTs+OR/fxh+XitvDpmuHSdLXveJazGvFhDmY2sC7MuT3GcEi2b9qGinxBhKm0d2CHndfkvJ5WQZw7cUVDRxjELbNMN7y7ko5voa2TRFZAMBdynU8gcs6FBMAoaobpldXc7/oqvpOadpqzTOl8I4tbKjkvJvWfEwI3IpOM8F4lKoSP1DSB5x7NbF5Qt4Rb1vH73ReJTNp71+ecw6ZD673GlS3etlaTND9lTQTdLXBgkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vRzZFkpKkpiasAiHZYtMm4gaOcUq7NQRnMtwKNDFK0=;
 b=f2pTFZoRgnvi7QWzXbfub+0mnoRKFhwrBTQQ+76LHIf9tQLEFrXeQhXiQ65vCUiJDrloB1xuoHbfDdmNV4iZTIwXiOm19uF9CQxk9uIccqJDFDjf9Ihbu3dSTkhe6Wt3Pw9i4CUPvHhlKu4qO/t4jOT792NDJQf/mDWh5dxPeGfEqYNIAQpCU3djl8zcwpdOHB74NJ4S3rc0hlKI/iKPjgMrNMp1GdQLpSxS80q+dwm0g8u2zgCdwYFL8IgCCXY58LJ+Q9glUTjFDQzSQBSL/xmkD4NIRXGFGBZCumhdfkVn5l+B0N05dPFdfvkatPbvgWOln24YvXh4PTU3Kluf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vRzZFkpKkpiasAiHZYtMm4gaOcUq7NQRnMtwKNDFK0=;
 b=RUsOMY35qXyj24/NpLPtS75C6FqLSNdDXJUGt7/NEcSJSmLz/6nwrxHI7p+rAUh7dvcws681d559QR1MJ37vWEHhYa2f2E21LboUzD20g91sPbJn4XePanLPVRsO5guzkL3TjNeOm0TVezWOpSU+27L1Zf0IN+yokQtQUlgSaZpgmdnF1+jH76ZWrYveZXMZjI+0R3be6uVXIRN7Fmi4359ZjAsMVEzxWMz5oEMh/7Ypjc5JkMOI1DO3LlOs4ocK7A/VasyvMlYmyrMfjyh6jL1tNS7vaA0NQbeBBIehOFUoWpABcG0ZbEg3k2nnbpMjXjBHNV9p0lao4WBnmMBU1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:08 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:08 +0000
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
Subject: [PATCH v7 2/8] gpiolib: free the label of lines released after their chip was removed
Date: Fri, 20 Nov 2026 10:13:54 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: c09c9724-b84f-4461-0e16-08df46de402a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|261021123027099003|261021121427099003|261102123227099003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oVJWZvHFlsAp11+F81nvuXU1qz7ozI5z9llbgL41xLt4ymbKPU+bhIXwY6eZ2OjXmyVwEmIPUlq/d9OH1BF+7Y4KcTBXXK9KcmtMy7DxEJGhaV1oi8TXUzdDijMRbmOzH/FJDaosdkIrGzstYpebgi+o8c7CxaJNPGeUCwMg00chuEj+k1ht5FTU/nimKjH1m77UIbgQ6reykRL5vpQT3NSDCHE6xcN4ChNafnBCK3xtSf9/Js5cqsI8XYHhJ8oPa7/VEgB0hbnfl+FTc7o4EXVkk4zTnq9qM7iomng20vhkX1XQ0Q366VyHZQEYCgOhRfbONi5DuQwtnqX8TuNkFAWUzyaG4i/yB1ZzeLkFRSJBjIPmBKX2NvbO5R/AAG0EUWqViZAjyfcRj47WhczkfgWd7QuAJ6G70fQThnCOm1ggkRkdg64nHHrmdQaY9mmfK/JyP1pn1Nrm+IbdmvltKZQniUEjjGNmUfGKEHOm1ZzdYdLSgGxFwVrMSdLxL16XfrnajMyvQdIZ8sARdZ4fIHM7QU+cUhHiFTG+gC1wdm2Pd8UcbqTvzhWHP/tK+4F/pp3e5AqSVKu4aEwpMoDih3nnVhxGwy/3PuBOhC7cSlXnAGJ/HLYzeyTT9eDGkFmdFImfV4SH2q9fXrJjzozlnUXIhTISLPoGBcRUWXuhSIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BjX0F/adsv8wYwfP/7nU95jTWPUjxBpCWdKzp4BE5FKfJ31YZKZWt9hlBcEW?=
 =?us-ascii?Q?d58FeUtLDS1YAKuDjZ5mRMYk3G6j/2XiSU8ldElwXAxC4WOiA/uRw/ETFiGA?=
 =?us-ascii?Q?KRZc+hRLruXlkAVOFmYMWvjoXZso0UCCdN+cc71bEeazxlNKgdfWq4jhal8e?=
 =?us-ascii?Q?bl49kVbf19u3TpI/X94gJ1fs0b08yoTmjbLZqUDOXc83FpnB0fTe5WAB6w6W?=
 =?us-ascii?Q?rK+iE/3VL6QIePF6F37wiAi5EQ7/J6wWNMn2AJnLeZS2HSwxXH2lah25LMgp?=
 =?us-ascii?Q?9m5UXGgVocQMfh7zsTGl4Z+vOICscYYPalqpoQ0xHIhh9yuqzivYqzaeTlRz?=
 =?us-ascii?Q?wpqIIOyt7HjImzajQqO1WiqUI+Ild6JrvTnS+3taP6Xf6JcWWp2RYeb1TDVM?=
 =?us-ascii?Q?QHhVnrpCJVxoje+kY/Z50pUwYsYD6DIGy6uIJntvQ7W01sm9FpjrHP9yQ08m?=
 =?us-ascii?Q?JOCoEkpR8btnKXv9YobSgTgdadDJ8W2qTHd5Iee1+JMPkUoNjLN9eiKiRbIT?=
 =?us-ascii?Q?qWtdDrHJt8H9i7wd0wypU8Gcu0WjEilDJVHTPJimBnIZylfa3q2HiB37F2jM?=
 =?us-ascii?Q?DoHi9R7YT1kPhj02PZ1cJzvk3XdoWwOQTFA6DSVHOzmUlmb47J6oMsfACmhj?=
 =?us-ascii?Q?/yBC1h02bR9kG9DNdi2MQw8nEyhLwsbqrNHkpJIr0Qocn5tIklEnaVUY1d4n?=
 =?us-ascii?Q?BkeGns8+Qmu8xX3VZha7D4SmcLmAYIXsKUCxQq8yp2UJCcEsarHAaL2dUwSz?=
 =?us-ascii?Q?a5iVq+FtpwsTUiJVYPuMXLteHxGtoWd0/IgNnW7p6B/qgOe1zJHMea5kAri2?=
 =?us-ascii?Q?dkP8Bc1k19PRNHGp3qIat5wiFTVUcA84nYROzmFAt+3nhvEPUivHBtewCYK3?=
 =?us-ascii?Q?7SssVIjFKFtqmRXxavc9B9+CN1w8xfBIQAm5WT4KYD4VTGljFGH/cdysmmSS?=
 =?us-ascii?Q?YHZiiSFyuoTkTzLpkHKSrROxX5ebCYkYdjfvxe27oJVKIwB7aJ0r89pYp+yi?=
 =?us-ascii?Q?bqNLuFZeBTMKuLkCM3deyXAy1NKnsiElqe/K7v6D+w1MNp196BwHYjSSj3QN?=
 =?us-ascii?Q?KvUauI3IHqkf7yNX5p3SAx8bdBCHuWG+5LfVRZTekBWtE3XG70rWK+kCGXzq?=
 =?us-ascii?Q?FU1qqJpT06fprLSf9R6H07DT1Y4FS34G8cMUNWRolh4jfbG/tw7pxrS/oReC?=
 =?us-ascii?Q?pJuIE/5pQDFCNCVc09fzHP5JZc9nq4U58wkgEBXWhbcD3/5XI7BdmkpGkFWB?=
 =?us-ascii?Q?AYXQ3HoUnxWkoZ8QS2sts0oqTY9l2+EfrynpNtCXeSTqQM7cmW8Y7CqP60vY?=
 =?us-ascii?Q?j9gPBE3occwu+UMtQysDEtomlCgbLUsQQCY8RT1c3wOSfdJ0llJQmvbwOB0Y?=
 =?us-ascii?Q?mZDi3lHI80S8J0ObwVYFHiEgVKN79zPU2iu13CxrcZUaSeX3GU4Zw82m0dnp?=
 =?us-ascii?Q?qEGQt5KF5pHQkzmBLmURRNzQGCiOL0FyEBG3CxTaOgsX+knzjMcm3C0SAhMk?=
 =?us-ascii?Q?MM/t6+ucZL6mzc1N4rdDQNQh0AFyj7zZeIhi/we/N1pBQnr1+d1QOrHJiDnG?=
 =?us-ascii?Q?ntONvbc5Fy4c+9W2XAO3GHg4Zdo8H6Qhv7tpJNocivYNlYXhsKfhghAHRGdB?=
 =?us-ascii?Q?aDhs/bX7z7bYttW39vVbLivmyXUIzWVT//Ud1tlmgDp4yxGue92SevXukDyE?=
 =?us-ascii?Q?RCg5L8r689uUEYttQc+bgJDY3833sYJF1Zl7eNKfRqCMSlvYI1vtL8z1ft8S?=
 =?us-ascii?Q?LQWZDoEkLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09c9724-b84f-4461-0e16-08df46de402a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:08.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWCkqvGC0aP4NvEQN407L6Wx+Z+yKT7YoMRzahFSixXSHPCgSqHBm4fIBSEVxROWFdpPX13LtDcKNjdpUMG5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 82e0be8864f4..9832f755312f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2707,7 +2707,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
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
 
@@ -2717,7 +2722,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		set_mask_bits(&desc->flags,
 			      BIT(GPIOD_FLAG_ACTIVE_LOW) |
 			      BIT(GPIOD_FLAG_REQUESTED) |
-- 
2.43.0

