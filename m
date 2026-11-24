Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490899;
	b=t/HGWR4+zkvkvmVlJQElW+8RA0Zw83Xj0HfnRy2mu4xdBvumQv3yHdN7o/gsZzm4qLVC
	 Y/54xIWk+fDhGiRy1WzNIkLkkrSb3MpzurggNGl68K5uTUA+PS6l4u/kPyeCqRRfiBYSt
	 HVHSdt/1/fojfrnGSFkTBJtkFxVSKKPo8TFaKAImJ5+hmmAoIWI7LbhXwWuzpyM2sCIHR
	 U/GW1Sz+ty1Jei/LZSnvRNDnouzlKhI+VfuPsusavDrOBMl5zuJ7QrEgroe9AZIA3sZh9
	 rYTeVR0Gf1SHESOg4gb70tDoXAmS/+SxtiAX7j2qVLuCmf88eRkTU69QNSvIh0W2I9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490899;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=hKYx5d0XorS3vbtbqf8M/0ktdLEpll7/AxGdZCUFBYY=;
	b=S45Qj2aDMu1DhGjoRC2T1UjLypjrgTW9lun73d9ni5qf3MOmEH6DxwJFZVGCVEu/Q9nj
	 gZTMrwReUR4dH3Tj9PfjJdaxj8qu0LhVMhEe1JJVmakeI8Tquye9ipBmyu806cSkFYj64
	 HJKjS3MSsBoc9soliRR8onLk5JKtIqBit5QeypGkkH1p68kaK1WCRiNY2BllWidEjGcvx
	 qFn/NJ3va8ukYiGNTV8mUt0RIoFbnWn9e+TdjZsa1p7wYPfqEEPNDUHmvrAIBbcA1Ta4d
	 k3bBtGmM18MVT0/ZFTvYZnRLNIaHj2G6YNq65eQKwATBLxnUNL1nCPtzeoSxfKBDpZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mqvkChGF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.6
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DE606A321;
	Tue, 24 Nov 2026 03:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743DE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mqvkChGF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCc3OrtEKf3c2omsi7kIYwXoZqVcPrxm9KcAtZdwjWdBlR00j/ImaLRDM0GL+Llln5YfY0JMUrCvAf5pyApN7+2XaFARwlsjIleVuQTrQIRPAaXUNAMjW9/WEPeInTB9H/v1kLJiz5hVyLHDzDyF6X178QFJ0wnpiVqCKSi7pfSeo5QAa98Z+bf3uMZ03oadqCmNEoYjq1Ltr5xWWx3urol5ZVteFn3S7nzFW6msKJfTZfdopmFbO2ub15J+2NFskffE3MFxDWX6mwAMBOzuNz6IEU25rfOzDviN29YDz0VIsZswsRba5C4kJxKIjQCV4IOwyc8WHCfCtIXOMdBUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKYx5d0XorS3vbtbqf8M/0ktdLEpll7/AxGdZCUFBYY=;
 b=wdLQEYkxGe7wALx+dKOB8HIQKaogwgwcyVjD658mC+cwT+qLhlB22Gq6LOBe4TaH4xfaPvImD1RC212nkxKT91WgpJouPbLqoJVO2pgtXk7/grPPKCCprCdwDtnHdN8tmcZz6uX9hEdLPjp6spQZouGHDuNGUQuaVmYMOI0KnHz7T5kOGDCJL3slTdKA8GPNwkNyK1tsR/OQ8u6c5p27+Bi7wQa/cuuVi454KMFBT/2bBQQRfLm96QMrLhAXdosUIlEUSYbVgOjo2cR826A4H41QBuvDTm7iPJyr3o6QsxNWTikuAaCA2JGBC75j4Eim/iAmEBUJ9FWiWxV6TvB19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKYx5d0XorS3vbtbqf8M/0ktdLEpll7/AxGdZCUFBYY=;
 b=mqvkChGFHCXU9eMGzoqUBsyq3THgioAPwLC/IwrHruukOwExvCSFTrRbGHBckti4SF7SajhJme1qXsjr3B5eEYBwYqhWGzZ71eK004p1h/5r0HGMzqLwz47cCzD2emYML/w482ICbHudV2+HABL9+oIy5l+oJvCka+t8kNxfxCtGN5Nm5AVFPSV6+4ll5K/6xoED99+Ra1EbRMCu6Q1gns7fHGZs73tssW8VwC4VivBqaykgdp9tzOWopVkH9BY6LoQRCB3NWHWkKZ6v2dkbgpI7gexF7SEiSeTSVjNu0ywBdWOgSH1Po2x7y6xQ+A4KzCjCyvOgz6ySOLe6G0/AIg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 03:28:15 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 03:28:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 06/10] remoteproc: imx_rproc: Register SCU cleanup after resource acquisition
