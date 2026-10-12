Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E7F411A16;
	Mon, 12 Oct 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813031; cv=fail; b=UzkuIGS6RLW67c7JqU9rO7vmhqh6U+pp7M++Sxb4Hqs/eobfAKc+0QFmEVldYvgeY4Pv9E1zsLXhSlXZnLHu8Lq4cNHGFNpXRZ3XaTunRvakRYVCFf4E4TtmoeSOIlRz0n/ul930mlWPwprS7EvMKWd1QrG+fonZ12aQo+gAhAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813031; c=relaxed/simple;
	bh=oOF/PJuaJyHssX/I76mioU3sYrmFnu/ZFL0liPDmbo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBksIdafUNcZnfRIRW/KpHtBmIlH2/wpPc8G0fKC6sMqEnEhyPPFdCin/kCSKFFV5nOEuUR22XEg1gFM6O9wNWGsks0aAZLSTXTGg+1xNFVL9yiy85xFiGOvs5qCMvD1QZ3iP9FzXhv/f4UKTMhBGmrY4t4n6kQfzgnNPUYISeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NU2Ghzit; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NU2Ghzit"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI5tc8AJQD88TGrC9k2dmO7FcdRUZ5LYQZke8N5SkaoLNenOtfiK0nmol5vMsnj9BCkL3rcGHxrf2TpR/x+T7gaB0+HBLlW0Hd2KRLrVx72uVr7GF8rzCBA6JR2fuN84XBmvQY/dkpquWkWh8mo83oOC/epBLwXBpX4oXqpihOFOujmtQYfN3Bb+f5wHDZZNkNKmWW73Ra4zL5NR0NLGxzOh8XgU3+ZPOhDiZ85gs+WjNinzuIx71Eg8/r60QsQW7WkKbyGZSrJvvj64Eqqw6wLBh/FNsZJJGin7gJrQfRtawEa6dQ6pxavITGWiExmwQeVnNQ543PVZc/h/Jc5yDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fagoEWxohml5QAZl6gGN9XAJWl4d3N7YSHFn/Y0Sex8=;
 b=YHlwkgwlA4Pl/3mOk9+8oYZ6hYadeJYbkNUfT6H1uEwrA6kYusR9Wc3qLwKILAbHpQzqYRvClfTh0PHZRGatzeqy5VJIFawTtV86rLTYXfh9bQ247AQcUnUxo9EBGH7wI4EJ+AyPEHpCk5Y8npPdJqsHsolqTSdLNtH+cwoR8RIHXW/ZsBRiUqmYT4A0olJBZmDFsk5/mzuvmX1kH+n0CH7GlsZKF935H9PXz7uPhMNlliY+43zXfmYpHKmsMhi4iOwPysVch7ZOW09D4PKB/lBZRMY/VqrlQ+/xHgv0S1rJCZ+86eveMMEUoFvf+AbXxLkBNcQvEHLPYGBz3M+Vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fagoEWxohml5QAZl6gGN9XAJWl4d3N7YSHFn/Y0Sex8=;
 b=NU2GhzitRJHwfBHYgzdWdGjsFDolPnuXA+fB7VTcNvBIRiO0PMwustSKbN8OqZz+mmWE2j7JEkz9E2pLihR/fcu6iIFLR0S2RpLwEW9QvwcNho5kWb50M8w+SfI2e47iGyg8OdJMekOLyLk/I8qDHWBJU/MVOCWEaXp0Sa1z4LjInSJGxnr+H8hxrPMlCrJ2nG7Pfx/o//FwzN8NVKczsk6VOXz955Gqq7qqt0G6ityb7AhqRZw2zHiTEEWGaBWEAsFyPlDnUJcCyEyjoHHrWGJWSsAFIJkhwzDXflTv7yh9IdGyxpJr6kWht9MFFOr35gbd13/ZRfLnCWMINhec3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 13:50:25 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:50:25 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/6] gpiolib: free the label of lines released after their chip was removed
