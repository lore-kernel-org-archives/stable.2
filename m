Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC53DCD85;
	Mon, 19 Oct 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417163; cv=none; b=oXpVihr1L2kH62+sBsvABEkXn8vC3lJtrRmjhZKMcIOhtyF3C4EXWW4zEY734fyosT5484iWEb4UzlclWZ68hlrf+hG+50BxzaugszpHqfnE97/+plgOkpG2IdTLVkYGIwnzy7AcfW5lOlaTKS0y+FoSBBWdRDpaC7HO9ktxbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417163; c=relaxed/simple;
	bh=slYxthp496E4xcRQzJ2OurTUqSc5h7per4A8X+sBkMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kM/mwmBVy8G4hGeca70jguPCfGFYCZ3hwj9adT9rFznTsSNpcEceJUnQVyMz2qmq/Af1CmxqrE7ZLqEHhnqh6KElVXuOzsqoHxun8k3wuNftw3P8ZVx3jKWusPWKZvmVU3HdCcDZV6VABY2n1Y88vxPYmScVOOgyc69ZoziY54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooQ1JabA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooQ1JabA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B87AC2BCFC;
	Mon, 19 Oct 2026 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792417162;
	bh=slYxthp496E4xcRQzJ2OurTUqSc5h7per4A8X+sBkMc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ooQ1JabA+OKT/VV/Ola+j8K5TW/1zqY49k4ymYvOnOaFuUUozVqQ0QrOQFb4j/3c2
	 iR8z2/7xXv8ZeGANB3t6nVpErxwppOf1KpXzkIbjr9+1nmhZVKO0vKgawzcQnw/qWa
	 vz0PflMFYx+uPgYPT3b3lUfwOkDF2i73tGQSg8rEuIKrHh7Aro0uwK+BcPMaAXez0W
	 k1ZMNlBcD82416yrUo5u+1s7yaYbYeMyoMtOEh/FBUPYF+YxYm4Rl0yClj5wx6KBwg
	 iIyRP6HxZjUkEIj4yVWesIx2fam3Tk6tiJ5IbT6+/4xbHZ2q0KqZqDpmWCszrGakHY
	 CaWCCIO7gG7tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C2CCF2E3;
	Mon, 19 Oct 2026 13:39:22 +0000 (UTC)
From: Mohammed AlHashim via B4 Relay <devnull+eng.m7mdhashim.1.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 16:38:55 +0300
Subject: [PATCH v2] drm/msm/adreno: Register devfreq after the GPU-specific
 init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-msm-gmu-freq-guard-v2-1-799eb15890ba@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RhaA6muvIdhUaZDGWNBWyAaw
 t0F3Lt8yfvvz5A4Cie4ZDNEniRJ362gDxlQazvPKG5l0LkuVa4MhhTQhxGbyC/0o40OubBkToV
 RTV3AOnxGbuS9R2/Vj9NY35mGrbQZraShj5/9dVKb9/dgUqjQubN2RMRsyqsPVh5H6gNUy7J8A
 cCu7pbGAAAA
X-Change-ID: 20261018-msm-gmu-freq-guard-e5ac83581fb5
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792417161; l=6463;
 i=eng.m7mdhashim.1@gmail.com; s=20261018; h=from:subject:message-id;
 bh=r8SfK/Iz/wVLnIplhj+V3MUujIzOEzMTsriA+q8roW4=;
 b=loEzTtjSzd0LghPPlDggXNMIcuYnZGEFrwTAxA0TB7rMZD0/qmxz2e5HNpxS0/wFLX9gzxI30
 l6uInSRHW73A5aMS4YIeT3LYrcoRHIcQfEipypSRSt7Q5RAuj81yrwr
X-Developer-Key: i=eng.m7mdhashim.1@gmail.com; a=ed25519;
 pk=nadicxm5lJrpr6u2tkxbYV+wi8bWOYqheGU3HolXoXA=
X-Endpoint-Received: by B4 Relay for eng.m7mdhashim.1@gmail.com/20261018
 with auth_id=1228
X-Original-From: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
Reply-To: eng.m7mdhashim.1@gmail.com

From: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>

a6xx_gpu_init() registers devfreq through adreno_gpu_init() ->
msm_gpu_init() -> msm_devfreq_init(), and only afterwards calls
a6xx_gmu_init(), which fills gmu->gpu_freqs[] and sets
gmu->nr_gpu_freqs. The devfreq sysfs node and the cooling device are
live in that window, so a write to min_freq or max_freq, or a thermal
QoS update, can reach a6xx_gmu_set_freq() while nr_gpu_freqs is still
0.

The lookup loop then compares a u32 perf_index against
gmu->nr_gpu_freqs - 1. With a count of 0 the bound converts to
UINT_MAX, so the loop reads past the end of gpu_freqs[] until it hits
unmapped memory. It faults with devfreq's lock held, so every later
GPU user blocks and the machine hangs.

