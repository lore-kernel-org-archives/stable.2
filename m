Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C62475CF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829790; cv=fail; b=RygBIWTLsIA8vJRg0ZhNVNNqBP1IMWpH46X8iEK4YX2l2Z21LhJCXRY1MU98FVk+CEXF3RvY0rVu6l3fhl8x4GVC5sbrG1QZMiugSifbPML3lZcg27XJitqwvyki7dC0LU6kvYMXuMGW5aMi+nqOJlcY+fJnSbwwio9JNKRkvns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829790; c=relaxed/simple;
	bh=m/eqMxIxcARz56iz3yjxLjEjESVqFYQbVRxtUczDmsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqCh8rYKWs/ob2lJbNdy++RdGJaGwk+1ZESnZbVTpgSg9MNAxJKWH4Q2jcmy14vWcjSyOKGyrb2s21s4YtGSli+kLvkdKkVC4hAR+rE6qoHmb89x0EX/2zder7azuFuGm4UlAwsKAMtPQDxpgt8/x2s7Q7ypGDckJRI6hnZ9Sy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qc6JAECo; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qc6JAECo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR8tLMzWZilBehWds4Shhd0CJKpe8XA1pdDcHQVVWPB+qTdXbfMAU5AACzeKU+w/xT3Zff4nNjowLXDoj1k334lb7OltQ2NZA4BK7pueksDudSYdH0BIqFcIpY3xtmDWOfmDerT+3WhrFxZ1QbQ/7w0QpgwJ5K/pdRLOBBts8XAPHl3kCyAoALCfpCEm+++mQzZ5nlCF83MMR9wvQKsKHUUtZ6ku2UTpv3VJLf1qgQHMQ1zYNqg21gW4AXL1V2SJ1cmINJPfHBUeA50LD3aI40hhwYT54+6F3ZecP8GB3D2r6iETPFBNsxbixK7brEHzfth0gx6VvoOlfFMHsawHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJNNTrp7PLNFk5b+Fc1iFQVLGztawxKNILoTSi6XHPo=;
 b=A9hzsCJfT2vi1qK4WQ+4vntJ/IDUS8qYO+DqHithI98IUPX0YAknPbbt3OJgHlvOYdEg0EnEi5FU3pSXFvfavUU5ZT1AHv1Lkgc4tYZCRPq7j8R6aHhTHwYUwU9pOGw4p+VsIWVbkbYCInVxoNELF9FhxT4jxRXneooqG5Hvq2GE0bNktVpUszU5SRstUrHww4wRxOMSemVmleoMFTGLHYs1OnQtbN/pccr7s5xhLNMgV3oecrKDQga2ijiV48AlS3QVDwxxWRRs+TogMf8Pun5j7ULAhlxFHjTZ9Z+9v6l9V5jPIjj7z0foOlJ5yQ+bdaE5B4E9KjujI47pW2/zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJNNTrp7PLNFk5b+Fc1iFQVLGztawxKNILoTSi6XHPo=;
 b=qc6JAECo6ynunNP84Iznab7GKOrA0ez9en2REb3UfmpuxfdsD22Yachyg8BnLqogXrUr78jV2JFVm2f9YhQOTeeEOo0NeJyrh11MQyuVqX6vPUnY7g0GZjHSTHQfDLH7eFaFr9jY+GgOIGQnQame5SDRnUxkQTMAnMJBxaHkVOg=
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 18:02:59 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::a1) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4 via Frontend Transport; Thu, 23
 Jul 2026 18:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 18:02:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 13:02:58 -0500
