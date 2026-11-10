Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794291199;
	b=Q80XRvp0akf9Ry8ocIFAs9U7Whf2JH2DOmNDf50LByC0L/jKHulusK8/+ETZTGTwMLg7
	 a4JM5NLve9LoAIZ6sYFNXPutLJbtdLPMY6sS0V1HO/3UPq3X5fMb7P8+CzVERnCWZyxie
	 d5VZ56V401hBE7d5DTFCyn4sqLShSszFrUTEmP+qThT9k9hCb2dLKX5nnIxS1qgxkTp+S
	 80CBl8jqejwZlhCXomrv7sPHPGhAWlak3JPehn1CWlysuI+f+NfgNYynohyBnDPnRudvN
	 XbehAUaAU0KF6v4AdkK/TokKUkujKiqp473Ozyt7g5XZL9Sz26KDfshcWQb6SkNnZaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291199;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=aR1uPFvdgMoCGeavtuLzQx4j3O3lgozN/DmwYH6CV9E=;
	b=PM6Yf0jV+hAdKc7qo4//fp8y4s7aIk6g0gjMMd/RB6MlE/eQOId5rbAbbGFDXMBoHfGM
	 fnPt99yaJG7UxSiUdilOp6rTgcJimpSpbXZYasVWw91kwklSYeWVc3Tr3dn+ttDzTstXm
	 wxY7IlLRIc03DdDNrGxm1DTotHKba/di60ygf86mE2TWxr2n1STuMiXvFIksKCYiDQ91W
	 MPlH8rDAdW7jtxpO1bYv0QeMj0GH9FhTnklDeN5yQA9MmgTselu+UKgufGg8NtcpHFZa+
	 nz4zlyQ0OpfijEEbY6eDqGv08e5VJyYZ0V+pQwGwrvJOqL4aZ/JGofPIRsvEc4qtoTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=uOgDXRPY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.68
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D3606A326;
	Tue, 10 Nov 2026 06:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C3D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=uOgDXRPY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoP2Wtxbpgm1eoxjA9b3fXpyraF1e1L0cnac9Mjpl2CRtnpRMNrzyV8ic+3hSYahTGBLrx81nTjl37jhaA7Xi12880zpf7h0Wo9l8JB8dMGV1kC/bU9k/5CRhvgRMT2DDKAzjL6dpEyP8upQkcJuNM5uzM1E1A6aMtrx/gGwn7WJveyqe2f040Cgamn7lBYYs7YQD6fJmO5kENdXG38ObmGuD2fTwV21r0ob+7ftI9WFB4SaLRL2J1tSJQhR3FlI4YaGdVe8hY+tNJ+Fs3ZvDDb7RagpTPVJTL3x0XXUE4FtiLbUhXFo1h2BzmELQtxApvc5v+9pI0dhikR/zwFmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR1uPFvdgMoCGeavtuLzQx4j3O3lgozN/DmwYH6CV9E=;
 b=PjC3jdvuUTilXrbGchOn3FKnhayDYfAkPvq4KQcCTKpNj8fSnfee8ZQT5FuogjbrynE0qN+1qzlgSy6W0mgvgqXFha7BZVaTGF9G91zaAAXGHAgSOS/HhskTIApASxRe/cWt+jBq5Q9eALvczukzY3pYTjCFT056CncapoYVIryFxnp3PB7OIc2B5Vfp4rJtScxbmm8Uvi6ymNtGuIqF4WQ2ZHQ/NDLX1gYnkjnZ2YV8k1DxphrBVNwEe/bw4CkN5jTUntXUYDFbc4/0MoRkDyl+YkTJ3zz9j8j9d/AMyFjgVBRP4q8aj/98YmMnGmUPuNfib81RtGhwBczT9TAuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR1uPFvdgMoCGeavtuLzQx4j3O3lgozN/DmwYH6CV9E=;
 b=uOgDXRPYo+vk/F2edLNmDEcoTrk3F1/wopJa0rkG4ducuov9W5qtFDQkkQilttwuFDNuKdcrvj/xxRfq4ZVSL8Dd1HAdtSHUZ0XyAVuYT0sAuzIl9ePpyPJBinomuzDw3oh15zM8zq33QVVkcDRi6/egZLfGz1iB/Y9QKCPvWTWEcv2L5i+LnShLDG6EERObunPVk6JpwDE1umTl3ar/Whrt+04QWt3gBquHAvVygS0n3yG8Gggr7WsV3+nOCDOetqDUVtI77dA4x1BMz3LgtNVdADeFKpq7iniGNITO4DFSSpRQs96gubvnlQQYk6Rk5koAUgSEAM4hwYh6ZWmF9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by PH8PR03MB989187.namprd03.prod.outlook.com (2603:10b6:510:3b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 06:13:17 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 06:13:17 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] clk: socfpga: agilex: register the SP timer clocks early
