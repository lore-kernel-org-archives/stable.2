Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74213D3308;
	Sun,  6 Sep 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700807; cv=fail; b=i3zyqnZVaE/hk2V/6YMGkpxQzBdRdQZh087ipBG2Orz6UnyLclx11DFktizBgWo64ph0Nwo04xdvwc1fiofAu9U4Qz4GRuKkQV+iccoXklbIGQhLilq9Ekhv+v5Y0ZxtyfqFQ9MEmfjylek7n68oKAyhbIraoa+E/uOBjavZQf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700807; c=relaxed/simple;
	bh=nWmHKTnWK21BCcOexgbMbm48smp9qbtBr7cnWSWdVsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhxnStg4qJMdWlTP7wdYH9T2eb4Rlw9Gu1EIenoRGR2bMK9yh0ht7VNIfVyPGQDYhixmf8MkFq4ROK1eNlr7lDrrY+IJMEglrYUCvv2jH9ONx74lpraHttagDBTPHpo0IgyHwDK5IUA7iDSZ3hBqUETXvDAASKkT3I+ViciOZ7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q2U1LTHr; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q2U1LTHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKhrCeW76bAQDXjkxte4PIXq5r6Yc2gTyX1yZ8bUv922wsgu6USGbsK15XVZ9m8iIpaN3AKnhyrInV8IloQUEx/4ifAdXgYXaZ4gpGvFSIpxPksVn6YK+ncGPiE2TrD9qvam/Y6Lcg614KmrOxzWbrnXpGV/jJSkudYce2f1bY4YnXfxDhRVYl2CAaiSTc1sC5VoZbRVOTrQvaXTweib1I149vF8EYc0Y704AFVME4/J0slwbsLF7bT3mXXWnxlD9tgk7CSjHxEnD/p73sAiZrVm7rdJ2UdhXh8Dp9J6LC49s/3pxUvYcJgWLvSq8AFHEslrwcrwZdkC90Tb5H93eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81oW6uX2NhxZhc2FXvAzfSusXHqyT63oJ6XQ/Y4FsF0=;
 b=BNe+JYGipOLnWcGQhjkiXDV1ecGkUg15v0p9+PY52oXrMo9ABfrm6jM5oQ/pN3WOF6KyhKLQv337EwIfuqFkX93/0Km+xm0UMV3t89Cd2VcwPfXAv0r3ioJB/ZnJlPE4yHAYx6exJ6qCdkPtSgeRBtHVff47lHnTdPg5HE4y4tTSX/7j3pFhIIZhQPzVds/Xc6irG+lcWgbOIV2vXSFFBbqdIBsubE/+QfcM9Ma9A+CHBALr1HdJpCxilGr8cW6Qx7KM7oerRg8rMl8IuG9sJyTaS+PGSi1abUD/coOYWY5MS6zIUQcEN1zk8L+qDT3qP35nAryacXskAhidzjcWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81oW6uX2NhxZhc2FXvAzfSusXHqyT63oJ6XQ/Y4FsF0=;
 b=q2U1LTHr2a8KudxfsxdNgGLRIgmR/SP9hp3H+lo7reDWEUqll7EXt7hOquE6yzVthATmYsgjdJN45B0lTT/LdkTzafRVx4jDoB1jGrhJ/vSBemfajBrUyIvF9b6fK44ShOdS9ixNTGdVlrTLsqZsTUWeZJGDbxUKfsVgNVd6TOA=
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sun, 6 Sep
 2026 13:19:58 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::4b) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Sun, 6
 Sep 2026 13:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sun, 6 Sep 2026 13:19:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 08:19:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 08:19:56 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 08:19:54 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<sven@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 RESEND 1/2] usb: typec: tipd: fix uninitialized typec_partner_desc in tps6598x_connect()
Date: Sun, 6 Sep 2026 18:49:41 +0530
Message-ID: <20260906131942.83153-2-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906131942.83153-1-radhey.shyam.pandey@amd.com>
References: <20260906131942.83153-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: ed54b3ed-e838-4a46-dae4-08df0c198c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|6133799003|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	j/n9ku4dREdQ1VHKDNjZx81AdmGuUaT+9c8OZ9OXuoV9SBaN4lYu88Al07cey0WNWWye7D3M4Vm2uaCp6hTsr/LHryU9p49NKXt7039ku6r6RJVRniInF7AJ2kXGiBfmyusXHvNKb0MoR1tpjpI30IKGgn9FjSGpYAiX7wkvtxbLgpvNwrrh7UOFZRracFohCKukh5fIMLntWkF0ZDCCcyNWk4coC0oAvUBxhl/UUh9yIpSVr88/0EvnJa6I1isC3fn/I5bexfkTSLJJdGf2r+0DoBEHx04AyvCa7/PZPhmPiYfvRG0zxIboAIEJBnDIQqNLERnwlpKt4pKhYHiuceeMao67UkA/HrnLao8fUugunTTK0/85fRkK0op5hMQj8r41P6V1s2XyABr+u2k+NGHVdNTAnuW7Niaz1qGO/GHqppjqiReN8yQmks4tq3BNE8B146wsv40RBR2NVg+2VfLUyMGejWP7tPJvvCM43uDxAiWZDF9FIoyY2hRVlzSNTFssFsWHlNg2uiF3C9GR0fOR6iBRIR6rzSAbunMBcHYqnMLdQ2DE9MZKHQfJXiSrstCtz5uhurCrZyXQb6Q/3llPemw91yiJrtieurH4BGyAa/ZxMo24l9fTeNXWJqcCR6eo2zsqXdvxgPirI9DdhgHuKRKcrk1vZ9fIN5GCCF8vUfH49PIagSmPNaA17jKnv8KkMvbLU9zoszDbmdGkgw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9VRLQWtePbpTohp9BpS/K9HWtg/ZwW4ptklRlo1MpTpUSyNMUaxiF1rWJvqjq8sbY8KDOgmkQ/OPveQ6cZZblo9e07JoYK6M/8M4kD5VB7n8bW9ECsWioBgxXrAuegPWrpHeu2o5e0shvvN3gfTK1DS315MkOY/VoOskA/7T7+XJSpk+R4MHtTfh+X7XkXOetDw44ApT1An9Wlz+/90rVuFg4Tsr9Lh0dS33MsS89sF8ViMBgujnyI0K3aK7JftFKi1cOXEs19Rmw+1U+tuv4PBrbWY0ttlocaGzEEq2/CABEQl8PXq+DtV6L4Fqtalqybj+4vfoAliID62Ebbq45k3hUzuD2s+6haXN1RzgsF9K7eF3duRkDCQ4zwYU/55SLL1MLXgVGjM490/SWvFxH5a0dafyFBH2d/w8dFvnR+rtOKGuUw9EpLX9fBaoGc9+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 13:19:57.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed54b3ed-e838-4a46-dae4-08df0c198c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/typec/tipd/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f76f563dc42b..525b4f2ba128 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -343,7 +343,7 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
 
 static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
-	struct typec_partner_desc desc;
+	struct typec_partner_desc desc = { };
 	enum typec_pwr_opmode mode;
 	int ret;
 
@@ -354,7 +354,6 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 
 	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
 	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
-	desc.identity = NULL;
 
 	if (desc.usb_pd) {
 		ret = tps6598x_read_partner_identity(tps);
-- 
2.43.0

