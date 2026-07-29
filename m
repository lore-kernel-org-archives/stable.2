Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1D3AEB5D;
	Wed, 29 Jul 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306908; cv=fail; b=AHWH08BjSWLtFqZFQDCl5/MWBHq8Y7vRWN8tujr/dkJqGchFxejjOxQ2sLgiZy+zGDJ2uXdOtm+8wvLy8A0yBo78yvmlTPVEE16rgUSWvZPH+kcFsNgpTTWdE1i5RxXqP0H8Ny/V7OccetvlJ+geihF4SubV7P4zyiY9TIv3IGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306908; c=relaxed/simple;
	bh=x1AR88r1BuleHpkr1zXkTel7BTRjeRPyGM730WCb6kw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B/uB32srQMFysHi23c7Ad4Ko4+b0GPq4m6z47i3sRbjT7gZ1cmd66lkxatZUuI0N3tWPTX0CyN+GPnQYthueniVIhtbfwRSQ98vTUrBQ8N1GtPTS/+RXSyLzvP5Rx4eurICqyzxzk3XXwSCP7SXX7rfjkYaLKtCbRoaaEHSsVPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q3Qa/+0t; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q3Qa/+0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X06zjZQHSj84iz/Rs78vuCd5FfYcYySSkSQD5/rkfD6B3Q8ANiF22k5Z1oIFhUTykiAiBvmKKDrWxRbLzAr/ou3wMT9hZsqLTvX5pNyPMttjncTPtFEK8YFr1j1rN55+DWy63jzoOUe97hCQ0ku4BKpsOsh74iRNSpyaIHmgmO6GWHMpmWJJeiBVhZnZtGTk2j98Q+OUC7yCkI2dIw140LQlwpqJPHHy2yLk20NmiyxlXNdnF2y4FDTtd5xVgpj1W/lkT4PRJXFCWLEHcFv0MJW2rNWnRcOQecc4IzT7TrSYI5UDPWuyPXNmDG7cFOFdwAMLso7aW03/H9msk2VE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7dTVKwMBoGAizsc2qs5ftNpg6U7c35yxPoicjhbLfc=;
 b=BIPkNxsNXOeN+j8R8B4vgI3C1WKALcpgFls/qNDssjKsxRRANukMdA/4uwZuWASvOvfZHmS/eALs0S0XT58MiNXQZzx7yBoY3Zlnzq+pBWnDe3QGmLL45ecwGB8XvYbzpgxR1C9d+moGh2zpJnoSO5s1rX07ZFXT3+Cqao7YigKZM5rZG+i6YpJQE8YvYRrQPjphZ1h/1Pt5bI/wCghNq80I3R8fowf2S6MlxC62BaWNDdNnygn5PAO8Y+nzTvydlCD/vsSkbUL53IRc5htePkWTBBqm7/teYyKpEFH3ei80sfrw6z9zqanWmUuNhGuYMInN6DZ0O3D2KYT4nkHCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7dTVKwMBoGAizsc2qs5ftNpg6U7c35yxPoicjhbLfc=;
 b=q3Qa/+0tzg8jbB8rjioyGGAWz9gPqktnsxzsxt+NZ2t5qR7j6Bv7nYDhlxeEfTDlH/l3GoO7b/nn60Zcvy7P+B7kSFMGyFlC2dEFY/IAmzxokqhV5OH9rHZc84S8VCf4dZ2203PEJSk9My0vw/JWFRlevtcMyMkVSqFItQrh3LDha5Uhk6kaC1hrDqynvVKSmH7o/HgZ73yIuhleXMshHE8xixZMMCIZ2SI6lENJEdN76DqXsZM//BCd+c4f81W94WaNc6Kfr/Gozl0rkSCd2v6vRPNGA5zIGBWkS7/NN1T5uSzMPd+0ZJOuIawXFJ0JJ+rXX9DXfV5L/Qs8NEeoLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6)
 by MI9PR04MB826873.eurprd04.prod.outlook.com (2603:10a6:290:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:35:04 +0000
Received: from DU0PR04MB9418.eurprd04.prod.outlook.com
 ([fe80::130:1767:2462:db72]) by DU0PR04MB9418.eurprd04.prod.outlook.com
 ([fe80::130:1767:2462:db72%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:35:04 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Wed, 29 Jul 2026 14:38:30 +0800
Subject: [PATCH v7 1/6] phy: fsl-imx8mq-usb: fix typec switch leak on probe
 error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-imx8mp-usb-phy-improvement-v7-1-c385ee40ade6@nxp.com>
References: <20260729-imx8mp-usb-phy-improvement-v7-0-c385ee40ade6@nxp.com>
In-Reply-To: <20260729-imx8mp-usb-phy-improvement-v7-0-c385ee40ade6@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785307123; l=2891;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=ZsDcvxpPXbUZuAxaap5cZc1C/zvW1XKKeEqtWdbC+X4=;
 b=PYnQOfWvtkfsXSusOMlFChA+eZYmPxGN6rT8yN7eQIY67KDuRR3W4mDuorOWRBkGKHlmE0aa3
 cqKDHa5WYGnDFYQyYomQBO5mRMroi3xeow7r8+Jipm9saSlXuvATfuR
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To DU0PR04MB9418.eurprd04.prod.outlook.com
 (2603:10a6:10:359::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9418:EE_|MI9PR04MB826873:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef9ee6e-a13d-4b8c-6846-08deed3b85ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|7416014|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T++Lh92mNEHOBeB34NZ07ZJAaUhCtd4gwB4mxydSRyo3itEcb7knxdXw2P/awaAsOBfVkeyl009oyJmDEui4EEB6QRg1JzGcZsX4ybWnNA4LWG/dU3sWbdAjLZgGrrHKcLKh0Ks/YvLe1rG6dAPSaNWw99eHdfUo/UYU7qq/pizo/rilh5PaqAf/5kVe9P+t86K/3wKdN6z2jfMDJM4IKPigxzgpKUa57LiPWqP+fsr5YVjylDrMCx3+VuUBCgDadh6oqmiBYYdeRdFBcTHgjMJgPdVFigqHwoWGheXUyZdvpWy+zVWHoeVt+/GEk7/CZk37SUVxme0kS40UeP8abUwBTLpnsGjAWhsUUPOsauHaHigg6fPgvH8Sb5ZAZa3HQtU5IwE/CStOHxjk2wrqgJe71Gugh9v0lij7w2bf1XdO04WjLIRuZ8EEUrYhlhDNjqoOWSgdJ1bZxT/jycwk3qfOEkoLwqwMR2kZJbtS+q2WdPK33OCWU+E+nBQwf09/tcmhgSMGlWQcSri1Ab42T+FgVCZvRR+8lP+u5TGnLL6JjsMwmJjHL1odjq/BwKPYecdnnfIWBs0+nKGLbhf88PmOggVAtAfwwOdpWqQV0CUAC/yy9/F9SIEY9bcl7cbojck5GyDgsc3drrZwrmDZPA3i50lOTUzQ2waoliZykMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2puWE5QRVhTWGg4NGZwQTNNMW5QU1dUOGt2Sk94RjVuVnRIVERvVmJsQU41?=
 =?utf-8?B?MjdCRlVJWmU4ZDAvRUlNNGdtQXRTbGYxdjk4QWZ4QjNDdzNzZ1U3UTFVNzVF?=
 =?utf-8?B?TjllcGd1YnQ0YkFyTjZqZUFrZDhVM2U3dys4OWJGUlNxTTk4cHk0VzNacklE?=
 =?utf-8?B?SHdiTGs4UWFpMzhpQ2RKSUdGQUhWV09YVE9qUGVGeEQ5ZW5YWERXRWwzSm5F?=
 =?utf-8?B?UHRMNm9HbXhDdElqb09UdE9JZzFBay8wS21BTEt3eGIyWC9LTERBajZSY3ZK?=
 =?utf-8?B?RlFxTWtCVVA5V2pXVHZJRWRSMVNtdElyWGJPMC8zSyswMzhmanRJWjcyYVBi?=
 =?utf-8?B?bDZzVmRVVEhFRG9zUjFiQ285UktaaHhyZVhDRWRmanlHNEtpNlkweWgxTTdT?=
 =?utf-8?B?Tk9wNWxGSFhtVnVNVEpXeTZvcWVKSy9WU3BtWlZlaEVNb0NrZ2FtK1Ivd01w?=
 =?utf-8?B?U1o5UkNvYzFhSUdPWnJCRnRscnJJK2NUZW52TkFrY2tDR0FQN2JtOVowL0c4?=
 =?utf-8?B?V1FIZlNOT1d3YmMza0JOUy85dlJ4Z0w0ZGpmd0wrWUx6dzNYUEFjNktvRGNx?=
 =?utf-8?B?OEtoYWRRaVc5SDNjSWJNc1pEck95VHgvazNGZ2ZyUGJKRlJ2b0dib202djY5?=
 =?utf-8?B?bG0zVUluanRKc0t3a0hac21EVGRXK2hYblpoeUZ0aTV2N3cxYkxCMzhLMDc3?=
 =?utf-8?B?OXdadlRZTzIvbzVDSlpnMWdSSFVoejk1NktkaHNxb3FhMUxNYWxnTkVzZXR2?=
 =?utf-8?B?eWl3bXhZMzkzRXVoRXh4L3E4SWNuZ2hhK1JQZWI2MkVwamwrQVVGQTJJYWgv?=
 =?utf-8?B?d1ZMNVFYZDA1c3JGSTYrNXJMQUYyYUkvNExoTE5qMEFDNXdSVDBMZWRpWDJ0?=
 =?utf-8?B?Y2tZTXp2c3ZUZFpicFdmRHh2cFhhbGpLL0VtVXhNZmNzcHlocTR2bm1aMExC?=
 =?utf-8?B?N2pTT1Ezb2FldnI0TTFmYlFEZEU0ajkycjdyTjJHVnE1UHhIUGRPSytnTnlp?=
 =?utf-8?B?a1NoTzNwNFpJbXpma3M4UVZpUm5kVEdlRENOR3A4bHNzOW5mcWh3RlQxY0FW?=
 =?utf-8?B?QlVmVTkvWUdjOFFjUGtaV0FQb0VPZUhtL0d5b0krUUxPb3cxREZMZEc0ZFd4?=
 =?utf-8?B?ZzdwczgwUmljRkFIK1YyQlpnZVpQekZxSTFSUlpuOGZPR1NVSng1ZXRybklS?=
 =?utf-8?B?NFloUWxFUlpyeVBpYTBJWC8rZFlLc2VCbG52bFI3UDB2OWRuUGk1R3JqMTZE?=
 =?utf-8?B?eW5CWUlNWHJrWlRqM05JdUJNM1ZQY3hOREg5QWxBY3RkaTZ6V2d1SmNUOGhq?=
 =?utf-8?B?TW12ZE1NWDBIUjhWenRLZEFOSHFSTlRraUc0S3d0M0hkaVMva0RWNDJFQlFC?=
 =?utf-8?B?Qm9hdC9yUzlJNHVDUHhFYzh3MDg2RUZ4V21FTk9OTE9oZnNYUHBENTMrYkU5?=
 =?utf-8?B?NHRobDJ0RzNZVW0wZWl4R0twbUE4S0IvZFZFSERqRGZjZHhObWR1N1NFanZz?=
 =?utf-8?B?Mm15SXA4WDZkLzVYZW9zRHp6QWhOYXJtSVpmWGM1OHNqL3gyVkUwSHVVVE1V?=
 =?utf-8?B?YmRtRWlhVU1pamNvQkdFam5nYkNYNWE0MUJVbXZhblpUZU5XQ2JWZlM2NUdZ?=
 =?utf-8?B?TVF4aSt0SWFGejdkYkYxNEM3anZlOTVzMXFDMkVselFzMDNOTC9rMWlpdE5o?=
 =?utf-8?B?ZXZPeFJsSndLY3FocUUrSUJlaG1sdllLY0g0SlZtVWh3RU1xOHVYNEZQd0ZX?=
 =?utf-8?B?M3lyUlIzRGdCUE1kbndERENkYW91MjBtZWZ0ZytHcFdXdVVFcXZhRmNMSFM1?=
 =?utf-8?B?V29GU1pQd04yd2x4OUZvMTJyck1ocHBtRTllM0lZeXJIZXIxd3RhcHpXbFJo?=
 =?utf-8?B?Q0k5M2QzeFh5aU1iUERtMllGSitWU0dCRkF1SjlROWZGc01yZWhuZGE1ekhE?=
 =?utf-8?B?eWJkakR1L1pnUFJ0NE5aaHN1NDhDMTFuaUJBMWIzR1FYMWhGYnBEZ2hQak1v?=
 =?utf-8?B?bXJEYjNHaVk0eEN1QnpEclhYR2ovVHBJVGs1QW16K1hxcUV4aFJMVVk2aWRH?=
 =?utf-8?B?VENMKzRYRlkyWlpQMzRBVUtKSWVWNHFkOWs4STlEbHQ3T2pYVUFEMGk3aFdi?=
 =?utf-8?B?OXVLdzVSM1VZYkMwVkQxUGhuNVZZakduS3phMTQrTk9IVDZQQmg0NlB6YjUz?=
 =?utf-8?B?cEh0Zmo2S1gzSnd2VW9NNTlxY0dXTm1UeEtHb3NkbGZSanp6YkdHbjZBOUdB?=
 =?utf-8?B?ZHhEejV2L2ppV2dlQ2h5RVJua0hyek5Tc3d2eng1cWZkemJuellWWkpxVXZN?=
 =?utf-8?B?WGEvRjd6UU9NM1YydmVZZmovbTdtQUd2OFJlQkVvdi9ybjIvOE9uS05NUklp?=
 =?utf-8?Q?ydg4viNja5vjDRPqO009WJGyqewhQsbVmzXtZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef9ee6e-a13d-4b8c-6846-08deed3b85ff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:35:04.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylON5Jf268LYQB5E5NOs2HIn1Arv5SLa3iAuLefwY3GwHSr5+P9TS4Vssj1PCP0F1/j/ZipfdyXaRHE2cXkhZRx73HcRuKFDp8p8MKq7xPbJc29B9arwWY6QeUNv2zlN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB826873

From: Felix Gu <ustc.gu@gmail.com>

If probe fails after imx95_usb_phy_get_tca() succeeds, the typec
switch leaks because the only cleanup path was in .remove(), which
never runs on probe failure.

Use devm_add_action_or_reset() so the switch is cleaned up on both
probe failure and driver removal. The imx95_usb_phy_put_tca() is no
longer needed, it will be removed in .remove() too.

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - no changes
Changes in v6:
 - delete .remove() is deleted words in commit message
Changes in v5:
 - keep remove() callback as patch #3 needs it
Changes in v4:
 - add my signed-off tag
Changes in v3:
 - add R-b tag
 - cc statble
 - drop "sw = data" conversion
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b05d80e849a1..9a33c06d6fc3 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -173,9 +173,9 @@ static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device
 	return sw;
 }
 
-static void tca_blk_put_typec_switch(struct typec_switch_dev *sw)
+static void tca_blk_put_typec_switch(void *data)
 {
-	typec_switch_unregister(sw);
+	typec_switch_unregister(data);
 }
 
 static void tca_blk_orientation_set(struct tca_blk *tca,
@@ -248,6 +248,7 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct tca_blk *tca;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res)
@@ -266,17 +267,11 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
 	tca->orientation = TYPEC_ORIENTATION_NORMAL;
 	tca->sw = tca_blk_get_typec_switch(pdev, imx_phy);
 
-	return tca;
-}
-
-static void imx95_usb_phy_put_tca(struct imx8mq_usb_phy *imx_phy)
-{
-	struct tca_blk *tca = imx_phy->tca;
-
-	if (!tca)
-		return;
+	ret = devm_add_action_or_reset(&pdev->dev, tca_blk_put_typec_switch, tca->sw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	tca_blk_put_typec_switch(tca->sw);
+	return tca;
 }
 
 static u32 phy_tx_vref_tune_from_property(u32 percent)
@@ -741,9 +736,7 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 
 static void imx8mq_usb_phy_remove(struct platform_device *pdev)
 {
-	struct imx8mq_usb_phy *imx_phy = platform_get_drvdata(pdev);
 
-	imx95_usb_phy_put_tca(imx_phy);
 }
 
 static struct platform_driver imx8mq_usb_phy_driver = {

-- 
2.34.1

