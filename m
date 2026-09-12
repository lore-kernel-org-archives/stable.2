Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBA32D43C;
	Sat, 12 Sep 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237298; cv=fail; b=QWQV8PYu1s7gJK/p26DIFAfWe5cPVF6hhlR32UzdSsPnmH11gQ8y5fBsdS3s+WDDAXX4zWrcBmGVXs+1hEgi8K9yq7lf25tCUCb7RGN70GueQ8fhdrlOgyBaiXud81oXA/wHB3YxlKC9iO9Cq5m2OqsJcKA4Wk/104b+aVqPs2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237298; c=relaxed/simple;
	bh=QbMxDFh94/vP3rqTvWaHCCr3Sdd8UcOfkahsJxSYDWY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TPKkdJltWWMaq4XPciZ9zoJzRs0nQUKDKCCIGeisZDAacD1dYjXYAK868nncT7onMl52Wtttu8fnD684eW0t9njBo34CFkQd9ZiZuR4BKHNjnlAVwHztjMegUOyPCw6D4rH48FWGoNKUiAkzFPDv1PcI3JysDiTrEsjjjELDkaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCUuHfPy; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCUuHfPy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6oBVfcjlx2ikpO8+aDN1NJcRVJ5EC6nwVvXaHxCShFTWK/BxGA7ArV71qNPQV2S0eRbxuAGbNJyfRbRB4wkAh0f4NJR0vuipF3k8OB8cI9xhbHHqZanE9WnSEj5epT/60n+ihiBeDPt9S8b0rTwgqft9hXz/mVssMadydLl/QCmrqAL5yCrDbB/WRlr55PiYE7Cnt5VtZ6yCi4WyBzR7G38mqqOf5kDP7eMot6jRMW9uttqTiRlsT/OJLnO8X8eVNnd8Mk8uFunkQ2UmqaF0dZOdDuuwObwGlUketE3lXhRuB+duuOwHG2csdHyfxADKQSk9IBumlN/nesiUhr3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W/1+XyEPaXsT19XlWWerq3VWYMsn0y75qVmDPE7wIA=;
 b=AUrekhJQ8PEEEA0azb+YB8Gyi3IquqqvDY7wTmKvb0Mrqk/svdnRJv22WUFgD2VzLPeslp+/MNiq9OZKAUCnDV4W2Xypr5e5pe0fO66Ra2YFO2qHYMB2PhCTWGVr5GRTFHkC05GOboosVtaohqdX5cb6b/IR/FlbJ5KodnsVMx3BHaLNG+HqfzzTsYA+8nHDQSF3IJ6GPbz9Bkn/EtMjXGCiPfy6nwFa6QVzbUtJ4xP//CqPdKzzyt4BB5L5px5M8dH+KUUwYiBH3APNWhRPjcCW23l77ltOz9idTUcJ+WK2BTa7n5gvAXYE2sKkBpG8LP5pp3+UhU6WBFh/nJgZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W/1+XyEPaXsT19XlWWerq3VWYMsn0y75qVmDPE7wIA=;
 b=mCUuHfPyLnmEc7hinoEi4rHQpiNMxaOWrfm3VImFwyp5SInz2dvGpq2hO/bpkHDsiUxLDSpOrURaajLwIICbeG1K/z4ahjAB5OoH0BXKv/rAd5OhkM6DOJXTHsCtXn9KFlsGCTsWHyuCROwzf8kIlJuN7Cvgqj1qydINYbNpD6LeQpdIkcc2Lmw7kerY+t9VNsBiy6jY/TLqZunxK49bEvWUwvhoJFVa17P05xWoV9T3cKA5AkaQiyg5VMc4YllBt+9JjOPkuEj4i19f/F6JG1VNZZc/AYCcgKdov6hQqdq92Y4emG85fcCO1MimjULuRG+I++9QjL88vsdWY4LSww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 18:21:34 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::cb31:7ebf:51e3:d9f6]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::cb31:7ebf:51e3:d9f6%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:21:34 +0000