Date: Mon, 12 Oct 2026 16:49:56 +0300
Message-ID: <20261012-gpiolib-chip-removal-v1-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 704098a8-d786-4900-dc99-08df2867c430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|11063799006|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	51P+Ah9+8pyFpBICalKnw7Q26RcY6MZ4P0snLCfaU+m/L/PhMgp8i9hAASTiRZLh9Mh2/QfIJvO81p8oNKII+fwWJB4YqmyC1Su4mFOy0jtjrxd+twcHbpF+Pg7yfgc4zhNCNQQwzWhg1IQMVmVsXtqJ50LST9AgTVYrJc/2DSaA485x4Vm8Kx+Cq1ufQizGIMEcR2snJ+ceGdxohD2qeOUre5tjn4/uqLSLx+XEVks5ZPUVq1+GHVJxY3UjqDMJ9L8mjDRoD3Xfmm8mroHXqYFZqB2Yd97mbMBTbtfVtXEIodqvTEILmxseuzUs/oDO6/LyUZRM0tLiHDae1smiNxyqziicDwAr3Dt+uj9EOD5sLcbTNdSl/wbLYncMLzqt//71v1/qx8Gs7McnjzUJHUCY81U+g2fSBkANYmL3gUnSWRBUlbhNtl9zRCWPFjiG/7bZFaIXAzyXVpytpKnELXDfFpaBXc3vdEJTG1g9wzsZo09qnN/h4U9dqQm4xsWmJ6FLZgBxlJC5a4LEA76I13TZkHx8iOmJmMuJY34IUUplWji4xA8UybZmJ92ZyrXm7sxZxIxh1eJuc+FjFThS5OY5XAI16jWf1FWshP5lldZqG/tFebZujcQ4tyf1ujdJFiYVweXk5PVQ0qJBiKVXSW1gjaJOJeYkRsRwKiUEQso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dLnHXBlLcvNdWnh+icUoLjTzp9DINheQVhB9AHU6pUefiSbC50jajr9Jpxd?=
 =?us-ascii?Q?Vj+5dkkL10BTxKdE6pavOuflN5qHPST+lAvPSu1hiBuf4EGFqjbEW/uVhRvq?=
 =?us-ascii?Q?ScpoOgygAe5cpT2CoKwHF/8huriaBsdQFbMNfl+9/16WtKJztwR7LGxWUUdZ?=
 =?us-ascii?Q?zaSAXZOPcinm9UTppMhobzw6H7Um3bjuSGoUPbB2UJHBPXsXdS2ZGlGC50CK?=
 =?us-ascii?Q?gu0wTl+DR4nCopzIQUlQf0EJxuS9/N+xTmjpztCt+tcMKIQiPy5mX22fXxb6?=
 =?us-ascii?Q?429+UPyVa24uMjtPEK3YFsT6bFcKjTTCnz3mBWXEg6330A37B0m6gHV17gLj?=
 =?us-ascii?Q?+NCUiVqNOLq+gsmLF50UZM8MHEKLCOv2VpXa364T9G98hgqi/JF3k4MQnKTx?=
 =?us-ascii?Q?Fn9lPJZGGN6xJ1tXfrPwTMNAi3sdJ5kwXPzTxdkakSu0oSgx2di0uXZxGKDB?=
 =?us-ascii?Q?ymH4QJvKD8MXqmQLnk2EdWnYPEfAkZtwU/T8sz1MDNYQvyV+9D6xQdOOJaaA?=
 =?us-ascii?Q?Lzv0Yy2iwu8aIdOYko62q8H1SphvAtL2a/o3Xkk1M//hZnTS41FJMawEiVAZ?=
 =?us-ascii?Q?WQ7yf/cZY/SEPfKuksEFNEcBJHUM1k7MdPnOtIfXCT2CVJOTGPEF1NedfGqh?=
 =?us-ascii?Q?esoA5ge6f32V+fFkZbxns6Y/Z0GQLrjUY1Fwhw2O8o84EpSeVkRiCImDQeKt?=
 =?us-ascii?Q?QUNNwWC7JW8lBovhHrWFSh2j82J3jE1AN40l9jc5UajPICzN41D0HqzhytSV?=
 =?us-ascii?Q?FqebUP91idsEHPJr+3qUWQmYGNCFJ05HhGQsZWpsJkY5KuS/JlRY+QQd2Es4?=
 =?us-ascii?Q?B0QhvJoO4bpbF0Og+BnjctBG7bQ8lvsZkqR8Zz8sMttd4yFxKLOLSWm9DENQ?=
 =?us-ascii?Q?C7WePxJ9FN8z36WTF5/ZiqM7khQ6wgCK5YHHbbUVixt9FN8R9ArgyQv8nGrN?=
 =?us-ascii?Q?F7gQkJHQZW3pdXb6wSHZgunsS9FCTVTx5xr+drqzkQokmQ9GDRfbWZgx7B9K?=
 =?us-ascii?Q?/gYyuMMuDUvOCTNCa+CUMsyMuL5+L3sdszWAXI+lzMmNwG8cthjQtnE/rU+3?=
 =?us-ascii?Q?3aXB72HyGlKW9A15o1hNxX0eSj2oN0y2z5m8h+s1PfiwEZzADnocyMyGqGdW?=
 =?us-ascii?Q?oO+ITwl5luWoBrmot8/ZHtjMm41mTYCYsTmH0cWtNDoFthMQeXmRQqyAruzK?=
 =?us-ascii?Q?5rg99AI5hK0S5bLS7tSvBWJbBJgG8wahcXDiGPezn0TDgElxGi/kQAGg1yMz?=
 =?us-ascii?Q?ZMytrjTVsfn9dJGyUB0xrpRimrGqFF7X1WluOzMwHizXDZ84Q+l9xRrrtSD5?=
 =?us-ascii?Q?OdYSK461hD4TI+r2WK/FJa0/iVKeEfcSlx3jikKLo8hHxMmu+asQjgX+o7pU?=
 =?us-ascii?Q?piWCpCOzMSx4MruMi4DeLC6Py09qKa6caGS9w36BOf+ZRla986SiYPWpcvcg?=
 =?us-ascii?Q?gOQndfNUkevblhF0kKGDBcxTR3GfJiIQVMVujhA18Zyax8dPseWebn40h0BG?=
 =?us-ascii?Q?a8TNrPGS9sF+jU/gVWpGnG7k8tmMRhceEykjIU5aSsXmlz6Z+YApSu8+BB09?=
 =?us-ascii?Q?bK13OvIUYgXNM/pOUMPHMthpCFE51AV+jad3bhXYX53pJJrpA04L7JpAv9BK?=
 =?us-ascii?Q?ZAYEu9YNFOkAIE5HuxAVQ0iGUq7LpGQ48PDKmDN0S04Cm7cV29jl3RJJieNS?=
 =?us-ascii?Q?xdkDsJBnigaVdfnp4IasdQKB/E+VmH1LP0d5sSuca5GMbDWw0oaacguf54BP?=
 =?us-ascii?Q?F0JGROsL0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704098a8-d786-4900-dc99-08df2867c430
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:50:25.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUOmnHF1Kz2+Iap3foim9PbWxFFF02w1GRREFHU+idVs8y/6Jv1Q7wkWB7RulK7mnMno8InlEndUB2d/2EiS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

