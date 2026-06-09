Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9003D4104;
	Tue,  9 Jun 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986255; cv=fail; b=o5AKL7bMrxrbtVv7ypy76jWg239f7AcVKaAcvQqFFhmg7/Mj/uFH4FOE3ADEz3XnNGHjf8rdXa+Q+jC6DUJ3ABLyNOI2CFld4DJm9IpdNY5fI6rzCUqlJku9fB8uKX6w8vPd3abKZSuX6bT9blxTlwil3uIWrAXMbsyXHhjxeas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986255; c=relaxed/simple;
	bh=/XAcPn0kP1NOJY7pYZz56J8LmdU3CLlP6tXzr1mXM50=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RmdNYLXOoEUWzXp4BdEjZd1ykkrF5tnGHrJdVhhJt5BI50o26BFIhoomN29wJC1yNCsuDYcpijJ/IqMxP2fKJfZbOdOI68oPUbsesVM0O4xLJwwwINgAP9OaaQE16zG7p4UAHhmF4Wszaa/KluOpQmcMAtxfq4gyIsuwn5oI58w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UxykPyty; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UxykPyty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+qxJsVTk+U4KC8RnzWy8ffq40HyQOs3YLK/0bzFQio2nOcHmEVYP1wLaLbwyA08/v7GW7Q0j6EvHYwPHezOEcpZcF8e59ICf8YtHsRhhwIkhfpxXtjN9Aje2SHLTJENHtFxcp5QY7nUY5X3GX8C1Z740+KrmiuYqNsWXjk2dvkHjVhMxSu/tXAlsGjgbcuVnNK7OWq1ncXQ393llVuqu6oKRPfLk3CEHMuYjmUSHm5t8j7ObyRDl11t6LqQflBHyX/thYoAwd1BqvVf2SZU3oVX4pdOpDFpGq+RimlZDGBDLOuX2PGZmDN2BkiGGousHVMcBHYkZ5x7N4BlpcTr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCmCOGSQi8S64hdrWiSiFuKR/2QuE5zVgBUy4+TdVjw=;
 b=xL38DfvUYK+qTngYiY7MREx0m2ylfEG8Ad+DBGgwJBDCNrtcEIWZzCspYnc17VZ/UcZRaLBDYXIgiW45grBBkfHvk84eAOTC6wh9o18nZr52RsloRPH9JyA2UphTc0GIWcXpKp3RRB/b1cnQ/CXIYAir1uA1veSL5zybj7+UxUDFN9yD3tu9Ljdw0u2jK3kjIBSzdjwH6Mp/tyuZ9biVksYx4JXeonsjHCkoHw8SlzxpFVNyfkUtwVuF13hMq8Rm/r0y+0aPTMAAviHLSQ+IYfW9JiAOKVaJbZs9MEHbcjKHqjb0UXWamRH7jXa4glFT+uANke7IyNagv85VRhyuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCmCOGSQi8S64hdrWiSiFuKR/2QuE5zVgBUy4+TdVjw=;
 b=UxykPytyd4oXiGXNJo8Yuj1xXtsrbboce4FooJ8phW4WhrrJzaDvwwLY6f+Xr7y1bP5cGReITAomt0zaPhYdbTOGeq8O1rRI34PnDaRAbDahdrXp9AITMo+YWLsIomJP+5q6T+a87e1DJeYy1bc9t2VnggzA83VSeFSFXEOBZsUrFbCi8GQWyZffY8W54X4kI65XjmBfrHh6YLfjRmDoI5rw78Cix0Y9V4GBr9eqC2+5T5tsFwxxX+rOV9RtYvRM4zNE5qDP2RgP/EaQY8MhkR+XIqzraZMVlhuXHm4EV1q1N88axtU6skKUCLtv3f56pURk9JCISLxe42WesUsiZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by VI0PR04MB11670.eurprd04.prod.outlook.com (2603:10a6:800:2fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:24:11 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:24:10 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Tue, 09 Jun 2026 14:26:41 +0800
Subject: [PATCH 2/2] pmdomain: imx93-blk-ctrl: Extract PHY as shared domain
 for DSI/CSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pm_imx93-v1-2-d06c004b0f51@oss.nxp.com>
References: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
In-Reply-To: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Guoniu Zhou <guoniu.zhou@oss.nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780986431; l=5025;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=/XAcPn0kP1NOJY7pYZz56J8LmdU3CLlP6tXzr1mXM50=;
 b=Kih4XuLKkYbrW8RHtiXE2qfMWCzNLLHL40f1FC7DjdUy15OdU1f4v2hhBmmG1PToMHwMnsi4r
 BsCH7CslkQoDTvwYJLfjutxduivQMZPYLyTPRaM5lOoanRfMIkcg9NH
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|VI0PR04MB11670:EE_
X-MS-Office365-Filtering-Correlation-Id: d8711de3-b067-4b6b-b7b0-08dec5efb7f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	37JlnQEfNLKv5joj0l2N2gIJmqpeh0m09YeDSMZL+5b1izsXX97FG3JY0+NqYHDNX3KTwm7LnEKi4smegcobXYKPlNZ1gnQmMcfoTMLPuoiPPIMBkmF190S5Qv29G6awA6B/XyBrITT0UkQnZCI/RK9abm57Iyg8fxWvowzNXS59v75dkwirABvQ9FmKWVuw8TOyxYOqW2QBiY5xmPQ36JYGjfI/rgmVayDMAxHpYkqrzrTPJqJi7HUmQKXVdSEc8xTX/Ym1szbIf4tgDFwEMz7+22dWr5TegspHQ7yBCkV41tPBunpe+xXi0YS5ILZaUTNaRJ0399Hk+dTgPnjvKaiJ7gOO9SG/663XRfXvIqUdPkUCFkW/u0+1CqUR2M1SjTTzgPG7ny1KHYrxZLOFVrhARUyS4GojlqUclLUHdrLbOoOP//bK2gK+5efL9t5/krwzYknGFwO/tivaXMvoXATH580TTNqyi0zt7nkkFfDvlEb9NnefCt6PmZ9eR95BnjPYtzAV5OIFqS3DepBOTcKbVEuFW2kQT6Ysvrc2RBhuxC10do9LGQ0uts7wq3q85ONFTanPIt4B7kFElHR7ylO8Rt0Am27aJ/vurj7dvsmq1CBvOkBiOqP5weLgR7th//0sTezJmKGYXE6ij9vXH+mHGvhV97EKCCuGb65KgpJiga1M3aBf00ahcmofWXlRpA+rn4cngg/oTp2JuHDEVMg5IminfFNcsRsYznp9oiPAe0QIm/awPTstiVuIe4MTXrIHBfw+/0MwkZEZI8pSoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVFJVERkU2hUcGhpOWFQQVorQ0lJQ29YK3FzQ1I2eEQ0L000STY5NTUvbGtZ?=
 =?utf-8?B?MlB1djdhdGNZaDh4WGNnNmJGU29LZzBOTk92UU8rUklFTmdSZGpPblJnTE5I?=
 =?utf-8?B?R0ZTYUNOa0N5NFV0TWtNbU1iT1dURjNzWDBBNHU4RlJHcDVJWFREeWhMMTQw?=
 =?utf-8?B?aHRmZ0RUa1JPdWJXZGlmcGhJbEhwRUl5WHIrcDRBY2NGV0ZHcXlKTG4rSGdF?=
 =?utf-8?B?bWRKU09VaEVmYnIySkh4UWJyUXMrcUxvTFNkZ2YxWVl1ajZxV296R3QrUlhu?=
 =?utf-8?B?T2ZUT1RjK0ptTXJCQmIyTVFReGg2cmk2WEZXVERiSmpuaVV6bmpKMGE3aS9a?=
 =?utf-8?B?T2xMYW5VQmlKa3UxeE9ua3BoSFpFYktxc0FUL1pmWDlXVDdIUnl3eG5teE8r?=
 =?utf-8?B?bVNEbGV6d1ZROHZFc3VkTUZRVG5hSW5jZEQ3Z2FReURrd3lTc2JmSHFqM2dn?=
 =?utf-8?B?bkJqZnFZZi9RMi9ZQlZRQUNpNnJxMGx0YTZueXBlQnRkWWVKNHNnelJoWFY1?=
 =?utf-8?B?akJwdlVUY3BKUFlsYmlTbDAxamErSVFBY0ZHanhWcUtlcWEzWTNLMU90TGMr?=
 =?utf-8?B?QWNScW43dTFlQ1ZFU1E1OUdpK3VsK0Q4bnQ2K3NnOFpvcVpzeFhJUnlMM0or?=
 =?utf-8?B?cFRzbnY3UHFpMzlHc0R2akNNMlkzQnZZWWpSSkYzWkJJNHVxeGJlMEg4TS9j?=
 =?utf-8?B?M2RnSjlRSmZ5enEzYW1wa09mZFJqWmxVT2RWeS9YWHNXdGlzd1YvVFFzalNT?=
 =?utf-8?B?b0lNckdSSDByZk1SZEZqZFk3Y0gzY1M1RklaZi9XeDV5aVdUQVVkblpaNG1L?=
 =?utf-8?B?UjJTeFVaRklDb0FscG5JV1ZwbEV5MVJTSkg1c0ExK3dIL0JvVDBDbGNUSUov?=
 =?utf-8?B?TFRHVS9sdEwwaXhOSENDMm9hMWtWWk9FYi9Kbi93Z29GcE9LUXZEVDg2R3JM?=
 =?utf-8?B?N3RVeE1mVFNRbnROd3ZwV3Q0UUdTN0RTS043MUZqbUNWUzBtM0x1OXBGaUdD?=
 =?utf-8?B?Smo2VG1ZWE1JeTFmem5LamVzRE9FL2RGNEpOdEJtQmM1VStGQ1FaNDNSRnBG?=
 =?utf-8?B?QWJtSFFKdjNNT2UvaGN2anN3Sy9tQkVsSEVvWUVaT1E1OGZHMEdTeCt3OTYw?=
 =?utf-8?B?VUxDeE1XcHFvZDcwSU1USlJMYWt3MVF1eTJWTXZFa0RaQUVIOU1Ra1hTN2tF?=
 =?utf-8?B?VFMrVnBwelVPR3oyZjhEeVY3MTk3d1ljd0Z5MlVXaFZ5VUloTlBQM0xQSXBS?=
 =?utf-8?B?dWY1ZUtDM2ZlZVpOUmdnZlZET0dveVAwZVg2WjVlRURUM3R6bWc4SUlRVXRz?=
 =?utf-8?B?a0xlTi9jL1lKdW9jRzZTN01GZkh0TTFCYnk1VjdOcEFiNHZnRWpVb25LTnZK?=
 =?utf-8?B?UTZ3VWFyQW9VS0I2ekNHYW5XWWRxbzlRODVKbU8wYnhLY0RjUVJlY2hHZGtV?=
 =?utf-8?B?TW9wUnZuTmE5QzFZZFBVNG9SSVN5YU5uK1cxRUttelRHVnRlR3lRSkxTMzhP?=
 =?utf-8?B?amt1aXprcWNBd1k1RmZnQjZ2KzVZb1ZkaVF0S20zdUxId0JSTk9BMWdWL1hN?=
 =?utf-8?B?dUVZL1U5UHlXWFFGeUphQkJqa3ZjeUthYldibGkrNmhOQkZqMzhmeWFFek9v?=
 =?utf-8?B?U2FJT2ZCVFVkbXRGMU1NN0lXVWxOeVRWNS9ab1k1cTRHcEpzdnRjOHpNZ2Rl?=
 =?utf-8?B?eGhSdjRncXFVcHJhd1VnZlh2T1M1MkxuR0dhTWoxbjVDVEJNRUFuWjdHcEZ3?=
 =?utf-8?B?SEpTZHY0VW1KQnA1ZjFlRUlHWmdGR2xhT3RvOFdBNUpmckx3NW51cCtqTmlz?=
 =?utf-8?B?Y0xTdU1nWmlhbXhUMVRWR2laR1NrUkFKMFV6Q3dLMk1wTDFJU2hySXhEMnBh?=
 =?utf-8?B?VUFVQ0Z2RGNma0t4WHYxL201ZDllUnFYVXFvVE5wcXJyNVlXdlA0NU5QNHQ2?=
 =?utf-8?B?VG12QllkUDRCeXJvS0hvUmo4UmI3S3UxSWlVOXBXYkc3UmJUOCtiTkZLd1FG?=
 =?utf-8?B?b1o0c0IvTnR0US9TYzZybzd3K29CcllJSVJPdzM1dzN4YWN6elp3aFNqa2Fj?=
 =?utf-8?B?dFpvZHRubVVFOHk1d08zNFBnalBzdWE5Qi9DWWR2OHQ5NHZjSldpcFdGWjN3?=
 =?utf-8?B?bzVTcU04b3J4NVRKSFB4d3BFdkVWYXMrSEZkcCtMbGpGNG5FKzdqcFo4Q05J?=
 =?utf-8?B?bklDYkMyWGZ4ZDZ0K0Jpb1hleTN3Q01JdUR1NTFxWWV1YklubnRRRllySnh2?=
 =?utf-8?B?YjhBdndFdzZxbmY4OGVBMUVZR1NmNENFVEZ3SkNGRXdVVzRUSGlBQ09Qc1Y4?=
 =?utf-8?B?SlNURFFTL0hLcHNvb0dSQlkybzY5b2YrSG9HbG1jckhZWWVZazdzZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8711de3-b067-4b6b-b7b0-08dec5efb7f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:24:10.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P5m6ta2qx1L2ujkCzAUTSxRJmgAkJrOhU5i7+lmpFtFa5xt/067GQjV9Td+R2T4EgP3rXclX0Poua3irm/Ecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11670

The MIPI DSI and CSI domains share control bits for clock and reset, which
can lead to incorrect behavior if one domain disables the shared resource
while the other is still active.

To fix the issue, introduce a shared MIPI PHY power domain to own the
common resources and make DSI and CSI its subdomains. This ensures the
shared bits are properly managed and not disabled while still in use.

Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 60 +++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 1afc78b034fa..243ce939ba68 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -48,6 +48,8 @@
 
 #define PRIO(X)			(X)
 
+#define BLK_CTRL_NO_PARENT	UINT_MAX
+
 struct imx93_blk_ctrl_domain;
 
 struct imx93_blk_ctrl {
@@ -68,12 +70,18 @@ struct imx93_blk_ctrl_qos {
 	u32 cfg_prio;
 };
 
+struct imx93_blk_ctrl_subdomain_link {
+	struct generic_pm_domain *parent;
+	struct generic_pm_domain *subdomain;
+};
+
 struct imx93_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
 	u32 rst_mask;
 	u32 clk_mask;
+	u32 parent;
 	int num_qos;
 	struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
 };
@@ -203,6 +211,13 @@ static void imx93_release_pm_genpd(void *data)
 	pm_genpd_remove(genpd);
 }
 
