Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795422571;
	b=16JvfTo5nktembUd1zRuCalmT5W/8vz/GfBHYmHCglQzPg8BAO3E6H46lb4FyGV7ZE3M
	 zeKX7N3T6wgMidaRjs/zXUwnd4qVjThR//fAZKlft9swSRUHKZ5GtfFdYUY1CWnSoHbze
	 6n6uRij95tiU1MiaffN37bNQKqFQ3pmbNhj40VWJR04EXZJSOWudHstwRhEBZtkmApmFW
	 d6tQJ6MlKQDaOpRFzDT4EITwkwTaFZGtXNXsvltwIDH1Rn4SGDLaU8Kuo0C4zGGNmpe5x
	 q2JsAavG85vlS1XFvCjw+YqV8abekSvXZ+OV0MLmMHLA/MhXv9t5RSs18VAa86KjVew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iklVS4Wei67K9fNCcyEVYUc52IalltrV85u/JSTwlaY=;
	b=RR0Sj7D+fH/OgfF3NaWGJmjXXjOdAJ8Tg1CXcYkKizo+hr/1V5mVMne1JfdG7Kz+fwLN
	 UN6IYxEspwzSj43KMbv/0Vxpk9Da6S6JO+1HJwvAwwT47/yIAzu9qyNMtA8IRTFZsnOfM
	 RwTwHtAClfsYW8zKuabdakB+FStAtFHCGJcVwtTgDuyGQyigdhAU6w8DE534iqry15K0o
	 DCsvuyLZngLRd09yCnZoedYw6tmUKNHqmztY+4bRqEZiVlXWrAx+VgMyCXAwIg+LCshOv
	 GP5W6eWnlfS+ugRin0nT6Ve+fihwCwCxqPBoopkngQHpqfAtkFoeWok2w9u2DaLr3yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LD8AA2kq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.43
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18E606A31A;
	Mon, 23 Nov 2026 08:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B18E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LD8AA2kq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fk0PRiwHrsrbpEiD9C4+fM3ps7glgzTjfHfMGKCLwEbI4ggEN9V38EyB9Q2io/i5c6NN1odlULTyrnk39SvhA9AasJH9h97JbY9kHcOwwp76iPhG2DRPgg4R7vLs8vHAfX2H5Dxb/70CByoaVuqcW94bqKkF55blc4PGxrzirC4rAlF9RM6BOdYuUHjhDyEQVujPsOP38qCCyeWGtLGm14PR70oxTL0HUa4zLr2byer9gfsrZj4XM4MPGWoWNXhmpNpXrPR/Q8BvExKiR7UttLdocABCW2dOcddlP0cldsCBfOTYUB2rDowQKlJa75NyQAjanhMj31NTdOB7Hz7Q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iklVS4Wei67K9fNCcyEVYUc52IalltrV85u/JSTwlaY=;
 b=WAMRppRWclJhursSgaMpRxQpOF9tviB8DdZPS5qlxAXzF1ychP8dE2rocu7Cw/huOdMrY8SQ9iFqiD+Y4j/UCGGL9+SW0V9nzk1xZ0FFldN0mLbH8x8N6G/w3pSGBdiKKS47j7ZR5jJMXOoEXHIaHGO+QCFV+wP1/d2QGHanb+24uU/wSmSncHD5VOPJZqdmE8jtWkeypwRZt/hzEYo8GBjBBmGgnmvnAYhdtFlZzhoxOQYhYTKxuPEeTxJVyvVCT8V70swa3yf+xfHLQo6noS3yjyspFiL22Oi0oNW7NcEXsJe99cbqqogeHycNdEJP9OKUNWJ84OwqYqkiJjDf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iklVS4Wei67K9fNCcyEVYUc52IalltrV85u/JSTwlaY=;
 b=LD8AA2kq82cwfeFRI3zLCKGNzED5KuQsxi7uay+1poNWfMRrvCT8fEUV+f+IXFU+xTD1EjIvGO7EEVXLySUN4uYyOGY7t5WgDyOeohO360XreRVzgD7uDzk3R8lzY07Nscikig7et1dRPQiKIe1cx4OUDrGjuhEylS9mxJP2mQY=
