Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793143435;
	b=nv/aSFFeh3VmrMEPIdkBJmfQHROmNcbT5hy3O1jDAx/iMqxy/ljYauzYEhCahkIgKJ6N
	 pe32JTkZs85mWUUvzkkQkcEm/08Kgc65s8Zx0PyJgPm0urfNS5ewINurfiap1wwB9Lf/j
	 lwBXXdWgToRShjn4IuwRoSwUCQIO2Pz9NRgA2ZmBbMhyr/dx0R4VMhtwj0KAQWVgeJtMX
	 TqyXbqwVj06N9Bj6/8WgTXM0jTJtbh88WT9X718Tk1yR1QYcG3xRKP/XRymsHrCkeeH0j
	 kQ2UUC/a+nw9tbVX5SFhekCVg8wHAmV6qkLXdCw21igmSA0mmin/vKbhuEF4/5vuRZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143435;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uB4PAhCOUnzNSPnnSonQR4dF19dvYyOdw9YsF3LxuAc=;
	b=M5CO2R10MbtNlGWRf/FXWkTZ1xrqvZlfjrtmG7fKL7FGUJoc9dgN56CpHNjL0qgwPP2Q
	 ch3fnkLw0Q+dGRG9ACVo8Kn8wFbZgGgVn12oBziIU9ANPg9D6kriE+ODawDjrs4TBFx8P
	 04a9/pcycNWGG8EfG5HGwM45S0AFVtoaJYkmLCgdIZ7idWbf87PQAjLwDODqYjDwGB0Xr
	 8RIh+ItekqmLAdAYqOsCeQqCcyzQYotvxgLELWAJfKTWWTs1/s1h9IXEDAsgqJMaHh6Mt
	 LbN8eLfIoCtxuVyIgpr1kT7OuTCnxApqQ6O3YN0fsG+XvkVkGRRamIK4JGtbti+dAew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S+UFHbbK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.41
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29762606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 23:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29762606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S+UFHbbK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqsjBdiH0gY8E0LS1Si5CHhSr59MwqZxtwJciCfCKWVhjSkeORK4qo28wD15oH6wTyDHg+NHXE4a6RgxWanVV7I9v63zfp48ZXpAoXOQPZB8pI/Dg0PJQ64mpkhRFcrKjGhFgtZxwEWsS8oYF76feZa6ta2Joo0k7Ddr4oUtoY3/DUYCMbDkPmjalIaj+nYenSX4fCgdrmsydinVU/HKCzBSw/X5bDxWI2xhbun2oa2fcBm5qfeO4nf5SB1hdlpcaHCMdBVsRFC4ipPRRSg2g+3biC5pS8sLe4E+AlmZ7jGBZ1/EqGKWc1kWZFB40cC/ukdHjzOQ4uAXlpolH/Omzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB4PAhCOUnzNSPnnSonQR4dF19dvYyOdw9YsF3LxuAc=;
 b=gHvQi6IrnDQBZdErAVjkosasLIW1H4rNCKIgtDhoFt/ogJ/zS387SD3imdDvHe9GNaEKmLJ2aQAUSQLCeV05QDFKeVxBhVwyRB/YkJpaxLkhnjr95zg8KA6JmOF3tN3Sbb2Pb8oQFdvFrbB29j6nPXcyiwN00/Al4Mdfy8Kn9Kf4ylHwmA6P2pc1hCC6VxN8n18CfmI8H/l8vU99KAzghzApAjs7RTsGNTQK2F0lRLXD4S9wG3QcUXpmrro1hCx6o9Pr+8FRcDcxGTVjUQnYvch/jY2jP9kaR8s0TTLY3YqfhmZ9JPJGgmdv5CSxoeqPytJG0/tfCGbC3Pn5zcxHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB4PAhCOUnzNSPnnSonQR4dF19dvYyOdw9YsF3LxuAc=;
 b=S+UFHbbKkNDePJ8ySiDXUNcpPs5e/rJ8zVzaU9mfGuhdXqu99JBh5bqPsFUeT1YWTYeh983gI61xlUDjbLRmwGQ6+/GWZRQqCOnTqoeOeI3FHnkjzTeMyRWkWa+bXNjFXyVGlgfcRnFV5mzr/SiR3XMX9E5XvyB2CWOz1LIfTi8=
Received: from CH0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:610:e7::17)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:23:32 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::12) by CH0PR03CA0222.outlook.office365.com
 (2603:10b6:610:e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:23:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:23:32 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:23:29 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>, Dillon Varone
	<dillon.varone@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 14/28] drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates
