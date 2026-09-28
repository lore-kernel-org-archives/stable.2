Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA254E7806;
	Mon, 28 Sep 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609160; cv=fail; b=qWSswfHbg40VeylnODEYvIENklDP31oHj5WPe9AmEOwyuMSOhNYqlo9g60iWR42E7ySAYFY3AqRoFGgQr8Eln2P9v6DWmmrRww7NOZ95ms51nEmdHr4HrS901oqOXU56HPqe/08vRGiOVyKoIebH6bzP4juc0qksmfFjH47K7yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609160; c=relaxed/simple;
	bh=Kxyn79VGhkL3QMBtXh/EUhF0sGChJ17p5KRE+8/J8BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aV9ltKXm+wAWgRKQeLOmSwNMXGjZqIZIFgGzZFj+38HGxWlARdaEAXBwu0cvBR6cjNRhyh96w7Hig+xPFgh/B5P89oFJLM4lSRRQNumyDryaull6LU/OI9H0VLBUjUrK1fhF9c6GVpmgMz8339lxnnDjcRENV0iWOmUUxVl9kbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RM8iHdFb; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RM8iHdFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doLX3KMiby89X3NFbVpAJPdHnIKeookzn1D++9Ie/cRc/qVkeJwn3LGUCxvt7GeimlpgrwtuVtXGwG6a+RHJIHpnLxO/uzneQMixApLoRc8hJ9CKCZSBexs5+6c+L1kgShNMHTvcOHXs2bjEdSMplcGubLpQgDYI6UQNqWoKjh9eoT8YIp6k8WizE4C9tyO79tYf5RGl6CxLmxIz0oUhS1MA2gDMxJXyFbNgQ/ioNvXzgFZjC0VaKjGwo1Wd1hLY7Z6LTnOQeLTy2iogCGUVIdn0OUPtfFUOwfEO4z/vDPy7SOguRR6DN4W386GNBOjMJuYJpJn1ZQyfd8nVxWErag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbgoXopiEOV3sqUaX6O1WrQKBlgDVJmc3kVyF8dTtFI=;
 b=r6eTXs/l2aRRkBR0awT99l8HfiOR+PwQKoh2Wy7HOzgpd6DDyiHEj3/fS70gBg21nyvGNALW6FdH+iNN+OOzI+DA7Xx51u1NM4b/hrYsmt2L33E8Sh0lFEmZwlkqt/h69d4mUgPUiLz7Khv2Y3qhHFddFjowBCmrFQGMFLED3ohjSWh+cgKNBKzGeFk+d5EXhk25Q/f39I3rS+z4BytrGUekcgtPn3exOMAjfY731/UEfdQ5RXOMtD/Z6rwc84zqGuCafLGqLHVUAgpibFMDYYpeQusW4M4ac0ncgb2wiIyfCqAKjr9pPKUEiTN5SX+RhYnrQuzecScOQG7IzT14bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbgoXopiEOV3sqUaX6O1WrQKBlgDVJmc3kVyF8dTtFI=;
 b=RM8iHdFbyhRLYQWPZ6h91KUrxQyHKawVPDUDC0d9DJjsONEyLe1IwHbxnjxV6q2FDLO9cuPsTlGsY7Kddwu1/5m0hCeA90cnk7lk1cifK+dpNNFYFnPJT1T+hDl2KQgbIbwiW52t2LS5VgqHFJas7kYPHvBKlOMgCWwHvIOwQm4=
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
 15:25:53 +0000
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
Subject: [PATCH v3 02/15] NTB: ntb_transport: Start TX offload thread after queue setup
Date: Tue, 29 Sep 2026 00:25:37 +0900
Message-ID: <20260928152550.3354675-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 41437bda-790e-46b9-997a-08df1d74c92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dXQvNLEK5M1JFHEznRwd0rVXiYVsi2bVGr40f8F3aNWEvtc3hoBW/k0K0bTIQE/G/Kd6nwxX2JuK0ChCrHCaJ9yV5f5mqnTxuyepzKnIBIPh6qyv3fgwldJPysE0fL0ObayR586dNScOwNIJzPafsJUZDMWn3uaDZkJyi2slwDoVe9e6gt65Wx2lVmyx28vpJl0hcOqk6Rk8I147CkEed8WhJNFB6wFlSdYlSGLL3zLlnhtcxb4MyF5J+ZHeMQfg0tR3ZXMV4yV7i3u48/fP38f8MXtOtdGuJAZHjF8OpE4SCdSC6Xcj9t1Hd5BezzmhOn1ds3GkrPaAbB95kFmpFQQm819PfA3nZHICkevPwLVG5/Tm45KeAyXvTmujox/cBhwW1GPiqcAS5p+ln8ZfNQZvFAHYhZJWAL+NKjyihsHNoPLMrxh1ZdRKQPNJFdunLCivJpPmwFOTSlRsmk0ujtzsEJ0pHKTqgpr0qpTL2eOPffQ40ek0v58hKc92g7hl/tykMV8+6WJoy0IR1trJXfH3Nx/KgwWiqvswaQUZpkYW+Q3DjZMzs97fSfzHC1zgndjfv8NOFkmKAEWoUKQuysMDFENMX768eqY0ekWIMhPUX9pU3lkRejWfs94ITvtoEuHkaRC3s2bh5fNW5jYoyF76QGoze63tY06OTUyKWFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aX9M7CJ5GarX1qYdyT10pEA5trACG3xc9mQGFqykrMjngPZz3kyX4eDB66+7?=
 =?us-ascii?Q?fAkKgMfjc9pxBZ9633sbtZi2UqObogq+1nrs8ME6u2KjGcO8uXNqFB09PNal?=
 =?us-ascii?Q?H8z0DbzbmZ8a1OvgphhFDMZV6crn7eFuS77qhvwNOn+IkX8eI40mRs39olkO?=
 =?us-ascii?Q?h2TC8eluTEAZ2SiIPSRp/cwPEz1/Bqv7VndBWVaatle+9KqQMhNSMzhX8Xys?=
 =?us-ascii?Q?YuouTghpQR3ViywtyCQDqNeu6jAb575+n7Blc+pXcBJEdKvpQJz72w/pgS2O?=
 =?us-ascii?Q?zSqfu6qbE6H09nEEsa0r4djjN2OeTAs5hFLNckkz0ivXzFtr10lcJqryDDQM?=
 =?us-ascii?Q?aAyAsfdwigBZyZbbxYqtxqYXBCycQOg0p0QPreA7ZJQF6O32r6m1ugGgXzhW?=
 =?us-ascii?Q?y4ShDQuOwJfRNWTRgmWW7HimWcDrwNVAsQpAhhJnxUetwJ42/DCPdUwA3LGo?=
 =?us-ascii?Q?bh5q+hM3o/tq7ZGgGpCMOvtLYzhEYOsOEdE2fDkbNedpoMZ8V2R+WnrFwUtK?=
 =?us-ascii?Q?DhTRkYFZlEqZXRbOEiqLr9rgfoGJk5au2Ad690n+6/mBXQs5bT5MgQCP+FKu?=
 =?us-ascii?Q?4sxkXaWTlr1ZidyYSUc0J3xv9fO6AfRFWJ6EA7JgJIpul9N3nXmPRiewqSkk?=
 =?us-ascii?Q?pl4eJ20txmuItGPXAmboOAxiJPEV8IKsMBBTXpn7DAkO5ui5WWxQQE4CswCX?=
 =?us-ascii?Q?PTAZED7PUqwAPMmQtPvq5A5xYdb9LhMo2fkpZVB1JhFMZKV5+TSz4vCAxa4x?=
 =?us-ascii?Q?MwrQ1DduJfBKaatIPKXlBqUXc4R3aQgOkNFCi35H7Oc7OHtIUDtVDyDN+wcX?=
 =?us-ascii?Q?2+VqN2Q3dnj2nJQ/DAujJwLiJq3YrOJLApaAdtFGdJfQ6A5390/zlKXTFbK0?=
 =?us-ascii?Q?ghklfeUUaiQzxRD3WUIl/E2xgTS8XA4oqXvV4IclN2FsDslgzz/Kl9NIeGJA?=
 =?us-ascii?Q?HTIMEQOk6H+trREOFsNWeVNaL4mNEFkegzIGKblAB2Btqf39NvblvNUXkvkq?=
 =?us-ascii?Q?zrSe9ot1RmkKdmzw9/oPqBH0ohFL9Zc6ztFHbCqvCgFT3+S/m+QTm/14F+7F?=
 =?us-ascii?Q?YLFujGfefwjjlYLeF36gqQkjyX7Orc79m4XJfZUh4abmepFIc4QY+VhIRvUA?=
 =?us-ascii?Q?ZLeq9rbNxi90pnOR7XbHN3Z11ciyMh3whQ6bbBV8cZSQ5RxH0jAWdqB9NMAt?=
 =?us-ascii?Q?x/4X+s1KCD+pGusLYJVaLy8UZPZ5TOFFM1ZSBPWKRwM/vgZIHjR3u864KY7V?=
 =?us-ascii?Q?3IpDmGvv97nI9Rd53UrqfWjFVXQJ01s5QQUvLhAzSevRxtQ7J7Y/sQQucFyb?=
 =?us-ascii?Q?ki2nPuLrRfuEKkdh2cHN8LfUVWeDUL3m8y3XXY4yWcaBjj9SMwys+QY8JhFK?=
 =?us-ascii?Q?NBUZAWmPirU0XvafOUECYF4l65DhtO7z+1NYHCkGsDor3eDebs52s3tT8Zn1?=
 =?us-ascii?Q?hnbX2tGdOiJ2xzC1+VD+wVWu2nvJJyQoqod7z0ky/lLq7FSb3mUwa47l1ZqC?=
 =?us-ascii?Q?q/EEQQrlz8AuIB3VUnch0dXbZHf96toko8fYiywr8gXhaTQSFalMLdzPQP2X?=
 =?us-ascii?Q?Im9808fIj+UaoS3sVGDUL2a/Ci+XbuDndFEct6LknPnwbhJPiDDYyWvvuC1r?=
 =?us-ascii?Q?fsNosNj8ghvJdj9dxqfl7obShLnzsgJDyLIQyYvk4lBDbaxMFeHRKWrZgMI6?=
 =?us-ascii?Q?L5fJwlNZtWG3KNz5shm5Cm0md3sxN/FD9Jabfjdbg9cWiMHD/+Ls0kuAzaeU?=
 =?us-ascii?Q?VPEEE8x2LzGA+QZHusMZ0+02oYUMLeZOIAl6DWpYmc6uLc4DTgP9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 41437bda-790e-46b9-997a-08df1d74c92f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:53.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MS7XIOqru0PBVqWTYwiO0qnyCe9KCqHG4OEVuwsAMqIA6IaR4pZEgTajQ718YKWsBdf/l+6luuCX+kci+a7fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_transport_create_queue() starts the per-QP TX offload thread before
