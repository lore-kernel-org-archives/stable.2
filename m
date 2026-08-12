Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DA38F64E;
	Wed, 12 Aug 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551336; cv=fail; b=G95olwJX0IHCh0IJ0XGtKLIMJvOkvp7++PRK8CsLsUAIIog2vl3I5miFvBE84Iw9lr1rwEjnEZbWzzQK26Qzd6GXgZNXFqQ7sMEk31roktMBTou5/7a/PJ7KgDYWT3n7CzJB8WUq41RrJMYgw7N75RPUvWwWKQinOXuuymOJuwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551336; c=relaxed/simple;
	bh=FVeYfhvEsilNBg9TpFRFjSp8LG0uzJ6eecoZ2BTzlMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2XwcTT1KVXqksXgf7Dd0iQEDDX9G8GeKcq/2EoH6MaTKhQW1ujke9R0jI+nYh/BdsCZr3E3hPyjL8iabjphDS7rEW+V4a4rj5AVsfdJe5tp9VmFISkSLb79vKWPbDTBdcQfUhlJvEJuBE5uYARuSxJnMlFOMZbhj6dQ4Aek1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aaA61mHj; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aaA61mHj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTps3kD1nPiN2iGlYpkIP+3HPGojXs2743FbbaFJtdOhKcr00qSeSBBeoJrrA4CebLHmrQ3QLgWK6XpQWgCTKAR/JLNF5bJYG3Pg0mmycvaTLt0zw73wsd59E7FBzFCyFQUdsq9a4wlno4ImDcAUFouI6tZtJLx0pnz7PRkq3bJdww7KYI2SY2AqW8fBjyVrFdHrTN40g2qda2J8GqP11Chyg8UUJs7byfuVWRnZWNDoqeW0mBMGFhYwSLCwHHm/IKwG/Ybf2Z4GVV+Vpj/PC22GNSgMYHdM9epJ6alSXIxhtpsZdf5YeIo49TSHEkAfGyFEJAa5IrKYFq5HQr5qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXVsz+suNHAcIEQ66sEkKuxzKty0x9EfvQzlPTU6pPo=;
 b=Sfk0E5XHPWGEYowrgWL43bAB3m+vh838oJnrziwxKy33EuA5zFp4PCAazGiPNpypIkh+zkM5+Bag2lA9bNhwXboaKgThutM0m114Lg9XIk/A0bwSZ7GTs+9+OidCrdvEgmNLvdwseiEqkYf07WX+5IClbBwUv/V8PfGLOUsjm8n4fclfa1QzQfjchvXeyS7a3MYCKYZkQHrgpImTkxA+wn7otu60wHUstU8I5zO9U54ooYgvNuN5RrGOmygWCzf5hzSkcuxOsEZHd2BJIfxpUgIA0z8tNbTltNvP7Yr4FapWFkDrl9R/jXHnwru4c1cc29p090CTDBCf+9s7rS/frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXVsz+suNHAcIEQ66sEkKuxzKty0x9EfvQzlPTU6pPo=;
 b=aaA61mHjNPIALVoDnglMfL133oPXvAyMYleGFmzLHxgLrn8UZffILzCkWz9h2W0v5Vq7mFB5rGwes1k4IvzlEdqiNvjDYwaf6WRPSvIeoPa1GDWplW7K8vub0Np4XPFcFdrYwatoxkbGb+S9rK3IubVjSrf2N6+fOZxR42sTR6I=
Received: from BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 16:15:26 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::12) by BL1PR13CA0368.outlook.office365.com
 (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 16:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 16:15:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 11:15:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 11:15:14 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 11:15:12 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 2/2] usb: typec: tipd: fix uninitialized typec_partner_desc in cd321x_update_work()
Date: Wed, 12 Aug 2026 21:44:54 +0530
Message-ID: <20260812161454.149606-3-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b408572-f2fe-4e72-a9e5-08def88ceab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|11063799006|5023799004|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QlEZKN4SURkYUzC/dRY1HO0MqV5BRRovuyLqX9oiEQRzoSH7v+wwM9iEGDk1S+dthqX9xx13hnKGb3+adQ3J9iH3RbtLUXs60r+dNc/UMModeLkrzGQwnz9dW0zcCdYFUchwU2EVEkEInyKKXqw6iOQQ19V6ZG6rH7eSZU8bSMHrbCgqn37dMB+XMEXGyQ8J+RrbpdzDSX/7jqXRFyzktTuLyI1HAwIIGoUZlFDuao7se1dSoUXzfU+V04Gr7XYqw+chu6/PVKcsUeaexOEohLtQN0wxeyXxCqGzp79Pr6fkIH/DlXSa9gREfB2zFNkJAZ6xG4Vrcroz523Xu39gEUE6hDq9NUp3BBQvMHU5mGBtNazzyO2xVWiu1Et7Nj9sw6rkTCvSba1YX4DgEot4JIQ6btBrMNOial8GmNMsBzP1AS5RQZshLj/IcxVu4d1FvmqIpUzCjHMAnibYlTJ4W2GcDH+O+R3Jm9ysSGx98ojnXxi3vg82+G7UYUWt4rORUrNNS6aDwugaQSHsiVH9V3r4FtqdmjXdcDa0v2/iJOr2r2erH1ZBxLUx508ZGBGPvqkc4/cmtUMLPa67EtsyLcnd+DKgN8Zdgf4SAFGMeqYfEQz/d5Tm83qLlyfXO/VrSWeaGJoxoWkUyTHiIyYVvy/sR/3M0nO9oI+ob6Uybi8I4tjUezVg4uZAHkfwlUqi3o3sW5Zl0vPogqG8or43Wg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fwIfHFJsBbesqlKcn5cY+LihUM6qwJSn5CBDSi+YABq8cjgpBJJfXFleKi6q5NVkVuDYepHgpNHCDSqVablwTmjEQXke/Avc+8enDd94nvL3BprE1gb0hLTKZarFmmealTjqQagOib+SKxoOlv99VG2OExYi00e0Wg94yAd5j0tixwcxA2GMi4J/yLM9eMvCpxFzyQpziepcnci2tsXRQsFvO4y0Di++XlzqYbbaX3WeMBtFs+sA7TlZnA/LXjyMMCtPvBg+OEmqkzd7QIC/WO+cnTiFqvWVo8qkOiVDwf42Pwg/WsMk2Y7j+3TS2YEeM9C579y6VNJkfZmt3M4OzryNLH/+YVG9+ay6Lo6ThHVqTldvOt426Ee5hcNdzb6bIObp10sr/tHTkiIUYKI1cBUQZfaWtqrYNRjAZUxBrt+s488WGHMtGEtmul1oLTQC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:15:24.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b408572-f2fe-4e72-a9e5-08def88ceab0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754

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
index 54ca726c3b15..d99a55063e34 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -840,11 +840,10 @@ static void cd321x_update_work(struct work_struct *work)
 
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

