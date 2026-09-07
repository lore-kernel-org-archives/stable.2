Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355536B920
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749981; cv=fail; b=op8jUkXS85WlYpV+MDxhYpdQr0wP8ZPUqLCOu5ZiwlK2xyo2xUCb5bKaMl2dg32cyJDnKSEYY1KyP5XwBlX06U+SSqWSmaZ+ldu04w8axLLESQShWHXLAGNe+jP/bFtV5tNByGh+lyxl32BHP8Sk04XgocN7SlRX4mSDCTZRcAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749981; c=relaxed/simple;
	bh=I2BLvGFqhrDYi82GetN2BYAGqzjh8xTkruAEYeP+PN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nwJa1cVEw26iVL730YYzZXip+6/j+9MyfYIxNaEz1PJbMteZTjoaKPl4xiS3mU2UK7WlQcWR+damTAKLYbNjrHe+3e1HpzPS/7lSZL/UN6jWEdq0369YBtkRjzirP4iTxN7/xF4o+8eeMz5JlDG2/b8376Zpog6V3S7DLZuLNJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=N/adVtjB; arc=fail smtp.client-ip=52.101.228.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="N/adVtjB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqWgAjKWaAmI/zdyC+m4QXIWp4EKcJi5OBFdTXVo4E+METn+vX2b6pNZ2vl9HfWwiU1z4hzXr3wKrPHTJeyLCWbGzYGJ1HdDOMl+rsnNBFaqImudD2MiLvpGpQ6SlHsP+5KMy8FbLkK9ANHildoBw0t4T8HBRzowBpKnt7mwf+O61jDeNxqpSC95z7jVvuqJqAl9OgYEAoyTSk+Y6J24N2R31Y5P/RKJ0ju2/LGfv2RMu26zi+oLoRfRYJHI69AEc7ibKA5/7Ajf5Ai260zFCh36au3UdObfQSfVOLPhQ/yqaclCQ07cBk1d3IIYC47cS53ZRRUM5PKoaZFu79wrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P85o3972CSeH3PEdVJF2V4LEQuCASQMS/9VnRw60B+8=;
 b=d6hFSc/7RfDtl6O0IX/1AycY7MmOuFCVTAuc3vg8Lk/64vm4kP5Kp0jHOWo6DqZz01iFosaFhAQtdoh+roz/4BGxtTlbc5vENdto3QXTEzRu64ezQYsPmgE1Vd7Eq8afMVbwsvcdY+SBHBWuT1GNRy1Bx7FJR8yP6Jla/1+L0MHYdx6cB4IrP2DcJRGiKnzYW+MULTXorShQMdyhcCnkPHJCZsXUZoI3fg0t+Nu2acLo1Xtuhh//g8HJ5i28v1XZJRCTmFAo4KWeEcJap+suPAXpIdU8JGYmFm7Hh3bQ2ENnMAsjgiZMZIGjTHIflitrchHKMbkQ3Vtw6HIrXeNUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P85o3972CSeH3PEdVJF2V4LEQuCASQMS/9VnRw60B+8=;
 b=N/adVtjBS1SjPq1ZM9S4rxp68XQXV6hxjNcDWWyVTIMEcl//JGfED/8Vs8BDOEc6CfsXsdd8VaaoYZ7UcjOdhBiPjl2ulfxGYd95TuBPiY/AcL+4ug8KLptc054Dr9AyYH1fqLWjMPR351hgO11VvlnRGoow62s3HH2SqowvoX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4137.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:59:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:59:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 11:59:29 +0900
