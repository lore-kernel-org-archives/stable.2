Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D63BFE34;
	Wed, 29 Jul 2026 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310870; cv=fail; b=ARTkTcv+gmh5eLuirHWNq0b/r3twDslb67FGmQZknj65BI/qUsLD0+JW+EpoVUdm0o+RFg4wvT5g6/cm/Pu+eD+trBOz/XstPo0vViif1JteBcQFR4bxY55ammkTbIdpfatLEG3kToBjMmqWrlLoRxNnHZYXvHNGHNgnuWO8odo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310870; c=relaxed/simple;
	bh=qw2NvsKNxyXJRym8nA+RXO0PVOODZN7r/OZs5GbfuXc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JBhofFSRFsn0Db3EVf+8Un9rNe0SWvfARCb4S8WQnx7vPud2HkNaVdePxtnDeSXY1R9Ds0+wuj+K5udsqDl+10RmfyjnmP+RflPsYIbJi357Jup+mz1zkeeV+sGXwdvDT3ZeHzYd0xgOwHxJn9KCRadStQHKio6aQfQD8FUWZIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s2eyFT4K; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s2eyFT4K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DouB5t+DORyi1yWvhfUA9gwvenCywrLE6yl0XHVrIYLwNreyzprMgZ1zm0GOezheYUQAoDIXLLjlMQ9ackpfOpTVDWrc72NxkfH+KYvAloXlokUE30r9z9Z7H1zjQrQP6oCzdmpJKgT8mDxIrqcdv5K3aj05ILKfajt1Oa73HmpZggH64Yd+Q4UP+RMfqwbdfIhlT+ox+nPD9sejk+XQfJiKVhBE9YmiipJXVMHKlipuLWjPFoa8ej8xxPbJ0SVOBIwYNXQuSjrC7oO172UofV4GYOY/LETCFu/FXcwzdoRYvyYqpmdtr7kmpaQewlj3/XZpM67WOBC0kwYWe4D4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQoGc5nG1Sqwpt+eQVhGy+swRt1qKDt2laPnAmInt9g=;
 b=nI1XG7kjOoKx9CpF7e9XLnz1K94L+h4gUp1RztgXsYLD2UZBwRMwivGb9Gk+Xp9SdJwsB0OTRF/a37J9uIYGS/kIqbTmBeSB+hb3qn1cGGdcY20VHN7EIv+a1JdtZLpV0BEwOL6RmFUyVzVIRFuJ86HXBKaAfmEiJNWXgiObFaQ2xPwfITKmiHFFmqdlLKKBcWYIwwzCg6NGeFw4nTKrtP8L942Pvsr9JqrpOEKCf8yRHjMTWVNlCbbG1KUUFGsau/uCXTJVvJr/h1WOfOSjCTy39el1h+iF7v9Qe5rqUJv6RDX3luErwwazQTBin5mkwd9GAuAbAbrMu14w0/KSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQoGc5nG1Sqwpt+eQVhGy+swRt1qKDt2laPnAmInt9g=;
 b=s2eyFT4KpFuZko+vhfwuHwlvzS1haQc3hfzla3omLJt47KCGBV/y3uueY65zCZ/9ubWZzcqKpz6jyJRr8qYIaNWs7UZSY2J0afujLblGX86/E9Bb6Zt5GdzbByGRd8GSqVIMNQUEXnx0HSeJqB1IpjuQdhZ48/nFTUQPUhW+FZWE11g8AgvXwjhNV99hN5cXyOG8fYUToVw5v/Sp1NgAHDSI96ugHTjEnvMN+tPoLloNuttZjY76xtDRW3LN1KLgiVOX8MgBIqXXMlao14gh5nfgvHuK0RxlxHNf2lJumUwGkYnDU4pzX9qIGh3Y+DIYXVjH7+Qv0yoD6aBOxjixDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PA4PR04MB7903.eurprd04.prod.outlook.com
 (2603:10a6:102:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:40:31 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:40:31 +0000
From: haibo.chen@oss.nxp.com
Date: Wed, 29 Jul 2026 15:43:30 +0800
Subject: [PATCH v2 4/4] leds: pca9532: fix use-after-free on unbind with
 N2100 beeper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-led-fix-v2-4-09ad218457bd@nxp.com>
References: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
In-Reply-To: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
To: Riku Voipio <riku.voipio@iki.fi>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785311027; l=1765;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=9ooUq+43tSddJGRjIZULeusY2E19RngtcKJuLwRH/Sg=;
 b=kmYeArHMAn9tm7POoflEM6mb2+Nr+eNnpWd5YiPKeJECOTbeFmU9JNOJU5MYCTsrcklgQRS+6
 bVaBIspIxgMBxVHtqs1s8O++qqIrYzoBqgG20KNReLprFL9HDcoQInh
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::11) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PA4PR04MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1c9f3a-50e4-4c33-1b91-08deed44aaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eqYLNMGZj8W6QJwZUmcw4r2pab6tTD0TQf5iiNtLaLyse2nCZGJxRx89by9LzdJUNo0EcCRsjaecOoqX9gn1yYsghy0s3LqB6XzdJKLXoDKmw1Uoh+4aMMPwBtu/DLoZcklzMgTQuI2IKIdXLuOh2LI9VFiE0VxBDGvxZe/5YJarHG3k5ZJ7x0fhmpJU5JnIfwJ/bvMyZkxRbPgheZkHoeGsbjustt0PAIq3qAA6bc3e0ZKJzyVaycRNry0+5dQ2k596NSNVroiX9LAB927iSJ6ynTnRyOKCkP5PuJhyxS23oCtW5mvzHl9NKECVrpBEhMyzl3cCHN1Kan+cINEDyx4QCYZNDB7YHPB4WDNBeXPjKYFEHbx+B9wftn/BixVR3N9eAYgto1S7eUT2LJnxHGYrxgJmIc2KBG0tm+wtgYGJChO0qKc9fNOIqG2MICJ6BFKdoUzehLZCTTFMcBocG8QskRqODENkT5Sn29ZK/rxsQWElm4udPczf3vkPe1V5JJwvZD1Rzd1fpwi5bC8cEUPf6/pM++Z58HX9zShpVOXnp7BMgf0Six1wTUE5Xa2wvQHHTqo0tyyM2AadQGNxKrLHk3bVAJ7dQ0CF0dPb1LGo5wdBHxzsa4hicQKZme3WpRGIm9Xvkaz8TqxU7+PGywolWZWZOT5MYhhzixfmMfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUg1UGc2K2RsdGxCbHZxN0VHNXpWRE5lQXR6U1VDZTRldkJkSis2SmR3ZGhW?=
 =?utf-8?B?L2V1MG9CSXFmTVFnUFphRUhVM08yQk4xNFdTV3VOa0VFNjdjRW4xS0ExTHd4?=
 =?utf-8?B?cVJZaDFyTERPZVVKVkFRa01jK3pQUktUaHJ6WkJTcFdTSW9SZ0hnT01EYVVP?=
 =?utf-8?B?Y0dvc01HbEZtNkxvZHN1OG1FWHkyVnVVeEtUV1NDVWJlL0hERTNvWHdDU1dO?=
 =?utf-8?B?cnpLUC9tbHdoeUF1QXlRN21ic29pV0h2WUZrOStUNG0vWEFxWlBSdWE3TFVy?=
 =?utf-8?B?dG9teW9kcnJKZ09hbm8rR3B3dGVCdlovbkZKS2JFK3dOdEVIVlJiVUROZStB?=
 =?utf-8?B?RFcwQkR3dkVkOW9MUG9veWk0RWgrYVZVZUJhV1lVNSsrTlI5NHpISWh3SlM5?=
 =?utf-8?B?YUZaMFlkRWY4eVc4em1DTkQ5UjJsQlVXeWtCL3NpNzlxY2tqN2NQVFc2TVpD?=
 =?utf-8?B?Z202NFVKSldkWGdDZks5ckkxNmJXSi9XVXo5S29OcStaL045bStQeEJNU1Iv?=
 =?utf-8?B?UHIxYkFzWStqYW4veGJQK2E3bFF0bjlLUkpONkpRamV3ajVsOENNdWhrWGVz?=
 =?utf-8?B?VjhvU05MNGJaazFFV0ZzZHZmUTVMRlBKenNuUDZ5bVlGUHd2ZzBFb1NmYmNl?=
 =?utf-8?B?ZktQd2pYTnhRZWtkZTQ4bEF6YzlYaVcxMGlrK2N2U0I2VFhGbjdhYjZSMkxB?=
 =?utf-8?B?N1lpTms5ZVFLb3gveFRCRVF0WmR6ckQzUUVuT2tMaHhkN2gyL25uWUNza2VU?=
 =?utf-8?B?c3FZTXVUWFpYMlJxS0xHNUNNc1dVUXdINi9iMjFYUGxuTWRudmhzb3dtNjRt?=
 =?utf-8?B?TWZpZ0xDTEZvRzdsTVpNeiticy9rUHA5U05FbXRWcWxpRWlXdVVIMlE2aW9h?=
 =?utf-8?B?VjJQVTBiS2dPWXdOLzBKRjhjSTMzejZzT2ExMDZKME5vMXFiTkVGeWI3UWhw?=
 =?utf-8?B?RFJQWDdudWdBbmxycUJNbGp0QTQ0bkRPRC81bTZzM1QvZkdkTDd4cnlkQkhO?=
 =?utf-8?B?TzdDUElldWJhTUhJSWordmZwYzZKVWFqWU9mbitQaGx2OHMvaWJSa09xZi9s?=
 =?utf-8?B?b0QxU1VHWjBhd1YrUkRGdjJpNkRXcXVKNHdXcTFqcHZ5WHoyQUU2TEhJY0FV?=
 =?utf-8?B?K2szelZnYnVIR0NPNEpUMW9nd2YrSXJvaTl1ZTJvOGlacGVBRVlrZW45RTlN?=
 =?utf-8?B?ako1eEpHQXF1T1dIdS9HQkxoMUo0WjdkRHFrOWVhSWdwNy9ZZE84VHoxU3hD?=
 =?utf-8?B?cUpUNWwxZEJobDRFQTEwazJpdm80OWhRUUtMSE9laUdvM2JOTXNldzE0V25W?=
 =?utf-8?B?blE1WGpxQXdQU0ZFV3V3RlROdDV5QS9maGZBZHdydU9UU3VPQnlTQ3lBZTNa?=
 =?utf-8?B?OUdIenh5WFdtUG1NanE4ZlpYN1JvbTBKcnJrODQ4YTBMM1dkaEF1V2JDbzZq?=
 =?utf-8?B?SjkrWXRZODFKZTlmVnM3RTNZNUFXcGRJVDZLYnIvb2JhUnYwNHIvd3ZzVE03?=
 =?utf-8?B?OXFMM1h0TWJaMENSNmVRL0xPTGxHR3BidkE1MUJDL0dPOWxsMnl6bVZ5ZEhQ?=
 =?utf-8?B?UHRLOElUY1llaXYyakNFdFY0MVp2bHhSZzBuS24vZkV6UG9DR3E2RklOd2F2?=
 =?utf-8?B?aTVhSHFmT2NsRFFBMy9VeXZMMC9SNGRZVWZCOFFWZUxLcFlpcC9BNlh1T0VH?=
 =?utf-8?B?NEhJQyt2ZzdORDVWcmFuMjBoWmx6U2VJcmU4YjZnSVlqNVEwb0J3Nm0ybUQr?=
 =?utf-8?B?dk5RQzcxTE5abXpzNW5WV0Q2VzVMNlpZSzB6RTRVTmVtUGI4M01nbEdmV04r?=
 =?utf-8?B?OUtMUGNpRm5nRUcyaHJhWWoxVUd2eDFtOExicWFDK0RZdzB0bUc0YU1mU29K?=
 =?utf-8?B?VitxbVZVdzkyemxaN25lMlZLenlWYjVUSUtYbnR6WitwWElDZ2dVUVdDazlm?=
 =?utf-8?B?c2Nka0RZQVZ4dlNhbDJrVFJ3d0w2RnZJcW9oNEZoMjBNZ2d6UHREcHBmMzZq?=
 =?utf-8?B?clltaXo0Zk1tRG1PeHdTWldzRk1QTklibUJjSGI2VFRtcUxaZGRyYy8rbWl4?=
 =?utf-8?B?OW8rS2JxdGR1T2VBcG1nRDExTWl6WEZhWWJhNkJoU2VYWFp0SEtxZ1dSN1Ez?=
 =?utf-8?B?OWI2ZFNNdGZlRVdabTg4UUdpb00zS3NkRzVkclhWQ0JyTG54a1pOREQvRXZa?=
 =?utf-8?B?N0pPbW1MWlViTndiS1pUYnVvNldGNCtadC9nV3BQdytGd0dhSXhsbzhpTGtF?=
 =?utf-8?B?a2MwRTUzSGFCOEZBS0ZVL0pLYjhUV1FqZU5MaUZhQ2hiU00xVnV1aVpheTMx?=
 =?utf-8?B?K0l3ZkFkUjBOSHFhVzl4Wnk2dXV5WVhjSEQrOXhMUEVDWEV3SHgvTk5iY21s?=
 =?utf-8?Q?Z3OfCXhDRjnHcCnWKVSIVgmslAUItkrur9XkJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1c9f3a-50e4-4c33-1b91-08deed44aaec
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 07:40:31.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MopPIDTt1Sgt4LVa4VK4H8LgtkTxxhvQhCPhgw2Sx9xGq2vYaRYuB9r1nIwxMhXbm6jRhbwgQKHeCzr5vMzOUDvmH4jdLBP5+WvcvZ5aUarDtX1ttcmWCuLABRbhTC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7903

