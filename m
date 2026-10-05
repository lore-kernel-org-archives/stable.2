Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251E44A3F1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203631; cv=none; b=Ly2ICJ+RTpeUihQve/ufn5f/T5qBKwFzlxxP5knws2kvATJ4kB4NDQaihwTs99krP9FAQf98C6jX65f1oJjqaPFai6BLGvDBgINe7eh0hvxaNFuGZm7LsRVyCG7TLrM/x59bg907aC+St5kLvHTk5SjgZf4GOMs0luLahbV/7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203631; c=relaxed/simple;
	bh=xKdvVOkclsoTCELbXxl2utzQ78oLLvfA9ghmQHU3LZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMv9RTspxrqBw5c/5/AhwHbhMiJXIeWeGslv9gQe2AIRfgyuis8AvxncuyFyB9XrWn2arzdFd540nb6dlwmhI5Q/KL3VJ8h2sTdNI7Vv1NLiIoykEE3HivGVvxWCg/n/SAw4F5X3384eC22O7N6x7GFBpCZL8aYZ5Z2HR/F2ghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8gWjkmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8gWjkmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24B51F000FF;
	Mon,  5 Oct 2026 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203630;
	bh=2nJTx00vFp92jaQEDK0nT6SmUJoCdeaGvGgxoVlNI38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W8gWjkmc9CszF+YsRJM/1Q2CBTkaJHBJq30ZXjTlWDoKb95JH+p1YLOCuFe3s2HMv
	 3+Ez5boQNHhczvIwmYSBeOPrMlBP+mI5IN3a8r2HrLzV4a1dg0fUhuMWadsmfJtZzP
	 +N1KWhfHCvbbF+3CHh73HYzwzJrirDiLZyJFtB9pT3rAxwU5aN2plgX1r6tYd7WHoR
	 Lo7bKsGXJOpJmaT96G34KD7BpiXcJb/0zFLf/lmIn6T8nTYmqbx5j0KM3jOQIA2+3d
	 HMgPB7Yz5NkN1jmhCKjPVZ+diFFMYYJfJX81O6VgaGFJoPUA+x/lxLtXkX4zbnRBy/
	 xJnt/GxFIxF0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	George Zhang <george.zhang@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend
Date: Mon,  5 Oct 2026 08:33:46 -0400
Message-ID: <20261005123238.1909936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100557-droplet-spousal-f396@gregkh>
References: <2026100557-droplet-spousal-f396@gregkh>
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
[ sashal: Adapted context from dc_state_create_copy() to the existing dc_copy_state() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index deaf98957cb76..86282119252bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2645,9 +2645,14 @@ static int dm_suspend(void *handle)
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

