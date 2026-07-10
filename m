Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE52D8376;
	Fri, 10 Jul 2026 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653226; cv=fail; b=CzOHHq6lAz4+hnbo8BNoSsbR9GS7emdGYhivveLfwLB9u+o7a0r/JsnmPNA5tZ7uqbcgxDt5bmQ4aGH/RIoBrvBFT1pjd/0bv54o/U+N5wYdU56oyANFh93eIoPJU/lVOfvNKfTk9shVcVg22H5Zuw58KGFDVGfDKmanJDQEwKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653226; c=relaxed/simple;
	bh=iqinjSTB0czzZp6hIWEgfJDB6QXKgQRKAotJckVUUP0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KOv6yVpE7TUcaYWoEoz9PC6+WnZaJKyXTz5uj1pHmiSFvXg6eHf3koNrYkexBzo89NDQngwcP4IxmOYJTBUfWxI1a2GUKK17v0PY2eR/Ns4S49cALoxnglerIh1Z3NgZsA3tKc98dj1xEIencyqvA2YLnpNYIFPq9zO2x34suec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PFacnxIf; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PFacnxIf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKTTwMbuqy8Ohk0A0qHRoi6EqRpafXZvWYHK5jaAirpgsDHt1WO1bwlx7hHUJK/4pHSRS/EzHBHHjw0w4CxPJJzF8lx5mbg/sJfrw99EH0b5+vLKDVK/lOqlEzWlyRxc13GChMipmg4NathyyG78F1PeZEG2evWeB4obhHMIh2+/Kidgs1jR+PlLbu6etOget0wxgA31YTGePcbu1aXwuD0V9lf3CKR8xc2xBtM7tnJ/0r5ngKegXEngAFZgMXtZqGTZChPDmU3CRu84vSEh5Hr4LGgzmfPrnzMqQLdEG7vFCW3W0WRUCTkKv3qEntcSASeM2RNokjbAbBN9bgFRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tODgnhHMNdW2fkLoxV2zdmIMlaa/lqdZI0m9YScz2kM=;
 b=Sr5VaAUEWE8GJV+nkzNU1R8iQAxoDqSMc5Fs4GS8HQBL4LdyuqB1IGqxK8s8cAKpTEWhZUNREcm4pSxzINR2Pa4OxvAZdSfmCagzGcsIsJ/upoO7Gc/7UP8jO8TsdFp0CVtKRxKOAJhIpZobNq+T0E3euF7+zAxaOwDktf4C2jD4ZW1yaG5qEqQp1hYQi7QfMNP6tS0waorQqA5VqJnGQmiiyVqAba33jB2dHgYQ3sWojSb3uO3TQ//qAEmgzpOYvFGC6YxsFS9Z22B7iUERVbZXgh/ffOSCo6iCFLZaMo7rUeFz9Xv1v0d2u070fK+7FMcMFx2trUqSmIiGxgZ4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tODgnhHMNdW2fkLoxV2zdmIMlaa/lqdZI0m9YScz2kM=;
 b=PFacnxIfetRNr+jGUrIYZQN1KwRwlfHB/nUWgnTNRCjVboOTjcx1FZ/Ih1iI64kLIVIX5HZSgpgmDhHehYTCvkuDu9dZSwbQoof9Da42OHQOeQHqxFoqSzHULU1v1JU4qCzF3VQ6h/NC6Tyj28F+j+iT/EiK3te73AE1FkAHru2sDC1cpUgrtfyWl4u7MaemRmCb3F0IGlOvZVHRJjBtUuxnXnNxFHb4BpgN8US6Hd9WfiDpeLJMX6r2/kdwtHh+TYjSwiCLvYgCuCMz4kkmfDj7599aAO8wsE2Z4tuU6YPpI6WC86TvLsSv68ZziKajx2vJi0jP7QOhrU2ARR5CGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by VI0PR04MB10590.eurprd04.prod.outlook.com
 (2603:10a6:800:264::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 03:13:40 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 03:13:40 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	Frank.Li@nxp.com
Cc: kernel@pengutronix.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl: imx-card: Skip sysclk reset for active DAIs in shutdown
Date: Fri, 10 Jul 2026 12:13:33 +0900
Message-ID: <20260710031333.3491445-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0090.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::23) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|VI0PR04MB10590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8657b439-0f9a-43e3-97be-08dede313d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+pbm/mtU4qdEJ3wfdVzQHmM3bKw7YPqzhqv/QmyA4o0GfkyMLahGdySkWOTZVkNr5/Wrtfg5ZJsbO6ggQhXhZMy7GMJsQYknty7LGJ7FxmxN0CpCxC4B1KtCwA/iUsAUv7yLDiSU7QdKOjb2PYYigytnudZpuBcgVe4ZA3U84+hA6um8WnWJRVdbn/ZgRGKSKiPX94l14/F6KJMO8DGMvoptUrm79DsrHHXg6x22VVOCjDszd8J8+k1cVkqwIzlNCtinDYQWHnRdepS9vToPWG66oQf/cR3MJUah7S+7nm6O+EipohVz8LgmUYsS1irs2m3EAhDswA3RSK1gYf6u0ueBGyqHZlziCbrDS79mIyR2n16VH6ct6iDAtjogSG4QOz3RPXeJyYGOySPqkqIjsX+2zPbm165HFpW2QH510r9OoVustwUO6bj22Zw+5apxoIcIyHwxozLVisFsi3GrPGEMAdlNU7mkLeuq7Ik0fe7Iy2D5Y6HS2dQb57KQyn84QSSHsyqCVhyGlac9u/bfZGqNoa/NE72GjjwtO0QNfStl99XpsARROyhCPu7bbD+tRZyNFUsVphpGbxdEiiCCn0NGok+AI6fkXPzQJ4XrnSoqq8kzCrDzG5RKlXyuiOa8gkqBG6yKbilhAC1UWR/yQWlCs0Ma2PWUclDjnVNoXD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IG1eHS1rZ2isoAqBbjSX3AifQEALi0hVKgkRiw6MYx8zkI88raGE0LGRO83u?=
 =?us-ascii?Q?obkPmAVA5GALsgjI0NFMc2Qd0WbfIySEOR7eO3HO573vOLw12DQsaDiddEfu?=
 =?us-ascii?Q?/jrBrAU01DQxAN5tTqOGQiy0xZtvFsx6QSPQl/NxltKppQkjvjdmiHDu8XUZ?=
 =?us-ascii?Q?bRQEwyFFE02gIHqwdel0QaXu5YJ2bJu+aWOJjvMYn4uflPIBiqa/OIskTeiq?=
 =?us-ascii?Q?0FwdMpsCe4FhV+BoHM19NLFo9KQBt8NJ71FRj55eJ3tKGeIhav/HfTUCVryz?=
 =?us-ascii?Q?sd00zMD738QI3x+jmIfjzcQsbKvOFXT89AxREdGp+iTkjpuzJ9VmVOO6BzoI?=
 =?us-ascii?Q?WVd+kflXgbVjs2K2+/WiR5cBKSOLbkqYKRyRBi4EO/ol8NAW1zv/2AsFiTli?=
 =?us-ascii?Q?owXg/wXHwpNNMZy6uJx4pMKLqTew81ZR/Q4VUXHWkzAmWkc1a5jDQhZQDvC7?=
 =?us-ascii?Q?6UJjs2k6Spf0pygSQvChlP3Z3utNq+5ZiQ2VU/ZFGTQjyjpqgHGiZyhQ8VMC?=
 =?us-ascii?Q?WSpLrHwf0bWlSOsmlqRRZm3Bf8wkatOIR/cvWH29W098teVLeDNE/8v5R1e6?=
 =?us-ascii?Q?0Rb9cGiLUxg26H+8mv0suDFgv2HbuL1xtBw5fHSeW6krasC2NylYgPwFvkbP?=
 =?us-ascii?Q?f3TjeU+Ea/+0eyA9HdTbOPkNmKtluoq5g8kwiZpyBH5ZjiXoIjMSPuppenXb?=
 =?us-ascii?Q?d0mORX2pbEQN0n/ijXJeBEjD+GLM0Y0c94eLsCOUMAtZPTH9ITesoeOxkMzG?=
 =?us-ascii?Q?DK7nLneJrfGkn8u3MMPz5PjwBjcQuPOBtoMbK3Bs9kE75pMEUhsUpUmY4n3P?=
 =?us-ascii?Q?xQG0VUlalL0IXphJG7u47mxcF/JfORXoqB4PxOi//jcqpU45YEZQsZxV63mp?=
 =?us-ascii?Q?fnPizVFy9LNxzLM9dckz78OBCLvyhBhdNT3qnlCnaJGcqvl5P3djqKivSPIb?=
 =?us-ascii?Q?5XVBRx4q3rJ/KPh9xU4K7iZOI7YVAPJ8avrCOx/tSX7INTMdzzyvRr27fdfA?=
 =?us-ascii?Q?xqC0FkpZfSB5dxjo1/2uORPx+P5KikKBqpB1kfyDWgsAUHptJrkuc9saORX8?=
 =?us-ascii?Q?r2B5DBjbEv7RHGmdNMd68pKnDdCG8UuvrUxWuwKJxlQBUxvvf4MkcxDXxAY9?=
 =?us-ascii?Q?C8mykhF6HwS68b53tVjy+gC/jh06Mly0J4OHv40pG6nS52UctK1RdFPOpOLo?=
 =?us-ascii?Q?sJHAACOi+gQGTXh/ntqn4dd5W6hEAd67JCBNoifc9n7+39s4lQIddc83M/jw?=
 =?us-ascii?Q?NgkGw84S60xosp4c0OS74AuDJv1vsVpInyPzmihgsiMata7YyBXyGEkhuAz+?=
 =?us-ascii?Q?hxWA8YtSiazreFi6fBosQTbb+7luOHPN4wL/fD93b5KWoXIU2Ia3TpvREluV?=
 =?us-ascii?Q?I+PkTTOXHQM8OuogK89/wOAEBHV8LARW0jTpZb7B759PMHVWHhnbAcfbuuK1?=
 =?us-ascii?Q?TwfhqjOPUdOuDr86JgtdOQrAgpHugENi/AZmmIqbLB4v7Jr/Roh/YVuGO0xC?=
 =?us-ascii?Q?YhLe4/xVen9D+6BVcDICoSlYKfC8/buncQ6tM+EJ6hdEbVgtZdJpjJsl0Koy?=
 =?us-ascii?Q?mJkRHvsxMMKSOsrqbDjt/zRh39EYe5s9uVDOYcHa6GTCgXUKoiMzqPAB9Wq5?=
 =?us-ascii?Q?okGWmU6yib5tAaso4Y7f0Guu1PLrglw71GT1on0OnU5ga98KIEVoQkrChTMN?=
 =?us-ascii?Q?jtz+ROv7KLDi7rcgeqtUhAr1fo1gqjHSnw3zNdQxa/D9/I07RdwY6dy/3iiJ?=
 =?us-ascii?Q?xEdfM0BiJxLBaF5iloJfm9kEawh4SwbZm++tSFyeLzl90XR7xsk+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8657b439-0f9a-43e3-97be-08dede313d85
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 03:13:40.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFquP6BjZuejn+wfDfh5TBYa1UWcmKqzlzhht/c3U8KJ7BIBssQNbtETBBtpfHP818uDBGKAGLt67syA5fmi1qropyXZ59Bs5X7apIKhxw85imIfj5xPwdHE68mVz2wx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10590

