Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E833D47C0;
	Sun,  6 Sep 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700809; cv=fail; b=BuFhywB4woLfLn4dGTa66Br3sOUHdDvGQLRGNB/kvbsVzPOFbXHnfoZGo83H2gFB9hp4MoM6pDQ2nmUniMrQeAxUys0mM/HU8ozsutunyrn72YCReX0PHc8DixzzBDIYJ6FvDfoD6qPoX+A5xCP7wqnJUa5lQvjIxYa1u8AFxf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700809; c=relaxed/simple;
	bh=eJnc6oiV5vfrHLEgz2SfxpGJTSCm6BB8mmlLe+dlx5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq8WEuRT143ktMQiEiM14Onjmx73s1/vB1rQErZQw+YxV2cOMxUzuGnJJ/jZ/An3eO21uhYrDRg5h2HGe5zgZd1NxAwRyGRZQu3o4Fmav7OUnbPsDCvQoCTOQntCwsS6UuE551eIQeIKhSUa4Zv9F9uKWVYfYu8mXYg+WIMW9+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRcenOwC; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRcenOwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgwdbcNYUwgrFsfzGyvROf1qjbhTL3gTHbRtn0/HChtMbgC0dWB7tjH/qTX9zPA9hO+IQKWvNy12zCpMteiGv5myFF1qyEgUH2ZQ9toMImmUb+uClgnKCC7MiCyomigwn65q0LaC58EhBl/3QKQxKcIvd+0Wf4ciTVAG8FJW0qvGB+Xwl6IGZKf9KIXcWbo3kXumItEgooM6gOtGbSSQVag2X2lILOSbFXYCi0P0+OAv4cyj3adp3cNKfvEVrVfcicl4FhpfWGetcvkwJ+W7i7D5BLgt8nGUlkPSlYaY4Gr20frvDNuz3w5TICxDdibNKLP0putpfmZ5U1zHMyhGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCjqqgGlp3eUQi/8BimMDcDy5aSOGX+yZ6OzR8lDt4g=;
 b=l8g2ViiCqjnMAXkbh8uQTSks60hg6ZgIGOJnoNJNTaEzf0eojfoDF2X9+ZHvwsJzeG01RBi0j+ujLOaQ+RA+QYl1omCp06mAzXx0zcY1RmZX132YnFGa+9/khCGymNHmghqhEkpV4M2ru5tebWgdhRCUUYbaYTv0gEGmqHpOct/mTPQ43TGogk4JefQkihHZiKydKIxZFBqE8NHJKEC5xUY165cXgIDhrf2VcH2Dyu4AccCio72ioKSeZSPMt/XMUQKLlxfT28X4co3BbJj0gnb5uGUtUCXxIDvPG5I5JsXAoQqYsYlWD9kDTFrhR242DU0EWs3NdX1cIars9b3dnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCjqqgGlp3eUQi/8BimMDcDy5aSOGX+yZ6OzR8lDt4g=;
 b=tRcenOwCluL04dy3cAPkZSxLp59jcrevf6GFoCLfrwqaxCKrLul4Z4MCjsOmydt+vbbKt721vF4e/sLcqsK5B3bHQ6k1vwLMHkQboJ8mPeEtzXrtOJBdXvPG8IhS2dgwt3Cp58kIvLr5RzuF0njbbkN7XyOCy9zZJMQxtZJS0bA=
Received: from SJ0PR05CA0207.namprd05.prod.outlook.com (2603:10b6:a03:330::32)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 13:20:02 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::40) by SJ0PR05CA0207.outlook.office365.com
 (2603:10b6:a03:330::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Sun, 6
 Sep 2026 13:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sun, 6 Sep 2026 13:20:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 08:19:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 08:19:59 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 08:19:57 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<sven@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 RESEND 2/2] usb: typec: tipd: fix uninitialized typec_partner_desc in cd321x_update_work()
