Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1F4EC65E;
	Mon, 28 Sep 2026 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609177; cv=fail; b=pjswb04UB7eY2mRVATHligF7u3Ng4MLHpNkw75nL/U++o7D0drnYXSGBsS1xk0AzuSz9TW8IYroNNVfEJCdHWpQzSA0oFCvabrB6qEZn5vXdOA+PANXlBouwWJae4ugzDQaqfnI6QSy0cUZMsXciKzVODAmg0XZw++bipJS43TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609177; c=relaxed/simple;
	bh=AeqF24POGX3DDvii1Bz9VdM77KvvL4S69uxHwlwur+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqqnQ7aCmrWpVnBDKkMFby4kOc1lqm0nZEiGhnVVZEdDEvWhGco8OIQgRR+MlaDleGisF2gFSL0gUBcexntqDLa5fY+txWAG0LhycF3cXVssZNUSu/BeA2wfZCcjTzUZlC31w2/Ex27ihExgYOaHhf0wjFPKt+bUj0BMOsiVW8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=R3QTjt88; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="R3QTjt88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2jI2AAL1fy6Pc2jG1KWSGs5K/C4KJA4E7XQ5HdqFBs02OyIzDKDE3QzpHYN6m91dC3z5Znn09pWKA0vnemk1xnMenQpZhfuXx4+oAWhkKbKw8V+rsGZdvmE84malrt4X8Z17Fu1rYykAadOmFcu6QAso2IXs/OoUZvSCHIq9oJGjnJHHRUxoXyytjShSECQyNdq77ja2KdcbYvOE8Mk1sEW42h/JRaaOp0LDdgU7/Ox81PspvzqmAy84rfY/KNTfHOxNh7alwKP5ERy5gOSVIBH1wwRVK3GNWnPwP+fYMnRBjMMeu49sArGtEIdOtiX+dEHkZWZpMifxcDKg11Vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZN4sGJdYSGTeFSk1iSKijxMT3xexVqyP/D49KII/nI=;
 b=YdJLzGa+PC2/Da2KAX/pHhVREX/q7BhRdRVoifbHk1GSaowlikCNNeMJBgQL0W7ijzP3SVtsu9SEpyOxaEPkJvejnsxQQaZ/t4t/WjT5q3dReD15N63AMMagXyhTa1tad0zqX9Fqb75POQ92PM2L1ed3HIlm00W2HPENKi0UbnC/3Xd9segYOVkNTujWdjfLUY9xKTlevUHmZzDOW2k1WHQMLME+gazZiWYynwWfAN0HQkLcPrGohOyNF1YA/gpnytXvMNtDYFlLTqVLavxQL+CmxQR7op2FiudJpIIVYJBq7kg35zyetwIupDwNdZGQdrpLGizga8aOuXslr4H7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZN4sGJdYSGTeFSk1iSKijxMT3xexVqyP/D49KII/nI=;
 b=R3QTjt88oNZwMNQeSW2lpEEQuZbGdtTJLMrqgSjYas0hjmvUUJomiuGmu3NJpPjmUTg0jtgpNnjJBEfs19nmxraRonn1djNc6c48oLYsaH8UskR7p2FYoAVfAhpS6c7dZ185OhcNp4jnS4Y8zIi0NtecsL16FRNotV02IWErulE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:59 +0000
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
Subject: [PATCH v3 09/15] NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
Date: Tue, 29 Sep 2026 00:25:44 +0900
Message-ID: <20260928152550.3354675-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7c669a-3f4a-4e64-46b2-08df1d74cc78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kE0baiVh3UUFwn301AoL63K5ejtSoJ1ilJywDM9DHVVTLErPPQYB/vRfnwgwbH2QQYPuKB4uG622HhpQBCymETFTocgZypy+6M3ZdnBQMDV7tRiudiuVRFOo4h945Et9tz/Oy4Ut4LNIhflvCL5xfQlAHbzWq4LzzmQA5lVszh34LqvlXTVNFcxtLsQdSXepvkb1DAVEx0TuakDOU5AN3xfE8NuiNzz953TSMZ4CAsaH4OsgJ7CpgmTPCynQ1/P1Fxv3UpG1MQuiktToIK14Y8lOuYPECIhngHsxphgJTb8qwf7iM8NpQfvVAb6TWI87Mpz0pgH9NT0TmQ2P3CvkUV3JlDznNxETdqBhuzLVrWYXqxCvgTHAC8VPvIKbYizuTIfkOXEDQ9z0VmMiVhsK5MuPlbGNVVvQRTnpb/08wo96NekdlJ6NmNqbwGJJ9vmt/QDvDcblq7CkCx7rChfQ6qmApf7CKqVA06AKCW448Wolo9pLKrH9kWtZKdnN2BKEUHjp02+WN7geuoyl8uhoE3hhzgI3jtBkjvZ3v5f2WHvkcSIPMClGuUM+3lLxriOmXCxxLZtPnnYKOVrOpCFMoMojJma0XWB7s1BXUk9bu7+7lfccrvupvttN2Zwx9yV1GFz/6tGbB1F+i+XU4socOJiMgmaXexWJ71WgFAFUGq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LzfzPVl8U0LTs3Rg5pBivDt9fYTNQV+Fii8j7Jaalu/aH48yDjMSlGzzLQsC?=
 =?us-ascii?Q?m497kkwEmiO2ahZsp+Iv9JGdIPnbfhHDn3NNnJXdhLMrINTvCYJwLaNdN0s1?=
 =?us-ascii?Q?DnCcANppTATUdkLC+zVS9hA30fleDIZZFuirsPxaBee43muPuGqtVZlm1MFs?=
 =?us-ascii?Q?WAPOPISRIKBcKbufliWKMPFxv6H7xZPCBeb7GEW/JmFUHlWK/28nRR/FUCSF?=
 =?us-ascii?Q?tDZjj813rderDsXUKsunqj8xsxd23Qb4MLWnOGTWP5xmXFVLS8MUaLNsJSgI?=
 =?us-ascii?Q?ldvc7FAtwuZQNGHmp6waRinu/1yngg3mUhrfLymsxJ0yHnUa/KIbJ+5n3Pmk?=
 =?us-ascii?Q?/NpMCzYkO7OXGIGwzeK6U1pcl1DMvz2nWohHSel5JOasYCecJ0luwLFUwmFW?=
 =?us-ascii?Q?EFG41M0CtD+XirvbKWsP3MkU3LyjMxfnPX/UdboxsOMhuKbGB/6FCMAixx7j?=
 =?us-ascii?Q?xvNN3PMWNi/jNijAnQbxVW7a+Tg4GrkUmfx9vHS9y93l2JObpP9n2RFOfWCy?=
 =?us-ascii?Q?8GrL9G8CPf9T7iMU0NdauRVlKac3e+ReY7hM91Y/2Y1euhvutkcRrUJSIAbG?=
 =?us-ascii?Q?cIC8/hByBg5UAzZaJTz7nJV0+vEBzaQSI5ziPYWlmfPG2QI+TjLqx/gCLZ1g?=
 =?us-ascii?Q?gMOkoHWmHXPv1Ww6e7w8NpdrNMxb0470L8pWVCdcVJZqvLePhlb5Lga5N1sD?=
 =?us-ascii?Q?8+3tnKtWgjzt1yIOaSC8gK2Gqq625dBkNGhk1H0ZzDt1xT1VI4oVhyulW2ID?=
 =?us-ascii?Q?TuXos5Cep+DXCBWHU2n/6bxCEOg03BVDqafbDKEjPooOFwHj+aYchKvJKxvZ?=
 =?us-ascii?Q?sQ3keMw6fBU8qvlk+rIV0jJ50sD3pHuwGN1EdHvvwtMOMaTEmttNWap6P3Lj?=
 =?us-ascii?Q?aUWIdj4iTv59ODXxAwRwy5oPRQS6AY0fp/KqO2QdhTNUpSuhFrExj/KFjwy2?=
 =?us-ascii?Q?tOAn39RxCxWaCVDGpBP+Hdijr+zjO5sA1LVsnG3deTbuzcJgba0NDfMqNLYk?=
 =?us-ascii?Q?030EPiAwImVJQ7IAi+iKmEV9LZfoLdqZmFa5F18d59uQeSmplrDqpaN21OZ7?=
 =?us-ascii?Q?zOglrGeI8LdBWhCZ69R3o8X7DG05HxX17qsOZD5owK1Dj6ayzE2beODPaSJO?=
 =?us-ascii?Q?PisBdGiNh1ZuDvss2DkHkaZHavjaRchTpPor3Bbufguc947E++NFbIemnQTa?=
 =?us-ascii?Q?LkoNARyex6XWNUuGpgJdggV7X1m47nUAlIRfpN5JRbJx1b8kxY4Etl59tIlf?=
 =?us-ascii?Q?5KB0VCR8pK/7Q/R/7dwpWDK+0MhqPEBI0dOhsJzj6/Od0WTtuC6UddxWBdjF?=
 =?us-ascii?Q?yxFRRaNXH/wgO5+GvcBVBlithwewD3iGZlT7lvSYBMA9D3fvv9kD09AR9nG4?=
 =?us-ascii?Q?YUL787g1eDCXOf2C6ZR1Hsx91aUScT/EeaCSqJ8xuCIpXd1WHpQXbyoR22Cs?=
 =?us-ascii?Q?HdW5vBjAhUKadv+Z+Hycg0k6i5IaPLsiu+Lk5Jush+gkou6kmCpK5T9my7kB?=
 =?us-ascii?Q?+pkuBPpiAgL5pjruAC+LteuwLNqTzNuw3ph4lyFT7LINGjwMgaa/yY5D8rS6?=
 =?us-ascii?Q?zEDgitlzHlVnWNaGlSdO7ATr2Xz1CCRGi2W8KDquYJhih2Ud8Y2Vrs+RXEYG?=
 =?us-ascii?Q?al+YNgOVhI+O9RTReIQnp9qTtFHrY+yv22mC53VyTGoNRfFsYlvF78yw9HQy?=
 =?us-ascii?Q?ofwpZiZ+uYuPIefKnP1GHdYErAgDAM2+xSiu4lsWuiFokGEdTofN2QeCEZpZ?=
 =?us-ascii?Q?J32OWnGoNJ1H1paMGcO1wjy1xhmfR3bBbEvEFigMsEpRFAKJ0WnD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7c669a-3f4a-4e64-46b2-08df1d74cc78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:59.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhwJejzlNtPrfFLbmp4HpZ/6OhxSBpZiJ3CwHMaSPTAs5spCTdVSicltJdnVxy0sxw9lzXyFwI1unoTMgZQXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

