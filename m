Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41912342CB0;
	Wed, 29 Jul 2026 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310817; cv=fail; b=hz9h8W0A+SwZ6DJFchasr/bSHMInEqkqVdv0P9DXDStGQSoLTPJ3yRIDE7yrEUlDx0lXTcvsH8NxTkvhkGCxNCJl6AK0QMUSrzBX3hBaZbFkD5C+L6w2+yj2YOFVznI4WHCph6g/F9GGuhDVUcvfwgQblDxdFqZqtYAqBXYeB84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310817; c=relaxed/simple;
	bh=gt5h7hMdZ2mWchx7fAT13VHObyzXmjBr4Tn8cTwrchk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OecJ90KLxQ9wlHocEq1l2RIJgggZC2wl6JSav4tyqbLQvWmMbW+WBbdNkPvY1ZNvJu4ZP7OB2VMyprFTw8UEjebkW31CWVCKxA7T3ZPlo+cbBrLnT3o4JK14Lnj2ut4GuzpICHVjV967lGMpfa1nxcZgJV8h/gLwn7VTI3TyAtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y1Abffbo; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y1Abffbo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0dcN7ziPDXAsLjxe4fiFZHbVYdipIxweyHAppKthR9RhQQRwLPoM+92/GhmSxuvQ4s1pVSMHaaTS1Dgrb2Sm4HMJ9kFNtlJ5o0NbKrsR7tgMVW2yW6MZJyX6emP9oIG592chgl3J0NgdpPDgxrnXPt99iknDKXpazMWRVf/zG0dv0gTLbJln05sbRG6yL6Np61DOjzNtkIB2tUV0fi80fERkpr+vbC3LVmUETWtDBHamVWQQFGzM2L1YMbkg0vKac/6OHVbZ6XHWhMKOk1rVTR8IgpnFi7Bn01Z3ngBLrsEVrK5HQDwf3DxmySeSKUtbaGwlFdFzPpZJKaSQCyxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te2yNtT6jiG1PMmSyrKITmS4mH1S8yo9dQTBrwXo/0g=;
 b=W+s34QYZqQ1MpFOCwadbszP7cDkZfJl47eWOYYuvrukAd8u7AWnzQiVdJUywGAifhOCxRzpqlBiSuaBruz12psyYqUemSNG8/h5bY0AnRuHkxfgqsG0Tjurt3uappwG+yYW3+NfY/HdeqIMwJkF8dBVufXOEHerFWH8N9NiMpZ/QYiiNhY6XwcaENmBrN6pn3b5oV1/Ke4kWgSAM3gkwsJDtnxG+azgDMAaaNe13UIrySgJdibEcgqnTeBMNj7x/Ai9s8JpuW//dAjrL+0s/x3Ctc/kQT5rrwwatj2bbf6sMkxUwBDshXmaaz8fWy9G5YdCnsifelhx4GGx7S8hFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te2yNtT6jiG1PMmSyrKITmS4mH1S8yo9dQTBrwXo/0g=;
 b=Y1AbffboAEXacA2yUN7yz9swrex8k5cuO3Lq1d7W1sXy3mOHcuTjzQNbKuSy4l4SDxgShqxcMP55R8yrnCpR3OaWLRgHi4MP5DIllizimsHCHIzIHo/g9nzDmDWfPLuAVT0MyeIyfPfs8WkRJY5vCsnJ0vXiym7hAr+qISa3IUZJAIY3t1MisEMReoPfpDfy/xAaIoQjLLz2B1rVTnEu0/7tlAHCfeydQqyLCiJVsXSTKUKiLGbGjAqiM5f8rVX+6q9VSbQo2XhOFTVwQk1KMBEukuM18bzKe+6w99uoDyf+OZ8MCX4Qfgcgkr9GtXqKnceBYbsjyeBnIUgdcH4+cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PA4PR04MB7903.eurprd04.prod.outlook.com
 (2603:10a6:102:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:40:04 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:40:04 +0000
From: haibo.chen@oss.nxp.com
Subject: [PATCH v2 0/4] leds: pca9532: fix unchecked I2C reads and unbind
 use-after-free
Date: Wed, 29 Jul 2026 15:43:26 +0800
Message-Id: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6vaWoC/2WMQQ7CIBAAv9Ls2TWwDaV68h+mB4XFkig0YEhNw
 9/FXj3OZDIbZE6eM5y7DRIXn30MDejQgZlv4cHobWMgQYPQpPHJFp1fkUYnRsWSHN+h1Uvipvf
 TdWo8+/yO6bOPi/zZ/0eRKNEOvTJK9FqK0yWsy9HEF0y11i/X7X1DnAAAAA==
X-Change-ID: 20260727-led-fix-28f085e12feb
To: Riku Voipio <riku.voipio@iki.fi>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785311027; l=2876;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=gt5h7hMdZ2mWchx7fAT13VHObyzXmjBr4Tn8cTwrchk=;
 b=Wp/2IOpw90N5yk7FApHTdY3WPRDguea9BlP3cbMQ/QD2oiGNXidwXLqMwvjcG0yd6wDan/io9
 j6n9RBhNeNKBs7QM/nJ5sf819QmcoQlCIRHV+9yCed44Sv6sr0QkVmc
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0257.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::12) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PA4PR04MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bc3abf-82fe-49b9-fcb9-08deed449ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cVzB6dgWmgdjwlbwRU3l69OB/hRUCAGXHpZDQr40ZdBogAycexXYKtRLAl9O1kVB6lnDKNwm9PaTrQNcv0xxxqLQKWY29aW65j0uPa7e7jsE2ICpchOcMD4ha7o7np85uJdccTWGqK/0ScMxoAadRIaj6T3ofXrtoQ8TiMtc4TbT/g6j9UiR7A7h8GHXmNFG90H3YrjYgi41aknVYwWEfV8Ucqgr2BJs6p2dh4ct1ECT+Wl1YDsB9yQrFjBTWqJQLenmsTSNxJKMH6x5x9I+7/c93A8jODB6KllE5rrSKaPcBwOQjSxrYSbo7B2g1w7rhbeYE2oh4rYza3ouEawEdde97EW7A78e49z2nVlNLsAPNSi1suI1f6ZZzqLLDyIWfAXs9CxWtV0083g0+Wc6lcbKZuvj7/ZdmUfwqM4qFDrGUCr48dpFdJiHj4puoM/0Pu83KiT76eT2a87SrrmmZS9bs3ppdORglkTx4Uq0k4TvQLLk9Piw+/iY9iuAjlKil+Y2wzxR00B5MgEt/HNpBg9pYzxgFj2jRLK8CSJXkFxnp8F7PiA89ZvHfZsMk6Ks7IM5aL5ZHP6uIMHNWwCMEXp0s3iugaU4f4eQKMOy+OLye2EAm5wxyO227ldT8k1J/VvHCiwx4wc9M0+jLBu8MtEHNKujT9NJ302Iv4aOFNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aENBUG5DZ1FxUGtBWVRZNFdxR3k0b1RiSC95TWZ5dkhJMHdRTGlkNy9zQWti?=
 =?utf-8?B?Q1h5a0xVM0x6OGZBeVZVNUJ2akVEUGhMaUVlUzJxNGZzci9sSlN4TDFsbnBF?=
 =?utf-8?B?cGdHNGdEUTdHb09TWmdadWhoMDgzbFlaN3Njdjdoa3lOa0drb3Y0T2x6R3Fl?=
 =?utf-8?B?V0N4cmpmckZqWFZtNTk5b09jbWlQSVZsaG10QnFSbUo3TEIzdFFWWXNxTkF6?=
 =?utf-8?B?LzJzK0xGb0hFcHk4Sjd0b2w2UllmNWY5ZngvdytNN3ZnSUJXdldlWld4bHly?=
 =?utf-8?B?WHowZUk4L2JHNTRmMkJJZlprdHFIeUdUMTJXNlJ2L3pnQStFVG56Tk9wV1hN?=
 =?utf-8?B?MEVSek43ZGZERXRDbUtGdURDNUcxT2V1SEJJRmpCamFVRWY1eTYzSDFCU1BT?=
 =?utf-8?B?Y0s4Tk1acm8rcmlmTFBuM1JmU0ZaL2JVRDVjSEZueVdtYUxRN1VBN1JLcVVw?=
 =?utf-8?B?ZjBzOENaRUJGb0xTK2dCMVBuS29XSFVHdFFxSDU4WVR6QVZ2OHBRNmt3cVBV?=
 =?utf-8?B?ckJHakNmY1Ria1N3RGhHZGhFYWNEZ0wrSUc4R2JILyt6SFJoYi9IUjhyNE1h?=
 =?utf-8?B?d2RoZGY2Z29hbHVaZytmQmlGZUo4Z2NCSWh2ZWlNbjY5TTBRRWFqVy8rcExI?=
 =?utf-8?B?S3RFRmxSZUNPK1NzUU94WkpDZDdzUTlER3l1eFhuTFlqZFFRa24yLzFCTmdh?=
 =?utf-8?B?Q1ZodHA5QWF2U0N2eGxweGFYd25TZEdSQmVLM0kxQldsQ1F1ZnE5YVdIUktP?=
 =?utf-8?B?L0p1WVRIdXNrWHRFK3N1Vm9XY283eWZKczVzckFGbUdCUnhLTVBWU2NKNnM3?=
 =?utf-8?B?U2xJZkt4bjQreW5Benp2L0tJUTdCNmtVakVONDdlRXJicVRXb3crUU5yc211?=
 =?utf-8?B?VUltN0NCTzAvZGJOOXE1c2lVL1A0M3NkeGpOUVRjcmkvbkluTTZuK3d0L3Yr?=
 =?utf-8?B?amRhY0hlcXBTUkd0elhCUmdlSnFNSE56bGNKRGRUVVFBWVJOV1JwYVV6azdn?=
 =?utf-8?B?WkFrcHZXOFJ6eTcrMnNtSldzZU1LVkFRenBVRU50bHpnSmQ1UkYxendVT1ZD?=
 =?utf-8?B?QlI4UCsxYmt3WjNXZzdZemJTR0ZlR3NYeXpLSkZBWWpEMm5yYmR0cHJZaW90?=
 =?utf-8?B?TGhGZVc2elhjSEtIY0prQlBFMURkcU1qb3Z4eW5uRHV5bndJUE5peFpjUEM4?=
 =?utf-8?B?VWV0dFBaakhiVUhTSjVmRk1xUXh1amI1c0JvWmtzb1YyUGppQjFwamlaZWxT?=
 =?utf-8?B?NjB0ZWozclJCd2ZZekJZV3lNNzExcEcwWWYrdTlXMzdhQW54WExTK2pYZFBN?=
 =?utf-8?B?b0Rxb1UvZytHZ01KNzQ1dHZ3Zm1WMzFVVVkvZkp5eFdoVENiMXF6OGJVeXhT?=
 =?utf-8?B?MUY4cDRPZFpPcjI1YmpaSE1NdXphNngvYjlPQkhuOUhsZEM5Y2RPRTdKcjFU?=
 =?utf-8?B?alYrR2hvZ0RyRzg3Z2x6clFrSTl2WGVkZ3ltUjVaK2RCNVVOWWtJNDJQbFFS?=
 =?utf-8?B?clZjNXRocWVHNnBNTmE3dVQrMWZUTDdvU2tYM1VFL09QN0krYUU1OVJFUEMw?=
 =?utf-8?B?TUJzdXhGYSsxVkpKTGFQNDBBZVNXcEZ1QUl6Q01PQmsvalZPYWZrcjBPWVVl?=
 =?utf-8?B?dEZxVlo4TEZ4VnUxSWF2Uzg0TnZBOEhJVCtNazZuVThDUjdxS2pZa1RRb2g2?=
 =?utf-8?B?VjJoUk1VZnU5MkNQUzBGOUxLMGgxVURRRzZnVG10bVFSRzMvbVd3cGpMWW9T?=
 =?utf-8?B?U3IwTVM1WnBwZ0xGdFRLaDQ4QVpxZ29iK1JFK1NweVpKelBKaHNtdHdaN3Jw?=
 =?utf-8?B?dmVxYWJYeVB3dVlHMGVOVHZ4cmNselN4Ly9PWXpBa2R2dVdpdHJGckppbWY4?=
 =?utf-8?B?Ykp2aEdSQnFyaXY2Qjl4NmJkUkVkVTk0VXNNeS9GSlQwemd1bGJrSzF0ODd1?=
 =?utf-8?B?bm9CWWV4Vi82ZHZ2WStLMDBQbVViTWg2NkpNR0h4MVZrUHJRTW5EZDViMmho?=
 =?utf-8?B?bE5ETG9XMlI5b29qa3FXOVJYMGRmRXJkeHQyWi9lSFRvYjNvakQxdTJmaitq?=
 =?utf-8?B?bUk4TTBYazRrMTl1MnF5M0xhNjI4c21MOWsvVEh1ZFd4SnQ5d21vNERONUx6?=
 =?utf-8?B?TWxLOVhON3YrelFSMzlWNkVHVWh1UHIxY3dGdkRrYVZ4UEhoaEZTa2ZWODRv?=
 =?utf-8?B?YUxaRlhNQ0JVV09INzI0N2xycVNscllTZXN2TnRhUGs3dEZXNmorM0JvNTJL?=
 =?utf-8?B?TzQ1NFB4dktjU2hYTVJrQTBqQklRWnJ3QWYrb2YxYmNVTVVWR3o2UTVubVNZ?=
 =?utf-8?B?OVhRTkRpSmZxWGZGRllQWVhnSit3ay9YMzZPOXk4S29mSFhnOG1YbGxLeVlo?=
 =?utf-8?Q?FeKYZly4v4JoEU6IRh6QAmYTwMLJIkmrfu38M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bc3abf-82fe-49b9-fcb9-08deed449ab9
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 07:40:04.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rhbbnfnkbSolP283kmQVAt4nN8LUY+DlzDaCyyYF+NG02K/fRTNNi79d/UgqrjdFiSegnDecj2+1/nR2NOd/g1FeGZ6aJkyc37rRdsn82jqzh93b+aIcFL9zpANX2pm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7903

