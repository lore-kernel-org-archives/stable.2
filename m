Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346B285CAA;
	Fri,  7 Aug 2026 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127013; cv=fail; b=sAFns7AoeUqKQqhMO4qR98L+JpTt55IQsvnFK8KPLw0KZm5299wj4znoWNRopXl0e7RstOdMWZC40Oac2S9j/PWMHEtnrGHkOeZRfnDLRV6VHd5swAf+mexiSoCTyuAt0frSH6EFRQ1aBhFoxYmGBL9+wMsFpuyxNgfe+bO2zrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127013; c=relaxed/simple;
	bh=+FScmWliC8LlU38d6yBT1pHehQuVXN6DvhkwfmKe3Do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9ufby/wYRQDR9zZEKdPe5GrdDEAPdqX67kC1Tvi/Unyzfzdgzy7DKu557ZNLv+PObzT3bShfJlE4hwsZTCRCbxoJdPltRX5vjzTLh8ntwjkw5EdEcGgbs/eKCr1x8+/bwdZqtICCn/EWpgMejqawsme+NkxjW8SodG9fe9WVhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5pddWDzY; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5pddWDzY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb/jWydlL/EOa2YnlBkRyZ640ih7MUQ7mkmFb2K2IxAJtZnTEDG8TtR4B/ulWchenAloePtyNTqiB3j8zXeWPEI/7hiDEHqyPUpBNH/3WfJE4bgjVI+9B/qfexy4uW/v9XaWhJu0LHV/37M4ui77BXxuuDQhnFxT/2Oy2UQdPwS4pV6wAPoDAwlaGH85MosDrP9Q6IH6oySABuhjB5MRnNc4j7EZREal2hixAdwucDkZb7awWNg7fhZBc0zR/siWV7Ay9SELuiWr5ETkYzMZJF1TjY79gZG2iGYp5umPX07YJVpfqrD/iHTqRWOgiyEcYNVioUK5TXlzsLLY1i9Oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHB2Armig0HCvseXkKRl5ZOjKFZwNhil1y/2w2oM/MY=;
 b=K9vNYKXeDt45tImXZ3T1ckv9bnHWdNBu3k05IWowKIcqvyB5eF3fZw1MCVI2/9FFoJGFhXK5iROHRYJnIeVv4eC2bTL3yPln+XJfbTbgg1Tii1T9PZurkmOmLat+vXoYyUW5QjvQ6xVLUjBtYk9O4pr/NMR9wgixc5Vp3S8PuVsSOWKHGDFg03DgsSW0DVBVbGnSPXfIq7ubUy/FZPI1qdCoGk29D8vNp/gpnfYeOBTIxmR11uJiRZKFZjuKW5d0ZAQNmpMWiUdTGhD6ZrVhGlIYos7MM+0TuextKAlTzvfbixlv9yd6e1VNn4tf6+FdeJ1iuaBa9OtgHZ18JEkbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHB2Armig0HCvseXkKRl5ZOjKFZwNhil1y/2w2oM/MY=;
 b=5pddWDzYY8AgaSTth74LMgBy3t05uIjDk0umJwQOccMbpR4HAz+kffUfRB9r7ismqFDOs1T99UV66g/I5oLUbP/bs7/RRHKxD7m0dhq5LPWpGTfuP0SqpT7LJfCI+oE0ZudhJF9ymlKxTJeaF0rKm/WwrkvfgIWrQNP0P1j2c9A=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 18:23:26 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::51) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.8 via Frontend Transport; Fri, 7
 Aug 2026 18:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 18:23:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 13:23:24 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 13:23:23 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: gadget: cancel NoStream work before endpoint teardown
