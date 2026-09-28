Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95454E8E03;
	Mon, 28 Sep 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609182; cv=fail; b=tcFes0/7erOCs38gyHz/WdORAhzGZfkHSgweszlg/LG0SiRjHlD5mzM3IjfHTS1HkJ4TbHpzqQVPgDWhH2mT3iNLDOJzLMwCIvcS9PuLBc4GjGfk49DOCB/olCfxzjvvpvFxef3MPqZqrlF8L/41gRNzV5sNnAV5oqNFlbr+Ulo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609182; c=relaxed/simple;
	bh=H2llFf1zcOU1prWsva1YBFIXTk0V2HGysNz+fJ6ISUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RGT6046R83z4FwmQ4no3nBm1S7TYvWzcizws4n6+pcFZN3nU/CaSLqBiExaxiPvct3xeVSsri+XBtoG3PdX6k9SreX86P8sJcvl3LkIB2WPeE51N0bTcYgn+SoyLKSC9ZHtyVR1W86c0J6vxMTcbCRJL5nyUpU9BDdcRTx/hBtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EDUxWPYK; arc=fail smtp.client-ip=52.101.229.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EDUxWPYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGvrOKF7dW5Dz8Od3pIBLpHCePR0aMU60EQ5Imd3idB9pXFPJuppg0xILeBPeC5O+nbEzSUa2BCqL8msajTogCzdc2rLsnGv8ni7Z3GopkCYuOEunP6XR5sd8puTzmOTQIhGu08j3/Qpocwjdp5y9lqQTzNaiD19XTl1jHY4npl6dkm4zP/QOCC3ibE4NZBXGY7nZbIvDb5AKl5DHexo8J00qsu8Fru3s9+F5zfjZPSr4Bhgt5w/gm4H09uj907Ey6H2MeZ2p5EEkNJHj7FqKjioC/GQhxsOSrbcIg4XdEdFyUpPpMymX1AsXFhdzuo4S22ZyJvDF/VNsEU2bjiipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qq79UzPUfpsxgGZ/mXU8SKCp3KtvVAFgMAM7dsObm8=;
 b=OnVBAxyhZrMmmDCy+7ELMjybigSNG6dji231ElpjwAhPFvKpjNT6F5MqfcM1huneslecJwaO+XhrCL0saQbtVKEX//+GBDm7GFbR5oGMKmBO+LCVcr7wqL/IwMB79AfHdlU7jJqMvaAtAJuxlA+ZhpgMBDEzBAm3uMKGMyykGrN9vVYoSIGvoZzXnx290pqsUihERc9RYglZZT5+ZJyRj+Y9vbCKBJhi4IXqCvikbo4A6pGIO/rVo724YsXYvT7ic4CF51YNWlgcRJ7YQi+qKhpjI+vf3yHlhALntqOOWEM0Uj6PteoknQ0g0lo4BB/81d1upqw9aNAhqWqOMSEUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qq79UzPUfpsxgGZ/mXU8SKCp3KtvVAFgMAM7dsObm8=;
 b=EDUxWPYKDe2eiVMHvNmKHCmC9pihkMe1gJiPkmhkFApo8mlODHwBaPDU73jySzgx5Yb3K81PvJY2LkYeqw3mcox1duA7XOs/Ppjf/l93H0EdKD5I8wV321J4KLphFDYY4NF34prft5F9y49nQUgvsxKrScPWLk8XOIDZNogBs3Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:26:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:26:02 +0000
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
Subject: [PATCH v3 13/15] NTB: ntb_transport: Clear QP pointers when freeing an MW
Date: Tue, 29 Sep 2026 00:25:48 +0900
Message-ID: <20260928152550.3354675-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b649bbb-d3af-4199-3cff-08df1d74ce5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SbaEGxFXK0G1lBtF2yawrcyc8RFhFsWRf/8ZGjr23qWMMiMCRtHao2UaxRlXwjbGcvCJEdaymV56WMcn5APZhG8/fDqBIceLI/6cXLmPRzXJcVWcT0c9kGCNgNc26mngFzBgFVieeX/5r8oz8wgYPZSquTpSik9vjIHED4sPHfbsT9wgqPaC7WqV/tDl9j/KVH4+tD8im/GawTt0mY7ZgeKCD7kMOmzN/TSDeQ+j7ec1Tq3oPgojogBN3RvU0K0V101o3I8/wuiRVkDa+rQAt1FJVCs8+OBkkMWAjZ7FRyZLS3fa5Er6M4HEIzG0y+TD0z0gCYWnGICifS5KqTPDlz93Dx1fMdKvdEDK5IeGdQZLOLXvAYza6JcZVqEmzvHIFvxyRo1mAN3q9238nrIGFWv6rkBfsP0V/QYcLU3aeR/exxQf2qo0WBQglnfxts5elh5qGsj+O4+IxDZ1mHDe2LYiVA0/GUAJMKVvGPfdmzzRZzmw3D5jskIiNmk/I640FVjUa0cA1YzdlXDr1JWwIT9KfBC/E80nuSZs+lJJ/S7sngf3AN/8/90ehI/OD627YRXWsOs0jPlPV0ak1lbgrPttOGnklQEcE7sUEfLIm/YbZZz4ue2X3php4SJmnC3Q1acH3EGMxbcEzPUynexSZ1pcAIOQu2Dfsa6uwjfOJzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N5qUv0390oQbyAmOGAemn2YEhVqjBrl+f2hizVAJKRZ12zYR5wHiwYR2b276?=
 =?us-ascii?Q?Jr4c9hV/7txmqYSjEfsSkl/aUGx6dCoDxlWx9jGEzXzRO+7aKCRWMX+ZZGnS?=
 =?us-ascii?Q?Z6BO77Xo/4IErvzTI+NmdXHx7z8b2rJmqRalKEN9baPoToW8I3HE8TFufZJe?=
 =?us-ascii?Q?BfKCGJCbUFawdi2su2ZuAeu/pfYWUpi8iBWC8JLte1r8lrXhgBdkvP2fHhHP?=
 =?us-ascii?Q?NivXJXdeqQRv2BkD7iiZwT6ZMtROVYlQCaGIXXV3nbIoFpGe/1AcNI4qFSQN?=
 =?us-ascii?Q?74vBFnhMOnUKP7xDkr/4x01OVwHNs+RFuRPGj1TktzgwbY2winezvFu/+zUH?=
 =?us-ascii?Q?AjS3q6dKxwJCZlOiCY+0y7nNnZAtYNpPd4sIStp58lMb92/opPIPwlm953h0?=
 =?us-ascii?Q?y9lW9xBgEh+mMy0uxzN9B/q/16tMAIn6xW9U0tzyWHnRT7rYM7m1B0UwMp5I?=
 =?us-ascii?Q?zYRXTaWQi66z27xCxZw1P9CCdVGcvW11yZ4QwpwNoBx8uTqZQddPfhu9co3q?=
 =?us-ascii?Q?t1miYZms5oIhGA09r0XjoGpLwoNsjZldvG0FR2NyTyAuYSkpqaekVls5uc78?=
 =?us-ascii?Q?7znJW+/P4wcF+au7liVgsJiU0EMw/Rt94piJSGxLP+WJ3VxIKquTyGVFxS3A?=
 =?us-ascii?Q?JghXXI3nB0VP5IXLPgsxV5sxks34e1QVGbZB/pKRomB1t9mHTz/ePlQiU/Ic?=
 =?us-ascii?Q?z5IdQJXM2tibCj+c/Qze0AvIBePzppOnPeREolfmWDgjLbXvAQwsYwrWT5Is?=
 =?us-ascii?Q?JhCOxt6HF4Nygv3YS4CCprD/yAFzvYzEI+YyfAvuAy2uKuzycBNVXH1Enzqr?=
 =?us-ascii?Q?y2lF+r76Zw4R/UbOwcofNIDepWR3C8j5uRbJAQuxMt5sHVEAncHbPg9JdUfz?=
 =?us-ascii?Q?nmVfoQRwCG1aJOwfDpJE1NNDlMrQvHwGZfKToIOrx2uxhkhxXJOuLS5gmqpR?=
 =?us-ascii?Q?GOf/kqVxecRR2Q6pGccEa9zDSz0f2PaStt9ROGUJD5BBr+t125J6SQA9FpZX?=
 =?us-ascii?Q?n0UHKX275KVcFU+wAOU3shD7EFUM/BZWm9TFG6uMiLrXXP6oU/xYE+Ikh6GM?=
 =?us-ascii?Q?2OjQJ4ldi6YM8pmCOCjUHfakWlhiVjkHC/3S2Hadeo1anyUo3mnM1aFUHJVG?=
 =?us-ascii?Q?Dzl4nvKr5FpK72Mp1o0dtOrdMUYtSUhv2O984mpghlY1aCw51MVzYXlDKxmO?=
 =?us-ascii?Q?1oQG8MzxfAo/aZbK02hbOPzq3BbjGiUp6bJuHYDRRTrzX0gHY6+kTs6NPdE3?=
 =?us-ascii?Q?dvhZZ1Wqq3Odat5x10xtHq72PlSNvQSIlBNtRqfwDokLvyOvnAzb66/kWa+c?=
 =?us-ascii?Q?v4pvKunbJ5v0EcPMUgLae9JCjhwaEUVukhoyn7zHLijbmy1YhXLSFx5Fte/V?=
 =?us-ascii?Q?CWXMq35Al4vPzAF5AegDpd4woHGu0pF2AYOQfojBZzH2AiLZbcOFSox2ZmNy?=
 =?us-ascii?Q?ClpRo04JoBdw+K/t6iw/fBz0/lX9JqoCO4d8INj9AC+DFRJTuqKuqmPTI+s9?=
 =?us-ascii?Q?x68xXBVA5IDRPeiqEXHOIf3CyPWxdJUg3WqqPDPfQgkOgsZcsY/Rgjv5Nkxz?=
 =?us-ascii?Q?mgyiR4KeMkju3GNIz5xqAedLhF5iPQaFEi0+Hjx/xOOMP911JqB9Uc0LF8tM?=
 =?us-ascii?Q?4d4zCjppCcHsjriQTo1US1ie1i2gDOKgeCyniB7jgyCkZlLKCmaP4bY2zrh0?=
 =?us-ascii?Q?dQhLIZDqFCLapI2Zg+jJ1QtWtAA9CkUKAKTkCMrK4QX5iWO0kBw/6Ml5AO5+?=
 =?us-ascii?Q?kD1Cejx+Rv4KmKyLRcj8E5YXtVT691Zdn40342bZ9Z9CsFsBmpu4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b649bbb-d3af-4199-3cff-08df1d74ce5c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:26:02.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0myUIuB1ilqu/RNSWhQmQvZf/WG+4f1J12RZApVoG/V/3UTESz1Ml8OqJ605E/OkuaaKHeULiyYIt9ePLL4AGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_transport_link_cleanup() frees MW buffers but leaves rx_buff and