This series hardens the pca9532 LED driver against unchecked
i2c_smbus_read_byte_data() return values and fixes a use-after-free that
can happen on device unbind.

Patch 1 (the only patch in v1) checks the return value of
i2c_smbus_read_byte_data() in pca9532_getled(), fixing a Coverity
INTEGER_OVERFLOW report where an I2C error code was cast into a char and
used to compute a bogus LED state.

While reviewing v1, Sashiko AI review pointed out three additional
pre-existing issues in the same driver. Patches 2-4 address them:

- Patch 2: pca9532_setled() has the identical unchecked-read flaw, but it
  is worse: one register controls four LEDs, so writing the truncated
  error code back corrupts the state of the other three LEDs sharing the
  register. The return value is now checked and propagated to callers.

- Patch 3: pca9532_gpio_get_value() stores the read result in an unsigned
  char, so an I2C error is truncated and returned as a valid GPIO level,
  silently handing corrupt data to kernel/userspace consumers. The read
  is now stored in an int and the error propagated.

- Patch 4: on unbind, the input device allocated with
  devm_input_allocate_device() stays registered until devres cleanup runs
  after .remove(). pca9532_destroy_devices() only cancels the work, so an
  EV_SND event arriving after cancel_work_sync() can re-queue the work and
  dereference the freed driver data. The input device is now explicitly
  unregistered before the work is cancelled.

All patches build cleanly with CONFIG_LEDS_PCA9532 and
CONFIG_LEDS_PCA9532_GPIO enabled and pass checkpatch.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v2:
- Patch 1: reworded the commit log and added an Assisted-by trailer.
  No functional change.
- New Patch 2: check pca9532_setled() I2C read return value (pre-existing
  issue reported by Sashiko AI review of v1). Cc: stable.
- New Patch 3: check pca9532_gpio_get_value() I2C read return value
  (pre-existing issue reported by Sashiko AI review of v1). Cc: stable.
- New Patch 4: fix use-after-free on unbind with the N2100 beeper
  (pre-existing issue reported by Sashiko AI review of v1). Cc: stable.
- Link to v1: https://lore.kernel.org/r/20260727-led-fix-v1-1-d635c5037109@nxp.com

---
Haibo Chen (4):
      leds: pca9532: check i2c_smbus_read_byte_data() return value
      leds: pca9532: check return value in pca9532_setled()
      leds: pca9532: check return value in pca9532_gpio_get_value()
      leds: pca9532: fix use-after-free on unbind with N2100 beeper

 drivers/leds/leds-pca9532.c | 47 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)
---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-led-fix-28f085e12feb

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

