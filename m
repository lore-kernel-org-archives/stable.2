Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501251;
	b=vCxPc4kgc5daH8DHtd9ds5pBEZjR+HF27yE/XFV2eWqrJp3Nr+u5923FLFfhq7TJR2q9
	 gMfs3H7nmzYKot8FqgjyMxJ2TWNW3/s7xJSBjUzPHtcr9iGlRLr5oNFGJvmtoAwCueXNi
	 ksOYtZ3gwgrcsq7kVGskByNeSsFAnhhOQLlXCSlDkFtKc6BwRt+PvUntquQsv1o5rsKhh
	 0ZSCn+cSeMB7g4WKEnh6y+aM/k3g1aoJxJai45YIPY1kRjDtm7jxYQVFRbX/cBoVkHDi2
	 qFNod4VSkialAH54Y99CMd0U3Bsbzor3ZGIMIiIvIIxGt+o1Tcm+kAsIDwiZaJ9Hrsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501251;
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
	bh=YQHbMpgxaeDkcPsJY6V5PgT/F2b5oBArBNUVHHsELkQ=;
	b=CYaLbRAz+kfQTMZE/tNDdycnB36zsVbCZ17rEJBYeCFtBTsErQ+2le6zWOAh26LolT93
	 CduPqYMLiSSmeZK8KDPnrULN/NkdAHDdUu1tSYiTxqqxJHAv+7FcXLFRVIj5jjHsPgWm1
	 de/+2B/5QU3PjJsSmlnAc+QJ2gchCcA5mYLZjcDCaXQwvBoVH2vSLrTePzCt9+Q8c/aqC
	 khsl6LC4eGtNTw0IS04Ty/1OHB5QXWnrnoH7wZpjIBcvmfgerosw4deINGRu5zoyU728c
	 D0pGz7Y+UpD5A0dAXS5EUM5vjdg5CBS4l1XaD9Zfedi1qkJXucTkcrL2YHDiqSbMP9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hTVXxztG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.51
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E3606A33C;
	Tue, 20 Oct 2026 13:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 933E3606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hTVXxztG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU4jG4OpySoQnRaN/YjSbHFwprF5WTMW3btU5ICer+bflejLALAe6SGYxSjMasYO65A6qrGAffVw9i0n+M4qCbAoFyJSFTI9BCp4SvqKLB04OK6bsv0BrOJD2w7ZiF/J516M6lZ9mq9z2kBcOF8JR16MF6tiSgQ52tp+JZazVQeJ7TVAs0kLxvyhockslcEIFJWDrYLfnS0riuD2r4HiMbDIiigqhshu33s/nR33m5ZyTkobJxnVsSNC7KmDBgA6snVg1Xuf4lAp6nczrgDDTElMoKVc97r5BS94AlHx17qXJBl5BeNWW51dqaaXi2vxBj0DktBYCC4JIPY8S4nGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQHbMpgxaeDkcPsJY6V5PgT/F2b5oBArBNUVHHsELkQ=;
 b=sszLsJmW6wVIkgA4zR+YsWTGT1itL5X9kqBJB+oy8INpIHGsdprCPsLEHY6YPFem66JPBTDdbMS5Y37eMPq1izjhPiMx+HdKHtsriXB3SlPAC9CsymO7wdpeHHn5WqWtBolIDk2eueyZhO38CG+dsnCgiLdWkNkO/Hqcwrp++taQi6S5jE6P4aVyoYtWQLR6+TNdsXud5Q4PJi8NAxV9q5ahyBTbnnxh8fZ7WV25TnTrLgqSzvZRAsGO93OUY6fZkIFhYIVGKjjS8vKSkVvCcPFeFYGj3gC7LjdkABwouzpRJ34/5L69fLklDgM2WFZFj94Hr7IHgZbT8jrBA37HgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQHbMpgxaeDkcPsJY6V5PgT/F2b5oBArBNUVHHsELkQ=;
 b=hTVXxztGyzjFG1ifznlPYO85YWsnLzY/EXQThi9b+V3sxU+ozR5h2xikz9Rha6x/8fQIe3MK5tnQKlKV7iUVE/BIMjbt0DK8GV9ENaw9gXjIXKRQrFVKECX6o2/WMb0e8zdT5JlivHl1+1zv8DPmM9+Dfy+YFWI1u3fQwqbC8fInEO+opB7isgL2Ti6VtnAXdZdBy0g1x2T1xBCb20XLn1mqmGO0dE5wp1lxpBcJGSspTZpJ4EtvSJh0zyJKeYgyz5TMleVsXAJVpor8nNenUCkarsp3aKibpl/sGKE4L48MLr2H4DQ+Clr0BCG1B/6a6HEJHZoEthTa1FvrKFCp8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:00:46 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:00:46 +0000
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
Subject: [PATCH v3 2/6] gpiolib: free the label of lines released after their chip was removed
Date: Tue, 20 Oct 2026 16:00:24 +0300
Message-ID: <20261020-gpiolib-chip-removal-v3-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
References: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::14) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: b1200594-9545-4812-e15c-08df2eaa282f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uWZtf8saqikfyBM+w4viz6NhbpVvY/q0Eb6fLNrfcHqJIQCuXDCCgALF6GxtVq60fswNKLPHteYa1/NJpfw45OwPQ1dZ2PTN9rWQYt+oAIZ3zFp2OULLRhnntIpa5y4Ayv+Hl+n7g+EQis2ToR7OA7Lq6LZR8LRuENIoR/scaEbGG5EqBHs0CCUXtH9qSqGgYsZ5VGdfJYttOWbFXVNX3CRnyGhXBdwLjAwumncdDbH5q2g1ynTklRCz7cyfHwcdvlm80MJknLaXot1lyza09CAe5Tqfh58tLukPxBmdCBTKzJpZ9/zS8h1mwgXVybZyf/z5cldu7aF9xHnrWzM8oyXZxqdlKq8TAYv648nTPbn5qZvaZJcS9rqMTu229r9S+Gb6Fi5+tOJ+l7r3G3gWPgNJ9546jxMn+GEjw/cW4TMHdaDp5E/sbv/+ReRpqQQef/EhsHae7g2OpGlgB6T4RDZTT/SLySGSPXYSG8TIfL4rcXI7J9uubc4zMApJTV2wobK+fRJKBobm9Wyjd14SUp9TXPekMucXh4k/jGi0mku8n5cYlsJctS41ojKIfBSoosZZTrBs5DHZKkI3o9hhHVcpxfAY0v6Jlt5RAgInfCsvg1Opo9ixtsuJ3jnSyiqrfYWQOAda25s8KbGt7mxknwisokcKxZTBDp+fH0ZnDBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1DI/64xsZpDC4tmDuAdSx+hxLpgYofVsv1Jv3iJvi31/BYJI6zMjcw1WnEGZ?=
 =?us-ascii?Q?jfKnnLYMoskqqpQHw+fX9QbV09+taNLcJOHCyI+Run/3zcgF3nhhhAxJJmq7?=
 =?us-ascii?Q?09uHAz7UjN0u9CeH+Lz9RhqtG4eUcACFSSD7Lyc9kDB15E6MbXXg7m4vtWvP?=
 =?us-ascii?Q?W55YYpDHayFtml7N34Q2IzITxm3wZf9noYhCmQ+r8nNlfxkn7YQ21w21cKhR?=
 =?us-ascii?Q?MAJdTBCnIed1O4jmGuAsJE402xCEgF80A4BHQD6bXCgJwjW7hUp7UWA5dv95?=
 =?us-ascii?Q?ta9hN9PuVyhTdBo8O+budf1OYo8stvMzS1alvm8e7DVterH8ZVi34RHGn0YF?=
 =?us-ascii?Q?0AQZvf0mCeiNrRlTtFKJIFS1jTMzB5K3tNrcvzcwjk7tEQXKGI5kqrKYawWB?=
 =?us-ascii?Q?YBLRE0rcJNrFSnIcYdcJ4c1QHnMq4GhaKsbrW695XQij6EAlrDspwSmhC0lA?=
 =?us-ascii?Q?a2E4UjFhIpVlOYIOxOuW+FWbb8yDN1Z0QKthrGgpesmxjhEImarttvrIBaWk?=
 =?us-ascii?Q?SgxDBJRNb4/Il/x0iLMY6wyd7ZaNbecijE3IfmHBt+g+2W+QbcV5V9OmVcu7?=
 =?us-ascii?Q?tCSlZ3hYQoYcNBu313RsUepolTQjk+lVljY8lBXarvTCWitm8E+rAIbYg5Kf?=
 =?us-ascii?Q?DadQteV6dNF/0boF54E5926peVfagSseJ3wrvN4aebmMdXT/avttdT5CdfJQ?=
 =?us-ascii?Q?aYQeYm0QK02PtKFVZ2joQVeWH/B6I8sY38yGnKFwZSM31NpPxXKDc0l5Wtb5?=
 =?us-ascii?Q?k7eORDCLytk1GET0ar9kObuqsbWAYYjTLfoMJQzfFnAeT2AANz5If6fDR/jp?=
 =?us-ascii?Q?VkvhCEOnTQbSJEqXzn7WH/G24/DjG6twPnQQooF7n7F+3LbxxJOOAH2IAr6V?=
 =?us-ascii?Q?Tgv1Z3ITRZ1Dx1oKQoXS+vtEXwLzlZPL0yxjeupy6EWSrXHHjmwf3VG636yI?=
 =?us-ascii?Q?2RExaaS/c0lS/KSwD1x6BxeL4WfzENK73uudemj3yGl4suabyDeoTF8p8JzQ?=
 =?us-ascii?Q?04VD3pMl9shXvlThyJ/dOLKVAJ1iQCnRqBcwkO1EHr7vcpfuyLjQnY+EO5GQ?=
 =?us-ascii?Q?Qu+/1zIe993iT39HLr73fNpblhfbFsL0uoy+7XLeq/oJe1mXWAuAlN3UHwbP?=
 =?us-ascii?Q?2CewvQVhQ5zUB6GYLOpNw6xdzxSLD7Q2CCI7WhjPvCS13B8iMeYeJP+Svkue?=
 =?us-ascii?Q?nCAlQmVCckZcyx5/MhcFjoor+9EQwIkYhlAC5Hs65LL5d+SpDwCFzdUKLmwl?=
 =?us-ascii?Q?1uZV449+xdkUOv+oWLPTrAfUUm2Aoe65WFkNJFNKx+HPYYXGe04zQ58WLAeI?=
 =?us-ascii?Q?3QvmCIgB807aGWcce9UW4jfkRrizAO1qVNkeDG4xhOru8n5Oib+GFXHB6kTB?=
 =?us-ascii?Q?Wt4aKcgpozmpIdOEWVPJPiE07C540qhn/QpxQOQ73hmyi0qmDZZMCmwWXGNe?=
 =?us-ascii?Q?JXxAjoYVmi9Y6dZuvcInWhnnw/CQkfA4ZB2Jj+wIL3VcLCfM2pOBaIrAw3c3?=
 =?us-ascii?Q?7+Ob7trwQmb9MpxWLkCQhE/e0gjlFtdpgu5A98kT4WPBKcFrMabld4Z4pMAV?=
 =?us-ascii?Q?IbjGVI5aqUlGSejguUrgx+JD7vZgZkN4PY73EUKbsBhxvGZJyYwJQ2Vee+BM?=
 =?us-ascii?Q?habDN1ger4eACK69ufVSSDuIF+/3tFpK4kCXm+rWPazh2T3Yv7vaT/lpi/m/?=
 =?us-ascii?Q?SrtdZ+flc3WjxDIonYBAP3EyNVvgWcjq3+KrU/S7WMeJ6a9H5UA3HtbNlNd1?=
 =?us-ascii?Q?jE2sSHUKUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1200594-9545-4812-e15c-08df2eaa282f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:00:46.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzK9qS9Lkw7px/0hlIpDjQUnIP0OA4PnrqGA/tzQV4ztcilm6K5S7e9HNCWtevQV1x2UqUsFHPXxKomrkc4B4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

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
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5326c472a54..e923512febf1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2666,7 +2666,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
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
 
@@ -2685,7 +2690,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		WRITE_ONCE(desc->flags, flags);
 #ifdef CONFIG_GPIO_CDEV
 		WRITE_ONCE(desc->debounce_period_us, 0);
-- 
2.43.0

