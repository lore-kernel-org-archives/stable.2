Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA643B4A3;
	Thu, 23 Jul 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814178; cv=fail; b=gBBl/kWI1jKXGGb9fOmU3l1o5sIeOXzqmv7g6ei3xRZoQglptYlzqGVHet/wZAR+06VqLh0UT+SnhPFoZISWZqp7mzCkHdw+9WoRXRswsRh8OW6/yMiNc4qWSwLQl3aBqHhlq+OlcWZk2dkJK+zED/IE2u6ZEEUOzQWp5Uq36qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814178; c=relaxed/simple;
	bh=nCaVBnMuI6y8t4waMXILbEEDlaup2iq/17jN9+Dz/wU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C3VYpJrW1KJlZ+vn3o1Kium5QtHHZhmTdp/eCikDGHf7ea8uE5GTPDlwf6capKRI+QNmGxEyZXiCboi3jgd8VxzeIosm/60oOkb5Hj72HOEzOjcVnnS8ZHEX0fL1U0xHqVosgK9uXfPGtIiiqsxNNBvrF02aT+DW0f4DKulPeuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npdW/myV; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npdW/myV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwHSfT2NavbTYupQcZ680Q5W5jCcVLyYvKwFiWAIYqyFsHvtcQ7iBWzN8WYKKG8C3ei3mQKmr7abBz2DBHMDHRE+vV1L6Re+rbRDR9uz8VRCr0+BssS8Bc5jBefLd4nOq9A/ILC1LEknYcfZ0vqXIR7uAkqnRMTLO7vE26XzOSxqemyoA8mQ7BGSuFhufW3B83xQcBdQQjF87UsTJULO6+wJY/DfIXhJOJEUVh/resnCjFAmd62nJMHwP8P1VgVdCmcChmpI6BiJMqfLAR6bKhb8wJlYn4lW3DKhKB+QiN6hAKVUzPEny3PnUqDqn8RUuWYNOQEOr0KSL8grd07k7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiuxZvgLU0P2vVsKoigYC8NM4FElFsTbCO4me9CXDic=;
 b=pvMkC4zGNQKHMGBCP4ZC4XHs6BcyAwhqpX0e3cuuB4EZ+thc5lHLgj2t+Y352XAJCTj1a3FxQgzkWA73KpMWM5en4ycbSESmTxDZJgbNpri+0l+bi9gDdO6eLcwortmzRjcr1Hd3DYNKfVisC5TRX4QmAqwHIKlL88ApqgFu+Nb2OzRGhFg4o3ZAMCBEtIdKNfn9NmPFJmCLplBbt5WgY2BZL1k4i0NS3c09IF/nmsUbgXxbyrotuJ5F2+FX9wjEmVNfEg5o/f0sZqzYwL/3rV2uipu9dS/OF5bqYEqwNKl9boorLDwcMXfUh/dyW61SAl1oRce/6Hv3k25GCVf4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiuxZvgLU0P2vVsKoigYC8NM4FElFsTbCO4me9CXDic=;
 b=npdW/myVEc5vBlVVHkcEMFkLhZfIgdAVn1jY4iGiy3VGL5itkLjogh50z95upzzHcdeJz3mY40zxp06hQHHDtXxEAlz5CWINzTgNPOszPERJmyGb0yeW76IhX4AAojA/aHzvElqMPCQVSmFcvBcamXjqOHNL8Ku10X+H7H9ua3e5p+/RdweKJczilPlE/hz2wZjMzv1a4dSzLPJphYvppQcIRd6tlsmDWdeNJh7C+gU/F7DUMG1wEDcLvz9oiixagdqyHHRPxJrCVDv3U3Vx3gBChT5mqPM6sXbk1shbUir6u5jIjrwNJ4qatFHdmjPs0WkU5LgOtRWCX2U+WvtXvg==
