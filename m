Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DC420881;
	Mon,  3 Aug 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777346; cv=fail; b=JxrwIjX4DsxUoKid/JMYsDCnSPj9byO4OVQWaodd2C8Nh8TKfh2XMVPf9NqAOn0kTv/SKk9i5mIyLoqHarSVRgFElWfzem9ezgHWi5BZWcrh5wk9YCRSaoWoJu836XQ7NrTqbo7QkITRHeU/eCD73z87W2EblBQAZA716jTg/2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777346; c=relaxed/simple;
	bh=7Pu7XG1gP3nIvY5JYr2wfI9DY7BR24aKO5/vjMCgt4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bg29SkEkexV/HgzQggAKbP3fIGRPYczpGQUOx3S00vny59lW1Gw/aD9nAmF395R52OZLdaHb9xD7e6FdbxotZXVXW2xQ8ppJcQh9QNyVHlkZFpPvNIzpnQaJSz2riRrvd8Gzgx3viUxWTKEGFRSlf0Qq83kStSmOHkGy8T6mV2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WEcl+uAn; arc=fail smtp.client-ip=52.101.57.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WEcl+uAn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRAiVNYnn3OjqmFzC8kEPM8ZVSCfZ+9qTqXxTagwGGlpPcplOF9x66Z3gso/p2J+9UhPBcutyJQOx0wmFl3c4tf4wN+IzrctKvoVlC9vaO8cYww47GYy2ijI2TtSDtZ0L7N1wJrNkSr9Q5hTopxaDj491tR8YfIG4h/zD7k1XymXFj0OiTofLeQX7rNPDNlNsjyLpMoKGI6VVx0t3MwtILjRkH5mlwzwYzuLLpc+4lmeFDsrqYlEXrv6N80pWdVW1ek0SbCiVvoL+Am2Tk0Y2/8/hI+iliosI/kGjoTnRzxL4Gfp6+Z6BCf3IkIedMH170rUDiEhwLYgBPBZQMG4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wykev1PUiaJbIEjtawNYxlljCQLZ05F1VeT8LyM2O+g=;
 b=EWoe4bMMNhtSRTJCGWUY/Wf3wNtKvzxmO0snHzi4I6OgzmXVYgsoe37EgUh17urIIUOAO7JH5UvTxCiPrFYv1sJ4ezdtnU6nxLv8/KJs9k8ojUB4V9MYkcRMNs+9QkdA+MZQrznhAtEeD3rM+gAGkv+0VMMpm07Y3QxkJwGU1MNgCUpepRr+nW55/wVMhq4ZLaNeqYo940OOJpJ6C/oh7pkuKHh8Up/SrT0Sz/TXlVA3EiIUjGzn4Qif+MAHFwmgoQQsIsuS49t/WuY+BwBdxNOY/xoBCX9+9fO/SEAVvlrOJ7uBgbiATbqgMqISyi+7NLZUhOJSyM1UX7GW2WHY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wykev1PUiaJbIEjtawNYxlljCQLZ05F1VeT8LyM2O+g=;
 b=WEcl+uAnZDe0qdxEfi4MDelCS0Qz/UF8n9Fx78pvXV5RSmMtjwWZW5baYxUaYO1/Pu+feYTbrHaMH45n2ecAcuT2XeRdJwqFqfMt9WDGMQHcTiOmfMdFthJb3kEf4O7H0SedAf2BOay89HyzrCRkumU8Q6iFnmjqdHvL8QLyadY=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:15:41 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::59) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 17:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:15:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:15:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 10:15:40 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 12:15:38 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: typec: tipd: fix uninitialized typec_partner_desc on stack
Date: Mon, 3 Aug 2026 22:45:21 +0530
Message-ID: <20260803171521.3381942-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6a14ff-99ce-4e34-4982-08def182d85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|5023799004|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	psZblhvFldJ8pQOHanOWhcqY7DfeumHyL8kpB5J1dLj7JXpRF/iDErNoE8D/Tm3WoSGpjeueHNheiU6n9SZeqA8eRuzJhuvdiwAEA0mLqwLOkrCmO2A6l/2juu1XKgbuLMFrrFzFQNeBVmxP4uOfua2dme2nkSaudxsZI7+LEjqoai0H79GRAYtpa1/QYKumf7n1Lfi9H9kAeadvJuQFBvdo8yooa1HD4QJTNXqw5WapTBZF4+mJU8zFOWAKMHwP2fW+CQqOV5+TWtcOvP1Cba/YbL6gJlnZ7B+b+nAJadsdv10uU0bUM2QHOZz0O9Eoec4KrcloBnDwBdgIp8JaJgOuR347A04NxY7kWcWdPbcXviRv5x+0JBswg3eJDz8aJlQ9aY9hoHThcp11W7+HhFIXOwlAuVFEMvdRD/mtdUwTfb1pJv9TjG3DmRCvfaUfYfVNTcbDygknCTGKB+t+mnql11EliY1CB7f1nSb8EcVY5ssUmAKVkCoxbe2jr3/OPCHzrxFdO8NwimLHfb/Y8TT6tZbTDoK1VowlKU0YNWDMeWc3j5/7ecaErMDPkrTbZTzPzGRM2i3XiXOUVS6Pu7qUnUe1i5Y9sFo3WB05PU+/naMiDglKlglslA49UITCZkl35i/Ss/s/VB5rtTzOMzlxA8RXkNtWfCmJ2Sp41LRgIlDzRCs8IvXBPGAwuVozM3qTDjz8s6xxYn9/SrkOeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(5023799004)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pTcWhnv4WtiR2pnu2ui0dm+YwO8N/cJUFfuvsDE/aAd+9XaH3QIXjeTNtD6uypydC4zKXkVuUyIPxv4cZXN/YjHmgTH5wjUxF/+gZjf4L90SpH7/TCRAdo4saSlViNdR/9wRcEkX3O6C3rFDJIz0dv1NoUMSZb2N4ef6Y6+1/8fjvuNhnllIeetBVDmRz4G9jMiiEoyqZybc7KFxnqGuUD0EnTZi2bHv2KuLv1WD+2/njeX32zsLbSAkYQpeItV1Pa5LOQEjj3NSbzYEBBUn6EQMMvYIhYdF4PnBLpOkAtSqY+WQ9AMnjIJ1ls8mPh1KR7apyKSv1UTe/KOmfUs2jKdMUR5U81bRpwyKFP6EIgAXJVAjnxJOlNEpnmOHplzahDjeUZNEpyJphNfdEcm7h38huNOr3M0Cyv04Lwf2uID1Mwkrtuc3CphqbIkwAeuB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:15:41.0670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a14ff-99ce-4e34-4982-08def182d85b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641

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

Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
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
 drivers/usb/typec/tipd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 522f56742aa9..1dee1084b02f 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -344,7 +344,7 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
 
 static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
-	struct typec_partner_desc desc;
+	struct typec_partner_desc desc = { };
 	enum typec_pwr_opmode mode;
 	int ret;
 
@@ -841,7 +841,7 @@ static void cd321x_update_work(struct work_struct *work)
 
 	/* Set up partner if we were previously disconnected (or changed). */
 	if (!tps->partner) {
-		struct typec_partner_desc desc;
+		struct typec_partner_desc desc = { };
 
 		desc.usb_pd = is_pd;
 		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */

base-commit: 415606a7be939835db9b0d6b711887586646346d
-- 
2.43.0

