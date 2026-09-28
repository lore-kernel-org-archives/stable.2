Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F274E77F8;
	Mon, 28 Sep 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609179; cv=fail; b=o3JupZUh7UyL+HuObzeJjvH0r4YjiBulbRYCQFXmf7lLzdzM1/72SHxWJIweJZgciP+KKrVrNBgI11n6VHvOI7YawM0iwjXuJd0pUL1h9XAAS/t/Yx4NyBEYoD6MvTDejYOnTGAYr0ZPveAxE/9AdER0+IAQTBTcK6gu3BFMpjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609179; c=relaxed/simple;
	bh=LM5TXVbbrkl9FH8zlfn/7qA0q/dksM5Xoawt6xsTI5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JX2krwxgO7wAWcWWgCzOdroc1QYKo6J8+ydKROE/GFzSwEjDjK/xwOhApgU7j1I6ZMedPzWHq4olb96NWzxWPZpqSYS95XuqL159dRjyYz19UKahD+grTpPS57pGZvo/wE7njm0GzPXB4oK1VEUUmWAiz342pORvc8iqh3YKILY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=V6zueJSK; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="V6zueJSK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THFhgpYzB+N9kARE23KGf7PNRlaA8D+465qza+0OVPjnQXfj6L6TcycsZ7d/Qt1KV3PfgbUskA94UZAyU2oZaUlJe92sNWssrfU1CYvrGtE4kyLzfOW3fIG/sVOTTUQfBUzdT3Iax8IhyBjhC5Uu1gZrxzM7TLFl2HRm/niPsqFUwds8CP9eTqnR6nP9Dz4z/646zoRaty9HOYeJY//cLGJhrlWbDIhh6/oA/ylwOKx7JD5QpBVIHeqgRtVx9A+c0ASVp3qE/wCuMQppXoqNvZEyeNJtAe8cVOWDgz+Lb2V8g9Y215pz5tl7EnI5L28/Jqy6702ud4R9Pou3jdrpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRubMNAuIYS4/3x46l6nba5vf4LWYnbyJ/dn7XociU8=;
 b=buiUrOR7KSvL2y9DhHr298MAMSGvRiwW+BPHaxkiPwW5tfNKKBTLGkDZlHdZIRaGS5Lzmp6FT79azQoDsSWZdYuDd9TLFkPZ5TT3py34BTMD2BLI4HHShNh+SIR+L27Wcy1K8Pf9VuxY+9g7IQ/PvxpxctECKnbofIsWbvm+O9C2hDtzl2y9gCivcylLOTyjLdDPhb/zxrfklYL8/AhEC4ZIoCfr4fci7DsV88V7Q8zlswfwGxRFCiRbotmwrNjlKlbU2PxoFZrziPY1xBORUWrMcvpif+26xdGktm4XI7mU550dg4j3/Urae0dfMGbHv5S4InaFPgwmNW7w99EVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRubMNAuIYS4/3x46l6nba5vf4LWYnbyJ/dn7XociU8=;
 b=V6zueJSKbVmjl42AgTxlqAGDMfUo2w1264KjLA4l9SGdkHsTvRbsjRXpuUqy42lptAQR1AGDYjgqbiJov05qK3SVzsBJD24yPxz7Y2ito2zE8uz+x//QAd8nAvqYm0sC/79AxDGIg6OgA161vf8sv90AE8hr9cpZOvXcnE+fgqY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:26:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:26:01 +0000
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
Subject: [PATCH v3 11/15] NTB: ntb_transport: Wait for RX completions before resetting a QP
Date: Tue, 29 Sep 2026 00:25:46 +0900
Message-ID: <20260928152550.3354675-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 178d52fc-5ee3-41a2-45ef-08df1d74cd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MxQ+9C/ipS/rxqC4hu/I3gXlI/DEfr3aY0JnQJyvAPmprNZ+p57yjQhjid48RcJs3P/8OdY5qm8FI+zSsT0paQ0NKpLb/m0d6lWe0xIWPvEVQHjHx57wKzbNqAT5p9uvK6rXDNY8m0t7/Jo+5B/uQ3QCupLvtimXN599UPO0pVyNSGSf83xpZRPedqo3ahPOEnfVtEFgltYDeuBjCAv4ytwqgEF5QjPUpEJTta9j6ELVvh7cSJc4xQfX1nX2K35B5Jeb5ptS7QsTCRYWNErlhcH0/7LrVJKIx2+goadka7VlaRt2BLedDM8BM0wxmjAc2Dmrok7I4Uh/DMT+4kbIe8DRAQKy+y0BBBnyChQ5C2TxwRz1YwXhLgc6w30AqkJcI9k4q+q5ViXk44208rlrTKcFWClOOid+1txmukvfuO+U7F2QeBkjpith8MzfoCIbV5EAKqym3yKMb8l+PJQP8OivICpDkStHBSz4/v4uI/2BqKoP6hOoM1dTPFTCK7g+CtLsgFTHBYjBogZR+icQoW9jvxNDyGUUFoEWOrVqvqF0qsI/sdlc1NMBsG7H88z/ffUyblsKulThtKXviTm9SMN7ReivTJDqFcCSVyW/ILI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9kiqq+o5KDSMliV/s0Q25iGJlz2wbLg7xh3sinfCDWoPp/BFctUxU9/p70S?=
 =?us-ascii?Q?YmnD95q6empbdWEVgeSCUqVhzeyrJRDy2u22Gj9j5D/g8WL98FfxrvZ2aiB8?=
 =?us-ascii?Q?xCH+m+spJEMbtRIl8yKgLDFLZrq9vm04Cl6Lt1ft9X6eZHCLZ63cOaK+I0cN?=
 =?us-ascii?Q?/rInGWjB0BxV9Lm5bEOzVG8NmQQkaTopoF2V6k8clgvmlWb+37ELwOXVwKar?=
 =?us-ascii?Q?S0RZGN+rZWwyAL2lIp7sTqHXMH0nl5o8aEkryKi4/kipN95/TliJk7VLT8oE?=
 =?us-ascii?Q?df0M/1puP5xsOuSBbW13+cqZWPLh7qBCRlHT0AyqBLTRoVFehJXpwUcCE10y?=
 =?us-ascii?Q?NYoKw2ckRJXWHbBq5rgRj7Bxbhn+MxAgeEt31VpJji024nZRjn7YK/G4uCuV?=
 =?us-ascii?Q?JC4lo78HUbHNbbu1bkaymMJNjcZFLSLJKYRtgdSG1xWoCIkqOMuVzknWCni9?=
 =?us-ascii?Q?2UwV/Kl8x528cFB+YqlYPKUbv0p8Pt+goD4g3APjKlFBcgMqYgwN3d3Qctvc?=
 =?us-ascii?Q?Uc5je/G2xQopsjzVQVsQhFMFJHyHBQLtcZJcUFVzmg2clZD7Z+011MocCT1Z?=
 =?us-ascii?Q?Na26PEu/9NXzu4dQMizO4FVLJfy2tmVaQVLA94njYRQo7ff/Uunx+hdVnwAm?=
 =?us-ascii?Q?uX0e19ZGUx4yPKvH0zfH0eZyVCOVBP958w3378SqWO3ZB5mga0xy/K9lzb6d?=
 =?us-ascii?Q?1RNEgIItDrOhk5VVt9zPdYsaok9QfQCtwk8j+1VOb2FsKAacOathiQyRS3yZ?=
 =?us-ascii?Q?US3U1C7CGepQvuRpAaUyhuMioq/h/b45bA6Tk+ygjWFJZe9lCL/DWSngKx1A?=
 =?us-ascii?Q?RIFGiGfZ0ExD7zGNVKYja1VSxzW9l1OJHZitqoMFJbAJPhdvmqf9MBnRCkM0?=
 =?us-ascii?Q?vp4thR732NPxHnrC9h9pfcmHJvzZViSBA/IIh2FVl2ob8lkFbvHCTzlxG813?=
 =?us-ascii?Q?r+TBOcSucl3hJ5MBERFsV1M78g+r4+FT8H+qoClFiMbJ8ZRx+ndrukY5wHrk?=
 =?us-ascii?Q?djx8ui4MnF9S57R05QHVvOV8wXV6wnHoaqK8zPf01rFQrYRxcCae3zizCM4F?=
 =?us-ascii?Q?BVExOda6rKtL+AodQ8BD6wSo37bGMOcpsxtkMKrWPWLuqw1DIDE7cSvPyd1U?=
 =?us-ascii?Q?Aon6wtEZiojienJoUABVToSSRnm45gI6G+41pxP2CPXP22BgJMY1vF3yrs4o?=
 =?us-ascii?Q?KnO0I0rNR0nV72FoReDinlgROGsX/cutHiKvY5hcTTpUtAPHf7sN94Lw6doD?=
 =?us-ascii?Q?DqZnw/gefJt7X0irigo01I7wd6nzGoHiU0GBLIMxc1tkxDRN5gLB+ShyARE7?=
 =?us-ascii?Q?0IWs2HwHQdI1DP4KNyLxahyoAXEpVEyTdgdlf+wkSW5mFHf8z+J1MfQ8WXMr?=
 =?us-ascii?Q?o/RNzCKnFiRCHGwk99f6+F1yfkgi/tJkj3rfsgU2AVkShRzUmttboWUtzQQX?=
 =?us-ascii?Q?HIZfqQEATxReR4wV3pvV2dIyKpJGDJXonbJ0IjEQZC/JD2+tfQUszAYpxM6X?=
 =?us-ascii?Q?zCH2xXPzgib1fT5WIzyxhCqVSYJB8JXaDHYbiKep0wuzzqazK5RuA4cuJl71?=
 =?us-ascii?Q?ft16vldBDvvWHgQq/SbXwLQii3PR9LuhrPxEq9avIXoBhbHwsGCq1W9vBmZ9?=
 =?us-ascii?Q?omqeGGYdcWvuSkVJy2xh/XFJfkFeEogIDUHP35/dLMJGMJqd80WsklcK4e97?=
 =?us-ascii?Q?HIo23CaT6gZ+EwsKygWYOyJAJttq0Yeh354sO+9Ety1r5bxQFpESTYO/UV+f?=
 =?us-ascii?Q?4ACYxwVZzz95z/nczwpY79PlnLBNfRnH4bsjIwZCUHJo77WjLDwx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 178d52fc-5ee3-41a2-45ef-08df1d74cd5f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:26:00.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac2kp2yegfcFvbkBtXWrLy7M3r4Ny94tYfJEZMWP3ewAB8Du6YytBaXL9m75b/MWnQwuwXMF05UQrj8RCZpgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

