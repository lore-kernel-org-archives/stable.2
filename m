Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273392;
	b=MsAzd0JQxNZKXAGmAWKBXj2fkpNsNp+4nNStM7pp43ygub1KBPfMQGjkW4EWjjd1gAmN
	 cLiqPMQdW5QCHcauYmnwcDCDEnXm0AvNhfy22LZX8guyzMwX4l0XMj2WgOJZORyKl+qvj
	 yqMH07YPxB2DVxGj7ee4aXGeL1nIWuO7062xZ53yVaodkX7mN2YxA0rZzM/6WAaecJBJV
	 OXWny2we2QcAsPyk+SibGfDVXi3KtZNXYYHYexRRDv8KOHen2Y5cvGWQAYC/WFefOWd9m
	 K9rbcrIOWe1///qQMi/ApcEtXf33rpLR808MGn2y5UluJVqIIusKROoA/Q9HLsxxXGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273392;
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
	bh=R2iRP3hUaHUXwpmbqK+JvpTTHXIjx6DcTCN1PbXkNng=;
	b=RVIMcwYkawDjTDfv/LZeab5S/fADVR94IqqFjHsA5ESpUtuqZIwJAeXv8jF2AmP5ghLa
	 3zInGD+nWvAPcS855WlWC4SWokQK02JFv0QFSES4bCsxv2wrsZ2t5LxwYZyLVZV9AvVww
	 loP5K6aS8XYm+RXcB6YKaLKIQMAF/agWoIHGT+EDHFBmiyOPkX9PhQpfNn5KYkQ8ts3EV
	 TEQoX1eMc4/w3FHEFiDqDZttZxC/x8xHU4MInSITNxVV6SNWG1d2ajYyhQjeRZV1JGplH
	 0K954AbsPEZvz+9+IPaOfMc9iJ6NrL0OyuotMdlNmGBHf4sQMecw+VFxXkNls/rRE+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JWfjCpNz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34113606A336;
	Thu, 29 Oct 2026 11:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34113606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JWfjCpNz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkucpGZ0gtZaVtSWDgh0lQVuXnSlzfvmDeXhd38MMeXucYaltimCUZyaWUhk8zrqZaSNXlhrebXLF50olShMvkneIaHjbUIyz8l8ny1vmmXAfsgg+wPf6q1RGo/496dTK4aN8h1J0PxrhlgvHyWj4IwmvkUXPYb2TGXV1m8hRqK26oAabRYTzqoj0r2m+Bn3FYoK4EM9gMCwI6JSz4WVNbONyccqmJJHNc8m6Z6J9A8u2IpjT+JfG55WmWWpe3/VlSt4O/+89XIjR9B1vHdZJN/YRhYtbKm3+fOl3QCcCu84HfmBxEQoy6BrtAv1dyULFYsMgKZp/IjX1wDayz7EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2iRP3hUaHUXwpmbqK+JvpTTHXIjx6DcTCN1PbXkNng=;
 b=SZ2f1x3Trd4xv3A0YuWAUruRgV+PWMZyHSurV8nxNxLE5GUxqzp9/+JQ2QCSipnm5xbd0Asf3EUL8X0b3pjj+mrzOalWEi7bIpPbAPUIl9+4VZ+wtMAu+RdqIUJu19GtCkeEFOfQJ2snVa1DjjFbaeDCuYTlLGCnmP6FqXemZ7ogtDkEkc8NxSkyW/PLoOPXoxW3UAVIMyvHzB5+c6HAsuHVTHV8NcneHI18dsda58/eeEIMC8AR7jnlQ+pAUJyH9YMzgndNMuUsLlIVDPCBotg9qY1wNwiAcbF8+wdFjI4mF4730A3366TBdoXu6bSM7c9uRNtN2En+KBySZF0RCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2iRP3hUaHUXwpmbqK+JvpTTHXIjx6DcTCN1PbXkNng=;
 b=JWfjCpNzX1aMu8JSYOReuqiS5wx6O41B13CvtimyhNol7FbZ8MKVhnVrrvBCopLT6sUYIP42cxgZCyKsJKVQ6m410pajrD4MsPAmCqq94qUHKXQ8BJ7dqvusf2Q8kevRJ5HU3IV8F9JekOffMh8NlWFFdxRzY0pA6hIlMoDKA6wyKlUFN6oHCvvt9ALaRocNxjG0Z+xNGqAbdewhqWdFoG6a2YD209ziTCK7dKQl2a7zviHsSyPhiLDxX16JhK9k62O2L4LJj9Tz74dKAXAWxNL/LmIG3ddkIpirf0FmXXXB9jK0vHf1TzmcKcDP7iChqNhEXYcjAMOg17NC3A9PBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:44 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:44 +0000
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
Subject: [PATCH v4 5/7] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Thu, 29 Oct 2026 13:29:20 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d32e4f1-fe71-4d6b-24db-08df35afee5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BVsOwYehvYjcF01e4182u0rqgPmDrWfJUXQTx+Onagao6rZDsO6KVyeRiOSsNW71Q6sz7upXFqi1qArkhTPHwB+FO62aM3vM9e1vEoRhJLK8JTliaGKullqyKz7nZcgb9i2DC3Lmb8GJW9or/xPT1+rL4i48HtwA6i/JSBiOx7MoA2WUIUKo9iDetoafCfPcda/4wRsh62hhzXs234/pZBeTaAW4tZ8/+dR3OcThHemq4hiD/CGbEedgEQnFEdzhb0tlSC1wzLqyj+s8g3G3PIU5pCRN/CFn2EHKIeX8KkRCOkPq+bxs3hSHhmfkvjfP+ukIl5i6YUPBni3guYXOHmVfHJdsfQ8LkUINr2+HqPXePpUOkswISqP/tXiC8mnHltN4JkPi3aQAfTO3Cp2qN8iHeL4orWtiph8ygYMTM19ZmLEEI2A+zqrV4dCNCyxEfZNxZUGU7EtoMhCwPzN1jtKBi+GurmncuFIaPa6DX6L7C9hZrdj/eTgcNSEVSH1rXS51bZbf8zxjqTOADK+Qw0gID0e4Bb3OyWDGDDtyCKjBwYyIT59rYnWsNsD7hpiZTFmOPzV9+HT66LOH+yzr6UlN1siV8DH9rT4gE1D00SEwA5552zefcotRNqu81GEbgrR8V8u8h0yVoBCIHqbwf2JoVWyhXfrS+VFoCO+Rn8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJUOryf74Aymp8MVoAW3bg3c9RpFAT1sHNjX6/Is0Y4hCrUL+RFB8yRb5Jpe?=
 =?us-ascii?Q?Gb5fo7Z/SzuZt77dyGYAkmj52QQMPWbfoHtU1poIYcDoMuFxKNdjHbdIlXPj?=
 =?us-ascii?Q?GgqKd9W6kPbq8J87wxSPa/hxom5hnQ1isqXkEOwdUSBHy7jXkg4VlGMtsP0H?=
 =?us-ascii?Q?Lk9a304K7mD/91p/Xh/vWS5XObY5guB9X4DF4n//mH8lgb7FwkRZbso9YnrQ?=
 =?us-ascii?Q?3PsCmAESjw/Cm+gagH/R7dQO2aXQDQPgAm2+7OUeirkorH5N3ekS4GHFpvZm?=
 =?us-ascii?Q?zjh+sa+bwEd6VbNLKgfC4JZAz0ihD9u9ktPuG8nKaCb5/Gu4UGFj4nE/WNfh?=
 =?us-ascii?Q?P2G5BmoIyLHaasuuFZ4DNmaq1/3oFdC1mfkB0U7gSuurSpUa0Bg9mAvTiZV2?=
 =?us-ascii?Q?KS7ZxitjzcIlskRB57Bf7ngP35UHqKtNmpgb6jd2SLABGJfqOSwOwJGLie4C?=
 =?us-ascii?Q?HxodyTPiX91TyB4QWQjqHrBnp+LQKu+77vy+kr4YS7N7wIy9SmhwgF+8LaIp?=
 =?us-ascii?Q?T8EpYU3Obmr5mIr4R43s5Yba3yc8C31hz+KWtuodOACkllaI4w45r7qHb7Sr?=
 =?us-ascii?Q?kkDii9x7fgMtA9oIwxLLyRaOm6PjRbrifh6ZZ5k0VM9ffI1hCR+tnh5PPY/z?=
 =?us-ascii?Q?zcMM9Iehsx8cYz5UQrgwUu43hzYr4Qn3FTvpl7tjAavv/uZT1TGoi3CYapv2?=
 =?us-ascii?Q?zdWPuEjLR3k7KkvOjQjeUzPMJBu8+yUBFo2MF/p3xiJem/SnMEjSmjJhLR9M?=
 =?us-ascii?Q?Hp8upUGGTBsnIg7DE2jFPLVN3f10gEendj/mjWEfL+S4ObHFnBjbB5e14dWJ?=
 =?us-ascii?Q?C7ahpzw0AeE+6E7ADQumRGVMZQrQpoII1bd5t5wuVWUF08ngNPqD2Kp9FWOy?=
 =?us-ascii?Q?htQG07HEfUtTb5Uqy1zwlskhOYhqwOinnCXeXFJAf5ph/gtJuLHs1SXKJG8A?=
 =?us-ascii?Q?5HqpVG/C6cRR18sHGc0hoQ8QOzyCYGehLL4Lwv+zp+RPqcDDcptFuGTe8J3f?=
 =?us-ascii?Q?enHSuvya04/NIc3ydOC3AH3orv+dszYXlOyFlizMVnU/BugRV58w4ZPan0Yu?=
 =?us-ascii?Q?Xev+WSeLFH1D82MbnFXr5deuoCExjVOVErGe+kXyx44K1bHSTsgqmvv+Gh+l?=
 =?us-ascii?Q?G01Y1Me52NdShIXz2fpkjzp2HG27mdIaNHZF03Dz6qTBBlIRKeVzHDTazgUQ?=
 =?us-ascii?Q?NEjshTPcMAzsH3DB7GKhfqWHJeJrYPH6ZkHlbXxJaXTsZZFjVbAGZg+sInX9?=
 =?us-ascii?Q?SRsOvXVHp+g+SpZVT6a0DhdonCv3zMFQg9brZisHDfoY9TerFrVyJZAFg216?=
 =?us-ascii?Q?HgYn5lpfP2b8LfwW53XpER5QSuGEEBQJfwwahOBG28JI/dL9V7i29aWERyAF?=
 =?us-ascii?Q?98H2wIaIK53o2ZY9dVYMineQ3YDnx53YEfSoNRpPtnjuAdN2deuCakJL9X8I?=
 =?us-ascii?Q?tbO/xOis+rBm9qWWpp3bFKP19vpw0RVCgY5rY65XBmZ2d22dsV6fGBcpXHcc?=
 =?us-ascii?Q?owTCeImZz8KR0YWta8gX6lP2dnIUigSWzDjqHfhIAOcrsMVquSeLwrmIiEmn?=
 =?us-ascii?Q?3YlxbSb9rfrQZEh4nJ+4YV5REad9vLSOU26+7H6OgjMJYzUKLUhuc/77Vnt+?=
 =?us-ascii?Q?mZVVzIwlo9fTtOKvcyZfJSO01LxUnlSZN8fIOv38YD2cDj3AldZwooUrioee?=
 =?us-ascii?Q?oWFmOyDHgTHAg57XuHMGtTLwV7CmfukpKrtNp7QL3KGYbSQB2V8yibQAduv4?=
 =?us-ascii?Q?UzLo2P17KQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d32e4f1-fe71-4d6b-24db-08df35afee5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:44.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb7j2wCftfbYk88Sw6BHtNzpdD2lwvhPHR7UTQG/okjU0ik19+M7LaD28xUwK/SzgvQ/nZ0BkG+mCD9jsxwJ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

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
index c5869e3f7767..cf23b5296fd1 100644
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
@@ -936,6 +940,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return ret;
 			}
 			line->irq = irq;
+			line->irq_label = label;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
@@ -978,7 +983,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	free_line_irq(line->irq, line);
+	free_line_irq(line->irq, line, &line->irq_label);
 	line->irq = 0;
 
 #ifdef CONFIG_HTE
@@ -1078,6 +1083,7 @@ static int edge_detector_setup(struct line *line,
 	}
 
 	line->irq = irq;
+	line->irq_label = label;
 	return 0;
 }
 
@@ -1776,6 +1782,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1789,6 +1796,7 @@ struct lineevent_state {
 	struct gpio_desc *desc;
 	u32 eflags;
 	int irq;
+	char *irq_label;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1824,7 +1832,7 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	le->irq = 0;
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
@@ -1908,7 +1916,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2147,6 +2155,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	}
 
 	le->irq = irq;
+	le->irq_label = label;
 
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
-- 
2.43.0

