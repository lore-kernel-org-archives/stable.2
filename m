Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8B14E80A9;
	Mon, 28 Sep 2026 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609176; cv=fail; b=W01kCNjECHZrUhBifuslNEwX/36iNFnN9V4NIhZLuGEpzboq5J6eG0pBXe8Uh6utIt8fNHk4fPeUFlKYJfzHBLZ3NRxLODOukCY5+Hf4JlmWtabqIJr4xGYxGq8k3SBwt68nVEwNkhpZj56VYY2lrwjkDImVgN7JGm/4bYZ5nU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609176; c=relaxed/simple;
	bh=uNSx4436Ewkqp460B8H/YBbKG3Jv0XRz9Fpy+UOKPpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijYkldOkdtiBvirgdVjkJXSdWFVYIzj46WvrW99KATQk1tQ8srHi4fWUx9DJ16FQawXkd/HphCeRL6IQVNrwoJyItYX4Ldswj85jr+rHtordSoIlVyGyg0BpW3rJ2cPBneETJ6+dhOczlYafzjCic9LoujcTaJiRmfT4FLc/Nlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sRFD0KWv; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sRFD0KWv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRQ1L6uMl2ToTHsB8p4h8A+AA4yfsR6kmTWZJjlKS2jk8TGubBViU7uTWVshZTkpEZ67pArf7ZfJx1Zd02iKJNf4oHoohK30gsdfH4DJ9ITrZBpbYwONCfNVTTKKfK9tzfgajoXvMDyqXZIxVkC/i6d1ijm9WKJl9mTatSZNpWtsjRIzTqMgDT51CSfzBSQtIKc2JOU9kkfWUnYlQKc8Jz3GacDufhXuxkhOG06MODUTrMoWgTPePjEBKGnZzLNNoejSMXNwvlm2/s3aBGzBxXf1hqbIcaVdiHzhcXWQ2UvGmVspxZszp1RMXI1gpfxfrh5FBXS8ESfHnvrDZAzF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O240QLGf21Wmlgs6gnajSoY1jeCBozgHkL7A8RFT0v8=;
 b=kHT07qmKIrmjFG6nsoNbdrI4WaJaWg+ySYsziHWaFWl3f3BA6YL0iJd6AzfmZd9TIBBwYo7J0QyGHwmAOu97cOMw2+u27HPxzcIJMPCaniGyrLDLu6QTIE1jkOR6Bxflf2B2vp972Lk6ku4l0pHl6q9VzTqhDg1yPoZ0u4coX0nJmr/mdij+bIJvHGuJVSot8pFyXlejEiZq6zNACNUA3/nTMrQBIzcZkUEs0Qkhul1MbnTpptUwlbsDykiUdLRVjdvmFEuzHEbUiZ9NRi260VWnDzv1vZsPp2pREX76IRxqWnkPsIR4jGGCzc5pt/Glk2/xExxZwWTtHZvrD/PgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O240QLGf21Wmlgs6gnajSoY1jeCBozgHkL7A8RFT0v8=;
 b=sRFD0KWvdLabQCuKyWVg+dINcIT7qBzBkKvBGZHki0Jt8YKxUbhW52HoXlh6rsPPncCB9TSzezijW39YWR7iGERDOaZwh7CXwiHHIwcb6BeLOe2IL6nW67zUktV6vtRDET/5OSxSh07z3rfxmrnE3KyEkyQBlPE3eKN8MTUSIGA=
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
Subject: [PATCH v3 07/15] NTB: ntb_transport: Clear link state before QP cleanup
Date: Tue, 29 Sep 2026 00:25:42 +0900
Message-ID: <20260928152550.3354675-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0ca773-7c11-4e47-a70a-08df1d74cb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xbW27kDbKdxDsyPxkRqpNOOAdSK8jyoQuzLAXSOtQaWsm2GZyBXLrjOu+e0GBwoiXnPsTiIW7PwQsKv7Q9QsF/nBF8F4U6ZoBDXZ0QIRPvnza2pHPOM4Q37PMNUdCFmV2fBaW5dp6k0E//m3y6A76qtDclsXRXe+VMs8p3SZSjrHQmvF6Nm8GCxVWbquVQNeHNG30IbezfM0lSaObhp7GE9Uz8tV90V1JONwtDPxpnEi+k+FfnTBV2U7WUDglImjP/Leq41m1K2z54WcRHnNnayh0x37xPepUeh2bDy1qQzJiRAHXCMtIEZlCoYfphT+uBDTASVz6eonAOkQm3TXuRj01o3MZpyQi4NH8YHXsYH0qv7r4IlmD45NF/mM5ixRfeeIcTg22ZyJlOuNYnbEso7IXhdesFxlqVX0pLIIOSAW3O6Yfl99sWX/AqR1WYaHPOW0EJSBLHQLQT7qfN5ZRowUzfGswXAq+zV6DnbkDfp/6rguIuljUSzaE6Ybi2641iUQDXXgtYfmBJpul0vq+SzZgcLvpyh16oasP6+FVkOe1ePKPhfWOuTVAw6cyRSFjVjIRUle/d/va+7lrB5pq9hpxC6KKaXurhmTY0JF6xuvCa+B6DqCSGjYC1Pm98A1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDzo2d9w19Vo+AUM19dTBqbFm23qtj8TpVF2EidNVIbINohsca37N4FMreUg?=
 =?us-ascii?Q?4LNVFpTQ5BtnTA1+8bUL0LHYcVfLW2a83lTAVSyY+Z/gfKkMm3tQ8BQaxi89?=
 =?us-ascii?Q?3avtTNNsj+YLlbpaUVZKpP3hZDKNeWewJZ/KQYFgYuP8qjbnqH2AbYf3Fsuf?=
 =?us-ascii?Q?qDRjpnKtfCs2ZENCxNtf4HnxPwv2mPa6l/f8KZq/1HySRANMqVSWTQhlR89t?=
 =?us-ascii?Q?XFdSp/jAu6WIACj6+l5I2J1Elwn/0bMZIh1UjhyycRMKWnwqN84uWFBstL0p?=
 =?us-ascii?Q?NcMoifZDpurvnvvYceEcwZNtAdBpYO65icV5K4gSQ0x/p2SyZhEq1ct42Yqc?=
 =?us-ascii?Q?+U4vy+pMWro/Ca8IpBdfVQsZV1yizlWkwKzgptJHf222XQD4x+qO1Q/73+8F?=
 =?us-ascii?Q?O/+597361PiwcY4LYQwqwXk+s0t/HuDfR16Qtl+b620eIRRkms47dFCrfgms?=
 =?us-ascii?Q?SJOf+WY/CU2OVnN/Uz1zNJQpkpOrtnweJ3wbxMqhWlTgZrQ+F/s/5VA4Rqx7?=
 =?us-ascii?Q?K+5z5ruyoXify0+F2cvJPfdJURI+znf33cLT0R/lzr1rE5+OtVMHIciE453h?=
 =?us-ascii?Q?LxhyKt2B2VdFjE7oKiQSZxWldi/keD4yhcx37IismWg67RxYVnEtTDY3hj4T?=
 =?us-ascii?Q?fVBZQgdqXqb6mBR6ye8EMgo0kxNz1dpiVHaKP8wMuhNAG2X50M2kSB5G67Ke?=
 =?us-ascii?Q?QsBeHRThJpVqSslBHp0kAEyaSGexF0hAsFLCaXw0vr7+BAFvR4Tzg3Pjv0E0?=
 =?us-ascii?Q?QabaEPzyqXdt7DpQa3Kgy0eLU5q5ZFindIhBNcG+EfRe+CaibN6/Fvcb1uLw?=
 =?us-ascii?Q?AiQQSBeN3DXppXmHEKkKQKeN1QzfHdFO5Op98EagFjY/6FyLZ+Ybun+Z8s2X?=
 =?us-ascii?Q?rv5kqLMPVtoE+iCOq0WUI0+a3GCrwH08ptt/aGqv1hxTG0dlkqdGTKvPy/3x?=
 =?us-ascii?Q?j+RKu8/fyuXI+OPLboejWJt69mOJbpYKn+Ywl8WvsEPUupbM3ER4+9sHxtgE?=
 =?us-ascii?Q?UPD4sFlX0iga7dGdYbEizqF3XFxzZBH8QEiOW7djyVZhE2PAIBBHyrcPpNW4?=
 =?us-ascii?Q?SOcez5NaAdkj1ImmkwZVaAA9eZtuZRE+GAAJc9NcIshs/mkim8LcI662LteZ?=
 =?us-ascii?Q?R+BAiqe/SVwz22IQDEgyy/klEimJxSR82zdg31rq0DdiwSeD3YJSpaZ3VoXV?=
 =?us-ascii?Q?4a0JIFm+J4HINyWnS7Sgw0bzmA6sZHVbYtDMWepvPZ/a7BVsMovTAfd2oimY?=
 =?us-ascii?Q?NsFk3UHKb4f6oBIO/8VlPMXsNAtX5+q0tDVxoeyTK96RJUitIWBIJG2nz5oW?=
 =?us-ascii?Q?9TI2mBOASZZizn/qgcEwdyvKbEFcG+CrkMB5nhvGVvpsnHGkcBoqjyBYSBWM?=
 =?us-ascii?Q?lc2X79zEvj5GAKVaAr4Sc5x8GVgP+YxPgO4fd76h0RAjIbmgSWxAX1SZQD6e?=
 =?us-ascii?Q?cJDf75rfzuC5OeBSe9KCeR/Xy4drIIvMIvwXie7gnsjp+y6onCVdFF8lMcm6?=
 =?us-ascii?Q?z2jVEkArHCERstlTjSPFjX1QS+ROUvuYWWs7OY7C2Oe4szFSZBTPDkO8kxwc?=
 =?us-ascii?Q?i5NtvT6/AZ5vlf7RK+Jhfz9XFPl+R6wXGyl1JPcqape2F7Bw11Kdgy3gxMHJ?=
 =?us-ascii?Q?lMzm4wTJJzI+cAZyRrF1dUrpt7U7v1UeU87nWgTg26l//83PwoSvilBFHek5?=
 =?us-ascii?Q?ZJQNGfektV3jq0iGLWcNA+buRHsMEGs4rO5rR6W8WkynkY19aZeSVPX/jG7S?=
 =?us-ascii?Q?U4OowMFsYnw4VJ5rMhlIz/5LMDxB6J/RP9zhkB2csZ+uweSuawcs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ca773-7c11-4e47-a70a-08df1d74cb7e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:57.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8Qz+bXaaxzzf0iUfc9dFMccmcdm2Mdk0wU2f+R6Mc2pJTahHq4BxdpZ5+qoRROtKasm7sIW2SOuGax9A4KwPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

Cleanup leaves the transport link marked up after releasing its MWs.
A subsequent client link-up request can therefore start QP link work
before the transport has been set up again.

Clear link_is_up before cancelling QP work and releasing the MWs.
Have QP link work return if the transport went down after it was
queued.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Use atomic accessors for link_is_up. (Frank)
  - Carry over Reviewed-by.

v2: https://lore.kernel.org/r/20260910040836.3792333-7-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d290e5869c21..571d633c4f0b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -974,6 +974,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 
 	guard(mutex)(&nt->link_event_lock);
 
+	atomic_set(&nt->link_is_up, false);
+
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* Pass along the info to any clients */
@@ -1139,7 +1141,9 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
-	WARN_ON(!atomic_read(&nt->link_is_up));
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (!atomic_read_acquire(&nt->link_is_up))
+		return;
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-- 
2.51.0