gpiod_free_commit() only drops the consumer label while the chip is
still there:

	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
		...
		desc_set_label(desc, NULL);

A line that is still requested when gpiochip_remove() runs, for instance
by a character device line request that user space keeps open, is
released only afterwards, when gdev->chip is already NULL. Its label is
then never freed, as gpiodev_release() frees the descriptor array but
not the labels, and kmemleak reports one object per such line:

  unreferenced object 0xff110000057b63c0 (size 32):
    comm "gpio-hold", pid 111, jiffies 4294696675
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      3f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ?...............
    backtrace (crc 7ff222d9):
      __kmalloc_noprof+0x4ee/0x670
      desc_set_label+0x32/0x110
      gpiod_request_commit+0x1dd/0x320
      gpiod_request+0x28/0x100
      linereq_create+0x61a/0xce0
      gpio_ioctl+0x49c/0xc80
      __x64_sys_ioctl+0x134/0x1c0
      do_syscall_64+0x109/0x5d0
      entry_SYSCALL_64_after_hwframe+0x77/0x7f

Commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
cleared the label unconditionally; it moved under the chip check with
the removal of gpio_lock. Clear it when the chip is gone as well. The
->free() callback and the line state notification still need the chip
and stay where they are.

The label is now often freed just before the last reference to the GPIO
device goes away, which depends on gpiodev_release() waiting for pending
label frees (previous patch).

Reproduced with gpio-sim: request a line through the character device,
set the chip's configfs "live" attribute to 0 while the request is open,
then close it. Without this change kmemleak reports between 15 and 30
such objects after 30 cycles; with it, none after 100.

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1984f3416437..750378f3907a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2689,6 +2689,9 @@ void gpiod_free_commit(struct gpio_desc *desc)
 		WRITE_ONCE(desc->debounce_period_us, 0);
 #endif
 		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_RELEASED);
+	} else if (!guard.gc) {
+		/* The chip is gone but the consumer label is still ours. */
+		desc_set_label(desc, NULL);
 	}
 }
 
-- 
2.43.0

