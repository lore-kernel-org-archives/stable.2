Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929E3242B2;
	Sat, 22 Aug 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426545; cv=fail; b=S9jS+dTw2n88qy8PzShQoMS1MkSOr/jFMzpTzY0+6LVWgGdUvI7fNvfeagoaHE8APTtQKJDpkFcTdb97p6WPTQZfOGuyOtTICztBodWPMVEpL/Javsf4fcv5v928c6WroUVHBM9ugtAreqdWewSs77SMTtSxXVxgmU6HjP6ivBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426545; c=relaxed/simple;
	bh=eTtyDmcXw08U83yDvsQu0tI70M6Z/jx9at9rpiU47QY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bg+E6SWyR8XdLByM4pHttCDqor38Dqeh2T3KmSH205Ptoj2hH/tyVvI6/riQZX3XAJ2rEfz6UZZWLFOug/xPj5wzgnt00+H5M3WurDjQ6dMKeI9p4xm9AEMAAHUZtKohNQ9GdMGUzNE0WFo//YxAGE//lT7AFAktOIBzZEHX3Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2VsOsY0s; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2VsOsY0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtMaPcQDFmMYZDYINNpEnqUCIXxHWp0pMfoSIcmctmbDVvB/uGWX1Mxy5n67aE0GAelo3q8gU04xCOmg1/MQ/pYdIMTGyJpu1VMsVPUUNfu9bH6opZmIgq5+ELeK/Eoeo2pjxao2NSEfituYG2ImkLTMFlOltZTdASi9aaWqOkr0NxbcMn1Gi+c7b8VW7EwqzCBmgzm+Y79kQsEIwZUqn/wVZMzLBiEDjQBrPqYTKL61ccWVZmZ1qO13AJRZnApJHpD+rvwNWQg1q98PxczoVghhQdKBwNny+CjgZJKi7SnpbMUPgTponXVRyV/QRwpXXAcmd065mEeZE5S3g9Q5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/g91It7w7VdXWCc7MuLvRmasBUeLXjvfvZF6q984JA=;
 b=cJvjcg5znohdie9/hx0IeB+ywK6WLDxALJyo2iYzp7QmALns7Y2d55oAy6KiT3gVbH7ckqF95AiFRABEUbwQzKjxhvOaUEnRs5fgjnbC6udQIGPw9QzGYw6QD+cDSCk/wG4EL1XHWpY7VSiCiWYm58NZVcrFI8Xc3vwg/lyO6UArRItFt5pTvuipuiToF4QKBMwnZSwr3e7CitbzGQiUbuEYBnLKTiUNs65h0mJlcXzHCYVSL+gSMf32pyB9/zyPnENO3tcJ91NaowzfTMFYSEet6uunMjbQsNKZ5/k2cTQXBoaMO44ozYnBIvy86UFV7vYvqEaPp64tRPzjsr8v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/g91It7w7VdXWCc7MuLvRmasBUeLXjvfvZF6q984JA=;
 b=2VsOsY0sPGNA6GEGbvFm+sunv4UOuZ6fbltPD+WhNdfqYBkjYLonHXu2hiLtHqkilSIyousngGlC57lQRvIVfhfTO9MF366Ic5deCsz/bsJBsYD1knz5c9aJB20MgzH1dx2/HRX+UXtsyDSXnDBjSHRONQ8ye8ikFfgym5JdxBg=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Sat, 22 Aug
 2026 19:22:16 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5e) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 19:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 19:22:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 14:22:12 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH v5 0/4] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Date: Sat, 22 Aug 2026 19:22:02 +0000
Message-ID: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANr2iWoC/33PTQ6CMBAF4KuYrh3TKf0BV97DuCjtFBsDGDAEQ
 7i71Q2QEJdvJu+bzMR66iL17HyYWEdD7GPbpKCOB+butqkIok+ZCS40V5iDry01VWwIHh0FCHE
 EUwq0ruSFVIql4jMt4vhDr7eU77F/td37d2PA7/QvNyAgSK9RKC7zUJqLrf3JtTX7YoNYAULvA
 gI4ZD5oboN1HP0WyBYgx30gS4AhozE3KJUPW0Cugf0XZAKcplAUKLWwfAHmef4AGTeXBXUBAAA
 =
