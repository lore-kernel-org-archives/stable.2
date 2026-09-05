Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013082.outbound.protection.outlook.com [52.103.46.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EB14A619;
	Sat,  5 Sep 2026 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641332; cv=fail; b=OBSz+OP6E58LeldAmBfhLY2MfvtL/vJ1w67R6ZRHNwxkekZb9F6iq7ncX+CH4eCYfOUoYv5tDSGcZb+oZVR6qf1RHmEFINsnsKX5SdWrd7pwGR2MOW3oM7rt7IOH71iZKed8P/JTGJdFaUX3++SJBYrYDyM6JRb3nKERmgR2xnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641332; c=relaxed/simple;
	bh=FvAyqHkIs1Ip1ZyiBgkiYkt99CH11L7+DJSEFS0izxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fFUAIzh1yrkc3aDnSDX1d9NxoNxBeIPRXfMEAGYj+7LbjABStpku0a4eCT+0GQesSH8m3eDrS7xUz9rjFpOm+RlRz7lR0bqus5F1RpXwDyGpdMMWuhbaFeItzt/OCneU4C/2PynR2fC20GSw6Gosfg5XgvI6lCAKVczjfCaQCE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Ek4POoIS; arc=fail smtp.client-ip=52.103.46.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Ek4POoIS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avTVLb0h+Nis2iaNvbl+pPH5iSwlFPVUeIWWtybvgg6SPuyG+0CjNkPxQKaGONEZamWQ3z8IQ0SuBaKAg596QzkZKZ29PRQ4GlVexZiy8W5qYoKwPVKGbKmvum3+ckROsepYn85uLJ1DA0IitvhZhNUDNGype0Nl0OnXNTt+BCm1y2UUardqJ/1NaNQ4mppngGPGbLWegxOYxiUiKQw4RLnMcV2Y8n2z3dkXgRiZvdMqBg12xOqfa2lppW6TnkdHUKM+x4jNVWFYmGFdXOSgIVHjMPaXgO59IC1ybYddp9WxqsXQYV2BdDDI6bz4+WBThEvuYX0FclTCD3FBknldpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tegd1GECJ9D1sJrLs/B9DOHmTKY2wOxS7gCgv9dsjag=;
 b=iwAugbwkJtWepU08PiFp5j07X5QCNcv67y/MyiRvI7pzrOKLKUPn1RzXMFxkiSm20/hunGNBllSr+rXJv4xLGmzuc223ahiPwko8Uad2Ek5W9o0ycS53KHuZDlGOZQi446Ty9euN1H+8PA1R770U1bbYQzrT1v78NOE4olEN2FsHWzZ6Nsc6SMVh9lAPXoWGHkLLmQjVGbojIoLqYdydo0JB2Y4J+ItF4THQV8oZLUm6px+KVoxKB8MjalW2MKjGjLw8u49bmIhdHq9UKX/XTTyyubStCrrBHXPPw+BvfLRnvvjAfKRPoyJbE05iDnTLMgM9nvSQH2XQzqZ4EcfF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tegd1GECJ9D1sJrLs/B9DOHmTKY2wOxS7gCgv9dsjag=;
 b=Ek4POoISXWT4xgpdaGp/Wiu9nB+R2C+B4pDBU5eXf3/w2B+Ksl8HCpX8q/QKvWPhSvHc6VjmlUyvbTtyLuYOZ3q5+zlM/HGpoodPmZCWxvVoLV5JD0G9ODQ11VAbwZp4VDIAelqfFREzH2d31+scNJbFtY0g0HLCNDhoS9Y/23PJthgEtGNLhtVCXQnliuPJ2WZTLUMByyIVcSTJVgKGgdzGuTzPTUIa2Tm+E9msJe0g/UGC118oe9eRU3PvPvMyOeAVyaTRG0opG4jRG0LxukxUpjmfmUsOlgt15nWW40XjLCI1FWyYTVAs74E0HPlK/fZ2p2njDBcbWVYyvrBmPg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PA1PPF75DB7739D.EURP251.PROD.OUTLOOK.COM (2603:10a6:108:1::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 20:48:48 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:48:48 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] interconnect: mediatek: Assign .num_nodes before accessing .nodes
Date: Sat,  5 Sep 2026 21:48:46 +0100
Message-ID:
 <AS8P251MB00010F5EE7878E15AF0E49F3C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905204846.31973-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PA1PPF75DB7739D:EE_
X-MS-Office365-Filtering-Correlation-Id: b178d9a2-bc90-494e-bdd1-08df0b8f15d8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|5062599005|23021999003|5072599009|15080799012|25031999004|37011999003|41001999006|8060799015|19110799012|25010399006|4140399003|52005399003|40105399003|2607281247196008|3412199025|440099028|26104999009|19061999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRAdEVm7dvy6vtTfHRcjqDruyTrqHOCCEcFq1cs5q2dPpZc1c2JuZuQ+/FyC?=
 =?us-ascii?Q?N+maEEfC6GwD2GfZP5NMYIt3PKm0VSqT0swHvOi5sjdiM364Rk2iIT4p22ZH?=
 =?us-ascii?Q?pGbwQSaWLQSph9lFCKVxB3LXjPOnjJzrcV6FnoDZfQOIrAK7bDOq5XvPnrA8?=
 =?us-ascii?Q?vFwXDNKdt8IJftvvHNYCzMfSRWUh4U87EdR9hx24Iozad/zN7Ih/nEQJKmN0?=
 =?us-ascii?Q?QqluHBeca3bkWefJPLLWS/TMsTYl4YVjalv5wD1GaKqZVqrR6UJ1XCWE/AA+?=
 =?us-ascii?Q?oYuVsZMXRNN7051sVrK+L1S0HB7zMNM7uGkMsi6kyc/aQ4jg8TcFra6Fs263?=
 =?us-ascii?Q?+XiSiTsJeRC53Kd6jDBElmB/jigt5vyt6KbBk0rih93XWBdvUmUpiD3uEIAW?=
 =?us-ascii?Q?1K8BsP4wHxrb2DgzX2BjT4CrfgUqThD1w9G49WFAa6ZATwc83Dur1dzpjyGr?=
 =?us-ascii?Q?e1vFleYPbjl1yQTz3WTZBK+yUeGnKcMW/MPVi6H7SlhSLB0ISQy4TU1Wvsww?=
 =?us-ascii?Q?Ia3mvOOvLJyHUlb/MQYKIoFxncDdAbk/iUatR8f4s3/AJanX8C1r+Q0mfHr+?=
 =?us-ascii?Q?70aCbmUYD/N/RlaPh2Qf+2QwONFkvM2Q/9jUBSmp12ExmcJhP4mbeCeXyHL7?=
 =?us-ascii?Q?73OnVxkxChgWXS1kD/tvi8bWn+4XiIQOR9IJpnz8B99HgFNYZMltzZQIyPLJ?=
 =?us-ascii?Q?D4w85rzUzgQUEkfWs32ZJUxU091mi2/rvGZTWs6SLHJr5HhQtaqhB1Z5+vry?=
 =?us-ascii?Q?NFyZbLFK57R+SpQSHh1FQ8lrQA06RmKJ2iqj1lTx+tfpNjN2/6fiSzcJI7uM?=
 =?us-ascii?Q?rBl1aquRBFgDaSl2lYaJX4awfctKMk40KHEWco27Pxsc3SuTtTnpC8OLYx3a?=
 =?us-ascii?Q?YfxEzB1UlOBVfN7YqtNzUCPa4ffZCjYKQw8dDtJAjHrc1DwR09Xy+7WVtAdB?=
 =?us-ascii?Q?MF0i6BW8Yxg/KlY7TWP6MTBedVqu49d3Xddip1JqwJ5Yrc/zUD8Qjk7aNlRz?=
 =?us-ascii?Q?6D8mYpuYO0yjg1LifwEFYd0vCz8NZzfXNHO5Zb7Zdu2STr2go1sOJ6/XGeVw?=
 =?us-ascii?Q?1Keo0AcjXU+O1rLlFXEOCIzIYmyyrvOOh4DlTG+PjfCBs7gT8QZcYrZ7vZWd?=
 =?us-ascii?Q?SaEdW9aM/3c4?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOIXuVMssia3Ye0nemadkTpN0guVfP3row4pc4NYJ8zPAk42AfMbafforJEr?=
 =?us-ascii?Q?qw+q+8m0qqRELiKaQVh62hjsH5VCF9GAvfWPGK2CTmTxavFKrJGTOqgt3E0O?=
 =?us-ascii?Q?RWMZjVQ86x2heyVAuvOf9DmVVcDQ5Yal+cbuPbn6SjBJUiafIVSDdpkrYVfn?=
 =?us-ascii?Q?iWiM9euBHvDgPp0C9c3gAlgg0AqBafJuwpc2NVPqf0gOxrIzSV8SDxHK2XRa?=
 =?us-ascii?Q?i2wqrMQ/vo1r8+D6nyGGs9+a1vsnnAV4V3/nq2h9bkojJ2lFOLIU1Davu6Eq?=
 =?us-ascii?Q?P514hl2sKvsdDX5uPnBhb5dYA/1ktF/tM+Tqmdew341ss7pAJqY2430HuTXA?=
 =?us-ascii?Q?NDDz0wL6srpfkNhThwdtt+Re+8mj9ddiByAUJAlSeUwtdz9PvprNw7CZ/8/F?=
 =?us-ascii?Q?eyqDMXNA2EGIF7r/3xwf2GXZJ1i9jERnziaZ8qVyfwK/D53ByqJmllr089cg?=
 =?us-ascii?Q?i3yq9ihn9vctQphg8ARlvRG3X6wFL3bXj7mvX9GtAl9rRc8+5wG1LsWX7Dh/?=
 =?us-ascii?Q?VnWh/7a6qFy3wVCB4lt2mEQNzt/AFR90d/0L+VXdCPvcYVLf/+wFhbuLWsi1?=
 =?us-ascii?Q?EUv7IA5CjeE5iT87lj6bbJo50DLaCtMZC9S23NAEgNVmFFTSNcPLzwshEalo?=
 =?us-ascii?Q?RVOV8ZKImWnLfqBisX5XyjR9UnKGW/x2lmly54z/7LTBXgKhPqP0tC0aPh6C?=
 =?us-ascii?Q?MSexNS74Zv9h9ueWZN61QDGemRZwYNWSyo12y3AR3e3ZgbNFsyD15VF192pi?=
 =?us-ascii?Q?bweo2lprILqozVrQfxtAfpNAinRF3OvKkGbx2Al/motJr7nDy/rYWP8lmNbW?=
 =?us-ascii?Q?BOpN84Na6l7K5V36eTZXEKaD6/us8D9afM5eT9VPizJlqDD8XHNwjdiqMMIi?=
 =?us-ascii?Q?+IysTjzfuNXj9YL1YKv1v/rFaES9Xs126E3/OEx7OKVrtyfG/YisGRmkSE35?=
 =?us-ascii?Q?ur/0DZAq5ns9esmbPRT8ggnEbIOccfpcZknfKyibVmQthxmFg6KUwZzmi+C4?=
 =?us-ascii?Q?DQNqNwxAKhXocJCSZtM5BEJLGPgrh5c+wfPeyIQ6BNW3ud6A3Ln5WC2n92XU?=
 =?us-ascii?Q?lipUiS7inOCx/hyj+Jeiv/V6LNyEfzpdRnsLuVUJuaRf51T0/zE2rZeT1Vrz?=
 =?us-ascii?Q?njPUSS94rI4zQFAf1l1MsjwJpU2y/+J+sWKvMKjrbI6/lKWqZc/CI54rI9wg?=
 =?us-ascii?Q?sl6KLX0Vi7XB4lq5Al0j2unedDOxaVGymzdqRlsdPBvf6T/PrDvxJtNncYrm?=
 =?us-ascii?Q?SHS/nyklhre8pGQh1Olb58iqAMCzcJvBtMe53a/Yj95U/tZU2nrMpQ1/+nt8?=
 =?us-ascii?Q?jkWTZOclIpVrsD63soMCMOuBWpFTFr0bOlJ+wSVb+CdvzTEUVR1Je8Bo5Op+?=
 =?us-ascii?Q?Dk3Zj4zEchsQ3iIswR+DKQVjb96u/mWo0RHio5nMmDXiNh+KYJ3evmyiBNL+?=
 =?us-ascii?Q?rHn0C7062BRGDK1nWhA1UJYLfn3Gr8rA?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b178d9a2-bc90-494e-bdd1-08df0b8f15d8
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 20:48:48.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF75DB7739D

Commit dd4904f3b924 ("interconnect: qcom: Annotate struct
icc_onecell_data with __counted_by") annotated the nodes member of
'struct icc_onecell_data' with __counted_by, which informs the bounds
sanitizer (UBSAN_BOUNDS) about the number of elements in .nodes[], so
that it can warn when .nodes[] is accessed out of bounds. As noted in
that change, the __counted_by member must be initialized with the number
of elements before the first array access happens, otherwise there will
be a warning from each access prior to the initialization because the
number of elements is zero.

This occurs in mtk_emi_icc_probe() due to .num_nodes being assigned only
after every node has been stored in .nodes[]. With CONFIG_UBSAN_BOUNDS
and a compiler that implements __counted_by (GCC 15.1+ or Clang 20.1+),
this triggers an array-index-out-of-bounds report during probe, and with
CONFIG_UBSAN_TRAP the first store traps so the interconnect provider is
never registered.

Move the .num_nodes initialization to right after the allocation. The
value assigned is unchanged, and the other users of struct
icc_onecell_data already initialize it there.

Cc: stable@vger.kernel.org
Fixes: b45293799f75 ("interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Found by a tree-wide audit of every __counted_by annotated flexible
array whose counter is assigned after the array is first written. This
was the only remaining user of struct icc_onecell_data with that
ordering; the same class was fixed earlier in clk-s2mps11
(3e14c7207a97), exynos-clkout (cf33f0b7df13) and clk-raspberrypi
(6dc445c19050). The audit, the fix and this changelog were drafted with
an LLM assistant and reviewed by hand.

Compile-tested only (W=1, no warnings), on x86_64 with GCC 13.3, with
CONFIG_INTERCONNECT_MTK_DVFSRC_EMI=m forced on the make command line
because the driver depends on MTK_DVFSRC, which has no COMPILE_TEST
option. GCC 13.3 does not implement __counted_by (CC_HAS_COUNTED_BY
needs GCC 15.1+ or Clang 20.1+), so the build only confirms that the
change compiles; the sanitizer path was not exercised. I do not have the
hardware, so this is not runtime-tested and no UBSAN report was
captured.

Based on v7.3-rc1.

 drivers/interconnect/mediatek/icc-emi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/icc-emi.c b/drivers/interconnect/mediatek/icc-emi.c
index dfa3a9cd939..c4aa0ab566d 100644
--- a/drivers/interconnect/mediatek/icc-emi.c
+++ b/drivers/interconnect/mediatek/icc-emi.c
@@ -100,6 +100,8 @@ int mtk_emi_icc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->num_nodes = desc->num_nodes;
+
 	provider->dev = dev;
 	provider->set = mtk_emi_icc_set;
 	provider->aggregate = mtk_emi_icc_aggregate;
@@ -126,7 +128,6 @@ int mtk_emi_icc_probe(struct platform_device *pdev)
 
 		data->nodes[i] = node;
 	}
-	data->num_nodes = desc->num_nodes;
 
 	ret = icc_provider_register(provider);
 	if (ret)

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