Date: Tue, 10 Nov 2026 14:12:38 +0800
Message-ID: <1e3b10fb1fe51f0f43cf60d686549242a31b4450.1794287244.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1794287244.git.adrian.ho.yin.ng@altera.com>
References: <cover.1794287244.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::9) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|PH8PR03MB989187:EE_
X-MS-Office365-Filtering-Correlation-Id: 3686f7de-0b58-4e22-be48-08df3ef1b5c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|55112099003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	GuigvJX6/zt8gD8QTXDDOLxl5FvgebVrJOQrCA6+tTe3O7HktII0T/q99AZGZoN2uj+Hxn6MVBRWtDSxO73COtFxWi00H4FQ2ldlhF3WQib2TyvzM0KQ7eVPpxZZZdVTGi37PeZM5Jlq5UO+C+Q/CHjskQ3XtftXwP4oje+pYI9nPIQS+QpVveT1gm18/grEvbC7Gq1N/EqGiezCiTs0YayRlWpv3y46qIIAuOnqY03h35xwQqSRj7PsFnUWfjJHzln38sMKt5RuyhkX6QO8j9pvpUGboB2aWN6OGDSLMyxF+MPxfpaDsnoNk6iioB9XDlGWMOl8jc7cG2AGr1HUmWfHAgfmcqZTnyZPT7vsOizjGfatvmN8YBuHuWLUuFnMRAk/xGcMjh7TRfKv/WC+7Rjzk0cinlkM8/icMOufCBxXAAwgDVCWja/q1LQs0PIlsr1Q2aqWkhjM6dAQg8RKipXsfbolUlqGrxj34vYka9WK/gLHmEwL71n6kfBFAxOZ2lLI07focHXXec4ngRG/wnK1vKxyqtOnJOyexu+1K4957EF4Yf+8+7yVaidYRCGBwjkGI/I/c6YNexWZjSnBJhdv8YLvr2ALbP7H2LtqhKjOAvpLUp0cUWloO//dJRuT4RBO40VK1ur+58wRjHoe7MUZLsGWnQTmiypvohuCU8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(55112099003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5idejrFM3sdXy01rCdsC9G3XvmuI+jmczECL2A7DxnvKMJjlb+Me8rV5mSI?=
 =?us-ascii?Q?o2S+dJTbBP+HmvKrYS5Eq0zEud3LDbNDluw5ZHnB2BrzMrXhvzeaqNh2nqEy?=
 =?us-ascii?Q?iUVb+p854dH8MFWx1yLi9gDYBewDhs32JlMQNLn2DjUUjNvzIAMpNYkH5e6p?=
 =?us-ascii?Q?/AzSQo6tqMtkVUVWq+uqpPbRDd5hdItZbkEpZEUnYJD/Y5uSXBg4xvnu1Gis?=
 =?us-ascii?Q?jby8iSiGvoEViY4XChukwuhWfY77XLLwtGkUfoImUY9QqfQeqqpwyt/OJ3+/?=
 =?us-ascii?Q?zmbEEvki1H4fWhDtXOAvNx9DoBAeeEHPHbCWL7XkISYin8kGPs7qvz/jL+nK?=
 =?us-ascii?Q?j7ag3DVsu9Xx4qxjF+y6I8ywqwFY/6koOiWaJbelXOf2j3sU61eI4c91HBdh?=
 =?us-ascii?Q?rb6DBad5dF+dVwLDSSrV127fYUH50whOdL56it32B2MxT/B1xAAXOoP1xjRU?=
 =?us-ascii?Q?tfxb48v1r4fDsTPY4a5Wc2A9LpwSQt3PAR5EEljhk7YucY1yxTFZnupegUik?=
 =?us-ascii?Q?SRzMtKPH29zNjNcJNK2Zt7kFCMjQaeTr/fUkZwFq/qd678DUNlV0IgrxDnMc?=
 =?us-ascii?Q?kEkAC6jgDoRGw5sDJy++CtDxwpAUrVazqttpejYrmHK8JhoLrDeKFaQCcvNr?=
 =?us-ascii?Q?eVyPd+B1ezencHieV6a/X7/6f2Z+URi8Gqi0zbyZLXwY3WfMjUdPBJNA70am?=
 =?us-ascii?Q?HAk8+fEUnltvaWOVsHf0ZNwu7ZlC3KFIvM+Oemkuxr4VafcE0SMa5lxZ3DgA?=
 =?us-ascii?Q?fQXCqX0LCav11kwUdV/uJhTX+QHBFs4x/hy0GKgHZAeV2L2oex5IuNoS7L+t?=
 =?us-ascii?Q?aAB90NwNL2X8n+0YtKBnRj0OW4VOGHy1Hwc70WOw2vdsjwsNi0ofO+xmOaJe?=
 =?us-ascii?Q?KxnWHk6F5W52vrhsolVNhjIma4dvYbHm51yEE/wAnuanIYrzIjOZdwMKzhsI?=
 =?us-ascii?Q?pOieZILssq+CTMiY4HcxZBd+Q7WLU3dmXwbiTcmAqXHuGMrSYAty1jmzM+hI?=
 =?us-ascii?Q?btgpx3tGgr/fkgOWCnIb+p5Ue5BqjCXCeXQJ69GIj7a/r3yCAJLG9fW+LpI8?=
 =?us-ascii?Q?LH9J2uoqYj7YiN+aOTd6zEuS2DDg0rfsFqzQzES8HIAdaWKyZ1kvnuIYUpf9?=
 =?us-ascii?Q?yVkCAmNj4lq9drXYGfphokYsA+Yq5UzPSSH3DJqlSiTfTvv5EjGw4yVzuWiL?=
 =?us-ascii?Q?67fIEijUanFPJLt4/CJ+er4IVi7WgGb/C5IzA8pmTpgZqLugSkKe7sxLiuQI?=
 =?us-ascii?Q?x+vtpJzYg4XPk0ORFh7XlC6T/AjtdQalyHyOD1CMcQQ5xpRCioEgFiDkuXNm?=
 =?us-ascii?Q?Ibr1WsBHHnwgUSCpfvD9HD1cAhZKoUEZLeBIxGOdBqeIxeHGhQ4yXdZMPGUy?=
 =?us-ascii?Q?j7nAdTcmjutDb8gzC+Clz2Ri7wGaSQbUIo45J5UkdZPVwOg23Kxg4VKWuJlh?=
 =?us-ascii?Q?vL+qO22L6nsAFgdyfyDnKdyVVmuGJ1joGPQCKRO7tFcVh5/x0ilgu5EtmimL?=
 =?us-ascii?Q?iYyrjBa08Txp18h2uc1f2odJ+fuM1tZthussK4Gx18EcpN9PkkSSnC9WWn53?=
 =?us-ascii?Q?TFA9KPAaojfurvc58f0P8brwXpc+lLUpIgBxJjjIdsDQvMeFHV0VGV9gFUkG?=
 =?us-ascii?Q?aLgpMeRS9xflVrjmQOwwHetM3emKnJK8UuAE3Hq6uWQKNNEO8fK73rln+x5D?=
 =?us-ascii?Q?w0mq6IqaeTZHKRT3ZAO0UDlPZWY3sYuMK0yEdtplP0BylF1kxpWQAtNesm/u?=
 =?us-ascii?Q?gfiZqXbNBw5TXwTMHvwK0H0oZFbtryQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3686f7de-0b58-4e22-be48-08df3ef1b5c8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:13:17.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFVPRj09D+rdGNfFDbfTyxwMUdl6QVVV0Waq6Y/4NZiDQ2jij7Z81f1ChBigc5O2NXrRMWupSiTQGWHxvmN2ge1r0Ockr+ZArPpe4mX648E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989187

