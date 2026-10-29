Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273407;
	b=m7OoS4udczeq2Z4a1Ys2lf7OzWcpmPvIrfHzMJY6m6wXfu0cjSzyn3qQ//ZwELr360ar
	 zJNwBMG99kEKBzrWzfRQjmGwGjMb6JetJ72r0KZzxtwqtnQ2K8ii+bOiaYpZ51z/mXSiK
	 vX5dWNtDHxQ9BmpYH85SV4GYjhche3G8XT5nYCQ+vgdga5OaARC1gps1sGwZibUILXjAQ
	 P/38Nvpa0ksxb2yYBqsuDmgNiVvDRqg2QQnuPNhchBxjTIfTCEPJui9SQnCCjeWlPi5hC
	 ftD/oJVMWMjFnBzKEy4R6bl2V6Ropd3Zp8qrg5IFaqhMPkxgUjbdJn8KX2cN4rI1FBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273407;
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
	bh=8u7O1RK3mk60LG337hDztltAZAE492yHQCoLYNUCCOM=;
	b=0fMDZrRYyj6BmRGbeuhqp/ZSZn4B2TyHWFKEQaqruuMDM+MH96fHVglVdF+dW0cbqxBa
	 4M70LRrTQW6bzWPbFAOEEwPR1dCqkBqdq4bZZYBQoos7Hm2YkY0eGE6UL4QF1dHHha9kS
	 Y4d04IC9dSRHt8zauTtp+2dBj/uX40WAppxkDu4jOa8XBjpP57HgwsZIO07QMOsQLQLCX
	 HNZWKVJmONTTyS7A3ngu2qDCmLtk//ISQ90/RxK9fmmZNSuBx9RbrlyUQ1VxqWc4fW59K
	 zc0TXA1Efnv7aZAJbL2G4ZJ0V3aqJuLnfRG2yjHrpQttQkzEdIklEQTtiIKVXZmteQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MnALZUKZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53E606A323;
	Thu, 29 Oct 2026 11:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA53E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MnALZUKZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIvaRugSRHp3pdgaLDSH6ZVdVvyqTozaO6AR131pHz/D2MpjyWO3On1FToqtGA3hKaeuQiUJeSOZOsAP99sk5dUAMilA+q3r1QoPUVzdNWVkOfLesqX83H530AJqR4RBmjWT6Bm0rBQCKnQn3ghh1duXW0NHKjnoNnsbqH8BcID96bMl17QXDA/xI2C9GUwEFRCtPReuCs/YTY5NrbR/bF7TQgC7dS/gJ6aVLjiK8b2/jSVxuFHcQ4/T+qrMFeQcLcoDBsQV3YuIQuE23+/HPaML4ZFisTS9Pa5mPhpNx0C3ef2kxk38Ht6qBVHeWEVZI1YrR79dg7zWakZo+8EqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u7O1RK3mk60LG337hDztltAZAE492yHQCoLYNUCCOM=;
 b=dP7+lJ2/nlC0zGiYDRf3dU/lCEADTtgrN1fuN2UjU0zDkau7Nave7Y8M2JSg01nMJTeBUQJcZPXdtICfapP8DneFDgeIc8Cjux9djHOgE4LPGZBxlHtjh/3DmW2dFHfHU/bGxCMtTbxp5Y8/NeHvFg7WR2AT2Ohh4zH+uikgqYDaDVsO8f4z47X9yWl7cOxZvE81/zHRbL2O4mto7KLP3/Ind/cIaPi1lQbJuqYlm+RdCKmiPE+LhruJ1o1aTtkpsunR2YfooN9j6zgJ8ek1QzyFUv5nWVhoX++M2rYolivK4hT0wxBmmuRCRby/Uz0Hepgdvomy+dSYFM3KgOLzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u7O1RK3mk60LG337hDztltAZAE492yHQCoLYNUCCOM=;
 b=MnALZUKZPiXNL51obJhvcjMVb6vX3A4Vg/Zuc31gLfX7mC1gR9uJeFhLZDUi8nPXh540Bn0CjY2o+t8rYtJp9ZHecDKB1/7CGcGaa9bs3VSwNnchVyfPKMrm+UiEs/3vQ33lKCnQB146vhIDp2SFX/kusBdczUV8VGoOjKIiu/c58eCotvWknh3br9rEd6lzaUsR9S5heyuvgnJyMZPNEsnoqFfF9k6MjMXg3fqDrmM3RzGwBkCpzmft5vbdwa2S7nlORoFKfFEXQk8UHnK8xti5zazMOsREkClBBOwlJkOmwikYg2kR/75TABqa9xD2ZGGvinx6DJ0ihs0TTuq1YQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:49 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:49 +0000
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
Subject: [PATCH v4 6/7] gpiolib: cdev: don't report a failed line read as an edge
Date: Thu, 29 Oct 2026 13:29:21 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc28686-120d-48e7-2b66-08df35aff17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Txvb5rVekA1EfYfNelSIz8MtGr8ZngpoJnXWeEvmA22DrK2g5kD4RtRmAYLMWCchOdeAJIyv/i6p7mqpF63G6lNkdgpaw25Va5VNp4tyJPW+77wK/Qo8SAlq1HZsfe0uGUIkYplGn7HroX6Cpel5N/1dV+DQcAzmaUlgumcpaM6a14gKYgqMRtWIQo7TVD4HyuUMN15fPXBV0o6TfOeBp0OhUsj6Vm3DQWpXoDULDEYrY8VYJF8heWbZt99xkhx/9NE+//ENWTmUO6YwvzWte99BzfOVwbI9KRM8trSiZJ4frlK4C0BJjoTCPKMpoYinnZTpksvWWgoyjWZ6US8I8Dv8ysrByJTFNUBsrl1IYOpWOvzCNldevygnv5yxpmriX3l9gT976v+5RfHU5VZ8tp2oDCFot3oRJ9nS3l4ki8iDYntjo0SQCqtTuqzPA7dyGdIEK3vlvQ645a/VcPFEiirJClu0Om/wkrzrmVW6scyS1QUfNNAmRQdgb2OJX4cjb07hlmxAji0CDqeQYWCMcegvlbQR9qLscs9FnxrQ4/N3c2Fpp/28VY/nmxJksNdDbCwuNXX1wVwJNTNEYTiLwlxu8xqY41ojdkRrk6y82k49eGoV+ClZu1wqwLKeiKdnNrN5h3aPCD0/gzTWVYC23zwo/MMnbIFYw1cCX1NWKW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhnWPu9JRmy7lMk04IDKHdAreNSwtUS9bZHqh7emoQG8GT7SE8GSeE7SPdn+?=
 =?us-ascii?Q?DWW+38KVbeBCArJZmRGCMSvTDEVqWu7whrEin4ZfEPNfHKDdcqQ8QwzDBwG/?=
 =?us-ascii?Q?+rc2jNMmx6CUXaQ6uy8N2/rHs40vv7JEC8Oqrsa54LqnqjE27cHz4BEv1X24?=
 =?us-ascii?Q?EWpf44OKSV0w2lgoLQfnSspZjIaeIpGD/05OTLxavzI4MSJPPyNHt7Jg5xZT?=
 =?us-ascii?Q?YXq06JRioKIyRSt433TGgmZbK2JAik8lauVcuE6ThlvftihzfManl4W2v/Ia?=
 =?us-ascii?Q?a007FiVcsthfK/tqU7i1yvi4T7vpAXZ1KeF757ilgojvYubXxj446IFEhumR?=
 =?us-ascii?Q?sR5obDLbyqChXenlVrWaLa/xxLuWvqKkdEsMNDRSMqZRgnHP9HBulpxAwZ0b?=
 =?us-ascii?Q?Kx3JrVJsGGoOS2rfjxx0x98oP1i6HrkFLd4Z6eUakd8/vcGtsYzNE2liqGHl?=
 =?us-ascii?Q?dNMkTQtV9jOQRJfzMOhBjXJRKFsHubmnDM6SGMg13quG/jgHO35ArogADTLj?=
 =?us-ascii?Q?cNEDWgp6XzI9+ALgy9D0cAxVt2U1c1CqGudAyoUXDPiwIXpTNXCsY/+7s1HX?=
 =?us-ascii?Q?KOjPBABMQ8ziuO18RF+gbce0vwj6ITmLWGYj+GHWCuNwdf+q+MyksjKKns4K?=
 =?us-ascii?Q?TUmsZlnUdV7s5lTwbAX1wRbay28Drqoz492UqJsGLS3Bx5icqpTErLjOBcm6?=
 =?us-ascii?Q?V/nRRN0XGeA/IuLokI8aAWkgfIzXZewMhW/5gqW0LOZQfxN5It6x1OsHlztC?=
 =?us-ascii?Q?NgvwDHWwK9pYjnmRVMC3rlMAalKgcJ6ofODUkDwl/UNokrFam2yPeWDnVQ+U?=
 =?us-ascii?Q?eYRB084sJEfKId/aXY/cFXi6Jee4yOn+8FlnGjmR/XQ4XBixFkQeA5y44qfh?=
 =?us-ascii?Q?B5XT+Lh5oXjaiKMjuBcQhyArnVnZFOwsXYGAGtVhDyobgo4WqPnHyITGfJ5L?=
 =?us-ascii?Q?ythje7wDFJbknIUJmjg6Uk18C2XLwv7DdB43geDdSk2Qm4g3DH2A2dn9rZQh?=
 =?us-ascii?Q?jubUC/jN/VbJNjqzBWNVgGqts/1hThRGuy2/S50ZBANGc8m8yWobWKTBUPLv?=
 =?us-ascii?Q?5sZM/tYDMQfaIARiQxqDgOPylP2M30jZPvKwuyLBQd7poP6dHiB3A2K/QzV5?=
 =?us-ascii?Q?kYBAZ69gdAslSh357RwP/b+XE6A9woLGJga+/qldUw1VMedh8g5GzvtDku/0?=
 =?us-ascii?Q?zaVIdHy7Vsau5Lmq+PYLfk4dwFQuCNMD4arlfb3j2okpeC96DxvuvTc/tBjW?=
 =?us-ascii?Q?1zKlnaae7/BECznDssNySkVOgqvxneswT+SuaDQt4FJ2bEdgvztKgstHIMI0?=
 =?us-ascii?Q?n9pVvU0L99tG4bZkcfi8N3JDjv26Hn+/la8wM0hZV/ueVjZ8Gpr/o1Bfs82p?=
 =?us-ascii?Q?6BHGpryTJgzkDbD70LiRTpsSiJ+KnfR11F+OS+awStCTC52nekkSa6/o52jV?=
 =?us-ascii?Q?6xw5QFGoLsUE0ti+mXVMTnxHBEu+otxxBzrDxIp5yE6dpCe9TgfuYcOWvwuI?=
 =?us-ascii?Q?+rkQEbcTAB0XU8OVLdyX6GPWiuLod9Tgkj/0cjThuhb+0A6PDARlWbPTKzG3?=
 =?us-ascii?Q?s8flIO2hrigHq2l+ern5UvL6f5bfNKXgBNNMTqrT7l8J8I2oe1ukKBY/ZOWz?=
 =?us-ascii?Q?rA9BWrYeHEBDL6i01gv83IERMOEWyVQnIOCyFLyLOvn+bvQVBJpHrOPGvHBb?=
 =?us-ascii?Q?aIM+5uLH4WDVnUPwqv/gMt4dpH3uaed81KRe1298L3JxIAx3GyBmcg4W55Rs?=
 =?us-ascii?Q?us7y1uPSEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc28686-120d-48e7-2b66-08df35aff17c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:49.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Rqkm564Mf4n/pjZOw7/18gQCkXVHgItqEWb/sy4uStsJtKt/C1ypZd7bQFogtev3lyFoPBfOqmi39ITxaDB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

With both edges requested, the IRQ threads read the line to tell a
rising edge from a falling one, and report any non-zero result as
rising, an error included. A read fails when a hot-pluggable chip is
going away, or when gpiochip_remove() has cleared gdev->chip before the
IRQ is freed.

Drop the event when the read fails, as debounce_work_func() does.

Reproduced with gpio-sim and a test delay in the IRQ threads: a falling
edge during chip removal is read as rising; with this change, it is
dropped and read() returns -ENODEV. The HTE path was compile-tested.

Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
Fixes: 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com?part=6
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index cf23b5296fd1..0d6853751e6e 100644
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
@@ -743,6 +745,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	struct line *line = p;
 	struct linereq *lr = line->req;
 	struct gpio_v2_line_event le;
+	int level;
 
 	/* Do not leak kernel stack to userspace */
 	memset(&le, 0, sizeof(le));
@@ -763,7 +766,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
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
@@ -2006,6 +2012,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
 		int level = gpiod_get_value_cansleep(le->desc);
 
+		if (level < 0)
+			return IRQ_HANDLED;
 		if (level)
 			/* Emit low-to-high event */
 			ge.id = GPIOEVENT_EVENT_RISING_EDGE;
-- 
2.43.0

