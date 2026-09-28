Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2F4E8DE5;
	Mon, 28 Sep 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609175; cv=fail; b=ATeO+ujiuLIvNptwmCVaz+iqo/9egERrw8AJjGv97x98pu/tcPX3LHqedX/RkV/ZZ9wnNdcY69uBJv+5zInWzExEkhxggsvjqoco9QBVGrKH3eBHX4wVuqIfBO4ZNabxO/qLn5yMB7Dzfgj/mYFbEIsAliuMtu44i2gkUPtZ3Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609175; c=relaxed/simple;
	bh=x7pYovn/DOsj+Vcoh84ziOxG4GmY3+iktvjOg/IGhuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmTJPhsU8MoeTBoBAT5iMfPNyjtebLwovIuMBcSxYqZMIFgJq84U+3/I6g1alEUBQNiIzMwtnwbA+PuvKWr2wmocvtRE/fTZLy7Fwg37DKQhAxdubzZ2XtnYPg8HkGWfankwU5jqgXadRq/oRNrvGD71R1UgkAvWfwEQejNAP8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Tem3MPTS; arc=fail smtp.client-ip=52.101.229.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Tem3MPTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSjLkQbiLp3NCYnrrVPMM9Bh6EMG11wQGzc9ZCFWY8yb7FoWR+n/aRWlCDeRdez6aaCwATdrAD40z7Ju/XOnCouDAqnseptWt50yIoLPX2aeqlrT8JDBpLU97E02rJl7T0x9sXbPBmNssKVEXy5xQlyYOxwTRVU3AYo+tiXoppplJohirI+HuHedXdrY6NvkL6XZMdsVUhQAsHI8+V9ymdCnV0BL1Tfd43Utfi62YiMPTJo9Pysavx08+dNgHBukovSP+l6f/vBPvkn8+8bLD3y4LmvgQh1qmAXblNRpw17USgo+S3o8YetEzidme+3lsBlNI09piWCFoFUH/ScaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd03ymiAkZa50CO9tZpxQhCUiC2RBilWmsBpPZ64+Vc=;
 b=LICb3eyrQCytSFHZArc9LQxZKe7n86IVZCIrsHuoZjbPKo5BLYihCrQTabyQjsEmn7nKkvF4brL6131zuOLrtolQDZdqzywaP2y0xfygNr7Q0AW2qOtMFPzQp25+eJEnzBzsx8/WplHn+aKwxCzwWFejma9l+jLZZy7W+Peo3IthDdAAt+vbf4gZMugovSQ2axK9gCKgiGDvzgytnEpze++zWnuLUT90i3jV6mb/+KqkXZLhVlOrpWOimMTYEvEYvrGMvNrQngQN7Kqa3boQ1IGaYeCuqoNeoZXGlbgB538l7lSMKaHqMEw6ehCh6T8H+HNm59afxhTCvtEOZ7fx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd03ymiAkZa50CO9tZpxQhCUiC2RBilWmsBpPZ64+Vc=;
 b=Tem3MPTSXBW3Lm6r/B9Sv0RBm2i6EWHbryLKRnom7uxgOi1SjQAj5Ei1vPvdJpcotQ5MJ6NopDEO0u1ZpmHV7MJaBGRZgf2t3k8/cATevWP4UglsVnTEzOtM+TY93oIROjM/id0HNARlOjCRSpF/aF0mUKwLnt/6hfOBiZDdprY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:58 +0000
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
Subject: [PATCH v3 08/15] NTB: ntb_transport: Stop QP work before freeing a queue
Date: Tue, 29 Sep 2026 00:25:43 +0900
Message-ID: <20260928152550.3354675-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: e537ebac-2abd-4039-be77-08df1d74cbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FeDfTaiUxBjZH58tsgYvuSw8bt1POZ9Gp4qQ3u3pAAQ3ikTBvOls495l/BeMxIeUCLMQt7mivfSD2zGw3u2smUxA0iuDbjeOZjSp19hTWT6OkNc7fsU99C4LzPIvvykRFnnaMzn+0EUL+AgEuU6ni82Ay5jSiy4jLGYgPT6isY7a6UpOGswMB1IaryqJRDhliAVFqagI5swBW3QOOE9TG9JSkvPMQMOkpNCfsdI/SHAoSFZ8Ls1Jsgyro9s/hIPZz1nF9yV9Rztgr8Q9LSW9NxDaFDToDy+S+UJDo8x6H058EhWqBxfoLdXIMx+aNJx7Jse8I35d9dOU6jd2bsG+QKeu29E360O5ukZk0dEtOSbLYic1HZAU3UFv6sXQZE6rTTzoeZRd+RwyORGzmJUEBmmQ8iFkS9QTOiq6760GTK02Qox8itWVtkA/f6e+djnYkSTdDkFWNNFTn/LGBExz/dZkip+53GSPRX6tGu+9Cy1fCTmunh6X0iAwao8nJjpCoe4YTX9pUmXLptBLjZw7wDyHjDO8cseyH0QZ9C1Kp1Im5yzfp0XBbSuKtr0HsYeWiyruopGrt+ymb80IHYSTJsIhYM42DcNO7MVRTBlME2TT6X0oDh6Ul737BMeQR7JC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6cgBgZTPtCQEuDezV3E569JoUtGN1MocI65LmAIewa6jjZbxqML50Gynkh3?=
 =?us-ascii?Q?mqOlMXRuV2aMcG4rdJKIF6I4klsFEy2n+v01bftYN6iAiVRMnKlAR0CcTkX2?=
 =?us-ascii?Q?HZB/DFVtyyi9xHxk18btlkZ7SI9FnfTNY5WgB/NyNCmdI/E+ieTUT6w20w7P?=
 =?us-ascii?Q?cYOQhw6I9eP5E2WJ3YM0Op+y6+OUaj2I1KBNwX2dcoLLGhd7nyXiYY7zUyVU?=
 =?us-ascii?Q?Zcx+2GqJzmOpMB+XHoNaltqdA3op4FBAgQKK/g0WZRKVPDC30spyNBLRM7nx?=
 =?us-ascii?Q?ulikm+YpyXtUjVJIfEHvXeGey21szhq3mtlfBpizFsFvZclIiudtH10ALCfp?=
 =?us-ascii?Q?5TiwUqIzuzTe8RTLjKAkYLSRLf8HECN4mk0ZIsZtnLmVLNOoDGoGpjlZHzEF?=
 =?us-ascii?Q?GGTf8d7oCKNRvA18s0AUe+ck5dfKvyhrGpCr2OdsgLIvvKywx6TUaBn3yEfN?=
 =?us-ascii?Q?/9uy6C3vuLaZzB29sk0qnsk9dDsKzbCuKEbqvXNgJJzgLpflqBQkk4iBFGcL?=
 =?us-ascii?Q?EAifHHiHKU2UaJkq+V8DRIcQpm469AmitqyV5rrNnIPhD1odie62ddiq87L8?=
 =?us-ascii?Q?zKk+eWJgvq7Jwn7Q9x3Tgs2IQ1D3hE3cwJ8x5n8iybVktnxtxJJYNaX8APtK?=
 =?us-ascii?Q?LpXvLQ0HfxLU1jNhvYsfBag+TunLFfiyFhZKdY58H2Q/Oxrdg6RO6lLkEv8w?=
 =?us-ascii?Q?WzD+4nWvNwfw6oYKhS78y9+PcRz8D+Tw/mH++lMFvFVJ6OOrDk0SjXyZ3gQT?=
 =?us-ascii?Q?Bedoy+QvsSDJmd2cO+IA2658hrHuLo9ucKr3csmAOko1mdCgJ2dG/jZf5fIZ?=
 =?us-ascii?Q?pOrrgdyop2u66VUzhWUJt5w+kCdWz/r5JGFaIEAUdUoYuQFl/Ex9lE1xdRTe?=
 =?us-ascii?Q?5eEXxtqgovxRJv8j+aMyqwY0r1UG9QEHn9pH1izneyh6xrBTNuqN6Atautwe?=
 =?us-ascii?Q?mef0p24lnf0twfvLW89CzUJTdM+Msr5rZ0QltVkVF4aQugB7c06CJ54NKIrt?=
 =?us-ascii?Q?+jpE7jBhYh9lL/WkKgGHuvMRET7wbKBCeZLlMD+L71DHsh7lBA9W9Nd+mFT1?=
 =?us-ascii?Q?i9fi+w2FPnY7yww96qWX8kvPSNiGWBZcXFz8ARCG54b7LM1ISShKPWpH30d0?=
 =?us-ascii?Q?zHiuOfxCNkkU+6oOJx4i/rlIzfqHoCZCNhAwwJMhi0On1R3LkVm+NZUTv2a5?=
 =?us-ascii?Q?HUMRCOHHhDdtzfdsAXCC6D2GVy97PzkQ+zMluNrwj7/wvr28C4yNdrbjg0+2?=
 =?us-ascii?Q?8LAKACWomkbtDFRgbOyc35bbGMR3gKh8MLqWTM1UmN20HNlZ45sif61WzJOk?=
 =?us-ascii?Q?gZ4i/xIvXZTQWNxIvqX0StDRPTVAF+5dZSpP6iRAGPYvnE3PCFaKhPNJobMy?=
 =?us-ascii?Q?U83G0XzSVHALfu71sZr8k5gu9yq7DjZwYZE/f739rPv1YbwqFThXydsDJP+F?=
 =?us-ascii?Q?aPLDjFmoexkOyBHpn/K5p/4GQUkfEFzcCY6teYvham7bBrngOFbss8hVkFHI?=
 =?us-ascii?Q?buopCvbipGNDu1JEzXmChhxGA8BHpk+3kvlebSUHbe4KGE2+MVg10ksrYpHe?=
 =?us-ascii?Q?qremPilkgmGBbBvDQuS+AcsTsXhD1P6pQZ/MhJFnEztPNFX57ouDGHU8V5oU?=
 =?us-ascii?Q?ii3kDxQN1hYIYPWyu6vMtshorJsNxcQW7Z0a09E5NxTfDbvno1K0fd962z0q?=
 =?us-ascii?Q?hDzttSEOO5EgkG/iVO+Q4dxZvrgNWpbwFazUQcye1v2Yfm+vWq71lS1MPlOw?=
 =?us-ascii?Q?ZWugrzJf2h7LHT1cuJd3hD/QFUlFFtUZMRDJV2qiWyFI1cc8mx1N?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e537ebac-2abd-4039-be77-08df1d74cbfc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:58.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac2a0r8dQTQ4qMyHoMmlBjqXBmMwktIENyMhN5vOX6a7NgQW4jbSC+4+dIDbWEcqLdMy1l6zZa1CRREYyxUDbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_transport_free_queue() cancels qp->link_work but not qp->link_cleanup.