The DW APB timers are probed through TIMER_OF_DECLARE() from time_init()
and cannot defer, but the clock manager is a platform driver registered
at core_initcall(). The timer's clk_get() therefore fails and the timer
is never brought up.

Register only l4_sp_clk and its parents (boot_clk, main_pll, periph_pll,
main_pll_c1, peri_pll_c1 and noc_free_clk) from of_clk_init() using
CLK_OF_DECLARE_DRIVER(), with every other clock left as -EPROBE_DEFER.
The remaining clocks are still registered when the platform driver
probes, which reuses the early provider.

Fixes: 80c6b7a0894f ("clk: socfpga: agilex: add clock driver for the Agilex platform")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/clk/socfpga/clk-agilex.c | 242 ++++++++++++++++++++++++-------
 1 file changed, 187 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 2bdea1997b5e..445d814e2f3a 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/agilex-clock.h>
@@ -232,24 +233,49 @@ static const struct stratix10_pll_clock agilex_pll_clks[] = {
 	  0, 0x9c},
 };
 
+/*
+ * The SP timers are probed from time_init() and cannot defer, so their
+ * l4_sp_clk and its parents are registered from of_clk_init(). Everything
+ * else is registered when the platform driver probes.
+ */
+static const struct n5x_perip_c_clock n5x_early_perip_c_clks[] = {
+	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x54, 8},
+	{ AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0, 0xA8, 8},
+};
+
+static const struct stratix10_perip_c_clock agilex_early_perip_c_clks[] = {
+	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x5C},
+	{ AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0, 0xB0},
+};
+
+static const struct stratix10_perip_cnt_clock agilex_early_perip_cnt_clks[] = {
+	{ AGILEX_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_SIZE(noc_free_mux),
+	  0, 0x40, 0, 0, 0},
+};
+
+static const struct stratix10_gate_clock agilex_early_gate_clks[] = {
+	/*
+	 * The l4_sp_clk feeds a 100 MHz clock to various peripherals, one of them
+	 * being the SP timers, thus cannot get gated.
+	 */
+	{ AGILEX_L4_SP_CLK, "l4_sp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), CLK_IS_CRITICAL, 0x24,
+	  3, 0x44, 16, 2, 0x30, 1, 0},
+};
+
 static const struct n5x_perip_c_clock n5x_main_perip_c_clks[] = {
 	{ AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, 0x54, 0},
-	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x54, 8},
 	{ AGILEX_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0, 0x54, 16},
 	{ AGILEX_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0, 0x54, 24},
 	{ AGILEX_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0, 0xA8, 0},
