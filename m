Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724D276038;
	Fri,  5 Jun 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683634; cv=fail; b=RNBhbZvaNWj2p2EHCiEnQiwaWeLO7PL2rDRKiBbQIaKarohnFIq1TW7zFRB6NJQF6d9lutH6E/XsVVSpBokdqH6qMP6vK9cs+aniTsJR3ATOVCbnWWfUvWKQAuLr7JD1FyaNg0CgG9B8aPEWr81gjZmFq1pm7obTbRi+ez2BAXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683634; c=relaxed/simple;
	bh=DRe7oNzuCA6WfvoBReKVUXtzENKostYJa8+2/l65lXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scqCEnPeBGPbPTw8gyZR6iVXAj/7YzF24sUGXtAUgo0KaxxFETJ2Dd1wd/RqlkAM8MjjUad5M60dyOcJJRxm5KFA17g2AEEkxElr5tCHkwe8PdvpJqi79CXH1wQONHZmCcR/qtWEd/XNSJzqgZCun8d2LBYlj+OJulK5YbqyrJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MuYopQ2u; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MuYopQ2u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3pytIHUIbyA3yRC1g+z3D5lM+EL8UEdK47lUHrltGPSeFrWfW1KeXTAXZjQUBj/NUcsXlQktHtTSxjpzEYPb1OXQLX1ZifMX4PHViZmBBm3D7cQMpSzNsSChi6yI7g861OBqp5F24MDenHHQWlGX8qVKD9dFgcVXVyMscwLnPeAnkLXvNbAIqceV86Lz5earF8bqTzuulM6VjnYuBfiog8vmFGSac04qA+8GtTQjLN6Bchsz3W5VFN5YKx+JnHEfj1fIonV95fkIQXN75SIXWJ7S5LRMaDz4IeX+hhvwRFq3jXY6lfSWkTOHNbpQyOVZovKLfOrZkuMDocIO63Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3+bSBh9F8MbjGaT8JDae0GnxE3mI0ftdaRtlx/NiI0=;
 b=swnRCZ6xZHGDM+1S7hhKoKPt4A+QIFFj5QnbbEQpt9LETQg8ohBHg5fwcJouqJS8RsPtzXxwZ7+GS5xy/KwACdGYPH4VJJFT3uQiPnPN3/JioNngnLa3UfFzrdA4K7TjB38IehiqwXMb8nlAxO1QdBQWwexWdz5LD1UHZf1KpMhZBheEiiiLhTfx9+SkPdCmh4jiK3tz+4xeVHy7QNv2UAvX++jJRiOirmt7hx2Qtd+Lnk/gaHPFGu9rcDTnqnPA31Ue/KHyf0uDrq4lOlq33Fysry7rSMdJxaHDqRtS87gL6hvpREP5zfx7Ulg1gKGDOo8q9nhVZ/QluH+wA4UYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3+bSBh9F8MbjGaT8JDae0GnxE3mI0ftdaRtlx/NiI0=;
 b=MuYopQ2uGeMrF9ylOkSXXkNLB+9/2Xz5Gzh+uJzrtdH944MRsseAxDDpgKkagCcKdnUWtB5Sma+pVzdikv0PXmj158puVZgc+EzfG6o2SslrP8F+phKAm+drRb1nvQqPIxJD+g72vw7Q6+CMMWECJsjqQ3731PVMSULLwixyUEA=
Received: from PH8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:510:2d2::21)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:20:22 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::88) by PH8PR15CA0019.outlook.office365.com
 (2603:10b6:510:2d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:20:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 13:20:20 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <djb@kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Li Ming <ming.li@zohomail.com>,
	Tony Luck <tony.luck@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] cxl/port: Fix missing port lock in cxl_dport_remove()
