Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CE2D5922
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877457; cv=fail; b=gMiqOYh4iNrY7IoMwKDiLF6qMAEQL+ZKT2RDDwFvCAWtyALHOcnymirY7BiTIpxtHhA1/HvzN0+fViYD4Od7hxOZ6bdHRCGMOqL0xG8Fuiyj+N7qyoV8lxgTRpLOWRdxxGdJ7EukGKgwZQUyQ7mqhbtipuYDBfYDXan2KGDnnp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877457; c=relaxed/simple;
	bh=GfcZeMzXBiipClcpNRTx8W6nhNQdtmN0piMk8gS/CcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MY89Q8UxA27k0pFrEliew7Dil32bqI8mB+jE25zoXt7MfA73XP/seJOSF7M4rqApZlTEc7NKFGBKusmgYLdZuTaHf1Ml1Exxb9O16PwfeovtFUPE8MptgHfjC/bjja/qkVIcZ5bZzJl+e1raseYUs+qocP31QDJL6jwuDlBtzyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rERO2CAb; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rERO2CAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3J+J6OEMy1L5TZAWqdcmLNJNowP98JoKWZb6vBXzSNVsNweKa6dtKLyCYFDnfoiTQ18CAZ5mEmGva2xnnR9zbWbanr8YMe9ChLu4U4vP5LFr6JFKAXPFBmNLV8jntDp7HRFHf+fnwEEhcow3+JpE58B1L8fCZpDhq4BNcFgimngun1TDvmJo8HumTt7F4dmki5HghPNRL3OCWE4YDBRtV4RPHfqGN3Fj6Su32MGZC0K5H+7YI/J21TmGXoV2BCclNK+9rnB0lgXfHo8X8nb92rGpQdsximHMBEiDIx75T9ueTPdEwMSo14j1skE9HWV5A0U7b66KRqyRPL37Mnofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWTHwnuUaO7ajui6E7rPF8gG2/2nrmU6m2hOE121N3Y=;
 b=YuzCPw8PIZCM3qg8eo9/QktwbL1/Hu1Or5iFp+SSB/nZ7x7UMC2V4YoaYuf76CQ6HS2+cizfqDQWejirU+K/nTxoQldALC8r1HhIdrA+Z0gvnQ3vFFzcJ5kBl3Kye5YPJVx+uxMeeD6o2kDbkBrj+HwV8Q8VoamtdWbNmtp0/T0iiXyiOqdpfmAowyJ6xf9PnN3aexkUkZhXPLyroCOVEoFJ63WfNYxHRqmkk6jAoP3lCKA2z9zsbM+HVoeOCRD6w2D8FhyMPvq13Pw767kJQyrw1a5canovuir0QvADnSOBLB8D4bLbsjBuHvr4NGrp/uXtg2lD8Rqyyn/y7ymBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWTHwnuUaO7ajui6E7rPF8gG2/2nrmU6m2hOE121N3Y=;
 b=rERO2CAbvMz6dhDVY6b1IXeM1utHtx/cU0tkzXRBv4CUvpSwYF2eAtsuQ2h/IYP/P3PuMptTus+K2Tqdhv1c5RAdSCAidSWU4GbiZTS89ZPxpf1BytgvO/aYSF57m4tCJMl60/u8BtNvPNdBM3Od6VbPQ/Wm+De8548A4p2nQD0=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.16; Tue, 4 Aug 2026 21:04:12 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::43) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 21:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:04:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 16:04:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 14:04:11 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 4 Aug 2026 16:04:10 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/amd/display: validate plane degamma LUT size for private color prop