From: Chancel Liu <chancel.liu@nxp.com>

In a full-duplex setup, when one direction (playback or capture) is
closed while the other is still running, imx_aif_shutdown() was
unconditionally calling snd_soc_dai_set_sysclk() with rate=0 for all
cpu/codec DAIs, which would disable the clock still needed by the
active stream.

Add snd_soc_dai_active() checks before clearing sysclk so that only
truly inactive DAIs have their clocks reset.

Fixes: 2260bc6ea8bd ("ASoC: imx-card: Add WM8524 support")
Cc: stable@vger.kernel.org
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/imx-card.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index a4518fefad69..43438af1e1c6 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -496,11 +496,15 @@ static void imx_aif_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai;
 	int i;
 
-	for_each_rtd_cpu_dais(rtd, i, cpu_dai)
-		snd_soc_dai_set_sysclk(cpu_dai, 0, 0, SND_SOC_CLOCK_OUT);
+	for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
+		if (!snd_soc_dai_active(cpu_dai))
+			snd_soc_dai_set_sysclk(cpu_dai, 0, 0, SND_SOC_CLOCK_OUT);
+	}
 
-	for_each_rtd_codec_dais(rtd, i, codec_dai)
-		snd_soc_dai_set_sysclk(codec_dai, 0, 0, SND_SOC_CLOCK_IN);
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		if (!snd_soc_dai_active(codec_dai))
+			snd_soc_dai_set_sysclk(codec_dai, 0, 0, SND_SOC_CLOCK_IN);
+	}
 }
 
 static const struct snd_soc_ops imx_aif_ops = {
-- 
2.50.1

