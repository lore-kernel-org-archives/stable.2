Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011072.outbound.protection.outlook.com [52.103.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48FA4EBAF1;
	Sat,  5 Sep 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633616; cv=fail; b=c3udZUkwmZsuxkUxtM/5Q3kguwqOapzGvRscAFehh20ysonUPQhr3iclG76cC+bIqcC+lOsBP+mkjWJtFBQ5vLMtKh71Idabbw/4QpXMth2IfFsN2rBsvX30Bp/G+7k0RqPWnUMfcEU0jxCwGQVVXKi7VkjyKaHVDFAge4auSFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633616; c=relaxed/simple;
	bh=xa3gCqAQCSre/4B/7A8NetYCa6fiUCM9EYA5fXEAQAs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hZ7X2z9M4aG3qIabs3ffnKcSN0hHMOzrdXO1xXgybQxYtywKEw2CC6+Oi0QBHKRmBsiG8DAlGtbCycS1zmMNfZnTAgLdaDrdWog1YAK5SiDUyHjGnXeR5Jb/ATFs3TjL+FO49b/roqTg5WM0oqpSOctvqwzRPZ1QgDeY1SR5Gd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=LfYRYWka; arc=fail smtp.client-ip=52.103.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="LfYRYWka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9j54hGDGTOWIEiGNENdEeDg0FJ7f7A4Rs0nqTnYhBqhhtDxT57loybeJoQPuvS19ENQov3gTtvT3rCRk/kCfc2F+VIfDhfR+BKC9y/Nf+thPK4oP1HHERw55YR92WK8eM50+QKRZ9sfoDOPdCD6mrBHWok+QJ9mamU0FLKNthS52CneVTptz8mB9aDQ6I7npO4IL7k++aW4H3/0611R8PkZtx2044rY1I81d+Ng7gk2YYFzMs9ikZXhqpd1iadaghSNtaTDrSKEPhEMXLkG4lTPmOiYwO3FW1Z4FFTsZMU1VC+zBO2YMkbSXCzorWhDBGlZqzqKDZrIUIO2ay5elA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOC3xEnL0KZ2icP/yx/4hn7Iu+13puDSL4RJijeNQIg=;
 b=BD6ku67kLgEp7ejTMXjdSnqA6fm9XwbzVQdSf3SMhxJ4SMWYXkRis64wj1YuDWHeJVt5oeKLHQfhvqhE0a2YQhNEDbE8VDsCs1GoVzdoeVhSKc7+g0qMMMkcWk+bj1Kc/XNCmPC0kAvBVDaVEywO/i6S3L/tRDsO6xapvHIhDSieln29y/+hV5YeLOjdyABJUW7wHLDlE4QuvDeaNhCQemX9MylBEY7aUtL0Us+tZOrCtGXKr51gKvE20SKFQicX4C0iwc8zmQ8GyNluOjoL0hUNnhg0EiNtfwPFJcRYFnLNBWRDEjGIqmQXi+IHdGaYhjwnaL6EbUjjf1PHFEdeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOC3xEnL0KZ2icP/yx/4hn7Iu+13puDSL4RJijeNQIg=;
 b=LfYRYWkaoDUAlgolTc5XOGcoQ66zZZ53deMmGVbsfR5s8w/3gjlxgpdJoBc57+alnKTv4Lak9Kj7T5Qtx3K5SoivxHArRTG7zNE6GLb8kUTEdFI4a8SwgsHNu5efNRgyJnIU6vYNRuw1eYz0TfxDHOgYTTEgg8n0/CVbpd3Wx7FrcCyOZnKyOuWutXo5j+yQqj5SJNz0EOlqt1Agj8NYv98VUzIXet6FFCoWeePs0ZWUXWxb9NrjjNb+owcklQYa84nrPy+tDZCwZuuSPnipEcJQ5GzfbkE/YrVhDdzbYYf6Ku1/n0jTBco4wrlqWTedfW0+m4nzCzNal9drsAyHvQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV2PPF5543EE396.EURP251.PROD.OUTLOOK.COM (2603:10a6:158:401::b58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 18:40:11 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 18:40:11 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-sunxi@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: ac100: Assign .num before accessing .hws
Date: Sat,  5 Sep 2026 19:38:08 +0100
Message-ID:
 <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905183808.4100-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV2PPF5543EE396:EE_
X-MS-Office365-Filtering-Correlation-Id: a73dead2-7c5c-47fb-e416-08df0b7d1dd8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|5062599005|19110799012|41001999006|5072599009|25010399006|4140399003|23021999003|37011999003|22121099003|25031999004|24021099003|39105399006|15080799012|26104999009|19061999003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0E2xGghawMFxBTyDvGksLd3vsrDtCrpbAe9+8PWLruViovfIfh022rhOogMd?=
 =?us-ascii?Q?ummx3z5bI214Cn9MuDNKZNcHSxVkYraD+JySR+N+JXUFOPVFMQOkmfA05pDz?=
 =?us-ascii?Q?9azcQfoExLRC1VVvYWcPTPowayTBn85meCSLXa+YbmnG5V0V5HqQoguRn+eB?=
 =?us-ascii?Q?si0lTRicw4fh0iHB6cJbSUudKcmZf+BdJjLTO0Wc3o6BcU/wjsBFqz7dwx2b?=
 =?us-ascii?Q?DadetOZ4WPLJ8ZpKghxRoqt3ks2ys0ezNOLwU9yYDX/SkRN6OsvBDvdSDPcr?=
 =?us-ascii?Q?BpIs1szb7MIYA4xt/HASUQ/XHoXbPbuz0YclFwKa+f86swhDbvk7yq7M2KVj?=
 =?us-ascii?Q?VISN59RPJJQVa3Oo/MtHtmWUawXPXWcpdPWDvFi4i9IiPdzVqi9TgApjd8jw?=
 =?us-ascii?Q?TpuOU95FJs/Ej8Mi9tnGZc1fWrqAwHZOWGiXF6QnkpmK5huQKtpLkAU35eXI?=
 =?us-ascii?Q?48qs4lrlW6SIkD3wtwPrH+ICp3uRNS6rv62l6KemLspMchJ1qUsh/z25dh4J?=
 =?us-ascii?Q?6d2l5ow4VBPU8cn+NF1nGmpWphUadLs5FQCjYXQ9p1hbRzKrSb07OKgdMCz4?=
 =?us-ascii?Q?sCR9vKz4rk1MJEK78OhuPzjtebLd0T+2709J8F4daIUmbMLDc8RwV7NNdZ89?=
 =?us-ascii?Q?2mzCTVDAt1mwKLscqMsI9yoQywIeVz7PMI7F/AAzZe2Qas5FA6LSHrR9u+7I?=
 =?us-ascii?Q?Rg/ogGhS4IIW/gglWtcOm9WkluiU8NuRV5gPjIkrlKyHxMi5SObGAyInkrPU?=
 =?us-ascii?Q?n52N1mSTQFkifl8UakWQ1jiHa0eJpLCt48Z3vnII+zxY5ctd3+rWc5gVIcAe?=
 =?us-ascii?Q?e3onMJwgpKsdQyhNTkSokZcPE2aZ/OMBjLNcqmhNqvdlnc2EqEHMhfHGdDp1?=
 =?us-ascii?Q?Yuwi6pP2oUqV8Edh7SC3nZ8sovqOxkH1o4FVBg3EocTf1jkJI3gIJdG03jvq?=
 =?us-ascii?Q?xwe0fxuNkzGjPPnO/PSBAveGCaBDMsQvbXL8bPmd2nR/+jyHLqLvRf+lBNkq?=
 =?us-ascii?Q?/EYiwRWx/TyYpPwxrdaW0LgsJYQJV5JIs9ceIa7ZLL1OKgg7AGTd6jXk+4Fc?=
 =?us-ascii?Q?aRrc6R46ZB5z78WJGIdprG89SXkRzgLcO2mzOImd1KHgMildSRpYkf0EUvhL?=
 =?us-ascii?Q?R/UbZeJE4Kk+ceOnElyzDA9PkGsMnQ41RQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qkwGmXeogU5vmmqCNtjoOPLlSRRzKhQ+egG4q1amhlw8OLGkXS22JRvki8X?=
 =?us-ascii?Q?kT7iGvyLqa05YBywvRDbGsMu0iDgI2wZb8qkAB6wJiuGa3TMSmL47Ak43Ui1?=
 =?us-ascii?Q?NTdV2+KoLhkyfhG1dgypByxweAZxSjK59Aa6rYw8fWZx9uACyyxoHx/kr0bP?=
 =?us-ascii?Q?IdoCm0HqmMo7d54UAX3cC7H0IsuMUxgTKaNAwlnzsoFSOs/RbzWrsSG3flu+?=
 =?us-ascii?Q?e+yR/xsxmmmX+/xgKeU7MveAhLvc5Phax1vBilclt2yVIMbYSI+fdk6Kgghm?=
 =?us-ascii?Q?zQ51uB2TNHNtnbwtEWaxKUsGej0E42bZDi6s1bY2SUwhvzR2vEmU2XWb60EV?=
 =?us-ascii?Q?HyIRZ48IzFNNLWFLd8Dm+22VneSpvxqg1KAtSlBsNpe1PyHN2/15eoQY/Xns?=
 =?us-ascii?Q?+q0zL87xAbj6q1MNZ8+ldwEzHgy1cbpxeMSJCg6LifAINy5odUyYIaIMOKs4?=
 =?us-ascii?Q?bwYUKQllyp6XDhmlx6Kw1y0q7bXzZYG80ytOdVifH/9m8GDF6pxHBOKou7xp?=
 =?us-ascii?Q?Bg/CVXGsuInJwgOSGkXV6DuLlGBYQ3UFCa7ZyZ270jHCev21Z27KFKTG0hR9?=
 =?us-ascii?Q?wxEfYOXwweeZplGKwvr4TBPYaqnuZ7RylGAYFbn+a382eE0aI9cb9j4Oxrxz?=
 =?us-ascii?Q?vjS0CTfIXRSJ9CCivlMsaLXCu98rRRNsu4zg+iS2Wfj178HtrUpQ3Y2Pg9Ye?=
 =?us-ascii?Q?IMZGpKIw7T6uplG+/mqER3xCsBzfHwNAY4Z2QUFjyCc1B2B1atTJ2w8aTgp/?=
 =?us-ascii?Q?G2OhJcxPBOzqXVF36DSJepyENgFBj3/Lkks92yW+CCg/1nAb64fh1Mn1zdwj?=
 =?us-ascii?Q?TGPXqi8GB8vnDDDQ/waQrUh12LMT0dkuNgHt3DVymYbicjUcC4MATOcPNQVz?=
 =?us-ascii?Q?3Kuj7gBalEIOTJPL7xwFx/L5BFOT4uX9gBvN6MuCprFIQV0GNh87pLAISJG+?=
 =?us-ascii?Q?iksZwjp9mjlrRk+98b175vIYwqmjenJ4Gt8d5A2otZbVoNr9QdgUB/1OExcC?=
 =?us-ascii?Q?X+ei52abdVOVqV1uLFB6vY47a611do7LwOopwz47b3HFBXHI9ItuJaOY/DP2?=
 =?us-ascii?Q?Lz4U0MpDTqxBHjaaYDdHS3AFAJkHk+adTWGpodqetbKrJvxiaytRDGB80/m7?=
 =?us-ascii?Q?qpKjqaJXwIrU2Qkl785COkqAsrFlDqcX3W0ZUAo6h7Wr45taiQ+onrz8fO5n?=
 =?us-ascii?Q?ocblT2i+CZZzhKOs+YgSbx3LzDXiZAneTXDw+EStHHkhP9AbkPx4x/1qjFY9?=
 =?us-ascii?Q?27jK9z4VQ358o4zoVBBptSiQucSooHwrZ+y9wD8ztyUB/YQH+4SVNYnvVaNq?=
 =?us-ascii?Q?LzI3jxqs7pSFahDxRyC4VbYhPoqYsMP2UzcjDqnzK+YWRToB/3RSq8R6Toht?=
 =?us-ascii?Q?A7Z6hk7PKAhcrIp2Ahel5q7k9vsmadNnMb38sK0oBTiREEPCwgUNyOoNE9Bs?=
 =?us-ascii?Q?mQif/+71zrOMcA3byDDXRrohUdiwtnAT?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a73dead2-7c5c-47fb-e416-08df0b7d1dd8
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 18:40:11.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF5543EE396

Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
about the number of elements in .hws[], so that it can warn when .hws[]
is accessed out of bounds. As noted in that change, the __counted_by
member must be initialized with the number of elements before the first
array access happens, otherwise there will be a warning from each access
prior to the initialization because the number of elements is zero.
This occurs in ac100_rtc_register_clks() due to .num being assigned only
after every clkout clock has been stored in .hws[]. With
CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
during probe, and with CONFIG_UBSAN_TRAP the first store traps.

Initialize .num with AC100_CLKOUT_NUM, the number of elements .hws[] was
allocated with, right after the allocation. That is the value the loop
counter ends up at on the success path anyway, so the provider's
behaviour is unchanged.

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
CONFIG_RTC_DRV_AC100=m forced on the make command line because the
driver has no COMPILE_TEST option. GCC 13.3 does not implement
__counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang 20.1+), so the
build only confirms that the change compiles; the sanitizer path was not
exercised. I do not have the hardware, so this is not runtime-tested and
no UBSAN report was captured.

Based on v7.3-rc1.

 drivers/rtc/rtc-ac100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index bba7115ff3a..a2f465438fd 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -317,6 +317,8 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
 	if (!chip->clk_data)
 		return -ENOMEM;
 
+	chip->clk_data->num = AC100_CLKOUT_NUM;
+
 	chip->rtc_32k_clk = clk_hw_register_fixed_rate(chip->dev,
 						       AC100_RTC_32K_NAME,
 						       NULL, 0,
@@ -360,7 +362,6 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
 		chip->clk_data->hws[i] = &clk->hw;
 	}
 
-	chip->clk_data->num = i;
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, chip->clk_data);
 	if (ret)
 		goto err_unregister_rtc_32k;

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

