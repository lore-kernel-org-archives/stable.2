Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745150;
	b=dNOFaa6/2iytPMNwC2f6UQq3g1QoJxZecSywn3lQ3vlTGae14dWU1Z6A2IIW7DVL3saT
	 VpnHrZ7LHNdgWcJIXMw9eupokWItTja0sG3my4qqHoz/GXj3Xtdh9xenlX1n4sG1hPRoO
	 5r6Bkls8nlQmeUx/pDHIRg5h7ViIT8JmsInUADG//XPEbrqx0icRkUgMz3B6KBvYx8l7T
	 /RgUnXEZcvh+Te1whCyxT0lXCKFWvthBKZRPr08igok5iqXhzLxzENDM8/iKZkSxDrVX8
	 rtgVhVrgHdtcILR243bywnr3C0cPLyHaQZqbF2CZdatWcjcq/3YDOVPlqgJbcknyidg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745150;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
	bh=j7lU1Qz7hecT+S6oBoMfrbblZcB/CWLWhMyfnyC6Nt8=;
	b=eBCy7SQekA5bh93+QpdFOQV8xXUA3916KKKo8Wb49lPNvtY/C8mv284/HiB+6nArz0pd
	 tEdl/DgP/M+FvhdBEyT/zfxTjkHSxWVfjEnrqdtBP3TLEasIWcmLy//p73SwZxrAriq8K
	 hZZMbHE3N1+7JvXmg4Ur7dTcqATWlkjLVGoWFmmk/jkgljgGgJyuZXtx5AORfyiIPjrJM
	 ntf6GUoB3frd4l+czrD9y9GlxdntIRXTYJ+m/u0kDQQSq/ELhNNUSux+BaZJ/yE7fxWHj
	 7qMhL7FWYIlJ3KQOO+D9S7o0nWc5sBzr74BZsmJpO0gwRjtju/5JIaNKxQmArYzuSaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=p0uj+Jho;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020123.outbound.protection.outlook.com [52.101.228.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DFE606A31C;
	Fri, 27 Nov 2026 02:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=p0uj+Jho
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0TgOg08cTL7S0op2f77nc2Y0a1flE0M8FqPBtTj5V3ErQZY/yTqZc5lE04oCihjxcYz8c3JNt7ac8Yb8OMwqd0RofQtn+k1hUYpVi1PWnym4ntF5YJ6vo7LtDWhzmzig4wOgjtOtBtfWYyLmmkf5e3vl+dW46lXFajv8diIujwYN2j9imbzBWwhgFf1H05E7fLtTU7iD5M+glFrKDZ1rUtRk0s/f85sMVuX3c+sQvct+y/APgAK1q0cAsyjfH85r1wb6pyPr+KG0HtvJY1p2Z6gQHpcprvSschSbbRElJnAbMhDDGq96xKDMcIy7xvlKFtrLd/N+Jw7Ysp2wzENeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7lU1Qz7hecT+S6oBoMfrbblZcB/CWLWhMyfnyC6Nt8=;
 b=yziuF5uxgxXSzNKDtn1s6VnGAdwnOsAWkM1f9+bSN/mmjPKcN1/7OsaiOhL9vjLx2NMK3OZhQbCxM8LRsWhYU1dGrJist6OkqRwK4sRGozdJMtdYUFewj7Km0TVSuq8DoGhtJ0Ku/s+tqDe83FS0ylOdHZtkhsRFW5RBKoDv4HZ+40UCYzCyxzmlMROLbwm1e+78s+pLDoCn+t+Y7aw4hsTst8HoJ9JXNMztM+wbomr/raMOeDJH8ln642tJS0okszxVCBgjQWbAYZ0MjW+hGEW15pBZNt5Rlg4k//0NhLEv7VpWltjfnnI5nYM8NyB94Sx10C6B6zSFvClZNbyUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7lU1Qz7hecT+S6oBoMfrbblZcB/CWLWhMyfnyC6Nt8=;
 b=p0uj+JhoHmkCOoaq8LPQF4dnIxXxzSZMzwPFtmwIhUcGx5ogulYRrK9VSMeeVpZmp1zUYQvcYqudUz7g75h6Xx3qY31FwXCw8bbpwqGER5ckexwOb35mbRbwh+VWosHw++L8B4v2JTly3tzEemZugk8xay0CFiXoAhVnKzE0D+g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:46 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 00/15] NTB: ntb_transport: Miscellaneous fixes