A caller can read qp->active before teardown clears it, then schedule
the RX tasklet after tasklet_kill() returns. The MSI handler does not
check active at all. Teardown also releases DMA channels before
draining the tasklet.

Protect active updates and the check-and-schedule sequence with
rx_sched_lock, including the MSI path. Clear active under the lock,
then drain the tasklet before releasing DMA channels or queue entries.
QP link work is already disabled, so it cannot reactivate RX. Use a
separate lock to avoid contention with RX list operations.

Fixes: e902133162af ("ntb: stop tasklet from spinning forever during shutdown.")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Reviewed-by tag. No code changes.

 drivers/ntb/ntb_transport.c | 50 +++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 556e1d255284..30411e118a7e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -180,6 +180,8 @@ struct ntb_transport_qp {
 	unsigned int rx_max_frame;
 	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
+	/* Protect active and RX tasklet scheduling. */
+	spinlock_t rx_sched_lock;
 	struct tasklet_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
@@ -650,11 +652,26 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static void ntb_transport_set_qp_active(struct ntb_transport_qp *qp, bool active)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	qp->active = active;
+}
+
+static void ntb_transport_schedule_rxc(struct ntb_transport_qp *qp)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+}
+
 static irqreturn_t ntb_transport_isr(int irq, void *dev)
 {
 	struct ntb_transport_qp *qp = dev;
 
-	tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return IRQ_HANDLED;
 }
