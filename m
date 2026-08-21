Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BD49483B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328626; cv=fail; b=C2/3BdjtsAso79K5iyLOpXNLCzQ6vPbYjeUtL3wWAqN+B0CyOLQrzj9L4xXObVEa2uamKz64W7Li2PYYx2yb0KgDIgBS31yvD28vDpPzX7acf1pfgSwoMJnKm7cpp43QdPFIvzuSw58N3Usj/O9rlRawSsmd/YcInGIkc3DPudk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328626; c=relaxed/simple;
	bh=Yx7mntnXT87ACRnPvalQJIH1hQhZtQj9P9G+oLIQdMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4luADJFZ5MqrPNlAl1UxHmfIWM817AkuY0Tdb1cRs0X1EkxJmUnbJmFlFt5z7KH7GVhDl6/X/YwMmbBnKDSZvsQhlq34jYLOjZpoXShc+hKuB5kiAHyMw7caH2AOzuJjH4C8Myyym8VZab+g8HBNYYiZxxA5rAB78PdS0osZ8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ykhUVY58; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ykhUVY58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDUcb3LYUo0LBUwqxjCrX7297JvJBcAYLRzd7QN6QZN1E8maUyAMA9zJQvcsUQfWJ4/NMMx+GG1ovKWy07/46hjM3W9bhzSTe64qRn+xLq7JvquDU7EK0SkgUkJp1lJCA5wrC+yI9syPabxlxby4f0IQB7SAmtU08zycaYg7dY1lKsDkOGUGjPZkErbtw7MjIPRyObwyx4oiIN600y5qPEJ0TYewHnI64ajLsA1IpcHBCWwdmh4UyxFTUr7vrmrLlzDrZSeq4RFEdWx403tsOv9eEcFbFas84ydPybf4p/Wp9sPrq7/ZS4OxE9wSWqgpv60TWtyiXiUEnIh8hEAMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAZhMZ5hcIMX7ZsqHio93ckJezWln32n/p1avseXcxc=;
 b=puz8cZ+29AJu3h6u1d0YzdsHtrm389KgUP9EuOHtuuATkqnGjPGQ/3KwRWqJrjOcOTxso4aUF5oA0qqrSw33gezMPZcVNi/bSgKM4fltzn8dThmzXcmygzZeBA0XmmG3zlyyBA0TzaRSkN695Cd0rsdZkmnVgvWy8iXoX0ZOTB9jmd59OE6UXp+vAbHWuTlPAjlnaZNYZxqljk6BMW3qRtxJhtz7+UwZUWbB4Ybp0A6HlThfTlEibl0hZc+dmrfFAjJceW7O7vUuS33V7nMDQnnFUQgGz/mLyupYfxOJE4PmZIl7rVjUC7/s4cEM8zPYK3s9VqLCwsHTJE/2anRZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAZhMZ5hcIMX7ZsqHio93ckJezWln32n/p1avseXcxc=;
 b=ykhUVY583o4bQWFSKmm4FkvR2XRyhTuQ2zhmB/yHORxYiVO/b2OOJ7PY64bgGgrmMZDJBb6h6c+7rm/Tdogdj5XUOo22IQUQwrOZGwfdNadSOhkwIZtpiESqp62e/9ZFrHtN4vvnu+l+4CAlFomrdsGUFP/s9imcw1eRbOLi3As=
Received: from CY8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:930:4e::22)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:10:18 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::5c) by CY8PR12CA0024.outlook.office365.com
 (2603:10b6:930:4e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YuBiao Wang <YuBiao.Wang@amd.com>, <stable@vger.kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 12/13] drm/amdgpu: recompute the dw estimate after allocating a new VM update job