Received: from PH7PR13CA0015.namprd13.prod.outlook.com (2603:10b6:510:174::21)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 08:29:25 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::22) by PH7PR13CA0015.outlook.office365.com
 (2603:10b6:510:174::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 08:29:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 08:29:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 02:29:20 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 02:29:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@amd.com>, <git@amd.com>
CC: <stable@vger.kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Hyun Kwon
	<hyun.kwon@xilinx.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:XILINX VIDEO
 IP CORES" <linux-media@vger.kernel.org>
Subject: [PATCH v2] media: xilinx: vip: Make use of the devm_clk_get_enabled()
Date: Mon, 23 Nov 2026 09:29:16 +0100
Message-ID: <6fc78f17621e1392fb5a553f826672f3a4a0de5f.1795422554.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=michal.simek@amd.com; h=from:subject:message-id; bh=UaP0dwQZzDrjNG9CU6dPW9zD0hjHnrBkEAE2T6jCQlk=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQz/4ybFHZ6r4dTjtYnow/Ht4vb/dsQp/SSY2myW/DFo 6EBfjs/dZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE0tUYGXY+1Fp4NMjDYTfz 14jj03r0lu2fnb7jgDRTNuvKB8fvbhZnZOjUP2AXcXb2H60NcfuZb5aE8lj6M/rmp005NX/xNe4 f9lwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 6569266b-2e26-45a2-9bd6-08df493be1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|56012099006|10067099003|261102123227099003|261102130727099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	cseJUkAlSZr9DcRa/gDEYbC1hn1YbRkai3eTIgAFEJLmOIWiP6xdlIL40aKg0d6qFztYAsL387mO7iEleCviWYD/F5kw4tKxmZuJ48Hb/sfw+xj9M1WoaNU+T1LkK0FVK+FkT4uC4cMrh+YOqh/dJYVvsdcXmHpx0oPuoYxVrJYTm6XVl2a6Ardu2Y81ktdqzz7rd7cSn3VJx40gvuF/dO0La9hOZlYDsR1N9mhgxNdNIiclzPUf4SBehLpMGMVkKJ/+4JZK3t+nz5inicz72nUmOS1RRz4fblFoLM1oIkSpJw42mPTKSG+A/obymZNMLTi1UiKLWrhC4s84Do8K8ukodyF+O/26iVnD2Sv15nq2wwxSC6hHgu0LzIjWyebvJBqUQllkg1jASTgyDdK2c6LywNLmjy/0b4FKt+8KbvPXf2gEL3v+aRw/RMgYutekqJFmJTFaP9oPbOkayptHyRdxKXLIDEd+LwuYEFUldhrqu62CMb6sDUb3HRXMNTNMHHvyyZoryaUenbY6x5Hgh78m9Xptu55ULtJR9mOX7XUMKLgjI+YmtqLwhJ1O8PT7u7/mLAmCag88Ve2T6pUQd6VfBnTUtv90OzQOPuJmuy29/6B+xqq6MFsJbK/UNBCY/ermUC+VCnVs3u3tfTs+MRauZoxJitzqOkpgRozBDIlfjvZPjLWbvz4PIoqMf3857JgXp96lgSVl6WiBak7OvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fU2hhvxC55LNNZC1CtcxFBa/pc8QP2pJZGUTkcI28RnDrO/JORhku/+t9TZOGRtqVM06GsneE6pPYEIeQtbs9tIyAA0kg+gMq15/YqDluI69ArCYXz5OVdYbBv+erp8tZ31SD9jCtFHz+IFFijl0cJKcAI8KSmOp5P7An4bdGLt2g400CFlc2UAIb7q0jlZsI+Nb/eKrZ9mnr7T/SfPMuZirvE5cDNjTL63YKL2YXZUP0Du/Z5llhtgGEH6MPQLVF8mFs4FauUbXJkJAgd47sva7FfJg318rzSAZqcMb7H6UuyC6pia3z5JfCD/hVj36fM/Mj83HSA6h1K9oNzrUEyOWog75bmOEiXvvYqjPyjD7WwyLtU7kyjFuq96YHji9V6VCPZHcc8jsarhEE0PNWUqnShaguZLbnhjox1noCUnPrD5IqQQWrcoS4/j16lO7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:29:24.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6569266b-2e26-45a2-9bd6-08df493be1a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

There is missing return value check from clk_prepare_enable(). Fix it by
using devm_clk_get_enabled() macro.

Fixes: df3305156f98 ("[media] v4l: xilinx: Add Xilinx Video IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Add Fixed tag and CC stable

Removing xvip_cleanup_resources() should be done separately on the top of
this patch.

---
 drivers/media/platform/xilinx/xilinx-vip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-vip.c b/drivers/media/platform/xilinx/xilinx-vip.c
index f1574edd2b43..537702ace760 100644
--- a/drivers/media/platform/xilinx/xilinx-vip.c
+++ b/drivers/media/platform/xilinx/xilinx-vip.c
@@ -212,18 +212,16 @@ int xvip_init_resources(struct xvip_device *xvip)
 	if (IS_ERR(xvip->iomem))
 		return PTR_ERR(xvip->iomem);
 
-	xvip->clk = devm_clk_get(xvip->dev, NULL);
+	xvip->clk = devm_clk_get_enabled(xvip->dev, NULL);
 	if (IS_ERR(xvip->clk))
 		return PTR_ERR(xvip->clk);
 
-	clk_prepare_enable(xvip->clk);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xvip_init_resources);
 
 void xvip_cleanup_resources(struct xvip_device *xvip)
 {
-	clk_disable_unprepare(xvip->clk);
 }
 EXPORT_SYMBOL_GPL(xvip_cleanup_resources);
 
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
branch: xnext/vip

-- 
2.43.0