Date: Tue, 27 Oct 2026 17:17:10 -0600
Message-ID: <20261027232005.2879750-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: b99fc090-61b5-4015-b38a-08df348150da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009221227099003|261009223327099003|261009220027099003|261009221727099003|261022075727099003|261021121427099003|261009223027099003|261022105027099003|10067099003|56012099006|261021123027099003|261026121527099003|6133799003|18002099003|22082099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	4EPxeJIe0rwkqP7Zht9NkpbJgYgYei4CSrts4vqBwgNFa0ZRXz3GdIwjmj+PAuciykegFm5fZCuZkd88SvUH7u09LFXFy8hz5lnUfUwJK7TnXZIDhs1GkVMHWvFH3emzG+2qqBhs2/asD3tMteRiuR25GSdOMvOONdX8oYIaeGAj7mMTiqJ/ytpsYJL5mUUmz8tG2Q7+BHZ7CMwxpTrpn8gqb7qeVugKxFNSSfdA4XnD7Mt6CIZqWyDNKczZTUwM78aO/K39/3QSvv0lu3/ufEkRgPAGuFe6uAXFy3uELvW0VQi+lqoxHyIlHBRkxaFE5l7MWDGCl2izXFW2upodbZaIs7Ky/LPe0VpMUx0Tc+JEqOWF1B7YosJ0V+KhYlUb6EzxTyH5CQTgiE/S3ugcXup0AXCRWntkluE+Ax7GuSti4V5/wz2El39K9v3zk6GRaR3rLzVj8cSn7Uz90FVjrO5lm8/0IxWxVwjLeQgDEiFtQyt+e3SPrvsY6v2MVm9UTOIOTOAxXc/m7Bd6XC1FRKSBVAxZCB4Tx0+ko0jiabszjoa5KOdWqLeVEiGPxDFGIZ3wq0co1GP9hMk1zpeD2utF5C05mx6i8/bCUwJkBLwpfSL/4zpw5r2uSnOgn9+an/WE5R5Mzi3t81271krBVJnkDuMXqJSDYnj52EkP0tQVlNFrG0XGTBZwvtUm1LvzPWzs03zHS0bNxawRhgoqfg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(261022075727099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(56012099006)(261021123027099003)(261026121527099003)(6133799003)(18002099003)(22082099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BFpW1dBoJT2HjzY1kvE5glJLYrzN1aLaA4Gzqy/LytL0lMaxAtjl+wC7y2c6cSdKg0MlbEZzxIp4923t2ni27mxl/6i53eK40SwJyBt9AtaGgYUjvJwycPoWrFAOelYfMvAYHEPfFNV3WgHE2q0CkJy0pS9Z7l200VvFZh8tyv599DlsVK/8JezZEFI5TepQXolneuSxaKBvce9AX4cPla93FMMWldnt5SvCIFXaIzAk/LzBX7kz75xW/i2/HdmApd9SmVNNS9s4xYaF3ezaxSfkDq4Hu5/dDdV8m/flJkeNSsm7miepaaqg2KDozJwKMY0ZGu6fZsZ0nJiM3+0Sp3+hG26YG1nlAXCX3UK2jUV6VLIdqJFXGv9AIZidDirnx/yEAeKmCpaArQKiqKfREZm+0aoYUp5j3i5JNZraocMJDO8NXoXH90TyuDDQfp4f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:23:32.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99fc090-61b5-4015-b38a-08df348150da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

From: Roman Li <Roman.Li@amd.com>

[WHY]
DC asserts with:
WARNING: dc/hubbub/dcn401/dcn401_hubbub.c at dcn401_program_compbuf_segments
Call Trace:
<TASK>
dcn401_program_outstanding_updates+0x36/0x60 [amdgpu]
hwss_process_outstanding_hw_updates+0x33/0x40 [amdgpu]
commit_planes_for_stream+0x171f/0x1ff0 [amdgpu]
dc_update_state_execute+0xaa/0x170 [amdgpu]
dc_update_planes_and_stream+0x42/0x70 [amdgpu]
amdgpu_dm_atomic_commit_tail+0x16a9/0x4020 [amdgpu]
commit_tail+0xc3/0x1b0 [drm_kms_helper]

The DET left by the VBIOS on a HUBP without a plane can be larger than
the DET planned for the new state. The compbuf is sized for the planned
DET, so DET + compbuf can exceed the CRB size. Programming the compbuf
then triggers the ASSERT and sets CONFIG_ERROR in hardware.

[HOW]
Release the DET of HUBPs without a plane before the compbuf is
programmed.

Add hwss_reset_unused_det() and call it in the commit and flip paths,
to cover both seamless and non-seamless boots.

Fixes: 7a1eb6680939 ("drm/amd/display: Perform outstanding programming on full updates")
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 +++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 31 +++++++++++++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 ++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ae5f03a73132..e73666e46557 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2551,6 +2551,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		 * update pending complete before optimizing bandwidth.
 		 */
 		hwss_wait_for_odm_update_pending_complete(dc, context);
+		/* No DET may stay allocated to a HUBP without a plane (e.g. left over from VBIOS) */
+		hwss_reset_unused_det(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
 		/* Need to do otg sync again as otg could be out of sync due to otg
@@ -4981,8 +4983,10 @@ static void commit_planes_for_stream(struct dc *dc,
 	dc_exit_ips_for_hw_access(dc);
 
 	dc_z10_restore(dc);
-	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
+	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required) {
+		hwss_reset_unused_det(dc, dc->current_state);
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
+	}
 
 	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 415ad6ddb740..3c5ffa7073f5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3140,6 +3140,37 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *c
 	hwss_wait_for_all_blank_complete(dc, context);
 }
 
+void hwss_reset_unused_det(struct dc *dc, struct dc_state *context)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+	unsigned int i, j;
+
+	if (!hubbub || !hubbub->funcs->program_det_segments)
+		return;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct hubp *hubp = dc->res_pool->hubps[i];
+		bool hubp_in_use = false;
+
+		if (!hubp)
+			continue;
+
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[j];
+
+			/* A plane-less pipe renders from the DPG, its HUBP (assigned with the stream) needs no DET */
+			if (pipe->plane_state && pipe->plane_res.hubp &&
+					pipe->plane_res.hubp->inst == hubp->inst) {
+				hubp_in_use = true;
+				break;
+			}
+		}
+
+		if (!hubp_in_use)
+			hubbub->funcs->program_det_segments(hubbub, hubp->inst, 0);
+	}
+}
+
 void hwss_wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 3ee6129a388d..e8ffae05add8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -2059,6 +2059,9 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc,
 void hwss_wait_for_no_pipes_pending(struct dc *dc,
 		struct dc_state *context);
 
+void hwss_reset_unused_det(struct dc *dc,
+		struct dc_state *context);
+
 void hwss_wait_for_outstanding_hw_updates(struct dc *dc,
 		struct dc_state *dc_context);
 
-- 
2.53.0