Date: Tue, 24 Nov 2026 11:25:17 +0800
Message-ID: <20261124032519.5338-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261123172140.3547896-7-lee@kernel.org>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI6PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:285::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 64caace4-18aa-4236-103d-08df49daf9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|7416014|366016|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|10067099003|5023799004|11063799006|56012099006|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hOJ4Q9gGo95v4iKhBn2vnRnSWs8f39YIsq4rFJhqe/OYRFQa+mO1do6yvRns0Y7Rt7GPGCU8qJbBX8yH/cxaT9EFl4x/U0VbKFbleyjWjMZWOo/fmBw49ntbU4Zw3R50/GE1h5dFy3BfKWf5Ochj/Xa87R8Fp0qiLAN3qMt33nGuHErGNbK5CnEAySns5fOSK8nIFls+6bFelNQgjB+YeL03eUUCiEc58U05eplw0OLTaTX9kMW28L5QELBdKPgctSY7KBhfGVsmu27274g5LDcYGOPJY1Qva4rFNL4Wbs0fRWzxBG/oeH6DAADC4HdwDQXsJCq2vxU7nH18QlOqQwiOPbvoP+2v1ikXaIjHKN6YAeiw++RrlmNuAbixlNGFM/ska/niLdp1dTcKo/TpG06ZkqSJkwNbaAc1seNNCEo0u7DmZcZt5ry/SCLfIzsU6MZYkhCrqCsXUQk57pBaKB7h6gBeeMAzBCOnom7JKgzmQLEAzQCC3cSHIIf0zwzXwulSnChdNTlZSiSANogAdvYtHqcVCd/bYh+UgPGsY7yHvD5j/BwQ+szOKI6zuI9uuo8Vo6fbPRWasQjisCxa1LmWREnGObXpm+Go+R0SgSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(10067099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d37RgqZtFygds928bn7ORGOYnNDwfNadSfcVq8SS+6xmkxdWHjPQlvCS/tdj?=
 =?us-ascii?Q?8WgBxUrLnhLCRk50d8nu5OQsr53GI5qHawiRnyHOGIO48iq4zSi5lZakFBdx?=
 =?us-ascii?Q?DpGzrQzhlgEFt0jKHpQBdF/3oBfjoXS9q3pCmNFEGMCk5xhzXdIejV3mxEB1?=
 =?us-ascii?Q?JQiYHJlzFR+2INsiy5C9GO50V6EMDwfCi98mHeHoJzwSDY9YuSiX+1lhbuzK?=
 =?us-ascii?Q?M+nxnztgv+ZYHH6g3h43aU5dGopIzTD94NZ85AKPWH5xdeny9AF8fSccIaRX?=
 =?us-ascii?Q?4yVlXnSY2AofSNLdsfvw998ZYhUvr2TUV2x9JTZXXBjqi+MAJnrk/A2YNdJQ?=
 =?us-ascii?Q?qMG1NV573YAfnofIjaFYSYGKvFnl7LbV1B0KbHP6+Ia0NZLZ6trSs4DHjhYQ?=
 =?us-ascii?Q?W3rI6tUP359mYzIW1ofCjmGJmX+tOyOrBEqOydMpCKh7sTlyK4tcp9N3FEl2?=
 =?us-ascii?Q?2BPBh9YKAMr4BJU5y6nAkgPc0OIzqsibIYeVjplr2J7IOQWYwPuyJPzPOnqd?=
 =?us-ascii?Q?01b1H2kzX1JMxYKLWSJBnyd0DPLt+WgfV8U1wmt2hQvSHtqXwIXr6JoLXpAq?=
 =?us-ascii?Q?lRsYhYg6ElTG63VqWwZUZwqSr9kEPxyG903WDMMHOAOFJuSIFfuajVEOcGK2?=
 =?us-ascii?Q?tBk9fc7/wA1PqigJUndlYrWJc2DU872YN3eEDRb7jQuEZlfvIgJmyMSR/38W?=
 =?us-ascii?Q?hWmmP+2qe4gursGn35X6xH6JwtO5T6bais9S8swW+HTBTIf2vk3EGV4iQCkI?=
 =?us-ascii?Q?Tb/88CbFMtlntEy+k8AcQgUK0chhAZCv7k81BKTDt7hUxjCaJUkpEfpszKp6?=
 =?us-ascii?Q?t3uMJqJT0glzBvpQVd0P6HfvfH8WML17Jyc2kI52ViyZEIPn8DiRd4Y6SgIc?=
 =?us-ascii?Q?GKOFyzwWxoFQvwnBCf6fYle+zY86j69oR1KsYHRfrl+r/7MzCRXNUNFtxbR2?=
 =?us-ascii?Q?mGdCB+wyd+jV2aeyyXDQTfbPL1t1Wqy7hyRahRTpfzEXmUDIc67a5pjAsHmF?=
 =?us-ascii?Q?U7HTn/HWKe3gpb4Yy1g5H/Xd3xp1WS6O+DE5wJEvRbz2uvuHtGM3kM6LV8n4?=
 =?us-ascii?Q?T6Q53V1jRuTKVlreVj4s5KFuZrg5yVzAIWMsYch4F3og3uU3Lvv8hMSR9xps?=
 =?us-ascii?Q?dBY4RRGZSSAo1VvkoHY32f4oewZ26hPYnsGQ9T2j+CJcQL5MxVTGuixvGp6J?=
 =?us-ascii?Q?V0qAy0L/PKU5M/2qpmXWa4AQ3EmjvsFMmDA9jU1CBgcJMF67KwgSEakY1w1S?=
 =?us-ascii?Q?P4kXoF//Tqcn3LzbTBl3HIPp1ZkvKQSH+PQhj6YnzlxDmZcCYSQqx5wVJvFV?=
 =?us-ascii?Q?MVQXEdBxBDH7gghJNqH5iIW+vGLDEE9KzNyw2osrYfrmRto/eUVDZoG98o5Q?=
 =?us-ascii?Q?/nivIl/hC9jbU7XUMfNpn+pw0moTRDYwnY67qumIPXosDEycmihM/tquKTwF?=
 =?us-ascii?Q?LbRarZdf7bqVpd0RNXFH88of/8l2Ju7UcKkMfV4GzXdm108t91g1BLLC0+bT?=
 =?us-ascii?Q?sh9U079ZabebtAAtb09WaPGXWiQpndQ6X0j5JoZYINGtzcF0z6m6mc2lk8D9?=
 =?us-ascii?Q?wqUbVjlmWtDQ7SyUrAdmV9OjuyojiDA/QCy/2rxT3rkc5LwZhFlFCi4HZFsG?=
 =?us-ascii?Q?L8Q+yA+DGHQRzPuD5Dz42bWjrL1cL47dBVXEj4KHLOOQCtG5gFmjSs9hsgsb?=
 =?us-ascii?Q?YiQRNQlrzcaPn2a/jBw2YY5jY2s9jp8XAUFwpaQUFr+sz60mZbV6N9pKHf++?=
 =?us-ascii?Q?3avpR8zjsKeIUjFpGGH1aTAfp6/by5xdeA3fNtoMU5P7joGBDVpy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64caace4-18aa-4236-103d-08df49daf9c9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 03:28:15.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94/6QseO4hut6OR8j23z+XSjJpX++Y/LMC5am5WrSap5cGiYWAg0teVPcpXk2em/O+873OWxMEUZy9I+M/LP9mxbccAZ/0VKJgDJ/ornsEcbCrzMDcFBrEXdImDth8xM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

On Mon, 23 Nov 2026 17:20:50 +0000 Lee Jones <lee@kernel.org> wrote:

> imx_rproc_scu_api_detect_mode() registers the imx_rproc_put_scu()
> devres cleanup action before attaching power domains or registering the
> SCU partition reboot notifier and enabling its interrupt group.  If
> imx_sc_rm_get_resource_owner() or imx_scu_irq_register_notifier() fails,
> imx_rproc_put_scu() runs during failure unwind and unregisters an
> unregistered notifier block while disabling an unconfigured interrupt
> bit.  Worse, if imx_scu_irq_group_enable() fails, the error path
> explicitly unregisters priv->rproc_nb and devres subsequently invokes
> imx_rproc_put_scu() to unregister the same notifier block a second time.
> 
> Defer devm_add_action_or_reset() until power-domain attachment or SCU
> notifier and interrupt setup have completed.
> 
> Fixes: 9b2451658afa ("remoteproc: imx_rproc: Use devm_add_action_or_reset() for scu cleanup")
> Closes: https://sashiko.dev/#/bug/linux-1230a154-7627-4ce2-96f3-d0033709ba4e
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
