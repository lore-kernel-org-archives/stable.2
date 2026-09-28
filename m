Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591674E9C15;
	Mon, 28 Sep 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609168; cv=fail; b=BcJH9XX3kN9NqZyDkYjzvsHeAmE9D/jmXPE8pyVvqCzI7gd7nR7+IoAVYa+/+4V3lRMtJvgyWfjIt5UYJuID+NrDBzeXmP1CjGid3gRniS79Ph/NnU7rnW73j58ZP5Y++1H6e6Q+BrigNvR2VK3rR1svNYx25RKncIJri/JNXr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609168; c=relaxed/simple;
	bh=b0aOuSSzPodiZOHcWx7n00Yip3uqaXpXvZiEnQstRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEkxstOptIB2F+zK/H/efGZOTxIVFhwR6ZdRx+sTBZELKHFACJo2dLQpdV0taIoj0dYPnRxJf5YcoTpBB//XmgX23pQ8vuysskeVACuCS9CffovkAKjVBTPrIOIGb5A+nEN6r7tAUihXpxGbF3BLUf6HxyPhv7kFoDMYrVOkHMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IKzUAyhE; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IKzUAyhE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB3arRjCj/2BLQRwphhaXRwhIzZ8WrK8wyCYsmEWmE/GBIc7NnVomv4QLKCXJMQzW0i1NRXHAzPyyOH/lFszToiadVb/wsLcwnjuO+VNwNjju+QyquwwdRB92uXCLCU8wh3PgGiVblrK/PF+bHxRzaW1Q1UiLEXkv+qm7rFBr9M4BflR1b0V/YWpN0Avmy9cHPT2cQa3IK7EBBKik2Bf34nNsfx6CPyTDPlWI14N5HLbLhb5tH3QilUi1RnfLw0bprLjI6tydXa9dmaeRbGFZBrg0nY1UIU/94kcXaQfSbsPrWC7b1CcccOv6LJnQVWX4kEqvCy+dOk+6ZNE8Y6rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIV9TOaeezJAWYMo6PpA1mIMshLQTwndoRtce3ikVDE=;
 b=WSJ4Ercbqnqn1WSNRCA4WsCWFSekA8Ku56rFcNZbFe8QYFbsE8uU5tyOK6ZGRTYkX+0KwFQ+D4z+RsJ9tYBPKdI6a6CTomN2K0GmcWB1NTa0Gvris0KgA6FPJXd2PrqHnWZdskxRDloLaAjo1Srmz3k0+wTGyaebY5t/ROvM8HgCXiteA/Nffd/FCiuxCeg3aNnu+TL3nny6VKQPy0U9VcNDy4zJuedzhGLye1qHuyD5LRNfKI7d2zu7bhV6lqbrJSmzVOgaFk7H5vjPOZCssMqa+vrtEmuQX4A9f/MQ39k0Z6zdVgsXmjV89Zd+nF4wkWhyHGC034FfNzQlpZCp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIV9TOaeezJAWYMo6PpA1mIMshLQTwndoRtce3ikVDE=;
 b=IKzUAyhEeeick+XKY+HP1yaoxseoWPYayFUFr13pOeXx/0bLRYcaCghWW7OBuHjds2rxAx8wgRORrHgqYvacyTvhuuP/GZkAnLcCyP+6BGvsTiAwiIrFB48WRrFZvGHuHTLpELf3ehzO4CD7zeHyxIO/D5pzwbmjXysZL90Qk6I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:54 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:54 +0000
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
Subject: [PATCH v3 03/15] NTB: ntb_transport: Make link setup flags atomic
Date: Tue, 29 Sep 2026 00:25:38 +0900
Message-ID: <20260928152550.3354675-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b355f4b-68bb-43bf-b3cb-08df1d74c9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EhObC8jrBumvGC/VriQNo2ue6gQ5rF/VctnArXHsSynAyiIDqBWLnePadk/uagPjE5A68p1ErZwAP5SqiormQoNQfUbpDRuJ0FxlDtgtXDbHHMo/0k3lGYpHL5x4s8wdyg+eR5BCtRVI6GP0IRbpCUEbIqkj1RTJgpzvLS8R6TssRzTMQNdrwr7TsC/23sHVJZ52ECuMhANl59DdiPOmHgrsDT+Y0An4IlATjmaeb2mADlzswNLoLRgxtGmdLW4o1vEs/hbxIuLoUKbRZ4igeYnfurGdXHgCb/jTJchbc7SwW5xwEAqgXW+RwyV26vLjN8M9dawUGnrOUzCGQjWRoLBV4JCdbSIOa5hgdbyeky4hcoMbtVLwIYX8VDa/gRdHYYOx4JR7pBhW7kFk3Dx4lyFxFO1aXgOwWEKAlNbKu/NffwJlx8hKZ+QbCCm6Uin/qfmgH0FMl6Rj/a+WhnlG6ey2jMJ1Vjh7D8tRV2GpOdTjXQPzfwwA7fId1fJLWv8iPG15EV2NrF4F6qgV6DpmWOCyYVEV1xJspyNgeKlcqtnxmVVU6gNeaLx0a1C9pUYPB1Z4YguqVhhNYPd6ZmctjsBZ5lZmxwyzuEAc2tm0snC2aNSKNsDz5P+N03dT8oTu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPfViPUpOrsXP/3uegseSCNZOz2tqXDhBY5Qt0BF4xg3w6cv0iEiN80WOQPl?=
 =?us-ascii?Q?jWMh60QtnrfYkOpofAYDWuqLVXKdsBvEUfN14KBPJc1uzAnR9madnEbu0xY0?=
 =?us-ascii?Q?7O9qDOP8gCM0gbu4vu/ZjWKLk/8J7WUfDjFFxM8mMljjp0y4qjiAlxUyBC8O?=
 =?us-ascii?Q?Uhx9lk+4rArH5EAxWWTtHQj7qNAZgiH2bP4YZh888Kw172cjzslpCyTai3eX?=
 =?us-ascii?Q?BHgG1o+wiNIRdGnG9UYBVaRwXUn/c62724qSGa2sZ5eowTFH+KumOJ22IZZh?=
 =?us-ascii?Q?hwkWrKlikhm2hNmK1yLky+Qasax2CAljyMMd67iL56ngTW0gQizHlZK0XYRg?=
 =?us-ascii?Q?3zSPSXw/JfDy9+LXOQMrOkV7t8j1pMjJkaNJSWuxeyU+orlHru0EIyLJAIbX?=
 =?us-ascii?Q?e2Y0FQSh9hc1rFcwE4HQhyJKRXyvYnBDU2b25XvylyPR8eb9/69A95PaiKrR?=
 =?us-ascii?Q?2lViONFCX8g0l4/C5X4raVzWfjgUeujJD9mnLWwn/iP16At51e9epYb6RsEp?=
 =?us-ascii?Q?0GG0WeZgCN9XoqZxLNlovCrDoMBv+S8jXbyEWTrbU2O2w2prRS+8dursrdeC?=
 =?us-ascii?Q?DgHQJNRPaAEMBQhB2YB8xHouyS+VMoxBTwen/0K4dMou+oWu108s22SSEm1L?=
 =?us-ascii?Q?xh4/m8N2IMsGz2cMgS6jiOozn+5CkWthr7yGs7W+LAkYqdxUyz8My7Mou4z1?=
 =?us-ascii?Q?xGiZYcCnhAEDwcuZygbU9HJ2AcW/wa7+Kc83LRn9cGw6DMC941Hhrr2u7BDA?=
 =?us-ascii?Q?Ngc6yLdGnSPfqVBZ79EhK81pcSsfAmbCiWf+ChQTXEDYSePC0EZO2JfCQdV8?=
 =?us-ascii?Q?n23fswriGSg2p5BjH7ZcrOUDi6ulAAYJ5DrbJ0U8cBXd161wLAkR8DppiMkC?=
 =?us-ascii?Q?fMmbwJ8C77mNO5RLbqOIGZRbaKSbLRMtgZVh/uMi3/HzmWQ3OvsDmhyZdBRh?=
 =?us-ascii?Q?QqtBI+UhmGnzpwvQtIJQUDEHD+C+kYMgw4ZCw23DzPfuoDcXrlBhBoSR8Zjc?=
 =?us-ascii?Q?xe/HQ0ln9fWPf5z+VOKjfk43svjOO0J9qt/xyW6D/imlLi2T1HvB7ZsxEY5r?=
 =?us-ascii?Q?HqsZa5Qq6YiNCQ9VAJn0Jy8JiTIwNQ06WfWr0W8k6+Yw8Ra8teToB2DHhwQx?=
 =?us-ascii?Q?dRzzhm7kCJa0ZsFlVO7HcJT6N2/b6jI2iEl6Sfo81KvEWquOzn5FMlPE81CU?=
 =?us-ascii?Q?wOYFcJuDEvIl+mXsbwvLBS9473K5L4M2duDxOqTg8LTqz2B0ZFdxV/SzswWP?=
 =?us-ascii?Q?IlupWCsa+ZQ9zZdWvSkKbKYO+2I6oMPT7gmVq53nof8SAQBZ54/u21Cv6g/1?=
 =?us-ascii?Q?aXBxMe9PtbT90t8WVHyirCMj952tsuozLBvX2ueC2no2Hgt69kowKMWVcLH5?=
 =?us-ascii?Q?lJ2yW+hPW2KYAnhxKKeCo5eDPdxZCxWJVY0BCMduW4pN7yDq/pQzxjnoxaUh?=
 =?us-ascii?Q?SvZUwN2g4ir3dJt5kT2RAADiRtyfUhQjRFo8TZSb13Yy7tpxPWjzcl/iLZJ7?=
 =?us-ascii?Q?8J5eNc0ecTUf1mWi+DxfYZf0ygWAc85eWY3bWIGy1kD0XhvHaXldzb5+LbgQ?=
 =?us-ascii?Q?yKA63Ls/O62bn59xGAlNS2Fg4C44kyYyXq8Zo9lN+Mwb7kN2pcqudL4dxcBb?=
 =?us-ascii?Q?p5Lvkr+Qlgw3MX8J0iHi+GA4afKLllSX5P1aZ1croqEKrU8aO/mwaw47xQsC?=
 =?us-ascii?Q?63vYFPe2jk9650w/Xj2HihLs83ylYAjBFhuotLzQXZs/l1jhLFa91R1BfmMI?=
 =?us-ascii?Q?W5Jx72v2L0m/BPa/9dcYHXn8/rYcKr5DFlbeVwpE+zG7p4CmlRXu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b355f4b-68bb-43bf-b3cb-08df1d74c9a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:54.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0QYyn02UbTEem7OYBsDxkE0qlTlfKRyjZvsBsgkZYNW39xbQtt3KFcvqnIvdRYgwBpCc0UO8hY+o497Zf2cBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

