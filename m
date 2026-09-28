Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB634E9C33;
	Mon, 28 Sep 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609170; cv=fail; b=PRP82EW0l5h1jCD1aGZEMKkcvGArvm738PhPMeYHValhYQnHEocaqmjPWnbULDfEUs9Baiiss+MFeCbz3VXDyLBlpO5qLcyQMBIRRY5MItShqy6V4x5mC1HoMyKkkt6+Poopz7t2AhlKCyr6MDEm/KzMrKG0BW6D/T/yoB299ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609170; c=relaxed/simple;
	bh=CLOerwD7yBZiDqwVZNoFTPFMhdsvGv8rxn1VB3BSemA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jH3opkn/kXl/ikaLlTtNf3FXEGmzxNMbLXGymEpHcoKBCwWWzc8Q4ko1BfYlqULI8hvh6jNLrkwWvy7F8dBPiLhs5/6ntdlxoF5MBSsv5gOLKhPDGQMnKJJUXhqFojeLMnkov6JZxrDchjng+0F+z/KLdqipm4dFEODWPmPlxuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=J2QwJUMe; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="J2QwJUMe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvFz3GtWlejCUjcvmh7hUHYkafkVQ2E/iLeoiAPZdy6du3XmkKJLkBIKP5H+Hl/xz0W8CJSD5DmAp+kVCnGVFfbdCopa4dBJoD0rO2KXpaHQgK6n3TxxWWafOBPfsVaeGvurV6BwuyB5tQHY/aW/umLeEc0ZY3VKjIRB+qgvZjihA6MitsUgjgcPu5ahDcMIc6M2aJdr7QzmPwcBFbc9Yt46ckC5E7T3cQwAU3xBRiInQDS0nZA0PrMBBz697ML3x06Moh6gerMWNMwk06lgXcdRdbfLmsoBEbJR75RhlFT/A5egjMRP5/BUZHG5fNmQ0rIQMNaUUVRk+VA4il441g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TufhRS3UbYOlMIz5p3JIc8djOdwrp8B9l/sK4c5TAD4=;
 b=Jtu8tq+CnUjkdZrfb4DGrvybnDzPCaxivMUiKNRHaVoPaAYuY10jtiA1PJ56hwUv6hL+alnp7w8nm7BtgEXkqFYJMGPR+qc4mu4veqfE0dCIQW962GRlodtybtWnczvY8fY+bkgHgIJ2ixHq4iANB/8Ni+PLOZ/vKIIDC35F74Ji8R8Lhjw6Y2d/5squ3y9qdBAs0q+coVMRpSJDGQbKWNr75lInRPQIBfegKeptWE7cisJJ+rsRCCbDUWoUjGwGIDxcFV5qbypCPzVg2ynA+kDOBXiSWlhhSUs7fTL3XnTuBQvU0XbxP75fqcp0rOwnQsTmLOv7x+I3Xrp9hIfdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TufhRS3UbYOlMIz5p3JIc8djOdwrp8B9l/sK4c5TAD4=;
 b=J2QwJUMeMclIH05G5SnHHpWiXaen6Hdw0g8ocQTNL0bdcI/Wvz4XettGbv/f6DaLFk26ffX9SZlNRehCYXP6L5j36H5eThjIxpNzcHI4kWLIym32BzVuNrc+HpV+lLVwAmqnsO5ZJmWSwjn+tXA6djLCN8BAgODbp2zO5+mpC8s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:56 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:56 +0000
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
Subject: [PATCH v3 05/15] NTB: ntb_transport: Publish link state after QP setup
Date: Tue, 29 Sep 2026 00:25:40 +0900
Message-ID: <20260928152550.3354675-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: ec52fc83-6de0-4383-6f39-08df1d74ca8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b9CbAMkDiWZuiQZIh/gD6IhsVgeRS0li27mpc4Ya0WOL6OWLE8TbJeMBmenArTNzznyUfhsi81OeploU+KEYlMfT6PMsspV69FT1MuvWBq+UttQnzPCkUJEdvTySEy8N3laeqkmoyQRNJLru5IRtH0zJxysILUDh7P4RDBmgIbOUl+2VoHMNAyQUwYA0s37Zcl/ZqJoQRiB4KdqFE+aLEz+6At4afEraKXMjst/pHcCMmFhSqiYOVsGmf60ocLUwwr3tgXG75UcY1/NlvONmX0Wr1/Y/dGcQZJm899I8fleSMgh7CU8D5uQVODjbi+qv4I/vUyRbMvNWX4AGWLT9+a/bdEXX+112pP6btizg056MdGD3tkeCl8MLdysYzJkrmst0RX4nsgaQO+miq1J/AQXBdKBk+Ktm0xMe0dnX4Tv5ZUh0VfSFu/IPM6iAfwb8Rc/igfQjPXyu4nryGSBoGmVoGcb8QeFlAhZGzyhWQNKNTXXrlT5wJwrkOZ/OH3Fci/i5cg0DtNvGcxK/tW/PsZj8xsHult66IY7l61YZjysqJ4Isr1qOpA40kaCRtcs346i3diA7Df39dpvw3h1fHra8q9MQ7rhd2drB4vjEGCGaxFOjWaYpUQbC74hxyOir
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bs9R+U/sPAGEEejOCw5WBzeUCjMyXOEnmWLqlyPkn/d09uSZV7VaqI7x4dNR?=
 =?us-ascii?Q?b7IWmXTB4CUscrNawspPn4K6xczpu+Rh+oaQZyutT0zyK+6I2mvWzp/zlP0t?=
 =?us-ascii?Q?L33Vr5eH0F8TkLbI2/UU1eu+PjYQ+IsvoDLG6gTZRcf/FMb05Oy4gtnQt+by?=
 =?us-ascii?Q?kKg2HsNeWYfFlNfmn/Uam9pKMMPoMNk3/w4I/CnEka+/1EIEIxZXg+OGhgJw?=
 =?us-ascii?Q?+5afB3xfFsKrV6zq2W3gQ71QC5+J3vJUHCIZbeWMe+z3nrNOMxkGghpq4zRX?=
 =?us-ascii?Q?xL3mJLv0amPIywUtx05dKvy2YEi67t9PmZLNNHuXcH/0YHaqgd7zSQUGWrBw?=
 =?us-ascii?Q?cltHpNCfU0Btvixb3sveyEItNGma/9UxC09vcbJVuAHxLibBqHRoGhr3L2nw?=
 =?us-ascii?Q?tMu1hRWAQMNUWDtg/VrZVit08Dw+xilq0Ro1IubNFWkgUC1ekniHMJTBTVrB?=
 =?us-ascii?Q?q36XAVORTQtTrfBS1MxrHeLjGvp619IXkoh2ALJnPFF/rwn80K6GbnHGtt0b?=
 =?us-ascii?Q?QcgKnXsz3Atd1JgiZGpWJa1iBShy5q+vBAYeBLGQRkXdkcTzM5OigN22fm6B?=
 =?us-ascii?Q?I89fKhAb5LasrgSGkXgLHrcRLP/fAWqK8E0RMhtj6RuWUBWUcf6Bg5MFBpPg?=
 =?us-ascii?Q?DfItXeZFvY3njBD0RN3oDKsDjO8R4MXu21ju/f2tpxbHmT3SQAUFLuXQxYZJ?=
 =?us-ascii?Q?Pv4P3fv5PxDbyDNmnNUr+VTtAlZR5oOnbuNMaslf6dWi2yaIar9iL9jHDlys?=
 =?us-ascii?Q?bpoC5PicFzYD31Ex5j7uJrbp6pLLM9uKZrL6oBWlu3h23GydF+J6SvDKk+T+?=
 =?us-ascii?Q?GO0CGyOUwHzbor53fU1ll8oMreD3xqKFX7t0GJTKEEspDkW9yb217ZADWKxn?=
 =?us-ascii?Q?WZ4OfHeJPUhOEdl10JDySCK/Q+7Lz1yoFCddcdYvNnE3rW3BJFCr1edivuxp?=
 =?us-ascii?Q?2v0Uyl9fFS3qJ6Nl3AWftqFd/SdngeQwelYP213myTXwTx8mraKqWLxqaT/6?=
 =?us-ascii?Q?w4UbaPTUoVOnVlz9oXvDEoWVJtHPpmZmZuSzDngXDp6lgNMrd9yTdEOy1QG8?=
 =?us-ascii?Q?hgFT4Gh1+hnv1nKX//xXDNbf25qiLYaT1kxgwf2zZwkaWmYZCEhwyvp7Fx7H?=
 =?us-ascii?Q?ub0wZU4VAqccT2qkcFhm3GgRFU8lT8TnL/5Fp0jQlHBe5BExP/9ma6gw/Cqh?=
 =?us-ascii?Q?uLBlo6JWZ9sD31pBgzuQIISkolHUr8V8hvP/2MwD7auAJ1tKiIaBf03KsFF0?=
 =?us-ascii?Q?gcOifc9nsedDdj0lyNmyoDcxQgnU1kDGbTI3DAdOewjmK9bM07RJUYNP7og7?=
 =?us-ascii?Q?4PA5sIIvb41d5KVRzI7fOJyrl2qVqSqrchTXbe0OZBV5o3PzukPNBwFWCSuP?=
 =?us-ascii?Q?cUceHd0AlR2zE29FRWc5j9y7eO7ZZj4nKUKnrB/6N0L/0FMcsvKuKaRmgYfP?=
 =?us-ascii?Q?Ps9ueW6vo/XXitTJTkifnPOWGDk+v+xIQNcnR/vCjY10mo+i7wZOW/RsGADl?=
 =?us-ascii?Q?/hlGtAG2zaIYdTLUvf7JETMJ2yZowqNWFskXIFTe0rOCIPG3m4yd+Jmzuzkz?=
 =?us-ascii?Q?KzwMxtD8838sajVlugRVn6/BVxQvXoESg2IXnUJn2jp1m8FvazAgSKh9bhP4?=
 =?us-ascii?Q?g96RNhQQBKfzNifFGJoSAJjqPEZaG7ActP90zQ3ysw7Vmpt928oMz9KF8qht?=
 =?us-ascii?Q?annVE/VwZUowIRL30VrU5n6i6xyY7xcdEboJKNaYb58Rxr/uuXSzYv3gIQBG?=
 =?us-ascii?Q?QGsmmP0WiePlnBInBTeqBnwV8VFFGcElfu3EfMtNUN4KBsE9d6ln?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ec52fc83-6de0-4383-6f39-08df1d74ca8c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:56.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PB16FwoCy/HrQNbUiNVwgAQUL95DpvskrElkrz4BhYbFQUo9n437XFKFGTHyejuCxKWf6Z++Ex1pFTZaQ6/8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_transport_link_work() marks the transport link up before setting
