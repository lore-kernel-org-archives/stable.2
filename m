Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428733;
	b=aBhZ/O/eP94TnADY5xvZBpsYOeRdObDFgF+Ru7i0oGx8T4nfYbnq4SB83TuhfdHx3VVd
	 WzyPg4t02THNdrAlGdYT4v8hXTRCMda+iKklqckM02y8wJrKl/3ZhWe8hlbnEYxKKqR7X
	 CzS5vwYRK5EPv0KhqDc3H8a8SyQ70InGbP+hOpUA76CP6GOwlwHHwOn7MQsu5dSuOv7Px
	 AzBOASLMPucsuQCZwMgC0ysud6Qkwva7jdLQMbsli3Ikw7AXgWUrSkZU64YfV68peQB6k
	 TCs4bl+JtUEBuN4ZA+WVv/coUc6iyGj75IjdJLb6XsOtMf0TFFRn/roa5VqsDLAPP5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428733;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fu5voAbElW63uM3SAR19Q3o+cbRKHCuYO8s3mZwbL2I=;
	b=qrobpyiuI5pU1S2JecztFeRBXXIABvFQyvYIrn1s+koA/XJahdVFc8GEfCisrCDR+xd2
	 FbBh83YFs+KYlpfm8jAHSeCjiku1oI3clmU7DfFVYgwvxQ7iCw3nHGPjNtSFPbK+zx/rl
	 5Wu5xeBqGzR/8UXGrmW5cd2quZt5U7h18CtlCd0wyLP13PynizwxLO90iWrHVXW04hSkW
	 hwXwg51Zgt+FILZdRD7m+QImfIKx6QIwPyfKYpvMpr8ykdRx4lysUK4ruetQ6KloLYcqz
	 ddj25tT9TCTMUGqX44SWSWr0G4th2V3a9tjsklNGNW2cM4lKmv95rud9/NiclQn2zbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=TR3uh8vY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.53
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FD606A31A;
	Mon, 19 Oct 2026 16:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=TR3uh8vY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWlHBi9tUBLSRTTnQqznZ2eUISK5GGbWmr6q71JU+hyMbQeFvIXwFavcLz+N3mo3uoNHomZIvVxrfxIg3lAcUMWzYHrH3dF6P2lhyiZ3CIlvivydqJ7yTC+WhicfCTkTwyiUo3GzWDqWrAjRrtHAdutIxx/ZuCtfisd7HVd1uPM6r5I+Sq+eiOy7z1iJ5DQl9+EDZjwEI/jFgfPJ/hoIQylR01UmZfS0P0CFE2V8ONHaVed5gl3tA3lfiUghhdJfeKjTk4yrDGf7Dm/zF8hfK7/xn14hSCms4G/O0L3tJngOz9iBghgYtE7sn2hmlYLCUq1a2WXsIkHAZFRrkVnQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu5voAbElW63uM3SAR19Q3o+cbRKHCuYO8s3mZwbL2I=;
 b=m2Sl54m5IQrIjLpeEdWU9leMl4ywmg/FKX98/E/NXhWM47INy1W/Hz7YvyZVWjZfraXqxNg1pfRZhNx2lKHuUnXoFXJqKAPxDFXJSQugZSoPKY+mtdquGQUi3SJ8yPETpL2+MuoJkGvt+osFUkXz5gBh+GQjwh2nfMFbG98OOpVYWxXhdZ0nv8xRPAIIg7k/sN7KG7lwhxlrd0FeaeKu3K0CyG4hhEh0ZoQLdbaydlYJX60YGIH1wllQ/V7pEgc8ouI/haKgN5anL9Yy9TzxiQi35+DBnsGvEacO85NiWuWVDUohca4JVwCeSRf50t1yZxatSWmcRql1SfssNK2srA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu5voAbElW63uM3SAR19Q3o+cbRKHCuYO8s3mZwbL2I=;
 b=TR3uh8vYm2VnQ0+M+4Vd3VV38MAIcjOGuvcgomfxxmm7bJ8qwp042zAC57ndaDu1YXnAdNSGSwphIIS+AesJ/ZGEWpcKb432jFHUrI3KRlQZjei1mOBmVEFYtXICcZ4rPxPjJ0PBmUwx3zIlByTFcmEojD9IkkIQWwpN49vAwYO3D38cH2sRnZ7Rm68aH1HG6fZv+UHFNhEQTijwK7jCU403+q7fvcgnFGlBCIY9ofLbMazLX979xQLtmDslNNrHgy83ANYf63gDozpr9r2+ITauQ7j+Z+hZwDtygjyMB4j+Pfe6638GuldhufwBmOZdyie7rzmKH8oLiO2sCN/ovQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by CH1PR08MB10740.namprd08.prod.outlook.com (2603:10b6:610:2b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:52:04 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%5]) with mapi id 15.21.0496.015; Mon, 19 Oct 2026
 16:52:02 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PCI: Don't read config space of disconnected devices in ext cap search
