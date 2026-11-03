Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701990;
	b=KsVb/jgTcyU6Hw8TbZnreawyZzKfJDEg0nckNfTIKuFluDWfYsm5fLi6h/OWCRRnolKY
	 OK0Q6KjFmtUAg8hJOqYVzirORBRW4jSZacCrLHo2XjjNaV9904n6ktHNwiuxaT0aB5cUK
	 7j45QaPd+MCYDFK54ub/zNX4zGUYb/yinR3o3qCfUG8ycZiN8iqYA5NN/AImqgmKrK51w
	 NQVHDEj8+b7Vn9dMXdAS5iFuxlvjEs1May4PbWzFb+Zu2fNiLOQ/qddz5/52eBhMI0VJb
	 w9mGgvBrpwQ9MU0Yk9Jq8mC2KDVys0Bo3b6IU0r5hq3OLo4FhrlDvqtUVDOm2aJV+3g==
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
	bh=+p5Pu8kdIO05xs/e+0FsP0KvdEAgjHQY2dBVvZHDrQM=;
	b=RWp7M+DizCgH5NDu6T6hrlk/xLXuW5vOK40J4S2JMwK5M9441Yh2RagtUoG19xgHNWmk
	 3RvfgS+Q9QFGPr2j5tkaegInziNZszDQ2vrqmg02jfqbfBIZUmNIdiaLLczCQzv86v8PI
	 ah1zt4q9OL0PAcXDNJ5bNHZBpq1ddh6rwyaU4302Zsit5LQ9Bs6aAQuhX6hcc9CbQrYyj
	 QQGVqVoRP7cfAFDrZfLyElztE3R0LORW2psrqNithdFJhqlTWjcCs5D0vGfHPlNSZSCe3
	 Qpgcm/nhpnCo6WYoEaD56GYAWWMTBj5A8Q810B5rlPTHMBLWQye+vyTIKFv4kwufQzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XZ0wHVp7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB15606BA68;
	Tue,  3 Nov 2026 10:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB15606BA68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XZ0wHVp7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVdAoDnt6FjgzeP4Rn0QPINi5UQ2VzsFXDxM3/oNha7N1/lS9oviwbau9BNFzifeVmeZd/GXUDTT5qQoMBqrx3+JR614y2Fg6HiglInXo+FFD9CESFECyT0P3gVNIAsycbdpUBxACcuFpjwZPSNXA8Z+mDfdthFKjYdAyGunaEbiK/9AdZIQla/YTGV5Mr0o3GMNN2STKp8EraWBSyB5BPsGvfl8qAfHOGBtsTBtLtnuvry26Yc4Bu1bMF+Beo7iwDV35t9YydJloKsin+9WqP8c+PR+M4VBrAbZhN48J05bb8bM+LQ18wqKYXhH9Uy7c+abGoKSxa5kB1mvYtwpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p5Pu8kdIO05xs/e+0FsP0KvdEAgjHQY2dBVvZHDrQM=;
 b=cxOXc1rnCFJu9oiZZ8bjqqhjNjCJCj7yrZEYNXjGx4mtta4AiS+WEgcZRoZxffHqHbK2PKylcsVuH/okpk8//kArFnoQHzkmEWX2vDxfja4xg+SXuOWc8Kjs+rr/o8dFQO8jXFznVirIrNlShG8OsDFigd4uA2bMMaDma+sQNfJiNR8/vW2YeLeTzWOU2d5KiRbBTBJLbN5yCfdJyHxwiOP20S+UtVfN4+cuqzOcRQjhLVdq7sdmIdPp8wOigatJt4CcTGy/6qTKPdbCf8iVSJyQYNIxhAcYIhVN0fSCp845c8q76xXUqZkHY3UYE0MkoAbgONBoMWLClDWebCUHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p5Pu8kdIO05xs/e+0FsP0KvdEAgjHQY2dBVvZHDrQM=;
 b=XZ0wHVp77kuTy28UMvYTH+QiX4mivlp3AMirL3C0eC8WAuLz28SN4SL4HSGSCBlOdBy7WcXVC4Wt/Ux7rzsTcjX9aPF7CCBpF+17BqnJt5Ny3jWbTuxrywzVzUPmvw4f/sxv7dzNz68VYqEHSL4Nc3R+2GLLGCb7nij3xqlT4sa53ke0tpUF0VgFjuPqOHSkA8DnTKZVCzHi8Uo6/siNiEHeyYmdQNsa8cc38ntFj/x8gkvanWQQBqYPwEGEv5fWDDOzW3pb+u5E4OzbtaFPu9E31wQZLP3TTV2eGpnXizV/b+10fvKSI4PuBtDVEQLlfvgzYAUNa6kq2CixM56a8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:33:07 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:33:07 +0000
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
Subject: [PATCH v5 7/7] gpiolib: let the character device free its IRQs first on chip removal
Date: Tue,  3 Nov 2026 12:32:40 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 85345859-cdc9-4c5c-ccf5-08df3995d941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|261102130727099003|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mBq+ilibxdute/N4nSRthu63ChU3fr2Bg9AojPiaGmwlrzKsFowKuk2AN7+vlEs1wHzv4yryttbN34WyLuTJlHuD+J4Z6ptxMVehJl6rOMWlikIDRKu8jJ3ZpatQkAeAzIJGpjfLgWJJCRmRuFnKpvf3Njswyng/Izut/7N7cLSuvvlAKfyR8o1J96KgYcMpPyTGV3Zlo2euiPwQw0MbapFdx/jZRo2xy+e7z6kIGqeGzTMJMTXi23xnJlrBUc8lSOdK0DDv5xFvkOkX4EEruV9HW+QF+vDH800GHJt2GQJUZfAOpuclYmvq8XG3II/9lQGWXZj+KQbZF806NU5GFNDFiE38v7IKDb6eKq20l66E89LtzrKbmdDbul0dZ91z8bzWl2h3TzBAgj3LZ3Gvuc4oTlBCIA1moMTw3LyYfwLVksYIU4UG8ld1oGB1cczhzUiRW6q1PfInLqxR0xLC/z7a+bL7inCNOds/H+ghkbh395EBCtHTC1XMSWJ0lYMWmP/xv/ptNJcIo1Yky4OPkSG3Qxmbw5DLB0LxVZXRGsh2bIyx5YvBfyWms0nFPbvOodsDtwHU1Pf4BQ0BEWAbhbNcRfIFiwzHQLuNgUzxDQPE+rqzODOaqBFr5CWChaN+cwAsPSJfOY1IJIGEwH2CQpkRp+mQvCOYWjiUXrKJWlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/Wljt+7uGLEEUQJ8ozobCMz+pvg25ABWuMVifIfC1ulqeCey10dMbXsVKmC?=
 =?us-ascii?Q?9omLYlLXBKxGyLPrETu/jySONV3TspOwmL9lc/wqE7qt1v7f+ph9OeDMMKRE?=
 =?us-ascii?Q?UjIMvVL1++LH2u6xHfaozFn++3qUpZDqfiUx7mFrrab8R4OQeBd6AZ44BBNs?=
 =?us-ascii?Q?bMAaSIIDy/+fafir6ErToFrwCAHro70YqotuYOBvZBcvaHSIBUchnBiNl5Op?=
 =?us-ascii?Q?xRFD8ytUjRTTdCMr6e0BEv7u7Olv4fSaEbE14xuudvFBBaOQUS/MLCeXPoFS?=
 =?us-ascii?Q?IBAgj0Un/oNkRc2DWRWKcTTWDCMYKO7zXmDdQJEr4RrKityohSpbFfZgRw6B?=
 =?us-ascii?Q?S/aBNN1FvhfsOKKg65QhPZCi+jt/EK1hx8Sh986ULjhaJJ4OA0cjF9oXFmcW?=
 =?us-ascii?Q?R6C5SpZuCdTkjmSFVpA6/n2XrghmT+0G1SHefQNjDjVSOJeYNAjoHsA8EWOM?=
 =?us-ascii?Q?PFSCSBukf7Vow56FQTu3no3zNb3qVgaIh52w9NpLIFVmdRGZJOEOP6YxDZJu?=
 =?us-ascii?Q?cJlUMZ5wlntCAgvRa2y42YALtV8tn4mBadvTYonMmWOOdDYImNA71FUO5TTc?=
 =?us-ascii?Q?978WaaD580xIg+EUPYOqtCyjhfEzz8AESdWwXWW2jxEwVB8F6xKBXNqZgB89?=
 =?us-ascii?Q?TqVjhyGWaqh/GlLZEym5agYhWVzHcL6ow5mfcJlnXEHp1vU6TJ6ZlyYeEZj9?=
 =?us-ascii?Q?ErFKBDjAdLm7S7aRl0/74ep2d9A5bNrS4sMLLgxXmS1rT107+hcvB83RKe1U?=
 =?us-ascii?Q?6Zs1XF2nxjLEm0gW2yvqYd+J/8uoKpQ3yetuTSMBY+qOp85GLeDuENtRMRMK?=
 =?us-ascii?Q?1Og0lBPmrc87tZiEPMdjG4lUIt9U9RSLRDFwN8wmARgdEih1kTP7uOO161Zr?=
 =?us-ascii?Q?nV2eMo3Us09aFMIZ4oi8jX1819Ibl1a4tMtoLIR/KXu36u2atMuW2SNHY+8r?=
 =?us-ascii?Q?MFEyUqD++0hxIwBDD7auvMiAENVwCTliqA8cfvvhgLXJ9uDL0AdXoXM3o2EE?=
 =?us-ascii?Q?1JrDqvyQyKg/beUCjGT9PvUE8h2KIol1ncyRwsfh1tappD3nsbxOOaXb7xih?=
 =?us-ascii?Q?JQfgeDtx1PwtfoZ1IDpt3pJDfqJdue+m5S8n6WLX9XKoNj7Z7gJp7lTxPSxo?=
 =?us-ascii?Q?7ZesH6pbXBNUKBMPJ9SItzmiNwXQe9neQnctjuFhXwQTvHxKcWRgiRwUknS4?=
 =?us-ascii?Q?CpKd+91silEUX0wdguQNXHIO7krzHaCb8lPFOzKJ3qkUbIIJp+hKCbw4Beti?=
 =?us-ascii?Q?15EQpLwnEwCeIR1ntvxxEsshGIfuRHiuBJwgcPw3j6viYF7iz+unOol3Yn1F?=
 =?us-ascii?Q?QbNp+rwPkZQAp9P1Na3IJPgSDde2H+O/fAgJ0aj4KSWZtqOA9AhTtteIXJQw?=
 =?us-ascii?Q?KUUHUKffgq5zXwTmPNU3h+FsZziXE64DuaJCUJMXxMfe115BChSr1PAbO0cz?=
 =?us-ascii?Q?fB86HYyOVApf8gonHECzLzL7h6eFhnYTXJS2E4bh6HvClYyFFJOnazSexQyT?=
 =?us-ascii?Q?Dbee8Ul4dFeZssPPTdZVphSGdQrYT9qQKzIJqylZXcNteL12Ld7D37oH46a7?=
 =?us-ascii?Q?iVnHWUHt7xGwbUaCeH33d2T3uvFjplSx/6Nf2IWQoslSzirDUkcp3sxQBXVD?=
 =?us-ascii?Q?ZNypc3aD1Z5xkHj0Za4dAVjJm2CU+VT2/Yh6U4X5xbtNC7DiSgXvp9LGG5sf?=
 =?us-ascii?Q?yvO/n+dmnW6uUKS9xWhvDID9Cv663EFbo231Q5JLJA2UP2MRdEUQxiFzdVKL?=
 =?us-ascii?Q?UmzdX354Sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85345859-cdc9-4c5c-ccf5-08df3995d941
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:33:07.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VDXRKgr82B+GIXHHfn2rSiUoG3aFix3WNzpeCS1VVA6eINZDL0rm6CUdV7kHItha2P59zpoatNaPXIZPjLl9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

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
first proposed calling the notifier earlier.

IRQs that in-kernel users leave requested are now freed after the chip
pointer is cleared, when gpiod_*() calls on the chip fail.

Reproduced with a test-only chip on the hierarchical irqchip: both races
warn in all 30 cycles; with this change, none does.

Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 35 +++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.c      | 28 +++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 50b1a77ef0f1..e6f1da943532 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1591,19 +1591,29 @@ static void linereq_free(struct linereq *lr)
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
 
@@ -1674,6 +1684,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1691,7 +1702,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1791,6 +1801,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1805,6 +1816,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1840,8 +1853,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1921,14 +1936,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
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
 
@@ -2102,6 +2121,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2837,5 +2857,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ec5f81f4fd9e..2aba76f79fd6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -851,11 +851,22 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
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
@@ -887,7 +898,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
-		gpiod_free_irqs(desc);
+		gpiod_free_irqs(gc, desc);
 }
 
 static void gpiodev_release(struct device *dev)
@@ -1422,7 +1433,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
-	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1431,6 +1441,14 @@ void gpiochip_remove(struct gpio_chip *gc)
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

