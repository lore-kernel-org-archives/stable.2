Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274118;
	b=oujJ/BWud79+CGI53PdYVuDk4okY9zciyZ/ulIORiV3hRdB39CUKokWehf8F/Fq5wK28
	 UPjdPapjgKWHyy0oBSjMUfn4jgHe05XatrC663zTqXDyziW54HDXdDHhzV5K9aFrJ8d5P
	 f3g4o2DrL+VWp9JcNvGjaV2Zs4P4Xg372x+Ze6YKXbuArDItZkJQ187nS5Dl710TXwFjV
	 CyH9iUipn2PaGOjVGZK5SamrynQMGuTFKOPG9wqKbN0DyneJFMQHzP1+oULNiPUMNN2iA
	 YaEc0EOqJu9Wu2Eea+V5ZfrTmcru5o4c4xjoh66giIwlxKsoTXnEQKn+AbmW/PS3Xtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vua7embOk2PO4RQNE1JuA8PWA7jDkiUXIbIqiVNR6yA=;
	b=Es6oc/U6OayGXbl5d0IFPv3o1ckl7qJnOf7rnYZPCbpvoRS3XG/eW7zZdTAgI++Qv2bW
	 MMB6bUGGAFAD4tZjJBM732jhXHLbCau+jygoCehxxBsktTgx3mmF+xkniXx6ZmwF86dn2
	 uaO9KUaCNi4APx+BIRyxezghkTSnSAmC3VtOauv/IeNDUMuxs0L7ekq1Qpi77Sorp5Tqq
	 Fwd5FKBXV0wqW2BxygJFwHoKDUJ4knMG2m6E72CGGx4pE4s2E4pAv2/DEEG0BvwaM5DsM
	 i4yyApOkcRDSs9iC3NBcdbJvSC9GspQ4Avye2riSG14dvlGVit8ctzyuh+gT4HSLaIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGYDwqLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGYDwqLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0BB1F0089F;
	Tue, 10 Nov 2026 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274118;
	bh=vua7embOk2PO4RQNE1JuA8PWA7jDkiUXIbIqiVNR6yA=;
	h=From:To:Cc:Subject:Date;
	b=PGYDwqLCbbcqEdPpdFhMVGvwLiORrq/km0qDXPrDhleJn2nmT6naTIs1sLhB0rBYg
	 g6lEqz77J1s36nU0ogAJ+4lT40RNF64Q5WEHJ0pPrDFFDxktc3dSDiPf/3auQ533rd
	 HSLhRFvM+VzUKbgrxVFikQqCcAi+unJXCnqal2akI45+q/hyOQIu5tf5yo8+Tac0Ru
	 NJuqfrQAZxcTDuYHUQ78XMT8HsMvLlKfHsRBUL9aigrVsreXcXZjUMDFLDfbdFwXbl
	 ltzrOYe6sRhSvRMhobua8D1iW5DWgEZqEmzTuiw5eAFYStXMigaO/SAAQ5+2OkrDsf
	 qk8KzRxPZQiGw==
From: Sasha Levin <sashal@kernel.org>
To: prike.liang@amd.com,
	lijo.lazar@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: finish GPU recovery callbacks before restarting schedulers" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:36 -0500
Message-ID: <20261109202836-failed-5.10-733389cb31e2@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 733389cb31e2c55e355410759fdc68afe74a4582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202836-failed-5.10-733389cb31e2@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