Date: Fri, 27 Nov 2026 11:05:18 +0900
Message-ID: <20261127020533.2481725-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df3d597-aa43-4d21-389f-08df4c2af343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026135527099003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z6NE1JaXNYV134Vx/a1viT552jO0OQCKxyQVQ0trXmAz9TEmfYJCGz86fcGAy499PbNgrymHEYnucB8YQVa/Tc3KY2GVZR+N6fm2ZA8ZCDKeBmbHoeyOHgWXsJJfXHylsgKSQICmmGR7SvNczmcNYovOdrMhIl3ss5rO6tfFL5UN8ZtUWSv1nvCmN+r0yYGlWJXMw16PJT2vvCJxz28EVSK64Z48mEl8EFJgTxVRNfBoI/71F9ZpTgUgr6vEvl71zdGzsDJtJc0ivcxzOrk/A/vYcTKK1hK1Sa2OIAfrSco89/WiIeqWNYVRwkyVsgoAHVsfAjy9Zm4XqkeejNE7fOp/kCvt399HoXcZzwPb98N9zh6G989tH/yZQAOLVWOeqFIUZJ9zW2ddmrv4fUn4M6FP6c0gbRjJ9x1+/WchWXIxTOg+wC9opH7X13DofJ0Ba6o4Fj3PHUm+rvIF4K1GYQ/WnGN61QUNjFfyWcmvfAGsESfbebT0HqZpGVj64prckTsmEKohdhzTgsg1Oo6+rrKDRTUttPmzG/7G7ATJuzdTxqXUur4l5o2e1jO+mx3P6TjtRA/fnRg/l3tNtukW+6YkY2M82Gb6VlxcpwRZ1HGvm6lgiKL1U4hkQT+BgO+o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026135527099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EkjXYdqRU3ZDKBEmRAO+xzzlbmg4I/7AqFJDrEteBGlzraMUeQcI8et1qsqh?=
 =?us-ascii?Q?+d6HOvx990TrwNO0EppetHui4j2+RGhbDjFcN/ubXCInOpb8bJ4sH3Fsw7al?=
 =?us-ascii?Q?AYIvDPCJdKzYHxU6Ql1T95k1c7ekNrId/blLrvW6tt8vhy/0eGPJP9dxZ5/0?=
 =?us-ascii?Q?jwUT2kegnYXC8AEQpcqFExaWuaZXk9nJRW2ou/U55qX0NXt5HR8YJL5OgiEm?=
 =?us-ascii?Q?mSPgdSl7belM+jD6m+Uxao8qafKfqnhcLypgk/zjPuIcGkrNmxNR0/kXlzyn?=
 =?us-ascii?Q?PRUKVybpgu4Nck05VoW/x5qRv0C+7hVV3Mgmuo9tRyIWI8mhzu8NhLosqWwH?=
 =?us-ascii?Q?qrWf/JiADDOozBFu3lB00hx0roXKrInITU5k7F9yLyF2PDBwhjC4PSaBLw7L?=
 =?us-ascii?Q?tUHyidEu+qsOOhe5EV+8/bTnjYYv6+CatgziGrNh10DbMQjyHzucu2q6yb32?=
 =?us-ascii?Q?yNanFkFz7+Aye7lCaq3pc6dbmIACW/SRd/4AYOGN3h8e/Z0L6KF5mAp/+e09?=
 =?us-ascii?Q?fT9vP7ruqmAMDuKNrOxLDlT+i2VsrHjJ6t7vQbGGBcg0RrwHhZfN0fZNLbqW?=
 =?us-ascii?Q?+P170i3FRA3iYDGLjJr7yerElWb3bay7GsG4XWRwPt1el+ui54dDJi16p2fV?=
 =?us-ascii?Q?Y7eIluYjJnT9SS6mDE94mLNLDQZhcrAFoVxzcsFLkHR+QdTYL59xZz7Jg0Jd?=
 =?us-ascii?Q?V1+W1Kgz6IJ/M/FDSW4tuvvFeVXFgtX2iokGPi8s16qyq2IzPHUJGXvt45op?=
 =?us-ascii?Q?aNqQhget6MQ+/1rjJRAe2QJqiiAIGUf6FIemTGYa7lbfXxvW5jVjKdw93n4E?=
 =?us-ascii?Q?r3blkGyaut18HW3FI1HicyIm4kucxc5gmEyKiXoG1oANBHG5/JlENSzKBQk2?=
 =?us-ascii?Q?fj3SX9dXq+uJHo2QamvFzM3DtmWxracVlR8XhdRqpB6o3Fqq/V9lIbj5UOfa?=
 =?us-ascii?Q?gwmfSdQyd2/fI+l9X3++PMZc036kww0YyUokG4E/4hXzoQhejBP9Y67q+5if?=
 =?us-ascii?Q?kvO0MQIgTPKxuxKL6qqKCjNkJy4/wBpAg+F0T/rDmTZRNK1uSdZ8bci0vF2g?=
 =?us-ascii?Q?MFoC1jOqLrlOXFONt9ralnLmkfvbAQnD3Fk+rOpfLOValHsYLEuj6iiNf2QZ?=
 =?us-ascii?Q?NjOfJ1pznnDx9Qf0ldQXp7khmqcLhe3oLLuIr3ssDoY1CNTyJxWM3kEgMkMb?=
 =?us-ascii?Q?2Hh3YGnXuygaYsaKuwbWjaRJun0MjyLSJrj2hdn7wFh5bjWslAepXbl1uQe7?=
 =?us-ascii?Q?puBKDbsTaj2CHpjow5WXjHUBT2Lrxl5nQerNvAznqZBrYZoZInoFiz7ADWbb?=
 =?us-ascii?Q?V5dKgPf+i3XF/F0oQSEN9b7x7UZP6i6S6P4GCuMf5E+dRuM/D+vXIzP+3ZTZ?=
 =?us-ascii?Q?ZNVZoge6QHIy8vvuIKrsGb+/n7VUJtXM2cI/w/Oew0+NtVFmZV2uxUrfxS5b?=
 =?us-ascii?Q?kz2WMyKa/zUBjrJ3KOIo+vV9nlneh8icfUWrM8GmEnjNgWc5Mo7uAiYp8vpQ?=
 =?us-ascii?Q?p8mA0NKsTH6C2Ggvig8enU68MTT6nymcfnMRdspn3U1U5HKqVp2SE0vi6h2r?=
 =?us-ascii?Q?tin7vBECMP7bdAQsgSBUm+jeyv9WbVo3ECAqlYakQtidIinrgO/tK2AzyPoj?=
 =?us-ascii?Q?dOcVo9cvQdL1uj6IECOtcXLbl9jtMMMO7L5lSGGM/gwwFkv/pEgqxERp73mL?=
 =?us-ascii?Q?j4lxJJTnufmGVapMuFzNg+mtXebS1YjJVaRsQNsCVcKtscUglqKIQin6f2OR?=
 =?us-ascii?Q?anvNKgxrb4HmK9AQ1FooETXAcXAeoueklZrq8dMrmsWFx0OgQiKd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df3d597-aa43-4d21-389f-08df4c2af343
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:46.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHvcY4cjr1CUaHbgBgKjT4dx8XEV73Yo/SWvHiB5oT4EoxpWFJ5IJ9cTBTlgnx5UXScaY6nr8nfOloqjWVFCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