Date: Fri, 5 Jun 2026 13:20:14 -0500
Message-ID: <20260605182014.2254410-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f54b008-665f-47d1-de63-08dec32f1b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|18002099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	pcJrzI1CNFhEbP6X5xhku3vR/+4bJo3f4Ql7H7Dk7tN7DsGMVRbn9qd8J+jI9aaz2bXMJsaYshUCOAdExpdHhZO6a6Ff9r2ruBLhkdnDYe3QG+eydYE74Du7MhHL1yHJMETXofZ7z7J3567qGASKtowbKVMjZKYjfI7dv+52J9smifPTPP80Z0HhBik5R8rngBRjKt3AUzB3jO1StmiKFBXUjoagDXqNfPDX2qhh4irISle7/HIQumC/eybY/OfxFw1b47dxBITWq3PPwtLjksx6DugeMgEnbKPw/UEix5WFl2vQsskTJwaF6oWcD1Vj9qBbNQVszHzACPnpNey9N0JyJzBM9PqojTF1viVA4spVlFzM9HILeQM1pfCMUHSixLSTGkIiU4bXAvobplP08lZ7lT/TM0Phx4EmQFzkHsYyr9XnjQC+HM+tGziLSSj0mil92w7G1THioMTm7SsKXFJ/CySECRG4wk3mKp2gSOxwuQDRVp4hrMeAysYPbdUMs3DxsJ1ndzHjXGsZKfAIJZCzJgf8BCOA9WpIILYI8EuJYXM0zy6z9f6vZo4+h5oerMqKZGAWZKFq2KJXayrnZj7L+FQMyQ1QMYzyF3L8MOSknHgSCCRUoJJBjYvnxKiHZARKzV3aAUv5qoQWM+pKrKxNOtaKvJfkohMAHdyWDysOPITooYzv9xMD+8cP6UCHzKenF6imJg3OsDy7tqXq07EyprIyv9N03d7JlVRHWBYcrlvuSezVh6RFyIInP4zGX78N1Rsvbzm/+KKDEPKrcA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(18002099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sqfe5UTeYttTZygwSdBDCjh15rDWi4z/W4YNxpyGWGeFro+SMVYG6/OSJy6K3a7YANszkJDaeFmFsUnqXp+tvdDSd2DUC0RFdJu9vEF6c7DDLoeUH1ETetT0bYZiLOHpA7jpSgnctcvzwJr0hpuO9pPY/BDZxG3WBjLOaCOLFm8p5xMrzJBlT8mHkoagX0LolrzTy0agatXHWHRWLlHE7pXg/rqxRN+kJNky6NYbbNNMCLK8WX0aPQXtBbimk0YPXPXlZLUmBMvXkyd41E8Y0DT9tYrIG67WonHT35uRf5qMCQouMX//IpzHjFA5AcBzH8tNkIZHxIID8hJyCAvY1F7LkezZQO3Zy/vyNyl+8rgl1K1497/fZC3KxALY4R6vnGkQtRgR5nXRZpblemBdwP/FR+x+B9TkIfxJ6lmrlQvBGi08vq1Dhjjig82/geYe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:20:22.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f54b008-665f-47d1-de63-08dec32f1b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

xa_erase() in cxl_dport_remove() runs without the port device lock,
creating a race with any caller that does xa_load() on port->dports
and then dereferences the returned dport pointer. A concurrent
cxl_dport_remove() can erase and free the dport between the xa_load()
and the caller acquiring the port lock, causing a use-after-free.

For non-root ports the port lock is already held by the caller on two
paths:

1. Driver unbind: devres_release_all() is called from
   __device_release_driver() which holds port->dev.mutex.

2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
   before calling del_dports() -> del_dport() -> devres_release_group(),
   which synchronously runs cxl_dport_remove().

Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
the port is a root port and the lock is therefore not already held.
This matches the pattern used in __devm_cxl_add_dport() for the same
reason.

Reported-by: Sashiko
Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..80ce7c4d357c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1088,8 +1088,17 @@ static void cxl_dport_remove(void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	/*
+	 * For non-root ports the port lock is already held by the caller
+	 * (driver unbind via devres_release_all(), or cxl_detach_ep() via
+	 * devres_release_group()).  Acquiring it again unconditionally would
+	 * deadlock.  Use cond_cxl_root_lock() which only acquires when the
+	 * port is a root port and the lock is therefore not yet held.
+	 */
+	cond_cxl_root_lock(port);
 	port->nr_dports--;
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
+	cond_cxl_root_unlock(port);
 	put_device(dport->dport_dev);
 }
 
-- 
2.34.1

