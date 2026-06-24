Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12283DD502
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324593; cv=fail; b=SU53vbx6uyKU/iVlllnqEOGG71CvQ/sPDJQ0XIego3fkNLAgusITLGvWTb+GjKn4hBQ5ukOTb3uyX9BfZ0kpuiI0LoVXYWxLuEpCegwDg2hTOiTD+UJ/BZaz9899q+HG5xSOe78vrpIXbZDYtJUXPqxYi2GNOE9psELmpR4uQLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324593; c=relaxed/simple;
	bh=wtBaLy20xPh4wfrJT+DhVim6X4PXuT9JtlAPtlZC8d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsY70bHyqjKP5KCgGU3+KP3R/zqPIlYoRNCLlF7LgZJmmnFBa3WZrnOTkgRqjAKgff+FNPYrklFFEgu8N4rLfkJzn5hT7npRSXHoykX0vR88p68OlD5/X1jQ36DaB397BI7tQYhoYOH8ZinaT7pPE5P5Du0fUlzoBdjYt1UGqZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fw3TRNPE; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fw3TRNPE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv7ZGdwS6opMVOxcXnPTp8WjvwTVNhPCV9on4Mx7FBqvqH/lJ+qK7kP7Jx0qDcD80oowIdQvE5eYE4hTFsfOuhCYi7vw56pkGkbKiUIArRH6k60qc77qEPxwq9FmeGIZ9LesVKsvSqwwHVMCBWjK65z9agVOEpBpQOWFwcfMMbM4fq4IEXssByiyyrrincKIb9lT14A0iaNxULpoUVjoPZw/Zys1iATBEvJf9qeNJRUwWO6i+lO8Og+8SuVEKYUO6oaKRcFHnHDBoCqmXZNKEfug1ZE/3naTzKFEhD1xMviD6hMouSci9B9b9/0zq0Inh2l/YAxYScioCXW8UMaIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+7INNuQiJ4XwMfe6y7oY/QjQPSKbtLqWpCykD79tSU=;
 b=rl1Nz1AfaUMjyefCcB5bOfvmqlsr2m2Sj33KoSVEp//iZFBj6j8NBaPbGYxHAiRfNGuxyxPebxcERpIsIVm4U0WR0CXW1pHYvnx+L/Lyz39B5y4o6D5Vr56i+LPJ7bCiWvOtt7jPCz6eJekuqRBYCNsu8Ow8AyOuNUIs8+INjZwGxVybDSySb3XZTE1lsO2lXjRgFkO3w8mTaE8ec2XSYFqZiUpD7bklROb8DV8vJSjtetJcb/VxbCL1hWWAzDlLEXIIupxdvdVjUl5NZUu9xdYshDeV+3BfO8DCo6/L2llDIn0opcqq2/OT6DpWLPTCBQZWVdKjwrEBtrMdueD0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+7INNuQiJ4XwMfe6y7oY/QjQPSKbtLqWpCykD79tSU=;
 b=fw3TRNPE3dRm3Ki3MCYO2xyBio+EN9QShU/Sm9uR72NWVE5AbM5O/QzcGgFru5yqP8mM2MsmblyWlemHGhZyyMVt/apB42bs51qL06XiC69a0IIVOzoiNgsPh2rpgpPKv+gei2sFJFgFoAO0evAlL/RpehZr3kdyYKuCnOrFklg=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:43 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::92) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Wed,
 24 Jun 2026 18:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:43 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:34 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, George Zhang
	<george.zhang@amd.com>