Message-ID: <20260907025929.469386-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026090338-handiness-send-b02b@gregkh>
References: <2026090338-handiness-send-b02b@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c49d02a-265e-4c78-3fdd-08df0c8c0ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	od6oDD2DpeM8xI+CX04timAQZx9s69X+0MpzcsNBfGpSI0S4sYLiwS8xpo6L5sn9eZdZb11P9HwkgOywyJblepo7vIzBczJXNyXPbRK7Sz9S+FMFrkCFrVCR8DstM61i8ZORDMWcNAwQm9s7yt19JC3bZAEiArKfUvDcnYHR6yWXK+BCfwi/Jbr3Wx4jr3FCBDPrGZQoIfzogiCDNe+TsSZHH3ZwTv9vtuIVw9tMW8/HxfYHK5HEKpvx4OIvFTtz/2Tx997cDnkEGhjldE9SX5WWNimaScpA8TPeQlAp4AQfZfB/rjHepGpu8TXmLtnPZjJLqty9MTEhHFGLLUZSLCp2izPrO+4x1AlRbgTW3YNyPp0Ddmgmvicz9is2SBwHnR3uAwIJTlrC1TRz7imMggD0s2PhgmHi1+0pfJPwy/SUmDCNqNLbsO8UvTr/Ed1DvzrL9hdzpCkBBEe6UzGv+3rAbBwxeP6h7edO5IBN36nmkuDOIZM4gbhvRifXBumPjympDmLQXA7iZOI/wykHV1CAWeDuW7I+a1DFO6NLUaETgNLBqYI/mmllgVSdfztniWsQ/NT/L5FOuyEF3l5QCtbW50XAmxKMU24FA6kcGnM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FV7yeXSrgD0nL463Er5lFwPlLjb5udyidyaqPxiR8VhOZj0Jc4a1MUXNPpT?=
 =?us-ascii?Q?fPGgvdXeVVwWVug/BRpaKi2chDd6ykUaR/sn2CDREpHzknI5fVoL/tBpaW1F?=
 =?us-ascii?Q?ZccgdqPSV2x1//W6mhtQA5hnEzr+L3X13z7Y/gpzbb8PUv5UWTWFt6GBLoQ5?=
 =?us-ascii?Q?1O4rk6KdrVvXVA8lrCjNLlw8SHG/jObCbeY2/rSmBrgOQYZVp2YLT3tK1YqZ?=
 =?us-ascii?Q?Bl5MsdCv/OOtAFFikqiI+7Hy5L9qngzeM1lUWswH/3xCeoaaOIQemzhSs+N4?=
 =?us-ascii?Q?unXlm58LanlW6rQ+e9mAe+V+7ShhQQZoV73hy7r7K/qvvFgCRuIhFDqOQ7SX?=
 =?us-ascii?Q?zGcvB+PsrZmddAmZ10u5wCqRswm7+YUEwGbwO1as1Cpgfr9vHEj/qNIgZ3wr?=
 =?us-ascii?Q?knd0sDh+T3Tb2ULwCe/9Qrp00NAmu3danXnI0Afbzdkrv8NlOXkmfebm/vzD?=
 =?us-ascii?Q?HAEAZrplmU9TKYxUdcPTnfRFZCrxsNFcRZZ5iPP1oYnyA6gCdO6uYadcGYrz?=
 =?us-ascii?Q?qGByVbrl0lb+fG55zp48p4oPh19ob5hMQqAQB7h5mwT6yRPFMk0RZlrFUW1u?=
 =?us-ascii?Q?oHWWojsM7rlWmvgT5EubrvpTOR+YMln+DMAXQj22IGmF6ywxI4rSbJXiqctO?=
 =?us-ascii?Q?goblK+r8OFVDoIpTnGhZ0ZAAJAVy3dNfhbBBX+tKhpxuH4uyL8KfyCawf/cb?=
 =?us-ascii?Q?6yeuS6kp/GjtFvqG0c6Gmlf6k506dYUcLgk3VEsMQpH8DD2X0RFAjubO2+iD?=
 =?us-ascii?Q?XyTXyLH6yJQlmzWmCbPkySzoAyOSeKRUR8YkRWkJYxvJ/ALW7m2n6xv4GAze?=
 =?us-ascii?Q?PEjozuqnhyx2dPF3cSLa+oC7jm4reFoMsXXFheO+4SYiieh00TKUyG33iJFg?=
 =?us-ascii?Q?O8prXAnqGWNC5gj2LucPa+Gc67H5DbSxHtBHq/tURnDyzLQ8EGhAeLGh7xkZ?=
 =?us-ascii?Q?6qb8oOxV0IfMYJfUl+JSfMbd9Li4g4HBsXPYXB05Ktkg6WlaVhDctRByQIDB?=
 =?us-ascii?Q?XCmUPyB5UDzYXwtBOzblD1CHPyKCDKx+9C+jOdGhprBdiBTqZAuzdx5fg/6a?=
 =?us-ascii?Q?tpmM8e04Vq6qFyfx9uITD4vqmzwLg6OPDrnAnkLKaMfkA6AG9HJNvLS/ERJS?=
 =?us-ascii?Q?UfOHwf0RLUmMtsCN1nbDsJO5T/Xupg00c+eR+tmRTlG1xJG5msdHTu3JZtKS?=
 =?us-ascii?Q?HndfLXjNY+J2B/ySg51iecrRWcej/igJpMvnet9WtzuTiZymKn4qDEbFEl/l?=
 =?us-ascii?Q?PtSt/DEtZvtEG+4EW2in/HYhI3YO+YDnKw5P0rmtbmn8DKYDXti288o/OZ7/?=
 =?us-ascii?Q?pBjKxGKBClu43TcaXmwsBFJ5ok+az7daGmgI/Mq+4DpZk3jN1iGjndei0CFx?=
 =?us-ascii?Q?zjlc/T/m1PELYnUpX/xYfHTBhoUSHMqVteB98bu3edHtjhGhJIysCMfbmHY4?=
 =?us-ascii?Q?DZSlZ1SuY5dLK8OqFyI1PIompYQT0ybIZ7Yn8qM4mxPQ9ibC0tV9S24/xxc3?=
 =?us-ascii?Q?j+kW+JPGQvArKm2tZXHsO3IAC8zod3kPuGSUeTSsI5yx8Xd1VJFHMcuhOzHB?=
 =?us-ascii?Q?xQ8EmLs3/S18iYkhvVID7TWP3RaIMeLn478yJV9liysGsqOa47zx53XAx9ni?=
 =?us-ascii?Q?n/pydyUj6Be1lLUxtr0J/xlkndg91dFfoW9PYUm47HA6ifD+QjN9Yny5ruR3?=
 =?us-ascii?Q?/t6HahZHpHFBjPNhD7COhuYVLk/FSOAYqXEfGl/YrZ1EURTBvTmh22V2blti?=
 =?us-ascii?Q?OCPMnMddHI0SVSaxEG6dmtZBqqNp52bHGOrhzX78dHwWBcgxkw7w?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c49d02a-265e-4c78-3fdd-08df0c8c0ba0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:59:34.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d3wZpBlcrwdv7QCf4TBlSP7I0INT6I5hnmp2PFSPoLsxJN4ek7JnPz6ar93cQETnkgZaCSi8DIOJs+4Ad4gZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4137

[ Upstream commit 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 ]

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
[den: adapt to the single-queue implementation, as 6.12.y lacks commit:
 ee970634c777 ("net: ntb_netdev: Introduce per-queue context")]
Stable-dep-of: 873ce713fef5 ("NTB: ntb_transport: Fail TX enqueue when the QP link is down")
Stable-dep-of: a4f2387db6f1 ("NTB: ntb_transport: Reject oversized TX buffers")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 05bd6ad9c88f..86f6c17f911e 100644
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

