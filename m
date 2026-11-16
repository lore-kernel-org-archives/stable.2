Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794839882;
	b=E7Kp8dj+VZQBxH8x663hXNE/NbqkRWrU+8VIIPRNMLljKRqgkKacIjOXAgSpWag9Ek0d
	 iAwOIRu80EGfYJKhpmRAG04EupHGh8vd/CRSYhNqzDLnWglPdV25WQVovrPZtyXKYmDL1
	 hHoTA8Ko7ZiSxxav8EEnyfP9Hg9RbQXi8Vz97yPI7CwytrAioahnHaV8TXiHs/rAJvzfz
	 pnIR0/aj2MUqfgbt3/oqMk2MW6RWoxXG+kLi11cscqdR8lFFTksc3ylrNUOyacwszbK6D
	 agkREYOwIle3tjSIk3eBpNT3TrZMtERn+pX6DxM1D7LJZie+GFAOvyJSvLzdiVY2lwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839882;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vuk1puCfh89SptU8HhOSqcMBZKvfplDkfrccjLK4vio=;
	b=40VREou63Al4Pfm1A1YHwj07tOtQP3tQZDMR0GVOeg14z+6ATrA4s5ugw8m6MfLflKOc
	 jMhJDrrkw7AloVSKVRxsL7vVCQY6aYKIebRgSiaXUS3kJ8IThnNI/9ujbdvzYzNpKjUv8
	 uSoGcJt2oSt+eRs1u2wM8OAZvMoJUorbpHAlx6tcPtzvJ2rS7RGGt8OUqpyddNAAs/7DL
	 nYFL6qMAmiiagM4bSedi/BNTSmrCHe9aQOWZV4D5DfD+5jJRLBcqO3NNG6gJRFs1ZyYJ6
	 KLcA16/lwJNDWgEc+wNdFhPP/HWEna/sWi1AQK2ft1AI6OCAiRwoCL6fNevZbMD4TWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telcobridges.com;
	spf=pass smtp.mailfrom=telcobridges.com;
	dkim=pass header.d=telcobridges.com header.i=@telcobridges.com header.a=rsa-sha256 header.s=selector2 header.b=ntJUcxx1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.126
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022126.outbound.protection.outlook.com [40.107.193.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1B606A32C;
	Mon, 16 Nov 2026 14:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1B1B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=telcobridges.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telcobridges.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=telcobridges.com header.i=@telcobridges.com header.a=rsa-sha256 header.s=selector2 header.b=ntJUcxx1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKTWHRbWfV+bfYIdZJypgKskmm/IitT/7ZfL63GCfPQmULyg3fmdK5Gm5Leo3N0SPE8nCWS1TE/jOz1pClUmAj3RzK87YuUKj7M1xIeDgIVsnm3eKYCCJLFiVokle1VryyC7WX6RM2/JKM0dJdFaJxqvgAOGvXrKivOAH4CYl/3N8+5TNZ4rFxetnF0X6rmvg7mbFa8cl/NOhmC4UCqRp0sZPMrUw3TEYoWLgFx4DKQbRwt3H+zZD7qAZJErPoQqPB0tcq3meo94a0a7649W/eigULuqzwyOyky64GCrjQITzw3iBUR9/PvhOjfOkHa14B1mHh709NwDi3ugyJT0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuk1puCfh89SptU8HhOSqcMBZKvfplDkfrccjLK4vio=;
 b=r9rpkvLYmPjr1fXnNNJ4oaku64BNWsB8Oi5LrHLd4B29hwmzyQRdO9TQhgzcybiC0AGj4guT8e7kk9jDH99KYDHr2A1qPA6JDbP7fxyG7KcsH5q6gdiy6lWi7ZUWNNGAdJB3oX/08CV7sh5lLpE284+DqtgkzVetKSnfabkFypCB7pNFqO/37ycbEsZ2NPEdWquu9RS7vpue2yxzy5aQJNuZA5XaVC9VlaawEw4WJxkDxcCNrQZbt5cUpWQM5BtWokzc9zrtS5MD1yajYKoFEwA3/x9MVSEVxFCOoOMUWMsvp1o4ufNPmh92v8uTXIaFlMl5pJr308AUc4OyJDdzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 142.180.224.216) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=telcobridges.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=telcobridges.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telcobridges.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuk1puCfh89SptU8HhOSqcMBZKvfplDkfrccjLK4vio=;
 b=ntJUcxx1qZuq9KJRdf/1yqM77ThR7mFEpZCgk2NYx0v0PGYQz1fMuGTtsoFo87iQOe6eSxB1qqSMSZPBpuL8GT7C6jbtO7JOHsT9si+egMXx5aW/RHnUSJZ9QyIWYF5SbzW7erZcOLOI4l6qK8UeaZ5v99YpdQZjzI95dNh5nRI=