+static void imx93_release_subdomain(void *data)
+{
+	struct imx93_blk_ctrl_subdomain_link *link = data;
+
+	pm_genpd_remove_subdomain(link->parent, link->subdomain);
+}
+
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx93_blk_ctrl_probe(struct platform_device *pdev)
@@ -302,6 +317,34 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
+	for (i = 0; i < bc_data->num_domains; i++) {
+		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
+		const struct imx93_blk_ctrl_domain_data *data = domain->data;
+		struct imx93_blk_ctrl_subdomain_link *link;
+
+		if (bc_data->skip_mask & BIT(i) ||
+		    data->parent == BLK_CTRL_NO_PARENT)
+			continue;
+
+		link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
+		if (!link)
+			return -ENOMEM;
+
+		link->parent = &bc->domains[data->parent].genpd;
+		link->subdomain = &domain->genpd;
+
+		ret = pm_genpd_add_subdomain(&bc->domains[data->parent].genpd,
+					     &domain->genpd);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to add subdomain %s\n",
+					     domain->genpd.name);
+
+		ret = devm_add_action_or_reset(dev, imx93_release_subdomain, link);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to add subdomain release callback\n");
+	}
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
@@ -326,8 +369,9 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.name = "mediablk-mipi-dsi",
 		.clk_names = (const char *[]){ "dsi" },
 		.num_clks = 1,