DMA mappings and queue entries are allocated. If later setup fails, the
error path returns the QP to the free bitmap without stopping the
thread. A retry can then reinitialize its waitqueue while the old thread
is still waiting on it.

Start the thread after queue setup.

Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Reviewed-by tags. No code changes.

 drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3389d6ca9ebd..55a20ae9a85e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2055,20 +2055,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	init_waitqueue_head(&qp->tx_offload_wq);
-	if (tx_memcpy_offload) {
-		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
-						    "ntb-txcpy/%s/%u",
-						    pci_name(ndev->pdev), qp->qp_num);
-		if (IS_ERR(qp->tx_offload_thread)) {
-			dev_warn(&nt->ndev->dev,
-				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
-				 PTR_ERR(qp->tx_offload_thread));
-			qp->tx_offload_thread = NULL;
-		}
-	} else
-		qp->tx_offload_thread = NULL;
-
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
@@ -2129,6 +2115,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 			     &qp->tx_free_q);
 	}
 
+	init_waitqueue_head(&qp->tx_offload_wq);
+	qp->tx_offload_thread = NULL;
+	if (tx_memcpy_offload) {
+		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
+						    "ntb-txcpy/%s/%u",
+						    pci_name(ndev->pdev), qp->qp_num);
+		if (IS_ERR(qp->tx_offload_thread)) {
+			dev_warn(&nt->ndev->dev,
+				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
+				 PTR_ERR(qp->tx_offload_thread));
+			qp->tx_offload_thread = NULL;
+		}
+	}
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
-- 
2.51.0