This series attempts to fix miscellaneous issues in ntb_transport.

Jon, ntb-next has moved forward, so I've rebased this series onto its
latest tip. The rebase was conflict-free and needed no code changes.
I've also updated a comment in patch 6 as Logan suggested.

Please consider picking this up for ntb-next.

Best regards,
Koichiro
---
Changes in v4:
  - Rebase onto the current ntb-next.
  - Clarify the memory-barrier comment in patch 6. (Logan)
  - Collect Reviewed-by tags from v3. Thanks for reviewing!

Changes in v3:
  - Convert flags to atomic_t in a new prep patch. (Frank)
  - Drop the redundant TX credit assertion. (Sashiko)
  - Collect Reviewed-by tags. Thanks to Frank, Logan and Dave.

Changes in v2:
  - Address Sashiko feedback, including regressions introduced by v1,
    with new patches 5 and 10.
    Note that to keep the series manageable, this revision does not
    attempt to fix all the reported pre-existing issues.
  - Add a fix for client removal ordering (patch 14).
  - Reorder patches, moving v1 patch 4 after the fixes it depends on.
  - Add missing Cc: stable@vger.kernel.org.

v3: https://lore.kernel.org/r/20260928152550.3354675-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260910040836.3792333-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260907142429.951930-1-den@valinux.co.jp/


Koichiro Den (15):
  NTB: ntb_transport: Remove the device debugfs directory
  NTB: ntb_transport: Start TX offload thread after queue setup
  NTB: ntb_transport: Make link setup flags atomic
  NTB: ntb_transport: Avoid deadlock when cancelling link work
  NTB: ntb_transport: Publish link state after QP setup
  NTB: ntb_transport: Avoid losing QP link-up requests
  NTB: ntb_transport: Clear link state before QP cleanup
  NTB: ntb_transport: Stop QP work before freeing a queue
  NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
  NTB: ntb_transport: Drain RX tasklets during link cleanup
  NTB: ntb_transport: Wait for RX completions before resetting a QP
  NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
  NTB: ntb_transport: Clear QP pointers when freeing an MW
  NTB: ntb_transport: Abort link setup on QP MW allocation failure
  NTB: ntb_transport: Remove clients before freeing transport resources

 drivers/ntb/ntb_transport.c | 245 ++++++++++++++++++++++++------------
 1 file changed, 168 insertions(+), 77 deletions(-)


base-commit: 0aa2e6bc39f17e1199345aaf21278e3ea25e6036
-- 
2.54.0