Date: Sun, 6 Sep 2026 18:49:42 +0530
Message-ID: <20260906131942.83153-3-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 216437b2-976a-4744-e83e-08df0c198dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|5023799004|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3waRRIpbXvNLJcSh9P/ktpgiXKrOgPFXn2X9GAxuRGIFZ2wNTczYy7Ikhh0+FAD5Bds3HimbhLAkqwruxdCBw82sQ9FB8OC5KVK/5rvpja04LVQkRNTpoinLUDJFQD0S9e1nnRYXuq94UMA4ibK0ErWcoNmrwwGwtCxstDNEgdCfQJnRh4lxvPoxUtOLlyRnpYyQUFza2T4Xb//k86WcqkigCRI5cGCpEZH0yRbdPd7R/yZ7gQEcNQ/E9v+i7sBqVt8MN/gdEB1wx1J2duVDqgG4U2hI47an70GdcZEOTq5x1xSykg8BP185zMO4dTIHA9Yf9ghi5MTjCjxG2n4SUW95P165CcfPgFflsN24ghV9yEr3hQZIsebIwqIAmD8y9mE60fXztLsqosaSDI2fdRPEYcX1EGPCXMU9TiWzTRkEKDrZxDYCDYPi0DQeNknB8kUhCm9g566r+N7dsHamGNMMn/WBrGfIH0vKjxZe4SlZWr+eoqJeJ8oySuElm9UMlKS6PjOBbJYKiqIQfhnk9E/Qsvm3u19plhg/f2BeadxV1oRvDleGH+6Aj52DJv6kL76SsyZ9zot7w9evBC/CHkQLmiv2QoNutBcKULZwRze2cAL8tJydMFtqj+rbo5MGCLr7q5Ef5JhPJMEfI0lJap9bk0TwX8Mix1bsJ3AkfSdGYurxjnHrBNk6h7kFY6VcBTn/pWGgIYTYtEKKOOIL3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(5023799004)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gi4TWS56qGyS8ljPiBdD54X0ItP4ddt5C8R0RZPLtpuKa1fNqAK1Efm1ncHe7piKYgWmLM3rRJnSBfcrfFn0MJ7s3gh1De9twf2wUDpQh/AaxgWS2YGrzXhb3DnxMKYuqNKV9Jq4o/Vnm9grKEak/Kp3Jtu40eJnKYQH3SsLAztmoK3Iddrp0mWjM+fG2Z2IivxLS+HfBug/m6iCic5Zxqf35x10bqjOHf4xOUvHd5iBdR1/YMt994h+QLgU6D8dh0bEAsJP3McOuZZmZ23MdWVhwp9gGCjEyPUsJdDlJN7eEuRLPFp/t23JGG7fV51j/gKIgpCnw7wSkNO7YWjWUYmNaNpZhE9FMwavmQ+jwHeVzfsf1ylM/AtOK1EZJt4Gc7qv8ninTqBH8cb5/Q2eU8kLOh3wBtlRNv8KVAMuYnyyOktg4olivyt0ueaB/oxZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 13:20:00.1348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216437b2-976a-4744-e83e-08df0c198dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

cd321x_update_work() passes a stack-allocated typec_partner_desc to
typec_register_partner() after initializing only usb_pd, accessory and
identity.

typec_register_partner() copies attach and deattach from the descriptor
into the partner. With those fields left unset, garbage function pointers
may be stored and later invoked from typec_partner_link_device() when a USB
device is linked to the port. Uninitialized pd_revision and usb_capability
similarly leak stack data through partner sysfs.

Zero-initialize the descriptor so optional callbacks remain NULL and the
remaining fields are zero.

Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
Cc: stable@vger.kernel.org # 6.18+
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/typec/tipd/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 525b4f2ba128..a3d9f20eeb04 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -849,11 +849,10 @@ static void cd321x_update_work(struct work_struct *work)
 
 	/* Set up partner if we were previously disconnected (or changed). */
 	if (!tps->partner) {
-		struct typec_partner_desc desc;
+		struct typec_partner_desc desc = { };
 
 		desc.usb_pd = is_pd;
 		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
-		desc.identity = NULL;
 
 		if (desc.usb_pd)
 			desc.identity = &st.partner_identity;
-- 
2.43.0

