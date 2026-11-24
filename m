Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512081;
	b=YGGDazzmlj72XLOl3gvE7Cp+7fpt+UUMptSfzx2HV/rSxyUbHBE7vj2QRwUgLel4+ERG
	 m54dtjxo3yP+K5EW0SUjJvdrNJ3S0KN2gESgHdQcsE6l9r1rK7+E+QFH/xeudRNtsDF/X
	 WoY49MyI1yK0qlNhJXoXaRMW4ahu9FfXfyzhgh9oeTUJTvtEtl0xb7i1Xp7GDzgdZr6jh
	 ioH3lLuFohAzVq+Qsy04H8/AXpkodXhpjoth1UQR5YS2jQucJMTreSZwAyUi2LOPrH4L3
	 jHV5VFrrXgHF1MwY9o2yjcyroipY3b2C/wKZW8q4lp7LQr71xdJ+Ff0zYuP8ZUvFwHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512081;
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
	bh=urxXitIh+HUU13+NOh7WRAWp0/q9VmEdlkGoYZSStbo=;
	b=yri5zSp6109McgDTtNtB5q3L3PlvnZf29UU3qonLHKqB/GC4dlEmIzO1N+5guOrBkNGz
	 Qe2wKhB9eRB924dmb0/JbJd7P+yiuNg0cuRlV2Aiat1O/vgIFAIZ7GQpPU/7Q+NYjrjwP
	 OPEIZv5YutUdRVNWIoQnlNLL2l9rnQF3+DtzjUPe8XVoRVcZaVYRUykBXwGjDnh6Zzl+m
	 NSfC88dMI1dtrCgzQLaWo8cMSn4YGk6qnz++WKU7oq5Yy5ylNSkMRJ110GGUyRoMqn9j+
	 rPNQSlRK0RXk5PknSYbg9KgHm82BQtuMvC9uUE8/QMT1vKMbu1MOWzZXfJmXyvwtuMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NX3id7P2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC32606A6A0;
	Tue, 24 Nov 2026 09:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC32606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NX3id7P2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJIybySmRQH+3X5MXXStfVUHRrF1xktPn2FnNDgdXY/n0j0G0uvCh/eDaQostgRUvKQxNnrPxCRmLp51qNUfqDVNMferjfDzzbsZB4+pjbfUPKb1XYf4Lunkp4QYJbCFBtDi7tkbeAS//U3WHNkCHPnVZFwDHQ4pNwBbuwSljpL8G+UEYkS67tt688x/u3JXbsf3/4/pmqfpwgN2FJJ8agiRM9ClPKY0I8uCw9Rf7cssUKFjiPCgZkbtHX+7iZoVvqK2Dx4KEmSSHTLOIcWYdfT/XFqXykZAYNuI5K0LcKymDnRCuacKamph4NrVcpIuwiZRDdOI2707aJxROzDHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urxXitIh+HUU13+NOh7WRAWp0/q9VmEdlkGoYZSStbo=;
 b=LtdV0OZRg1BEW1gUp53NZxCZqwzGqC3FBRRCX8L5RcrtCsy7uP4MIO+JfCrfGo/jyVxDjZMafZTdbIH367VNC1itnETxyZS5MK+fg/b+qbI238a5X1QrQd0b+CIBYXwPLY7+PSqIcvygxk3UErfaodD/5Fgjjp6yLJGICI5B4K3vw9pZx0ARbHR+7dLv2lCvF+TQu4xSW8tYs95cC4WI5a4d3JPEx4sZ4/8JNgs2KCJM6SeEh/sAqXbEDz7zWo2QccILZjVjlWrduzMqi8ApN6ZNA6xuvUxuKVKZurwQvK4Q/6PrSAFeGp+jSXLv/AiYp05K7dmmRpPQDlrXsg0KRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urxXitIh+HUU13+NOh7WRAWp0/q9VmEdlkGoYZSStbo=;
 b=NX3id7P2gBzV309ojGysnMHu+HPnsBhcXZCpBat/fXsrWxAfKnf4FS4E3ockVuUQDv3e3gx9n6Bou9iWcPgJ3tfHiJYZIiGUwDgRhrtKJG8IR9lImKYBxJnaPPCudvXfc7oNbfTbD53p4R+nX5cMMwCmGE3JioNgCLieHIPcgPjE7ts98gjhBUAJp6kP+/5u7Qk1cy94PLPLC4FsXxdTxCBybSv3JWygczTSyK2Gh43XnWWk6eJ54e1acyz9JBv7wMlz83cO1Ije1IN/RgrK/X0wbzKuZfVOaMlpSZ1IjQjEOecmYltc5xmUKC9krScaJmL2KadFcEvJe4N9ht+Maw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA3PR12MB870191.namprd12.prod.outlook.com (2603:10b6:208:712::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:21:14 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:21:14 +0000
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
Subject: [PATCH v8 8/8] gpiolib: remove the shared GPIO proxies before freeing the remaining IRQs
Date: Tue, 24 Nov 2026 11:20:39 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA3PR12MB870191:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b8c47c-e269-4e76-f75c-08df4a0c4970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kwNyr0PEwjmADqoSFuwHlSUj34WlcFxBHCe2QDr86kyYqLRTHvte3KgHBuW2KJpGEpcNqTpM7Q4GrxbW3aq2ZB54XiwRor+rQiIXGIDl+lL9TAahB/WNxeZOKm7pHCjHSKOafHbHNlJwyDRzk3V2+UUl4Cx7bY3klVfodLhEa0thnN5qm3WFxQ8JrTU1iJLhXlrzIwdR3jGXhmZ6hNyU7TWb28+qhvmXNMe50jPM/BJHSx/SsAcWGKPsrz044AngNR7hUIyCo/O7L7JIKysPfd4Nq8MXAikrydz4PjmqPGg7S4bMgDNfmqOHaYPIK4o6w5MqUjyZx1IhMOEn6knp/K6AJvfz9I+3tUSbbrcTEAW2zXZVEZR4K8HQEvSP7PgoavJI3NmNky2Y6zeUqht1T6FJ8mD4w+KZ4gMZuxaoPV+nBFzGDY0NxZsKKnzMgiFxb+zD4U+2QxgskHLDF2NIm29FRbxJcwXiVxuYb8hm2HYpiye0qwEEiFl0RyfbF8QyyZrOmznO3nSnIAey1gHcCCKWZrhppO9XFWmgG/WCLeaO3kCXTHUTQRKKILNpCvRExCwdIhcUVzHE8hiKk4pjz3cM5VwC0wRMY8cXaMKvhHtZs5ZFG1SFArOGzDeyQiv07bcn2SrvwYflOKpVamNzDJVy8AonyPTB6eYl7ILkj3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hh5XaLQVEsELnGWH140VAynDTIWcdQiLMlikKNFfad5JjsIQgXuajDIrw8N7?=
 =?us-ascii?Q?WDCJoq/Xqmrp+eruS4st7xVtLlMsnIAhsuOzFwX+EI99AtDV5jktCm6xNdBF?=
 =?us-ascii?Q?7Uy2/sTVYf6JdeR8DGS1QBuetZc+RidfW+4NWoiMjD8DhM0kFOF2ffwQF2PS?=
 =?us-ascii?Q?BpdAPooxVVgy0RVb3ehGTNf7Nos4QC8pRXx0HZ5ahKkjvbndrZCut3u3RLaA?=
 =?us-ascii?Q?UpkPTFLlI7Rs5T1E0bqvYPyHfB8RJHf7OmRYkf6bQ7UBGz4lVu5e8PaYPecB?=
 =?us-ascii?Q?Rlg4z349wfVrUy91E+ALqds0ZMFTD1mydm9jcK3BFb/gzMn95ST0WFd9CwkR?=
 =?us-ascii?Q?Tx/35U4u0QqdbYQSsmLYub69AbsOE9iTyuzZJ44lqTw0cZCvxxBxPtmXE1n7?=
 =?us-ascii?Q?GleOcNeLieIjoizJ25Re/eYxnBoSVoTc3OM4BOaQGloW+fZV0oXw9cPHvTmi?=
 =?us-ascii?Q?LU1T0sHjj7kyM8rzHDYL4ofACCqsemPn6hufNZQtHOMyiLrhM6MDcMe3JTg3?=
 =?us-ascii?Q?Tm0+DqoqNfLmXrPjxUf0UGbFofd0HDIBVlnGUgtyDl6Cfq4wN5q0PPNKEFv8?=
 =?us-ascii?Q?1CL+ww7MZUUPW4LzDpWfGrUVcyACGb45guaZyVWLFmiwIuA86QvvUNSwWFBg?=
 =?us-ascii?Q?NqZxutkcXOEvWqyKUUa6YFEB1rrncPKKzdsCLe+vdfHJA/cgYVH5e9lyRShn?=
 =?us-ascii?Q?9BjPEljZjtw82V2BguZjQuKSYhhzmpipjuXBy/slWgeXiyoMCQZtkJLurG+D?=
 =?us-ascii?Q?mAyvu2n3Ww0lt+TLrqC3gBgryazFdLiCH3zN66piygrfQl8GwRcKLSxLhE5O?=
 =?us-ascii?Q?YW40jmRiNyNYXAHpaWpiE7wIPDcQ05gCYyiRtS1s6pt4Tiy/u4qvjaluyLdM?=
 =?us-ascii?Q?+HiekjiWASrW/z5PJ0cNBEtgjEnEZ556Jbc6zXh1OpmJB8s9A4lus2WBX5Dt?=
 =?us-ascii?Q?i4PtW4sjL9wijwSBeRsMituMtokqLOubETyLk3/i+/ge7TmRRDvkLaj7hySe?=
 =?us-ascii?Q?hUls5oOfv/Pqc9+nO/52BM5nKwicPJ6YG76jsmBmzzrtKS794h736IeTrdog?=
 =?us-ascii?Q?gAYwPmiTlZtN1AWbncWWp7Q+KbgiyCoASeom32RhpefNUpMwXF69t0cmtykv?=
 =?us-ascii?Q?eM4Y1PVYIHggr3UoByy/YBHbW8SEczuUZsmOxDtn8O1Mrq0apghkCeJLrjxS?=
 =?us-ascii?Q?YCg0FOt0Pv+NU5stDGrgzrS0w6wz2uOFW01C71MgthKs/PfY17U11KsLSyc1?=
 =?us-ascii?Q?VFTJZYPZ6fmt3GETGSABecoPlu0FLYgGbBDzHV72JhTFV6o/Jg4y5srKqO6o?=
 =?us-ascii?Q?kfSPMR/8Fep7OA3QrkCiVtH//CfYPJERwG3ytdvTOvcw8zzirhdLnMaJYmRJ?=
 =?us-ascii?Q?EOtyEc51dfOS/c5WJKFv267OP7JDlJJfu71IDTuUoT7x7uMNaFaHlpEMBMo3?=
 =?us-ascii?Q?C/S/iCJRg+YINnjUFHdgMoSTzuTRW2W97pnUZ5WzydJF91D8kG+qpqMRvOha?=
 =?us-ascii?Q?ZCLiZpBGAqFRruxHZW7tVux69Tei/Ac1PTL2CHqZsKki9iVgxuJwd1gtGbiu?=
 =?us-ascii?Q?NL7K5s7+8YAfei6SXku9gF3xK7VyfOCuC+aMgScc482FaH1ELVe1S71Lf2dR?=
 =?us-ascii?Q?nj2HEsjM3cN7XfJTRg6RHeysg3ZeWB0nRX70mVkGb72ifkhgldZsL0ZilIYV?=
 =?us-ascii?Q?Wds2xsSjKXJL0UyPSDa5BdfSRz7MCwr9WVK7q8A9CZSLTaUDwh3VHrx5pSGM?=
 =?us-ascii?Q?n+UAd13MlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b8c47c-e269-4e76-f75c-08df4a0c4970
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:21:14.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfHe/ADiRePEblOeuDpMBBNNIpKVvgmR/fOWX2Of7e49+sWOK/VMHwyDVwJHD6Xkaby1ggHZco+i7b0ojXvEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB870191

gpio_shared_proxy_to_irq() returns the parent chip's IRQ, so an edge
request on a proxy line holds an IRQ of the parent.

When the parent is removed, gpiochip_remove() frees the IRQs still
requested on its lines before it removes the proxies in
gpio_device_teardown_shared(). The release of a proxy line request is
serialized only with the proxy's own removal notifier, so if
gpiod_free_irqs() frees the IRQ between the release's irq_has_action()
check and its free_irq(), free_irq() warns:

  Trying to free already-free IRQ 22

Remove the proxies first, so the character device on each proxy frees
its IRQs before the rest are forcibly freed.

Reproduced on arm64 QEMU with a shared gpio-sim line and a test delay
before the release's free_irq(): 3 of 3 runs warned; with this change,
none.

This patch depends on patch 7 of this series.

Fixes: 1e4f6db614a3 ("gpiolib: support shared GPIOs in core subsystem code")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com?part=7
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e0ba17a73c4b..57024a1b042b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1461,12 +1461,12 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	/*
 	 * No new interrupts can be requested through the character device now.
-	 * Have it free the ones it holds before forcibly freeing the rest, and
-	 * both before the irqchip and its mappings go away.
+	 * Have it free the ones it holds, also on the shared proxies, before
+	 * forcibly freeing the rest and removing the irqchip.
 	 */
 	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
-	gpiochip_free_remaining_irqs(gc);
 	gpio_device_teardown_shared(gdev);
+	gpiochip_free_remaining_irqs(gc);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
-- 
2.43.0

