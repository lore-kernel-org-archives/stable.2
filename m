Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021136.outbound.protection.outlook.com [52.101.125.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F373E5EFD
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749847; cv=fail; b=lZzgZStmMlDtxqQhf6uFw1EOOEKuEpzWA1OwqPGrNapxISlZOdkopZrpN+0zpPYPgpJ4PbqH/NY3QObVuL2LMjaxc7O0ULVGZwCuYpG1pwGC34G9tlV6yozIfBbW8eFb50gZXTZg/MxYvdObNAB83Ck96M5IB14cfqvmrZZ4mjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749847; c=relaxed/simple;
	bh=UlslWTZz6MW+zz9jwUSp6Yq7TA9A2KnOBBYRkIqB964=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8CvS5bi7UcI1OUUpt/P41PeUGOSDERShwEvqnobQdB2C4gjFOpYM/X0IlyGKi2xZQVbR2qb3+oHOOQil9IOHFUt1UHnPVr+MwisLlkP6RG2tUmoYk59DC9Zoh/8mAwbYs1VNepwV1Dceb6e20WZYWtq3dlS073L2qXSiov1jAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BnY3mCgb; arc=fail smtp.client-ip=52.101.125.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BnY3mCgb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja1ikHCazhH4uu0PixVu2x4cBGJNwSlfG+wHmYKVWhHk7WqRaleO2uPMX+8wpj0+KiFOlWaBhlt7k0Fhod8mccQqem3SR5BtFVKxNkeDRHyozip/qwyeClsAcIeMxYfyG3Ep/Wr1ETqFtR78iCWMEVqj3SKY5k4zCNx1eTYqxSQKxVY1Tl3vL/owp4qJQxg3g47h0jzHNAP3SnK4oYBICV1d10BkAZl85gqPMxbU4IbfKGk6LCrdsBNgtPvyHoDHv3RIApG2xpPy8Cx6UJGGimxat69I5t7OxloqOb0ohyJUT/g67eu8sXVU9N04e4zjjk4oVAPvoSLVhyAYgDOGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbld7NAxvI8OyNSz+v4q5txpaPPzgCr2LLMK/sRjOow=;
 b=FcoEjGkCl5hkvrKPkKoESXVPjB1t7ydGRoHv3qvSxluy5E/K4qyo1Hvvl3Z2CQBBJtP5xx3QFyx/bF9cysK5n+E50/c1VSWN2PRJBQuyuDEWL3asaHmJyN9bR3N3yfk4WcTbUwIbNxdQUDHpBrsRyGnTa8kf636a3eBulXp2xLWCsh5x0hCPTa7hcIxlSuqB+98DaE17BlF/bhOFXFXEkIuMfbK934nsKt1MMpDs6jZqa+fOICwn6Ye8Ed+OLKck7ZrRK8jOVrtOEhimIU29urzKJAFQaxn9ZWAWrIq4mVEdGKlAM93CiYCC5htpD9UvETBdSfy9Rz55RV63rEqSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbld7NAxvI8OyNSz+v4q5txpaPPzgCr2LLMK/sRjOow=;
 b=BnY3mCgbNMg71j1ZNcCGZ68Vsyrq3AdirAa3aEBMc/2fxZibOyeSBffnE0X32IHneyL3wqHC6LHNphppHDFfF0/lm+AtEdrbj5q1P0Lz0CCQd0akPwWjaZqVga6z4IALP+yZB+cGUUNMKDj4B6Td/5eGFFmCDuzx4SfMr/4sdcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4137.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:57:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:57:17 +0000
From: Koichiro Den <den@valinux.co.jp>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 11:57:12 +0900
Message-ID: <20260907025712.468641-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026090340-monogamy-pancake-e076@gregkh>
References: <2026090340-monogamy-pancake-e076@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 039dc422-ba94-4fb3-0c9c-08df0c8bb9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ybcudCIjwj+StaDT8ZvUm4c98yUMPQFynP4SPiaNMvteJDOC5bxC0lQfZF3R/mhUWkEmtXCXhP5iDtctkOB0GbDtIwewjIc2tKVC+rEXxNvUOfct+gpaqhV1J4gZD1uO4uXDBjksyzOa5Qw3SI1qzYLUjgUneWByglPPTAN9cTptdBsUDFgx7erdqcO2mpuKFZEuU1QMzx2B0iP+tAqDEPZP8muT+FKaLBlAmKiwiMb8UzbhBqSosjp7VcReVtCdIyvEIXoBZ09+HJhDjCvda/oIDmliWfxRFakHrsGYoLJEOJbJ/lkb+m8jpMke0HPMh61uudvNg8VbnfaLSkbMRLSYcl/Tz4NtQwpWdykq5hCwILndfkFS4YdjGsOBWajBwBIexwihCljIbe6vaTK8cDUyPrIxa1KJWbQiJTfsx5xx+iKy/zNoV10CUWyNP8I4zKOqGfBrgHljJigilL/+4whivltj36pNMLK8PJe7q86xTmdA0XA5t/oCW02HjLy7EuNilmuRAoYQ1iEKCnSsSE+UB+BGYIb0zQS/fJSmsbhQnbHJ6InxrDEtw8Co+L02rv7feIekqJ8+U671ZvG0OCI8+4FGkE94XR1BNsctbRP0er+9snvHJTik4rX2RABk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uY3XmHMckSr4lr4LY54hBLWb1sBAN9iJ0yhR6KU8w1EFG05of0B0zUDLYt8P?=
 =?us-ascii?Q?Qm3kDOYMTCvmm83ZH+X4yYYywSJMBocl52/PJqPpYnxDYc59v5wUOka+iscR?=
 =?us-ascii?Q?uLO8wBEwR3rieSmdPo+jD65b5mDnRv+o5HQpH3s4Zwai0v7Yv/5O7qR5ggLq?=
 =?us-ascii?Q?XOy9R5BLIm0fysN5CwhvQEPUSVkMF9MI98w+LcwPfNV+viN1Pc2aUyOQGaep?=
 =?us-ascii?Q?vIueoKn4hxWSZZgKIkhJ3IRyT+9Who4GJZbhlS86VzolWz0/tICmPnMFoyMC?=
 =?us-ascii?Q?KOWqEhiCf5pllipK/LR4QoNSYRQ8/CYzdHjSVztS0aQRfptFszYZlwG3FILu?=
 =?us-ascii?Q?JPkR3VmmYle7ZCC0NdsyIxr+iSZ4pxOmutVPIDqmEZVEK/nS+n2BUT/WOkns?=
 =?us-ascii?Q?eW3kb5HXBAia0USG5sOGFiG27txLvzHtOw1jWUmSUmQuSU50tGsH3/d6cyxz?=
 =?us-ascii?Q?8Yp+G78gDL9vPH4mOFq6OcA1bbjKt40XT05UaKS3C+E/kILDvtPXgC/DOGyn?=
 =?us-ascii?Q?LuR0xdRyIUF/g7m4wIlV9RY7CPbjd2ZLPq3lZyQZmu9jka5xN3DkW6xE6U8a?=
 =?us-ascii?Q?ZAV3v49F8OTd1uTHMTrzn/Mplqsop/45wXRq8cy4lo23E3SpbFNn12bWWC2n?=
 =?us-ascii?Q?mfXDs5f79qlF8iABBZtTNeZuOPhAmPOwMp5La9mE/uM8Efr5g4JUbiWzJW5Y?=
 =?us-ascii?Q?yzRqRSC0Ojyv2insgad5Li6y1htNUpoWQGRm2I7mm0t4nYSNNTxhjVrMNglj?=
 =?us-ascii?Q?rJQumHCREpEeUk/mdhjfMJexq414njY54ZVGy2TYKf3QHsAd6MrthzG+LdMC?=
 =?us-ascii?Q?gUIcITeq8oAEHy9JKC+43aSA0myWzk/8oTQAR8XXeKqFLAYeH3/W4Kc5Hudg?=
 =?us-ascii?Q?IUbT8iU/tDXVQxmKKCuE7edoZUmcx1GEtmZXQyTaiMKXh5fZVtmZnyBlcNb2?=
 =?us-ascii?Q?n1Hkc9K6b4MBHkm2O2Tk3TBN/kJDlMj5Lvbl7NkDWYFIomjgKmpMfrjdev3t?=
 =?us-ascii?Q?++J+ohKR/7GRsorY72CnWLp/ohE8oRSGUsuGhI16aA0bN5y06heT1vf1b0Fj?=
 =?us-ascii?Q?XCnqYPo3jaO0CtQPdgNVpowQ6HjafOYe6sVhmeI3D0a8f4CS67q/YeKe+rk+?=
 =?us-ascii?Q?NUHoCE6Co7Nw9V6qIH5gYDJpZV1r3e6qj2NtymTLrvSl2T5viDfxVeLrPWE/?=
 =?us-ascii?Q?5uQDFU2nQAfX3ioGZ+UdHKcSQIvR3lIwGcU6NIclPNfkiEFvCup6vO6wHXBN?=
 =?us-ascii?Q?ApzOaxlTJGmgaBwImRgklTZWz2uh5v+ZjSxmDQPEDUhyyvsywXD0Emy7Eial?=
 =?us-ascii?Q?f9NL19EN7adp4XAMN+oS1ftcuUq494UbSLUOW4nfo+FR9Dk7oRUZp0BM+iBs?=
 =?us-ascii?Q?2/yhaP30noAQDtA4uBti0KeJxFeLvOXRVGKRuzDlIjxRPx2CzolKTri93DxO?=
 =?us-ascii?Q?TaRD+MmrmEP8vUQqB4OGpJjYsoraznOx+yHMVPY0PEWFNLPY3AdfOZNBYA0+?=
 =?us-ascii?Q?mWF/vD36xcPlnhEKYWVf7OtHbWIrQDk6N746CJoY8VyGg0ptGm6vaER4/mM0?=
 =?us-ascii?Q?hTgzYa3lVnQzNETBbv41xvahjieds+QAvo1quVSFgKlUb4fJjJo2N8i6gMr3?=
 =?us-ascii?Q?F6Fb1OYFXvgFanbY1o5/++o0aS45xNnISjEI65bt5NNESZyYN3kQuiI0H+Fu?=
 =?us-ascii?Q?fgCD4oPkEhV7RgsxImYsa4nOBW+ObDK6YgssxpPA00aY6e4DaGFoGsPlPwXs?=
 =?us-ascii?Q?dIR0raR8w0rkJb2sodJ9W0iVnh5/VqTHrbXPazWOnpQMmHv8sZ2g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 039dc422-ba94-4fb3-0c9c-08df0c8bb9de
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:57:17.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rYVUB6DcEOD3q/d+mfgidlFasvx0arCUyrFcisekq+W3FoPxMqqX/AkoE/CdT/Q1Z0FH0BYgzpDFHK4o1tJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4137

commit 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 upstream.

Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
also increments the drop and error counters while leaving the skb owned
by the qdisc, and may return BUSY with the subqueue still awake.
Retrying a permanent error cannot succeed either.

The unconditional BUSY return and premature accounting date back to the
initial driver. The error-path queue stop was later removed without
changing that return value. The current flow-control code includes a
resource check, but ntb_netdev does not honor its result before enqueue.

Honor the resource check before enqueue. For -EAGAIN and -EBUSY, stop
the subqueue, arm the existing reaper timer, and return BUSY without
touching the skb. For other errors, free the skb, increment tx_dropped,
and return NETDEV_TX_OK.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Fixes: d723485cb4ca ("ntb_netdev: remove tx timeout")
Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260817053519.4135287-3-den@valinux.co.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[den: adapt to the single-queue implementation, as 5.10.y lacks commit:
 ee970634c777 ("net: ntb_netdev: Introduce per-queue context")]
Stable-dep-of: 873ce713fef5 ("NTB: ntb_transport: Fail TX enqueue when the QP link is down")
Stable-dep-of: a4f2387db6f1 ("NTB: ntb_transport: Reject oversized TX buffers")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 7e562751d6dd..0ac87b69699b 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -167,8 +167,10 @@ static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
 static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
 				    struct ntb_transport_qp *qp, int size)
 {
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
+	if (netif_queue_stopped(ndev))
+		return -EBUSY;
+
+	if (ntb_transport_tx_free_entry(qp) >= size)
 		return 0;
 
 	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
@@ -211,21 +213,30 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop)))
+		return NETDEV_TX_BUSY;
 
 	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
-	if (rc)
-		goto err;
+	if (rc) {
+		if (rc == -EAGAIN || rc == -EBUSY) {
+			netif_stop_queue(ndev);
+			mod_timer(&dev->tx_timer,
+				  jiffies + usecs_to_jiffies(tx_time));
+			return NETDEV_TX_BUSY;
+		}
+
+		goto drop;
+	}
 
 	/* check for next submit */
 	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
 
 	return NETDEV_TX_OK;
 
-err:
+drop:
+	dev_kfree_skb_any(skb);
 	ndev->stats.tx_dropped++;
-	ndev->stats.tx_errors++;
-	return NETDEV_TX_BUSY;
+	return NETDEV_TX_OK;
 }
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
-- 
2.51.0

