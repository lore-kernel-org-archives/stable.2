Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDC471D1C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197469; cv=none; b=coihpH6PIZBmsOlx44B4CQiERpH5Tdv0yrDKA8xfBU17AuFzykFicLfcyFIkxPANA+XXDayF3iYEoendyLhQQ/z0zzOjKbU6TzGieGsCBknkvX/+bWz+OmpWqUdIKR9zkyBQ+8gGPUQteUVU23r2j7j+bURLTh5W7X3Nj45FvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197469; c=relaxed/simple;
	bh=rBb7eFqqb8ta6FUOfA1Kqs9afPVT7/9moYnEfn18qmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuMiIsTtiToff0+dChEMB5Pfh4cjzEneeVzf5bbIcIbQ0ueBUwQIQ8SDCEBkI+lx+e0pzHWkZkXxvq9Y9G6BNyROWsmBxnPytA0RzexaKabCUH6+7ZY9DOeziIUdztPPrIXX/XOTzdh1nUPrDtNf1lMudt4HbHTv1AOWP5VnSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmvcHs4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmvcHs4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90BE1F000FF;
	Mon,  5 Oct 2026 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197468;
	bh=gI9141ZYdgLS+cA5QZltr4WT2EEL1dcgU0E4+z6CrFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmvcHs4QNuEkJ484T60YJFSluqxJsxZjMEfoXVXs/imGSJ4zNiKylMfBPyx/+SrNM
	 eMqoGTp0XMO98DUZmdvsfpUn8z08ZfqJTM8+cWWpkGY8RgGhcPRAx58Y0rgk47UOEj
	 XAQKVhQthn/85sVC2GWw0hVhIVHjN+H4YLEQUg+DKTBPaMpZcn2ki8fHv8lnhUT78i
	 W5inSlJbd+Wx+a/5I7uHQRmwlyu/Ub8w/uenvh2JEABrsM0CPMx4/J8C9rgFhhxr7j
	 TN3h7pKd4+ATFr042IwDdAh7uVa8loZSABS07eEp3r3fvAO2cbUfdB1DZp/5aG5/ku
	 17ztXpkqOHhJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	George Zhang <george.zhang@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend
Date: Mon,  5 Oct 2026 06:51:04 -0400
Message-ID: <20261005105017.1547713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100557-busily-flail-a0c0@gregkh>
References: <2026100557-busily-flail-a0c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit 015e72cde567d2450e282c2790773463156b2d0a ]

dc_state_create_copy() can return NULL on allocation failure.
dm_suspend() only conditionally skips dm_gpureset_toggle_interrupts()
and continues execution, returning success.  dm_resume() then
dereferences the NULL cached_dc_state in link_enc_cfg_copy() and the
following dc_state->stream_count loop, crashing during GPU reset
recovery.

Return -ENOMEM immediately if the copy fails, so the caller aborts
suspend instead of leaving a NULL cached state for resume.

Fixes: 8092aa3ab8f7 ("drm/amd/display: Add null checker before passing variables")
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 84b6d7932fdd2857795a257f9f258562a3cddcab)
Cc: stable@vger.kernel.org
[ sashal: Adjusted context for dc_copy_state() instead of dc_state_create_copy(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b03bb4b913f8..530b85a22222b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2639,9 +2639,14 @@ static int dm_suspend(void *handle)
 		dc_allow_idle_optimizations(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
+		if (!dm->cached_dc_state) {
+			drm_err(adev_to_drm(adev),
+				"Failed to allocate cached DC state during suspend\n");
+			mutex_unlock(&dm->dc_lock);
+			return -ENOMEM;
+		}
 
-		if (dm->cached_dc_state)
-			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
-- 
2.53.0