A peer link-down message can queue cleanup while ntb_netdev is freeing
the QP. Cleanup can then requeue link work after the queue resources
have been freed.

Disable and wait for cleanup, then link work, before freeing resources.
Unlike cancel, disable also prevents the RX tasklet and transport link
setup from queuing more work. Enable the works only after queue creation
succeeds.

Clear client_ready first so RX completions and transport link setup see
that the client is no longer ready. Clear link_is_up and active after
the workers stop, since link work can set both back to true.

Fixes: 7b4f2d3c3b82 ("NTB: No sleeping in interrupt context")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Clear client_ready with atomic_set().
  - Carry over Reviewed-by.

v2: https://lore.kernel.org/r/20260910040836.3792333-8-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 571d633c4f0b..556e1d255284 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1239,6 +1239,8 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	INIT_DELAYED_WORK(&qp->link_work, ntb_qp_link_work);
 	INIT_WORK(&qp->link_cleanup, ntb_qp_link_cleanup_work);
+	disable_delayed_work(&qp->link_work);
+	disable_work(&qp->link_cleanup);
 
 	spin_lock_init(&qp->ntb_rx_q_lock);
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
@@ -2152,6 +2154,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		}
 	}
 
+	enable_work(&qp->link_cleanup);
+	enable_delayed_work(&qp->link_work);
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
@@ -2197,6 +2202,10 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	atomic_set(&qp->client_ready, false);
+	disable_work_sync(&qp->link_cleanup);
+	disable_delayed_work_sync(&qp->link_work);
+	qp->link_is_up = false;
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -2244,8 +2253,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	ntb_db_set_mask(qp->ndev, qp_bit);
 	tasklet_kill(&qp->rxc_db_work);
 
-	cancel_delayed_work_sync(&qp->link_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
-- 
2.51.0

