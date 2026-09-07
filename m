Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325612B94
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749913; cv=fail; b=Hrcxp1gpxE/mYF8KwFLwLzS0Q0zFaa9KzCGy2ky4vIO83hwd6e+MKiIvIZiLsULxCVCXQ/pMTOUa/0jr3E6K/YOn7vDcXAWCCEK2XXFajLTRRFhwv2B+UtY8IenNorHTITImVPvxl/KQS97gXmSt/swWIZXo9qmdnn2vjtp3LBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749913; c=relaxed/simple;
	bh=+r43olIH0IOScMh+iKqkC0toECxwXgLKIRU9gKlgCNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=undyZnDcDFiSWff4XW6WFmP1DZbSoRHBHiFhykwg54xlOvCxpVILpNRXRLzfzjMCOjdBLMBN7CHlX9MqQYCWwlsrUdCH6OjiclT15fuPa8xfLxJPrvwiHrBNGRl+sKzbJFSNwvAGa91B9ITkw56SGYP8qSTZKkmVHQN9QlhcnLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sLrgxIk7; arc=fail smtp.client-ip=52.101.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sLrgxIk7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbmiE387mD0H4MrpQLpadtgZLRsvaVTH+IE8DdP/22Jfz0uyf+sUcOI4l8MFlqIhyiB1pWrw4UxgLecHEubEJ2Vx92LzdtHxeotJJ/2Ap7gXApsHsa/+TwfxHe0CFIW+mWHymfp2er8m3pejwgYQdY5wJFIQ7ISHdGDOPKQakd+3Dm+gi1f2mthvj5O2zhV7bygtIpFiV6RSr8V8OBajxOXOEATqaNyCOY3VAdjnHk9lEprIpAI1VzdGyEq7k6XtyjYCHRYbxJFVPav9b7ALBtI0/gCqzbuUVVMdFzqUsZPXpUkgOhXMe+ZaZukHKponMUWUsj8300cmXMCvu+hdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG+gAafaRMOW/EtSH/5YkN9sUUlcifQhbb79T6qG0d8=;
 b=zQkxFeb5Ipd97qigsF7mUGx/Ycjfx2AHEuEi26HrpaT5B+unUqin1+oos35B+Afxfg6mFE1u1iLvsLiieAUCI+OsKTrxdEO9f7GkPy2ZEqXqG7oLi9XnCaf/ZFSVZvfviiYPaLoTdDSZC+dhgHMN9NzkMiXDcPU+4yqBpyGcZWKLV/Egt6AjvyjmloncskRvOgUcvbzDW0PqZPtKvDjAxZxj0xpFzs9iqfaQEkSX32o6z0W61r/g5QUdLOoOPrheSDiALTG5+Pl6yQ9fyecpMrMi9IHib3fXWW3fTt0wBw9yjgOTo6IX1p8rBV/0g5jTabS22BW+lOGk1o2KZ/2sjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG+gAafaRMOW/EtSH/5YkN9sUUlcifQhbb79T6qG0d8=;
 b=sLrgxIk70SOUth4ox9NMMc7JAz++PX6bkde0gdvmm096UoxfUpvW2oPHPMdnSW8F8LsGmgagz5bk6NRbkL9ito4YtbAOe2LixnlZEHZvAZ9TTqMaNrTtpTTGLPPQKs04dZ3qFsrb3SdpJ4uP+8+WqAz2rfL3xbrXmCBEZjSH8iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4137.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:58:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:58:28 +0000
