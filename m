Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272987;
	b=yJL/6Qq74Jx5hL+jMSaLXCzwgqxAoUjiId5ttBL5X80u2dPpz6c7Gw/Wzh+rzXQ2wm/j
	 PeOHLmYxfNwePy61JtfMsEr7gquVaWXa5VaAkFfxRUJF5kwNJphvPQa0VBJqALFHEI+7G
	 dJmpJekr82rteINhwjFny41eauhE/OF3B7beEHst4EAXAOVvYaq1nsc6PCEmZj5yd2bjw
	 ewGmo0yD88dwkJfonfHZFZTq30LwZVILpE58eYGkdLx7Ay65sR2eYildSItQh5QK38YdT
	 PnJgGaOST8bVrOW3W2BAZYmpqZg3CGWKLfBOoO4BM2mM1DWHlXKDs4srIS8YxUImWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZoOoB1PwYUfmMAsMvdekJ1rW1yvfLHGVdC+UyFoDstQ=;
	b=H5bjFuv5kWjlw8Wyr4aP3kPdYXGAKYzRkekxuizHowZn9bW1d0Z1FR7WJeQ1ypy+nevq
	 ucSRHMC61+lccPgWzTw+x+qo0PNutKl0mwidA3vWO1Uu8MFD8Oqu8N5oadxnlK+HzkVIH
	 6NwAzkdR/MNWcp/NNDN8SrEQmvZa521Br3HgcB3E++jaFeiGF3UORLwLuEkMjpp4MRrW8
	 v7IQnoiDgVWpkTHlt/J8S9XQmoz7zWO8jcFAHPoB8JU/noV1OMW981A8BIwqiNFdQ8ato
	 Qg4bKQCEfPL2+pJ2En0WcFODFBzOV9t+r8FlKgcbCF9Ts51HLiwrmy4M9w5qOUK4bNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JdLRFh/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE660A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdLRFh/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073181F0089F;
	Tue, 10 Nov 2026 01:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272986;
	bh=ZoOoB1PwYUfmMAsMvdekJ1rW1yvfLHGVdC+UyFoDstQ=;
	h=From:To:Cc:Subject:Date;
	b=JdLRFh/3UmC7sUxcA6t/JkUUPuNs0P2MtSTGCubJjYfYceo5jSllFL/ZYULQeMDjt
	 xqs52YhHsGZzPaGwOSc88+eyfsP9bgFx78VkEIaCZoUuthyorVtoqZSoih94D9/Wds
	 XyONjJos07JtN9aaEdXkzocClJh0aKhBBHT2Tp0XOGr8bVslr6qO9y2UJ7CYWJ27I6
	 H72J3lrVmMJ9ODC54Kzqu+PxnQSyI+HoV3TaUA6Fezvtht5Gm5jDMfpBRonn6mIq3j
	 rZZBIi8rf+0+ZpsHtpMKD3Bgd1eJieBm2H4PRnGPcdrvaFZhLW8ex0ELE0XsR8VLQ3
	 kQHEDR/uNWh3w==
From: Sasha Levin <sashal@kernel.org>
To: prike.liang@amd.com,
	lijo.lazar@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:44 -0500
Message-ID: <20261109200944-failed-6.12-733389cb31e2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 733389cb31e2c55e355410759fdc68afe74a4582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200944-failed-6.12-733389cb31e2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 733389cb31e2c55e355410759fdc68afe74a4582 Mon Sep 17 00:00:00 2001
From: Prike Liang <Prike.Liang@amd.com>
Date: Thu, 20 Aug 2026 15:27:56 +0800
Subject: [PATCH] drm/amdgpu: finish GPU recovery callbacks before restarting
 schedulers

Run GPU post-reset callbacks, including KFD and display-audio resume,
before restarting DRM scheduler workqueues. IP hardware initialization
already happens inside ASIC recovery; this change orders the remaining
callbacks before new scheduler submissions. Preserve the emergency-stop
and guity job completition path's callbacks without starting schedulers,

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1f6433e2b264e75c56ae95f187788806201bdbc3)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 53f05ee7193f2..5bec9cd3f7d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5859,8 +5859,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
-	if (need_emergency_restart)
-		goto skip_sched_resume;
+	if (need_emergency_restart) {
+		amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+		goto reset_unlock;
+	}
 	/*
 	 * Must check guilty signal here since after this point all old
 	 * HW fences are force signaled.
@@ -5870,18 +5872,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
 		goto reset_unlock;
-skip_hw_reset:
+post_resume:
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
 		goto reset_unlock;
-skip_sched_resume:
-	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	amdgpu_ras_post_reset(adev, &device_list);
-- 
2.53.0