Received: from SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:42:47 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::1a) by SA9PR03CA0008.outlook.office365.com
 (2603:10b6:806:20::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 13:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 13:42:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 23 Jul
 2026 06:42:29 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Jul 2026 06:42:28 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: [RFC PATCH] mm: use precise current RSS for high-water accounting
Date: Thu, 23 Jul 2026 06:41:58 -0700
Message-ID: <20260723134158.1473841-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f3c0cb-e3ca-4e5d-a225-08dee8c047f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZBZqjacDW/XR1iUM2d8Cj0EvuxADXF+uoYa2btWkFgT8vaZSICYf5wYU8INoZjgYoPlpuyimJuwypVHuXsjM+qIqJoa0dK4owgYyrHHn7aVyC9SGUfnMh6vXGaSFRiVNsCQTa8Enr/TfI/ccwP1ctN4LP7pv8Fv9SYsHcJTx9CGqq5AiQpADiy6c8HaGtKIH3LsueHkbeuZCLwSoRpm9u16nYtPA90YKxtyZ0XlM03ZMTdJU3hnt57wA+n/hC95lBf2TYzOaPubFyekT3jUKJ95PbnD+6ObNUA1VxGmFHBlN9YshaR6/jJDUlglEWaW2bb1zpZ45ELO3i8begwx6G1o/78lb907027wR7l0Oa9xx866PnPwX0IZS25eLazBIFL6kKnZwuaMHTewcj+aKFCUl63LYoWGTJV5U6ZGi/krjgP5MeQL2/Pw9dRiL8qd2Y2P0a+BI9V6v8Z/TQu3/m8mdzenm6UVtnRsgk4jw6J7vJznoQTrfp45LL/uYZApp5XITnEywVPMC8d5NfabZ0Hge63jdBIll07uqKpylBEJUdvhQuSYpGUUNmyo3D9Se3d16nUsmJz01ThqZfJ8rPHZzcQeFswMDiN7EfQQBd8I6ICUAQfs2vgGV22CtfkBkhfOIfe8cBKvNtj8RwnUmU8/7sTGiGc52fEBEnBoA74hnd8uuTD1Q14iUr5o9jPaI4GSGmZBngH6KRZrLWajPqA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(10067099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LH91GQdh1J6mSnxrxITljMx5oiuD/lOGyHqb1CGicraq/LGKc9bPvB6i+EslpWJQ1zqqL3CjYVDBqzrTD+OvySKR+ypWvt1TvCL3fZzNQ3H8W/AgpuZaKZ2+OLVtIGwmyP8gwMQf8UdMKcoRP2eKfyUVotefAGPsyo3EWGLllKJd6Gh0YWTNML/wZL4bQmt3sMZxQX+Mh0dqgBXitYY58EV/fTRm9qQiAmhdqKpBFMfjpt0EH1l+cktkosbuffA/NtPHdnU4obSew4UZCC8F0ZmcIjOs7uec28jcUmMV+BoTXeQvLbsmC90vKjv456Wb4p1p2IOxVhVrCRnHkPRbQI9L5tN4TL3zfSMhspWfekk7g4ZrcPkPXOexAlae8iz/wtS+p76NOKWL8r6m7v44DO7csFtJmJmvJ+XLGLE1xAx68NHDEhEbgChfry3sd0Up
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:42:46.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f3c0cb-e3ca-4e5d-a225-08dee8c047f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

get_mm_rss() reads approximate per-CPU RSS counters. On large systems,
this can under-report the current RSS used for high-water accounting.

On a 352-CPU, 2-node system with 64 KiB pages, reproduce with:

  sudo -E env LTPROOT=/opt/ltp \
      PATH=/opt/ltp/testcases/bin:$PATH LTP_TIMEOUT_MUL=5 \
      bash -c "cd /opt/ltp/testcases/bin && ./getrusage03"

The test failed 10/10 times with child.children=270336 instead of
307200.

Use get_mm_rss_sum() when reading and resetting high-water RSS. Keep
update_hiwater_rss() on the approximate path because it runs before
RSS-decreasing operations.

The patched kernel passed getrusage03 20/20 times. getrusage01,
getrusage02 and getrusage04 also passed.

Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
Cc: stable@vger.kernel.org
Assisted-by: Cursor:claude-opus-4-8-thinking-max
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbddb..1b613c6356baa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3405,7 +3405,7 @@ static inline unsigned long get_mm_rss_sum(struct mm_struct *mm)
 
 static inline unsigned long get_mm_hiwater_rss(struct mm_struct *mm)
 {
-	return max(mm->hiwater_rss, get_mm_rss(mm));
+	return max(mm->hiwater_rss, get_mm_rss_sum(mm));
 }
 
 static inline unsigned long get_mm_hiwater_vm(struct mm_struct *mm)
@@ -3429,7 +3429,7 @@ static inline void update_hiwater_vm(struct mm_struct *mm)
 
 static inline void reset_mm_hiwater_rss(struct mm_struct *mm)
 {
-	mm->hiwater_rss = get_mm_rss(mm);
+	mm->hiwater_rss = get_mm_rss_sum(mm);
 }
 
 static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,

base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
-- 
2.43.0