From: Koichiro Den <den@valinux.co.jp>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 11:58:26 +0900
Message-ID: <20260907025826.468978-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026090340-stereo-dexterous-e88b@gregkh>
References: <2026090340-stereo-dexterous-e88b@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: e8744afb-5f85-40a2-55b9-08df0c8be43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nO1MiVTOlIbd6fDMRO+t0WXkJ9S8lXzill2JocJS1zy2LOWxMrLWw0fLtxSovAISaOTuGHbg9AWRkMU8iQB67LrMehx7K2x1pfR4UShZG6dwrYLZQ2jKOrK7yCBYUatoP71b3FSRmyGj7tBYOImE2IuRnKimmS+5uhbb+u9it59xUhX1/nX2ofTGsRF+fKDgqh5yi4lq3BH2tbu7HGKvqvGqTYJSfYb96DRJxzIfeeiDMa03KPX++cJ7hne5xtRHaVqk6hf8vOLBXJZWIN6xlpS2v4aXE3oHxlvHAf+trWGpt9eb09o3KGRxXOIaoU9dDkdqj0sf5gOc5BPrzANE0o7UucjMlpSecJg0E+uFATsneKVWmU7mQADXfxnGueI7JwtcTYJVOEwRPIwgPlMbKtWqkSmf2KFhxhGgQQJaS9Dx16aTISZV7sg+52FaZC4mRbDc8q3A8LqoX+o+jq9l7FJ02meLk2QYmy8E1we4cx5I5VAI7GkrhLcBSnn7jYJJimHwkyR9r57rAMJzUPOJryFN+7HCWDduIrdQIcLRoPYTnGLONW8ELIvX0BONWVT8UyO6GQoCvA0PIAt/an0YWPCmYjcLap0gB7NOR82hxi/s+Iw2cGnNqMKu1forZh6y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rd1iJH9jy7QefwDFcngl2CsqGmElk47v2Q0O0dNqAcQZJdzjmYBpFfmjvXCx?=
 =?us-ascii?Q?uRlJvkET+QQuzQXcRScxev9kiUaQAjbd1YDpyMRI4qWouctKhjRHhfv/fXOW?=
 =?us-ascii?Q?XL8rmgeu+/40XGLpX58OAMX46udQVCYqfB/22odRLEY/9kNedxp8XmUg0Jg6?=
 =?us-ascii?Q?8DOdADmR7pRj5+qPrkHdy7Ad5WX61+Y0hU1rAen/Iy33qsAV0BNO4/+r9vTD?=
 =?us-ascii?Q?77JLUluR16hlQAE0tw+QMTv7YVMEJgNPF3yeWB8GAJfuPhbAG0t1ou6Sx78b?=
 =?us-ascii?Q?BWhoZwEXfWnmEzITcS2p+vIWHdiVpfmP/q9uYGI7f41DoHSGBzUVF7Vq+7av?=
 =?us-ascii?Q?zZUthIlipYlwJxpcXbpXZ+UdVXmpJFIVyJgnfWMxu+dXQVe+Fdiz6w8WGFrQ?=
 =?us-ascii?Q?CgnMT4hc5gtmYbRSEW3Nw2mPOUeaOO4IXpRLVWxjjHDQk2hOP4vMQ3LavqvO?=
 =?us-ascii?Q?2x/wLHEZgsBdLbL3SJUFkiXL3qYJ2lspPOuc5vxsuVACe+Q+I2J2gonFgJoZ?=
 =?us-ascii?Q?Ml21hMOwrX1BOpH0lEJ5xNsyjxDI67SCuy4AJPyzKvLj2xRb9jCENcbgJHpx?=
 =?us-ascii?Q?QJOGgFkCxHsBUZ0wYEAf+yExXbwtrLqI0FHtk94Jc7wQELGyoQYsPINRup/z?=
 =?us-ascii?Q?wnjgycQeTcjyPyFXweYE1+zeRLQKM3y4WverbHMpNvSFAWO0548RQwfUtdmK?=
 =?us-ascii?Q?HTncNXf1XQA2Ez9AlyLBSUHfCEx7mNVowCZGMxgTeUnMo4sUFv4Kc/yDjI2v?=
 =?us-ascii?Q?GjvwDZwjEPC2jyBCyFwxsspD4XT4M0NCJ73nPrCq+0ANTKUbcGPPpdg19Mnt?=
 =?us-ascii?Q?xvAyzzFPq6zIghAy5lmVnC7IlxlnFGMMg7gZK5jUbBFk1EAiarz6Q1aNBG/g?=
 =?us-ascii?Q?Fy9EPiohfGvI7BGFVvMFcdBgUkfUWYGyOhIKHct+MXIjUyHgEnkNnOJNH4jw?=
 =?us-ascii?Q?FizxBA7xCTWM7iulDuPovcNt2h3QUzn0JHgquJTTH4leVa6H6HlRRsyD9siX?=
 =?us-ascii?Q?Y5UPDYfXDTc8IBQ9zK2OfTD5U9dC4lbRVpik4zSKrMMBmxDTjzrTAklpoFbh?=
 =?us-ascii?Q?QlGMYXz3ywnfztSE/iHbWEqidliHoXmWGTNTqdfL/mZIXe4s89jqn9g8QG5n?=
 =?us-ascii?Q?E36T4l3K78sEG7/jb+f6fyT0+V3a0dhQwSKcq5rbKLY+h8iiDWFCiOi8Sb05?=
 =?us-ascii?Q?ytEzzoMIpiTXVzPtgULW81BxGawlhWxsKj3sAp88rqWOnRmVvHMc72Kd25ij?=
 =?us-ascii?Q?McbZ6UpIDz2UyX5zO/+zkpKi8EBDBRC/ZD1lDAYsedcqhmP087xa6nMtmbUJ?=
 =?us-ascii?Q?/9uHhtMb7nfIYFgC7teuOaaF57R/jgtcpMzZDWh7lwN21EHOdtoUKDFEwk9m?=
 =?us-ascii?Q?7B1UXU46NGQhhrPRzcvGdQKtYTEuZ3/DKR49zzcfD8/iSwfWexq4rvhLRsS+?=
 =?us-ascii?Q?40xpbT/aoJcOCNVqGoruuixw4gc9L9J3uyvANUygXL/jvkdwTkJ6cJ0iUHBb?=
 =?us-ascii?Q?4EWgOux0Ui2mKoflY5zTXqc9lt+bDCebbjkwPbcOfiTbYvtryPnCogT3ObLU?=
 =?us-ascii?Q?zz6e5yJLcaoPUbYULhRhvff458zq63j71G1q+Tq40+wuENmEySnxVHqDWokm?=
 =?us-ascii?Q?tk1GPlTzPeCkr6LQdOTJQo/C3nfb94ZxkvGhC46GNFPkTRSJvw0tFIEm3KVe?=
 =?us-ascii?Q?WACEvbnFBUWWKC34SBt3fh44wYn2lWzGG4RlkaCO1IErHdk5iJ5sIe2HTEkV?=
 =?us-ascii?Q?Hy9kv1i5C5849/OlGaQJWcSMSsDR1RYo94BtKKN6qEvRJX86NMM+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e8744afb-5f85-40a2-55b9-08df0c8be43f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:58:28.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C4MtJIqP+18lcz+iZuaQtUlyeeO87Nz3rywNvSdiqvyHkuDZ8cG7INiylnOCBySwOAdVTXNJdV/COwZUudYAQ==
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
[den: adapt to the single-queue implementation, as 5.15.y lacks commit:
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