From: Haibo Chen <haibo.chen@nxp.com>

The input device for the N2100 beeper is allocated with
devm_input_allocate_device(), so it stays registered until devres
cleanup runs after .remove() returns. pca9532_destroy_devices() only
calls cancel_work_sync() and clears data->idev, but leaves the input
device registered.

In the window between cancel_work_sync() returning and devres
unregistering the input device, a userspace EV_SND event can reach
pca9532_event(), which calls schedule_work() and re-queues data->work
after it was cancelled. Once devres frees the devm-allocated driver
data, the work callback dereferences freed memory, resulting in a
use-after-free.

Explicitly unregister the input device before cancelling the work so
that no new events can be delivered after the work has been cancelled.

Fixes: 8614fb46637a ("leds: pca9532: Convert to devm_input_allocate_device()")
Cc: stable@vger.kernel.org
Assisted-by: VeroCoder:claude-sonnet-4
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/leds/leds-pca9532.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index cee398d8275b8953b5dbdb741c36161f34bba029..eeb91b7466419325191200f6cd9a4dc81f8ee20c 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -385,6 +385,12 @@ static void pca9532_destroy_devices(struct pca9532_data *data, int n_devs)
 			break;
 		case PCA9532_TYPE_N2100_BEEP:
 			if (data->idev != NULL) {
+				/*
+				 * Unregister the input device first so that no
+				 * new EV_SND events can re-queue the work after
+				 * it has been cancelled.
+				 */
+				input_unregister_device(data->idev);
 				cancel_work_sync(&data->work);
 				data->idev = NULL;
 			}

-- 
2.34.1