Date: Mon, 19 Oct 2026 12:51:59 -0400
Message-ID: <20261019165159.1268120-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::29) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
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
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|CH1PR08MB10740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6165f1b1-f904-41c7-9456-08df2e014c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EglmbGSFIRbW13s4N/07QMRgfC+NCK0ReDRBeIcapcZbUD78Vya9tNYmQmeHfPVh7dRE6psltjuEnrzPKeWTE0UJ25RYgKb7KYeLnfPyEFNbYRItLO8IP0Hlj9z/w8UQD8UXTGwTH8B+p01jCzNsUHIZYEIiw5Rc+D3w21zf32JjUIVklhPGuXskO56/nxSBA/XNSo52s2gcobrY4VBw6b4Q7RKnZUnUhgrGWxs0/w4oeDE4qYyje4pJQkyBWwnyYOLc52QhJr8pGmHoHJ2sRK5h/KNXLWEfoT17WUYfhJIkttNShcdlkBe2mm3WTSVdoWxXx2DzRuSKMkswn/nRD2WXRYGNTzD2WI9OJb5hQYvBjVCAWPd1h4b0ieYbJXalshAtEDeGzrHDXgKD2ftTH5PrwB2QxhLg2xuxZYtBqsWqdT4TnFIYEup1pvGO7acGUP6ggkLW+TQfPlY6Bn/K4rsg/fEfyqxiCopMA92mRgFWoZkG88JmHmbtsHQAGHUpcoInzP65ZQDsc/19nTDq0bDp0Tahpnf06VdWbaTrS+kxQnbcwdNWJ2Oks3p6uo0nPhFhrcRClPJ8Gbm978duHTu6sZo1WPAFgwOkU0r0Gbf06a8yA5QbIQcwMA+Gs8BNcvIiTvCc5pHO4kSU/vx8qGQr0Vc4onMnme9lQv0PLok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gn0DBgBuBLEiJF8VxN7WcdcpXB0C86/QQkv++H3iHBEztg5JDI7snXqRbEOg?=
 =?us-ascii?Q?WeX35ume60JV6Sqbn81Qz1nNB/QraXlJA55NtOP7y1UtKEW4SDHFqNsMFSgQ?=
 =?us-ascii?Q?XNugpWAfAbKtedSJ85m39jT5/5cR1YYGkgvau9UzAT2T3/aJ8CfYLVr7bark?=
 =?us-ascii?Q?lfb5DW88e1wBwr9BpGj5EbMIRjb6lMwY/0t+k+C6dWYe0/JXBcHSaPQf9uS0?=
 =?us-ascii?Q?m6ysznIkIVpl5RcOP4lYZFN4aCQcBb31FXbOqKCRsPfoKPA9CBJYrYiGZ/yv?=
 =?us-ascii?Q?H2ndQjz5byQkrkuY14o/NaUJHBic0UXUIk90D7IRdIsBuvfDyoQHDW+1m53E?=
 =?us-ascii?Q?wMWanyt+42LtGsYpWwug8iICjtPUuhLaY0GPk47JNnQQsw2Uten5D2Sx5ctV?=
 =?us-ascii?Q?pnMFlhu6XFB8lMPGTUz5ZA29RxN/8Ais/JkcgnvqS8YUtPnLRtGdk5m3I/+8?=
 =?us-ascii?Q?cVQCl33/BqCwgMj378p0zELWOtlNVgnv6MI/8wqAzbk/K58+Yj2V3uHF5D9p?=
 =?us-ascii?Q?HxONXQT0iR4BibgbfnJabkvK7l7vSa8bY0GYsAyX5o8UgyolHjuyXeqC0M7J?=
 =?us-ascii?Q?M2Y2KMjts8CRf5zG4RlgoAaUK0nigfRMAgM11dM030oe1od3I88O7XJM/gwg?=
 =?us-ascii?Q?4rUaZQaXz3a1Cf0arpJAyWC+JnmQ5DESF7muKhYzGdjOMU9QhLdSQl2t4IMC?=
 =?us-ascii?Q?vafnYUtkqH1xwO9X0NU2N8IciETY3b11Udcam09eWEsli3cUtPucglaAFO80?=
 =?us-ascii?Q?KDbUXUq2EpnGn0+MAsC5cR4CsvofcolQaOJbZFff/TiT7CQvY3Je7YRn/dP5?=
 =?us-ascii?Q?TsP7LtZ7+/i16fdOCf7B2SECUf5zVA6ATsq5Zz3pDMWTi8l9uHu6p93gyNs2?=
 =?us-ascii?Q?TeqieoXfxoDIavO30muyJ3jwigFPs0sxQbz7pmaikUd2ohcRJYfzSUB67uT1?=
 =?us-ascii?Q?0rmbgzrmFCjKunQYXzMfS/OmmYq3OgfIDmfLTGXCgkSzKC3MvECcmFRNgpMh?=
 =?us-ascii?Q?PW0NdnaPLjv3S++82P7lSOfpEyPxo1Y2L3WQOrj+6MAh1flCjUlyvcXUC4Zq?=
 =?us-ascii?Q?nuMA7GBFPqfhxmWXFyPXBx48RkvRIFeGJflMTwxbJsSieaZaBav2hAZs3mmi?=
 =?us-ascii?Q?J9tc2LskDvXjON4RjEfAKVoZ50poXwrqwoOe4M/IFxWzyy7PgCmUAuc3M6Kj?=
 =?us-ascii?Q?nfUf2/P/fv6m6alA1vyBtrFwgI493dgXVH6+xuvywgDdlcmfsY6w1YIZLVEi?=
 =?us-ascii?Q?xHIo95tzCVDg3vTpHo6eyqhUzPVxifdHC6HKgHwGIM18eUDZJDoc5WWvtiWR?=
 =?us-ascii?Q?QVJRlUAFkEAv/8T684Cg+ZIk8MosOZ1yOsoGwDpU03V2U1z3oTs4u99UpE2P?=
 =?us-ascii?Q?MGjrWSHKyowflUQXu2H1UxIJ2VthBxBE9yA2gYqDte38yY+GlQ0oFy75xFo0?=
 =?us-ascii?Q?G7QhQ0b3+SuuubyA4HT6axaEMiNOsds0YP+lLwZbXxLBmKuXaJ1k4mEPjfSN?=
 =?us-ascii?Q?H5twEb5D/CK32aFv2BhPrKLqbvYRSCroJG2KKKPTvQYIkZXbHNzq/l9VDvHt?=
 =?us-ascii?Q?l1iTBLc71LCxgiUjufqsPczZhqLqNQBBACRCUX27J7Zj0OH9+QLoEh52XMa2?=
 =?us-ascii?Q?YHF4e6fD2WAwPZYZIPe/wZsoDjEpHd4xp33kZbBSEcEG29ZzAhZdRmPLRyIC?=
 =?us-ascii?Q?i741og6tvZJmZcO6KCWNEzTkLfLd3NF1/QujnIIwRbC4e32n2CsChpyVr6b6?=
 =?us-ascii?Q?bP1LMEmuBA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6165f1b1-f904-41c7-9456-08df2e014c2b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:52:01.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJPTvTMKUT8EO/pjzaUoop0B0kHkVY/5JHZus2bdMPbPxgwWdAntgYTdSmHhWixWLKEO8A/MsoX5zxYOxGiuWw7n0RHX2tMVKO5l7l6M/sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR08MB10740

Commit 4d909bf1a53e ("PCI: Refactor extended capability search into
PCI_FIND_NEXT_EXT_CAP()") moved the extended capability search from the
device config accessor to the bus config accessor. The bus accessor
skips the disconnected device check, so walking the extended capability
list of a device already marked disconnected (surprise removal, AER/DPC
recovery) now issues real config reads to it. A dead device returns all
ones for the first extended capability header. That decodes as a next
pointer to the last dword of config space, so the walk keeps re-reading
that dword until its TTL expires, roughly 480 config reads per call.

Restore the device accessor so the walk stops without touching hardware
once the device is disconnected.

Fixes: 4d909bf1a53e ("PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/pci/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d79d2ee4ac69..908d2273466b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -519,8 +519,7 @@ u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
 	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
 		return 0;
 
-	return PCI_FIND_NEXT_EXT_CAP(pci_bus_read_config, start, cap,
-				     NULL, dev->bus, dev->devfn);
+	return PCI_FIND_NEXT_EXT_CAP(pci_read_config, start, cap, NULL, dev);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
 
-- 
2.43.0

