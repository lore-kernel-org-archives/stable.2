Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701990;
	b=gWyQc8liZqVr9JKwzH543eiVGWSrw7seMiHCVHpU6S3MyUGXHre5ix1nIIIBatRFfLxM
	 dD2SwNyb+xlkGrXzxXe/ohG6CqC0n8Rhcs4QwJflU8JEqRlcsUMggpvtQaHsjWfhdreUi
	 i6oTu08sFT+FiwHXHANbMmfnVBmJS/jL2+/q9toRx9uDHAmQNCBfVbV5UvG7rfiYyUs6p
	 I8fwwpwnOXeJy0mbOGBmOKp9BUhvRE7TO2UK8P8NsA7KR9KfOiZ4eFOSV0P0yD2cm9r+z
	 f7LROUmEVq8C57LXTh/UU6p3G4XpEnOF1hQM+OTTAeGhKMplk+PNehwM2h+K/ew6AEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701990;
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
	bh=g3m2mGfXH20IphEsill1uplryjayEM4Uu7+mGiTrhok=;
	b=OIbtRsjlZXlRVx1/NDR56OGUPcXH8QwbeZpIpJ9PXL2goKGIoXIKY2FS9HnaIJysILci
	 wXoNDMWNr/EMfCH3t4lYoACITQI4dRQhB+9pgNQeqKY/sznwdT0jFQBmBaxLIhZfCIPXj
	 BuSIS1Pf9MnsOoLhKjWxCBujY3NfmtjBY3aEsJhqAMQ/whs65S/Di3E5bgN4SPO5PNGGv
	 kXKP6zBoZvpT3B7r7G0JHiT86u3tluVAfRYmwtbGzyR8lAQTtNXdcrVgTF8F6mEZNU2rH
	 EIw4biZuo514tPxErGZzRQmzN+i8A+yE7E4zhmfeEJ4f/nxB6xb2SxEW1N0cHmEsaXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dPdQHj42;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09E606F7C2;
	Tue,  3 Nov 2026 10:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F09E606F7C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dPdQHj42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMcuXaf2nobWkyzz/C2svCYjRNbdfqKchwGi5HZC2OejpdGmSuaCMqJ7d7lLZFbU7wFjAMVetCEASnj+saxUNIfG1fqR006WeF+yGccWeB/2x7VjqqpHD6y+3W7C4mjLq67i3OI+XsYgiPqAPhPTARiR4MT6xastdmTXTsqZncoRJO3ruiWB9Y5mb6YBRU2qbLWBfjEH+w+DU3tYL1Q3Mwf89/41BgoPtrHEPO8edL4d6ceM9v/fAvH23sPUqAcQkFigDZvcLPlF2N8kT5S1SDBuglsQtKVMDcvTMVLZHcnsY/1XGFGW5dnKUAKcGjyS6c8NHN8Qpu6BCBQqjQRajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3m2mGfXH20IphEsill1uplryjayEM4Uu7+mGiTrhok=;
 b=l549pjVOMQlk7yU6U1DOFR3r4d+7bxobeTbLMkLRqoV7AOQ6RgdycjqGSbL8pHQk3f88VRPi6tLjZhrFR5CE38JzNntI62QCiGzT6Z3rcF/0AT8MT8LoK1VTys+P+/LdIn3QIsp0Wstd3LxKBSKQeexbsWV5U00DbxXIzvxs1b8+bwtXS3gbYBP8ZJQA69FhCKDDS+bj2dy3DG/DzuGZNlH25dUjxpSmuElSbTYU0Y6Jm0NrbpU11L0eXd8dnUjf1hpckyw/3t3RCVAOVzL3FMwicG1PIbtMOERR9OrfyXtsElXYP2b81HQjK/ct8iqTJmW66zYbeDjA0kZbjyZJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3m2mGfXH20IphEsill1uplryjayEM4Uu7+mGiTrhok=;
 b=dPdQHj42ahDTmZf6jJSgci5w1NHUgTIm0n4alqdYcSR6MCKPz6bODK7kBoFRI8EUvY8FPzPKG48+MSl4TKTlN6bW9C2++Qp9S0UhNOpjNMlBJzSggNFoUhRwmDkt0lot6oZlXPiXyHfAQPsxbL/j4z2qYmj6FMsOkNtbWRF9x3i7Mm3tkrKCv/QtSsTCv42WOaDEgiy0BCSPj1cfY4z/gWDbWRie0ouTNF/bwOKiSEkMi4W4UpNOl83KXY6dSAjMjLD0BBiosqvyZs0R6WdT2gEC1b+v9VVMUwJbBDTdeB++qrkicNBSadNwOoRhI5Tcp9ml7NvFWti8cPdKlkxdnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:33:02 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:33:02 +0000
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
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 6/7] gpiolib: cdev: don't report a failed line read as an edge
Date: Tue,  3 Nov 2026 12:32:39 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 320f7ebd-c130-4a56-c54d-08df3995d6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|56012099006|11063799006|261009223027099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zJd1SlQE1gqt94FsFq0LsJCD4HiI5zIZsRxO8I9iFqsCOciFNtIlQXSd+P5wv+hhtvRCO9Rg9ehS6uRkkKJUqs3LyLvRuOrJyPlMnWEhd62XotVWNmEwI/6xHFZQrf7fAt5g0WjGdqucUEocqrCWszIxXxg7XNQwmxJipiPUSdGJDQ1QR42d9qDETWrTc62N3UxI4xWg+330G6bwZkdvbeg/f21pD5PJ/P7tyREZcIEzrrh/innZnXkKGbOmwGHNMqgIl3fhidpI/EG3MWNUgQWQD8cnHI5bsXZEpHkhiEeysfb5g19TZMiFPioA7OHHGNUuQwQDosUk3jOSjpYfYQl8bY2iOmPTKte4Wg+Ku9VmFeqF1EtaAHuXloKb1OvwTn5EOzp6qT6UWp6l/RPZKo49kqQ3ggI6Li46xMpFCMSdKjijzWVENPjHzkWlFNIb/K8aSmoFAqfJhj8hdhruxigULnj8BIgnKHr8V2/63LbxzBJiyWkaewM0SxVUTzWA3oDO4BtpxqWsLlJ/l2xjSC3xO6F0KMLyyhPmpVnW6YKoUH9rvaNbMRmeXsgsUww6GQrKz9mJjLR7YEm2VLuT8oot4978r9zwmpCA9Iq3vgqJIOGKZhVqoHEuuj1QNe6Y5ZCxQs1jc8HjTVvGRPR0i/z8+pb949kmL96NGLZLSmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ee0vi0Qk1PlbRPKiuLawrH6VZNMoTYIL40EBCUT9WOrW5OaaBFmP3MbKi/sG?=
 =?us-ascii?Q?8Fk8po5UksPvrGQEdLS7Ndp5TuNLu/CDSm04ESTY/cSnhUGhK3LxjsK06AsP?=
 =?us-ascii?Q?MlfBb+D5Z8sbdX/bRfyREPAwXBmDQGkByS4M2LqSPWN4D3+mAQNHzNmYKo9f?=
 =?us-ascii?Q?x0VqL015MWwGZiTOhQMRv177rekHPqoUmyh/XmH4ztiQGkAZB50SC9qT2Itn?=
 =?us-ascii?Q?GHDMUPfnnlnXOR/gAnH+fYJ81/vt7zh00H1kTZrYEJ24JcXqWw7ospIVtQuS?=
 =?us-ascii?Q?w7ZnKK2ULI4rQljtnGFP3sKxazy/YvhCF5o+GqMP+puIbBYW2tVrZInyoGxU?=
 =?us-ascii?Q?qidiV0hITwbTZ8U0KI5Cn739PGeaTWJWlV9p/9H5GZHFfIINebtVrP3umdSZ?=
 =?us-ascii?Q?Vo1NggRvpYq0pIRyvNL5KIra42wWUZFErCSP0L0drd5T+4auXqxfoxkPcF4t?=
 =?us-ascii?Q?Bunz9vu0HcJvVcxk+B9IwWSOq141imjUXpg3Zk2UfhIYnsx/eET4v0fskEpO?=
 =?us-ascii?Q?3ZUfq2Ibj6CHrVix6SuyGAnFpIJchVRHiOaxoeCg4jGtNFUoNYu6AJo1N3lz?=
 =?us-ascii?Q?bmPiGS4dgJoPFOPtYRbCJzfVQ629rYkgSJ+eW0v87WbXhHYrtrFL6lBksj1P?=
 =?us-ascii?Q?GhgWKd2PbXWT2NIKYfjWTVISS1B2SHwk3NQrJxXFFyVL2Go1CPYwyJI7yllZ?=
 =?us-ascii?Q?uO0XxpQq84nPRavGRpUdSmtMLiH6M2D1NiXtga7esY7sF7L4U2kZzW2mdLh1?=
 =?us-ascii?Q?D8QGRhU1y60mBnIAd53PdSsY4HISq9ByiWC7e0MYAt76/QPtm3nAg67Mnntt?=
 =?us-ascii?Q?Eo8/48PqqYc5dUmQeIntSPK4e6nhl0DSLLe4TuYxXcfGC/biZb1NtUQfNPvx?=
 =?us-ascii?Q?3UbA/V9rpsE1s0OJ7d015cXEMjp7HHYpiTJ44y95W7buMZ10Ld0rqYs+mmDq?=
 =?us-ascii?Q?o5X0ZnI7kCjCC5BmkQPTwPQvHGvHDEYQc0DjKgd3M2KMqGcQknBM+Rjwkgyd?=
 =?us-ascii?Q?Ah9FEhELwII6SyKrF5pA8SGUdEzsC5e3IE1mHx8ZkJBcJmVpvvMwIz8BzzMj?=
 =?us-ascii?Q?qis2t7PMWFRZXkNUagH7CE9vWLBIUC5zxBJkl2hFmYrW/t2hNDGRKaj6oOks?=
 =?us-ascii?Q?wQuW6Wn9R4NOvSYVCp0/A1HC35WL2kQYxYkqxwrtjaJtl7Skq20IuxHWjEYr?=
 =?us-ascii?Q?ETlIwdvtsIk1mjlbgkUVONG0wAta0zBSKa7gqL7dDCUa6U5B3uk50QjRVNUN?=
 =?us-ascii?Q?YthZnW8BCuD3hB37ieyusqOw4svHaZAwVfvPrBxLYekxkfXePwNQJ6ujKPS+?=
 =?us-ascii?Q?sb/czffHtXDLjldmACERXwhZCb7/x/2vWLyj81L7V90um5NUYNshxZhFcCE4?=
 =?us-ascii?Q?Riu98xIeVoPHDXxnLMJUbobKhlxuCPpA0boUBStVfFl8gG7lrCGO07dAtv+a?=
 =?us-ascii?Q?t7saOLT6ZPmiFFWRVynTBQ5qOB813Ao1oJ8GH1xn35nHpKGRvdAKxnK06gzO?=
 =?us-ascii?Q?2SrO8q6QUZlsXAfRVjRt1ecwGEVQmfZspBBVqw4sb2F+sdf+/oy9ATVoyjpB?=
 =?us-ascii?Q?c2octhN4aqy7XwshIBSIoeieerARunnPLtGTwN0lQyjw01ElbN63PY3xxEuw?=
 =?us-ascii?Q?uF9HgzItIU41NrZcTNtI50gSq4xGNosf+MhynxMIPaXjzibm33zpAXyaCl4R?=
 =?us-ascii?Q?5yoOmz95eOwsrkGQ8/XcqvNIrR2c5XrycR3QYG8PKdzc4KQkx9R/nPDVO2mY?=
 =?us-ascii?Q?BYYBxXLR4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320f7ebd-c130-4a56-c54d-08df3995d6b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:33:02.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upNvWZGl9W30iRSp15xSet3BJDDYMw8DRZk9ZzOpPvkcw+2aW8Pm7Gzd9HU2Z545Z3TFg5A2H9khKUOU5rpxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

