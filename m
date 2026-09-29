Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BD3D9025
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700068; cv=none; b=fdl1NSmXFEN3FCsey+xFAPeIt1V267eF9/+YfEJ6Xv9OdOJjMYXMmgrh6GXA8il87HotfVfY4tL811/bfWACH11Ks6Hy/CgNXJitDuQLe4SQo9CaQXkdUiuyz+C2KlXlFoF/wIcuKgVtICVDQUwfW+KAFzva+YwS0/J77NNY0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700068; c=relaxed/simple;
	bh=wCZ4shIk9utWO2fISPGW61jQ8XDuTcX7KNA4ZNnNpLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyGywNKeRFoaHYUto+H8hzwfwuhCvoO5GhJNTNThPIv17kVBR3e+8ZAvaANQoJl08bYH8yF4oE9+rOklE86ZwW/UlAZx+t9AGgq4p5B4aVCqVHiBGr8NRpkPiY6baIynWCnZ8iJFPMtooRwX8Am85qX6JgphbrbQEfXY1tDQLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPpw44dB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPpw44dB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7EB1F0089A;
	Tue, 29 Sep 2026 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790700067;
	bh=rl2tDvpjLjA3BTdrnAGJOWakJR8MeUEvxcVQaUwxXFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gPpw44dB5Thm4i3zQZrBeocnwFyEXwuHHJEOxJP7x0ui3hSQi/iQjzdUiXP9/lAN+
	 0nwT68RqNOi9AV4gNETPEBGeIsu63CM+qiOlBAtbXWh2pT8Ehcsm3MDGf9XlJlJUgy
	 0Jbd6ujfR1yMq0p19yeL9Ef8C/iIU3Qc30IdMm9cOelhjmDgVRoMSbKZbT2FeFBJP5
	 yEBcBmHjG3wO47MhJXpKRitjMOdL7Ow+GxDYw4XN9Gb39VE7deRM+sayL0+zsRcSgx
	 hEvnW0wMTiUQbowDb+LI7QIUqvijklygKr2JvoDZK7cP0uiIIlSRY3uurHRCuH7dPD
	 FVLSTG18deNYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
Date: Tue, 29 Sep 2026 12:41:05 -0400
Message-ID: <20260929164105.122654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092929-vividness-vanquish-6e88@gregkh>
References: <2026092929-vividness-vanquish-6e88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 2b86ab1bd6673c525adda88819d7658ba9e784ec ]

amdgpu_debugfs_test_ib_show() resumes the device with
pm_runtime_get_sync() before taking the reset domain semaphore with
down_write_killable().  If the write lock acquisition is interrupted,
the function returns without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference acquired for the device and keeping
the GPU awake.

Drop the runtime PM reference on the interrupted down_write_killable()
error path before returning.

Fixes: 6049db43d6dd ("drm/amdgpu: change reset lock from mutex to rw_semaphore")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ec30a576c2d4c0364549e6c04218f50704ef56c8)
Cc: stable@vger.kernel.org
[ Adapted `down_write_killable(&adev->reset_domain->sem)` to `down_read_killable(&adev->reset_sem)`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 8a1cb1de2b13a..5ba4fd1e9342f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1259,8 +1259,10 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	r = down_read_killable(&adev->reset_sem);
-	if (r)
+	if (r) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-- 
2.53.0