Received: from YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::8)
 by YT1PPF9A3978E32.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::56a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:37:54 +0000
Received: from TO1PEPF00005346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d:cafe::9) by YT1PR01CA0069.outlook.office365.com
 (2603:10b6:b01:2d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 14:37:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 142.180.224.216) smtp.mailfrom=telcobridges.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=telcobridges.com;
Received-SPF: Pass (protection.outlook.com: domain of telcobridges.com
 designates 142.180.224.216 as permitted sender)
 receiver=protection.outlook.com; client-ip=142.180.224.216;
 helo=srv-code1.telcobridges.lan; pr=C
Received: from srv-code1.telcobridges.lan (142.180.224.216) by
 TO1PEPF00005346.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server id 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 14:37:54
 +0000
Received: from srv-vmware-cmcburney-tbos10.telcobridges.lan (unknown [10.0.0.68])
	by srv-code1.telcobridges.lan (Postfix) with ESMTP id D58069628;
	Mon, 16 Nov 2026 09:37:53 -0500 (EST)
From: Curtis McBurney <cmcburney@telcobridges.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	willemb@google.com,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	Curtis McBurney <cmcburney@telcobridges.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: keep txq->trans_start on repeated netif_tx_stop_queue()
Date: Mon, 16 Nov 2026 09:37:15 -0500
Message-ID: <20261116143716.367451-2-cmcburney@telcobridges.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261116143716.367451-1-cmcburney@telcobridges.com>
References: <20261116143716.367451-1-cmcburney@telcobridges.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PEPF00005346:EE_|YT1PPF9A3978E32:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70ad27ac-73d6-4340-16a5-08df43ef330f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|30052699003|18002099003|22082099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	aFEOMxpMkgKI12EiV+meieFb5X7ODEZ6OfSKsyWH6hgL/y3yphMAXPw+gYTAKrmgTXzpDRx3tK2SKO66n01lWkCTra2SwuV8OTlm+3kGImDCxH4Zb0nHJOleMZhHxxwNRlvx8IHTrlUW7R2C5iLH8JCEPrf9hqt2T5yfCQLPxiJkOC+HkJxEqHNFPCr24dqkI7SE3JyN4E4sPaQaIF2VvTBcouy0d11xdrk7jErAip2OJNZL489xUM0RAFJMY3STFaqGnWoh6B6ZG4880OngFdoPZFkUypVH6cRwl6WSE2BPjmD+vECcl0hf7I/f86tWL0cvw3VdzfTMmdfp9osFYDuh9OfuMmcb4GgTEHRHqSPHMgKiJL6QV0LX3SInUChmKT+mb0I/VuTEfJt56/nXCLB55A8y6XXrA/5fjOxBujAfQw/JSBnMCaGxUZMX2Ip/GsXOaB2QER3WmkCmZckem0fdC8bqBc4DUyfC4WfllRkaDWUKD6NqXSqVs5PxWTAvQ2IQ07HettgldI9h1XFJQpExTi/TwHdzrfbJpTM7U3azSkjHJJlByW+knkP/oPr8b8zHgI3bSo96xE7fzEUBB40Mx5nIemhjrdpsM8jn6Y9NLEfqug/Eg4Lq3KA/pk+CphPicQoCcxKgGtEJKNsC/pVIri0LJcaFFEk7w1eanrxq8ul2vWOGxlg27laAzp7/ADEhRe6kceiTMOnOAYdmuA==
X-Forefront-Antispam-Report:
	CIP:142.180.224.216;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:srv-code1.telcobridges.lan;PTR:ipagstaticip-a30715f8-af06-ab92-2e59-6516aeac2c90.sdsl.bell.ca;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(30052699003)(18002099003)(22082099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CocSfodjecDD9MbGOaxlVqLgXaig1Y3Hie2YqPvCOj8QKC6/S9MGbCJuY+Xy9qxaEdXJbIYhCpHzsUe5TLLXMONk0hWlX6UAGFAZQXnVwyJLJ2BC6YQ6pwBhuNcdDon7FvzRYOKkUEt5YNLXfSsbO9Sq6dWViA+SDgb/BNeLZK65IZnoEcTqjFjm7MyaBp7wQuZTTP5HrLFWbIoRpWaEBeqeT8jZvDZFO2xpwca4WJWvSAymDLW+YL+ikuCez35d1QsLupRzL1odb3sJ6DTTj1j4c8w36AUoNmsoCRmM6dMnEhXwLxDB9U+aax/Cj/Fl6UrwCFnMfBaaGSOcBaE6m77UDOK7YOwObYKVvmFT6Lro8WneFIBpVrOBsHx1dlETI844pRdQCe+jliQVfYP+lW0TI8KS+BDc+uAacyBYGTIalrgiAClPnYLu7M92OT5Z
X-OriginatorOrg: telcobridges.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:37:54.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ad27ac-73d6-4340-16a5-08df43ef330f
X-MS-Exchange-CrossTenant-Id: 5dc833ed-bd96-4d5b-aaa0-0d8be83ae4e5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5dc833ed-bd96-4d5b-aaa0-0d8be83ae4e5;Ip=[142.180.224.216];Helo=[srv-code1.telcobridges.lan]
X-MS-Exchange-CrossTenant-AuthSource:
	TO1PEPF00005346.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF9A3978E32

Since commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()"), netif_tx_stop_queue() writes
txq->trans_start on every call, also when the queue is already stopped.

Several drivers stop the queue from their periodic Tx hang check and
leave the recovery to dev_watchdog(). e1000, e1000e, igb and igc call
netif_stop_queue() or netif_stop_subqueue() each time the hang check,
requested every 2 seconds by the driver watchdog, finds the hang again,
and do not wake the queue. Each call now moves trans_start forward, so
dev_watchdog() never sees the queue stopped for longer than
watchdog_timeo (5 seconds for these drivers). ndo_tx_timeout() is never
called and the adapter is never reset: the driver logs "Detected Tx Unit
Hang" every 2 seconds while the NIC stays hung.

Write trans_start only when the driver stops a queue that it had not
stopped yet, i.e. when __QUEUE_STATE_DRV_XOFF is clear. The write still
happens before set_bit(), which keeps the ordering against
dev_watchdog() added by 95ecba62e2fd. A queue stopped only by BQL
(__QUEUE_STATE_STACK_XOFF) still gets a new trans_start when the driver
stops it.

The test_bit() and set_bit() pair is not atomic. If
netif_tx_wake_queue() runs between the two, trans_start keeps the time
of the previous stop and dev_watchdog() measures from that earlier stop.
A timeout is then reported only if both stops together last longer than
watchdog_timeo.

The issue was observed on a system in real use: a hung NIC kept
reporting a Tx unit hang and was never reset. Code inspection then
pointed to 95ecba62e2fd.

I reproduced the issue and tested the fix on an AlmaLinux 10 kernel
(6.12.0-211.68.1.el10_2, which contains 95ecba62e2fd) with the e1000
driver on a VMware-emulated Intel 82545EM. Reproducing required
modifying the driver: a test-only module parameter makes
e1000_clean_tx_irq() report a Tx unit hang on every hang check of one
interface. netif_tx_stop_queue() is inlined into the driver, so the
patched variant was e1000 built out of tree against the 6.12 headers
with this change applied. With the fake hang held for 30 seconds:

  unpatched: 15 "Detected Tx Unit Hang", no NETDEV WATCHDOG,
             tx_timeout 0 -> 0
  patched:   first "NETDEV WATCHDOG ... timed out 5054 ms" 5 seconds
             after the first stop, followed by an adapter reset;
             tx_timeout 0 -> 5

This patch was not booted on the net tree. The KUnit tests added in the
next patch pass with this change and fail without it.

I wrote the fix. Claude Code (Anthropic) reviewed it, built the e1000
reproducer and wrote this changelog.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Curtis McBurney <cmcburney@telcobridges.com>
---
 include/linux/netdevice.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7e..6a488245db1e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3805,8 +3805,15 @@ static inline void netif_tx_wake_all_queues(struct net_device *dev)
 
 static __always_inline void netif_tx_stop_queue(struct netdev_queue *dev_queue)
 {
-	/* Paired with READ_ONCE() from dev_watchdog() */
-	WRITE_ONCE(dev_queue->trans_start, jiffies);
+	/* Only write trans_start on the initial state transition
+	 * (when the DRV_XOFF bit changes from 0 to 1).
+	 * This prevents recursive driver watchdog polls from continuously
+	 * resetting the timeout timeline and blinding dev_watchdog().
+	 *
+	 * Paired with READ_ONCE() from dev_watchdog()
+	 */
+	if (!test_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state))
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 
 	/* This barrier is paired with smp_mb() from dev_watchdog() */
 	smp_mb__before_atomic();

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.52.0

