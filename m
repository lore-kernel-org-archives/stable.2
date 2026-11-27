Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745160;
	b=Inr5d30qJkoXSgLmHOZ8n5UFbLk5Ujnew3ztZri8iLrOf2C5cNtVmniH/PdY53nMbycG
	 6+GWon3l0nq7B0dwmO4CT5oRQtVj7gNCLDVu2Vj69jGuBzL0f8aT7OsZM5KbVuU28XFG5
	 4htqohEHTt3tp5u1Kiejkzdfcbm48dCFdAnqqsK3G5/xqOYeshaY5IkhkoNXDeyAIgxlb
	 eIvAB7mfI5PYM8xGh1Fo9fMl/8Kw5px1zMZe/2t+ccV8+FJDoV6RD7YIdCss7eIE7Zkw+
	 KnVx3x8XBYvZqF/LTm48T/haSeS5CgIv5IF7AlNaxiyb1SJvVbGw6T2JW950yoeu5FQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745160;
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
	bh=phlIfoPPN9txlEfFp3ITU1aMV9AZcYulheAFMZ2lr9w=;
	b=xUIVZas7yG83+L3wz32o1iD2biqz5lPFUB6vSeDoevj088nO5deBsEZ6/pOtTNvZs/Pb
	 0eX8LJ0qxk8ClJdWJ9cLLxHnH/N3KCI9ZsVSXhZ3pS8hm4yptqzUr+UxCjPS+USxVw4Yb
	 BmIIQY791/OqtVKDDvY84b6yad8GqCB1zcps5dq1idezD9+CXdpO0vCsqp44Orz1erdF5
	 L4cdziypofevE70+2hPL5Vnnu5pBbFEIEu/E4Mprk0CNTF15AUc+6bS57GJcAFgP48sb+
	 krOZndybdJYqw0cOo+TmkUwLTzm0dmlUX4wpsOMcDSL4VaQwuPJZegowwm3PVRHhUaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=OaGfBfU8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12C606A33B;
	Fri, 27 Nov 2026 02:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C12C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=OaGfBfU8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj/N7fTiswlaZK9+cbKMRwRn+myaujybcXbOxxqy/zyHtj4YHb9ZdiTmJDicgKpfXN4fzsvfLKtFbyb3QO2lcrkhh3qClPqRo04WsSQC8SGRDmU0yPh9jv0IxK3TkL13A/sko8/j/8S9y9NkAGNPPQv4itvnJXK9Du5MGhKsM63kiZRLBn6EueVxIbqApGOvM+JY55PZpCfwSVkFqJDevf9zUPC35FxKeKvFstuAlsUtcO8P9vaTtHHYLdsE8//8WJEfjcPmA2Q0uiFNLasXk3YfmxO6Ra2nyuDynI/LBF7Z9IDsODwT+tKYKktMid93MrwvjJJofwZmml+N1MfIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phlIfoPPN9txlEfFp3ITU1aMV9AZcYulheAFMZ2lr9w=;
 b=Xcxb4ZCUgWh+gjAZv1RAECRMjy40qSeKKd9rU9EiqBCJ+VqV4YXkEFHd4TDJyie2gmfEB+0iKwpj5WY9SSr094XDy0aAtDn+U+p+b66yuqTv1KxoB9xmLJB5VZ/7ZzPG7xbC0IC944NL9HPyBH73HiIAaZy6HMEycaibqCUiBjdFCFLr2s49WV9e6k2tlgW6b4NzPR5XeJkPf7iJ2B+teDZ2Eg09zhgV4VF4oP9b7zcqjgHcrErowLTypWP03L5dIQBIQPWeIMv2DHN8XE7+0JvdlvjDyvFOIJqvlK2YJ9GqCf+VrqIVqJ2uUolvNGY7gEBmgGfXImJLRHdWyS29FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phlIfoPPN9txlEfFp3ITU1aMV9AZcYulheAFMZ2lr9w=;
 b=OaGfBfU8/ocDafoOK87uq4ctzn7TNwXew4txV2uhBO6hyaZwGWcq608Ku230GkirzVcQ5LMy/hxgoU/CHukCkZWeNRMVw2+yAoSKNagVqO0ITUS/ifjn4BiQ1RCCddRLBI+rXqt4woL6y0wcd0pdvY08LOPk4cYOthVrC5zQLkQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:57 +0000
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
Subject: [PATCH v4 11/15] NTB: ntb_transport: Wait for RX completions before resetting a QP
Date: Fri, 27 Nov 2026 11:05:29 +0900
Message-ID: <20261127020533.2481725-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 00adeed8-bc8b-4113-232b-08df4c2af9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eVGHvkKthxTxeqb3PeYfXOa32KgkfMgHbRIElnFuDGogvXJRWyA+Kj1vM9Ytk+0x33pgTqP7GZMH91H10YNo+ehf2QSnDNhHo32+x0HtMXfbZWG+Xggo0LVIjB3jc7TKDW1H1VK/HbtHiQGYiiCopy+JcLIzulXvZ7qll/7yDqwDHOeK0Bgir36NqU2fwPRIHFc5HZkMmP6Y6W0x7FdL3Db/cUZr8BtRK2Db2xTXoWHNlhV2Srl2zGM2C1kgvEFjv4DlRtCYDPKpPvwKIKlxr/FgMMB/ZItieDabY5WZ0updG+PI2R3XaqWi5mVDqiuUnVUX/PNnEbHxkfOFsiG8QoYgvyquxvBlPL5RssRiR89xkDMWmBvQLvqULrBsNi3F2vt4AVlv0Z3WNSbVRGczIPfAYEThriM/wnB/tgd9ATo+pvIlxNUCUPeMOB/kHPOD14aDnt3nqpEZsGgHvWrlcf0us/IpOH5cRV7qMvf6hMj6gPWjUylrd9MrH9dR50Zu7/n2H6Plpo5Z0DMlwS4NZj2B166HSGhTc2cM5JiTGJLkrbZv214pqdebdMNiC7+fpziCinV8E1PvPONrgtaCs4RxUKQDYQLTqgNa757dTko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSlo9eLuebeRuaA5QbazSOA65K2sCLTBFkW8c0mGhQNLENjIrtIUz+gAzuWt?=
 =?us-ascii?Q?zu3vsnCdk6zMBDgolE42xjQdF21LsLrTg1Z6uy0YwOxXZ/T88H7rTM07Pp7v?=
 =?us-ascii?Q?sOhr9/XPVvr14IZC+dM4Z/MViBQWlyBabHTJ90eSSCBOvMkeX0C3Di1Wngbs?=
 =?us-ascii?Q?6Ww21a0lwR9xW1W5fACoFQYcPRD+LmjT6eOZSFQxediJrOcxP+P9OgoH31o6?=
 =?us-ascii?Q?JHeTlVPJLmxzIrfxc9jw6d+8rbKsIZ1YSjyxm2hwQ3GVQ/Ikmu7pNwcrFT52?=
 =?us-ascii?Q?0aG6o70n7toAQAKFwF2H63vaqyW4FJTk0E6BtOzfhClnTxa0vqVLsFs5n9Xx?=
 =?us-ascii?Q?qGyESh0W5CUK4Np1SUWR3d1wW7W2q/3zBWfYIQcl6ZF8XXK1QRXSRyAhnwAe?=
 =?us-ascii?Q?5pxtCNQ48BCxHDTA2soSZ8IGN8dXi4M9F1Z0c3b6jv/v8G2kcWThF/X6p+nP?=
 =?us-ascii?Q?BE3uqHRHno4VIV6Q8BNcJ3MrUO4cXqlquhw897vvpMTU1JL3nm/K9knyz1X+?=
 =?us-ascii?Q?JHJ6F5Ok9rmhTiVchpC8HPqdss6t34adRJD4TVC2xtNw4WtkVpgzBMlTklha?=
 =?us-ascii?Q?7g+qbMxD7dugLsB6+nMLcgMpGSQPwAdfdKLZomV4mXIOyVpp/jLdtnGkQbTH?=
 =?us-ascii?Q?5B0XPrn9SlNQcBHFojFOeQ6U6k8Nx8INTJttz1yTFDXrS4NZLXgAJt8YBWip?=
 =?us-ascii?Q?j0b768Kz5YiAR3bK7SmvlYwNgPsp1DPslgyCtR8or8aHUHtXsj78EzwjL2M+?=
 =?us-ascii?Q?FL/VUaPiM7HP5CJwV2+yEI2Z3Vu7CEDaAxNw7GZw+HRhWlrACNfY8a38+23c?=
 =?us-ascii?Q?a/f8b+Ptxkwfp30UK8JUML+8ziGaIYFy4XIVZGP05wRWJR1K1FZZrYJCgfgZ?=
 =?us-ascii?Q?Au7KnN8HEeeMEbPwzcMLBmOSPwLPjc5UU9coTcVZle/gy5G//v3FwN2hUBJp?=
 =?us-ascii?Q?G31vXrq6bLwyOzsEWWO6NaHkWo4VG8D/JvV1Y8AW1gwXvEeZ5wvmdw4D//sd?=
 =?us-ascii?Q?RhSakyGTU4FqlRaptNQCX4bY4VtsQsXWnlg8imnmKxY89JBFsZkyApCXCsDs?=
 =?us-ascii?Q?tfxGdILRwkExYMooKdHDtumS8VoH+RMlOURXY/v7ydCzRoH+7eA9UPU/cUsx?=
 =?us-ascii?Q?gDPFK/LBKSmr/Zf+zhFc0e8ofSIxMyy9b++jsRQknR7/J1cw3Yaeu13UnYjf?=
 =?us-ascii?Q?Iff5lLHRnKGJiiRL1rlrUALlq5XHWj1gY28/YJQtF2HOYWXWSKh1uvD9tAx1?=
 =?us-ascii?Q?f8bEeM0pYTVCqo5aRIimjNLpbV5oUqG0DgGYgZvXjRWve2BUNlvl6EAXpYDf?=
 =?us-ascii?Q?a1zdOGMJBz01eh5sxFw7dP4gItRErHGGtg7QE8j9dsDGfBPOKXgYWsEWrhQe?=
 =?us-ascii?Q?wgApKZk0nu16TGig676QfgAqRvHldVA0m68ORhytPxTQRHbUD2929We3t1yF?=
 =?us-ascii?Q?OfrFT3HgiiLx0bEX6WpQQL3bhw28a7kUOdQt4VNFXytLxv7UUFCqFiCaDLoN?=
 =?us-ascii?Q?jWxe54IO69qcgWkJk7HgbGFynLf3mBI+ryfClU4TnIKV6vdsU1BIkS2LdO7D?=
 =?us-ascii?Q?1cz6onwILTkQcl2IiMak7xblD4yPEqztNZGsaw8NpkcyjLkDegUmyk1Yh4C8?=
 =?us-ascii?Q?yHn7y0su+RZ+iNMXKGT++b5kk2qWw+iT+nIkudwgToEdTSZ63p7OFedBRHPW?=
 =?us-ascii?Q?k/TTcMi2cErPteMQ0yJLGummckHcQf7Rv2g19B3P8VFCXr2bZXBgodYDRDpM?=
 =?us-ascii?Q?pxq3J8/LUkBMsgFBccQxZa7SOV/W1Z9z2h/5Whz3RTA11YB73q1Q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 00adeed8-bc8b-4113-232b-08df4c2af9f4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:57.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSVI+TDFvPnQllSsOLhiyx7he+S34/9Md44YZYERBkQKzPha5QZwG+pmjNNw3reriaXoyjZU6j9f2XBLLmKYQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

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
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 19a1975ff1b2..0c661558a5eb 100644
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
2.54.0