-	{ AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0, 0xA8, 8},
 	{ AGILEX_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0, 0xA8, 16},
 	{ AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0, 0xA8, 24},
 };
 
 static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] = {
 	{ AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, 0x58},
-	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x5C},
 	{ AGILEX_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0, 0x64},
 	{ AGILEX_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0, 0x68},
 	{ AGILEX_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0, 0xAC},
-	{ AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0, 0xB0},
 	{ AGILEX_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0, 0xB8},
 	{ AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0, 0xBC},
 };
@@ -257,8 +283,6 @@ static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] = {
 static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks[] = {
 	{ AGILEX_MPU_FREE_CLK, "mpu_free_clk", NULL, mpu_free_mux, ARRAY_SIZE(mpu_free_mux),
 	   0, 0x3C, 0, 0, 0},
-	{ AGILEX_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_SIZE(noc_free_mux),
-	  0, 0x40, 0, 0, 0},
 	{ AGILEX_L3_MAIN_FREE_CLK, "l3_main_free_clk", "noc_free_clk", NULL,
 	  1, 0, 0, 1, 0, 0},
 	{ AGILEX_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0,
@@ -292,12 +316,6 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
 	  1, 0x44, 0, 2, 0x30, 1, 0},
 	{ AGILEX_L4_MP_CLK, "l4_mp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0, 0x24,
 	  2, 0x44, 8, 2, 0x30, 1, 0},
-	/*
-	 * The l4_sp_clk feeds a 100 MHz clock to various peripherals, one of them
-	 * being the SP timers, thus cannot get gated.
-	 */
-	{ AGILEX_L4_SP_CLK, "l4_sp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), CLK_IS_CRITICAL, 0x24,
-	  3, 0x44, 16, 2, 0x30, 1, 0},
 	{ AGILEX_CS_AT_CLK, "cs_at_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0, 0x24,
 	  4, 0x44, 24, 2, 0x30, 1, 0},
 	{ AGILEX_CS_TRACE_CLK, "cs_trace_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0, 0x24,
@@ -454,33 +472,166 @@ static int n5x_clk_register_pll(const struct stratix10_pll_clock *clks,
 	return 0;
 }
 
-static int agilex_clkmgr_init(struct platform_device *pdev)
+static struct stratix10_clock_data *agilex_clk_data;
+
+static struct stratix10_clock_data *agilex_clk_data_alloc(void __iomem *base)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
-	void __iomem *base;
-	int i, num_clks;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	num_clks = AGILEX_NUM_CLKS;
+	int i;
 
-	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
-				num_clks), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, clk_data.hws, AGILEX_NUM_CLKS),
+			   GFP_KERNEL);
 	if (!clk_data)
