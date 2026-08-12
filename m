Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1046F486;
	Wed, 12 Aug 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551322; cv=fail; b=ZpQLmGoGgrnKH666e6lFypZ7iVLI8gNjHU42EfADyxU85rcJ6qBET/K3E0jNB4azIfTikU/WrqQ7hbwPndzInmD2dMgmQ9etsoU/R6GLovX1og+pagGo8szWbfu+I/ZbY0Ft6gbmUIE9QInFDTpRI9p/ZhnkJKihP1RB2FcBwy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551322; c=relaxed/simple;
	bh=tNOwDHnCOFm+OSUCEWNK9iaSp6Q/SPAZag3PZRWsAT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlOowTFVTGm+Ejgofwm7j2VDVm/zec4JmOgWZedXzsNIJd//Nt2eRNutGfaXUrGuY0eNCLYCZ7LmzDe9TyD6EDjMR7yr2u7qcT7/9wdtmP9NBoZRDWggJbWjnBbZC8JPCIkxve0Dk4gsORCqP1xD9AdiGV02iwfCB1MIr0fPWKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCuDyrvr; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCuDyrvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKgoIL4e7rLwiffL3rBcCU3HvilSzlTPItooPITFKKvMKgb0R/DpBJqHT68Uhw8BVLTK09Obvo2H+qDocl0DhhG6w8fwt30NcG1MDCW07ZGLZwk6Qo5isRghzMDnBKsIT0x6EHKXqVTd2bngy2l7yJEEM8Y+PzeCWWbPczP+OjqTVCvGbfP3Ou5jIOcsfcRgEZ6fChzLXAT5bmduW4Ae787PRGmuCRKCxzw8u74NZoTqY2c8B/dYHnCuFPVt0uzX9DaVARDpSrlYyk0WWKa/bAW+8iqpTzp/Q13BLncJQsxPvc2quSY6jLBenJos7IUNf59ga0XtKpOvKMW5YT1jBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTNUQezE40TqpYc3wAdIQ4muLTsQRK4Z2ZrU2wSFUog=;
 b=cdtbAPX9wITB1JPd5P5Rx2+UXR80jGPklSzR4uQe5+DimrKlb15BbSCQQsxSGGotFXTWHsTagG1G82FiVjdnn50v6PsTwX53OO2AF2obcrd6/QUUojIEypdgEfBIUyR6ogUdk/6Wo6OGlXWIYBIH9m4uVCVF8gJ1zYqx85q9IT8pwjAP3+DxumuM2ZAQj7T+Rnjott8CrzVCQMw5fASpKj06gvl4hbdLckGhd+NHPkT33vxB4ghfylib9lK5NCzwXr3X+xHOt3c5c8IRp+ZUw/nHsOsvLay3JJC2xfnNA+OUwflf8/7B1wm/bYfxVjxUsg8Wrf9ztu0R+gOf7u25Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTNUQezE40TqpYc3wAdIQ4muLTsQRK4Z2ZrU2wSFUog=;
 b=QCuDyrvrvQen5rBjZrLxzhz0DQyeyMf+M6stelkN5uD3TKBeSD+bdvz7ffcFwiqQ9S7vrDcLrL9hcZsZOljGoh2XkQ/ppDjUVGxdyl8T2TyesBNes99uJXyl8j9BBRZF8R7wjCGXQDEzVZiDXNHaa7c2HEMZMLWjQl1wEUquIgo=
Received: from BN0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:408:ec::32)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 16:15:14 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::34) by BN0PR04CA0117.outlook.office365.com
 (2603:10b6:408:ec::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 16:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 16:15:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 11:15:12 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 11:15:10 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 1/2] usb: typec: tipd: fix uninitialized typec_partner_desc in tps6598x_connect()