Convert nt->link_is_up and qp->client_ready to atomic_t and use atomic
accessors throughout. This prepares for the unlocked cleanup check and
the link-up ordering fixes that follow.

Leave control flow and locking unchanged.

Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch. (Frank)
    https://lore.kernel.org/r/i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5/

 drivers/ntb/ntb_transport.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 55a20ae9a85e..5d2ec484c3df 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -47,6 +47,7 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+#include <linux/atomic.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -142,7 +143,7 @@ struct ntb_transport_qp {
 	struct dma_chan *tx_dma_chan;
 	struct dma_chan *rx_dma_chan;
 
-	bool client_ready;
+	atomic_t client_ready;
 	bool link_is_up;
 	bool active;
 
@@ -249,7 +250,7 @@ struct ntb_transport_ctx {
 	unsigned int msi_spad_offset;
 	u64 msi_db_mask;
 
-	bool link_is_up;
+	atomic_t link_is_up;
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
 
@@ -945,7 +946,7 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 
 	ntb_qp_link_cleanup(qp);
 
-	if (nt->link_is_up)
+	if (atomic_read(&nt->link_is_up))
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
@@ -972,7 +973,7 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 			cancel_delayed_work_sync(&qp->link_work);
 		}
 
-	if (!nt->link_is_up)
+	if (!atomic_read(&nt->link_is_up))
 		cancel_delayed_work_sync(&nt->link_work);
 
 	for (i = 0; i < nt->mw_count; i++)
