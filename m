Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273408;
	b=uCa8AXlZZaakFr10W7AKS3E0Y+pyWQH2FIuLwick7bvQAmDe1gCr1poFFcDaIlluqGHy
	 m+Y6FQpQ7LOZp6UFYbSM9cJ051THoG7rC/SwkVnv/lrHx1hhXAW1Ewh+0IeUCB/bzcXrl
	 oE4I9BfjdjaQk5HYCoXxPpsyE/THWC3K8hLQ+758Oc+0DMiL4pk3TEWQmd/N2Azo0tUAY
	 GaUgNt44JoUjkougZw2VWITkvVOTVOWxToX26vvhH8ItqnVw5m9euAGqfHEQFc8Q/zuKP
	 ums+vJiD3MKYyUJM3+ilj0AWN6o8YMzD2KtkDQojRLwZ8kUkrHuXChb2/N9kO+FjH6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273408;
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
	bh=yci6FavH0wl+5+Apdgk8p+hR5tUckwuRXsUE/muejAs=;
	b=GG/QvHZwnSVI/wDv7Q+3mPRZcFXruR+i7jzKmrfk2lEtshw+M8iSvIaRqIFn4cO7V7rb
	 j6ROrbCG4EQtqGsrsCOP0UkwuArelgGB1C6pdatqHezxjkNHNKmQ0JIeOqAtmW7IaRJDS
	 wR7yLAi11S1+Jm+aRR0pp70VTyZDGMdoGsqd4tj/0A1ranKZye7fGctuw1/ZBUVwHDra8
	 I1IerAbQsuIBja00uygGVbZx2ciYaBMDHkvIFXHyeYzGEokmrGQm2HNubOdfPP/1Ff1Lr
	 fvYVB7/qxkBWWb9IQ1jCGF/o1oNPqesKpwQlzaEx1zWmNR+h+OSq4PieBucCA2s1G9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KZLCaNBs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB1606A33C;
	Thu, 29 Oct 2026 11:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CB1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KZLCaNBs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P10yaFN2bbd+sJbRvcqxUCmTQETOwV79NHrj4jGRnY8nTzZWP1d4EUrsu3hZ2aOnmYygEL3F97OmsRNtl5R8sn9hZK2tVPxXSFBTV5sB+ALUL4t485TU54GqgGLNEfcTJelA2YkfV8eotzYf3EnXXrptMFYlNdZ9j59o30H1RZdq0ntFSca3Qy6QBhudicOtynzw95X3BrgB2bmEu6CefhKZ1/nC2qrV0n5Re3/1wIlLJrH1Fgb6riL+o0HJx41beRejtyDq1Bzo5w/7zSoFX1L1sueiXIptTntfOrOdeQnyTbUtnBpQa3dLHFltAYrYWo0Az2vtpbNfeUoVfHanBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yci6FavH0wl+5+Apdgk8p+hR5tUckwuRXsUE/muejAs=;
 b=iDikDJi1IWY4DIyt1VDkyl1LapE3q0MeniUKXRbv7p0kg4+2mr18XtSdbjTIh9qNla5kslMSoEcGOAIPwnOBKnWX/Vv7NAW10qYbTDG3zJkSVcewylQTlyc8hIvTqRc8L45SjqZmg/SCEOP1D5a/JD22YOml4Ct8NKnjjtFLDZeJqjFUNY2EKIdP9E0chRpNhX6o1Eu2cY2b0Z0zf6w6AAvsn3RgQmFSObAoIre0bIGU2TD3sFe96WIiPkjVnoMc3p+bipzFVngp5uCwPTtbYN6haaObfpIzcWTpKVlKnMv/UWQ92QWmaeiDmPzOEUXv2+LAl5rlGtxJup6Y1GdRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yci6FavH0wl+5+Apdgk8p+hR5tUckwuRXsUE/muejAs=;
 b=KZLCaNBsU8FVMX9eNShxRSBWt+DU1Qax1lrFKgTRyZBm++FQ2Mbkgt7UAYTxRcdFw0fEWQOZ1wY6NseUn4D+c8OVFjoHN0d8dFSRszDtScsuTaKDFMPWiRO8qwX0+ZTQzEzn+E+UnoPBldlDMcKHPARDcmxkX6Bjo3hrNne8cK3gfwWdor6Oz7rxWdJoaDZvlLdMfs+/vdTxoVLatuQDKeCYNogRS6lAQsz3TUUJ6aRG3K32iTV/lLOWKIDXkp8v6XfV0Mu/PWbDEa0QHy7qh0UGnjikZ4PLiH2UoS3FQubbi4rSdmZbk6pSZfdZCILMrCxWhnEh/jKMWJ0spb+WrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:54 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:54 +0000
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
Subject: [PATCH v4 7/7] gpiolib: let the character device free its IRQs first on chip removal
Date: Thu, 29 Oct 2026 13:29:22 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::13) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c4a016bb-023e-4474-b04a-08df35aff409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	42OyM486Q04+m9uQoHwek02rbQXWct0QWtrgioGWMfCf3a2EW2M90EkhO0A8yr5mSJBcl6sGShesWR71AALfI+fc/aB8rX72iMVtZ4cbrJ3Eo81yK5sCpyB7eyTCFkpzHYBizwy1iSv89mrYxGJx3eycP1vCN2HhMGIh5UYTfBTxZw44ca3gTXQCbApKG52hsegXCKa3QjgKurJzE5erw2w1rYba2sKjOC95gk53KJRZs310p16QtrxI0jCJVarfyUxcn1e+Gds+r7fFxgKJNDmDqYpfL5f6FrHD20uly+6PxiROyh6wgUjFUGcAmi7fNt8oFGU+A9Kj6pDID9AewghEWnh9M/ozx3J/T2G2B/32D2eiDSifG/NrJ80KQFNFLYM1APZ1j6+gvISKwFAPcJfP8jFwLwGeC+zk0Ee0Y5EfofCXZJzAJgKzS/5a1GLBCaB9QVnnP3L52+X5oqlhvLO1xXIkbUJ/G57FwFXNKAEtJsW+yhH90kSjDBcDV3mmovCIPHSB4IUaVMeyhkoPvcYiFRI3OeDNbA+OJ6GvMmHFK8swkABSimulKrekiHa4N2WnQQEOtBzr9eCL1gHiMMUO8Cf9m1l9f8KSm9fuA9CYx7hNycpUAIP+FgARa6LQKnpYV94FVAe2iT09pYDAEGQTC7xcpSOMB48Nb/YIu5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7YugUqjWWU2rkO1iSHVct4wdNZHkW6u01s9MHzBGrn1Ln3mpNDN0w973RKe4?=
 =?us-ascii?Q?t6jHxwo9LZoqWzQJNUZks3zAz90kXzJK3KYuSIE1d8Du3BQlyqAEnivztpRb?=
 =?us-ascii?Q?W9THcphM0MS3j4IBbaV+pbpg2FedXSxxEzgL2Ue2STfiP0X1MlCOdoLFa2QV?=
 =?us-ascii?Q?4c5bf2/inpwWI3CpEBxpxf9f+wu75ZsPvQzYRXsP6pyDUhq2tTE+WYywqvHq?=
 =?us-ascii?Q?6BxWZaEs+W0O7Hdz/4FyUTZFXN3sR34bCJmcmNpk04mo9WFWcVOad9jQzw7F?=
 =?us-ascii?Q?2GouV5onyV8pLJrV5FKhIy7OrucptihLi7VSTRbLGSUon/HCu0ecyHRMzR8i?=
 =?us-ascii?Q?2YFH++KE51QUYHEsRYBE9BpjriIV5+G1DCjhvDb/wC2/OHAiTZIJyUOJFMO6?=
 =?us-ascii?Q?vL5JuyC2HGEpGBhmiX4fll+A0Ap9z8pUsLYOn57+hhVAOiWRSw28C6tZlNwV?=
 =?us-ascii?Q?r+mXOQjd0IokqKDhhKL2/M3vnuIcJY0McrOPHHe1qOiYYY+UNOcYLCD8+bbP?=
 =?us-ascii?Q?DK32xC+OJkufiscP5RGCYhNGzsTe+1ponTWxidtKxAbH+5kibdzlSEyoogxd?=
 =?us-ascii?Q?vCWw7R/SJ9SgyJXP9MZLHrUlNCb+ak9X+ry+Qt/wXQgSqgztdg8mHbKQHIRi?=
 =?us-ascii?Q?Z269kD7BzhwHCMn2Yqch4H4RFMXOrYv7uWV9T/35fQBvbjc8JCi3zKT4I+ah?=
 =?us-ascii?Q?pYToHTJxxGuL7Q0zBAr0H1mRmaEII6+w4JK6r2kp+y7fbbRYjkxjF7qNJKxJ?=
 =?us-ascii?Q?iMAwEB2pIUcgQWn4UYpOn+qslG2JWR2XP6ztqlZnLZj0Jb2fIxpC46ZJQBeE?=
 =?us-ascii?Q?hlbzQsL3uYiXwUH2O2HtDFcGyN5tgEF87se6z43PBrR6UGdMLCDeidaCrR0j?=
 =?us-ascii?Q?sEJX69Uw0iPWIlbuTeeh5w7zYCQ+bNVmNtG4aU8BpqQeIs3MlxarTO01dKSZ?=
 =?us-ascii?Q?KCctICDNxle3IMd62SvJQON+mQYCAG2xUGOYfiOGZokpt873P9XxiAid8j0A?=
 =?us-ascii?Q?bFByTeYPbDeNGlDJr+PQVdbwaR7wzTw+17ojX00B/ZGIcFtj3bSYyxGEtNg2?=
 =?us-ascii?Q?8S7gXPifsqiZ6bYNE7D1UjK8UhBZ+Uoh0o5WCQYcWtzWwq7T8lUKq1tBzU80?=
 =?us-ascii?Q?vMDksTSq6KnsoYQPjE7nuXaI85LGIDouwovucXZQyRMG4RAHfaH5/QcSImyV?=
 =?us-ascii?Q?CTiQvvu7OpNmDbtw8WYRThj27NxhzqJ6iHdAWTZBfmA/pCgko2TWBlAItF/G?=
 =?us-ascii?Q?nGPqNNlO8k6s0huf9/98DW9hd5LBkZafHa63odw2ePPiIXmY07l85fUeotW2?=
 =?us-ascii?Q?3mdYDe+IFh0zORPhCPA9ZEg4ycR+P49aL+vua7wc2j2zs4mRc+Vf450XWGEC?=
 =?us-ascii?Q?FFAFgondIirKGjldGXxe+CXEc/GjqKZx3XScJMwXT3iv02qXUa1F5AfW/10Z?=
 =?us-ascii?Q?jv4sk0rL+X1XZ40WuVss3flGm3Sp5+iC3RaTEZBLosJ89zpcBcIVk8krMXwB?=
 =?us-ascii?Q?QTONt73Rk9+0x2DBP0wLUw8U6fFRnQbETzFRaZUgO94WqUXNDRWY8GqXs4Y9?=
 =?us-ascii?Q?UC1iaAw5e+dJygtnmfIB2r/lBnUYl1upeoT19VgGL+XFsm/Ie8YXU+/dvq/i?=
 =?us-ascii?Q?7A3ebdRgmtr9xIxRTD4noUtCFnjyaDuzTNCggZZMfr2JsCYDEg1l6M6S+xy/?=
 =?us-ascii?Q?2h510ftm6GoIgk0QV9s15T2574scUu9hEgqIPltuuqCpmJbYae2AjKXOmgbr?=
 =?us-ascii?Q?9ovlfnvbgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a016bb-023e-4474-b04a-08df35aff409
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:54.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2a955k5FxcisBx8RZXONjjzIb4Lj9Bp4wTzufW4rSINAPHRMhLL7APrfvg+RhtP69mqgXABXq2QNYUcyF928w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

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
index 0d6853751e6e..ed00bd3205ac 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1589,19 +1589,29 @@ static void linereq_free(struct linereq *lr)
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
 
@@ -1672,6 +1682,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1689,7 +1700,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1789,6 +1799,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1803,6 +1814,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1838,8 +1851,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1919,14 +1934,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
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
 
@@ -2100,6 +2119,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2835,5 +2855,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 49b2823dab0c..673265c9d95c 100644
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

