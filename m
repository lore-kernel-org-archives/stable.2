Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D10381C4;
	Fri,  7 Aug 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124846; cv=fail; b=nnHumtocQQZUjYvTcY10v8ldfEoEVC2e2XNxVAISVvTjGVqKR/kQ4+zK1ieyuflEtrZlARlQwTWgDQkI+oEX0V0jRAQhrWsgtXzqJ2VXCOwXn4NKwqs0K9AnFTYa2buQexTyalcyZBEC349jfyPomrXPpEGyH4q2v8WbWWb/qZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124846; c=relaxed/simple;
	bh=bzMQK8/ju5oB863WzNulOhDSrDUJhNot+IzO3RfKIfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3HANECueKaXj9yyNiVny7GPpOMRiJLlYMa+WSYU0vURxmWzfoQTQ/nsvt693fFTLPioK8YOIux+3uXQ1UGhiWPppL/m04cmDFXwWr66qJuI9j5VWBsKJ7H8G86twBRdQJfV0AQcwzCzv6qSNf2nLX2+mw8N+NJPtl0dfVGYAw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VlXbNB4k; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VlXbNB4k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymg4tB9JvzEpdjEZejbbuNy3BmGC61CpQwNt5WT+cqWvyYyL6HJ+KCyBOmtoFHH2ck8GskUoq70eYbeit6K9SPNEkEerrqXBLm/s+BKZHN9r26DAMNJNBp1AAgvGU7A8jLQBGMa/jp5UloBeDXqnIed9Y/1P/wgua+dLbyLNtaZIIYfTOj7ADqLBmZDKVlPa7h+LHqetloXx2hMVDiSxKD+XuPzJxbVfyQtJNw34qh444VrsgAdjzjYWAI2OXj0E36Q+5kQsKKZehCz+vkU3xizwMID6KlEBVW+4qNe1rfIg2SOfn0SOZzNsQAbivxiwX110q0yX097u9FeGzFRZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtLUpebLdREH3A4BhGvvfUR1jyBzbmYzn3+2gfU1rXg=;
 b=xBs5+NWjXNrmszIdku0F0GntfN+uLFstCSICR6L63S5d8Qc2DEFaCK70x58NPEo8VfZ/Er9qhOoGkTedHdiJU60ggpqfovK1Y5OAX2uKszv6LvFKnil4fu3eIdZYk25uvJWiklMgH3mEMRBBgvlpezhKKyDVdUroflJ9JhhNFhKPA3L4zTPAZeFUK6LVjUwbuQslImPsuoQQdDp1iY0qZhecniSLqH46ZJKmvdJsdM9QYVfWM0iP8RyiVzgPEKMTh0FmrpDNr8XBJGR/adK8KgQ3IiNeTj1VoKDevbDI/f0Iut9SyrDoTVec8TvoIhE0caRAvyZmj/JKeehxhO+a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtLUpebLdREH3A4BhGvvfUR1jyBzbmYzn3+2gfU1rXg=;
 b=VlXbNB4kHK6YfW96Wk7GUOG/qyKGQPDc8SndVO5LQTQYZ130oY3KaO6mIV7ULVykrV7hq+ffA0N+3P/GRN9P6T79zw5glqhikDjcGkV3lzZA93OQpGgQqKJ0/Ti+1vkxOzcwe2wwqUT5IMj8ofQ2A0o8+LFAwBW0Rzf3a4ZPur8=
Received: from DS7P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::8) by
 MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 17:47:21 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:8:25c:cafe::c) by DS7P221CA0019.outlook.office365.com
 (2603:10b6:8:25c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 17:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 17:47:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 12:47:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 12:47:11 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 12:47:09 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] usb: typec: tipd: fix uninitialized typec_partner_desc on stack
