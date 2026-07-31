Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5343C09F5;
	Fri, 31 Jul 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485270; cv=fail; b=dRrFrs63iBOIXLp9g9LViVUhJZFu3Mg8RHV8XpRem1ixFjMy7MqCZnkzwAWLF1cD4XClppuCwcCP4L6UQDAcxGORvKhlBFd/rn/AGjGgRBVic42RXFyCnUNZb2bpO/S+pPChAh7CX8errvtk1fbBnEj3vDQF4xwKT5CwN/tfZMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485270; c=relaxed/simple;
	bh=TaegA7Hy1Es3W2SgL0VNgr734Md4qXYNn5fq4LhUhw0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EwH+OR8pPVvpJhRdmkGQcr3ZkEuS3XRHo56cXImpfqVgl8qbz684ahWQwgreQYWoW/s2lnkHaa6VUUpiYz4PUEGrfQR0ue3MnbT4aCkZVxM1Utd1blT7XP5SD/M1smX+fhOV96w90V8EtvbaN6O088uZqtMTYlkdau+/2Yz8JX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vGm9KwO/; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vGm9KwO/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COyRaEd75lRwzwfdYXBCsb3RsOZRNQL+VQW+AiPbIWg0y+7MrGmPgFlgQqmhVRE/ZU0K/InoICJQ9oPu4GpSeSuCVcvSrmxLqHkZ2WyGaN4/rClxDZOTdFoNtlfD29gTCIDcQamtvYZ2zHVj0QpARv1Dfyd273zcFXZcu8FGrr9MmrxNat64Z1eB2zbLtonLzrKjbjX51apjT3/anh2FE0QPBgk5EGrUxydF41ON3PeJTojlDs8GGUPA6y/HKmdWvJGp1gSfBz3L492V+9fICdQ6BCh1P0/A72HXwsGerA8ZTbNhNAUahh5qN2es3+A/Nwl1Ff4k+7SZkEe1qk489g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ4EbefePnH7M/zW9n4Jb2rJVqJvBEFUKNy+xXjrmRw=;
 b=K1atpqPJwwghUz0p5jkcJ1HA12L7ojM3vjvN/VhuokT1kITNl/wywOj5SHs2/zZJBAJj592NBTkJUSSvgF+vaY2SbhL9imjLzr18EbS+kyRF+q5Kk5RXOr2gYIiZFy84ss4Y2rO6GhTH668OGxV+AXJDwSayuHSdz1/e1eLq0V7x51l4h4eTlSEvw2VBBVlSGcyL/MQmQ5gBQTvdVIoWd/w6TkXF1BTiBL7ghSxv8ayn2KTKdm/JR3LMyB4pYYAP7d+pEFn7nna7/NkYgckf90DZ3OqiM38o3E2B7O95bSDOPDa5Pe0c68BDh860S8bRNXMYCCSTZ05kHzkmNvvN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ4EbefePnH7M/zW9n4Jb2rJVqJvBEFUKNy+xXjrmRw=;
 b=vGm9KwO/mRzMxpSVsq+SDAAhAzhxGryRRYzXzddONakG32hlD0mjZ6JsOY0gHsGeLqUjspb95u4s9Aowfx3LqrPS77DYPOT+3ljha3jE8rRn5d5nwGf1ZrPtvZ//fzJJqi8FrlFrmJ7+QujxtBAe5o2d13nCyP5YiW7jEQ/jjxPLVDcfkai98yNhVxEziL10iTKO9c2koCknrS/xxmxDAO/z3SNyT/a+PiD22ww0CaDqYHqYDhl25Zlanom6D9ukUYq06LJ9p4kiBKDdYJO4mcXO/ii5ey0Bv/taxJKdEuMuaHmbgDV5038KVVk/JXV6qMd2hIS8HaEnFFA1XpvXVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:07:46 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 08:07:46 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Fri, 31 Jul 2026 16:11:19 +0800
Subject: [PATCH v8 1/6] phy: fsl-imx8mq-usb: fix typec switch leak on probe
 error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-imx8mp-usb-phy-improvement-v8-1-2ec8d6b3854d@nxp.com>