Date: Fri, 21 Aug 2026 12:09:57 -0400
Message-ID: <20260821160958.753063-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: a48725cb-b75c-408c-6df1-08deff9eb16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6eoI7D+eyVy5YhsjLBYkrifnaejozn/rL7YEVzAP+laZtktoeTc+Eg/j9dlwyCi4WtptEAdmF7rfoGJHPLiIXm2xH9OlEuf3A/e0Q9+ZI1pRqQNvqORsRscyawsIsoQWvTFJ7C3CBGy8nJHFuPjQ6yDOZof6XHzc5A+O7dzpmZCS7ql0VNqADWb4DoEY6uSxo91Wr8g26MdoDcWJUETCnwZ3i68dGAXQbN1HE9SY+GnwwEgNYiHR5dQ12sfP5NS3qWVZbpqTtBN1oACDDWY+utmKgf5/16QYf6d6gnQ5wfxwXSOxAdd7S5fIoHwC5r/4zDeD973IOy/ATAJgVKzIbj1HtqfAeYNaOWmj9R7WSKosxj4JeowqimjowyWwVXtw8+FoEuf/DgpZFYtuBnrtt5wdwEfMdn7Wes8/S46cHwYeqSDR8rg9zlMdiHhkfMuDegvBwPvv3OXP47Df+0gY6BAi0/5/cOWuN2NrYIt2lDGn9LytXsgkdsEhR0NKHMZK53htg1yD1h4E/P/268e8SVYcJAGkdfnz9T8QEL+G1uilUJpoj9PTn7FnRILMALiy8UHR9kIx0hkRep25I9rqSaDJyl5g48svIwuGyYyUrssGm3H40twRpi/VP3pJWguxCoQD4dyqMn53WRiFjgoIw4p+9AO77+k64s8rPw1dC3VklZXkYhHphrLwd6jICMRtDbd7OjY4KYiex32szukPUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	btv/F+HkUI8hf0Jyqd2rHotprJeB0++pBmJ7jouItAuXkKMrq5C+7vzvdTFbyV0bakZ9t/a6gAlfPfkAAZ0E2gE4lClXK3ee9eT1TjqkOBdBuUU9lRm+aPX9h0aC1kpD8XfmL4tnVqk0j4eyaU7cRjT7Hmu8/CwAMzF7anbRdXcT6DhzH4FYQRrSmH32ydLchbA5z0Hgnoyu3YkHcs4XWCcICg9orOTD2I+bJlylqQegEqWSHJ0HUx/Yurnr+zdKjTxNQOBjC8R2ZOeGiINp60lNRw+3puJApLkby8IKeWsCtzVTgU1Msk2HhiwiE61h1opayL3qWbe4JE2yrMypcBG2dKKtwfWp2WCSVnJuaU6oLtID9ATmwTYi4sOnnTPyX18uazUCe9Gi40Dx1h0RaSt+BKwrRARhu6Fm7zgBsxVNnsiuSt8BtEVNlxHCsKDI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:17.4166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48725cb-b75c-408c-6df1-08deff9eb16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

From: YuBiao Wang <YuBiao.Wang@amd.com>

amdgpu_vm_sdma_update() keeps the number of free dwords of the current
job in a local variable. When the job runs out of room it is committed
and a new one is allocated, but that local variable is not refreshed and
still describes the job which was just submitted.

The stale value is then used to decide how many PTEs fit into the new
job. If it happens to be copy_pte_num_dw + 7, or one more than that, the
result is zero. copy_pte() encodes the transfer size as count * 8 - 1,
so a count of zero asks the engine for a 1GB copy starting inside the IB
pool. That runs off the end of the pool, faults on the first unmapped
GART page above it and hangs the ring.

Re-initialize the estimate from the newly allocated job, which is empty
and therefore has its full budget available.

Cc: stable@vger.kernel.org
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Change-Id: I2a1979b4ba9f1445c109e0cded862c36eb05015a
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 4302742376897..4db0ff3436abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -254,6 +254,11 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
 			if (r)
 				return r;
+
+			/* The estimate above describes the job which was just
+			 * submitted, take the budget of the newly allocated one.
+			 */
+			ndw = p->num_dw_left;
 		}
 
 		if (!p->pages_addr) {
-- 
2.55.0

