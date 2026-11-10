Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272525;
	b=MFF3thWzo2wD5IH0z+6LPaCjZ94dnR6uhjKycQ0A8UYArFAvXycGwJ2vsBxtcLGaLROp
	 HAlMMQz7usj9CRAdUxTJAZ/QY5CFU1F54T6yILt5K8x6cQZ/HIiXddL+XKTUEOHvMyKY3
	 bVGuGDKLC6tLBlEECLlwUQTuvjfNsAlCP3op6AfSzJJdQO+AmCHQpQeCKqF15ExKdFoWP
	 3K64/MUMuNkda2d3piTr83U9e9HLX/a+aXnVaA8H7EcS13JOvdhJyLkAKJflYwQQIsMTs
	 zCrhRZNlXDWTvZW8+gkzWczyI4sINMymswSf3OPPPUon/N7s9m6bxnRJiVH5oTSOSSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G+hAoRTvUMkcWrBcwWOMmzRATiJw9YAEJLW56C1Zh9Y=;
	b=pV5+DVBP3kYuBGKUhBlHYUz5eDA2H3bT5T+bKHheBXQhptFVQEP2NOoF2bH9pcwQZ+L7
	 GmVTv4XvQQIO9lBMmArJl1u+9dJ/rNzfWYJGkn+myX//odalHykumSnbeUImdWO5uZFzo
	 +rukxOcf1a57rUFx/fI/5r8QnxQdJN8GD6oJfgGx5gsHKSagGq1Sp6vRO87DtVHtPi/mY
	 8dBrWRYiXNvWDnFXHr4M2oYhOD5gsJjk4FH6+H/BU9nYNLoN2aBE/gfChR8Ar1hUOg7xi
	 9D6FrDvakiqKMFaWcxp6AfkHUyfV7MhIFfZsU5nNKcdnPIios59MdqFvA1BU/sat18A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBxO0dh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBxO0dh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F047B1F0089F;
	Tue, 10 Nov 2026 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272525;
	bh=G+hAoRTvUMkcWrBcwWOMmzRATiJw9YAEJLW56C1Zh9Y=;
	h=From:To:Cc:Subject:Date;
	b=QBxO0dh4NzZCXTO3WpBSyVlPARYxRl2fmpsa+qqZS2/NKHAe2VkjVLdOCx6gSzOfN
	 4YjTDkG4vU4dv4EY1pXCtkVjqDKGRHWN7eqPjVeafE+VEawaYtrjeUaMEYGTk27Vu0
	 a7LcbTGVKuMmRd5y7JXQ+ebtR4NHCm1HCGMwA9wcDpf2psWKvzhMwDnZk4kzP0U0WF
	 Vkhz1Y58POC74ptS3XCBXFjBxIAywVJIm8anKJHr7yn2dqjSgzfGpy92nQsI5t2FBD
	 dosJEWwhFMw/Dpz+qgBDZJ9PBkzAYnbJCVCM3o0kdI9q8N1a6WhkSDBjR00ahhGQql
	 uSw+M35XKINiw==
From: Sasha Levin <sashal@kernel.org>
To: calvin@wbinvd.org,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:02:03 -0500
Message-ID: <20261109200203-failed-7.3-5b3717a14ef6@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 5b3717a14ef602c961a4abeb2ce8039f0394bebb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200203-failed-7.3-5b3717a14ef6@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5b3717a14ef602c961a4abeb2ce8039f0394bebb Mon Sep 17 00:00:00 2001
From: Calvin Owens <calvin@wbinvd.org>
Date: Tue, 27 Oct 2026 13:35:26 -0700
Subject: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"

After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
the screen. It reproduces sporadically, but at times it is so bad the
machine is more or less unusable.

The garbage is always horizontal bars extending across the entire
screen, always approximately 200 pixels tall on a 3840x2160 screen,
for what looks like a single frame. The bars are mostly black, but will
sometimes exhibit striping and periodic artifacts which smell like
non-framebuffer data is being rendered to the screen.

It took some patience on the "good" side, but I was able to nail it down
to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:

  bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
  good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
  good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
  bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
  bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
  good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include amdgpu_video_codecs.h only where needed
  bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix aperture mapping leak"
  bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test plane colorop helper walkers
  good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test helper_check_state rejects
  bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP block NULL check during soft reset
  bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix indefinite fence wait during GPU reset
  bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit LS for ISHARP before coefficient write
  bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KUnit test for wb jobs
  bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove unused dcn42 socbb values
  good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix VABC Init and OLED Support
  bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
  first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT

Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
of v7.3 completely and totally eliminates the problem for me.

Mikhail has separately reported this regression:

  https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/

...but it seems to be much more consistent for me than for Mikhail, it's
never taken more than 30 minutes even when the machine is completely
idle. I've also never been able to reproduce any artifact one single
time without commit a637a140, despite a lot of effort.

I'm not sure reverting this is the right way forward, since presumably
this would re-regress the timing issue Fangzhi alluded to in the
original commit. But nobody has proposed anything concrete yet... so
let's start the discussion here.

I'm happy to help test other better ideas as well :)

Fixes: a637a140ab86 ("drm/amd/display: Allocate DCN32/1 dmub memory to GTT")
Closes: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5714
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 899489d2e2aa854cf5e933677d6561dfcbb94529)
Cc: stable@vger.kernel.org
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index f4b0ced7d391c..383c53afd1f67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -538,7 +538,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
 	};
 	int r;
-	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(2, 1, 0):
@@ -675,19 +674,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	/* Limit to allocate dmub to GTT on DCN32/1
-	 * TODO: Other asics with GDDR7 may have worse latency
-	 */
-	if (dmub_asic != DMUB_ASIC_DCN32 &&
-	    dmub_asic != DMUB_ASIC_DCN321)
-		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
-
 	/*
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
 	r = dmub_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				  mem_domain,
+				  AMDGPU_GEM_DOMAIN_VRAM |
+				  AMDGPU_GEM_DOMAIN_GTT,
 				  &adev->dm.dmub_bo,
 				  &adev->dm.dmub_bo_gpu_addr,
 				  &adev->dm.dmub_bo_cpu_addr);
-- 
2.53.0