X-Change-ID: 20260518-dmaengine-kref-fix-7b21acb09455
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Frank Li
	<Frank.Li@nxp.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787426532; l=1706;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=eTtyDmcXw08U83yDvsQu0tI70M6Z/jx9at9rpiU47QY=;
 b=UBvJoSTrVez8m421lJ31cfvyhBe7bqRnIg9Fl04fzFV+3pkqFKAPzXeb0GY93tTZjRxTKNCpM
 d0NZzeRm613CiE//7bLnx78F3VDuqoBVbSXbPaFoBSDKQC0Viwc1OA7
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 840c6c7f-dcdd-4d8a-8324-08df0082acc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|10067099003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9rQsAQmXCyLrdRpu3mNezgR6v70+LQMjxW8PqhwGteyFOxNCZfoCX+PSiUuQqUJBf6+E9CfF/Co3k1pIxqS0RYneH/Q6PzOjEQMKnbtTvlvRa7Nfrsm0cVYbn/aNjwZdXxUS/qLR/dxXg3Cm8As5AETrypf7qM2PHzbrAl6fgbIec0el+zoU2xNoC+ZSHvElBZOcfdsGgO6sKZgJlq1hkfpjd0rSpy4oatNAvEaB1uafMrFvnuvzrDtRKiePLP/PYI6anJSt6C3cW4NcZoINL25gCJ+w5w+N6zIA+Ub8Cz6ULpy5Fkq/cMNW7LufoY1gNiyAtC8Ijvl522gM9ygqjljEZnbOjDm5y7SoT3DNKcty0c1fHu622HDDczgaXAgcDekGRxtMhYZ3/V2M0HDu4KpIj94arbZSdC+sgwAf0SPrkE8EeqW3uIYawaY5fRW+xFBTk8QN2WDI5VlQxz3CXguwW5gVAgDaYD0UwrO1FncveVrlawM1tWo3gTLFcZ33lACLcjgHDRvIFZYGSe8y/vSEZ0TUuFpR/5Mdwa9aY0mHE4BXuvZMVxH3sA70n8RgeUaeM3RdzViI5BjwX0/Nqtg1P0vXAolyanYu3bGOci/kFLdERreZU7cm/b4ItpCf3SwzhnLeBWV450YO//v8nwGWbB94fFZ8YxerLqI6Bt9eNyynX8MafTjpKoe7Hrj4SN5TXztJ36J9OQWvmxYgUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UrA3nfICFXcoKUKPBpat3fPzmhlKFXFd8IeB1i4Vbif9tvbk030BOp6uRk7rEzdfFHw51lPcs6x//4cBMg6iV8AqOHfmUuzd7pUOx7XfW6JKdmsysWle7iQX4uJC/iY9RHrLZ9hnVIBc1x8l3rYt3roPa3pyzGzH+k8do+rNbD4T/4jFsl1PzJJmmiIbd8Ag6l7htZ/icrL3twVS85/N6tvSk1tUqmSD5V53S6PVz7YbKUwCFEuOrN48kcXKc0bDt5H50PdC5RbxXpS7oZgTMnnsLir6ChwLo9LgSgfFdgzidHMHgOkcvPa6Sq+hGQ7cmRPqF9IoeU4K9sxJJ/i5J31TKHZUxgSgsyvlkbjcKgMyHaLVDX0vIV+hNnKo4OWS4BTMDrkIaPcirhQ2yZnDBwr4Gzo5OEplcbIrTCxotPDDXnzQ9nInik/75rCULowb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 19:22:15.3383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c6c7f-dcdd-4d8a-8324-08df0082acc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593

Fix bugs related to dma_chan_put(), found while testing with SDXI[1].

[1]: https://lore.kernel.org/dmaengine/20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Changes in v5:
- Use int return type and add __must_check for dma_device_get() (Frank)
- Drop the comment above synchronize_rcu() and note in the commit message
  that this will delay for grace period dma_list_mutex held (Logan)
- Link to v4: https://lore.kernel.org/r/20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com

Changes in v4:
- Add dma_device_get() helper (Frank)
- Drop dma_chan_put() move change (Frank)
- Link to v3: https://lore.kernel.org/r/20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com

Changes in v3:
- Add patch 3: add synchronize_rcu() to wait for RCU readers to prevent
  use-after-free. (Sashiko)
- Link to v2: https://lore.kernel.org/r/20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com

Changes in v2:
- Add patch 2 fixing the dma_chan_put()/dma_release_channel() use-after-free (sashiko)
- Link to v1: https://lore.kernel.org/r/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com

---
Shivank Garg (4):
      dmaengine: add dma_device_get() helper
      dmaengine: Fix device kref underflow in dma_chan_put()
      dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()
      dmaengine: wait for RCU readers before releasing dma_device

 drivers/dma/dmaengine.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)
---
base-commit: a4ff2be345d0abc943da8dd8da98151843b750dc
change-id: 20260518-dmaengine-kref-fix-7b21acb09455

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