Date: Tue, 4 Aug 2026 17:04:05 -0400
Message-ID: <20260804210405.278934-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804210405.278934-1-harry.wentland@amd.com>
References: <20260804210405.278934-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5a83f2-9b25-4294-88dc-08def26beefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6+mmccT/8J+RyQAS1utdJS9M1/9sJp2DwmhFQsQDz1/cSPAueKUfQOfrTua/WoJ8f1Vy4jZieZ3ehDJlpL+5v+YTv/SDoFhTWcC6f3gIRt9N/1ppVjtjFMBIv5oPSwEYkbTwHvE2GWrdFfd9SCO90Kp8uZcxkB8SnekJ0GfC/6pr+GmKz/yAcjUb9xH6qUvtzVbKXbOsen1Wi6wnVgCvZhySdzOh5b6BJTE6gnDyA5A+5up4z3WJSMai0RWoRRuIzq/VRFwbncGGXtLZ7HXdG+kgPV6f82XsDWlvqi3GlgqeENjAj0ZtJJziLhA+6oh+V+NBJ5Gc+eKa0z5Ju9vyBaQVzqNBGUvyOqLdyJZApvyX+OWUGUqU4vc7Cpy6C5K4NWmjr1x+rfBWR5t8ARAQmQV0U18RLqMO29tWJA72zikjsEADl5LL4n51s7hbmiA0lj5F/ZoeAyHyO/6o37thuc2bODNNQ5y+XcV7FfiwibwRQEYHD6PzLSovdyePuOq/7Qdb+dm+TyLMbxf8yK/3KXwvydjYLEY8OhOB2QX+2qvxGGZpwy87J+aelmXDEiDNxZICfTbX/iMj4Zy2p9S22I43SWh6e48F19HqTsnT7CNCdY60UfhLqd9JZ5T12e2+kNwo38vy0ev1Wd3L2MH0wYdN6DDHPJFnR1roaTlLpdDwHRFApdzFg902+Ki7Vdnk7v5L80EFO3+mReh3ntJk5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oh3j5uyLBmdEDXXa/30oI+dzy4HsDDb/j7APdzayGZaaUlwGWS1qEF7ar0jvqAepaO9gMHZyhbYoyl4m3Fp8M3+hNJCP0mZVtWWpwO4tG82rJFrQMJwSnDsyLnOZbY93o2k3HzEXJswEZJLJESZjXFmRq4DGnAYMB+7ysLfxeYYTSMMHfA4eQ5mNOBVsLqz7S9HmHiBNOteAk/Yaw1XnHMydz0aYdcWXYiY/5bU3A9UrV2PfCzMRi+5ZnCTLwBV8Bwkfm2b5fAYIB2PrXWqAcZc/+eJrlhrtU8BIckjJ6t1/bV/eJca+ADD237TP8paQQc38jIbZHgAO1OHWKyhofZJPkSgMLcDYCYYlPKAvHoVkyRLgoqOym3ynIj3cFX6AaUGVqvcPcHD1+im8q4/iC46TC4JRbcDHm5IPnJgGFp+J9hyDjyKoaixb8oblLEe9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:04:11.6924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5a83f2-9b25-4294-88dc-08def26beefa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

Unlike the CRTC degamma path, which is guarded by
amdgpu_dm_verify_lut_sizes(), the per-plane degamma LUT size was never
validated before use. __set_dm_plane_degamma() passed the user-supplied
size straight into __is_lut_linear() and, for a non-linear LUT, into
__set_input_tf() -> __drm_lut_to_dc_gamma(), the latter always iterating
MAX_COLOR_LUT_ENTRIES entries regardless of the actual LUT size.

A malformed AMD_PLANE_DEGAMMA_LUT blob (e.g. a single entry) could thus
trigger a divide-by-zero in __is_lut_linear() or an out-of-bounds read in
__drm_lut_to_dc_gamma(). Reject any plane degamma LUT whose size does not
match MAX_COLOR_LUT_ENTRIES, mirroring the invariant the code already
asserts a few lines below (and which the CRTC path enforces).

The AMD_PLANE_DEGAMMA_LUT property is only exposed on builds with
AMD_PRIVATE_COLOR defined.

Fixes: 980f8710075a ("drm/amd/display: add plane degamma TF and LUT support")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 26e5c89375a5..d55dc06167a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1495,6 +1495,13 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	degamma_lut = __extract_blob_lut(dm_plane_state->degamma_lut,
 					 &degamma_size);
 
+	if (degamma_lut && degamma_size != MAX_COLOR_LUT_ENTRIES) {
+		drm_dbg(plane_state->state->dev,
+			"Invalid Plane Degamma LUT size. Should be %u but got %u.\n",
+			MAX_COLOR_LUT_ENTRIES, degamma_size);
+		return -EINVAL;
+	}
+
 	has_degamma_lut = degamma_lut &&
 			  !__is_lut_linear(degamma_lut, degamma_size);
 
-- 
2.55.0