Received: from flamewok (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Thu, 23
 Jul 2026 13:02:58 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Fix flip-done timeouts on mode1 reset
Date: Thu, 23 Jul 2026 14:01:59 -0400
Message-ID: <20260723180159.52121-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: a0676365-d0af-4bbb-3d92-08dee8e4a17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VuqLeTkE6DQ3g39axAmR4N7JCuod3KrLhWATm8imUguf/09A9XNCX+mCvtCPaqu0jZBEGq6dHB0xxfbPOk8dtjimV8m9QXgzSZ5KtYy0xiqPBrrtH9Zn/erBERKUckwG5YQPuQ031UlP8nLx736yRwLk4fnXUN5alaUPlmWm8Glszvn/ZsWSf+TqNQ+Cvr/n2ygQNAuqdGQ62QxeAINmnmcsjN/K50Tria5iq/EupdcSOWIYc05C9yDHrwi9MhEq+7jBYQfzpz2H+oH6ouNpavjCrWecgS33KHdVoPU+qK70p//zV7ACqO46g4GH4hJTrBZca7HJOhcGwNwhN0/vdMagMERfpzS6lVoyjQwI+k5JmlLTGbKaTNRz4tX9Gm6TlYJ4hmpvnz7UpBvN0Xu5Nthpm+/hbCxP/5ANPm1oQm8gBNnZqa3bMvZkSxlQ1pYKNc2C7X55uqr8ZTcbkCMWRWlfkVCvf/XAKsb9dlAUILCimNZkqPnfuEEZhvgLl4M4wl8vDFHI8Dh01AMWZE9he8rkXHb6ZD2e0ensZkvX8zCQM+TCDKav6lexTsVJkiLb1tno0rLZbBcSUjhMbI62r3X+nbpNCgo6BDXC6Wyw7rhdEd8gu5hAtX/PGv4sOt6wN+A1MDiakoZ32E8tfD3SB7WXPmcyK+exV6IUzYqFWMjA1dwumn1K0ujoyY9lbdI+9ueq9PwyiDsaJeY6Tw81mA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wcE2+tDT7iGIqaI9KGD3g8nUf9j04PWuHV1vKKvtROnZ2KmJ/5mHp0QqsS8bTx8RUpY0Wth3Lz5NRLRVrsXtQt5JRBKUVziNgKyPWt2IiM4jaNlYsak/inAj2SG5DQe3SI9kCxCdUwiDtrIDqt9fvkEmskqXY3T6LJyrjrQaPuFF5kd9ZmZSimNVKFdv0ZeOHoP5rkNxWimlTycg//g8j5ci+rNSj7SsJy+oSX06izxx04vCTqFMnPkzZvEfvFsFLfKCKKSWe4XPakqEO90qdJ0TBEbOyzVXizPGOu6TGuHK3eG67zHMbMNWwz1Nmhikm8dV/k04CNsM1YuvH3QWblFMVZOh3JzVMmtDfMsfrDmBPlDtEErXHzMYnOs1ImoOOWWIU38du5iLBk36OfE+Y4qI32brOt9bnOinz7m1Nm6xx1k9jlR2jJCVZcsD7d6T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:02:59.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0676365-d0af-4bbb-3d92-08dee8e4a17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

From: Leo Li <sunpeng.li@amd.com>

The vblank on/off callbacks mixed use of amdgpu_irq_get/put() and
amdgpu_dm_crtc_set_vupdate_irq() to enable and disable IRQs.

With get/put, base driver will callback into DC to disable IRQs when
refcount == 0. With set_vupdate_irq(), DC is called directly to disable
IRQs, bypassing base driver's refcount tracking.

During gpu reset, base driver can restore IRQs via
amdgpu_irq_gpu_reset_resume_helper() > amdgpu_irq_update(). So if
get/put() is not used (i.e. refcount == 0), then vupdate_irq will be
disabled.

This is problematic if DRM requests vblank on before amdgpu_irq_update()
is called: drm_vblank_on() > set_vupdate_irq() enables vupdate_irq, but
the refcount is still 0. gpu_reset_resume_helper() > irq_update() then
immediately disables it, thus leading to flip done timeouts.

This is made worse on DCN since VUPDATE_NO_LOCK is the only IRQ enabled.
Prior to 8382cd234981, a combination of GRPH_FLIP and VSTARTUP IRQs were
used, and they used get/put(). This explains why 8382cd234981 exposed
this issue.

Fix by using get/put() instead of set_vupdate_irq(). DCE is unchanged,
since it relies on unbalanced enable/disable calls based on VRR status,
and hence requires direct set_vupdate_irq(). Plus, it also uses
GRPH_FLIP and VLINE IRQs, which are properly tracked by get/put().

Cc: stable@vger.kernel.org
Fixes: 8382cd234981 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 05d6915f9a6b0..079d4ccc88da6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -287,10 +287,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	 * is enabled. On DCE, vupdate is only needed in VRR mode.
 	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
-		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
+		if (enable) {
+			rc = amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Get vupdate_irq ret=%d\n", rc);
+		} else {
+			rc = amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Put vupdate_irq ret=%d\n", rc);
+		}
 	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
 		if (enable) {
-			/* vblank irq on -> Only need vupdate irq in vrr mode */
+			/* vblank irq on -> Only need vupdate irq in vrr mode
+			 * Not ref-counted since we need explicit enable/disable
+			 * for DCE VRR handling
+			 */
 			if (amdgpu_dm_crtc_vrr_active(acrtc_state))
 				rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
 		} else {
-- 
2.54.0

