Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A776EEC3
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635362; cv=none; b=g13B4Mlidxh933jyR+CfMNhY1+/Jl2AInFrvEzGTXH8vfUuxSEOVQ/VomL7d487bqrXEOreBKcJzQGDkbhtspPxGCq1NsaNEYZOsSYxbsDhuCAhexxp2SGACU19Rb4ZzfMmNxZk/sApEALy9kYobKEMkYylmAVah1++1+mTVGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635362; c=relaxed/simple;
	bh=ULm1eNmgWlp3xTmjOyrtSq9Po5TWP/gwaj3mnYRFzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU90IULXJ6iCpma/6S/mK8JKiaJKU6dM1j4i+TPVX50pJ565KKsaziRNpjJqMEnHKtDNE+TvMSsDcpRnoekWSG4y2wDtclvGEk5AzNv2Pp0pFVZni0d9YUSwUZH6VObvUsUEhpaT4pWcPcwXbWVrCbOLLH6QRZwTZHC7wsmgK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9BOFssl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9BOFssl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8321F00ADB;
	Sun,  2 Aug 2026 01:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635361;
	bh=FXG4TDxJjxHWxD7byUVXWiLRX4P0a6bAvI4E8ZbEEvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9BOFsslc5QRm+B1V2Ng6IXLKuvdR+fuJ9zTzvqXsBLR9KLWX2iuiXOqPQC7YSGC1
	 70weGJuJwj/LLhQWwIfcxnCM+vWJ1RttRG8UG659I6OUpiNNxi07syAOjqGooo6Tkh
	 XY1SIpVC2OFX3zCxBKoiEkrZ411rW9Tm22qqX/hiKv222dzojEMll8CdRUAiz5uGUD
	 Y7oIR60rM0bhs5OetMTnnp5xkv9/Dgdq9vyC+dGujMTJKmp79rNHM1yS2glUi8MtyP
	 uaa/UwkJFA52W+jjg1TIaGpUWf6JCcLZpME+HrDOQvfQNM+xpV7Rx2d/mWP55FlnaO
	 yl+6SrogTtERQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oak Zeng <oak.zeng@intel.com>,
	Brian Nguyen <brian3.nguyen@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] drm/xe: Add page reclamation info to device info
Date: Sat,  1 Aug 2026 21:49:14 -0400
Message-ID: <20260802014916.504747-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802014916.504747-1-sashal@kernel.org>
References: <2026072945-jaybird-vaguely-739f@gregkh>
 <20260802014916.504747-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oak Zeng <oak.zeng@intel.com>

[ Upstream commit 9b1a0e0a15c97987fdf56a615f3d13995bafd042 ]

Starting from Xe3p, HW adds a feature assisting range based page
reclamation. Introduce a bit in device info to indicate whether
device has such capability.

Signed-off-by: Oak Zeng <oak.zeng@intel.com>
Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20251212213225.3564537-15-brian3.nguyen@intel.com
Stable-dep-of: 6384271ac1ac ("drm/xe/pt: Reset current_op in xe_pt_update_ops_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_pci.c          | 1 +
 drivers/gpu/drm/xe/xe_pci_types.h    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 0e80f2940c99..2ed03fd074ff 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -305,6 +305,8 @@ struct xe_device {
 		 * pcode mailbox commands.
 		 */
 		u8 has_mbx_power_limits:1;
+		/** @info.has_page_reclaim_hw_assist: Device supports page reclamation feature */
+		u8 has_page_reclaim_hw_assist:1;
 		/** @info.has_pxp: Device has PXP support */
 		u8 has_pxp:1;
 		/** @info.has_range_tlb_inval: Has range based TLB invalidations */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 89cc6d32f041..b78729211790 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -591,6 +591,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_heci_cscfi = desc->has_heci_cscfi;
 	xe->info.has_late_bind = desc->has_late_bind;
 	xe->info.has_llc = desc->has_llc;
+	xe->info.has_page_reclaim_hw_assist = desc->has_page_reclaim_hw_assist;
 	xe->info.has_pxp = desc->has_pxp;
 	xe->info.has_sriov = desc->has_sriov;
 	xe->info.skip_guc_pc = desc->skip_guc_pc;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index 9b9766a3baa3..a7b6576725ed 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -42,6 +42,7 @@ struct xe_device_desc {
 	u8 has_late_bind:1;
 	u8 has_llc:1;
 	u8 has_mbx_power_limits:1;
+	u8 has_page_reclaim_hw_assist:1;
 	u8 has_pxp:1;
 	u8 has_sriov:1;
 	u8 needs_scratch:1;
-- 
2.53.0

