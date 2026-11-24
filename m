Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512080;
	b=q33eRoQh22OsxYSiBdalFRDplW81E45S5SnrcO/pu6QeUZr6bt5AjCv6tp/GGI6IOQ7l
	 Z1w9jhLSmRvxwTQJMY29XlvGp/2AB+Bp1vw6EWsVpg+WxVbkqCWutJ5Wsc02M+CePkK0a
	 wHn/ApigN3+g9LuoEnK4Y8hfYYA6E6JHDVwS8TKf29H8EreliA7zVxLqG8j07QT0mrKnr
	 GyeSPeIRluroIHZGg5fCpA6StqD82imt8M07V/ZBmV8JtQF7zmcM1zgtuacoQTjkJ0aAp
	 J3dBXb2XW4tLv/v/7dHwpfJlNpg9Kg7DG9wNoDcPhPRMz5aYruvhfcZU5VioQfLK5Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512080;
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
	bh=2j8L2zRBSJ1CYa45it2ANAkhvL5pY6D6F+PM6DZDi1o=;
	b=1n3sGeSSClNs8bBVwLmFDzHJCPMSy/Fm1WwOjlIlp1MhDN+dZMZWVhCdz9uNP0msVzWC
	 G2rIG0LH6pP7AzZV5NQAzWoFXGDn/hffg4HQV9448hEyUTNfZagTE/NXEwobP6G3tc0OE
	 f81uVe0Z+EWXfLWIUZb6aHdatVJkW7bQzA4zc4A0wNxLx5SnSiftpR/yDBZJfMe1bwLw1
	 Pe+v3JpYzDZpAkP14BSyS/jqz7S1yJjiUb8bqgNNA6VE9KSbcRCYIkjKynFqMTj1Bd0no
	 I7cqGUWVjxCqInIqIUthcElY949F+Q84ciyZUV/vanfKjUBBp4htUIleF3/amSzzeZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rnbRif3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC64606A68D;
	Tue, 24 Nov 2026 09:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC64606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rnbRif3m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW39BIRoVwJpZL79x/OSsWupbz7dsFrOLn5xzJNx+hR5StUXGtrRsZx5wZbK4eXYgI8dqN/Yf3pbLJlL/1cuCPqmuC0+Pp3M/LK2m7eLDytCZqPaF0/KZDZ1E474nqcEUuMRlgdMQOS8rDue6F//vjYCOzGsZy1ixz/v6o92msMpps7ERdarmvQMOS7pAJNDvr+6A2bRsXpPtxUkSHnysU3A7eGvzB6K69bJE/bynX/BfhVO/5B4w2G/dvLebldHWIr1+KNz4w6z0+EkrX74rKGF9V5/6z93GtboZZLKMKfb3u+lhz+NR1Z4fekRUUsFkiFQP3jIueJYmOLLcErB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j8L2zRBSJ1CYa45it2ANAkhvL5pY6D6F+PM6DZDi1o=;
 b=zKx4/V3VSVZpX8hgAG+BKWwjhRDInzWb+KpX+ivkwMloMj9VuQ5LQsLbbPnThV+28QxwzyB3jt9Ps42SaWD7c/LdgvAcm6oz1swyg2BF7RACfc2QaBD2tFzyrk/jVuUpr5Zzy50LOcjuA1Mc1Zln8/xod7S3cgoOCP8n8n+u6zEMdnP0x5T4oxw6xTpS1ahHh2XpIPgMV8+XVNXcJ+aTcoedWsFCEP/ftsDIWCwpwRGD3jgxux1pCDazF4+1GlrpK9PjQIEeK82w8njeqOmLhrI5/8q06PVWwCjl02UTuYdGfpTmup3ehxToNE1Ts5slVmmUEO3BSoOna9StemmqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j8L2zRBSJ1CYa45it2ANAkhvL5pY6D6F+PM6DZDi1o=;
 b=rnbRif3mcZmkNWdfEXsLoBI3EwfXIflJCkslWr6ZkPuqATbMMzCLDeACJYQ+Uaom7rgEG6EBIj0N9bgnX6gyEoSiS2tPx5hKrnRsoqCMzv/lWunfXQnYkQSgoUEebbiooC+JUi+TjNm6ppFN4IFpckiDUWqPbHFdGS4aaHWE+5lXeJvGWjZev329QBZyHGP39+FoOVilasfsHQevuGtVOnMZgqi6ckkejUW+IsP+4xdFr8fmDEX5KWj+zG1NCICnjYwP+ld05lVh++f+ytaldB6I1XZEDj5ir4k1ty87XGApjCmTGY82cwZqTtGusE9o3fb29T/BSNj6e5KNWXmn6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA3PR12MB870191.namprd12.prod.outlook.com (2603:10b6:208:712::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:21:10 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:21:10 +0000
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
Subject: [PATCH v8 7/8] gpiolib: let the character device free its IRQs first on chip removal
Date: Tue, 24 Nov 2026 11:20:38 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA3PR12MB870191:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8d342d-07a9-460b-b43b-08df4a0c46ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102130727099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jmBKgdtC1MmtmfhkrkYJZaSA/Z5wthtHS+v8VBcTwULGVtu4wmvHXvL52dISNkiYLj++GdY46Un1MwzKMx7VJS0kn7kLYmAyWGvWriQ+fp6+GWUKByuxlDeLId06WbkeXY41/im+huJ80YoRfzZGtH9slfspW8McUoJE6zqkOLnmqMyYx2V7MNtjBMYE/HdaNzYvz0uUxc+NRGe0lcJDDR/CsPzq9bXPV5mGMqh3Yj0GcplsS6s0k3s1TDuWdsQPlW/ziSG+ib0bY71YJVS/mboG9JmmgkvIUexKvF3bQTL2q4bHgKJwC+GQJ6f9hAvXo0EXLyrXX5UpBPfxDtXgilMrRgrgfFnUd8Uqi+nSw3Jp5qrboj5N9FNxOs3lTpepWqA6epAv6VzSWi+U244BcU9eHS4E0WyinrD9LznJVIg6PhaeXwii0N+aPO/ylEYOHhiNnbDC368mLkPwI8ks4Ye9opOyF1XypKjcKxJVqeAMXeZj6wNtktTQluxnkN/hhUf6rMalvhrmlW+vlmOLy5KQIP4rv47aSDZlT2NjXQtTL1envEZBPT31uBmHTNcfeK9IzwNK7uCpCfMkxqkGrMHWrr8t6mo4YHcOnuxpJKWOGcx4bzM+08y5SC1cTVhMxb2vpu8Yt3S4Xn6oJZwFcVP4uTx3DpG6el+V8qHddj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102130727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5wyOtJ6LleLObPrAXiA2//Yyhpd6Kc05XmdocL524dFDScDlTD2WQqGWewP?=
 =?us-ascii?Q?co/PmWPWUxI8XSs8r2HyGsPlVFqTVnMFCbHHe3Ne7SjMypqtGUYB1GgZLpS+?=
 =?us-ascii?Q?KOJB0s32g9rgR2rrZmNFTaMR5wKvZq2YQyNHV4tKuv3UzvKuC4r6+xJUrRGQ?=
 =?us-ascii?Q?ecjEMB8IS0GQ7C9V1rQOmWTL6bfKIqVMf4hNja1FvTeV62uQ3lqOjIbFrhU3?=
 =?us-ascii?Q?RpDkSTuGh54M74hBQXg/MSbmVVRC6JJh9lFItXXdQOz4/kU9fjodBkvHKfxX?=
 =?us-ascii?Q?RBT1TaVmEwEJXIY1mwB8oM410xPcdCSVBMBOWyuzRrNasmrg8TPXIxY6GJGf?=
 =?us-ascii?Q?AifLM/9Wx3c4+I943UvMIzWNP4zEK5fVrtvBzDbLIqangtkCj5DRC6kmUq8u?=
 =?us-ascii?Q?6d3zI+b33md4UL6rOP6fAhYjy3Xlzs0wwi5PvfdxhIY/ujzza/p7Edz6bcmn?=
 =?us-ascii?Q?1a+YfNvQotNDjQTufWuTV5cTaTrGQuryK84Jn9ZxHqEQLJ6tHnGCh7dOjMoa?=
 =?us-ascii?Q?BrkMtWKoL6Hy8Oki1uUyZQXT/IhPnd0748B+HT13FXVZOtjN23f/fXOvO9uJ?=
 =?us-ascii?Q?Lyu/PPZN75I7gOBVidSOUDmDe232mD4B+3822xoTZcbxJfUpJcLlND3Z1kYw?=
 =?us-ascii?Q?Jurbso4T8nmoCHMwNMxbVTygUAO1oXD8vQC9mb69uLgPVg/nRL+MKbDJVGFc?=
 =?us-ascii?Q?H1iRYBmIl4KXZkmfTraV2kJ0fYlQIi7NlI0mv347VYnZzBtrkK47PzTH6HZr?=
 =?us-ascii?Q?ndJfaO75WV0EkDOatimcJ9qWv8poExOaPZ8kSr9xHRFCu6vTmSEFe0WWIozi?=
 =?us-ascii?Q?TbXLNv/t4a44MnhduqHJtR/l4ExNMqur5gKXSgXzB7UQnbZfTeRMB48hkqMf?=
 =?us-ascii?Q?2DWwGpFmA5PXjDHe02y+0VSxY9VVlKSg5xacxbSBwg9Kr8GOtyUAJCE++dib?=
 =?us-ascii?Q?Cv5j3ddx1tm8hg9PkqWzyxwpKdgdDInGRS6Sn1mBLcQSHDLuI+gSq7SKp6rF?=
 =?us-ascii?Q?LQDx5LizmLzB/6dWYRj1Arut1jrH8wtK6WkIvjyf8GAb6rjq7ep8lnPdGbbZ?=
 =?us-ascii?Q?U6PdR4vH+fQoyBF/o3Mv3buSjnFwr/unZ6M5MNgsiPeYOyVeX+hqk2meFgQW?=
 =?us-ascii?Q?j/ZR4TJwQa05w66uZNziTAdSEDaFvcYWMEV4v1sOOMI6CRIyp90qj8M/DUrX?=
 =?us-ascii?Q?FVFcfloeKtJ0LcukN7wEBvfG/TF8LDjrmtgd2dM9bI1lcYJXvL7LxpivHc2O?=
 =?us-ascii?Q?9L857rRrTRXxc3/4JyV1yTDKk8HDZEW6aM8yWvFv2ucZ0LIApYUquJE32/ql?=
 =?us-ascii?Q?d7HWwNcRwpCx0Kxiag7gj2gRpBEeL2bJZu9R41bGgtl3tAyTcNp79+LUC21a?=
 =?us-ascii?Q?fa2pf25lwYa0N0L+Fsd2UIq9xcoC8q0Pohh/03gL/0Vvqd4iW2ZX1hsXE9yl?=
 =?us-ascii?Q?hk5EMRJUzTBoRghIf+JKYgH8sQKAzZrlGjjX8tndar1wu4r6zHZiE/8ZsTmF?=
 =?us-ascii?Q?RZBreVbX/cjTyOAve+CavWE31ULBrfLBBYz//X12La9o/eth1LQ8jgZvCMoo?=
 =?us-ascii?Q?VpNQTWriKs+Gi01QNoX3fhD65TRPp5RkrzkO+6P9CFwdElAkV1GvAruJyDc1?=
 =?us-ascii?Q?N7ph0JMkCTaK48OFX+oH5Q6+nr8t7kVp48bN6LKtzab7tbG7S1UDku8DE2oB?=
 =?us-ascii?Q?g0W99DqyvNQTQKYa2s1mmKKY8Ipw9VcjOypseYkK0+HNmEdVnmD8XXjbqj+E?=
 =?us-ascii?Q?/lxEnQHLiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d342d-07a9-460b-b43b-08df4a0c46ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:21:10.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98c21I8MW4iSk9jl1QBr8dGjOE+TyBo7VSeZjw/hHMkdLk4qxcBRmn1+zim9Ee4dZpcTU/EucjLMzJcpvtbARA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB870191

gpiochip_remove() force-frees the remaining IRQs, removes the irqchip,
and only then calls the notifier on which the character device frees
its IRQs. It may then free an IRQ it no longer owns, after its mapping
was disposed of and the number reused, or from a release racing
gpiod_free_irqs() and gpiochip_irqchip_remove(). free_irq() then warns
"Trying to free already-free IRQ" or uses a disposed descriptor.

Herve Codina first proposed calling the notifier earlier [1]. Call it
after the chip pointer is cleared and SRCU synchronized, when no ioctl
can request IRQs, then free the rest. The release paths now free their
IRQs before unregistering, under the lock the callback takes
(config_mutex, or a new mutex for v1 line events). Initialise
config_mutex on allocation: linereq_free() takes it, also on
linereq_create()'s error returns.

IRQs left requested by in-kernel users are now freed after the chip
pointer is cleared, when gpiod_*() calls fail.

Reproduced with a test chip on the hierarchical irqchip: both races
warned in 30 of 30 cycles; with this change, none.

This patch depends on patches 3 and 5 of this series.

Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/ [1]
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 37 ++++++++++++++++++++++++++-----------
 drivers/gpio/gpiolib.c      | 28 +++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d829f7d00b5e..ceecce572a52 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1590,19 +1590,25 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
+	/*
+	 * Stop edge detection while still registered for the notification, so
+	 * that gpiochip_remove() does not get past it until the IRQs are freed.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (i = 0; i < lr->num_lines; i++)
+			edge_detector_stop(&lr->lines[i]);
+	}
+
 	if (lr->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
 						   &lr->device_unregistered_nb);
 
-	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
-			gpiod_free(lr->lines[i].desc);
-		}
-	}
+	for (i = 0; i < lr->num_lines; i++)
+		gpiod_free(lr->lines[i].desc);
 	kfifo_free(&lr->events);
 	kfree(lr->label);
 	gpio_device_put(lr->gdev);
+	mutex_destroy(&lr->config_mutex);
 	kvfree(lr);
 }
 
@@ -1673,6 +1679,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1690,7 +1697,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1790,6 +1796,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1804,6 +1811,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1839,8 +1848,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1920,14 +1931,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
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
 
@@ -2101,6 +2116,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2836,5 +2852,4 @@ int gpiolib_cdev_register(struct gpio_chip *gc, dev_t devt)
 void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9832f755312f..e0ba17a73c4b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -854,11 +854,22 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
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
@@ -890,7 +901,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
-		gpiod_free_irqs(desc);
+		gpiod_free_irqs(gc, desc);
 }
 
 static void gpiodev_release(struct device *dev)
@@ -1439,7 +1450,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
-	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1448,6 +1458,14 @@ void gpiochip_remove(struct gpio_chip *gc)
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