Date: Wed, 12 Aug 2026 21:44:53 +0530
Message-ID: <20260812161454.149606-2-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812161454.149606-1-radhey.shyam.pandey@amd.com>
References: <20260812161454.149606-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e927004-ff22-4565-0ecf-08def88ce3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006|5023799004|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LRjx+0tLKKb6Vm2bG9ERnJVlxP6SBvlmSNl/+t5tHCeRA23RxM4nlwZZpN2BfX5qzhbazE7HzMk3beo6pFbKi2OUv0/CQ7BFnTJHlHtdXy1BhC1Z5MS6Hw0O9WaR3/4NVXIe1GoDX6yhCsf4B0tYDen0uKUQMRVJ8oYzvetNHJhviPGfCLvH7Y6hK1Sa8ekFV9HaJ3sU6L/QqiZllufi8zuZz+FEpNBVdV+63cDLTgofNBCuCPFwqCLt1rtePOzHXp9mRugU3qoIw/Et0i9hSqA8tC3YKj5vQpH+vTgydeWdF7jvfUFZJZ3Kc2gUHKew8Dz4ShaIv6Gb1SQCCzDWZwX13pFcv9D8KUfuBAU2lKrKBkiV8bauBK3/9llU0x8ZwIOomFjObNeyAtUTNP6qAYJj/mqhuhSl0K4ZOI5DG8xNUVaUp31BFatEZ5FXlA7WhXF2xylpxBWCk3Dp3/47a7l3NfgjfCPZcl42ecCZgUhhoLqm+oi6Ci824z7zcsxvN0sMIViVPYpg/uiV1KoqQ55ymOmZNATfcJKPXNqggMGb4vRj9X3jxPFy+uYVaUrJMf5es2iaxizmHKQBW5ZdNbK6t/yHSAQ5CT22eU8ZEHNCQd3qm0m3XKMkfeWweu183dH9R2y0qnwcgFH9YmikvfP4CUyMBBtu58bw67fNUYyu1Su7eBdX5VUM/QbRPmcol+I96hHklyEHuzdShPG4fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MJ5qZYIMv+IpLgEp/h8SaDk1Zjq+3EfUOAD5ghJc7Q2gLLUazvMNU7wcjU9BiMFqLySzBXtgBUmXQn/xyb/WdTf4SdeacYe9wEXhQMNA5uL6r4P5+HL20YHYt/Ude1yCCNMQjlB7IUCYheyUBUIn0nW5lDuuDI+elYjyYAmOLhFpY9dLocjiLkf+M3+G8uY2u3zKXFXJ7SuQyc4rcnldYSG0gK2QRysTeoIWVLUgAGAJuZFd4mw5KSikPFZzNHdlv2SIL22HoLjhVoMCog8qaHKuNC955eFU3REE09H3+bCRT6jd5GTO1ErhXyXfyovppq48KL8B2fGXZuifVdYL5x7GPXqWb1IWGGQKNnoOJDToBZYebCeugLCtEQvwBZ6g7oUB5riZ453J+JcsE3RJ//FS2pfXKPFvGyLC+XX/Oo7qktPigEBm8gxjmWP07ZaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:15:13.6426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e927004-ff22-4565-0ecf-08def88ce3f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

tps6598x_connect() passes a stack-allocated typec_partner_desc to
typec_register_partner() after initializing only usb_pd, accessory and
identity.

typec_register_partner() copies attach and deattach from the descriptor
into the partner. With those fields left unset, garbage function pointers
may be stored and later invoked from typec_partner_link_device() when a USB
device is linked to the port. Uninitialized pd_revision and usb_capability
similarly leak stack data through partner sysfs.

Zero-initialize the descriptor so optional callbacks remain NULL and the
remaining fields are zero.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v3:
- Split v2 into separate patches to simplify LTS backporting.
- Drop Heikki reviewed-by tag as now patch is split.

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
 drivers/usb/typec/tipd/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 522f56742aa9..54ca726c3b15 100644
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
-- 
2.43.0

