Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794312360;
	b=qwDLCoOMZBoGaQXZE+r/IV3ngqht+O5tTmjkoQz4/cCrqpfPQDZ/pLIpX9CJm/dE4ONF
	 +mk2jDgszLF5Ngxi6kp+i4h9dhC6vTza1klrLr5ZogwxumzHPjkYd7imBlg5FfDVi825Z
	 ikkqK6tF0QsPq2Y3GSo2zOeLxSVS/U+4K1qqlSpJ4ez5z1YczpNvxOZgjdF7OpuzMiUC9
	 sZg5G0G31x2GSUAVlfZYKLkC4/KlyjPOgMH+F6SMgT96W2OiGdV+ZZhkpFhTB/tv7kazc
	 LBKWxqjQQKATYEqQgB5CJnqJeiGb99Wb9Pf6nc09CuHSkOyEq/ABggGFBojJZ6+Ewrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312360;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
	bh=tRlbDnd4PNg3AzJ0rO8/pvTovkhQ3/QptVL33hMY3uE=;
	b=IZQ2RznlekiVMjELTam8LLNkbCFvY3d4n41ZDwjY3zQ5p6wJhbNx7rEynosTOC8dEgi5
	 BAsECiH4H/iudFFBJRciQccBTj9m9hlVxtUAsFxJsCmG4qM5mgLmt2o5qgjgoP10fm7sf
	 nT9rMq86+eE5g9JXj3SABI/bCjDgSr9hQvOqTLwDOyYHZzpmXMD2VxJ+lnQCBxZByVrJ1
	 wYTojugprvXHvA+vWhBjQA0TYf+d9z80ss/4T4MhKbMVnkO6qqT3OMoHWF99FNOQkLX9g
	 OWn6cZQWzekw0k0DfmrH5p33iD4qqavm7S8PWFaKGt93eobp+C/EX8iKyFRA/pmbeaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YpVGEGOV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.9
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270D606A321;
	Tue, 10 Nov 2026 12:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7270D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YpVGEGOV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkzU0FAktH1dJlr8JJmIAaUOjinhac8dN3yzVxznTZvfxgfMxXkgqnSLAFPbFj03n+SH//wEeHOmXDs5xMV1eCCbDeiu9FdZm9aaRxrcc/rAuW0D5wrx55i23WhJl6oF6UR2ZhBlmNqwr7BR0JgjjL1ktnkHdeH5CHil+Sph08f2cdMtMYxf308CKx3NTzjHnb5C06bgEHIQLr5SNhm3OJxVyF+Ojo6YEgcsuD4WBg0+XpX0rdYN89ENAWeN3u0YJ6RPDI/v/8YetrYwstoSOMNf05lxM6ix9gZ3Hs5V0JSIBQp9nPWHYIT15ysSbg9194BxO7YzVDM7z+H8rNQWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRlbDnd4PNg3AzJ0rO8/pvTovkhQ3/QptVL33hMY3uE=;
 b=C+lnzAG+9CPylX7pqpABSPyGKWvf/hQFlMkmEoS11IKQIEXybs5+qEAp7DoxBh+nJbbHPJQ7uYMU3BWgagl6AW6zW7ZZJt5p/LfqfcbI/HksdyctpnlDRXuxePp4ceMk+kF9MIAaxr8DLtDHjPMO23svn/veVl6us8KT8odXs/60AcTogRa5VfgmRpYSlpEhBSvWcHw/453K258kU+Z3d/uGr7BKTmfSTQp9fjULi59H8/WUFoiOR1WISglfWniJOA2/G+CcFUaM9i5c3OU5eh951uLK6Nl1y6oWX6JFH9mDvjCcicVWU82t7zawhTqqVoLJlhWz8ZJc60pRIYW5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRlbDnd4PNg3AzJ0rO8/pvTovkhQ3/QptVL33hMY3uE=;
 b=YpVGEGOVydhhBaOo6PcdFiVBC4qVSZhgaow0upxJElwp3h6JSyzzC1Qsl9DfjrfmnQ8+aPUMuO/aAspybDpKLwE8l0xmPXQIiWCDSONOVeTuRSkl8/57gHrgyXPd6WIzCfCS6mTlRMwBi1SIQyqX4BhVZ+/ooVM9ymhiRWc5Y2oWA0N2ZjHmS1JDuGAj7kEc+dypDs2BXL2HTJryz603IQ0xHcY0m5guMD2qYbLOUYJRfNG2yWBditGSCws2o9HVongDZ1wd0k5OdQZrPWc1LQrTZ/IaqVCoju95N6X935X/LRKileZUU5G7OQMCjlKvCfMS9NbGOmaSCwqNZKst0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by VI3PR04MB572389.eurprd04.prod.outlook.com (2603:10a6:800:377::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:05:55 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 12:05:55 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	daniel.baluta@nxp.com,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Oliver F. Brown" <oliver.brown@oss.nxp.com>,
	stable@vger.kernel.org,
	Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH] phy: freescale: phy-fsl-imx8-mipi-dphy: Fix hs_zero underflow