@@ -1084,7 +1085,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	nt->link_is_up = true;
+	atomic_set(&nt->link_is_up, true);
 
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
@@ -1092,7 +1093,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 		ntb_transport_setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
 
-		if (qp->client_ready)
+		if (atomic_read(&qp->client_ready))
 			schedule_delayed_work(&qp->link_work, 0);
 	}
 
@@ -1121,7 +1122,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
-	WARN_ON(!nt->link_is_up);
+	WARN_ON(!atomic_read(&nt->link_is_up));
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
@@ -1141,7 +1142,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
-	} else if (nt->link_is_up)
+	} else if (atomic_read(&nt->link_is_up))
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
@@ -1165,7 +1166,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->qp_num = qp_num;
 	qp->transport = nt;
 	qp->ndev = nt->ndev;
-	qp->client_ready = false;
+	atomic_set(&qp->client_ready, false);
 	qp->event_handler = NULL;
 	ntb_qp_link_context_reset(qp);
 
@@ -1373,7 +1374,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	if (rc)
 		goto err3;
 
-	nt->link_is_up = false;
+	atomic_set(&nt->link_is_up, false);
 	ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 	ntb_link_event(ndev);
 
@@ -1457,7 +1458,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 
 		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
 
-		if (qp->rx_handler && qp->client_ready)
+		if (qp->rx_handler && atomic_read(&qp->client_ready))
 			qp->rx_handler(qp, qp->cb_data, cb_data, len);
 
 		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
@@ -2268,7 +2269,7 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len)
 	struct ntb_queue_entry *entry;
 	void *buf;
 
-	if (!qp || qp->client_ready)
+	if (!qp || atomic_read(&qp->client_ready))
 		return NULL;
 
 	entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q);
@@ -2385,9 +2386,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
-	qp->client_ready = true;
+	atomic_set(&qp->client_ready, true);
 
-	if (qp->transport->link_is_up)
+	if (atomic_read(&qp->transport->link_is_up))
 		schedule_delayed_work(&qp->link_work, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
@@ -2407,7 +2408,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
-	qp->client_ready = false;
+	atomic_set(&qp->client_ready, false);
 
 	val = ntb_spad_read(qp->ndev, QP_LINKS);
 
-- 
2.51.0