-		return -ENOMEM;
+		return NULL;
 
-	clk_data->clk_data.num = num_clks;
 	clk_data->base = base;
+	clk_data->clk_data.num = AGILEX_NUM_CLKS;
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+	for (i = 0; i < AGILEX_NUM_CLKS; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	return clk_data;
+}
 
+static void agilex_clk_register_early(struct stratix10_clock_data *clk_data)
+{
 	agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
+	agilex_clk_register_c_perip(agilex_early_perip_c_clks,
+				    ARRAY_SIZE(agilex_early_perip_c_clks), clk_data);
+
+	agilex_clk_register_cnt_perip(agilex_early_perip_cnt_clks,
+				      ARRAY_SIZE(agilex_early_perip_cnt_clks),
+				      clk_data);
+
+	agilex_clk_register_gate(agilex_early_gate_clks,
+				 ARRAY_SIZE(agilex_early_gate_clks), clk_data);
+}
+
+static void n5x_clk_register_early(struct stratix10_clock_data *clk_data)
+{
+	n5x_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
+
+	n5x_clk_register_c_perip(n5x_early_perip_c_clks,
+				 ARRAY_SIZE(n5x_early_perip_c_clks), clk_data);
+
+	agilex_clk_register_cnt_perip(agilex_early_perip_cnt_clks,
+				      ARRAY_SIZE(agilex_early_perip_cnt_clks),
+				      clk_data);
+
+	agilex_clk_register_gate(agilex_early_gate_clks,
+				 ARRAY_SIZE(agilex_early_gate_clks), clk_data);
+}
+
+/*
+ * The registered clocks keep using the mapping and clk_data, so neither is
+ * released once the early clocks have been registered.
+ */
+static int
+agilex_clkmgr_setup(struct device_node *np,
+		    void (*register_early)(struct stratix10_clock_data *))
+{
+	struct stratix10_clock_data *clk_data;
+	void __iomem *base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk_data = agilex_clk_data_alloc(base);
+	if (!clk_data) {
+		iounmap(base);
+		return -ENOMEM;
+	}
+
+	register_early(clk_data);
+	agilex_clk_data = clk_data;
+
+	return 0;
+}
+
+static int agilex_clkmgr_add_provider(struct device_node *np)
+{
+	static bool added;
+	int ret;
+
+	if (added)
+		return 0;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				     &agilex_clk_data->clk_data);
+	if (ret)
+		return ret;
+
+	added = true;
+
+	return 0;
+}
+
+static void __init
+agilex_clkmgr_of_init(struct device_node *np,
+		      void (*register_early)(struct stratix10_clock_data *))
+{
+	if (agilex_clkmgr_setup(np, register_early))
+		return;
+
+	if (agilex_clkmgr_add_provider(np))
+		pr_err("%s: failed to add clock provider\n", __func__);
+}
+
+static void __init agilex_clkmgr_early_init(struct device_node *np)
+{
+	agilex_clkmgr_of_init(np, agilex_clk_register_early);
+}
+
+CLK_OF_DECLARE_DRIVER(agilex_clkmgr, "intel,agilex-clkmgr",
+		      agilex_clkmgr_early_init);
+
+static void __init n5x_clkmgr_early_init(struct device_node *np)
+{
+	agilex_clkmgr_of_init(np, n5x_clk_register_early);
+}
+
+CLK_OF_DECLARE_DRIVER(n5x_clkmgr, "intel,easic-n5x-clkmgr",
+		      n5x_clkmgr_early_init);
+
+static struct stratix10_clock_data *
+agilex_clkmgr_get_clk_data(struct platform_device *pdev,
+			   void (*register_early)(struct stratix10_clock_data *))
+{
+	int ret;
+
+	if (!agilex_clk_data) {
+		ret = agilex_clkmgr_setup(pdev->dev.of_node, register_early);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	return agilex_clk_data;
+}
+
+static int agilex_clkmgr_finish(struct platform_device *pdev,
+				struct stratix10_clock_data *clk_data)
+{
+	int i;
+
+	for (i = 0; i < AGILEX_NUM_CLKS; i++)
+		if (clk_data->clk_data.hws[i] == ERR_PTR(-EPROBE_DEFER))
+			clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	return agilex_clkmgr_add_provider(pdev->dev.of_node);
+}
+
+static int agilex_clkmgr_init(struct platform_device *pdev)
+{
+	struct stratix10_clock_data *clk_data;
+
+	clk_data = agilex_clkmgr_get_clk_data(pdev, agilex_clk_register_early);
+	if (IS_ERR(clk_data))
+		return PTR_ERR(clk_data);
+
 	agilex_clk_register_c_perip(agilex_main_perip_c_clks,
 				 ARRAY_SIZE(agilex_main_perip_c_clks), clk_data);
 
@@ -490,36 +641,17 @@ static int agilex_clkmgr_init(struct platform_device *pdev)
 
 	agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate_clks),
 			      clk_data);
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
-	return 0;
+
+	return agilex_clkmgr_finish(pdev, clk_data);
 }
 
 static int n5x_clkmgr_init(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
-	void __iomem *base;
-	int i, num_clks;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	num_clks = AGILEX_NUM_CLKS;
-
-	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
-				num_clks), GFP_KERNEL);
-	if (!clk_data)
-		return -ENOMEM;
-
-	clk_data->base = base;
-	clk_data->clk_data.num = num_clks;
-
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
-	n5x_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
+	clk_data = agilex_clkmgr_get_clk_data(pdev, n5x_clk_register_early);
+	if (IS_ERR(clk_data))
+		return PTR_ERR(clk_data);
 
 	n5x_clk_register_c_perip(n5x_main_perip_c_clks,
 				 ARRAY_SIZE(n5x_main_perip_c_clks), clk_data);
@@ -530,8 +662,8 @@ static int n5x_clkmgr_init(struct platform_device *pdev)
 
 	agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate_clks),
 			      clk_data);
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
-	return 0;
+
+	return agilex_clkmgr_finish(pdev, clk_data);
 }
 
 static int agilex_clkmgr_probe(struct platform_device *pdev)
-- 
2.49.GIT