@@ -896,7 +913,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
 
 	qp->tx_index = 0;
 	qp->rx_index = 0;
@@ -1156,13 +1173,12 @@ static void ntb_qp_link_work(struct work_struct *work)
 	if (val & BIT(qp->qp_num)) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
-		qp->active = true;
+		ntb_transport_set_qp_active(qp, true);
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else {
 		ntb_transport_schedule_qp_link(qp,
 					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1190,6 +1206,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	atomic_set(&qp->client_ready, false);
 	qp->event_handler = NULL;
+	spin_lock_init(&qp->rx_sched_lock);
 	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
@@ -1726,8 +1743,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
@@ -1738,8 +1754,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 		 * ntb_process_rxc and clearing the doorbell bit:
 		 * there might be some more work to do.
 		 */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	}
 }
 
@@ -2206,7 +2221,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	disable_work_sync(&qp->link_cleanup);
 	disable_delayed_work_sync(&qp->link_work);
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
+
+	qp_bit = BIT_ULL(qp->qp_num);
+	ntb_db_set_mask(qp->ndev, qp_bit);
+	tasklet_kill(&qp->rxc_db_work);
 
 	if (qp->tx_offload_thread) {
 		kthread_stop(qp->tx_offload_thread);
@@ -2248,11 +2267,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		dma_release_channel(chan);
 	}
 
-	qp_bit = BIT_ULL(qp->qp_num);
-
-	ntb_db_set_mask(qp->ndev, qp_bit);
-	tasklet_kill(&qp->rxc_db_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
@@ -2347,8 +2361,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return 0;
 }
@@ -2545,8 +2558,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp_num = __ffs(db_bits);
 		qp = &nt->qp_vec[qp_num];
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 
 		db_bits &= ~BIT_ULL(qp_num);
 	}
-- 
2.51.0

