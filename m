Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011024.outbound.protection.outlook.com [52.103.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6C277026;
	Sun, 18 Oct 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302648; cv=fail; b=CVZij1t3KYpCWPhZt6p+WyIrd791h78Ll6dN0m5COqvbMKzHINFzGEHgKRgsxpvyr9f9y6LUHI7LCY+dLgh5jnqK+dkv+pifcS/ufNanMIo5xtGrXHJQAzdeAN83orniDcRtPR9UtJPSSqwzNdJfa+xbkNTdK9EB4w29vWEECWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302648; c=relaxed/simple;
	bh=XbC2cGZ1UpjWGUJug7U2VsEiMf4c0lrPMC9qMUiVmYE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g0YIv1VdlikOcJZkiB0qqULTMl4jrot4RBiJJWR4ufBHP0XZfmL3zmXsrURGQfw43JsgjhJn+cKeSMiNz7CeN1N8o/n3UcqhnkIlMVc1ou0KFdnlOrDkWc6GUl6tXN2wc5skv3b4wx0Lg+cy4s8ppiOp5mpEgoX7d0Mc8BgGI+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XLPM6Dj2; arc=fail smtp.client-ip=52.103.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XLPM6Dj2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzFTQFsiI6vzUphKIOgEUl52oo2+YG3yQXSmdhVJX8Sp+j1zOLJFjQvLxIEUpqz2fd4uhA3599IpmpYufnsATJsfVkKKUenB2NqwrhlrI9ntJTB3FR3Q/RGub4maa8pVw6/S9Hu/OOWUD1VPTvqmcVgvjShyZYjRVbz7LDZQEtP2FEbPBh6eJX46bytK4yDVJET7anwJABcnx6W4UwX+U9pnhm3pblz7xcXInRMJcf0VGIlO/aekSn0pTCGJFpLoFWWHtEnM1eTuBgEb4pYLOYa5143M6OuhPY7KQ4IkwOwiZVe6KFOXNBlpzfiRbFg1O/Ngq/5/imry+FJGmzZCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts47byaqRdAmaRd9OdFJfldRcSLQUiLPootRXsnXQ8o=;
 b=O7ymGPds9ZP0dPBnpqcyfUFTg1CtclHQPw8LFT5dyW/5dO9e7Wo8rWP0DPcWuxttW90tVuWiAVHnrePiglO5m5B5n5gXcz87LJXmXTMrRQSvjWXNKeCGlIcIPIKwzuPvNSG5iZof6k7w1OfSYqo78zuAmTiiHwjIA6T7AuEji07ouSebC0mgCS+Nx9beDDXdEUpzQB+WqFx2RDS/4o4rDIIjeahxI/d/JmpZOe9kTZjp/5XPbmpnYpjZafF96CEFAi9NrgYdxkepxrK3mgtvOP27h8TUe6V+wYu9xv6WVVvVhWTvKbScTKS6oHXbPK0dsgB+lO8CrCSZFFqjago2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts47byaqRdAmaRd9OdFJfldRcSLQUiLPootRXsnXQ8o=;
 b=XLPM6Dj2uTrEQIQxsw57pQvf7kIrL68YsZSomC9Gk7Mne/cWpWYLW86VnJgVDuI+cnXWCI5cakf12sCQdnUArHWXyzbNjbn2JV2mUA2ubCc28pQjUl4qvlQvDV3/9poyGDoZH8mtBJte8TsXFRqnqZJGbOy2jvf+cOMKlQOZ4yq1tG2DKPEVG81Rpf6U6+3boNyu9heJUzi6mT7+syHgQKjkNg6qspstbx4CU3VNWPy9KoBG7j/iyTOpcUHbBnshpFCoCsTWPuGaMGMrWOyIlAx2akDY+3SGs6a7l8TsVB+Q3hokXzMh3sN6NNcTArdN4NAKh4lJceADxwpFBTZpfg==
Received: from OSCPR01MB15019.jpnprd01.prod.outlook.com
 (2603:1096:604:3ab::14) by TYWPR01MB10523.jpnprd01.prod.outlook.com
 (2603:1096:400:2fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 05:50:41 +0000
Received: from OSCPR01MB15019.jpnprd01.prod.outlook.com
 ([fe80::d06:4844:6b2f:9fa2]) by OSCPR01MB15019.jpnprd01.prod.outlook.com
 ([fe80::d06:4844:6b2f:9fa2%4]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 05:50:40 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-clk@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shiji Yang <yangshiji66@outlook.com>,
	Mark Brown <broonie@kernel.org>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt7981: fix "emmc_400m_sel" clock mux sources
Date: Sun, 18 Oct 2026 13:50:16 +0800
Message-ID:
 <OSCPR01MB1501934D1DC407B535D78F02EBC992@OSCPR01MB15019.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To OSCPR01MB15019.jpnprd01.prod.outlook.com
 (2603:1096:604:3ab::14)
X-Microsoft-Original-Message-ID:
 <20261018055017.384837-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSCPR01MB15019:EE_|TYWPR01MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1296375d-6e41-49fa-afdb-08df2cdbbda0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|4140399003|260925184616899003|22091999003|24121999003|19110799012|8060799015|5072599009|5062599005|23021999003|15080799012|24021099003|52005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tulQrTOxiciepnZOcTefWH5lc8bLFrBuWxrClrRHofMPFIQDnRWoy49IZ/X?=
 =?us-ascii?Q?ZnltuWNy+JMVt8M33qp3UfBfAsJzqYoWNpLdrcNJdR8M5Tya5LDN5NjxlJWh?=
 =?us-ascii?Q?nU6JK2F7sMkVOXaqSrjdI2do639EUPTZ1dWzsgE0R4C30x7JdptpjBLwoakN?=
 =?us-ascii?Q?vprXBsVD3UVMl/z4lpo3hLcdILMSTBOPDbiw0zoS38CkwYw7mhIzayB4zA1p?=
 =?us-ascii?Q?4QISSJR18ExG/QHP5uYOgRlwlOZ5vZOvh3TdgEudWGggIzQdwoTzY299NUon?=
 =?us-ascii?Q?W5bKJ69VuRfe8NuP7yEC4adjKkAii6ML7ECuPbnqPF2YqvnkIfln6frLaVD9?=
 =?us-ascii?Q?f/v0MF47d1ZGn9Gu4QIxOeGNghVjJm1Z+uFpmPUQusgcly3R0/+osSw7L6Hf?=
 =?us-ascii?Q?UGQ/GNSCYmAx907VO0LtxgAd0fHwjdgZCG1T33+sGmPdPLVza53n3e98qmgk?=
 =?us-ascii?Q?vV3MAosSuIYWdjwiXnzJzzSufx3s8UmfhrtDoEcFyIKrx0ljpRkS9Z+WDcdt?=
 =?us-ascii?Q?oDRyHtATjtHItbzvCrAzLS3mz9R+TB0TpKwloH4e+isJttsaWYErpTGqj9V9?=
 =?us-ascii?Q?YVD4O8DMa1wNdL+fHn7YGrB7tAuS8pMpCyT9yWiaHzM2FeBDyO+eriiy5VxE?=
 =?us-ascii?Q?jShHnMvc+w+eDJ+dso/FeC+M1zasPC64lZLdpt2YA8RXjDyqLeTHVb4M5N3f?=
 =?us-ascii?Q?l9ueZsAapofRoClTxc/Y0s3r7Nn1AL/8IJXw1n3I5bIi5z9HyMQbh7R1T1y3?=
 =?us-ascii?Q?zqyXd0Mipl1q+F11I7xZgFJKVMXaPsSYBfkt0PYQxhhtn/6dh4xkLeW54oTk?=
 =?us-ascii?Q?Y/KLuC/NJp+vab3hZ2IhJyQPu3q7ZDAYLFluugm4DY6tkdyxv2wsXiuTyqR7?=
 =?us-ascii?Q?9Ig3JTwpAGETL/WDpNwzBbF/QmD+cozUjPcvKb4gExMX7x+wFY52tDO/gwpG?=
 =?us-ascii?Q?jxnpOBbkfwy1DFV4qHK6TffjEMXjbqi6ZhrZT1cOUiTqwqWZJp1GD0gb8Itj?=
 =?us-ascii?Q?37yGkqyA2B0By6NClr0cGvIyJWU7sLK0lWTLvq+BYVf6DL6rDBnrdGojxN0d?=
 =?us-ascii?Q?zXa8hUkE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPal46XGttb41n5Aricc2p+WB39ay2pMxN5O/Js8e+MapZ2hhwMjYYCTJ13X?=
 =?us-ascii?Q?1CqMAxmWpd3f8AdJabxgnD4KTQrTSFKSY9IMk+NJd890zCI/J/a8yrM6IslL?=
 =?us-ascii?Q?T0nAGaY+TyjU/h/3TKU3nJ9dbVNpE/uqrnBMzVllbAzTZdoR6bzUEEddJ/Y1?=
 =?us-ascii?Q?U9t04RPhPbugoVy0E5rd0moaB/8fqszGd1VTPKc7grLDGt/vISPXFsJQsj5S?=
 =?us-ascii?Q?6GiY6PB1mTy7dRVVr0p+WN63/CPS9k97yjYP1z+cee2nhPeVp6ZzB6CIYvqb?=
 =?us-ascii?Q?tXUK0wfBu5SzNbOFJf5+fAOl8GeOtQAtqnlqewQoFYWDeFpAO/l9piLaTxjt?=
 =?us-ascii?Q?xPkO9z7sISRDmpWRzYkKbvpOVZkHhKoVcN2cHdn2vDMSuw63fZlJfeRswOE7?=
 =?us-ascii?Q?x0oufjyqG3I1jelty3TrrpUnmcDXiUFHv78B61YkB68/ONWkMIXp7EVJeLAT?=
 =?us-ascii?Q?irRAM79dZx28b42O7gDcw2oSUY7IMUUcvcZmfSZwNpl/RH9JLcWZ2G3TVsvJ?=
 =?us-ascii?Q?NUPe2nLMV7E8UET9Sr+L9CCu95BRdUQl+li4OIkWQJY59+TXP0nqQmgr/6zC?=
 =?us-ascii?Q?6NSJIFHsAFNhvptsidMiV8981myuq9tFt7O48JELv/STCpwNv4hYs0r+ip8f?=
 =?us-ascii?Q?cUBlImeK0OVdVdaB/P+4+fsB3GIR4jBmDIzmx5SAFE2Loef5wKh4o4K3T0rT?=
 =?us-ascii?Q?nYfeLzAXdc5ojfnmz6iF+p38bZLskEOa+NxJa5HkU0boGDDFUdigARibwxXN?=
 =?us-ascii?Q?jrWGQ1k7eMoj8iH7jnrclklRKrZI45909ExsjWu2fmyPDzMOI9eoE35upZhQ?=
 =?us-ascii?Q?rHF7OBIkhxEAWmvHG13/KukjsNXibLLFlf/ein1yfgS9OZN6/F4/rYqALIiv?=
 =?us-ascii?Q?1S1ZCLapK5nQNT5O6jgCZm+Lv8b46GJpxkbqZoLv6iL3gL8RsMhMDnQTHFz/?=
 =?us-ascii?Q?ebUqOIMmEePrhxA6DhEoUJchv0KxYn1KbL1IZbhBCfXk7BJhmkLPw5n6xu+T?=
 =?us-ascii?Q?HgU3dekPrTt5jtyHNs6ix6gkUtWsSqIJFRDzz1RRF/oaZzi5YdNjZNhvBTru?=
 =?us-ascii?Q?00/5UtLzL0ulcSxZ9y7+ijDl0gneWGWLbN2Pp3E6lYEX/QBZ2974dkQI5PAa?=
 =?us-ascii?Q?SwneeicXP5nER9pGSoMFLJjw/IHF+IZ3bHVwvsAW0jdrdRz0mPswLobUv4Fu?=
 =?us-ascii?Q?Gtxs5fpVD4CjwD9s7qLHyPZd8unnKLBRk0kd5rxtNypjuURRI5DDYM2KGDAr?=
 =?us-ascii?Q?bFADyWjgtYqoJIzgmKjsvuN6yDNaseBHqjN7uRakoVHX5jxl5QSj0G2/X33J?=
 =?us-ascii?Q?/xU6vHh7FSgvc9Mfq4gQLi9OvoLXnFhgA6Rt710LxllD+HuVAGwyRkcnU05m?=
 =?us-ascii?Q?abDqjBJ66AQqAI/8vtWiLJ9g3CV6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1296375d-6e41-49fa-afdb-08df2cdbbda0
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB15019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 05:50:40.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10523

According to the document "MT7981B Platform: Registers Part 1", the
4th clock source of "emmc_400m_sel" group is "cb_net2_d4".

Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/clk/mediatek/clk-mt7981-topckgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index e71ae8fadd5d..8df0dcfe30c6 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -173,7 +173,7 @@ static const char * const emmc_400m_parents[] __initconst = {
 	"cb_cksq_40m",
 	"cb_net2_d2",
 	"cb_mm_d2",
-	"cb_net2_d2"
+	"cb_net2_d4"
 };
 
 static const char * const csw_f26m_parents[] __initconst = {
-- 
2.53.0