From: David Cemin <dcemin@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jack Yu <jack.yu@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: sdw_utils: clear stale RT711 device reference on exit
Date: Sat, 12 Sep 2026 11:21:31 -0700
Message-ID: <20260912182131.1156475-1-dcemin@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To CH0PR12MB5089.namprd12.prod.outlook.com
 (2603:10b6:610:bc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fedb103-080d-40d4-1dd7-08df10faad32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fidbXFT0qEDX2WKlD2cPQJ0cbiOgoSOUR7h5Frq84gHQ/n227EhGtPV74oiwSFXqn6wuB4FN1KgSG9WKMPk3t8GqTHaiGiH8L2XWTGgJaW5DK3JvysE+Ot5kdFjXzf6BeIxiYj8IT/hZaiQTcD0mz5EXXZv2rDapxV5Xd0zVwKBmkoxI0uBKnx3xHaDyUPKRJ4EQfR264EoRdQ2SmjT2bKEr6EIYnIYk7LqShZA1V/FZsvVFbc+cpJB8fmNzUqbCqbeCNSfNtQc+z9ECEFCvkudkups9PxwOigi0V0s22WHowNeeZnNpDPXmIESwqNpORy5z6k4aoRDL8HYTF9bXwBvsRulALr0Vwr21nFrVjFz5lrP+L+kaqvp2kJuIEQVvGLr3UZ4dAbwFbqeRcgewmJVjytzC3hMY+tIfgtnmh+WuqJJlWbWoDQ5ovFAbbz9cEh8OzfBEm5SyyiJwxciYmMSHdIywoXTBzfs2yHM+7mgFwhgSE4yLCQki957s8O0S6cB9myH8NaZRLOO8ZU3BKNuy8uQSRrtvy11PdOZmJzIsnVlwlAgFtbAc1DEWPccG+VwA7adwSEo6CwyWa1TDI1e/g8WjF6QiuMhbrDJAmjJpwUpN3MUPJuMilPpNPC5/JrHC2qDRo7bZvB6rUePGYJv/WF70T5EyQtlP/auOA4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDDxinAMB0WBKKJQI2ktMiyj++3Lf9UHgmjRLEdqWFqwKcEiPEBvo7lSbcbp?=
 =?us-ascii?Q?67yvXkz8A6fxL/ckDHmTHShMlw7O50jIEZzAJZVKuQHZm5Roy+7FhrqcmalA?=
 =?us-ascii?Q?kTtbMEAxITeK8QzpP1nqnBWmUHyZ4D3NIPz75ZiW43BqXsvm5ggws38Xi0Jr?=
 =?us-ascii?Q?qbOfxrcbiZTQ3ezFWaOYfGhqL2OUP51yQDkBoBAJ9NvcJlQnzes/YlbuFyCr?=
 =?us-ascii?Q?7xRL84f1NDxkzC6KKyMVffs0m4JIm0VubUCXj0HWFIuc2Xm6cuF2f7mp00RN?=
 =?us-ascii?Q?+sMf3w8qQyGcZ/rty0raBz0f99Xap7ngYGTUwAuNK8ElOFpsAUR3GlUzOUaY?=
 =?us-ascii?Q?9VIu1l7XvdsAs7tX58aXGK1qBAXQOME/5SeONO9LMatS/3X7p1EgGBbgxmjx?=
 =?us-ascii?Q?5k6FIw5oFAIy3FPqFmvvXUoxj0wmq0/JmKKg2JDZiKeUgoEGXxoFVwb8ADud?=
 =?us-ascii?Q?kPsMttPMHQDQ2cVD649P5069AE6BZqs17982+vv4CDjVLiwFE3eu9CkXt2CL?=
 =?us-ascii?Q?N0FFGg8mj1vtmlSeHNlsRm1/9mnXfrfJyq9Ralg113R076tJqTHSf5azjlAh?=
 =?us-ascii?Q?iDx2RHsSmaMA4HapjETtv16HHVCF++MRXFRhh9bNu5L3nY19biC9bhBefBCq?=
 =?us-ascii?Q?BL5oPD2j3PkG2ogdCzAZpNZ/bswzZizG9FbIInxDl3PJ3p+fcVguDeoOlq9C?=
 =?us-ascii?Q?3mKK2UvJ3V9/wJXmGWCQ/GeWBPtM+zQ6OgbM4jST0kngtXWl1YYF6PriwDtQ?=
 =?us-ascii?Q?CkGAagegEWNOcoZm2uIlA5R95rWdh9gOOsxEjMFlrvR7JJH/ykbdcpkwfk0u?=
 =?us-ascii?Q?mHjiq3FqiOjriReeLDqevqsDaQeQt6bPLGbreSAmddIfHNj9H2enMGEh9Vxz?=
 =?us-ascii?Q?8vECH2byIPXS3VeRyYXXXhamvqDabohg5tnfCKd9rmZEtZZTTdGH+sIKv+cO?=
 =?us-ascii?Q?op8inIFURIoXomI8EFUE1X66kdeFYKbS6kZA33O+r+9735hUNeQajVXgSRgG?=
 =?us-ascii?Q?AXJGLKl/nsA1yx4fC+D30FK/RsmAbeXcWyV52ey9xgaFrGlKA//H12idWW0l?=
 =?us-ascii?Q?sOCQihLNZjrtopQHD2zNfYkwL7InHnXaC0bBfX4jX9Ztc++NiFKqsKuzPMkY?=
 =?us-ascii?Q?6SAFRGiGJp7oh+uqoqO1TyjOYo+hrBq+XM8SrVHHiqeAGh/M+kVWEpFAOnGn?=
 =?us-ascii?Q?u0bg3ZyL71CER8iqj4CockTzkdxtJrwDOXbvq5I60ZFkW/eUayQm+5Mt7KqX?=
 =?us-ascii?Q?zOx0X1gIaTbND3Ume/sZRg9uuCgBdlBbA6BSmtFxj7k9MIf4tnhFmxGmavya?=
 =?us-ascii?Q?zRuBrUg0RTp7O8uvXSuRkcUaUyMmATLhLbUuSwAkZv2Yk1WQTOVZU/DbzqIm?=
 =?us-ascii?Q?OcLHzoVdxPKz/rE2JVOq3f9iJj1PpsFQN551PO0LSD7+buXHM0gq0PloBtqG?=
 =?us-ascii?Q?vzfnmrm3sMeqXMPgytcjyQFPic6uD+0GFozaFJa9kQvqXlA4rtgQH1nv2uJo?=
 =?us-ascii?Q?kqHly8P4R5G8069TrM80ZLvN7kpWGepgMHPgwhDXuaUjdApy5WqTjKVRKdTl?=
 =?us-ascii?Q?jXGYMofx/i7im3ZBNbpDC1BYhGL8FVi7UyC1yzu/OOe2cJlRb4zUfyoTmcL3?=
 =?us-ascii?Q?pcKl3BDgshEnS4X9W+0+JfNZ+behVW/V/driwe9o+IpTKc0SacpwSvldN/VS?=
 =?us-ascii?Q?c/MaO3BoxIBH3H7ZbKBUn75W2RTRZ5b/GePv+v7B79vQ0R2I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fedb103-080d-40d4-1dd7-08df10faad32
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:21:34.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny+8M8Mi6+UxhMgMuo+BkZkyJegYRl2xLar/MKU6njB6J3TQx4N8nRMQw7diwE2WdUIcdmOOFbJ4Lr1JtIDyBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

asoc_sdw_rt711_exit() drops the reference held in ctx->headset_codec_dev
but leaves the pointer populated. If the card cleanup path reaches the
exit hook more than once after a failed or deferred probe, a later
invocation reuses the stale pointer and calls put_device() again,
underflowing the refcount and leading to oopses when later probe,
driver bind, or suspend paths walk the SoundWire bus after the device
reference was released. Observed as boot- and suspend-time oopses on an
arm64 platform with an RT712 headset codec, reproducible
deterministically by repeated machine-driver probe cycling with the
codec drivers unloaded.

Clear the pointer after put_device() so repeated cleanup becomes a
no-op, which also makes the existing NULL check at the top of the exit
hook effective. This matches what commit 046173b98de3 ("ASoC: sdw_utils:
fix double put_device() on aggregated amps") did for the aggregated amp
references.

Fixes: 811648340707 ("ASoC: Intel: sof_sdw: avoid oops in error handling")
Cc: stable@vger.kernel.org
Signed-off-by: David Cemin <dcemin@nvidia.com>
---
 sound/soc/sdw_utils/soc_sdw_rt711.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_rt711.c b/sound/soc/sdw_utils/soc_sdw_rt711.c
index 3a3a66b4b737..4707190e160c 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt711.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt711.c
@@ -124,6 +124,7 @@ int asoc_sdw_rt711_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_
 
 	device_remove_software_node(ctx->headset_codec_dev);
 	put_device(ctx->headset_codec_dev);
+	ctx->headset_codec_dev = NULL;
 
 	return 0;
 }

base-commit: 841e384b841a3d89c50b4b2d6c5bb6abab1a7e39
-- 
2.55.0