Subject: [PATCH 22/28] drm/amd/display: hold a vblank ref while writeback is pending
Date: Wed, 24 Jun 2026 14:03:20 -0400
Message-ID: <20260624180829.4775-23-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: f82f7acf-8903-45cd-796c-08ded21bc45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|22082099003|6133799003|18002099003|13003099007|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	6Pw0VDqJYMDs1UTvsleEB+2B0BMj4vE9qKiwanUTBQAM8DQJqeTDJOI+CJfGJhgx6iotfj9cy+F/R6E9cQcdyvYbxGXAvk4Df5lYZR01XIPNBmIuVysHGt8IzXJcoIE0wBxz+rHTF2rHsU8+MqCE5kJhZAZ9RZb2SuGOpJG/mLudi4lJ0UVuBOfwE32aL3x3N6Codu1kIn+0KpfQtQM6uoePpAgTMv2wxcah2TuZw9LUytkA81viRj6b0BD1mrWnJWCzY9UpsqRnfkgug8s16MQ0tdvsY1jcCjdglAqb5jrU9pGfQnheRzldm8COpMO/17I1nsx4ERgM2ReslXGB3EWJBDIZhgsrXUG6vTVjv3he4v64CtKcny3BLmUg248HsOgTfYE2Qk+1kyRcGYZFcH1cOYAZ0BoBDGkP4YXo70vvNJ/CGWgoP9hEid6n/qD3r40Umu3egZ6NVP9+dtKNehHKDXwDEM0pdefpQBPA2YVzBQHSDnACeJdyhhxKcPbRoFu3xyQebnTAZPEK1mGuTjLyuqnRpBXrfyPy9oF8U6D93DX+bQVt9tp4YnrjWJhwZWF8JMctcOMrRNREK3c4789u6Whv/WOpG8Chjvz+vbd89P8SUHYN+50SVQc0jMev3BmSJAs62goLCXzfpN8tyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(6133799003)(18002099003)(13003099007)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ep655hUn9YdUX3ycg7fKZSsPydxJt0XmdBwRhkV/YcRUAbBwimPg/L+4jUWQe0rTb1k+0ttkggMGuXxfiAEpEZO8SIod4KvixYdVn2UrTV1wuJrGaUXQ9qksDw+avnpcYe3Gh+zGZnpKX9IybLxqN4ytyZf1r6sZ2E2JMXQrWcGgRe9rTzK9vpKzAdGuTRN4Uh4IKNQCyQXhDdxJ3sr/yACpCQ3TlpnT09TFrdIqFh7vqAa+IrNfp2cKE07i71gm6pdUt8WM7A/SwBJtj17YWMb/nMqo7nNqMdchZzZ7tAQNbkTzFqMhxrd/NNJkSwlwkSb4wlAnz4aY2MYy7EgM7mrocpHl99aIOXJ0HW+OtFQGNZZLiGY6d7xc/hzAkp8oSBYf2zyo8OlT1n80INNnFEs+m/Jkag4Ejr+BvU9XJhShxBEUMTGWz+lxkl63TiFj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:43.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82f7acf-8903-45cd-796c-08ded21bc45e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

From: Harry Wentland <harry.wentland@amd.com>

Writeback completion is detected in dm_crtc_high_irq(), the CRTC vblank
IRQ handler. The arm path (dm_set_writeback) never took a vblank
reference, so the interrupt was only enabled incidentally (by a pageflip
on the same commit, fbcon, or a previous vblank's off-delay window).

A writeback-only commit right after a fresh drm_crtc_vblank_on() (e.g. a
writeback connector detached and re-attached) therefore has no vblank
reference: the IRQ never fires, wb_pending is never cleared and the out
fence times out. This is reproducible with IGT kms_writeback and was
seen via kms_colorop on writeback-capable hardware. The relevant IGT
branch is at
https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop

Take a vblank reference when arming the writeback and release it once
completion is signalled. The get is done before arming wb_pending so the
completion IRQ cannot drop the reference before it is taken. Factor the
shared completion bookkeeping into amdgpu_dm_crtc_complete_writeback()
and also call it from the teardown path, so a writeback torn down while
still pending signals its out fence and releases the reference instead of
leaking both.

Fixes: c81e13b929df ("drm/amd/display: Hande writeback request from userspace")
Cc: stable@vger.kernel.org

Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 ++++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 45 ++++++-------
 3 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ca62304fba2b..c72c417903fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4494,10 +4494,55 @@ static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_stat
 	stream_state->mode_changed = drm_atomic_crtc_needs_modeset(crtc_state);
 }
 
