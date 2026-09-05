Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013074.outbound.protection.outlook.com [52.103.35.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B83A7198;
	Sat,  5 Sep 2026 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641302; cv=fail; b=EhsP75ER+q31Rs1q02242qNEXlVGLNSJAySvsD1+Es5YAPIrTiyqBALanMXfDM+Guf43zZxo3ZQ6S/5QSrtnofQ8eHuQwtBRhKyc/A/9JdCVT2ZiQ/d2m3+toWFp4hQ3cM3Cl+vZ3ouY3j7nzeKzxhxK3d2Ukig0XmkAa4XH8zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641302; c=relaxed/simple;
	bh=cS6h6V3DuB0FGKKy0tNR0Eq34T39x+R+wc2NVlT+Otk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oT6mM5y1OjUQQqawMceV+nekdngQ/pzhtGgunNCpLDq+js45ZpGLar6ssRCfKvVzE1VyeZK7a0T5gIYYWcOkW6kH7WHs/iwInAQZhTmMZ0WdRu1/TDA/aGpa8rs3ek2gzPYYhxZv8xy0mQAq0H+w+tXj78Omo0SRq24ZjcLFHU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=M9rN3aey; arc=fail smtp.client-ip=52.103.35.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="M9rN3aey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3HEC7QfaaEGI9ZrwFM8i4ZpgzvL0NIucg8MtkU2ScAVRsk/smzsY/1KfM/wV5DbnulRN8rovZZSsH6kA4Owr4cLBGmKU8CAGerzYd/MdNsNSaxFZio8n6MAJ7jv6PC9X3m5SR/CB+9oawJpvN7DUzLBdw33XsMXy40OxuDqGo9TnYzIh+LN4FK6QQWlZBDn+DD31KDEA3FyLE9OdBZ3hRot/x8E8jOGjJ/IHjeiRbfbsPibI7oQFMxvTapcjcOiCqSKoZTLJ9Ik3DjbcHBN7Sv9kzkqu7QiT5ThTDbaOSLg8DnrydeE2RksjOSgYUZWC9UYVqhdG4L4pUoSAy89eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xp8KQeehEjvHnd46BlS4YLmrmakc1uozIlqsBkKWZI=;
 b=V/r+qdDE6ALi5VtUm8gpSe3tcvTDr41zddrhAcmW57RnUtfh+OjoHRUPhpymJtGvdj2kWtmRoKhJJPgMY+J2x+HkMwTGAjuRkMETH/PJ0DrqUu5JYRAY0HCfbwwrkiD/WU5zvmTjuuy9H7jf0fMlmxjbja32jPQcB02cgpxGFmIc93aJIvUC4Y5Z+CbWYlzPd3vt89XzozDP/NvPZHYaSkkQFdlV6V4tFZQpyF96qfG4EVKa2nK3gCJe4NMtJ+gEAxMzbEMxx7HX1VdVtdsAHOrAIXZv3C5eBkjKtqGXHoQCfpixEdJRr9yGFeShbnoJJDsovLozKaZvMWJboX/Scw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xp8KQeehEjvHnd46BlS4YLmrmakc1uozIlqsBkKWZI=;
 b=M9rN3aeyqTKqIvHIaVJvFJEWTJHQvYV4Z6izd9qXSyoDH4uzjnLkGeKP/JNJm9XEncS4YZ10/C4b1sHbr8+LizZO90qXOxNjAwBVDU8q6R6z0lr2ZMvMHGsshi5nsGm4IrlK+2BNJma13YsV8xfIY7RQQ5XHGm7XrZDu0j/k5g+tdX3VkN7ej1rYoqOKIyOyrexVT1q4c+nsJ9SqVaGPNR1D9u4ijTx/p3IIGzLkjGgUtunBdqv/bHxuOI3M5rIOdDPkKGq39HWC90G1j8SwlDqVeFbEuGk9MfBP+8uRFtimzJfZd3IoxZ74NcLaucdEDmaE8x7fM4A0WFKUDbR/rQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PA1PPF75DB7739D.EURP251.PROD.OUTLOOK.COM (2603:10a6:108:1::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 20:48:17 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:48:17 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Gregory Clement <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws
Date: Sat,  5 Sep 2026 21:48:07 +0100
Message-ID:
 <AS8P251MB000199E5C86A0447B3FC48EDC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::15) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905204807.31752-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PA1PPF75DB7739D:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0da56a-1e3d-4918-88b3-08df0b8f02eb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|16041099003|5062599005|23021999003|5072599009|15080799012|25031999004|37011999003|41001999006|8060799015|19110799012|25010399006|4140399003|53005399003|40105399003|2607281247196008|3412199025|440099028|26104999009|19061999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?goPrPvwlGcyVknayN+kbFq1LjHVjCEkrWrnaSilqfVuyTFS2QTgjip23r1g6?=
 =?us-ascii?Q?1CEdm/SEiGnX/cD60hx1uyi9mQd0WQXSVz9cq0NPd9YEtjQsRteqwgSl4PXA?=
 =?us-ascii?Q?AGy4qVHEwY4KefUvzOjMJZNtcGljkxro95qqgfY8oFySklGTSLyXpZ1SI3sR?=
 =?us-ascii?Q?D0TYZpw79ivLJ/VWCQr96lN9af+m7Y2LFaScEPDorGQwA3MTfabRAewAEQlV?=
 =?us-ascii?Q?ylGCULJEsUoufI5Kd0RYAQH2/3qghiJCQzae+HhhOA4gp1OO9HVPsPcO8tQd?=
 =?us-ascii?Q?hnfqSpW7eJZBzYKHa+wkm9/cT+xiGbI3VnrxAFQ2GEoH9MQDZr5oyIWS61LK?=
 =?us-ascii?Q?3G/mln/XUIIQtnOunVSATBDC9WQJ3uyUTiYv0PsFtfMmAxsVVxDp5oi0oM80?=
 =?us-ascii?Q?5tic5GvdPOMpUcdLwiw6jczvYs5S0nW+VehtVnW/Vs0EW6L12gewUC/2TDZX?=
 =?us-ascii?Q?OrDxLtrHPbmWJzH8AWXfnBmWdodbaEK7Rnzi0JFwJFrC2enc9fbOZiNr+Yp7?=
 =?us-ascii?Q?wn9+dkn+HpRMjA4r9t6yoZOkCa98L4fTOF1uhhq4OhoLISj7RPBV/U8qWmXk?=
 =?us-ascii?Q?3NPgOYatiB0s3gGv0TSpLS0KZdw1ZkJv/aipr7AWHE3iweroPUd8mV59XqZx?=
 =?us-ascii?Q?/bGnPNxg07lm7D02AghPcwBDZuFuhPRc5JQbi11xAgaFj+hXAML9h8QN0Yx/?=
 =?us-ascii?Q?w/90MYAzTdIRMBQpjHZ3EUw42UWNe4CQAFsQbQPM2WwG79FWl9eI0oGG9wAX?=
 =?us-ascii?Q?+QhnjjMgq5Z3lsYfnWOIPXBUP1STAfZP8y9edyWvtOeqznov47LWMO4tganv?=
 =?us-ascii?Q?TjWPiPIujI1Jq5qsbCCOWBOAsbDnKSZJH76gbwB6AsHX8iGYMUjPtS1FX0/3?=
 =?us-ascii?Q?xzJSeM9B22z8wU8r6GQU9JCDgXxO43ljJ7gLkbXCzPdLetg9VJkUhb7o1ZZQ?=
 =?us-ascii?Q?BeEQRwLX49dvCe47bq1DiybWBaJeJ6v+DH1QtglgF2Vyg85SHQNr5duMUpl2?=
 =?us-ascii?Q?+WiH9+GAPtVaB7/xrja1Di0a154SzkLOzrXnFekU3Mxh4ZT4NYHhZL1AXFZ8?=
 =?us-ascii?Q?9EnfBOLfE118ZBMw/iFLbR5CmbDLRirjYzf/KK/aHUPxgWDFnTB+PCMHcKvw?=
 =?us-ascii?Q?jipUi7Gbpb3YuSujKNIvZA2sDs5mqHB2oQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syBZFhAzUvrmdv+BdVKa9626umdDc+djyfwyr/Tpn2QN43+QEF3+kVlp4yRu?=
 =?us-ascii?Q?Qh8IxZlA15AWAzMZoyoYvlxY17dxZT6aXfvFmbV9KoPHcxPSvHauwR9dEHzK?=
 =?us-ascii?Q?QNuUWp7l5Pq6Rfge/4ZEyUKsTJi6hEK8LQmLA2+kD8ulbrs/aGz5oZIa39ln?=
 =?us-ascii?Q?4ceDz9fH2wnSSXBHFQ31xYu/q+E1U2jbpaLOhi2W6ej1rpkoq7kh9hrAzxmY?=
 =?us-ascii?Q?aJkmgjJxg7tCFPJF05urWJSTUj0hYp/N/PFWRPJtSRHAHA8yq3hsPj01/BsQ?=
 =?us-ascii?Q?CGlHFBlT35uWVU59A4l7fSBqOPCXKWHaDO1Lxceov4JHmz1C1badb8/Z2jF5?=
 =?us-ascii?Q?YJFeSbzm+x8yiYfys7brynwVr6CT99rIqQZKOKuG0PQRm6N52LOioskh35fP?=
 =?us-ascii?Q?6Jlz0LVnouwgHF9MVwqPGEGORQSro1Q7V3vLzeUKwtd3ooAHPYwqNENxZrJt?=
 =?us-ascii?Q?1nr7U3sn6/fAqDX6uxzbLS24w0sktL+DE5hGLGn2ciwkr+U/DL+L8pG6RGu+?=
 =?us-ascii?Q?s5n4lfeVYANbrljLzkrZpyen3GTELUQb6ZHgUYqezVrs3awM4g61phwcMKi8?=
 =?us-ascii?Q?+Lyp39Ln+gqC8SJQp21DVlpTOQFwoyvQoCULXvoYY/oxnET3LhLj4kdxQzcY?=
 =?us-ascii?Q?tAw0+OdVSM+qUwn3OA4N9cJ3e7yNjQpXJWCePWCxbl0CJ3HaSqTOn7zrqdFG?=
 =?us-ascii?Q?rDzinldFlD3RW+B6ZMf186+sfPBBT5hA7D3rGT3wLKrlddj3o57LGx6YkrLe?=
 =?us-ascii?Q?9BTYqlf0iChubnQs0g8kKsEFwZDuzDBb1+yO7RfCPIbWsVNZYEs041vaqxCP?=
 =?us-ascii?Q?Ktobk15LYma7M4nk53PVR/HlghbDCgIGrdPh7R3s9mpPjpIoTLslSLqaMJwl?=
 =?us-ascii?Q?Ur8NWnPv8JwtGbYuAMncqAUafLLKW6pwN91AJ7pcsKkZoOaiqp9mjltujsY7?=
 =?us-ascii?Q?hyfkRSzVhrTsg2qFKftssiPd7dgXBpF83NpJ1kX7wz6UuPEGyGaEqTTkuSeM?=
 =?us-ascii?Q?NXJdIJ9rO4qremFVOpxBpAk5hPYYjt29GAKrhJ08usyyDmP24cVBQGu01+bl?=
 =?us-ascii?Q?28Aiy71oLF3tN94xytzDz7dXKOTA/dOYRwEbMRQcs3j/5E7yef9IGRJ4KYZE?=
 =?us-ascii?Q?Hauo3xduv++jSEbRl0YCQlLIUKCwJ5qvoPXEjNLeR1smTL0GcBMkOmcYjrQv?=
 =?us-ascii?Q?Wsh1bMVx+LS7do02j811SuHOJF4PkaKDpPmvcMyYiJyNJf59TE7/7uyPV+99?=
 =?us-ascii?Q?xEVdFW7beW+oMIrXyt5H41nut4awTLaRkRp6XbsqOjT2X16Br7eL5AKhjL6B?=
 =?us-ascii?Q?3DM46BfaJ6oC1JKKI64q9Uwq64DnEwhtVSrjU334fpK1oql8CblDdTxqbFnw?=
 =?us-ascii?Q?RjScwYOKxJ9DAZFfmPNSf54ylhAzJYfKwEZ0HNG4mL8JdEcVdMwu2njcYO6r?=
 =?us-ascii?Q?EivdRRlj4KMoBDFg7ul5I3VKqtk6zASV?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0da56a-1e3d-4918-88b3-08df0b8f02eb
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 20:48:16.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF75DB7739D

Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
about the number of elements in .hws[], so that it can warn when .hws[]
is accessed out of bounds. As noted in that change, the __counted_by
member must be initialized with the number of elements before the first
array access happens, otherwise there will be a warning from each access
prior to the initialization because the number of elements is zero.
This occurs in ap_cpu_clock_probe(), which reads .hws[] to skip clusters
that have already been set up and writes it inside the CPU node loop,
but only assigns .num after the loop. With CONFIG_UBSAN_BOUNDS and a
compiler that implements __counted_by (GCC 15.1+ or Clang 20.1+), this
triggers an array-index-out-of-bounds report during probe of the AP806
and AP807 CPU clocks, and with CONFIG_UBSAN_TRAP the first access traps.

Initialize .num with nclusters, the number of elements .hws[] was
allocated with, right after the allocation. For the in-tree AP806 and
AP807 device trees, which list the CPU nodes in ascending order, this is
exactly the value the old assignment produced. It is also the correct
value for any other node order, since of_clk_hw_onecell_get() rejects
indices at or beyond .num.

Cc: stable@vger.kernel.org
Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Found while auditing the remaining clk_hw_onecell_data users that assign
.num only after touching .hws[], following the fixes already merged for
clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
were drafted with an LLM assistant and reviewed by hand.

Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, with
CONFIG_ARMADA_AP_CPU_CLK=y and CONFIG_ARMADA_AP_CP_HELPER=y forced on
the make command line because the driver has no COMPILE_TEST option. GCC
13.3 does not implement __counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+
or Clang 20.1+), so the build only confirms that the change compiles;
the sanitizer path was not exercised. I do not have the hardware, so
this is not runtime-tested and no UBSAN report was captured.

Based on v7.3-rc1. On clk-next, the context of the first hunk differs by
one line (struct clk_init_data init = {};), so it needs a trivial
refresh or a three-way apply there.

 drivers/clk/mvebu/ap-cpu-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index 1e44ace7d95..ed3ca59e0ee 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -284,6 +284,8 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 	if (!ap_cpu_data)
 		return -ENOMEM;
 
+	ap_cpu_data->num = nclusters;
+
 	for_each_of_cpu_node(dn) {
 		char *clk_name = "cpu-cluster-0";
 		struct clk_init_data init;
@@ -333,8 +335,6 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		ap_cpu_data->hws[cluster_index] = &ap_cpu_clk[cluster_index].hw;
 	}
 
-	ap_cpu_data->num = cluster_index + 1;
-
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ap_cpu_data);
 	if (ret)
 		dev_err(dev, "failed to register OF clock provider\n");

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

