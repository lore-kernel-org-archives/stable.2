Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021105.outbound.protection.outlook.com [40.107.74.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E460149C7B
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749940; cv=fail; b=ZgpNVjtuMa120SkAPKvYgEXmFAhfMgThZ9e60+wEQh6UIPwdNdy+rsU4fHGhneWADZ9fxlUhBKyAP8sOPf+KOJdKXTlAKo7ZyBtjXzLpZpBgdeANxQ0SwPYv9Bk2KOrbeZYb98dTR9kpakA6gaEF4czxBZlJ48dWdfOF5OI6Xo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749940; c=relaxed/simple;
	bh=h/0dYuKj+LEfy26HM8qnxQZ4TJ3ZTmnkdfZol+qm0sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAC/k11ZCEKsSPmVK8bQa5RVbPE7Ve0wpB2h8swdnsW6y5goFEq5WcgqkXGC8HEiFCVBCT+bZJ9AVpMs1O0Vsh2mTuBNfakd5x+rSIv7sreg5Bz8fnlWFwbAtv3Xez6LXQWl3iHeL9IA27thjTKAH+ZAX5J3pOjSeWircBUkbXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hy87LMmY; arc=fail smtp.client-ip=40.107.74.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hy87LMmY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJImrij7KeG8jOeMv+FQBgPtdKTp5zP10oRWLa9AmAyKNNilbXvaHM4qMB+5plQt+nKJAOec5npJNA0sfHwJKWTkcD37/wRatdPNu5psbt2elTnVTPNp53HOF1QQIOZyZ3yeQOVzEa81mk8EHK+K7ETdXdXkZUCFGOr1FF5njuVxevRwKXbSd6LDNz/etc0xPtFc0xcMqdK+BVbDAYKxYup8LR5HWvYlGS1Bfu5GoDzdI1pN0p8HkHmNpjWLb/3/FwBTsRtfuATYPsQgjHPuQrwH2f1QthMk/hH7A4OYgUG+hmtE8w4BEPOejaxmwksL7azDlrOTRSmCNXXx6OVRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDmFMeys9XcBCLwHybvVo6sNtE3nQsjVU351Y5aesKA=;
 b=v6EaAh0KkCVTZZLQPVi5HGIiEz+iqSr3LpjWrhbvIhY8q1XGXN0VkjMJmmDr1HVdaLYEsfHa3kEeNdwmFKFxf3NFiTZTAM4YdY6NAz+cu8sSTorvtj0KYA172yYLohOyYVdNFgAyw1iztDq7NDh19lhuJ9tdGRbHpNFSrEordZ4Tt2F1o53eg/J2iZkzpgE8AUDcR1J04R6n3DsdogsS60qYUY1f3V1sOGb+yFmgMNR/0htu2hKSbaqxKbXNeVUSAigw8OGp8ivirQ4Y+DTOwpjErNr7bH/NIL6nacwt6773vmC2rFkBEPw/+8ng82kvgqjHTThHRs7RNcL4GKc28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDmFMeys9XcBCLwHybvVo6sNtE3nQsjVU351Y5aesKA=;
 b=hy87LMmYfhgJJZj7AGEV1MCBaRJq7QNxOBG3FpoPsjNPCvLl2d936UNI3uLUrkHGI7d9EsiMSUlOXKmb/Rs0oTRnIFT05wPayA7Cz+P8gx5Yn/lAgI4mjDPufkJhojBhVuHiNgVxSFJ1vWMbirB9iJETjjSUpFzt23r/txXqYJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4137.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:58:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:58:55 +0000
From: Koichiro Den <den@valinux.co.jp>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 11:58:40 +0900
Message-ID: <20260907025840.469024-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026090339-existing-freedom-ef51@gregkh>
References: <2026090339-existing-freedom-ef51@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: f3371517-2503-4a80-400d-08df0c8bf4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XJHoSErDw4FY8MzVSjDp5icvEsFZRiRpcVMu/dEbk+wJpXA2oOJ4r5IOihFTtahW/1oRmuwngUNrD9/Tk5rLGzBlcr2YCh++1W5E19zXVPda2KBBmyL3H0mTSAQA0e9+mJF8F76Fqc4BKSUalA2/Hv2WGRxEKf9sw55miOvtVSALycHuK98YqOwbQNPNBSK3t2oHWVg0KCs4rJq81v6AVwrFAHfKnkrz5vRyNa13zErZHYtDn4lez0vzGTmsYzWfwbWOtF549KKPOm4Qh63CbhKplOM+9yKUYLz1UFbC6yRr01iQN/uTk4HliwEQ6NMl9uGBaz1jt0M+RMdtI9FQOzcX+k7XrpB4qk8r6IxXD4KsTTxhhJY289Wl8ZSAr4J6u8RvzIwdrJ07zevn4t4yFOnq1KeLYZ8sH3oWvJPZRWSkwyZChU7Nv6LjYv6SUnNqxAaqMsI0CsmP+0xJWrNlKfaTvIVnM3FEw1ZD/2mCt02Y8MJAufi7Ktx45faMTQph3yfKR8YTD5m3G1j1xIyZnRksrU8Di4wZs5R0zt42O5Dp+kbgbWdIFNIeyLJbO2MpLU9uOnHh0HsdlAioqOOkzx5E1qurQW7Po5A6JV6tR9uCfkpx/fT6+/62Li7UI2wj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+rkoRMxWbvd8HFR8/9hsyZtpM7ulDSr1dJQmm+BqbW4PCfosTRvUcQeMfJTi?=
 =?us-ascii?Q?dOHyZQHYsvoDaiv3xLZenecVA4Lo6F44DE5/3zUdBVMH1dCcJB/Eg8aCoXJS?=
 =?us-ascii?Q?pW7D/DfB5NM710+JeurwB50CALTVyq0b2tQNEtqJPfyfrY160cFss2ZKULq+?=
 =?us-ascii?Q?7tiNo1RKuVOT42HNuhYqwMIvoWsAflzutlomWwi4ww1gAI7hjU+ubkJapnYb?=
 =?us-ascii?Q?fwcw7++/Rf6laWefWtANw0BG9hy26MChGeDbHo6o/DbjzR2nwgYhXw+WXM8D?=
 =?us-ascii?Q?NheY1IvG2YUyu71QyIwB5LztRqHY7fTjyVTpEje0wrxMAViVSK64Cg+jht8l?=
 =?us-ascii?Q?N6+skzaeWVN+4HPa+BKBVQnli6bAfQiQpFCo02PnQISCxayV91+YdRAeDGTW?=
 =?us-ascii?Q?4IcdZWsmdoEINZcReOg/iIoyaQmB/Sf04U9MUqgkz7+s7B6euoDZ6v5+CktP?=
 =?us-ascii?Q?+mSlyh/2n2arGyKEi7FFPE9ae+L89eTqmR3mdQvfYXlGWMKFu8MHqJnBpuny?=
 =?us-ascii?Q?esVLFJsBUKH/7wuDfigpictaTigfVkaszGsSnT9Qnu1rdKr6ZscGgzYu01Zi?=
 =?us-ascii?Q?HoSkt9YG1YvxyexEtTsMw6dqvPgDJmVGNdFOHbyC72dHCsBHSbwlhnAN5Syn?=
 =?us-ascii?Q?Pelba1glqtyZxzpV3czWuAn7PiSPP342dgmRCheMgvkIOzme5xJHkYzPE0wi?=
 =?us-ascii?Q?HT3d+YLNy2MkLHFiWXnv2KhPYvuEXjtf6uwGD3NiH2piFT8p6zi81wZ9ScD8?=
 =?us-ascii?Q?M9eriAI54iLvZAYEtHUTKB5CJV22Nhe3CA9/akYXY7X+S4WyQ7xFzfHja4lt?=
 =?us-ascii?Q?uu2rH/Tdodazh7+J9nSMO5fB9ZCIgqCQ3uj2mqV6hZm4z0s9iv0l0JQXGDQ9?=
 =?us-ascii?Q?urmnQhklEENFFPKnZyNjJZ9+AqgI8M3P+vdB8pXkW1EsI0h2BJWGEFSLbwnx?=
 =?us-ascii?Q?CQ5AxO3pLyy4eFsdx8TiA7kRtHm+WaVGu3qN8K42OsGWFc/4PhPqnmH9PW9Y?=
 =?us-ascii?Q?bIrd3e8qrQtBdX59ThcIQfI8k1rNDufEv0WxxI46Vg+zzxQ5VIlMQokdrAHZ?=
 =?us-ascii?Q?JjlZxOjH+ZzdsU8oK2F9tNez51WYzcODiOCHQM2bcLIFkN2N/9JM+t5FEGQo?=
 =?us-ascii?Q?xUykwH3JJmoNlHObCZ+9ia/M2GxhDt8hJMy5sYbVFTfWhgKwoxsKkv8wcC5P?=
 =?us-ascii?Q?b/HUH5sfXEJJ8mGOLBCl1pHkCHi2NdN8A3+r/w2VvNwhT0My4U0BtxOLHfxs?=
 =?us-ascii?Q?p1cr4Jtwku9IVfDkgeY54gio2AV5Jy+jsmRJOWL+sT0NkQ9n0G93zBaXXMvb?=
 =?us-ascii?Q?8Fy6aIoqhtRmyJ2OxItisQxkAHm3PPUgVouCrhlRpcFmPslqmFU4z4TY9ckF?=
 =?us-ascii?Q?M/rgkB5s3y5YFQYImaWSduy5RGE1FcKquJbmcV3U8ym9AOZ7Jp3nh2fS3dQs?=
 =?us-ascii?Q?FScs/ZJubrZxu8oK1PVUV1H55ew6X6isGoXLxQdHvf0o9N/J2rcqvM0QjcsI?=
 =?us-ascii?Q?Q5hSJmd+DZ0t2M8Bl/Sji8Skl49/mKDwEmWoc1yOOXcGwLg/Vkx6dJmcocwU?=
 =?us-ascii?Q?njipdqbCbCP8TdswTyFXMebMg6+by5TWFuEyevAQYJrUa4S1KtmLAR0kcP3l?=
 =?us-ascii?Q?F13rhQKQJGp2JF0oy+vpr+X0yluZs5bKqJKrU6grBD/8QJwlUsC7m/v9tnwY?=
 =?us-ascii?Q?fWQvVwRQbWiRVChbjLohPzp73qlhedn23+NkEESlpPAA11KhGbDRPIPy/1up?=
 =?us-ascii?Q?ZL6x5bQ9pf5hn8OIu0kFX5cXImHVzlY5yNyqizx346cJiUIpGoyo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f3371517-2503-4a80-400d-08df0c8bf4b8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:58:55.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYYnPV2V0sbPXMgUxywe/N3VngRjwT+VxdsdcrksfMHJWqLhk1g6bj+RKBRLH6nSc9i7IfO+t+FIPMNhw/yPFw==
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
[den: adapt to the single-queue implementation, as 6.1.y lacks commit:
 ee970634c777 ("net: ntb_netdev: Introduce per-queue context")]
Stable-dep-of: 873ce713fef5 ("NTB: ntb_transport: Fail TX enqueue when the QP link is down")
Stable-dep-of: a4f2387db6f1 ("NTB: ntb_transport: Reject oversized TX buffers")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 95193a4ab091..9fe87efabd8e 100644
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