+/**
+ * amdgpu_dm_crtc_complete_writeback - finish a pending writeback job
+ * @acrtc: the CRTC whose pending writeback should be completed
+ *
+ * Clears the pending state, signals the writeback out fence and releases the
+ * vblank reference taken in dm_set_writeback() while the writeback was armed.
+ * The pending flag is tested and cleared under the writeback job lock, so this
+ * is safe to call concurrently from the completion vblank IRQ
+ * (dm_crtc_high_irq()) and from the writeback teardown path
+ * (dm_clear_writeback()); only the caller that observes the pending job
+ * performs the completion.
+ *
+ * Return: true if a pending writeback job was completed by this call.
+ */
+bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
+{
+	unsigned long flags;
+	bool pending;
+
+	if (!acrtc->wb_conn)
+		return false;
+
+	spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
+	pending = acrtc->wb_pending;
+	acrtc->wb_pending = false;
+	spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
+
+	if (!pending)
+		return false;
+
+	drm_writeback_signal_completion(acrtc->wb_conn, 0);
+	drm_crtc_vblank_put(&acrtc->base);
+
+	return true;
+}
+
 static void dm_clear_writeback(struct amdgpu_display_manager *dm,
+			      struct amdgpu_crtc *acrtc,
 			      struct dm_crtc_state *crtc_state)
 {
 	dc_stream_remove_writeback(dm->dc, crtc_state->stream, 0);
+
+	/*
+	 * If the writeback is still pending when it is torn down (its
+	 * completion vblank IRQ never fired), signal the out fence so a
+	 * waiting client does not stall and release the vblank reference
+	 * taken in dm_set_writeback().
+	 */
+	amdgpu_dm_crtc_complete_writeback(acrtc);
 }
 
 /**
@@ -4650,7 +4695,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
-		dm_clear_writeback(dm, dm_old_crtc_state);
+		dm_clear_writeback(dm, acrtc, dm_old_crtc_state);
 		acrtc->wb_enabled = false;
 	}
 
@@ -4924,9 +4969,24 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 
 	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);
 
-	acrtc->wb_pending = true;
 	acrtc->wb_conn = wb_conn;
 	drm_writeback_queue_job(wb_conn, new_con_state);
+
+	/*
+	 * Writeback completion is detected in the CRTC vblank IRQ
+	 * (dm_crtc_high_irq()). Take a vblank reference so the vblank interrupt
+	 * stays enabled while the writeback is pending; otherwise a
+	 * writeback-only commit right after drm_crtc_vblank_on() (e.g.
+	 * re-enabling a CRTC that was disabled) has no other vblank reference,
+	 * the IRQ never fires and the out fence times out. The matching put
+	 * happens once completion is signalled in dm_crtc_high_irq(), or when
+	 * the writeback is torn down in dm_clear_writeback().
+	 *
+	 * Arm wb_pending only after the reference is held so the completion IRQ
+	 * cannot run its matching vblank_put before this get.
+	 */
+	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
+	acrtc->wb_pending = true;
 }
 
 static void amdgpu_dm_update_hdcp(struct drm_atomic_state *state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2f4a567412f1..909ee71d6d59 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1120,6 +1120,8 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
+bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc);
+
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
 
 void amdgpu_dm_emulated_link_detect(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index a821183c076b..c5467f34c51f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1965,7 +1965,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
-	struct drm_writeback_job *job;
 	struct amdgpu_crtc *acrtc;
 	unsigned long flags;
 	int vrr_active;
@@ -1974,32 +1973,24 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	if (!acrtc)
 		return;
 
-	if (acrtc->wb_conn) {
-		spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
-
-		if (acrtc->wb_pending) {
-			job = list_first_entry_or_null(&acrtc->wb_conn->job_queue,
-						       struct drm_writeback_job,
-						       list_entry);
-			acrtc->wb_pending = false;
-			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
-
-			if (job) {
-				unsigned int v_total, refresh_hz;
-				struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
-
-				v_total = stream->adjust.v_total_max ?
-					  stream->adjust.v_total_max : stream->timing.v_total;
-				refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
-					     100LL, (v_total * stream->timing.h_total));
-				mdelay(1000 / refresh_hz);
-
-				drm_writeback_signal_completion(acrtc->wb_conn, 0);
-				dc_stream_fc_disable_writeback(adev->dm.dc,
-							       acrtc->dm_irq_params.stream, 0);
-			}
-		} else
-			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
+	if (acrtc->wb_conn && acrtc->wb_pending) {
+		struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
+		unsigned int v_total, refresh_hz;
+
+		v_total = stream->adjust.v_total_max ?
+			  stream->adjust.v_total_max : stream->timing.v_total;
+		refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
+			     100LL, (v_total * stream->timing.h_total));
+		mdelay(1000 / refresh_hz);
+
+		/*
+		 * Completion (signalling the out fence and releasing the vblank
+		 * reference taken in dm_set_writeback()) is handled by the shared
+		 * helper, which is also used by the teardown path.
+		 */
+		if (amdgpu_dm_crtc_complete_writeback(acrtc))
+			dc_stream_fc_disable_writeback(adev->dm.dc,
+						       acrtc->dm_irq_params.stream, 0);
 	}
 
 	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
-- 
2.53.0