remote_rx_info pointing into them. With a QP still allocated, another
link-down notification or transport unbind before MW setup runs again
can make ntb_qp_link_down_reset() write to freed memory through
remote_rx_info.

Clear both pointers in ntb_free_mw() for all QPs using that MW,
including those without a client. This also covers link-setup failures.

Fixes: cc79bd2738c2 ("ntb: Clean up tx tail index on link down")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
How to reproduce:

  1. Load ntb_transport and ntb_netdev on both sides and establish the
     transport/QP links once. Stop traffic, but leave ntb_netdev loaded
     on VHOST so its QPs remain allocated throughout the test.

  2. On HOST, unload ntb_netdev and ntb_transport, leaving ntb_hw_epf
     bound:

     modprobe -r ntb_netdev ntb_transport

     Transport removal sends COMMAND_LINK_DOWN to VHOST. Wait for
     ntb_transport_link_cleanup_work() to return on VHOST, using a
     function-graph trace. The "Link Cleanup" message is printed before
     MW release and is not sufficient to establish completion. Do not
     bring the link back up before the next step.

  3-(A). UAF via repeated link-down notification

     Use ntb_tool on HOST to send another link-down request:

     HOST# modprobe ntb_tool
     HOST# echo N > "/sys/kernel/debug/ntb_tool/$ntb_host_dev/link"

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_link_cleanup_work+0x2c/0x50 [ntb_transport]
      process_one_work+0x5b8/0x12f0
      ...

  3-(B). UAF via transport removal after link-down

     VHOST# echo "$ntb_vhost_dev" > \
         /sys/bus/ntb/drivers/ntb_transport/unbind

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_free+0x68/0x588 [ntb_transport]
      ntb_remove+0x5c/0xa0 [ntb]

Verified that neither test triggers a KASAN report with this patch.

Changes in v3:
  - Move test details below "---". (Dave)
  - Add Reviewed-by tag. No code changes.

 drivers/ntb/ntb_transport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index c4dfef75f159..9f23c9c3d220 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -782,10 +782,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
+	unsigned int i;
 
 	if (!mw->virt_addr)
 		return;
 
+	/* Drop references from every QP using this MW. */
+	for (i = num_mw; i < nt->qp_count; i += nt->mw_count) {
+		nt->qp_vec[i].rx_buff = NULL;
+		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
+	}
+
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
 		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
-- 
2.51.0

