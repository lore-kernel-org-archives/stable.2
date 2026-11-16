Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836855;
	b=A3JMzl54A8iryWJODJKpxrmYYXDkplkE+PXSWMr3d+hRHzHe3aMv4mXqKv2jyU4foS6X
	 8I/JBZu2KYO4YINVytmndfWbk2PWZRbj/CRS+/wJKfMGxzDFaWIG1MuNOZBgNTL/rmTXj
	 f4LhtOH7Md1WZNwoCl95BOAxN7pERJ/HdHPbch6Mk/0x11+44lrFlyns+Li3i75F3zYXX
	 U5b2/A8roHZ6H7N87SGw69Qu5nJveLRj4RKQ0DJ6i7DxzNqjPDM/J6N7WHwwUcRvL85AN
	 75TB9yo4jfb6kuijvdR5tp2y7DzJrXHi7QdqMlMxl4qK1k/Wa4YrAMuOrejUczLGx9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836855;
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
	bh=3SYHClRTRnjni2DfqNgBNtw2tWdRN/K7Yb4LzWDqZNk=;
	b=0yuRwCASxMXJa7d0iEx9BrQGTwmWHEYmpMjAM77y4WutTPK4eedfcVYS4dYudo91Rghk
	 5hSMRukYEVwKT5nwr/jHy/uuhCBGC0ZgBjPZ4Y6DfLBAS9Z+wnxuKpaEe3rMx/60Srbjr
	 iRgBHHUSWydxYUfXv8Sry9+cyfRg0YDR8Dk6ZYzOjxnqSGei5GYu3QSRr/Mvd2Ncyl3HD
	 FHNBwWe/Gad093w8fE5mAneeEnOKvsBs92HWiokiyBhxpX0Qjfg/6rYXK+BUb46al+0Tp
	 LDEINy2n5bNqxuSjdOu6OOcOj+GHmQW4opxwsrFPdfXR3i8iB42z6OZgxlIyCS+HmKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eLSUFuuP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD5606A898;
	Mon, 16 Nov 2026 13:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FD5606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eLSUFuuP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUpExUjOqkv2z0anRADfnVZDZTBz3UNhzv3/T47n8vdoUTmjKgzSg9PZqT4YJDo2lXNEY7Zh4i3mvVz2lt3KtEinAgupcAR2RZw1SlTGvtueftbzZreY5ZGlXCDnfAuNRujGrUtM41fe+ZnvpnZSs1evU1cW7N9t/oN9aXQ9biM5KQngY9iDcQdIydRByDBFLF932IHOej9QuzrA4fE5taUuGoiJqr+8O8aGzzLBDCUj5+reKKNYLSXSqq33uyB7Nb5TCSVfqH7qeg4Jax3tkNkQrogR5DH03YUcdfMpw7Tcmjszm0YLsCg1WE9hDFJTMXJiXI3L1rv5DrCb0dIbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SYHClRTRnjni2DfqNgBNtw2tWdRN/K7Yb4LzWDqZNk=;
 b=mmkPY0yLfc0jxItTAg7D38UiBhtCGeyj7EMGM7Z048jZXyDgjOYwqXZr3tBTNLZnutQw4Qj9q30R9lz+GzM2sn8I5Il20LFi/dh9Qdu0R/KB6AcfE3jjrzEB6ARNnTTQw0yiyED9OgnUMjl26Vlez7aThjuHLDQArJ3QIkwBDLxsHQgv2lGeP8dryjkF+AOjywGIrmJeJRXI525QQ0qJNbBeMNTnSaualqBwtIQBLE/Q+fnUAOuaLSOi8DftQUCFVF4gq9mIbV2IUiyU5PL00W3qe6EnlGZqdPi2/pglS6kgKnWBtD5Pz7UgLAEo4KrGVowhoifrZe0Wtwy2tMTSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SYHClRTRnjni2DfqNgBNtw2tWdRN/K7Yb4LzWDqZNk=;
 b=eLSUFuuPjoPdRRI9/1k4QadVCd26kniwh1v83ZEOQ9KQOJEPFuatCxAYyVgigiqrOPTPiWDjwQx+Z6h2KeihEbq5X5olrQns/iKEpk+dDN1CGVqw5QaN27vefSmdr6IVuYxp6Cla4kZLy5KLgfoBQNfVv9rctiGe5ZZEZ5r55Xyg5dC1n9z8fHeGRIGW8g8ClGD3Hhj8jpkJ2L/fPveE/Lp9250ShxJ9TW3VZH5RKjPxlik+DMy8Q7daEpkHyl8LfEXsT626BYAmCaSsmPxBkchXdsKARHtMel7jpvIR8uI3ONgjDSmuckYi+MaEvUtgLzU7lcAGm54MK5wKmbDEqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:23 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:23 +0000
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
Subject: [PATCH v6 3/8] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Mon, 16 Nov 2026 15:47:06 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0f3c1759-09bd-4e2f-f669-08df43e82420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|11063799006|5023799004|261026121527099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|18002099003|6133799003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	N7TRFH3co2On90rfjnJFHkUHFoBl3EYaWhOTf/ZXrP3PsGWfNn6iE9j5CHHNf7fYskeE8ZnuQmSE6BY9BBJw/ItZP4mTGBs9EjiXulwyCu1dhs8j6CWxEDUY+GwxDuk5FGkInvp7mqyI7vx+bb29vSd+SIpvrRvT7XB/OrGq2y/nd3k5vJ311KzG1fC5s+UAypor93COXg3UyqKxg65mbPHs4SwQA3QuchoSsVfHTbPGW95b1YniSO6UdfBgoIV1ycvBnbcqvQEIajeYVgtcm/GuznPuMnP/a4vZNvB/MRITgtr5f15qoyKP+QuOM7T7Z5k+0skBlWKOZNz6NxZ8fV/uU1Zqym7PWuwhCNdR4BIHg9roWTMy2Vo3efieuBsF7iQf9Ju8mSxOL6B3fH5DbpCW8OoXSW9mDNg2E8j0uOpjA2GRtYORH/gmtZelNL6lw5Dr+P7fAoNBYfOLkzfpJKKhiy626mnDhrB+NQl53H2mHBRKwSvhd5SBywvIuyrPcJU4XF3A9NgHngQZ/Bw3iIo3wmcsW/BTaK0Mu+FwV1dgRCPUoxxpxiOr5QbySGEv7AawvtfvSVARECOaOcQOvDCxxkkeqyNoxMw1XP3TniCjQsQmTbtwlP7Xe1FNKkgu4RiasGbxcmqfJjQAatUe9pvGKMCm+/tVT3VQHxKp07s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(11063799006)(5023799004)(261026121527099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z/fNGs9Ly90qaKuJdAdwxQXGtVzKhYRFkiDmx1qxxHz/wBw9XMFeoho+aYP9?=
 =?us-ascii?Q?wjtj7+SOTYTMYtzDsQi/tcB5wKxOV79u0C5Lcmvd93fn1oZV4kYdf03wZuY8?=
 =?us-ascii?Q?SQsP2AsXhnFBGhF5b304XMdqXJ8T7BWL/eO0Uh01GfRSrvdmHGNUD9NS+E7z?=
 =?us-ascii?Q?hp+We2nVyTNUBpGqNqWrvsMOuaVXo0YV/d5DeRG0ZsgV9/ooxcIQz4E9Dqrw?=
 =?us-ascii?Q?Ekh75n24ziF11g5EhpYdicAVJ70MkB3iPzGmDvqirRaDP/pB3nDi0zsTuX2i?=
 =?us-ascii?Q?d75c9Owg5szUUQ1EEAML0Tc9GuPThyXDOmMPgryxNg9VpZtDWx6k1giGQIJF?=
 =?us-ascii?Q?qReescW9Kd2dZpaTuaj/cdGXOyLKRFiyPm7zTDzKsloTZHdWhCqgoI74yi+6?=
 =?us-ascii?Q?AKBo7k+Gf57aZGIRvQCjcyQvkZqqPuaGUhL51dYmHOi8OVfVQdhf5naZm8C+?=
 =?us-ascii?Q?e6WN7Rrfl0h4X0dUX5k9qmvFGUNHlT1hAzwmtHe24E8Af2eo2Y6YjvZhwOAR?=
 =?us-ascii?Q?FtfqEdyzq19AkL5qI/vd9hT/NrSqb6qBc+f7yfgblClT0pHMcrK78KUuACuW?=
 =?us-ascii?Q?pIU4LvX2orWv5w7XpB/lB/p5vOlx6ox+phXyscpBqHVJvuTTq/o0bzaCaLiW?=
 =?us-ascii?Q?5uulnuTdE2L+jU37V5kTXMAcWj4ZDSPU1hGMSLbyOyQ81Dtp48gCWY4ZilLI?=
 =?us-ascii?Q?KHjcthnt/uRFyWwWERNZB05cVPQIc1NT+iB6khhneoTyvzKf5/u0QLB7kjJn?=
 =?us-ascii?Q?GDUlF7yV4dqSUAYuiwztT0V663Y3jtklzAlfDMkgmHBD738BEhjM6iKLoM0S?=
 =?us-ascii?Q?poaKqZxEAljYiMZ+C2z3zMZe5WmTligxPBn8OklbR484xTs6MQHg0ElJT5dB?=
 =?us-ascii?Q?WwsjlxQn1poT/GYELxUS/4kbUfM1oNJUppTKYaa56WsqyYHbxq5zcM37oS09?=
 =?us-ascii?Q?BUI4B2hntZ0Xcgy1Tw2NeUaWtIaesD+IPvC7rN91GYdBdDpZLWd7l8DMQmaE?=
 =?us-ascii?Q?fFDjcG2d7WpkL05VeP4YePqYgJ0BVaulD2IwAW1HQMWK9U1wqrDbnHKLPf/S?=
 =?us-ascii?Q?W5biB7gcuEKnV9qZQGA5pWAlbq2++fOUKucZGA285I5ny+RhwcNEOz4Q7j5n?=
 =?us-ascii?Q?B3ta3WDNDsi+EamZ8KLyeUH4fX/RR5bCeXvx2paxPTy3L2kYgtRcxV0If2S9?=
 =?us-ascii?Q?+iSZpFlAsD2xKFd9e+ehIPqMkM6X5yh4R6jT8mwi+XuZrsUe9l0R/BCDqZlc?=
 =?us-ascii?Q?u/JHy3lxyto7K4FqacGz0imWdYHWIGYJpFaTktP1zpBqsG5yLaLn446nR4wa?=
 =?us-ascii?Q?yxJ26E2GK9fiaWVfXwq1Q5/xDP4weET2jJ9f0Jj8sykuvaeMo8vKYdv144zi?=
 =?us-ascii?Q?wPCegzVSW4xK8W5ZKwb3Fb8DCFD/EzWMNJn1+F9WRjOkLbP/G08Cpo+wpAtQ?=
 =?us-ascii?Q?I9nKhG/2Uh9Ifz3vygZ/UP4Jxcz6GgDTAt6dsGKiJu9SGRIKcMlt+wVCWrJU?=
 =?us-ascii?Q?rmjX89paeI2t/AhCG/ftwNYimDkaUlF/XFj7mCCEUfFyUqOJ+0+bIJD2KFrR?=
 =?us-ascii?Q?05eLJ9s9i5JCpeDWnyjb1epFY39fVzrc3wRnHI0FmOAY+jR69gw0CtvhMhbK?=
 =?us-ascii?Q?9mXXm8a4yuoG0wLtpJ+VEt221aOFm8CbqUMbUTcWSKBNBC/v6JcC6ErXdoWx?=
 =?us-ascii?Q?PGPwrt+sqiGO923wHAUZOYR1BwM4wZFo+Y3bOkkI9J8A5yLFy2tDfG+TyZXC?=
 =?us-ascii?Q?vBpL7rWTuQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3c1759-09bd-4e2f-f669-08df43e82420
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:22.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55gHxJBXqH/apltosvQat60pxDYi8yCOZtLeAQVLF++DcBg1f9NBSDcuXS4PIB6U/5GuszN5FopgIRekKF6acA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
when the chip is being removed"), gpiochip_remove() frees the IRQs
still installed on the chip's lines. A line request or v1 line event
kept open across the removal frees its IRQ again on release. If the
mapping is gone, that can touch freed memory, as reported with
virtio-gpio; if the number was reused, free_irq() warns:

  Trying to free already-free IRQ 28
  WARNING: kernel/irq/manage.c:1881 at free_irq+0x193/0x2d0, CPU#2: gpio-hold/111
  Call Trace:
   linereq_free
   linereq_release
   __fput

Stop edge detection from the device notifier that gpiochip_remove()
calls, under config_mutex so that it does not race a reconfiguration.
Free the IRQ there only if it still has an action, as gpiochip_remove()
frees only those on lines flagged as used for IRQs. The release path
then finds nothing left to free.

Reproduced with gpio-sim: remove the chip under an open request with
edge detection, set it up again and request the same line, then close
the first request. Every cycle warns; with this change, 100 cycles pass.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Reported-by: Jia Jia <physicalmtea@gmail.com>
Closes: https://lore.kernel.org/all/20260817070429.157993-1-physicalmtea@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5f78960eb7f1..58e9da9a0662 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -545,17 +545,6 @@ struct linereq {
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_EDGE_FLAGS)
 
