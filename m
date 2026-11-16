Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836931;
	b=qBPrKaSODzIHPOFGHfp7hEj2PX6v4QjPBLzMHt/7ZtcOrWDuYA1HvuN9kg20VgWOVjb8
	 obDIecseOoEei4/GTSc/ph+9SxtuCILRjGAQGPbVYmEeR147SUczRGIgcoSNxlR9XiaOm
	 9mjGX9r+n/Y7qpjQ35FgQRpQtYbDGMVbRcHciFC8EIO2dA0DkahyolG7ZicPTg4pNT5Wm
	 wTue8AWYfD3PohLkXZ9EeORfHRtzWcQJHHgofFqiefCFetcFPyTaF+NNQiVWegxyxxe7d
	 mCP63fFtk+4n1sxki10MVot27/dDuMcVuj2Tfkfe+sTJXpmH+zos9a7+ak1AYKNf0sA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836931;
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
	bh=994Kz6DAVqWiba3C1kWO3VWN2db8vqbytHxtx9hiw7g=;
	b=a7R2NYIEqCkmrJCQwV2P8PxTgt2SSJZ3UJmKQ2ttIDLcXjsPRV3sU/kl4ge9SGB74wfZ
	 sSFkTnP6AiD+yUzT9KlL9JgFpjNbd7D4Qh0gL2zWV3Rs/bv9o+ITabH6mdQfnBb3AaAYW
	 DjRackUngMLucfi41MDwxAGu2tchXNDAcMQ/mqZ2qCtQgUfEkuVCpKzZAUCzvZ4ARgyCj
	 STB+A7amimgC9f8MACoTgvKRo/EgpDmzX5zihxjVO5AJPwah2+plYbQj7vjwvYq/q4UWg
	 NpKupg6CBQS6yc5V1GciciJZ6R6Lv8vtHwD4SA735RPgota3/ccrRQA3ubzh8PocRsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZQFyu41U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA10606A88A;
	Mon, 16 Nov 2026 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA10606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZQFyu41U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+sMaduIVflWeeABNVM+ugAFzdXIDmabbiTAxP+3mi/rGNHzQjSlBAHQAxj0dKDI0RqnA5An6aPNLqnbwSHxtX7by+Aosse9IEIuA/Ks9IAkTw3er8mC8ACj1Tj6rJ7jflgK4SdTct44LpQPfXCO97yw1NL/eImGOyuarW4xjE5HEovuupAgpPQTBHIF89hbhSz6WyFZ0bzCALBRUrQCdx+jmziQdY1zIPgnY6HWiaPJme2Z+8GpcC+01Yzc6ZTxcWEXwrY/EDJozRcU+NYaNcB5Wxo2/SYcqXWPwBjp4ZxNRmWe6XhZtjC/EDaflkTOvUZOjtaj7nQ0OUAq3cmWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=994Kz6DAVqWiba3C1kWO3VWN2db8vqbytHxtx9hiw7g=;
 b=m02Om3N7P7CNQkwugOAFDhl0f5XqheS2jEtc5piHaMW+x1+ufsSBwHCf9EQPGGTcMscrKjD+fET3bGCSRt97H6FL3VpprDFN83AtiG1zvaCCTNnft+GPJWqris4jhveUkFRyowVgHbnIUzDKbiYKBX2TrXbjQT577f2mpaXppq4IUgUhQgfTMXC8dztwomQvDl4YipSNm1xsmAXPojrvhVSqopGuoEM97uO83aFqKUctx3BU9Uoog+ncCpGOzp+619HW7D7O/UiUEZM/bMMJAUnCGCw6X0qwNycYWQPPy1PTzndDJFCGd26kaWgL6idtzbBESdMfEWydvR9R9A6Qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=994Kz6DAVqWiba3C1kWO3VWN2db8vqbytHxtx9hiw7g=;
 b=ZQFyu41UCA+RLCCIdNgcOmnBeLY06R0LF1ItaMp8p2U6D5OpItyJIqkdTNgZYYzTg4SvymL5qlnmtUPnPUm7ejcgR4luFQn9J45Yxfc5hZYxy6PinbWnH3/dOcx55Va+zKRMgRm1nDXmlOiCxM/KAUPj/mssFG/WTpR8Z+LYVKbnnBSEuhj/Z1T5txlVHuDs6sFgf1vpVtLZIPMcfxf/OFkAy3+EANYmaOyIIZCnc2kqcUm4bj64d6c978vYwYVFzO9FcJF7oLCr0Ply4PIOZDXjQdAR6tVUh/ACCm2UnLmcBZELj6usGsx7vplvpRp6UbqZ0NiG167UPjsvq45xiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:35 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:35 +0000
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
Subject: [PATCH v6 6/8] gpiolib: cdev: don't report a failed line read as an edge
Date: Mon, 16 Nov 2026 15:47:09 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b111a5b4-fe1b-4633-01c4-08df43e82b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|11063799006|261026121527099003|261009223027099003|261022105027099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|18002099003|6133799003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	w4+5N23AKeVNsH7q4AZIViWpNcZHw3o1QbQ3VEZ+0KU11gLFnCs9lRtCq2zMLSQ2BZDVIUzqVAycsXZkAXg7/yl7O5Fv++Tx4Ahb8SUjf8EdvbsFH3afY5XzLphr6PyAA1QJCcZzMb6sTDZJdrN8XqvaWjbamcJU6f7gM/1Ex9fltFChGNfv5m0FrcrMDEffm0SpVGfXPwoothPHpIApjbYC/bsZbu418bk5vCWgEm8LHSqVtux1O+wGl2sMJXZtCN/gsUST7AbtsnH4mjNasrSM7qTPMLIWzeqodi2CfdPjESb7nC79pQiVS6tXfzMBffxSCPSZvKDWyT04ykkDcYkjyZ4NakZEhpyscZS+XhucuLV5WC5/g1lPRRrgqYoBDlONEcLfTeIMvo/Jm953HRyvvTPSG5ich6Z9iKHkZFE1N8zkWX3YwQYK3vPU6sBYyhwh4veqR0kxP5/2O+ie4WeRc4PgPXqVsxSBu2J2c+rMr7byXl0UGDkaD6HuUnrgkVdp2CSGGZEHsT82r3nbGSZI0CnWkzyp1Us5hxjoa7EAYqYXnAcw3tl+Mwe+43j0XMOOPWXC2GNUq03rCVJjoqWRkrbsks4gJARWKdfgsQUMYMN41g4qe16/HTw0uLWr8pi8IZW+A6oTdHvZ+jca+rwU8WjEV+um9obl8EYEt8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(11063799006)(261026121527099003)(261009223027099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q861sQTrqE+q1Jzcn7qKe+xigbVfcGJ0bonMkDtISXVE500wX4RkFNLjbjp0?=
 =?us-ascii?Q?8c/X93nCsxYcl8ZVs0f+oiEa/kgwDITK0/pAqhrWNXfhG/WLKHLbzviClBq0?=
 =?us-ascii?Q?YViNL6QjBSKo8jLGkkfB34MX2iGFtuWdmGZ9yyVN068RbtnsIaLNLcMiJY2S?=
 =?us-ascii?Q?2sw/N4Q9tPS+Xzz0e863SrY3m6gDNhBz4qc00dyfnZL910MMALBDKvji7tpz?=
 =?us-ascii?Q?2BwGLPJl1zGa1cB7rOVxrCHtq81fFFb1Sa/KfLeEpfdNn3xa0cIIs+kBkfti?=
 =?us-ascii?Q?lpX+W34dfenRYeqTYaARCwi88E7g+7gkzfMBnbSZItx2ZwApappe55xACFMI?=
 =?us-ascii?Q?NDXIyqn4zSI/86r3dXUaWTSZ/Yn0plKZWdwQaXfRSOu4iwjvaEzFmQLyIGye?=
 =?us-ascii?Q?BOFOJimUsH51ewJsgW6yAVbdJKhv/6KDDB6jRCap/W0nan3efvCHimCi2Wku?=
 =?us-ascii?Q?xbLMT5PlgjCqvoscZvtPZUx6hkwcodDXNLuRIKm2hFIRORSoorW4O5DHXwQN?=
 =?us-ascii?Q?Q5o/Xqcqc3SBeXVPIXCS7vj4HbRVdnrxf8e6uat+BLGa1gY8IKdR94k8aald?=
 =?us-ascii?Q?dgEQeI0Z3Rw0Gbtwr+zCYIKvP+qsQ7Faoqe+p+YE07ns+bPmcb4OkygLPfKM?=
 =?us-ascii?Q?5cD3XIQXSOwpZCY/wJpeAWQj2RgBriiJJDWcoeRfphZlKS8YaZrgYHtX8Se4?=
 =?us-ascii?Q?/UwSz7Pqq92IkRerH8USpSZnvLpJkAG9bNDFOEosDeZS+B/DGdxkqI+MRTeM?=
 =?us-ascii?Q?XzqPdZokxK1dQ9YxcCHhhrjb7o5i8hdwG7+0IzBnwdVW/nnEcIVM2sFARcsl?=
 =?us-ascii?Q?GotWb0UFDU1Kqu2B4owhUuFGuIn/ynVjBhqeTP0XgVkWgbu7JCzQ6xEIuAlB?=
 =?us-ascii?Q?8D8rlYMwKN96en4ekwgsUchLTxmKwIkJAXqRmn0W4HkzJpHaGUZlJbind9pX?=
 =?us-ascii?Q?aUT41CU6idKeCkJuLHCQs1ucJjwNXLhU6ES57UfSM5fG5BPqvUvJXDIjmZIQ?=
 =?us-ascii?Q?+QC4+sM14YWMJJsofJvH9DQ2y9OvSp20WsdcH9o7yr+jsiFnZ0xnC4uU6U/O?=
 =?us-ascii?Q?OReO7AuDCilbkELSiqlE839lu+0j0ZDdIBgM53YfPLOp2N7ot1mVDJPZ5q/L?=
 =?us-ascii?Q?5f+gg4wJRz0dx1X9qthBYLcPC6kniGoFTx1Op8r0qtDBhLhQPNbMVlgELAh2?=
 =?us-ascii?Q?IAqrNilxwGM8DA/+hohDTumrwCzmFaSTqBkdv7dFE1rrb/UJuxN0ZupMhPzw?=
 =?us-ascii?Q?2ScuWMLZNVve0FK148RPI6/a9KrD6J+qFODw5rqg3BMzfetduvgFacVBUifF?=
 =?us-ascii?Q?uxhM98r24vFHuADAvmEt5dyLwV4NSNhV8Yqh2JTjU0WYqnMWTo41/EfdhdHu?=
 =?us-ascii?Q?M36XqgoqSAMfMALfxsSaPF60l74pZgNRm2m/Ci/2y6TO8/YoJnIUHvjLl2R4?=
 =?us-ascii?Q?pjQvvYTiFj7jt/XzXuI+DK9T6j/7BxhuY8VbFcdOka2S2A7FOoHzyF5nJH1a?=
 =?us-ascii?Q?OOeYJV0bkpn27cPh63iH0xT1h9hyEIY8m5WuJZHx40fhX1jDMa/uOkJ51+7e?=
 =?us-ascii?Q?8/bavK4pyhU/4jxOcqIqeFlPp52/P1RkHdMuurZrLZgi2US4cPVEeEo21Sgn?=
 =?us-ascii?Q?EL5og6l7Mj6CsXDMcWda4SfFYsXmqPtTl5F5d5HhH/KcWoZlZaS45mJk81iy?=
 =?us-ascii?Q?c4z63r4eTW/DITrrwEuMxI4FuBkukSiz3GmmTi7l/0HnSJdBRDD2+O+BFaWm?=
 =?us-ascii?Q?th0iwe027Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b111a5b4-fe1b-4633-01c4-08df43e82b87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:35.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRdUPnRcZrO1ckmVXoG3TTQfiDs7oDr58yvDE1eCRsy4GPiJ5vr1LTwfVX5aCll3Uoy3og+tBVOMbOorAR2XDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 3f378748f508..ffa8175b78d8 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -644,6 +644,8 @@ static enum hte_return process_hw_ts_thread(void *p)
 		level = (line->raw_level >= 0) ?
 				line->raw_level :
 				gpiod_get_raw_value_cansleep(line->desc);
+		if (level < 0)
+			return HTE_CB_HANDLED;
 
 		if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
 			level = !level;
@@ -746,6 +748,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	struct line *line = p;
 	struct linereq *lr = line->req;
 	struct gpio_v2_line_event le;
+	int level;
 
 	/* Do not leak kernel stack to userspace */
 	memset(&le, 0, sizeof(le));
@@ -766,7 +769,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
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
@@ -2007,6 +2013,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
 		int level = gpiod_get_value_cansleep(le->desc);
 
+		if (level < 0)
+			return IRQ_HANDLED;
 		if (level)
 			/* Emit low-to-high event */
 			ge.id = GPIOEVENT_EVENT_RISING_EDGE;
-- 
2.43.0