With both edges requested, the IRQ threads read the line to tell a
rising edge from a falling one, and treat an error as a high level.

The read fails when the chip is gone. A driver's ->get() returns an
error once its device stops answering: pcf857x when the I2C transfer
fails, dln2 when the USB adapter is unplugged. Since gdev->chip became
SRCU-protected, the read also returns -ENODEV between gpiochip_remove()
and the IRQ being freed.

Drop the event when the read fails, as debounce_work_func() does.

Tested with gpio-sim removal (test delay in the IRQ threads) and a
test chip whose ->get() returns -EIO: both reported a rising edge, none
with this change. The HTE path was compile-tested.

Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com?part=6
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 3623b05fef60..50b1a77ef0f1 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -643,6 +643,8 @@ static enum hte_return process_hw_ts_thread(void *p)
 		level = (line->raw_level >= 0) ?
 				line->raw_level :
 				gpiod_get_raw_value_cansleep(line->desc);
+		if (level < 0)
+			return HTE_CB_HANDLED;
 
 		if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
 			level = !level;
@@ -745,6 +747,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	struct line *line = p;
 	struct linereq *lr = line->req;
 	struct gpio_v2_line_event le;
+	int level;
 
 	/* Do not leak kernel stack to userspace */
 	memset(&le, 0, sizeof(le));
@@ -765,7 +768,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
 	switch (READ_ONCE(line->edflags) & GPIO_V2_LINE_EDGE_FLAGS) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
-		le.id = line_event_id(gpiod_get_value_cansleep(line->desc));
+		level = gpiod_get_value_cansleep(line->desc);
+		if (level < 0)
+			return IRQ_HANDLED;
+		le.id = line_event_id(level);
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_RISING:
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
@@ -2008,6 +2014,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
 		int level = gpiod_get_value_cansleep(le->desc);
 
+		if (level < 0)
+			return IRQ_HANDLED;
 		if (level)
 			/* Emit low-to-high event */
 			ge.id = GPIOEVENT_EVENT_RISING_EDGE;
-- 
2.43.0

