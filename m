Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270E48822B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207547; cv=none; b=roAxP2JpIeTR9aZPrcNDOtsvUtu0YlW1qoujxIppB2i3hQZrddJN5NdzH9d5/4uOAPMAVwEI+QMgJNO3XKd2AVbaGdRt4RXIe/kEgcnhnruUb2goQh4O9jhxtZkOxV2X/Z9+QJrktf3Jw9acL/FmIcn25mrcsxGtAQridSbEj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207547; c=relaxed/simple;
	bh=Wp9Q8qqaFLTaGhGJld2BGj+Sq0p0CzkWDnk0IzpzQa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4nCMr1wXRsnW9oSRLlMX+tMZXKaQuWJVnuvdvbqTcyeQnwQuG+wpE1QL98g4tzBNb3Q2LSRXu36121EBd5ZaqSMl/ZfIVbpMhSrTukjMD2JcCtr9dTAU7Kv/y07zCHYBxoWu6+4NrgzEPNG9qeRZm5E9nzKfsPxZctYegm4X70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPUaGLJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPUaGLJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09E41F000FF;
	Mon,  5 Oct 2026 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207545;
	bh=CIPB3v1hQYuLDsg1DEINAvLBOGyjd0bEZSbdHXdEroM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPUaGLJ3lfQsmjFPAffx7e8VojfXuFrlqxNKwWszqkh0JLFw3e/mAWqWiNq/L7KbG
	 9cW6tyY+mHWnRX7ehuJLEaVCUVh5m2cgInmzuefgjtKnCOKKHqgso28FstF2t+kU42
	 oa2PkzmyhmdId8shzubjJvkuXj6NIMT3gdaOtgYg03XSGYDkrhSxBnPH47b/h+AdtL
	 89L47DSquORDyH9nosGOCzbh50tlLEYg9FcZYBvKni1sh3x9+WaeSWG0Yo24HneZtR
	 iU2/yxhXLzlxyB7k2tWQQHQU0PEYscqUQqeaTAn/ZMyfNPYSB7uDC1OHOXatc4gfU/
	 hSu/+Ja9BPyrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	George Zhang <george.zhang@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend
Date: Mon,  5 Oct 2026 09:39:01 -0400
Message-ID: <20261005133809.2960136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100558-hardness-compare-fb18@gregkh>
References: <2026100558-hardness-compare-fb18@gregkh>
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
[ sashal: Adapted dc_state_create_copy() usage to dc_copy_state(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4530d22139355..288ef18e70d05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2440,9 +2440,14 @@ static int dm_suspend(void *handle)
 #endif
 
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