-static int linereq_unregistered_notify(struct notifier_block *nb,
-				       unsigned long action, void *data)
-{
-	struct linereq *lr = container_of(nb, struct linereq,
-					  device_unregistered_nb);
-
-	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
-
-	return NOTIFY_OK;
-}
-
 static void linereq_put_event(struct linereq *lr,
 			      struct gpio_v2_line_event *le)
 {
@@ -610,6 +599,21 @@ static inline void free_irq_label(const char *label)
 	kfree(label);
 }
 
+/*
+ * gpiochip_remove() frees the interrupts still requested on the lines of the
+ * chip being removed, so once the chip is going away the IRQ may no longer be
+ * ours to free.
+ */
+static void free_line_irq(unsigned int irq, void *dev_id)
+{
+	const char *name = NULL;
+
+	if (irq && irq_has_action(irq))
+		name = free_irq(irq, dev_id);
+
+	free_irq_label(name);
+}
+
 #ifdef CONFIG_HTE
 
 static enum hte_return process_hw_ts_thread(void *p)
@@ -977,10 +981,8 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	if (line->irq) {
-		free_irq_label(free_irq(line->irq, line));
-		line->irq = 0;
-	}
+	free_line_irq(line->irq, line);
+	line->irq = 0;
 
 #ifdef CONFIG_HTE
 	if (READ_ONCE(line->edflags) & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
@@ -995,6 +997,25 @@ static void edge_detector_stop(struct line *line)
 	/* do not change line->level - see comment in debounced_value() */
 }
 
+static int linereq_unregistered_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct linereq *lr = container_of(nb, struct linereq, device_unregistered_nb);
+
+	/*
+	 * Stop edge detection now rather than when the request is released:
+	 * by then the IRQ numbers of the removed chip may be in use again.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (unsigned int i = 0; i < lr->num_lines; i++)
+			edge_detector_stop(&lr->lines[i]);
+	}
+
+	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
+
+	return NOTIFY_OK;
+}
+
 static int edge_detector_fifo_init(struct linereq *req)
 {
 	if (kfifo_initialized(&req->events))
@@ -1788,6 +1809,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1867,8 +1891,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	if (le->irq)
-		free_irq_label(free_irq(le->irq, le));
+	free_line_irq(le->irq, le);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-- 
2.43.0

