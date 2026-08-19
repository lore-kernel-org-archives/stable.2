Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCD3009F2;
	Wed, 19 Aug 2026 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118475; cv=none; b=aD1Q16U6sGhZv9yY+gDC0PkCGhTCkjCpXJVfMK10neIoPfOIlYPnSS04c/Qv+OIo93xgHrXif5FH1P1F0CfZ3bN5u1WBmtFKRyjfe/CEbqm4IfaO8E/hbQorHLb2eRrg5w2Qbu27ijNXPd3fMovzAP82TolrKueAzkK3PwtA2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118475; c=relaxed/simple;
	bh=/P0M2aVGm5QOUw0nnoxK5mEpWBwxkj4ivElxg5lSp7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAlfKd2bLLMDzk6eu5HrukzteEOWwiQBx/2pT953bD1rLFEGPVf6P9v/uD/sp1zI7443JPGU7BqPwnth7v2RH7+BNB6dqvI3H76vIfDFUck0qfbvZOAd35CNESws53zSI02YwnqbLczvdbbL4QPKHp1GV4hqAfQLSoK8fsq8iS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 81237c649b9111f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:935162e1-4b5d-4aed-acbb-16546980a9ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:061688282109be565fb1e26fb1d5117b,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:5|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81237c649b9111f19a56ed5b684f684d-20260819
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 191839397; Wed, 19 Aug 2026 13:47:46 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Mario Limonciello <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	gonglinkai@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix dc_lock leak on GPU reset error paths
Date: Wed, 19 Aug 2026 13:47:42 +0800
Message-Id: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On GPU reset, dm_suspend() takes dc_lock and leaves it for dm_resume()
to drop. If amdgpu_dm_commit_zero_streams() or dm_dmub_hw_init() fails,
the function returns with the lock still held. The matching resume path
is then skipped, so every later dc_lock take hangs.

Release the cached DC state and unlock before returning the error.

Fixes: 3cf7a0bc87f0 ("drm/amd/display: Catch failures for amdgpu_dm_commit_zero_streams()")
Fixes: 2b6943df5413 ("drm/amd/display: Pass up errors for reset GPU that fails to init HW")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 941c1a312824..214aca906fe1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3511,6 +3511,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		res = amdgpu_dm_commit_zero_streams(dm->dc);
 		if (res != DC_OK) {
 			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
+			dc_state_release(dm->cached_dc_state);
+			dm->cached_dc_state = NULL;
+			mutex_unlock(&dm->dc_lock);
 			return -EINVAL;
 		}
 
@@ -3824,6 +3827,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		r = dm_dmub_hw_init(adev);
 		if (r) {
 			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
+			dc_state_release(dm->cached_dc_state);
+			dm->cached_dc_state = NULL;
+			mutex_unlock(&dm->dc_lock);
 			return r;
 		}
 
-- 
2.25.1
