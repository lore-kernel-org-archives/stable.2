Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793320E023;
	Mon, 27 Jul 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161909; cv=fail; b=nOYKlXSvZsunczyIBTBvUEpdRQlAaGoUF+mXH1tyFJo/sBvMfGJBEXLqMFnj9K/RvN0aoOqwrb+jjarWjo6cYGPDNGLBOkM4aojmtj1WqFq+B5TF26ePMI3HEyE9AnOHphIXemw1f0tNdmewY+8kwmSHl/LvSsGPvBs7J9TGDxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161909; c=relaxed/simple;
	bh=ITrRmcMCXHgBD+3JvsKfA7m3hp6foVUnomlxdYBnkfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qj5wIcPwB2qXjzQbenmJMEiQDF7yBzXDweipKh3l6hUUpQdp1na9jRz8dxRXCc6OhFpaxHFe/7Q7Y1tf7Qy4YKKqQ9nWUGaiUsf/TbIBCxsdzpg3hhTgrZ0NwpvMZvX157Lg7KlDKOrDO1DKiLVaELZrfNwnQtrtY7IkmURnLuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EDbOiPgY; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EDbOiPgY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG2hdyCNe0MPSEJyo+deZVhvtBiaoZGypJkCjY4Npkt81YXptxJU8MRGBwoo1AG5tIarq5qoIY/9zm45WItf5DPy7xdp/USOtNmdsvmfvp8u9BlWizsMLXYroUm2FSpO6JOD9CVek72ObFUxke8BtCO6grrvW5VIjjUKvfV6s+AnOO4Ajga1e3q/p00a2z2MoQnxZR3oXLuvqHY/xyCpnnLBhGMWmHO/a2G7BWhZwzl/zgKrOn7moP/BQtvwW8coupteSBuwLAr3iDj2CA/chbfm2/2IAhdt7IsrICgnCIv8SZ5bhjUXDPzPgPii3hgrijnjtLJurGKxPVSmLyWrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlo/3RMtHIx0EuM3yc7cjImJceaVcNVP33Nl7NZ+oEg=;
 b=BetJh9sSuFF1Ep1gFTan9jTzjDYyDdM5qfReDtlDxBgcmbZC3RGmk12dK79bNfKNJw2T2B0g2FHdE75Yl3hjoBghV/mYag+Cmx3wBJQZ8UKEuW6YCSKx0LpfKknXX8OYSB888YcuzzINkC/nRTpCU1VH/PL7OcMvST5PIfoZVbaVvsJDeDX0P1Tv5e9HtLzed1iRwfHu2XaSobSQikXekYbRUegePaunNdHCjMyKrBrn5PTjX+Om3j81/PbXW1nrsUVQ68gK0l75revakZ0ZxKRCK+9lSKMLZicbxIRglAR8mMqcFbNRegWhSHve10Z+VT8ygREs+tgGcMxWh2qcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlo/3RMtHIx0EuM3yc7cjImJceaVcNVP33Nl7NZ+oEg=;
 b=EDbOiPgYH4wCMhcWTe0B26NuEybJyf1wS9lS1uB4TnbbzPy7U82FOF7/3YugSTjzsEjgBO/c9SpzHU/1/mxjSHOBKnJQTz1G5MUee3rGSY2ujmcTZFuvfwa2uKjQGYfhoe9Q1lWfcsTFAEBw6Orv8RiywNaWvtmQzv98qhTx0iCAL43hao1S/uW4LY7aOipSI9jExayfTW2/0FLrsRwwx3Wb4mKW1Wjt/4dMfkJDTwqJ+BTy8hH6RgGYQsaXxaCMCbMENkhzy/m1TyRUAJTUXcjc4bpwqliOh8b83Vwb+FWk8IF/wkTZVe9QK03KV3kncZsOWoxeqYZbESlx9ikDPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8365.eurprd04.prod.outlook.com (2603:10a6:102:1cf::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:18:23 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:18:23 +0000
From: Frank.Li@oss.nxp.com
To: mirela.rabulea@nxp.com,
	mchehab@kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Cc: Frank Li <Frank.Li@nxp.com>,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: imx-jpeg: cancel timeout worker when streaming stops
Date: Mon, 27 Jul 2026 10:18:15 -0400
Message-ID: <178516181337.2418749.12752720504801599437.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623103031.3051-1-fanwu01@zju.edu.cn>
References: <20260623103031.3051-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1ebc50-de06-4199-fd83-08deebe9eab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QUTzsWpHdm9DQpN12yesX5zKD5Gq2BfFzgyVQ6fN4MjcROl9PoCiklwKQQH6Eeuo7+G/VsVpsnqGWcF83IjBLbkVznD/9GSaGo/GkypaC0+8BCUs1wPtJIZEQ7BgtiB9RNUvtz4gZaRk1noX2D/2B4F0lokNs5q5eU1ApxqsxnnC40BpDfIR4NvChCQ3hGxw1dheSwUN+OiVDtASCQbrZ4SsymhbRmIXwaz2tcmpfRnqjUuukWtKfbdXqjiJp3hIuOQ7yLd8KZNt8bS1S3SB7MDv4rI3YMI8fKo+TxxRoMhdfP6RPLHB1Yr3dWwIof8drcECapU2R5kvrVWS3NW7N5+rcCprHjyzJXuusewk/t+hOX8PYgQI9m1ZrikPBNbu+1hLXj1RSe4Lcv98Mne1ZAK1y8H+GxxCQjm4k8bHXkTSmr6REicUzNH7n3fFRqNecBPs1ohfXsVTFR22Zz0/m8RzeYbEzsMOiJDcXB2/W1U8aWYJCneQueCERYMe/OFwlPnklfLyFg6Y7xJycDGRjJXqDLEEQPDbAxaUWnfvTlX7mlyE2pf1LM1d2uUVJk8/oXP/nGnW9vxMmXjcao2N5awWECp7u5ttOry5kkiNY3rRNB8capioQODDyE6Ruk7M2VcNln94lfJY4QM5LT2dOp48aVTfWm5WumX1qQmU6+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW94RXltaUR6VjFUT1VZc013UUVUNm81eUxua1E0RjdUc3JQMFdCNGttSlR6?=
 =?utf-8?B?OVlwaThVT1luZjZPdDhiUlhEMWZUbXVVYVhHZEsvNjhtUXBLK3h6UXJoZnFR?=
 =?utf-8?B?RTFHd3JOL09oTzhrQTNtWUtoUmplQUE5SkJkR1c0R0xGeTRHM1JqTHNNMVRJ?=
 =?utf-8?B?cFBBZ2lhZWJ6TThkUlczM2xGY1JVNGVaR0pZYkhocWZJS3l0TzdNYzNsVnl3?=
 =?utf-8?B?amtwYzlqUTRYbklwRFROdllwSlFDTnFRTXZDaGJWVzF4dThhMW9UZW5jK0p6?=
 =?utf-8?B?ampYempHbU5YOU1GREN1OVhWNGE4ampKeDdoT0lueGJ0SEJTemN5bTNjQ1lN?=
 =?utf-8?B?ZDBxc3d4TENHQkhTMXZEanphekcvVmlCTmU3TVF1ZkpvTnFCLzkwdWFtQjZE?=
 =?utf-8?B?dVh1d0pDOE5pUGJIdFo1Rm9hMFhjeXFvUk1pd2pXQ0gxMjNNMkFldUFFV004?=
 =?utf-8?B?WkcrMHIyQ2NQWnZjQXVQZFdKcUdkZVdwb212c1BIOFpOQXE0YjV3RSsvZkkr?=
 =?utf-8?B?ZGt5ZWo4RWZXQllwVTdCT1BUYVBKT0RpcmQ4bzU1QXo2ODduV3VTc3hUNGdt?=
 =?utf-8?B?UEMvYmNsWEpGZGw3OXpDVVFGTXNsTDQ1SDBDT2dyaDFES0lVZlFWVk00TGdw?=
 =?utf-8?B?UHpnMTJHYXViMGlUTXc0NUJPRjIyNGg1S2FMMXpFRklvZWY5M0MwdXdDMkU2?=
 =?utf-8?B?UGUwNzlVOE40SFpNNjdSRlZBWmlodVdwQU5rcGU4NUU3MTQwZDh1M2EzRHFB?=
 =?utf-8?B?eUtkdzZwaEdNYWo2VHBQRlkwcCthTXh3QW1uODZ6NTg0RGpSUlNIZmZ0S0M1?=
 =?utf-8?B?NGdqSWRUNWttVld5UmFLdW5hTjN1MVUzb25OVmd1bkRlQ0tueXByUkZhckRZ?=
 =?utf-8?B?aXEycUJYSWhydmwvM1dPcUdqRWU1S2s4MEphdy95SENUdW5SbXl6aUNmMmZ0?=
 =?utf-8?B?QVkza29CdE9acHdBSjc3Tmk5Rk5zRGNPL3pvTWFvcjJsZHdMOXRMYklTLytt?=
 =?utf-8?B?STdoL1lWMGNZWTZOYUM5UFNtODFQQnN1a2tNcmdrQ2RvOERNYnlwcU1TVG9s?=
 =?utf-8?B?cktsUWxySUtIY1N0WEplRFlUa3RmT1ZrZ2tvTUx6ZnhqVnZsOHh5NXFJOFVG?=
 =?utf-8?B?MlpBRHhSd3FjaTJrbjZSZ1ZycmlwWG8xTVpIUEFUdEpCNHhZeUgxZThkM012?=
 =?utf-8?B?ZzdmUUw2Y1ZTZkh4bHhlbWhPL1QzbFl4K1hncjJ3UE4zaXdlS1p2S1RGZFkx?=
 =?utf-8?B?SGNkZk9CYXc0SFRGcWgxdG15b0tpUFZpK0JEaVpIQ0lOSHR2QVJpaDBEaEFS?=
 =?utf-8?B?dWN6dmVVT3Uwc3ZFbEpKTUYrbzVGS21ENUxHSjc3bWJDYTBCQUJETHNoYnRM?=
 =?utf-8?B?Unk4djdkMituMmpFKzlsTFNqckZ5bkgrSUQ3YWJLK3doZ21LZWUzNjkrV2Ji?=
 =?utf-8?B?NmFmY2VrVERyeGFBMnY1blpXMzB2b1d4b3EzRUlHak9mV2w5YzhjU2YyMW5l?=
 =?utf-8?B?YjF5bTYzNm82ZVZFdUgrTGREL2dPVy9zSzFzTjhlOGRjbFBEblBFcUd5TDlv?=
 =?utf-8?B?aUprRzdkOVlYWFlZTWZBVFVQM0hXRHVWT2pub2lXQTNxUmMrRm1XNkFhblNu?=
 =?utf-8?B?dUxDRXQvTjUrb1ZyYU1IN05jbWJGRlhaeCs0Ym1Kb1dpdU1GaGUyTGRuWDRk?=
 =?utf-8?B?VTVFQ0QxM3pnb2RDSHN0NmNDV3VuTjFQUnF1V0FrdXYvK2dxbE1LcGhiN1k3?=
 =?utf-8?B?V1o2Tm9ESHRSOTdiYWY3TFEzZG1ZVUxpY2FWRTFQRTdlaVZTNDBYamQvcWhQ?=
 =?utf-8?B?Wk8zbzBmakVCVVVqS09ROHFYRW5TdGpEK1lPOUh6SzZmVVdRTTQ0WDBPdEMv?=
 =?utf-8?B?K3dqQTdReGcxMm11N250L1Z0MjgrNWdBdWl0UHRWYW95NExOVE1GUUhBYkR1?=
 =?utf-8?B?aG1RM0h2aEtRYlJZTTFzLzJxYWJNL3hCLzdockQ0MGI0NkEzd3BKRWdiS3ZS?=
 =?utf-8?B?OWgrbnN0NnFmekJ4Y0xndU1jbEl0aVZoOCt1TzExYWZ6OEozcG9vdnhKT21j?=
 =?utf-8?B?VkdFZEdvQTR1OVo2WDloQTMwNUFvSlZYc0ZGVTF2b1dDT2xyS0FJVnhMbkNv?=
 =?utf-8?B?NElvMkhyWlhUVkM4SjJ5QTZMYkZpOWd5VUhTbXo0ek5YODY3Zit1cDZYMGZL?=
 =?utf-8?B?TFZidWxpakRqeGRqMlR6ZTNBVVczVTVENDBFbmRiT3lHaEhlZlFCMFQzUXhG?=
 =?utf-8?B?elR3OExFZjdWdU0rNVc1cjliRzlNZ3FteW1uNlM1b1hPeVo3WGs2K2gzUXRt?=
 =?utf-8?B?cGdsTmYrTkxuSVo0dzg1ZHFVZDhKZE02a1B5aWRDNGsxSi8rZUFBRFUwcEh0?=
 =?utf-8?Q?qm31BLLt5N2vqoQeJUDQeeJ8r2RbG6XQ2k/Un?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1ebc50-de06-4199-fd83-08deebe9eab2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:18:23.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w++jZaa5L/UsMIboZ7HXlXNt7FwyqjN+sNDYWbqpN+GH8MzdhSuxzg76dlRDBRc0wiJv5BQv41Ag1tqSIwVrBXd2C+vGvs15yU6iotSZvlgAQrkV3wSGXphAM9N+3Mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8365

From: Frank Li <Frank.Li@nxp.com>


On Tue, 23 Jun 2026 10:30:31 +0000, Fan Wu wrote:
> Each per-fd context ctx owns a delayed_work (ctx->task_timer, callback
> mxc_jpeg_device_run_timeout) armed via schedule_delayed_work() at the end
> of mxc_jpeg_device_run() to recover a stalled encode/decode job. The only
> existing cancellation is cancel_delayed_work() in the frame-done IRQ
> handler, which de-queues a pending work item but does not wait for a
> callback that has already started, and it only runs when a frame completes.
> 
> [...]

Applied, thanks!

[1/1] media: imx-jpeg: cancel timeout worker when streaming stops
      commit: 670a7fd24621dc74b8032507d958ffa5eb2d58d2

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