up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
can then queue QP link work, which may enable RX and notify the client
before setup finishes.

Publish link_is_up with a release store after setting up all QPs,
and use acquire loads before queuing QP link work.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Use atomic release/acquire accessors.
  - Carry over Reviewed-by tags.

v2: https://lore.kernel.org/r/20260910040836.3792333-5-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8941da0b3d61..51d9e9969065 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -923,6 +923,16 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
+static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
+					   unsigned long delay)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (atomic_read_acquire(&nt->link_is_up))
+		schedule_delayed_work(&qp->link_work, delay);
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -942,13 +952,10 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_qp *qp = container_of(work,
 						   struct ntb_transport_qp,
 						   link_cleanup);
-	struct ntb_transport_ctx *nt = qp->transport;
 
 	ntb_qp_link_cleanup(qp);
-
-	if (atomic_read(&nt->link_is_up))
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	ntb_transport_schedule_qp_link(qp,
+				       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
 static void ntb_qp_link_down(struct ntb_transport_qp *qp)
@@ -1086,16 +1093,19 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	atomic_set(&nt->link_is_up, true);
-
 	for (i = 0; i < nt->qp_count; i++) {
-		struct ntb_transport_qp *qp = &nt->qp_vec[i];
-
 		ntb_transport_setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
+	}
+
+	/* Publish the link only after every QP has been set up. */
+	atomic_set_release(&nt->link_is_up, true);
+
+	for (i = 0; i < nt->qp_count; i++) {
+		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		if (atomic_read(&qp->client_ready))
-			schedule_delayed_work(&qp->link_work, 0);
+			ntb_transport_schedule_qp_link(qp, 0);
 	}
 
 	return;
@@ -1143,9 +1153,10 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
-	} else if (atomic_read(&nt->link_is_up))
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	} else {
+		ntb_transport_schedule_qp_link(qp,
+					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	}
 }
 
 static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
@@ -2389,8 +2400,7 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 
 	atomic_set(&qp->client_ready, true);
 
-	if (atomic_read(&qp->transport->link_is_up))
-		schedule_delayed_work(&qp->link_work, 0);
+	ntb_transport_schedule_qp_link(qp, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
 
-- 
2.51.0