Date: Fri, 7 Aug 2026 23:16:58 +0530
Message-ID: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1ab08e-82e1-4817-f0c7-08def4abee01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	61BVl95uy8uyp7lI/P28OAxOA8gtJJdBLXU7FoaInPD8FPu+40jg1CMgwC7H//yjQsszxJqQ++tZCjM0McztCB1Zbw+27BNti/qYnO1tK/fU1C9Lk3jgYaW6RVng/7v7mc3V718FLrzV6eSqLplShKB8YFNDqKCqRGojj1uQNri/bXKEGddmdrZwiEQ8mMPAjNTBlB6G0bBAupdXR4RtkRll7levYqyXCMxyh+88oBsPhsLuKOcTj64fupJM50SPsFV9oIYm/++C6cyaFNUHZm0rBNaRV59U0iAhk1vB+zcCY/GHPG3oxXu5hPuNCENwFYoK6PxMkVxYR6j5F5hNYgtnhZWXBborH1q6odtRU1wgVqzNOVKv1uuEgq+JuTiHRI4rYFjaKyyaIH34QJt2ufQlXSmsDthMV1dDhgb4JnCD99gXH1OhL8a2SJk50K/xdcxcE9tVkv02gpb9F2j6XGXWJQeOsd9VgqzuwVeJ5n4lb97QmY7AWgBg7kBXgwihJ9XlAbBW82RkD/zGmkh0Fpv2f2Tk3us0XcN97SeZ58Bi70Uqg4lXUP+Z88dmie2CunE3Ojc5jZ1U4Pjlka5hoyxCGgOtYCZOJ1DbxeXcRh97/AMG+FoxwAy1h2XLMsD+wqEPus909eKCVOF8KwF9LIZ7V3BLC2mR0DsDnwJ8Xh81tMfhBeQ+cfH6Yqx7bRJmKSxahy+hj/7JOBYRMxeGqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N5hpU24faF++48Zg7LXMRIgJJP6cuOA8729tI44cuAizZ7M1ip00SC7wj+QfQttKsKaDw/akpDL8nJ9ihHAef4asIiuAZ/Ss7tc5RbpR1HVNqq45MVqd19lQUOORrCV5fXzl7QXKTq65KPytUv0dGB/rsmkSRuM5e4fV0XWQuGeLDEbvETeoDqfOy+ProqyeaYszsdn3+H9o7YzGM33sjfWmQXNfELafBJGXDvRR/CqcKCHahosqKrCqefeU5OgJYg6opsscQxvBNPmYxQ9903yYYOSQ22rYFoNLc+FTpGHVES5xZrHvay0JMe4UyLTTihvrxsCcCTDrLYlmac+tA5Lfwjemu01NjJFKmmdY6/9KdxjHaTyp4KVrJ9RbePzuUwKaUeszB62dCrjyISJYATbI3F8odwboDPPVxo7VnNE50WyHQK+omwyNv2IV5C6z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 17:47:20.2235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1ab08e-82e1-4817-f0c7-08def4abee01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514

tps6598x_connect() and cd321x_update_work() pass a stack-allocated
typec_partner_desc to typec_register_partner() after initializing only
usb_pd, accessory and identity.

typec_register_partner() copies attach and deattach from the descriptor
into the partner. With those fields left unset, garbage function pointers
may be stored and later invoked from typec_partner_link_device() when a USB
device is linked to the port. Uninitialized pd_revision and usb_capability
similarly leak stack data through partner sysfs.

Zero-initialize the descriptor so optional callbacks remain NULL and the
remaining fields are zero.

Assisted-by: claude-mythos-preview-high
Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Add  Assisted-by tag.
- Remove explicit indentity=NULL

AI code scanning identified this issue; the possible call graph is shown below.

  USB-C plug event (IRQ)
    tps6598x_interrupt()
      tps6598x_handle_plug_event()
        tps6598x_connect()
          struct typec_partner_desc desc;     /* bug: attach/deattach unset */
          desc.usb_pd / .accessory / .identity = ...
          typec_register_partner(port, &desc)   /* class.c */
            partner->attach   = desc->attach;   /* copy stack garbage */
            partner->deattach = desc->deattach;
            [if port->usb2_dev || port->usb3_dev already set]
              typec_partner_link_device(partner, dev)
                if (partner->attach)
                  partner->attach(partner, dev)  /* indirect call via bad ptr */
---
 drivers/usb/typec/tipd/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 522f56742aa9..d99a55063e34 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -344,7 +344,7 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
 
 static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
-	struct typec_partner_desc desc;
+	struct typec_partner_desc desc = { };
 	enum typec_pwr_opmode mode;
 	int ret;
 
@@ -355,7 +355,6 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 
 	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
 	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
-	desc.identity = NULL;
 
 	if (desc.usb_pd) {
 		ret = tps6598x_read_partner_identity(tps);
@@ -841,11 +840,10 @@ static void cd321x_update_work(struct work_struct *work)
 
 	/* Set up partner if we were previously disconnected (or changed). */
 	if (!tps->partner) {
-		struct typec_partner_desc desc;
+		struct typec_partner_desc desc = { };
 
 		desc.usb_pd = is_pd;
 		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
-		desc.identity = NULL;
 
 		if (desc.usb_pd)
 			desc.identity = &st.partner_identity;

base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
-- 
2.44.4

