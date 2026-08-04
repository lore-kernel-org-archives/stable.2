Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EA3E5A09
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877458; cv=fail; b=mFgMHbHB9JiujxAPq+doewzp6Wjk229MZyOWFyJSyO1n1irahsp7zGgDxz7G2eQgrGToN+Op2JCvkyv15rJ3U4B2/cmZQHrFqD9zGCwT7TNOm2tOiXydAS3TXvjlSp/4ELTo6aRvWO0QpVc5HSL1wRg4H1uEa3Pk5pvMS08gqVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877458; c=relaxed/simple;
	bh=UWNt969NDgXxM7fnn02BTMLQvgcWlYQ5SQt6f0BL5k4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7M9RMsHo1wc91OntVkqlXw9bJSh70vNDTO+j9SrQepluCRtvXv34r9wXDpdZ1i/EfNIgrmTkUlx0lQDgNG/bSfqijTzIT8w5RbrX5uTDpjmQoAGlhv8GAztUBnUpQPaq+eCoHi7MV3UinDeHCKDzkuZ5kd55f9zL0yqCflWAoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GtvIgsWl; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GtvIgsWl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFz5RR6zpUZAvlSyrOIq0k9bIx5cPUgjslLeNil+3IupeyYTkzmUszErwc5o5uigBJ+XE8YyonLinbW5w5HyDzhz6GXoIl8gjIc9MuxlVZ61kFcMPUOSUtgdaCpRc6sNjKlwDs+J3wl6/sbXZRdiQ+YbZ1ngUUX4tq0lRS2d21RPoy05LJyAaEgVCrtBWdKtRY/unqzbfNMuIJjBroaEMxHhfWTJOxymT55TaFhwrEYscDeVdKaXgoGGiaGBkaPU/Eqx2bGRFIAXM+LbItEr6I6kkQfnkddMWcGAN58ga85TkOlO2HZ9O/dmgSRKVIL8N9NqAwb84KLV3n7uyzy9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qetnhnXWcspIWg3qJ5j3tPffOJ9RmcWq1w61vrzH5hk=;
 b=bPTI3gMy/LxfGurhqlTL0Jb57ghey5D4Ac+23Mfd1Ab1GbnkYhkdNviq9Ch9p26zksZZ6fGOJXjkFpIBmHGiCFgqm7b03RexQDjcLQdaWFx3cZO0dxNoGMprYvGpFZ6SOQJhBVYW6mad291MKU+8Ya1VH1kbL5Fhxx5WsD90kdm8wArRCC8m748S5ez1BbK7Z05yRlvwaQ9Kw7q6d2rMH7+NNQgLCuj3jYgv0tiJWyQGZ9g0OdL2zchUUuaiW/zr0MBvi4artrwqbp4fqovZmNZ1bBAj/z7gKRFG2vNV0wiLn9N43Q63MDzEN5vsdnrZCckI9m/CwMr/oUSsUpFCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qetnhnXWcspIWg3qJ5j3tPffOJ9RmcWq1w61vrzH5hk=;
 b=GtvIgsWl5/hlHdsdFl/q5JNFIu6DRlQbcs1xpPRZ0tnQ/Vu29xLUfwj5Kzj4+jzq+tSFeLJUN6r6M988NkbhGgz9eVW2n5aiz70fHQj3HxOj19xpPevQ5HM20XHp28ywNlO/TKD7gbFZ0/hCbnbQh2xVQjmUbnxNNoH+LudkgHI=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:04:11 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2b) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 21:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:04:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 16:04:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 14:04:10 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 4 Aug 2026 16:04:10 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] drm/amd/display: avoid divide-by-zero in __is_lut_linear()
Date: Tue, 4 Aug 2026 17:04:04 -0400
Message-ID: <20260804210405.278934-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e50e436-7e0a-499a-380e-08def26beea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	khrQpBDtD8DVRJ6ciqU3ayd3vbn9L50GkByDU0OnBB/rLxRwvHW7/MhTD5xqvI/UN/YJUb/ZaLJi9h5b+9xfBdpCsENktUMamyJUgh8wTI+OaGEQ4sAjqhjUPvsJboYV69xt4ZHEzzTJ1Vp9PH4NsrNsBlUKPQsV6Y+Y3V8MbhISlsPrFWDJkBazyRyHcEpSLCXdmi62zpE6hvqhAO2Xpn5vOhzoqycYipqH6v0w1LpDWviUQKxE1tR1pgR95atgFX9HipY+/hZjHeTxQoPEM0hmduZd6RIMY0qCZlo3szacuFdta2uGJ4oZ/RRGvJ0VtWdi0AERiAYa8KkC/sIHnEFWVy89G2jWG1FHgSzpi1+6xI+OEkeWzbd0ceX4qq1nK0xzl/oS00Ap2+2k9/rAE2geby/3znudhTpzIzgGcxWxGAncMDl+0o82IAVnihj+eae985o+I3QHvWhZNCVKtZiZlsyKVHvPN1zBa6+/ecKv2odszDH459Z/Y+4oOsRpkBDW1z6o0oHQUICVmmLKSq5tE9JYgD9hJgcKabDMEufSNF+MiWPfJJGTZJ0gG088/lR2F5k7OfAdX9NGXSKr+2gpSMn3SV90lzg7cJv+SALae1RUK6hgibDMUVaePJOfYLJ3kjkIbe0W5quOBQTBYeKChuG6rY0rQ1FYzLbOg1uyTdJbx9irhatKZ+c6igQI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cbAeFLudwuLjlAogGMONJ3aLGEjQa7MkTcxlzg6l/05ubLgIL/2hegl6y7OqERoTCu7KZCQaaPxxSjIWj1Ecd8XrQsvP5nLzgAWG7zT+vT4swIgYfZZ6dFpQvkqLJKU8iqnJX7ZHOmh08OkrUQSjPhyk7gLHNvL0tFxE4LXdNiYXjzWS0wpYd+9iVNUBK0mvQ7JnzADENQoAYRFrXkyDhDNQDA8mwRVmLJAqOtbu8kBalyEFlVqMwdbiF+zOUM4MdzVwvR/qkp5MT/ZMenToWEjwJ0lEV5mLDMxOVl2CszYoPsYfXp8iYPrRH+GRW0MXhGvizTIIu4qmkqGjZZ55693oYxAsStRqg/HDl4JCaf9vRNJYaXvQkuqK4Vr4bVyQJtbOCBWPuz6GloXWYrAgIH9ZhudKhS/lMq9FtfTDp1T4P9d5LXtQ8OFNI+PjADqM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:04:11.1236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e50e436-7e0a-499a-380e-08def26beea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

__is_lut_linear() computes the expected value of each entry with

	expected = i * MAX_DRM_LUT_VALUE / (size - 1);

If it is ever called with a single-entry LUT, size - 1 is zero and the
kernel takes a divide error (#DE). A LUT with fewer than two entries
cannot describe a linear mapping anyway, so return false early instead
of dividing by zero.

Fixes: 086247a4b2fb ("drm/amd/display: Use 4096 lut entries")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 7b68c6846039..26e5c89375a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -471,6 +471,12 @@ bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 	uint32_t expected;
 	int delta;
 
+	/* A LUT with fewer than two entries can't be interpolated and would
+	 * divide by zero below (size - 1); it can't be treated as linear.
+	 */
+	if (size < 2)
+		return false;
+
 	for (i = 0; i < size; i++) {
 		/* All color values should equal */
 		if ((lut[i].red != lut[i].green) || (lut[i].green != lut[i].blue))
-- 
2.55.0