This was hit at boot on an X1P42100 (Adreno X1-45) laptop, where a udev
rule wrote min_freq as soon as the devfreq device appeared:

  Unable to handle kernel paging request at virtual address ffff000b80000000
  Internal error: Oops: 0000000096000005 [#1]  SMP
  CPU: 0 UID: 0 PID: 487 Comm: (udev-worker) Tainted: G        W  O
  Hardware name: SAMSUNG ELECTRONICS CO., LTD. Galaxy Book4 Edge/NP750XQA-KB2US
  pc : a6xx_gmu_set_freq+0x74/0x2a0 [msm]
  lr : a6xx_gmu_set_freq+0x3c/0x2a0 [msm]
  ...
  x4 : 00000000ffffffff ...

x4 holds the wrapped loop bound. The faulting address is 1 GiB
aligned, which matches a linear read running off the end of the
linear map.

Move msm_devfreq_init() out of msm_gpu_init() and call it last in
adreno_bind(), once the generation's init function has returned, so
devfreq only appears after the freq and bandwidth tables are complete.
Do it after dev_pm_opp_of_find_icc_paths() so a deferral there does not
leave a devfreq or cooling device behind.
This also closes the narrower race where a6xx_gmu_pwrlevels_probe()
writes the tables and counts while a6xx_gmu_set_freq() may already be
running, and it does not drop a frequency request the way an early
return in a6xx_gmu_set_freq() would.

a2xx has no gpu_busy() and never registers devfreq. a3xx, a4xx and
a5xx build nothing after msm_gpu_init() that the devfreq callbacks
read, and a6xx parts with a GMU wrapper or RGMU set the rate through
the OPP core, so for all of them devfreq simply appears a little later
in the same bind. GPU runtime PM is only enabled on first open, in
adreno_load_gpu(), so no resume or suspend can reach
msm_devfreq_resume() or msm_devfreq_suspend() during bind, and both
return early through has_devfreq() in any case.

Fixes: a2c3c0a54d4c ("drm/msm/a6xx: Add devfreq support for a6xx")
Cc: stable@vger.kernel.org
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
---
How this was found and tested:

- Seen twice at boot (2026-10-03 and 2026-10-05) on a Samsung Galaxy
  Book4 Edge 15" (NP750XQA, X1P42100 / Adreno X1-45) running a
  downstream 7.2.7 tree with an out-of-tree device tree. Both oopses
  were at a6xx_gmu_set_freq+0x74, about 9 s after power-on, from a udev
  rule writing min_freq when the devfreq device appeared. The log ends
  at "Call trace:" because the machine hung.
- With v1's guard applied to the same downstream tree, the laptop has
  booted 20 times since 2026-10-14 with no oops. That only shows the
  guard did no harm. It does not prove the race was closed, because the
  udev rule was moved to a delayed systemd unit on 2026-10-06 and the
  window is narrow.
- v2, backported to the same downstream tree in place of v1's guard,
  booted 5 times with the original udev rule restored, so min_freq was
  written the moment the devfreq device appeared. All 5 boots were
  clean and the floor was applied (min_freq and cur_freq read back as
  requested). Suspend/resume could not be tested: s2idle does not yet
  resume on this machine for an unrelated reason.
- On v7.3-rc7 v2 is only build-tested (arm64 defconfig, W=1, all of
  drivers/gpu/drm/msm/). It has not been run on mainline or msm-next,
  and I could only reason about a3xx-a5xx from the source.

AI disclosure: an LLM coding assistant helped read the oops, trace the
init ordering, check the other GPU generations and draft this commit
message. I reviewed the result, tested it as described above, and take
responsibility for it.
---
Changes in v2:
- Register devfreq from adreno_bind() after the GPU-specific init,
  instead of returning early in a6xx_gmu_set_freq() (Konrad).
- This also addresses the two Sashiko findings on v1: the residual
  race with a6xx_gmu_pwrlevels_probe() and the dropped frequency
  request on resume.
- Register devfreq after dev_pm_opp_of_find_icc_paths(), so a probe
  deferral there does not leave a devfreq or cooling device behind.
- Retitled from "drm/msm/a6xx: Don't set GPU freq before the GMU freq
  table is built", since the change now touches common adreno code.
- Link to v1: https://patch.msgid.link/20261018-msm-gmu-freq-guard-v1-1-dd92dcccee86@gmail.com
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 8 ++++++++
 drivers/gpu/drm/msm/msm_gpu.c              | 2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 05c77fe27..52d90e1d1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -247,6 +247,14 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	/*
+	 * Register devfreq last: its sysfs, QoS and cooling device can reach
+	 * gpu_set_freq() as soon as it exists, and on a6xx the GMU freq and
+	 * bandwidth tables are only built by a6xx_gmu_init(), after
+	 * msm_gpu_init().
+	 */
+	msm_devfreq_init(gpu);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636..452da9272 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -968,8 +968,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	platform_set_drvdata(pdev, &gpu->adreno_smmu);
 
-	msm_devfreq_init(gpu);
-
 	gpu->vm = gpu->funcs->create_vm(gpu, pdev);
 	if (IS_ERR(gpu->vm)) {
 		ret = PTR_ERR(gpu->vm);

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261018-msm-gmu-freq-guard-e5ac83581fb5

Best regards,
--  
Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>