Date: Fri, 7 Aug 2026 23:53:18 +0530
Message-ID: <20260807182318.3736662-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 712f6fc7-0d2f-4e57-c72a-08def4b0f86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	McQmASH+BjHxnKHNiGBMvKUkdXF3e2V5LzqkDunQZ5Tl9WdXrdh5VRhVhErZ+QtMfHb6SXpTSQ+3DQ20XzR5t2QKKo1pe5hwOk9h/DStNFlBKf/iIsTiDZ/uiGwn9X1ETW0YIQXkzBaAbt/vIw8LLcIB/DarH8PUQ0pRGJjfhRuPelBI1j86Hcu7ZU0w3A/nGiV/KDSPMJ4Ur0awIgYDlZRCIcegZ2WprRYnKi3pKuK2s9aShZvZIaAEV9sEKTBq5PnK8HJ0jwwiTT1WZQv0hD7tQP4FzB+zAfZnwGuGUYS2okWFWMFnfRitPF1D2eq2hJTpSWwDm3Xs7P0JVykGgCIO4gEA/5YsE0QkZiPdeQ7+HlpdkDCSc8aERGCTau6GgIdKhSvKySmLSjr2X38gOo7vOcxP6SLJOxenLUr2bZRnLZpehvgM0ZmM8ZaIIDrxJwhbo+vjVmPBCz3E8paNl5llIGbpsnm1KzuJvfkYBXE0EiYPacDNfqDd9pTUOdAqu48mGC3wAlq/rN5Q/RQn4nNXoChQK+qatz/znnyiwzGN9RQY8WgIZFuTrrzbJqOEYSxlvN+EJ/h3lmninGvLCjjtw8mrhB0uVaIpC1iCMQGatQ4c36swEdnV6EukhXIQtxdBxsVOkhCVNlJ4JP8SVd5nkfAhp3OGU4oOjG3/na7E5NFwTTk8opaYqABC+JC7nfhpPoAmJot1clvnGebdEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dUdfHvy4vt05Jek+2B+UbU71F7uQLNHUWXutRouDh523UPFRFyKqe6hNYfeNVfj5w/Jx9Fa0OMr0BKwt9tNdETmtsV0UKHVCNS+2BHOnla9CkGDZXNw1jtIQdrwIonDeICe3Fi9zkwMUiJW86P7VrJLrJRTVpnzi2VSUOXcY7EuWyFgBFfTiq1AjYKtC4K3JvAlophAi7hUF3jjFlrNwjdUDvvZKomlyNXdIWRPAZKMy1QDwZwLyB/nFStZBQnpnWA3bwGXeMmtLK1pp8l/2aWZn5k1aJXsPHlPgiOIvHjA0eed11bLR4jYChM4xagA+zlWOBvjQZNJnHzHiuaSrfzJLRFiI2IP8/2o95Yip6SEcPTvEWkx0xaX6CGXQKNv+W+3kdw+xi6QJrOdkaJCK951A9FXhEJ9pBBJ30FdAZxxXPkmF05h4v2LvEscwAibC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 18:23:25.1903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712f6fc7-0d2f-4e57-c72a-08def4b0f86a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

DEPEVT_STREAM_NOSTREAM schedules dwc3_nostream_work() with a 100 ms delay.
Neither dwc3_gadget_ep_disable() nor dwc3_gadget_free_endpoints() cancel
this work before freeing struct dwc3_ep, so the handler may run after
kfree(dep) during DRD/OTG role switch teardown.

To fix it cancel the delayed work synchronously in both paths before
disable or free the endpoint.

Assisted-by: claude-mythos-preview-high
Fixes: dcfe437492e2 ("usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior")
Cc: stable@vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..ddf1e262e2aa 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1175,6 +1175,8 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 					dep->name))
 		return 0;
 
+	cancel_delayed_work_sync(&dep->nostream_work);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -3508,6 +3510,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 		}
 
 		dwc3_debugfs_remove_endpoint_dir(dep);
+		cancel_delayed_work_sync(&dep->nostream_work);
 		kfree(dep);
 	}
 }

base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
-- 
2.44.4