Date: Tue, 10 Nov 2026 14:05:46 +0200
Message-Id: <20261110120546.6247-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|VI3PR04MB572389:EE_
X-MS-Office365-Filtering-Correlation-Id: fe601bc2-1c1c-4c29-4940-08df3f22f907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|7416014|18002099003|56012099006|11063799006|261021121427099003|261102123227099003|261021123027099003|261009223027099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	+hZz04YiOxdWY+Mcoo6fKXk1ervrrVDMnx/axch7b3CxZHD1ivszuUeBDu/m2opugYoVHOtOwWhtGUbeWyaL7+36bcepi8v2GN3Wz6AcaKKU3B5AHGku18zOAB3PIg0U2eFhiGV/NV/U7yAnZspXCsbtrwb1TmSA9qd2jRq571W5XIRtzupUKVIzmugeUtqESM9/UjIfcCYGkgXiV6BPe/2poXQwslngIKghtikO5KnD9X6KfUok2XQNy938zaKE0f6q96rPgENKF1ZoJAt9lY4s8HOjI5Nq/Lf7f7qzuRaRfQBeXV6ZeRLo5LQ/Vxpt1d6stcohMux6NsRv9ZVIOlLnjMltAtpF2GjR1iwvkEh1nCM73Akc8ZjrsySzmGRhoqe/V65UAB9wsfq8fpXhBBQ/ncEtx0Z7Pnrq3M9clD2V74U9qGuhJGeV28wXV7u7uKy/UvcPrTh9p7mTyZoVTAcixMWM0rcw2c5QIBNb8Jl0w0DNyuzVHv8oOjNahhaemc8bWD0AqKSmmYspNELIJ9gmeOq4sFJT428QnAChGUCW0//fePSf8d6jnKGHFYh20kuEpsQpZbUdAqD7wekAuxWwF2dnGVY41qa/5qBvkeBOb4Z3MyiPr3XDC9pc4xgku25AexJqV7ctNRzLje+QuG5bc1QKQoWqX5WYeUdwRvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(7416014)(18002099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14/TY6DlfmMjvIU82p5ar71r/aWEdH4qlW1McxSme060y94tTM4+ksuebVAA?=
 =?us-ascii?Q?1ZaAt2NW+7PFEUdqZxdtj6P48zH42uEyflotm17VlZI7gOVHX9DEa8qhW8ju?=
 =?us-ascii?Q?hdCN1iyLQUD5CGyCyezDgTUWurh4URPRQQ+5vAIY2OcOxaq7Zvr2/0ykf0Sr?=
 =?us-ascii?Q?VtUl4SykA5P8CM7Lg7RgIAUh2aDksO91dO6XJNRYQvfbJK4P/VVpOYbnSdvO?=
 =?us-ascii?Q?3HZCTVse2qnQJOvJIJBZ0Sj4Ibo6XxremWJ5stQMC13sJEFhnx3zIBZKdYLj?=
 =?us-ascii?Q?VfzsKJgpvQhk/9qYU+Rnz6KYBh+MEoqjFs/uKtcfvq554SdUL6H/2oSi7lVU?=
 =?us-ascii?Q?Q/IRAe5Fe0uqOhl9pR4BzCMN1E4Hk95tgfuPsle+C415fSfdf0TefDBbXp7d?=
 =?us-ascii?Q?mmCi36BV49oxQEOGgXGUvAUDxO6uyqSotMaLajTeeGYr2+4dqwvhpMp8NK/j?=
 =?us-ascii?Q?wW/gKgnR0cTM4Hms5ZXRFg9tVnXhSRFgDWOKXrZMhE0j8qUBA7P/SUBQcKCn?=
 =?us-ascii?Q?9Ew47fIqkYNOIuzr+oub1VUnSQ6Mi5DN/w8Dmymi5diqu+buvah5TyaLW2pL?=
 =?us-ascii?Q?lVlwBLlgYrUP+FbQtEG3v1bw4Az7x9FymQyLY9HCYP6aRjsx6ZfyldxBR4A2?=
 =?us-ascii?Q?i2LhZ6rQm0Xyd1jNZhsZ+2Tq2D/JNjbOG9BxX13ahX+lB9OGh/pSAdnWdgBh?=
 =?us-ascii?Q?ado/n+/4+L99w1SrOn5d3tC7t5UzgISILLGfMBabChTYpbqUMGEHsaiZG/PD?=
 =?us-ascii?Q?3lEwAPahm/2nGv21Y1ONbWdKaHQCezWKprENIeK5/V8KnAUnXNbkKD2rbJeG?=
 =?us-ascii?Q?BBdwWHxPwzQpohwZ1Lj7oeFX1DQFceXPuXpQv5gzgFnElCYGge0fn4qgSu4g?=
 =?us-ascii?Q?odkNfYGVDi1yPNIKIfVEI0ZFDDL1tbjfypHhf0NrhIivw8JAjKkJyGL9a+84?=
 =?us-ascii?Q?2top1QRsh/AxeP2/Cuj0EDtgaeUAqW90QnQdf4TBfew5Pr3rvqBLh8BWvrJt?=
 =?us-ascii?Q?iJWQFsAP81N4sChpGpoyZTdI092B+wQ4CWzni1M3FotGZItGGqpOgVgfEHAb?=
 =?us-ascii?Q?olnJwQ/DNPsWYGviUSB5YFfxGB7TAR/Tc6RlK176iMDevJne1EcM8aPfif4W?=
 =?us-ascii?Q?3+YFXgnaMytBPmND1ylR/4DS5n/1wpad4e/73NeKVKXHzBf8B//l32SZEjzV?=
 =?us-ascii?Q?MzSTcWeo8kG/WT4Bolz6JnmxVrzxN2iYh/ig9WxyRa8f5H+oVn46yZZoqlc4?=
 =?us-ascii?Q?YVxAuFcstqFt+b83EBOis7mQUFcoc1Rnn+Py4DdiDbFzO6YDFL47myQpjAY+?=
 =?us-ascii?Q?H06voCY6AHx2xgsVp/0i6MiCXoKOZ1REU9WxKLZ0yROOwU7nM53BmXnwK3+e?=
 =?us-ascii?Q?WpYfGU0etheO5bdcx7UfFwdk3dRBv53ORnC0ByKyxAw99JBUTSIykBq026ni?=
 =?us-ascii?Q?XxpaL3nW+o8TW8dutR5h4qi4re+wDJp/YwLHQbWdCRaRmB6A+eF/BEz2IU4U?=
 =?us-ascii?Q?bj7d/hcSpp/W9505111bN8q/x2llM2M9aWN2xeczQ3LjhxyNJc2J2xylxpHa?=
 =?us-ascii?Q?G1gS0KRk1nNjUFFfFkefLjoaUtdhw08XsRpKiT8V78Iy9H/hJyftST/PyNWE?=
 =?us-ascii?Q?UBfRnZZsaxhLlIvUa/zFrDxq05SnrXjK/L9wYT6x2Ddi80RsyfEdGXhPxxYb?=
 =?us-ascii?Q?T6WqszNqjZXeiNE7iPT5rqDt/QXpBurUVf12zpFnUHiXn2VX81orhIIeAiXT?=
 =?us-ascii?Q?F4aaJHv+wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe601bc2-1c1c-4c29-4940-08df3f22f907
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:05:55.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDldVHTYUhwfHWvnCZu7PS518gNxBgTkq3vCO3VMpmzZaLkRWhLTn6xSBIuEpuRvW+OaJGplddt7Hyje8fRUUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB572389