References: <20260731-imx8mp-usb-phy-improvement-v8-0-2ec8d6b3854d@nxp.com>
In-Reply-To: <20260731-imx8mp-usb-phy-improvement-v8-0-2ec8d6b3854d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785485487; l=2922;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=OcgMTHT/DO702/bwB0CMlIF78PTpDipwB842e9LK2nc=;
 b=MmFolJUZlqyii7BNo/36sxqQDDrLNXhCkPSbqlnh3nOTfujzLBmwPzc6+gsgAq/oUaHr7rp9M
 tk87Ok9IaQ4BOk0xM4vDHyBxDXAr+Q9mlbMxc9Tz49oeO5PaSkdjDWD
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS8PR04MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fdfaf6-1771-4477-5327-08deeedacde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Svvqpb67H/4qTzJgEZO48Ghxn6v8zvteE0EKzAwJ0jZr2nysCPYDoQ4HlUB0m6gVXKPCq2jU1Ez6rHIKrniNf0jvEiaXqWew8F3fXr873Bo9UMytcyLvhvvy1vqwwD4Wkv0Iu6tz5vcB4R8RB4UaqOe9LerqiF8P5TC52w7OnsHz+zZdfoDb60/yB7IDSt9LQByyazGxPmNba26cmQkZSvd4cMMznNXjccrl8yuia4F1Enr9ZgJj8ZLQjpnzUOYkAZlwb0VIcIq1w2avVGj1F9d2icylqxHmXdGL8iZXBz7yt5gxmbbRHH9kUeisGfxvSn05vznN6B+KyTeCupCJ64PsCbg2WunthEf1LbKATOPuVfFmgch6j3p4wY28aDg7Er9zPAMTZSfFhMPyU/w79UbTq0/ujXEb89Gg7YRmmKY5UxV+4GNW7WtQ5DtefNXsiKUn5yTuFSRGwpJ/98qFnjkx4CrdAerWZ0sry8QbG5f71vK3LKJdiZl8kr+SrUf0GoJWnpCzNBON9crYiyURLbyjAva69RgMdOgzUEN13i7jnwgOtPM5WqhtxzgmhTZ3zX9jogg3qIwlOyqC2a1OSCf/IYilyeFRBXfYXpQGQTsXRroCdhB1QaVUv8vKwOdZvWifdhOLOVdUG/3AFML+XsbHbZ0fR8kn3TBwBo/4k3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnJzWW1neHF5TzdNYUNzNk5zUFZmSVpOeUhDaDNGVjVSY245NGE3VDMrdGVM?=
 =?utf-8?B?OHdGazdFUlRtR3JIVGpUakpaYlZRY3VsTUd1Z21Fc3dRMjFweDBVQnVmRDcr?=
 =?utf-8?B?K1IrYWNpeWJYYjFxUUczZzR5OU5yLzhmWTlpTk5YeUlZRXdndUlvQ0d6N1RV?=
 =?utf-8?B?a1JBVWFOWnQvLzRUcVhZWmM2RVljNGsyZGlVQWZDalorN2sydGtKc29EWnd2?=
 =?utf-8?B?ZUNSY29Hb0dzT2Z4bHZJajczR01xc1ZLUVFTT2UwbFd6NHFIV1N6TjZtakVI?=
 =?utf-8?B?SWpXMjN0dTNUR0xQbVhMUVVYdXVqck5VYlRnYzVYTVp1NlFjdllpd3VUMXNv?=
 =?utf-8?B?ZEQ1UkVXdDdTT3VDWldyZWF1cjRJRXFtOE9nMmJXektXZHF4bkw3OWticHdB?=
 =?utf-8?B?ZHlUN012d3I3Z2poc3ZjdlhGcEoxU2hSbXNOT0hWMnNleHU5dUFBbGdPMWJn?=
 =?utf-8?B?VHBvQzR3eHlYRm9LZnZYWjVTR0Q1OWhRMDYwTkZoZnhtcGdXU2JJSUpyVmhR?=
 =?utf-8?B?anhNM0xqb2w1OUNRUXNmNnFHTHZDRUZkMmpzTDV1WFVHd0FNZ1UwbjR5SWtJ?=
 =?utf-8?B?eHJVUXFCUXh3ckJNNGtNcmI2QWxXc0x0V1RTbS8wOG4wRjZPNTNSeHBqWEYv?=
 =?utf-8?B?cHg5eDFyS3FZekxCVEt1ekRPZ3d6cnh0Wmt5RkNuUzJYV3BvTlZTSUN3d3k4?=
 =?utf-8?B?ckl5M2xSY0hJa3VvSEsvQnBIcW1yRklKMklIOXRvUFdvdklYWmFwVHpkT0ZW?=
 =?utf-8?B?Y3lNUGdSbFRVd3BBWXR3dkNHdGw0YVhxcE1xS2VaTSsxOWV3SzV3cmV2elNt?=
 =?utf-8?B?TUNxaE15T1hGNmJ5MUIvMkVNRWZjTnRZalRxYnZManJxaGMzdURTazJTd212?=
 =?utf-8?B?YlI2aml2L1VoQ3MyMVFSME5LN3pBSmJPMHJjZThIMjd6WGxQM0JQcmNBRllP?=
 =?utf-8?B?Z0JRR0pBYU1LYWNCTytYTnFnMWk1N1hwbGZLUml3TUlKNiszeENPU3BLZm9P?=
 =?utf-8?B?VGF1T3ZIRkhIdW1XR3ZvOHROV2Y0MlppWlZqa1JhVnozZzM3OU1ZMHBsWGlk?=
 =?utf-8?B?U00wTTk3SUhvSTREZm5oU3ZteHpQMlg0ckREVG1YNUswV0RmaDAwOVB6emd1?=
 =?utf-8?B?YmRHaEMvaGZZdWg2Ly9iWkxDQkpkMVJOVWhoY0xQR01CY2Fmc0NYZlE3SHFv?=
 =?utf-8?B?V2Y5aHI5Ti9MM05WaFBvTExIS2dYT2NJRDRpZ3J4NHQ5dU54K283TEZGQnRw?=
 =?utf-8?B?QTh4YUQ5SStsem5EWjVhM0JsdllOUkhrY1l4NEhVWWhVVkRtMVJyU29VWlc4?=
 =?utf-8?B?Wmp6M1cxUkQ2MWp5Y21VNU5MdExzYUZWQXg1V3FKOEM5MlpmWWU2TVpoZmV0?=
 =?utf-8?B?K1RLbzkyODFQQy95aktDc2hpVm5QQTBvcWVuZjBEVXpGcTFlMEp2S0NWREVW?=
 =?utf-8?B?UWgxRUpaVGVRSk5EdlRlY1RDTUV3dHF0K0JuNHJUUGV6aFBYakl0QzdDLzFo?=
 =?utf-8?B?K0RrYUV4TXFOWEI0R1Mzc2QwMzF2OVh4Ymdyc0ZzN1NSRitKZ1A2Yy8rd1k0?=
 =?utf-8?B?dUpmM29idFEzR2JUb09pNE02WGFZZ3pCdkkyeUs3eXh4VDQza0FtczJGdk5N?=
 =?utf-8?B?MkdONllEV2lxZjh6dytIVDVIemVvYW9WM3ZQRzltOHBMY1NnUmpibWlKaGsr?=
 =?utf-8?B?Rm05YWMvSzVIaFVoOFBHdE83NTZqWjI5ZTZISWp1YjN2N0d5TmRPREZsZGQ2?=
 =?utf-8?B?UDBJQ0sySFEyb1dKNVh3QUNoRERTR0hmL2phdlVOaHQ2S2lYQ3dIQmFld1hT?=
 =?utf-8?B?bkp0ZGlkRFBweXJuOXBzbkhzbmNzdVl0d09pcnkzTElXRXNsSnV0Q05lemRX?=
 =?utf-8?B?Y0ZWODd0bVNQV3BLUUtzSEhTYW5oOVM5YnlDZDgyZU1mTXQ4SXBiZ3o5WU41?=
 =?utf-8?B?VTdIdWFKQjROcTJEYkM3VmlrRnBwemhPN3I5d3pVZDJGaWlXZlptdWZLK0dU?=
 =?utf-8?B?MlJNMmtmcmhnRGhDUXJHNGs5VGs3eFBqTGRldUtSTURESURmMkN4Y1RqcHph?=
 =?utf-8?B?NHkycDduOVg1TUxSRjRGR1J3Vm5aeFVFMG13M0lQVy9qYUpzczNZS0daM2kw?=
 =?utf-8?B?VGNYVzE2VkNpWm5Tdng0QVc2cisxT2pYc1NXMlNiMHFVdmpIZFFSTUsxSVVi?=
 =?utf-8?B?Z21GMHlWWUIxd0ZXdGU4ekpwdCtxR0F6OGhsNzV3TWtrMUNhQ1dNM1JBcTBw?=
 =?utf-8?B?WS83OGlOUUFtYzJRRVI3WjNSUFV1dXVWWCtXVnhweGZPd0Z6SHNMcmJkYm1s?=
 =?utf-8?B?MExCaWdLeEthYWp5QnhBTlRmWDFrMmRPRkU0dGpTM1ozaENyQmRoaUVrTFpk?=
 =?utf-8?Q?qyDVfhReMhE/1Lk5k65A+e4quqPVMwJVoEOs/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fdfaf6-1771-4477-5327-08deeedacde3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 08:07:45.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WHDrmzEZdaaVdmN/xSHRGsKzod24z82Lnjhqwjdpbju7PBAh6o+FGi2VhPpxj1ehY4pDpGv/XMN6Gwof6ko5CSMxCzqn3+/LvctBk7pCJOUcoEDzyFQciVjKIjQTbDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657

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
Changes in v8:
 - no changes
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

