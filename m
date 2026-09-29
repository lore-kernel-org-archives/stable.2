Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847A379C39
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699726; cv=none; b=RLXVH58TA7gyt2X9ChHrKzfG2Bt1mVlC6iMZ1EZSUxV3IFn6m/Mhv4Jua7BIMk1n+bZhShfYbzh7lPBOP24kQhpIkAX78WZrqaotxK3z0jCHRoEV+z0gkvsLK/+vT1uQp9Zi1mAZnWvOhBKCEhIEtKGnrGREKX0OjLWTP1JnINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699726; c=relaxed/simple;
	bh=T83cO06hPXbPaMmt9eAip6fxGswxU2wdS6XXoLobMk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4L92f90cxLZNjuar67qBz1OqXAm2Yg5XbrYzahNKbsn0X1UmrOP4tV6BR0eUgXJ/RKm1PrB0uXjaHMT77AEU3jx+xPO998OroyfD7InVtawKRGv1R3+bO1lBb3M2nV2EntuTbf77Y4EY105ulJSngRcdUTDzxqgkmvgQ+I8l9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8JgxczN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8JgxczN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F831F00893;
	Tue, 29 Sep 2026 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790699725;
	bh=x+xRXyfKoMpoUn4YK0bF2nKa2F3k539+NMQlC/CskNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O8JgxczNOugZoDRnuNDVeCOKqL3Ne/h6NVtkVqAntB+D5VJLRTbbJcBCaThKI+Sj2
	 jrRPgwNtLsPdVx49dsxftyGK+S4iH4H4AfCOzhqNsFLwo5hnjh4GHj1bP+B8XD6+PA
	 HhVKZRxWrttvb0+6INuFuQp0YaWlaxujgVy6PwVjdK4foTX4wOwcFbXYgWwAVaATbD
	 7rcbJoix4f6pQMWWc/ncepwzAeFRR+D0N3OZe5LHJQtwl98tEMpqMGONshDoZf/b4d
	 2lIKYBd6RTA/S6SW4cYarmsg0+ja8cp0JYRX/VGjRzihnl5se8GWWvw1CrEh1zvJ0E
	 CORMMwju4SGlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
Date: Tue, 29 Sep 2026 12:35:23 -0400
Message-ID: <20260929163523.91935-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092928-heading-septic-a26f@gregkh>
References: <2026092928-heading-septic-a26f@gregkh>
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
index 49711776b3516..944ecf780781e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1140,8 +1140,10 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
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

