Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020116.outbound.protection.outlook.com [52.101.229.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566072D0C89
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749952; cv=fail; b=H5VOXk/b2ErLvHQk4sTzJIJYau3h3DmxZ7eETnkZf2azDPDJIE9pBRkwZdu6Jh1oI7bXD1BtkLN8xUJs3elpIzTxt/WFquLTrvTyBq0JYP6NnUjo4B38rXwMMGSf7ldoowSiDOr/egk7MzAqS3A45K3MFCk64S/u12UNWChHFSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749952; c=relaxed/simple;
	bh=ok3xLZzvb/vfAytaGM5UCDYay6hVYN46hM1pN201j4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RGbtDuLa5sFFSfFHZ4n12Qrd9Xj90aTc2UsafBFqTDssGZhzTIs1E4p0Qa7kJXY+cmBFUmWcbFTE5m48a5Tum4zWnp/j5Ke8o7/vtjdQ9PkHmQ53tpODD2JffWeq1vSACnTOPIW9ESMYajWuwobunTXdB/t/pA8e4npHJs9gg3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AQxlGmIa; arc=fail smtp.client-ip=52.101.229.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AQxlGmIa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+g0fFBpfSSUuoGSXhvxhvypXCRv83RKdykyi8i2KcNM6mMOqGKIANx17V53Ey1mJStd02VWGLM4oIDF3NTPns3jqUM9Li8WR4ZumK8ZNNpgcdy3OzXWxy2HdEpKknakp5qxywm2f5TTOuxRsaphwtWI9/LQnq5VuCA6p+LOywRyu/T8XpavkKkHyljTQ6Mu1T25YtnC61dsAgMxBNMjKx4RoyTyyqAwMK1nw1fH5NEzprmPCxro6Da3xstzxGXpiY6A+KWw8hNEI1n61J7CLQmktozHJR+SoDPtwsl9I9XiCE4dAJx38s87mXRi4u3spZHX5X8L6WZJtzkV0uFvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr/m8feanmfp9RXSAGCcV5OhdtijsfV6nlVAPupZCtQ=;
 b=X+9ApKIqbzRdiU/erqV1wZ4EiZfsGLI6lO+F3yUIF/RQTiUb8S8QpkortpLJBJWyKCRghnlz2oGzwGs95Ths44ToPbuWyYdWmFOWmujbEXkjgjDtlUqwsVYQ77f5xkYQNwpcnmGPBaPS6DN+FT52HTrRSR0eZQ5nXuX6qkYNjGlhg7gr0q8OuRy1upQCs5UkEwKe8+5KC+OpFTEBb+c52CX0xYCs9mJPxFxlJYcLOeV4VVcVHl2TVJtLb4pa1o+0GINGC1BVUC7uWOi/qDlKREHJxnRENLYk1K4IB1UhiRmrmEDuNJb6LQixVMMLerteeEWUK7LrQwS50znyaQY7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr/m8feanmfp9RXSAGCcV5OhdtijsfV6nlVAPupZCtQ=;
 b=AQxlGmIauS9AuZNKa8O/FjFt5r1xrRbFWqnJhWzO0FThbpkOVd7GAXljS2JEWvokJZeWNKX0vsEJjw7EJlZ2J87VvBhTpbZyJrmXJb7tP9d90t7sda4K+3t5wBx295FeIu7yQXXsPrWYw+Nua1q3lf29zFmQPCR45ZT84eD78MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4137.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:59:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:59:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 11:59:04 +0900
Message-ID: <20260907025904.469166-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026090339-subsonic-book-dd53@gregkh>
References: <2026090339-subsonic-book-dd53@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 648de22e-761c-4d6b-1130-08df0c8bfbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qPBfhpL+ZR+wXAVacSMHnQOAzXrtVKmYCM2iPMEywaQkkIyG9WcC3CUKSinFsEk+qcrq+p/ieJZsPenM6Z+Cmv+yLFOHTW4iBVrg+E7K97FrlgaCSa633/af7kPH6h35i8kLiBNiU3LVQj7bqtk9KwjddozTz0WNFU99RUxgHt3LB3/Xq+Op9ua0r88wSKJuCWUEoClTWUGUbqNdkYzZIoNJlK5CU1kyePEYsF8qBr4nN/S2sOAxrt50HS4heyuSRkliwKmrs/ihfX89ZJyAPdhHMiwDY0FQJ4kSFOxAREf3S72rH/I8eP2m0p8Ac2zrguqI2IOp9rivNzZ8BVmKXmowAuMEqoZelSJWzhvcv+5z7QcBcbFn21g5rCU3Q+K6mm5OguzmvEZl/Q3t2CKNCPL3debcfVZRkEDBUxn8LLCxVK8HJhQIFKhHrVU4lZiMblRo6thLqOH9qX5tiKmRoeX54NSJezYQVXaxablb1xwsfLbXYwOhbEUzlZQQ5ZUYmmBz7sk5vsoF/2sNUsP7c6edOoOfau/uxULU5PzBi3B6K/tzlc55BgAiVhNJbfuos2fh+Ix+oZsMi1yjScmtUQj4S4hXkvDRVajX5WzWWRt0rHtzUiws0huNj3yI6Obj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VWHnvzRSyPlgKbleGqT+cBGTjVne3CkLE6dNL0mxIy7JHDSuCv5h7rjWHTW/?=
 =?us-ascii?Q?tTA9n/m914Qjfwvo1O8fcAJH1aJ9x8+RAnUl5MAPPpSIanGDSONG21BVqYz9?=
 =?us-ascii?Q?Cml46szo/wfNKZEpNUJS2zYR4pfgjoI+bY8PcglvRDdnONhrdsMg+Rlhsxvw?=
 =?us-ascii?Q?pKimbTqmj3yE3YtBJcaoatdINHtNMaPZM7AgTqhUjzQwbDxHAGKMODGu4Jks?=
 =?us-ascii?Q?1DgCpg0SGIYqB22LlxrYyQ9P+1D+iG+i9Eu1yXUh8OSQKFkbOq/dKineqoBo?=
 =?us-ascii?Q?w+OoQe9AVZ01SbTDo/BVmB6vKcF8ZnvPTIeheUQfIXy2jCjo5CLw4WowK8Lo?=
 =?us-ascii?Q?k/slgCqdPvKf0e+fw1Ml/IJRwoKdGgtvafdUyROjcEwg9btftTSrvSXYBPbs?=
 =?us-ascii?Q?g6/JlBaD0MMXpfaRNFgnyCFPuXUFv54nuT890gH/JRX456vxa5AiQfk+AWNC?=
 =?us-ascii?Q?e78/cirltb/7v3TXv7qWrORtRN+J9d9n75VTW7jIM+tvMvVSV2tUYdfPddWu?=
 =?us-ascii?Q?YRDaBlQIE9dsEma0iomoUAqKqn2QQ58OgcRgRe2/hm3UaFH07ejAZ+0WUvUW?=
 =?us-ascii?Q?GsTy0epACLhCvJp1N295Kb/OkfQfKuJCq7WyYTzO1j347qiMeBGjJuuW12ml?=
 =?us-ascii?Q?rbcQbWfUh5B1zt67/RmfvOVOuZpf0UW9FsBTgj0e12uzluxsI3BKPh4cl9Z9?=
 =?us-ascii?Q?kUsPiKn92HveFvOYRCVA0Ejnh7gmLqbcGhhRjEVNAXxeM2lQMnssqGBuy/zy?=
 =?us-ascii?Q?dHzkG8RGp1K7sEeiP4xU4h3Sdl7uKcbGU1XraY7kv3Ys8cfvv1dmiKVttHLo?=
 =?us-ascii?Q?Oye2tBpdXT1ny3RvMiHtX72AU98rpmifPO0AjnAEDreWcKfAxT+rky/8Ai0b?=
 =?us-ascii?Q?0G18PlvPHJO8T4vVHnL1Xy7m1RsTmRDcSyNLpOMHps5GL47wepB/FpQIWgzx?=
 =?us-ascii?Q?LuuUsMXBmIGsBAIyqHt81FmpTiT+0jp8eNUKY66zWA2sdAbLVrIjjB5JE7qz?=
 =?us-ascii?Q?pwFNO+l0fup7EDNlbBflVY8wqRa6Rn/oc0fzuufgcNriN6KQhQQclYPiVbVO?=
 =?us-ascii?Q?qMNbVBUj3HfcWVpxb/p5Jkw2JITiiysH4dO2auc9Aed24CYj06iQYF+7Q9IB?=
 =?us-ascii?Q?/c/Q4Yp8adNlibFgu3G2AjWeYcluo+g+3O902aNdp2mOURyxGKNbGADBElUZ?=
 =?us-ascii?Q?+TwkwJBjSIdeou0hlgbuBtOCIgOaJ8AqdhqCb9H6gG8rro0HVV2EeBJDx/2e?=
 =?us-ascii?Q?XZh0NRR4fFQeuUXjjRToSD/Y3kncEexJVnS5TytaO6XRqHMn7HpNNKlfcSkN?=
 =?us-ascii?Q?fa9NSMblBkfHEEwTpaA9ffrIlBpFQf6HKv+tYFyLju44TJIM47DcvpJC2IaE?=
 =?us-ascii?Q?xGwTOjUSVvfPj1NQQ1zqI2vkpyJF2pMfS9TXF/7uG/wcrZ1fJd9oi5Y4b6Bf?=
 =?us-ascii?Q?c6A7f+GaEPxKVvvHWreTAXO1tfMCL1raG8S4YRsJdflzLXyXEU2+Z3jmTtM6?=
 =?us-ascii?Q?B0mkXejuGsT+o8RKtAYNMZT2RORI5VRK/EiwwWdpPjBjP9HA6G0BgswH32PK?=
 =?us-ascii?Q?x4kPs/6viCS7jmOs4KLN80FVAzw2Dz6pkkuxUwWM8rJ7qPkuxvlUjTFlebhN?=
 =?us-ascii?Q?HR5W1HDO017mWZQPPK3nUBBOX7YwCmAi8CfFrEKUe3VGQiSjNUIAwDfoPTAZ?=
 =?us-ascii?Q?h5MV5JwyKk66/Vdb3Gfcwtj0NAFHbq0qOiSX/9N/8S2SemmRn0s4xsWU5ThC?=
 =?us-ascii?Q?LnBNVI01VaFh2t8ux+TK8vAruC8gysUmJtSRu2ZSekcC3wV/rOLu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 648de22e-761c-4d6b-1130-08df0c8bfbf3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:59:07.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o9aH8YWVOImKwHHBILS1i4grqygykL0yE3Qr1RWoIOkWX99tCPrYFUWbjbdY1boSHjUC3jk8kL21dQnDGVWLA==
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
[den: adapt to the single-queue implementation, as 6.6.y lacks commit:
 ee970634c777 ("net: ntb_netdev: Introduce per-queue context")]
Stable-dep-of: 873ce713fef5 ("NTB: ntb_transport: Fail TX enqueue when the QP link is down")
Stable-dep-of: a4f2387db6f1 ("NTB: ntb_transport: Reject oversized TX buffers")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 554ec6e54440..234a9e0579f8 100644
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