-		.rst_mask = BIT(11) | BIT(12),
-		.clk_mask = BIT(11) | BIT(12),
+		.rst_mask = BIT(11),
+		.clk_mask = BIT(11),
+		.parent = IMX93_MEDIABLK_PD_MIPI_PHY,
 	},
 	[IMX93_MEDIABLK_PD_MIPI_CSI] = {
 		.name = "mediablk-mipi-csi",
@@ -335,6 +379,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 2,
 		.rst_mask = BIT(9) | BIT(10),
 		.clk_mask = BIT(9) | BIT(10),
+		.parent = IMX93_MEDIABLK_PD_MIPI_PHY,
 	},
 	[IMX93_MEDIABLK_PD_PXP] = {
 		.name = "mediablk-pxp",
@@ -342,6 +387,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 1,
 		.rst_mask = BIT(7) | BIT(8),
 		.clk_mask = BIT(7) | BIT(8),
+		.parent = BLK_CTRL_NO_PARENT,
 		.num_qos = 2,
 		.qos = {
 			{
@@ -363,6 +409,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 2,
 		.rst_mask = BIT(4) | BIT(5) | BIT(6),
 		.clk_mask = BIT(4) | BIT(5) | BIT(6),
+		.parent = BLK_CTRL_NO_PARENT,
 		.num_qos = 1,
 		.qos = {
 			{
@@ -379,6 +426,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 1,
 		.rst_mask = BIT(2) | BIT(3),
 		.clk_mask = BIT(2) | BIT(3),
+		.parent = BLK_CTRL_NO_PARENT,
 		.num_qos = 4,
 		.qos = {
 			{
@@ -404,6 +452,14 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 			}
 		}
 	},
+	[IMX93_MEDIABLK_PD_MIPI_PHY] = {
+		.name = "mediablk-mipi-phy",
+		.clk_names = NULL,
+		.num_clks = 0,
+		.rst_mask = BIT(12),
+		.clk_mask = BIT(12),
+		.parent = BLK_CTRL_NO_PARENT,
+	},
 };
 
 static const struct regmap_range imx93_media_blk_ctl_yes_ranges[] = {

-- 
2.34.1