Transport link cleanup can free an MW still used by RX DMA or its
completion path. QP-only cleanup retains the MW, but can restart RX
on ring slots whose old completion callbacks have not yet cleared
the headers.

Wait for rx_post_q to empty before resetting the QP. ntb_complete_rxc()
finishes its MW accesses before removing each entry under ntb_rx_q_lock,
so cleanup can free the MW without racing with these RX accesses.
Using dmaengine_terminate_sync() instead would not work with drivers
such as IOAT that lack the required ops. Cookie-based waits would
not work with DMA_COMPLETION_NO_ORDER either.

DMA teardown in ntb_transport_free_queue() is unchanged.

Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Reviewed-by tag. No code changes.

 drivers/ntb/ntb_transport.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9f71af97a8ef..8f1acf44bb53 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -950,6 +950,13 @@ static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
 		schedule_delayed_work(&qp->link_work, delay);
 }
 
+static bool ntb_transport_rx_idle(struct ntb_transport_qp *qp)
+{
+	guard(spinlock_irqsave)(&qp->ntb_rx_q_lock);
+
+	return list_empty(&qp->rx_post_q);
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -960,6 +967,17 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 	disable_delayed_work_sync(&qp->link_work);
 	ntb_transport_set_qp_active(qp, false);
 	tasklet_kill(&qp->rxc_db_work);
+	/*
+	 * Some DMA engines lack terminate/synchronize ops (e.g. IOAT), and
+	 * DMA_COMPLETION_NO_ORDER rules out cookie-based waits.
+	 *
+	 * Waiting for rx_post_q to empty suffices: ntb_complete_rxc() finishes
+	 * its MW accesses before removing each entry under ntb_rx_q_lock.
+	 * qp->active is false and rxc_db_work is stopped, so no new RX DMA
+	 * can be submitted.
+	 */
+	while (!ntb_transport_rx_idle(qp))
+		fsleep(1000);
 
 	ntb_qp_link_down_reset(qp);
 
-- 
2.51.0