From: "Oliver F. Brown" <oliver.brown@oss.nxp.com>

The hs_zero timing is computed as

	n = (144 * (hs_clk_rate / 1000000) - 47500) / 10000;
	cfg->m_prg_hs_zero = n < 1 ? 1 : n;

hs_clk_rate is an unsigned long, so the subtraction is done unsigned and
wraps for any rate below about 330 MHz, where 144 * MHz < 47500. Because
n is a u32, the wrapped value is never seen as negative and the "n < 1"
clamp does not take effect. The garbage value is then truncated into the
8-bit m_prg_hs_zero register field. At the minimum supported rate of
80 MHz this programs 199 on 64-bit and 181 on 32-bit, instead of the
intended minimum of 1.

Make n signed and do the arithmetic in int so the clamp works on both
32-bit and 64-bit. The divided rate is at most 1500, so 144 * 1500 fits
easily in an int.

Fixes: f4c8116e294b ("phy: Add driver for mixel mipi dphy found on NXP's i.MX8 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index 0928a526e2ab..84bd21aaf9e8 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -191,8 +191,7 @@ static int mixel_dphy_config_from_opts(struct phy *phy,
 	unsigned long ref_clk = clk_get_rate(priv->phy_ref_clk);
 	u32 lp_t, numerator, denominator;
 	unsigned long long tmp;
-	u32 n;
-	int i;
+	int n, i;
 
 	if (dphy_opts->hs_clk_rate > DATA_RATE_MAX_SPEED ||
 	    dphy_opts->hs_clk_rate < DATA_RATE_MIN_SPEED)
@@ -276,7 +275,7 @@ static int mixel_dphy_config_from_opts(struct phy *phy,
 	cfg->mc_prg_hs_prepare = dphy_opts->clk_prepare > lp_t ? 1 : 0;
 
 	/* hs_zero: formula from NXP BSP */
-	n = (144 * (dphy_opts->hs_clk_rate / 1000000) - 47500) / 10000;
+	n = (144 * (int)(dphy_opts->hs_clk_rate / 1000000) - 47500) / 10000;
 	cfg->m_prg_hs_zero = n < 1 ? 1 : n;
 
 	/* clk_zero: formula from NXP BSP */
-- 
2.34.1

