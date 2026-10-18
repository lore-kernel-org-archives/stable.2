Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011015.outbound.protection.outlook.com [52.103.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031F2ECD32;
	Sun, 18 Oct 2026 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301193; cv=fail; b=hgno7Op6lHGxnlUNfpolk+E1Y+Ip2EOz9WoZyj24DJh+QjvNDxDIglVO+H7VT+zsiTGe6zf1c8nQ2hC9xyFmAW2eRpnxlnN5HyBChoR1qLJ9MovNlstrvSP3svz1yKJxr1aI+NsgZ9UO40x/TK5GJVgd8zF+e+btziilgCM2R14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301193; c=relaxed/simple;
	bh=VSe5MHtg4HrCaX8m6FdeGoTqXlRZiEjdtIOEtV7KJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VR/nFShioLbq46EYvuanSc9LHGMLdW14vUesZuwn7JhSdVQnfqoUao9ES6bUr3ad4+I8j3QX9i88vQ4Elds8E7Fa97bGurAgAPhvigtpIOy3b+ra8LHoNKrFZ0TZbeemSOK0ExvHjtvP3g1Nv9JYvTdll98C+KfJP7IfDuSCwKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oYBm11rl; arc=fail smtp.client-ip=52.103.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oYBm11rl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3WV2Mq1FldN72Ch4/OTx6sYWz2s8n1/jQLZRPGCIdOkymMJw9VITpBRQZzwASUDZUdVBXZ7ah+2S5bRoWo1rNwNc7VCgKxijez4Xi8K/QGO1XUNlo6BUziEATAEJyYvAPM52p1y2A836zXne8h3ue5chF2+7+XBLG+1QyVKSV5dJPrS6Ot/wfoAK+rnF6/yk8XP61Xl+VoLdNHuGMoyGT+NsBWASH08v5DsWDZLdX/nD8mg9H9FcmolI9f4MOMl+m7KPbwiVX+PT9y9HRys3cKJm8A+4+AFqMSi0yDajyYWh/ububscMd+vvTv+RC6EwsU4rYHKodsY231m+KTOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfVdB80T5wB8ZctlTht6wW2MsiYWi7kNTL0295YksAI=;
 b=oTgDiqSb56Y3JZiBulkI1MtnDOvlepbWjrhC8eQkMqYqCbvd9mtuN+2sR1LO7Q1G31yUiDRijUW21/d+5pgpRgryBQRfpB3owBN8VM46wjr4wqLhYqf/8jJCh/fPs+ua6CtuqqwkY07urlOpcM251aVva1ZQWeQe7wFybYjMwBPKPUjkReyUpXKZ+bCu3OaO/IFoJWAkmymxXloUmBPQy1tbatUFSlcvvCOBZk0ZHaKVctFvsubpKISQPIfd+MencKDPfDmQmYvPj2h37vKMBv4npLBIdi2XuvYCLFVg0bK34LPIpZl2nxulkrwtKSNK40ypZClKZLXFpX/kDExt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfVdB80T5wB8ZctlTht6wW2MsiYWi7kNTL0295YksAI=;
 b=oYBm11rlBO/HRaqiIJRDYD5lH+BMAfaSsyT+aaE70UHE9fq29wxoOw8aZokom0T0YyE9LFzWEsPNK9JMFt3BpE/DwjTc2Ak6gmLCQd+1a16ZCUcndD86qSs7AyVhZdBA0diWYTJestvTJwKDWnXIzOhhwVNgwwSFZhaIdXkmtPDz03h3YVfKxamV/w2xZoR2kHAlnm2zU6Q438a7FsF2v+3pCPk9ION5Xe+RPmPnGgXGL0TJjTC9HE9prAUb4xCdTEXb9+r0PejEOz4PsBxoo5cjAPNDeFig8aCqcjCWFngCpJmdLAL7Gxz0grHEKyvPt1rpnIe7o/3sRKr3bmC/yw==
Received: from OSCPR01MB15019.jpnprd01.prod.outlook.com
 (2603:1096:604:3ab::14) by OS3PR01MB7970.jpnprd01.prod.outlook.com
 (2603:1096:604:163::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 05:26:27 +0000
Received: from OSCPR01MB15019.jpnprd01.prod.outlook.com
 ([fe80::d06:4844:6b2f:9fa2]) by OSCPR01MB15019.jpnprd01.prod.outlook.com
 ([fe80::d06:4844:6b2f:9fa2%4]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 05:26:27 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: bren@bren.win
Cc: angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	stable@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v2] clk: mediatek: mt7981: feed MSDC from emmc_208m, not emmc_400m
Date: Sun, 18 Oct 2026 13:25:56 +0800
Message-ID:
 <OSCPR01MB150195AE38951F5CC274ED5B9BC992@OSCPR01MB15019.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017194308.1541507-1-bren@bren.win>
References: <20261017194308.1541507-1-bren@bren.win>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To OSCPR01MB15019.jpnprd01.prod.outlook.com
 (2603:1096:604:3ab::14)
X-Microsoft-Original-Message-ID:
 <20261018052557.376980-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSCPR01MB15019:EE_|OS3PR01MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 1485ee08-dab8-4c8e-cbe5-08df2cd85b6c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|19110799012|8060799015|25010399006|4140399003|260925184616899003|16041099003|23021999003|15080799012|24121999003|22091999003|5072599009|53005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfY/sARqUS+9D+n9e3HVEYZnHh1Z5V0iosPaxwT/TGhnoQBm6WIbAGNKhd1a?=
 =?us-ascii?Q?UU/bC4kWufJeigT93yGxBsbi9NOmXtwj91hZOXRuXEeuXHGoIt+Wip5OQi36?=
 =?us-ascii?Q?K1peQh8denQwdELhHTqy9TGkR08E9hQ2CgAHByapXJAW7/vHLK+3OsDaG/qt?=
 =?us-ascii?Q?5tugVsTgYYRX6ormC6KJ50szMSt3iQv5h1tkagTJmiMe2Apq8UWMJBlsMwl7?=
 =?us-ascii?Q?//8lgkSWe2ZDSLFB6XLlJR3bVKaMHYYGMdwCfp4S02yvvX9GYI7hg7cq4Yng?=
 =?us-ascii?Q?cR6sy/BZ181lI+5JfXWHRUh+t4cEC7sr8FTJ8FgyxQjgouIJsoIQuou+OGF4?=
 =?us-ascii?Q?UpC5RWCKKhUeaYlUZxUbylwf1ay58LHJt5kMTac9MZCxUaBKoN9LyCv2QVWn?=
 =?us-ascii?Q?dH6QNKhKZX9Mtd79Rv7yIwwCmiJRPUOdtae9ebCaehqipulWouaQm2zBBxvt?=
 =?us-ascii?Q?8LtWR+W8vGftHEpCcdq9ufUxP6XgUY235qu0iHJIGbD0KsKRBqNGIyWx4SL7?=
 =?us-ascii?Q?TdDhZmJR7QTB6D3Ttr8+Ve0hJ/z/VhIcX7LP5IWZ8V2WREBvV/0MvLDvz/ZA?=
 =?us-ascii?Q?Fim3UNrDLEn8Ehz9WtnsRazCrq5aagihWUc9zWskDi3g95h3ZuSuC7Zae54p?=
 =?us-ascii?Q?wKMEvtCVWBfYx+Jxzfj9zMZHd6qZ4iEuApz8pOPOxVLSwP4jY/TDyynppW4W?=
 =?us-ascii?Q?z4IOSlawXKVOeLlcs76ajKODrfaP80ivyGZ14CtuvYBHHJWT8PHK+qVPOiwA?=
 =?us-ascii?Q?0lgkt/oo628JstVnfxw87A+POwU606+/eas1qizCkylHPPUjGIdvTOXpArB4?=
 =?us-ascii?Q?BFqCYQ/MW73IQtUEo3XfpmitcrDtLLbssOMzjPj3WVy1Sr2ZZej3DAcbc7+5?=
 =?us-ascii?Q?7cl1FnXaeo73SY6nymaxI3jblc0aGRhQWR9OhD7o5ru8jm9PqhGo7rYDchO0?=
 =?us-ascii?Q?kVg+P8AxutRD0ALOMalA4RzmI2All57yRL38XsZ6VGXxP4IGKRAJ9Yd2i5Z3?=
 =?us-ascii?Q?KH75wlPuIdkK/b3ibDMuU5L9dXWJR4xXR7uSBzBNtktvmR0l+dqPW8FvCxyQ?=
 =?us-ascii?Q?RSlizgzD?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g740eNXfBtsbPe8b5JY75vZfNvjcTBdOOuyo52aA9c9fcdggD9rcqVZudfxo?=
 =?us-ascii?Q?6pamYcN9HZsQHtGHQvQcBsyRws9A4js6S5XlkUxCywLsGWStx+jHH1wujvDR?=
 =?us-ascii?Q?tHRuLYK8A7tfYIeWSX5daJXj4CIgE3yIaaa5fAQ88xWpKUDADlSdeVb5p4Ul?=
 =?us-ascii?Q?t+i7KZL1Vaywq23n2MazKaKHAFXdemDetmu2VJ5AFnPQ0o9PEXDHRZkqtDRN?=
 =?us-ascii?Q?AbVa/dL82EJLFUIhPvO8kdzTPM+vZqJFk50jd+cjw2O47ita9iqyMiYZivv2?=
 =?us-ascii?Q?aB+B4t8Du+6OHLWCkK01VPG8KsloFArooqqjWQWzASb+j1Jpkr2MPWjeaf5n?=
 =?us-ascii?Q?vV/ZG6eJgODJY2n7uM4QS8/j25FjR2A2NojcB3lTGVpH0HqUwy9cFfM+sNR6?=
 =?us-ascii?Q?fHoaOZP5fG5VwqPBs3c0foIEKgBkLlbkZpWAc/muJmOl3kSF9e3NVmjcG9dt?=
 =?us-ascii?Q?2tpabOyfBASgASVxx0UhbvEw4pGsLjOnRn9BlC+I5bUjIf5ecNEHZXACW1Tb?=
 =?us-ascii?Q?5tdqPaTl913UsypC20dO7XQAVtab0nZPoKBlkVRY9YMsPxW0D+DfnJUZxM5/?=
 =?us-ascii?Q?LlCEMAL9q9KARAX+n3NtWrinSNWKKZYeylqcBjLHDiE/Qm0A9F0w1A9pLaZT?=
 =?us-ascii?Q?AbECPBGGpSauBe3AU36qZwYSN4IgcvHio2mccMaGrpODaf4yqVl2Bva/dweX?=
 =?us-ascii?Q?8SmQbb8H0mkUs+ytl5pjHDKQ9cuPqoiUDJENQSY0T4xXWhemfuzW61CInfaK?=
 =?us-ascii?Q?5faNR8sCHICOR1eg8Zx86ylPgQE/jwZvhKuHgZwOgApW4SlChr9nf2vdwRdJ?=
 =?us-ascii?Q?S8b0ly6Z53+qEEhS7+GpSV3jkCgkf8r9c+okBy3c2xOX//PxuILeESL/twN5?=
 =?us-ascii?Q?FLgai2lE+6bYN1RJw+7OP25nmxPyGA35Ydd1+HXkHzC1AxYWh418589VkdUM?=
 =?us-ascii?Q?sQQ1i/y6sZbtSJwksP5lr9lnXtSsO3rMdinVlsCq408izZJPDOhn/yJ8j+ve?=
 =?us-ascii?Q?0OvA60xNo8+pEhYqOx7BxTlqhIu7rnDA2TNJAb6SgrSzZUU9AOh0qXjegzJ7?=
 =?us-ascii?Q?qLYf+zMOgcrjRmxSAwHmJcMVFLy1F01qHL1edfyu9lkjxO7/zqe46w/JtLj6?=
 =?us-ascii?Q?PzCrwTTUCgiVPNdX5R5IQAvkXmvpY73O852rFuZ1Rhv/xkmjYteNoTv0UOQU?=
 =?us-ascii?Q?7Gk+nH0bI0Ht6feNW7w0nnefxSc55tTP1NxUoHhnZ/bFdFSgOhv0ID8bHLso?=
 =?us-ascii?Q?bdkHviXQM3giGcA3NjzgQU9ymxuX+ziwlI00HeGN4h0A3P+s5aoqEDq3yose?=
 =?us-ascii?Q?1GAtNXK7FgOLKPiqI9t50VTSfzgu8OwQtHWRBoycYaugplqYTaAA2w1DpHbx?=
 =?us-ascii?Q?Vjko93SMtYv160ErFEEpoIg5JvwW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1485ee08-dab8-4c8e-cbe5-08df2cd85b6c
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB15019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 05:26:27.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7970

Based on the U-Boot device tree, I think you should swap clock
sources "emmc_400m" and "emmc_208m".

```
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -157,8 +157,8 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA1(CLK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", "infra_66m_mck",
 		    14),
 	GATE_INFRA1(CLK_INFRA_FRTC_CK, "infra_frtc", "cb_rtc_32k", 15),
-	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_400m", 16),
-	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_208m", 17),
+	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_208m", 16),
+	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_400m", 17),
 	GATE_INFRA1(CLK_INFRA_MSDC_133M_CK, "infra_msdc_133m", "sysaxi", 18),
 	GATE_INFRA1(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", "sysaxi", 19),
 	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "infra_adc_frc", 20),
```
Regards,
Shiji Yang
